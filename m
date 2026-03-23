Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B5EF483C8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iWy-0002Ti-Aw; Mon, 23 Mar 2026 12:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iWk-00023i-Cf
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:53:21 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iWi-0000W7-8u
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:53:18 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43b44c0bcdbso4726266f8f.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284794; x=1774889594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IF5AIne3aOjW5NQiAWyFpvmY0cptp84jUlFsWbEzYLg=;
 b=fOp2r857ZlfBon5HJUjO2hbbcr/MqsQ605/NxaxGawk3xvgzLybN918vYNTKuulPN2
 cg84XuQeSiNqb5PKG531Ei9G3vJWB5IlnpmY/D24C/oTYvtG3c47ubNmeRD+/E2zjp/5
 q0rOuebnVXZTjLxUCPjKiIRZnz7bmLUDtOLsyrNRpOIlwwLzzEycnVAIu9he0FQPO5RD
 B/nja5BbiqgkZabvHX58A4eqdGCncGENuwu5hj+kwawVgPUuqylA83My3tjLGMFsFM3m
 8Dzz9fZntc2IKtfHHHBU/Ehal2JKN/ioGLPspGee2DEphipYH27nnn1W/hwTdNU/tnEo
 KCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284794; x=1774889594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IF5AIne3aOjW5NQiAWyFpvmY0cptp84jUlFsWbEzYLg=;
 b=BtXg+Rfb8KIS3iBPimki1e4TPFgSkh+vJs/UhkKe+GVbGeoHnCg+dxqT0Wa0Y1jB+q
 QEHZgQeuMNm8W81NAJwQOrm4vzTbDiueYOt+H85BAT9i1meQq3JnBoKyFvLa7RXB9mGu
 JGCS4TyDykZi3Z9eOk11jtxRSWXrYNALid6SuTmEJQAoJ1ukjXMf6mUc+PwJgJOT+dQo
 7dpHTpxTHS3d5k0EuOLsfWST1dSJkXBV+wlHIJrcBdalI2GSmIfvmlVwUGMPC0v21Ocl
 wQoBHGiDNgFWPe5Hr9/6mfqJoI0BYdzfizHFsTgevdJLAUr9YpmCZGysTtJnJIle+Ke7
 W6gQ==
X-Gm-Message-State: AOJu0YzyjE6hwJIdeLyT2h7j4NNYa/NtNqMq6W2YV6l6EB+Ek108QNLb
 KWIVisMnNaNZOVnaGdTFiBhK3JSi4otlPSkCO6QMmARn8i/40i9263Qf2V5+2pNmNJ8c6Dejuhr
 Opd4r9Jo=
X-Gm-Gg: ATEYQzxyTZ2stUeRtGSO8XQHjj72MFafIMNfFChO0uc73/pFrooVa3elK17ImrUNETo
 znlY7C8J+0f6w9fDs+Dn5MC4Pmt3HE9BxpRmC/gJ/5YtNuHvjNqjsGLQs9ZFSBBbjvN8DBnOInt
 dDyZDcWkkur4nWF7Whm5YflK3ZyqSFZqNIUhjqne8obFkZUvxco1Zcm7NJdwhsutoH9gaMfaeKD
 xbPdrYgQdyRPjoJ6Ke3CeqCgwNR/xIT6Q17Apss5xqK3HGQzho/sT2nhd4Y9U+sMKiOCuoV3aDT
 08xqCb/ooUJN8lYocaPBRZ9+g+S2qlrDLZ7NTSy4WI1R/QUeQW8yxDLJKXDwmGTDCEfZYHzVkZA
 tRBao6R0XyfcD2+R+eGHRuGdSbbcr3svaXB2Xh2hYeWY+PDlgN8duLDP+pWnhln8lPdL7Em1tn+
 7d7W1IepfxVVZwaT5NmzApH4uzdbBoOlDaQMdgRrl7ewt3Iisgt/99invvoGMgXBvLRCcZY4dJ
X-Received: by 2002:a05:6000:1861:b0:43b:4396:6738 with SMTP id
 ffacd0b85a97d-43b6427b2c2mr20318638f8f.50.1774284793959; 
 Mon, 23 Mar 2026 09:53:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6470380asm30181991f8f.24.2026.03.23.09.53.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:53:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/27] hw/pci/msix: fix error handling for msix_init callers
