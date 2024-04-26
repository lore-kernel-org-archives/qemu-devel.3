Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB27C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 17:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0PaW-0005U0-T5; Fri, 26 Apr 2024 13:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=oYEp=L7=kaod.org=clg@ozlabs.org>)
 id 1s0PaM-0005RM-33; Fri, 26 Apr 2024 13:42:11 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=oYEp=L7=kaod.org=clg@ozlabs.org>)
 id 1s0PaE-0007bu-QI; Fri, 26 Apr 2024 13:42:09 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VR0Qr5zfzz4wc5;
 Sat, 27 Apr 2024 03:41:56 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VR0Qn3Wg3z4xKb;
 Sat, 27 Apr 2024 03:41:53 +1000 (AEST)
Message-ID: <f39f0e4a-6f9f-45f7-9f84-1663f20cd755@kaod.org>
Date: Fri, 26 Apr 2024 19:41:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] ppc/pseries: Add Power11 cpu type
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
 <20240426110023.733309-2-adityag@linux.ibm.com>
 <d35b2a2d-1307-46bf-81ae-747a0e62d6be@kaod.org>
 <p57z4il36laqlccge3llmbzveepyzad7dokxpoipxh22t2y2s3@tsiegjpijeas>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <p57z4il36laqlccge3llmbzveepyzad7dokxpoipxh22t2y2s3@tsiegjpijeas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=oYEp=L7=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/26/24 19:05, Aditya Gupta wrote:
> Hello Cédric,
> 
> Thanks for your reviews.
> 
> On Fri, Apr 26, 2024 at 04:27:04PM +0200, Cédric Le Goater wrote:
>> Hello Aditya
>>
>> On 4/26/24 13:00, Aditya Gupta wrote:
>>> Add base support for "--cpu power11" in QEMU.
>>>
>>> Power11 core is same as Power10, hence reuse functions defined for
>>> Power10.
>>
>> Power11 uses the same ISA it seems. What's the value then ?
> 
> Yes, it uses the same ISA. But I added this option so we can have a
> Power11 PVR in QEMU, which should be identified as Power11 in skiboot
> and linux, hence defined Power11 cpu type, even though code here is
> almost same as Power10.
> 
>>
>>>
>>> Cc: Cédric Le Goater <clg@kaod.org>
>>> Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
>>> Cc: David Gibson <david@gibson.dropbear.id.au>
>>> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
>>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>>> Cc: Nicholas Piggin <npiggin@gmail.com>
>>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>>> ---
>>>    docs/system/ppc/pseries.rst |  6 +--
>>>    hw/ppc/spapr_cpu_core.c     |  1 +
>>
>>
>> I would separate the CPU target code adding support for a new POWER
>> Processor from the machine code (pseries).
> 
> Sure, I will split it in v3.
> 
>>
>>
>>>    target/ppc/compat.c         |  7 +++
>>>    target/ppc/cpu-models.c     |  2 +
>>>    target/ppc/cpu-models.h     |  2 +
>>>    target/ppc/cpu_init.c       | 99 +++++++++++++++++++++++++++++++++++++
>>>    6 files changed, 114 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/docs/system/ppc/pseries.rst b/docs/system/ppc/pseries.rst
>>> index a876d897b6e4..3277564b34c2 100644
>>> --- a/docs/system/ppc/pseries.rst
>>> +++ b/docs/system/ppc/pseries.rst
>>> @@ -15,9 +15,9 @@ Supported devices
>>>    =================
>>>     * Multi processor support for many Power processors generations: POWER7,
>>> -   POWER7+, POWER8, POWER8NVL, POWER9, and Power10. Support for POWER5+ exists,
>>> -   but its state is unknown.
>>> - * Interrupt Controller, XICS (POWER8) and XIVE (POWER9 and Power10)
>>> +   POWER7+, POWER8, POWER8NVL, POWER9, Power10 and Power11. Support for POWER5+
>>> +   exists, but its state is unknown.
>>
>> The POWER5+ pseries machine seems functionnal with SLOF
>> (Sep 18 2023 18:57:48) and Linux 6.6.3 under TCG. May be worth
>> to mention (for AIX users) in another patch.
>>
>>> + * Interrupt Controller, XICS (POWER8) and XIVE (POWER9, Power10, Power11)
>>>     * vPHB PCIe Host bridge.
>>>     * vscsi and vnet devices, compatible with the same devices available on a
>>>       PowerVM hypervisor with VIOS managing LPARs.
>>> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
>>> index e7c9edd033c8..c6e85c031178 100644
>>> --- a/hw/ppc/spapr_cpu_core.c
>>> +++ b/hw/ppc/spapr_cpu_core.c
>>> @@ -401,6 +401,7 @@ static const TypeInfo spapr_cpu_core_type_infos[] = {
>>>        DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.0"),
>>>        DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.2"),
>>>        DEFINE_SPAPR_CPU_CORE_TYPE("power10_v2.0"),
>>> +    DEFINE_SPAPR_CPU_CORE_TYPE("power11"),
>>>    #ifdef CONFIG_KVM
>>>        DEFINE_SPAPR_CPU_CORE_TYPE("host"),
>>>    #endif
>>> diff --git a/target/ppc/compat.c b/target/ppc/compat.c
>>> index ebef2cccecf3..12dd8ae290ca 100644
>>> --- a/target/ppc/compat.c
>>> +++ b/target/ppc/compat.c
>>> @@ -100,6 +100,13 @@ static const CompatInfo compat_table[] = {
>>>            .pcr_level = PCR_COMPAT_3_10,
>>>            .max_vthreads = 8,
>>>        },
>>> +    { /* POWER11, ISA3.10 */
>>> +        .name = "power11",
>>> +        .pvr = CPU_POWERPC_LOGICAL_3_10_PLUS,
>>> +        .pcr = PCR_COMPAT_3_10,
>>> +        .pcr_level = PCR_COMPAT_3_10,
>>> +        .max_vthreads = 8,
>>> +    },
>>>    };
>>>    static const CompatInfo *compat_by_pvr(uint32_t pvr)
>>> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
>>> index f2301b43f78b..1870e69b63df 100644
>>> --- a/target/ppc/cpu-models.c
>>> +++ b/target/ppc/cpu-models.c
>>> @@ -734,6 +734,8 @@
>>>                    "POWER9 v2.2")
>>>        POWERPC_DEF("power10_v2.0",  CPU_POWERPC_POWER10_DD20,           POWER10,
>>>                    "POWER10 v2.0")
>>> +    POWERPC_DEF("power11",  CPU_POWERPC_POWER11,           POWER11,
>>> +                "POWER11")
>>>    #endif /* defined (TARGET_PPC64) */
>>>    /***************************************************************************/
>>> diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
>>> index 0229ef3a9a5c..a1b540c3aa9e 100644
>>> --- a/target/ppc/cpu-models.h
>>> +++ b/target/ppc/cpu-models.h
>>> @@ -354,6 +354,7 @@ enum {
>>>        CPU_POWERPC_POWER10_BASE       = 0x00800000,
>>>        CPU_POWERPC_POWER10_DD1        = 0x00801100,
>>>        CPU_POWERPC_POWER10_DD20       = 0x00801200,
>>> +    CPU_POWERPC_POWER11            = 0x00821200,
>>
>> is that a DD2.2 PVR ? If so, It should be mentionned in the definition.
>>
> 
> Yes, I have kept the last 2 bytes same as P10 DD2. I will mention it
> above the line I have added it, in v3.

Skiboot reports :

[    0.121234172,6] P11 DD1.00 detected


C.

