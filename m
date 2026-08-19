Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA421C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 10:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwd9c-000465-NK; Wed, 19 Aug 2026 06:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wwd9b-00045d-5F; Wed, 19 Aug 2026 06:04:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wwd9Z-0000y8-9s; Wed, 19 Aug 2026 06:04:14 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67J6VrCh798121; Wed, 19 Aug 2026 10:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3G4OIz
 2l7WJjq2ksQqe3w+JcHc9VOsJn3A186FNeEJ0=; b=b2WCCSreZROcQK+sQ4+TBu
 qtLSPyGa+VWhd6gLsauY0dnbHMrv0IaUrFI+uGyF54J+iA0bzmtl4pBHQBl+EEfI
 7Sjfi/MPkbA/fyI6UnhS7ui3tRSrkqkWYC0NE4px/H8yDMpRWVUP6Vnh7L6qE7R3
 kamzxFAyT3Qk64eNDGvY6h7JTyYRgPKnD2OK8Q8l7D0gJYKjUIEXYdVxGRTn/hZM
 yuK6DkIGoBU/o+hOsVoTPogVjhxZJOITk5cANHT1SyfOIKFyxctkm59+glzuEfmC
 E2h/qERmKKlDYSxxQEsJ6Qe+thNDJKTOBw4bokwXbU0C+Mb1sUCz0oYa+kszq6tA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu02xt9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 10:04:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J9uJHL023302;
 Wed, 19 Aug 2026 10:04:09 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngg3r0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 10:04:09 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67JA48qp29819504
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Aug 2026 10:04:08 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7780D58060;
 Wed, 19 Aug 2026 10:04:08 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE6215805D;
 Wed, 19 Aug 2026 10:04:06 +0000 (GMT)
Received: from [9.39.17.179] (unknown [9.39.17.179])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Aug 2026 10:04:06 +0000 (GMT)
Message-ID: <1a184add-d994-4635-a9ca-f1a74aefd27d@linux.ibm.com>
Date: Wed, 19 Aug 2026 15:34:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/ppc: Add lower bound check for watchdogNumber
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com
References: <20260818104551.76023-1-rathc@linux.ibm.com>
 <01070c86-0a61-43e5-8f55-7f217a3f96a9@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <01070c86-0a61-43e5-8f55-7f217a3f96a9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2aDaDj4L7NXA9gHj3iW8q8CRL2UEHKEx
X-Proofpoint-GUID: 2aDaDj4L7NXA9gHj3iW8q8CRL2UEHKEx
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a857f9a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=ox8g-gRuRHoHs4K2XM8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA3NiBTYWx0ZWRfXzinHsh31fT4w
 a6FI/ILQr8s6DUL4MFWpx7e5QtNmjhjJ7nLIUTxzbEZ+R4CVt+9Bn6wpnYsKzhy9nirevZtJq3d
 wXwq8ySWjGKXzYu83l1g025h7Q+Zt2Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA3NiBTYWx0ZWRfX96Xol8x+xEqh
 siB4ZYLOKgdX7GMn2cAiWS/XUcMFYpuBB4etSRpEusWAqa745Q68W2jNKuRm4qQgoLLZDoslVsa
 dXEtsAQOjl5LL1l2lw7rp0ssdj6fSLqtx1odvfGE/0dMdxPW9tVqS4QSr71QtJnWSh7BJmRyXKM
 U3tG9s2HSbAL3hBtGSKK/hM5lnBaSpJRhuOYDPhj4mh+BJ12u0xv1rMFs1Td8AdA03Ovqf4oZXX
 TVyeAdrt9A566XW+z9IqF/V2rJVjZgZbGUszRBkrIvhJjx+Wg6WfggkkOTmQYfZo3TbjB/n7krx
 95oANq/MkeCGxG7ESl1IXVqa0p7FIfb4p7TQA5BZ/PALM/u58bWeRy7s4apv1eg8MKj6O1CA/Mr
 oyX6s/tltoMRymiDeW00dQQ1y8PYZbZOttFkHj3rnSNIQPiAieaDrLBmR+SI5ReVWdOoEJKEanH
 9zr6hIV1ku/5kjDXzIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190076
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


