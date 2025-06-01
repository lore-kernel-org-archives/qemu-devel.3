Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0509C54FB3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkZ1-00027O-Fy; Sun, 01 Jun 2025 11:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYx-000255-GM
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYv-0004dD-Bm
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f470Te/20A+JI7N7uDj23gq/WhgjwkX/MH5JkqvMLnY=;
 b=QujeeHjwDCPlHPBhORXaLyL3p2WMdLUeT/7TbOHx8Fougf8IsKwhfQvhgayp1CFMTwRSLx
 Z22ZkV0R/ZpKS5foR01i+3sqF08G5V2DkPXb7vNUzsrpY/pgLRJm3fzEuW0lpab7eZACxR
 hd68S4oGqJG3QGguMs72LhpyCWVmIwo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-jOeLjqkdOqan3r5IKu_9cw-1; Sun, 01 Jun 2025 11:25:23 -0400
X-MC-Unique: jOeLjqkdOqan3r5IKu_9cw-1
X-Mimecast-MFC-AGG-ID: jOeLjqkdOqan3r5IKu_9cw_1748791522
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-451d30992bcso6712815e9.2
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791522; x=1749396322;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f470Te/20A+JI7N7uDj23gq/WhgjwkX/MH5JkqvMLnY=;
 b=GFyrm8rjPa8VNIwMpftXU+6qL/qQ6Evnbmiag1ExLnJZuhs69vGQzSvNZHBa/PcFhR
 E5Zjt1HOWSiUVDc/CMyyCe3qSniOp+vxmaGhJ7StBY0ce5oJNeWeN5tL+SGGLGQfpWRh
 BPBp0mmsWAN/YofjsalOdgkTZ938eu69Q4nVs9ryhykPFfzZG4LqzDbRLNdeL4nmqN57
 +9wG0HEHYqux60DkL8wutsueviQAArRd4BD0r7hYYIHX0RKCbEtbR412EnHfrAWfyEP5
 +vGcB6A2WOPHvC4vvgRDdFWmCcVhR2Dp3UlGDVm7B5ffmnE79fdZVu3mTNREwlHWe0Pm
 IqLw==
X-Gm-Message-State: AOJu0YzxUpDXy8Gsl5yQDGh5tzIx1kDQ3I+7t1wBFHs9gv5gC4DKe6ek
 qJr0ma6NWtU7w+WPB+8oRqL+D/mxZZxp73qvsVLdkPfyE01rU7GrPlVgbXyduQ2ZPKia8iNbLVf
 84+gSbHkfsNzNFyxlUCEXnhz8fewZqDJdegJiNKnDTY3gnW+ftiUmsT2/O+5BaUKYQULnp8jbhD
 S5Tv2M+FOO1E1S2784pqM20GWX+qBW2kcOVw==
X-Gm-Gg: ASbGncvJykTlp7QkfDgi2KCPJb3HVeyGODcRWmldseBXiG2GegMyHYW07ho3A4sfd/y
 ua3RAqIT28VIVZsApvGO+ydY+x3tLFz4+V4owhRdqIMJk0/GN8Pb+ycOI1UaeSorOjx2fhmts++
 yDvURmN7sEqjYM5RTIq4GvLZviaoMtyx0wRa3B3T9JB9Ex7B3qMYCG3JvSkpGKdBBAIc7O0O4fy
 KoLtP3X1rGekq7uo/2m5umfDNIPap7iECjrSejA5noyc79K7WCc4bIhQ/K0vfZJ5ugu4kJpbvuN
 sS1FkQ==
X-Received: by 2002:a05:600c:8b11:b0:450:d4ad:b7de with SMTP id
 5b1f17b1804b1-4511ecb9cd9mr48814555e9.3.1748791521538; 
 Sun, 01 Jun 2025 08:25:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3oRx0DFOf2pEH7L3o7ZAWFS5oZylVxJXGYiYF8/BUlsrxYWXnjUrKzDZWUdLV3ByHF7WMwg==
