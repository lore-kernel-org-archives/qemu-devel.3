Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2EDC77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 15:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVBFz-0003ru-Da; Fri, 27 Jun 2025 11:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uVBFv-0003rR-LY
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 11:44:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uVBFr-0007rt-4X
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 11:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751039082;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HEDOUjPtxmsWcDn67nR+IKB3WKWJ3kq0H/uNMQDCfdE=;
 b=hpweYK2jhRrhXIQEmtG0Rm8eckTyhQ6RCZkOYBC61LFl1M1F+cfuihVeF6pODEtZjxJ34r
 qN3J13L9HaOn/nOwK6mvKz2osDlK8eW+sxQUcSO28b9uLUjeJOgqlDj2zaD2Wf+HpWl97v
 iMnvBMnxIeC0AIibi3CywqP83zjaTyw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-bggVS6CiMiyY3-oqdgYZwA-1; Fri, 27 Jun 2025 11:44:38 -0400
X-MC-Unique: bggVS6CiMiyY3-oqdgYZwA-1
X-Mimecast-MFC-AGG-ID: bggVS6CiMiyY3-oqdgYZwA_1751039078
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4eeed54c2so1507084f8f.3
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 08:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751039077; x=1751643877;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HEDOUjPtxmsWcDn67nR+IKB3WKWJ3kq0H/uNMQDCfdE=;
 b=G+XjDzYMw1UZ/NUkK5yLTOvVSAvlsSNbVT6AkvnpAS0erixq+Ft94r5Apu2wNA9KVl
 R6C+8piktNFKGOdo7vWgCosyjZ9bydDN7g/PkSNl9ijnbhnUBCp4IbbqvY1ad6bMdm7V
 j/mFs25HBmxDkwz/esqgDe5m2at4Apc/6efDHiL89D4/+Xe4GDecQOMDaqo3aWIQShvQ
 szqxMICuI/Nasz46wSVqF86OnkohhWs/Svjqap3spBjXB0HRdMdeeur/TDgr79LrWGcy
 /rgiv2CWBQ4FKPihoEFbE1obkb1d2koFza36mD6yImBFEn9nzJVTsjUnC2V4Frt77MCr
 fNJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnVxFp7Xa63uRAvqlTxcNi6drFnZ+YNXFk0HzjbIFmTyx/pSTkgrBzUGFlVOgUzXZbDT8ah+QZncgA@nongnu.org
X-Gm-Message-State: AOJu0Yx6en/SSKowcGl0mjpplySvsJYqSWD2xqxdPbCiy43zsfdFw0ZT
 zZdtyLO+od53GRtywghtx/W199rDvBMaf1Yg6vG4UZSSDOnd4PtaiglV9ID0gNm7/apXJ9x32AB
 xLlJoDxZhQOX6ZkBv3WO9E5cTcTi23FYaJeeETFwZBIsiY+pdlCyymtks
X-Gm-Gg: ASbGncsBfi5e4h+XIc7fxEXdRwnuxYV8n34SjV6NXeCqQVzalGwvGrwzcLRDLPJz4ka
 qgsmr7UcjREzJMzDj8BkbvLiEp5S9/zt6mWc9GcgLFHJz0P0+Cij2HmJeL5apX+VWeTNQ+RBITS
 CNkDiOrvxUiyTVmzbpYR4GLEOjO4TXaEscMi9h6d23NAyDjZd6Xb8CPATyPkAdgWw9fnw+UXk6q
 u7jBRBZK+4Zycz3uGG+NBObh3bMcEGQYIp+4lV+DJLhAc7uBNgDBATf+ktY+4PHpVySXtnb0oS7
 6SkKZXn0GgT0HII8gzQlgO3tFvHMJQHfp0ml+crKZfGlZtnktrVCdVuXxDyPZIBbpSkoeg==
