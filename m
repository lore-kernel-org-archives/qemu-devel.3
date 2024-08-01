Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F28C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZTBE-00007X-BH; Thu, 01 Aug 2024 06:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTB3-0007ds-7Q
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:36:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTAy-0001j6-5N
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722508611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n9nPduN4HntJk65ImfCAHcmgUilYqHVhP2ou2W3VzIM=;
 b=i9WuGSZrlaAiTgkcpVZrHCv2eZuZRQn6KG6r6yu4dQeexzpwvpp1MpIlQpQwGjqqhJwFA4
 fYs0Gvff6GtYhtp231+1HJFtiO9HKSVlZchrwqFeY8hm8iGmCkwHQCPBa09OaMUfFoF3jp
 OFZEPDdLuVtsAMa1I78yHi/E76cz+cg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-0A3HblJMMi-c85rdcLG2Yg-1; Thu, 01 Aug 2024 06:36:50 -0400
X-MC-Unique: 0A3HblJMMi-c85rdcLG2Yg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5af95f7d65bso4834308a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722508609; x=1723113409;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n9nPduN4HntJk65ImfCAHcmgUilYqHVhP2ou2W3VzIM=;
 b=mflfpY/QKR+kfO734L6HPmOPC3Sx9wm1YOeZITdP3N0FfHIYQAzOCo2/DBzQCQ9pfk
 rJDMMx82VjcWPHRucOi2sqjITzSbSD08+s92vQKCwJYb4/R3GgVT/BEYGeMN9Pxi2VEX
 H9n6MGJqkBqm2LeXiNphQPus0RegAxD9xsULSJ7nPhSFr2oY6FT/pyjUMIDdBxBO2XzF
 kSadXD3QS0P2VQL+Kr+aNZC2Ljnr0KvjZujmGhXqyMMXOpHVUjrWlyLA0N7lwGZE8bdI
 cgv0TNUydyZOcXvoLiRcysIXk1UOqHABORbd3Qzi6LMCZz2QwGEpobFtYzBEskFgoiyx
 95WQ==
X-Gm-Message-State: AOJu0Yx04q5llyoQ8cISURAneyOuHtsCHVQZA05cg01ZD7xx/uHezy4n
 8GFKF29eJ2H1/SuaB88PCuBmSJ7UvkNJ2wd27WExLREwShia/RzTpfVG+xEozMQsqaKcRqJYblf
 4eQS8zwpVkJzNlrmav9aMT78XQnlym6XlyCvoVTvLTQ+KCHvsCFzA78wRpBjzK2yIhdDNPT50fy
 mEsXyGS+RFBoLysHfcad90hBEFNplJuQ==
X-Received: by 2002:a05:6402:7c8:b0:5a3:b866:eae0 with SMTP id
 4fb4d7f45d1cf-5b700b99e95mr1249131a12.32.1722508608732; 
 Thu, 01 Aug 2024 03:36:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMbTARhiIyBpbWxXZgxeMVo/HhSZC1ys6S0y7QvAfYVsVWe2TsvHr3PHrK5lVW6bmm6ym8sQ==
X-Received: by 2002:a05:6402:7c8:b0:5a3:b866:eae0 with SMTP id
 4fb4d7f45d1cf-5b700b99e95mr1249098a12.32.1722508608071; 
 Thu, 01 Aug 2024 03:36:48 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac65783621sm10107893a12.89.2024.08.01.03.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:36:46 -0700 (PDT)
Date: Thu, 1 Aug 2024 06:36:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL 13/19] Revert "pcie_sriov: Ensure VF function number does not
 overflow"
Message-ID: <19c45c00dc6a52f80f27dabbd28de1b770c16a89.1722508478.git.mst@redhat.com>
References: <cover.1722508478.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722508478.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This reverts commit 77718701157f6ca77ea7a57b536fa0a22f676082.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/pcie_sriov.txt         |  8 +++-----
 include/hw/pci/pcie_sriov.h |  5 ++---
 hw/net/igb.c                | 13 +++----------
 hw/nvme/ctrl.c              | 24 ++++++++----------------
 hw/pci/pcie_sriov.c         | 19 ++-----------------
 5 files changed, 18 insertions(+), 51 deletions(-)

diff --git a/docs/pcie_sriov.txt b/docs/pcie_sriov.txt
index ab2142807f..a47aad0bfa 100644
--- a/docs/pcie_sriov.txt
+++ b/docs/pcie_sriov.txt
@@ -52,11 +52,9 @@ setting up a BAR for a VF.
       ...
 
       /* Add and initialize the SR/IOV capability */
-      if (!pcie_sriov_pf_init(d, 0x200, "your_virtual_dev",
-                              vf_devid, initial_vfs, total_vfs,
-                              fun_offset, stride, errp)) {
-         return;
-      }
+      pcie_sriov_pf_init(d, 0x200, "your_virtual_dev",
+                       vf_devid, initial_vfs, total_vfs,
+                       fun_offset, stride);
 
       /* Set up individual VF BARs (parameters as for normal BARs) */
       pcie_sriov_pf_init_vf_bar( ... )
diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index aa704e8f9d..450cbef6c2 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -27,11 +27,10 @@ typedef struct PCIESriovVF {
     uint16_t vf_number; /* Logical VF number of this function */
 } PCIESriovVF;
 
-bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
+void pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
                         const char *vfname, uint16_t vf_dev_id,
                         uint16_t init_vfs, uint16_t total_vfs,
