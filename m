Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB02CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UEm-00009R-Gt; Sun, 05 Oct 2025 15:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEe-00089v-CW
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEa-0006VM-Mm
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mfKdz/3nMvjpW+z6FeaL4DezlsHzfdVMCcRVA0zYnAA=;
 b=cKDAsiFkXAvBSauY7NukK7KXanLoQ0J/kv6WVwChaZDI18BDMh3hWX/Wax5IMRsHuJYe77
 +yVJPCcZaik/J9V+5elo/C7DSydwmdQQm47qC1rm+r5lcDhsMypOZJ+9iTDsSsrFGWd0Xp
 oyzTFGROvsmdUJKpFvSzRJPEQ+UC3qU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-4ydYZVfFPM6FRql5mRipXQ-1; Sun, 05 Oct 2025 15:17:24 -0400
X-MC-Unique: 4ydYZVfFPM6FRql5mRipXQ-1
X-Mimecast-MFC-AGG-ID: 4ydYZVfFPM6FRql5mRipXQ_1759691843
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e31191379so26933245e9.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691843; x=1760296643;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mfKdz/3nMvjpW+z6FeaL4DezlsHzfdVMCcRVA0zYnAA=;
 b=frp1CMPhHJdVp5yfFWYAt7sPftTEjaz0xJH2VrPi/0BwPMVWBeB6myvldZOKmrF/FW
 mZr/hTNVMc3M4M7K76m8tJlYB8B8fbmATG7W+4Wv3Bz9uZUsVkSCl55VJDwAFXxFnFRX
 A4BjVmILGie0UWmjZFVEqAlbAAea+wGqV1vk+T0762IGr44I4SNiUNjva14EE3gu2cng
 Va8bwUKIqCJu73jQQ+VBW9X04iumDTqZB3fsxOblhkjiensNInL8AeTYezL8NRNNj40d
 Rz1Icq8/0DQxXAQrvqq5TPT40338z0xvksI6bGjJBX5QTTKmULM9MiyPwRTH9LnWLp40
 d1vg==
X-Gm-Message-State: AOJu0YzvkO+oXxIf31MLwSlPj1NDUR9KPUIvZRLbIUm4VqMZGsIpoOxf
 znxxSXmrHzq2htXB/gv6nDzqvzu6TJq1Gc6LokWXYU1cxtPZKZmzPw1w8DCPhxH1pq31AVNEBLp
 pd9q5TwZt3dbDepI2GIt3w1fWkICKqS/F9dgj/4YWsO7hedDyOm9QHk/mgrVcQDEBVcDl4u6C4N
 7IY8JelvB5cos4gZBrbe5Ewu3Pk+fvZzz/tQ==
X-Gm-Gg: ASbGncuM0FrAO82NM6hGJN/dzb416MrRB5ADL3t1+wI3UMNFh7tdUaS7FyQ0ThRl1Rt
 hkCodLMXkTl7uzQB2JYZwAjdA3S2HtF4ct+pNyAYDJa8k+IcNeiAg3P9jsqLib5pDNjVQzciIoy
 qvB2BkW7EM5mtY+s/pCtUAdqDNZt1jxkMQhPD9IJmW+WhRoZ6fLh9l3Ln15VN+vQLiKvc86KeRz
 Z+K7RphcP2ajwhlHzA+UhsfxkMto3yUyNIMUdWbJpv1zMf9gQeavPFeY3T7onzCNwk29MbVs/61
 oWhuRsb8Fyg7FQNS2hJTVLi53vKB7RMY+zCPeY8=
X-Received: by 2002:a05:600c:a103:b0:46e:731b:db0f with SMTP id
 5b1f17b1804b1-46e731bdd23mr38825605e9.28.1759691842626; 
 Sun, 05 Oct 2025 12:17:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/V5c7E9+JjAlIc9G9YdonWDZA0/PtZBjw04TKhvrfr2K5/2RKowjcleGT+zF8K6V2Mg16RA==
X-Received: by 2002:a05:600c:a103:b0:46e:731b:db0f with SMTP id
 5b1f17b1804b1-46e731bdd23mr38825445e9.28.1759691841958; 
 Sun, 05 Oct 2025 12:17:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a8542sm17438120f8f.9.2025.10.05.12.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:21 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 35/75] hw/virtio: rename vhost-user-device and make user
 creatable
