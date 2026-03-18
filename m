Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C7D103E183
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 14:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2rh8-0007qT-3c; Wed, 18 Mar 2026 10:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w2rgW-0007Lf-Hw
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 10:15:49 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w2rgS-00060k-Kv
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 10:15:43 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-82985f42664so4582652b3a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 07:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773843337; x=1774448137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rcq98p8TBMj9rp8LW0tSIRQYuIxm2SJ2Ri6ycH/WQ9o=;
 b=k8GKEXT61iESXMCSA0plHxcyKEg/RgZAV8VRp8HGhkpHZeuthsUTB0LfY2RsryZJGQ
 DmLfyCppvjHeGgiNjsLYTNn4Kz5mqa/9v5L3NJaA40Z5GehbgKESjk1QCBCEgqso4ehx
 JKZUglHydO8z8lsy6GddA9CQEavKJcFIeL3UYBlEQXKsEA8bggPOxgdcrdbqjKOHD0F+
 iFc5eMiGQTs7lsvZUKnDtmRS/cdoTAjLbYSfq83Cxz/4RFLo33bGinU7lvJCThxOda9m
 yo3u/4SWbl8v5Cwb11G464OwkmEDOpDa9LLiTSkD4hititF7n23U7tBcp5T25xwm1L1t
 maCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773843337; x=1774448137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rcq98p8TBMj9rp8LW0tSIRQYuIxm2SJ2Ri6ycH/WQ9o=;
 b=rYX7h2PtKRzQMC8GPscPJ9Nc5UnfPsR5KCveqI1pWLIcIERdcssum75Mb7glgc+P59
 AKu+lRjR+yyhKt+sxBT5yAtewlUXe+inAzHth7+3oHFM+FNaDrQAnwnvItSJouSZr99x
 hAVTJPZxQdthLTkjTC/vGbw/KZT6VeO0navvUR2ulLH5hoq7dtSETV9vCTX7l7Aqxx2A
 W/JGUMuiQnBOmX1/yXdNf0B+0b7d8VTd2rGKEq9qs8/M4jxubgBGCk/sNiMRsP3Q8xkS
 K45OUoZMveBVBclcC3x8csPMvDI5oXgpViX4b1ceTfqB2HyrzDoZrDfhGxNVV5krn6dt
 QfMw==
X-Gm-Message-State: AOJu0Yw+7R7NwRYvqRselDVXzss7g2E1YAPq6KX3p99YoQNT/CpxOBVc
 9O33a/1WLVocjrj1aCfE3VedB8D4eecPPO6wKlVm08ULWgRFtfs3YhxfYl4DBYGcWHE=
X-Gm-Gg: ATEYQzxQl6YItOsg1Ti2Ffh4cSvtdsM66gBafvodpN9s7zQidSBhMuswte5UecJnLDr
 h8by5wNnvlx9BdF3UTiylB4/X8om54HeYqPrR0VrCF67IiciR6r0fdJ6ucvZ57vqkfxoP5w/5hz
 BAg0so8vCJfuRQKSHwIiLBTZI0imca/2PpfTeHnBRUDNamTKvKV7UTgpNZqNNDvXzjfn+QXj79D
 s71GnxDt77Rz0ELKDJM73v9jXTMiWo6MY+bHVNSGgsIgyXmuidh3GAJiiJ66TO0khlslzfUl02P
 uJMYAYe/A150rvdsspR3XzgaLxoENXa7SFDJaTG6N8aADkNecDKPPDxjuZNMQ94O/3GOlTszLwK
 hRPLGmX5q2q62RX4UFXWAiVytSgw5YR2cf5KBmKWdaGSeaUl0YtlX7Ebj2G0TJrIJgtzSYoMs1W
 PnJXTzpNjp9lO2vNxwS1uyNNnDJ3HkaBV22l6ZqQT5tSNZH2eCAzBMx+M1FgfBniNP6Yd5COWqO
 2Nyd/OJMw==
X-Received: by 2002:a05:6a00:9519:b0:823:9e5:855e with SMTP id
 d2e1a72fcca58-82a6a969227mr3247067b3a.0.1773843337277; 
 Wed, 18 Mar 2026 07:15:37 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local
 ([27.122.242.65]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a6af06bd7sm2927272b3a.0.2026.03.18.07.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 07:15:37 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org (open list:megasas)
Subject: [PATCH v3 4/4] hw/pci/msix: fix error handling for msix_init callers
Date: Wed, 18 Mar 2026 23:14:13 +0900
Message-ID: <20260318141415.8538-5-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318141415.8538-1-vikingtc4@gmail.com>
References: <20260318141415.8538-1-vikingtc4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=vikingtc4@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Check return value of msix_init() and return early on
failure instead of continuing with invalid state.
- Use ret < 0 to handle negative return value.
- Use errp parameter to handle failure instead of NULL.
- No functional changes.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 hw/net/igbvf.c         |  2 +-
 hw/net/rocker/rocker.c |  2 +-
 hw/pci/msix.c          |  2 +-
 hw/scsi/megasas.c      | 16 +++++++++++-----
 hw/usb/hcd-xhci-pci.c  | 16 +++++++++++-----
 5 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index 48d56e43ac..9a165c7063 100644
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
index 4a7056bd45..910dce901b 100644
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
index b35476d057..1b23eaf100 100644
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
index f62e420a91..a29742d449 100644
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
index aa570506fc..c5446a4a5e 100644
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
2.43.0


