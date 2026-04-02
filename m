Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E350BD6AB17
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 21:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Q2R-0008UA-VI; Thu, 02 Apr 2026 17:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2O-0008RJ-Pj
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:16 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2N-0007AO-2N
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:16 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b936331786dso140380366b.3
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 14:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775167033; x=1775771833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7wwyEKp+01Czgx6hMOiu7U9RUmG9r7Ino8NfNmLre3Q=;
 b=hJTx89Rmc1d/z+24efKjQZwMzn994uitYnp5u7C0clajh5Sq8o1Pb4N1rwutCEByHv
 TgugYBbk+Llj3F/xd/HGAid9Il0MZg4YvXkE1l4gPS7+S7WK7x9eenIRhf/ME4oB2iwM
 EgdPd5v+VQUJqQI73Ebl6l4NKC8Ks2vB+HEnihMmcZVGWgh2ZUFYmomoXs3Wom4dkRNk
 H30JDBxadrlIl4+NkniSVgjc/83JxcOfl1m/KbyUsQQeWw44fKCen3SVqQgGU1impB4I
 kQtvw+bJUxKDvbkCYT3nSvmxum/ghDCdWtrsQ4imMArDRAq5K1GSQZx4aJS4WtC2EnyI
 ahIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775167033; x=1775771833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7wwyEKp+01Czgx6hMOiu7U9RUmG9r7Ino8NfNmLre3Q=;
 b=TjRn5HNVzjwMr/WnOtElJegylzaWA0yE8nbebIGImUs0z2dv2tU2kkB7bAde0+gSCX
 7znIgeKeO9jv+dLN3zLHm2hSU1XkRFAHTsxi2A26K92fzNcYQb3XVOsKF1Ddd6EAL4uz
 x45u/NkJh3J3IPQxophqBZKLbNeliYqdpYv5pH5kofdSdjspM7Gi7x6CCqx1TytxYvwY
 w3NU3xfB9XzvLd/XYgZZG0xcmRYDuO6NDu+tuihTC0JyMKpZqTP8w/BKrVbuVKC1Y9S8
 zCShsC4d9HTCwd19X78OLN9ZEyP+sNvHICVq8vfHjzGZeywMMW/rOwU7da8tTNckC/8s
 LP+Q==
X-Gm-Message-State: AOJu0YyO2mD0+gYOaZARL6FWrlR6spyxeyvSUbbzf0wZY7IIaW9xvrjI
 DC8BMww9mABLySth4MlPMCvECrarwOaiIHXaSlDdlZz4hilHcyz/5TjzpRsapIja
X-Gm-Gg: ATEYQzy87wp3LazE828dxV7pHJgCxSPWXFcbc1ZbJ05PyxXcpaMSWUf+JIHvEvTCDJM
 vgz1Ck/Y+5bhD7/uGKw0tvAwA95S/XKs/TECTXNIibnHRmoDy138QH2069XseeM+EJkPi54xbl3
 +W4NqhOPA3McIabW738Drl4H8Dm6e/wHK6NNPT81obHHTOkrovgnn5S8BLFB2H+U4F0Gzv93PKO
 giaYdhLzITMdmhx5VCyQ5vgg0GIaojC28FvwIrF8IJmR35YFYASOIf5n3UKWe4k51w4zeLd97l2
 fxUUjdpcfGgi/d/uPPlUH/HT5hPiGtnpXvljjSnTBiGp6orwdhcEyQxA+eHYuArb9Rz9m09pW5a
 EY/Ob8WP8JZrNqrnuNA0xULIsVCcQC5HcjR7Fhvnlg1NT3biJ6QSfzVV3Vgl9z6I9Edh9B5SiVn
 3tzvn6lSKE6Dw+J4bNQgITF1wyPS2g72IgfBvVWzzWqhVzk9VRaCpBu20P1MwkUAKyNCFyNk84Q
 Hvw+rcu
X-Received: by 2002:a17:907:25c3:b0:b98:8a9c:7059 with SMTP id
 a640c23a62f3a-b9c6744d8b8mr26019066b.19.1775167033216; 
 Thu, 02 Apr 2026 14:57:13 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-182-244.adsl.net.t-com.hr.
 [93.143.182.244]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9c3cac0e1asm134009166b.27.2026.04.02.14.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:57:12 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v3 17/33] hw/core/fdt_generic_util: Connect device irqs
