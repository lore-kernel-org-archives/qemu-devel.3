Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4EF1061B2B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 02:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7P0o-0007Hg-Mm; Mon, 30 Mar 2026 22:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1w7P0m-0007H6-IZ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 22:39:24 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1w7P0k-0000RP-IS
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 22:39:24 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-56a8fdaddebso2113465e0c.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 19:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774924761; x=1775529561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o9+wZ/N59nMhGRJ6JWlo/ziDQG2zIs3unKhmp0oq0M4=;
 b=ycTmAKaX4mDmppq36LpDWayofdC+CCAzdPCGUw+YHZF7xYT7t1aVTLoq4C5Bv78pCC
 dZP220MkWPrTaK1MyziRaaDBmSBF9tBydNEfEPa74yzsCqwy0CScDd9rSwZNOALEgA6A
 6LoaCMhiktJirHj2jDaVWqHHLaYm3GClTv7J5GKoFlaVs5yDP+PhYqxdlf1Kohr3sPRw
 pLXJz6PzvY9A5XF14BjPKPRbdLNjB/3Dd99IRQti1iOIHO7y6Adz2YUaCquW2mHs2ZFh
 2RKL1ZjlbpIMLJZo2oD9/+spcHZKaQim7NEasS1fu46HaqNmyZ/EMn8I2b6svxILUkom
 BFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774924761; x=1775529561;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o9+wZ/N59nMhGRJ6JWlo/ziDQG2zIs3unKhmp0oq0M4=;
 b=TUsJ7a02yR5E5DiyCHNiAgwMHPNWkOqCfUrspb93s5IUNiduksTNv9Nz0V3JL9YjUG
 vHhGUYqkfCW9KWhyhmoTVqbG/hqNbMZpzfWnKX8H2OmU4HlWNp0QaRjw+lZ2Li4ZnLMM
 3zAA792DkLzPTQDvzBPu1k370LhZtHK61YQdZyRUS7NVlwLqiwB37HB9NzDmiELRvhjG
 Jqi0gxvAL8Kd1Hnyan4M6Pia3PKWdHt5lQFFJzZNAmtFetKr9JNQa+uByryvBdqU57je
 wjgil4wBA54HWFh9HGCxQJ4xaPvSKti15JOCxy37HlBXRT68W4XhQewLe7mkincxe7Bv
 VevQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrjLDk7Z+juZlwJR4MZQgJet768N3At3kEmWYn+3pX6bKm7VR/ISg9TJXCcow0kPKwXzC62OlQSDYq@nongnu.org
X-Gm-Message-State: AOJu0YzoyE9mQUbRyTUH3ohKrkQvhMK8xpgYORzMCTbWJI6wkEykqQaD
 +roCob8j20Oad5qin2d0ZiGo0JElQY61atsw3NRtG5r5VTCdCsLnb/95dQUf9Rucmak=
X-Gm-Gg: ATEYQzxUAm6fMbV+B+PYxkc4B+Qn6dNsljvjhPjDlILz9qV9esCFhQVJbfcLHcxcXB1
 zF2X4lS4uJ3lIIjseci0Rwgk7kKrCjhgFjo25DD0RYSHv6ZHzRdh61FWonynhlgS4s9kXEZeZWS
 rJJQ0MFxdlZOuuTxtoJ7K4xvVLLg+61TLYEe+YS9m7nXY8diQy4w63qGBZNhofFI7MKSMsiOLtr
 BN5L+qfZ4NALJA9R1tdtEK4t2E2eQalsTuMZYXyJJ3zO/jUf5E1VJ3oNJyuWbUn0v1nQvdu1gWr
 7zoaKeoz+rjttA9G9rO3ivrbET6nFC9eqMR+iRF+uEiQ7k3Ja0Nhowa0sFm1HxAtDe1nhwAeD8h
 UkKJ6LZMh/zViB0GO1GsusNBFEbSgQiZ7k3TmBPK45eDSI52wBOnuikBBDQfIcA/EYOJhtop5BZ
 SqWiYzqo3Vj2zLCGGYIabqmyVUl0XLQDgX6MM=
X-Received: by 2002:a05:6122:6e0f:b0:56a:f542:78fb with SMTP id
 71dfb90a1353d-56d4a51966cmr5484448e0c.7.1774924761146; 
 Mon, 30 Mar 2026 19:39:21 -0700 (PDT)
Received: from [192.168.0.104] ([186.215.53.158])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56d58a7ba96sm10665084e0c.17.2026.03.30.19.39.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 19:39:20 -0700 (PDT)
Message-ID: <31880989-7b1c-4b71-9ec9-896ea1a7d408@linaro.org>
Date: Mon, 30 Mar 2026 23:39:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 6/8] hw/acpi: add cache hierarchy to pptt table
To: Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 mst@redhat.com
Cc: anisinha@redhat.com, armbru@redhat.com, berrange@redhat.com,
 dapeng1.mi@linux.intel.com, eric.auger@redhat.com, farman@linux.ibm.com,
 imammedo@redhat.com, jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 linuxarm@huawei.com, maobibo@loongson.cn, mtosatti@redhat.com,
 peter.maydell@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, shannon.zhaosl@gmail.com, zhao1.liu@intel.com
