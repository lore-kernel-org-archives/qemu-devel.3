Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A75CA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI6b-0002At-IZ; Mon, 01 Sep 2025 23:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI6Z-0001zG-6p
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:54:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI6R-0005VZ-Hl
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:54:46 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S2ei013176
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U6PwOan1A83CikTWzfuGC3mzOnnmos/q4b8cMO0Z0wI=; b=pBcV86KFJR9QHq6s
 ZvOiYqh962gUdmj3sKOt65gXbIkU/OgRyflmqIAo7JcaKsDIgTvgUon83RGPaPMb
 zNoZH+4vcOULeJYXPJCJZV078zhxYU1Dc8adpqzdGI4p57ce0e6OhMfUNAjdloaJ
 Iln3HDg9QECJjPw3HEypGV0tgznMkpNoCAn4SSKLgBhGu9UkscnU2aOfTDRZ6KSB
 Em1mhJamMDPlvR0rFA74o1CZECq2feZbZ+Q9EkDkmB7rAVUL/96egEhTRqrD98Vj
 jqvqvbD6e9VnenoYazrD0yLd3pjfsCpNQq/sNDqU1axg82Cc+MRGP/rnFxU7Lo9I
 snfzSg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2feahq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:54:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-248d9301475so67662155ad.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785276; x=1757390076;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U6PwOan1A83CikTWzfuGC3mzOnnmos/q4b8cMO0Z0wI=;
 b=SQcwHZnazuHXfpKtgpFbYxthiBLSkPrfq+8WGPSXofk1nvkWYcGHvR2vn2YagIy63m
 K2hteJYPVMpAmriye60wF3EublKivH9C0gVeISu7+ZTWCwT5qoRNeyMamz9EItVxmCdi
 gPbN1lQgfY3EZ7owjsCYhG6eGAzklQ+Us6p8c987phFmAxszKPE+LmSFZeguvjrHvW7c
 NEgxQwwhFiGcs+y49GPweoUXvq4v+fAH4dcNyBitRTxVKLysxQQs/4U4t03hhwJ0QeLE
 YGlex3aS0oYAYGiRRGCBr7063XzgYubhR0zECpK3ojnGZjRSqzmYoKxJlgJ/WixKiHfH
 guPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgiQ0oikc06BNTO6XCUM5HideJ8aPulGoW3d+gxw7zqs/xRAgQdK0fTOLTtQm7pa2q8YgHwj/YHeul@nongnu.org
X-Gm-Message-State: AOJu0YyU37Wj3CdgPwEK58+DocgnGnx/WJM390OkD4uHeP8sL6Gd1dvx
 5eDDDAox6lgm7M1PbOgZuEZIutwWoRfHZxeBMMICMa2AhGqtnCjt8pXmCWDFXaX5M6W4hsW9h0k
 X+yqmWbvHQB+eEyY9VkDug8gbJ4DBNCAza23A8ND0xcZLWYtkjs9v2qNeIA==
X-Gm-Gg: ASbGnct5Ys+lFZpEPrm0B/gQ+/p8/pFAKRmO+EpKuvcXPql5VTw6/oXqUYwIEYnY+Mb
 AsFcXraGYBGGaRxFRs6LGFowM973Hdre2PMIZgWppnHBvyufZzVpxr8MuWMi6DdN/y1eo4oh9wj
 cPSv/mbJC4lloUUvIGH9HtiexDNgn8z1SpXalrTi4NUJQlc1/+DTK/F5HvtMQ7D43L0aqzQusB9
 tggYdILm67FolnwVbhIeBvtkfQzm3yo0+8Uh32s9QjpJMWVihHcWA3/TldmN899OQCLaRRgLPcb
 Dhwnqh01/VYxuyMOSLQWQhk5x5z4HY5evkq92iXXylupGCQ+oeFQCpQoYUfBow==
X-Received: by 2002:a17:903:2309:b0:248:ef1f:bbbe with SMTP id
 d9443c01a7336-249446d2b42mr128890805ad.0.1756785275660; 
 Mon, 01 Sep 2025 20:54:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgI/0MuU0L5vdRMFhMj1NIDXf/MxszPvv57W8u8884vH2cXSN3FZU0lOc9flNOfDB1QAT4Cw==
