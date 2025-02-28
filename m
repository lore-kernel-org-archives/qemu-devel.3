Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0613FC282D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 20:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to6bf-0004xV-JO; Fri, 28 Feb 2025 15:05:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <37RbCZwgKCmgcNKTJXOQMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--whendrik.bounces.google.com>)
 id 1to6ba-0004pv-4N
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 15:05:06 -0500
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <37RbCZwgKCmgcNKTJXOQMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--whendrik.bounces.google.com>)
 id 1to6bY-0000yA-51
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 15:05:05 -0500
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-4393e89e910so14582635e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 12:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740773101; x=1741377901; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=hyuNddXB12O2QD6cZesmxd3qfxmTAioxmOYCYIQvpfA=;
 b=pc9MA2vkg2yUqo/AwICBPuYwEI6qJCFRoFCjdXlcZlSc+wnlqlP/LCCiScXQ/bLoen
 bkdL/GKN6xMqiaRlE+5wCqGo3iht4ImEYc8eE02uNsquRZcBHADR7CkFfsG3MiFK2135
 PwvOUBE9O6mVcC5NQXsFpltOj5ywnDX49++aYt6Ay8GMwEk8B8oIlqoY2Nel8If3qAOz
 i3Z5m233TR/A4W30JKCzQfYMUIbuDxUAMmat06mOKrTB2Xty1u3TbuoQcjK0EO06Mgm4
 wTr+ayPcxLkz0DM0coltL8FD5/F5C1inH9LfReRG6tzrJFgy9/PVVzoveTJSwlO95DM1
 EROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740773101; x=1741377901;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hyuNddXB12O2QD6cZesmxd3qfxmTAioxmOYCYIQvpfA=;
 b=D3SFCZj6jYpb5E1Nu3RDm3+3u2GzcePG5v9LjsbpQpfgJnyfkEmrSJARp6B5EUHEMb
 a/QaELte4xYVZQdSnjgcuzgBBdzYqG4Btp+zI71U1AFSiB3Vg1Totw2RR9mg88NJORB7
 esoda/8INcn3FZi/LiW1BZmoG2a1VdxC1IVlgUNaGgToANvmbszcSIa5PN7mXUkaIhJj
 Gm2Vxm5DZ41WzeIV8kq6k8U56P8tu6misfoiSzd075jDX5V6olOmRdHGzfciAkw6nYJQ
 6WeY0PDl4uBvybZ72DTGFWbqFRvdfJ+ONmyPPHrLE2CSl5fL6cAUsAtUx5tQowI3KKsA
 acjg==
X-Gm-Message-State: AOJu0YxHMKjZq39AvGyMsPeNp3+s3P3D0FTXuYjRFOBIPao/hkvLM2Qn
 5bV7tl8KLA1WRILr+yRcDzUtHqsIWXEisYM/7pZwrBL4F7XqKJXNGcOUejZNpD/Qq6ReF2/25Qz
 jhdPpjSlsXbsTl94NlzAlTIr7P5/BtQjrbVTh+97t5pH/Htgn63wQvaJiN4fo5APuOz866s/baJ
 amwBpYWjgk9lKxO6uPJ/Bzq9zw4eJE+qqWP0C0UZwCvg==
X-Google-Smtp-Source: AGHT+IH7eqTRgkrTYJGBVWCG5bG9DuB2zgUa5d87oGQsD5gCmuDsq0cj8zDiAzS38QAOou2q+XChM9iZs5+gsQ==
X-Received: from wmbgx23.prod.google.com
 ([2002:a05:600c:8597:b0:439:8b09:7257])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:46c6:b0:439:9c3a:bba7 with SMTP id
 5b1f17b1804b1-43ba67749d3mr34611515e9.28.1740773101304; 
 Fri, 28 Feb 2025 12:05:01 -0800 (PST)
Date: Fri, 28 Feb 2025 20:04:47 +0000
In-Reply-To: <20250228200453.45173-1-whendrik@google.com>
Mime-Version: 1.0
References: <20250228200453.45173-1-whendrik@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228200453.45173-2-whendrik@google.com>
Subject: [PATCH v6 2/8] i386: Add init and realize functionality for RDT
 device.
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com, 
 zhao1.liu@intel.com, xiaoyao.li@intel.com, Jonathan.Cameron@huawei.com, 
 v6-0000-cover-letter.patch@google.com
Cc: peternewman@google.com, Hendrik Wuethrich <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=37RbCZwgKCmgcNKTJXOQMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x34a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Add code to initialize all necessary state for the RDT device.

Signed-off-by: Hendrik Wuethrich <whendrik@google.com>
---
 hw/i386/rdt.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
index 76a253902b..498c7b70ad 100644
--- a/hw/i386/rdt.c
+++ b/hw/i386/rdt.c
@@ -18,7 +18,9 @@
 #include "qemu/osdep.h" /* Needs to be included before isa.h */
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
+#include "include/hw/boards.h"
 #include "qom/object.h"