Date: Thu,  2 Apr 2026 23:56:02 +0200
Message-ID: <20260402215629.745866-18-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402215629.745866-1-ruslichenko.r@gmail.com>
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

The patch implements IRQ wiring logic for fdt created
devices.

The wiring performed in two stages. As devices are
created, their IRQs saved in the list.
After all devices processed, fdt_init_all_irqs() goes
through all IRQs and does actual wiring. For IRQs
which have multiple source, shared IRQ handler
allocated.

For interrupt controllers with auto_parent callback
implemented and their fdt node has 'interrupt' and
'interrupts-extended' properties empty,
the auto_parent() will be called to connect them
to their interrupt-parent, for example to CPUs.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c    | 143 ++++++++++++++++++++++++++++++++++
 include/hw/core/fdt_generic.h |  12 +++
 2 files changed, 155 insertions(+)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index 0b374b550d..b0e26e11bc 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -69,6 +69,88 @@ static void fdt_get_irq_info_from_intc(FDTMachineInfo *fdti, qemu_irq *ret,
                                        uint32_t *cells, uint32_t num_cells,
                                        uint32_t max, Error **errp);
 
+typedef struct QEMUIRQSharedState {
+    qemu_irq sink;
+    int num;
+    bool (*merge_fn)(bool *, int);
+/* FIXME: remove artificial limit */
+#define MAX_IRQ_SHARED_INPUTS 256
+    bool inputs[MAX_IRQ_SHARED_INPUTS];
+} QEMUIRQSharedState;
+
+static bool qemu_irq_shared_or_handler(bool *inputs, int n)
+{
+    int i;
+
+    assert(n < MAX_IRQ_SHARED_INPUTS);
+
+    for (i = 0; i < n; ++i) {
+        if (inputs[i]) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static void qemu_irq_shared_handler(void *opaque, int n, int level)
+{
+    QEMUIRQSharedState *s = opaque;
+
+    assert(n < MAX_IRQ_SHARED_INPUTS);
+    s->inputs[n] = level;
+    qemu_set_irq(s->sink, s->merge_fn(s->inputs, s->num));
+}
+
+static void fdt_init_all_irqs(FDTMachineInfo *fdti)
+{
+    while (fdti->irqs) {
+        FDTIRQConnection *first = fdti->irqs;
+        qemu_irq sink = first->irq;
+        bool (*merge_fn)(bool *, int) = first->merge_fn;
+        int num_sources = 0;
+        FDTIRQConnection *irq;
+
+        for (irq = first; irq; irq = irq->next) {
+            if (irq->irq == sink) { /* Same sink */
+                num_sources++;
+            }
+        }
+        if (num_sources > 1) {
+            QEMUIRQSharedState *s = g_malloc0(sizeof *s);
+            s->sink = sink;
+            s->merge_fn = merge_fn;
+            qemu_irq *sources = qemu_allocate_irqs(qemu_irq_shared_handler, s,
+                                                   num_sources);
+            for (irq = first; irq; irq = irq->next) {
+                if (irq->irq == sink) {
+                    char *shared_irq_name = g_strdup_printf("shared-irq-%p",
+                                                            *sources);
+
+                    if (irq->merge_fn != merge_fn) {
+                        fprintf(stderr, "ERROR: inconsistent IRQ merge fns\n");
+                        exit(1);
+                    }
+
+                    object_property_add_child(OBJECT(irq->dev), shared_irq_name,
+                                              OBJECT(*sources));
+                    g_free(shared_irq_name);
+                    irq->irq = *(sources++);
+                    s->num++;
+                }
+            }
+        }
+        fdt_debug("%s: connected to %s irq line %d (%s)\n",
+                 first->sink_info ? first->sink_info : "",
+                 object_get_canonical_path(OBJECT(first->dev)),
+                 first->i, first->name ? first->name : "");
+
+        qdev_connect_gpio_out_named(DEVICE(first->dev), first->name, first->i,
+                                    first->irq);
+        fdti->irqs = first->next;
+        g_free(first);
+    }
+}
+
 FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq)
 {
     FDTMachineInfo *fdti = fdt_init_new_fdti(fdt);
@@ -82,6 +164,7 @@ FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq)
     while (qemu_co_enter_next(fdti->cq, NULL)) {
         ;
     }
+    fdt_init_all_irqs(fdti);
     memory_region_transaction_commit();
 
     /* FIXME: Populate these from DTS and create CPU clusters.  */
@@ -772,6 +855,64 @@ static void fdt_parse_node_reg_prop(FDTMachineInfo *fdti, char *node_path,
     g_free(reg);
 }
 
+static void fdt_parse_node_irq_prop(FDTMachineInfo *fdti, char *node_path,
+                            Object *dev)
+{
+    int is_intc, len;
+    int i, j;
+
+    if (!object_dynamic_cast(dev, TYPE_SYS_BUS_DEVICE)) {
+        return;
+    }
+
+    fdt_get_property(fdti->fdt, fdt_path_offset(fdti->fdt, node_path),
+                            "interrupt-controller", &len);
+    is_intc = len >= 0;
+    fdt_debug_np("is interrupt controller: %c\n",
+                is_intc ? 'y' : 'n');
+
+    /* connect irq */
+    j = 0;
+    for (i = 0;; i++) {
+        char irq_info[6 * 1024];
+        char *irq_info_p = irq_info;
+        len = -1;
+        qemu_irq *irqs = fdt_get_irq_info(fdti, node_path, i, irq_info);
+        /* INTCs inferr their top level, if no IRQ connection specified */
+        fdt_get_property(fdti->fdt, fdt_path_offset(fdti->fdt, node_path),
+                            "interrupts-extended", &len);
+        if (!irqs && is_intc && i == 0 && len <= 0) {
+            FDTGenericIntc *id = (FDTGenericIntc *)object_dynamic_cast(
+                                    dev, TYPE_FDT_GENERIC_INTC);
+            FDTGenericIntcClass *idc = FDT_GENERIC_INTC_GET_CLASS(id);
+            if (id && idc->auto_parent) {
+                Error *err = NULL;
+                idc->auto_parent(id, &err);
+            } else {
+                irqs = fdti->irq_base;
+            }
+        }
+        if (!irqs) {
+            break;
+        }
+        while (*irqs) {
+            FDTIRQConnection *irq = g_new0(FDTIRQConnection, 1);
+            *irq = (FDTIRQConnection) {
+                .dev = DEVICE(dev),
+                .name = SYSBUS_DEVICE_GPIO_IRQ,
+                .merge_fn = qemu_irq_shared_or_handler,
+                .i = j,
+                .irq = *irqs,
+                .sink_info = g_strdup(irq_info_p),
+                .next = fdti->irqs
+            };
+            j++;
+            fdti->irqs = irq;
+            irqs++;
+        }
+    }
+}
+
 static void fdt_init_parent_node(Object *dev, Object *parent, char *node_path)
 {
     if (dev->parent) {
@@ -902,6 +1043,8 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
 
     fdt_parse_node_reg_prop(fdti, node_path, dev);
 
+    fdt_parse_node_irq_prop(fdti, node_path, dev);
+
     g_free(parent_node_path);
 
     return 0;
diff --git a/include/hw/core/fdt_generic.h b/include/hw/core/fdt_generic.h
index 05ab07e08c..3961615a9c 100644
--- a/include/hw/core/fdt_generic.h
+++ b/include/hw/core/fdt_generic.h
@@ -25,6 +25,16 @@ typedef struct FDTCPUCluster {
     bool user;
 } FDTCPUCluster;
 
+typedef struct FDTIRQConnection {
+    DeviceState *dev;
+    const char *name;
+    int i;
+    bool (*merge_fn)(bool *, int);
+    qemu_irq irq;
+    char *sink_info; /* Debug only */
+    void *next;
+} FDTIRQConnection;
+
 typedef struct FDTMachineInfo {
     /* the fdt blob */
     void *fdt;
@@ -34,6 +44,8 @@ typedef struct FDTMachineInfo {
     FDTDevOpaque *dev_opaques;
     /* recheck coroutine queue */
     CoQueue *cq;
+    /* list of all IRQ connections */
+    FDTIRQConnection *irqs;
     /* list of all CPU clusters */
     FDTCPUCluster *clusters;
 } FDTMachineInfo;
-- 
2.43.0


