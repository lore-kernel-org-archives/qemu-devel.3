Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B494D6AB10
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 22:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Q2X-00005m-Au; Thu, 02 Apr 2026 17:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2N-0008MW-2s
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:15 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2L-00079c-0p
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:14 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b9b1ffbb9f5so154422666b.2
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 14:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775167031; x=1775771831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5+ZNPSdOIRkRVr+Q/vKL8bV00FekXBJXM/FhoKVAOes=;
 b=CRDjOgcAh58OJ7vin24HmML8Gq+2IYTHWuOSAj2c1I7zq71oJONs358IqTplJBVtV8
 aP8b4E+eTNbvn7+9yWHvN1Pp5hrI3Pas8m3J0q+0WgmSBqIwz166SfFZ5ckDCzVyAkvE
 dbcO+h10dpQHXPUbpOgV9KSk8Hm4LbDDa/wruKjvzcicC/RMKHPO9raQg4qtQeDgAOop
 6snYzHoie8MV39Xz13mF976NUQgyokHUXJZVd32Bq1PVseAd9jvbw6DRXYUD9R1/5ozp
 /91LOVDiYPUkLfkPt3c4eNerog/F5G9gthDYVXAyXB20eLzuE3O6U4qYA3IHQ2/Vl/UI
 CXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775167031; x=1775771831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5+ZNPSdOIRkRVr+Q/vKL8bV00FekXBJXM/FhoKVAOes=;
 b=cyP7QXSXI5BjbtDyN6x9oP975A+hYKP1yWBIBnDvaOyPhKw/OsLaL1JBAOL5l4OOLk
 2PLSxKRTJXX8kWrLCNyCle0kiub5+Jx0AFFtwvphgbqUMkRcT00JGXOgOqBZfMvyi7Xy
 xDf6B4C+nr4fGIL5pl8xKt0NEN7JPXIAbwndHPWoQWkXsaV6MYBAChkAK5jv06X1AH23
 c6BLaH0BRhkHDQc0r4SMqL17HTEqbXUQmNPwwdKIl3Et/QNDSrauFMyOG6p/u9BKHvq+
 k4b9rgE0sdP0pr/7OERnBvQwB85VpsLNN4eahGmfIvar2MgJeowb1RhQN1pyzvwZfYMd
 xe9g==
X-Gm-Message-State: AOJu0YwC5DE97PfqjTMjKj1IOC1xFBn/3XGXrJ3XX4tFH4VLWOzHsWrN
 mgXmYZwdg/Urv8ilG4EdNAd30sKUrg9qLMazFyNRdxZ4mnNFdx9+1b+UJDnM6Xb2
X-Gm-Gg: AeBDieu0gguWhQ+jgGX54bIdZ+zkQLDkKa1D7F0ISzMGTHbrHMJaMUe3afcpGdwJJfY
 i8/QtTsaO16Oy0Uiq35aIg1uUE7esJth6qCItozAQoaTcvhhlJVQy1E6LXObbLWLSggdVJsK4nT
 DzYZQcR/qDe+AGacZ7t1fm/koKWoxr5PX89mosPXM4V+Mf+Mnb69I9/oU9v3Box8O5CeClxGwMc
 7c90e+UTpjytJw2WEEO5DY0M+Fyr4YVf6TRxKZ4SU8ILTEnCC/gOtvHPftojN3kuQQUYZMnyaK0
 1EAdoqVOPIaF3cMZULOZX8SWhAR+LcPLQgwiWMvQNNLg8CLz/87gaWpDgWGHH3Ug/P4pf/RF913
 fc0m+lcJNf6rL4stO8WdXJw93oRpiOwKhQdZpOQGXXfiAzFp5J5Cc1/yJT7fjbKmU4YcIAFsAhn
 kL4UuFW/oCU5Q+u2nj86aRp+QGW5RhXKg6wYJ0fVqM4wPqWuD1BCrNhqLNTkDhJh6aQQjGbQ==
