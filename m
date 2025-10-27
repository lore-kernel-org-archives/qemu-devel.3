Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915B1CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 19:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDTCM-0004ql-K2; Mon, 27 Oct 2025 15:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vDTCI-0004qC-SI; Mon, 27 Oct 2025 15:48:07 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vDTC7-0001D8-ND; Mon, 27 Oct 2025 15:48:04 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EECA65972E4;
 Mon, 27 Oct 2025 20:47:42 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id GA2hvVyPPey5; Mon, 27 Oct 2025 20:47:40 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B11C75972E2; Mon, 27 Oct 2025 20:47:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AF19F59703F;
 Mon, 27 Oct 2025 20:47:40 +0100 (CET)
Date: Mon, 27 Oct 2025 20:47:40 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH 2/4] hw/pci-host/articia: Map PCI memory windows in realize
In-Reply-To: <7747275c-8e0a-4983-8613-fc39fc03bb39@linaro.org>
Message-ID: <87b009e6-0d51-7409-61ad-dd65582eb13e@eik.bme.hu>
References: <cover.1761346145.git.balaton@eik.bme.hu>
 <ceda4c28887c40e1c8eae3f561ee381ca98b0484.1761346145.git.balaton@eik.bme.hu>
 <7747275c-8e0a-4983-8613-fc39fc03bb39@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1154126658-1761594460=:85857"
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

--3866299591-1154126658-1761594460=:85857
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 27 Oct 2025, Philippe Mathieu-Daudé wrote:
> On 25/10/25 01:31, BALATON Zoltan wrote:
>> These memory windows are a result of the address decoding in the
>> Articia S north bridge so better model it there and not in board code.
>> 
>> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/pci-host/articia.c | 15 ++++++++++++++-
>>   hw/ppc/amigaone.c     | 28 +++++-----------------------
>>   hw/ppc/pegasos2.c     | 13 -------------
>>   3 files changed, 19 insertions(+), 37 deletions(-)
>
>
>> @@ -169,6 +174,7 @@ static void articia_realize(DeviceState *dev, Error 
>> **errp)
>>   {
>>       ArticiaState *s = ARTICIA(dev);
>>       PCIHostState *h = PCI_HOST_BRIDGE(dev);
>> +    MemoryRegion *mr;
>>       PCIDevice *pdev;
>>         bitbang_i2c_init(&s->smbus, i2c_init_bus(dev, "smbus"));
>> @@ -180,6 +186,14 @@ static void articia_realize(DeviceState *dev, Error 
>> **errp)
>>       memory_region_init_io(&s->reg, OBJECT(s), &articia_reg_ops, s,
>>                             TYPE_ARTICIA, 0x1000000);
>>       memory_region_add_subregion_overlap(&s->reg, 0, &s->io, 1);
>> +    mr = g_new(MemoryRegion, 1);
>
> Won't Coverity or other analysis tools complain about the leak?
> (this is why we usually keep a reference in the device state, here
> ArticiaState). Otherwise:

According to 
https://www.qemu.org/docs/master/devel/memory.html#region-lifecycle
there should be no leak and keeping a reference should not be necessary as 
the lifetime is managed by attaching it to the owner object so no need to 
keep a reference when it's not needed otherwise. Not littering the state 
struct with unneded references makes it easier to comprehend so I'd only 
keep things there that are necessary.

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Can I keep this R-b considering the above?

Regards,
BALATON Zoltan

>> +    memory_region_init_alias(mr, OBJECT(dev), "pci-mem-low", &s->mem,
>> +                             0, PCI_LOW_SIZE);
>> +    memory_region_add_subregion(get_system_memory(), PCI_LOW_ADDR, mr);
>> +    mr = g_new(MemoryRegion, 1);
>> +    memory_region_init_alias(mr, OBJECT(dev), "pci-mem-high", &s->mem,
>> +                             PCI_HIGH_ADDR, PCI_HIGH_SIZE);
>> +    memory_region_add_subregion(get_system_memory(), PCI_HIGH_ADDR, mr);
>
>
--3866299591-1154126658-1761594460=:85857--

