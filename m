Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF57C54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 15:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riyhF-0001bl-VQ; Sat, 09 Mar 2024 10:33:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaacwoods.home@gmail.com>)
 id 1riyZw-0000H8-BI
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 10:25:42 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isaacwoods.home@gmail.com>)
 id 1riyZs-0007vx-V4
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 10:25:38 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-412fc5f5152so22444745e9.0
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 07:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709997926; x=1710602726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p8duqk3DQZ4pwtbBPDMsGhD+I9fcYJiGxlPhWsv3q6Y=;
 b=YeJxoT8g1ukdv0joldVS46VSyLqruuwFa/j1KIyvvqmSS5U4xTGBjs2Q7Zg+hgHFYQ
 ja+1y3mtZvhbYAEF9ac6kK9p9WdsB9rclkYKXTGSAJoEI3IcIm8GnxTIPZ7e66ecylcF
 vgBqvso+0eV4hEuk145KIJOZnYVzt8KJ1KpOxAygzPSrih5Vg3ogDuLbouRooIZJii+H
 ldMpZjBV1gGy+z7JQ8RFH1Xz/hoDKU3oQFcHqfUOclSjXT5xjnKrXucf1UmOI6aZtCMM
 8aTSl6ZQcXNiDp+Q70rlMlf0ZmuBkgFcmcorEoM88oUCXhOsodIaIHRtCYrhTDQbmn84
 p7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709997926; x=1710602726;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p8duqk3DQZ4pwtbBPDMsGhD+I9fcYJiGxlPhWsv3q6Y=;
 b=dfK+22YO+UjSo6OgxZBWE3zfXGmFEYU5pHectx/+yfZOr/ERzAex/VZN7xwc3gPlcJ
 yeieACOQWzcmNIGOdlrzmPAJ2Co26mS4urIq55TRdDmTA7MI10PeYFRVIsrAHdHGzrW8
 FNbPEgK5L/mdPO8qB7J96x/+01ekqFuJkI6IM2qR8MQH1db93hKqXWcwbS1RkjZvn7RK
 m1nFrhFcD/K+dknjH9cVXviDhAQlZnzb/6gl30a7DfiwCa9Mj81A4vHrginaBetUNBLp
 BKx9gE6bRMjHWwBJBQJ6UfX4e2kiK32EHZiWahKKXM99AWelVwuUq8Zz+e57hfsfvFst
 2bBA==
X-Gm-Message-State: AOJu0Yy6tl7AFqp43uJf1ypu8GbT84sutYSO/dqtjpTVbP2roy7VMwPT
 xpKDgimOcmSkgil+K4cX6pbPGA1PT4zdMF10z0fp9CgYEf8X3soy6sHc7S+4/SY=
X-Google-Smtp-Source: AGHT+IGJv20BhtepCG4TLGuqnAhJKZLpD11MZ4BgQFpzAxfpVP9PauGJyERuOPocWdxKGaw7dAWk2A==
X-Received: by 2002:a05:600c:5020:b0:412:dc02:9824 with SMTP id
 n32-20020a05600c502000b00412dc029824mr2025487wmr.9.1709997925480; 
 Sat, 09 Mar 2024 07:25:25 -0800 (PST)
Received: from localhost.localdomain (25.58.198.146.dyn.plus.net.
 [146.198.58.25]) by smtp.gmail.com with ESMTPSA id
 v9-20020a05600c470900b0041312e8ef2bsm2842322wmo.26.2024.03.09.07.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 07:25:25 -0800 (PST)
From: Isaac Woods <isaacwoods.home@gmail.com>
To: qemu-devel@nongnu.org
Cc: isaacwoods.home@gmail.com,
	kraxel@redhat.com
Subject: [PATCH] usb: add support for sending MSIs from EHCI PCI devices
Date: Sat,  9 Mar 2024 15:10:32 +0000
Message-ID: <20240309151031.29417-2-isaacwoods.home@gmail.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=isaacwoods.home@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 09 Mar 2024 10:33:12 -0500
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