References: <20260311160609.358-1-alireza.sanaee@huawei.com>
 <20260311160609.358-7-alireza.sanaee@huawei.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20260311160609.358-7-alireza.sanaee@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa2a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Alireza,

On 3/11/26 13:06, Alireza Sanaee wrote:
> Add cache topology to PPTT table.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
> Thanks for the review Gustavo.
> 
> Change log:
>       v18->v19:
>            - Fixed some comments.
>            - Removed the extra check on existence of cache at the topology level
>              in build_pptt function since it is already checked in
>              machine_find_lowest_level_cache_at_topo_level function.
> 
>   hw/acpi/aml-build.c      | 200 +++++++++++++++++++++++++++++++++++++--
>   hw/arm/virt-acpi-build.c |   8 +-
>   include/hw/acpi/cpu.h    |  10 ++
>   3 files changed, 209 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index b0ea8a5d5d..7edc8aed42 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -34,6 +34,7 @@
>   #include "hw/pci/pci_bridge.h"
>   #include "hw/acpi/acpi_aml_interface.h"
>   #include "qemu/cutils.h"
> +#include "hw/core/cpu.h"
>   
>   static GArray *build_alloc_array(void)
>   {
> @@ -2150,6 +2151,108 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
>       }
>       acpi_table_end(linker, &table);
>   }
> +
> +/*
> + * ACPI spec, Revision 6.3
> + * 5.2.29.2 Cache Type Structure (Type 1)
> + */
> +static void build_cache_nodes(GArray *tbl, CPUCoreCaches *cache,
> +                              uint32_t next_offset)
> +{
> +    const uint8_t node_length = 24;
> +    int start_len = tbl->len;
> +    int val;
> +
> +    build_append_byte(tbl, 1);                         /* Type 1 - cache */
> +    build_append_byte(tbl, node_length);               /* Length */
> +    build_append_int_noprefix(tbl, 0, 2);              /* Reserved */
> +    build_append_int_noprefix(tbl, 0x7f, 4);           /* Flags */
> +    build_append_int_noprefix(tbl, next_offset, 4);    /* Next Level of Cache */
> +    build_append_int_noprefix(tbl, cache->size, 4);    /* Size */
> +    build_append_int_noprefix(tbl, cache->sets, 4);    /* Number of sets */
> +    build_append_byte(tbl, cache->associativity);      /* Associativity */
> +    val = 0x3;
> +    switch (cache->type) {
> +    case INSTRUCTION_CACHE:
> +        val |= (1 << 2); /* Instruction Cache */
> +        break;
> +    case DATA_CACHE:
> +        val |= (0 << 2); /* Data Cache */
> +        break;
> +    case UNIFIED_CACHE:
> +        val |= (3 << 2); /* Unified */
> +        break;
> +    }
> +    build_append_byte(tbl, val);                        /* Attributes */
> +    build_append_int_noprefix(tbl, cache->linesize, 2); /* Line size */
> +    g_assert(tbl->len == start_len + node_length);
> +}
> +
> +/*
> + * Build PPTT Cache Type structures (Type 1) from cache level `level_high`
> + * down to `level_low` (both inclusive), appending them to the PPTT table.
> + *
> + * On output, `data_offset` and `instr_offset` hold the PPTT offsets of the
> + * lowest-level data and instruction cache nodes respectively.  These offsets
> + * are referenced as private resources in the Processor Hierarchy Node (Type 0)
> + * that owns the caches.
> + */
> +static bool build_caches(GArray *table_data, uint32_t pptt_start,
> +                         int num_caches, CPUCoreCaches *caches,
> +                         uint8_t level_high, /* Inclusive */
> +                         uint8_t level_low,  /* Inclusive */
> +                         uint32_t *data_offset,
> +                         uint32_t *instr_offset)
> +{
> +    uint32_t next_level_offset_data = 0, next_level_offset_instruction = 0;
> +    uint32_t this_offset, next_offset = 0;
> +    int c, level;
> +    bool found_cache = false;
> +
> +    /* Walk caches from top to bottom */
> +    for (level = level_high; level >= level_low; level--) {
> +        for (c = 0; c < num_caches; c++) {
> +            if (caches[c].level != level) {
> +                continue;
> +            }
> +
> +            /* Assume only unified above l1 for now */
> +            this_offset = table_data->len - pptt_start;
> +            switch (caches[c].type) {
> +            case INSTRUCTION_CACHE:
> +                next_offset = next_level_offset_instruction;
> +                break;
> +            case DATA_CACHE:
> +                next_offset = next_level_offset_data;
> +                break;
> +            case UNIFIED_CACHE:
> +                /* Either is fine here */
> +                next_offset = next_level_offset_instruction;
> +                break;
> +            }
> +            build_cache_nodes(table_data, &caches[c], next_offset);
> +            switch (caches[c].type) {
> +            case INSTRUCTION_CACHE:
> +                next_level_offset_instruction = this_offset;
> +                break;
> +            case DATA_CACHE:
> +                next_level_offset_data = this_offset;
> +                break;
> +            case UNIFIED_CACHE:
> +                next_level_offset_instruction = this_offset;
> +                next_level_offset_data = this_offset;
> +                break;
> +            }
> +            *data_offset = next_level_offset_data;
> +            *instr_offset = next_level_offset_instruction;
> +
> +            found_cache = true;
> +        }
> +    }
> +
> +    return found_cache;
> +}
> +
>   /*
>    * ACPI spec, Revision 6.3
>    * 5.2.29 Processor Properties Topology Table (PPTT)
> @@ -2160,11 +2263,31 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
>   {
>       MachineClass *mc = MACHINE_GET_CLASS(ms);
>       CPUArchIdList *cpus = ms->possible_cpus;
> -    int64_t socket_id = -1, cluster_id = -1, core_id = -1;
> -    uint32_t socket_offset = 0, cluster_offset = 0, core_offset = 0;
> +    uint32_t core_data_offset = 0;
> +    uint32_t core_instr_offset = 0;
> +    uint32_t cluster_instr_offset = 0;
> +    uint32_t cluster_data_offset = 0;
> +    uint32_t node_data_offset = 0;
> +    uint32_t node_instr_offset = 0;
> +    int top_node = 3;
> +    int top_cluster = 3;
> +    int top_core = 3;
> +    int bottom_node = 3;
> +    int bottom_cluster = 3;
> +    int bottom_core = 3;
> +    int64_t socket_id = -1;
> +    int64_t cluster_id = -1;
> +    int64_t core_id = -1;
> +    uint32_t socket_offset = 0;
> +    uint32_t cluster_offset = 0;
> +    uint32_t core_offset = 0;
>       uint32_t pptt_start = table_data->len;
>       uint32_t root_offset;
>       int n;
> +    uint32_t priv_rsrc[2];
> +    uint32_t num_priv = 0;
> +    bool cache_at_topo_level;
> +
>       AcpiTable table = { .sig = "PPTT", .rev = 2,
>                           .oem_id = oem_id, .oem_table_id = oem_table_id };
>   
> @@ -2194,11 +2317,29 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
>               socket_id = cpus->cpus[n].props.socket_id;
>               cluster_id = -1;
>               core_id = -1;
> +            bottom_node = top_node;
> +            num_priv = 0;
> +            cache_at_topo_level =
> +                machine_find_lowest_level_cache_at_topo_level(
> +                    ms, &bottom_node, CPU_TOPOLOGY_LEVEL_SOCKET);
> +            if (cache_at_topo_level) {
> +                build_caches(table_data, pptt_start, num_caches, caches,
> +                             top_node, bottom_node, &node_data_offset,
> +                             &node_instr_offset);
> +                priv_rsrc[0] = node_instr_offset;
> +                priv_rsrc[1] = node_data_offset;
> +                if (node_instr_offset || node_data_offset) {
> +                    num_priv = node_instr_offset == node_data_offset ? 1 : 2;
> +                }
> +
> +                top_cluster = bottom_node - 1;
> +            }
> +
>               socket_offset = table_data->len - pptt_start;
>               build_processor_hierarchy_node(table_data,
>                   (1 << 0) | /* Physical package */
>                   (1 << 4), /* Identical Implementation */
> -                root_offset, socket_id, NULL, 0);
> +                root_offset, socket_id, priv_rsrc, num_priv);
>           }
>   
>           if (mc->smp_props.clusters_supported && mc->smp_props.has_clusters) {
> @@ -2206,21 +2347,66 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
>                   assert(cpus->cpus[n].props.cluster_id > cluster_id);
>                   cluster_id = cpus->cpus[n].props.cluster_id;
>                   core_id = -1;
> +                bottom_cluster = top_cluster;
> +                num_priv = 0;
> +                cache_at_topo_level =
> +                    machine_find_lowest_level_cache_at_topo_level(
> +                        ms, &bottom_cluster, CPU_TOPOLOGY_LEVEL_CLUSTER);
> +
> +                if (cache_at_topo_level) {
> +                    build_caches(table_data, pptt_start, num_caches, caches,
> +                                 top_cluster, bottom_cluster,
> +                                 &cluster_data_offset, &cluster_instr_offset);
> +                    priv_rsrc[0] = cluster_instr_offset;
> +                    priv_rsrc[1] = cluster_data_offset;
> +                    if (cluster_instr_offset || cluster_data_offset) {
> +                        num_priv =
> +                            cluster_instr_offset == cluster_data_offset ? 1 : 2;
> +                    }
> +                    top_core = bottom_cluster - 1;
> +                } else if (top_cluster == bottom_node - 1) {
> +                    /* socket cache but no cluster cache */
> +                    top_core = bottom_node - 1;
> +                }
> +
>                   cluster_offset = table_data->len - pptt_start;
>                   build_processor_hierarchy_node(table_data,
>                       (0 << 0) | /* Not a physical package */
>                       (1 << 4), /* Identical Implementation */
> -                    socket_offset, cluster_id, NULL, 0);
> +                    socket_offset, cluster_id, priv_rsrc, num_priv);
>               }
>           } else {
> +            if (machine_defines_cache_at_topo_level(
> +                    ms, CPU_TOPOLOGY_LEVEL_CLUSTER)) {
> +                error_setg(&error_fatal, "Not clusters found for the cache");
> +                return;
> +            }
> +
>               cluster_offset = socket_offset;
> +            top_core = bottom_node - 1; /* there is no cluster */
> +        }
> +
> +        if (cpus->cpus[n].props.core_id != core_id) {
> +            bottom_core = top_core;
> +            num_priv = 0;
> +            cache_at_topo_level =
> +                machine_find_lowest_level_cache_at_topo_level(
> +                    ms, &bottom_core, CPU_TOPOLOGY_LEVEL_CORE);
> +            if (cache_at_topo_level) {
> +                build_caches(table_data, pptt_start, num_caches, caches,
> +                             top_core, bottom_core, &core_data_offset,
> +                             &core_instr_offset);
> +                priv_rsrc[0] = core_instr_offset;
> +                priv_rsrc[1] = core_data_offset;
> +                num_priv = core_instr_offset == core_data_offset ? 1 : 2;
> +            }
>           }
>   
>           if (ms->smp.threads == 1) {
>               build_processor_hierarchy_node(table_data,
>                   (1 << 1) | /* ACPI Processor ID valid */
> -                (1 << 3),  /* Node is a Leaf */
> -                cluster_offset, n, NULL, 0);
> +                (1 << 3), /* Node is a Leaf */
> +                cluster_offset, n, priv_rsrc, num_priv);
>           } else {
>               if (cpus->cpus[n].props.core_id != core_id) {
>                   assert(cpus->cpus[n].props.core_id > core_id);
> @@ -2229,7 +2415,7 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
>                   build_processor_hierarchy_node(table_data,
>                       (0 << 0) | /* Not a physical package */
>                       (1 << 4), /* Identical Implementation */
> -                    cluster_offset, core_id, NULL, 0);
> +                    cluster_offset, core_id, priv_rsrc, num_priv);
>               }
>   
>               build_processor_hierarchy_node(table_data,
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 3fff78bcca..b230ea2c8e 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -1255,6 +1255,10 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>       unsigned dsdt, xsdt;
>       GArray *tables_blob = tables->table_data;
>       MachineState *ms = MACHINE(vms);
> +    CPUCoreCaches caches[CPU_MAX_CACHES];
> +    unsigned int num_caches;
> +
> +    num_caches = virt_get_caches(vms, caches);
>   
>       table_offsets = g_array_new(false, true /* clear */,
>                                           sizeof(uint32_t));
> @@ -1276,8 +1280,8 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>   
>       if (!vmc->no_cpu_topology) {
>           acpi_add_table(table_offsets, tables_blob);
> -        build_pptt(tables_blob, tables->linker, ms,
> -                   vms->oem_id, vms->oem_table_id, 0, NULL);
> +        build_pptt(tables_blob, tables->linker, ms, vms->oem_id,
> +                   vms->oem_table_id, num_caches, caches);
>       }
>   
>       acpi_add_table(table_offsets, tables_blob);
> diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
> index 2809dd8a91..04c821d2b9 100644
> --- a/include/hw/acpi/cpu.h
> +++ b/include/hw/acpi/cpu.h
> @@ -69,6 +69,16 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>   
>   void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list);
>   
> +struct CPUPPTTCaches {
> +    enum CacheType type;
> +    uint32_t sets;
> +    uint32_t size;
> +    uint32_t level;
> +    uint16_t linesize;
> +    uint8_t attributes; /* write policy: 0x0 write back, 0x1 write through */
> +    uint8_t associativity;
> +};
> +
>   extern const VMStateDescription vmstate_cpu_hotplug;
>   #define VMSTATE_CPU_HOTPLUG(cpuhp, state) \
>       VMSTATE_STRUCT(cpuhp, state, 1, \

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

