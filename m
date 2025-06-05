Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10959C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 09:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN74b-0000xn-0K; Thu, 05 Jun 2025 05:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uN74X-0000wx-Ee
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:39:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uN74T-00066i-PM
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749116376;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NNc10oa4HDAejizmpkusYadxkjVid0FD1Qzlu73P6dE=;
 b=VvnyeZlPs4+ihlxEsc/9ePKpf1JB0SsJfdaXSVEnxSbJu9quA7+B5Stg6ZuWwlpTfvN5Ia
 kPtiqCgvAVW1So0S/5hlzEO2dPQSJR1/HerBcnbIVGo1J5noknDA2FYSg0wyShGHLExuuF
 KWwNvzLgiIF2E4rGGuUfYikyFkLLnJo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-6D2_Kv7ONNuNpvF4AhW2Mw-1; Thu, 05 Jun 2025 05:39:34 -0400
X-MC-Unique: 6D2_Kv7ONNuNpvF4AhW2Mw-1
X-Mimecast-MFC-AGG-ID: 6D2_Kv7ONNuNpvF4AhW2Mw_1749116373
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4fac7fa27so345749f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 02:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749116373; x=1749721173;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NNc10oa4HDAejizmpkusYadxkjVid0FD1Qzlu73P6dE=;
 b=qib0t7RQDbrlGVvq2grcSDUHmgDybkzq0N0u2R3zcVcTQJ629KMLd/mYux8d2WuGbf
 6Gtu0Q/UTmcB9/JwAvoz4uXCYSlloBcHjNrQAhzKZR7UkFrL3djmrSItZ+DChcC5F8tg
 fIPqOBOHUDG1RX8qLsXQgWX49nC3BUNOUTof6kz4MSDayvX5wi7bcW7c+2vGNNRsZvc3
 h7hEDy+OdjicgdHBo1qlHOCsdCa30yK1epJBOvAz5/YArannNQrWZQ+MJSB7NT7DgDAt
 4Ho5gnF/RuPAq0XItrjko+WHgbEtKSavLaWKunfwMJbLACKgzJPEfshndAnI3qEhOf8v
 ofGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTO87vfubGzWQcY2rxOGilsCdZP79BHZGnCMupflOSlRtsXLCVVludNQqFra27cybBObJismg/Z8Xw@nongnu.org
X-Gm-Message-State: AOJu0Ywu8qzrb7MKCUr6i81vBClu7TB+EBWLuWXUNfYYfdJ2c/AFheLX
 PPrFOFxfl/xcTE3OZjv9Z2G8I2fdDl/pej7xNC027GWySMRBYZi6PactT0UDrqD7CgxXvQL1/oS
 KQAn8ccmdEkGGB5TDC7gW8lidtXZLc/0uEk+Py+eoUGL8Cjx8nTYBauwY
X-Gm-Gg: ASbGncsEBRcO6IQHZoToTPTV3yP7xV9BmGQk7XYQ/SCEX1rbBYtgsejOfSqCmvjD8dQ
 4Q8IfRnXCgjU8eYn/SO92HKwuZIWlyJe0KZNd860l4jtVliRkWUwdt+9WhwwawylSDIQiUxZxJF
 7hUijjDNqNCpF5K/dfJud95wdKFucd31rdCukL6zHZLOEQ4xw3hN5ukLQRCGp5BAFv58aF+s3qX
 KP0qAW2YSkwb+ul/uTll064Ze0fymspEwNH/zsEzbdqsoGQis9sr6U33Mdfuk8XCop3mxkZ0eKR
 safyN66kg86KjSec0m0mgqBLOGe3GcBL4hRXlIs3579fo3S4nVgT4BCk1BM=
X-Received: by 2002:a05:6000:2085:b0:3a4:dfaa:df8d with SMTP id
 ffacd0b85a97d-3a51d8f9fa2mr5281811f8f.9.1749116373195; 
 Thu, 05 Jun 2025 02:39:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ+QnEGXSGr8xoejBm5RJogSB+e28XrqfrykjZ0/U4yVQU7CYRsVlRCZ5JGNSMqkoPM2wVAg==
X-Received: by 2002:a05:6000:2085:b0:3a4:dfaa:df8d with SMTP id
 ffacd0b85a97d-3a51d8f9fa2mr5281772f8f.9.1749116372726; 
 Thu, 05 Jun 2025 02:39:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b871sm24388642f8f.13.2025.06.05.02.39.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 02:39:31 -0700 (PDT)
Message-ID: <5a08ba9d-4a47-49d1-9390-c19539a97939@redhat.com>
Date: Thu, 5 Jun 2025 11:39:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] hw/arm/virt-acpi-build: Re-arrange SMMUv3 IORT
 build
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250602154110.48392-1-shameerali.kolothum.thodi@huawei.com>
 <20250602154110.48392-3-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250602154110.48392-3-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Shameer,