X-Received: by 2002:a17:907:984:b0:b9c:1c26:9eb with SMTP id
 a640c23a62f3a-b9c672d42afmr26531666b.10.1775167031039; 
 Thu, 02 Apr 2026 14:57:11 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-182-244.adsl.net.t-com.hr.
 [93.143.182.244]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9c3cac0e1asm134009166b.27.2026.04.02.14.57.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:57:10 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v3 16/33] hw/core/fdt_generic_util: map device memory regions
Date: Thu,  2 Apr 2026 23:56:01 +0200
Message-ID: <20260402215629.745866-17-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402215629.745866-1-ruslichenko.r@gmail.com>
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x62b.google.com
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

Parse device mmio regions provided within standard 'reg' and
custom 'reg-extended' device tree properties.

For 'reg-extended' properties, the parent phandle is extracted
along with the standard io memory region specification, which allows
adding these regions to specified parent memory regions.

The mapping itself is delegated to the device via the
'TYPE_FDT_GENERIC_MMAP' interface.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c         | 158 +++++++++++++++++++++++++++++
 include/hw/core/fdt_generic_util.h |   6 ++
 2 files changed, 164 insertions(+)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index 51b808d9d0..0b374b550d 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -403,6 +403,22 @@ static inline uint64_t get_int_be(const void *p, int len)
     }
 }
 
+/* FIXME: use structs instead of parallel arrays */
+
+static const char *fdt_generic_reg_size_prop_names[] = {
+    "#address-cells",
+    "#size-cells",
+    "#bus-cells",
+    "#priority-cells",
+};
+
+static const int fdt_generic_reg_cells_defaults[] = {
+    1,
+    1,
+    0,
+    0,
+};
+
 static void fdt_init_qdev_link_prop(Object *obj, ObjectProperty *p,
                                     FDTMachineInfo *fdti,
                                     const char *node_path,
@@ -616,6 +632,146 @@ static void fdt_init_qdev_properties(char *node_path, FDTMachineInfo *fdti,
     }
 }
 
