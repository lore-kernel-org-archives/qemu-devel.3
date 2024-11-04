Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FD7D11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7ks1-0000hd-N3; Sun, 03 Nov 2024 19:23:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7krd-00070z-5c; Sun, 03 Nov 2024 19:22:40 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7krb-0002nh-DT; Sun, 03 Nov 2024 19:22:36 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71e7086c231so3039888b3a.0; 
 Sun, 03 Nov 2024 16:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679752; x=1731284552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w839eVO4scFP/y3Tya9yuKryETH0D2suBlVY2rkyxeY=;
 b=m3yRiYyEeMT2BQVTq/FzMtxmPTDXEjUqFjThctuE3ifZ1tJ0uqkww1UQLRcPmi5Qb6
 mEevBH8khIdMcpZvnfXq9l0Vdibkdv1Angeb8qhfRYjqx8WD3SYH0tnfebeHbYloPtRf
 jSopovta97PysiULh4/SbGGOXKP+f34LqQfJibxKZmdJNbWQRFBFxlLn4tXVBGJaS7XW
 cgoox+Fk6MNiUzE27VCgUwcb0Isu0KtsNHvFPBYGM8BUMWAzsY5i1bKSzIXP4e5X1KnK
 GCgVey8V8ZSnAq/mNZdz6fWRUCCZ5Slgq6Md5+/LMXBHaPvFR5vqJBej5LfvloAZjq1Q
 NlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679752; x=1731284552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w839eVO4scFP/y3Tya9yuKryETH0D2suBlVY2rkyxeY=;
 b=sNOzViylDnyH/kbVwMTzf2qdZUWa5fEDgaLIKjiqZW21u7yLBSEAvs4aS/qJ7RNrBm
 NMEfX6eta+92mFAJa8DXFNPTPUUdrwBpldNZaxmgZegp568kAZVjasiLaTeSwQi29z4g
 kcrTmLfaaFLIh4/8zLXRFL76ki8kIu5eJHKeIQosroCauXtRwVkAh7pw/4Xxpo0DT2BR
 LRHEeIopCJMqK+8oRzj7cBjalhN8+wJKN9l8OASGCVgdeTK8u+CoUnzfkGYYF68TJGWL
 i81RIk8t1hVCH3KNQ08oM9ecoiml5eTJ1CcgYaU5zOfv3ORTstgnAcZvfGYccxFaw9K9
 TPtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURe2d7im9e5yHyHR/g8zOhMQDRv8GsX/TLaXbQ+QsDuciEu3P9LAG/j5HlSh6wWn5y9VD79CYsug==@nongnu.org
X-Gm-Message-State: AOJu0YxWJwqFFb9wmQd+MbArbTfCUGqodcyzrzfCi7LCADzdIgSJpeka
 IqXnleSugg0Vw6T6I/Se0dtOShQKTsU3Vg/tCV4Ka8vOTuMhD6ffuFgf5w==
X-Google-Smtp-Source: AGHT+IGTtER2P8Sfc+lIUt/uBMzAd0WWFASgxaREa0wUfFNe87d3Q7umQ3mkCncEMRNHMR9X9DztjQ==
X-Received: by 2002:a05:6a20:361f:b0:1d9:c7df:3b1d with SMTP id
 adf61e73a8af0-1d9c7df3c73mr26347960637.12.1730679752247; 
 Sun, 03 Nov 2024 16:22:32 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:22:31 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Michael Kowal <kowal@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 56/67] ppc/xive2: Change context/ring specific functions to be
 generic
Date: Mon,  4 Nov 2024 10:18:45 +1000
Message-ID: <20241104001900.682660-57-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
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

From: Michael Kowal <kowal@linux.ibm.com>

Some the functions that have been created are specific to a ring or context. Some
of these same functions are being changed to operate on any ring/context. This  will
simplify the next patch sets that are adding additional ring/context operations.

Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c        |  6 +++---
 hw/intc/xive2.c       | 20 ++++++++++----------
 include/hw/ppc/xive.h |  2 +-
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 774e624160..84240d3c3e 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -114,7 +114,7 @@ static void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring)
     }
 }
 
