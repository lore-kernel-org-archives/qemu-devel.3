Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CE9C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 18:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txVHX-0006kG-0t; Wed, 26 Mar 2025 14:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1txVH6-0006fJ-0u
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 14:14:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1txVH0-0000s9-OM
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 14:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743012880;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ybwIXtzCkKHm5WIbRxVEJixLP3bhT/+Zj9fD/Gd9SRo=;
 b=M4mzqMm8xeGxSnNqWIiSurjktKJHswrlkRBAUauiJt9k7amIMxxFpznfTzB44aulbMQA3j
 v5xTA3wZmHanEl37HntuNkMa0uUgIfNekI7P3T99ZdxR2qOgDGHyzSjzXc0cA9nU+avVsZ
 h58CYrgEJz+bbOIsJWjsysutkT4sGQo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-mqXX02E4Mha2MjfmojkhtA-1; Wed, 26 Mar 2025 14:14:38 -0400
X-MC-Unique: mqXX02E4Mha2MjfmojkhtA-1
X-Mimecast-MFC-AGG-ID: mqXX02E4Mha2MjfmojkhtA_1743012877
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43941ad86d4so782075e9.2
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 11:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743012874; x=1743617674;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ybwIXtzCkKHm5WIbRxVEJixLP3bhT/+Zj9fD/Gd9SRo=;
 b=tNZyfz1SSfdxP4h1sOeeKgWHvK4dqGbjVuSHwg39fSxaJBIO1Y9K8AF/kzQ/ULVuVr
 +7OEYZ25tMU3NmmX/ag5qrRogrG/Hi2G9u22zITbCGYZtBYIMKHc6uOVjs4Tna75QfUx
 +l6TbNKJUKKSAfoGAqB8jtjo1dKM9RF54pvfGSSmPpHVcK6tpRYIqjPBiHsGiAiK4US0
 VuxtAXC6VWCeRHu+UBmOpsKz6Epi0xQunghkWhr5h8cXFUyfHsMn0u4mbMyuUhzlfI49
 sycXQWSFLwbspatnXMLcLoToqFniZaXTZ0ydjO+LKgoPnPz3yxeL0aiqFd3e9z7iPtTW
 xD8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAqv878vYmKvd4qkgjUGiI8GfGJ2AcMTpDE2Mqmb7JjUjl5dgEym8gmRtZRz1p5N6WDX8j+y+co4M0@nongnu.org
X-Gm-Message-State: AOJu0YxOkNA5tpofTvUZR0ScuTr/N9fzrrSj+XNNovRVS1W+FXHZeNu4
 MMo5NgR7SgvC21LjiSGYQ9Sggq8zQZpNT8lz7xP0mvNV9xSJU3vUW0sMSpE/F4BlmoC2MxN2qJB
 FP0+r9dj3ugHAmnWg6TTukYpdtrh4dJs5FeqDY/bkZqlLMdlqpg1d
X-Gm-Gg: ASbGncvWb/CviMxqT8sPI4bCRgbK0eFGDMlHiKmAszNwpYcnYRlwyYo6lPB8bSo6eeb
 IXgxLE5lcqDNMQPYdGk6WrdsQAqHw6ZEaq9AGxlWZbnvVCY6c9YDAilyKAZkq/9HGdWx8siBLK/
 9kFNiKb9dFSNcB/3GZRxId7q//2cYcq9TwYxlZ1i8nhw1y7WIxqt+J21Sqk1k7p03IoAhkiuHdN
 GPsXUBZfnEVdZ41neZAdG791h/UDfouVlj5ZwK9GNxhJojSm5UCm4ufwqaGqQg7V6ukPITZ8e4u
 FBT0uUkpdm50at3CpQaUc+Xznt8afb/1SBLn4I34zjVUx7PF/dHVTgtW8aptgSw=
X-Received: by 2002:a05:600c:a02:b0:43d:42b:e186 with SMTP id
 5b1f17b1804b1-43d84f8b84amr4231965e9.8.1743012874031; 
 Wed, 26 Mar 2025 11:14:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnH/6vAgXXcJno5vM8n2tDEDDYEEWfEaRg4aaTTe6xagtsdy2J7Cc+O07g8sQsKHmAOHvmbA==
X-Received: by 2002:a05:600c:a02:b0:43d:42b:e186 with SMTP id
 5b1f17b1804b1-43d84f8b84amr4231585e9.8.1743012873493; 
 Wed, 26 Mar 2025 11:14:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82a041dfsm11349035e9.0.2025.03.26.11.14.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 11:14:32 -0700 (PDT)