X-Received: by 2002:a5d:5f46:0:b0:3a5:8d08:6239 with SMTP id
 ffacd0b85a97d-3a8f58749a0mr4203606f8f.21.1751039077330; 
 Fri, 27 Jun 2025 08:44:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8EhAG5Nblcyu/ctSh5xN+rbIjVE28EEB3NUYFDp1pzWCJw4x2jJMbHVwJf3ibtH2uyd7hiA==
X-Received: by 2002:a5d:5f46:0:b0:3a5:8d08:6239 with SMTP id
 ffacd0b85a97d-3a8f58749a0mr4203574f8f.21.1751039076729; 
 Fri, 27 Jun 2025 08:44:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e59884sm2947388f8f.80.2025.06.27.08.44.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Jun 2025 08:44:36 -0700 (PDT)
Message-ID: <5e0e0aa6-cc09-4aa3-b48c-65de8273549c@redhat.com>
Date: Fri, 27 Jun 2025 17:44:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] hw/arm/virt-acpi-build: Fix ACPI IORT and MADT
 tables when its=off
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, udo@hypervisor.org,
 ajones@ventanamicro.com, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com
References: <20250623135749.691137-1-gustavo.romero@linaro.org>
 <20250623135749.691137-9-gustavo.romero@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250623135749.691137-9-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Gustavo,

