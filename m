Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634BFCD6E7B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 21:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVc4i-0007oc-EP; Fri, 05 Jun 2026 17:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1wVc4c-0007jg-Dr
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 17:27:28 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1wVc4Y-0006Zv-H8
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 17:27:25 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e6cdd78fe6so1228558a34.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 14:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1780694840; x=1781299640; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sGJ2zWdTQy5OMVXgDnK58g5j7YQaI1xNZsT8+Cr2GU8=;
 b=BQxxch/4mHrVBXaqOs2mCTRSkUn+O4d+HJ2UEiKiKa+VDOIn6cmmoJVZtRwe/X95r/
 n+tTduJvpIhfmjT12+gk9+Gd7ATvip0u2O/28QbFI10M0p9PVrzVGSWUs9n7ztyv3ZFT
 udCucdoZ4ZYsU1PELmMYZuHnE9+vGUkjoriBc9gzBgkB/kioRft6z7dbfQ1Pg0naPVtr
 h8pOgs+lm8mDRk0sVPEi+rTIRvu+RViqD/SbiN7GhYr7jzJqA2HJOOLF/ox9qv8ODYqB
 G3pPZQULT+HFx8LB7Mj5Qg3TDdzy6Jla3G3OXSEPmtV7KeytAQhTyGwLcDhu9+3hJ/vZ
 Yrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780694840; x=1781299640;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sGJ2zWdTQy5OMVXgDnK58g5j7YQaI1xNZsT8+Cr2GU8=;
 b=gl4QNOUilSSFTrDgPf0EgU8wFwykLVjfsPLeEomGMyRgytMWvDE+c458DvMS/OOApo
 dFjQqgzuzm90uQi6P0nCIjVOLe/sEA704m5U2Mx+OuL8b6qFC0ANHHdSnRfq7XK1LrtB
 MM4eQ/2cV7ppHaCC0rz/lGQC82kg0NAgpvVITIaWuuCqzP7ed6Ei2bYtKpUThWI5j8MP
 UnCsw1ycGXnX7KJF1mMDZsJ5X+npx+UvhvGwB8Go7tCBo6TK3uJsM203Zp8i9CSWJnt/
 XikTRr51t4MCojayLdw7mQAOOtTHRUIgJwfwXKK4FBrI641NsfR4TdYYoMlgJc0JrOjd
 B8CQ==
X-Gm-Message-State: AOJu0YwYOS+k2DQuh/9RAT0ZsPc4gE+qXTWqpQ8z2kDXAdWpXecVb7BW
 sJ3jPWscGle048w9Um/Vm82Xqj8NzaXMDY2BsIDNzQvex19H7ObZ7PWjVu8djQQMBes=
X-Gm-Gg: Acq92OEj3Q8JAq8p8btqs2xaGDJI5isAx+oGxqX0ahZUy1vR/4rQP306xPuol7tKRpu
 AkCvDcmW4MZkD9bCkBmivNDljw49ofXETnh0Z4sY/JgXwKEpE34xkN0AWjx/b23dzO6rbmJtM4f
 4ZZlp/1idHspQGizOwQpbvnkeuOKjD6vm+y7x6pFGyGZ5hUPwdDRH9uCl7TD0zvK0v0cFJKaak8
 kkH921N0fS8xnR8Upud1a65/egMJX5PCll88tSbgYFdx87vUezkNcwbevBY0knNvmxeF2kMigJH
 C5tWuMGQQyMQkhCQItkuMEAwWnW/btfYnlaYJLj2kWYtJRsT6nNZKy+suChBpQr/jjatTVtzEUx
 KIU90FOtkhR/jsXJI0CItdlk8UthbDebrx4YKT1dNordDqRVbKyZlNEFes3NgLbIvtXcXsaT7Xc
 peaV4ibrLUJtGS0mhKaFOwCFwAf683Rmgs1S7LROqZxQxMC+/wKQXhWD6XnZmgpIrPiCK/32qVK
 Af49TIFuj03Pyc53g==
X-Received: by 2002:a05:6830:2b09:b0:7dc:c7aa:22c7 with SMTP id
 46e09a7af769-7e70c3e4ac0mr3235786a34.0.1780694839728; 
 Fri, 05 Jun 2026 14:27:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e74b5e80sm6694964a34.7.2026.06.05.14.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 14:27:19 -0700 (PDT)
Date: Fri, 5 Jun 2026 22:27:16 +0100
From: Gregory Price <gourry@gourry.net>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: qemu-devel@nongnu.org, david@kernel.org, imammedo@redhat.com,
 philmd@mailo.com, Zhigang.Luo@amd.com, Lianjie.Shi@amd.com
Subject: Re: [PATCH v10 2/4] i386/acpi-build: partition device_memory SRAT
 umbrella for sp-mem
Message-ID: <aiM_NHx0a6x95KtP@gourry-fedora-PF4VCD3F>
References: <20260605104609.1739911-1-FangSheng.Huang@amd.com>
 <20260605104609.1739911-3-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605104609.1739911-3-FangSheng.Huang@amd.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=gourry@gourry.net; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jun 05, 2026 at 06:46:07PM +0800, fanhuang wrote:
