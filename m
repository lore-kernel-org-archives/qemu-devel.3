Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D0AC3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 18:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEBIU-0006hn-VB; Sun, 11 May 2025 14:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEBIS-0006hO-Qs
 for qemu-devel@nongnu.org; Sun, 11 May 2025 14:21:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEBIP-0002xb-A7
 for qemu-devel@nongnu.org; Sun, 11 May 2025 14:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746987663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M1U9V4E/jCv//fGAcFqg0RehFRBMkYL8FRS2hvieAAA=;
 b=EH1rpI69+Wq1IxCy00zqv1b53BC56w7AAifOysboVkak7gLSlxlDuVHbpGc0WrWvX7YJF6
 NCZ0gnpAC3EtDU1q2QRJPST1XEvNz+Fy3UMJ0wbMoKwrZzLjuD0nwr2I8KqfXcqUQQTYAC
 L++7QcyzKHsh53rzRgCV9fMmjrQ1jEw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-GbZ1eRuJMG6NsbQKXjNzQA-1; Sun, 11 May 2025 14:21:02 -0400
X-MC-Unique: GbZ1eRuJMG6NsbQKXjNzQA-1
X-Mimecast-MFC-AGG-ID: GbZ1eRuJMG6NsbQKXjNzQA_1746987661
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d734da1a3so17515425e9.0
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 11:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746987661; x=1747592461;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M1U9V4E/jCv//fGAcFqg0RehFRBMkYL8FRS2hvieAAA=;
 b=jhbykNz2knyIpISyT3D4HSgNwPbJgF9EWWnppMEr9UBKgqeCicvzn5OYcahb/htrfI
 eLpY8zJc5vX+RHWfPdMf7BTypQwrbvHcpSIVGBImB2773NGR2TMChCeiu7A+7lvEQbjK
 6Gylj6mZ2ZMBwGi57ArJ3tn/8Bogukz+0T96ATHhfErLDyD/a7336Va2KCf9avNyNIsg
 ccMnYXlW1i3/MQ29PfxW/SoOlfNr4f+TC6gmV+5Jgu2BNGZVKfDqFeTy3YL83VOrOgtx
 RgldiIPVNg2Gpe3cOQoh2Vlweh6ujNMNbu6CcltR5YoNnXojI9fKQey6tJBze7ZcdQfp
 j0Qw==
X-Gm-Message-State: AOJu0YzVKL7sHPjZhRvrA81kDvkR0qg+pEE6Olb42CKHm3h/3qbG1n7W
 82GXn8vtFgU8s9WSc0cOPSGo3WjyAZB/n8J79ViFtBRpmIRAZq7K+KnC0Hl9wUeNBefx61q9Vh6
 jeGxnEKzPZAxZZzktmiNPniMFGUNNIde7Y8zkQwZU4bdegJBD3mta
X-Gm-Gg: ASbGncvZW3YEamywuOA/XCryA1qScSZOJGgRw61lHgm/PPxSjhqIJFVdr8+vJc7Pmqj
 T/Zkl8ApJS9GY0Ta85jo9jlPISdJGFoy+6b+c7EfTxznQWUqFO485Zs5wACcDf43fBn/DGe6XV8
 +GB7hW8o52hJtbzBvtS6OcIlyCQ07bIeEj6GGBx4p3yzMjISnfyDYmgPe3jAffa+CfcKsFsvobr
 kMcQXHnM3YvmNQT/vzx2y3vZ3t+QPKkKWjTMc1Xjgb1EUnF53udr1I9rC7bIY6/o1A/yNeOE67f
 Gp7J6g==
X-Received: by 2002:a05:600c:3490:b0:441:d4e8:76cd with SMTP id
 5b1f17b1804b1-442d6ddec00mr85363055e9.29.1746987660912; 
 Sun, 11 May 2025 11:21:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFul0HAy0pEVe1yBMCmrVkvWUX2xlUc8VB8+z6Al5Q6KLDKvg0b/fPCFULsbzRo3v873FYwQ==
