Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9132DCCD1BF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 00:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCS9v-0007XO-Kc; Fri, 24 Oct 2025 20:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCS9t-0007XC-RD; Fri, 24 Oct 2025 20:29:25 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCS9q-0007MC-Uy; Fri, 24 Oct 2025 20:29:25 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A776F5972EB;
 Sat, 25 Oct 2025 02:29:19 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id xHllPorhwAJe; Sat, 25 Oct 2025 02:29:17 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9995559744F; Sat, 25 Oct 2025 02:29:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 97B9159736A;
 Sat, 25 Oct 2025 02:29:17 +0200 (CEST)
Date: Sat, 25 Oct 2025 02:29:17 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v5 11/13] hw/pci-host/raven: Do not map regions in init
 method
In-Reply-To: <809dd471-4acd-4f14-80eb-3454a365b69a@ilande.co.uk>
Message-ID: <370952a5-c0a0-98db-3c05-328bf773af60@eik.bme.hu>
References: <cover.1761232472.git.balaton@eik.bme.hu>
 <586026b62dd514cc2c4bc0a67346d9e79d13dee6.1761232473.git.balaton@eik.bme.hu>
 <809dd471-4acd-4f14-80eb-3454a365b69a@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-13883601-1761352157=:598"
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

--3866299591-13883601-1761352157=:598
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 24 Oct 2025, Mark Cave-Ayland wrote:
> On 23/10/2025 16:26, BALATON Zoltan wrote:
>> Export memory regions as sysbus mmio regions and let the board code
>> map them similar to how it is done in grackle. While at it rename
>> raven_pcihost_realizefn to raven_pcihost_realize.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/pci-host/raven.c | 38 +++++++++++++-------------------------
>>   hw/ppc/prep.c       | 10 ++++++++--
>>   2 files changed, 21 insertions(+), 27 deletions(-)
>> 
>> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
>> index ebf0c511dc..1e36a637a6 100644
>> --- a/hw/pci-host/raven.c
>> +++ b/hw/pci-host/raven.c
>> @@ -49,8 +49,6 @@ struct PREPPCIState {
>>       AddressSpace bm_as;
>>   };
>>   -#define PCI_IO_BASE_ADDR    0x80000000  /* Physical address on main bus 
>> */
>> -
>>   static inline uint32_t raven_idsel_to_addr(hwaddr addr)
>>   {
>>       return (ctz16(addr >> 11) << 11) | (addr & 0x7ff);
>> @@ -170,7 +168,7 @@ static void raven_change_gpio(void *opaque, int n, int 
>> level)
>>       memory_region_set_enabled(&s->pci_discontiguous_io, !!level);
>>   }
>>   -static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>> +static void raven_pcihost_realize(DeviceState *d, Error **errp)
>>   {
>>       SysBusDevice *dev = SYS_BUS_DEVICE(d);
>>       PCIHostState *h = PCI_HOST_BRIDGE(dev);
>> @@ -180,7 +178,18 @@ static void raven_pcihost_realizefn(DeviceState *d, 
>> Error **errp)
>>         qdev_init_gpio_in(d, raven_change_gpio, 1);
>>   +    memory_region_init(&s->pci_io, o, "pci-io", 0x3f800000);
>> +    memory_region_init_io(&s->pci_discontiguous_io, o,
>> +                          &raven_io_ops, &s->pci_io,
>> +                          "pci-discontiguous-io", 8 * MiB);
>> +    memory_region_set_enabled(&s->pci_discontiguous_io, false);
>> +    memory_region_init(&s->pci_memory, o, "pci-memory", 0x3f000000);
>> +
>> +    sysbus_init_mmio(dev, &s->pci_io);
>> +    sysbus_init_mmio(dev, &s->pci_discontiguous_io);
>> +    sysbus_init_mmio(dev, &s->pci_memory);
>>       sysbus_init_irq(dev, &s->irq);
>> +
>>       h->bus = pci_register_root_bus(d, NULL, raven_set_irq, raven_map_irq,
>>                                      &s->irq, &s->pci_memory, &s->pci_io, 
>> 0, 1,
>>                                      TYPE_PCI_BUS);
>> @@ -219,32 +228,12 @@ static void raven_pcihost_realizefn(DeviceState *d, 
>> Error **errp)
>>       pci_setup_iommu(h->bus, &raven_iommu_ops, s);
>>   }
>>   -static void raven_pcihost_initfn(Object *obj)
>> -{
>> -    PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(obj);
>> -    MemoryRegion *address_space_mem = get_system_memory();
>> -
>> -    memory_region_init(&s->pci_io, obj, "pci-io", 0x3f800000);
>> -    memory_region_init_io(&s->pci_discontiguous_io, obj,
>> -                          &raven_io_ops, &s->pci_io,
>> -                          "pci-discontiguous-io", 8 * MiB);
>> -    memory_region_init(&s->pci_memory, obj, "pci-memory", 0x3f000000);
>> -
>> -    /* CPU address space */
>> -    memory_region_add_subregion(address_space_mem, PCI_IO_BASE_ADDR,
>> -                                &s->pci_io);
>> -    memory_region_add_subregion_overlap(address_space_mem, 
>> PCI_IO_BASE_ADDR,
>> -                                        &s->pci_discontiguous_io, 1);
>> -    memory_region_set_enabled(&s->pci_discontiguous_io, false);
>> -    memory_region_add_subregion(address_space_mem, 0xc0000000, 
>> &s->pci_memory);
>> -}
>> -
>>   static void raven_pcihost_class_init(ObjectClass *klass, const void 
>> *data)
>>   {
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>>         set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>> -    dc->realize = raven_pcihost_realizefn;
>> +    dc->realize = raven_pcihost_realize;
>>       dc->fw_name = "pci";
>>   }
>>   @@ -278,7 +267,6 @@ static const TypeInfo raven_types[] = {
>>           .name = TYPE_RAVEN_PCI_HOST_BRIDGE,
>>           .parent = TYPE_PCI_HOST_BRIDGE,
>>           .instance_size = sizeof(PREPPCIState),
>> -        .instance_init = raven_pcihost_initfn,
>>           .class_init = raven_pcihost_class_init,
>>       },
>>       {
>> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
>> index 816455d289..973d2fb7eb 100644
>> --- a/hw/ppc/prep.c
>> +++ b/hw/ppc/prep.c
>> @@ -53,8 +53,11 @@
>>     #define CFG_ADDR 0xf0000510
>>   -#define KERNEL_LOAD_ADDR 0x01000000
>> -#define INITRD_LOAD_ADDR 0x01800000
>> +#define KERNEL_LOAD_ADDR  0x01000000
>> +#define INITRD_LOAD_ADDR  0x01800000
>> +
>> +#define PCI_IO_BASE_ADDR  0x80000000
>> +#define PCI_MEM_BASE_ADDR 0xc0000000
>>     #define BIOS_ADDR         0xfff00000
>>   #define BIOS_SIZE         (1 * MiB)
>> @@ -293,6 +296,9 @@ static void ibm_40p_init(MachineState *machine)
>>       pcihost = SYS_BUS_DEVICE(dev);
>>       object_property_add_child(qdev_get_machine(), "raven", OBJECT(dev));
>>       sysbus_realize_and_unref(pcihost, &error_fatal);
>> +    sysbus_mmio_map(pcihost, 0, PCI_IO_BASE_ADDR);
>> +    sysbus_mmio_map_overlap(pcihost, 1, PCI_IO_BASE_ADDR, 1);
>> +    sysbus_mmio_map(pcihost, 2, PCI_MEM_BASE_ADDR);
>>       pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
>>       if (!pci_bus) {
>>           error_report("could not create PCI host controller");
>
> In general the expectation is that memory regions should be initialised in 
> the _init() function, unless they depend upon a property in which case they 
> should be initialised in the _realize() function. Why do you feel this needs 
> to be different?

Is any of it needed before realize? If not why have an init method at all? 
As shown here this works perfectly without one and is more comprehensible 
that way for people reading it without deep knowledge about Qdev. In 
general I think simple devices only need a realize method and the init 
method is rarely needed, e.g. if there are some child objects that need to 
be init for passing properties that can be set before realize or similar 
unusual cases but for most classes init is not needed at all. I only want 
to keep what's necessary and remove everything that's not needed. I think 
that makes the device model easier to understand.

Regards,
BALATON Zoltan
--3866299591-13883601-1761352157=:598--

