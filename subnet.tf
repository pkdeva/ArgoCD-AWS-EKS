resource "aws_subnet" "pvt-sub-1" {
  vpc_id = module.vpc.vpc_id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
  
  map_public_ip_on_launch = false 
}

resource "aws_subnet" "pvt-sub-2" {
  vpc_id = module.vpc.vpc_id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1b"

}
resource "aws_subnet" "pub-sub-1" {
  vpc_id = module.vpc.vpc_id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true

}

resource "aws_subnet" "pub-sub-2" {
  vpc_id = module.vpc.vpc_id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-south-1b"

}