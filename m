Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E88C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAdp-00069m-0W; Wed, 14 May 2025 07:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdd-0005yS-DI
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdS-0006CB-73
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J0C8HFVJ2DNJTeZFn2iX0dFCwIr6ly7cQ6TeLyNcp1w=;
 b=g0wCt2nFYiZS4C7fF6cXoiXarzaALBSw/F8kDx3Yhi6T5f47Qki8v5JB5SCj+ZjrP9sXEK
 IpzKTbucon8DyBjj8IuUwmYzrJtSNm9p1OBz7ZxwrVMD8CH6TPWRxBmXXtpSPF4QUNwRJC
 PjR/pmfWjnJarQatt4XNaWmiCdeTDSU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-syJ1e0rWMlqdW2qSEnmhuw-1; Wed, 14 May 2025 07:50:52 -0400
X-MC-Unique: syJ1e0rWMlqdW2qSEnmhuw-1
X-Mimecast-MFC-AGG-ID: syJ1e0rWMlqdW2qSEnmhuw_1747223451
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cfda30a3cso34303775e9.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223450; x=1747828250;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J0C8HFVJ2DNJTeZFn2iX0dFCwIr6ly7cQ6TeLyNcp1w=;
 b=pcYUN7x+ECU/egFMSv1JGPI0tTsGXa2zstRY2aoS9/a96SQ+K6cBnSvYITAEHNYV7Z
 puiXn9z2YxHXrzRiBzb0w53EmoLbvsEP46E9Bnz35ik5iNKq3nHjJhBILQJxSqNef1rg
 bPSDguEMFZ49RImctwDuyaAe4+QrVV6M1SC2OKLMPvoRfMrgsRz3/g1dQgYE8nYcQIfn
 vYRu6FjIIF76wu34BQSV2Z+9/8SPJPylOZk+cQV0LLLnzpBUarlgB/suSfqBRwptEK3F
 awuipGMCqa334q2XcLws2okt6nRkIj5bhjJ9WpkHxi6CKg+djZVVclh0l3kf4qYxjO0N
 CD8Q==
X-Gm-Message-State: AOJu0Ywyib4HzqdAug24009CGW44HUBzhq1pr0/PO7ySjc06uxeVmZ7j
 HotyaSyXFm/WpTYK46Ge7EwC6NgXhsNJ1nVwrk57CFLoO9iyoDrhH2wgbHhuUcafY74UfxmgvDO
 ONA4QBlEFsMQgw25jRFdhqhi/ipp0MlLoI9ov9JcBhwbrJ3/W8cgfZu91Wz5ADKk7dBsyd77c/R
 5lonlLJuUuk0WWIvH1xEJYzOYfQxTpbQ==
X-Gm-Gg: ASbGncvRRMXLsIRUiOo3XZwJ1NsKBQ0ORTDrV7ziUj90hurMd9VHWkQSz4WDfvxF8Ys
 HT/dtqZhb7YXMVStRTl+7X15zNGFEOePrjKKYYfwD37832BlrVK2HCduDixQpCua7K7Poi96jsh
 uhtfnXR3+Q9NdY9fL4bCsl1xH+pD+t/fWqCkhjh33hv/Nr1MhEM5cj0/MAMmkrN3vGSa2nrZumD
 kxcMdkw2p3biDdCqYo6/DeoGHOs4ZVtEsZpCeiz2KCZOYcfKvpPDvjUNCEizwRSzY6N4jDLBhOQ
 8fBPUg==
X-Received: by 2002:a05:6000:2401:b0:3a0:b784:883f with SMTP id
 ffacd0b85a97d-3a3496b8ab0mr2086020f8f.23.1747223450367; 
 Wed, 14 May 2025 04:50:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVheJh9Ge6MGKZLCBFHzmHjWYnnok4EJzgVkPf6YBhadDBr7Eyn2DiSFdDzF18VIOVyY1bLg==
