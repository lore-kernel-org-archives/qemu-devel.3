Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD6DBD1119A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7krz-0000aH-SY; Sun, 03 Nov 2024 19:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7krf-000719-Iv; Sun, 03 Nov 2024 19:22:40 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7krd-0002nw-Pv; Sun, 03 Nov 2024 19:22:39 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71e79f73aaeso3003741b3a.3; 
 Sun, 03 Nov 2024 16:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679756; x=1731284556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eNQIlh9E03AkTT+nJ3mokqkoQL2ZdRCi7nnwW1kK7io=;
 b=EzsbuCdvlQ/u7zRMbggIN2MEkkw364DrMKBYmx9zYlB8eAcJIOiJMuvKT3SA323Tgt
 XgYZetcYJ44fUZDNiFl/j4QBP43OGgMbsw7GCYWBBC4GB5vDVb6UoDF+4Or0/139ODxP
 INezAJjuHoCGgMSmt266tVW7aRkJhn9ro3DOon4F8Le7rjRMlEXluXbVDeucOr2Z84EK
 WKDkG6tCbK4iWUEtrhct9Cx+0ixjEiMwvVsnH9s9ys/MZD9D0JwneDucUHNVhuoWqbnR
 gd+1l1zsb7U3R87dOKW0BdMoanpLUhY9CkLzl8SPTS0Bh3AOKy8SdOJtpz8pHlYcZg20
 WzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679756; x=1731284556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eNQIlh9E03AkTT+nJ3mokqkoQL2ZdRCi7nnwW1kK7io=;
 b=a03/cO5aMYg5g2xiLSMphpub1Fie71R/vY6ByqrC9BE707lo/iIPS3hh06PHs1/W9l
 0G39pARe1spG58TPuXjqQVQ7f06YW2j0a7OgtUSlgtKx9KVjKTDLMhw7jW/h3b6aiZeU
 hPwVmbzqT2MITaTkWwLOHHnvD3wAR0CjAPvM5XtHJi00X6eNmQzOW2Giv8h317Wn8sEV
 2i9+KdoHUwH+qqZw9uF5CoM5rqtJ4ek6UMZF4K3hITTdeS97C/9BzrLNGIukLSrUBQq+
 o6qi1VvdlbgxRwo/siT8+ihff93BFlVHjBa2npXsR4AVYLGnS3xR73uOrCRQpzjpNaTo
 HAzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyDqUPskiMnA8jELRhWMxvV61GqwWeiyNhbabpbEb9T6Aw+ULyH4d6RP/yGAb2LKNp5TJDBy5odw==@nongnu.org
X-Gm-Message-State: AOJu0YyFwVIk/iN2NNALoSOOFQVfn+qeduaNDJfwm407EbaJ9ujUZD98
 vg+L+DWQLNwgGTrk+JSLpcQHNd/asa/1RF99gmDIccsbnZOxerFhoFajAw==
X-Google-Smtp-Source: AGHT+IF3gcE8g3Pn3kKH+81cdgAgWvYY0FErEHqE9nmqL3LyTpiyWSKAQTfrLLoCs53WYutLY++BHQ==
X-Received: by 2002:a05:6a21:e88:b0:1d8:f171:dccd with SMTP id
 adf61e73a8af0-1d9a851e08dmr37851670637.37.1730679755792; 
 Sun, 03 Nov 2024 16:22:35 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:22:35 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 57/67] ppc/xive2: Support "Pull Thread Context to Odd Thread
 Reporting Line"
Date: Mon,  4 Nov 2024 10:18:46 +1000
Message-ID: <20241104001900.682660-58-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

Adds support for single byte writes to offset 0xC38 of the TIMA address
space.  When this offset is written to, the hardware disables the thread
context and copies the current state information to the odd cache line of
the pair specified by the NVT structure indexed by the THREAD CAM entry.

