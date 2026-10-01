Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D83ECA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCCwV-00083E-8l; Thu, 01 Oct 2026 05:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xCCuO-0007JD-6Y; Thu, 01 Oct 2026 05:17:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xCCuL-0000ZV-0z; Thu, 01 Oct 2026 05:16:55 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69175TVQ3446152; Thu, 1 Oct 2026 09:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Kjmemd
 Qo5InXh6EGigxRz7NxcUATIcIk8ghRJMWG0W4=; b=c1E7gLRTSMOuQjXAUSp+D/
 QH+AWiy3buhq232U+jvcegLOMzdzhRKNpFQnkoUYNEKdp5jSZAxa+CJIIAP5V2uH
 DhzXGMS240uksmm7DR5yPDYUzTjpXkHY9XfiJ4HALg56mL44SBc2CyYdRZ77QgXT
 crTCZs8GLjXwxtDe13JNIGnX6cWYNJXMvC8UFEYjcI6fmpXWiAWy4y3Yen0cvzuS
 ILnQa/FyiaJJSaezybe/8lew1vm+ivCm9t4ptQsntCQL5tzZwD1iO2D5BXBoZPoq
 P39//kDy8WCJiFkZtmXKlRCFd5hj9GIdxQ/3VFY8J2XR+XcyfJX0fGJwVKISgvYg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qrj912-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 01 Oct 2026 09:16:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69172VRP520699; Thu, 1 Oct 2026 09:16:28 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpg1ra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Oct 2026 09:16:28 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6919GQWW13501006
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Oct 2026 09:16:26 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C654658056;
 Thu,  1 Oct 2026 09:16:26 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27DE25803F;
 Thu,  1 Oct 2026 09:16:24 +0000 (GMT)
Received: from [9.123.4.251] (unknown [9.123.4.251])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Oct 2026 09:16:23 +0000 (GMT)
Message-ID: <826a6e78-6e61-4a47-bdfe-eb5c3adbbe6e@linux.ibm.com>
Date: Thu, 1 Oct 2026 14:46:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] ppc: Raise decrementer IRQ on zero write
To: "Kirill A. Korinsky" <kirill@korins.ky>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Anushree Mathur <anushree.mathur@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
References: <20260923230452.3765-1-kirill@korins.ky>
 <20260923230452.3765-3-kirill@korins.ky>
 <20261001143415.3f3b33fc-f8-amachhiw@linux.ibm.com>
Content-Language: en-GB
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20261001143415.3f3b33fc-f8-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzNiBTYWx0ZWRfX+zigfHoVe9tK
 b57Gi5R2Dq2C0/DK3sGQBCF8xoDwgieSg+2NnoO0/JTQdj2xSfe7YQEVfbvyLGMvHVeGU3FdFBW
 YBX67LHFYIgRtkMZwhJo8TiiVNZhvT6+bsnbFrgxNLitzXDsNhJ7o/Wfy6BMmRI8OZ6yL0NM1J9
 a5Tx8JYmy3gd56vT3NJ8oh+wFzQt452vKixTtaRLCJz49Jdq39Ipj1uZHyI6ElkmT9PaRnSF3Xl
 Gvin0NTRiZ13z01G5e5dGMRZljplImESibIz3nrB7IQVdRn0htFSMotddxwYo5bHlObeaUDolG9
 D1nnTPezSMJiIp24iVftrQ/cF/U837RsJlBvcpcrbBsbwr8mCYRRMPBgKXHInUbZkoZz6IhuayN
 q0p7UfXhDH7KSGFjPL5DSs4e+L3+NCrFeRc6u5/IPwutPbWP+xWf7nh44Ab+VHtwU6BY1SIM8nB
 fdpAVWoqQycUQRkgSRw==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abe24ed cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=VnNF1IyMAAAA:8 a=pcZqCyVeAAAA:8 a=d9ORo7Ge7a1a01qBZHYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=SGy6VSG0Ue1xmPAwIFl9:22 a=ojN_UKswjOqU4wFocON6:22
X-Proofpoint-ORIG-GUID: eAsceTLs6tO3gtKPVmHIrKjLRmWopZR2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzNiBTYWx0ZWRfX0rI0axja1kf/
 Uj61dOGspORosKHzNvipPvIrEjWkmL2fmS21i7KuIwm9ow5EOO30Z0J04PYGlmCg+XGcZBWVHPq
 n7UFiQQwI3Raq0Jd+CyEMVlp5HNrjRs=
