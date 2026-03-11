Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BDF1125865
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 18:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0OP0-0004tX-II; Wed, 11 Mar 2026 14:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w0OOz-0004sA-3a
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 14:35:25 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w0OOw-0000m9-U1
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 14:35:24 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ad21f437eeso2310425ad.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 11:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773254121; x=1773858921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=laRsm3TUDdJSpfAUPBx12/AjumPgyQ9OTcdCV3+erMI=;
 b=EwknB44rxSRT9848t4bsmDqoDH+cWpThB0+03grh5hfGNwFQHUzM9QAcdNZLfmK4Cr
 c4/DV1qo669n/NkXU4G7mkrELYogi1YHA7fZB5AjqI3GYUgttPIr4p1NDd/pHOSUN9R3
 9PAvq0O+SMSmHJY9RUe62Qj0fbJXh93//PpBq+botPG5E74uDBY6GP+fESlTDETAzp/R
 td7aztiS726WYlkbQcadtwE+tn4uQK/W+sU1cs5TUH+xWmEj4lyyKEuiEUDglvi0Snxv
 olKEhJzFmV354wt3GQhuv1vPS2ZzSBKI80hUrLf5CqeA9rOE0iOXkDLKwWYMRTinHIzb
 OIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773254121; x=1773858921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=laRsm3TUDdJSpfAUPBx12/AjumPgyQ9OTcdCV3+erMI=;
 b=Uh1jsx1Xs8Mb2ogecY20nM6o86CysF9tsR++4kMJZ9HC1IUTftq+mDIt0kRdjxPmp5
 2gcsP1d8m8a5oxANUCs1z8aHsh7C6+BQQrg6KQZ1SwPJ5be3FQZhXMivc8v33kYnmEJj
 Btnt7c54a4hLuluV3yIOzkCKQX8pGQ1KornnvXLxIqWcSnp1lfCxGWV261nPEeKLU+Lr
 hQXLuSlaBUa5LanNKYvXdVYPTm14sxZnz4FbA0c8DgpY7DZTnuWIYZmyRv1Qp3Zc2+MP
 PxdBjqk69vxpFBv8xB6mUM3w9raEBPX1v+0cigGd60ZxhtIEExzqiJ4A5d2nuc/Qcwp5
 4Irw==
X-Gm-Message-State: AOJu0Yyt5JksbWkd3Scu4ZRUg8+/RwlZ0PgCCaMNHkd4dqm/4N0YtvGb
 /xnQdlJJK2fq5cGU6SdHqQW+h3hw8gHfbXnPQIsQUG2R2qs5YQ7Xd4ubzd/Tbvf3KQeyGw==
X-Gm-Gg: ATEYQzwTZb+uEeyAS7cu31rmP0V/uOFknIBqFHN3e63GUTP+sLyutTrDDyDvXGq3nuQ
 PsWYskZwnnX9cHNvw56xKkigzc/g2gWWt4hxLwh92VqB63DoHqW6VdsA33JjjG0bvx4BNCxfcYy
 vp8s1qqaTdAd9tu/a+iK1hWGyn/Dh2FLnLW2ugrXNNwtch10LTqQKrufn2F/Zbr7saFgjARBmlf
 jjEc/5j40EdlxcmNcT3Wvvx36CsqYjwy2lekov3HUR+c4v2i8g7GRG23ewN3HS39KBcr2/TlZbD
 G+Y7x89s4ADLS0IR+pNk2khfzvn8Zs7aD6aJQEwuUm3QEx8TSIxGGwhsgxhReE6wHZdsr6NvR3z
 b2SxG4NQJd/be0FgG9XjAI1YjY40E9gaDfC+Yc1CWcDN0earfI6URj1ZEQXcaUQR88scwKeoxPI
 3VmrVnL0iRLq0Qk9Gcqyf5Wp/2IlGf7osJ71HLTq9kqqX5jQ==
X-Received: by 2002:a17:902:f543:b0:2ad:a96c:e40c with SMTP id
 d9443c01a7336-2aeba4bd825mr4186295ad.16.1773254121284; 
 Wed, 11 Mar 2026 11:35:21 -0700 (PDT)
Received: from localhost.localdomain ([123.19.166.13])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae222e2fsm42124115ad.2.2026.03.11.11.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 11:35:21 -0700 (PDT)
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
 Hannes Reinecke <hare@suse.com>, qemu-block@nongnu.org (open list:megasas)
Subject: [PATCH v2 4/4] hw/pci/msix: fix error handling for msix_init callers
Date: Thu, 12 Mar 2026 01:34:30 +0700
Message-ID: <20260311183432.214960-5-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311183432.214960-1-viking4@gmail.com>
References: <20260311183432.214960-1-viking4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=vikingtc4@gmail.com; helo=mail-pl1-x632.google.com
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
- Use errp parameter to handle failure instead of NULL.
- No functional changes.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>

---
v2:
- Use errp parameter to handle failure instead of NULL.
---
 hw/net/igbvf.c         |  2 +-
 hw/net/rocker/rocker.c |  2 +-
 hw/pci/msix.c          |  2 +-
 hw/scsi/megasas.c      | 18 +++++++++++++-----
 hw/usb/hcd-xhci-pci.c  | 19 ++++++++++++++-----
 5 files changed, 30 insertions(+), 13 deletions(-)

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
index f62e420a91..b237ba7656 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2380,11 +2380,19 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
     memory_region_init_io(&s->queue_io, OBJECT(s), &megasas_queue_ops, s,
                           "megasas-queue", 0x40000);
 
-    if (megasas_use_msix(s) &&
-        msix_init(dev, 15, &s->mmio_io, b->mmio_bar, 0x2000,
-                  &s->mmio_io, b->mmio_bar, 0x3800, 0x68, NULL)) {
-        /* TODO: check msix_init's error, and should fail on msix=on */
-        s->msix = ON_OFF_AUTO_OFF;
+    if (megasas_use_msix(s)) {
+        Error *local_err = NULL;
+        ret = msix_init(dev, 15, &s->mmio_io, b->mmio_bar, 0x2000,
+                        &s->mmio_io, b->mmio_bar, 0x3800, 0x68, &local_err);
+
+        if (ret < 0) {
+            if (s->msix == ON_OFF_AUTO_ON) {
+                error_propagate(errp, local_err);
+                return;
+            }
+            error_free(local_err);
+            s->msix = ON_OFF_AUTO_OFF;
+        }
     }
 
     if (pci_is_express(dev)) {
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index aa570506fc..3bdde9b64a 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -173,11 +173,20 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
     }
 
     if (s->msix != ON_OFF_AUTO_OFF) {
-        /* TODO check for errors, and should fail when msix=on */
-        msix_init(dev, s->xhci.numintrs,
-                  &s->xhci.mem, 0, OFF_MSIX_TABLE,
-                  &s->xhci.mem, 0, OFF_MSIX_PBA,
-                  0x90, NULL);
+        Error *local_err = NULL;
+        ret = msix_init(dev, s->xhci.numintrs,
+                        &s->xhci.mem, 0, OFF_MSIX_TABLE,
+                        &s->xhci.mem, 0, OFF_MSIX_PBA,
+                        0x90, &local_err);
+
+        if (ret < 0) {
+            if (s->msix == ON_OFF_AUTO_ON) {
+                error_propagate(errp, local_err);
+                return;
+            }
+            error_free(local_err);
+            s->msix = ON_OFF_AUTO_OFF;
+        }
     }
     s->xhci.as = pci_get_address_space(dev);
 }
-- 
2.43.0