X-Received: by 2002:a05:600c:3490:b0:441:d4e8:76cd with SMTP id
 5b1f17b1804b1-442d6ddec00mr85362945e9.29.1746987660460; 
 Sun, 11 May 2025 11:21:00 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d687ac8csm97752365e9.33.2025.05.11.11.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 11:20:59 -0700 (PDT)
Date: Sun, 11 May 2025 14:20:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, anisinha@redhat.com,
 armbru@redhat.com, berrange@redhat.com, dapeng1.mi@linux.intel.com,
 eric.auger@redhat.com, farman@linux.ibm.com,
 gustavo.romero@linaro.org, imammedo@redhat.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 linuxarm@huawei.com, mtosatti@redhat.com, peter.maydell@linaro.org,
 qemu-arm@nongnu.org, richard.henderson@linaro.org,
 shameerali.kolothum.thodi@huawei.com, shannon.zhaosl@gmail.com,
 yangyicong@hisilicon.com, zhao1.liu@intel.com
Subject: Re: [PATCH v10 2/6] arm/virt.c: add cache hierarchy to device tree
Message-ID: <20250511141514-mutt-send-email-mst@kernel.org>
References: <20250428110754.48-1-alireza.sanaee@huawei.com>
 <20250428110754.48-3-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428110754.48-3-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Apr 28, 2025 at 12:07:50PM +0100, Alireza Sanaee wrote:
> Specify which layer (core/cluster/socket) caches found at in the CPU
> topology. Updating cache topology to device tree (spec v0.4).
> Example:
> 
> Here, 2 sockets (packages), and 2 clusters, 4 cores and 2 threads
> created, in aggregate 2*2*4*2 logical cores. In the smp-cache object,
> cores will have l1d and l1i.  However, extending this is not difficult).
> The clusters will share a unified l2 level cache, and finally sockets
> will share l3. In this patch, threads will share l1 caches by default,
> but this can be adjusted if case required.
> 
> Currently only three levels of caches are supported.  The patch does not
> allow partial declaration of caches. In another word, all caches must be
> defined or caches must be skipped.
> 
> ./qemu-system-aarch64 \
>     -machine virt,\
>          smp-cache.0.cache=l1i,smp-cache.0.topology=core,\
>          smp-cache.1.cache=l1d,smp-cache.1.topology=core,\
>          smp-cache.2.cache=l2,smp-cache.2.topology=cluster,\
>          smp-cache.3.cache=l3,smp-cache.3.topology=socket\
>     -cpu max \
>     -m 2048 \
>     -smp sockets=2,clusters=2,cores=4,threads=1 \
>     -kernel ./Image.gz \
>     -append "console=ttyAMA0 root=/dev/ram rdinit=/init acpi=force" \
>     -initrd rootfs.cpio.gz \
>     -bios ./edk2-aarch64-code.fd \
>     -nographic
> 
> For instance, following device tree will be generated for a scenario
> where we have 2 sockets, 2 clusters, 2 cores and 2 threads, in total 16
> PEs. L1i and L1d are private to each thread, and l2 and l3 are shared at
> socket level as an example.
> 
> Limitation: SMT cores cannot share L1 cache for now. This
> problem does not exist in PPTT tables.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> Co-developed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>  hw/arm/virt.c         | 343 ++++++++++++++++++++++++++++++++++++++++++
>  hw/cpu/core.c         |  92 +++++++++++
>  include/hw/arm/virt.h |   4 +
>  include/hw/cpu/core.h |  25 +++
>  4 files changed, 464 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index a96452f17a48..ece8203e9f0b 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -238,6 +238,132 @@ static const int a15irqmap[] = {
>      [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
>  };
>  
> +unsigned int virt_get_caches(const VirtMachineState *vms,
> +                             PPTTCPUCaches *caches)

pass an array size so we can assert on OOB at least.

> +{
> +    ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(0)); /* assume homogeneous CPUs */
> +    bool ccidx = cpu_isar_feature(any_ccidx, armcpu);
> +    unsigned int num_cache, i;
> +    int level_instr = 1, level_data = 1;
> +
> +    for (i = 0, num_cache = 0; i < CPU_MAX_CACHES; i++, num_cache++) {
> +        int type = (armcpu->clidr >> (3 * i)) & 7;
> +        int bank_index;
> +        int level;
> +        PPTTCPUCacheType cache_type;
> +
> +        if (type == 0) {
> +            break;
> +        }
> +
> +        switch (type) {
> +        case 1:
> +            cache_type = INSTRUCTION;
> +            level = level_instr;
> +            break;
> +        case 2:
> +            cache_type = DATA;
> +            level = level_data;
> +            break;
> +        case 4:
> +            cache_type = UNIFIED;
> +            level = level_instr > level_data ? level_instr : level_data;
> +            break;
> +        case 3: /* Split - Do data first */
> +            cache_type = DATA;
> +            level = level_data;
> +            break;
> +        default:
> +            error_setg(&error_abort, "Unrecognized cache type");
> +            return 0;
> +        }
> +        /*
> +         * ccsidr is indexed using both the level and whether it is
> +         * an instruction cache. Unified caches use the same storage
> +         * as data caches.
> +         */
> +        bank_index = (i * 2) | ((type == 1) ? 1 : 0);
> +        if (ccidx) {
> +            caches[num_cache] = (PPTTCPUCaches) {
> +                .type =  cache_type,
> +                .level = level,
> +                .linesize = 1 << (FIELD_EX64(armcpu->ccsidr[bank_index],
> +                                             CCSIDR_EL1,
> +                                             CCIDX_LINESIZE) + 4),
> +                .associativity = FIELD_EX64(armcpu->ccsidr[bank_index],
> +                                            CCSIDR_EL1,
> +                                            CCIDX_ASSOCIATIVITY) + 1,
> +                .sets = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
> +                                   CCIDX_NUMSETS) + 1,
> +            };
> +        } else {
> +            caches[num_cache] = (PPTTCPUCaches) {
> +                .type =  cache_type,
> +                .level = level,
> +                .linesize = 1 << (FIELD_EX64(armcpu->ccsidr[bank_index],
> +                                             CCSIDR_EL1, LINESIZE) + 4),
> +                .associativity = FIELD_EX64(armcpu->ccsidr[bank_index],
> +                                            CCSIDR_EL1,
> +                                            ASSOCIATIVITY) + 1,
> +                .sets = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
> +                                   NUMSETS) + 1,
> +            };
> +        }
> +        caches[num_cache].size = caches[num_cache].associativity *
> +            caches[num_cache].sets * caches[num_cache].linesize;
> +
> +        /* Break one 'split' entry up into two records */
> +        if (type == 3) {
> +            num_cache++;
> +            bank_index = (i * 2) | 1;
> +            if (ccidx) {
> +                /* Instruction cache: bottom bit set when reading banked reg */
> +                caches[num_cache] = (PPTTCPUCaches) {
> +                    .type = INSTRUCTION,
> +                    .level = level_instr,
> +                    .linesize = 1 << (FIELD_EX64(armcpu->ccsidr[bank_index],
> +                                                 CCSIDR_EL1,
> +                                                 CCIDX_LINESIZE) + 4),
> +                    .associativity = FIELD_EX64(armcpu->ccsidr[bank_index],
> +                                                CCSIDR_EL1,
> +                                                CCIDX_ASSOCIATIVITY) + 1,
> +                    .sets = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
> +                                       CCIDX_NUMSETS) + 1,
> +                };
> +            } else {
> +                caches[num_cache] = (PPTTCPUCaches) {
> +                    .type = INSTRUCTION,
> +                    .level = level_instr,
> +                    .linesize = 1 << (FIELD_EX64(armcpu->ccsidr[bank_index],
> +                                                 CCSIDR_EL1, LINESIZE) + 4),
> +                    .associativity = FIELD_EX64(armcpu->ccsidr[bank_index],
> +                                                CCSIDR_EL1,
> +                                                ASSOCIATIVITY) + 1,
> +                    .sets = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
> +                                       NUMSETS) + 1,
> +                };
> +            }
> +            caches[num_cache].size = caches[num_cache].associativity *
> +                caches[num_cache].sets * caches[num_cache].linesize;
> +        }
> +        switch (type) {
> +        case 1:
> +            level_instr++;
> +            break;
> +        case 2:
> +            level_data++;
> +            break;
> +        case 3:
> +        case 4:
> +            level_instr++;
> +            level_data++;
> +            break;
> +        }
> +    }
> +
> +    return num_cache;
> +}
> +
>  static void create_randomness(MachineState *ms, const char *node)
>  {
>      struct {
> @@ -421,13 +547,96 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
>      }
>  }
>  
> +static void add_cache_node(void *fdt, char * nodepath, PPTTCPUCaches cache,
> +                           uint32_t *next_level) {

coding style violation

> +    /* Assume L2/3 are unified caches. */
> +
> +    uint32_t phandle;
> +
> +    qemu_fdt_add_path(fdt, nodepath);
> +    phandle = qemu_fdt_alloc_phandle(fdt);
> +    qemu_fdt_setprop_cell(fdt, nodepath, "phandle", phandle);
> +    qemu_fdt_setprop_cell(fdt, nodepath, "cache-level", cache.level);
> +    qemu_fdt_setprop_cell(fdt, nodepath, "cache-size", cache.size);
> +    qemu_fdt_setprop_cell(fdt, nodepath, "cache-block-size", cache.linesize);
> +    qemu_fdt_setprop_cell(fdt, nodepath, "cache-sets", cache.sets);
> +    qemu_fdt_setprop(fdt, nodepath, "cache-unified", NULL, 0);
> +    qemu_fdt_setprop_string(fdt, nodepath, "compatible", "cache");
> +    if (cache.level != 3) {
> +        /* top level cache doesn't have next-level-cache property */
> +        qemu_fdt_setprop_cell(fdt, nodepath, "next-level-cache", *next_level);
> +    }
> +
> +    *next_level = phandle;
> +}
> +
> +static bool add_cpu_cache_hierarchy(void *fdt, PPTTCPUCaches* cache,
> +                                    uint32_t cache_cnt,
> +                                    uint32_t top_level,
> +                                    uint32_t bottom_level,
> +                                    uint32_t cpu_id,
> +                                    uint32_t *next_level) {
> +    bool found_cache = false;
> +    char *nodepath;
> +
> +    for (int level = top_level; level >= bottom_level; level--) {
> +        for (int i = 0; i < cache_cnt; i++) {
> +            if (i != level) {
> +                continue;
> +            }
> +
> +            nodepath = g_strdup_printf("/cpus/cpu@%d/l%d-cache",
> +                                       cpu_id, level);
> +            add_cache_node(fdt, nodepath, cache[i], next_level);
> +            found_cache = true;
> +            g_free(nodepath);
> +
> +        }
> +    }
> +
> +    return found_cache;
> +}
> +
> +static void set_cache_properties(void *fdt, const char *nodename,
> +                                 const char *prefix, PPTTCPUCaches cache)
> +{
> +    char prop_name[64];
> +
> +    snprintf(prop_name, sizeof(prop_name), "%s-block-size", prefix);
> +    qemu_fdt_setprop_cell(fdt, nodename, prop_name, cache.linesize);
> +
> +    snprintf(prop_name, sizeof(prop_name), "%s-size", prefix);
> +    qemu_fdt_setprop_cell(fdt, nodename, prop_name, cache.size);
> +
> +    snprintf(prop_name, sizeof(prop_name), "%s-sets", prefix);
> +    qemu_fdt_setprop_cell(fdt, nodename, prop_name, cache.sets);
> +}
> +
>  static void fdt_add_cpu_nodes(const VirtMachineState *vms)
>  {
>      int cpu;
>      int addr_cells = 1;
>      const MachineState *ms = MACHINE(vms);
> +    const MachineClass *mc = MACHINE_GET_CLASS(ms);
>      const VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>      int smp_cpus = ms->smp.cpus;
> +    int socket_id, cluster_id, core_id;
> +    uint32_t next_level = 0;
> +    uint32_t socket_offset = 0, cluster_offset = 0, core_offset = 0;
> +    int last_socket = -1, last_cluster = -1, last_core = -1;
> +    int top_node = 3, top_cluster = 3, top_core = 3;
> +    int bottom_node = 3, bottom_cluster = 3, bottom_core = 3;

do these one var at a time.

> +    unsigned int num_cache;
> +    PPTTCPUCaches caches[16];

why 16?

> +    bool cache_created = false;
> +
> +    num_cache = virt_get_caches(vms, caches);
> +
> +    if (mc->smp_props.has_caches &&
> +        partial_cache_description(ms, caches, num_cache)) {
> +            error_setg(&error_fatal, "Missing cache description");
> +            return;
> +    }
>  
>      /*
>       * See Linux Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -456,9 +665,14 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
>      qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
>  
>      for (cpu = smp_cpus - 1; cpu >= 0; cpu--) {
> +        socket_id = cpu / (ms->smp.clusters * ms->smp.cores * ms->smp.threads);
> +        cluster_id = cpu / (ms->smp.cores * ms->smp.threads) % ms->smp.clusters;
> +        core_id = cpu / (ms->smp.threads) % ms->smp.cores;
> +
>          char *nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
>          ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
>          CPUState *cs = CPU(armcpu);
> +        const char *prefix = NULL;
>  
>          qemu_fdt_add_subnode(ms->fdt, nodename);
>          qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "cpu");
> @@ -488,6 +702,130 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
>                                    qemu_fdt_alloc_phandle(ms->fdt));
>          }
>  
> +        if (!vmc->no_cpu_topology && num_cache) {
> +            for (uint8_t i = 0; i < num_cache; i++) {
> +                /* only level 1 in the CPU entry */
> +                if (caches[i].level > 1) {
> +                    continue;
> +                }
> +
> +                if (caches[i].type == INSTRUCTION) {
> +                    prefix = "i-cache";
> +                } else if (caches[i].type == DATA) {
> +                    prefix = "d-cache";
> +                } else if (caches[i].type == UNIFIED) {
> +                    error_setg(&error_fatal,
> +                               "Unified type is not implemented at level %d",
> +                               caches[i].level);
> +                    return;
> +                } else {
> +                    error_setg(&error_fatal, "Undefined cache type");
> +                    return;
> +                }
> +
> +                set_cache_properties(ms->fdt, nodename, prefix, caches[i]);
> +            }
> +        }
> +
> +        if (socket_id != last_socket) {
> +            bottom_node = top_node;
> +            /* this assumes socket as the highest topological level */
> +            socket_offset = 0;
> +            cluster_offset = 0;
> +            if (cache_described_at(ms, CPU_TOPOLOGY_LEVEL_SOCKET) &&
> +                find_the_lowest_level_cache_defined_at_level(ms,
> +                    &bottom_node,
> +                    CPU_TOPOLOGY_LEVEL_SOCKET)) {
> +
> +                if (bottom_node == 1) {
> +                    error_report(
> +                        "Cannot share L1 at socket_id %d. DT limiation on "
> +                        "sharing at cache level = 1",
> +                        socket_id);
> +                }
> +
> +                cache_created = add_cpu_cache_hierarchy(ms->fdt, caches,
> +                                                        num_cache,
> +                                                        top_node,
> +                                                        bottom_node, cpu,
> +                                                        &socket_offset);
> +
> +                if (!cache_created) {
> +                    error_setg(&error_fatal,
> +                               "Socket: No caches at levels %d-%d",
> +                               top_node, bottom_node);
> +                    return;
> +                }
> +
> +                top_cluster = bottom_node - 1;
> +            }
> +
> +            last_socket = socket_id;
> +        }
> +
> +        if (cluster_id != last_cluster) {
> +            bottom_cluster = top_cluster;
> +            cluster_offset = socket_offset;
> +            core_offset = 0;
> +            if (cache_described_at(ms, CPU_TOPOLOGY_LEVEL_CLUSTER) &&
> +                find_the_lowest_level_cache_defined_at_level(ms,
> +                    &bottom_cluster,
> +                    CPU_TOPOLOGY_LEVEL_CLUSTER)) {
> +
> +                cache_created = add_cpu_cache_hierarchy(ms->fdt, caches,
> +                                                        num_cache,
> +                                                        top_cluster,
> +                                                        bottom_cluster, cpu,
> +                                                        &cluster_offset);
> +                if (bottom_cluster == 1) {
> +                    error_report(
> +                        "Cannot share L1 at socket_id %d, cluster_id %d. "
> +                        "DT limitation on sharing at cache level = 1.",
> +                        socket_id, cluster_id);
> +                }
> +
> +                if (!cache_created) {
> +                    error_setg(&error_fatal,
> +                               "Cluster: No caches at levels %d-%d",
> +                               top_cluster, bottom_cluster);
> +                    return;
> +                }
> +
> +                top_core = bottom_cluster - 1;
> +            } else if (top_cluster == bottom_node - 1) {
> +                top_core = bottom_node - 1;
> +            }
> +
> +            last_cluster = cluster_id;
> +        }
> +
> +        if (core_id != last_core) {
> +            bottom_core = top_core;
> +            core_offset = cluster_offset;
> +            if (cache_described_at(ms, CPU_TOPOLOGY_LEVEL_CORE) &&
> +                find_the_lowest_level_cache_defined_at_level(ms,
> +                    &bottom_core,
> +                    CPU_TOPOLOGY_LEVEL_CORE)) {
> +
> +                if (bottom_core == 1) {
> +                    bottom_core++;
> +                }
> +
> +                cache_created = add_cpu_cache_hierarchy(ms->fdt,
> +                                                        caches,
> +                                                        num_cache,
> +                                                        top_core,
> +                                                        bottom_core, cpu,
> +                                                        &core_offset);
> +            }
> +
> +            last_core = core_id;
> +        }
> +
> +        next_level = core_offset;
> +        qemu_fdt_setprop_cell(ms->fdt, nodename, "next-level-cache",
> +                              next_level);
> +
>          g_free(nodename);
>      }
>  
> @@ -3193,6 +3531,11 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>      hc->unplug = virt_machine_device_unplug_cb;
>      mc->nvdimm_supported = true;
>      mc->smp_props.clusters_supported = true;
> +    /* Supported caches */
> +    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L1D] = true;
> +    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L1I] = true;
> +    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L2] = true;
> +    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L3] = true;
>      mc->auto_enable_numa_with_memhp = true;
>      mc->auto_enable_numa_with_memdev = true;
>      /* platform instead of architectural choice */
> diff --git a/hw/cpu/core.c b/hw/cpu/core.c
> index 495a5c30ffe1..3adfc3ca0001 100644
> --- a/hw/cpu/core.c
> +++ b/hw/cpu/core.c
> @@ -102,4 +102,96 @@ static void cpu_core_register_types(void)
>      type_register_static(&cpu_core_type_info);
>  }
>  
> +bool cache_described_at(const MachineState *ms, CpuTopologyLevel level)
> +{
> +    if (machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3) == level ||
> +        machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2) == level ||
> +        machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1I) == level ||
> +        machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1D) == level) {
> +        return true;
> +    }
> +    return false;
> +}
> +
> +int partial_cache_description(const MachineState *ms, PPTTCPUCaches *caches,
> +                              int num_caches)
> +{
> +    int level, c;
> +
> +    for (level = 1; level < num_caches; level++) {
> +        for (c = 0; c < num_caches; c++) {
> +            if (caches[c].level != level) {
> +                continue;
> +            }
> +
> +            switch (level) {
> +            case 1:
> +                /*
> +                 * L1 cache is assumed to have both L1I and L1D available.
> +                 * Technically both need to be checked.
> +                 */
> +                if (machine_get_cache_topo_level(ms,
> +                                                 CACHE_LEVEL_AND_TYPE_L1I) ==
> +                    CPU_TOPOLOGY_LEVEL_DEFAULT) {
> +                    return level;
> +                }
> +                break;
> +            case 2:
> +                if (machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2) ==
> +                    CPU_TOPOLOGY_LEVEL_DEFAULT) {
> +                    return level;
> +                }
> +                break;
> +            case 3:
> +                if (machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3) ==
> +                    CPU_TOPOLOGY_LEVEL_DEFAULT) {
> +                    return level;
> +                }
> +                break;
> +            }
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +/*
> + * This function assumes l3 and l2 have unified cache and l1 is split l1d
> + * and l1i, and further prepares the lowest cache level for a topology
> + * level.  The info will be fed to build_caches to create caches at the
> + * right level.
> + */
> +bool find_the_lowest_level_cache_defined_at_level(const MachineState *ms,
> +                                                  int *level_found,
> +                                                  CpuTopologyLevel topo_level) {
> +
> +    CpuTopologyLevel level;
> +
> +    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1I);
> +    if (level == topo_level) {
> +        *level_found = 1;
> +        return true;
> +    }
> +
> +    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1D);
> +    if (level == topo_level) {
> +        *level_found = 1;
> +        return true;
> +    }
> +
> +    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2);
> +    if (level == topo_level) {
> +        *level_found = 2;
> +        return true;
> +    }
> +
> +    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3);
> +    if (level == topo_level) {
> +        *level_found = 3;
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
>  type_init(cpu_core_register_types)
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index c8e94e6aedc9..68ff99d6806d 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -39,6 +39,7 @@
>  #include "system/kvm.h"
>  #include "hw/intc/arm_gicv3_common.h"
>  #include "qom/object.h"
> +#include "hw/cpu/core.h"
>  
>  #define NUM_GICV2M_SPIS       64
>  #define NUM_VIRTIO_TRANSPORTS 32
> @@ -50,6 +51,8 @@
>  /* GPIO pins */
>  #define GPIO_PIN_POWER_BUTTON  3
>  
> +#define CPU_MAX_CACHES 16
> +
>  enum {
>      VIRT_FLASH,
>      VIRT_MEM,
> @@ -189,6 +192,7 @@ OBJECT_DECLARE_TYPE(VirtMachineState, VirtMachineClass, VIRT_MACHINE)
>  
>  void virt_acpi_setup(VirtMachineState *vms);
>  bool virt_is_acpi_enabled(VirtMachineState *vms);
> +unsigned int virt_get_caches(const VirtMachineState *vms, PPTTCPUCaches *caches);
>  
>  /* Return number of redistributors that fit in the specified region */
>  static uint32_t virt_redist_capacity(VirtMachineState *vms, int region)
> diff --git a/include/hw/cpu/core.h b/include/hw/cpu/core.h
> index 98ab91647eb2..a90b708b835b 100644
> --- a/include/hw/cpu/core.h
> +++ b/include/hw/cpu/core.h
> @@ -25,6 +25,31 @@ struct CPUCore {
>      int nr_threads;
>  };
>  
> +typedef enum CPUCacheType {
> +    DATA,
> +    INSTRUCTION,
> +    UNIFIED,
> +} PPTTCPUCacheType;

Given specific values matter, you should specify them.
Also, please prefix names sensibly and consistently:
    CPUCoreCacheType CPU_CORE_DATA and so on.



> +
> +typedef struct PPTTCPUCaches {
> +    PPTTCPUCacheType type;
> +    uint32_t sets;
> +    uint32_t size;
> +    uint32_t level;
> +    uint16_t linesize;
> +    uint8_t attributes; /* write policy: 0x0 write back, 0x1 write through */
> +    uint8_t associativity;
> +} PPTTCPUCaches;
> +
> +int partial_cache_description(const MachineState *ms, PPTTCPUCaches *caches,
> +                              int num_caches);
> +
> +bool cache_described_at(const MachineState *ms, CpuTopologyLevel level);
> +
> +bool find_the_lowest_level_cache_defined_at_level(const MachineState *ms,
> +                                                  int *level_found,
> +                                                  CpuTopologyLevel topo_level);
> +
>  /* Note: topology field names need to be kept in sync with
>   * 'CpuInstanceProperties' */

same here, prefix everything with cpu_core CPUCore etc.

> -- 
> 2.34.1


