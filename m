Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C04C36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 02:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tznSH-0006pk-NA; Tue, 01 Apr 2025 22:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tznSG-0006pF-1N
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 22:03:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tznSE-0007qW-8M
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 22:03:47 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531EL1RW024628
 for <qemu-devel@nongnu.org>; Wed, 2 Apr 2025 02:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bpEgKuquQ3FANAQtRVpjCGkPB9W87goVBf/ZQI+J56Q=; b=bnXpfqudwxJtYWeC
 MW6jhSX7dYg00l9gEyILyVNjPW1Zcy8H7Rn9ldPZIM6LP9YPOPAMs/KYiAyJZho/
 rYPlzBvzzFgH/EzscrbbZNpd5TMf2W6BTgFB/zBCowf1btRfP7VuGJ9No8sQ432v
 TMuaXI6itXNhvyoh2okd/nWVp9JXWOp/TrcfiUqNvr0OvMCJ2eSKR2RcFF3ZjQxh
 B+XrGGGCt6XH72pqt3gbw0+wl+9NMpDKjKKGHNiCaW/l0ssuq9m5sDKRfPxBVYjb
 KL1c2u73IyYS12k7S8c5qzoKtfKXk9dWwR9sWf5MDFFqjWrg7xx0rKbKnelQl0t5
 SvXXsw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45rbpytute-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 02:03:43 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2240a96112fso196443315ad.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 19:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743559423; x=1744164223;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bpEgKuquQ3FANAQtRVpjCGkPB9W87goVBf/ZQI+J56Q=;
 b=M8RcC0Uad3oK0LKWG9F6IBghnnel6sEeuaat8SkXTz4+z2SXishM/HH2RNA4nW1LE4
 f386dmPZFZDGu354w9iskf+gkH8hXTNhdIYeLF5BE1+ktl7s43LHCEqiDrrg5KUZ328i
 cwfxnffYUXd7yh/ig8rg2p8PTLgNyrgh528yKwpd++/GmWO4oUVmbDetvrplE8aMiZ0N
 tXcfh2YAEwm9NE1Cq7KCNHNGRGv3ZX5WvZILvrCWLcTX3HOixhfRtzBhaBb+CysKry3v
 dleJf+FQTfODvdiVc6Eif1tDQDZJCBAYD+pN3mqwilrspSUSfgZx+AM6rGJc87R75una
 Bi3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaSnooxcdRp3HOA3g4kzypNVdyyKeyVTjgfliz+HcKiz8Hop/d1MCOjL+J+0HU1rcY54OBWbkRnF3q@nongnu.org
X-Gm-Message-State: AOJu0YyY4hmF6KIWt+Nsjdq8+ssdVgwovuPnazkQMn3zgqQAatIaeIx0
 HmB2zscusfAfCgLiL5Q7sI82sqG0Z8oPBbXIaBbS6WWKfqLbiiYw/ejmLjV3jGKJxef6uC3Wsf1
 OLmiiFcKXvy6Bn/5mzeXZJ8bCKS3i1mm1EVgxbfCthhxe3xrZpa/r+w==
X-Gm-Gg: ASbGncvS/7z/9/qCI1DmvQae8yc4u0tf+GSI3VOWTFO8r8vZrc5k8mewLdybsfDJFsn
 YDIWiqovx07ZY/QLTIooKlUKHnw267w06THc1yFvQfhC6u+8EYVIY0zy8yUfVcvT2fvnII5F/hQ
 hAy9T3zzEKpNFzHiSwg+bbUnY3S78/cL6N4leV+VhhL4z35s6hi7thSAaqaHeDrdds7p1UCPLvR
 dmomjewrJ+O3FA0RyIr/pN7NSq9Iw156Nx2LVPj+8Odw2zObR0JYHK+QtuWBooIlTRXW1MiCKOZ
 W4izdcoGUwqGOVmCa0VvzK34ToR5t+E5Zui+H3uxERGFjrvyV+9dCs9UBoit8kNFU1884ZX9Cyk
 SbEtjbm1078KxkQS6
X-Received: by 2002:a17:902:da83:b0:21f:f3d:d533 with SMTP id
 d9443c01a7336-2292f94240fmr228141855ad.2.1743559422872; 
 Tue, 01 Apr 2025 19:03:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCDXwna0W3JjLNqTUiUswFT+XkP3cmN4lYnJ4Mw+0DaOtuV3UnYHs8ETEISqwTFz87hLArhA==
X-Received: by 2002:a17:902:da83:b0:21f:f3d:d533 with SMTP id
 d9443c01a7336-2292f94240fmr228141595ad.2.1743559422404; 
 Tue, 01 Apr 2025 19:03:42 -0700 (PDT)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73970e1d922sm9765450b3a.37.2025.04.01.19.03.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 19:03:42 -0700 (PDT)
Message-ID: <c611b189-a224-4a38-a9c8-ef5ae28f751e@oss.qualcomm.com>
Date: Tue, 1 Apr 2025 21:03:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/39] target/hexagon: Implement get_exe_mode()
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-9-brian.cain@oss.qualcomm.com>
 <017501db976c$7a2181c0$6e648540$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <017501db976c$7a2181c0$6e648540$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kwrctb99yvsjlSFhRhJjbPm0TmPCkE7N
X-Proofpoint-ORIG-GUID: kwrctb99yvsjlSFhRhJjbPm0TmPCkE7N
X-Authority-Analysis: v=2.4 cv=ZNLXmW7b c=1 sm=1 tr=0 ts=67ec9aff cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=54_VnY60zeZCF6dr1K4A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_01,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=844
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020012
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 3/17/2025 1:43 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Friday, February 28, 2025 11:28 PM
>> To: qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
>> Subject: [PATCH 08/39] target/hexagon: Implement get_exe_mode()
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>
>> diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
>> index e64568b9fc..e0dd120cd4 100644
>> --- a/target/hexagon/cpu_helper.c
>> +++ b/target/hexagon/cpu_helper.c
>> @@ -237,6 +237,30 @@ void hexagon_ssr_set_cause(CPUHexagonState
>> *env, uint32_t cause)
>>
>>   int get_exe_mode(CPUHexagonState *env)
>>   {
>> +    g_assert(bql_locked());
>> +
>> +    target_ulong modectl = arch_get_system_reg(env,
>> HEX_SREG_MODECTL);
>> +    uint32_t thread_enabled_mask = GET_FIELD(MODECTL_E, modectl);
>> +    bool E_bit = thread_enabled_mask & (0x1 << env->threadId);
>> +    uint32_t thread_wait_mask = GET_FIELD(MODECTL_W, modectl);
>> +    bool W_bit = thread_wait_mask & (0x1 << env->threadId);
>> +    target_ulong isdbst = arch_get_system_reg(env, HEX_SREG_ISDBST);
>> +    uint32_t debugmode = GET_FIELD(ISDBST_DEBUGMODE, isdbst);
>> +    bool D_bit = debugmode & (0x1 << env->threadId);
>> +
>> +    /* Figure 4-2 */
> Figure 4-2 in which document?


I don't think that document with this figure is published.


I'll just remove the reference instead.

>
> Otherwise
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>
>

