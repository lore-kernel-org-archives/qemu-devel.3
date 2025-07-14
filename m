Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB042C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 10:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubGAD-00034s-31; Mon, 14 Jul 2025 06:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubGA9-000326-3S
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:11:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubGA5-0001gK-V6
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752487912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lUXjGTQHADW/W6yljww+ubfDW1EIWHPT2Nw1GAGAdCQ=;
 b=WIqTlBPeGnpCbwXQi1W1WBdEBJNys1DiRBhH1Tpg1N/4hJOMQTyB8dd3g7upnjhv6VS/AP
 k/1hXXRWEYfIdPDuxChiJydzc5Elyr6ihmIEyeUM8ISIYnUh5jA5IHRvjVYlSxKuH5cJlt
 VWZ0HfFPT09LNfFMFxRO5p/LsPiFrK0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-XyiXoAZVMlCIuh5wMZIWIA-1; Mon, 14 Jul 2025 06:11:50 -0400
X-MC-Unique: XyiXoAZVMlCIuh5wMZIWIA-1
X-Mimecast-MFC-AGG-ID: XyiXoAZVMlCIuh5wMZIWIA_1752487910
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4561a196f70so4528055e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 03:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752487909; x=1753092709;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lUXjGTQHADW/W6yljww+ubfDW1EIWHPT2Nw1GAGAdCQ=;
 b=vMxXzpJFPyXT3zYZbGxSqs2TNu8qaAS6kCFfJgf6n1f0HF1pjok8toOUucQkn1ovNw
 X4EVvQQ7LoIYsu4SPFzzHGn5RRCpkafShUZNqXTDgvu0OGk/fyBus8AV2zMrJg08AI4H
 PCaZM0wTc3L7EnL5pX6Vx5DYhtuiRLRcx+F72rCbGfNYXYVjfMo55t3yZ6tNK0jkwymN
 pFEazs+QufRTf+0pE4OMTqV4jqZNwvOq9uLwg5vgn87Y+mowqGzPNcqnIXMDkczioWf2
 dYq1UYQnsxJ8y3HDUWuPsEmKT2kXBuo5dT2stu3ETUq8qyYR61S7NbiFAMsB5GYUYCa4
 M84w==
X-Gm-Message-State: AOJu0YzyoqVBEwxOjVzewgvH9F6BK5wWhOZKtWfoZytogtet5m2TBbml
 ygHVoUHeR+g3n3Q6AnEaUlLceA6BWbKVqZLY7zJ5nd+2JV7VVug3362Rph5FKHCRsUrfneDO+t1
 eVW1New3efFuq2djmV/BlxsZyi0Xx/8G993Pp72jzU/OwCdNrfFhBMrGo
X-Gm-Gg: ASbGncvSJcIVgW2NFcpmeoIfdH1nvk1xg88yuIIoT/w08h2pWd0BxfGAvG8RIVenk4X
 sBBQSGyAp1KQ/SDvgWq7GL+o+H1+Gu+rrJSYySNuNHrjEa8yv9sv+mCEtydSMCZo8Mtd9aXkT83
 GHwTFOtq+nR793iQafWIyZDoIDjoTw9FkHJuzF/eUoOdyBLi0KFEXf4KFd76Axhhr7sFvgD6NiF
 VW0X5peny9Op7nhQriA8dkqLQp+scnaSjZNzgqt2TKAPc8Cs7kfdo5UxKtGlqVXFhlUpGO4PqWW
 OoA1aU0XdQXJHIOm0ehCRpFlvpG7amWF
X-Received: by 2002:a05:600c:a00e:b0:43c:e478:889 with SMTP id
 5b1f17b1804b1-45555e65e51mr112485715e9.0.1752487909215; 
 Mon, 14 Jul 2025 03:11:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmbR/OhX4q4PGP2x6k0Wenz75zhbtx5or+odBwMuoyBl8wEuiKiundLgFK1+Y6gdOQ6IFZ+A==
X-Received: by 2002:a05:600c:a00e:b0:43c:e478:889 with SMTP id
 5b1f17b1804b1-45555e65e51mr112485095e9.0.1752487908431; 
 Mon, 14 Jul 2025 03:11:48 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc2087sm12172246f8f.30.2025.07.14.03.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 03:11:47 -0700 (PDT)