Note that this operation is almost identical to what we are already doing
for the "Pull OS Context to Odd Thread Reporting Line" operation except
that it also invalidates the Pool and Thread Contexts.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c              |  9 +++--
 hw/intc/xive2.c             | 73 ++++++++++++++++++++++++++-----------
 include/hw/ppc/xive2.h      |  2 +
 include/hw/ppc/xive2_regs.h | 16 ++++----
 include/hw/ppc/xive_regs.h  |  1 +
 5 files changed, 69 insertions(+), 32 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 84240d3c3e..951aaf5279 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -117,10 +117,9 @@ static void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring)
 void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring)
 {
     /*
-     * Lower the External interrupt. Used when pulling an OS
-     * context. It is necessary to avoid catching it in the hypervisor
-     * context. It should be raised again when re-pushing the OS
-     * context.
+     * Lower the External interrupt. Used when pulling a context. It is
+     * necessary to avoid catching it in the higher privilege context. It
+     * should be raised again when re-pushing the lower privilege context.
      */
     qemu_irq_lower(xive_tctx_output(tctx, ring));
 }
@@ -581,6 +580,8 @@ static const XiveTmOp xive2_tm_operations[] = {
                                                      NULL },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, NULL,
                                                      xive_tm_pull_phys_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_OL,   1, xive2_tm_pull_phys_ctx_ol,
+                                                     NULL },
 };
 
 static const XiveTmOp *xive_tm_find_op(XivePresenter *xptr, hwaddr offset,
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index c5aa784fe8..2e41bd9edb 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -323,12 +323,12 @@ static void xive2_tctx_save_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
 }
 
 static void xive2_cam_decode(uint32_t cam, uint8_t *nvp_blk,
-                             uint32_t *nvp_idx, bool *vo, bool *ho)
+                             uint32_t *nvp_idx, bool *valid, bool *hw)
 {
     *nvp_blk = xive2_nvp_blk(cam);
     *nvp_idx = xive2_nvp_idx(cam);
-    *vo = !!(cam & TM2_QW1W2_VO);
-    *ho = !!(cam & TM2_QW1W2_HO);
+    *valid = !!(cam & TM2_W2_VALID);
+    *hw = !!(cam & TM2_W2_HW);
 }
 
 /*
@@ -351,35 +351,52 @@ static uint32_t xive2_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tctx)
     return xive2_nvp_cam_line(blk, 1 << tid_shift | (pir & tid_mask));
 }
 
-uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
-                              hwaddr offset, unsigned size)
+static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                                  hwaddr offset, unsigned size, uint8_t ring)
 {
     Xive2Router *xrtr = XIVE2_ROUTER(xptr);
-    uint32_t qw1w2 = xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
-    uint32_t qw1w2_new;
-    uint32_t cam = be32_to_cpu(qw1w2);
+    uint32_t target_ringw2 = xive_tctx_word2(&tctx->regs[ring]);
+    uint32_t cam = be32_to_cpu(target_ringw2);
     uint8_t nvp_blk;
     uint32_t nvp_idx;
-    bool vo;
+    uint8_t cur_ring;
+    bool valid;
     bool do_save;
 
-    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_save);
+    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &valid, &do_save);
 
-    if (!vo) {
+    if (!valid) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pulling invalid NVP %x/%x !?\n",
                       nvp_blk, nvp_idx);
     }
 
-    /* Invalidate CAM line */
-    qw1w2_new = xive_set_field32(TM2_QW1W2_VO, qw1w2, 0);
-    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2_new, 4);
+    /* Invalidate CAM line of requested ring and all lower rings */
+    for (cur_ring = TM_QW0_USER; cur_ring <= ring;
+         cur_ring += XIVE_TM_RING_SIZE) {
+        uint32_t ringw2 = xive_tctx_word2(&tctx->regs[cur_ring]);
+        uint32_t ringw2_new = xive_set_field32(TM2_QW1W2_VO, ringw2, 0);
+        memcpy(&tctx->regs[cur_ring + TM_WORD2], &ringw2_new, 4);
+    }
 
     if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
-        xive2_tctx_save_ctx(xrtr, tctx, nvp_blk, nvp_idx, TM_QW1_OS);
+        xive2_tctx_save_ctx(xrtr, tctx, nvp_blk, nvp_idx, ring);
+    }
+
+    /*
+     * Lower external interrupt line of requested ring and below except for
+     * USER, which doesn't exist.
+     */
+    for (cur_ring = TM_QW1_OS; cur_ring <= ring;
+         cur_ring += XIVE_TM_RING_SIZE) {
+        xive_tctx_reset_signal(tctx, cur_ring);
     }
+    return target_ringw2;
+}
 