-                        uint16_t vf_offset, uint16_t vf_stride,
-                        Error **errp);
+                        uint16_t vf_offset, uint16_t vf_stride);
 void pcie_sriov_pf_exit(PCIDevice *dev);
 
 /* Set up a VF bar in the SR/IOV bar area */
diff --git a/hw/net/igb.c b/hw/net/igb.c
index b6ca2f1b8a..b92bba402e 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -446,16 +446,9 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
 
     pcie_ari_init(pci_dev, 0x150);
 
-    if (!pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET,
-                            TYPE_IGBVF, IGB_82576_VF_DEV_ID,
-                            IGB_MAX_VF_FUNCTIONS, IGB_MAX_VF_FUNCTIONS,
-                            IGB_VF_OFFSET, IGB_VF_STRIDE,
-                            errp)) {
-        pcie_cap_exit(pci_dev);
-        igb_cleanup_msix(s);
-        msi_uninit(pci_dev);
-        return;
-    }
+    pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, TYPE_IGBVF,
+        IGB_82576_VF_DEV_ID, IGB_MAX_VF_FUNCTIONS, IGB_MAX_VF_FUNCTIONS,
+        IGB_VF_OFFSET, IGB_VF_STRIDE);
 
     pcie_sriov_pf_init_vf_bar(pci_dev, IGBVF_MMIO_BAR_IDX,
         PCI_BASE_ADDRESS_MEM_TYPE_64 | PCI_BASE_ADDRESS_MEM_PREFETCH,
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index e86ea2e7ce..c6d4f61a47 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8271,8 +8271,7 @@ out:
     return pow2ceil(bar_size);
 }
 
-static bool nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset,
-                            Error **errp)
+static void nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset)
 {
     uint16_t vf_dev_id = n->params.use_intel_id ?
                          PCI_DEVICE_ID_INTEL_NVME : PCI_DEVICE_ID_REDHAT_NVME;
@@ -8281,17 +8280,12 @@ static bool nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset,
                                       le16_to_cpu(cap->vifrsm),
                                       NULL, NULL);
 
-    if (!pcie_sriov_pf_init(pci_dev, offset, "nvme", vf_dev_id,
-                            n->params.sriov_max_vfs, n->params.sriov_max_vfs,
-                            NVME_VF_OFFSET, NVME_VF_STRIDE,
-                            errp)) {
-        return false;
-    }
+    pcie_sriov_pf_init(pci_dev, offset, "nvme", vf_dev_id,
+                       n->params.sriov_max_vfs, n->params.sriov_max_vfs,
+                       NVME_VF_OFFSET, NVME_VF_STRIDE);
 
     pcie_sriov_pf_init_vf_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
                               PCI_BASE_ADDRESS_MEM_TYPE_64, bar_size);
-
-    return true;
 }
 
 static int nvme_add_pm_capability(PCIDevice *pci_dev, uint8_t offset)
@@ -8416,12 +8410,6 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
         return false;
     }
 
-    if (!pci_is_vf(pci_dev) && n->params.sriov_max_vfs &&
-        !nvme_init_sriov(n, pci_dev, 0x120, errp)) {
-        msix_uninit(pci_dev, &n->bar0, &n->bar0);
-        return false;
-    }
-
     nvme_update_msixcap_ts(pci_dev, n->conf_msix_qsize);
 
     pcie_cap_deverr_init(pci_dev);
@@ -8451,6 +8439,10 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
         nvme_init_pmr(n, pci_dev);
     }
 
+    if (!pci_is_vf(pci_dev) && n->params.sriov_max_vfs) {
+        nvme_init_sriov(n, pci_dev, 0x120);
+    }
+
     return true;
 }
 
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index f0bde0d3fc..499becd527 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -24,27 +24,14 @@ static PCIDevice *register_vf(PCIDevice *pf, int devfn,
                               const char *name, uint16_t vf_num);
 static void unregister_vfs(PCIDevice *dev);
 
-bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
+void pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
                         const char *vfname, uint16_t vf_dev_id,
                         uint16_t init_vfs, uint16_t total_vfs,
-                        uint16_t vf_offset, uint16_t vf_stride,
-                        Error **errp)
+                        uint16_t vf_offset, uint16_t vf_stride)
 {
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
-    if (total_vfs) {
-        uint16_t ari_cap = pcie_find_capability(dev, PCI_EXT_CAP_ID_ARI);
-        uint16_t first_vf_devfn = dev->devfn + vf_offset;
-        uint16_t last_vf_devfn = first_vf_devfn + vf_stride * (total_vfs - 1);
-
-        if ((!ari_cap && PCI_SLOT(dev->devfn) != PCI_SLOT(last_vf_devfn)) ||
-            last_vf_devfn >= PCI_DEVFN_MAX) {
-            error_setg(errp, "VF function number overflows");
-            return false;
-        }
-    }
-
     pcie_add_capability(dev, PCI_EXT_CAP_ID_SRIOV, 1,
                         offset, PCI_EXT_CAP_SRIOV_SIZEOF);
     dev->exp.sriov_cap = offset;
@@ -82,8 +69,6 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     pci_set_word(wmask + PCI_SRIOV_SYS_PGSIZE, 0x553);
 
     qdev_prop_set_bit(&dev->qdev, "multifunction", true);
-
-    return true;
 }
 
 void pcie_sriov_pf_exit(PCIDevice *dev)
-- 
MST


