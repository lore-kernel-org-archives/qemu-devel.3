Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A037C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYYY-0000t9-TY; Tue, 17 Jun 2025 11:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRYJO-0001BQ-S4
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:33:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRWvw-0005ag-VP
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 10:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750169103;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t7fvMTs02Yc4ySb+1f1Y2yV8qjqLU6pID/iGbEfUA1g=;
 b=EQ70wD9N34zsO02vcWBcgQ+dKQb5QJTGRYalsdFBc9Z8Nw/yiwB80TA7dYjcay5Cj6QTay
 BhkFd3RV07mVAa9e7o5J45Cy/Ycq0WWZxowBIvgz8C1QjL6xB4QhCyL2lbsZCFZRu022UW
 6hbP/2sQlWr26m2LqQNPOCluCEAfG60=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-FR2bBv6gMFeRS1pkPm8Sxg-1; Tue, 17 Jun 2025 10:05:01 -0400
X-MC-Unique: FR2bBv6gMFeRS1pkPm8Sxg-1
X-Mimecast-MFC-AGG-ID: FR2bBv6gMFeRS1pkPm8Sxg_1750169100
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45311704d1fso32795905e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 07:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750169100; x=1750773900;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t7fvMTs02Yc4ySb+1f1Y2yV8qjqLU6pID/iGbEfUA1g=;
 b=TZcCxUMgXmGbhV9UXQIFUqmtsLSu/lUbIU/weKYPPA8JtaL6xm8I+ysYT1dlmMyTx4
 38rcXAom2RwA/1ToAPBMpdFdLuplbR4d8Cbopk/uuXu6IvfHUm01RMIUvUPCP/xI9Vlr
 E1oQJSOn4w1jQJFQYrIiSF8Wbp+bmINqy8U1+hJBwKqzeu2zKXtXGa6KZwdYmeuWfnmm
 n4Neq2CmzfEM6ZJhalAXd0ozEt0MqLuUlHK3kYoP1r6QYwZxj78nPSx1yBiOFW0XvwSk
 JwL47P8T4f9t6uE//kzNlyed1lWXYX7W/UByNqwtXq9w7qnxsC4d1uj0rQlSHJfi8TjD
 U2YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZjaN1NW7zkNsk7d5/I7it+rLJWwjP4E5bNosngW/aE88cuu276qY71mUEzFZhrh3EVyMo06Z9XO3z@nongnu.org
X-Gm-Message-State: AOJu0YyRQo9sfhpQ1mAJxIajJkAvZVWHnGY7ABk5xq6xEw/TOZ1zRIzg
 otnBqhnkZ8UUz9aRWUv2AYhFxoF2CRQ38c9Yr4w+iov5b/NHNAG8ztHCrgWabiaVMfubLs7jrkQ
 qSgl7fnaFZmWvhfZ1mm0b1ss7d555i6DiiTIixOSfFHl6yQSg3MGKCN/w
X-Gm-Gg: ASbGncuYqLOKvpVSLVf4FKLjnD7EggphkAyyJS+fgQpPVSz/UV7zzwEZUaXvceDf2GY
 Kc9YPc+/Xg69Ixwkni4lBBbjgqL2G8ddPp1zKExIYNi/a9YvlW57uKZ4H7hx8l7bKCY16YDq6XT
 T4qvC2NcGaXfbtm4/v1D/jIA3wXH8GT2vQV55LL4y3DKEFLT9vyV8uIwtddr6B/6/xpS/443wyE
 CEL+hBRzxGWDq9dKFmWL80SV/mS5UFKR58vpnPxg76VJW4mLlyEDnjmjiKoCp5IfpOkpF/SR8iK
 MF6jFrcuzCYVTpoq4H+1kPXK7w6yFdSS5VtvNS0iX+WDYZj+Jj7e41gKPEYjKaMFUeHlpQ==
X-Received: by 2002:a05:600c:620b:b0:450:d4a6:79ad with SMTP id
 5b1f17b1804b1-4533cb4bea8mr119324665e9.23.1750169098267; 
 Tue, 17 Jun 2025 07:04:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNHa9xPGBrlGViVTjKwHUHrrRRInb5RI5F8jy6FmGyJoW11BYseKIOgEQAtyZGxeGZyJIHQA==
X-Received: by 2002:a05:600c:620b:b0:450:d4a6:79ad with SMTP id
 5b1f17b1804b1-4533cb4bea8mr119323835e9.23.1750169097480; 
 Tue, 17 Jun 2025 07:04:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e232219sm175153485e9.9.2025.06.17.07.04.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 07:04:56 -0700 (PDT)
Message-ID: <2ccdf511-825b-41fc-9a59-1cb4c662a002@redhat.com>
Date: Tue, 17 Jun 2025 16:04:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] hw/arm/virt-acpi-build: Fix ACPI IORT and MADT
 tables when its=off
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, udo@hypervisor.org,
 ajones@ventanamicro.com, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com
