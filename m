Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4033AE77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 20:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBre-0004mk-Ju; Fri, 13 Dec 2024 15:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tMBrN-0004gG-LG
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 15:02:02 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tMBrK-0002zD-Ao
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 15:02:00 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDBhosg018442
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 20:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Vmbch0uSHVZX2KNieGeI0a9HN96cM57DNXqGsNX/C6o=; b=FxKF0XHKdLFJ0NL/
 F36Z1WrJeQd1qkZZ+Xr7ikS7ZneawlWmiXigG5LcSp5yNd0oVh9D5amS4gRgObIA
 GJ3nQWNAo4YYyPYiHgS+GDQc023QbTETnf75lgOE8HGcytD1SzFUbVeTyM/3JI8i
 VmzIwL+NxKmITJNtHzrAWvRjkz+L4vx4naqqz4zmSANxmtOdcj6OftMW0B6365XE
 VuuA+UiCfGHT0JfyzuHEfOoQCZfdIfThZj5dcvaQIiR+8k1v3iVOePO51rqi1Dsj
 BPgNnZ+7V4S4eD16BNY/aUlAb78F9WihfQxLwpI4Ge4JMQr4Zqrzehw9yMnunLaV
 bg6ETA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gmac16yq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 20:01:54 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b6e241d34eso283304285a.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 12:01:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734120114; x=1734724914;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vmbch0uSHVZX2KNieGeI0a9HN96cM57DNXqGsNX/C6o=;
 b=WSpU6Ou8lb5yE+x/WfoW6AiGwVTGeFELKRfESBZ8BxENlQwcXF6BRKpo8l45zKJy0n
 JpyOkibsJD3RlFwOH/7lKkDls482tx382EO4qFKkteZmHOykV/HxUr6FDzRvQEvW9QKi
 33nKybEPS8ntmYKK7S0ErVn5Lawk+YSCVT6CanM8sEQp1gMK4/MghjKlNt7intxUJk7b
 qJwg+tbZNhvztCEsqb7+gkyRDcp12XME9QoExkW2deWtf6AZ85/JaI9bNw85V3w+RO6A
 tywS4IQZ+pQ52mWFO/gwMBO0NTcY/bFdGtzsErkhshXsCBhjCXEQ5H0Ip0j0sAjOXnqr
 SJ1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbhw0km/8xTsDxXryHYq8earWk2yZbB1CuYvQAceJpNl2nny8Xdm7Ye26AgOlshr8wPcT4kyfIivOD@nongnu.org
X-Gm-Message-State: AOJu0YxsyDHVeGakqJiOGZEu6DivcbkHI044f513E78rX8nftWkHnD5E
 BB7SwYGNNmqEUk5Hwn0OmtEhGsczJzqPUVU+RWBCt5gyZHWx16/VHGwz2s78d2ZYr7JozAVNxGs
 cFOnoQ3FK0DtUZZDl7/TbZSUHI6CMsssJBkZJ0fetuh/5HgtaKNC+/1H9327F3Q==
X-Gm-Gg: ASbGncv1vPwecEN8/e6wtFFRvtXF4XTtA0AhJhSiD0hcP5JHovTJMQVqMzoa/4bYEev
 ScO8c2RrqhmsHhaf/MftnmiOdDE3fDpy0g3pC5BELT1eYBdtM/0XFg5p+8KfCmT84p2jd4dRosA
 0b5+eDXstg79xrd5cFRyi3Ix+1THcvbMb7pNwTYLalvx8D1LeNKZmgXgsUvEM5CUiSAtfySNhpN
 AA1ELxu0VZ8lPerQD2uZyCoQpOMsXy6qf5e6a6l2FU6BkMqGhUqDkEADU+VnpWS0CGj3vOFOJ+v
 UipipiNeQAkb+F75fNsuajlxwnSXDGqe+9/1+SE=
X-Received: by 2002:a05:620a:46a6:b0:7b6:d393:c213 with SMTP id
 af79cd13be357-7b6fbeca5b9mr546893785a.8.1734120114072; 
 Fri, 13 Dec 2024 12:01:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/UePEFY738qnCKtbVrBLQ3qfNFzvGo8J3/rDMBRde5I7NnFrLTzGFJp5oFtFQtfE4Z3RcRw==
X-Received: by 2002:a05:620a:46a6:b0:7b6:d393:c213 with SMTP id
 af79cd13be357-7b6fbeca5b9mr546890485a.8.1734120113749; 
 Fri, 13 Dec 2024 12:01:53 -0800 (PST)
Received: from [10.222.168.90] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7047dff17sm9515985a.44.2024.12.13.12.01.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 12:01:53 -0800 (PST)
Message-ID: <8c48018f-e772-4aef-b6e0-ddbe6c7b13d8@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 14:01:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/71] target/hexagon: Constify all Property
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Brian Cain <bcain@oss.qualcomm.com>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213190750.2513964-7-richard.henderson@linaro.org>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20241213190750.2513964-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: jXfadnA0puJ1m2-oQRqSUlyeWsb2F8SC
X-Proofpoint-GUID: jXfadnA0puJ1m2-oQRqSUlyeWsb2F8SC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130143
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 12/13/2024 1:06 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hexagon/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index c9aa9408ec..a70007245e 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -48,7 +48,7 @@ static ObjectClass *hexagon_cpu_class_by_name(const char *cpu_model)
>       return oc;
>   }
>   
> -static Property hexagon_cpu_properties[] = {
> +static const Property hexagon_cpu_properties[] = {
>       DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, lldb_compat, false),
>       DEFINE_PROP_UNSIGNED("lldb-stack-adjust", HexagonCPU, lldb_stack_adjust, 0,
>                            qdev_prop_uint32, target_ulong),


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