On 6/2/25 5:41 PM, Shameer Kolothum wrote:
> Introduces a new struct AcpiIortSMMUv3Dev to hold all the information
> required for SMMUv3 IORT node and use that for populating the node.
>
> The current machine wide SMMUv3 is named as legacy SMMUv3 as we will
> soon add support for user-creatable SMMUv3 devices. These changes will
> be useful to have common code paths when we add that support.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/virt-acpi-build.c | 112 +++++++++++++++++++++++++++------------
>  hw/arm/virt.c            |   1 +
>  include/hw/arm/virt.h    |   1 +
>  3 files changed, 80 insertions(+), 34 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 7e8e0f0298..bd26853ef6 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -266,6 +266,28 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
>      return idmap_a->input_base - idmap_b->input_base;
>  }
>  
> +struct AcpiIortSMMUv3Dev {
> +    int irq;
> +    hwaddr base;
> +    GArray *idmaps;
> +    size_t offset;
I would suggest to comment at least the offset field which is not obvious
> +};
> +typedef struct AcpiIortSMMUv3Dev AcpiIortSMMUv3Dev;
> +
> +static void
> +get_smmuv3_legacy_dev(VirtMachineState *vms, void *opaque)
> +{
> +    GArray *sdev_blob = opaque;
I don't get why we use an opaque pointer here.
> +    AcpiIortSMMUv3Dev sdev;
> +
> +    sdev.idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
> +    object_child_foreach_recursive(object_get_root(),
> +                                   iort_host_bridges, sdev.idmaps);
> +    sdev.base = vms->memmap[VIRT_SMMU].base;
> +    sdev.irq = vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
> +    g_array_append_val(sdev_blob, sdev);
So if I understand correctly this helper populate an AcpiIortSMMUv3Dev
object with the legacy iommu info and add it in the array of
AcpiIortSMMUv3Dev. The name of the helper does not really reflect what
it does and generally get is associated with a put. I would suggest to
rename. I see that afterwards you call

sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, 0);
to retrieve the first element and then sort the ipmap array.

Why can't you do all that stuff in the helper?

