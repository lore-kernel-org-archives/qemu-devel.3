Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A15CCAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UGF-0005Yo-Jk; Sun, 05 Oct 2025 15:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UG0-00050I-2f
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:19:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFx-0006hg-Uk
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ghXDZ+n9Et0LsGtFaG9r3BwQQMqcSZpR9BTBqrZEGYw=;
 b=cTQOy6d8KEfX4Abufso4KpIgZ4nFV8XRjlNSGBSjRrg0D03LCBD5kUSfrTvzobQWVA80R/
 tAu+UPNSUk9W+7ELxWPO9A0B+0DdDx5Grns4ISHOF8Z0wp+Sb7X+ttFI2a2nJWJyIjOLb5
 mdw28dWM1bdH28kpPLjNu6aDYdpj5Ao=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-Q2GlvWCMMZyR__UzuSS6cw-1; Sun, 05 Oct 2025 15:18:51 -0400
X-MC-Unique: Q2GlvWCMMZyR__UzuSS6cw-1
X-Mimecast-MFC-AGG-ID: Q2GlvWCMMZyR__UzuSS6cw_1759691930
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3efe4fcc9ccso2224274f8f.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691930; x=1760296730;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ghXDZ+n9Et0LsGtFaG9r3BwQQMqcSZpR9BTBqrZEGYw=;
 b=VFA2p/MKaUgwJ3Yzsjh+obQnJqozRr4ZUVSWb4E1wKdPEGuVGJrG62JrLdkwSJeVaI
 RBwln48tCwbP2WiGCqLLbz8JbWIGhqSRgxJ+k4kw7QxLqGxFMkpPUmYggraYQyxHvDBN
 h1+WVqWfcV9XPBYsmuD7yDLCMurMumdwGFxW1Db54rEIYYMymHRoY5WaaL+01/cafKex
 LqRwrd2jv/NqksHzsDHRsF/lrnQiNscXCUu+/5D5f/PayHhXahR46bM9bq2TG1aSQigl
 Yb18tBZ4bnJWGt5J1d5TRZmVpjOJpZ4mtHWxY74EPJdBBwOZ4/uk+27tbMlcVuZEOfCe
 VUZg==
X-Gm-Message-State: AOJu0YyWkF4Q0wQJPMXvej68aZW2T8eID28aCmogyjYMtb11lEm47y5i
 mQtQ3evXzVEEx8vGxtAUaTdODCJsMBlrpM6sPUzdP8eSn8/pdFUetr80EqcgSxMT3TchibVhJEa
 fBd7XALgU922O4sVVzhHIqTO7biA1ykRyPSa9x4hdavpmR+c37sYbGiPpVmT7Rr0c+kPd9/Gwm1
 2VJGtshh/LGn19MktQpCEuCY8Ets05TBnZEw==
X-Gm-Gg: ASbGncscNUiMCj3uZ4XMi1GSA+bVQftOeIgMYoFZkw/5BHFeO29bj9y0bAJqzvCykqf
 Kw3GNMOj1oFIGU/8OPFKCGkPuX3lJET3/8yIXkasLJRce6IZyWHFq+2gtB5Kwn8iUp3gWgGXtP8
 SzGhm9B+4TR75Px6lhJDASfcuQp4h3C+AqMWVlYOuqR7vmZpdCU+dvS6p6rceF/oQDgzdPoyRWx
 PievtVIpGTk+AQMsxPRHXTqzmUx9Ck6oplZZp3e/yFxsSX37pn89iwsoHVX9amTLbpt/p2tDh/3
 BAWT7NJ/1CbY5aEHALDLwS17MqKmp3E8cRNUDsw=
X-Received: by 2002:a05:6000:18a6:b0:3ee:2ae2:3f34 with SMTP id
 ffacd0b85a97d-4256712a506mr6269172f8f.13.1759691929750; 
 Sun, 05 Oct 2025 12:18:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBzNbQKJDOIT8Dh77yaeD0wFsFKznaKetafHFSKQ6Qrke3lsZgPmvcg1aVxZ7xK+sGtvQ9tA==
X-Received: by 2002:a05:6000:18a6:b0:3ee:2ae2:3f34 with SMTP id
 ffacd0b85a97d-4256712a506mr6269155f8f.13.1759691929139; 
 Sun, 05 Oct 2025 12:18:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a0204fsm225317325e9.14.2025.10.05.12.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:18:48 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:18:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 75/75] pci: Fix wrong parameter passing to
 pci_device_get_iommu_bus_devfn()
