Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484A9C5B549
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkYx-00024l-71; Sun, 01 Jun 2025 11:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYu-00023s-UK
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYt-0004cu-1X
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4oOyhyn0zwWJsClDDP7Djl4UlBECR0W4KSvSBeBDXig=;
 b=KxCzsCLf7J1ppACQzBEauNfEsXT41IZklK0S9KfS+ZSlv9K1Ox0FHqhswOLrLYcUFrdVHW
 0ZPTBi6CqrbwrY0TM6S6RG2Hc7U5zxeUfgL/sD4lHuMp9bzP1u1wC67CqQqF1aNKQ7XC2k
 HqcjLt5CX7OH+esST/YVCr2N/kJFgsU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-LiUI1UfRO1C2gxILs-lWnA-1; Sun, 01 Jun 2025 11:25:21 -0400
X-MC-Unique: LiUI1UfRO1C2gxILs-lWnA-1
X-Mimecast-MFC-AGG-ID: LiUI1UfRO1C2gxILs-lWnA_1748791520
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-442dc702850so24188755e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791519; x=1749396319;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4oOyhyn0zwWJsClDDP7Djl4UlBECR0W4KSvSBeBDXig=;
 b=S3Xh45fYAwICtZHrYEYR/vTrnSM9Y+wUCvaUPvPi6w0kpHKd7pDqc6544IKlCBocwE
 gSJ3YiqtY45Hxon1VFAbwjcQmWBarcSX9oeZDS7nRE/Rdv9v6OOxvo/tvldOy8beloqL
 bLayOETtimP5eI53JYa7pyz8O6Z2kI6ECJJXgEkMgKfIqy5lt/eYIoRq1TapWUcwz+vc
 JmqIIcH5d6lLpae4JPAWEaBkInCVmzNXaHZuptTH8z86JDibSF+TGWNXbJFFIhAdRRzi
 EbeuSYaWxKO62aNwBKEeC8BmyrWUoaQpyoWZx8n53t+cYI7W0frXlXp0Q/ziIuRaWT2v
 CMUw==
X-Gm-Message-State: AOJu0YzzAwyP9wQDmElAS83glnb6jNdAWi+BFfOOhk7gyFV66NlztCkn
 36lQq9cuu9p9Lrx8s1GB+N5WVg9079EbrOYUZqeaiND4Pj7X5GopCebey9gFz3FNI455rC4LeYi
 0nDenjW2vx1Y+RNFkHgySlJWjJ+jjqR7uXm6n80HWqV7srxmzmU6fgGuYwdqmJVzAVtQCCtcEtU
 0ugdXBZAwfUff0xjhmb5MRDUY27GS2Zh6qcg==
X-Gm-Gg: ASbGncvBVjVoBX3IqB4bjBdoZ1F7XX0KeyFY/krGagPQC/Q8MaGrVdORBUig3jT8ldv
 BscRXEWpn4wE7BLco5AghKNaAMz+v2oxGAGPj8MuVV0S1/hG//oyg0Atbics2y0x1l33v3aewMY
 42ItqUKIp2m4D0rV6ewxdV+U0J9XQyCmK7EC3bkSci0Bd+GwufduFkJ6LkyZSDG9+xiasm3ueXm
 onsVsKgUCJIuTLYPKgGaAyEIKniYt1inbnIKotf9rgM73vz1Ph6C2Pc9615Qd8ivCy6eV7W+g1c
 XBMQQw==
X-Received: by 2002:a05:600c:4747:b0:442:d9f2:c753 with SMTP id
 5b1f17b1804b1-451221a1bbfmr35598245e9.26.1748791519127; 
 Sun, 01 Jun 2025 08:25:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIWBPmbXwauyNBsxvUduJZ1u0g6ygdwkngsvcHVyVzsqVlPZx3M7EVDag8+OJgOGcr0aMWvw==
X-Received: by 2002:a05:600c:4747:b0:442:d9f2:c753 with SMTP id
 5b1f17b1804b1-451221a1bbfmr35597975e9.26.1748791518577; 
 Sun, 01 Jun 2025 08:25:18 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8006946sm87957085e9.31.2025.06.01.08.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:25:17 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:25:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Ethan Milon <ethan.milon@eviden.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 13/31] pci: Add a pci-level API for ATS