-    xive_tctx_reset_signal(tctx, TM_QW1_OS);
-    return qw1w2;
+uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                              hwaddr offset, unsigned size)
+{
+    return xive2_tm_pull_ctx(xptr, tctx, offset, size, TM_QW1_OS);
 }
 
 #define REPORT_LINE_GEN1_SIZE       16
@@ -424,8 +441,9 @@ static void xive2_tm_report_line_gen1(XiveTCTX *tctx, uint8_t *data,
     }
 }
 
-void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
-                             hwaddr offset, uint64_t value, unsigned size)
+static void xive2_tm_pull_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
+                                 hwaddr offset, uint64_t value,
+                                 unsigned size, uint8_t ring)
 {
     Xive2Router *xrtr = XIVE2_ROUTER(xptr);
     uint32_t hw_cam, nvp_idx, xive2_cfg, reserved;
@@ -473,8 +491,21 @@ void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
         assert(result == MEMTX_OK);
     }
 
-    /* the rest is similar to pull OS context to registers */
-    xive2_tm_pull_os_ctx(xptr, tctx, offset, size);
+    /* the rest is similar to pull context to registers */
+    xive2_tm_pull_ctx(xptr, tctx, offset, size, ring);
+}
+
+void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
+                             hwaddr offset, uint64_t value, unsigned size)
+{
+    xive2_tm_pull_ctx_ol(xptr, tctx, offset, value, size, TM_QW1_OS);
+}
+
+
+void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
+                               hwaddr offset, uint64_t value, unsigned size)
+{
+    xive2_tm_pull_ctx_ol(xptr, tctx, offset, value, size, TM_QW3_HV_PHYS);
 }
 
 static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index 36bd0e747f..5bccf41159 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -123,5 +123,7 @@ void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
                              hwaddr offset, uint64_t value, unsigned size);
 void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
                             hwaddr offset, uint64_t value, unsigned size);
+void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
+                               hwaddr offset, uint64_t value, unsigned size);
 
 #endif /* PPC_XIVE2_H */
diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index 99840e88a8..1d00c8df64 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -19,16 +19,18 @@
  * mode (P10), the CAM line is slightly different as the VP space was
  * increased.
  */
-#define   TM2_QW0W2_VU           PPC_BIT32(0)
+#define   TM2_W2_VALID           PPC_BIT32(0)
+#define   TM2_W2_HW              PPC_BIT32(1)
+#define   TM2_QW0W2_VU           TM2_W2_VALID
 #define   TM2_QW0W2_LOGIC_SERV   PPC_BITMASK32(4, 31)
-#define   TM2_QW1W2_VO           PPC_BIT32(0)
-#define   TM2_QW1W2_HO           PPC_BIT32(1)
+#define   TM2_QW1W2_VO           TM2_W2_VALID
+#define   TM2_QW1W2_HO           TM2_W2_HW
 #define   TM2_QW1W2_OS_CAM       PPC_BITMASK32(4, 31)
-#define   TM2_QW2W2_VP           PPC_BIT32(0)
-#define   TM2_QW2W2_HP           PPC_BIT32(1)
+#define   TM2_QW2W2_VP           TM2_W2_VALID
+#define   TM2_QW2W2_HP           TM2_W2_HW
 #define   TM2_QW2W2_POOL_CAM     PPC_BITMASK32(4, 31)
-#define   TM2_QW3W2_VT           PPC_BIT32(0)
-#define   TM2_QW3W2_HT           PPC_BIT32(1)
+#define   TM2_QW3W2_VT           TM2_W2_VALID
+#define   TM2_QW3W2_HT           TM2_W2_HW
 #define   TM2_QW3W2_LP           PPC_BIT32(6)
 #define   TM2_QW3W2_LE           PPC_BIT32(7)
 
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 558a5ae742..5b11463777 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -138,6 +138,7 @@
 #define TM_SPC_ACK_HV_POOL_EL   0xc20   /* Store8 ack HV evt pool to even     */
                                         /* line                               */
 #define TM_SPC_ACK_HV_EL        0xc30   /* Store8 ack HV irq to even line     */
+#define TM_SPC_PULL_PHYS_CTX_OL 0xc38   /* Pull phys ctx to odd cache line    */
 /* XXX more... */
 
 /* NSR fields for the various QW ack types */
-- 
2.45.2


