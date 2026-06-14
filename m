Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F635CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDV-0000cg-SE; Sun, 14 Jun 2026 15:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDQ-0000HQ-Hz
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDO-0002kp-Jb
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uYbQ6vGTUylKqc37+T6WR2Ax60xzKMG8Kdty/wQ3y5s=;
 b=iIs8vJON4Z9hdJlLgLS+5p4BAZ+Nspu7ZYrIpMq3ufTGhwwWe35kyuHhpa0In2ZefW4AJ7
 +milPYPbZIMOz6ikpm0q8aMKeEeyOeitKS1UQydVEKEB8QzRDX7raA939vhyohEViqqbhR
 u7IQ5b4wqhk6fpcHUTWvWIGtLWZfL+s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-QhY8w5C_PKyq0fh4VBQVVg-1; Sun, 14 Jun 2026 15:09:48 -0400
X-MC-Unique: QhY8w5C_PKyq0fh4VBQVVg-1
X-Mimecast-MFC-AGG-ID: QhY8w5C_PKyq0fh4VBQVVg_1781464187
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490c4f61a34so17535615e9.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464187; x=1782068987; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uYbQ6vGTUylKqc37+T6WR2Ax60xzKMG8Kdty/wQ3y5s=;
 b=pVEPtbJ88uPqpv+8CqA0Zr3gXTHmsTiILwi/XwDzwG3WQtEbjy55iPU5umuJgkWXnx
 TiA4/2olWMbfY9Umlxxs0pJDuvIt2e0DwqoFc2kvjK/ZvtMHl57iwH+VgW5H1uAnDfLp
 cSb6jvzw9/70in48grCMI9RlHNmxQnieGiJ02bsjOQ/QNJvoeMkCJQ5oqFKWxDr6oiTH
 bO1R63EiI/i6uS/rvkknGUqcqGPBIvHAg4rvsW2CldxwyosbWipk0rWr1LbPBMZ/MkF+
 IJZufZ2IgRSXH75oBwdNfLQlaJyX76u+wyIVokqAWnPHrmvcUxL0zM+B/83uoLxaW4FU
 YJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464187; x=1782068987;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uYbQ6vGTUylKqc37+T6WR2Ax60xzKMG8Kdty/wQ3y5s=;
 b=F+4kcHH3JJAfYqU5nZsXDJ+ZaSNGi/YwyG/I2TY2znEsUFyTWHEewbS4kXKvm60QjN
 L+jPjL4HaCJJ3BIFQQ1aOxGSMwro1JlDACknkNCArseNZ+WxUOegSjCDAeDPd4pjP0dr
 Fx4MT3dBGZEGuqIc0TXGwvgPJX1715FFoNK2Hvw00PkY/SGdh+7TuWTQ2UsJJ8d2dn0C
 SmSrwsY9QRg9G4lKtWeBnXy5qcJmaiGLNPRB1ze5S4Q3f8oO6mx2V6ejZPhzG4Trsg38
 kHa+83IlxUI40Sn/s+9tFDEnkaq9ZdQylTHMFlsZVdjNErb71AegYpes1XmjY1Jjdrt9
 715w==
X-Gm-Message-State: AOJu0Yx8Q7YTNYqNbgJxnkcN8ppYTJcEDjDbWPz6v5XdoF1acACt0SCP
 hxtyS+eYj6yibT9kxA4ZwHpU9e531M1gz16sW6mJfXila/tTHKIZGwWmGb7Veg5F/8P2x6bSneD
 l5W3qbffehwv2LlXmsaK1NsPFc2MNkgoACRV8b3ZVHaXyeCykKG/VRzUnj5id7rs4zM1Rtalgge
 L96I6mNcfBKlYyeKUt/SYXeyVHRDdsYuRb6Q==
