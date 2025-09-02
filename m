Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D048CCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI3d-0001XL-G2; Mon, 01 Sep 2025 23:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI3b-0001Qx-As
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:51:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI3Z-0005B0-3E
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:51:42 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RnmC029672
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bHAJ5ICgrm08NHWiZez6eH+RQ/7jUCDny6R4+ElkOUI=; b=DwVuTeSC8XvUDEHz
 y3kIMBrZp+JPMBrTJyllo9FE91F8WavZFhC6d70wVaD4o91cU7QeYKK2T0Ph7JK5
 AXKgt1kgIOBUp2Z3hsuYWxzNyRTDI/UCzDcca1pypLcFILJAVRipQQafZoXbBLkC
 ZueoyaShHShzXUBKJXPsfPockcUGffsEQUvlYRbIGdCsG7uaqGzG3w0MmtZWs1yo
 lete+ynzRkX52rwYvB/7DpWLBMx6Q9YFTIHuqWIG/BdxT4a4D0qpJSvNpvofOyTR
 2zFpYLGKAHrTZ/SKtrqZjiuUVi22gMXXZxIka7JFl4yzm0KhhvVmh/ZDhTRLqHJQ
 I/koKg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy2709-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:51:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-24927876fadso41826445ad.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785099; x=1757389899;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bHAJ5ICgrm08NHWiZez6eH+RQ/7jUCDny6R4+ElkOUI=;
 b=CdwIjVNtOU77Tf6C0ySMl44ze6jjEnrJkuZb/0IHNoddVA/0s9OuFCB/lZZyLJ4oG5
 /KrMCfsffA6nnmgcILDNqmJK+1+6JipIEmG57BJ+yIWXD5zblS1ElBJMO98zzXIwmwmr
 e7DxERnk029nN19g64V9UBIEYkFK93A5fenGX+kkPWs14aRPwZOv8yuwH9R+s0s/b8bw
 mf4+oysuH91wGAs5kBxwljiT7pRcVElMt+0ZUqNTgWLiKDAhk04lKT55L0t91BvE1q6H
 4BIHA7Ms8KUVFIEgX+TaZYQ87qF6MYQ7JKB2/jKZa00cTV2L+7nflV4+pJflRlIyvXSi
 eT6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLZQTQGwLXAUEy1uG23jma930EDmklhb2/zJy49GW+jVxgUOLhoCfVfGL1vn8iJsiobkA7izqIY4/+@nongnu.org
X-Gm-Message-State: AOJu0YxIkBb4IrHyDjbPgxvJiw/ac5nxfWtdJuh4iafL6Ju0urIgdFin
 yR0e9yjLhyHd3FG34duKR/Qk92sz7s5pVJ9GeLuLEiMcyNJLcPS//BxCBsk6TTjcLrUccFKRHhe
 X4qVdUweKD6WC189tJs5UasveYOcVmJlXEbNZwwYtBpACOO/mctyMN42ewg==
X-Gm-Gg: ASbGncurv9iDWcLrpYHbwDt0bLZnuC7i86Uv7mlMkINpBNULCnKU9NMFwPpceyTDSjZ
 DS9hMM8YRsWaiX33hwM3znA5S9Z9HcUQsfQGa2r6MOzZRrkZoeJxfabxfyi1oOow8ySBDkrvzfg
 WcHV1Sa4VjXUr9ZonOOTZRSTeplT7SYCNrGOZVOTuwpngEDaR/tKkF9uia/ixW4tb+YZKalrPoA
 5BOEtqf4Wc5J+uUue1LWP0quz6ypfMKg6uaZTIRY30ZouK4iDgQUBGA6DshxoDCtcpoAvoS2JVd
 flzSdPv3hWm2BLtTmpAXwtr/eTuHFdJnsxdP3Sj9Q4+tR2riMgVv0jgTXmlClw==
X-Received: by 2002:a05:6a20:3d07:b0:243:a251:cf5b with SMTP id
 adf61e73a8af0-243d6f7ec09mr12487402637.57.1756785098789; 
 Mon, 01 Sep 2025 20:51:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ453eH+pRIdIwHOdD+SAuB+MtkdM2qjnON4vi3/PicAB2mLTUduWZHynx62OVTuNmEUe3nQ==
X-Received: by 2002:a05:6a20:3d07:b0:243:a251:cf5b with SMTP id
 adf61e73a8af0-243d6f7ec09mr12487377637.57.1756785098353; 
 Mon, 01 Sep 2025 20:51:38 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006c340sm10903626a12.1.2025.09.01.20.51.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 20:51:38 -0700 (PDT)
Message-ID: <5a792230-3c01-46ba-9bf7-f48becb9aaba@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 19:25:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/38] target/hexagon: Add guest, system reg number defs
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-9-brian.cain@oss.qualcomm.com>
 <023901db8ede$f8dc6980$ea953c80$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <023901db8ede$f8dc6980$ea953c80$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b669cc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=NhHuhPAb4ofzREI8okgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: iWIdGfipnMLDstoQuj97kLcNiHWdAwR6
X-Proofpoint-ORIG-GUID: iWIdGfipnMLDstoQuj97kLcNiHWdAwR6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX3LDTlBfU3dY1
 Ev/uEMaGKhydjHOpVUTAc8joV3FOyuDL3o3xSfPMfb96FelqI3G6c1/wcKmEL7yb+C17KDyq3jw
 uq0KvaXCLsQU/8YFVHBs01NTxa4P4hZKY0IVzXvMb75Bnr9jSw6IcP5Jd+NPJmahUeQiTZ6dTXl
 haqAPLg2HBUPRt9kMG2LbCU8GeVoLZVguapcEC0y3km6mtv5lXdhGCH7XaLnXWDbr5qGG7AjaOO
 JJVhDWOfohjM2Z1kjDuB1XJhak6lkCqqTLEbwiQpKYl/QYw5uOSqLCBYNSJ2DnhKXQ0gKdlKb6r
 2yXnHha+Q3UawHF0ZgJCZNPqcPsL+Dp8iZMREFUSAmForHkoqCpe5SiW5oRk84kWu/YC3bE2k1D
 YQvVSbZc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 3/6/2025 3:30 PM, ltaylorsimpson@gmail.com wrote:
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
>> Subject: [PATCH 08/38] target/hexagon: Add guest, system reg number defs
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> These registers are defined in the Qualcomm Hexagon V71 Programmer's
>> Reference Manual - https://docs.qualcomm.com/bundle/publicresource/80-
>> N2040-51_REV_AB_Hexagon_V71_ProgrammerS_Reference_Manual.pdf
>> Refer to §11.9.1 SYSTEM GUEST, §11.9.2 SYSTEM MONITOR.
> Strange to put this in the checkin description.  See prior conversation about doc references.
>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/cpu.h      |   5 ++
>>   target/hexagon/hex_regs.h | 115
>> ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 120 insertions(+)
>>
>> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h index
>> 79e60d4bfa..20ea0adcca 100644
>> --- a/target/hexagon/cpu.h
>> +++ b/target/hexagon/cpu.h
>> @@ -20,6 +20,11 @@
>>
>>   #include "fpu/softfloat-types.h"
>>
>> +#define NUM_GREGS 32
>> +#define GREG_WRITES_MAX 32
> Can you actually write 32 G registers in a single packet?
>
>> +#define NUM_SREGS 64
>> +#define SREG_WRITES_MAX 64
> Ditto
>
>> +
>>   #include "cpu-qom.h"
>>   #include "exec/cpu-defs.h"
>>   #include "hex_regs.h"


The above issues should be addressed in the v2 patch series.


