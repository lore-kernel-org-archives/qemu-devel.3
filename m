Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7D5FD4F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 18:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w01sT-00028F-87; Tue, 10 Mar 2026 14:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w01sQ-00027R-Hc
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 14:32:18 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w01sO-0007jU-QN
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 14:32:18 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ae3a2f6007so76505705ad.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 11:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773167535; x=1773772335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f4WMeVTtNyCYe5DqHr0pijVf9waAyr2THm7rATwiVXo=;
 b=JzCv6aQ7s0HVphw7MxWiTNg4KtahQpHk4ZJtu0aIN7MkUVHqjd3G51hRJcqBUyD9sF
 CoO1bUuPuemR4QABtrigw1njAeHXxlWcjC9PCx5osKpVuzWCPlncAhil8bdXhe83zOw0
 jJlaPogMdYbfERilas8DHJZu6lhyrTn4zrO+0hc5Y8sUuJdA7CdIvJKPdTI2rvpDzsoa
 xKCaLJzfTWJQ5nd3IKXss6QJ6YWhzyxXIcHPuRNcZG7aL59pBq7Sowmt4L1vhnJ4EAO9
 S5EhHNEz1ykFUZ0H5zIc4dfak6595Nc/q0HKmBsf0Je6nkQ5ymc6LKWUtPK2VSSk5sVr
 21og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773167535; x=1773772335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f4WMeVTtNyCYe5DqHr0pijVf9waAyr2THm7rATwiVXo=;
 b=ap0/KqHGOFMGQ5GM6174PQx++vCHK8PXkZNK5xNFc+PGTPLD/eMtr9EKGmRUmyloff
 YapB25GE8mSoDuIqNCIZF45vv0+WUOdgk3mb26f4NFldBvApa1YTiidFKlW0Ebk0gjXC
 lUiTLWxkd5vwluJt/0SgWK91wZXjpM/0H/fhE8arfNOneSimj5n5QpZ8oLiQFA1M77z2
 EGshG/JHwQqOu0R7s36GAjGxD7fS6SCwUsasftA2PYiUZzF9XUO6+a1wgi02L6EqbV2j
 765q1sLlFU+KHMXqZkHgSpDstPoFw7L/DFqiY+OwukaVwUcRrYIg/grq+mGgDqrsANr3
 01XA==
X-Gm-Message-State: AOJu0Yzinhjd+p51AxTpaAMrXwN1fvr05pHaBMr99BD2MJOH9kuL39We
 qDlZK0JqNDrgvEvkpmSWyKuJKX0WOifqNBBCgRHZwzJqwbsfDa3HzzbtcqGNLNblE0XmSQ==
X-Gm-Gg: ATEYQzz0sVzfcfvEusDSwav4wglgwAltFH/SgbQLYPJN0tlZ4OJEkVgsowpY+umHE7Q
 zXjwZULeev7D9oEht8ivrStDhxCdNOO/fbyh7kCYtCZ4FfXLhhzq9VuAzqfGRst3dbSMxbOCIS+
 CSwDzmpMrZHOySAFI3fjVh07B9PjuGV8bFkAs5mbpx5wrUveK7q9RHfcukb0OKX/qRzeYxudUyB
 huLA5FEYm2w+xZnX4yqSnlExD30XKmuBjCqbU11NaHJ9ZSoPzTksNxr9bqSLuzHuKYYQ+TaP82y
 38EQjzMkR6lbCcA1lS0yW2gCsyHea1qpP94QIg0X9fJnTGCIxL7ZwQb8ulllHskTT+J7BJy9eQ9
 WBYUt04DEjLjfyn24ygdbjfqxpmRJL0mLwH58J9Cod27k1juRiX9wdeUMN3uJGncAhyWUCmWAS3
 7OOFmERDtzNYHYiJqVrJfQHEhbAwXVqpwkOw6jBOzo/CInbg==
X-Received: by 2002:a17:903:32c1:b0:2ae:4645:6f77 with SMTP id
 d9443c01a7336-2ae82455f70mr164858565ad.20.1773167534894; 
 Tue, 10 Mar 2026 11:32:14 -0700 (PDT)
Received: from localhost.localdomain ([123.19.166.13])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae840b2e9dsm209437015ad.85.2026.03.10.11.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 11:32:14 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
X-Google-Original-From: Trieu Huynh <viking4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hannes Reinecke <hare@suse.com>, qemu-block@nongnu.org
Subject: [PATCH 4/4] hw/pci/msix: fix error handling for msix_init callers
Date: Wed, 11 Mar 2026 01:28:00 +0700
Message-ID: <20260310182801.196443-5-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310182801.196443-1-viking4@gmail.com>
References: <20260310182801.196443-1-viking4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=vikingtc4@gmail.com; helo=mail-pl1-x62b.google.com
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

From: Trieu Huynh <vikingtc4@gmail.com>

Check return value of msix_init() and return early on
failure instead of continuing with invalid state.
- Use ret < 0 to handle negative return value.
- No functional changes.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 hw/net/igbvf.c         |  2 +-
 hw/net/rocker/rocker.c |  2 +-
 hw/pci/msix.c          |  2 +-
 hw/scsi/megasas.c      | 16 +++++++++++-----
 hw/usb/hcd-xhci-pci.c  | 17 ++++++++++++-----
 5 files changed, 26 insertions(+), 13 deletions(-)

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
index f62e420a91..90d397374e 100644
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
+                        &s->mmio_io, b->mmio_bar, 0x3800, 0x68, NULL);
+
+        if (ret < 0) {
+            if (s->msix == ON_OFF_AUTO_ON) {
+                error_setg(errp, "MSI-X initialization failed");
+                return;
+            }
+            s->msix = ON_OFF_AUTO_OFF;
+        }
     }
 
     if (pci_is_express(dev)) {
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index aa570506fc..7bd4425b34 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -173,11 +173,18 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
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
+                        0x90, NULL);
+
+        if (ret < 0) {
+            if (s->msix == ON_OFF_AUTO_ON) {
+                error_setg(errp, "MSI-X initialization failed");
+                return;
+            }
+            s->msix = ON_OFF_AUTO_OFF;
+        }
     }
     s->xhci.as = pci_get_address_space(dev);
 }
-- 
2.43.0


