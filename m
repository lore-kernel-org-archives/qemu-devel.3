Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881E2C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8o8-0005ZN-Qs; Wed, 03 Jul 2024 18:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8o4-0004xt-CO
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:50:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8o2-0007Xo-6z
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720047029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=30vtT+Bk+aBG/k9psr6e7+phVupnPVIwCqnHm1QF2rI=;
 b=ZbZ85pPvR/ilXUQCB8ktSoFgVBFN2omtIjiNPIPEVo/2zDfaoqJhaoeHFLFUbFX9U0yc6E
 HRT/fZAK3UGcwkCPoWDPspHYBi6lukRBhbdPoV2kY6Bj2nvEIYASUrKG98ksdlfm24Epg9
 Q58CkZUDkxKpKAxDHYYc1kD/t/loT3g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-nvh8kc6UMGWX5CBkDLpmDQ-1; Wed, 03 Jul 2024 18:50:28 -0400
X-MC-Unique: nvh8kc6UMGWX5CBkDLpmDQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36740a84ad8so51066f8f.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720047027; x=1720651827;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=30vtT+Bk+aBG/k9psr6e7+phVupnPVIwCqnHm1QF2rI=;
 b=v7ttbxXcrMNmRLIerifMUKHcxUU0ZZDaCyj54TyZ+m9hxpI5Rtk62B5v5FyR2gyiLy
 PmU7uWootBRKOC0TZsAlp1DzhZWbMBOaFaVtvv0Vd28ASEwU+w1/BK8N9Hb5cKtTtb40
 JxqBs15P8uW/ldqyGxMN0haVES6vgH+M4FQRLSC8ZSIV3mBbVmJm5iu3JEE2S2lVQTsy
 MmU0b8vIo1ummCj+/mGNopU2EmbFaAwW7nPgW/ylTG6VVrM78zgpPxlxYTq6MNDd1Pys
 cpiZMo2MTT4SmT9nEOFu/b1GxY4zT++dVuy4A1TxomjqmOAmJr0FJCfyER7ynkXn43ag
 mZIQ==
X-Gm-Message-State: AOJu0YyacO5uRK7slA56kxa+zSfsw+36VCr/wR33KgaeT7UwQPGB4rs/
 tgpQK2F+3kfps6Z/FpCSYXiDGxdRN2QyG1V9iNu+Ku9M4vypqi3MjtEnQQVIgxB9m3HvNRoWEI3
 8rVX7I/6JPKext9Hh7TkvT7fFk2JnbCIpU0+Dg8RoIknx/8uYZgPa21Y/JyBqvYOlAEpATdP/x2
 Uyc5lwhjkli2bKW9D07gjYv38PDKd83A==
X-Received: by 2002:a5d:55c5:0:b0:367:2d2f:e634 with SMTP id
 ffacd0b85a97d-3679dd66971mr5124f8f.55.1720047026919; 
 Wed, 03 Jul 2024 15:50:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf44Meb/FUzXp1aYvGqhquZJdCtebhyMNFNhxMMcEXtPSxBDnGrO8ppKWaEhcqXWND6Wk0LQ==
X-Received: by 2002:a5d:55c5:0:b0:367:2d2f:e634 with SMTP id
 ffacd0b85a97d-3679dd66971mr5101f8f.55.1720047026011; 
 Wed, 03 Jul 2024 15:50:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3679c12440asm292045f8f.73.2024.07.03.15.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:50:25 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:50:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL v3 80/85] pcie_sriov: Ensure VF function number does not
 overflow
Message-ID: <77718701157f6ca77ea7a57b536fa0a22f676082.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


