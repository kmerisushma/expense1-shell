source common.sh

echo -e "${color} Disable MySQL default version \e[0m"
dnf module disable mysql -y &>>$log_file
status_check

echo -e "${color} Copy MySQL Repo file \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
status_check

echo -e "${color} Installing MySQL server\e[0m"
dnf install mysql-community-server -y &>>$log_file
status_check

echo -e "${color} Start MySQL server \e[0m"
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
status_check

echo -e "${color} set MySQL password \e[0m"
status_check


