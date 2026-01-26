Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C6DD19502
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQd5-0001Zw-FR; Mon, 26 Jan 2026 12:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcp-0001Pu-HD
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:44 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcm-00007d-Mh
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:43 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43596062728so3569223f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 09:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769449419; x=1770054219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8v1gA33hjaYhV55XhXrq0Gi+pAkxwSl9Pre/BV0Vh8U=;
 b=ePM+xd18oRM+DGALVxRekZwfc8qIWuzwXEDLyLP/SEclSPvNztKgwaiJPxmnpCsqp7
 Jp9ujVzgwIF2X4+ryuYoFGl3QSmM4au4ahGuVQ1cpyOUQCKvL87z8eB9Pb+upfeNzcm9
 6SAEzsc41eILZbd9LL0Yspzh9yDpOjonbMcQd7Z1x+b5J4IUGAolY/oKXAGsMfdTRbQt
 oIhkBE0UVNVOTPi77HZULsnN4q6ENf7sjuKpqztQPHPyHNzcOQAp9QkYKJOB6vGqx4pp
 eqrprh8sz6+8Vrd7G5zvMwEmPCeyXblB2umUeMn5pGEidqSeEs4xtXZMg6UqppRXHOCL
 KZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769449419; x=1770054219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8v1gA33hjaYhV55XhXrq0Gi+pAkxwSl9Pre/BV0Vh8U=;
 b=jgrm48HcqnN71g73wfLiA/A3Z/cA4G/xEyOM6YH0mt8BhvPu3RTq8PUHTgQ6io4V5u
 XrfoLvjRpzC3CwcXfkf1cx1UfmwmdIgwZZb7pc7xk19Jr1vaRZ375aZKOd6xbgaPcY0q
 adeqLSMMjzyd/vfc0k3GcJrdKnyvDuv8FiiUrz9JW9MVtekYuLxd/KS+lWCPDvbFlxic
 t9IYkqtv2KHfgS7q40LPMqjOl7wVIUWIp7utwZDzEqbExr+ySYI+OSbDePeZ4HylJY7e
 j5DsyUjjnbkGgTa6Yyc550eJaV9VrZVTZBuQbq4R7+jhfMMtf1WGEYABsFhp75dxz/9T
 xonw==
X-Gm-Message-State: AOJu0YyAFcHz5qxpiOQ8GXSqF4oaXMBu/jo45X/i/3GYXIltOxknRCrT
 UXEeNKChn3LoXTguIMTLvvaIgAY4ql4co5u99qL5z08/rX4fIPnNbUzech+MAjYS
X-Gm-Gg: AZuq6aI1WT16CSQnaYfDnqoIIB2waC3UU8uj+ZlzIMqVcbhvaI0THdnpNiq98f1RiKu
 1qQXNGKcm36U7YpDyCiXhBvO8mBOdLd0um09fSLgAVQ97Odmu1g7RIUEUvUySq6M4kAWkQutaU3
 yaDLgEd9LS2WRiTxZmRVchYvMhUH9lWr52pLtJLck7JKZkyFQRO9ZAR222Wl6JYJzIoNyFmSoFE
 jFm0OqJRs1Cj55Avuyec0pp67Ucmoiqb7QyilRQC9WOk+ZDWIuG40w8i9jsLypSDt96XN21CdH9
 H7A9aWZN1xzDSj9HmoGgKNbm0w/fjqeFGf9zhoOfKbqQVXcFl9uuu0v3xcVPf2QbTecMF7oHVMA
 wDhVY6aTOkt5WM9YaNGweB9espbWycvacPH1Uf0QBC3HMTdKHSVTy/1HIsdjAziwDCtMHgbWGnk
 7gclJAooh05bvA8PxroUp16NkYJEWxOMZFnaz8DbdTW4VPtvhm+pMO5w==
