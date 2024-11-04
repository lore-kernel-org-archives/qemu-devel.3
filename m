Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8989BD11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7krr-0008BT-Cu; Sun, 03 Nov 2024 19:22:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7krR-0006z8-Td; Sun, 03 Nov 2024 19:22:31 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7krP-0002me-EH; Sun, 03 Nov 2024 19:22:25 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-72097a5ca74so3421483b3a.3; 
 Sun, 03 Nov 2024 16:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679741; x=1731284541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bh6b9iqeWevef2cEJe76rh+lALiI/hMsSWHKlE5vZws=;
 b=RbSN8V9dU0Y7dXdspHTV7elI1MShJtKuopH9yJ5rVu3EBH/7wuxMIjNw0eu9pWF8w0
 8LsQMDBriQ/MGpziIA7/XN8NF38eRQePgDASyJ0Zw3I3UDABVOy7gu3GwVyWvW2JdW4B
 VBVzRMM4sTYyPwqJGqgEhpA45OcF9glBunyyc7kMeqziqJikerleviRLtj8EdmE2OPVN
 IMFInbO/0BbWzu+irIvzc/XoxQoKzxEWsObd2AbWplO09S8tP+Ke0eGYLjED37UavxHC
 y6Phnkie5MJTj9PGUi/VXKz9QNlxT2apL6G3bhiRwvReSzpY1esfGas2iH1C6A9QX5eu
 e1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679741; x=1731284541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bh6b9iqeWevef2cEJe76rh+lALiI/hMsSWHKlE5vZws=;
 b=nVpUEukq+Gkyvm2HRdfwNxNo8Z/e1NRTvBZKfenBKosssf2KtNfpofOs7TPHIbFKRn
 UPsBBdpXrZGSN0lTKKpx196DlDvi/CXMu2LG3JFfgZdxkRpee1d4tQmYHB5TDjcoaw7j
 zhmT442pUvCPZoD9yvmqXhWQ041n4Ym3/5oeXJvhNbzUxBgHP9rEVXswD5pqWAefdDnr
 b6T1CIDzTqzT8iMrTqXT7trhJUu1Hypg15s2ThxKmJXZ72aPDZRqUmtb/2TF1ysaNPlz
 smF9kip14xeNZxAtgac2rhVgZFk5fLUjbre4V9pua0Fh2QKpdteIdWXo3/TjFVm8bdNA
 9+iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJJ4AKBT7t9hw2z4bjOMcQRtl31GLw7/XWQm4m1A5eYepbP3NFNBXCGJwZ/+1XmsKlmhvhTi8bVA==@nongnu.org
X-Gm-Message-State: AOJu0YxlKqfASnMv9lpGoINJk9DCSDnAKDZOZ3Q/LL630zvsLLOVUvPg
 YH53Bg75LbA3hPfxFWxbsf5s9FMC3nmIzX1DaPIGhHblvl7e5huKoDHSug==
X-Google-Smtp-Source: AGHT+IH32QBCj49gUkmRjAAfu91xQIKVQqngiDg94k5ihZnRK0gvKy7I1559BbYXvh06Uv9kI7MIbw==
X-Received: by 2002:a05:6a21:1693:b0:1d9:1dcd:b22c with SMTP id
 adf61e73a8af0-1dba55734fdmr17159905637.47.1730679741329; 
 Sun, 03 Nov 2024 16:22:21 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:22:20 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 53/67] ppc/xive2: Dump the VP-group and crowd tables with 'info
 pic'
Date: Mon,  4 Nov 2024 10:18:42 +1000
Message-ID: <20241104001900.682660-54-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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

The 'info pic' HMP command dumps the state of the interrupt controller.
Add the dump of the NVG and NVC tables to its output to ease debug.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/pnv_xive2.c         | 44 +++++++++++++++++++++++++++--
 hw/intc/xive2.c             | 55 +++++++++++++++++++++++++++++++++++++
 include/hw/ppc/xive2.h      | 12 ++++++++
 include/hw/ppc/xive2_regs.h |  6 ++++
 4 files changed, 114 insertions(+), 3 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 78609105a8..834d32287b 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -490,6 +490,23 @@ static int pnv_xive2_write_nvp(Xive2Router *xrtr, uint8_t blk, uint32_t idx,
                               word_number);
 }
 
