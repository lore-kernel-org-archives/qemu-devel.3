Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5223ECCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Qa-0005pG-Ds; Tue, 07 Oct 2025 10:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QK-0005mD-Gu
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:17 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Q5-0002Ck-F4
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:15 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e34bd8eb2so70690575e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846312; x=1760451112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9vT70SGLGzJ9UAFdfil179Il/lcyiSaLS96E+xQcOcs=;
 b=xKz83rybroccz+OPASW7YpaZ+6HKtDBV+PC5lvkEGpSkUMimCTZlN1TQNubMXZj4hr
 GvGSas5bgdfJSJ/bkUVWegiJTHl2so2tbxs1Llz0g0ZtNP4H+OU0kt88Q8o2b5phJ2/T
 zwbJJKEqhTt12NcPtLJg6D5cj/BGoxwdTIPacykwni5mFFa+EE29yPmcIxlzOaB5eVnO
 BFqYaS6UzImwtbM9Pg9B8jrQby1I2LV4MK5RbXNpQj+1JDheadRV0yjTM6IwLSSRL7IM
 HGUb5tEaCrt2X8IKvgCEUxI9XDu7w8rYM/AIG7u0t7kSDx6QxWC99RyrA9xv4nRazZtf
 2+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846312; x=1760451112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9vT70SGLGzJ9UAFdfil179Il/lcyiSaLS96E+xQcOcs=;
 b=ELTxHU4+whY1iXGO0+zPMqQpeWOBEvmrTFU1GlSxWVVHQnDYDt98WU561GK/KOhK8d
 ZONmXNNKbdtLgvlO+8pCm6ygWXkw8EhYYKW9yO7zFF/2c2EMPnTllktavINC7wd3F00S
 F9prvVFqQ57pynH1+gPBojtSKuBIyoUK3ihcgZX12CQtF5fueNEgLsqqObTfN63vrhTM
 EuSjBIp5ANZvQZyI+z8dNoDSK1hROAZ1ttnmVXKwN7f3Er6ktPT2uqbH+74IhBI1HYT/
 cpa/2FK96ITIKAouq024JzkMeHLOPkTwRTYs/bfpGX5pmH4GQAutIKZJPPfRFh9uuD6O
 zBFA==
X-Gm-Message-State: AOJu0YzZxntJrvwI6lE0D5WSJ+GbD4cA5BT/Pela8BiEN4lIWuyn1k3M
 qCB1soIyuQHl77bfKawl1MjpANasPkIvSgyLzgwPSm1SiXz6B56j+m3VRWs1u5ODoI3KMGv9ajb
 06A58
X-Gm-Gg: ASbGncsgBQP2b16/q4e6G6/uIBherjlfFWaEmL90DaXIa/UPlN5+dQ69yZFxEEvSlRV
 hmore33jKKbSZDmuythNpwNqS6slbxQWOXxF9UT/eSq2oLj6pHkBvhCs6HaFPowApN7X/iIrU0D
 Vl9V/mVn36jZ65OS3iceefle5BXD1V3HUO6BsI/QufMExyP/GhI9tnl2YuF2lpHYWDj8tWREceK
 jtDIj74iWu/ZkEl6qrvX2ZmUP32hgJA3ROc+mFcguC1bliS4JBOoYW3/Ag86mn6QtfOSt8VCjK8
 BxbErIE2EJqm6eAQbIanUlKLvoz9x76v8h86UZJH/QUONoVBqQay5CLwZqP3zvAykRbUHZ+Zzlp
 Fpvo4tXfKbxd0ZI/TeDCcax3xiF6M1Rvt2szQwB3/VMnQYVRO0kJyIf8s
X-Google-Smtp-Source: AGHT+IHxs6nZtCC9jGgCZvKWqzQfH/MHYn+o6ox6cNK7427N0bKUI39LKILz5z4g8LntgjMhkskfIg==
X-Received: by 2002:a05:600c:1987:b0:45d:5c71:769a with SMTP id
 5b1f17b1804b1-46e71146083mr109009105e9.26.1759846312156; 
 Tue, 07 Oct 2025 07:11:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/62] hw/arm/xlnx-versal: add support for multiple GICs
Date: Tue,  7 Oct 2025 15:10:45 +0100
Message-ID: <20251007141123.3239867-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Luc Michel <luc.michel@amd.com>

The Versal SoC contains two GICs: one GICv3 in the APU and one GICv2 in
the RPU (currently not instantiated). To prepare for the GICv2
instantiation, add support for multiple GICs when connecting interrupts.