X-Received: by 2002:a05:600c:8b11:b0:450:d4ad:b7de with SMTP id
 5b1f17b1804b1-4511ecb9cd9mr48814315e9.3.1748791520994; 
 Sun, 01 Jun 2025 08:25:20 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d800671csm88636315e9.30.2025.06.01.08.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:25:20 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:25:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Ethan Milon <ethan.milon@eviden.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 14/31] pci: Add a PCI-level API for PRI
Message-ID: <f0f37daf8e67c7208641aec5e238197279ca7331.1748791463.git.mst@redhat.com>
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

A device can send a PRI request to the IOMMU using pci_pri_request_page.
The PRI response is sent back using the notifier managed with
pci_pri_register_notifier and pci_pri_unregister_notifier.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Co-authored-by: Ethan Milon <ethan.milon@eviden.com>
Message-Id: <20250520071823.764266-12-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci.h | 130 +++++++++++++++++++++++++++++++++++++++++++
 hw/pci/pci.c         |  66 ++++++++++++++++++++++
 2 files changed, 196 insertions(+)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 5d72607ed5..a6854dad2b 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -375,6 +375,28 @@ void pci_bus_get_w64_range(PCIBus *bus, Range *range);
 
 void pci_device_deassert_intx(PCIDevice *dev);
 
+/* Page Request Interface */
+typedef enum {
+    IOMMU_PRI_RESP_SUCCESS,
+    IOMMU_PRI_RESP_INVALID_REQUEST,
+    IOMMU_PRI_RESP_FAILURE,
+} IOMMUPRIResponseCode;
+
+typedef struct IOMMUPRIResponse {
+    IOMMUPRIResponseCode response_code;
+    uint16_t prgi;
+} IOMMUPRIResponse;
+
+struct IOMMUPRINotifier;
+
+typedef void (*IOMMUPRINotify)(struct IOMMUPRINotifier *notifier,
+                               IOMMUPRIResponse *response);
+
+typedef struct IOMMUPRINotifier {
+    IOMMUPRINotify notify;
+} IOMMUPRINotifier;
+
+#define PCI_PRI_PRGI_MASK 0x1ffU
 
 /**
  * struct PCIIOMMUOps: callbacks structure for specific IOMMU handlers
@@ -536,6 +558,72 @@ typedef struct PCIIOMMUOps {
                                        IOMMUTLBEntry *result,
                                        size_t result_length,
                                        uint32_t *err_count);
+    /**
+     * @pri_register_notifier: setup the PRI completion callback.
+     *
+     * Callback required if devices are allowed to use the page request
+     * interface.
+     *
+     * @bus: the #PCIBus of the PCI device.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number of the PCI device.
+     *
+     * @pasid: the pasid of the address space to track.
+     *
+     * @notifier: the notifier to register.
+     */
+    void (*pri_register_notifier)(PCIBus *bus, void *opaque, int devfn,
+                                  uint32_t pasid, IOMMUPRINotifier *notifier);
+    /**
+     * @pri_unregister_notifier: remove the PRI completion callback.
+     *
+     * Callback required if devices are allowed to use the page request
+     * interface.
+     *
+     * @bus: the #PCIBus of the PCI device.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number of the PCI device.
+     *
+     * @pasid: the pasid of the address space to stop tracking.
+     */
+    void (*pri_unregister_notifier)(PCIBus *bus, void *opaque, int devfn,
+                                    uint32_t pasid);
+    /**
+     * @pri_request_page: issue a PRI request.
+     *
+     * Callback required if devices are allowed to use the page request
+     * interface.
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
+     * @addr: untranslated address of the requested page.
+     *
+     * @lpig: last page in group.
+     *
+     * @prgi: page request group index.
+     *
+     * @is_read: request read access.
+     *
+     * @is_write: request write access.
+     */
+    int (*pri_request_page)(PCIBus *bus, void *opaque, int devfn,
+                            uint32_t pasid, bool priv_req, bool exec_req,
+                            hwaddr addr, bool lpig, uint16_t prgi, bool is_read,
+                            bool is_write);
 } PCIIOMMUOps;
 
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
@@ -595,6 +683,48 @@ ssize_t pci_ats_request_translation(PCIDevice *dev, uint32_t pasid,
                                     size_t result_length,
                                     uint32_t *err_count);
 
