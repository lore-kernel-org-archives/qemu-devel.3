Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F2EC54FB3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkYx-00024t-D1; Sun, 01 Jun 2025 11:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYm-0001y8-Kc
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYj-0004b6-GZ
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wHQQCAnK0yg5PoT18e6XbDRnMAD0iEsb4QQNqN7pqwI=;
 b=NHOM2rwPAQyAIuU9ZEdnEfRUy9qrL5Fg0Ufgx0eATQspYiSd7aCEeG1gctBU+WtFcYh8aY
 M0V9ISzD2joXw/yl27U40ad+K0ce2j0wvy3thsioGNMjG5oSw1lbdSEX2Q9lJCJA+eMeI0
 UI90CHd5Ziklgainigiz05X2y1QMM7Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-y6HyuIKPOX6eRMeg4RB74w-1; Sun, 01 Jun 2025 11:25:11 -0400
X-MC-Unique: y6HyuIKPOX6eRMeg4RB74w-1
X-Mimecast-MFC-AGG-ID: y6HyuIKPOX6eRMeg4RB74w_1748791510
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-440667e7f92so24462885e9.3
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791509; x=1749396309;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wHQQCAnK0yg5PoT18e6XbDRnMAD0iEsb4QQNqN7pqwI=;
 b=CmfqJluAGjbVYNSm2HhK2AZ4Q5GFq59uL81jZvjZjV1sS4MKHKuRuVsPXRGc1qRjur
 GJVs0gZv+KxR188B6aMD5bjxkLogLqkLxhe9RXzYHH/LkXRopu/tQSVrWFlQspL0k5bI
 I9a4ZEZrddNV7DPucr6CmpuheR/0QlFIgmd29XZISNOQluz+HDreMO4cm5ARUq9UYAnD
 1e01U4pVPKHjMKBaoBPJGxdbtBWEelTY2/xjhxZlQ1Bspkt3rJ6HgmCiculQ9c/iiSeu
 obTeyTC7V+A5zM0KX8wnMy6AflySGKikhq5c4fgjTAtQkB42NtNK6zpJN/kzHwMtSrFI
 EK2Q==
X-Gm-Message-State: AOJu0YyxtofhdveOJjUkKTpb1zKdDKOuNL1NkuUa/8RIfMbDT55fW4qR
 fmPnxq9wm/SSPVKyTvQrXbY77kFPpCbuJHsX1JDWQetGrO80rbH8GPp08ug+7GvODEtFjnV3TfN
 hHs4NkCdgc1lGHgc4MYc7vnlRKXvgD8LvW3nLZZCaryir8AASjKXi2Vrf+Fiw6H4IGO9RNFgifC
 ff4WwSgpiGLq0tmOCXlfkJTPQ1XMiuj7y2Hg==
X-Gm-Gg: ASbGncuQ64P6cT5KN/RYO89pSxODXoWwQOl9KiDshgZJSDupARvJlkspx3kgu4DdAEj
 Z85q0+WGTFkMzzlwUqbXLt2Q4gK0JejHYDfnubXxIMPdGIgEWlfCxIeE8AM0nUBBdaQ7yZ3aIqL
 Ek70vnTfs2l+y2fLOaPPu71nVp5geQJ+Galagh6gHNWXM91Nvy6vfwyrSWvQxhUFFH7WedR4t16
 kn7TbWv+2Xa95tYCtIUkf5LLnYkjVuf9Hjt72G2DxrpKWY3TY7Qp0Of8838OrSO8UTUF7FlCno8
 WE8fEw==
X-Received: by 2002:a05:600c:5007:b0:442:f4d4:522 with SMTP id
 5b1f17b1804b1-4511ecbaa8dmr41654465e9.5.1748791509536; 
 Sun, 01 Jun 2025 08:25:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSitZJG8mEpqAbldandhlkLpNzIX0v25LDDbgKUce+cPRuwN0lDVkVQn2as6jqCqAJ1c/vSg==