X-Proofpoint-GUID: FN-4p7RfiADcGh1sr9vCYQHFQpgNFliV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010036
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

+ BALATON

Hi Glenn, BALATON,

Any review feedback on below patch?

Thanks
Harsh

On 01/10/26 2:40 pm, Amit Machhiwal wrote:
> On 2026/09/24 01:03 AM, Kirill A. Korinsky wrote:
>> From: "Kirill A. Korinsky" <kirill@korins.ky>
>>
>> OpenBSD writes zero to an edge triggered decrementer, then enters idle
>> expecting its interrupt. QEMU defers the already due edge to a timer at
>> the current virtual time, leaving the guest stalled.
>>
>> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
>> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
>> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Suggested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
>> ---
>>   hw/ppc/ppc.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
>> index b123b4cc1c..736a37d32b 100644
>> --- a/hw/ppc/ppc.c
>> +++ b/hw/ppc/ppc.c
>> @@ -885,10 +885,17 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, int64_t now, uint64_t *nextp,
>>        * an edge interrupt, so raise it here too.
>>        */
>>       if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
>> +        ((flags & PPC_DECR_ZERO_TRIGGERED) && value == 0) ||
> 
> Thanks for the v2 — you got the guard right (PPC_DECR_ZERO_TRIGGERED in
> __cpu_ppc_store_decr), but the flag-setting landed in the wrong place.
> 
>>           ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
>>             && signed_decr >= 0)) {
>>           (*raise_excp)(cpu);
>>           return;
>> +    } else {
>> +        /*
>> +         * Classic 32-bit edge-triggered decrementer: zero write fires
>> +         * immediately
>> +         */
>> +        tb_env->flags |= PPC_DECR_ZERO_TRIGGERED;
> 
> My suggestion was to set PPC_DECR_ZERO_TRIGGERED once at init time in
> cpu_ppc_tb_init().  In v2 it ended up inside the else block of
> __cpu_ppc_store_decr() instead.
> 
> That mutates tb_env->flags at runtime on every DEC write that does not
> immediately fire.  PPE42 goes through ppc_booke_timers_init() and gets
> PPC_DECR_UNDERFLOW_TRIGGERED but not PPC_DECR_ZERO_TRIGGERED.  The first time a
> guest writes a non-zero value to DEC on PPE42, this else block stamps
> PPC_DECR_ZERO_TRIGGERED onto tb_env->flags — from that point on, every zero
> write fires immediately, which contradicts the PPE42 architecture (commit
> 7197f6f7baf2).
> 
> The fix is the same two-liner I included in my v1 response:
> 
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index b123b4cc1cce..6f99b61a2876 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -885,6 +885,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, int64_t now, uint64_t *nextp,
>        * an edge interrupt, so raise it here too.
>        */
>       if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
> +        ((flags & PPC_DECR_ZERO_TRIGGERED) && value == 0) ||
>           ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
>             && signed_decr >= 0)) {
>           (*raise_excp)(cpu);
> @@ -1104,6 +1105,12 @@ void cpu_ppc_tb_init(CPUPPCState *env, uint32_t freq)
>       if (is_book3s_arch2x(env)) {
>           /* All Book3S 64bit CPUs implement level based DEC logic */
>           tb_env->flags |= PPC_DECR_UNDERFLOW_LEVEL;
> +    } else {
> +        /*
> +         * Classic 32-bit edge-triggered decrementer: zero write fires
> +         * immediately
> +         */
> +        tb_env->flags |= PPC_DECR_ZERO_TRIGGERED;
>       }
>       /* Create new timer */
>       tb_env->decr_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> 
> PPE42 never enters cpu_ppc_tb_init() — it uses ppc_booke_timers_init() — so it
> never gets PPC_DECR_ZERO_TRIGGERED and the new clause does not fire for it.  All
> 32-bit classic CPUs that go through cpu_ppc_tb_init() (7400, 750, 604, 7457)
> take the else branch and get the flag set statically at boot, which is the right
> place for it.
> 
> Thanks,
> Amit


