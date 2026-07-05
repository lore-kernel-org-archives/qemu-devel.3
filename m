Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E85AC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNw2-0005DT-UP; Sun, 05 Jul 2026 10:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNw2-0005D6-2g
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNw0-00018Z-AJ
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J0MKVmrch/pvBo8melADVF6zAaT/qDBqYQukgYg8kKY=;
 b=Z5rY2aXaq77kai6tMCjQTAPtR+35mvlZychgHPOoDxoKYTYaeuQrtdxgfq5E5EcSyWvbKh
 5m9bqXWAv/mlFoQvfA/11noE+DnyOcuFNlMoDrmW7mhkZdaX/7i5+8v5s+WXLdheKfIZET
 Ve6QKeVl9GSsWrx9m+151BvDe4Flrok=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-gawYNeLzMmK22axxNY3Ysw-1; Sun, 05 Jul 2026 10:35:02 -0400
X-MC-Unique: gawYNeLzMmK22axxNY3Ysw-1
X-Mimecast-MFC-AGG-ID: gawYNeLzMmK22axxNY3Ysw_1783262101
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490a767c7dcso16872705e9.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262101; x=1783866901; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J0MKVmrch/pvBo8melADVF6zAaT/qDBqYQukgYg8kKY=;
 b=AqC3vpB90IS4oCd4Hf3BlZKQc8WGYsccZtHYHoYhshz9PNR1wFTeFmDcBbPP8Y9hnF
 xfSWF8HsVslK/pirez0jy18A059TvS5dUGyk5DXQdip49ilSpBCAWkVUuuLjdRAksGym
 YGmvWOCphicAEvfjBuyTcWAyIOq7jzJgPw4Os6Cgcrz6oTyK7M7Mn6HY0sk3v0MV37Ty
 kIwEnlSoJkYt3R/G44Vxn6TmSVHKY1w3ZZ4YWXfQGG2vwDQtZofV0+1A4gbOY+jR9n2Y
 bOLqDkoZHCvteIbDpTvO3ESAe/MBBmhIGp4y01cw9ZpLBn0X2idDzm0WFQFohaXxMBZ+
 eLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262101; x=1783866901;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J0MKVmrch/pvBo8melADVF6zAaT/qDBqYQukgYg8kKY=;
 b=JHNJOk3BEpAPZqAHinV2UH7BF9Ndrfhz83plZFuW5eJYG4ChnzKFHCSiPQXMMhvSmS
 pyYL4X4yrHR/vIl4ePt8/oiYmRapb6dE0xzhil0PNfzwo/nLLpTmp0kLJJv3QbtpQ0Js
 l/l+o1LMOYvCBNmliCkThr76Z0voDIIgFhvKOsdaewAeYraEh2jgZt94etS+6OaYpwnR
 nSFbtEnHcOC0n+Y7e3qYpCr/tQic+J9b5W3WAX3hA1VfXlZK0S7/8fcxfyQxG5DN9mgA
 k+iUVcWNY9Xbj0oxQ8XSKhUrQ5GQUeJx4b6RsWcwsdBWirjLiN7gV2fxS1Rxbb2r6Z9I
 rnTw==
X-Gm-Message-State: AOJu0Yy9l/6YHajiac2cdGWS9bwdpY7iT06naAYZLA2sPgyhPffR7dWD
 Dv9f2L2hGcNZ5OCKdq2U3SsvjeQxJRNfkxDVG8KJqryctSOqQ9pjay76n/uB5FirIDSddrD42/b
 2oqOiP85PP3tQ9eDIs8c0ADczxig1P9eM3HIhaqDvIMEQNqR9AeCzL0cvaAfrbBIIJEiaJnDOtc
 k17FThiizYzPJe5uh/2TNSOXfx6u9yO8tQBg==
X-Gm-Gg: AfdE7ck+7isRdVwVyC7TQOn9fYL8Nqrv/UnIuwj1h7SY+mxgrg4mvddRglh7FO4J7+b
 NB+CN3HYIbXyic/6N35vO8teHHYU6ABwrkb/G7k/cVjMamuvC1uGDS/NeMbYhsD/ZNZKDarkH4s
 l/+GVMmlWHZvKQDia/9skVLGUO0vQJBkke7wpfYKumJAJTtsubV4AL9uDJhveK/A9sc2DwR+jJe
 kJUt1W0f39+ahOUkIgjKPFj6Y+yAImoBNc7qpbynX9gudu82H4fziaOoBoApLijQykdEBdxByCE
 i4KiidiIqjjLmFKR3vj9s9y5G6HX3Ucbcnhl/fWsO7Im9DNRGZ/LBK3JZghLhLZElhmQdCXpICb
 Sf1diozi84GZii8TM00HDR4uhv9UzHUwd
X-Received: by 2002:a05:600c:c0d1:10b0:493:bb23:152a with SMTP id
 5b1f17b1804b1-493d11fe189mr56804225e9.34.1783262100856; 
 Sun, 05 Jul 2026 07:35:00 -0700 (PDT)
X-Received: by 2002:a05:600c:c0d1:10b0:493:bb23:152a with SMTP id
 5b1f17b1804b1-493d11fe189mr56803945e9.34.1783262100356; 
 Sun, 05 Jul 2026 07:35:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c0e92687sm301930125e9.0.2026.07.05.07.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:34:59 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:34:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 fanhuang <FangSheng.Huang@amd.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/44] i386/acpi-build: partition device_memory SRAT umbrella
 for sp-mem
