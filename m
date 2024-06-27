Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EECDC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 06:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMiJR-0004AB-Nh; Thu, 27 Jun 2024 02:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMiJN-00046N-JT
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:08:49 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMiJL-0003eX-Kt
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:08:49 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70698bcd19eso2071061b3a.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 23:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719468526; x=1720073326;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0lcaaU9R5OXSyI4TGr+cuN2Ij0UFV5jhF4TGS6bzzI8=;
 b=uQQRCga6t35Gi0UB1bY1OWi2mi0WGQpcOIGZOAm8Khi7PB/ihUgBmgtQAw7u+/TzTr
 0B5OsjGAriOQToKmTrxrsx3uBSqDoTjssUWdkUxlcqp8yyYd42mrF8dUc7+hNlLEKTqB
 0+jU0cjCgdj67mXS4LRKYhPA6ulFdN2L9HcR5o9KMfLp2MRa7wfIQK9x/HSW20y/7ITe
 E9Q8jxsBdxnFmqkBc5Hyw21EVbN1QYRfGX5ZJ055EZjIfWgshtYIKAT7lMOVxMt1P7W3
 jzh/PVDzqU1X0fty8KxVMZmuvFxU1krJzrw33VYTInPMigEOPKCj1aY3fi5639MnlSb7
 AafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719468526; x=1720073326;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0lcaaU9R5OXSyI4TGr+cuN2Ij0UFV5jhF4TGS6bzzI8=;
 b=nlqazMVTZXYeCOIAPpLr8CUDA1AwVqTqkIBT9SP7POCjKMrui/zI5xR61ExT1T8V0R
 V3eRcVGU8esKVLyjetlfTBwYnzdWFTg9fqcyf8EcQZtX52kDmtWjRrFr2EhPPUCofZBt
 DPsnqmBtX34XrrXEfb64a3/fgE61KYcLgMj98yAnsf2tLQMAh+9PGfqpTpYDXehBnxB6
 rpl4ITJkkm0AbtWwcrKzEethtb2JbfHcoLw2mIKzPNajNxs3HJ1YyXwht7iFeoZ5I+6i
 4BW4yCV6ymbCGcaa+risW56h2pc17pqfMgxeyTfXhq1NoRQv6zKRCYlCWIDbiH4EnBgl
 G1BA==
X-Gm-Message-State: AOJu0YyKMgQbWflqBX9PwNojIfnLw7yQFyd/zcJQau3VyjfARGDwAB4p
 hx96SJzymmBnS6xh+h07ToJ6JsDC50nTWVJthuKw0Oqu9O6pJip34t8PObuL5Ys=
X-Google-Smtp-Source: AGHT+IEweVqOb6+JPGQHbbOvWaGLRkXDa+S4fol0v6qZShl0x2ps5R1XWboCMqYgChZplAs4osGpzw==
X-Received: by 2002:a05:6a21:1f07:b0:1b5:d063:3396 with SMTP id
 adf61e73a8af0-1bcf80260a0mr10238608637.59.1719468525976; 
 Wed, 26 Jun 2024 23:08:45 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1faac8df8d5sm5071095ad.38.2024.06.26.23.08.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 23:08:45 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 15:07:55 +0900
Subject: [PATCH v10 06/12] pcie_sriov: Reuse SR-IOV VF device instances
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-reuse-v10-6-7ca0b8ed3d9f@daynix.com>
References: <20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com>
In-Reply-To: <20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Disable SR-IOV VF devices by reusing code to power down PCI devices
instead of removing them when the guest requests to disable VFs. This
allows to realize devices and report VF realization errors at PF
realization time.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pci.h        |  5 ---
 include/hw/pci/pci_device.h | 15 +++++++
 include/hw/pci/pcie_sriov.h |  1 -
 hw/pci/pci.c                |  2 +-
 hw/pci/pcie_sriov.c         | 95 +++++++++++++++++++--------------------------
 5 files changed, 56 insertions(+), 62 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 6c92b2f70008..442017b4865d 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -644,9 +644,4 @@ static inline void pci_irq_pulse(PCIDevice *pci_dev)
 MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
 void pci_set_enabled(PCIDevice *pci_dev, bool state);
 