Message-ID: <1b03e73c-f50b-4be6-b5a5-58f3e80f9161@redhat.com>
Date: Wed, 26 Mar 2025 19:14:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 19/20] hw/arm/virt-acpi-build: Update IORT with
 multiple smmuv3-accel nodes
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-20-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250311141045.66620-20-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> Now that we can have multiple user-creatable smmuv3-accel devices,
> each associated with different pci buses, update IORT ID mappings
> accordingly.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/virt-acpi-build.c | 113 +++++++++++++++++++++++++++++++++------
>  1 file changed, 97 insertions(+), 16 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 3ac8f8e178..c232850e36 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -43,6 +43,7 @@
>  #include "hw/acpi/generic_event_device.h"
>  #include "hw/acpi/tpm.h"
>  #include "hw/acpi/hmat.h"
> +#include "hw/arm/smmuv3-accel.h"
>  #include "hw/pci/pcie_host.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_bus.h"
> @@ -233,6 +234,51 @@ struct AcpiIortIdMapping {
>  };
>  typedef struct AcpiIortIdMapping AcpiIortIdMapping;
>  
> +struct SMMUv3Accel {
> +    int irq;
> +    hwaddr base;
> +    AcpiIortIdMapping smmu_idmap;
> +};
> +typedef struct SMMUv3Accel SMMUv3Accel;
> +
> +static int smmuv3_accel_idmap_compare(gconstpointer a, gconstpointer b)
> +{
> +    SMMUv3Accel *accel_a = (SMMUv3Accel *)a;
> +    SMMUv3Accel *accel_b = (SMMUv3Accel *)b;
> +
> +    return accel_a->smmu_idmap.input_base - accel_b->smmu_idmap.input_base;
> +}
> +
> +static int get_smmuv3_accel(Object *obj, void *opaque)
> +{
> +    GArray *s_accel_blob = opaque;
> +
> +    if (object_dynamic_cast(obj, TYPE_ARM_SMMUV3_ACCEL)) {
> +        PCIBus *bus = (PCIBus *) object_property_get_link(obj, "primary-bus",
> +                                                          &error_abort);
> +        if (bus && !pci_bus_bypass_iommu(bus)) {
> +            SMMUv3Accel accel;
> +            int min_bus, max_bus;
> +            VirtMachineState *v = VIRT_MACHINE(qdev_get_machine());
> +            PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(v->platform_bus_dev);
> +            SysBusDevice *sbdev = SYS_BUS_DEVICE(obj);
> +            hwaddr base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> +            int irq = platform_bus_get_irqn(pbus, sbdev, 0);
> +
> +            base += v->memmap[VIRT_PLATFORM_BUS].base;
> +            irq += v->irqmap[VIRT_PLATFORM_BUS];
> +
> +            pci_bus_range(bus, &min_bus, &max_bus);
> +            accel.smmu_idmap.input_base = min_bus << 8;
> +            accel.smmu_idmap.id_count = (max_bus - min_bus + 1) << 8;
> +            accel.base = base;
> +            accel.irq = irq + ARM_SPI_BASE;
> +            g_array_append_val(s_accel_blob, accel);
> +        }
> +    }
> +    return 0;
> +}
> +
>  /* Build the iort ID mapping to SMMUv3 for a given PCI host bridge */
>  static int
>  iort_host_bridges(Object *obj, void *opaque)
> @@ -275,30 +321,51 @@ static void
>  build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  {
>      int i, nb_nodes, rc_mapping_count;
> -    size_t node_size, smmu_offset = 0;
> +    size_t node_size, *smmu_offset = NULL;
>      AcpiIortIdMapping *idmap;
> +    SMMUv3Accel *accel;
> +    int num_smmus = 0;
>      uint32_t id = 0;
>      GArray *smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
>      GArray *its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
> +    GArray *smmuv3_accel = g_array_new(false, true, sizeof(SMMUv3Accel));
>  
>      AcpiTable table = { .sig = "IORT", .rev = 3, .oem_id = vms->oem_id,
>                          .oem_table_id = vms->oem_table_id };
>      /* Table 2 The IORT */
>      acpi_table_begin(&table, table_data);
>  
> -    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
> -        AcpiIortIdMapping next_range = {0};
> -
> +    nb_nodes = 2; /* RC, ITS */
> +    if (vms->iommu == VIRT_IOMMU_SMMUV3_ACCEL) {
> +        object_child_foreach_recursive(object_get_root(),
> +                                       get_smmuv3_accel, smmuv3_accel);
> +        /* Sort the smmuv3-accel by smmu idmap input_base */
> +        g_array_sort(smmuv3_accel, smmuv3_accel_idmap_compare);
> +
> +        /*  Fill smmu idmap from sorted accel array */
> +        for (i = 0; i < smmuv3_accel->len; i++) {
> +            accel = &g_array_index(smmuv3_accel, SMMUv3Accel, i);
> +            g_array_append_val(smmu_idmaps, accel->smmu_idmap);
> +        }
> +        num_smmus = smmuv3_accel->len;
> +    } else if (vms->iommu == VIRT_IOMMU_SMMUV3) {
>          object_child_foreach_recursive(object_get_root(),
>                                         iort_host_bridges, smmu_idmaps);
>  
>          /* Sort the smmu idmap by input_base */
>          g_array_sort(smmu_idmaps, iort_idmap_compare);
> +        num_smmus = 1;
> +    }
>  
> -        /*
> -         * Split the whole RIDs by mapping from RC to SMMU,
> -         * build the ID mapping from RC to ITS directly.
> -         */
> +    /*
> +     * Split the whole RIDs by mapping from RC to SMMU,
> +     * build the ID mapping from RC to ITS directly.
> +     */
> +    if (num_smmus) {
> +        AcpiIortIdMapping next_range = {0};
> +
> +        smmu_offset = g_new0(size_t, num_smmus);
> +        nb_nodes += num_smmus;
>          for (i = 0; i < smmu_idmaps->len; i++) {
>              idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
>  
> @@ -316,10 +383,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>              g_array_append_val(its_idmaps, next_range);
>          }
>  
> -        nb_nodes = 3; /* RC, ITS, SMMUv3 */
>          rc_mapping_count = smmu_idmaps->len + its_idmaps->len;
>      } else {
> -        nb_nodes = 2; /* RC, ITS */
>          rc_mapping_count = 1;
>      }
>      /* Number of IORT Nodes */
> @@ -341,10 +406,19 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      /* GIC ITS Identifier Array */
>      build_append_int_noprefix(table_data, 0 /* MADT translation_id */, 4);
>  
> -    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
> -        int irq =  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
> +    for (i = 0; i < num_smmus; i++) {
> +        hwaddr base;
> +        int irq;
> +        if (vms->iommu == VIRT_IOMMU_SMMUV3_ACCEL) {
> +            accel = &g_array_index(smmuv3_accel, SMMUv3Accel, i);
> +            base = accel->base;
> +            irq = accel->irq;
> +        } else {
> +            base = vms->memmap[VIRT_SMMU].base;
> +            irq = vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
> +        }
>  
> -        smmu_offset = table_data->len - table.table_offset;
> +        smmu_offset[i] = table_data->len - table.table_offset;
>          /* Table 9 SMMUv3 Format */
>          build_append_int_noprefix(table_data, 4 /* SMMUv3 */, 1); /* Type */
>          node_size =  SMMU_V3_ENTRY_SIZE + ID_MAPPING_ENTRY_SIZE;
> @@ -355,7 +429,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          /* Reference to ID Array */
>          build_append_int_noprefix(table_data, SMMU_V3_ENTRY_SIZE, 4);
>          /* Base address */
> -        build_append_int_noprefix(table_data, vms->memmap[VIRT_SMMU].base, 8);
> +        build_append_int_noprefix(table_data, base, 8);
>          /* Flags */
>          build_append_int_noprefix(table_data, 1 /* COHACC Override */, 4);
>          build_append_int_noprefix(table_data, 0, 4); /* Reserved */
> @@ -404,15 +478,22 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      build_append_int_noprefix(table_data, 0, 3); /* Reserved */
>  
>      /* Output Reference */
> -    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
> +    if (num_smmus) {
>          AcpiIortIdMapping *range;
> +        size_t offset;
>  
>          /* translated RIDs connect to SMMUv3 node: RC -> SMMUv3 -> ITS */
>          for (i = 0; i < smmu_idmaps->len; i++) {
> +            if (vms->iommu == VIRT_IOMMU_SMMUV3_ACCEL) {
> +                offset = smmu_offset[i];
> +            } else {
> +                offset = smmu_offset[0];
maybe we can also use smmu_offset array for non accel mode and get rid
of this.

Nevertheless it looks pretty good to me already.

Eric
> +            }
> +
>              range = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
>              /* output IORT node is the smmuv3 node */
>              build_iort_id_mapping(table_data, range->input_base,
> -                                  range->id_count, smmu_offset);
> +                                  range->id_count, offset);
>          }
>  
>          /* bypassed RIDs connect to ITS group node directly: RC -> ITS */


