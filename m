Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFA8C54FB3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkYw-00024A-6h; Sun, 01 Jun 2025 11:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYn-0001yL-Gg
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYl-0004bc-FV
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MwBttvuXo9B6rx2/RlekvI4+H6DQqjR7+n57u3/7wG4=;
 b=OaNOBlp4OIAMTvUZEC55K2bJLQdItawT5/3dpAWV6yGbQIe19wkRvdTHTeKPB7BSAH/uxo
 9CAqL7YJOsNDSKQLFYemQpg84wc1wYJkdv4i6xb+cr/autZqRGLYTjlJ6fQ7b3t8Wd6bcM
 vZsRIPzinIk5fKNiBugvQSXa3oxRvIo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-wOQD4cilMTa7T2uYCjSIhg-1; Sun, 01 Jun 2025 11:25:13 -0400
X-MC-Unique: wOQD4cilMTa7T2uYCjSIhg-1
X-Mimecast-MFC-AGG-ID: wOQD4cilMTa7T2uYCjSIhg_1748791512
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4edf5bb4dso1966095f8f.0
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791512; x=1749396312;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MwBttvuXo9B6rx2/RlekvI4+H6DQqjR7+n57u3/7wG4=;
 b=VZvbb5wvqgIRojOM0FLU/FkcDkV+R8IrucGgF2PN0vieKZg/udIq/gOG7d4L3EQGIj
 CHtCdLivzMg3E61afLrJkuCSf0/LxC4o4qP8TDrshidFvD+Cc9bPmnyNtpIemztibyYB
 NV5+xrFIh1be34Jkqe1We0o0Ry+X7kb+Hf70ghGwEQM1jGtWYZQvX6LUNgJ01hQo3aLX
 F47U/ioY4E4rByHGfRrgQHdw92XZb5LYvIOv4lk5KOrEMVc1RlMRNUJWHkJI6rbmZuGJ
 JvEAoxkpHzTXoFa2APE7JRecp8bJS0sKX4Inc+AEcK8E6musLKmfQqaNT4tepIMvUJDl
 X95g==
X-Gm-Message-State: AOJu0YzitS11ObWXk76MqOEZtXnweVZFctY1xm67mOpRi3UIKQUCK9Zd
 FvJw0r6/xbLEkqXQQakHEI3Rnp8eNLCQQX9rKkPIfkJjHnmGBX7qXCwM5H9WwD0MlPdBjhFRZC+
 DhEHd0Z4MgJ6+quqYO2z3qriMYJvzL6u7NlOD6u8HWtX1D1zdIpMTufx3szTgvKtpXaFj9ByUxO
 dtovXwcDnqiBNnnJ79hob/RwctUJWBW+RLMg==
X-Gm-Gg: ASbGncvX4SWWyz4ZhJQUh7H17UlL4ztsY8hDFCDrbZimQ8NSiSAZJ1qfhzQCJrwo2Qp
 MZFoRHDTRJoXaR/qr0Us4WGoLoIW3VZUWHueyqUbXcj/NKThUqV+lg+Hd0SQSQkgD4WCQDqFmWD
 6+looa4OcbMZl0jpA9DtO1lfBeEJWTO3awB+4TKC6aoi6Vh1reL//pvUIk9rukUQMLup8Cdu5QD
 h7tzF/FJ6V/6ggzRTpqudGlz5gyM+UaWIU3MbQN6CNLCJcjL0V+lSiwEy+UwKS99vWOvFDAqt8H
 GX2BxQ==
X-Received: by 2002:a05:6000:250d:b0:3a1:fe77:9e1d with SMTP id
 ffacd0b85a97d-3a4f7a4d55amr7696163f8f.16.1748791511927; 
 Sun, 01 Jun 2025 08:25:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/UePlmHvH59O/Ma6rwu8/EnmX6ovCcZ8HFYYRiL8t0+trkRhcwksWZabWcCGlWxDljvSuyg==
X-Received: by 2002:a05:6000:250d:b0:3a1:fe77:9e1d with SMTP id
 ffacd0b85a97d-3a4f7a4d55amr7696140f8f.16.1748791511460; 
 Sun, 01 Jun 2025 08:25:11 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f0097210sm11755182f8f.73.2025.06.01.08.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:25:10 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:25:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 10/31] pci: Add an API to get IOMMU's min page size and
 virtual address width
Message-ID: <042cbc9aec7caca639dcb1a8a996406a7c572706.1748791463.git.mst@redhat.com>
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

This kind of information is needed by devices implementing ATS in order
to initialize their translation cache.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-Id: <20250520071823.764266-8-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci.h | 26 ++++++++++++++++++++++++++
 hw/pci/pci.c         | 17 +++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index c2fe6caa2c..d67ffe12db 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -429,6 +429,19 @@ typedef struct PCIIOMMUOps {
      * @devfn: device and function number of the PCI device.
      */
     void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
+    /**
+     * @get_iotlb_info: get properties required to initialize a device IOTLB.
+     *
+     * Callback required if devices are allowed to cache translations.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @addr_width: the address width of the IOMMU (output parameter).
+     *
+     * @min_page_size: the page size of the IOMMU (output parameter).
+     */
+    void (*get_iotlb_info)(void *opaque, uint8_t *addr_width,
+                           uint32_t *min_page_size);
 } PCIIOMMUOps;
 
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
@@ -436,6 +449,19 @@ bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
                                  Error **errp);
 void pci_device_unset_iommu_device(PCIDevice *dev);
 
+/**
+ * pci_iommu_get_iotlb_info: get properties required to initialize a
+ * device IOTLB.
+ *
+ * Returns 0 on success, or a negative errno otherwise.
+ *
+ * @dev: the device that wants to get the information.
+ * @addr_width: the address width of the IOMMU (output parameter).
+ * @min_page_size: the page size of the IOMMU (output parameter).
+ */
+int pci_iommu_get_iotlb_info(PCIDevice *dev, uint8_t *addr_width,
+                             uint32_t *min_page_size);
+
 /**
  * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
  *
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1114ba8529..fc4954ac81 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2970,6 +2970,23 @@ void pci_device_unset_iommu_device(PCIDevice *dev)
     }
 }
 
+int pci_iommu_get_iotlb_info(PCIDevice *dev, uint8_t *addr_width,
+                             uint32_t *min_page_size)
+{
+    PCIBus *bus;
+    PCIBus *iommu_bus;
+    int devfn;
+
+    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    if (iommu_bus && iommu_bus->iommu_ops->get_iotlb_info) {
+        iommu_bus->iommu_ops->get_iotlb_info(iommu_bus->iommu_opaque,
+                                             addr_width, min_page_size);
+        return 0;
+    }
+
+    return -ENODEV;
+}
+
 void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
 {
     /*
-- 
MST


