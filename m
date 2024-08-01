Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8C1C52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZTAy-0006jt-RC; Thu, 01 Aug 2024 06:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTAx-0006YQ-IU
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:36:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTAv-0001in-Ju
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722508609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hRCx2gCZ+ZzoKrIRZlzKc05euagciJr8hV1RAZGu1aM=;
 b=KMeACFgztfcRN6zxqeXJIADU5qUGg7xhyszdvvzrO68evAERaacEa6ZKpYo9hE4zYznBnG
 retsMog3cFp2qrsVbm5TCDCzXlZT6ULw1S5vtIuChGbNNv1xZbvmiLWkpYshnhFtm51SfU
 /7gdYJUrucSaqEQLKJzQjvIXAyY8QUc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-5u6Esno8MTOM267ap-nOUw-1; Thu, 01 Aug 2024 06:36:45 -0400
X-MC-Unique: 5u6Esno8MTOM267ap-nOUw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5a16fae2ba7so3876925a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722508603; x=1723113403;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hRCx2gCZ+ZzoKrIRZlzKc05euagciJr8hV1RAZGu1aM=;
 b=whGjvNEP5NtwLj7uxPure01FCK66eH0BdNn2r76qNzOLrSkb4xdh7qW7aSYGgzza/k
 CA4Vx8yBxavcdqOlJsbUghzQUVcAeYr3kdFmKAz+fptWTbCtfIuwUucZNKzlBT2I+bbE
 pC/SWrfUrzpwWlH/N8vkJAvua5//MNdQIvk2AXYbPjM7gLX9KPuZp9lbzS09lBTCtywQ
 ZTAN4IVoUoAtB6GIWDyt8qYHQsb7yqeC4C/Zwco76qiuMyaQ493Y116BNuFRytdtbRzF
 2toKfW9qk0rhYvoIzME33CVe8M93WXwJ0MgT/BOrkL6+e+abkLR85tyvhBPpEGhPzGN1
 2Qsg==
X-Gm-Message-State: AOJu0Yz5NhlJSMUP60jimoCQZ8FMJVr+tBQKnYpAqHMAICKH1v8amjZs
 RgRKiOpAM/ifUsa2+3/MbeKUSI9UawjnNkNNbFwJ9UVZGptSut+8zoG9q3qR8GK+V049NYWnCOc
 ZO7TCykjIK/jELB32jxqOg05KXGwdKdV+cFG/BZbkIZh2JmqnvB8sYc4ekD1CGahlaJc6rnIq1Z
 1PDarsbo0B4z8YoSRtSNxsUQi3BHzKdA==
X-Received: by 2002:aa7:c391:0:b0:5a2:c1b1:4b9 with SMTP id
 4fb4d7f45d1cf-5b701279a87mr1188389a12.35.1722508603068; 
 Thu, 01 Aug 2024 03:36:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9++EKZI5TYsnSbZ001Ilx+sA0qJkX72C8/8C8Z02bJ4Yu48d1cG50ftoemOsQ+YOTwei4dw==
X-Received: by 2002:aa7:c391:0:b0:5a2:c1b1:4b9 with SMTP id
 4fb4d7f45d1cf-5b701279a87mr1188363a12.35.1722508602388; 
 Thu, 01 Aug 2024 03:36:42 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac6578356csm10130110a12.87.2024.08.01.03.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:36:39 -0700 (PDT)
Date: Thu, 1 Aug 2024 06:36:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 12/19] Revert "pcie_sriov: Reuse SR-IOV VF device instances"
Message-ID: <b1282f1e352db9947267a6524c6ded9678e82629.1722508478.git.mst@redhat.com>
References: <cover.1722508478.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722508478.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This reverts commit 139610ae67f6ecf92127bb7bf53ac6265b459ec8.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci.h        |  5 ++
 include/hw/pci/pci_device.h | 15 ------
 include/hw/pci/pcie_sriov.h |  1 +
 hw/pci/pci.c                |  2 +-
 hw/pci/pcie_sriov.c         | 95 +++++++++++++++++++++----------------
 5 files changed, 62 insertions(+), 56 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 14a869eeaa..fe04b4fafd 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -680,4 +680,9 @@ static inline void pci_irq_pulse(PCIDevice *pci_dev)
 MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
 void pci_set_enabled(PCIDevice *pci_dev, bool state);
 
