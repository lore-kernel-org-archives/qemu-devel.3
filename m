Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B28C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeEX-0008AH-07; Tue, 02 Jul 2024 10:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeEL-0006dA-KP
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeEG-0000VT-Db
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=30vtT+Bk+aBG/k9psr6e7+phVupnPVIwCqnHm1QF2rI=;
 b=W3FmgLEe5RNJTIkmcpx+y/bql5IWzYdjm6a88nhaHgzak6XNUVUoPe/k71m/FgE/gxHuOM
 1Yg6YuL9VxB4Nzi1NP4Jlak6SzCM+yllyiKmSoOqoF/cHRYJdK6qTM5vwNhhbaFmvIxI0O
 IN2F4f1ZHBE8LjXWp6LbZjTgR/YO62w=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-pDZ8CvyzNfi9TknvQcXeYw-1; Tue, 02 Jul 2024 10:11:30 -0400
X-MC-Unique: pDZ8CvyzNfi9TknvQcXeYw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52cd67cee83so4073022e87.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929488; x=1720534288;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=30vtT+Bk+aBG/k9psr6e7+phVupnPVIwCqnHm1QF2rI=;
 b=J/7ONwjpbGKhDrDc5TzfUGz5J5/xHUUgbkbRijuf1uGcW2Sbz8yp59jMeZe/bsdlga
 Q0msspjRg2JS4vPb+ghlPhAzYCpohlj8rEAS7jQFZNlSgz5PgzRmE6JT3xGFrfL6tYDE
 /dfViktP5Wi9Twp3/Dgzt19E6cLdekXCv/VbBGAnDZ94ebDJdJDSTBJsHV3uLl12gPZA
 TMAvNSZ3CgLwN6V8COI7nLm4xJbIvifPh5P+EJ4ddnpf4kkOvJTAprLt4817SfMoxvZ1
 4jXPtIbKvwtpITaS21MJ198RcXCvYKmZrMNkAr7xwPsf/lQR0EaOpArguqsw38MreMt2
 zNjg==
X-Gm-Message-State: AOJu0YyDXHrgCaEEA17gSZxT54VDiS8WAsQN1nE3fi8KMRP0g+mdkLpN
 qTpr5YgSCJlwcrmtbSdMVFgLwdhyFVCfoOasE3/Ui9hUQqH60KY11JeLqrRZtFOFp18w6XqqbAB
 TvuhypkKaGyOzcQdShgtqs2WhH7S4VVyvtm3ZNrC/hYXYPjEEluOoBZylNbLCDtKbBRPV71QRp3
 4JxTDRc+SuBDn1zK7iJfNVV2Q5NT6gvA==
X-Received: by 2002:a05:6512:110d:b0:52c:d8ce:c323 with SMTP id
 2adb3069b0e04-52e8268d891mr6638306e87.35.1719929488362; 
 Tue, 02 Jul 2024 07:11:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEINwpP7OSLBrzw4kz7cZjG5BfwRTxdHJOJtzkCPwoB9/B8SmPLU+cbtMRtoMscyVkRPv8Ow==
X-Received: by 2002:a05:6512:110d:b0:52c:d8ce:c323 with SMTP id
 2adb3069b0e04-52e8268d891mr6638249e87.35.1719929487528; 
 Tue, 02 Jul 2024 07:11:27 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09a828sm201949865e9.37.2024.07.02.07.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:11:27 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:11:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL 86/91] pcie_sriov: Ensure VF function number does not overflow
Message-ID: <fc309267e8bb103ac4bbc3cdf4eac7eebbe5ed7a.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

pci_new() aborts when creating a VF with a function number equals to or
is greater than PCI_DEVFN_MAX.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240627-reuse-v10-5-7ca0b8ed3d9f@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/pcie_sriov.txt         |  8 +++++---
 include/hw/pci/pcie_sriov.h |  5 +++--
 hw/net/igb.c                | 13 ++++++++++---
 hw/nvme/ctrl.c              | 24 ++++++++++++++++--------
 hw/pci/pcie_sriov.c         | 19 +++++++++++++++++--
 5 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/docs/pcie_sriov.txt b/docs/pcie_sriov.txt
index a47aad0bfa..ab2142807f 100644
--- a/docs/pcie_sriov.txt
+++ b/docs/pcie_sriov.txt
@@ -52,9 +52,11 @@ setting up a BAR for a VF.
       ...
 
       /* Add and initialize the SR/IOV capability */
-      pcie_sriov_pf_init(d, 0x200, "your_virtual_dev",
-                       vf_devid, initial_vfs, total_vfs,
-                       fun_offset, stride);
+      if (!pcie_sriov_pf_init(d, 0x200, "your_virtual_dev",
+                              vf_devid, initial_vfs, total_vfs,
+                              fun_offset, stride, errp)) {
+         return;
+      }
 
       /* Set up individual VF BARs (parameters as for normal BARs) */
       pcie_sriov_pf_init_vf_bar( ... )
diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index 450cbef6c2..aa704e8f9d 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -27,10 +27,11 @@ typedef struct PCIESriovVF {
     uint16_t vf_number; /* Logical VF number of this function */
 } PCIESriovVF;
 
-void pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
+bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
                         const char *vfname, uint16_t vf_dev_id,
                         uint16_t init_vfs, uint16_t total_vfs,