When a GIC is created, the first-cpu-index property is set on it, and a
pointer to the GIC is stored in the intc array. When connecting an IRQ,
a TYPE_SPLIT_IRQ device is created with its num-lines property set to
the number of GICs in the SoC. The split device is used to fan out the
IRQ to all the GICs.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-25-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h |  1 +
 hw/arm/xlnx-versal.c         | 56 +++++++++++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 9d9ccfb0014..984f9f2ccdd 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -42,6 +42,7 @@ struct Versal {
     SysBusDevice parent_obj;
 
     /*< public >*/
+    GArray *intc;
     MemoryRegion mr_ps;
 
     struct {
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index e03411bc212..9256eceffc7 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -45,6 +45,7 @@
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
+#include "hw/core/split-irq.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
@@ -317,6 +318,43 @@ static inline Object *versal_get_child_idx(Versal *s, const char *child,
     return versal_get_child(s, n);
 }
 
+/*
+ * The SoC embeds multiple GICs. They all receives the same IRQ lines at the
+ * same index. This function creates a TYPE_SPLIT_IRQ device to fan out the
+ * given IRQ input to all the GICs.
+ *
+ * The TYPE_SPLIT_IRQ devices lie in the /soc/irq-splits QOM container
+ */
+static qemu_irq versal_get_gic_irq(Versal *s, int irq_idx)
+{
+    DeviceState *split;
+    Object *container = versal_get_child(s, "irq-splits");
+    int idx = FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ);
+    g_autofree char *name = g_strdup_printf("irq[%d]", idx);
+
+    split = DEVICE(object_resolve_path_at(container, name));
+
+    if (split == NULL) {
+        size_t i;
+
+        split = qdev_new(TYPE_SPLIT_IRQ);
+        qdev_prop_set_uint16(split, "num-lines", s->intc->len);
+        object_property_add_child(container, name, OBJECT(split));
+        qdev_realize_and_unref(split, NULL, &error_abort);
+
+        for (i = 0; i < s->intc->len; i++) {
+            DeviceState *gic;
+
+            gic = g_array_index(s->intc, DeviceState *, i);
+            qdev_connect_gpio_out(split, i, qdev_get_gpio_in(gic, idx));
+        }
+    } else {
+        g_assert(FIELD_EX32(irq_idx, VERSAL_IRQ, ORED));
+    }
+
+    return qdev_get_gpio_in(split, 0);
+}
+
 /*
  * When the R_VERSAL_IRQ_ORED flag is set on an IRQ descriptor, this function is
  * used to return the corresponding or gate input IRQ. The or gate is created if
@@ -353,12 +391,10 @@ static qemu_irq versal_get_irq(Versal *s, int irq_idx)
 {
     qemu_irq irq;
     bool ored;
-    DeviceState *gic;
 
     ored = FIELD_EX32(irq_idx, VERSAL_IRQ, ORED);
 
-    gic = DEVICE(versal_get_child_idx(s, "apu-gic", 0));
-    irq = qdev_get_gpio_in(gic, FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ));
+    irq = versal_get_gic_irq(s, irq_idx);
 
     if (ored) {
         irq = versal_get_irq_or_gate_in(s, irq_idx, irq);
@@ -501,6 +537,7 @@ static void versal_create_gic_its(Versal *s,
 static DeviceState *versal_create_gic(Versal *s,
                                       const VersalCpuClusterMap *map,
                                       MemoryRegion *mr,
+                                      int first_cpu_idx,
                                       size_t num_cpu)
 {
     DeviceState *dev;
@@ -525,6 +562,7 @@ static DeviceState *versal_create_gic(Versal *s,
     qdev_prop_set_bit(dev, "has-security-extensions", true);
     qdev_prop_set_bit(dev, "has-lpi", map->gic.has_its);
     object_property_set_link(OBJECT(dev), "sysmem", OBJECT(mr), &error_abort);
+    qdev_prop_set_uint32(dev, "first-cpu-index", first_cpu_idx);
 
     sysbus_realize_and_unref(sbd, &error_fatal);
 
@@ -551,6 +589,8 @@ static DeviceState *versal_create_gic(Versal *s,
 
     versal_create_gic_its(s, map, dev, mr, node);
 
+    g_array_append_val(s->intc, dev);
+
     return dev;
 }
 
@@ -608,9 +648,11 @@ static inline void versal_create_and_connect_gic(Versal *s,
                                                  size_t num_cpu)
 {
     DeviceState *gic;
+    int first_cpu_idx;
     size_t i;
 
-    gic = versal_create_gic(s, map, mr, num_cpu);
+    first_cpu_idx = CPU(cpus[0])->cpu_index;
+    gic = versal_create_gic(s, map, mr, first_cpu_idx, num_cpu);
 
     for (i = 0; i < num_cpu; i++) {
         connect_gic_to_cpu(map, gic, cpus[i], i, num_cpu);
@@ -1539,6 +1581,10 @@ static void versal_realize(DeviceState *dev, Error **errp)
     s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
     s->phandle.gic = qemu_fdt_alloc_phandle(s->cfg.fdt);
 
+    container = object_new(TYPE_CONTAINER);
+    object_property_add_child(OBJECT(s), "irq-splits", container);
+    object_unref(container);
+
     container = object_new(TYPE_CONTAINER);
     object_property_add_child(OBJECT(s), "irq-or-gates", container);
     object_unref(container);
@@ -1720,6 +1766,7 @@ static void versal_base_init(Object *obj)
     memory_region_init(&s->mr_ps, obj, "mr-ps-switch", UINT64_MAX);
     memory_region_init_alias(&s->lpd.rpu.mr_ps_alias, OBJECT(s),
                              "mr-rpu-ps-alias", &s->mr_ps, 0, UINT64_MAX);
+    s->intc = g_array_new(false, false, sizeof(DeviceState *));
 
     num_can = versal_get_map(s)->num_canfd;
     s->cfg.canbus = g_new0(CanBusState *, num_can);
@@ -1737,6 +1784,7 @@ static void versal_base_finalize(Object *obj)
 {
     Versal *s = XLNX_VERSAL_BASE(obj);
 
+    g_array_free(s->intc, true);
     g_free(s->cfg.canbus);
 }
 
-- 
2.43.0


