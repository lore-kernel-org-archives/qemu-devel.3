Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693C3CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDL-0007uo-Ly; Sun, 14 Jun 2026 15:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCu-0007Pf-J3
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCr-0002Tz-Qt
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eABkb4PGnM+0KkhsEI++HbZI/L2LUOkqkJzR+Km3n0M=;
 b=Qct/sY0NHx5VOndfPtilkAxdXOvI0fnmm1gkXHbFn+xChn+jqPFy4yULfeiulu0TpaEbok
 oB1c1SC+Relt6tbOM4weVy08HU2G6sJIDnshGgXCy0URG0PVELcc7wk4J7c4ungpE0EngC
 LtebqF6MpYRSTyCg2WCjLL7afo1FRKo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-AWW3WJvFMGWEYc3immfmqQ-1; Sun, 14 Jun 2026 15:09:15 -0400
X-MC-Unique: AWW3WJvFMGWEYc3immfmqQ-1
X-Mimecast-MFC-AGG-ID: AWW3WJvFMGWEYc3immfmqQ_1781464154
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490b4d3d3e6so17664005e9.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464154; x=1782068954; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eABkb4PGnM+0KkhsEI++HbZI/L2LUOkqkJzR+Km3n0M=;
 b=tFyHLpk0aJ38nez7ATTymSHMs7F430czdeHY/WORKyN++g+OD10vSQHyqMmG/iUSuq
 QLG7udk5QTvUKPG5kf/KDRxFZk6kbTDI5jkUqZVAeHSyMGs7tkeK2kriMUi6kie5CqeV
 dLVeqwWw1kAuG3wr7iBzl6jg20F1Wr2u18PvJ+DHfT6NOY8s3c48aB9ikOT+gRt4w+FR
 rNQPbnxjNdyIQQu0oXlWlvgw0XCn5IweH/tYNrUAIn7CbiZUkdNi1g+Mre9TGpzZrpUh
 1r5xCfJKs89OZWLv7Klkb7bAN9igJzs0J+CHrqxAaX2dioH4ljdLHgZt6r/gR/FtHN3n
 GyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464154; x=1782068954;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eABkb4PGnM+0KkhsEI++HbZI/L2LUOkqkJzR+Km3n0M=;
 b=TVNTxDr8kFTNc7sv7+XV1OyiY0wsN2b/OodnW4czWb5x/kQa/yunSB/Y0R92khcsYq
 54QticeFph4w4Aes/KhoEq/htahCZa4ClBlFuZrWsj+ouyFS0L5MgBUjfy0gtcQG86F0
 sa+ZrMVaeBJ2zu5iwury8c7aOWGyZhPPclVwxasGFjXs4gL7yTcxuT22jXqlZH0LxL72
 9Z71wHKqMoedacNvEobApYIZpirRLW0IrRPU2NxIe9Q57VKKPfmkdTXozWvZLsV3DA4d
 H1mN5TwMrLagRdXdHz1zgfEmaoOE37I3d8sqtvJYYPA+n25w96t+nUCM8Kkv3r078yle
 OWMQ==
X-Gm-Message-State: AOJu0YxqGkhX7j/rSnEGYAXchFzhTzmNks9dYYacYj370+bqcGf1gJP0
 eHYSMbHGS9mqxjRVRLK1QJtoqqbYlqkMntvwqQOGv7n2wC5xDedxS5vdqX8PwfQeSQY9PiTQcLG
 xksMKpmrKT5ucJ6y4jp1FcnxoJNeGdU4GiAsiKAG4JThiFj9m7UXudY0rMPCcx+omtu19c5g1gt
 QZbB00wAWV+yh2sXh1QG2eLAYpwULklZ23zA==
X-Gm-Gg: Acq92OHgl9RResajk+LU7PG91R8ZkT0d5oG1aGDqKem3e7E932PZ09zKHhuAjYr4vH2
 4IqOFyaEil0zqQ5gzfB5StdJAXpdmII0jwQT6jLfCUUkiN76X9NhylCDrbmAOwa7Dr2qbOX2jVt
 AduUtWcr58oB30Dg64pplk8rDTdSbZ9cCdbomP1/f3hjzFBZPHvCLhrv5aAUtOyla3SeUbJOtet
 Qc7tS/tdzjURpTP9YGLO+veuTHrAkRYTE9bgAnt9wnDB9+bchDOxVzb/Xgfs9oBHnDh9rY0ncRj
 GPZwSMC0/jwHAlhu9WgBhJYjTI4+vGtKM/5iC/mkqSUjMeHycU2Ezjg7H2rKUsM56n34FF615ra
 wS5Iwki0EhSxlMmIFqJf2iW6/l7NW+LIP+rvMatzeHuc=
