Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BCDC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1y7-0008Rq-J8; Tue, 12 Mar 2024 09:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1y5-0008M3-BN; Tue, 12 Mar 2024 09:14:57 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1y2-0006rA-EX; Tue, 12 Mar 2024 09:14:56 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e6afb754fcso182342b3a.3; 
 Tue, 12 Mar 2024 06:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710249292; x=1710854092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wmZJDwvj+FJgsSty74chMzftbuB5FvT0QJ9riUDcjhc=;
 b=QIBQRi36iQBSWemeOAhHEQ6XjXYSFAWLZPlMDKboovkltrGrYQ9t3QNQVG/yjbLq2h
 Njq+WpAbIm9o+pIIC0cmX83vb6DQj/+YgWAycacWUj4ckzs+aF7vwP8uISLhXNT42DzN
 NPU7nW2PIZVN1/3/6ztYpqhZSoYxkU5GwajIdfdru+fRw4/R96TIBDcDLvJrk/Iq2kcN
 rznbzOfXjuoWJzQE8Y5zUrhegFxv/zR0/1ByzxGcZ2FX5bhLmxEltqiaw/C4TKcrB/jW
 QrIPitpfQRJDTxc6+EG+yhlQ2yWpgb5XipRkFz2Cd8GLXrlvbwswccwf72demUATXZMd
 oVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710249292; x=1710854092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wmZJDwvj+FJgsSty74chMzftbuB5FvT0QJ9riUDcjhc=;
 b=D8Wn9f82YHRqwsrsODpNFckqbnEz27Vz/154gNqIo/JDQK7H/zM/fjLNj5Ir6ixfiw
 e5POjhDgB9Zf4W2YgakK4h+SN5zWtWQwCmRgz6UCmyJmxHY08Z4sbbV9FYo1ExNhZuXU
 CHR1weCTeD0w02BEmJTkrin1V0fKW0GCNQ4N5bQco8mGaTkkdrGwLV0908GrbcHZ/18K
 aU5975o+rrIyLwLGXYHfYe0krn3XZvci6+HNQkvZ8w37GJ6IOVZhMm9PUrxEYxQTVDvQ
 4R6Ci02hsdvVtro7ltbUEi7EiBI7bER40TeTn9bDw6Fzt/MsLA8E3PbI0Qb39YPpX46+
 KSvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCIIhE1PaV4nlfIRBt+Qch/RJSj+9p3sb+9E5SFtcUJJsEimrbRaUQHOI0Aijko3KpDtbBnyZcBuumjwr3ZQGT873alkw=
X-Gm-Message-State: AOJu0Yx5iacWEmJ+yEWbfNKXxQYRvp81AfaSyqBoeB/Pgs/DBdCEu/D/
 B/xSf3HoQk8Pw3fEsi1n6RWPbjIQcKOQVVZXerykPFjKl0AUqxtKgbTNfiA1BEM=
X-Google-Smtp-Source: AGHT+IE3tLfO0e51FcEX4PzWYw1kIxCFxfpKOTLNUcLTV8224OUMCIIaCKuOk+/DM1XLkF4c8oO9Tw==
X-Received: by 2002:a05:6a00:1944:b0:6e6:1bd6:95ab with SMTP id
 s4-20020a056a00194400b006e61bd695abmr14152332pfk.11.1710249292474; 
 Tue, 12 Mar 2024 06:14:52 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 r15-20020aa78b8f000000b006e64f75c947sm6066084pfd.46.2024.03.12.06.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 06:14:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v2 07/10] ppc/pnv: Permit ibm,
 pa-features set per machine variant
Date: Tue, 12 Mar 2024 23:14:16 +1000
Message-ID: <20240312131419.2196845-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312131419.2196845-1-npiggin@gmail.com>
References: <20240312131419.2196845-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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


