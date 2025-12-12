Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A56FD59D79
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 16:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU6Hq-0007w5-EU; Fri, 12 Dec 2025 11:46:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vU6Hh-0007oM-Tq; Fri, 12 Dec 2025 11:46:26 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vU6Hf-0006Ki-Ib; Fri, 12 Dec 2025 11:46:25 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAXHCTVRjxpIgpoAQ--.12832S2;
 Sat, 13 Dec 2025 00:46:13 +0800 (CST)
Received: from [192.168.31.152] (unknown [222.244.181.125])
 by mail (Coremail) with SMTP id AQAAfwBnwe7IRjxpe6ULAA--.28134S2;
 Sat, 13 Dec 2025 00:46:07 +0800 (CST)
Message-ID: <ecfa9104-2864-48e0-8d3a-ac4f1540417f@phytium.com.cn>
Date: Sat, 13 Dec 2025 00:45:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/smmu: add memory regions as property for an SMMU
 instance
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>
References: <20251211221715.2206662-1-pierrick.bouvier@linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <20251211221715.2206662-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBnwe7IRjxpe6ULAA--.28134S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQACBWk7JbIJugACsy
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Gr45KF1xGr48ur1kXw1rtFb_yoW3Wr45pF
 Z5uFs5KrWxKF17JrZ3ZrsxuFy5Jw4vk3W5Kry7Cr97CF1UGr15Ar4jkw1jkr9rCrn5Aw17
 ZF1q9Fs7Zw47t3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Pierrick,

On 2025/12/12 06:17, Pierrick Bouvier wrote:
> This will be used to access non-secure and secure memory. Secure support
> and Granule Protection Check (for RME) for SMMU need to access secure
> memory.
>
> As well, it allows to remove usage of global address_space_memory,
> allowing different SMMU instances to have a specific view of memory.


Thanks for the patch.

I have to admit that in my earlier series I didn’t find a clean way to 
model SMMU’s AddressSpace handling properly, so I ended up using weak 
globals as a pragmatic workaround. Your approach is much cleaner and 
fits QEMU’s usual memory model.

>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/arm/smmu-common.h |  4 ++++
>   hw/arm/sbsa-ref.c            | 16 ++++++++++++----
>   hw/arm/smmu-common.c         | 24 ++++++++++++++++++++++++
>   hw/arm/virt.c                | 16 +++++++++++-----
>   4 files changed, 51 insertions(+), 9 deletions(-)
>
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index a6bdb67a983..0f08ae080c9 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -227,6 +227,10 @@ struct SMMUState {
>       uint8_t bus_num;
>       PCIBus *primary_bus;
>       bool smmu_per_bus; /* SMMU is specific to the primary_bus */
> +    MemoryRegion *memory;
> +    AddressSpace as_memory;
> +    MemoryRegion *secure_memory;
> +    AddressSpace as_secure_memory;
>   };
>   
>   struct SMMUBaseClass {
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 45d2e3e946d..840b1a216f4 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -616,7 +616,9 @@ static void create_xhci(const SBSAMachineState *sms)
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
> @@ -628,6 +630,10 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
>       object_property_set_str(OBJECT(dev), "stage", "nested", &error_abort);
>       object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
>                                &error_abort);
> +    object_property_set_link(OBJECT(dev), "memory", OBJECT(sysmem),
> +                             &error_abort);
> +    object_property_set_link(OBJECT(dev), "secure-memory", OBJECT(secure_sysmem),
> +                             &error_abort);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>       for (i = 0; i < NUM_SMMU_IRQS; i++) {
> @@ -636,7 +642,9 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
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
> @@ -692,7 +700,7 @@ static void create_pcie(SBSAMachineState *sms)
>   
>       pci_create_simple(pci->bus, -1, "bochs-display");
>   
> -    create_smmu(sms, pci->bus);
> +    create_smmu(sms, pci->bus, sysmem, secure_sysmem);
>   }
>   
>   static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size)
> @@ -831,7 +839,7 @@ static void sbsa_ref_init(MachineState *machine)
>   
>       create_xhci(sms);
>   
> -    create_pcie(sms);
> +    create_pcie(sms, sysmem, secure_sysmem);
>   
>       create_secure_ec(secure_sysmem);
>   
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 66367adc2a4..5fbfe825fd0 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -1171,6 +1171,12 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> +    g_assert(s->memory);
> +    address_space_init(&s->as_memory, s->memory, "memory");
> +    if (s->secure_memory) {
> +        address_space_init(&s->as_secure_memory, s->secure_memory, "secure-memory");
> +    }
> +
>       /*
>        * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
>        * root complexes to be associated with SMMU.
> @@ -1235,10 +1241,28 @@ static void smmu_base_class_init(ObjectClass *klass, const void *data)
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
> index 5d205eff3a1..d446c3349e9 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1514,8 +1514,9 @@ static void create_smmuv3_dev_dtb(VirtMachineState *vms,
>                              0x0, vms->iommu_phandle, 0x0, 0x10000);
>   }
>   
> -static void create_smmu(const VirtMachineState *vms,
> -                        PCIBus *bus)
> +static void create_smmu(const VirtMachineState *vms, PCIBus *bus,
> +                        MemoryRegion *sysmem,
> +                        MemoryRegion *secure_sysmem)
>   {
>       VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>       int irq =  vms->irqmap[VIRT_SMMU];
> @@ -1549,6 +1550,10 @@ static void create_smmu(const VirtMachineState *vms,
>       object_property_set_str(OBJECT(dev), "stage", stage, &error_fatal);

This unchanged line doesn't seem to match the current master branch 
code. It was actually modified last year by Peter in commit 8a934f1c4a 
which changed the virt board's default stage. So I failed to apply this 
patch. Anyway this discrepancy doesn't affect the core functionality of 
the patch.


Applying: hw/arm/smmu: add memory regions as property for an SMMU instance
error: patch failed: hw/arm/virt.c:1549
error: hw/arm/virt.c: patch does not apply
Patch failed at 0001 hw/arm/smmu: add memory regions as property for an 
SMMU instance
hint: Use 'git am --show-current-patch=diff' to see the failed patch


>       object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
>                                &error_abort);
> +    object_property_set_link(OBJECT(dev), "memory", OBJECT(sysmem),
> +                             &error_abort);

I noticed when using info mtree: after applying the patch, I see two 
address-space: memory which may confuse others. Is it necessary to 
distinguish the names here?


address-space: cpu-memory-0
address-space: gicv3-its-sysmem
address-space: memory
address-space: memory
   0000000000000000-ffffffffffffffff (prio 0, i/o): system
     0000000000000000-0000000003ffffff (prio 0, romd): virt.flash0
     0000000004000000-0000000007ffffff (prio 0, romd): virt.flash1
     0000000008000000-000000000800ffff (prio 0, i/o): gicv3_dist


For the functionality, based on this patch plus attachment #2 from the 
earlier thread [1], the NS/S SMMU code path in smmu_get_address_space 
works fine in my setup.


[1] 
https://lore.kernel.org/qemu-devel/db7fde79-85fa-4bd4-83ca-021ed3f09353@linaro.org/


Thanks,

Tao