+static inline void pci_set_power(PCIDevice *pci_dev, bool state)
+{
+    pci_set_enabled(pci_dev, state);
+}
+
 #endif
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 1ff3ce94e2..f38fb31119 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -212,21 +212,6 @@ static inline uint16_t pci_get_bdf(PCIDevice *dev)
     return PCI_BUILD_BDF(pci_bus_num(pci_get_bus(dev)), dev->devfn);
 }
 
-static inline void pci_set_power(PCIDevice *pci_dev, bool state)
-{
-    /*
-     * Don't change the enabled state of VFs when powering on/off the device.
-     *
-     * When powering on, VFs must not be enabled immediately but they must
-     * wait until the guest configures SR-IOV.
-     * When powering off, their corresponding PFs will be reset and disable
-     * VFs.
-     */
-    if (!pci_is_vf(pci_dev)) {
-        pci_set_enabled(pci_dev, state);
-    }
-}
-
 uint16_t pci_requester_id(PCIDevice *dev);
 
 /* DMA access functions */
diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index 70649236c1..aa704e8f9d 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -18,6 +18,7 @@
 typedef struct PCIESriovPF {
     uint16_t num_vfs;   /* Number of virtual functions created */
     uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
+    const char *vfname; /* Reference to the device type used for the VFs */
     PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
 } PCIESriovPF;
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 5c0050e178..b532888e8f 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2895,7 +2895,7 @@ void pci_set_enabled(PCIDevice *d, bool state)
     memory_region_set_enabled(&d->bus_master_enable_region,
                               (pci_get_word(d->config + PCI_COMMAND)
                                & PCI_COMMAND_MASTER) && d->enabled);
-    if (d->qdev.realized) {
+    if (!d->enabled) {
         pci_device_reset(d);
     }
 }
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index faadb0d2ea..f0bde0d3fc 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -20,16 +20,9 @@
 #include "qapi/error.h"
 #include "trace.h"
 
-static void unparent_vfs(PCIDevice *dev, uint16_t total_vfs)
-{
-    for (uint16_t i = 0; i < total_vfs; i++) {
-        PCIDevice *vf = dev->exp.sriov_pf.vf[i];
-        object_unparent(OBJECT(vf));
-        object_unref(OBJECT(vf));
-    }
-    g_free(dev->exp.sriov_pf.vf);
-    dev->exp.sriov_pf.vf = NULL;
-}
+static PCIDevice *register_vf(PCIDevice *pf, int devfn,
+                              const char *name, uint16_t vf_num);
+static void unregister_vfs(PCIDevice *dev);
 
 bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
                         const char *vfname, uint16_t vf_dev_id,
@@ -37,8 +30,6 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
                         uint16_t vf_offset, uint16_t vf_stride,
                         Error **errp)
 {
-    BusState *bus = qdev_get_parent_bus(&dev->qdev);
-    int32_t devfn = dev->devfn + vf_offset;
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
@@ -58,6 +49,7 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
                         offset, PCI_EXT_CAP_SRIOV_SIZEOF);
     dev->exp.sriov_cap = offset;
     dev->exp.sriov_pf.num_vfs = 0;
+    dev->exp.sriov_pf.vfname = g_strdup(vfname);
     dev->exp.sriov_pf.vf = NULL;
 
     pci_set_word(cfg + PCI_SRIOV_VF_OFFSET, vf_offset);
@@ -91,34 +83,14 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
 
     qdev_prop_set_bit(&dev->qdev, "multifunction", true);
 
