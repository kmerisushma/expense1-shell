log_file="/tmp/expense.log"
color="\e[33m"

echo -e "${color} Disable NodeJS default version \e[0m"
dnf module disable nodejs -y &>>$log_file
echo $?

echo -e "${color} Enable NodeJS 18  version \e[0m"
dnf module enable nodejs:18 -y &>>$log_file
echo $?

echo -e "${color} Install NodeJS  \e[0m"
dnf install nodejs -y &>>$log_file
echo $?

echo -e "${color} Copy Backend service File \e[0m"
cp backend.service /etc/systemd/system/backend.service &>>$log_file
echo $?

echo -e "${color} Add Application user \e[0m"
useradd expense &>>$log_file
echo $?

echo -e "${color} create application directory \e[0m"
mkdir /app &>>$log_file
echo $?

echo -e "${color} Delete old application directory \e[0m"
rm -rf /app/* &>>$log_file
echo $?

echo -e "${color} Download application content \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file
echo $?

echo -e "${color} Extract application content \e[0m"
cd /app &>>$log_file
unzip /tmp/backend.zip &>>$log_file
echo $?

echo -e "${color} download NodeJS Dependencies \e[0m"
npm install &>>$log_file
echo $?

echo -e "${color} Install MySQL client to load schema \e[0m"
dnf install mysql -y &>>$log_file
echo $?

echo -e "${color} Load Schema \e[0m"
mysql -h mysql-dev.sushma143.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
echo $?

echo -e "${color} Starting backend service \e[0m"
systemctl deamon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl restart backend &>>$log_file
echo $?
