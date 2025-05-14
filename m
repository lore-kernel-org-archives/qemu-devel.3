Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1711FC3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAds-0006Dx-Kq; Wed, 14 May 2025 07:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdj-00066w-60
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdd-0006FY-6s
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CyHusw9AnpZuF7E04bQzWNuAptqIyO52JzaZ4eBsnI8=;
 b=Z3J/02Ovf1doSZFudF2mZOJYjxggxnzfZNEAfBEXdfyLNVFACRD1I3O7Qwr007LBa0aD0R
 Kddufy5uoeM/Y26os797rWV/XCE+L7jUT6Oj2T5W26KXfV5N2nxC+Or7I6B22r5BUSYFGz
 0PmH1NOHKU9BrkJ1Ey4DOQ5s3NQhtk0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-FBmpcN-QOTSf64SSH4KNhA-1; Wed, 14 May 2025 07:50:59 -0400
X-MC-Unique: FBmpcN-QOTSf64SSH4KNhA-1
X-Mimecast-MFC-AGG-ID: FBmpcN-QOTSf64SSH4KNhA_1747223458
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d209dc2d3so33229155e9.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223457; x=1747828257;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CyHusw9AnpZuF7E04bQzWNuAptqIyO52JzaZ4eBsnI8=;
 b=RwOJBDdGIo0QF/GrhMUHQN9NgNhiLQM9y6t0r5OqMfcf58C8sZmPcSgewxB5hrmQkO
 s+TxUaDilEZ6ukagkoaYggUaCexZy4P8Lk8uPShtc2atpqrmnU31EjAt1bPmMwpKW/Rt
 GtJ9Xq5wAVa57d9JJ5PZC8k+9aa3KX87gVpnvhBH36ucOfs2my2QrJRCJnT7GGmngUHH
 0JZK0uL3lRB5oh6Ns6eC84pfJRuihFIVFAMTqpDAudmdEugMRkzmhqOyhPOb4UWkQ7iq
 S8wtMXESxkebngHkjHEI8c1ae0FunZLfrXZEKDtRLFxfS9ChkeafSNg70kqYuiJe3r43
 p6Dw==
X-Gm-Message-State: AOJu0YyQKBvLNm7UAIXrzScGG2ix0S305NkhDtmWdhQXZqApB4aLD8J7
 P8xX5hYScI7eT7UiQ2M/iz/i8kWv5q41+VHf8kf9e1Wy2NEof6L2YwQWcUXyZhtu8jj5BJz5xun
 qxFS71A7nOM7cF5+nLG00N0ElAROb2yst/dBWXPKtyJel2aYAtC2LEJgND63YMlUhCkldcGSd0H
 pNc/ziY0p//M38C7EULEELAtt8Kougrw==
X-Gm-Gg: ASbGncua7k/n8IP+jSlNQHcmEGGIq9kI7aoXb1PomArxOz4G11ONkFCdh1rndfNavhn
 Fo//ezUQkGgYjqQK66tGWBl4QBjwNTMEnZEWLssIvFFwcFbUInXkQaocKHMvyzzu5zTmwy6UpFr
 vS8WM3muiyA8K6b5FRoSR4778hvKgrhICOlnnf0n9Lf2zW7ocnXeZX4N9qhE7pmrRWSJXbp9EQ/
 G7ZkAr6dsL0GFoLUbNdnhQHv6Lp1YSBHEa2MxiFte10iD/2y3ECHJ+2nRQWuUdb9iV9OyrZYjVu
 9DC3lQ==
X-Received: by 2002:a05:600c:3c8c:b0:442:ccf9:e6f2 with SMTP id
 5b1f17b1804b1-442f210f732mr32145565e9.16.1747223457597; 
 Wed, 14 May 2025 04:50:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpiCCiX0V5P01m0JQc/+q1+SwvrKE6uWNXqF6ovzQX2rNTLKAy4fP48qbHCyi9G9XywEqQaA==
X-Received: by 2002:a05:600c:3c8c:b0:442:ccf9:e6f2 with SMTP id
 5b1f17b1804b1-442f210f732mr32145175e9.16.1747223457167; 
 Wed, 14 May 2025 04:50:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4c5e1sm19237061f8f.89.2025.05.14.04.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:50:56 -0700 (PDT)
Date: Wed, 14 May 2025 07:50:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Yui Washizu <yui.washidu@gmail.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 16/27] pcie_sriov: Make a PCI device with user-created VF
 ARI-capable
Message-ID: <d0c280d3fac644c26a86d2fb70c5920b3d5bef85.1747223385.git.mst@redhat.com>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250314-sriov-v9-9-57dae8ae3ab5@daynix.com>
Tested-by: Yui Washizu <yui.washidu@gmail.com>
Tested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pcie_sriov.h |  7 +++++--
 hw/pci/pcie_sriov.c         |  8 +++++++-
 hw/virtio/virtio-pci.c      | 16 ++++++++++------
 docs/system/sriov.rst       |  3 ++-
 4 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index f75b8f22ee..aeaa38cf34 100644
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
index 08f707e847..3ad18744f4 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -245,6 +245,7 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
     PCIDevice **vfs;
     BusState *bus = qdev_get_parent_bus(DEVICE(dev));
     uint16_t ven_id = pci_get_word(dev->config + PCI_VENDOR_ID);
+    uint16_t size = PCI_EXT_CAP_SRIOV_SIZEOF;
     uint16_t vf_dev_id;
     uint16_t vf_offset;
     uint16_t vf_stride;
@@ -311,6 +312,11 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
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
@@ -331,7 +337,7 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
         }
     }
 
-    return PCI_EXT_CAP_SRIOV_SIZEOF;
+    return size;
 }
 
 bool pcie_sriov_register_device(PCIDevice *dev, Error **errp)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index fee65d3645..9b48aa8c3e 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2111,12 +2111,16 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
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
 
diff --git a/docs/system/sriov.rst b/docs/system/sriov.rst
index a851a66a4b..d12178f3c3 100644
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
-- 
MST