X-Received: by 2002:a05:600c:6b69:b0:490:b642:ce2c with SMTP id
 5b1f17b1804b1-490ec4df221mr97545965e9.14.1781464154226; 
 Sun, 14 Jun 2026 12:09:14 -0700 (PDT)
X-Received: by 2002:a05:600c:6b69:b0:490:b642:ce2c with SMTP id
 5b1f17b1804b1-490ec4df221mr97545785e9.14.1781464153647; 
 Sun, 14 Jun 2026 12:09:13 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922032ae56sm179917075e9.7.2026.06.14.12.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:09:13 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 083/106] virtio-rtc: Add basic virtio-rtc support
Message-ID: <ae5f259a5c77b501b951d487030e617e546facc3.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Kuan-Wei Chiu <visitorckw@gmail.com>

Introduce the core device and PCI bindings for the virtio-rtc device
(VIRTIO_ID_CLOCK).

This implementation provides a read-only clock that returns the host's
time (QEMU_CLOCK_HOST) to the guest. It handles fundamental control
requests, reporting a single supported clock of type
VIRTIO_RTC_CLOCK_UTC, and responds to standard read requests.

- Virtio RTC Spec:
https://github.com/oasis-tcs/virtio-spec/tree/master/device-types/rtc
- Linux Virtio RTC driver:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/virtio/virtio_rtc_driver.c?h=v7.0-rc1

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260228182246.700714-3-visitorckw@gmail.com>
---
 MAINTAINERS                    |   7 ++
 hw/virtio/Kconfig              |   5 +
 hw/virtio/meson.build          |   2 +
 hw/virtio/virtio-rtc-pci.c     |  65 +++++++++++
 hw/virtio/virtio-rtc.c         | 190 +++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-rtc.h |  22 ++++
 6 files changed, 291 insertions(+)
 create mode 100644 hw/virtio/virtio-rtc-pci.c
 create mode 100644 hw/virtio/virtio-rtc.c
 create mode 100644 include/hw/virtio/virtio-rtc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5a82aa3a05..df36496cfb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2527,6 +2527,13 @@ F: include/system/rng*.h
 F: backends/rng*.c
 F: tests/qtest/virtio-rng-test.c
 
+virtio-rtc
+M: Kuan-Wei Chiu <visitorckw@gmail.com>
+S: Maintained
+F: hw/virtio/virtio-rtc.c
+F: hw/virtio/virtio-rtc-pci.c
+F: include/hw/virtio/virtio-rtc.h
+
 virtio-nsm
 M: Alexander Graf <graf@amazon.com>
 M: Dorjoy Chowdhury <dorjoychy111@gmail.com>
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 2ebdac16b3..91cf833407 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -76,6 +76,11 @@ config VIRTIO_MEM
     depends on VIRTIO_MEM_SUPPORTED
     select VIRTIO_MD
 
+config VIRTIO_RTC
+    bool
+    default y
+    depends on VIRTIO
+
 config VHOST_VSOCK_COMMON
     bool
     depends on VIRTIO
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 3943e0d006..0e02323516 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -54,6 +54,7 @@ if have_vhost
 endif
 system_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_RTC', if_true: files('virtio-rtc.c'))
 
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
 system_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
