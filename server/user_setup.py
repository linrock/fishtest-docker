from fishtest.rundb import RunDb

print("setting up users - user00, user01")

rdb = RunDb()

user_name = "user00"
user_mail = "user00@example.com"
rdb.userdb.create_user(user_name, "1230hjadsfg", user_mail)
rdb.userdb.add_user_group(user_name, 'group:approvers')
user = rdb.userdb.get_user(user_name)
user['blocked'] = False
user['machine_limit'] = 100
rdb.userdb.save_user(user)

user_name = "user01"
user_mail = "user01@example.com"
rdb.userdb.create_user(user_name, "1230hjadsfg", user_mail)
rdb.userdb.add_user_group(user_name, 'group:approvers')
user = rdb.userdb.get_user(user_name)
user['blocked'] = False
user['machine_limit'] = 100
rdb.userdb.save_user(user)