Message-ID: <78f08a0f47e787921d8beb78a5bade9a8a64400b.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: fanhuang <FangSheng.Huang@amd.com>

Restructure the device_memory SRAT umbrella entry into a per-kind
partition: each TYPE_SP_MEM device gets an ENABLED entry at its own
proximity_domain; the remaining sub-ranges get HOTPLUGGABLE | ENABLED
placeholders at the highest PXM, preserving the existing umbrella
convention.

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260623075051.3797975-4-FangSheng.Huang@amd.com>
---
 hw/i386/acpi-build.c | 96 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 4 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2ee061558c..8837b69687 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -52,6 +52,7 @@
 #include "migration/vmstate.h"
 #include "hw/mem/memory-device.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/mem/sp-mem.h"
 #include "system/numa.h"
 #include "system/reset.h"
 #include "hw/hyperv/vmbus-bridge.h"
@@ -1351,6 +1352,96 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker *linker, GArray *tcpalog,
 }
 #endif
 
+typedef struct {
+    uint64_t addr;
+    uint64_t size;
+    uint32_t node;
+} SpMemRange;
+
+static int sp_mem_collect_ranges_cb(Object *obj, void *opaque)
+{
+    GArray *ranges = opaque;
+    SpMemDevice *spm;
+    MemoryDeviceClass *mdc;
+    SpMemRange r;
+
+    if (!object_dynamic_cast(obj, TYPE_SP_MEM)) {
+        return 0;
+    }
+    spm = SP_MEM(obj);
+    mdc = MEMORY_DEVICE_GET_CLASS(MEMORY_DEVICE(spm));
+    r.addr = mdc->get_addr(MEMORY_DEVICE(spm));
+    r.size = memory_region_size(
+                 host_memory_backend_get_memory(spm->hostmem));
+    r.node = spm->node;
+    g_array_append_val(ranges, r);
+    return 0;
+}
+
+static gint sp_mem_range_compare(gconstpointer a, gconstpointer b)
+{
+    const SpMemRange *range_a = a;
+    const SpMemRange *range_b = b;
+
+    if (range_a->addr < range_b->addr) {
+        return -1;
+    }
+    if (range_a->addr > range_b->addr) {
+        return 1;
+    }
+    return 0;
+}
+
+/*
+ * Emit SRAT memory-affinity entries covering the device_memory region.
+ *
+ * For each plugged TYPE_SP_MEM device, emit an ENABLED entry at the
+ * device's own proximity_domain.  All remaining sub-ranges (gaps
+ * between sp-mem devices, leading and trailing padding, and ranges
+ * occupied by other memory devices) are covered by HOTPLUGGABLE |
+ * ENABLED placeholder entries at PXM = nb_numa_nodes - 1.
+ */
+static void build_srat_device_memory(GArray *table_data, MachineState *ms)
+{
+    g_autoptr(GArray) ranges = g_array_new(FALSE, TRUE, sizeof(SpMemRange));
+    uint32_t hotplug_pxm = ms->numa_state->num_nodes - 1;
+    uint64_t region_start, region_end;
+    guint i;
+
+    region_start = ms->device_memory->base;
+    region_end = region_start + memory_region_size(&ms->device_memory->mr);
+
+    object_child_foreach_recursive(qdev_get_machine(),
+                                   sp_mem_collect_ranges_cb, ranges);
+    g_array_sort(ranges, sp_mem_range_compare);
+
+    for (i = 0; i < ranges->len; i++) {
+        SpMemRange *r = &g_array_index(ranges, SpMemRange, i);
+
+        if (region_start < r->addr) {
+            build_srat_memory(table_data, region_start, r->addr - region_start,
+                              hotplug_pxm,
+                              MEM_AFFINITY_HOTPLUGGABLE |
+                              MEM_AFFINITY_ENABLED);
+        }
+        build_srat_memory(table_data, r->addr, r->size, r->node,
+                          MEM_AFFINITY_ENABLED);
+        region_start = r->addr + r->size;
+    }
+
+    /*
+     * Cover the rest of the device_memory window that no sp-mem device
+     * occupies. Keeping it HOTPLUGGABLE preserves the umbrella entry's
+     * role for future pc-dimm / virtio-mem hot-add into this window.
+     */
+    if (region_start < region_end) {
+        build_srat_memory(table_data, region_start, region_end - region_start,
+                          hotplug_pxm,
+                          MEM_AFFINITY_HOTPLUGGABLE |
+                          MEM_AFFINITY_ENABLED);
+    }
+}
+
 #define HOLE_640K_START  (640 * KiB)
 #define HOLE_640K_END   (1 * MiB)
 
@@ -1487,10 +1578,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
      * providing _PXM method if necessary.
      */
     if (machine->device_memory) {
-        build_srat_memory(table_data, machine->device_memory->base,
-                          memory_region_size(&machine->device_memory->mr),
-                          nb_numa_nodes - 1,
-                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
+        build_srat_device_memory(table_data, machine);
     }
 
     acpi_table_end(linker, &table);
-- 
MST


