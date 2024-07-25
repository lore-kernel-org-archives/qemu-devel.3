Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10ECC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Kl-0000wm-8w; Thu, 25 Jul 2024 19:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Kf-0000h3-Pc; Thu, 25 Jul 2024 19:57:13 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Kd-0001Jq-Nj; Thu, 25 Jul 2024 19:57:13 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7a264a24ea7so283233a12.3; 
 Thu, 25 Jul 2024 16:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951830; x=1722556630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DcGp0MCsUZIWO8ubIFG5p3FvmXSUuWq+0YDo/ZNaMg=;
 b=LWLXVojalscJXr2vQ5TdRuCigqnvUdenLsoeXNa1/5tNFjDwtuxWsy9c08hY5AT/Oy
 FWzJBaotppSKofLWoN7S91ATD7OpLXl8Wt40y+E5hiTf2OSQIcgGaAS+9Kf5yXheTS/+
 beI5zBu7pLZE9exGWslqtsepbaZWKDhzy42em32hgcgL0T6bKStm402dUv0DQ6DWvD7P
 onedA+iF0RzMXbdpY0ZgnZl54dLITWm9UGey9m3ntfS2/6ykVxCjLN+RhTDzFP2x05VC
 +GW9sMZT0A6a1bTSOMwR4XOLENx3nCyytUflOfBXEJA66v508JW6VBe3WvMMNGHBqMBP
 m0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951830; x=1722556630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7DcGp0MCsUZIWO8ubIFG5p3FvmXSUuWq+0YDo/ZNaMg=;
 b=XgAm8ca640XSBp+h7YH77y5QpdKOk9iGzayaOF9DHhznCar9tjUZfsxKOhuo7dU5bt
 FjSmWZYFOW0/Dszl/P53l7pQ6cCLyD09BW/bzvjzyIubUCnZ4r/cfytRF5HAC+srC0Dc
 9j3yaAat2bAKXDjASKAEhXcy9wVVp89pkqjn5WRdwXSfuQYSDAfFB90gKX29tBsgUpju
 dgOiA0JwAtDyolpL4ArjGgg5IPMZM9Tx32Uic4nD7dTrXU7ujE1AuCGSy0ZQTy0LboMM
 kfpRX99tMkV0M0Pqnxo37355CU5thN/daucael/qGb1ys5uMVzqDGxEAbOJF8sLwjoeG
 7MrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb/r4U1cDvchhzi9OeOr1U3r2QqbJFBgrhRwSrOCwvMN5Yd7Atss8n3zZcDkRy/rYPEajahv8Fdz1wx+IkgQWIJvpJ
X-Gm-Message-State: AOJu0YyaeDMSS+AsTdPc/7fFtHmquji1ymtnrHj/MEpkgeWaOxKSHFah
 X7uptxhxRG6YKkx/jJ0tfpaGoUftNMHzI/Hyd7G8r1VW9w6j8gRBNImZSg==
X-Google-Smtp-Source: AGHT+IFh7+e+Ypolzd7mSk6x3kKC5lZk9kLfvd29fbBeOHq8Z8uPNMJYeLphG0kuF1EpmsJAEkVpVA==
X-Received: by 2002:a05:6a21:3213:b0:1c3:b0d4:3e8f with SMTP id
 adf61e73a8af0-1c47b18da5fmr3171880637.14.1721951829663; 
 Thu, 25 Jul 2024 16:57:09 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:57:09 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Michael Kowal <kowal@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 46/96] pnv/xive2: Configure Virtualization Structure Tables
 through the PC
Date: Fri, 26 Jul 2024 09:53:19 +1000
Message-ID: <20240725235410.451624-47-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52b.google.com
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

Both the virtualization layer (VC) and presentation layer (PC) need to
be configured to access the VSTs. Since the information is redundant,
the xive model combines both into one set of tables and only the
definitions going through the VC are kept. The definitions through the
PC are ignored. That works well as long as firmware calls the VC for
all the tables.

