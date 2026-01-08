import os, time, boto3, psycopg2, json

def process():
    db_host = os.getenv('DB_HOST')
    db_name = os.getenv('DB_NAME')
    db_user = os.getenv('DB_USER')
    db_pass = os.getenv('DB_PASS')
    s3_bucket = os.getenv('S3_BUCKET')
    ssl_mode = os.getenv('PGSSLMODE', 'disable')

    print(f"Connecting to {db_host}...")

    try:
        conn = psycopg2.connect(
            host=db_host,
            database=db_name,
            user=db_user,
            password=db_pass,
            sslmode=ssl_mode
        )
        cur = conn.cursor()
        cur.execute("CREATE EXTENSION IF NOT EXISTS postgis;")
        cur.execute("CREATE TABLE IF NOT EXISTS geo_data (id SERIAL PRIMARY KEY, geom GEOMETRY);")
        conn.commit()
        
        s3 = boto3.client('s3')
        
        while True:
            res = s3.list_objects_v2(Bucket=s3_bucket)
            if 'Contents' in res:
                for obj in res['Contents']:
                    if obj['Key'].endswith('.geojson'):
                        print(f"Processing {obj['Key']}")
                        f = s3.get_object(Bucket=s3_bucket, Key=obj['Key'])
                        d = json.loads(f['Body'].read().decode('utf-8'))
                        for feat in d['features']:
                            cur.execute("INSERT INTO geo_data (geom) VALUES (ST_GeomFromGeoJSON(%s))", (json.dumps(feat['geometry']),))
                        conn.commit()
                        s3.delete_object(Bucket=s3_bucket, Key=obj['Key'])
            time.sleep(15)
    except Exception as e:
        print(f"Database error: {e}")
        raise e

if __name__ == "__main__": 
    process()