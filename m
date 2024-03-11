Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1DDC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjklM-0005HE-6R; Mon, 11 Mar 2024 14:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjklI-0005Br-Sv; Mon, 11 Mar 2024 14:52:37 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjklH-00052h-0j; Mon, 11 Mar 2024 14:52:36 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dd3bdb6e9eso29238145ad.3; 
 Mon, 11 Mar 2024 11:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710183153; x=1710787953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=53KvBEFRksY4/H9eNV515BpO58gbPn08sKddMwMjXl8=;
 b=EKP9b3UzHgEHLVuPXakLnj/YKDlHz4Xi2EFpBr6tM5OiqnOg5zSLusvtRdgaQo5gSD
 zny7EG8m6e7hAY2IYutGCHe7tiec8WM/UTJr1o+Y60J/d7v3/UgZuz9CwHA/XdEnJbZj
 ustqghDIUfV9MKzAh7jekxT0zt/czKlGlemCpC04wE4TJOKggKiV4DCmcBCxsbA4WW/c
 EgPRbjVaj9z7K/A8xZo3i6+QZ0GlBcQSMQK8JofUg80TaXUL8dy5sDkt22DegmBtWYHy
 +RuhFsDdN4+FJdb0qv+juqCyOfdo/VjlK3A1FCNQZlEqHg6/I8mhgA/CUgT3N6Zdi1rc
 pGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710183153; x=1710787953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=53KvBEFRksY4/H9eNV515BpO58gbPn08sKddMwMjXl8=;
 b=wFrfwZPRcSShYt9mPjoApqd65iYvEPJNDM6AoETKtFXmnfO6UYJhNw07zO5lwrs45T
 wwzijDf0Eioeth4fQVLnvHC156khQSXxXIxexrPnpuivQ5PYwumjvJ+rNcMQ/7qvmyXq
 ip5RFK0Xoqgq5JfQvNpN8wYK7IcO75II3XYKrUjhcVceXulSZf1XiLTma7qLLiLzX2af
 /VPpTgf0Hxa3DcT2gNW41LyKeMk/6CcUG4ziVBhSQkM8hmoMoa0IKcSp20XFCevXAJXF
 rTOc6eDGgx31BW8swIwG1DD+W35sEI5Z/sPnoHVbENUjTzhNLQa8ZbGmxlNhpfWk9xk+
 /UyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwOkyyWEWkSkz6mdKtJ+6kkfgUZPV8KtDz6B3MMr2sWq4VT6U7O91FqkA0/LJSESks5P9phRBsM7NW9s1qY6e6diNTPpw=
X-Gm-Message-State: AOJu0YyhW4WBdU6JY+B4In3mnE1tS6wgcaaV2lr1AjmupZ16f16d7WVB
 U81j8+LbHHmtfrRZg6Ue1y3Y4ybzyaKowmS4ykfCewJBSg4L+l+lhzjR/ait+QQ=
X-Google-Smtp-Source: AGHT+IEWcfkVYRP0Av+bh67PaDEBGpX6AyfdC4tSgeaSf1wNuP+ZXXlnNuiTvkm0dumU0Ns+KReUWg==
X-Received: by 2002:a17:902:e884:b0:1dd:9984:29cd with SMTP id
 w4-20020a170902e88400b001dd998429cdmr4873507plg.19.1710183152812; 
 Mon, 11 Mar 2024 11:52:32 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a170903018200b001dd7d00f7afsm4843887plg.18.2024.03.11.11.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 11:52:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH 07/13] ppc/pnv: Permit ibm, pa-features set per machine variant
Date: Tue, 12 Mar 2024 04:51:49 +1000
Message-ID: <20240311185200.2185753-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311185200.2185753-1-npiggin@gmail.com>
References: <20240311185200.2185753-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This allows different pa-features for powernv8/9/10.