X-Received: by 2002:a05:600c:5007:b0:442:f4d4:522 with SMTP id
 5b1f17b1804b1-4511ecbaa8dmr41654255e9.5.1748791509051; 
 Sun, 01 Jun 2025 08:25:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fa2278sm89609925e9.12.2025.06.01.08.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:25:07 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:25:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 09/31] pci: Cache the bus mastering status in the device
Message-ID: <8ff9e1def0ef3388333b6cc639c9f958f97ebe05.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

The cached is_master value is necessary to know if a device is
allowed to issue ATS/PRI requests or not as these operations do not go
through the master_enable memory region.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-Id: <20250520071823.764266-7-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci_device.h |  1 +
 hw/pci/pci.c                | 23 +++++++++++++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index e41d95b0b0..eee0338568 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -90,6 +90,7 @@ struct PCIDevice {
     char name[64];
     PCIIORegion io_regions[PCI_NUM_REGIONS];
     AddressSpace bus_master_as;
+    bool is_master;
     MemoryRegion bus_master_container_region;
     MemoryRegion bus_master_enable_region;
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index f5ab510697..1114ba8529 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -128,6 +128,12 @@ static GSequence *pci_acpi_index_list(void)
     return used_acpi_index_list;
 }
 
+static void pci_set_master(PCIDevice *d, bool enable)
+{
+    memory_region_set_enabled(&d->bus_master_enable_region, enable);
+    d->is_master = enable; /* cache the status */
+}
+
 static void pci_init_bus_master(PCIDevice *pci_dev)
 {
     AddressSpace *dma_as = pci_device_iommu_address_space(pci_dev);
@@ -135,7 +141,7 @@ static void pci_init_bus_master(PCIDevice *pci_dev)
     memory_region_init_alias(&pci_dev->bus_master_enable_region,
                              OBJECT(pci_dev), "bus master",
                              dma_as->root, 0, memory_region_size(dma_as->root));
-    memory_region_set_enabled(&pci_dev->bus_master_enable_region, false);
+    pci_set_master(pci_dev, false);
     memory_region_add_subregion(&pci_dev->bus_master_container_region, 0,
                                 &pci_dev->bus_master_enable_region);
 }
@@ -804,9 +810,8 @@ static int get_pci_config_device(QEMUFile *f, void *pv, size_t size,
         pci_bridge_update_mappings(PCI_BRIDGE(s));
     }
 
-    memory_region_set_enabled(&s->bus_master_enable_region,
-                              pci_get_word(s->config + PCI_COMMAND)
-                              & PCI_COMMAND_MASTER);
+    pci_set_master(s, pci_get_word(s->config + PCI_COMMAND)
+                      & PCI_COMMAND_MASTER);
 
     g_free(config);
     return 0;
@@ -1787,9 +1792,8 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
 
     if (ranges_overlap(addr, l, PCI_COMMAND, 2)) {
         pci_update_irq_disabled(d, was_irq_disabled);
-        memory_region_set_enabled(&d->bus_master_enable_region,
-                                  (pci_get_word(d->config + PCI_COMMAND)
-                                   & PCI_COMMAND_MASTER) && d->enabled);
+        pci_set_master(d, (pci_get_word(d->config + PCI_COMMAND) &
+                          PCI_COMMAND_MASTER) && d->enabled);
     }
 
     msi_write_config(d, addr, val_in, l);
@@ -3100,9 +3104,8 @@ void pci_set_enabled(PCIDevice *d, bool state)
 
     d->enabled = state;
     pci_update_mappings(d);
-    memory_region_set_enabled(&d->bus_master_enable_region,
-                              (pci_get_word(d->config + PCI_COMMAND)
-                               & PCI_COMMAND_MASTER) && d->enabled);
+    pci_set_master(d, (pci_get_word(d->config + PCI_COMMAND)
+                      & PCI_COMMAND_MASTER) && d->enabled);
     if (qdev_is_realized(&d->qdev)) {
         pci_device_reset(d);
     }
-- 
MST


