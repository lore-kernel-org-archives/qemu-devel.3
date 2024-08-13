Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22A4C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 06:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdlAQ-0000Jk-AW; Tue, 13 Aug 2024 02:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdlAO-0000CL-W9
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:38:01 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdlAH-0006VS-Pd
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:38:00 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3db1e4219f8so2902319b6e.3
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 23:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723531072; x=1724135872;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XP4TPVtZh3pRSWD5lDzkymaK3OFz5YOgTXNbBmvp+To=;
 b=SquWLOAVdVSVDtPjCXwE3Nfry/UpqOjGe4ZUvGICQIT1DAAlEpoWN89WQv2fN2f9pK
 pnUU/bkN9X4rFhpIga7VlhBNAcWMyUGOProoNrMt9M7Lt7YlRLPEoQbmqZF1rW/W6mxC
 CT1b0Ao+cw6xldqn1zQaUinPc9MNU2PQ+OX++zeAyupV0sF9Oqtv4uRsxZ53+3jhjS7D
 xTByDa9A3OnOxGP0TrVBlftrh2Zi4ZafnY6PkrugUlebBAd3AEUXmjaM40hK5wAtYa+Y
 PX55RXSYKNdOOurnBtfgrsHoZZ5p5UOFdwACLqLORcyo8ew4iSMTVRsgZhX9AKGFFz8W
 wfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723531072; x=1724135872;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XP4TPVtZh3pRSWD5lDzkymaK3OFz5YOgTXNbBmvp+To=;
 b=Hz89pOLsHjhK0nHO5chW8q+5saZZ5xumWf5SzqGBy+kSL02JYiVu67tT729uH72Rqy
 ozNY7H7wAv1Tk8HeC40UbF5dbRifIHxl3Dv+NpIcsf0mrPu79YRnd9uDcyQ6fEaGkKQ0
 Hs7q57HyBMFw457O7/aYNpGz7Bwk7lzXPjMVOIVvu5k7Q7GsKKbM4r/QEqi2bP8PnTDD
 pODp/kZTn9YYuMHHaPNweGp9nGWCz4REPTGJZyhuvUatFIACN+pjvQnohdE4bIeQhu/b
 ZIe4nPdMjWDQP1Lj7AckGs112AkrHs0bd6uBL/HQeoCJzrl3CJFs4QgJPUjZzT56644G
 YD2g==
X-Gm-Message-State: AOJu0YwHz6VzPz4k+Mj5zKd82vQH8lTRadvsQWGS0e9OYeK7/gMydp0t
 e22UG/fn4fqiiuQrUnecTbTL45RHsA4Cr1cK6b9tQuelmPcRyZr6BMjYIJ6NmZA=
X-Google-Smtp-Source: AGHT+IF1UakvDc9WUU1KqM1Htx5gUWRlW5rOFVbF3rQspx02BvyWdKP4qDhCh4KJruxWiSebBTF2LQ==
X-Received: by 2002:a05:6808:398e:b0:3dc:1b09:55c9 with SMTP id
 5614622812f47-3dd1ee32eaamr3551684b6e.12.1723531071891; 
 Mon, 12 Aug 2024 23:37:51 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-710e58ca645sm5141237b3a.94.2024.08.12.23.37.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 23:37:51 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 13 Aug 2024 15:37:08 +0900
Subject: [PATCH for-9.2 v7 9/9] pcie_sriov: Make a PCI device with
 user-created VF ARI-capable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-sriov-v7-9-8515e3774df7@daynix.com>
References: <20240813-sriov-v7-0-8515e3774df7@daynix.com>
In-Reply-To: <20240813-sriov-v7-0-8515e3774df7@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::22d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/system/sriov.rst       |  3 ++-
 include/hw/pci/pcie_sriov.h |  7 +++++--
 hw/pci/pcie_sriov.c         |  8 +++++++-
 hw/virtio/virtio-pci.c      | 16 ++++++++++------
 4 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/docs/system/sriov.rst b/docs/system/sriov.rst
