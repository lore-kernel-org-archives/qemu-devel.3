Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E36CC3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 14:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRueI-0005oI-TW; Thu, 11 Jul 2024 10:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRueG-0005Wg-0O; Thu, 11 Jul 2024 10:19:52 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRueE-0005Wv-9X; Thu, 11 Jul 2024 10:19:51 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-6bce380eb9bso585795a12.0; 
 Thu, 11 Jul 2024 07:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720707587; x=1721312387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98h1jtA/ysXVkdo2AXd2AHkw4hRmAuxtfKheKSDQWJU=;
 b=PsAD/u+ZlOykdiwiw3Ok58aV3PyYqf4/MeqHxUQoRowilSl9wfvMKuyxYjXGInIl+o
 DUmmeWaL2p+1QO1TeN1hMMCp3HBn36N1GHTh1QNgIdx/WXaCsnqbK1K+WzTIOGAPvgwz
 XhAoCIc9ApqLHfJIgdOo7SP3GER4sp1Kgob0i3Zs7EOGQcumPBhbe27lIVGVCezkPD2h
 PBUY81KK01xHeIMqzJjKUeEO4oqJifbc0p8cd3/Pnfv0Zl8VEQcdjFVsiGrLBetz+Pbw
 PY0jBIWIngRvMt6Ya0OzcLkJdNOO4puzqZN59Ly8AF4wwI7OyYtLES9FlkPTkbKUSST6
 V/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720707587; x=1721312387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=98h1jtA/ysXVkdo2AXd2AHkw4hRmAuxtfKheKSDQWJU=;
 b=POVYkpCRzaYC7eW3lOjBakXNO6gz9UzmwLT/JSF5QJGYYFDvmCEiT/8nfsjeJTpFdj
 El0GJylsWEsDOO/qeWYIH+E/52+7eBtFzwLc1cW85GUjg8ZGDdklbSv/YFn5t5dmv2xG
 T2IOSsLHxLig08iBDXt0/UJKenQ5009mSi7M96bAJY3oBVWcRvl9p93uCn4bzKm2fJLf
 2V25f5Ys824SL7eY5GI9t1tt1NRZILE44pp3+vkIG0CUMQsTl8rtjhJgqhmPTs0Di3Tj
 inQi33m6QdeVeiwwZ+NaUV+RRD/FR+ni73iFiw+PuucdQe9CJNxC8t6F2yb7GlAXoVTq
 i/Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+Irrlku56L0dtlgYWHN3rYpMGlWjbQTkRgVmDUtCSaFt34Mq6H7WGdX0FwXYtokoGlBbC5CMf0lu2GEFoCm23IGRsiJI=
X-Gm-Message-State: AOJu0YwpYgDoeeT7uw9XzLQHF9p0/X5+YnRl3y0TWTYuFC0KKMTQQbFX
 RB6QV4XUZwPFankO8mQGkY0zz6fdtXohZi/P6S/eGe8/rd4gJXM7RGq5Ahgh
X-Google-Smtp-Source: AGHT+IEdnUkIvLN0fF9Y0IsgMwN8Pr3QYgKA3NygzSsqOZLoOuiKyrsEN6Gnn5pk8lacuQm0T81k5Q==
X-Received: by 2002:a05:6a21:999d:b0:1c2:a0b2:e69 with SMTP id
 adf61e73a8af0-1c2a0b2110bmr8248049637.33.1720707587228; 
 Thu, 11 Jul 2024 07:19:47 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b54ec730fsm3308904b3a.173.2024.07.11.07.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 07:19:46 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 12/18] ppc/pnv: Add allow for big-core differences in DT
 generation
Date: Fri, 12 Jul 2024 00:18:44 +1000
Message-ID: <20240711141851.406677-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240711141851.406677-1-npiggin@gmail.com>
References: <20240711141851.406677-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

device-tree building needs to account for big-core mode, because it is
driven by qemu cores (small cores). Every second core should be skipped,
and every core should describe threads for both small-cores that make
up the big core.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d2ddc49142..d7488be74c 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -141,9 +141,9 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
     CPUPPCState *env = &cpu->env;
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
     PnvChipClass *pnv_cc = PNV_CHIP_GET_CLASS(chip);
-    g_autofree uint32_t *servers_prop = g_new(uint32_t, smt_threads);
+    uint32_t *servers_prop;
     int i;
-    uint32_t pir;
+    uint32_t pir, tir;
     uint32_t segs[] = {cpu_to_be32(28), cpu_to_be32(40),
                        0xffffffff, 0xffffffff};
     uint32_t tbfreq = PNV_TIMEBASE_FREQ;
@@ -154,7 +154,10 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
     char *nodename;
     int cpus_offset = get_cpus_node(fdt);
 
-    pnv_cc->get_pir_tir(chip, pc->hwid, 0, &pir, NULL);
+    pnv_cc->get_pir_tir(chip, pc->hwid, 0, &pir, &tir);
+
+    /* Only one DT node per (big) core */
+    g_assert(tir == 0);
 
     nodename = g_strdup_printf("%s@%x", dc->fw_name, pir);
     offset = fdt_add_subnode(fdt, cpus_offset, nodename);
@@ -235,12 +238,28 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
     }
 
     /* Build interrupt servers properties */
-    for (i = 0; i < smt_threads; i++) {
-        pnv_cc->get_pir_tir(chip, pc->hwid, i, &pir, NULL);
-        servers_prop[i] = cpu_to_be32(pir);
+    if (pc->big_core) {
+        servers_prop = g_new(uint32_t, smt_threads * 2);
+        for (i = 0; i < smt_threads; i++) {
+            pnv_cc->get_pir_tir(chip, pc->hwid, i, &pir, NULL);
+            servers_prop[i * 2] = cpu_to_be32(pir);
+
+            pnv_cc->get_pir_tir(chip, pc->hwid + 1, i, &pir, NULL);
+            servers_prop[i * 2 + 1] = cpu_to_be32(pir);
+        }
+        _FDT((fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
+                          servers_prop, sizeof(*servers_prop) * smt_threads
+                                        * 2)));
+    } else {
+        servers_prop = g_new(uint32_t, smt_threads);
+        for (i = 0; i < smt_threads; i++) {
+            pnv_cc->get_pir_tir(chip, pc->hwid, i, &pir, NULL);
+            servers_prop[i] = cpu_to_be32(pir);
+        }
+        _FDT((fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
+                          servers_prop, sizeof(*servers_prop) * smt_threads)));
     }
-    _FDT((fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
-                       servers_prop, sizeof(*servers_prop) * smt_threads)));
+    g_free(servers_prop);
 
     return offset;
 }
@@ -389,6 +408,10 @@ static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
 
         _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
                            pa_features_300, sizeof(pa_features_300))));
+
+        if (pnv_core->big_core) {
+            i++; /* Big-core groups two QEMU cores */
+        }
     }
 
     if (chip->ram_size) {
@@ -450,6 +473,10 @@ static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
 
         _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
                            pa_features_31, sizeof(pa_features_31))));
+
+        if (pnv_core->big_core) {
+            i++; /* Big-core groups two QEMU cores */
+        }
     }
 
     if (chip->ram_size) {
-- 
2.45.1


