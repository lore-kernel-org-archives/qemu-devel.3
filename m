Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9C1D6E2AD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 15:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWGIA-0004E5-Mw; Thu, 18 Dec 2025 10:51:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vWGI4-0004CB-Ge; Thu, 18 Dec 2025 10:51:45 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vWGHz-0006Ji-Rf; Thu, 18 Dec 2025 10:51:44 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDH4qj9IkRpwCjWAw--.1148S2;
 Thu, 18 Dec 2025 23:51:25 +0800 (CST)
Received: from [192.168.31.152] (unknown [113.246.235.6])
 by mail (Coremail) with SMTP id AQAAfwC3Dev8IkRpZBoNAA--.9740S2;
 Thu, 18 Dec 2025 23:51:24 +0800 (CST)
Message-ID: <051851b8-24ef-4ffc-a0d8-9894fe50d398@phytium.com.cn>
Date: Thu, 18 Dec 2025 23:51:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hw/arm/smmu: add memory regions as property for an
 SMMU instance
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>
References: <20251216235731.1793908-1-pierrick.bouvier@linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <20251216235731.1793908-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwC3Dev8IkRpZBoNAA--.9740S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAIBWlDDsUIJgAAsD
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Wr4UJryfur4fXw4kGw17ZFb_yoWfKF48pF
 WruFsYgrWxKF17JrZ3XFsxWFy5J3yv93WUKry3Crn2kF17Kr15AF4jkw1jk34qkr4DAw17
 ZF1DuFs7Zw13t3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Pierrick,