-                        uint16_t vf_offset, uint16_t vf_stride);
+                        uint16_t vf_offset, uint16_t vf_stride,
+                        Error **errp);
 void pcie_sriov_pf_exit(PCIDevice *dev);
 
 /* Set up a VF bar in the SR/IOV bar area */
diff --git a/hw/net/igb.c b/hw/net/igb.c
index b92bba402e..b6ca2f1b8a 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -446,9 +446,16 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
 
     pcie_ari_init(pci_dev, 0x150);
 
-    pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, TYPE_IGBVF,
-        IGB_82576_VF_DEV_ID, IGB_MAX_VF_FUNCTIONS, IGB_MAX_VF_FUNCTIONS,
-        IGB_VF_OFFSET, IGB_VF_STRIDE);
+    if (!pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET,
+                            TYPE_IGBVF, IGB_82576_VF_DEV_ID,
+                            IGB_MAX_VF_FUNCTIONS, IGB_MAX_VF_FUNCTIONS,
+                            IGB_VF_OFFSET, IGB_VF_STRIDE,
+                            errp)) {
+        pcie_cap_exit(pci_dev);
+        igb_cleanup_msix(s);
+        msi_uninit(pci_dev);
+        return;
+    }
 
     pcie_sriov_pf_init_vf_bar(pci_dev, IGBVF_MMIO_BAR_IDX,
         PCI_BASE_ADDRESS_MEM_TYPE_64 | PCI_BASE_ADDRESS_MEM_PREFETCH,
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 127c3d2383..066389e391 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8048,7 +8048,8 @@ out:
     return pow2ceil(bar_size);
 }
 
-static void nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset)
+static bool nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset,
+                            Error **errp)
 {
     uint16_t vf_dev_id = n->params.use_intel_id ?
                          PCI_DEVICE_ID_INTEL_NVME : PCI_DEVICE_ID_REDHAT_NVME;
@@ -8057,12 +8058,17 @@ static void nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset)
                                       le16_to_cpu(cap->vifrsm),
                                       NULL, NULL);
 
-    pcie_sriov_pf_init(pci_dev, offset, "nvme", vf_dev_id,
-                       n->params.sriov_max_vfs, n->params.sriov_max_vfs,
-                       NVME_VF_OFFSET, NVME_VF_STRIDE);
+    if (!pcie_sriov_pf_init(pci_dev, offset, "nvme", vf_dev_id,
+                            n->params.sriov_max_vfs, n->params.sriov_max_vfs,
+                            NVME_VF_OFFSET, NVME_VF_STRIDE,
+                            errp)) {
+        return false;
+    }
 
     pcie_sriov_pf_init_vf_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
                               PCI_BASE_ADDRESS_MEM_TYPE_64, bar_size);
+
+    return true;
 }
 
 static int nvme_add_pm_capability(PCIDevice *pci_dev, uint8_t offset)
@@ -8155,6 +8161,12 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
         return false;
     }
 
+    if (!pci_is_vf(pci_dev) && n->params.sriov_max_vfs &&
+        !nvme_init_sriov(n, pci_dev, 0x120, errp)) {
+        msix_uninit(pci_dev, &n->bar0, &n->bar0);
+        return false;
+    }
+
     nvme_update_msixcap_ts(pci_dev, n->conf_msix_qsize);
 
     if (n->params.cmb_size_mb) {
@@ -8165,10 +8177,6 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
         nvme_init_pmr(n, pci_dev);
     }
 
-    if (!pci_is_vf(pci_dev) && n->params.sriov_max_vfs) {
-        nvme_init_sriov(n, pci_dev, 0x120);
-    }
-
     return true;
 }
 
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 499becd527..f0bde0d3fc 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -24,14 +24,27 @@ static PCIDevice *register_vf(PCIDevice *pf, int devfn,
                               const char *name, uint16_t vf_num);
 static void unregister_vfs(PCIDevice *dev);
 
-void pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
+bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
                         const char *vfname, uint16_t vf_dev_id,
                         uint16_t init_vfs, uint16_t total_vfs,
-                        uint16_t vf_offset, uint16_t vf_stride)
+                        uint16_t vf_offset, uint16_t vf_stride,
+                        Error **errp)
 {
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
+    if (total_vfs) {
+        uint16_t ari_cap = pcie_find_capability(dev, PCI_EXT_CAP_ID_ARI);
+        uint16_t first_vf_devfn = dev->devfn + vf_offset;
+        uint16_t last_vf_devfn = first_vf_devfn + vf_stride * (total_vfs - 1);
+
+        if ((!ari_cap && PCI_SLOT(dev->devfn) != PCI_SLOT(last_vf_devfn)) ||
+            last_vf_devfn >= PCI_DEVFN_MAX) {
+            error_setg(errp, "VF function number overflows");
+            return false;
+        }
+    }
+
     pcie_add_capability(dev, PCI_EXT_CAP_ID_SRIOV, 1,
                         offset, PCI_EXT_CAP_SRIOV_SIZEOF);
     dev->exp.sriov_cap = offset;
@@ -69,6 +82,8 @@ void pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     pci_set_word(wmask + PCI_SRIOV_SYS_PGSIZE, 0x553);
 
     qdev_prop_set_bit(&dev->qdev, "multifunction", true);
+
+    return true;
 }
 
 void pcie_sriov_pf_exit(PCIDevice *dev)
-- 
MST