X-Received: by 2002:a05:6000:3110:b0:432:59d4:f54a with SMTP id
 ffacd0b85a97d-435c9d289c5mr10406397f8f.30.1769449418770; 
 Mon, 26 Jan 2026 09:43:38 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-71-105.adsl.net.t-com.hr.
 [93.143.71.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71730sm34199603f8f.26.2026.01.26.09.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 09:43:38 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com
Subject: [PATCH 15/27] hw/core/fdt_generic_util: Connect device irqs
Date: Mon, 26 Jan 2026 18:43:01 +0100
Message-ID: <20260126174313.1418150-16-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x42a.google.com
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
implemented and their fdt node has 'interrupt and
'interrupts-extended' properties empty,
the auto_parent() will be called to connect them
to their interrupt-parent, for example to CPUs.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c    | 146 +++++++++++++++++++++++++++++++++-
 include/hw/core/fdt_generic.h |  12 +++
 2 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index af20ffd9db..2f49909a50 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -76,6 +76,88 @@ static void fdt_get_irq_info_from_intc(FDTMachineInfo *fdti, qemu_irq *ret,
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
+        DB_PRINT(0, "%s: connected to %s irq line %d (%s)\n",
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
     char node_path[DT_PATH_LENGTH];
@@ -91,6 +173,7 @@ FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq)
         while (qemu_co_enter_next(fdti->cq, NULL)) {
             ;
         }
+        fdt_init_all_irqs(fdti);
         memory_region_transaction_commit();
     } else {
         fprintf(stderr, "FDT: ERROR: cannot get root node from device tree %s\n"
@@ -908,8 +991,9 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
 {
     Object *dev, *parent;
     char *dev_type = NULL;
+    int is_intc;
     Error *errp = NULL;
-    int i;
+    int i, j;
     QEMUDevtreeProp *prop, *props;
     char parent_node_path[DT_PATH_LENGTH];
 
@@ -1125,6 +1209,66 @@ exit_reg_parse:
         }
     }
 
+    if (object_dynamic_cast(dev, TYPE_SYS_BUS_DEVICE)) {
+        {
+            int len;
+            fdt_get_property(fdti->fdt, fdt_path_offset(fdti->fdt, node_path),
+                                    "interrupt-controller", &len);
+            is_intc = len >= 0;
+            DB_PRINT_NP(is_intc ? 0 : 1, "is interrupt controller: %c\n",
+                        is_intc ? 'y' : 'n');
+        }
+        /* connect irq */
+        j = 0;
+        for (i = 0;; i++) {
+            char irq_info[6 * 1024];
+            char *irq_info_p = irq_info;
+            bool map_mode;
+            int len = -1;
+            qemu_irq *irqs = fdt_get_irq_info(fdti, node_path, i, irq_info,
+                                              &map_mode);
+            /* INTCs inferr their top level, if no IRQ connection specified */
+            fdt_get_property(fdti->fdt, fdt_path_offset(fdti->fdt, node_path),
+                             "interrupts-extended", &len);
+            if (!irqs && is_intc && i == 0 && len <= 0) {
+                FDTGenericIntc *id = (FDTGenericIntc *)object_dynamic_cast(
+                                        dev, TYPE_FDT_GENERIC_INTC);
+                FDTGenericIntcClass *idc = FDT_GENERIC_INTC_GET_CLASS(id);
+                if (id && idc->auto_parent) {
+                    Error *err = NULL;
+                    idc->auto_parent(id, &err);
+                } else {
+                    irqs = fdti->irq_base;
+                }
+            }
+            if (!irqs) {
+                break;
+            }
+            while (*irqs) {
+                FDTIRQConnection *irq = g_new0(FDTIRQConnection, 1);
+                *irq = (FDTIRQConnection) {
+                    .dev = DEVICE(dev),
+                    .name = SYSBUS_DEVICE_GPIO_IRQ,
+                    .merge_fn = qemu_irq_shared_or_handler,
+                    .i = j,
+                    .irq = *irqs,
+                    .sink_info = g_strdup(irq_info_p),
+                    .next = fdti->irqs
+                };
+                if (!map_mode) {
+                    j++;
+                } else {
+                    irq_info_p += strlen(irq_info_p) + 1;
+                }
+                fdti->irqs = irq;
+                irqs++;
+            }
+            if (map_mode) {
+                j++;
+            }
+        }
+    }
+
     g_free(dev_type);
 
     return 0;
diff --git a/include/hw/core/fdt_generic.h b/include/hw/core/fdt_generic.h
index 46b7dc084b..ad9e249156 100644
--- a/include/hw/core/fdt_generic.h
+++ b/include/hw/core/fdt_generic.h
@@ -24,6 +24,16 @@ typedef struct FDTCPUCluster {
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
@@ -33,6 +43,8 @@ typedef struct FDTMachineInfo {
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


