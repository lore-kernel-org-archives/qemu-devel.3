Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61875C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 13:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAUI8-0008U3-Jd; Thu, 01 May 2025 09:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uAUHt-0008S0-Kb
 for qemu-devel@nongnu.org; Thu, 01 May 2025 09:49:19 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uAUHq-0004Dz-41
 for qemu-devel@nongnu.org; Thu, 01 May 2025 09:49:17 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E77BD55D257;
 Thu, 01 May 2025 15:49:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 4UQFOs4_rDLQ; Thu,  1 May 2025 15:49:03 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EFE4155D256; Thu, 01 May 2025 15:49:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EDF12745684;
 Thu, 01 May 2025 15:49:03 +0200 (CEST)
Date: Thu, 1 May 2025 15:49:03 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Chao Liu <lc00631@tecorigin.com>, pbonzini@redhat.com, peterx@redhat.com, 
 david@redhat.com, armbru@redhat.com, zhangtj@tecorigin.com, 
 zqz00548@tecorigin.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 0/1] Optimizing the print format of the QEMU monitor
 'info mtree'
In-Reply-To: <6d17f9a1-67d9-4a97-ae1d-21a78d2592a4@linaro.org>
Message-ID: <5d1cef0e-a8b8-77ed-0ad8-ab7c4e15fbdb@eik.bme.hu>
References: <cover.1746065388.git.lc00631@tecorigin.com>
 <6d17f9a1-67d9-4a97-ae1d-21a78d2592a4@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2029095747-1746107343=:26652"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-2029095747-1746107343=:26652
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 1 May 2025, Philippe Mathieu-Daudé wrote:
> Hi Chao,
>
> On 1/5/25 04:24, Chao Liu wrote:
>> Hi, all:
>> 
>> Thanks to BALATON, and David for their reviews.
>> 
>> In PATCH v6:
>> 1. Replaced the bool type with enum mtree_node_type to improve code 
>> readability.
>> 2. Modified the output to use only one horizontal dash instead of two, and
>>     aligned character printing for a cleaner look.
>> 
>> like this:
>> 
>> ```
>> $ ./qemu-system-aarch64 -S -monitor stdio -M raspi4b
>> (qemu) info mtree
>> address-space: memory
>> `- 0000000000000000-ffffffffffffffff (prio 0, i/o): system
>>     |- 0000000000000000-000000007fffffff (prio 0, ram): ram
>> ...
>>     |- 00000000fe000000-00000000ff7fffff (prio 1, i/o): bcm2835-peripherals
>>     |  |- 00000000fe900000-00000000fe907fff (prio -1000, i/o): bcm2835-dbus
>>     |  |- 00000000fe910000-00000000fe917fff (prio -1000, i/o): bcm2835-ave0
>>     |  |- 00000000fe980000-00000000fe990fff (prio 0, i/o): dwc2
>>     |  |  |- 00000000fe980000-00000000fe980fff (prio 0, i/o): dwc2-io
>>     |  |  `- 00000000fe981000-00000000fe990fff (prio 0, i/o): dwc2-fifo
>>     |  |- 00000000fec00000-00000000fec00fff (prio -1000, i/o): bcm2835-v3d
>>     |  |- 00000000fec11000-00000000fec110ff (prio -1000, i/o): 
>> bcm2835-clkisp
>>     |  |- 00000000fee00000-00000000fee000ff (prio -1000, i/o): 
>> bcm2835-sdramc
>>     |  `- 00000000fee05000-00000000fee050ff (prio 0, i/o): 
>> bcm2835-dma-chan15
>>     |- 00000000ff800000-00000000ff8000ff (prio 0, i/o): bcm2836-control
>> ...
>>     |- 00000000ff845600-00000000ff8456ff (prio 0, i/o): gic_cpu
>>     `- 00000000ff846000-00000000ff847fff (prio 0, i/o): gic_vcpu
>> ```
>
> Could we keep the address ranges aligned? I.e.:
>
>>   |--+     00000000fe000000-00000000ff7fffff (prio 1, i/o): 
> bcm2835-peripherals
>>   |  |---- 00000000fe900000-00000000fe907fff (prio -1000, i/o): 
> bcm2835-dbus
>>   |  |---- 00000000fe910000-00000000fe917fff (prio -1000, i/o): 
> bcm2835-ave0
>>   |  |--+  00000000fe980000-00000000fe990fff (prio 0, i/o): dwc2
>>   |  |  |- 00000000fe980000-00000000fe980fff (prio 0, i/o): dwc2-io
>>   |  |  `- 00000000fe981000-00000000fe990fff (prio 0, i/o): dwc2-fifo
>>   |  |---- 00000000fec00000-00000000fec00fff (prio -1000, i/o): bcm2835-v3d
>>   |  |---- 00000000fec11000-00000000fec110ff (prio -1000, i/o): 
> bcm2835-clkisp
>>   |  |---- 00000000fee00000-00000000fee000ff (prio -1000, i/o): 
> bcm2835-sdramc
>>   |  `---- 00000000fee05000-00000000fee050ff (prio 0, i/o): 
> bcm2835-dma-chan15
>>   |------- 00000000ff800000-00000000ff8000ff (prio 0, i/o): bcm2836-control

I don't think that helps. I was OK with just indents and adding graphics 
does not change that but this would actually make it harder to see what is 
below what as you'd have to trace back to the beginning of the line and 
not just look at the right end where it would not be clear where a sub 
region starts so it't less readable even if it looks more organised. So 
I'd keep the indent.

Regards,
BALATON Zoltan
--3866299591-2029095747-1746107343=:26652--

