Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80418C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjwv-0003hy-C8; Tue, 02 Jul 2024 16:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjws-0003Rn-I6
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:17:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjwo-00006d-Q2
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KfDnOZZL3lNpO7yBVqmvfyK4tBARWzqdyh5lLLcyyUM=;
 b=c6CoOmG5N6GhdLMUNqIp8uUrrvCcYhoOrY7XIx0DgpbX5pBUeYyfmOO5YFtnChI8Lo7ggf
 JkKdrbcDbFAEQvzVqWT9aaal0PSmtM+J5F8DNT+i7pyMjK9hQyRoMtgatZy9LIKmvRW1l8
 b+1Rw4B1b6vSY8CoaabScVI4JpdI/Pk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-3LtD6H9YPPS0lAeJ3DBwPA-1; Tue, 02 Jul 2024 16:17:52 -0400
X-MC-Unique: 3LtD6H9YPPS0lAeJ3DBwPA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42565672e0aso28969095e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951471; x=1720556271;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KfDnOZZL3lNpO7yBVqmvfyK4tBARWzqdyh5lLLcyyUM=;
 b=cl3zp6E+NMGt22p2OMWCPMV7qbkvudvKnnIPkw7JedNXEEAfd1biMqzZBCaYAVhv+n
 TcaNdX8FmE+8mMyWa/Ua+PMXyniqyuXdtD+tIN49aQK7MP1H+G7dttJHIxPLADXe3eg+
 kqgePnBrEsRbyB4XWGMoytJjQDoku16ShJR2/uE0WZ53dsNjsQKQyzVZyB9vsLe69O33
 dfZoGIY+k+pkgkHi0dOTU4AFDA/OXc2dK6JYCFm/VYvtLvL1tdDhvxOjJXKKyBCjoFOm
 D6UMv6fPqWcWQH43pXBgkz+jY2VKJAMaIxqAw6NuV43x4KdK6HthyyN1qcI09KZtfvPb
 nFWA==
X-Gm-Message-State: AOJu0YzX62VjJ8XQQtULrGArZ8YoC7iYH5O/1FqczqGF2wLfl4527K+h
 ybP7qIMHZ5q+fo75pMqGpfk1Bk2l4hiizF8qOddwXiNJ2ZK/Ku0Aq88gFbuMnxBSmp04bxUdkvh
 tfwfR4z4dDZzSv6pSyEk/R8nDr9y9Ty2J1SQglpHpWywtikoo2D8gMnt1kMjhWz43lh5MDRPr9t
 J9VaIiiGVYjinsqKksRS24cV8Nkb6Zag==
X-Received: by 2002:a05:600c:3551:b0:424:a7f1:ba2 with SMTP id
 5b1f17b1804b1-4256d58e420mr114386315e9.17.1719951471126; 
 Tue, 02 Jul 2024 13:17:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR5BdGfYyU+SrEQmiIaqx58EJGUMk/jmyZCTtGfwFYrNOfv5QrCOI3tUU1e4cj5VIZuL/ZPA==
X-Received: by 2002:a05:600c:3551:b0:424:a7f1:ba2 with SMTP id
 5b1f17b1804b1-4256d58e420mr114386065e9.17.1719951470500; 
 Tue, 02 Jul 2024 13:17:50 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257d0d38bbsm127519895e9.38.2024.07.02.13.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:17:49 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:17:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jiqian Chen <Jiqian.Chen@amd.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL v2 39/88] virtio-pci: implement No_Soft_Reset bit
Message-ID: <5d98e18823af6d5230fca8098a7ee966aaedeb29.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Jiqian Chen <Jiqian.Chen@amd.com>

In current code, when guest does S3, virtio-gpu are reset due to the
bit No_Soft_Reset is not set. After resetting, the display resources
of virtio-gpu are destroyed, then the display can't come back and only
show blank after resuming.

Implement No_Soft_Reset bit of PCI_PM_CTRL register, then guest can check
this bit, if this bit is set, the devices resetting will not be done, and
then the display can work after resuming.

No_Soft_Reset bit is implemented for all virtio devices, and was tested
only on virtio-gpu device. Set it false by default for safety.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
Message-Id: <20240606102205.114671-3-Jiqian.Chen@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-pci.h |  5 +++++
 hw/core/machine.c              |  1 +
 hw/virtio/virtio-pci.c         | 29 +++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 59d88018c1..9e67ba38c7 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -43,6 +43,7 @@ enum {
     VIRTIO_PCI_FLAG_INIT_FLR_BIT,
     VIRTIO_PCI_FLAG_AER_BIT,
     VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT,
+    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT,
 };
 
 /* Need to activate work-arounds for buggy guests at vmstate load. */
@@ -79,6 +80,10 @@ enum {
 /* Init Power Management */
 #define VIRTIO_PCI_FLAG_INIT_PM (1 << VIRTIO_PCI_FLAG_INIT_PM_BIT)
 
+/* Init The No_Soft_Reset bit of Power Management */
+#define VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET \
+  (1 << VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT)
+
 /* Init Function Level Reset capability */
 #define VIRTIO_PCI_FLAG_INIT_FLR (1 << VIRTIO_PCI_FLAG_INIT_FLR_BIT)
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 655d75c21f..f4cba6496c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,6 +38,7 @@ GlobalProperty hw_compat_9_0[] = {
     {"arm-cpu", "backcompat-cntfrq", "true" },
     {"scsi-disk-base", "migrate-emulated-scsi-request", "false" },
     {"vfio-pci", "skip-vsc-check", "false" },
+    { "virtio-pci", "x-pcie-pm-no-soft-reset", "off" },
 };
 const size_t hw_compat_9_0_len = G_N_ELEMENTS(hw_compat_9_0);
 
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 5941f1a94d..9534730bba 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2222,6 +2222,11 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
             pcie_cap_lnkctl_init(pci_dev);
         }
 
+        if (proxy->flags & VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET) {
+            pci_set_word(pci_dev->config + pos + PCI_PM_CTRL,
+                         PCI_PM_CTRL_NO_SOFT_RESET);
+        }
+
         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
             /* Init Power Management Control Register */
             pci_set_word(pci_dev->wmask + pos + PCI_PM_CTRL,
@@ -2284,11 +2289,33 @@ static void virtio_pci_reset(DeviceState *qdev)
     }
 }
 
+static bool virtio_pci_no_soft_reset(PCIDevice *dev)
+{
+    uint16_t pmcsr;
+
+    if (!pci_is_express(dev) || !dev->exp.pm_cap) {
+        return false;
+    }
+
+    pmcsr = pci_get_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL);
+
+    /*
+     * When No_Soft_Reset bit is set and the device
+     * is in D3hot state, don't reset device
+     */
+    return (pmcsr & PCI_PM_CTRL_NO_SOFT_RESET) &&
+           (pmcsr & PCI_PM_CTRL_STATE_MASK) == 3;
+}
+
 static void virtio_pci_bus_reset_hold(Object *obj, ResetType type)
 {
     PCIDevice *dev = PCI_DEVICE(obj);
     DeviceState *qdev = DEVICE(obj);
 
+    if (virtio_pci_no_soft_reset(dev)) {
+        return;
+    }
+
     virtio_pci_reset(qdev);
 
     if (pci_is_express(dev)) {
@@ -2328,6 +2355,8 @@ static Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
     DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
+    DEFINE_PROP_BIT("x-pcie-pm-no-soft-reset", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT, false),
     DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
     DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
-- 
MST