-static inline void pci_set_power(PCIDevice *pci_dev, bool state)
-{
-    pci_set_enabled(pci_dev, state);
-}
-
 #endif
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index d57f9ce83884..ca151325085d 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -205,6 +205,21 @@ static inline uint16_t pci_get_bdf(PCIDevice *dev)
     return PCI_BUILD_BDF(pci_bus_num(pci_get_bus(dev)), dev->devfn);
 }
 
+static inline void pci_set_power(PCIDevice *pci_dev, bool state)
+{
+    /*
+     * Don't change the enabled state of VFs when powering on/off the device.
+     *
+     * When powering on, VFs must not be enabled immediately but they must
+     * wait until the guest configures SR-IOV.
+     * When powering off, their corresponding PFs will be reset and disable
+     * VFs.
+     */
+    if (!pci_is_vf(pci_dev)) {
+        pci_set_enabled(pci_dev, state);
+    }
+}
+
 uint16_t pci_requester_id(PCIDevice *dev);
 
 /* DMA access functions */
diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index aa704e8f9d9f..70649236c18a 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -18,7 +18,6 @@
 typedef struct PCIESriovPF {
     uint16_t num_vfs;   /* Number of virtual functions created */
     uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
-    const char *vfname; /* Reference to the device type used for the VFs */
     PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
 } PCIESriovPF;
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 295a32714a4a..c682c3dcb68e 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2822,7 +2822,7 @@ void pci_set_enabled(PCIDevice *d, bool state)
     memory_region_set_enabled(&d->bus_master_enable_region,
                               (pci_get_word(d->config + PCI_COMMAND)
                                & PCI_COMMAND_MASTER) && d->enabled);
-    if (!d->enabled) {
+    if (d->qdev.realized) {
         pci_device_reset(d);
     }
 }
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index f0bde0d3fc79..faadb0d2ea85 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -20,9 +20,16 @@
 #include "qapi/error.h"
 #include "trace.h"
 
-static PCIDevice *register_vf(PCIDevice *pf, int devfn,
-                              const char *name, uint16_t vf_num);
-static void unregister_vfs(PCIDevice *dev);
+static void unparent_vfs(PCIDevice *dev, uint16_t total_vfs)
+{
+    for (uint16_t i = 0; i < total_vfs; i++) {
+        PCIDevice *vf = dev->exp.sriov_pf.vf[i];
+        object_unparent(OBJECT(vf));
+        object_unref(OBJECT(vf));
+    }
+    g_free(dev->exp.sriov_pf.vf);
+    dev->exp.sriov_pf.vf = NULL;
+}
 
 bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
                         const char *vfname, uint16_t vf_dev_id,
@@ -30,6 +37,8 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
                         uint16_t vf_offset, uint16_t vf_stride,
                         Error **errp)
 {
+    BusState *bus = qdev_get_parent_bus(&dev->qdev);
+    int32_t devfn = dev->devfn + vf_offset;
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
@@ -49,7 +58,6 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
                         offset, PCI_EXT_CAP_SRIOV_SIZEOF);
     dev->exp.sriov_cap = offset;
     dev->exp.sriov_pf.num_vfs = 0;
-    dev->exp.sriov_pf.vfname = g_strdup(vfname);
     dev->exp.sriov_pf.vf = NULL;
 
     pci_set_word(cfg + PCI_SRIOV_VF_OFFSET, vf_offset);
@@ -83,14 +91,34 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
 
     qdev_prop_set_bit(&dev->qdev, "multifunction", true);
 