+static int pnv_xive2_get_nvgc(Xive2Router *xrtr, bool crowd,
+                              uint8_t blk, uint32_t idx,
+                              Xive2Nvgc *nvgc)
+{
+    return pnv_xive2_vst_read(PNV_XIVE2(xrtr), crowd ? VST_NVC : VST_NVG,
+                              blk, idx, nvgc);
+}
+
+static int pnv_xive2_write_nvgc(Xive2Router *xrtr, bool crowd,
+                                uint8_t blk, uint32_t idx,
+                                Xive2Nvgc *nvgc)
+{
+    return pnv_xive2_vst_write(PNV_XIVE2(xrtr), crowd ? VST_NVC : VST_NVG,
+                               blk, idx, nvgc,
+                               XIVE_VST_WORD_ALL);
+}
+
 static int pnv_xive2_nxc_to_table_type(uint8_t nxc_type, uint32_t *table_type)
 {
     switch (nxc_type) {
@@ -2407,6 +2424,8 @@ static void pnv_xive2_class_init(ObjectClass *klass, void *data)
     xrc->write_end = pnv_xive2_write_end;
     xrc->get_nvp   = pnv_xive2_get_nvp;
     xrc->write_nvp = pnv_xive2_write_nvp;
+    xrc->get_nvgc   = pnv_xive2_get_nvgc;
+    xrc->write_nvgc = pnv_xive2_write_nvgc;
     xrc->get_config  = pnv_xive2_get_config;
     xrc->get_block_id = pnv_xive2_get_block_id;
 
@@ -2497,8 +2516,9 @@ void pnv_xive2_pic_print_info(PnvXive2 *xive, GString *buf)
     Xive2Eas eas;
     Xive2End end;
     Xive2Nvp nvp;
+    Xive2Nvgc nvgc;
     int i;
-    uint64_t xive_nvp_per_subpage;
+    uint64_t entries_per_subpage;
 
     g_string_append_printf(buf, "XIVE[%x] Source %08x .. %08x\n",
                            blk, srcno0, srcno0 + nr_esbs - 1);
@@ -2530,10 +2550,28 @@ void pnv_xive2_pic_print_info(PnvXive2 *xive, GString *buf)
 
     g_string_append_printf(buf, "XIVE[%x] #%d NVPT %08x .. %08x\n",
                            chip_id, blk, 0, XIVE2_NVP_COUNT - 1);
-    xive_nvp_per_subpage = pnv_xive2_vst_per_subpage(xive, VST_NVP);
-    for (i = 0; i < XIVE2_NVP_COUNT; i += xive_nvp_per_subpage) {
+    entries_per_subpage = pnv_xive2_vst_per_subpage(xive, VST_NVP);
+    for (i = 0; i < XIVE2_NVP_COUNT; i += entries_per_subpage) {
         while (!xive2_router_get_nvp(xrtr, blk, i, &nvp)) {
             xive2_nvp_pic_print_info(&nvp, i++, buf);
         }
     }
+
+    g_string_append_printf(buf, "XIVE[%x] #%d NVGT %08x .. %08x\n",
+                           chip_id, blk, 0, XIVE2_NVP_COUNT - 1);
+    entries_per_subpage = pnv_xive2_vst_per_subpage(xive, VST_NVG);
+    for (i = 0; i < XIVE2_NVP_COUNT; i += entries_per_subpage) {
+        while (!xive2_router_get_nvgc(xrtr, false, blk, i, &nvgc)) {
+            xive2_nvgc_pic_print_info(&nvgc, i++, buf);
+        }
+    }
+
+    g_string_append_printf(buf, "XIVE[%x] #%d NVCT %08x .. %08x\n",
+                          chip_id, blk, 0, XIVE2_NVP_COUNT - 1);
+    entries_per_subpage = pnv_xive2_vst_per_subpage(xive, VST_NVC);
+    for (i = 0; i < XIVE2_NVP_COUNT; i += entries_per_subpage) {
+        while (!xive2_router_get_nvgc(xrtr, true, blk, i, &nvgc)) {
+            xive2_nvgc_pic_print_info(&nvgc, i++, buf);
+        }
+    }
 }
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index ac581fa195..26b6e72129 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -43,6 +43,26 @@ static uint64_t xive2_nvp_reporting_addr(Xive2Nvp *nvp)
     return cache_addr;
 }
 
+static uint32_t xive2_nvgc_get_backlog(Xive2Nvgc *nvgc, uint8_t priority)
+{
+    uint32_t val = 0;
+    uint8_t *ptr, i;
+
+    if (priority > 7) {
+        return 0;
+    }
+
+    /*
+     * The per-priority backlog counters are 24-bit and the structure
+     * is stored in big endian
+     */
+    ptr = (uint8_t *)&nvgc->w2 + priority * 3;
+    for (i = 0; i < 3; i++, ptr++) {
+        val = (val << 8) + *ptr;
+    }
+    return val;
+}
+
 void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf)
 {
     if (!xive2_eas_is_valid(eas)) {
@@ -189,6 +209,23 @@ void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx, GString *buf)
     g_string_append_c(buf, '\n');
 }
 
