Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16A2606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 02:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nSjZsXry
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO4Z8-0005G5-OZ; Mon, 02 Nov 2026 21:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO4Z7-0005Fg-H2; Mon, 02 Nov 2026 21:48:01 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO4Z5-00020d-Mn; Mon, 02 Nov 2026 21:48:01 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C80F241AC8;
 Tue,  3 Nov 2026 02:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEFA1F000C1;
 Tue,  3 Nov 2026 02:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793674077;
 bh=g1jETx/PFI3usyqE1OuA6Z4jBvBxp7m465cRSmf7esg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=nSjZsXry28m6uGK9VxwtzzMGDtHKGT56f/CTWIboZ4JGLDd7K6Fqt8OZ0HW5rkdIK
 c5sh2aA5KPIgu+MV4fM8rNUtYZ+kBGtkGechLQVinXGAlGJ0J4dopbxFQ+q20cNExE
 MRvNDHtLjPqagF5X8E23e5PDNY+PvOezCIEl22Bw+MHpjD1BEU4Geyg9TP6PyYMyTO
 pX+81NHxm9zU4EbGDoTw1QyksraIqzY+yNzJGgS9JmVHGtDxI0CVv1demZix2xlr3e
 kgvbLT+nVzqRs/GuIJD2xUZsuDRvMMNrYg+mT/1UymlBWecKoUWKkpdW+hYr2KCY50
 Db0wBkvA+lmmg==
Date: Tue, 3 Nov 2026 02:47:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 23/37] hw/acpi: Build the MPAM ACPI table
Message-ID: <20261103024750.35a367ca@jic23-hlaptop>
In-Reply-To: <tencent_CCF4A4F14E44206EDE9A4871CF981EA7AE0A@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
 <tencent_CCF4A4F14E44206EDE9A4871CF981EA7AE0A@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 18:10:43 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Assemble the MPAM table when vms->mpam is set: walk the QOM tree
> for the board-created MSCs and emit each as a memory-controller or
> cache-controller node with its MMIO base, wired interrupt GSIVs
> and per-RIS locators -- per-node instances scope their locator to
> their own NUMA node, single-MSC instances span every memory node,
> and cache nodes carry the PPTT-referencing cache id.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

One thing around IDs I don't follow. See below.

> ---
>  hw/arm/virt-acpi-build.c | 101 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 871ee45..3b71af9 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -985,6 +985,102 @@ static void build_msc_cache_controller(GArray *table_data, int identifier,
>      }
>  }
>  
> +struct mpam_stat {
> +    MachineState *ms;
> +    GArray *table_data;
> +    hwaddr base_addr;
> +    int count;
> +    int cpu_count;
> +    uint32_t mpam_id; /* Just needs to be unique */
> +};
> +
> +static int mpam_add_msc(Object *obj, void *opaque)
> +{
> +    if (object_dynamic_cast(obj, TYPE_MPAM_MSC_MEM)) {
> +        struct mpam_stat *mpam_s = opaque;
> +        SysBusDevice *s = SYS_BUS_DEVICE(obj);
> +        int num_ris = object_property_get_uint(obj, "num-ris", &error_fatal);
> +        uint32_t oflow_gsiv = object_property_get_uint(obj, "oflow-gsiv",
> +                                                       &error_fatal);
> +        uint32_t err_gsiv = object_property_get_uint(obj, "err-gsiv",
> +                                                     &error_fatal);
> +        uint64_t *ids = g_new0(uint64_t, num_ris);
> +        int j = 0;
> +        int i;
> +
> +        /*
> +         * Locator for each RIS.  A per-node instance (node property set)
> +         * covers exactly its own NUMA node; a single-MSC instance spans
> +         * every memory-bearing node, one RIS each.
> +         */
> +        if (object_property_get_uint(obj, "node", &error_fatal) != UINT16_MAX) {
> +            ids[j++] = object_property_get_uint(obj, "node", &error_fatal);

I'm confused.  Why are we setting one id here and the rest below?  What is this
first id?

> +        }
> +        for (i = 0; i < mpam_s->ms->numa_state->num_nodes; i++) {

       for (int i = 0;
to keep the scope clearly defined.

> +            if (j >= num_ris) {
> +                break;
> +            }
> +            if (mpam_s->ms->numa_state->nodes[i].node_mem) {
> +                ids[j++] = i;
> +            }
> +        }
> +
> +        build_msc_memory_controller(mpam_s->table_data, mpam_s->count,
> +                                    s->mmio[0].addr, mpam_s->mpam_id++,
> +                                    num_ris, ids, oflow_gsiv, err_gsiv);
> +        mpam_s->count++;
> +        g_free(ids);
> +    }
> +
> +    if (object_dynamic_cast(obj, TYPE_MPAM_MSC_CACHE)) {
> +        struct mpam_stat *mpam_s = opaque;
> +        SysBusDevice *s = SYS_BUS_DEVICE(obj);
> +        int num_ris = 1;
> +        uint64_t *ids = g_new0(uint64_t, num_ris);
> +        uint8_t cache_level = object_property_get_uint(obj, "cache-level",
> +                                                       &error_fatal);
> +        uint8_t cache_type = object_property_get_uint(obj, "cache-type",
> +                                                      &error_fatal);
> +        uint16_t cpu = object_property_get_uint(obj, "cpu", &error_fatal);
> +        uint32_t oflow_gsiv = object_property_get_uint(obj, "oflow-gsiv",
> +                                                       &error_fatal);
> +        uint32_t err_gsiv = object_property_get_uint(obj, "err-gsiv",
> +                                                     &error_fatal);
> +
> +        ids[0] = PPTT_CACHE_ID(cache_type, cache_level, cpu);
> +        build_msc_cache_controller(mpam_s->table_data, mpam_s->count,
> +                                   s->mmio[0].addr, mpam_s->mpam_id++,
> +                                   num_ris, ids, oflow_gsiv, err_gsiv);
> +        mpam_s->count++;
> +        g_free(ids);
> +    }
> +
> +    return 0;
> +}
> +
> +static void
> +build_mpam(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> +{
> +    AcpiTable table = {
> +        .sig = "MPAM",
> +        .rev = 1,

Is there a reason not to go directly to a newer version?
Doesn't seem like that much changed and it might save us some churn at 
somepoint such as when adding mpam_fb option.

> +        .oem_id = vms->oem_id,
> +        .oem_table_id = vms->oem_table_id,
> +    };
> +    struct mpam_stat mpam_s = {
> +        .ms = MACHINE(vms),
> +        .count = 0,
> +        .base_addr = vms->memmap[VIRT_MPAM_MSC].base,
> +        .table_data = table_data,
> +    };
> +
> +    acpi_table_begin(&table, table_data);
> +
> +    object_child_foreach_recursive(object_get_root(), mpam_add_msc, &mpam_s);
> +
> +    acpi_table_end(linker, &table);
> +}


