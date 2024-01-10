# vi: ft=sh
# make sure we have an sso session
#
function e (){
    echo "=========================="
    echo "$@"
    echo "=========================="
}

# CHANGE THIS TO YOUR PROFILE ...
aws sts get-caller-identity --profile kc-bigdata &> /dev/null
if [ $? -eq 0 ]
then
    echo "sso session is active"
else
    aws sso login --profile kc-bigdata
fi

cd ~/code/rapidcloud/kc-rapid-cloud


# This code assumes us-east-1 is the region
e "create vpc"
./kc net create_vpc  \
	--name "mvpc02"  \
	--net_name "mvpc02"  \
	--net_cidr "192.168.0.0/16"  \
	--net_enable_dns_support "true"  \
	--net_enable_dns_hostnames "true"  \
	--net_tags "{ \"tag1\": \"val1\" }"   \
	--no-prompt


e "create public subnet and route table"
./kc net create_subnet  \
	--name "mvpc02-pub01"  \
	--net_name "mvpc02-pub01"  \
	--net_vpc_module_id "mvpc02"  \
	--net_az "us-east-1a"  \
	--net_cidr "192.168.1.0/24"  \
	--net_create_route_table "true"  \
	--net_associate_route_table ""   \
	--net_tags "{ \"tag1\": \"val1\" }"   \
	--no-prompt

e "create public subnet and use other pub route table"
./kc net create_subnet  \
	--name "mvpc02-pub02"  \
	--net_name "mvpc02-pub02"  \
	--net_vpc_module_id "mvpc02"  \
	--net_az "us-east-1b"  \
	--net_cidr "192.168.2.0/24"  \
	--net_create_route_table "false"  \
	--net_associate_route_table "mvpc02-pub01"   \
	--net_tags "{ \"tag1\": \"val1\" }"   \
	--no-prompt

e "create private subnets"
./kc net create_subnet  \
	--name "mvpc02-prv01"  \
	--net_name "mvpc02-prv01"  \
	--net_vpc_module_id "mvpc02"  \
	--net_az "us-east-1b"  \
	--net_cidr "192.168.3.0/24"  \
	--net_create_route_table "true"  \
	--net_associate_route_table ""   \
	--net_tags "{ \"tag1\": \"val1\" }"   \
	--no-prompt

./kc net create_subnet  \
	--name "mvpc02-prv02"  \
	--net_name "mvpc02-prv02"  \
	--net_vpc_module_id "mvpc02"  \
	--net_az "us-east-1a"  \
	--net_cidr "192.168.4.0/24"  \
	--net_create_route_table "true"  \
	--net_associate_route_table ""   \
	--net_tags "{ \"tag1\": \"val1\" }"   \
	--no-prompt


e "create igw"
./kc net create_igw  \
	--name "mvpc02-ige01"  \
	--net_name "mvpc02-ige01"  \
	--net_vpc_module_id "mvpc02"  \
	--net_route_tables "mvpc02-pub01"  \
	--net_tags "{ \"tag1\": \"val1\", \"tag2\": \"val2\" }"   \
	--no-prompt

e "create nat gw"
./kc net create_natgw  \
	--name "mvpc02-nat01"  \
	--net_name "mvpc02-nat01"  \
	--net_subnet_module_id "mvpc02-pub01"  \
	--net_route_tables "mvpc02-prv01"  \
	--net_tags "{ \"tag1\": \"val1\" }"   \
	--no-prompt

./kc net create_natgw  \
	--name "mvpc02-nat02"  \
	--net_name "mvpc02-nat02"  \
	--net_subnet_module_id "mvpc02-pub02"  \
	--net_route_tables "mvpc02-prv02"  \
	--net_tags "{ \"tag1\": \"val1\" }"   \
	--no-prompt

e "create endpoints"

