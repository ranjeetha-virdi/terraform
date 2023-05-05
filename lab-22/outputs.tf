output "server_ip_id" {
  value = [
    for x in aws_instance.my_server :
    "Server with ID : ${x.id} has Public IP : ${x.public_ip}"

  ]
}


#here we are creating a map = {}
output "server_ip_id_map" {
  value = {
    for x in aws_instance.my_server :
    x.id => x.public_ip // "i-132242434343 = 23.45.56.123"
  }
}

output "users_unique_id_arn" {
  value = [
    for user in aws_iam_user.user :
    "UserID : ${user.unique_id} has ARN : ${user.arn}"

  ]
}


output "users_unique_id_name_map" {
  value = {
    for user in aws_iam_user.user :
    user.unique_id => user.name
  }
}


output "users_unique_id_name_map_custom" {
  value = {
    for user in aws_iam_user.user :
    user.unique_id => user.name
    if(length(user.name)) < 7 //print all user names less than 7 Characters, we can also create a map inside map or map inside list.
  }
}