On 2025/12/17 07:57, Pierrick Bouvier wrote:
> This will be used to access non-secure and secure memory. Secure support
> and Granule Protection Check (for RME) for SMMU need to access secure
> memory.
>
> As well, it allows to remove usage of global address_space_memory,
> allowing different SMMU instances to have a specific view of memory.
>
> User creatable SMMU are handled as well for virt machine,
> by setting the memory properties when device is plugged in.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/arm/smmu-common.h |  4 ++++
>   include/hw/arm/virt.h        |  2 ++
>   hw/arm/sbsa-ref.c            | 16 ++++++++++++----
>   hw/arm/smmu-common.c         | 25 +++++++++++++++++++++++++
>   hw/arm/virt.c                | 13 +++++++++++--
>   5 files changed, 54 insertions(+), 6 deletions(-)
>
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 80d0fecfde8..d9bade3c803 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -162,6 +162,10 @@ struct SMMUState {
>       uint8_t bus_num;
>       PCIBus *primary_bus;
>       bool smmu_per_bus; /* SMMU is specific to the primary_bus */
> +    MemoryRegion *memory;
> +    AddressSpace memory_as;
> +    MemoryRegion *secure_memory;
> +    AddressSpace secure_memory_as;
>   };
>   
>   struct SMMUBaseClass {
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index c77a33f6df2..d3743810338 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -180,6 +180,8 @@ struct VirtMachineState {
>       bool ns_el2_virt_timer_irq;
>       CXLState cxl_devices_state;
>       bool legacy_smmuv3_present;
> +    MemoryRegion *sysmem;
> +    MemoryRegion *secure_sysmem;
>   };
>   
>   #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 2205500a8da..cc9d4385826 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -613,7 +613,9 @@ static void create_xhci(const SBSAMachineState *sms)
>       sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(sms->gic, irq));
>   }
>   
> -static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
> +static void create_smmu(const SBSAMachineState *sms, PCIBus *bus,
> +                        MemoryRegion *sysmem,
> +                        MemoryRegion *secure_sysmem)
>   {
>       hwaddr base = sbsa_ref_memmap[SBSA_SMMU].base;
>       int irq =  sbsa_ref_irqmap[SBSA_SMMU];
> @@ -625,6 +627,10 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
>       object_property_set_str(OBJECT(dev), "stage", "nested", &error_abort);
>       object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
>                                &error_abort);
> +    object_property_set_link(OBJECT(dev), "memory", OBJECT(sysmem),
> +                             &error_abort);
> +    object_property_set_link(OBJECT(dev), "secure-memory", OBJECT(secure_sysmem),


......

> +                             &error_abort);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>       for (i = 0; i < NUM_SMMU_IRQS; i++) {
> @@ -633,7 +639,9 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
>       }
>   }
>   
> -static void create_pcie(SBSAMachineState *sms)
> +static void create_pcie(SBSAMachineState *sms,
> +                        MemoryRegion *sysmem,
> +                        MemoryRegion *secure_sysmem)
>   {
>       hwaddr base_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].base;
>       hwaddr size_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].size;
> @@ -689,7 +697,7 @@ static void create_pcie(SBSAMachineState *sms)
>   
>       pci_create_simple(pci->bus, -1, "bochs-display");
>   
> -    create_smmu(sms, pci->bus);
> +    create_smmu(sms, pci->bus, sysmem, secure_sysmem);
>   }
>   
>   static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size)
> @@ -825,7 +833,7 @@ static void sbsa_ref_init(MachineState *machine)
>   
>       create_xhci(sms);
>   
> -    create_pcie(sms);
> +    create_pcie(sms, sysmem, secure_sysmem);
>   
>       create_secure_ec(secure_sysmem);
>   
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 62a76121841..9a67ce857fe 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -944,6 +944,13 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> +    g_assert(s->memory);
> +    address_space_init(&s->memory_as, s->memory, "smmu-memory-view");
> +    if (s->secure_memory) {
> +        address_space_init(&s->secure_memory_as, s->secure_memory,
> +                           "smmu-secure-memory-view");
> +    }
> +
>       /*
>        * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
>        * root complexes to be associated with SMMU.
> @@ -1008,10 +1015,28 @@ static void smmu_base_class_init(ObjectClass *klass, const void *data)
>       rc->phases.exit = smmu_base_reset_exit;
>   }
>   
> +static void smmu_base_instance_init(Object *obj)
> +{
> +    SMMUState *s = ARM_SMMU(obj);
> +
> +    object_property_add_link(obj, "memory",
> +                             TYPE_MEMORY_REGION,
> +                             (Object **)&s->memory,
> +                             qdev_prop_allow_set_link_before_realize,
> +                             OBJ_PROP_LINK_STRONG);
> +
> +    object_property_add_link(obj, "secure-memory",
> +                             TYPE_MEMORY_REGION,
> +                             (Object **)&s->secure_memory,
> +                             qdev_prop_allow_set_link_before_realize,
> +                             OBJ_PROP_LINK_STRONG);
> +}
> +
>   static const TypeInfo smmu_base_info = {
>       .name          = TYPE_ARM_SMMU,
>       .parent        = TYPE_SYS_BUS_DEVICE,
>       .instance_size = sizeof(SMMUState),
> +    .instance_init = smmu_base_instance_init,
>       .class_data    = NULL,
>       .class_size    = sizeof(SMMUBaseClass),
>       .class_init    = smmu_base_class_init,
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 25fb2bab568..603f4b6a1d7 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1514,8 +1514,7 @@ static void create_smmuv3_dev_dtb(VirtMachineState *vms,
>                              0x0, vms->iommu_phandle, 0x0, 0x10000);
>   }
>   
> -static void create_smmu(const VirtMachineState *vms,
> -                        PCIBus *bus)
> +static void create_smmu(const VirtMachineState *vms, PCIBus *bus)
>   {
>       VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>       int irq =  vms->irqmap[VIRT_SMMU];
> @@ -1535,6 +1534,10 @@ static void create_smmu(const VirtMachineState *vms,
>       }
>       object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
>                                &error_abort);
> +    object_property_set_link(OBJECT(dev), "memory", OBJECT(vms->sysmem),
> +                             &error_abort);
> +    object_property_set_link(OBJECT(dev), "secure-memory", OBJECT(vms->secure_sysmem),
> +                             &error_abort);


I noticed this line is over 80 characters and the corresponding one in 
hw/arm/sbsa-ref.c also seems to exceed 80 characters. I’m not fully sure 
whether QEMU expects us to strictly keep every line under 80 characters, 
but when I ran scripts/checkpatch.pl I did see two warnings.


```

WARNING: line over 80 characters
#47: FILE: hw/arm/sbsa-ref.c:632:
+    object_property_set_link(OBJECT(dev), "secure-memory", 
OBJECT(secure_sysmem),

WARNING: line over 80 characters
#148: FILE: hw/arm/virt.c:1539:
+    object_property_set_link(OBJECT(dev), "secure-memory", 
OBJECT(vms->secure_sysmem),

total: 0 errors, 2 warnings, 148 lines checked

```


Just flagging this in case you’d like to adjust it before the next revision.


Besides, I tested the SMMU-related MemoryRegion and AddressSpace 
instantiation for both user-creatable and machine-wide SMMUv3 devices. 
As shown in the info mtree output below, everything looks fine on my side.


```

(QEMU) info mtree
address-space: cpu-secure-memory-0
address-space: smmu-secure-memory-view
   0000000000000000-ffffffffffffffff (prio 0, i/o): secure-memory
     0000000000000000-0000000003ffffff (prio 0, romd): virt.flash0

....

address-space: cpu-memory-0
address-space: gicv3-its-sysmem
address-space: memory
address-space: smmu-memory-view
   0000000000000000-ffffffffffffffff (prio -1, i/o): system
     0000000004000000-0000000007ffffff (prio 0, romd): virt.flash1
     0000000008000000-000000000800ffff (prio 0, i/o): gicv3_dist

```



Regards,
Tao

>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>       for (i = 0; i < NUM_SMMU_IRQS; i++) {
> @@ -1609,6 +1612,7 @@ static void create_pcie(VirtMachineState *vms)
>       memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
>                                ecam_reg, 0, size_ecam);
>       memory_region_add_subregion(get_system_memory(), base_ecam, ecam_alias);
> +    vms->sysmem = get_system_memory();
>   
>       /* Map the MMIO window into system address space so as to expose
>        * the section of PCI MMIO space which starts at the same base address
> @@ -2256,6 +2260,7 @@ static void machvirt_init(MachineState *machine)
>            * devices go in at higher priority and take precedence.
>            */
>           secure_sysmem = g_new(MemoryRegion, 1);
> +        vms->secure_sysmem = secure_sysmem;
>           memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
>                              UINT64_MAX);
>           memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
> @@ -3051,6 +3056,10 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>           } else if (vms->iommu == VIRT_IOMMU_NONE) {
>               /* The new SMMUv3 device is specific to the PCI bus */
>               object_property_set_bool(OBJECT(dev), "smmu_per_bus", true, NULL);
> +            object_property_set_link(OBJECT(dev), "memory",
> +                                     OBJECT(vms->sysmem), NULL);
> +            object_property_set_link(OBJECT(dev), "secure-memory",
> +                                     OBJECT(vms->secure_sysmem), NULL);
>           }
>       }
>   }