+#include "target/i386/cpu.h"
 
 #define TYPE_RDT "rdt"
 #define RDT_NUM_RMID_PROP "rmids"
@@ -71,6 +73,16 @@ struct RDTState {
 struct RDTStateClass {
 };
 
+static inline int16_t cache_ids_contain(uint32_t current_ids[],
+                                        uint16_t size, uint32_t id) {
+    for (int i = 0; i < size; i++) {
+        if (current_ids[i] == id) {
+            return i;
+        }
+    }
+    return -1;
+}
+
 OBJECT_DEFINE_TYPE(RDTState, rdt, RDT, ISA_DEVICE);
 
 static Property rdt_properties[] = {
@@ -81,8 +93,75 @@ static void rdt_init(Object *obj)
 {
 }
 
+static void rdt_realize(DeviceState *dev, Error **errp) {
+    RDTState *rdtDev = RDT(dev);
+    MachineState *ms = MACHINE(qdev_get_machine());
+    rdtDev->rdtInstances = NULL;
+    rdtDev->l3_caches = 0;
+    uint32_t *cache_ids_found = g_malloc(sizeof(uint32_t) * 256);
+    uint32_t cache_ids_size = 0;
+
+    /* Iterate over all CPUs and set RDT state */
+    for (int i = 0; i < ms->possible_cpus->len; i++) {
+        X86CPU *x86_cpu = X86_CPU(ms->possible_cpus->cpus[i].cpu);
+        X86CPUTopoInfo topo_info = x86_cpu->env.topo_info;
+
+        uint32_t num_threads_sharing = apicid_pkg_offset(&topo_info);
+        uint32_t index_msb = 32 - clz32(num_threads_sharing);
+        uint32_t l3_id = x86_cpu->apic_id & ~((1 << index_msb) - 1);
+
+        int16_t pos = cache_ids_contain(cache_ids_found,
+                                        cache_ids_size, l3_id);
+        /*
+         * If we find a core that shares a new L3 cache,
+         * initialize the relevant per-L3 state.
+         * */
+        if (pos == -1) {
+            cache_ids_size++;
+            pos = cache_ids_size - 1;
+            cache_ids_found[pos] = l3_id;
+
+            rdtDev->rdtInstances = g_realloc(rdtDev->rdtInstances,
+                                             sizeof(RDTStatePerL3Cache) *
+                                             cache_ids_size);
+            rdtDev->l3_caches++;
+            RDTStatePerL3Cache *rdt = &rdtDev->rdtInstances[pos];
+            rdt->rdtstate = rdtDev;
+            rdt->monitors = g_malloc(sizeof(RDTMonitor) * rdtDev->rmids);
+            rdt->rdtstate->allocations = g_malloc(sizeof(RDTAllocation) *
+                                                  rdtDev->rmids);
+            rdt->monitors->count_local = 0;
+            rdt->monitors->count_remote = 0;
+            rdt->monitors->count_l3 = 0;
+            memset(rdt->msr_L2_ia32_mask_n, 0xF,
+                   sizeof(rdt->msr_L2_ia32_mask_n));
+            memset(rdt->msr_L3_ia32_mask_n, 0xF,
+                   sizeof(rdt->msr_L3_ia32_mask_n));
+            memset(rdt->ia32_L2_qos_ext_bw_thrtl_n, 0xF,
+                   sizeof(rdt->ia32_L2_qos_ext_bw_thrtl_n));
+            qemu_mutex_init(&rdt->rdtstate->allocations->lock);
+            qemu_mutex_init(&rdt->lock);
+        }
+
+        x86_cpu->rdtStatePerL3Cache = &rdtDev->rdtInstances[pos];
+        x86_cpu->rdtPerCore = g_malloc(sizeof(RDTStatePerCore));
+
+        qemu_mutex_init(&x86_cpu->rdtPerCore->lock);
+    }
+}
+
 static void rdt_finalize(Object *obj)
 {
+    RDTState *rdt = RDT(obj);
+    MachineState *ms = MACHINE(qdev_get_machine());
+
+    for (int i = 0; i < ms->possible_cpus->len; i++) {
+        RDTStatePerL3Cache *rdtInstance = &rdt->rdtInstances[i];
+        g_free(rdtInstance->monitors);
+        g_free(rdtInstance->rdtstate->allocations);
+    }
+
+    g_free(rdt->rdtInstances);
 }
 
 static void rdt_class_init(ObjectClass *klass, void *data)
@@ -92,6 +171,7 @@ static void rdt_class_init(ObjectClass *klass, void *data)
     dc->hotpluggable = false;
     dc->desc = "RDT";
     dc->user_creatable = true;
+    dc->realize = rdt_realize;
 
     device_class_set_props(dc, rdt_properties);
 }
-- 
2.48.1.711.g2feabab25a-goog


