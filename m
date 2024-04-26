Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5711C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 17:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0PNQ-0004OG-7g; Fri, 26 Apr 2024 13:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=oYEp=L7=kaod.org=clg@ozlabs.org>)
 id 1s0PNO-0004Nf-5d; Fri, 26 Apr 2024 13:28:46 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=oYEp=L7=kaod.org=clg@ozlabs.org>)
 id 1s0PNM-0004VC-03; Fri, 26 Apr 2024 13:28:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VR07V4W6Lz4wxf;
 Sat, 27 Apr 2024 03:28:38 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VR07Q1MTwz4wcd;
 Sat, 27 Apr 2024 03:28:33 +1000 (AEST)
Message-ID: <d8868238-8282-433e-9593-bf6e7b8fc57c@kaod.org>
Date: Fri, 26 Apr 2024 19:28:24 +0200
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
 <renzconck4oavacnkebh4g73jia6ovxsv5fgf4lkik4edwdbt7@kajfn5jcjf5j>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <renzconck4oavacnkebh4g73jia6ovxsv5fgf4lkik4edwdbt7@kajfn5jcjf5j>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
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

On 4/26/24 19:12, Aditya Gupta wrote:
> Hello Cédric,
> 
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
> 
> Sure, thanks for pointing this, will add these changes in a separate
> patch.
> 
> There were some points in 'powernv' docs, that might need updating:
> 
> Quoting lines from docs/system/ppc/powernv.rst:
> 
>> Missing devices
>> ---------------
>>
>> A lot is missing, among which :
>>
>>   * I2C controllers (yet to be merged).
>>   * NPU/NPU2/NPU3 controllers.
>>   * EEH support for PCIe Host bridge controllers.
>>   * NX controller.
>>   * VAS controller.
>>   * chipTOD (Time Of Day).
>>   * Self Boot Engine (SBE).
>>   * FSI bus.
> 
> I can see that 'chipTOD' was added in commit 9a69950feb098. I2C mentions
> yet to merge, is it merged yet ?

yes.

> 
> I will check whether this needs updating, but might do it in a separate
> patch than this series.

Thanks,



