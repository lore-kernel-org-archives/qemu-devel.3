Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DC4C5B543
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkYz-00026N-A0; Sun, 01 Jun 2025 11:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYs-000220-Ep
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYp-0004ca-Vf
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YJiOOwAv2YnFSleWHSjNqxKC6KzAim3GjLcQEGjgPCE=;
 b=MH5a/E3lqSX+AA5sD+hogwqudcEJB0MiSt6MkAHsuauDyYdfj6Qsjqj14U6IQvI1SIjEU7
 SXeyHlAC+OrPKMmpI1f6BRG6ZYNlIM4Pa+niukreEgHDn+ujiTt9D8on4gecXucCJo2lbX
 o20fOwwn0v+/CkDrZhijstI4NoqZ61o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-AD4yA8P5M3GgCeVx6yryOw-1; Sun, 01 Jun 2025 11:25:18 -0400
X-MC-Unique: AD4yA8P5M3GgCeVx6yryOw-1
X-Mimecast-MFC-AGG-ID: AD4yA8P5M3GgCeVx6yryOw_1748791517
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450d57a0641so21739015e9.3
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791517; x=1749396317;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJiOOwAv2YnFSleWHSjNqxKC6KzAim3GjLcQEGjgPCE=;
 b=PqHkgWnwMOr6RHOlJhN46mYluQEnMlsweqzq7j/h8TQdaPU+49zFNDmmEvC56hcu5a
 VoqLidiPaaFYcf6F8KnfW9yCL8y4jQHaD5BdrD+euPyq3xe9UBw7rBs8+qmbOmlumDO8
 xKYRlyTrq6E640VcHNN3A29qsNmN6qQvQbiURYeA8+tS8zjLyd+cuPXAn8QX0XAVwTLK
 gNXnjnQlLdyeavbBzvaxbUznIm5CmUUea72Jc7zL3M30i5VVAGE7BZ/8T0YNQZFpWrjx
 3UiLMn6HB1BlyaHVeUYSEVQ0PYO/MQOJrOMt4aur2RbRKEzQwBbjUWZK96K5GciiTHmh
 5Q+A==
X-Gm-Message-State: AOJu0YzLNowywJzJmm1DRpJEtJeTTu4YnlJmsqRaEVGbQM8uBpyqcn/6
 98GxZ0o873onzQZVbVQzHRC9zHUTExj1OosTJDn926aR0mdp3nvLc/J/X3SnWIRaT2C6xaM1Q4I
 ZEuZCMIWrV0T09AyQCyLwCMNNeZcbqrEfyEhtlsZ7w/uIOE5tqNhqxjULuuM1a2jfJIznrRPJdP
 uM8gRQxd4Hz6qXLFHS3+cfyGs5FjDKciWQdQ==
X-Gm-Gg: ASbGncuWwRhn4ZtoyLUI9rCPghKcHifhNGQ9BRr5bzIdEkyZgrO6P5SWzJMo7QH5iWl
 Ell46bTIzS/5IwKU052IAsk9HMQmB8LGe9TJW29oIKy7OOH0fk8g9BG4MyhIKC+LMU7mNZ39fjf
 RlY2q7BDSZAISyNsH4rg5brkSsEFOu1twO+Hkw3jywWVTRPjqoiQiIT8/WGFgGDBUZ5e5zSqmoB
 2XnlE2VTZpqsuO/NyamIkJkQRA4KdnHrK73cftm/I9VqKpJL6yYGKcN2OySvXyVNuIqMuait1kc
 vCJIYQ==
X-Received: by 2002:a05:600c:500b:b0:442:ccf0:41e6 with SMTP id
 5b1f17b1804b1-4511ecb8b24mr51248835e9.3.1748791516735; 
 Sun, 01 Jun 2025 08:25:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZoR6jNpuzkkkeQQAk/CySquFGt5ogDk51MwX5+nqOtRfRyJXdBv43GrOkD6F210i1dIqomw==
X-Received: by 2002:a05:600c:500b:b0:442:ccf0:41e6 with SMTP id
 5b1f17b1804b1-4511ecb8b24mr51248615e9.3.1748791516253; 
 Sun, 01 Jun 2025 08:25:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8012af3sm87483405e9.35.2025.06.01.08.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:25:15 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:25:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 12/31] pci: Add a pci-level initialization function for IOMMU
 notifiers
Message-ID: <a849ff5d6fa9d263beaecd6421fff8e21d2591c8.1748791463.git.mst@redhat.com>
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

This is meant to be used by ATS-capable devices.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-Id: <20250520071823.764266-10-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci.h | 33 +++++++++++++++++++++++++++++++++
 hw/pci/pci.c         | 17 +++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index d67ffe12db..f3016fd76f 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -442,6 +442,26 @@ typedef struct PCIIOMMUOps {
      */
     void (*get_iotlb_info)(void *opaque, uint8_t *addr_width,
                            uint32_t *min_page_size);
+    /**
+     * @init_iotlb_notifier: initialize an IOMMU notifier.
+     *
+     * Optional callback.
+     *
+     * @bus: the #PCIBus of the PCI device.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number of the PCI device.
+     *
+     * @n: the notifier to be initialized.
+     *
+     * @fn: the callback to be installed.
+     *
+     * @user_opaque: a user pointer that can be used to track a state.
+     */
+    void (*init_iotlb_notifier)(PCIBus *bus, void *opaque, int devfn,
+                                IOMMUNotifier *n, IOMMUNotify fn,
+                                void *user_opaque);
 } PCIIOMMUOps;
 
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
@@ -462,6 +482,19 @@ void pci_device_unset_iommu_device(PCIDevice *dev);
 int pci_iommu_get_iotlb_info(PCIDevice *dev, uint8_t *addr_width,
                              uint32_t *min_page_size);
 
+/**
+ * pci_iommu_init_iotlb_notifier: initialize an IOMMU notifier.
+ *
+ * This function is used by devices before registering an IOTLB notifier.
+ *
+ * @dev: the device.
+ * @n: the notifier to be initialized.
+ * @fn: the callback to be installed.
+ * @opaque: a user pointer that can be used to track a state.
+ */
+int pci_iommu_init_iotlb_notifier(PCIDevice *dev, IOMMUNotifier *n,
+                                  IOMMUNotify fn, void *opaque);
+
 /**
  * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
  *
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index fc4954ac81..dfa5a0259e 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2939,6 +2939,23 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
     return &address_space_memory;
 }
 
+int pci_iommu_init_iotlb_notifier(PCIDevice *dev, IOMMUNotifier *n,
+                                  IOMMUNotify fn, void *opaque)
+{
+    PCIBus *bus;
+    PCIBus *iommu_bus;
+    int devfn;
+
+    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    if (iommu_bus && iommu_bus->iommu_ops->init_iotlb_notifier) {
+        iommu_bus->iommu_ops->init_iotlb_notifier(bus, iommu_bus->iommu_opaque,
+                                                  devfn, n, fn, opaque);
+        return 0;
+    }
+
+    return -ENODEV;
+}
+
 bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
                                  Error **errp)
 {
-- 
MST