Message-ID: <722e9022a0b6db175209bad75aa52b24033249e3.1759691708.git.mst@redhat.com>
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

From: Alex Bennée <alex.bennee@linaro.org>

We didn't make the device user creatable in the first place because we
were worried users might get confused. Rename the device to make its
nature as a test device even more explicit. While we are at it add a
Kconfig variable so it can be skipped for those that want to thin out
their build configuration even further.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250820195632.1956795-1-alex.bennee@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250901105948.982583-1-alex.bennee@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-user-base.h           |  2 +-
 ...ice-pci.c => vhost-user-test-device-pci.c} | 17 +++++++---------
 ...user-device.c => vhost-user-test-device.c} |  9 +++------
 docs/system/devices/vhost-user.rst            | 20 +++++++------------
 hw/virtio/Kconfig                             |  5 +++++
 hw/virtio/meson.build                         |  5 +++--
 6 files changed, 26 insertions(+), 32 deletions(-)
 rename hw/virtio/{vhost-user-device-pci.c => vhost-user-test-device-pci.c} (77%)
 rename hw/virtio/{vhost-user-device.c => vhost-user-test-device.c} (87%)

diff --git a/include/hw/virtio/vhost-user-base.h b/include/hw/virtio/vhost-user-base.h
index 51d0968b89..387e434b80 100644
--- a/include/hw/virtio/vhost-user-base.h
+++ b/include/hw/virtio/vhost-user-base.h
@@ -44,6 +44,6 @@ struct VHostUserBaseClass {
 };
 
 
-#define TYPE_VHOST_USER_DEVICE "vhost-user-device"
+#define TYPE_VHOST_USER_TEST_DEVICE "vhost-user-test-device"
 
 #endif /* QEMU_VHOST_USER_BASE_H */
diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-test-device-pci.c
similarity index 77%
rename from hw/virtio/vhost-user-device-pci.c
rename to hw/virtio/vhost-user-test-device-pci.c
index f10bac874e..b4ed0efb50 100644
--- a/hw/virtio/vhost-user-device-pci.c
+++ b/hw/virtio/vhost-user-test-device-pci.c
@@ -18,13 +18,13 @@ struct VHostUserDevicePCI {
     VHostUserBase vub;
 };
 
-#define TYPE_VHOST_USER_DEVICE_PCI "vhost-user-device-pci-base"
+#define TYPE_VHOST_USER_TEST_DEVICE_PCI "vhost-user-test-device-pci-base"
 
-OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOST_USER_DEVICE_PCI)
+OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOST_USER_TEST_DEVICE_PCI)
 
 static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
-    VHostUserDevicePCI *dev = VHOST_USER_DEVICE_PCI(vpci_dev);
+    VHostUserDevicePCI *dev = VHOST_USER_TEST_DEVICE_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&dev->vub);
 
     vpci_dev->nvectors = 1;