Date: Mon, 14 Jul 2025 06:11:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, anisinha@redhat.com, armbru@redhat.com,
 berrange@redhat.com, dapeng1.mi@linux.intel.com,
 eric.auger@redhat.com, farman@linux.ibm.com,
 gustavo.romero@linaro.org, imammedo@redhat.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 linuxarm@huawei.com, maobibo@loongson.cn, mtosatti@redhat.com,
 peter.maydell@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, shameerali.kolothum.thodi@huawei.com,
 shannon.zhaosl@gmail.com, yangyicong@hisilicon.com, zhao1.liu@intel.com
Subject: Re: [PATCH v14 5/7] hw/acpi: add cache hierarchy to pptt table
Message-ID: <20250714061110-mutt-send-email-mst@kernel.org>
References: <20250707121908.155-1-alireza.sanaee@huawei.com>
 <20250707121908.155-6-alireza.sanaee@huawei.com>
 <20250713171146-mutt-send-email-mst@kernel.org>
 <20250714105958.000037c6.alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714105958.000037c6.alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jul 14, 2025 at 10:59:58AM +0100, Alireza Sanaee wrote:
> On Sun, 13 Jul 2025 17:15:02 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Jul 07, 2025 at 01:19:06PM +0100, Alireza Sanaee wrote:
> > > Add cache topology to PPTT table. With this patch, both ACPI PPTT
> > > table and device tree will represent the same cache topology given
> > > users input.
> > > 
> > > Co-developed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > > Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> > > ---
> > >  hw/acpi/aml-build.c            | 248
> > > +++++++++++++++++++++++++++++++-- hw/arm/virt-acpi-build.c       |
> > >  8 +- hw/loongarch/virt-acpi-build.c |   2 +-
> > >  include/hw/acpi/aml-build.h    |   4 +-
> > >  4 files changed, 249 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > > index f8f93a9f66..474f3035cb 100644
> > > --- a/hw/acpi/aml-build.c
> > > +++ b/hw/acpi/aml-build.c
> > > @@ -31,6 +31,8 @@
> > >  #include "hw/pci/pci_bus.h"
> > >  #include "hw/pci/pci_bridge.h"
> > >  #include "qemu/cutils.h"
> > > +#include "hw/acpi/cpu.h"
> > > +#include "hw/core/cpu.h"
> > >  
> > >  static GArray *build_alloc_array(void)
> > >  {
> > > @@ -2141,24 +2143,161 @@ void build_spcr(GArray *table_data,
> > > BIOSLinker *linker, }
> > >      acpi_table_end(linker, &table);
> > >  }
> > > +
> > > +static void build_cache_nodes(GArray *tbl, CPUCorePPTTCaches
> > > *cache,
> > > +                              uint32_t next_offset, unsigned int
> > > id) +{
> > > +    int val;
> > > +
> > > +    /* Type 1 - cache */
> > > +    build_append_byte(tbl, 1);
> > > +    /* Length */
> > > +    build_append_byte(tbl, 28);
> > > +    /* Reserved */
> > > +    build_append_int_noprefix(tbl, 0, 2);
> > > +    /* Flags - everything except possibly the ID */
> > > +    build_append_int_noprefix(tbl, 0xff, 4);
> > > +    /* Offset of next cache up */
> > > +    build_append_int_noprefix(tbl, next_offset, 4);
> > > +    build_append_int_noprefix(tbl, cache->size, 4);
> > > +    build_append_int_noprefix(tbl, cache->sets, 4);
> > > +    build_append_byte(tbl, cache->associativity);
> > > +    val = 0x3;
> > > +    switch (cache->type) {
> > > +    case INSTRUCTION_CACHE:
> > > +        val |= (1 << 2);
> > > +        break;
> > > +    case DATA_CACHE:
> > > +        val |= (0 << 2); /* Data */
> > > +        break;
> > > +    case UNIFIED_CACHE:
> > > +        val |= (3 << 2); /* Unified */
> > > +        break;
> > > +    }
> > > +    build_append_byte(tbl, val);
> > > +    build_append_int_noprefix(tbl, cache->linesize, 2);
> > > +    build_append_int_noprefix(tbl,
> > > +                              (cache->type << 24) | (cache->level
> > > << 16) | id,
> > > +                              4);
> > > +}
> > > +
> > > +/*
> > > + * builds caches from the top level (`level_high` parameter) to
> > > the bottom
> > > + * level (`level_low` parameter).  It searches for caches found in
> > > + * systems' registers, and fills up the table. Then it updates the
> > > + * `data_offset` and `instr_offset` parameters with the offset of
> > > the data
> > > + * and instruction caches of the lowest level, respectively.
> > > + */
> > > +static bool build_caches(GArray *table_data, uint32_t pptt_start,
> > > +                         int num_caches, CPUCorePPTTCaches *caches,
> > > +                         int base_id,
> > > +                         uint8_t level_high, /* Inclusive */
> > > +                         uint8_t level_low,  /* Inclusive */
> > > +                         uint32_t *data_offset,
> > > +                         uint32_t *instr_offset)
> > > +{
> > > +    uint32_t next_level_offset_data = 0,
> > > next_level_offset_instruction = 0;
> > > +    uint32_t this_offset, next_offset = 0;
> > > +    int c, level;
> > > +    bool found_cache = false;
> > > +
> > > +    /* Walk caches from top to bottom */
> > > +    for (level = level_high; level >= level_low; level--) {
> > > +        for (c = 0; c < num_caches; c++) {
> > > +            if (caches[c].level != level) {
> > > +                continue;
> > > +            }
> > > +
> > > +            /* Assume only unified above l1 for now */
> > > +            this_offset = table_data->len - pptt_start;
> > > +            switch (caches[c].type) {
> > > +            case INSTRUCTION_CACHE:
> > > +                next_offset = next_level_offset_instruction;
> > > +                break;
> > > +            case DATA_CACHE:
> > > +                next_offset = next_level_offset_data;
> > > +                break;
> > > +            case UNIFIED_CACHE:
> > > +                /* Either is fine here */
> > > +                next_offset = next_level_offset_instruction;
> > > +                break;
> > > +            }
> > > +            build_cache_nodes(table_data, &caches[c], next_offset,
> > > base_id);
> > > +            switch (caches[c].type) {
> > > +            case INSTRUCTION_CACHE:
> > > +                next_level_offset_instruction = this_offset;
> > > +                break;
> > > +            case DATA_CACHE:
> > > +                next_level_offset_data = this_offset;
> > > +                break;
> > > +            case UNIFIED_CACHE:
> > > +                next_level_offset_instruction = this_offset;
> > > +                next_level_offset_data = this_offset;
> > > +                break;
> > > +            }
> > > +            *data_offset = next_level_offset_data;
> > > +            *instr_offset = next_level_offset_instruction;
> > > +
> > > +            found_cache = true;
> > > +        }
> > > +    }
> > > +
> > > +    return found_cache;
> > > +}
> > > +
> > >  /*
> > >   * ACPI spec, Revision 6.3
> > >   * 5.2.29 Processor Properties Topology Table (PPTT)
> > >   */
> > >  void build_pptt(GArray *table_data, BIOSLinker *linker,
> > > MachineState *ms,
> > > -                const char *oem_id, const char *oem_table_id)
> > > +                const char *oem_id, const char *oem_table_id,
> > > +                int num_caches, CPUCorePPTTCaches *caches)
> > >  {
> > >      MachineClass *mc = MACHINE_GET_CLASS(ms);
> > >      CPUArchIdList *cpus = ms->possible_cpus;
> > > -    int64_t socket_id = -1, cluster_id = -1, core_id = -1;
> > > -    uint32_t socket_offset = 0, cluster_offset = 0, core_offset =
> > > 0;
> > > +    uint32_t core_data_offset = 0;
> > > +    uint32_t core_instr_offset = 0;
> > > +    uint32_t cluster_instr_offset = 0;
> > > +    uint32_t cluster_data_offset = 0;
> > > +    uint32_t node_data_offset = 0;
> > > +    uint32_t node_instr_offset = 0;
> > > +    int top_node = 3;
> > > +    int top_cluster = 3;
> > > +    int top_core = 3;
> > > +    int bottom_node = 3;
> > > +    int bottom_cluster = 3;
> > > +    int bottom_core = 3;
> > > +    int64_t socket_id = -1;
> > > +    int64_t cluster_id = -1;
> > > +    int64_t core_id = -1;
> > > +    uint32_t socket_offset = 0;
> > > +    uint32_t cluster_offset = 0;
> > > +    uint32_t core_offset = 0;
> > >      uint32_t pptt_start = table_data->len;
> > > +    uint32_t root_offset;
> > >      int n;
> > > +    uint32_t priv_rsrc[2];
> > > +    uint32_t num_priv = 0;
> > > +    bool cache_available;
> > > +    bool llevel;
> > > +
> > >      AcpiTable table = { .sig = "PPTT", .rev = 2,
> > >                          .oem_id = oem_id, .oem_table_id =
> > > oem_table_id }; 
> > >      acpi_table_begin(&table, table_data);
> > >  
> > > +    /*
> > > +     * Build a root node for all the processor nodes. Otherwise
> > > when  
> > 
> > This appears to use parts of
> >     Message-Id: <20250604115233.1234-4-alireza.sanaee@huawei.com>
> > 
> > which is:
> > 
> >     hw/acpi/aml-build: Build a root node in the PPTT table
> > 
> 
> Hi Michael,
> 
> I put a note on cover letter regarding the dependency.


To clarify, do you still want
20250604115233.1234-4-alireza.sanaee@huawei.com or should
I drop that too, for now?


> But I made a mistake preparing this patchset anyway. Will fix.
> 
> > 
> > but this time, without attribution, without documenting the change
> > in the commit log, and with worse grammar. What gives?
> > 
> > 
> > > +     * building a multi-socket system each socket tree are
> > > separated  
> > 
> > is separated
> 
> I think I know why this is still there, cuz I have fixed this error on
> the other patchset as this comes from the other patchset.
> 
> Will send a new version...
> 
> > 
> > > +     * and will be hard for the OS like Linux to know whether the
> > > +     * system is homogeneous.
> > > +     */
> > > +    root_offset = table_data->len - pptt_start;
> > > +    build_processor_hierarchy_node(table_data,
> > > +        (1 << 0) | /* Physical panodeckage */
> > > +        (1 << 4), /* Identical Implementation */
> > > +        0, 0, NULL, 0);
> > > +
> > >      /*
> > >       * This works with the assumption that cpus[n].props.*_id has
> > > been
> > >       * sorted from top to down levels in
> > > mc->possible_cpu_arch_ids(). @@ -2171,10 +2310,36 @@ void
> > > build_pptt(GArray *table_data, BIOSLinker *linker, MachineState
> > > *ms, socket_id = cpus->cpus[n].props.socket_id; cluster_id = -1;
> > >              core_id = -1;
> > > +            bottom_node = top_node;
> > > +            num_priv = 0;
> > > +            cache_available =
> > > +                machine_defines_cache_at_topo_level(ms,
> > > +
> > > CPU_TOPOLOGY_LEVEL_SOCKET);
> > > +            llevel =
> > > machine_find_lowest_level_cache_at_topo_level(ms,
> > > +                        &bottom_node,
> > > +                        CPU_TOPOLOGY_LEVEL_SOCKET);
> > > +            if (cache_available && llevel) {
> > > +                build_caches(table_data, pptt_start,
> > > +                             num_caches, caches,
> > > +                             n, top_node, bottom_node,
> > > +                             &node_data_offset,
> > > &node_instr_offset); +
> > > +                priv_rsrc[0] = node_instr_offset;
> > > +                priv_rsrc[1] = node_data_offset;
> > > +
> > > +                if (node_instr_offset || node_data_offset) {
> > > +                    num_priv = node_instr_offset ==
> > > node_data_offset ? 1 : 2;
> > > +                }
> > > +
> > > +                top_cluster = bottom_node - 1;
> > > +            }
> > > +
> > >              socket_offset = table_data->len - pptt_start;
> > >              build_processor_hierarchy_node(table_data,
> > > -                (1 << 0), /* Physical package */
> > > -                0, socket_id, NULL, 0);
> > > +                (1 << 0) | /* Physical package */
> > > +                (1 << 4), /* Identical Implementation */
> > > +                root_offset, socket_id,
> > > +                priv_rsrc, num_priv);
> > >          }
> > >  
> > >          if (mc->smp_props.clusters_supported &&
> > > mc->smp_props.has_clusters) { @@ -2182,28 +2347,91 @@ void
> > > build_pptt(GArray *table_data, BIOSLinker *linker, MachineState
> > > *ms, assert(cpus->cpus[n].props.cluster_id > cluster_id);
> > > cluster_id = cpus->cpus[n].props.cluster_id; core_id = -1;
> > > +                bottom_cluster = top_cluster;
> > > +                num_priv = 0;
> > > +                cache_available =
> > > +                    machine_defines_cache_at_topo_level(ms,
> > > +                        CPU_TOPOLOGY_LEVEL_CLUSTER);
> > > +                llevel =
> > > machine_find_lowest_level_cache_at_topo_level(ms,
> > > +                            &bottom_cluster,
> > > +                            CPU_TOPOLOGY_LEVEL_CLUSTER);
> > > +
> > > +                if (cache_available && llevel) {
> > > +
> > > +                    build_caches(table_data, pptt_start,
> > > +                                 num_caches, caches, n,
> > > top_cluster,
> > > +                                 bottom_cluster,
> > > &cluster_data_offset,
> > > +                                 &cluster_instr_offset);
> > > +
> > > +                    priv_rsrc[0] = cluster_instr_offset;
> > > +                    priv_rsrc[1] = cluster_data_offset;
> > > +
> > > +                    if (cluster_instr_offset ||
> > > cluster_data_offset) {
> > > +                        num_priv =
> > > +                        cluster_instr_offset ==
> > > cluster_data_offset ? 1 : 2;
> > > +                    }
> > > +
> > > +                    top_core = bottom_cluster - 1;
> > > +                } else if (top_cluster == bottom_node - 1) {
> > > +                    /* socket cache but no cluster cache */
> > > +                    top_core = bottom_node - 1;
> > > +                }
> > > +
> > >                  cluster_offset = table_data->len - pptt_start;
> > >                  build_processor_hierarchy_node(table_data,
> > > -                    (0 << 0), /* Not a physical package */
> > > -                    socket_offset, cluster_id, NULL, 0);
> > > +                    (0 << 0) | /* Not a physical package */
> > > +                    (1 << 4), /* Identical Implementation */
> > > +                    socket_offset, cluster_id,
> > > +                    priv_rsrc, num_priv);
> > >              }
> > >          } else {
> > > +            if (machine_defines_cache_at_topo_level(ms,
> > > +                    CPU_TOPOLOGY_LEVEL_CLUSTER)) {
> > > +                error_setg(&error_fatal, "Not clusters found for
> > > the cache");
> > > +                return;
> > > +            }
> > > +
> > >              cluster_offset = socket_offset;
> > > +            top_core = bottom_node - 1; /* there is no cluster */
> > > +        }
> > > +
> > > +        if (cpus->cpus[n].props.core_id != core_id) {
> > > +            bottom_core = top_core;
> > > +            num_priv = 0;
> > > +            cache_available =
> > > +                machine_defines_cache_at_topo_level(ms,
> > > CPU_TOPOLOGY_LEVEL_CORE);
> > > +            llevel =
> > > machine_find_lowest_level_cache_at_topo_level(ms,
> > > +                        &bottom_core, CPU_TOPOLOGY_LEVEL_CORE);
> > > +
> > > +            if (cache_available && llevel) {
> > > +                build_caches(table_data, pptt_start,
> > > +                             num_caches, caches,
> > > +                             n, top_core, bottom_core,
> > > +                             &core_data_offset,
> > > &core_instr_offset); +
> > > +                priv_rsrc[0] = core_instr_offset;
> > > +                priv_rsrc[1] = core_data_offset;
> > > +
> > > +                num_priv = core_instr_offset == core_data_offset ?
> > > 1 : 2;
> > > +            }
> > >          }
> > >  
> > >          if (ms->smp.threads == 1) {
> > >              build_processor_hierarchy_node(table_data,
> > >                  (1 << 1) | /* ACPI Processor ID valid */
> > >                  (1 << 3),  /* Node is a Leaf */
> > > -                cluster_offset, n, NULL, 0);
> > > +                cluster_offset, n,
> > > +                priv_rsrc, num_priv);
> > >          } else {
> > >              if (cpus->cpus[n].props.core_id != core_id) {
> > >                  assert(cpus->cpus[n].props.core_id > core_id);
> > >                  core_id = cpus->cpus[n].props.core_id;
> > >                  core_offset = table_data->len - pptt_start;
> > >                  build_processor_hierarchy_node(table_data,
> > > -                    (0 << 0), /* Not a physical package */
> > > -                    cluster_offset, core_id, NULL, 0);
> > > +                    (0 << 0) | /* Not a physical package */
> > > +                    (1 << 4), /* Identical Implementation */
> > > +                    cluster_offset, core_id,
> > > +                    priv_rsrc, num_priv);
> > >              }
> > >  
> > >              build_processor_hierarchy_node(table_data,
> > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > > index cd90c47976..a9b5aeac49 100644
> > > --- a/hw/arm/virt-acpi-build.c
> > > +++ b/hw/arm/virt-acpi-build.c
> > > @@ -962,6 +962,11 @@ void virt_acpi_build(VirtMachineState *vms,
> > > AcpiBuildTables *tables) GArray *tables_blob = tables->table_data;
> > >      MachineState *ms = MACHINE(vms);
> > >  
> > > +    CPUCorePPTTCaches caches[CPU_MAX_CACHES];
> > > +    unsigned int num_caches;
> > > +
> > > +    num_caches = virt_get_caches(vms, caches);
> > > +
> > >      table_offsets = g_array_new(false, true /* clear */,
> > >                                          sizeof(uint32_t));
> > >  
> > > @@ -983,7 +988,8 @@ void virt_acpi_build(VirtMachineState *vms,
> > > AcpiBuildTables *tables) if (!vmc->no_cpu_topology) {
> > >          acpi_add_table(table_offsets, tables_blob);
> > >          build_pptt(tables_blob, tables->linker, ms,
> > > -                   vms->oem_id, vms->oem_table_id);
> > > +                   vms->oem_id, vms->oem_table_id,
> > > +                   num_caches, caches);
> > >      }
> > >  
> > >      acpi_add_table(table_offsets, tables_blob);
> > > diff --git a/hw/loongarch/virt-acpi-build.c
> > > b/hw/loongarch/virt-acpi-build.c index 2cd2d9d842..dd34a520c7 100644
> > > --- a/hw/loongarch/virt-acpi-build.c
> > > +++ b/hw/loongarch/virt-acpi-build.c
> > > @@ -552,7 +552,7 @@ static void acpi_build(AcpiBuildTables *tables,
> > > MachineState *machine) 
> > >      acpi_add_table(table_offsets, tables_blob);
> > >      build_pptt(tables_blob, tables->linker, machine,
> > > -               lvms->oem_id, lvms->oem_table_id);
> > > +               lvms->oem_id, lvms->oem_table_id, 0, NULL);
> > >  
> > >      acpi_add_table(table_offsets, tables_blob);
> > >      build_srat(tables_blob, tables->linker, machine);
> > > diff --git a/include/hw/acpi/aml-build.h
> > > b/include/hw/acpi/aml-build.h index 6fa2e1eedf..3429cdae71 100644
> > > --- a/include/hw/acpi/aml-build.h
> > > +++ b/include/hw/acpi/aml-build.h
> > > @@ -3,6 +3,7 @@
> > >  
> > >  #include "hw/acpi/acpi-defs.h"
> > >  #include "hw/acpi/bios-linker-loader.h"
> > > +#include "hw/cpu/core.h"
> > >  
> > >  #define ACPI_BUILD_APPNAME6 "BOCHS "
> > >  #define ACPI_BUILD_APPNAME8 "BXPC    "
> > > @@ -499,7 +500,8 @@ void build_slit(GArray *table_data, BIOSLinker
> > > *linker, MachineState *ms, typedef struct CPUPPTTCaches
> > > CPUCorePPTTCaches; 
> > >  void build_pptt(GArray *table_data, BIOSLinker *linker,
> > > MachineState *ms,
> > > -                const char *oem_id, const char *oem_table_id);
> > > +                const char *oem_id, const char *oem_table_id,
> > > +                int num_caches, CPUCorePPTTCaches *caches);
> > >  
> > >  void build_fadt(GArray *tbl, BIOSLinker *linker, const
> > > AcpiFadtData *f, const char *oem_id, const char *oem_table_id);
> > > -- 
> > > 2.43.0  
> > 
> > 