index a851a66a4b8b..d12178f3c319 100644
--- a/docs/system/sriov.rst
+++ b/docs/system/sriov.rst
@@ -28,7 +28,8 @@ virtio-net-pci functions to a bus. Below is a command line example:
 The VFs specify the paired PF with ``sriov-pf`` property. The PF must be
 added after all VFs. It is the user's responsibility to ensure that VFs have
 function numbers larger than one of the PF, and that the function numbers
-have a consistent stride.
+have a consistent stride. Both the PF and VFs are ARI-capable so you can have
+255 VFs at maximum.
 
 You may also need to perform additional steps to activate the SR-IOV feature on
 your guest. For Linux, refer to [1]_.
diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index f75b8f22ee92..aeaa38cf3456 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -43,12 +43,15 @@ void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
 
 /**
  * pcie_sriov_pf_init_from_user_created_vfs() - Initialize PF with user-created
- *                                              VFs.
+ *                                              VFs, adding ARI to PF
  * @dev: A PCIe device being realized.
  * @offset: The offset of the SR-IOV capability.
  * @errp: pointer to Error*, to store an error if it happens.
  *
- * Return: The size of added capability. 0 if the user did not create VFs.
+ * Initializes a PF with user-created VFs, adding the ARI extended capability to
+ * the PF. The VFs should call pcie_ari_init() to form an ARI device.
+ *
+ * Return: The size of added capabilities. 0 if the user did not create VFs.
  *         -1 if failed.
  */
 int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index f5b83a92a00c..94ab92d8c80d 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -238,6 +238,7 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
     PCIDevice **vfs;
     BusState *bus = qdev_get_parent_bus(DEVICE(dev));
     uint16_t ven_id = pci_get_word(dev->config + PCI_VENDOR_ID);
+    uint16_t size = PCI_EXT_CAP_SRIOV_SIZEOF;
     uint16_t vf_dev_id;
     uint16_t vf_offset;
     uint16_t vf_stride;
@@ -304,6 +305,11 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
         return -1;
     }
 
+    if (!pcie_find_capability(dev, PCI_EXT_CAP_ID_ARI)) {
+        pcie_ari_init(dev, offset + size);
+        size += PCI_ARI_SIZEOF;
+    }
+
     for (i = 0; i < pf->len; i++) {
         vfs[i]->exp.sriov_vf.pf = dev;
         vfs[i]->exp.sriov_vf.vf_number = i;
@@ -324,7 +330,7 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
         }
     }
 
-    return PCI_EXT_CAP_SRIOV_SIZEOF;
+    return size;
 }
 
 bool pcie_sriov_register_device(PCIDevice *dev, Error **errp)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 0c8fcc5627d5..b19e2983ee22 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2102,12 +2102,16 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
                          PCI_BASE_ADDRESS_SPACE_IO, &proxy->bar);
     }
 
-    res = pcie_sriov_pf_init_from_user_created_vfs(&proxy->pci_dev,
-                                                   proxy->last_pcie_cap_offset,
-                                                   errp);
-    if (res > 0) {
-        proxy->last_pcie_cap_offset += res;
-        virtio_add_feature(&vdev->host_features, VIRTIO_F_SR_IOV);
+    if (pci_is_vf(&proxy->pci_dev)) {
+        pcie_ari_init(&proxy->pci_dev, proxy->last_pcie_cap_offset);
+        proxy->last_pcie_cap_offset += PCI_ARI_SIZEOF;
+    } else {
+        res = pcie_sriov_pf_init_from_user_created_vfs(
+            &proxy->pci_dev, proxy->last_pcie_cap_offset, errp);
+        if (res > 0) {
+            proxy->last_pcie_cap_offset += res;
+            virtio_add_feature(&vdev->host_features, VIRTIO_F_SR_IOV);
+        }
     }
 }
 

-- 
2.46.0


