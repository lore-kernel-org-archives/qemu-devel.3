Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50483C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 13:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRAsB-0004d5-8T; Tue, 09 Jul 2024 09:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sRAs9-0004Zk-4x
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 09:27:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sRAs6-0007ND-VS
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 09:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720531625;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jbI1WDKjUJrWfKnr+awdNz8FbJ/HSPUffNOcZEvJ9gQ=;
 b=dc/D5f5u2U5AIs7V4i0eQMEGc10TYsKKQJ063sU8zK0M5r9NDSofomBCn7mlu+5xNSNShn
 04sBNtzXZl3jcrctmOVRV633KJu1mVuQ9HM5KqQYT0efq+Dw82tCYiC/ASktK9BXnxjPrx
 n3o45rIFGoLk2PAeL9mmRCVYiNqUHPo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-6lW2eBQLOUuv6ywP7RwkzQ-1; Tue, 09 Jul 2024 09:27:03 -0400
X-MC-Unique: 6lW2eBQLOUuv6ywP7RwkzQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-79f19f19b11so127896485a.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 06:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720531623; x=1721136423;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jbI1WDKjUJrWfKnr+awdNz8FbJ/HSPUffNOcZEvJ9gQ=;
 b=bn1XGGkw4vSZaDH7qdocNTN04SPpmXtU0FwoAlxo5MESN+5vdFCESVqULtUByApo9G
 Q/EYGFT/9OCsyt/8aAEC7cO94NMZNYYeZ/pUosT6WCFCxA5CzHoGAWuARHUH/gIhJW/q
 sY/nt3fHl4jvrOKw+imnAr4pgcnGxwd9lrPhbz2lFelaVAzd2HHPsQT3CajyLsrLsdLL
 XX1VEqNR4PjdCGO/F014I90FVipAVlW7mx7nIA8xqu+dKEfOnAK05qM1/D4ZvHwDPGGk
 Vh+1w4lw0V1fFB3QqSzLwPqqLDjA5/YlYbA6go+Nx40TjDvEo9lLEJs1gmZqrZxxw/Nv
 tNew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDUtDB+v9LQA+mhuXhKI6X28VIbzyG70lpgUClLK3RKtYKel+BLOYiP+YddUz2iJw0vmJduoMaUJlVZ3i3Hv2vut68GaU=
X-Gm-Message-State: AOJu0YxTJDDydLwWqJodz/abtVsbB6wXCzZiPA1J4/xDA0dM/Y0R+Oim
 GtKsc7Uh1LcTKDkXbOmDmZ4whzmGtg/30vw5PL1QjG0Pm9BkJhgR+tD0Qb6/XWtQyDcwIEJJxik
 jpyYFaN70UfZNFd1kIq4mv1TDYQu4AmQ33yzOkJWZBw05Lmm3ELt2
X-Received: by 2002:a05:620a:4111:b0:79d:77b8:d2e4 with SMTP id
 af79cd13be357-79f19bee298mr250589685a.65.1720531623322; 
 Tue, 09 Jul 2024 06:27:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE26Rsb1CVJ/YF5tCQv0vXqw/XQ+TA7Vbu6lIboRhl0JJ73rJhmrKGDDElkHZ6dYx+1GWSLYg==
X-Received: by 2002:a05:620a:4111:b0:79d:77b8:d2e4 with SMTP id
 af79cd13be357-79f19bee298mr250586985a.65.1720531622937; 
 Tue, 09 Jul 2024 06:27:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79f18ff691bsm97238185a.21.2024.07.09.06.27.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 06:27:02 -0700 (PDT)
Message-ID: <9c3e95c2-1035-4a55-89a3-97165ef32f18@redhat.com>
Date: Tue, 9 Jul 2024 15:26:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv1 05/10] hw/arm/virt: Add VIRT_NESTED_SMMU
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, peterx@redhat.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, jgg@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, jasowang@redhat.com,
 Andrea Bolognani <abologna@redhat.com>
References: <cover.1719361174.git.nicolinc@nvidia.com>
 <bc7a57311ac4976699789ceca329edfdfe823c2d.1719361174.git.nicolinc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <bc7a57311ac4976699789ceca329edfdfe823c2d.1719361174.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Nicolin,

