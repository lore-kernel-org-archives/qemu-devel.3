Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C8CD1950F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQd5-0001ZM-16; Mon, 26 Jan 2026 12:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcp-0001Pj-2O
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:44 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcm-00007S-5Z
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:42 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48049955f7fso41117655e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 09:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769449418; x=1770054218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p4fgFw+MmsKOfnzb3jQSk/XlDC0OxrRjW4c0oi2lmAo=;
 b=B3BV2XQfKxB8RQ3iZwrxHeK0E2UIEO4wUe+srZMZX85yK1mx9UztnFL41vDd8DJa6T
 Q8JcY9mPe6Tzh/Km2/TPT31tkTMKXpgBWzzjG6fstZY5/hRHV/iCAuaIlbreL3Lsdj90
 UsCyoY0LBke1cJUuMrb/RF7DqjtxIpFPxbl5wz77OFRJZkyDIGAok1x6ytPEU8I0vfLC
 OJzr3kq9nHiSMuXk4k+1yM8/ko2zvI+8mytDAokmYQtuy7DMHhZ5EKxDvZ1k6KG8Hxp1
 1OpNORRMuSO7YDDdFutDw6RDJyGbVR4JUL1eRybKvbfvxN93h09p3faVptWWK5IeW3ob
 uE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769449418; x=1770054218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p4fgFw+MmsKOfnzb3jQSk/XlDC0OxrRjW4c0oi2lmAo=;
 b=HCu07+m2jcu/czM2O3ju/Zuv69ZYaGLXBGZ7RdgPAXnf3AWFp6sUyJ3NWI+lA7EgPx
 ptYyvnwusGjjK3gW/K9ZR2/G9sH1zbeuPh4abDQcE0BW0j/Xg/s9hejADTmrlDrW4LIX
 EFu4j1NDdkWSJ5vga8sQt418myPr6vEom0Vwh8QQRjgmm99IUnmLJNW2GXNqcylVFCZT
 x/RDrulVbuA0baqW2MPbLqsmDz3Jha5CJY3DTdnbqotIh/4YsZ0SbjoBjQmFQ2mBlSoO
 FeNjvBVmLtfuiz4siqOW4w0ze5flTVny2PYwjw/r6foWb7Kmx+E+KtiRyMwS5XdxzUVu
 yhHQ==
X-Gm-Message-State: AOJu0YyDRxaZNYgrOY6XzcA4+ZOc0vlIm+a1sHswtYveGHTxd7ANXmu4
 USEH+Wh6UGogVyWQR3RFCW1WkxpIVK3ARkzDTFWPIrerKj1WzMIaD3oHlbjZ0GQ9
X-Gm-Gg: AZuq6aLq1ZdS+zQDB/asuD2A9h0uC8MZ0eVxl1EYAfDaRjJPzaSrMxr+ZL5gxqd2zsL
 +8VXrKAZYGepcsaVuZHJOPbtBv0v8AaSF4lvTZTchpGnFm3ASNRuNPv/U8Uzx1RI9KyTi0WMWLD
 d3KEc2V95w0D8JcUrpRV7Q5z0d8CQrMk7SAHnydBFlAOVEEzRKiHAh0k1L3U7Hv1PkTTSARoqF3
 C8qVlTxBEllYe//wtg8aHxE/R5Ytv/idkc9f+zCyOhjIZCMA510GL6fbUzxKycnyR7vhIoRURjX
 SW1ZS3PlC2LDiVK5fRMI+RftyIef9zjmmakJWcES+kHZo2HZn8JT8Z+rPM2vmUOiL5TxqOn3fWZ
 S7QEYpf8WPW1IXqmOi3o2Bw5Pm2fyuI+2n0DihMETIQdUlNVCE9ZHRwBMSdOAtesT0IU2pNBq20
 D0vtfmJAMhceFj27B/C/1KxjuUJcI2+9qetz+NF66qTLY/0PRbPSnfsQ==
