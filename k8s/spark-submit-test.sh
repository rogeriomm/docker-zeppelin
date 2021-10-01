CONTEXT=minikube
NAMESPACE=zeppelin

                   #--conf spark.kubernetes.context=${CONTEXT} \

/opt/spark/bin/spark-submit --verbose --master k8s://https://192.168.64.4:8443 --deploy-mode cluster \
                   --name spark-pi \
                   --class org.apache.spark.examples.SparkPi \
                   --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
                   --conf spark.executor.instances=10 \
                   --conf spark.kubernetes.container.image=spark:1.0 \
                   --conf spark.kubernetes.namespace=${NAMESPACE} \
                   local:///opt/spark/examples/jars/spark-examples_2.12-3.1.2.jar
