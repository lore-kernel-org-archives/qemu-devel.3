Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12BDD6AB19
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 21:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Q2W-0008WJ-GO; Thu, 02 Apr 2026 17:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2L-0008Lm-UJ
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:14 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2J-00079F-02
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:13 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b9b1df1a6b3so163801166b.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 14:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775167029; x=1775771829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ti9TrcfoeyeQNd3Zl+7f/uTE9kKOziltFUJwrjRDreg=;
 b=Fr4iMmC7WwQK5xcFXq3KoWVvYw1sLpScUkAyX2dEBxAnaQ/c+DrWt/EvM7iaH95pVE
 w8eX89SdjLinq2SNiHTXiuEceo0VdjORF52Ozsj182KKD/fHrQrYCzA/2Mcj8b8LNYUF
 zks7OwlSXhlbGl3YJ9IsAs41xoPRn6lkIHaEr/+4gxWMhSR2AgXODZNABCqBOWQk7EPv
 nWmMQECFVAzn0DTo9VonLhxoj4BlYTbR40Nucit3sjvCxWET1RY0nXf7X+RvqF0aF7Y8
 yLUXYePTAXB8/NxXQYZO9W2HmRtkEb3mPzGSLXTgVmEMp89TOfiNAcZKNgy4VvtUNHGV
 EaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775167029; x=1775771829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ti9TrcfoeyeQNd3Zl+7f/uTE9kKOziltFUJwrjRDreg=;
 b=EASKxNG1Lp3+5S2zgloYtQkqFhBGkR4hcVTsXRCR+WEnT08R8xtSftxetpKRCsg2kr
 GWQv/jM1Kx+hzunkqFsEJScaQRzMfG9MUiSPUjS7cyuJIuKd/7MgzKkAmBvE/S+faqAa
 K5PD/KNjYUUCY3jghdMnpAoFRk230KFLSObKZLrvLuJlpP6jgf0/RjNTq6ACt2E4ZUcT
 eTfjepE2hzAV8Xs3CB5fhYiG7hMQdEPcDs0BnjuMGb/sgMb1CuST6MS/8FT0fmMkJsWJ
 QetcaL0XeNxC3HCDt7MxAvE/efBEgaX9Z+tWwuvZPxOqV1RarL9iwRmp9+ihXHS08T9x
 PHfA==
X-Gm-Message-State: AOJu0Yx34/sR6sNNPMAija6qmXb0y/ZdAMNTkJOycvTIaif54KLUCKZz
 u231NWfhFuXpWVIBylNnmguk768pioPbuyXL7PJJ8cOxpMAy8zspbXySp/cb5Nb5
X-Gm-Gg: ATEYQzyJI+R/F1lmriuM69uJnEYemxTr1eucVoBElJr4bItS08AWiOrAAOjFsp2LChj
 29txTV6PWCaX5zd6Th+d3bbAf2yPJUM79pjXMt3TrpbQ/z3DcTqOhaH3mgpDN7F6l8JCDRgfb0h
 y+pV50SLLQ35o4yzMkdf0SHKC1IidzXeOfC5Ix0DxZsQuu84d7yDxdz7ZkI8Zhgq2sRxgEt25rm
 RiYnMdu+HA7FXljq5P1vGQKtEJcsbuz+Ktt2lt+FAse4OGrqu/3xNQU6wKNK6dy1rtXdGZCgzx9
 c94znzMNtUAyDkNPAFdAtq2wdzfhNCITY/1OLNBB7hLsKMTo80KQkPCJ3ye1zYcQBkzG+fW7Gph
 6yJYXukpCI08xz9CtO9GT5oIV0aCSvTTEg5H4VGzwLteoBwuSa7tG0ja13McHkDn9zNciSg+9wp
 +krVBTCYHQ+6EHKsx2wORvEN18Gklxn+rPDLPXNaUHGsBGn5tSHFkbsKEaWiTgmFLrir9JuA==
X-Received: by 2002:a17:907:3f90:b0:b98:cb6:e896 with SMTP id
 a640c23a62f3a-b9c67b77b14mr24507466b.38.1775167028943; 
 Thu, 02 Apr 2026 14:57:08 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-182-244.adsl.net.t-com.hr.
 [93.143.182.244]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9c3cac0e1asm134009166b.27.2026.04.02.14.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:57:08 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v3 15/33] hw/core/fdt_generic_util: implement
 fdt_get_irq/_info API
Date: Thu,  2 Apr 2026 23:56:00 +0200
Message-ID: <20260402215629.745866-16-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402215629.745866-1-ruslichenko.r@gmail.com>
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x632.google.com
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

Both interfaces may be used by devices to get IRQ information
based device tree entry.
Both methods will identify interrupt parent for a device and
retrieve irq entry.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c         | 132 +++++++++++++++++++++++++++++
 include/hw/core/fdt_generic_util.h |  17 ++++
 2 files changed, 149 insertions(+)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index d816e395fd..51b808d9d0 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -64,6 +64,11 @@ static int fdt_generic_num_cpus;
 
 static int simple_bus_fdt_init(const char *bus_node_path, FDTMachineInfo *fdti);
 
+static void fdt_get_irq_info_from_intc(FDTMachineInfo *fdti, qemu_irq *ret,
+                                       char *intc_node_path,
+                                       uint32_t *cells, uint32_t num_cells,
+                                       uint32_t max, Error **errp);
+
 FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq)
 {
     FDTMachineInfo *fdti = fdt_init_new_fdti(fdt);
@@ -229,6 +234,133 @@ static int simple_bus_fdt_init(const char *node_path, FDTMachineInfo *fdti)
     return 0;
 }
 
