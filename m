Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB116C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDDt-0001DJ-SI; Tue, 23 Jul 2024 06:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDDr-0000k0-6p
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDDp-0002CY-Ij
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X3rdo+GHcXhDhgz/MwpIwvItnaY2iCPaS+aQJmkzF0Q=;
 b=E/fvjTz5ovr570QNuYYH95nQFVDXO5a4BexYas6Q/Vz9Bq0KBm35BjXYK9e9voJ7lX+7wa
 8d2cAccTkljlO5yASSeV1DAYw8wBx3EEFK+PVbMlST2qN7POMv3Z2CHzXiocWfXxSIb6TY
 qUCa0IJhe29ps8QKcFV3hrlg+iP2+Yo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-ei_kHM-hPs6V5w-dEgfoEw-1; Tue, 23 Jul 2024 06:58:18 -0400
X-MC-Unique: ei_kHM-hPs6V5w-dEgfoEw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a77cba34cd0so446987166b.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732297; x=1722337097;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X3rdo+GHcXhDhgz/MwpIwvItnaY2iCPaS+aQJmkzF0Q=;
 b=fnuPrdyqNYJkTp21homVSCt9TB3+b/PAbFwBSp1GKDpDdtXsDFVqnl1UUHd3ym1ql4
 Ds1lJr7/yMjExxDpNeUB4ABxq/ldbJsRdurqtc9AM479coXMNuC8NcZMD0sLOIFiLRVI
 OanJ2uJ/B7Dmc44ifdn8Aznpe6RYRVxzx3r8Nq0dXBr3Zc+Bl27GWyHxnqc+/m2R9wUx
 rrgnoFO0X+rFZdt0JDLvzmgRzN+ziCX22siodKvd0q4R+wMw4xgSG/ZQ6B5biQE+etyN
 5wBdtyQqsZlrwelIPhrVuxeIk8hDG0kqnXDLyJj5jUQEW9MrmLNKC/55bc+DWt3pGzaj
 YtDg==
X-Gm-Message-State: AOJu0YzwlCGEvnTfqPFC4AgAdVUujkz69Zr3rOLLW8z6dSrooOKBbc5O
 5dD73dZVbOp86TKgwZS1LrgQh7d7StPbyqEdxi6+iGSRHvV9JvQP2STyy3SvmlyLv4mMGkea/57
 mCS9Ts9kH1FrjUtRESUOHXCXy4h8bqJCXJHxDSxNFcP3asKAztoJ5TmyTyYaAwPK5cSlFlylCbQ
 lHMxoSHNXGP/gX9yxg+7FCp8UsIbJIRQ==
X-Received: by 2002:a17:907:9489:b0:a77:c548:6456 with SMTP id
 a640c23a62f3a-a7a4c424f3dmr634679966b.59.1721732296905; 
 Tue, 23 Jul 2024 03:58:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFweVQKmXHbqUATmnqFQoWBtqJw2FJ0qOg8J0UrhS0eGsBG778Vhh9bP9C6O6utBnt/rHPJlA==
X-Received: by 2002:a17:907:9489:b0:a77:c548:6456 with SMTP id
 a640c23a62f3a-a7a4c424f3dmr634676866b.59.1721732296136; 
 Tue, 23 Jul 2024 03:58:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a8a4de922sm93197466b.56.2024.07.23.03.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:58:15 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:58:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL v2 33/61] virtio-pci: Implement SR-IOV PF
Message-ID: <3f868ffb0bae0c4feafabe34a371cded57fe3806.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

Allow user to attach SR-IOV VF to a virtio-pci PF.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240715-sriov-v5-6-3f5539093ffc@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-pci.h |  1 +
 hw/virtio/virtio-pci.c         | 20 +++++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 9e67ba38c7..34539f2f67 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -152,6 +152,7 @@ struct VirtIOPCIProxy {
     uint32_t modern_io_bar_idx;
     uint32_t modern_mem_bar_idx;
     int config_cap;
+    uint16_t last_pcie_cap_offset;
     uint32_t flags;
     bool disable_modern;
     bool ignore_backend_features;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 9534730bba..0c8fcc5627 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1955,6 +1955,7 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
     uint8_t *config;
     uint32_t size;
     VirtIODevice *vdev = virtio_bus_get_device(bus);
+    int16_t res;
 
     /*
      * Virtio capabilities present without
@@ -2100,6 +2101,14 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
         pci_register_bar(&proxy->pci_dev, proxy->legacy_io_bar_idx,
                          PCI_BASE_ADDRESS_SPACE_IO, &proxy->bar);
     }
+
+    res = pcie_sriov_pf_init_from_user_created_vfs(&proxy->pci_dev,
+                                                   proxy->last_pcie_cap_offset,
+                                                   errp);
+    if (res > 0) {
+        proxy->last_pcie_cap_offset += res;
+        virtio_add_feature(&vdev->host_features, VIRTIO_F_SR_IOV);
+    }
 }
 
 static void virtio_pci_device_unplugged(DeviceState *d)
@@ -2187,7 +2196,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
 
     if (pcie_port && pci_is_express(pci_dev)) {
         int pos;
-        uint16_t last_pcie_cap_offset = PCI_CONFIG_SPACE_SIZE;
+        proxy->last_pcie_cap_offset = PCI_CONFIG_SPACE_SIZE;
 
         pos = pcie_endpoint_cap_init(pci_dev, 0);
         assert(pos > 0);
@@ -2207,9 +2216,9 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
         pci_set_word(pci_dev->config + pos + PCI_PM_PMC, 0x3);
 
         if (proxy->flags & VIRTIO_PCI_FLAG_AER) {
-            pcie_aer_init(pci_dev, PCI_ERR_VER, last_pcie_cap_offset,
+            pcie_aer_init(pci_dev, PCI_ERR_VER, proxy->last_pcie_cap_offset,
                           PCI_ERR_SIZEOF, NULL);
-            last_pcie_cap_offset += PCI_ERR_SIZEOF;
+            proxy->last_pcie_cap_offset += PCI_ERR_SIZEOF;
         }
 
         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_DEVERR) {
@@ -2234,9 +2243,9 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
         }
 
         if (proxy->flags & VIRTIO_PCI_FLAG_ATS) {
-            pcie_ats_init(pci_dev, last_pcie_cap_offset,
+            pcie_ats_init(pci_dev, proxy->last_pcie_cap_offset,
                           proxy->flags & VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED);
-            last_pcie_cap_offset += PCI_EXT_CAP_ATS_SIZEOF;
+            proxy->last_pcie_cap_offset += PCI_EXT_CAP_ATS_SIZEOF;
         }
 
         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_FLR) {
@@ -2263,6 +2272,7 @@ static void virtio_pci_exit(PCIDevice *pci_dev)
     bool pcie_port = pci_bus_is_express(pci_get_bus(pci_dev)) &&
                      !pci_bus_is_root(pci_get_bus(pci_dev));
 
+    pcie_sriov_pf_exit(&proxy->pci_dev);
     msix_uninit_exclusive_bar(pci_dev);
     if (proxy->flags & VIRTIO_PCI_FLAG_AER && pcie_port &&
         pci_is_express(pci_dev)) {
-- 
MST