On 6/26/24 02:28, Nicolin Chen wrote:
> VIRT_SMMU can be used as an emulated SMMU, i.e. iommu=smmuv3. However, the
> MMIO space for VIRT_SMMU isn't large enough to accommodate multiple nested
> SMMUv3 instances. Add a new VIRT_NESTED_SMMU to separate MMIO space.
>
> Meanwhile, a nested SMMUv3 could only work with a vfio-pci device that is
> physically associated to a host-level SMMUv3 instance, meaning that such a
> passthrough deivce must be linked to a nesteed SMMU corresponding to the
> underlying host-level SMMUv3 instance:
>       HW SMMU0 <-----------------> vSMMU0 (nested)
>           ^                             ^
> 	  |                             |
> 	  ----> PCI dev0 & PCI dev1 <----
>       HW SMMU1 <-----------------> vSMMU1 (nested)
>           ^                             ^
> 	  |                             |
> 	  ----> PCI dev2 & PCI dev3 <----
>
> Note that, on the other hand, an emulated deivce should not be associated
> to a nested SMMU.
>
> To prepare for that, create a PCIe Expander Bridge per nested SMMU as a
> docker for pci-vfio devices. It eases the QEMU code to build ID mappings
> in the IORT.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  hw/arm/virt.c         | 110 +++++++++++++++++++++++++++++++++++++-----
>  include/hw/arm/virt.h |  17 +++++++
>  2 files changed, 116 insertions(+), 11 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index ef59c79ca3..a54332fca8 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -55,6 +55,7 @@
>  #include "qemu/bitops.h"
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
> +#include "hw/pci/pci_bus.h"
>  #include "hw/pci-host/gpex.h"
>  #include "hw/virtio/virtio-pci.h"
>  #include "hw/core/sysbus-fdt.h"
> @@ -83,6 +84,7 @@
>  #include "hw/virtio/virtio-md-pci.h"
>  #include "hw/virtio/virtio-iommu.h"
>  #include "hw/char/pl011.h"
> +#include "qemu/config-file.h"
>  #include "qemu/guest-random.h"
>  
>  static GlobalProperty arm_virt_compat[] = {
> @@ -177,6 +179,7 @@ static const MemMapEntry base_memmap[] = {
>      [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
>      [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
>      [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
> +    [VIRT_NESTED_SMMU] =        { 0x0b000000, 0x01000000 },
>      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
>      [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
>      [VIRT_SECURE_MEM] =         { 0x0e000000, 0x01000000 },
> @@ -221,7 +224,8 @@ static const int a15irqmap[] = {
>      [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
>      [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
>      [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
> -    [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
> +    [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 (179) */
> +    [VIRT_NESTED_SMMU] = 200, /* Keep it at the end of list */
>  };
>  
>  static void create_randomness(MachineState *ms, const char *node)
> @@ -1383,21 +1387,19 @@ static void create_pcie_irq_map(const MachineState *ms,
>                             0x7           /* PCI irq */);
>  }
>  
> -static void create_smmu(const VirtMachineState *vms,
> -                        PCIBus *bus)
> +static DeviceState *_create_smmu(const VirtMachineState *vms, PCIBus *bus,
> +                                 hwaddr base, hwaddr size, int irq,
> +                                 uint32_t smmu_phandle)
>  {
>      char *node;
>      const char compat[] = "arm,smmu-v3";
> -    int irq =  vms->irqmap[VIRT_SMMU];
>      int i;
> -    hwaddr base = vms->memmap[VIRT_SMMU].base;
> -    hwaddr size = vms->memmap[VIRT_SMMU].size;
>      const char irq_names[] = "eventq\0priq\0cmdq-sync\0gerror";
>      DeviceState *dev;
>      MachineState *ms = MACHINE(vms);
>  
> -    if (!virt_has_smmuv3(vms) || !vms->iommu_phandle) {
> -        return;
> +    if (!virt_has_smmuv3(vms) || !smmu_phandle) {
> +        return NULL;
>      }
>  
>      dev = qdev_new(TYPE_ARM_SMMUV3);
> @@ -1436,8 +1438,31 @@ static void create_smmu(const VirtMachineState *vms,
>  
>      qemu_fdt_setprop_cell(ms->fdt, node, "#iommu-cells", 1);
>  
> -    qemu_fdt_setprop_cell(ms->fdt, node, "phandle", vms->iommu_phandle);
> +    qemu_fdt_setprop_cell(ms->fdt, node, "phandle", smmu_phandle);
>      g_free(node);
> +
> +    return dev;
> +}
> +
> +static DeviceState *create_smmu(const VirtMachineState *vms, PCIBus *bus)
> +{
> +    hwaddr base = vms->memmap[VIRT_SMMU].base;
> +    hwaddr size = vms->memmap[VIRT_SMMU].size;
> +    int irq = vms->irqmap[VIRT_SMMU];
> +
> +    return _create_smmu(vms, bus, base, size, irq, vms->iommu_phandle);
> +}
> +
> +static DeviceState *create_nested_smmu(const VirtMachineState *vms, PCIBus *bus,
> +                                       int i)
> +{
> +    hwaddr base = vms->memmap[VIRT_NESTED_SMMU].base + i * SMMU_IO_LEN;
> +    int irq = vms->irqmap[VIRT_SMMU] + i * NUM_SMMU_IRQS;
> +    hwaddr size = SMMU_IO_LEN;
> +    DeviceState *dev;
> +
> +    dev = _create_smmu(vms, bus, base, size, irq, vms->nested_smmu_phandle[i]);
> +    return dev;
>  }
>  
>  static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
> @@ -1466,6 +1491,48 @@ static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
>                             bdf + 1, vms->iommu_phandle, bdf + 1, 0xffff - bdf);
>  }
>  
> +/*
> + * FIXME this is used to reverse for hotplug devices, yet it could result in a
> + * big waste of PCI bus numbners.
> + */
> +#define MAX_DEV_PER_NESTED_SMMU (4)
> +
> +static PCIBus *create_pcie_expander_bridge(VirtMachineState *vms, uint8_t idx)
> +{
> +    /* Total = PXB + MAX_DEV_PER_NESTED_SMMU x (Rootport + device) */
> +    const uint8_t total_bus_nums = 1 + MAX_DEV_PER_NESTED_SMMU * 2;
> +    uint8_t bus_nr = PCI_BUS_MAX -
> +                     (vms->num_nested_smmus - idx) * total_bus_nums;
> +
> +    VirtNestedSmmu *nested_smmu = find_nested_smmu_by_index(vms, idx);
> +    char *name_pxb = g_strdup_printf("pxb_for_smmu.%d", idx);
> +    PCIBus *bus = vms->bus;
> +    DeviceState *dev;
> +
> +    /* Create an expander bridge */
> +    dev = qdev_new("pxb-pcie");
> +    if (!qdev_set_id(dev, name_pxb, &error_fatal)) {
> +        return NULL;
> +    }
> +
> +    qdev_prop_set_uint8(dev, "bus_nr", bus_nr);
> +    qdev_prop_set_uint16(dev, "numa_node", idx);
> +    qdev_realize_and_unref(dev, BUS(bus), &error_fatal);
> +
> +    /* Get the pxb bus */
> +    QLIST_FOREACH(bus, &bus->child, sibling) {
> +        if (pci_bus_num(bus) == bus_nr) {
> +            break;
> +        }
> +    }
> +    g_assert(bus && pci_bus_num(bus) == bus_nr);
> +    nested_smmu->pci_bus = bus;
> +    nested_smmu->reserved_bus_nums = total_bus_nums;
> +
> +    /* Return the pxb bus */
> +    return bus;
> +}
> +
>  static void create_pcie(VirtMachineState *vms)
>  {
>      hwaddr base_mmio = vms->memmap[VIRT_PCIE_MMIO].base;
> @@ -1580,12 +1647,33 @@ static void create_pcie(VirtMachineState *vms)
>      qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 1);
>      create_pcie_irq_map(ms, vms->gic_phandle, irq, nodename);
>  
> -    if (vms->iommu) {
> +    /* Build PCI Expander Bridge + Root Port from the top of PCI_BUS_MAX */
> +    if (vms->num_nested_smmus) {
> +        /* VIRT_NESTED_SMMU must hold all vSMMUs */
> +        g_assert(vms->num_nested_smmus <=
> +                 vms->memmap[VIRT_NESTED_SMMU].size / SMMU_IO_LEN);
> +
> +        vms->nested_smmu_phandle = g_new0(uint32_t, vms->num_nested_smmus);
> +
> +        for (i = 0; i < vms->num_nested_smmus; i++) {
> +            DeviceState *smmu_dev;
> +            PCIBus *pxb_bus;
> +
> +            pxb_bus = create_pcie_expander_bridge(vms, i);
> +            g_assert(pxb_bus);
> +
> +            vms->nested_smmu_phandle[i] = qemu_fdt_alloc_phandle(ms->fdt);
> +            smmu_dev = create_nested_smmu(vms, pxb_bus, i);
> +            g_assert(smmu_dev);
> +
> +            qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map", 0x0,
> +                                   vms->nested_smmu_phandle[i], 0x0, 0x10000);
I think libvirt is supposed to create the pcie bus topology instead and
it shall not be created by qemu behind the scene.
The pcie elements you create here are not visible to libvirt and I guess
they may collide with elements explicitly created by libvirt at a given
pci bdf.

I think it would make more sense to be able to attach an smmu instance
to a given pci root or pxb either by adding an iommu id to a given
pxb-pcie option

-device
pxb-pcie,bus_nr=100,id=pci.12,numa_node=0,bus=pcie.0,addr=0x3,iommu=<id>
or
adding a list of pxb ids to the iommu option. It is unfortunate the
iommu option is a machine option. the smmu being a sysbus device the
platform bus framework could be considered to dynamically allocate them
using the -device option. This has been used along with dt generation
but with ACPI this would need to be studied. However at the time the
smmu was integrated the machine option was prefered.

Maybe using the 1st option would allow to infer that if there are
different iommu ids this implies that several IOMMU instances need to be
created.

 
Adding Andrea in cc

Thanks

Eric



> +        }
> +    } else if (vms->iommu) {
>          vms->iommu_phandle = qemu_fdt_alloc_phandle(ms->fdt);
>  
>          switch (vms->iommu) {
>          case VIRT_IOMMU_SMMUV3:
> -        case VIRT_IOMMU_NESTED_SMMUV3:
>              create_smmu(vms, vms->bus);
>              qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
>                                     0x0, vms->iommu_phandle, 0x0, 0x10000);
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index b35c4f62d7..0a3f1ab8b5 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -63,6 +63,7 @@ enum {
>      VIRT_GIC_ITS,
>      VIRT_GIC_REDIST,
>      VIRT_SMMU,
> +    VIRT_NESTED_SMMU,
>      VIRT_UART,
>      VIRT_MMIO,
>      VIRT_RTC,
> @@ -141,6 +142,8 @@ struct VirtMachineClass {
>  typedef struct VirtNestedSmmu {
>      int index;
>      char *smmu_node;
> +    PCIBus *pci_bus;
> +    int reserved_bus_nums;
>      QLIST_ENTRY(VirtNestedSmmu) next;
>  } VirtNestedSmmu;
>  
> @@ -179,6 +182,7 @@ struct VirtMachineState {
>      uint32_t gic_phandle;
>      uint32_t msi_phandle;
>      uint32_t iommu_phandle;
> +    uint32_t *nested_smmu_phandle;
>      int psci_conduit;
>      hwaddr highest_gpa;
>      DeviceState *gic;
> @@ -229,4 +233,17 @@ static inline bool virt_has_smmuv3(const VirtMachineState *vms)
>             vms->iommu == VIRT_IOMMU_NESTED_SMMUV3;
>  }
>  
> +static inline VirtNestedSmmu *
> +find_nested_smmu_by_index(VirtMachineState *vms, int index)
> +{
> +    VirtNestedSmmu *nested_smmu;
> +
> +    QLIST_FOREACH(nested_smmu, &vms->nested_smmu_list, next) {
> +        if (nested_smmu->index == index) {
> +            return nested_smmu;
> +        }
> +    }
> +    return NULL;
> +}
> +
>  #endif /* QEMU_ARM_VIRT_H */