X-Received: by 2002:a05:6000:2501:b0:431:c60:c5ed with SMTP id
 ffacd0b85a97d-435ca1258a5mr8598574f8f.13.1769449417839; 
 Mon, 26 Jan 2026 09:43:37 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-71-105.adsl.net.t-com.hr.
 [93.143.71.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71730sm34199603f8f.26.2026.01.26.09.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 09:43:37 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com
Subject: [PATCH 14/27] hw/core/fdt_generic_util: map device memory
Date: Mon, 26 Jan 2026 18:43:00 +0100
Message-ID: <20260126174313.1418150-15-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x32b.google.com
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

Parse device mmio regions provided within 'reg' and
'reg-extened' device tree properties.
Call corresponding device interface class handlers to
create memory regions.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c | 103 +++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index d57d9387a1..af20ffd9db 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -622,6 +622,22 @@ static inline uint64_t get_int_be(const void *p, int len)
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
 /*
  * Error handler for device creation failure.
  *
@@ -892,6 +908,8 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
 {
     Object *dev, *parent;
     char *dev_type = NULL;
+    Error *errp = NULL;
+    int i;
     QEMUDevtreeProp *prop, *props;
     char parent_node_path[DT_PATH_LENGTH];
 
@@ -1022,6 +1040,91 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
         }
     }
 
+    if (object_dynamic_cast(dev, TYPE_SYS_BUS_DEVICE) ||
+        object_dynamic_cast(dev, TYPE_FDT_GENERIC_MMAP)) {
+        FDTGenericRegPropInfo reg = {0};
+        char parent_path[DT_PATH_LENGTH];
+        int cell_idx = 0;
+        bool extended = true;
+
+        qemu_fdt_getprop_cell(fdti->fdt, node_path, "reg-extended", 0, false,
+                              &errp);
+        if (errp) {
+            error_free(errp);
+            errp = NULL;
+            extended = false;
+            qemu_devtree_getparent(fdti->fdt, parent_path, node_path);
+        }
+
+        for (reg.n = 0;; reg.n++) {
+            char ph_parent[DT_PATH_LENGTH];
+            const char *pnp = parent_path;
+
+            reg.parents = g_renew(Object *, reg.parents, reg.n + 1);
+            reg.parents[reg.n] = parent;
+
+            if (extended) {
+                int p_ph = qemu_fdt_getprop_cell(fdti->fdt, node_path,
+                                                 "reg-extended", cell_idx++,
+                                                 false, &errp);
+                if (errp) {
+                    error_free(errp);
+                    errp = NULL;
+                    goto exit_reg_parse;
+                }
+                if (qemu_devtree_get_node_by_phandle(fdti->fdt, ph_parent,
+                                                     p_ph)) {
+                    goto exit_reg_parse;
+                }
+                while (!fdt_init_has_opaque(fdti, ph_parent)) {
+                    fdt_init_yield(fdti);
+                }
+                reg.parents[reg.n] = fdt_init_get_opaque(fdti, ph_parent);
+                pnp = ph_parent;
+            }
+
+            for (i = 0; i < FDT_GENERIC_REG_TUPLE_LENGTH; ++i) {
+                const char *size_prop_name = fdt_generic_reg_size_prop_names[i];
+                int nc = qemu_fdt_getprop_cell(fdti->fdt, pnp, size_prop_name,
+                                               0, true, &errp);
+
+                if (errp) {
+                    int size_default = fdt_generic_reg_cells_defaults[i];
+
+                    DB_PRINT_NP(0, "WARNING: no %s for %s container, assuming "
+                                "default of %d\n", size_prop_name, pnp,
+                                size_default);
+                    nc = size_default;
+                    error_free(errp);
+                    errp = NULL;
+                }
+
+                reg.x[i] = g_renew(uint64_t, reg.x[i], reg.n + 1);
+                reg.x[i][reg.n] = nc ?
+                    qemu_fdt_getprop_sized_cell(fdti->fdt, node_path,
+                                                extended ? "reg-extended"
+                                                         : "reg",
+                                                cell_idx, nc, &errp)
+                    : 0;
+                cell_idx += nc;
+                if (errp) {
+                    goto exit_reg_parse;
+                }
+            }
+        }
+exit_reg_parse:
+
+        if (object_dynamic_cast(dev, TYPE_FDT_GENERIC_MMAP)) {
+            FDTGenericMMapClass *fmc = FDT_GENERIC_MMAP_GET_CLASS(dev);
+            if (fmc->parse_reg) {
+                while (fmc->parse_reg(FDT_GENERIC_MMAP(dev), reg,
+                                      &error_abort)) {
+                    fdt_init_yield(fdti);
+                }
+            }
+        }
+    }
+
     g_free(dev_type);
 
     return 0;
-- 
2.43.0