@@ -38,9 +38,6 @@ static void vhost_user_device_pci_class_init(ObjectClass *klass,
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
 
-    /* Reason: stop users confusing themselves */
-    dc->user_creatable = false;
-
     k->realize = vhost_user_device_pci_realize;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
     pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
@@ -51,15 +48,15 @@ static void vhost_user_device_pci_class_init(ObjectClass *klass,
 
 static void vhost_user_device_pci_instance_init(Object *obj)
 {
-    VHostUserDevicePCI *dev = VHOST_USER_DEVICE_PCI(obj);
+    VHostUserDevicePCI *dev = VHOST_USER_TEST_DEVICE_PCI(obj);
 
     virtio_instance_init_common(obj, &dev->vub, sizeof(dev->vub),
-                                TYPE_VHOST_USER_DEVICE);
+                                TYPE_VHOST_USER_TEST_DEVICE);
 }
 
 static const VirtioPCIDeviceTypeInfo vhost_user_device_pci_info = {
-    .base_name = TYPE_VHOST_USER_DEVICE_PCI,
-    .non_transitional_name = "vhost-user-device-pci",
+    .base_name = TYPE_VHOST_USER_TEST_DEVICE_PCI,
+    .non_transitional_name = "vhost-user-test-device-pci",
     .instance_size = sizeof(VHostUserDevicePCI),
     .instance_init = vhost_user_device_pci_instance_init,
     .class_init = vhost_user_device_pci_class_init,
diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-test-device.c
similarity index 87%
rename from hw/virtio/vhost-user-device.c
rename to hw/virtio/vhost-user-test-device.c
index 3939bdf755..1b98ea3e48 100644
--- a/hw/virtio/vhost-user-device.c
+++ b/hw/virtio/vhost-user-test-device.c
@@ -1,5 +1,5 @@
 /*
- * Generic vhost-user-device implementation for any vhost-user-backend
+ * Generic vhost-user-test-device implementation for any vhost-user-backend
  *
  * This is a concrete implementation of vhost-user-base which can be
  * configured via properties. It is useful for development and
@@ -25,7 +25,7 @@
  */
 
 static const VMStateDescription vud_vmstate = {
-    .name = "vhost-user-device",
+    .name = "vhost-user-test-device",
     .unmigratable = 1,
 };
 
@@ -41,16 +41,13 @@ static void vud_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    /* Reason: stop inexperienced users confusing themselves */
-    dc->user_creatable = false;
-
     device_class_set_props(dc, vud_properties);
     dc->vmsd = &vud_vmstate;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
 
 static const TypeInfo vud_info = {
-    .name = TYPE_VHOST_USER_DEVICE,
+    .name = TYPE_VHOST_USER_TEST_DEVICE,
     .parent = TYPE_VHOST_USER_BASE,
     .class_init = vud_class_init,
 };
diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
index 35259d8ec7..bddf8df5ed 100644
--- a/docs/system/devices/vhost-user.rst
+++ b/docs/system/devices/vhost-user.rst
@@ -62,26 +62,20 @@ platform details for what sort of virtio bus to use.
 The referenced *daemons* are not exhaustive, any conforming backend
 implementing the device and using the vhost-user protocol should work.
 
-vhost-user-device
-^^^^^^^^^^^^^^^^^
+vhost-user-test-device
+^^^^^^^^^^^^^^^^^^^^^^
 
-The vhost-user-device is a generic development device intended for
-expert use while developing new backends. The user needs to specify
-all the required parameters including:
+The vhost-user-test-device is a generic development device intended
+for expert use while developing new backends. The user needs to
+specify all the required parameters including:
 
   - Device ``virtio-id``
   - The ``num_vqs`` it needs and their ``vq_size``
   - The ``config_size`` if needed
 
 .. note::
-  To prevent user confusion you cannot currently instantiate
-  vhost-user-device without first patching out::
-
-    /* Reason: stop inexperienced users confusing themselves */
-    dc->user_creatable = false;
-
-  in ``vhost-user-device.c`` and ``vhost-user-device-pci.c`` file and
-  rebuilding.
+  While this is a useful device for development it is not recommended
+  for production use.
 
 vhost-user daemon
 =================
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 7648a2d68d..10f5c53ac0 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -126,3 +126,8 @@ config VHOST_USER_SCMI
     bool
     default y
     depends on VIRTIO && VHOST_USER && ARM
+
+config VHOST_USER_TEST
+    bool
+    default y
+    depends on VIRTIO && VHOST_USER
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 3ea7b3cec8..48b9fedfa5 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -22,7 +22,7 @@ if have_vhost
     system_virtio_ss.add(files('vhost-user-base.c'))
 
     # MMIO Stubs
-    system_virtio_ss.add(files('vhost-user-device.c'))
+    system_virtio_ss.add(when: 'CONFIG_VHOST_USER_TEST', if_true: files('vhost-user-test-device.c'))
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('vhost-user-gpio.c'))
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true: files('vhost-user-i2c.c'))
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user-rng.c'))
@@ -30,7 +30,8 @@ if have_vhost
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files('vhost-user-input.c'))
 
     # PCI Stubs
-    system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('vhost-user-device-pci.c'))
+    system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_TEST'],
+                         if_true: files('vhost-user-test-device-pci.c'))
     system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_GPIO'],
                          if_true: files('vhost-user-gpio-pci.c'))
     system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_I2C'],
-- 
MST