./kc net create_endpoint  \
	--name "mvpc02-autoscaling"  \
	--net_name "mvpc02-autosclaing"  \
	--net_service "autoscaling"  \
	--net_vpc_id "mvpc02"  \
	--net_subnet_ids "mvpc02-prv01,mvpc02-prv02"  \
	--net_route_tables "mvpc02-pub01"  \
	--net_tags "{ \"tag1\": \"val1\", \"tag2\": \"val2\" }"   \
	--no-prompt

./kc net create_endpoint  \
	--name "mvpc02-dynamodb"  \
	--net_name "mvpc02-dynamodb"  \
	--net_service "dynamodb"  \
	--net_vpc_id "mvpc02"  \
	--net_subnet_ids "mvpc02-prv01,mvpc02-prv02"  \
	--net_route_tables "mvpc02-pub01"  \
	--net_tags "{ \"tag1\": \"val1\", \"tag2\": \"val2\" }"   \
	--no-prompt

./kc net create_endpoint  \
	--name "mvpc02-ec2"  \
	--net_name "mvpc02-ec2"  \
	--net_service "ec2"  \
	--net_vpc_id "mvpc02"  \
	--net_subnet_ids "mvpc02-prv01,mvpc02-prv02"  \
	--net_route_tables "mvpc02-pub01"  \
	--net_tags "{ \"tag1\": \"val1\", \"tag2\": \"val2\" }"   \
	--no-prompt

./kc net create_endpoint  \
	--name "mvpc02-ecr"  \
	--net_name "mvpc02-ecr"  \
	--net_service "ecr"  \
	--net_vpc_id "mvpc02"  \
	--net_subnet_ids "mvpc02-prv01,mvpc02-prv02"  \
	--net_route_tables "mvpc02-pub01"  \
	--net_tags "{ \"tag1\": \"val1\", \"tag2\": \"val2\" }"   \
	--no-prompt

./kc net create_endpoint  \
	--name "mvpc02-ecr-dkr"  \
	--net_name "mvpc02-ecr-dkr"  \
	--net_service "ecr_dkr"  \
	--net_vpc_id "mvpc02"  \
	--net_subnet_ids "mvpc02-prv01,mvpc02-prv02"  \
	--net_route_tables "mvpc02-pub01"  \
	--net_tags "{ \"tag1\": \"val1\", \"tag2\": \"val2\" }"   \
	--no-prompt

./kc net create_endpoint  \
	--name "mvpc02-s3"  \
	--net_name "mvpc02-s3"  \
	--net_service "s3"  \
	--net_vpc_id "mvpc02"  \
	--net_subnet_ids "mvpc02-prv01,mvpc02-prv02"  \
	--net_route_tables "mvpc02-pub01"  \
	--net_tags "{ \"tag1\": \"val1\", \"tag2\": \"val2\" }"   \
	--no-prompt

./kc net create_endpoint  \
	--name "mvpc02-sns"  \
	--net_name "mvpc02-sns"  \
	--net_service "sns"  \
	--net_vpc_id "mvpc02"  \
	--net_subnet_ids "mvpc02-prv01,mvpc02-prv02"  \
	--net_route_tables "mvpc02-pub01"  \
	--net_tags "{ \"tag1\": \"val1\", \"tag2\": \"val2\" }"   \
	--no-prompt

./kc net create_endpoint  \
	--name "mvpc02-sqs"  \
	--net_name "mvpc02-sqs"  \
	--net_service "sqs"  \
	--net_vpc_id "mvpc02"  \
	--net_subnet_ids "mvpc02-prv01,mvpc02-prv02"  \
	--net_route_tables "mvpc02-pub01"  \
	--net_tags "{ \"tag1\": \"val1\", \"tag2\": \"val2\" }"   \
	--no-prompt

e "create route"

read -p "hit enter to run kc tf init ..." &&  ./kc tf init
read -p "hit enter to run tf plan ..." && ./kc tf plan
read -p "hit enter to run tf apply ..." && ./kc tf apply
