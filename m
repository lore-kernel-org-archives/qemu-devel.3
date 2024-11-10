Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85597D5E39C
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 05:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tA03q-0008HX-7y; Sun, 10 Nov 2024 00:00:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tA03o-0008H7-QA
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 00:00:28 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tA03k-0000OW-Dh
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 00:00:25 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71e4e481692so3450222b3a.1
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 21:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731214823; x=1731819623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T/7TkwkgQvPOmcLIQVluWZYXiqDl7Se2cs6xhPEBaFg=;
 b=g2I9mWJCoLZDcTdpP1Kvt8sMFwrmQCLV8aBmez5LjDFERLHp+iYmBzfuJUXakgNUM+
 rkuCpMQ19bkZkAmoTPdr29IiVGpLSvy/kk3UaMhrRxMGjtMREiFILhllPrwzVhPN5wro
 mkDo7lBu3/L2pDtcgDtq7GprtKKevZIQbIHdCRNEAy5aP2YlAKsBHYTEgokLf3q/eEZn
 yAWpmlOFHolFa2tjeS/Ib62+FUdh5BelD8+LI5YmD8U+SCi1mj61o6icIxWGgNxSbLf/
 6/FtP18suAJQ+lzbzocKae9/i83DBSUN5f5wdSU2QxwWaRteZIeUKvGVDKnXqOvvjvOf
 kX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731214823; x=1731819623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T/7TkwkgQvPOmcLIQVluWZYXiqDl7Se2cs6xhPEBaFg=;
 b=LyOssLdzFKiogMWeBUS8JOuJeWgmiZOiXBwj1uxh74hUvFL8d+w1rrHSB2i//G56z1
 r9IkJCDrT/HhKHRHqwUT/y/FRvpQhTDwX5a1t4Dldu8hsAOAIJ0FfsTkandVnAvwitKW
 fkNVS9cxDwxV6wosNXmmiN/cu8LeLm3z/AH8dgleaRsNuvBrkzNmdQUAQezE/YhnNjJH
 wuVcRRNrtXHPAEocosmFXPXHST+FHe6AiDo6YF/ysbG454CpYm9qcYMs8T6oOZTtbpm5
 yTsTpLrRVvsJsKdvbScIPHRqpMkrUWndAyro0i9KtwArpDSeo36qo8cZS9Mqhr02Dxi1
 ZyYQ==
X-Gm-Message-State: AOJu0YweKndmQm/Gu78Ip5RKwgUU25TzdmlsqZhHkllIJqVQyXXbG+qB
 sf6K1IgxSBGVvicztNQ7KnmAYa7VJtfHR46cRTcPr29P4+6r6sBe+rJSTA==
X-Google-Smtp-Source: AGHT+IEelyv6n4UUh2mf4IEu61ciPwlxGqjbDBz2cE/C2r/7Lk2S1ttvaL93znQirnnLoaUoJvVoNQ==
X-Received: by 2002:a05:6a00:2d9c:b0:71d:fe19:83ee with SMTP id
 d2e1a72fcca58-724132a62f4mr12713512b3a.10.1731214822668; 
 Sat, 09 Nov 2024 21:00:22 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72407a18d8csm6709215b3a.149.2024.11.09.21.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 21:00:22 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/2] hw/usb: Make PCI device more configurable
Date: Sun, 10 Nov 2024 15:00:07 +1000
Message-ID: <20241110050009.389367-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110050009.389367-1-npiggin@gmail.com>
References: <20241110050009.389367-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

To prepare to support another USB PCI Host Controller, make some PCI
configuration dynamic.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/hcd-xhci-pci.h |  9 ++++++
 hw/usb/hcd-xhci-nec.c | 10 +++++++
 hw/usb/hcd-xhci-pci.c | 69 ++++++++++++++++++++++++++++++++++++-------
 3 files changed, 78 insertions(+), 10 deletions(-)

diff --git a/hw/usb/hcd-xhci-pci.h b/hw/usb/hcd-xhci-pci.h
index 08f70ce97c..213076aabf 100644
--- a/hw/usb/hcd-xhci-pci.h
+++ b/hw/usb/hcd-xhci-pci.h
@@ -40,6 +40,15 @@ typedef struct XHCIPciState {
     XHCIState xhci;
     OnOffAuto msi;
     OnOffAuto msix;
+    uint8_t cache_line_size;
+    uint8_t pm_cap_off;
+    uint8_t pcie_cap_off;
+    uint8_t msi_cap_off;
+    uint8_t msix_cap_off;
+    int msix_bar_nr;
+    uint64_t msix_bar_size;
+    uint32_t msix_table_off;
+    uint32_t msix_pba_off;
 } XHCIPciState;
 
 #endif
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index 0c063b3697..e23b5ff084 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -54,6 +54,16 @@ static void nec_xhci_instance_init(Object *obj)
     pci->xhci.flags    = nec->flags;
     pci->xhci.numintrs = nec->intrs;
     pci->xhci.numslots = nec->slots;
