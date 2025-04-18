Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C67DC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 20:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5sQb-0006Os-SR; Fri, 18 Apr 2025 16:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1u5sQZ-0006NI-5Z
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 16:35:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1u5sQW-0006sZ-6G
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 16:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745008507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJnY3gqdMxXaWcJ+S7r4EWTj/9mQDOVVIQ05PmRBz0U=;
 b=SIpwDavWkkmVPJkmT0I6CkaAqczpvcdWD237Ux4tcgAQNhTTGJIjISImGmzYmE79BmepBA
 R/ZYH9HxunyWyR7RDMpwiivRmCKjEm05iIEY7Mbim7i8NOeSOVC4zx73rlTQFyG2cX3XxG
 PRKgx7wkciQFBtQbs7JqYSMVgMAM9EU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-GLyQAL-QOHG_oqmw82b_dA-1; Fri, 18 Apr 2025 16:35:04 -0400
X-MC-Unique: GLyQAL-QOHG_oqmw82b_dA-1
X-Mimecast-MFC-AGG-ID: GLyQAL-QOHG_oqmw82b_dA_1745008503
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-476623ba226so36338551cf.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 13:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745008503; x=1745613303;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RJnY3gqdMxXaWcJ+S7r4EWTj/9mQDOVVIQ05PmRBz0U=;
 b=EkQ5o9iqPszqhdCPhJEqGiKhJ3XIIYh6NE84YifbulHToCmWu0q+8mCUWydPOtt+l4
 8HO8LKNipxk0fpDLGWnOJ7apF7+SFz6oJrskP4Ni6WbQJIh4U6Mb57yM715OFkeJPW6n
 EdSv/anhc7cpBYfE8euGh9V+YSYn3NVDgn2YeanG24HyY5DUins9vFvPurI9SUFIH2Um
 22bFQuW8gWl4D4YdfeZsnl5Fa8Ddlq6jhv98Jmxt+OLmNJdh5hdZIuyBo8Zt3fY+VvUV
 zzJddGqILvNRsfyomwFLo4zAtyLCJ5GUE3+FTByWSrvxREmTnu4GLjrayp6eTtPYrraE
 br7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3TTD3Wbi6a73CreGTvCFG4hyHryOKDbZ3Qt22GiiF1qpKergdcHCrYplZcCPxlAKpUVvVaH0C5ONp@nongnu.org
X-Gm-Message-State: AOJu0Yy7oECyePOBiqqifPLNcUJKybeTrUkxUpYcC5bCkdjrTHVadfaJ
 hoEKzmGub/YNZ5NF7UDxeaXA8zhCEMK6LGWmmPv+WNBN34n4LuJhJRP4w3Jw+0h8KQNjdHSbgHE
 hmpzo9MT9SNV25EP8aupZ1FT2QjBcyVVgN0xHMdJ4UHILMNLzDAXL
X-Gm-Gg: ASbGncs6ikE/8tebAq478hzqPFi5U5k1KjsduskiYkLrKYbHB+Kc8Xdewe6WKlGpc6a
 LrpKdh58iwUUNlqLBd5KAYyQcvpqdTMHCpNZ0el66gMTKBqRmQOYvLlY7o3V6Fjdu9lelSA4/3W
 jgr+C3cAUQWT0F5MjMO2/yVqik05x+c8GM7VHHDf8py/QAXTiyezDsXd5FDHzwWw6tKlC95fX3j
 qYbsjcO/dDLPGeqNZQRzLXjCe4n61O1TdifcjZPu35LzoBFgDH6IduldhpvN7VXnEoIjScjN9A7
 BbsNvW67ZXlR
X-Received: by 2002:a05:622a:13d0:b0:47a:e803:d7f with SMTP id
 d75a77b69052e-47aec35b765mr70018121cf.4.1745008503673; 
 Fri, 18 Apr 2025 13:35:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGp4HU759glOD+FcS0DtXb5ju+pImrN/puHMR9IdJhz4fTz4APjrcR3qYzsfOWFMWgyRQVviA==
X-Received: by 2002:a05:622a:13d0:b0:47a:e803:d7f with SMTP id
 d75a77b69052e-47aec35b765mr70017841cf.4.1745008503352; 
 Fri, 18 Apr 2025 13:35:03 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47ae9c188a8sm14007101cf.8.2025.04.18.13.35.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 13:35:02 -0700 (PDT)