X-Received: by 2002:a05:6000:2401:b0:3a0:b784:883f with SMTP id
 ffacd0b85a97d-3a3496b8ab0mr2086000f8f.23.1747223449969; 
 Wed, 14 May 2025 04:50:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f337db3bsm26059625e9.9.2025.05.14.04.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:50:49 -0700 (PDT)
Date: Wed, 14 May 2025 07:50:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Yui Washizu <yui.washidu@gmail.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: [PULL 13/27] virtio-pci: Implement SR-IOV PF
Message-ID: <3f9cfaa92c96d604e98f16ade5af4742460e4c0f.1747223385.git.mst@redhat.com>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

Allow user to attach SR-IOV VF to a virtio-pci PF.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250314-sriov-v9-6-57dae8ae3ab5@daynix.com>
Tested-by: Yui Washizu <yui.washidu@gmail.com>
Tested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-pci.h |  1 +
 hw/virtio/virtio-pci.c         | 20 +++++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 31ec144509..1dbc3851b0 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -155,6 +155,7 @@ struct VirtIOPCIProxy {
     uint32_t modern_io_bar_idx;
     uint32_t modern_mem_bar_idx;
     int config_cap;
+    uint16_t last_pcie_cap_offset;
     uint32_t flags;
     bool disable_modern;
     bool ignore_backend_features;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 0fa8fe4955..fee65d3645 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1962,6 +1962,7 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
     uint8_t *config;
     uint32_t size;
     VirtIODevice *vdev = virtio_bus_get_device(bus);
+    int16_t res;
 
     /*
      * Virtio capabilities present without
@@ -2109,6 +2110,14 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
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
@@ -2199,7 +2208,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
 
     if (pcie_port && pci_is_express(pci_dev)) {
         int pos;
-        uint16_t last_pcie_cap_offset = PCI_CONFIG_SPACE_SIZE;
+        proxy->last_pcie_cap_offset = PCI_CONFIG_SPACE_SIZE;
 
         pos = pcie_endpoint_cap_init(pci_dev, 0);
         assert(pos > 0);
@@ -2216,9 +2225,9 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
         pci_set_word(pci_dev->config + pos + PCI_PM_PMC, 0x3);
 
         if (proxy->flags & VIRTIO_PCI_FLAG_AER) {
-            pcie_aer_init(pci_dev, PCI_ERR_VER, last_pcie_cap_offset,
+            pcie_aer_init(pci_dev, PCI_ERR_VER, proxy->last_pcie_cap_offset,
                           PCI_ERR_SIZEOF, NULL);
-            last_pcie_cap_offset += PCI_ERR_SIZEOF;
+            proxy->last_pcie_cap_offset += PCI_ERR_SIZEOF;
         }
 
         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_DEVERR) {
@@ -2243,9 +2252,9 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
         }
 
         if (proxy->flags & VIRTIO_PCI_FLAG_ATS) {
-            pcie_ats_init(pci_dev, last_pcie_cap_offset,
+            pcie_ats_init(pci_dev, proxy->last_pcie_cap_offset,
                           proxy->flags & VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED);
-            last_pcie_cap_offset += PCI_EXT_CAP_ATS_SIZEOF;
+            proxy->last_pcie_cap_offset += PCI_EXT_CAP_ATS_SIZEOF;
         }
 
         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_FLR) {
@@ -2273,6 +2282,7 @@ static void virtio_pci_exit(PCIDevice *pci_dev)
                      !pci_bus_is_root(pci_get_bus(pci_dev));
     bool modern_pio = proxy->flags & VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY;
 
+    pcie_sriov_pf_exit(&proxy->pci_dev);
     msix_uninit_exclusive_bar(pci_dev);
     if (proxy->flags & VIRTIO_PCI_FLAG_AER && pcie_port &&
         pci_is_express(pci_dev)) {
-- 
MST