+    dev->exp.sriov_pf.vf = g_new(PCIDevice *, total_vfs);
+
+    for (uint16_t i = 0; i < total_vfs; i++) {
+        PCIDevice *vf = pci_new(devfn, vfname);
+        vf->exp.sriov_vf.pf = dev;
+        vf->exp.sriov_vf.vf_number = i;
+
+        if (!qdev_realize(&vf->qdev, bus, errp)) {
+            unparent_vfs(dev, i);
+            return false;
+        }
+
+        /* set vid/did according to sr/iov spec - they are not used */
+        pci_config_set_vendor_id(vf->config, 0xffff);
+        pci_config_set_device_id(vf->config, 0xffff);
+
+        dev->exp.sriov_pf.vf[i] = vf;
+        devfn += vf_stride;
+    }
+
     return true;
 }
 
 void pcie_sriov_pf_exit(PCIDevice *dev)
 {
-    unregister_vfs(dev);
-    g_free((char *)dev->exp.sriov_pf.vfname);
-    dev->exp.sriov_pf.vfname = NULL;
+    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
+
+    unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
 }
 
 void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
@@ -156,38 +184,11 @@ void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
     }
 }
 
-static PCIDevice *register_vf(PCIDevice *pf, int devfn, const char *name,
-                              uint16_t vf_num)
-{
-    PCIDevice *dev = pci_new(devfn, name);
-    dev->exp.sriov_vf.pf = pf;
-    dev->exp.sriov_vf.vf_number = vf_num;
-    PCIBus *bus = pci_get_bus(pf);
-    Error *local_err = NULL;
-
-    qdev_realize(&dev->qdev, &bus->qbus, &local_err);
-    if (local_err) {
-        error_report_err(local_err);
-        return NULL;
-    }
-
-    /* set vid/did according to sr/iov spec - they are not used */
-    pci_config_set_vendor_id(dev->config, 0xffff);
-    pci_config_set_device_id(dev->config, 0xffff);
-
-    return dev;
-}
-
 static void register_vfs(PCIDevice *dev)
 {
     uint16_t num_vfs;
     uint16_t i;
     uint16_t sriov_cap = dev->exp.sriov_cap;
-    uint16_t vf_offset =
-        pci_get_word(dev->config + sriov_cap + PCI_SRIOV_VF_OFFSET);
-    uint16_t vf_stride =
-        pci_get_word(dev->config + sriov_cap + PCI_SRIOV_VF_STRIDE);
-    int32_t devfn = dev->devfn + vf_offset;
 
     assert(sriov_cap > 0);
     num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
@@ -195,18 +196,10 @@ static void register_vfs(PCIDevice *dev)
         return;
     }
 
-    dev->exp.sriov_pf.vf = g_new(PCIDevice *, num_vfs);
-
     trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
                              PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
-        dev->exp.sriov_pf.vf[i] = register_vf(dev, devfn,
-                                              dev->exp.sriov_pf.vfname, i);
-        if (!dev->exp.sriov_pf.vf[i]) {
-            num_vfs = i;
-            break;
-        }
-        devfn += vf_stride;
+        pci_set_enabled(dev->exp.sriov_pf.vf[i], true);
     }
     dev->exp.sriov_pf.num_vfs = num_vfs;
 }
@@ -219,12 +212,8 @@ static void unregister_vfs(PCIDevice *dev)
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
                                PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
-        PCIDevice *vf = dev->exp.sriov_pf.vf[i];
-        object_unparent(OBJECT(vf));
-        object_unref(OBJECT(vf));
+        pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
     }
-    g_free(dev->exp.sriov_pf.vf);
-    dev->exp.sriov_pf.vf = NULL;
     dev->exp.sriov_pf.num_vfs = 0;
 }
 
@@ -246,14 +235,10 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
                              PCI_FUNC(dev->devfn), off, val, len);
 
     if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
-        if (dev->exp.sriov_pf.num_vfs) {
-            if (!(val & PCI_SRIOV_CTRL_VFE)) {
-                unregister_vfs(dev);
-            }
+        if (val & PCI_SRIOV_CTRL_VFE) {
+            register_vfs(dev);
         } else {
-            if (val & PCI_SRIOV_CTRL_VFE) {
-                register_vfs(dev);
-            }
+            unregister_vfs(dev);
         }
     }
 }

-- 
2.45.2