On 8/18/26 17:11, Chinmay Rath wrote:
>
> On 8/18/26 16:15, Chinmay Rath wrote:
>> Add missing lower bound check for H_WATCHDOG H_CALL's watchdogNumber 
>> parameter
>> as per PAPR documentation ver 12.10.00 section 14.15.5 'H_WATCHDOG'.
>>
>> Closes : https://gitlab.com/qemu-project/qemu/-/work_items/3600
>> Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> Reported-by: huntr bubble <bubblehuntr@gmail.com>
Hi Harsh,
I missed adding the correct commit message header here. Should have use 
hw/watchdog instead of target/ppc.
If possible please correct this while you pull in the patch along with 
the extra Reported-by tag.
Lemme know if that works.

TIA,
Chinmay
>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>> ---
>>
>> Changes from v2:
>> Renamed watchdogNumber_valid to watchdog_number_valid - Amit
>> Retained Amit's Reviewed-by
>>
>>   hw/watchdog/spapr_watchdog.c | 16 +++++++++++-----
>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/watchdog/spapr_watchdog.c b/hw/watchdog/spapr_watchdog.c
>> index 5b3f50de3a..5a72896066 100644
>> --- a/hw/watchdog/spapr_watchdog.c
>> +++ b/hw/watchdog/spapr_watchdog.c
>> @@ -127,6 +127,12 @@ static void watchdog_expired(void *pw)
>>       }
>>   }
>>   +static inline bool watchdog_number_valid(target_ulong watchdogNumber,
>> +                                        SpaprMachineState *spapr)
>> +{
>> +    return watchdogNumber >= 1 && watchdogNumber <= 
>> ARRAY_SIZE(spapr->wds);
>> +}
>> +
>>   static target_ulong h_watchdog(PowerPCCPU *cpu,
>>                                  SpaprMachineState *spapr,
>>                                  target_ulong opcode, target_ulong 
>> *args)
>> @@ -145,7 +151,7 @@ static target_ulong h_watchdog(PowerPCCPU *cpu,
>>         switch (operation) {
>>       case PSERIES_WDTF_OP_START:
>> -        if (watchdogNumber > ARRAY_SIZE(spapr->wds)) {
>> +        if (!watchdog_number_valid(watchdogNumber, spapr)) {
>>               return H_P2;
>>           }
>>           if (timeoutInMs <= WDT_MIN_TIMEOUT) {
>> @@ -170,11 +176,11 @@ static target_ulong h_watchdog(PowerPCCPU *cpu,
>>       case PSERIES_WDTF_OP_STOP:
>>           if (watchdogNumber == PSERIES_WDT_STOP_ALL) {
>>               ret = watchdog_stop_all(spapr);
>> -        } else if (watchdogNumber <= ARRAY_SIZE(spapr->wds)) {
>> +        } else if (!watchdog_number_valid(watchdogNumber, spapr)) {
>> +            return H_P2;
>> +        } else {
>>               ret = watchdog_stop(watchdogNumber,
>> &spapr->wds[watchdogNumber - 1]);
>> -        } else {
>> -            return H_P2;
>>           }
>>           break;
>>       case PSERIES_WDTF_OP_QUERY:
>> @@ -184,7 +190,7 @@ static target_ulong h_watchdog(PowerPCCPU *cpu,
>>           trace_spapr_watchdog_query(args[0]);
>>           break;
>>       case PSERIES_WDTF_OP_QUERY_LPM:
>> -        if (watchdogNumber > ARRAY_SIZE(spapr->wds)) {
>> +        if (!watchdog_number_valid(watchdogNumber, spapr)) {
>>               return H_P2;
>>           }
>>           args[0] = PSERIES_WDTQL_QUERY_NOT_STOPPED;
>