+void xive2_nvgc_pic_print_info(Xive2Nvgc *nvgc, uint32_t nvgc_idx, GString *buf)
+{
+    uint8_t i;
+
+    if (!xive2_nvgc_is_valid(nvgc)) {
+        return;
+    }
+
+    g_string_append_printf(buf, "  %08x PGoNext:%02x bklog: ", nvgc_idx,
+                           xive_get_field32(NVGC2_W0_PGONEXT, nvgc->w0));
+    for (i = 0; i <= XIVE_PRIORITY_MAX; i++) {
+        g_string_append_printf(buf, "[%d]=0x%x ",
+                               i, xive2_nvgc_get_backlog(nvgc, i));
+    }
+    g_string_append_printf(buf, "\n");
+}
+
 static void xive2_end_enqueue(Xive2End *end, uint32_t data)
 {
     uint64_t qaddr_base = xive2_end_qaddr(end);
@@ -610,6 +647,24 @@ int xive2_router_write_nvp(Xive2Router *xrtr, uint8_t nvp_blk, uint32_t nvp_idx,
    return xrc->write_nvp(xrtr, nvp_blk, nvp_idx, nvp, word_number);
 }
 
+int xive2_router_get_nvgc(Xive2Router *xrtr, bool crowd,
+                          uint8_t nvgc_blk, uint32_t nvgc_idx,
+                          Xive2Nvgc *nvgc)
+{
+   Xive2RouterClass *xrc = XIVE2_ROUTER_GET_CLASS(xrtr);
+
+   return xrc->get_nvgc(xrtr, crowd, nvgc_blk, nvgc_idx, nvgc);
+}
+
+int xive2_router_write_nvgc(Xive2Router *xrtr, bool crowd,
+                            uint8_t nvgc_blk, uint32_t nvgc_idx,
+                            Xive2Nvgc *nvgc)
+{
+   Xive2RouterClass *xrc = XIVE2_ROUTER_GET_CLASS(xrtr);
+
+   return xrc->write_nvgc(xrtr, crowd, nvgc_blk, nvgc_idx, nvgc);
+}
+
 /*
  * The thread context register words are in big-endian format.
  */
diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index 654f485e9b..b7a7c33ddd 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -53,6 +53,12 @@ typedef struct Xive2RouterClass {
                    Xive2Nvp *nvp);
     int (*write_nvp)(Xive2Router *xrtr, uint8_t nvp_blk, uint32_t nvp_idx,
                      Xive2Nvp *nvp, uint8_t word_number);
+    int (*get_nvgc)(Xive2Router *xrtr, bool crowd,
+                    uint8_t nvgc_blk, uint32_t nvgc_idx,
+                    Xive2Nvgc *nvgc);
+    int (*write_nvgc)(Xive2Router *xrtr, bool crowd,
+                      uint8_t nvgc_blk, uint32_t nvgc_idx,
+                      Xive2Nvgc *nvgc);
     uint8_t (*get_block_id)(Xive2Router *xrtr);
     uint32_t (*get_config)(Xive2Router *xrtr);
 } Xive2RouterClass;
@@ -67,6 +73,12 @@ int xive2_router_get_nvp(Xive2Router *xrtr, uint8_t nvp_blk, uint32_t nvp_idx,
                         Xive2Nvp *nvp);
 int xive2_router_write_nvp(Xive2Router *xrtr, uint8_t nvp_blk, uint32_t nvp_idx,
                           Xive2Nvp *nvp, uint8_t word_number);
+int xive2_router_get_nvgc(Xive2Router *xrtr, bool crowd,
+                          uint8_t nvgc_blk, uint32_t nvgc_idx,
+                          Xive2Nvgc *nvgc);
+int xive2_router_write_nvgc(Xive2Router *xrtr, bool crowd,
+                            uint8_t nvgc_blk, uint32_t nvgc_idx,
+                            Xive2Nvgc *nvgc);
 uint32_t xive2_router_get_config(Xive2Router *xrtr);
 
 void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked);
diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index d71a54f9ff..99840e88a8 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -212,6 +212,7 @@ void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx, GString *buf);
 typedef struct Xive2Nvgc {
         uint32_t        w0;
 #define NVGC2_W0_VALID             PPC_BIT32(0)
+#define NVGC2_W0_PGONEXT           PPC_BITMASK32(26, 31)
         uint32_t        w1;
         uint32_t        w2;
         uint32_t        w3;
@@ -221,4 +222,9 @@ typedef struct Xive2Nvgc {
         uint32_t        w7;
 } Xive2Nvgc;
 
+#define xive2_nvgc_is_valid(nvgc)    (be32_to_cpu((nvgc)->w0) & NVGC2_W0_VALID)
+
+void xive2_nvgc_pic_print_info(Xive2Nvgc *nvgc, uint32_t nvgc_idx,
+                               GString *buf);
+
 #endif /* PPC_XIVE2_REGS_H */
-- 
2.45.2