-    dev->exp.sriov_pf.vf = g_new(PCIDevice *, total_vfs);
-
-    for (uint16_t i = 0; i < total_vfs; i++) {
-        PCIDevice *vf = pci_new(devfn, vfname);
-        vf->exp.sriov_vf.pf = dev;
-        vf->exp.sriov_vf.vf_number = i;
-
-        if (!qdev_realize(&vf->qdev, bus, errp)) {
-            unparent_vfs(dev, i);
-            return false;
-        }
-
-        /* set vid/did according to sr/iov spec - they are not used */
-        pci_config_set_vendor_id(vf->config, 0xffff);
-        pci_config_set_device_id(vf->config, 0xffff);
-
-        dev->exp.sriov_pf.vf[i] = vf;
-        devfn += vf_stride;
-    }
-
     return true;
 }
 
 void pcie_sriov_pf_exit(PCIDevice *dev)
 {
-    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
-
-    unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
+    unregister_vfs(dev);
+    g_free((char *)dev->exp.sriov_pf.vfname);
+    dev->exp.sriov_pf.vfname = NULL;
 }
 
 void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
@@ -184,11 +156,38 @@ void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
     }
 }
 
+static PCIDevice *register_vf(PCIDevice *pf, int devfn, const char *name,
+                              uint16_t vf_num)
+{
+    PCIDevice *dev = pci_new(devfn, name);
+    dev->exp.sriov_vf.pf = pf;
+    dev->exp.sriov_vf.vf_number = vf_num;
+    PCIBus *bus = pci_get_bus(pf);
+    Error *local_err = NULL;
+
+    qdev_realize(&dev->qdev, &bus->qbus, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return NULL;
+    }
+
+    /* set vid/did according to sr/iov spec - they are not used */
+    pci_config_set_vendor_id(dev->config, 0xffff);
+    pci_config_set_device_id(dev->config, 0xffff);
+
+    return dev;
+}
+
 static void register_vfs(PCIDevice *dev)
 {
     uint16_t num_vfs;
     uint16_t i;
     uint16_t sriov_cap = dev->exp.sriov_cap;
+    uint16_t vf_offset =
+        pci_get_word(dev->config + sriov_cap + PCI_SRIOV_VF_OFFSET);
+    uint16_t vf_stride =
+        pci_get_word(dev->config + sriov_cap + PCI_SRIOV_VF_STRIDE);
+    int32_t devfn = dev->devfn + vf_offset;
 
     assert(sriov_cap > 0);
     num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
@@ -196,10 +195,18 @@ static void register_vfs(PCIDevice *dev)
         return;
     }
 
+    dev->exp.sriov_pf.vf = g_new(PCIDevice *, num_vfs);
+
     trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
                              PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
-        pci_set_enabled(dev->exp.sriov_pf.vf[i], true);
+        dev->exp.sriov_pf.vf[i] = register_vf(dev, devfn,
+                                              dev->exp.sriov_pf.vfname, i);
+        if (!dev->exp.sriov_pf.vf[i]) {
+            num_vfs = i;
+            break;
+        }
+        devfn += vf_stride;
     }
     dev->exp.sriov_pf.num_vfs = num_vfs;
 }
@@ -212,8 +219,12 @@ static void unregister_vfs(PCIDevice *dev)
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
                                PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
-        pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
+        PCIDevice *vf = dev->exp.sriov_pf.vf[i];
+        object_unparent(OBJECT(vf));
+        object_unref(OBJECT(vf));
     }
+    g_free(dev->exp.sriov_pf.vf);
+    dev->exp.sriov_pf.vf = NULL;
     dev->exp.sriov_pf.num_vfs = 0;
 }
 
@@ -235,10 +246,14 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
                              PCI_FUNC(dev->devfn), off, val, len);
 
     if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
-        if (val & PCI_SRIOV_CTRL_VFE) {
-            register_vfs(dev);
+        if (dev->exp.sriov_pf.num_vfs) {
+            if (!(val & PCI_SRIOV_CTRL_VFE)) {
+                unregister_vfs(dev);
+            }
         } else {
-            unregister_vfs(dev);
+            if (val & PCI_SRIOV_CTRL_VFE) {
+                register_vfs(dev);
+            }
         }
     }
 }
-- 
MST