> +}
> +
>  /*
>   * Input Output Remapping Table (IORT)
>   * Conforms to "IO Remapping Table System Software on ARM Platforms",
> @@ -274,11 +296,12 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
>  static void
>  build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  {
> -    int i, nb_nodes, rc_mapping_count;
> -    size_t node_size, smmu_offset = 0;
> -    AcpiIortIdMapping *idmap;
> +    int i, j, nb_nodes, rc_mapping_count;
> +    AcpiIortSMMUv3Dev *sdev;
> +    size_t node_size;
> +    int num_smmus = 0;
>      uint32_t id = 0;
> -    GArray *smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
> +    GArray *smmuv3_devs = g_array_new(false, true, sizeof(AcpiIortSMMUv3Dev));
>      GArray *its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
>  
>      AcpiTable table = { .sig = "IORT", .rev = 3, .oem_id = vms->oem_id,
> @@ -286,28 +309,41 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      /* Table 2 The IORT */
>      acpi_table_begin(&table, table_data);
>  
> -    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
> -        AcpiIortIdMapping next_range = {0};
> -
> -        object_child_foreach_recursive(object_get_root(),
> -                                       iort_host_bridges, smmu_idmaps);
> -
> -        /* Sort the smmu idmap by input_base */
> -        g_array_sort(smmu_idmaps, iort_idmap_compare);
> +    nb_nodes = 2; /* RC, ITS */
> +    if (vms->legacy_smmuv3_present) {
> +        get_smmuv3_legacy_dev(vms, smmuv3_devs);
> +        /*
> +         * There will be only one legacy SMMUv3 as it is a machine wide one.
> +         * And since it covers all the PCIe RCs in the machine, may have
> +         * multiple SMMUv3 idmaps. Sort it by input_base.
> +         */
> +        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, 0);
> +        g_array_sort(sdev->idmaps, iort_idmap_compare);
> +    }
>  
> +    num_smmus = smmuv3_devs->len;
> +    if (num_smmus) {
> +        AcpiIortIdMapping next_range = {0};
> +        int smmu_map_cnt = 0;
>          /*
>           * Split the whole RIDs by mapping from RC to SMMU,
>           * build the ID mapping from RC to ITS directly.
>           */
> -        for (i = 0; i < smmu_idmaps->len; i++) {
> -            idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
> -
> -            if (next_range.input_base < idmap->input_base) {
> -                next_range.id_count = idmap->input_base - next_range.input_base;
> -                g_array_append_val(its_idmaps, next_range);
> +        for (i = 0; i < num_smmus; i++) {
> +            AcpiIortIdMapping *idmap;
could belong to the inner block

Otherwise looks good to me

Cheers

Eric
> +            sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
> +
> +            for (j = 0; j < sdev->idmaps->len; j++) {
> +                idmap = &g_array_index(sdev->idmaps, AcpiIortIdMapping, j);
> +
> +                if (next_range.input_base < idmap->input_base) {
> +                    next_range.id_count = idmap->input_base -
> +                                          next_range.input_base;
> +                    g_array_append_val(its_idmaps, next_range);
> +                }
> +                next_range.input_base = idmap->input_base + idmap->id_count;
> +                smmu_map_cnt++;
>              }
> -
> -            next_range.input_base = idmap->input_base + idmap->id_count;
>          }
>  
>          /* Append the last RC -> ITS ID mapping */
> @@ -316,10 +352,9 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>              g_array_append_val(its_idmaps, next_range);
>          }
>  
> -        nb_nodes = 3; /* RC, ITS, SMMUv3 */
> -        rc_mapping_count = smmu_idmaps->len + its_idmaps->len;
> +        nb_nodes += num_smmus;
> +        rc_mapping_count = smmu_map_cnt + its_idmaps->len;
>      } else {
> -        nb_nodes = 2; /* RC, ITS */
>          rc_mapping_count = 1;
>      }
>      /* Number of IORT Nodes */
> @@ -341,10 +376,11 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      /* GIC ITS Identifier Array */
>      build_append_int_noprefix(table_data, 0 /* MADT translation_id */, 4);
>  
> -    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
> -        int irq =  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
> +    for (i = 0; i < num_smmus; i++) {
> +        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
> +        int irq = sdev->irq;
>  
> -        smmu_offset = table_data->len - table.table_offset;
> +        sdev->offset = table_data->len - table.table_offset;
>          /* Table 9 SMMUv3 Format */
>          build_append_int_noprefix(table_data, 4 /* SMMUv3 */, 1); /* Type */
>          node_size =  SMMU_V3_ENTRY_SIZE + ID_MAPPING_ENTRY_SIZE;
> @@ -355,7 +391,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          /* Reference to ID Array */
>          build_append_int_noprefix(table_data, SMMU_V3_ENTRY_SIZE, 4);
>          /* Base address */
> -        build_append_int_noprefix(table_data, vms->memmap[VIRT_SMMU].base, 8);
> +        build_append_int_noprefix(table_data, sdev->base, 8);
>          /* Flags */
>          build_append_int_noprefix(table_data, 1 /* COHACC Override */, 4);
>          build_append_int_noprefix(table_data, 0, 4); /* Reserved */
> @@ -404,15 +440,19 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      build_append_int_noprefix(table_data, 0, 3); /* Reserved */
>  
>      /* Output Reference */
> -    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
> +    if (num_smmus) {
>          AcpiIortIdMapping *range;
>  
>          /* translated RIDs connect to SMMUv3 node: RC -> SMMUv3 -> ITS */
> -        for (i = 0; i < smmu_idmaps->len; i++) {
> -            range = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
> -            /* output IORT node is the smmuv3 node */
> -            build_iort_id_mapping(table_data, range->input_base,
> -                                  range->id_count, smmu_offset);
> +        for (i = 0; i < num_smmus; i++) {
> +            sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
> +
> +            for (j = 0; j < sdev->idmaps->len; j++) {
> +                range = &g_array_index(sdev->idmaps, AcpiIortIdMapping, j);
> +                /* output IORT node is the smmuv3 node */
> +                build_iort_id_mapping(table_data, range->input_base,
> +                                      range->id_count, sdev->offset);
> +            }
>          }
>  
>          /* bypassed RIDs connect to ITS group node directly: RC -> ITS */
> @@ -428,8 +468,12 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      }
>  
>      acpi_table_end(linker, &table);
> -    g_array_free(smmu_idmaps, true);
>      g_array_free(its_idmaps, true);
> +    for (i = 0; i < num_smmus; i++) {
> +        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
> +        g_array_free(sdev->idmaps, true);
> +    }
> +    g_array_free(smmuv3_devs, true);
>  }
>  
>  /*
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 9a6cd085a3..73bd2bd5f2 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1614,6 +1614,7 @@ static void create_pcie(VirtMachineState *vms)
>              create_smmu(vms, vms->bus);
>              qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
>                                     0x0, vms->iommu_phandle, 0x0, 0x10000);
> +            vms->legacy_smmuv3_present = true;
>              break;
>          default:
>              g_assert_not_reached();
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 9a1b0f53d2..8b1404b5f6 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -174,6 +174,7 @@ struct VirtMachineState {
>      char *oem_id;
>      char *oem_table_id;
>      bool ns_el2_virt_timer_irq;
> +    bool legacy_smmuv3_present;
>  };
>  
>  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)