X-Received: by 2002:a17:903:2309:b0:248:ef1f:bbbe with SMTP id
 d9443c01a7336-249446d2b42mr128890645ad.0.1756785275242; 
 Mon, 01 Sep 2025 20:54:35 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24903727e23sm119295495ad.45.2025.09.01.20.54.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 20:54:35 -0700 (PDT)
Message-ID: <4e829933-c934-47c3-8cc2-5f0bc7ff6b5c@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 19:47:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/38] target/hexagon: Add implicit attributes to sysemu
 macros
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-24-brian.cain@oss.qualcomm.com>
 <009501db92d5$40aa17e0$c1fe47a0$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <009501db92d5$40aa17e0$c1fe47a0$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX5UqgioGf/TGp
 6gmrGjVj/Gx6AmXGNlcrbmhACfV86NspyPwkMespzB61v6OdjA7xbci/aS3QXjyGjEhrrAbnKRd
 UWeZHSJrG5m5H4DfIPQGO5WK3mCVUAhgWsvEY/YYTLN3BPnAAT8VJHF5+KjyglKtT5+Fo3EicIW
 OPUNLnqY6yYX0TIELiS1b7+y14AoEq8k0aNi0eecHjKGg+UqXdch7R9yDuYf217WGdSC14xZqm8
 NO+MKHNq6hcQO2r0RI9n5ZpMjORggO/j8i+X5RNmaUzTu9clSm54JKkzdzlavLHvPOnrz9ak2hg
 sAPqGemMQLg29Ob90Wh7TNBN9AB/hwWoqoNSJnve6V2DvUtekCmPEVElUjBiZ4ADA3sMEzlxeJp
 kRWHD1vC
X-Proofpoint-ORIG-GUID: jXm05Kg_F2tr3-nhBmUEyFNCPUpuATR8
X-Proofpoint-GUID: jXm05Kg_F2tr3-nhBmUEyFNCPUpuATR8
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b66a7c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=LKJEAGY7IiXhyOe4DOUA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 3/11/2025 5:30 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Friday, February 28, 2025 11:26 PM
>> To: qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
>> Subject: [PATCH 23/38] target/hexagon: Add implicit attributes to sysemu
>> macros
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/hex_common.py | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/target/hexagon/hex_common.py
>> b/target/hexagon/hex_common.py index 1e94e1fef5..7b5bb2cd46 100755
>> --- a/target/hexagon/hex_common.py
>> +++ b/target/hexagon/hex_common.py
>> @@ -128,8 +128,13 @@ def calculate_attribs():
>>       add_qemu_macro_attrib("fTRAP", "A_IMPLICIT_READS_PC")
>>       add_qemu_macro_attrib("fSET_OVERFLOW",
>> "A_IMPLICIT_WRITES_USR")
>>       add_qemu_macro_attrib("fSET_LPCFG", "A_IMPLICIT_WRITES_USR")
>> +    add_qemu_macro_attrib("fLOAD_LOCKED", "A_LLSC")
>> +    add_qemu_macro_attrib("fSTORE_LOCKED", "A_LLSC")
> I don't see a use of A_LLSC.
>
> Otherwise
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>
>
>> +    add_qemu_macro_attrib("fCLEAR_RTE_EX", "A_IMPLICIT_WRITES_SSR")
>>       add_qemu_macro_attrib("fLOAD", "A_SCALAR_LOAD")
>>       add_qemu_macro_attrib("fSTORE", "A_SCALAR_STORE")
>> +    add_qemu_macro_attrib("fSET_K0_LOCK", "A_IMPLICIT_READS_PC")
>> +    add_qemu_macro_attrib("fSET_TLB_LOCK", "A_IMPLICIT_READS_PC")
>>       add_qemu_macro_attrib('fLSBNEW0', 'A_IMPLICIT_READS_P0')
>>       add_qemu_macro_attrib('fLSBNEW0NOT', 'A_IMPLICIT_READS_P0')
>>       add_qemu_macro_attrib('fREAD_P0', 'A_IMPLICIT_READS_P0')


Purged - thanks for catching it.


>>