For the NVG and NVC tables, it can make sense to only configure them
with the PC, since they are only used by the presenter. So this patch
allows firmware to configure the VST tables through the PC as well.
The definitions are still shared, since the VST tables can be set
through both the VC and/or PC, they are dynamically re-mapped in
memory by first deleting the memory subregion.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/pnv_xive2.c | 47 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 561e61682e..33e76633b5 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -762,6 +762,9 @@ static void pnv_xive2_vst_set_exclusive(PnvXive2 *xive, uint8_t type,
          * entries provisioned by FW (such as skiboot) and resize the
          * ESB window accordingly.
          */
+        if (memory_region_is_mapped(&xsrc->esb_mmio)) {
+            memory_region_del_subregion(&xive->esb_mmio, &xsrc->esb_mmio);
+        }
         if (!(VSD_INDIRECT & vsd)) {
             memory_region_set_size(&xsrc->esb_mmio, vst_tsize * SBE_PER_BYTE
                                    * (1ull << xsrc->esb_shift));
@@ -777,6 +780,9 @@ static void pnv_xive2_vst_set_exclusive(PnvXive2 *xive, uint8_t type,
         /*
          * Backing store pages for the END.
          */
+        if (memory_region_is_mapped(&end_xsrc->esb_mmio)) {
+            memory_region_del_subregion(&xive->end_mmio, &end_xsrc->esb_mmio);
+        }
         if (!(VSD_INDIRECT & vsd)) {
             memory_region_set_size(&end_xsrc->esb_mmio, (vst_tsize / info->size)
                                    * (1ull << end_xsrc->esb_shift));
@@ -801,13 +807,10 @@ static void pnv_xive2_vst_set_exclusive(PnvXive2 *xive, uint8_t type,
  * Both PC and VC sub-engines are configured as each use the Virtual
  * Structure Tables
  */
-static void pnv_xive2_vst_set_data(PnvXive2 *xive, uint64_t vsd)
+static void pnv_xive2_vst_set_data(PnvXive2 *xive, uint64_t vsd,
+                                   uint8_t type, uint8_t blk)
 {
     uint8_t mode = GETFIELD(VSD_MODE, vsd);
-    uint8_t type = GETFIELD(VC_VSD_TABLE_SELECT,
-                            xive->vc_regs[VC_VSD_TABLE_ADDR >> 3]);
-    uint8_t blk = GETFIELD(VC_VSD_TABLE_ADDRESS,
-                           xive->vc_regs[VC_VSD_TABLE_ADDR >> 3]);
     uint64_t vst_addr = vsd & VSD_ADDRESS_MASK;
 
     if (type > VST_ERQ) {
@@ -842,6 +845,16 @@ static void pnv_xive2_vst_set_data(PnvXive2 *xive, uint64_t vsd)
     }
 }
 
+static void pnv_xive2_vc_vst_set_data(PnvXive2 *xive, uint64_t vsd)
+{
+    uint8_t type = GETFIELD(VC_VSD_TABLE_SELECT,
+                            xive->vc_regs[VC_VSD_TABLE_ADDR >> 3]);
+    uint8_t blk = GETFIELD(VC_VSD_TABLE_ADDRESS,
+                           xive->vc_regs[VC_VSD_TABLE_ADDR >> 3]);
+
+    pnv_xive2_vst_set_data(xive, vsd, type, blk);
+}
+
 /*
  * MMIO handlers
  */
@@ -1271,7 +1284,7 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
     case VC_VSD_TABLE_ADDR:
        break;
     case VC_VSD_TABLE_DATA:
-        pnv_xive2_vst_set_data(xive, val);
+        pnv_xive2_vc_vst_set_data(xive, val);
         break;
 
     /*
@@ -1490,6 +1503,16 @@ static uint64_t pnv_xive2_ic_pc_read(void *opaque, hwaddr offset,
     return val;
 }
 
+static void pnv_xive2_pc_vst_set_data(PnvXive2 *xive, uint64_t vsd)
+{
+    uint8_t type = GETFIELD(PC_VSD_TABLE_SELECT,
+                            xive->pc_regs[PC_VSD_TABLE_ADDR >> 3]);
+    uint8_t blk = GETFIELD(PC_VSD_TABLE_ADDRESS,
+                           xive->pc_regs[PC_VSD_TABLE_ADDR >> 3]);
+
+    pnv_xive2_vst_set_data(xive, vsd, type, blk);
+}
+
 static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
                                   uint64_t val, unsigned size)
 {
@@ -1500,12 +1523,18 @@ static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
     switch (offset) {
 
     /*
-     * VSD table settings. Only taken into account in the VC
-     * sub-engine because the Xive2Router model combines both VC and PC
-     * sub-engines
+     * VSD table settings.
+     * The Xive2Router model combines both VC and PC sub-engines. We
+     * allow to configure the tables through both, for the rare cases
+     * where a table only really needs to be configured for one of
+     * them (e.g. the NVG table for the presenter). It assumes that
+     * firmware passes the same address to the VC and PC when tables
+     * are defined for both, which seems acceptable.
      */
     case PC_VSD_TABLE_ADDR:
+        break;
     case PC_VSD_TABLE_DATA:
+        pnv_xive2_pc_vst_set_data(xive, val);
         break;
 
     case PC_NXC_PROC_CONFIG:
-- 
2.45.2