@@ -77,6 +78,7 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto-pc
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_INPUT_HOST', if_true: files('virtio-input-host-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_INPUT', if_true: files('virtio-input-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_RTC', if_true: files('virtio-rtc-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: [files('virtio-nsm-pci.c', 'cbor-helpers.c'), libcbor])
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_9P', if_true: files('virtio-9p-pci.c'))
diff --git a/hw/virtio/virtio-rtc-pci.c b/hw/virtio/virtio-rtc-pci.c
new file mode 100644
index 0000000000..fe25f21fbc
--- /dev/null
+++ b/hw/virtio/virtio-rtc-pci.c
@@ -0,0 +1,65 @@
+/*
+ * Virtio RTC PCI Bindings
+ *
+ * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/virtio/virtio-pci.h"
+#include "hw/virtio/virtio-rtc.h"
+#include "standard-headers/linux/virtio_ids.h"
+
+typedef struct VirtIORtcPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIORtc vdev;
+} VirtIORtcPCI;
+
+#define TYPE_VIRTIO_RTC_PCI "virtio-rtc-pci-base"
+OBJECT_DECLARE_SIMPLE_TYPE(VirtIORtcPCI, VIRTIO_RTC_PCI)
+
+static void virtio_rtc_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIORtcPCI *dev = VIRTIO_RTC_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
+}
+
+static void virtio_rtc_pci_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    k->realize = virtio_rtc_pci_realize;
+
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_10_BASE + VIRTIO_ID_CLOCK;
+    pcidev_k->revision = 0x00;
+    pcidev_k->class_id = PCI_CLASS_SYSTEM_RTC;
+}
+
+static void virtio_rtc_pci_instance_init(Object *obj)
+{
+    VirtIORtcPCI *dev = VIRTIO_RTC_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                      TYPE_VIRTIO_RTC);
+}
+
+static const VirtioPCIDeviceTypeInfo virtio_rtc_pci_info = {
+    .base_name = TYPE_VIRTIO_RTC_PCI,
+    .non_transitional_name = "virtio-rtc-pci",
+    .instance_size = sizeof(VirtIORtcPCI),
+    .instance_init = virtio_rtc_pci_instance_init,
+    .class_init = virtio_rtc_pci_class_init,
+};
+
+static void virtio_rtc_pci_register(void)
+{
+    virtio_pci_types_register(&virtio_rtc_pci_info);
+}
+
+type_init(virtio_rtc_pci_register);
diff --git a/hw/virtio/virtio-rtc.c b/hw/virtio/virtio-rtc.c
new file mode 100644
index 0000000000..32de9c1650
--- /dev/null
+++ b/hw/virtio/virtio-rtc.c
@@ -0,0 +1,190 @@
+/*
+ * Virtio RTC device core
+ *
+ * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/iov.h"
+#include "qemu/timer.h"
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-rtc.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_rtc.h"
+
+static void virtio_rtc_handle_request(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtQueueElement *elem;
+    struct virtio_rtc_req_head req_head;
+    size_t written;
+
+    while ((elem = virtqueue_pop(vq, sizeof(VirtQueueElement)))) {
+        if (elem->out_num < 1 || elem->in_num < 1) {
+            virtio_error(vdev, "virtio-rtc: request missing in/out buffers");
+            virtqueue_detach_element(vq, elem, 0);
+            g_free(elem);
+            break;
+        }
+
+        if (iov_to_buf(elem->out_sg, elem->out_num, 0, &req_head,
+                       sizeof(req_head)) != sizeof(req_head)) {
+            virtio_error(vdev, "virtio-rtc: request header too short");
+            virtqueue_detach_element(vq, elem, 0);
+            g_free(elem);
+            break;
+        }
+
+        written = 0;
+
+        switch (le16_to_cpu(req_head.msg_type)) {
+        case VIRTIO_RTC_REQ_CFG: {
+            struct virtio_rtc_resp_cfg resp = {0};
+            resp.head.status = VIRTIO_RTC_S_OK;
+            resp.num_clocks = cpu_to_le16(1);
+            written = iov_from_buf(elem->in_sg, elem->in_num, 0, &resp,
+                                   sizeof(resp));
+            break;
+        }
+        case VIRTIO_RTC_REQ_CLOCK_CAP: {
+            struct virtio_rtc_req_clock_cap req;
+            struct virtio_rtc_resp_clock_cap resp = {0};
+
+            if (iov_to_buf(elem->out_sg, elem->out_num, 0, &req,
+                           sizeof(req)) != sizeof(req)) {
+                resp.head.status = VIRTIO_RTC_S_EINVAL;
+                written = iov_from_buf(elem->in_sg, elem->in_num, 0, &resp,
+                                       sizeof(resp.head));
+                break;
+            }
+
+            if (le16_to_cpu(req.clock_id) != 0) {
+                resp.head.status = VIRTIO_RTC_S_ENODEV;
+            } else {
+                resp.head.status = VIRTIO_RTC_S_OK;
+                resp.type = VIRTIO_RTC_CLOCK_UTC;
+            }
+            written = iov_from_buf(elem->in_sg, elem->in_num, 0, &resp,
+                                   sizeof(resp));
+            break;
+        }
+        case VIRTIO_RTC_REQ_CROSS_CAP: {
+            struct virtio_rtc_req_cross_cap req;
+            struct virtio_rtc_resp_cross_cap resp = {0};
+
+            if (iov_to_buf(elem->out_sg, elem->out_num, 0, &req,
+                     sizeof(req)) != sizeof(req)) {
+                resp.head.status = VIRTIO_RTC_S_EINVAL;
+                written = iov_from_buf(elem->in_sg, elem->in_num, 0, &resp,
+                                       sizeof(resp.head));
+                break;
+            }
+
+            if (le16_to_cpu(req.clock_id) != 0) {
+                resp.head.status = VIRTIO_RTC_S_ENODEV;
+            } else {
+                resp.head.status = VIRTIO_RTC_S_OK;
+            }
+            written = iov_from_buf(elem->in_sg, elem->in_num, 0, &resp,
+                                   sizeof(resp));
+            break;
+        }
+        case VIRTIO_RTC_REQ_READ: {
+            struct virtio_rtc_req_read req;
+            struct virtio_rtc_resp_read resp = {0};
+
+            if (iov_to_buf(elem->out_sg, elem->out_num, 0, &req,
+                           sizeof(req)) != sizeof(req)) {
+                resp.head.status = VIRTIO_RTC_S_EINVAL;
+                written = iov_from_buf(elem->in_sg, elem->in_num, 0, &resp,
+                                       sizeof(resp.head));
+                break;
+            }
+
+            if (le16_to_cpu(req.clock_id) != 0) {
+                resp.head.status = VIRTIO_RTC_S_ENODEV;
+                written = iov_from_buf(elem->in_sg, elem->in_num, 0, &resp,
+                                       sizeof(resp.head));
+            } else {
+                resp.head.status = VIRTIO_RTC_S_OK;
+                resp.clock_reading =
+                    cpu_to_le64(qemu_clock_get_ns(QEMU_CLOCK_HOST));
+                written = iov_from_buf(elem->in_sg, elem->in_num, 0, &resp,
+                                       sizeof(resp));
+            }
+            break;
+        }
+        default: {
+            struct virtio_rtc_resp_head resp = {0};
+            resp.status = VIRTIO_RTC_S_EOPNOTSUPP;
+            written = iov_from_buf(elem->in_sg, elem->in_num, 0, &resp,
+                                   sizeof(resp));
+            break;
+        }
+        }
+
+        virtqueue_push(vq, elem, written);
+        virtio_notify(vdev, vq);
+        g_free(elem);
+    }
+}
+
+static void virtio_rtc_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIORtc *vrtc = VIRTIO_RTC(dev);
+
+    virtio_init(vdev, VIRTIO_ID_CLOCK, 0);
+    vrtc->vq = virtio_add_queue(vdev, 64, virtio_rtc_handle_request);
+}
+
+static void virtio_rtc_device_unrealize(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIORtc *vrtc = VIRTIO_RTC(dev);
+
+    virtio_delete_queue(vrtc->vq);
+    virtio_cleanup(vdev);
+}
+
+static uint64_t virtio_rtc_get_features(VirtIODevice *vdev, uint64_t f,
+                                        Error **errp)
+{
+    return f;
+}
+
+static const VMStateDescription vmstate_virtio_rtc = {
+    .name = "virtio-rtc",
+    .minimum_version_id = 1,
+    .version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_VIRTIO_DEVICE,
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void virtio_rtc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    vdc->realize = virtio_rtc_device_realize;
+    vdc->unrealize = virtio_rtc_device_unrealize;
+    vdc->get_features = virtio_rtc_get_features;
+    dc->vmsd = &vmstate_virtio_rtc;
+}
+
+static const TypeInfo virtio_rtc_info = {
+    .name = TYPE_VIRTIO_RTC,
+    .parent = TYPE_VIRTIO_DEVICE,
+    .instance_size = sizeof(VirtIORtc),
+    .class_init = virtio_rtc_class_init,
+};
+
+static void virtio_rtc_register_types(void)
+{
+    type_register_static(&virtio_rtc_info);
+}
+
+type_init(virtio_rtc_register_types)
diff --git a/include/hw/virtio/virtio-rtc.h b/include/hw/virtio/virtio-rtc.h
new file mode 100644
index 0000000000..51aa35201a
--- /dev/null
+++ b/include/hw/virtio/virtio-rtc.h
@@ -0,0 +1,22 @@
+/*
+ * Virtio RTC device
+ *
+ * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_VIRTIO_RTC_H
+#define QEMU_VIRTIO_RTC_H
+
+#include "hw/virtio/virtio.h"
+#include "qom/object.h"
+
+#define TYPE_VIRTIO_RTC "virtio-rtc-device"
+OBJECT_DECLARE_SIMPLE_TYPE(VirtIORtc, VIRTIO_RTC)
+
+struct VirtIORtc {
+    VirtIODevice parent_obj;
+    VirtQueue *vq;
+};
+
+#endif
-- 
MST