> Restructure the device_memory SRAT umbrella entry into a per-kind
> partition: each TYPE_SP_MEM device gets an ENABLED entry at its own
> proximity_domain; the remaining sub-ranges get HOTPLUGGABLE | ENABLED
> placeholders at the highest PXM, preserving the existing umbrella
> convention.
> 
> Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
> ---
>  hw/i386/acpi-build.c | 98 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 92 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 0d7c83d5e9..76efa83808 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -52,6 +52,7 @@
>  #include "migration/vmstate.h"
>  #include "hw/mem/memory-device.h"
>  #include "hw/mem/nvdimm.h"
> +#include "hw/mem/sp-mem.h"
>  #include "system/numa.h"
>  #include "system/reset.h"
>  #include "hw/hyperv/vmbus-bridge.h"
> @@ -1346,6 +1347,96 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker *linker, GArray *tcpalog,
>  }
>  #endif
>  
> +typedef struct {
> +    uint64_t addr;
> +    uint64_t size;
> +    uint32_t node;
> +} SpMemRange;
> +
> +static int collect_sp_mem_ranges_cb(Object *obj, void *opaque)
> +{
> +    GArray *ranges = opaque;
> +    SpMemDevice *spm;
> +    MemoryDeviceClass *mdc;
> +    SpMemRange r;
> +
> +    if (!object_dynamic_cast(obj, TYPE_SP_MEM)) {
> +        return 0;
> +    }
> +    spm = SP_MEM(obj);
> +    mdc = MEMORY_DEVICE_GET_CLASS(MEMORY_DEVICE(spm));
> +    r.addr = mdc->get_addr(MEMORY_DEVICE(spm));
> +    r.size = memory_region_size(
> +                 host_memory_backend_get_memory(spm->hostmem));
> +    r.node = spm->node;
> +    g_array_append_val(ranges, r);
> +    return 0;
> +}
> +
> +static gint sp_mem_range_compare(gconstpointer a, gconstpointer b)
> +{
> +    const SpMemRange *range_a = a;
> +    const SpMemRange *range_b = b;
> +
> +    if (range_a->addr < range_b->addr) {
> +        return -1;
> +    }
> +    if (range_a->addr > range_b->addr) {
> +        return 1;
> +    }
> +    return 0;
> +}
> +
> +/*
> + * Emit SRAT memory-affinity entries covering the device_memory region.
> + *
> + * For each plugged TYPE_SP_MEM device, emit an ENABLED entry at the
> + * device's own proximity_domain.  All remaining sub-ranges (gaps
> + * between sp-mem devices, leading and trailing padding, and ranges
> + * occupied by other memory devices) are covered by HOTPLUGGABLE |
> + * ENABLED placeholder entries at PXM = nb_numa_nodes - 1.
> + */
> +static void build_srat_device_memory(GArray *table_data, MachineState *ms)
> +{
> +    g_autoptr(GArray) ranges = g_array_new(FALSE, TRUE, sizeof(SpMemRange));
> +    uint64_t cursor, end;
> +    int nb_nodes = ms->numa_state ? ms->numa_state->num_nodes : 0;
> +    uint32_t hotplug_pxm = nb_nodes > 0 ? nb_nodes - 1 : 0;
> +    guint i;
> +
> +    if (!ms->device_memory) {
> +        return;
> +    }
> +
> +    cursor = ms->device_memory->base;
> +    end = cursor + memory_region_size(&ms->device_memory->mr);
> +
> +    object_child_foreach_recursive(qdev_get_machine(),
> +                                   collect_sp_mem_ranges_cb, ranges);
> +    g_array_sort(ranges, sp_mem_range_compare);
> +
> +    for (i = 0; i < ranges->len; i++) {
> +        SpMemRange *r = &g_array_index(ranges, SpMemRange, i);
> +
> +        if (cursor < r->addr) {
> +            build_srat_memory(table_data, cursor, r->addr - cursor,
> +                              hotplug_pxm,
> +                              MEM_AFFINITY_HOTPLUGGABLE |
> +                              MEM_AFFINITY_ENABLED);
> +        }
> +        build_srat_memory(table_data, r->addr, r->size, r->node,
> +                          MEM_AFFINITY_ENABLED);
> +        cursor = r->addr + r->size;
> +    }
> +

Should we expect (cursor == end) here and fire a warning if there wasn't
a full range to cover the region?  If not - why set it all as
hotpluggable anyway?

(Maybe just worth a comment here what the last block is actually doing)

> +    if (cursor < end) {
> +        build_srat_memory(table_data, cursor, end - cursor,
> +                          hotplug_pxm,
> +                          MEM_AFFINITY_HOTPLUGGABLE |
> +                          MEM_AFFINITY_ENABLED);
> +    }
> +}
> +
>  #define HOLE_640K_START  (640 * KiB)
>  #define HOLE_640K_END   (1 * MiB)
>  
> @@ -1481,12 +1572,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>       * Memory devices may override proximity set by this entry,
>       * providing _PXM method if necessary.
>       */
> -    if (machine->device_memory) {
> -        build_srat_memory(table_data, machine->device_memory->base,
> -                          memory_region_size(&machine->device_memory->mr),
> -                          nb_numa_nodes - 1,
> -                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
> -    }
> +    build_srat_device_memory(table_data, machine);
>  
>      acpi_table_end(linker, &table);
>  }
> -- 
> 2.34.1
> 

