Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4AFCAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 21:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzLkj-00064P-Jf; Thu, 18 Sep 2025 17:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uzLkb-00060l-FS; Thu, 18 Sep 2025 17:01:10 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uzLkZ-0000gE-ER; Thu, 18 Sep 2025 17:01:09 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8C67456F321;
 Thu, 18 Sep 2025 23:01:04 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id vlFmgwGDgiZM; Thu, 18 Sep 2025 23:01:02 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7B80E56F2AE; Thu, 18 Sep 2025 23:01:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7689B56F295;
 Thu, 18 Sep 2025 23:01:02 +0200 (CEST)
Date: Thu, 18 Sep 2025 23:01:02 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 08/14] hw/pci-host/raven: Use correct parameter in
 direct access ops
In-Reply-To: <fa60c6a1-8ab8-4fd9-b04b-9e06a4ee3b73@ilande.co.uk>
Message-ID: <b3634880-f3ff-a918-00b5-8ee8d2b91e79@eik.bme.hu>
References: <cover.1758219840.git.balaton@eik.bme.hu>
 <b5b4558125e2408ded29f7cdc306011358829044.1758219840.git.balaton@eik.bme.hu>
 <fa60c6a1-8ab8-4fd9-b04b-9e06a4ee3b73@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1085055822-1758229262=:47972"
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

--3866299591-1085055822-1758229262=:47972
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 18 Sep 2025, Mark Cave-Ayland wrote:
> On 18/09/2025 19:50, BALATON Zoltan wrote:
>> Instead of passing unneeded enclosing objects to the config direct
>> access ops that only need the bus we can pass that directly thus
>> simplifying the functions.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/pci-host/raven.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>> 
>> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
>> index d7a0bde382..2057a1869f 100644
>> --- a/hw/pci-host/raven.c
>> +++ b/hw/pci-host/raven.c
>> @@ -65,16 +65,16 @@ static inline uint32_t raven_idsel_to_addr(hwaddr addr)
>>   static void raven_mmcfg_write(void *opaque, hwaddr addr, uint64_t val,
>>                                 unsigned int size)
>>   {
>> -    PREPPCIState *s = opaque;
>> -    PCIHostState *phb = PCI_HOST_BRIDGE(s);
>> -    pci_data_write(phb->bus, raven_idsel_to_addr(addr), val, size);
>> +    PCIBus *hbus = opaque;
>> +
>> +    pci_data_write(hbus, raven_idsel_to_addr(addr), val, size);
>>   }
>>     static uint64_t raven_mmcfg_read(void *opaque, hwaddr addr, unsigned 
>> int size)
>>   {
>> -    PREPPCIState *s = opaque;
>> -    PCIHostState *phb = PCI_HOST_BRIDGE(s);
>> -    return pci_data_read(phb->bus, raven_idsel_to_addr(addr), size);
>> +    PCIBus *hbus = opaque;
>> +
>> +    return pci_data_read(hbus, raven_idsel_to_addr(addr), size);
>>   }
>>     static const MemoryRegionOps raven_mmcfg_ops = {
>> @@ -233,7 +233,7 @@ static void raven_pcihost_realizefn(DeviceState *d, 
>> Error **errp)
>>                             "pci-conf-data", 4);
>>       memory_region_add_subregion(&s->pci_io, 0xcfc, &h->data_mem);
>>   -    memory_region_init_io(&h->mmcfg, OBJECT(s), &raven_mmcfg_ops, s,
>> +    memory_region_init_io(&h->mmcfg, OBJECT(h), &raven_mmcfg_ops, h->bus,
>>                             "pci-mmcfg", 0x00400000);
>>       memory_region_add_subregion(address_space_mem, 0x80800000, 
>> &h->mmcfg);
>
> I find this confusing as a reviewer since the general expectation is that the 
> device is passed as the opaque for the memory region rather than the bus. 
> What is the reason for trying to change an existing convention here?

I don't think there is such convention that it must be the device state, 
that's just a common thing and obvious choice in a lot of cases but the 
opaque parameter is defined to take a pointer to some data the callback 
needs and what it is is defined by the callback. As this callback only 
needs the bus it's simplest to pass that as the opaque data.

> You could simplify what is there by dropping the PREPPCIState reference and 
> simply doing:
>
>  static uint64_t raven_mmcfg_read(void *opaque, hwaddr addr, unsigned int 
> size)
>  {
>     PCIHostState *phb = PCI_HOST_BRIDGE(opaque);
>     return pci_data_read(phb->bus, raven_idsel_to_addr(addr), size);
>  }
>
> etc.

So you broke your own convention here already by passing the parent object 
and not the PREPPCI. Then we can go further the same way and pass only 
what the callback needs which is what my patch does. (There is also no 
convention that opaque must be an object or device so no need to QOM cast 
it either. The type is verified when registered the callback.)

Regards,
BALATON Zoltan
--3866299591-1085055822-1758229262=:47972--

