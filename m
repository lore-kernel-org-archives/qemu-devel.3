Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E5EC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 15:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0irD-0003mr-EP; Fri, 04 Apr 2025 11:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u0iqu-0003lQ-6X
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 11:21:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u0iqp-000431-3W
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 11:21:02 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 534EsI3n032626
 for <qemu-devel@nongnu.org>; Fri, 4 Apr 2025 15:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8aKpJNJbnRRrYcRrLQ2ezLqnQoni9cuDH+RP1telo70=; b=bctbEdKOeLnLe21k
 Yx+r5MP5yTjTch8Yvbq8vG7DQEa2PuGn9P0MfHCT19uDqdAO2FWop0DicZnsnKdX
 dE+tpPEL3S/+gyHvgx7WxgnKOOVpXXSB2oRI9bUEMlZgf5FyZCnpq7d3ZHod5D9V
 tRh8+BbS3KJq4e2uUyu5jAfsVgzAwFb004SjKe18Qqmo15wmN4va9kSSkLZ48XiX
 JDzE9nTHVfizczwNSty6VjCjW8AiIONVvaFu13CeiHYUGKg1AhKWyPgF2BEnmmAk
 U3v1kNEPEDHZQUDTx9pgu7SIWUJrU3yQeYzR+n9MxoNGM/JK305LZX+yk3HNb8LC
 l3eizA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45t2d8t7cv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 15:20:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c543ab40d3so322131385a.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 08:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743780051; x=1744384851;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8aKpJNJbnRRrYcRrLQ2ezLqnQoni9cuDH+RP1telo70=;
 b=u8ylN9AEbqGKLfjn6oE0rYmXtT+FIjGOXbX1nBU6KICJiheTEaDY+ayfng0upJ63Xt
 OVazrS2ZrFKzawU0DZU21MPjdrqkgLsQkbaFw5W7I1jRlAyitt0qExNvsQWjATFUvOhG
 TEpFs1/A6BlJ3R6Cc4ZdVpFB9oShmult/VLPy5oVeaQcRpuo+iW0nwC/BEF9syRCgGbW
 qVPTgOWx2+FOXNNRAKyxrGFjrjwSdq+zbN7KSPbE2pz3sPXZetVudaeymERJsimnI7qG
 teHSp+03ne/EGoO6A0cEVnn1nqRix4TvCD5y7CWyQ8b32sCGsp1fMPF0atXNNZlP3+od
 DK0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYYp9jrWg96oD9yb9x5zF8tX+sWb2Nhu5lGP8BhxwH90gWEzkJibW+jBzkP7yTBWVW2wIENlivY3bh@nongnu.org
X-Gm-Message-State: AOJu0YwEE2uZ3EhWF1FANCt/LDSLV4rEpjTIFAzCwMWN259Br/34P5iN
 CImbqqoUiscnqjXlqgJ1zky2hrx554rHAvi8bS+3TZ1BgViuVDTHkdXzARkmaYXe2x32nRZWWiL
 t3u1p2QFndtnFELSdtJ9qiApO3sr33IYCsPoUHXH0O+nqY189Xvf0qA==
X-Gm-Gg: ASbGnctotK/Z1p7UCDJCkzZgFOCU2YxiKgceOG47Cqb3QYHo8BhElc32P4IH//G6LNy
 BCqYeLOGebbyn526vEmJxksBoQzt0GvZm8e6s3zTdqRyqKPMSaO2wDstL6MpvGFO71nIM40UgNr
 U3OU+ZQn7zw9nFnnzYskf2grICwFja4zgR5+KWRtvOPpjihqje6g51w5qyixZ75spr4QyFhZpET
 OIaOcUmV3+3+Je3Uhr15cT4+Y2qB4t68pFmgOwVX0tURVZpzCq9C6w9fndxVXGXh83fa8/bLoZY
 10zSGAtXAFnIW4s8ZIutj2X5HwGnVPSPP6YFa5l8wE5mixdYn6bXm05Cy2lO3YVy1aD+37chOQ=
 =
X-Received: by 2002:a05:620a:4452:b0:7c5:4de8:bf71 with SMTP id
 af79cd13be357-7c774dd918cmr431834585a.50.1743780050748; 
 Fri, 04 Apr 2025 08:20:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYXUJV5WdXKgQyGdcOW2jfR4MbNW4NGmVzo62ni7M9TwQ1q1ucKzixD9rVj5YH0KaFsTsAUA==
X-Received: by 2002:a05:620a:4452:b0:7c5:4de8:bf71 with SMTP id
 af79cd13be357-7c774dd918cmr431830985a.50.1743780050412; 
 Fri, 04 Apr 2025 08:20:50 -0700 (PDT)
Received: from [10.222.168.90] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c76e9689absm228720685a.49.2025.04.04.08.20.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 08:20:50 -0700 (PDT)
Message-ID: <15288f34-b8ff-4cb0-86ad-799ea66e8327@oss.qualcomm.com>
Date: Fri, 4 Apr 2025 10:20:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] target/hexagon: Add memory order definition
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
References: <20250404025203.335025-1-brian.cain@oss.qualcomm.com>
 <20250404025203.335025-7-brian.cain@oss.qualcomm.com>
 <3b0711cc-3747-4cba-a759-8a74de500e0c@linaro.org>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <3b0711cc-3747-4cba-a759-8a74de500e0c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Iy2v1BZqhvM7E1OkRdTkuyN_HFsAdkwC
X-Authority-Analysis: v=2.4 cv=IeOHWXqa c=1 sm=1 tr=0 ts=67eff8d4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=GaQpPoNlAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=xmxzQhnxIJ6quC8AXHwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=xF5q_uoM5gZT5J3czcBi:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Iy2v1BZqhvM7E1OkRdTkuyN_HFsAdkwC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_06,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=963 spamscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504040106
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 4/4/2025 9:33 AM, Richard Henderson wrote:
> On 4/3/25 19:52, Brian Cain wrote:
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/cpu-param.h | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
>> index 45ee7b4640..ccaf6a9d28 100644
>> --- a/target/hexagon/cpu-param.h
>> +++ b/target/hexagon/cpu-param.h
>> @@ -23,4 +23,9 @@
>>   #define TARGET_PHYS_ADDR_SPACE_BITS 36
>>   #define TARGET_VIRT_ADDR_SPACE_BITS 32
>>   +/*
>> + * Hexagon processors have a strong memory model.
>> + */
>> +#define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL)
>> +
>>   #endif
>
> Excellent, then we have that covered with
>
> https://patchew.org/QEMU/20250321181549.3331-1-philmd@linaro.org/20250321181549.3331-2-philmd@linaro.org/ 
>
>
> and the follow-up
>
> https://patchew.org/QEMU/20250321181549.3331-1-philmd@linaro.org/20250321181549.3331-8-philmd@linaro.org/ 
>
>
> which moves that macro to a field in TCGCPUOps.
>

Oh, I see -- thanks!  Will drop this patch from my series, then.


>
> r~

