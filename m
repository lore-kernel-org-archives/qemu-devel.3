Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BC9CA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCD3C-0002jI-CL; Thu, 01 Oct 2026 05:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xCD36-0002i6-0O; Thu, 01 Oct 2026 05:25:56 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xCD33-0001qR-3p; Thu, 01 Oct 2026 05:25:54 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9C38C583391;
 Thu, 01 Oct 2026 11:25:43 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 43uFbt5fka7J; Thu,  1 Oct 2026 11:25:41 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 78002583301; Thu, 01 Oct 2026 11:25:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 75D255832E1;
 Thu, 01 Oct 2026 11:25:41 +0200 (CEST)
Date: Thu, 1 Oct 2026 11:25:41 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
cc: "Kirill A. Korinsky" <kirill@korins.ky>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, Anushree Mathur <anushree.mathur@linux.ibm.com>
Subject: Re: [PATCH v2 2/5] ppc: Raise decrementer IRQ on zero write
In-Reply-To: <826a6e78-6e61-4a47-bdfe-eb5c3adbbe6e@linux.ibm.com>
Message-ID: <cb6f2275-3ab4-2808-1d63-479f894fd5bb@eik.bme.hu>
References: <20260923230452.3765-1-kirill@korins.ky>
 <20260923230452.3765-3-kirill@korins.ky>
 <20261001143415.3f3b33fc-f8-amachhiw@linux.ibm.com>
 <826a6e78-6e61-4a47-bdfe-eb5c3adbbe6e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1711518990-1790846741=:10522"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1711518990-1790846741=:10522
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 1 Oct 2026, Harsh Prateek Bora wrote:
> + BALATON
>
> Hi Glenn, BALATON,
>
> Any review feedback on below patch?

I've seen the patch but I don't have that detailed knowledge on this to be 
able to review so nothing to add from me.

Regards,
BALATON Zoltan

> Thanks
> Harsh
>
> On 01/10/26 2:40 pm, Amit Machhiwal wrote:
>> On 2026/09/24 01:03 AM, Kirill A. Korinsky wrote:
>>> From: "Kirill A. Korinsky" <kirill@korins.ky>
>>> 
>>> OpenBSD writes zero to an edge triggered decrementer, then enters idle
>>> expecting its interrupt. QEMU defers the already due edge to a timer at
>>> the current virtual time, leaving the guest stalled.
>>> 
>>> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
>>> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
>>> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> Suggested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
>>> ---
>>>   hw/ppc/ppc.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>> 
>>> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
>>> index b123b4cc1c..736a37d32b 100644
>>> --- a/hw/ppc/ppc.c
>>> +++ b/hw/ppc/ppc.c
>>> @@ -885,10 +885,17 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, 
>>> int64_t now, uint64_t *nextp,
>>>        * an edge interrupt, so raise it here too.
>>>        */
>>>       if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
>>> +        ((flags & PPC_DECR_ZERO_TRIGGERED) && value == 0) ||
>> 
>> Thanks for the v2 — you got the guard right (PPC_DECR_ZERO_TRIGGERED in
>> __cpu_ppc_store_decr), but the flag-setting landed in the wrong place.
>>
>>>           ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
>>>             && signed_decr >= 0)) {
>>>           (*raise_excp)(cpu);
>>>           return;
>>> +    } else {
>>> +        /*
>>> +         * Classic 32-bit edge-triggered decrementer: zero write fires
>>> +         * immediately
>>> +         */
>>> +        tb_env->flags |= PPC_DECR_ZERO_TRIGGERED;
>> 
>> My suggestion was to set PPC_DECR_ZERO_TRIGGERED once at init time in
>> cpu_ppc_tb_init().  In v2 it ended up inside the else block of
>> __cpu_ppc_store_decr() instead.
>> 
>> That mutates tb_env->flags at runtime on every DEC write that does not
>> immediately fire.  PPE42 goes through ppc_booke_timers_init() and gets
>> PPC_DECR_UNDERFLOW_TRIGGERED but not PPC_DECR_ZERO_TRIGGERED.  The first 
>> time a
>> guest writes a non-zero value to DEC on PPE42, this else block stamps
>> PPC_DECR_ZERO_TRIGGERED onto tb_env->flags — from that point on, every zero
>> write fires immediately, which contradicts the PPE42 architecture (commit
>> 7197f6f7baf2).
>> 
>> The fix is the same two-liner I included in my v1 response:
>> 
>> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
>> index b123b4cc1cce..6f99b61a2876 100644
>> --- a/hw/ppc/ppc.c
>> +++ b/hw/ppc/ppc.c
>> @@ -885,6 +885,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, 
>> int64_t now, uint64_t *nextp,
>>        * an edge interrupt, so raise it here too.
>>        */
>>       if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
>> +        ((flags & PPC_DECR_ZERO_TRIGGERED) && value == 0) ||
>>           ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
>>             && signed_decr >= 0)) {
>>           (*raise_excp)(cpu);
>> @@ -1104,6 +1105,12 @@ void cpu_ppc_tb_init(CPUPPCState *env, uint32_t 
>> freq)
>>       if (is_book3s_arch2x(env)) {
>>           /* All Book3S 64bit CPUs implement level based DEC logic */
>>           tb_env->flags |= PPC_DECR_UNDERFLOW_LEVEL;
>> +    } else {
>> +        /*
>> +         * Classic 32-bit edge-triggered decrementer: zero write fires
>> +         * immediately
>> +         */
>> +        tb_env->flags |= PPC_DECR_ZERO_TRIGGERED;
>>       }
>>       /* Create new timer */
>>       tb_env->decr_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
>> 
>> PPE42 never enters cpu_ppc_tb_init() — it uses ppc_booke_timers_init() — so 
>> it
>> never gets PPC_DECR_ZERO_TRIGGERED and the new clause does not fire for it. 
>> All
>> 32-bit classic CPUs that go through cpu_ppc_tb_init() (7400, 750, 604, 
>> 7457)
>> take the else branch and get the flag set statically at boot, which is the 
>> right
>> place for it.
>> 
>> Thanks,
>> Amit
>
>
--3866299591-1711518990-1790846741=:10522--