+/**
+ * pci_pri_request_page: perform a PRI request.
+ *
+ * Returns 0 if the PRI request has been sent to the guest OS,
+ * an error code otherwise.
+ *
+ * @dev: the PRI-capable PCI device.
+ * @pasid: the pasid of the address space in which the translation will be done.
+ * @priv_req: privileged mode bit (PASID TLP).
+ * @exec_req: execute request bit (PASID TLP).
+ * @addr: untranslated address of the requested page.
+ * @lpig: last page in group.
+ * @prgi: page request group index.
+ * @is_read: request read access.
+ * @is_write: request write access.
+ */
+int pci_pri_request_page(PCIDevice *dev, uint32_t pasid, bool priv_req,
+                         bool exec_req, hwaddr addr, bool lpig,
+                         uint16_t prgi, bool is_read, bool is_write);
+
+/**
+ * pci_pri_register_notifier: register the PRI callback for a given address
+ * space.
+ *
+ * Returns 0 on success, an error code otherwise.
+ *
+ * @dev: the PRI-capable PCI device.
+ * @pasid: the pasid of the address space to track.
+ * @notifier: the notifier to register.
+ */
+int pci_pri_register_notifier(PCIDevice *dev, uint32_t pasid,
+                              IOMMUPRINotifier *notifier);
+
+/**
+ * pci_pri_unregister_notifier: remove the PRI callback from a given address
+ * space.
+ *
+ * @dev: the PRI-capable PCI device.
+ * @pasid: the pasid of the address space to stop tracking.
+ */
+void pci_pri_unregister_notifier(PCIDevice *dev, uint32_t pasid);
+
 /**
  * pci_iommu_register_iotlb_notifier: register a notifier for changes to
  * IOMMU translation entries in a specific address space.
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 0c63cb4bbe..c6b5768f3a 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2987,6 +2987,72 @@ void pci_device_unset_iommu_device(PCIDevice *dev)
     }
 }
 
+int pci_pri_request_page(PCIDevice *dev, uint32_t pasid, bool priv_req,
+                         bool exec_req, hwaddr addr, bool lpig,
+                         uint16_t prgi, bool is_read, bool is_write)
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
+    if (!pcie_pri_enabled(dev)) {
+        return -EPERM;
+    }
+
+    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    if (iommu_bus && iommu_bus->iommu_ops->pri_request_page) {
+        return iommu_bus->iommu_ops->pri_request_page(bus,
+                                                     iommu_bus->iommu_opaque,
+                                                     devfn, pasid, priv_req,
+                                                     exec_req, addr, lpig, prgi,
+                                                     is_read, is_write);
+    }
+
+    return -ENODEV;
+}
+
+int pci_pri_register_notifier(PCIDevice *dev, uint32_t pasid,
+                              IOMMUPRINotifier *notifier)
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
+    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    if (iommu_bus && iommu_bus->iommu_ops->pri_register_notifier) {
+        iommu_bus->iommu_ops->pri_register_notifier(bus,
+                                                    iommu_bus->iommu_opaque,
+                                                    devfn, pasid, notifier);
+        return 0;
+    }
+
+    return -ENODEV;
+}
+
+void pci_pri_unregister_notifier(PCIDevice *dev, uint32_t pasid)
+{
+    PCIBus *bus;
+    PCIBus *iommu_bus;
+    int devfn;
+
+    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    if (iommu_bus && iommu_bus->iommu_ops->pri_unregister_notifier) {
+        iommu_bus->iommu_ops->pri_unregister_notifier(bus,
+                                                      iommu_bus->iommu_opaque,
+                                                      devfn, pasid);
+    }
+}
+
 ssize_t pci_ats_request_translation(PCIDevice *dev, uint32_t pasid,
                                     bool priv_req, bool exec_req,
                                     hwaddr addr, size_t length,
-- 
MST


