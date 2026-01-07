Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0541D0D170
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 20:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdZs1-0006Rp-6h; Wed, 07 Jan 2026 15:11:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdZrj-0006E4-II
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:10:48 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdZrh-0002fw-I1
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:10:47 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-29f0f875bc5so24144595ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 12:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767816644; x=1768421444; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u4evTaJ5RGHQzdv8Im1dab2ZDbXsj+XJBqWHnkuyWMs=;
 b=C/lC3yyDckoy6x8/FkXXNIKIeBJr2+vjF+oDWxkGO/McRBA5oaaBEt5hVNtTcHzz7D
 IzAoG8kOJR4+8D2+YnfjzRrvpnqsmm62uJ20YcvPPr+qVmur+vC9cUqVDKQmMAr/+1EJ
 Xtc4ADN3uVffi10UJPs39jGWpt0cyr/g88ujM6crwzPqEBisAkrEstZCEhel5yWGJcXB
 FNSu4SuNhbKBWMKc1N57dekv9IsuItzcw9aX2qACRaXShbU6Mn2yC3b34wZ0GeuW775W
 qSPMLu1xdS5s5Qz1A/7dIVEanbCUpO0FkT8ASY4i4Zcmk7CO9JtZdWhHjq6S/f7qQFTl
 FXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767816644; x=1768421444;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u4evTaJ5RGHQzdv8Im1dab2ZDbXsj+XJBqWHnkuyWMs=;
 b=S3AVXpFT/vpQ3tCnd1WT16mKcJA+UB87WRSX3RaNQmZxmU1sPn1LDi04iqyODKEBGs
 vs8cyZryuvgQ3ZTcNiMYJJid1841q6k/4izarlDdabmiZmJ1GvhFCoFXjTdpuiYNg49l
 3JgIT1mjeeOiX4qcDyCZzqzVuqH/3c/eDoEF7SII7G6khzG+ap4GbfHWUfYdSGmHgyUg
 4fhGppMtxoZ5dtuCNh1g2DLwTWV+MEi+4HOYLOffFebUy+f07G7srEssSAp/htY6ptHB
 SYZFUkwo8NMCfacQ0MWiYvn0mVwbYkQtrxHCqJ2tDW8FBOUiMoXYMTCBIPLFTTJ0f08f
 JBCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNgB3s59OrjZ2omVVh9XApwtU5vbUdcPJwEWWHTGyAQwhbjBgemfPlYJ++YgdETZYNwdWWoMwWWqGh@nongnu.org
X-Gm-Message-State: AOJu0Yz6ny9nyhGCH4EdvR3xlE8MWtv2LG02r8nwJ7WUvq7nQ4UojHD6
 REb67axDJXntYdhhhggkZjJcAMbtpG5OxDAi4fsiEvEujuDCGKVQw/jCWfDS3elf5SloFyLoVXw
 vvXZe
X-Gm-Gg: AY/fxX51cXRad9MAD2wG4RAScsGJMShkC7eyDDup+HQKRfsizMQBqNhO/u2SGaBQLkg
 RiPT+MgEpBAmsy/RapRrgmW32/4a/BfhgnacpTevs5790cyVVvT/CEImxeoRWyOzpONPfEr/Uc9
 kSzh6NbYU5jug5OfBzoMSWPLFJucsxUTgGSPgK1sUsHtmwMtWhypU8VWZmOEi0HmlJ6e+r1JcDu
 EPdrrJ3AT965OnV0VI9cUkItVXfy50WphruwfRNAiKyOMRe7LRce+LdHTmQ+6r25A3+56ALAUV2
 0qDgZ5YVrw8kD3QScFzzxQMeRZbVVKQCYlThEj5FwvNCIUOC2niio/790HW9DqTZ1x5DMQyBrSW
 wEzO2VxZNtdCJ3b2kWHWA5yjZGMIJTyBpWvTj9Q0MldV++YcOb6wBaAoletqA+N3gqTzPKPK+Cf
 Vg7yP7Wsio+WkzLEi1Ooo9tZjKl/73q/OmuDVgdK6bcocvAXj8j9/fb0MH
X-Google-Smtp-Source: AGHT+IHh3qPoFpwDCDPCM6wEj7a3aomOYzyqNA7Cjc0aHE6IoDAHK1ygam6YdWeIIUtDUG435dFL4w==
X-Received: by 2002:a17:902:f60d:b0:29f:299a:b6e2 with SMTP id
 d9443c01a7336-2a3ee4fea1fmr33222485ad.42.1767816643770; 
 Wed, 07 Jan 2026 12:10:43 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cc794asm58066635ad.70.2026.01.07.12.10.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 12:10:43 -0800 (PST)
Message-ID: <e5f3080e-8011-456e-a4cb-0febe71d4759@linaro.org>
Date: Wed, 7 Jan 2026 12:10:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hw/arm/smmu: add memory regions as property for an
 SMMU instance