+
+    pci->cache_line_size = 0x10;
+    pci->pm_cap_off = 0;
+    pci->pcie_cap_off = 0xa0;
+    pci->msi_cap_off = 0x70;
+    pci->msix_cap_off = 0x90;
+    pci->msix_bar_nr = 0;
+    pci->msix_bar_size = 0;
+    pci->msix_table_off = 0x3000;
+    pci->msix_pba_off = 0x3800;
 }
 
 static void nec_xhci_class_init(ObjectClass *klass, void *data)
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index a039f5778a..948d75b737 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -32,8 +32,9 @@
 #include "trace.h"
 #include "qapi/error.h"
 
-#define OFF_MSIX_TABLE  0x3000
-#define OFF_MSIX_PBA    0x3800
+#define MSIX_BAR_SIZE   0x800000
+#define OFF_MSIX_TABLE  0x0000
+#define OFF_MSIX_PBA    0x1000
 
 static void xhci_pci_intr_update(XHCIState *xhci, int n, bool enable)
 {
@@ -104,6 +105,31 @@ static int xhci_pci_vmstate_post_load(void *opaque, int version_id)
    return 0;
 }
 
+static int xhci_pci_add_pm_capability(PCIDevice *pci_dev, uint8_t offset,
+                                      Error **errp)
+{
+    int err;
+
+    err = pci_add_capability(pci_dev, PCI_CAP_ID_PM, offset,
+                             PCI_PM_SIZEOF, errp);
+    if (err < 0) {
+        return err;
+    }
+
+    pci_set_word(pci_dev->config + offset + PCI_PM_PMC,
+                 PCI_PM_CAP_VER_1_2 |
+                 PCI_PM_CAP_D1 | PCI_PM_CAP_D2 |
+                 PCI_PM_CAP_PME_D0 | PCI_PM_CAP_PME_D1 |
+                 PCI_PM_CAP_PME_D2 | PCI_PM_CAP_PME_D3hot);
+    pci_set_word(pci_dev->wmask + offset + PCI_PM_PMC, 0);
+    pci_set_word(pci_dev->config + offset + PCI_PM_CTRL,
+                 PCI_PM_CTRL_NO_SOFT_RESET);
+    pci_set_word(pci_dev->wmask + offset + PCI_PM_CTRL,
+                 PCI_PM_CTRL_STATE_MASK);
+
+    return 0;
+}
+
 static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
 {
     int ret;
@@ -112,7 +138,7 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
 
     dev->config[PCI_CLASS_PROG] = 0x30;    /* xHCI */
     dev->config[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin 1 */
-    dev->config[PCI_CACHE_LINE_SIZE] = 0x10;
+    dev->config[PCI_CACHE_LINE_SIZE] = s->cache_line_size;
     dev->config[0x60] = 0x30; /* release number */
 
     object_property_set_link(OBJECT(&s->xhci), "host", OBJECT(s), NULL);
@@ -125,8 +151,16 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
         s->xhci.nec_quirks = true;
     }
 
+    if (s->pm_cap_off) {
+        if (xhci_pci_add_pm_capability(dev, s->pm_cap_off, &err)) {
+            error_propagate(errp, err);
+            return;
+        }
+    }
+
     if (s->msi != ON_OFF_AUTO_OFF) {
-        ret = msi_init(dev, 0x70, s->xhci.numintrs, true, false, &err);
+        ret = msi_init(dev, s->msi_cap_off, s->xhci.numintrs,
+                       true, false, &err);
         /*
          * Any error other than -ENOTSUP(board's MSI support is broken)
          * is a programming error
@@ -143,22 +177,37 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
         /* With msi=auto, we fall back to MSI off silently */
         error_free(err);
     }
+
     pci_register_bar(dev, 0,
                      PCI_BASE_ADDRESS_SPACE_MEMORY |
                      PCI_BASE_ADDRESS_MEM_TYPE_64,
                      &s->xhci.mem);
 
     if (pci_bus_is_express(pci_get_bus(dev))) {
-        ret = pcie_endpoint_cap_init(dev, 0xa0);
+        ret = pcie_endpoint_cap_init(dev, s->pcie_cap_off);
         assert(ret > 0);
     }
 
     if (s->msix != ON_OFF_AUTO_OFF) {
-        /* TODO check for errors, and should fail when msix=on */
-        msix_init(dev, s->xhci.numintrs,
-                  &s->xhci.mem, 0, OFF_MSIX_TABLE,
-                  &s->xhci.mem, 0, OFF_MSIX_PBA,
-                  0x90, NULL);
+        MemoryRegion *msix_bar = &s->xhci.mem;
+        if (s->msix_bar_nr != 0) {
+            memory_region_init(&dev->msix_exclusive_bar, OBJECT(dev),
+                               "xhci-msix", s->msix_bar_size);
+            msix_bar = &dev->msix_exclusive_bar;
+        }
+
+        ret = msix_init(dev, s->xhci.numintrs,
+                        msix_bar, s->msix_bar_nr, s->msix_table_off,
+                        msix_bar, s->msix_bar_nr, s->msix_pba_off,
+                        s->msix_cap_off, errp);
+        if (ret) {
+            return;
+        }
+
+        pci_register_bar(dev, s->msix_bar_nr,
+                         PCI_BASE_ADDRESS_SPACE_MEMORY |
+                         PCI_BASE_ADDRESS_MEM_TYPE_64,
+                         msix_bar);
     }
     s->xhci.as = pci_get_address_space(dev);
 }
-- 
2.45.2