Message-ID: <317515f1-6cc2-4768-9a5e-8dd5dece9079@redhat.com>
Date: Fri, 18 Apr 2025 16:34:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hw/arm/virt-acpi-build: Update IORT for multiple
 smmuv3 devices
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250415081104.71708-1-shameerali.kolothum.thodi@huawei.com>
 <20250415081104.71708-3-shameerali.kolothum.thodi@huawei.com>
 <Z/8vzf/q24sZOdBG@Asurada-Nvidia>
 <8a76f317aa3048bfb7262b670629f43b@huawei.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <8a76f317aa3048bfb7262b670629f43b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/16/25 1:38 AM, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> Sent: Wednesday, April 16, 2025 5:19 AM
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
>> eric.auger@redhat.com; peter.maydell@linaro.org; jgg@nvidia.com;
>> ddutile@redhat.com; berrange@redhat.com; nathanc@nvidia.com;
>> mochs@nvidia.com; smostafa@google.com; Linuxarm
>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
>> Subject: Re: [PATCH 2/5] hw/arm/virt-acpi-build: Update IORT for multiple
>> smmuv3 devices
>>
>> On Tue, Apr 15, 2025 at 09:11:01AM +0100, Shameer Kolothum wrote:
>>> +static int get_smmuv3_device(Object *obj, void *opaque)
>>> +{
>>> +    GArray *sdev_blob = opaque;
>>> +    int min_bus, max_bus;
>>> +    VirtMachineState *vms;
>>> +    PlatformBusDevice *pbus;
>>> +    SysBusDevice *sbdev;
>>> +    SMMUv3Device sdev;
>>> +    hwaddr base;
>>> +    int irq;
>>> +    PCIBus *bus;
>>
>> In a reverse christmas tree order? Or we could at least group
>> those similar types together.
> 
> Yeah. Reverse will look better I guess.
>>
>>> +    vms = VIRT_MACHINE(qdev_get_machine());
>>> +    pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
>>> +    sbdev = SYS_BUS_DEVICE(obj);
>>> +    base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
>>> +    irq = platform_bus_get_irqn(pbus, sbdev, 0);
>>> +
>>> +    base += vms->memmap[VIRT_PLATFORM_BUS].base;
>>> +    irq += vms->irqmap[VIRT_PLATFORM_BUS];
>>> +
>>> +    pci_bus_range(bus, &min_bus, &max_bus);
>>> +    sdev.smmu_idmap.input_base = min_bus << 8;
>>> +    sdev.smmu_idmap.id_count = (max_bus - min_bus + 1) << 8;
>>> +    sdev.base = base;
>>> +    sdev.irq = irq + ARM_SPI_BASE;
>>
>> Hmm, these base/irq local variables don't look necessary.
>>
>>> +    g_array_append_val(sdev_blob, sdev);
>>> +    return 0;
>>> +}
>>> +
>>>   /*
>>>    * Input Output Remapping Table (IORT)
>>>    * Conforms to "IO Remapping Table System Software on ARM
>> Platforms",
>>> @@ -275,25 +330,42 @@ static void
>>>   build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState
>> *vms)
>>>   {
>>>       int i, nb_nodes, rc_mapping_count;
>>> -    size_t node_size, smmu_offset = 0;
>>> +    size_t node_size, *smmu_offset = NULL;
>>>       AcpiIortIdMapping *idmap;
>>> +    int num_smmus = 0;
>>>       uint32_t id = 0;
>>>       GArray *smmu_idmaps = g_array_new(false, true,
>> sizeof(AcpiIortIdMapping));
>>>       GArray *its_idmaps = g_array_new(false, true,
>> sizeof(AcpiIortIdMapping));
>>> +    GArray *smmuv3_devices = g_array_new(false, true,
>> sizeof(SMMUv3Device));
>>>
>>>       AcpiTable table = { .sig = "IORT", .rev = 3, .oem_id = vms->oem_id,
>>>                           .oem_table_id = vms->oem_table_id };
>>>       /* Table 2 The IORT */
>>>       acpi_table_begin(&table, table_data);
>>>
>>> -    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
>>> -        AcpiIortIdMapping next_range = {0};
>>> -
>>> +    nb_nodes = 2; /* RC, ITS */
>>> +    if (vms->iommu == VIRT_IOMMU_SMMUV3_DEV) {
>>> +        object_child_foreach_recursive(object_get_root(),
>>> +                                       get_smmuv3_device, smmuv3_devices);
>>> +         /* Sort the smmuv3-devices by smmu idmap input_base */
>>> +        g_array_sort(smmuv3_devices, smmuv3_dev_idmap_compare);
>>> +        /*  Fill smmu idmap from sorted smmuv3 devices array */
>>> +        for (i = 0; i < smmuv3_devices->len; i++) {
>>> +            SMMUv3Device *s = &g_array_index(smmuv3_devices,
>> SMMUv3Device, i);
>>> +            g_array_append_val(smmu_idmaps, s->smmu_idmap);
>>> +        }
>>> +        num_smmus = smmuv3_devices->len;
>>> +    } else if (vms->iommu == VIRT_IOMMU_SMMUV3) {
>>>           object_child_foreach_recursive(object_get_root(),
>>>                                          iort_host_bridges, smmu_idmaps);
>>>
>>>           /* Sort the smmu idmap by input_base */
>>>           g_array_sort(smmu_idmaps, iort_idmap_compare);
>>
>> VIRT_IOMMU_SMMUV3 seems to fit the struct SMMUv3Device very well,
>> given that it has base, irq, and smmu_idmaps too?
> 
> One difference though is the legacy VIRT_IOMMU_SMMUV3 one is a global
> Machine wide one nad can be associated with multiple PCIe root complexes
> which will result in smmu_idmaps array. See the iort_host_bridges() fn.
> 
Didn't quite follow this logic; shouldn't the iort be built for devices
tagged for a virt-iommu or dependent on a pcie rp (bus num/bus-num range of an RP)?
Thus, it's just an IORT with one or more IORT nodes?
I could see how the current iort_host_bridge() may need a revision to work with -device arm-smmu configs.

Which would bring me back to my earlier question, and it's likely tied to this IORT construction:
  -- can you have both types defined in a machine model?


>>
>> Maybe we could generalize the struct SMMUv3Device to store both
>> cases. Perhaps just SMMUv3AcpiInfo? And then ..
> 
I didn't follow 'SMMUv3AcpiInfo' since I don't see that in current qemu tree;
or is the statement trying to say its a 'mere matter of the proper acpi info generation'?

> Could do. But then you have to have  a smmu_idmaps array and then check
> the length of it to cover legacy SMMUv3 case I guess.
> 
Aren't they going to be different idmaps for different IORT nodes?

>   > > @@ -341,10 +413,20 @@ build_iort(GArray *table_data, BIOSLinker
>> *linker, VirtMachineState *vms)
>>>       /* GIC ITS Identifier Array */
>>>       build_append_int_noprefix(table_data, 0 /* MADT translation_id */,
>> 4);
>>>
>>> -    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
>>> -        int irq =  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
>>> +    for (i = 0; i < num_smmus; i++) {
>>> +        hwaddr base;
>>> +        int irq;
>>> +
>>> +        if (vms->iommu == VIRT_IOMMU_SMMUV3_DEV) {
>>> +            SMMUv3Device *s = &g_array_index(smmuv3_devices,
>> SMMUv3Device, i);
>>> +            base = s->base;
>>> +            irq = s->irq;
>>> +        } else {
>>> +            base = vms->memmap[VIRT_SMMU].base;
>>> +            irq = vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
>>> +        }
>>
>> .. we wouldn't need two paths here.
>>
>>> @@ -404,15 +486,26 @@ build_iort(GArray *table_data, BIOSLinker
>> *linker, VirtMachineState *vms)
>>>       build_append_int_noprefix(table_data, 0, 3); /* Reserved */
>>>
>>>       /* Output Reference */
>>> -    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
>>> +    if (num_smmus) {
>>>           AcpiIortIdMapping *range;
>>>
>>>           /* translated RIDs connect to SMMUv3 node: RC -> SMMUv3 -> ITS
>> */
>>>           for (i = 0; i < smmu_idmaps->len; i++) {
>>> +            size_t offset;
>>> +            if (vms->iommu == VIRT_IOMMU_SMMUV3_DEV) {
>>> +                offset = smmu_offset[i];
>>> +            } else {
>>> +                /*
>>> +                 * For legacy VIRT_IOMMU_SMMUV3 case, one machine wide
>>> +                 * smmuv3 may have multiple smmu_idmaps.
>>> +                 */
>>> +                offset = smmu_offset[0];
>>> +            }
>>
>> And I think we can eliminate this too if we stuff an smmu_offset
>> in struct AcpiIortIdMapping ..
>>
>>>               range = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
>>>               /* output IORT node is the smmuv3 node */
>>>               build_iort_id_mapping(table_data, range->input_base,
>>> -                                  range->id_count, smmu_offset);
>>> +                                  range->id_count, offset);
>>
>> ... and here it would be range->offset.
> 
> I will give it a try and if that simplifies things will include it in next respin.
> 
> Thanks,
> Shameer
> 