X-Gm-Gg: Acq92OFsCbyolwTRGeT02TUGdKAPNps+qiViDGjcopZTRlTbUSfLTvvZv4yGfE0A2ye
 sRHYJKcz640/rumRRkG8WuEUmOxj0PTKR6gnLDeiDoy3NyQsIhvjR95s2cLSO2UpIaqGKipzqGv
 9O3t6+YQLchI0FY8ZPmEAgubobViMHWcJfc63RH0Pi/Sv76+BzxirzSu40hZ26GOJxsO19TLv/y
 7CXwMNl7HMl336LbEMBq/HetYhnx11mUdvyD0SeL6RxlOvkrfMJXPOFjzLUbk/Zui4zMIBhONSg
 FuFoBhaPS+6z/qvMQO91UDZk9DGD6LN51/AF5cltkcGZxHBuCuCtVRqTjyAljWpFiJx1chlDaV1
 9S1jdj2+0lHo2jg0Z9D8mcc35Fzg9qc4FqmBdAsaE/wk=
X-Received: by 2002:a05:600c:820c:b0:490:c2a3:3302 with SMTP id
 5b1f17b1804b1-490ec526f4fmr143548945e9.35.1781464187206; 
 Sun, 14 Jun 2026 12:09:47 -0700 (PDT)
X-Received: by 2002:a05:600c:820c:b0:490:c2a3:3302 with SMTP id
 5b1f17b1804b1-490ec526f4fmr143548635e9.35.1781464186641; 
 Sun, 14 Jun 2026 12:09:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492203dd0b9sm181971825e9.15.2026.06.14.12.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:09:46 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Albert Esteve <aesteve@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 097/106] vhost-user-device: Add shared memory BAR
Message-ID: <6608dca74ecfc3e59cdf876cb5490750f37d3706.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Albert Esteve <aesteve@redhat.com>

Add shared memory BAR support to vhost-user-device-pci
to enable direct file mapping for VIRTIO Shared
Memory Regions.

The implementation creates a consolidated shared
memory BAR that contains all VIRTIO Shared
Memory Regions as subregions. Each region is
configured with its proper shmid, size, and
offset within the BAR. The number and size of
regions are retrieved via VHOST_USER_GET_SHMEM_CONFIG
message sent by vhost-user-base during realization
after virtio_init().

Specifically, it uses BAR 4 to avoid conflicts, as
it is currently unused.

The shared memory BAR is only created when the
backend supports VHOST_USER_PROTOCOL_F_SHMEM and
has configured shared memory regions. This maintains
backward compatibility with backends that do not
support shared memory functionality.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260304165223.2166175-8-aesteve@redhat.com>
---
 hw/virtio/vhost-user-base.c            | 46 ++++++++++++++++++++++++--
 hw/virtio/vhost-user-test-device-pci.c | 42 +++++++++++++++++++++--
 2 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 8b62c6c36e..39b5e637fc 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -16,6 +16,7 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/vhost-user-base.h"
 #include "qemu/error-report.h"