On 6/23/25 3:57 PM, Gustavo Romero wrote:
> Currently, the ITS Group nodes in the IORT table and the GIC ITS Struct
> in the MADT table are always generated, even if GIC ITS is not available
> on the machine.
>
> This commit fixes it by not generating the ITS Group nodes, not mapping
> any other node to them, and not advertising the GIC ITS in the MADT
> table, when GIC ITS is not available on the machine.
>
> Since the fix changes the MADT and IORT tables, add the blobs for the
> "its=off" test to the allow list and update them in the next commit.
>
> Reported-by: Udo Steinberg <udo@hypervisor.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2886
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Co-authored-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/arm/virt-acpi-build.c                    | 128 ++++++++++++--------
>  tests/qtest/bios-tables-test-allowed-diff.h |   2 +
>  2 files changed, 80 insertions(+), 50 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 40a782a498..17ae46804a 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -328,17 +328,27 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          /* Sort the smmu idmap by input_base */
>          g_array_sort(smmu_idmaps, iort_idmap_compare);
>  
> -	/*
> -	 * Knowing the ID ranges from the RC to the SMMU, it's possible to
> -	 * determine the ID ranges from RC that go directly to ITS.
> -	 */
> -        create_its_idmaps(its_idmaps, smmu_idmaps);
> -
> -        nb_nodes = 3; /* RC, ITS, SMMUv3 */
> -        rc_mapping_count = smmu_idmaps->len + its_idmaps->len;
> +        nb_nodes = 2; /* RC and SMMUv3 */
> +        rc_mapping_count = smmu_idmaps->len;
> +
> +        if (vms->its) {
> +            /*
> +             * Knowing the ID ranges from the RC to the SMMU, it's possible to
> +             * determine the ID ranges from RC that go directly to ITS.
> +             */
> +            create_its_idmaps(its_idmaps, smmu_idmaps);
> +
> +            nb_nodes++; /* ITS */
> +            rc_mapping_count += its_idmaps->len;
> +        }
>      } else {
> -        nb_nodes = 2; /* RC, ITS */
> -        rc_mapping_count = 1;
> +        if (vms->its) {
> +            nb_nodes = 2; /* RC and ITS */
> +            rc_mapping_count = 1; /* Direct map to ITS */
> +        } else {
> +            nb_nodes = 1; /* RC only */
> +            rc_mapping_count = 0; /* No output mapping */
> +        }
>      }
>      /* Number of IORT Nodes */
>      build_append_int_noprefix(table_data, nb_nodes, 4);
> @@ -347,31 +357,43 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      build_append_int_noprefix(table_data, IORT_NODE_OFFSET, 4);
>      build_append_int_noprefix(table_data, 0, 4); /* Reserved */
>  
> -    /* Table 12 ITS Group Format */
> -    build_append_int_noprefix(table_data, 0 /* ITS Group */, 1); /* Type */
> -    node_size =  20 /* fixed header size */ + 4 /* 1 GIC ITS Identifier */;
> -    build_append_int_noprefix(table_data, node_size, 2); /* Length */
> -    build_append_int_noprefix(table_data, 1, 1); /* Revision */
> -    build_append_int_noprefix(table_data, id++, 4); /* Identifier */
> -    build_append_int_noprefix(table_data, 0, 4); /* Number of ID mappings */
> -    build_append_int_noprefix(table_data, 0, 4); /* Reference to ID Array */
> -    build_append_int_noprefix(table_data, 1, 4); /* Number of ITSs */
> -    /* GIC ITS Identifier Array */
> -    build_append_int_noprefix(table_data, 0 /* MADT translation_id */, 4);
> +    if (vms->its) {
> +        /* Table 12 ITS Group Format */
> +        build_append_int_noprefix(table_data, 0 /* ITS Group */, 1); /* Type */
> +        node_size =  20 /* fixed header size */ + 4 /* 1 GIC ITS Identifier */;
> +        build_append_int_noprefix(table_data, node_size, 2); /* Length */
> +        build_append_int_noprefix(table_data, 1, 1); /* Revision */
> +        build_append_int_noprefix(table_data, id++, 4); /* Identifier */
> +        build_append_int_noprefix(table_data, 0, 4); /* Number of ID mappings */
> +        build_append_int_noprefix(table_data, 0, 4); /* Reference to ID Array */
> +        build_append_int_noprefix(table_data, 1, 4); /* Number of ITSs */
> +        /* GIC ITS Identifier Array */
> +        build_append_int_noprefix(table_data, 0 /* MADT translation_id */, 4);
> +    }
>  
>      if (vms->iommu == VIRT_IOMMU_SMMUV3) {
>          int irq =  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
> -
> +        int num_id_mappings, offset_to_id_array;
> +
> +        if (vms->its) {
> +            num_id_mappings = 1; /* ITS Group node */
While at it, I would suggest to rename num_id_mappings into
smmu_mapping_count for consistency with

rc_mapping_count.

Also I would recommend to rename smmu_idmaps and its_idmaps into rc_smmu_idmaps and rc_its_idmaps to make things clearer. But that be done outside of thise series if you prefer.

Otherwise this looks good.

Thanks

Eric

> +            offset_to_id_array = SMMU_V3_ENTRY_SIZE; /* Just after the header */
> +        } else {
> +            num_id_mappings = 0; /* No ID mappings */
> +            offset_to_id_array = 0; /* No ID mappings array */
> +        }
>          smmu_offset = table_data->len - table.table_offset;
>          /* Table 9 SMMUv3 Format */
>          build_append_int_noprefix(table_data, 4 /* SMMUv3 */, 1); /* Type */
> -        node_size =  SMMU_V3_ENTRY_SIZE + ID_MAPPING_ENTRY_SIZE;
> +        node_size =  SMMU_V3_ENTRY_SIZE +
> +                     (ID_MAPPING_ENTRY_SIZE * num_id_mappings);
>          build_append_int_noprefix(table_data, node_size, 2); /* Length */
>          build_append_int_noprefix(table_data, 4, 1); /* Revision */
>          build_append_int_noprefix(table_data, id++, 4); /* Identifier */
> -        build_append_int_noprefix(table_data, 1, 4); /* Number of ID mappings */
> +        /* Number of ID mappings */
> +        build_append_int_noprefix(table_data, num_id_mappings, 4);
>          /* Reference to ID Array */
> -        build_append_int_noprefix(table_data, SMMU_V3_ENTRY_SIZE, 4);
> +        build_append_int_noprefix(table_data, offset_to_id_array, 4);
>          /* Base address */
>          build_append_int_noprefix(table_data, vms->memmap[VIRT_SMMU].base, 8);
>          /* Flags */
> @@ -387,9 +409,11 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          build_append_int_noprefix(table_data, 0, 4); /* Proximity domain */
>          /* DeviceID mapping index (ignored since interrupts are GSIV based) */
>          build_append_int_noprefix(table_data, 0, 4);
> -
> -        /* Output IORT node is the ITS Group node (the first node) */
> -        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
> +        /* Array of ID mappings */
> +        if (num_id_mappings) {
> +            /* Output IORT node is the ITS Group node (the first node). */
> +            build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
> +        }
>      }
>  
>      /* Table 17 Root Complex Node */
> @@ -430,7 +454,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>           *
>           * N.B.: The mapping from SMMUv3 to ITS Group node (SMMUv3 -> ITS) is
>           * defined in the SMMUv3 table, where all SMMUv3 IDs are mapped to the
> -         * ITS Group node.
> +         * ITS Group node, if ITS is available.
>           */
>          for (i = 0; i < smmu_idmaps->len; i++) {
>              range = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
> @@ -439,15 +463,17 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>                                    range->id_count, smmu_offset);
>          }
>  
> -        /*
> -         * Map bypassed (don't go throught the SMMU) RIDs (input) to ITS Group
> -         * node directly: RC -> ITS.
> -         */
> -        for (i = 0; i < its_idmaps->len; i++) {
> -            range = &g_array_index(its_idmaps, AcpiIortIdMapping, i);
> -            /* Output IORT node is the ITS Group node (the first node). */
> -            build_iort_id_mapping(table_data, range->input_base,
> -                                  range->id_count, IORT_NODE_OFFSET);
> +        if (vms->its) {
> +            /*
> +             * Map bypassed (don't go throught the SMMU) RIDs (input) to ITS Group
> +             * node directly: RC -> ITS.
> +             */
> +            for (i = 0; i < its_idmaps->len; i++) {
> +                range = &g_array_index(its_idmaps, AcpiIortIdMapping, i);
> +                /* Output IORT node is the ITS Group node (the first node). */
> +                build_iort_id_mapping(table_data, range->input_base,
> +                                      range->id_count, IORT_NODE_OFFSET);
> +            }
>          }
>      } else {
>          /*
> @@ -768,18 +794,20 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>                                            memmap[VIRT_HIGH_GIC_REDIST2].size);
>          }
>  
> -        /*
> -         * ACPI spec, Revision 6.0 Errata A
> -         * (original 6.0 definition has invalid Length)
> -         * 5.2.12.18 GIC ITS Structure
> -         */
> -        build_append_int_noprefix(table_data, 0xF, 1);  /* Type */
> -        build_append_int_noprefix(table_data, 20, 1);   /* Length */
> -        build_append_int_noprefix(table_data, 0, 2);    /* Reserved */
> -        build_append_int_noprefix(table_data, 0, 4);    /* GIC ITS ID */
> -        /* Physical Base Address */
> -        build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
> -        build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
> +        if (vms->its) {
> +            /*
> +             * ACPI spec, Revision 6.0 Errata A
> +             * (original 6.0 definition has invalid Length)
> +             * 5.2.12.18 GIC ITS Structure
> +             */
> +            build_append_int_noprefix(table_data, 0xF, 1);  /* Type */
> +            build_append_int_noprefix(table_data, 20, 1);   /* Length */
> +            build_append_int_noprefix(table_data, 0, 2);    /* Reserved */
> +            build_append_int_noprefix(table_data, 0, 4);    /* GIC ITS ID */
> +            /* Physical Base Address */
> +            build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
> +            build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
> +        }
>      } else {
>          const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
>  
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..a88198d5c2 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,3 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/aarch64/virt/APIC.its_off",
> +"tests/data/acpi/aarch64/virt/IORT.its_off",