Cc: "Cédric Le Goater" <clg@kaod.org>
Cc: "Frédéric Barrat" <fbarrat@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index aa9786e970..52d964f77a 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -133,7 +133,7 @@ static int get_cpus_node(void *fdt)
  * device tree, used in XSCOM to address cores and in interrupt
  * servers.
  */
-static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
+static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
 {
     PowerPCCPU *cpu = pc->threads[0];
     CPUState *cs = CPU(cpu);
@@ -149,11 +149,6 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
     uint32_t cpufreq = 1000000000;
     uint32_t page_sizes_prop[64];
     size_t page_sizes_prop_size;
-    const uint8_t pa_features[] = { 24, 0,
-                                    0xf6, 0x3f, 0xc7, 0xc0, 0x00, 0xf0,
-                                    0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
-                                    0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
-                                    0x80, 0x00, 0x80, 0x00, 0x80, 0x00 };
     int offset;
     char *nodename;
     int cpus_offset = get_cpus_node(fdt);
@@ -236,15 +231,14 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
                            page_sizes_prop, page_sizes_prop_size)));
     }
 
-    _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
-                       pa_features, sizeof(pa_features))));
-
     /* Build interrupt servers properties */
     for (i = 0; i < smt_threads; i++) {
         servers_prop[i] = cpu_to_be32(pc->pir + i);
     }
     _FDT((fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
                        servers_prop, sizeof(*servers_prop) * smt_threads)));
+
+    return offset;
 }
 
 static void pnv_dt_icp(PnvChip *chip, void *fdt, uint32_t pir,
@@ -299,6 +293,17 @@ PnvChip *pnv_chip_add_phb(PnvChip *chip, PnvPHB *phb)
     return chip;
 }
 
+/*
+ * Same as spapr pa_features_207 except pnv always enables CI largepages bit.
+ * HTM is always enabled because TCG does implement HTM, it's just a
+ * degenerate implementation.
+ */
+static const uint8_t pa_features_207[] = { 24, 0,
+                 0xf6, 0x3f, 0xc7, 0xc0, 0x00, 0xf0,
+                 0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
+                 0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
+                 0x80, 0x00, 0x80, 0x00, 0x80, 0x00 };
+
 static void pnv_chip_power8_dt_populate(PnvChip *chip, void *fdt)
 {
     static const char compat[] = "ibm,power8-xscom\0ibm,xscom";
@@ -311,8 +316,12 @@ static void pnv_chip_power8_dt_populate(PnvChip *chip, void *fdt)
 
     for (i = 0; i < chip->nr_cores; i++) {
         PnvCore *pnv_core = chip->cores[i];
+        int offset;
+
+        offset = pnv_dt_core(chip, pnv_core, fdt);
 
-        pnv_dt_core(chip, pnv_core, fdt);
+        _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
+                           pa_features_207, sizeof(pa_features_207))));
 
         /* Interrupt Control Presenters (ICP). One per core. */
         pnv_dt_icp(chip, fdt, pnv_core->pir, CPU_CORE(pnv_core)->nr_threads);
@@ -335,8 +344,12 @@ static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
 
     for (i = 0; i < chip->nr_cores; i++) {
         PnvCore *pnv_core = chip->cores[i];
+        int offset;
 
-        pnv_dt_core(chip, pnv_core, fdt);
+        offset = pnv_dt_core(chip, pnv_core, fdt);
+
+        _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
+                           pa_features_207, sizeof(pa_features_207))));
     }
 
     if (chip->ram_size) {
@@ -358,8 +371,12 @@ static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
 
     for (i = 0; i < chip->nr_cores; i++) {
         PnvCore *pnv_core = chip->cores[i];
+        int offset;
+
+        offset = pnv_dt_core(chip, pnv_core, fdt);
 
-        pnv_dt_core(chip, pnv_core, fdt);
+        _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
+                           pa_features_207, sizeof(pa_features_207))));
     }
 
     if (chip->ram_size) {
-- 
2.42.0