+#include "migration/blocker.h"
 
 static void vub_start(VirtIODevice *vdev)
 {
@@ -281,7 +282,8 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBase *vub = VHOST_USER_BASE(dev);
-    int ret;
+    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
+    int i, ret, nregions, regions_processed = 0;
 
     if (!vub->chardev.chr) {
         error_setg(errp, "vhost-user-base: missing chardev");
@@ -324,7 +326,7 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
 
     /* Allocate queues */
     vub->vqs = g_ptr_array_sized_new(vub->num_vqs);
-    for (int i = 0; i < vub->num_vqs; i++) {
+    for (i = 0; i < vub->num_vqs; i++) {
         g_ptr_array_add(vub->vqs,
                         virtio_add_queue(vdev, vub->vq_size,
                                          vub_handle_output));
@@ -338,11 +340,49 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
                          VHOST_BACKEND_TYPE_USER, 0, errp);
 
     if (ret < 0) {
-        do_vhost_user_cleanup(vdev, vub);
+        goto err;
+    }
+
+    ret = vub->vhost_dev.vhost_ops->vhost_get_shmem_config(&vub->vhost_dev,
+                                                           &nregions,
+                                                           memory_sizes,
+                                                           errp);
+
+    if (ret < 0) {
+        goto err;
+    }
+
+    for (i = 0; i < VIRTIO_MAX_SHMEM_REGIONS && regions_processed < nregions; i++) {
+        if (memory_sizes[i]) {
+            regions_processed++;
+            if (vub->vhost_dev.migration_blocker == NULL) {
+                error_setg(&vub->vhost_dev.migration_blocker,
+                       "Migration disabled: devices with VIRTIO Shared Memory "
+                       "Regions do not support migration yet.");
+                ret = migrate_add_blocker_normal(
+                    &vub->vhost_dev.migration_blocker,
+                    errp);
+
+                if (ret < 0) {
+                    goto err;
+                }
+            }
+
+            if (memory_sizes[i] % qemu_real_host_page_size() != 0) {
+                error_setg(errp, "Shared memory %d size must be a multiple of "
+                                 "the host page size", i);
+                goto err;
+            }
+
+            virtio_new_shmem_region(vdev, i, memory_sizes[i]);
+        }
     }
 
     qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event, NULL,
                              dev, NULL, true);
+    return;
+err:
+    do_vhost_user_cleanup(vdev, vub);
 }
 
 static void vub_device_unrealize(DeviceState *dev)
diff --git a/hw/virtio/vhost-user-test-device-pci.c b/hw/virtio/vhost-user-test-device-pci.c
index 7f6d751690..2106557ed8 100644
--- a/hw/virtio/vhost-user-test-device-pci.c
+++ b/hw/virtio/vhost-user-test-device-pci.c
@@ -12,10 +12,13 @@
 #include "hw/virtio/vhost-user-base.h"
 #include "hw/virtio/virtio-pci.h"
 
+#define VIRTIO_DEVICE_PCI_SHMEM_BAR 4
+
 struct VHostUserDevicePCI {
     VirtIOPCIProxy parent_obj;
 
     VHostUserBase vub;
+    MemoryRegion shmembar;
 };
 
 #define TYPE_VHOST_USER_TEST_DEVICE_PCI "vhost-user-test-device-pci-base"
@@ -25,10 +28,45 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOST_USER_TEST_DEVICE_PCI)
 static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VHostUserDevicePCI *dev = VHOST_USER_TEST_DEVICE_PCI(vpci_dev);
-    DeviceState *vdev = DEVICE(&dev->vub);
+    DeviceState *dev_state = DEVICE(&dev->vub);
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev_state);
+    VirtioSharedMemory *shmem;
+    uint64_t offset = 0, shmem_size = 0;
 
+    /* Keep modern 64-bit BARs (2 slots) away from the shared memory BAR. */
+    vpci_dev->modern_mem_bar_idx = 2;
     vpci_dev->nvectors = 1;
-    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
+    if (!qdev_realize(dev_state, BUS(&vpci_dev->bus), errp)) {
+        return;
+    }
+
+    QSIMPLEQ_FOREACH(shmem, &vdev->shmem_list, entry) {
+        if (memory_region_size(&shmem->mr) > UINT64_MAX - shmem_size) {
+            error_setg(errp, "Total shared memory required overflow");
+            return;
+        }
+        shmem_size = shmem_size + memory_region_size(&shmem->mr);
+    }
+    if (shmem_size) {
+        if (vpci_dev->flags & VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY) {
+            error_setg(errp, "modern-pio-notify is not supported due to PCI BAR layout limitations");
+            return;
+        }
+        memory_region_init(&dev->shmembar, OBJECT(vpci_dev),
+                           "vhost-device-pci-shmembar", shmem_size);
+        QSIMPLEQ_FOREACH(shmem, &vdev->shmem_list, entry) {
+            memory_region_add_subregion(&dev->shmembar, offset, &shmem->mr);
+            virtio_pci_add_shm_cap(vpci_dev, VIRTIO_DEVICE_PCI_SHMEM_BAR,
+                                   offset, memory_region_size(&shmem->mr),
+                                   shmem->shmid);
+            offset = offset + memory_region_size(&shmem->mr);
+        }
+        pci_register_bar(&vpci_dev->pci_dev, VIRTIO_DEVICE_PCI_SHMEM_BAR,
+                        PCI_BASE_ADDRESS_SPACE_MEMORY |
+                        PCI_BASE_ADDRESS_MEM_PREFETCH |
+                        PCI_BASE_ADDRESS_MEM_TYPE_64,
+                        &dev->shmembar);
+    }
 }
 
 static void vhost_user_device_pci_class_init(ObjectClass *klass,
-- 
MST