Content-Language: en-US
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Radoslaw Biernacki <rad@semihalf.com>,
 tangtao1634@phytium.com.cn, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>
References: <20251216235731.1793908-1-pierrick.bouvier@linaro.org>
 <16a8de8d-3054-4d7f-b4b1-1588aa54ee24@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <16a8de8d-3054-4d7f-b4b1-1588aa54ee24@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/7/26 10:32 AM, Eric Auger wrote:
> Hi Pierrick,
> 
> On 12/17/25 12:57 AM, Pierrick Bouvier wrote:
>> This will be used to access non-secure and secure memory. Secure support
>> and Granule Protection Check (for RME) for SMMU need to access secure
>> memory.
>>
>> As well, it allows to remove usage of global address_space_memory,
>> allowing different SMMU instances to have a specific view of memory.
>>
>> User creatable SMMU are handled as well for virt machine,
>> by setting the memory properties when device is plugged in.
> 
> Will Tao's [RFC v3 08/21] hw/arm/smmuv3: Add separate address space for
> secure SMMU accesses
> be rebased on top of that. How does it cooperate?
>

Yes, the idea is for him to rebase on top of this series, providing 
access to address spaces in a clean way. I felt better pushing it myself 
than asking to Tao to integrate it in his series and deal with changes.

As well, we have a wip branch adding root and realm support to smmuv3 
that is itself based on current Tao's series and will be published 
later. Secure address space is needed to access Granule Protection Table 
to implement Granule Protection check. That's how I ended up writing 
this series.

