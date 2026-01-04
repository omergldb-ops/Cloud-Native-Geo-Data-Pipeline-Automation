import os, time, boto3, psycopg2, json

def process():
    db_host = os.getenv('DB_HOST')
    conn = psycopg2.connect(host=db_host, database='asterradb', user='admin', password=os.getenv('DB_PASS'))
    cur = conn.cursor()
    cur.execute("CREATE EXTENSION IF NOT EXISTS postgis;")
    cur.execute("CREATE TABLE IF NOT EXISTS geo_data (id SERIAL PRIMARY KEY, geom GEOMETRY);")
    conn.commit()
    
    s3 = boto3.client('s3')
    bucket = os.getenv('S3_BUCKET')
    
    while True:
        res = s3.list_objects_v2(Bucket=bucket)
        if 'Contents' in res:
            for obj in res['Contents']:
                if obj['Key'].endswith('.geojson'):
                    f = s3.get_object(Bucket=bucket, Key=obj['Key'])
                    d = json.loads(f['Body'].read().decode('utf-8'))
                    for feat in d['features']:
                        cur.execute("INSERT INTO geo_data (geom) VALUES (ST_GeomFromGeoJSON(%s))", (json.dumps(feat['geometry']),))
                    conn.commit()
                    s3.delete_object(Bucket=bucket, Key=obj['Key'])
        time.sleep(15)

if __name__ == "__main__": process()