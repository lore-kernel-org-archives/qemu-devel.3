Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96F2C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 07:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCa4R-0006Uw-Su; Thu, 30 May 2024 03:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Otnh=NB=kaod.org=clg@ozlabs.org>)
 id 1sCa4Q-0006T9-CY; Thu, 30 May 2024 03:19:30 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Otnh=NB=kaod.org=clg@ozlabs.org>)
 id 1sCa4J-0005pk-TP; Thu, 30 May 2024 03:19:30 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Vqd0h2vMmz4wyj;
 Thu, 30 May 2024 17:19:16 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Vqd0c52zLz4wyw;
 Thu, 30 May 2024 17:19:12 +1000 (AEST)
Message-ID: <09b4d73e-64a8-41e2-81ca-4e1185abda8a@kaod.org>
Date: Thu, 30 May 2024 09:19:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] ppc/pseries: Add Power11 cpu type
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
References: <20240528070515.117160-1-adityag@linux.ibm.com>
 <20240528070515.117160-3-adityag@linux.ibm.com>
 <d584063b-a30e-46f0-a69e-4737c8d6d46a@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <d584063b-a30e-46f0-a69e-4737c8d6d46a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Otnh=NB=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/30/24 09:06, Harsh Prateek Bora wrote:
> 
> 
> On 5/28/24 12:35, Aditya Gupta wrote:
>> Add sPAPR CPU Core definition for Power11
>>
>> Cc: David Gibson <david@gibson.dropbear.id.au> (reviewer:sPAPR (pseries))
>> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com> (reviewer:sPAPR (pseries))
>> Cc: Cédric Le Goater <clg@kaod.org>
>> Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
>> Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
>> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>> ---
>>   docs/system/ppc/pseries.rst | 6 +++---
>>   hw/ppc/spapr_cpu_core.c     | 1 +
>>   2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/docs/system/ppc/pseries.rst b/docs/system/ppc/pseries.rst
>> index a876d897b6e4..3277564b34c2 100644
>> --- a/docs/system/ppc/pseries.rst
>> +++ b/docs/system/ppc/pseries.rst
>> @@ -15,9 +15,9 @@ Supported devices
>>   =================
>>    * Multi processor support for many Power processors generations: POWER7,
>> -   POWER7+, POWER8, POWER8NVL, POWER9, and Power10. Support for POWER5+ exists,
>> -   but its state is unknown.
>> - * Interrupt Controller, XICS (POWER8) and XIVE (POWER9 and Power10)
>> +   POWER7+, POWER8, POWER8NVL, POWER9, Power10 and Power11. Support for POWER5+
>> +   exists, but its state is unknown.
>> + * Interrupt Controller, XICS (POWER8) and XIVE (POWER9, Power10, Power11)
> 
> I think it would look more cleaner to rephrase as below:
> 
>   * Multi processor support for many Power processors generations:
>     - POWER7, POWER7+
>     - POWER8, POWER8NVL
>     - POWER9
>     - Power10
>     - Power11.
>     - Support for POWER5+ exists, but its state is unknown.


$ /usr/bin/qemu-system-ppc64 -version
QEMU emulator version 8.1.3 (qemu-8.1.3-5.fc39)
Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers

With the correct kernel/userspace, it runs :

# uname -a
Linux buildroot 6.6.3 #1 SMP Fri Jan  5 00:00:45 CET 2024 ppc64 GNU/Linux
# cat /proc/cpuinfo
processor	: 0
cpu		: POWER5+ (gs)
clock		: 1000.000000MHz
revision	: 2.1 (pvr 003b 0201)

timebase	: 512000000
platform	: pSeries
model		: IBM pSeries (emulated by qemu)
machine		: CHRP IBM pSeries (emulated by qemu)
MMU		: Hash


Thanks,

C.




>   * Interrupt Controller
>      - XICS (POWER8)
>      - XIVE (Supported by below:)
>          - POWER9
>          - Power10
>          - Power11
> 
> So, that every next platform just need to add one line for itself.
> 
> With that,
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> 
> Thanks
> Harsh
>>    * vPHB PCIe Host bridge.
>>    * vscsi and vnet devices, compatible with the same devices available on a
>>      PowerVM hypervisor with VIOS managing LPARs.
>> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
>> index e7c9edd033c8..62416b7e0a7e 100644
>> --- a/hw/ppc/spapr_cpu_core.c
>> +++ b/hw/ppc/spapr_cpu_core.c
>> @@ -401,6 +401,7 @@ static const TypeInfo spapr_cpu_core_type_infos[] = {
>>       DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.0"),
>>       DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.2"),
>>       DEFINE_SPAPR_CPU_CORE_TYPE("power10_v2.0"),
>> +    DEFINE_SPAPR_CPU_CORE_TYPE("power11_v2.0"),
>>   #ifdef CONFIG_KVM
>>       DEFINE_SPAPR_CPU_CORE_TYPE("host"),
>>   #endif