-void xive_tctx_reset_os_signal(XiveTCTX *tctx)
+void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring)
 {
     /*
      * Lower the External interrupt. Used when pulling an OS
@@ -122,7 +122,7 @@ void xive_tctx_reset_os_signal(XiveTCTX *tctx)
      * context. It should be raised again when re-pushing the OS
      * context.
      */
-    qemu_irq_lower(xive_tctx_output(tctx, TM_QW1_OS));
+    qemu_irq_lower(xive_tctx_output(tctx, ring));
 }
 
 static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
@@ -424,7 +424,7 @@ static uint64_t xive_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     qw1w2_new = xive_set_field32(TM_QW1W2_VO, qw1w2, 0);
     xive_tctx_set_os_cam(tctx, qw1w2_new);
 
-    xive_tctx_reset_os_signal(tctx);
+    xive_tctx_reset_signal(tctx, TM_QW1_OS);
     return qw1w2;
 }
 
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 8d3d69a0db..c5aa784fe8 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -270,13 +270,14 @@ static void xive2_end_enqueue(Xive2End *end, uint32_t data)
  *     the NVP by changing the H bit while the context is enabled
  */
 
-static void xive2_tctx_save_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
-                                   uint8_t nvp_blk, uint32_t nvp_idx)
+static void xive2_tctx_save_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
+                                uint8_t nvp_blk, uint32_t nvp_idx,
+                                uint8_t ring)
 {
     CPUPPCState *env = &POWERPC_CPU(tctx->cs)->env;
     uint32_t pir = env->spr_cb[SPR_PIR].default_value;
     Xive2Nvp nvp;
-    uint8_t *regs = &tctx->regs[TM_QW1_OS];
+    uint8_t *regs = &tctx->regs[ring];
 
     if (xive2_router_get_nvp(xrtr, nvp_blk, nvp_idx, &nvp)) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVP %x/%x\n",
@@ -321,8 +322,8 @@ static void xive2_tctx_save_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
     xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 1);
 }
 
-static void xive2_os_cam_decode(uint32_t cam, uint8_t *nvp_blk,
-                                uint32_t *nvp_idx, bool *vo, bool *ho)
+static void xive2_cam_decode(uint32_t cam, uint8_t *nvp_blk,
+                             uint32_t *nvp_idx, bool *vo, bool *ho)
 {
     *nvp_blk = xive2_nvp_blk(cam);
     *nvp_idx = xive2_nvp_idx(cam);
@@ -330,7 +331,6 @@ static void xive2_os_cam_decode(uint32_t cam, uint8_t *nvp_blk,
     *ho = !!(cam & TM2_QW1W2_HO);
 }
 
-
 /*
  * Encode the HW CAM line with 7bit or 8bit thread id. The thread id
  * width and block id width is configurable at the IC level.
@@ -363,7 +363,7 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     bool vo;
     bool do_save;
 
-    xive2_os_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_save);
+    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_save);
 
     if (!vo) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pulling invalid NVP %x/%x !?\n",
@@ -375,10 +375,10 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2_new, 4);
 
     if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
-        xive2_tctx_save_os_ctx(xrtr, tctx, nvp_blk, nvp_idx);
+        xive2_tctx_save_ctx(xrtr, tctx, nvp_blk, nvp_idx, TM_QW1_OS);
     }
 
-    xive_tctx_reset_os_signal(tctx);
+    xive_tctx_reset_signal(tctx, TM_QW1_OS);
     return qw1w2;
 }
 
@@ -573,7 +573,7 @@ void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     bool vo;
     bool do_restore;
 
-    xive2_os_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_restore);
+    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_restore);
 
     /* First update the thead context */
     memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 3a65c2f29a..ebee982528 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -533,7 +533,7 @@ Object *xive_tctx_create(Object *cpu, XivePresenter *xptr, Error **errp);
 void xive_tctx_reset(XiveTCTX *tctx);
 void xive_tctx_destroy(XiveTCTX *tctx);
 void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb);
-void xive_tctx_reset_os_signal(XiveTCTX *tctx);
+void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring);
 
 /*
  * KVM XIVE device helpers
-- 
2.45.2