+static void fdt_get_irq_info_from_intc(FDTMachineInfo *fdti, qemu_irq *ret,
+                                       char *intc_node_path,
+                                       uint32_t *cells, uint32_t num_cells,
+                                       uint32_t max, Error **errp)
+{
+    FDTGenericIntcClass *intc_fdt_class;
+    DeviceState *intc;
+
+    while (!fdt_init_has_opaque(fdti, intc_node_path) &&
+           qemu_in_coroutine()) {
+        fdt_init_yield(fdti);
+    }
+    intc = DEVICE(fdt_init_get_opaque(fdti, intc_node_path));
+
+    if (!intc) {
+        goto fail;
+    }
+
+    while (!intc->realized && qemu_in_coroutine()) {
+        fdt_init_yield(fdti);
+    }
+
+    if (!intc->realized) {
+        goto fail;
+    }
+
+    intc_fdt_class = FDT_GENERIC_INTC_GET_CLASS(intc);
+    if (!intc_fdt_class) {
+        goto fail;
+    }
+
+    intc_fdt_class->get_irq(FDT_GENERIC_INTC(intc), ret, cells, num_cells,
+                            max, errp);
+
+    return;
+fail:
+    error_setg(errp, "%s", __func__);
+}
+
+qemu_irq *fdt_get_irq_info(FDTMachineInfo *fdti, char *node_path, int irq_idx,
+                          char *info) {
+    void *fdt = fdti->fdt;
+    uint32_t intc_phandle, intc_cells, cells[32];
+    char intc_node_path[DT_PATH_LENGTH];
+    qemu_irq *ret = NULL;
+    int i;
+    Error *errp = NULL;
+
+    intc_phandle = qemu_fdt_getprop_cell_inherited(fdt, node_path,
+                                                   "interrupt-parent",
+                                                   0, &errp);
+    if (errp) {
+        goto fail;
+    } else {
+        if (qemu_devtree_get_node_by_phandle(fdt, intc_node_path,
+                                             intc_phandle)) {
+            goto fail;
+        }
+
+        /* Check if the device is using interrupt-maps */
+        qemu_fdt_getprop_cell(fdt, node_path, "interrupt-map-mask", 0,
+                              &errp);
+        if (!errp) {
+            error_report(
+                 "'interrupt-map' routing is not yet supported for node %s",
+                     node_path);
+            goto fail;
+        } else {
+            error_free(errp);
+            errp = NULL;
+            intc_cells = qemu_fdt_getprop_cell_inherited(fdt, intc_node_path,
+                                               "#interrupt-cells", 0,
+                                               &errp);
+        }
+    }
+
+    if (errp) {
+        goto fail;
+    }
+
+    fdt_debug_np("%s intc_phandle: %d\n", node_path, intc_phandle);
+
+    for (i = 0; i < intc_cells; ++i) {
+        cells[i] = qemu_fdt_getprop_cell(fdt, node_path, "interrupts",
+                                        intc_cells * irq_idx + i, &errp);
+        if (errp) {
+            goto fail;
+        }
+    }
+
+    fdt_debug_np("Getting IRQ information: %s -> %s\n",
+                node_path, intc_node_path);
+
+    ret = g_new0(qemu_irq, fdt_generic_num_cpus + 2);
+    fdt_get_irq_info_from_intc(fdti, ret, intc_node_path, cells, intc_cells,
+                               fdt_generic_num_cpus, &errp);
+
+    if (errp) {
+        goto fail;
+    }
+
+    /* FIXME: Phase out this info bussiness */
+    if (info) {
+        snprintf(info, DT_PATH_LENGTH, "%s", intc_node_path);
+    }
+
+    return ret;
+
+fail:
+    if (info) {
+        snprintf(info, DT_PATH_LENGTH, "%s",
+                 errp ? error_get_pretty(errp) : "(none)");
+
+    }
+
+    if (errp) {
+        error_free(errp);
+    }
+
+    return NULL;
+}
+
+qemu_irq *fdt_get_irq(FDTMachineInfo *fdti, char *node_path, int irq_idx)
+{
+    return fdt_get_irq_info(fdti, node_path, irq_idx, NULL);
+}
+
 static inline const char *trim_vendor(const char *s)
 {
     /* FIXME: be more intelligent */
diff --git a/include/hw/core/fdt_generic_util.h b/include/hw/core/fdt_generic_util.h
index c92c79dd12..6fb0708d7a 100644
--- a/include/hw/core/fdt_generic_util.h
+++ b/include/hw/core/fdt_generic_util.h
@@ -16,6 +16,23 @@
 
 FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq);
 
+/*
+ * get an irq for a device. The interrupt parent of a device is idenitified
+ * and the specified irq (by the interrupts device-tree property) is retrieved
+ */
+
+qemu_irq *fdt_get_irq(FDTMachineInfo *fdti, char *node_path, int irq_idx);
+
+/*
+ * same as above, but poulates err with non-zero if something goes wrong, and
+ * populates info with a human readable string giving some basic information
+ * about the interrupt connection found (or not found). Both arguments are
+ * optional (i.e. can be NULL)
+ */
+
+qemu_irq *fdt_get_irq_info(FDTMachineInfo *fdti, char *node_path, int irq_idx,
+                           char *info);
+
 #define TYPE_FDT_GENERIC_INTC "fdt-generic-intc"
 
 #define FDT_GENERIC_INTC_CLASS(klass) \
-- 
2.43.0