References: <20250616131824.425315-1-gustavo.romero@linaro.org>
 <20250616131824.425315-8-gustavo.romero@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250616131824.425315-8-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Gustavo,

On 6/16/25 3:18 PM, Gustavo Romero wrote:
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
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/arm/virt-acpi-build.c                    | 152 ++++++++++++--------
>  tests/qtest/bios-tables-test-allowed-diff.h |   2 +
>  2 files changed, 93 insertions(+), 61 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 6990bce3bb..2240421980 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -295,32 +295,42 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          /* Sort the smmu idmap by input_base */
>          g_array_sort(smmu_idmaps, iort_idmap_compare);
>  
> -        /*
> -         * Split the whole RIDs by mapping from RC to SMMU,
> -         * build the ID mapping from RC to ITS directly.
> -         */
> -        for (i = 0; i < smmu_idmaps->len; i++) {
> -            idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
> +        nb_nodes = 2; /* RC and SMMUv3 */
> +        rc_mapping_count = smmu_idmaps->len;
> +
> +        if (vms->its) {
> +            /*
> +             * Split the whole RIDs by mapping from RC to SMMU,
> +             * build the ID mapping from RC to ITS directly.
> +             */
> +            for (i = 0; i < smmu_idmaps->len; i++) {
> +                idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
> +
> +                if (next_range.input_base < idmap->input_base) {
> +                    next_range.id_count = idmap->input_base - next_range.input_base;
> +                    g_array_append_val(its_idmaps, next_range);
> +                }
> +
> +                next_range.input_base = idmap->input_base + idmap->id_count;
> +            }
I think I would create a helper that populates the its_idmap from the
smmu_idmaps. To me to would make the code more readable. Also we could
add a doc comment bout the helper explaining what it does.
>  
> -            if (next_range.input_base < idmap->input_base) {
> -                next_range.id_count = idmap->input_base - next_range.input_base;
> +            /* Append the last RC -> ITS ID mapping */
> +            if (next_range.input_base < 0x10000) {
> +                next_range.id_count = 0x10000 - next_range.input_base;
>                  g_array_append_val(its_idmaps, next_range);
>              }
>  
> -            next_range.input_base = idmap->input_base + idmap->id_count;
> +            nb_nodes++; /* ITS */
> +            rc_mapping_count += its_idmaps->len;
>          }
> -
> -        /* Append the last RC -> ITS ID mapping */
> -        if (next_range.input_base < 0x10000) {
> -            next_range.id_count = 0x10000 - next_range.input_base;
> -            g_array_append_val(its_idmaps, next_range);
> -        }
> -
> -        nb_nodes = 3; /* RC, ITS, SMMUv3 */
> -        rc_mapping_count = smmu_idmaps->len + its_idmaps->len;
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
> @@ -329,31 +339,43 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
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
> @@ -370,8 +392,10 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          /* DeviceID mapping index (ignored since interrupts are GSIV based) */
>          build_append_int_noprefix(table_data, 0, 4);
>  
> -        /* output IORT node is the ITS group node (the first node) */
> -        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
> +        if (vms->its) {
I would use num_id_mappings
> +            /* Output IORT node is the ITS Group node (the first node). */
> +            build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
> +        }
>      }
>  
>      /* Table 17 Root Complex Node */
> @@ -415,20 +439,24 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>                                    range->id_count, smmu_offset);
>          }
>  
> -        /* Map DeviceIDs (input) from SMMUv3 to ITS Group nodes: SMMU -> ITS. */
see my previous comment
> -        for (i = 0; i < its_idmaps->len; i++) {
> -            range = &g_array_index(its_idmaps, AcpiIortIdMapping, i);
> -            /* Output IORT node is the ITS Group node (the first node). */
> -            build_iort_id_mapping(table_data, range->input_base,
> -                                  range->id_count, IORT_NODE_OFFSET);
> +        if (vms->its) {
> +            /* Map DeviceIDs (input) from SMMUv3 to ITS Group nodes: SMMU -> ITS. */
> +            for (i = 0; i < its_idmaps->len; i++) {
> +                range = &g_array_index(its_idmaps, AcpiIortIdMapping, i);
> +                /* Output IORT node is the ITS Group node (the first node). */
> +                build_iort_id_mapping(table_data, range->input_base,
> +                                      range->id_count, IORT_NODE_OFFSET);
> +            }
>          }
>      } else {
> -        /*
> -         * Map bypassed RIDs (input) (don't go through the SMMU) to ITS Group
> -         * nodes: RC -> ITS.
> -         * Output IORT node is the ITS Group node (the first node).
> -         */
> -        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
> +        if (vms->its) {
> +            /*
> +             * Map bypassed RIDs (input) (don't go through the SMMU) to ITS Group
> +             * nodes: RC -> ITS.
> +             * Output IORT node is the ITS Group node (the first node).
> +             */
> +            build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
> +        }
>      }
>  
>      acpi_table_end(linker, &table);
> @@ -741,18 +769,20 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
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
Thanks

Eric


