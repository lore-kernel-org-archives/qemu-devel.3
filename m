Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE5EC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZTAE-0002fq-6i; Thu, 01 Aug 2024 06:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTAC-0002ZS-1g
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:36:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTAA-0001WS-Ec
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722508561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mFbHQq6SisPQs7stJ6AXdD+sXFUtuivITCao3XMdKA4=;
 b=BnmEwp0OASg8PsYZEV+DgsPJd55kQTMcLc/xg95K7s03RoqBI3szrLN090eeVHlRCyE8el
 pfCpV/7ZKBoIo7hF2URDVlNCY9NUXbXnjq1eQyuRBsm+gPn8AqR81jhEEuFwhUFSXEabZa
 rD+Fe5968ccYEy4FlC8wWI+h/9+PPGE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-4fG3yTihOnOg9p37FjoZcA-1; Thu, 01 Aug 2024 06:36:00 -0400
X-MC-Unique: 4fG3yTihOnOg9p37FjoZcA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a7aaef3fdafso281792766b.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722508559; x=1723113359;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mFbHQq6SisPQs7stJ6AXdD+sXFUtuivITCao3XMdKA4=;
 b=dsgPHkvNwd1ZW5xGqsHMch326eN92HXcZJQwaWo8nE48d1qDjQPJObl4TOpuu9Fxw8
 BTz67PuXQFblzHRwU8+HRCRaOQkmCUABKIU+9mrcYfUcgtNCG0paNFihhV91GjgYLCuj
 Nnk3WQBCUSO7BTWsFhyJBCexecBsFvrF3iJTBISS1gD01Z06c8EHmPHy2e9ItIMb0kd0
 wTbogzRuEYWdKGFYgcGqCfS8eu8FEYeEnttSz7CheUBu84vxFTMsWlZO+PVF1Amt+b+6
 XNxgXRAVu9UMLiG6OnE4Q4Jcx5YwvGgiTKrOet9VsG/LTw4GXPcNl/cTFuV99SOy5YGf
 EXZw==
X-Gm-Message-State: AOJu0YwdsUdA0KDFeIH5eU7sguOEFfpsCet0XR5k1rFcKalMNFgu1Tuy
 jufi5VX/d8P1L0+laWtJHMW0D0I2GPaEE6Mw3F0NtmV8v2BCayMOGOLBEnjmrhr3RX+oInPHcBK
 PU7JE/GWh133v9/4MmHOdtDM2lnUDRjY4yUdAYkc5t/EQotumFDLT2E2HVnS0NPeg/vZWB0j8Jk
 kNruTX9c7uP9kRUEtmeIpqqs2CELxc+g==
X-Received: by 2002:a17:907:9485:b0:a7a:a33e:47bf with SMTP id
 a640c23a62f3a-a7dbcc28485mr78359566b.18.1722508559102; 
 Thu, 01 Aug 2024 03:35:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmq2/HSG6iZdmchZo95arLespmapTu+/31xMC2P0Iou3ASi6AAY7f5dM2fN23DAAFiJ+Fphg==
X-Received: by 2002:a17:907:9485:b0:a7a:a33e:47bf with SMTP id
 a640c23a62f3a-a7dbcc28485mr78357666b.18.1722508558307; 
 Thu, 01 Aug 2024 03:35:58 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acada27ddsm873539966b.184.2024.08.01.03.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:35:54 -0700 (PDT)
Date: Thu, 1 Aug 2024 06:35:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 04/19] Revert "virtio-pci: Implement SR-IOV PF"
Message-ID: <67f5b279fc72e43ccdee20a1a1e54cb51e24f06a.1722508478.git.mst@redhat.com>
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

This reverts commit 3f868ffb0bae0c4feafabe34a371cded57fe3806.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-pci.h |  1 -
 hw/virtio/virtio-pci.c         | 20 +++++---------------
 2 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 34539f2f67..9e67ba38c7 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -152,7 +152,6 @@ struct VirtIOPCIProxy {
     uint32_t modern_io_bar_idx;
     uint32_t modern_mem_bar_idx;
     int config_cap;
-    uint16_t last_pcie_cap_offset;
     uint32_t flags;
     bool disable_modern;
     bool ignore_backend_features;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 0c8fcc5627..9534730bba 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1955,7 +1955,6 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
     uint8_t *config;
     uint32_t size;
     VirtIODevice *vdev = virtio_bus_get_device(bus);
-    int16_t res;
 
     /*
      * Virtio capabilities present without
@@ -2101,14 +2100,6 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
         pci_register_bar(&proxy->pci_dev, proxy->legacy_io_bar_idx,
                          PCI_BASE_ADDRESS_SPACE_IO, &proxy->bar);
     }
-
-    res = pcie_sriov_pf_init_from_user_created_vfs(&proxy->pci_dev,
-                                                   proxy->last_pcie_cap_offset,
-                                                   errp);
-    if (res > 0) {
-        proxy->last_pcie_cap_offset += res;
-        virtio_add_feature(&vdev->host_features, VIRTIO_F_SR_IOV);
-    }
 }
 
 static void virtio_pci_device_unplugged(DeviceState *d)
@@ -2196,7 +2187,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
 
     if (pcie_port && pci_is_express(pci_dev)) {
         int pos;
-        proxy->last_pcie_cap_offset = PCI_CONFIG_SPACE_SIZE;
+        uint16_t last_pcie_cap_offset = PCI_CONFIG_SPACE_SIZE;
 
         pos = pcie_endpoint_cap_init(pci_dev, 0);
         assert(pos > 0);
@@ -2216,9 +2207,9 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
         pci_set_word(pci_dev->config + pos + PCI_PM_PMC, 0x3);
 
         if (proxy->flags & VIRTIO_PCI_FLAG_AER) {
-            pcie_aer_init(pci_dev, PCI_ERR_VER, proxy->last_pcie_cap_offset,
+            pcie_aer_init(pci_dev, PCI_ERR_VER, last_pcie_cap_offset,
                           PCI_ERR_SIZEOF, NULL);
-            proxy->last_pcie_cap_offset += PCI_ERR_SIZEOF;
+            last_pcie_cap_offset += PCI_ERR_SIZEOF;
         }
 
         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_DEVERR) {
@@ -2243,9 +2234,9 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
         }
 
         if (proxy->flags & VIRTIO_PCI_FLAG_ATS) {
-            pcie_ats_init(pci_dev, proxy->last_pcie_cap_offset,
+            pcie_ats_init(pci_dev, last_pcie_cap_offset,
                           proxy->flags & VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED);
-            proxy->last_pcie_cap_offset += PCI_EXT_CAP_ATS_SIZEOF;
+            last_pcie_cap_offset += PCI_EXT_CAP_ATS_SIZEOF;
         }
 
         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_FLR) {
@@ -2272,7 +2263,6 @@ static void virtio_pci_exit(PCIDevice *pci_dev)
     bool pcie_port = pci_bus_is_express(pci_get_bus(pci_dev)) &&
                      !pci_bus_is_root(pci_get_bus(pci_dev));
 
-    pcie_sriov_pf_exit(&proxy->pci_dev);
     msix_uninit_exclusive_bar(pci_dev);
     if (proxy->flags & VIRTIO_PCI_FLAG_AER && pcie_port &&
         pci_is_express(pci_dev)) {
-- 
MST