> Thanks
> 
> Eric
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   include/hw/arm/smmu-common.h |  4 ++++
>>   include/hw/arm/virt.h        |  2 ++
>>   hw/arm/sbsa-ref.c            | 16 ++++++++++++----
>>   hw/arm/smmu-common.c         | 25 +++++++++++++++++++++++++
>>   hw/arm/virt.c                | 13 +++++++++++--
>>   5 files changed, 54 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
>> index 80d0fecfde8..d9bade3c803 100644
>> --- a/include/hw/arm/smmu-common.h
>> +++ b/include/hw/arm/smmu-common.h
>> @@ -162,6 +162,10 @@ struct SMMUState {
>>       uint8_t bus_num;
>>       PCIBus *primary_bus;
>>       bool smmu_per_bus; /* SMMU is specific to the primary_bus */
>> +    MemoryRegion *memory;
>> +    AddressSpace memory_as;
>> +    MemoryRegion *secure_memory;
>> +    AddressSpace secure_memory_as;
>>   };
>>   
>>   struct SMMUBaseClass {
>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>> index c77a33f6df2..d3743810338 100644
>> --- a/include/hw/arm/virt.h
>> +++ b/include/hw/arm/virt.h
>> @@ -180,6 +180,8 @@ struct VirtMachineState {
>>       bool ns_el2_virt_timer_irq;
>>       CXLState cxl_devices_state;
>>       bool legacy_smmuv3_present;
>> +    MemoryRegion *sysmem;
>> +    MemoryRegion *secure_sysmem;
>>   };
>>   
>>   #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
>> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
>> index 2205500a8da..cc9d4385826 100644
>> --- a/hw/arm/sbsa-ref.c
>> +++ b/hw/arm/sbsa-ref.c
>> @@ -613,7 +613,9 @@ static void create_xhci(const SBSAMachineState *sms)
>>       sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(sms->gic, irq));
>>   }
>>   
>> -static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
>> +static void create_smmu(const SBSAMachineState *sms, PCIBus *bus,
>> +                        MemoryRegion *sysmem,
>> +                        MemoryRegion *secure_sysmem)
>>   {
>>       hwaddr base = sbsa_ref_memmap[SBSA_SMMU].base;
>>       int irq =  sbsa_ref_irqmap[SBSA_SMMU];
>> @@ -625,6 +627,10 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
>>       object_property_set_str(OBJECT(dev), "stage", "nested", &error_abort);
>>       object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
>>                                &error_abort);
>> +    object_property_set_link(OBJECT(dev), "memory", OBJECT(sysmem),
>> +                             &error_abort);
>> +    object_property_set_link(OBJECT(dev), "secure-memory", OBJECT(secure_sysmem),
>> +                             &error_abort);
>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>>       for (i = 0; i < NUM_SMMU_IRQS; i++) {
>> @@ -633,7 +639,9 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
>>       }
>>   }
>>   
>> -static void create_pcie(SBSAMachineState *sms)
>> +static void create_pcie(SBSAMachineState *sms,
>> +                        MemoryRegion *sysmem,
>> +                        MemoryRegion *secure_sysmem)
>>   {
>>       hwaddr base_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].base;
>>       hwaddr size_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].size;
>> @@ -689,7 +697,7 @@ static void create_pcie(SBSAMachineState *sms)
>>   
>>       pci_create_simple(pci->bus, -1, "bochs-display");
>>   
>> -    create_smmu(sms, pci->bus);
>> +    create_smmu(sms, pci->bus, sysmem, secure_sysmem);
>>   }
>>   
>>   static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size)
>> @@ -825,7 +833,7 @@ static void sbsa_ref_init(MachineState *machine)
>>   
>>       create_xhci(sms);
>>   
>> -    create_pcie(sms);
>> +    create_pcie(sms, sysmem, secure_sysmem);
>>   
>>       create_secure_ec(secure_sysmem);
>>   
>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>> index 62a76121841..9a67ce857fe 100644
>> --- a/hw/arm/smmu-common.c
>> +++ b/hw/arm/smmu-common.c
>> @@ -944,6 +944,13 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>>           return;
>>       }
>>   
>> +    g_assert(s->memory);
>> +    address_space_init(&s->memory_as, s->memory, "smmu-memory-view");
>> +    if (s->secure_memory) {
>> +        address_space_init(&s->secure_memory_as, s->secure_memory,
>> +                           "smmu-secure-memory-view");
>> +    }
>> +
>>       /*
>>        * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
>>        * root complexes to be associated with SMMU.
>> @@ -1008,10 +1015,28 @@ static void smmu_base_class_init(ObjectClass *klass, const void *data)
>>       rc->phases.exit = smmu_base_reset_exit;
>>   }
>>   
>> +static void smmu_base_instance_init(Object *obj)
>> +{
>> +    SMMUState *s = ARM_SMMU(obj);
>> +
>> +    object_property_add_link(obj, "memory",
>> +                             TYPE_MEMORY_REGION,
>> +                             (Object **)&s->memory,
>> +                             qdev_prop_allow_set_link_before_realize,
>> +                             OBJ_PROP_LINK_STRONG);
>> +
>> +    object_property_add_link(obj, "secure-memory",
>> +                             TYPE_MEMORY_REGION,
>> +                             (Object **)&s->secure_memory,
>> +                             qdev_prop_allow_set_link_before_realize,
>> +                             OBJ_PROP_LINK_STRONG);
>> +}
>> +
>>   static const TypeInfo smmu_base_info = {
>>       .name          = TYPE_ARM_SMMU,
>>       .parent        = TYPE_SYS_BUS_DEVICE,
>>       .instance_size = sizeof(SMMUState),
>> +    .instance_init = smmu_base_instance_init,
>>       .class_data    = NULL,
>>       .class_size    = sizeof(SMMUBaseClass),
>>       .class_init    = smmu_base_class_init,
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 25fb2bab568..603f4b6a1d7 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -1514,8 +1514,7 @@ static void create_smmuv3_dev_dtb(VirtMachineState *vms,
>>                              0x0, vms->iommu_phandle, 0x0, 0x10000);
>>   }
>>   
>> -static void create_smmu(const VirtMachineState *vms,
>> -                        PCIBus *bus)
>> +static void create_smmu(const VirtMachineState *vms, PCIBus *bus)
>>   {
>>       VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>>       int irq =  vms->irqmap[VIRT_SMMU];
>> @@ -1535,6 +1534,10 @@ static void create_smmu(const VirtMachineState *vms,
>>       }
>>       object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
>>                                &error_abort);
>> +    object_property_set_link(OBJECT(dev), "memory", OBJECT(vms->sysmem),
>> +                             &error_abort);
>> +    object_property_set_link(OBJECT(dev), "secure-memory", OBJECT(vms->secure_sysmem),
>> +                             &error_abort);
>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>>       for (i = 0; i < NUM_SMMU_IRQS; i++) {
>> @@ -1609,6 +1612,7 @@ static void create_pcie(VirtMachineState *vms)
>>       memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
>>                                ecam_reg, 0, size_ecam);
>>       memory_region_add_subregion(get_system_memory(), base_ecam, ecam_alias);
>> +    vms->sysmem = get_system_memory();
>>   
>>       /* Map the MMIO window into system address space so as to expose
>>        * the section of PCI MMIO space which starts at the same base address
>> @@ -2256,6 +2260,7 @@ static void machvirt_init(MachineState *machine)
>>            * devices go in at higher priority and take precedence.
>>            */
>>           secure_sysmem = g_new(MemoryRegion, 1);
>> +        vms->secure_sysmem = secure_sysmem;
>>           memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
>>                              UINT64_MAX);
>>           memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
>> @@ -3051,6 +3056,10 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>>           } else if (vms->iommu == VIRT_IOMMU_NONE) {
>>               /* The new SMMUv3 device is specific to the PCI bus */
>>               object_property_set_bool(OBJECT(dev), "smmu_per_bus", true, NULL);
>> +            object_property_set_link(OBJECT(dev), "memory",
>> +                                     OBJECT(vms->sysmem), NULL);
>> +            object_property_set_link(OBJECT(dev), "secure-memory",
>> +                                     OBJECT(vms->secure_sysmem), NULL);
>>           }
>>       }
>>   }
> 


