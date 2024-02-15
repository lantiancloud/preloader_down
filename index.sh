git_proxy="https://github.moeyy.xyz"
git_url="https://github.com"
git_repo="LiteLDev/PreLoader"
git_assets="PreLoader.dll"
download_url="${git_proxy}/${git_url}/${git_repo}/releases/download/${version}/${git_assets}"

# 自定义颜色变量
turquoise='\033[38;2;32;178;170m'
red='\e[91m'
light_blue='\033[38;2;173;216;230m'
yellow='\e[33m'
green='\e[32m'
blue='\e[34m'
# 结束彩色文本的标记
reset='\e[0m'
# 输出标记
log_info="${turquoise}INFO${reset} [preloader_down]"
log_warn="${yellow}WARN${reset} [preloader_down]"
log_error="${red}ERROR${reset} [preloader_down]"
# 构建显示时间函数
update_time() {
  current_time="${light_blue}"$(date "+%T.%3N")"${reset}"
}

# 检索版本列表
version_input_check="$(cat versions.txt)"
version_list="$(curl -s https://git.lantian.pro/ltcontainer/preloader_down/raw/master/version_list/versions.txt)"
update_time
echo -e "${current_time} ${log_info} 正在开始下载PreLoader"
update_time
echo -e "${current_time} ${log_info} 请选择要下载的版本${green}(建议选择最新版本，按下回车键自动选择最新版本)"
while true;do
  # 输出版本列表
  latest_version=$(echo "${version_list}" | head -n1)
  echo -e "${blue}●${reset} ${green}${latest_version}${reset} ${yellow}(最新版本)${reset}"
  # 处理数据命令
  echo "${version_list}" | tail -n +2 | while read -r line; do
  echo -e "${blue}●${reset} ${green}${line}${reset}"
  done
  
  # 读取输入的版本
read -r input
# 如果用户按下回车选择默认版本
if [ -z "${input}" ]; then
  version="${latest_version}"
  update_time
  echo -e "${current_time} ${log_info} 开始下载PreLoader ${version}"
  pget "${download_url}"
  update_time
  echo -e "${current_time} ${log_info} 下载完成"
  break
  exit 0
fi
# 如果是其他版本
if echo "${version_list}" | grep -q "${input}"; then
  version=${input}
  update_time
  echo -e "${current_time} ${log_info} 开始下载PreLoader ${version}"
  pget "${download_url}"
  update_time
  echo -e "${current_time} ${log_info} 下载完成"
  update_time
  break
  exit 0
  else
  update_time
  echo -e "${current_time} ${log_error} 请输入正确的版本号${yellow}(按回车重新输入)${reset}"
  read
fi
done