Message-ID: <e9b457500adb023229a08ece3a8d7f5866dd360e.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

Devices implementing ATS can send translation requests using
pci_ats_request_translation. The invalidation events are sent
back to the device using the iommu notifier managed with
pci_iommu_register_iotlb_notifier / pci_iommu_unregister_iotlb_notifier.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Co-authored-by: Ethan Milon <ethan.milon@eviden.com>
Message-Id: <20250520071823.764266-11-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci.h | 126 +++++++++++++++++++++++++++++++++++++++++++
 hw/pci/pci.c         |  81 ++++++++++++++++++++++++++++
 2 files changed, 207 insertions(+)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index f3016fd76f..5d72607ed5 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -462,6 +462,80 @@ typedef struct PCIIOMMUOps {
     void (*init_iotlb_notifier)(PCIBus *bus, void *opaque, int devfn,
                                 IOMMUNotifier *n, IOMMUNotify fn,
                                 void *user_opaque);
+    /**
+     * @register_iotlb_notifier: setup an IOTLB invalidation notifier.
+     *
+     * Callback required if devices are allowed to cache translations.
+     *
+     * @bus: the #PCIBus of the PCI device.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number of the PCI device.
+     *
+     * @pasid: the pasid of the address space to watch.
+     *
+     * @n: the notifier to register.
+     */
+    void (*register_iotlb_notifier)(PCIBus *bus, void *opaque, int devfn,
+                                    uint32_t pasid, IOMMUNotifier *n);
+    /**
+     * @unregister_iotlb_notifier: remove an IOTLB invalidation notifier.
+     *
+     * Callback required if devices are allowed to cache translations.
+     *
+     * @bus: the #PCIBus of the PCI device.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number of the PCI device.
+     *
+     * @pasid: the pasid of the address space to stop watching.
+     *
+     * @n: the notifier to unregister.
+     */
+    void (*unregister_iotlb_notifier)(PCIBus *bus, void *opaque, int devfn,
+                                      uint32_t pasid, IOMMUNotifier *n);
+    /**
+     * @ats_request_translation: issue an ATS request.
+     *
+     * Callback required if devices are allowed to use the address
+     * translation service.
+     *
+     * @bus: the #PCIBus of the PCI device.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number of the PCI device.
+     *
+     * @pasid: the pasid of the address space to use for the request.
+     *
+     * @priv_req: privileged mode bit (PASID TLP).
+     *
+     * @exec_req: execute request bit (PASID TLP).
+     *
+     * @addr: start address of the memory range to be translated.
+     *
+     * @length: length of the memory range in bytes.
+     *
+     * @no_write: request a read-only translation (if supported).
+     *
+     * @result: buffer in which the TLB entries will be stored.
+     *
+     * @result_length: result buffer length.
+     *
+     * @err_count: number of untranslated subregions.
+     *
+     * Returns: the number of translations stored in the result buffer, or
+     * -ENOMEM if the buffer is not large enough.
+     */
+    ssize_t (*ats_request_translation)(PCIBus *bus, void *opaque, int devfn,
+                                       uint32_t pasid, bool priv_req,
+                                       bool exec_req, hwaddr addr,
+                                       size_t length, bool no_write,
+                                       IOMMUTLBEntry *result,
+                                       size_t result_length,
+                                       uint32_t *err_count);
 } PCIIOMMUOps;
 
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
@@ -495,6 +569,58 @@ int pci_iommu_get_iotlb_info(PCIDevice *dev, uint8_t *addr_width,
 int pci_iommu_init_iotlb_notifier(PCIDevice *dev, IOMMUNotifier *n,
                                   IOMMUNotify fn, void *opaque);
 
+/**
+ * pci_ats_request_translation: perform an ATS request.
+ *
+ * Returns the number of translations stored in @result in case of success,
+ * a negative error code otherwise.
+ * -ENOMEM is returned when the result buffer is not large enough to store
+ * all the translations.
+ *
+ * @dev: the ATS-capable PCI device.
+ * @pasid: the pasid of the address space in which the translation will be done.
+ * @priv_req: privileged mode bit (PASID TLP).
+ * @exec_req: execute request bit (PASID TLP).
+ * @addr: start address of the memory range to be translated.
+ * @length: length of the memory range in bytes.
+ * @no_write: request a read-only translation (if supported).
+ * @result: buffer in which the TLB entries will be stored.
+ * @result_length: result buffer length.
+ * @err_count: number of untranslated subregions.
+ */
+ssize_t pci_ats_request_translation(PCIDevice *dev, uint32_t pasid,
+                                    bool priv_req, bool exec_req,
+                                    hwaddr addr, size_t length,
+                                    bool no_write, IOMMUTLBEntry *result,
+                                    size_t result_length,
+                                    uint32_t *err_count);
+
+/**
+ * pci_iommu_register_iotlb_notifier: register a notifier for changes to
+ * IOMMU translation entries in a specific address space.
+ *
+ * Returns 0 on success, or a negative errno otherwise.
+ *
+ * @dev: the device that wants to get notified.
+ * @pasid: the pasid of the address space to track.
+ * @n: the notifier to register.
+ */
+int pci_iommu_register_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
+                                      IOMMUNotifier *n);
+
+/**
+ * pci_iommu_unregister_iotlb_notifier: unregister a notifier that has been
+ * registerd with pci_iommu_register_iotlb_notifier.
+ *
+ * Returns 0 on success, or a negative errno otherwise.
+ *
+ * @dev: the device that wants to stop notifications.
+ * @pasid: the pasid of the address space to stop tracking.
+ * @n: the notifier to unregister.
+ */
+int pci_iommu_unregister_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
+                                        IOMMUNotifier *n);
+
 /**
  * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
  *
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index dfa5a0259e..0c63cb4bbe 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2987,6 +2987,87 @@ void pci_device_unset_iommu_device(PCIDevice *dev)
     }
 }
 
+ssize_t pci_ats_request_translation(PCIDevice *dev, uint32_t pasid,
+                                    bool priv_req, bool exec_req,
+                                    hwaddr addr, size_t length,
+                                    bool no_write, IOMMUTLBEntry *result,
+                                    size_t result_length,
+                                    uint32_t *err_count)
+{
+    PCIBus *bus;
+    PCIBus *iommu_bus;
+    int devfn;
+
+    if (!dev->is_master ||
+            ((pasid != PCI_NO_PASID) && !pcie_pasid_enabled(dev))) {
+        return -EPERM;
+    }
+
+    if (result_length == 0) {
+        return -ENOSPC;
+    }
+
+    if (!pcie_ats_enabled(dev)) {
+        return -EPERM;
+    }
+
+    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    if (iommu_bus && iommu_bus->iommu_ops->ats_request_translation) {
+        return iommu_bus->iommu_ops->ats_request_translation(bus,
+                                                     iommu_bus->iommu_opaque,
+                                                     devfn, pasid, priv_req,
+                                                     exec_req, addr, length,
+                                                     no_write, result,
+                                                     result_length, err_count);
+    }
+
+    return -ENODEV;
+}
+
+int pci_iommu_register_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
+                                      IOMMUNotifier *n)
+{
+    PCIBus *bus;
+    PCIBus *iommu_bus;
+    int devfn;
+
+    if ((pasid != PCI_NO_PASID) && !pcie_pasid_enabled(dev)) {
+        return -EPERM;
+    }
+
+    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    if (iommu_bus && iommu_bus->iommu_ops->register_iotlb_notifier) {
+        iommu_bus->iommu_ops->register_iotlb_notifier(bus,
+                                           iommu_bus->iommu_opaque, devfn,
+                                           pasid, n);
+        return 0;
+    }
+
+    return -ENODEV;
+}
+
+int pci_iommu_unregister_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
+                                        IOMMUNotifier *n)
+{
+    PCIBus *bus;
+    PCIBus *iommu_bus;
+    int devfn;
+
+    if ((pasid != PCI_NO_PASID) && !pcie_pasid_enabled(dev)) {
+        return -EPERM;
+    }
+
+    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    if (iommu_bus && iommu_bus->iommu_ops->unregister_iotlb_notifier) {
+        iommu_bus->iommu_ops->unregister_iotlb_notifier(bus,
+                                                        iommu_bus->iommu_opaque,
+                                                        devfn, pasid, n);
+        return 0;
+    }
+
+    return -ENODEV;
+}
+
 int pci_iommu_get_iotlb_info(PCIDevice *dev, uint8_t *addr_width,
                              uint32_t *min_page_size)
 {
-- 
MST