Message-ID: <e27b177339ea4d391ed7538fbdbad34518937408.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

The 2nd parameter of pci_device_get_iommu_bus_devfn() about root PCIBus
backed by an IOMMU for the PCI device, the 3rd is about aliased PCIBus
of the PCI device.

Meanwhile the 3rd and 4th parameters are optional, pass NULL if they
are not needed.

Reviewed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250929034206.439266-4-zhenzhong.duan@intel.com>
Fixes: a849ff5d6f ("pci: Add a pci-level initialization function for IOMMU notifiers")
Fixes: f0f37daf8e ("pci: Add a PCI-level API for PRI")
Fixes: e9b457500a ("pci: Add a pci-level API for ATS")
Fixes: 042cbc9aec ("pci: Add an API to get IOMMU's min page size and virtual address width")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 4854d3d618..541e03b38c 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2964,7 +2964,7 @@ int pci_iommu_init_iotlb_notifier(PCIDevice *dev, IOMMUNotifier *n,
     PCIBus *iommu_bus;
     int devfn;
 
-    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
     if (iommu_bus && iommu_bus->iommu_ops->init_iotlb_notifier) {
         iommu_bus->iommu_ops->init_iotlb_notifier(bus, iommu_bus->iommu_opaque,
                                                   devfn, n, fn, opaque);
@@ -3022,7 +3022,7 @@ int pci_pri_request_page(PCIDevice *dev, uint32_t pasid, bool priv_req,
         return -EPERM;
     }
 
-    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
     if (iommu_bus && iommu_bus->iommu_ops->pri_request_page) {
         return iommu_bus->iommu_ops->pri_request_page(bus,
                                                      iommu_bus->iommu_opaque,
@@ -3046,7 +3046,7 @@ int pci_pri_register_notifier(PCIDevice *dev, uint32_t pasid,
         return -EPERM;
     }
 
-    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
     if (iommu_bus && iommu_bus->iommu_ops->pri_register_notifier) {
         iommu_bus->iommu_ops->pri_register_notifier(bus,
                                                     iommu_bus->iommu_opaque,
@@ -3063,7 +3063,7 @@ void pci_pri_unregister_notifier(PCIDevice *dev, uint32_t pasid)
     PCIBus *iommu_bus;
     int devfn;
 
-    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
     if (iommu_bus && iommu_bus->iommu_ops->pri_unregister_notifier) {
         iommu_bus->iommu_ops->pri_unregister_notifier(bus,
                                                       iommu_bus->iommu_opaque,
@@ -3095,7 +3095,7 @@ ssize_t pci_ats_request_translation(PCIDevice *dev, uint32_t pasid,
         return -EPERM;
     }
 
-    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
     if (iommu_bus && iommu_bus->iommu_ops->ats_request_translation) {
         return iommu_bus->iommu_ops->ats_request_translation(bus,
                                                      iommu_bus->iommu_opaque,
@@ -3119,7 +3119,7 @@ int pci_iommu_register_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
         return -EPERM;
     }
 
-    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
     if (iommu_bus && iommu_bus->iommu_ops->register_iotlb_notifier) {
         iommu_bus->iommu_ops->register_iotlb_notifier(bus,
                                            iommu_bus->iommu_opaque, devfn,
@@ -3141,7 +3141,7 @@ int pci_iommu_unregister_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
         return -EPERM;
     }
 
-    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
     if (iommu_bus && iommu_bus->iommu_ops->unregister_iotlb_notifier) {
         iommu_bus->iommu_ops->unregister_iotlb_notifier(bus,
                                                         iommu_bus->iommu_opaque,
@@ -3155,11 +3155,9 @@ int pci_iommu_unregister_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
 int pci_iommu_get_iotlb_info(PCIDevice *dev, uint8_t *addr_width,
                              uint32_t *min_page_size)
 {
-    PCIBus *bus;
     PCIBus *iommu_bus;
-    int devfn;
 
-    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, NULL, NULL);
     if (iommu_bus && iommu_bus->iommu_ops->get_iotlb_info) {
         iommu_bus->iommu_ops->get_iotlb_info(iommu_bus->iommu_opaque,
                                              addr_width, min_page_size);
-- 
MST