Date: Mon, 23 Mar 2026 17:51:59 +0100
Message-ID: <20260323165218.96607-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Trieu Huynh <vikingtc4@gmail.com>

Check return value of msix_init() and return early on
failure instead of continuing with invalid state.
- Use ret < 0 to handle negative return value.
- Use errp parameter to handle failure instead of NULL.
- No functional changes.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20260318141415.8538-5-vikingtc4@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/igbvf.c         |  2 +-
 hw/net/rocker/rocker.c |  2 +-
 hw/pci/msix.c          |  2 +-
 hw/scsi/megasas.c      | 16 +++++++++++-----
 hw/usb/hcd-xhci-pci.c  | 16 +++++++++++-----
 5 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index 48d56e43aca..9a165c7063e 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -260,7 +260,7 @@ static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
 
     ret = msix_init(dev, IGBVF_MSIX_VEC_NUM, &s->msix, IGBVF_MSIX_BAR_IDX, 0,
         &s->msix, IGBVF_MSIX_BAR_IDX, 0x2000, 0x70, errp);
-    if (ret) {
+    if (ret < 0) {
         return;
     }
 
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 4a7056bd45e..910dce901b6 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1228,7 +1228,7 @@ static int rocker_msix_init(Rocker *r, Error **errp)
                     &r->msix_bar,
                     ROCKER_PCI_MSIX_BAR_IDX, ROCKER_PCI_MSIX_PBA_OFFSET,
                     0, errp);
-    if (err) {
+    if (err < 0) {
         return err;
     }
 
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index b35476d0577..1b23eaf1007 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -432,7 +432,7 @@ int msix_init_exclusive_bar(PCIDevice *dev, uint32_t nentries,
                     0, &dev->msix_exclusive_bar,
                     bar_nr, bar_pba_offset,
                     0, errp);
-    if (ret) {
+    if (ret < 0) {
         return ret;
     }
 
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index f62e420a91e..a29742d4493 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2380,11 +2380,17 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
     memory_region_init_io(&s->queue_io, OBJECT(s), &megasas_queue_ops, s,
                           "megasas-queue", 0x40000);
 
-    if (megasas_use_msix(s) &&
-        msix_init(dev, 15, &s->mmio_io, b->mmio_bar, 0x2000,
-                  &s->mmio_io, b->mmio_bar, 0x3800, 0x68, NULL)) {
-        /* TODO: check msix_init's error, and should fail on msix=on */
-        s->msix = ON_OFF_AUTO_OFF;
+    if (megasas_use_msix(s)) {
+        ret = msix_init(dev, 15, &s->mmio_io, b->mmio_bar, 0x2000,
+                        &s->mmio_io, b->mmio_bar, 0x3800, 0x68,
+                        s->msix == ON_OFF_AUTO_ON ? errp : NULL);
+
+        if (ret < 0) {
+            if (s->msix == ON_OFF_AUTO_ON) {
+                return;
+            }
+            s->msix = ON_OFF_AUTO_OFF;
+        }
     }
 
     if (pci_is_express(dev)) {
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index aa570506fc1..c5446a4a5e1 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -173,11 +173,17 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
     }
 
     if (s->msix != ON_OFF_AUTO_OFF) {
-        /* TODO check for errors, and should fail when msix=on */
-        msix_init(dev, s->xhci.numintrs,
-                  &s->xhci.mem, 0, OFF_MSIX_TABLE,
-                  &s->xhci.mem, 0, OFF_MSIX_PBA,
-                  0x90, NULL);
+        ret = msix_init(dev, s->xhci.numintrs,
+                        &s->xhci.mem, 0, OFF_MSIX_TABLE,
+                        &s->xhci.mem, 0, OFF_MSIX_PBA,
+                        0x90, s->msix == ON_OFF_AUTO_ON ? errp : NULL);
+
+        if (ret < 0) {
+            if (s->msix == ON_OFF_AUTO_ON) {
+                return;
+            }
+            s->msix = ON_OFF_AUTO_OFF;
+        }
     }
     s->xhci.as = pci_get_address_space(dev);
 }
-- 
2.53.0


