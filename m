Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005DEC5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 10:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHRT-0005yX-Qh; Tue, 18 Aug 2026 06:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wwHRS-0005yC-Ig; Tue, 18 Aug 2026 06:53:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wwHRQ-0001n1-TB; Tue, 18 Aug 2026 06:53:14 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IAVUCP028442; Tue, 18 Aug 2026 10:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SQkYWa
 PPS8eGLfBrmoOg0G17Ay7MNM3hULHF00tbZVI=; b=BPTrk/4ja738ihnfaCFAuD
 49jn9iRl06Xx87fhT6rByGGLSf4iTs7UK0dMAF2T+0hYgQrQFRogrK+LiK5w/ROO
 yxAY8ragjWj9AfkBwzF23XZd/KS6uhF5Fd00Sk6GyxFOI97brjpTPB3fOiL0w7hC
 cnVGlxXd6xFd7/xnDtailAzGcoY2ZbaVJWWmVsS+mA/yZoQW+t6pOQ6LUbBFsV3f
 gVYaX1+qTyhPOa1bR+1BfNwsvo1dPQtBAdiN2WpWRI2ZsP9ZrwItKDxqFRleSYR5
 +KfYu+7Q8zV01e/jZj4ga9NTmLJaIITHJ1hPZEh6GcYPR0MXuf9su8yxr6GDW3YQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4qpgk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 10:53:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IAfOEZ015035;
 Tue, 18 Aug 2026 10:53:09 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh2rew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 10:53:09 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IAr78A31326944
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 10:53:08 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A08BB5805D;
 Tue, 18 Aug 2026 10:53:07 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 932B058059;
 Tue, 18 Aug 2026 10:53:05 +0000 (GMT)
Received: from [9.123.8.229] (unknown [9.123.8.229])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 10:53:05 +0000 (GMT)
Message-ID: <712a4fd8-0827-4ee3-a4db-b31220fa2313@linux.ibm.com>
Date: Tue, 18 Aug 2026 16:23:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/ppc: Add lower bound check for watchdogNumber
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260818091019.51350-1-rathc@linux.ibm.com>
 <20260818145508.a2e068cb-0d-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20260818145508.a2e068cb-0d-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: zwFd7oqnaNGT9-DNxVhjkOnrbs47WWbH
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a843996 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=3hNtqh366n-UaAJ05w4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA3NyBTYWx0ZWRfX4fPPkVpqz5Ab
 TVsEtRyf7SUj9HlE0SEaFEvw1JuXN+GBXCMujWUjKvjfVTf/MXjF+MXVj2wmVQC7vUmLWG1qr3M
 KRfxHQAuq56T2J3lGsGmKAkVRSpaBpI=
X-Proofpoint-ORIG-GUID: TfZ6pWLLLAw1-sQDUMlai-pHFM3fQXuB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA3NyBTYWx0ZWRfX/98XWrTRohsq
 WGJ0iVEDjZTDEBYeX/gTZ2LeFVfp8FJPKWEd9TbifBYpb4lzu4k1ggGkUK0fnhbX7YU1u/OP6+3
 5UNFAzxns1mFCkvW+wPCP145BYexBet61gcag7R9YwOQh7YF+qVMtz27DNQU9OvXQTzaynZab+L
 8NCq1Fx4Ojd4VohXpNuqYR+tBkspL1Ejq2uEgPeR2biU+l/MgApcUzcxaI9vm76fJTxWvyAoVkw
 lJK+pi8F4poOToqMBRrfSXlaBE9QPkDg/Y+dcPQnkwc0J2G2oDyLykIy2dfVcqQ5Bcos1mL0KOl
 Ha7Nr1NTMVMVu7/Vo7tP8UAHTkNitzSCPe6rbsbFLR0RTAHzpKdXfOre/ro7kCttP0xYAzZI9kV
 Y7A2Rxrs/ZJFk7vIPyNftYkeBAgJgoQb8DUKAa8mkCdNdjYVPS+uUACZUXuwngZt8zsi/w84IiL
 81++E/xFHSkacLIiGQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180077
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 8/18/26 15:23, Amit Machhiwal wrote:
> On 2026/08/18 02:40 PM, Chinmay Rath wrote:
>> Add missing lower bound check for H_WATCHDOG H_CALL's watchdogNumber parameter
>> as per PAPR documentation ver 12.10.00 section 14.15.5 'H_WATCHDOG'.
>>
>> Closes : https://gitlab.com/qemu-project/qemu/-/work_items/3600
>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>> ---
>>
>> Changes from v1 : Incorporated changes suggested by Amit.
> Thanks for the quick v2 — the helper and the OP_STOP restructuring look
> good. One remaining nit below.
>
>> v1 : https://lore.kernel.org/qemu-devel/20260817105854.437724-1-rathc@linux.ibm.com/
>>
>>   hw/watchdog/spapr_watchdog.c | 16 +++++++++++-----
>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/watchdog/spapr_watchdog.c b/hw/watchdog/spapr_watchdog.c
>> index 5b3f50de3a..460b4457a6 100644
>> --- a/hw/watchdog/spapr_watchdog.c
>> +++ b/hw/watchdog/spapr_watchdog.c
>> @@ -127,6 +127,12 @@ static void watchdog_expired(void *pw)
>>       }
>>   }
>>   
>> +static inline bool watchdogNumber_valid(target_ulong watchdogNumber,
> The function name watchdogNumber_valid mixes camelCase with snake_case.
> Per the QEMU coding style (docs/devel/style.rst), CamelCase is reserved
> for structured type names and typedefs — regular function names follow
> lower_case_with_underscores. This should be watchdog_number_valid.
Hey thanks for letting me know. I have posted the correct patch 
retaining your R-by.
I had gone ahead with this naming cause the variable itself was named 
'watchdogNumber'.
But going though the qemu coding style, since watchdogNumber is not a 
'structured' type, I guess it should have been named in snake case and 
not camel case in the first place.

Regards,
Chinmay
>
> With that fixed:
>
> Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
>
> Thanks,
> Amit
>