Signed-off-by: Isaac Woods <isaacwoods.home@gmail.com>
---
 hw/usb/hcd-ehci-pci.c    | 27 +++++++++++++++++++++++++++
 hw/usb/hcd-ehci-sysbus.c |  7 +++++++
 hw/usb/hcd-ehci.c        |  2 +-
 hw/usb/hcd-ehci.h        |  2 ++
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index 3ff54edf62..8a714b6733 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -21,6 +21,8 @@
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "qemu/range.h"
+#include "hw/pci/msi.h"
+#include "qapi/error.h"
 
 typedef struct EHCIPCIInfo {
     const char *name;
@@ -30,11 +32,27 @@ typedef struct EHCIPCIInfo {
     bool companion;
 } EHCIPCIInfo;
 
+static void ehci_pci_intr_update(EHCIState *ehci, bool enable)
+{
+    EHCIPCIState *s = container_of(ehci, EHCIPCIState, ehci);
+    PCIDevice *pci_dev = PCI_DEVICE(s);
+
+    if (msi_enabled(pci_dev)) {
+        if (enable) {
+            msi_notify(pci_dev, 0);
+        }
+    } else {
+        pci_set_irq(pci_dev, enable);
+    }
+}
+
 static void usb_ehci_pci_realize(PCIDevice *dev, Error **errp)
 {
     EHCIPCIState *i = PCI_EHCI(dev);
     EHCIState *s = &i->ehci;
     uint8_t *pci_conf = dev->config;
+    Error *err = NULL;
+    int ret;
 
     pci_set_byte(&pci_conf[PCI_CLASS_PROG], 0x20);
 
@@ -68,8 +86,17 @@ static void usb_ehci_pci_realize(PCIDevice *dev, Error **errp)
     s->irq = pci_allocate_irq(dev);
     s->as = pci_get_address_space(dev);
 
+    s->intr_update = ehci_pci_intr_update;
+
     usb_ehci_realize(s, DEVICE(dev), NULL);
     pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mem);
+
+    ret = msi_init(dev, 0x70, 1, true, false, &err);
+    if (ret) {
+        error_propagate(errp, err);
+    } else {
+        error_free(err);
+    }
 }
 
 static void usb_ehci_pci_init(Object *obj)
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index fe1dabd0bb..e08c856e2b 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -38,6 +38,11 @@ static Property ehci_sysbus_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void usb_ehci_sysbus_intr_update(EHCIState *ehci, bool level)
+{
+    qemu_set_irq(s->irq, level);
+}
+
 static void usb_ehci_sysbus_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *d = SYS_BUS_DEVICE(dev);
@@ -70,6 +75,8 @@ static void ehci_sysbus_init(Object *obj)
     s->portnr = sec->portnr;
     s->as = &address_space_memory;
 
+    s->intr_update = usb_ehci_sysbus_intr_update;
+
     usb_ehci_init(s, DEVICE(obj));
     sysbus_init_mmio(d, &s->mem);
 }
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 01864d4649..e1f71dc445 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -209,7 +209,7 @@ static inline void ehci_update_irq(EHCIState *s)
     }
 
     trace_usb_ehci_irq(level, s->frindex, s->usbsts, s->usbintr);
-    qemu_set_irq(s->irq, level);
+    (s->intr_update)(s, level);
 }
 
 /* flag interrupt condition */
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index 56a1c09d1f..bc017aec79 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -305,6 +305,8 @@ struct EHCIState {
     EHCIQueueHead aqueues;
     EHCIQueueHead pqueues;
 
+    void (*intr_update)(EHCIState *s, bool enable);
+
     /* which address to look at next */
     uint32_t a_fetch_addr;
     uint32_t p_fetch_addr;
-- 
2.44.0