+FDTGenericRegPropInfo*
+fdt_get_reg_info(FDTMachineInfo *fdti, char *node_path, Object *dev)
+{
+    FDTGenericRegPropInfo *reg;
+    Object *parent = NULL;
+    char *parent_path = NULL;
+    int cell_idx = 0;
+    bool extended = true;
+    Error *errp = NULL;
+    int i;
+
+    if (!object_dynamic_cast(dev, TYPE_SYS_BUS_DEVICE) &&
+        !object_dynamic_cast(dev, TYPE_FDT_GENERIC_MMAP)) {
+        return NULL;
+    }
+
+    reg = g_new0(FDTGenericRegPropInfo, 1);
+
+    qemu_fdt_getprop_cell(fdti->fdt, node_path, "reg-extended", 0,
+                            &errp);
+    if (errp) {
+        error_free(errp);
+        errp = NULL;
+        extended = false;
+        parent_path = qemu_devtree_getparent(fdti->fdt, node_path);
+    }
+
+    if (parent_path) {
+        parent = fdt_init_get_opaque(fdti, parent_path);
+    }
+
+    for (reg->n = 0;; reg->n++) {
+        char ph_parent[DT_PATH_LENGTH];
+        const char *pnp = parent_path;
+
+        reg->parents = g_renew(Object *, reg->parents, reg->n + 1);
+        reg->parents[reg->n] = parent;
+
+        if (extended) {
+            int p_ph = qemu_fdt_getprop_cell(fdti->fdt, node_path,
+                                                "reg-extended", cell_idx++,
+                                                &errp);
+            if (errp) {
+                error_free(errp);
+                errp = NULL;
+                goto exit_reg_parse;
+            }
+            if (qemu_devtree_get_node_by_phandle(fdti->fdt, ph_parent,
+                                                    p_ph)) {
+                goto exit_reg_parse;
+            }
+
+            while (!fdt_init_has_opaque(fdti, ph_parent) &&
+                   qemu_in_coroutine()) {
+                fdt_init_yield(fdti);
+            }
+
+            if (!fdt_init_has_opaque(fdti, ph_parent)) {
+                goto exit_reg_parse;
+            }
+
+            reg->parents[reg->n] = fdt_init_get_opaque(fdti, ph_parent);
+            pnp = ph_parent;
+        }
+
+        for (i = 0; i < FDT_GENERIC_REG_TUPLE_LENGTH; ++i) {
+            const char *size_prop_name = fdt_generic_reg_size_prop_names[i];
+            int nc = qemu_fdt_getprop_cell_inherited(fdti->fdt, node_path,
+                                            size_prop_name, 0, &errp);
+            uint64_t val = 0;
+
+            if (errp) {
+                int size_default = fdt_generic_reg_cells_defaults[i];
+
+                fdt_debug_np("WARNING: no %s for %s container, assuming "
+                            "default of %d\n", size_prop_name, pnp,
+                            size_default);
+                nc = size_default;
+                error_free(errp);
+                errp = NULL;
+            }
+
+            reg->x[i] = g_renew(uint64_t, reg->x[i], reg->n + 1);
+            for (int j = 0; j < nc; ++j) {
+                val <<= 32;
+                val |= qemu_fdt_getprop_cell(fdti->fdt, node_path,
+                                            extended ? "reg-extended"
+                                                        : "reg",
+                                            cell_idx + j, &errp);
+               if (errp) {
+                    val = 0;
+                    break;
+               }
+            }
+            reg->x[i][reg->n] = val;
+            cell_idx += nc;
+            if (errp) {
+                goto exit_reg_parse;
+            }
+        }
+    }
+exit_reg_parse:
+    if (errp) {
+        error_free(errp);
+    }
+
+    g_free(parent_path);
+
+    return reg;
+}
+
+static void fdt_parse_node_reg_prop(FDTMachineInfo *fdti, char *node_path,
+                            Object *dev)
+{
+    int i;
+
+    FDTGenericRegPropInfo *reg = fdt_get_reg_info(fdti, node_path, dev);
+    if (!reg) {
+        return;
+    }
+
+    if (object_dynamic_cast(dev, TYPE_FDT_GENERIC_MMAP)) {
+        FDTGenericMMapClass *fmc = FDT_GENERIC_MMAP_GET_CLASS(dev);
+        if (fmc->parse_reg) {
+            while (fmc->parse_reg(FDT_GENERIC_MMAP(dev), *reg,
+                                  &error_abort) && qemu_in_coroutine()) {
+                fdt_init_yield(fdti);
+            }
+        }
+    }
+
+    g_free(reg->parents);
+
+    for (i = 0; i < FDT_GENERIC_REG_TUPLE_LENGTH; ++i) {
+        g_free(reg->x[i]);
+    }
+
+    g_free(reg);
+}
+
 static void fdt_init_parent_node(Object *dev, Object *parent, char *node_path)
 {
     if (dev->parent) {
@@ -744,6 +900,8 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
 
     fdt_init_device_realize(fdti, node_path, dev);
 
+    fdt_parse_node_reg_prop(fdti, node_path, dev);
+
     g_free(parent_node_path);
 
     return 0;
diff --git a/include/hw/core/fdt_generic_util.h b/include/hw/core/fdt_generic_util.h
index 6fb0708d7a..a04ded41ae 100644
--- a/include/hw/core/fdt_generic_util.h
+++ b/include/hw/core/fdt_generic_util.h
@@ -127,6 +127,12 @@ typedef struct FDTGenericRegPropInfo {
     Object **parents;
 } FDTGenericRegPropInfo;
 
+/*
+ * Get parsed 'reg' or 'reg-extended' properties from dts node
+ */
+FDTGenericRegPropInfo*
+fdt_get_reg_info(FDTMachineInfo *fdti, char *node_path, Object *dev);
+
 typedef struct FDTGenericMMapClass {
     /*< private >*/
     InterfaceClass parent_class;
-- 
2.43.0


