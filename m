Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7CDCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 08:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urY37-0005Uh-3w; Thu, 28 Aug 2025 04:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1urY34-0005Tg-D7
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 04:31:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1urY31-00070j-Ue
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 04:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756369912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u1rna2p3nDzTRf8uRugwMSxuLw11iW+5mAjPFVfB244=;
 b=PpvGZURnTWYAZQykQhF7RKrOgoZaOsuU3ew+WvObCqcUznzwlbTg56jQt58t9Abv9MKWoA
 qwFcI66Otr9GKjljnzBgADx0PLbEqvxL8o3l8O6Jx7dMAS+ZISNdzhbyCJmXtiLHvpDJYG
 B1oibv0PRzebIVqws8YOxqjjgLagBUo=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-8OstTPsLOD-aNaF6Jn4I_Q-1; Thu, 28 Aug 2025 04:31:46 -0400
X-MC-Unique: 8OstTPsLOD-aNaF6Jn4I_Q-1
X-Mimecast-MFC-AGG-ID: 8OstTPsLOD-aNaF6Jn4I_Q_1756369905
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-71d600f9467so8510117b3.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 01:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756369905; x=1756974705;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u1rna2p3nDzTRf8uRugwMSxuLw11iW+5mAjPFVfB244=;
 b=pGqhdEiBWvH1gTE2TtasU7fxdFKLRvzvvWDmtzoj7IC1RRkWIbuo36c3lXW0gsR6Q9
 l5i4/D2O7Ugbgq6euN3MP0fJJA7hE3oo5p7IpRnZYkR+mdCgjP3P7N7tyJgyK1Kvf6v2
 QX1m4Ck8T20v1EStg1ehgKb3t5NaRWIeixS1OCrSIEiPsb3JXqfdn9PCg8O6D/yA5ynu
 fJkHumBAxBnqGgDG3cRv6f2YkKWvwZeuwyCl8/lMh+JQJ0VzjQjcUfiJlk9gsueabC1B
 z/fxxNvDwzgW9+Z7TagKNYqYm3aL7awtWDzbKIQs33x39KTxqSbvwQ2Z+pd9hHou6Z+l
 6uWQ==
X-Gm-Message-State: AOJu0Yxw8oDHX/LdeRifzLRKhd9JXzW1X0wgVHpRtxDe0qQBuZw224xQ
 uKfQoaSbuEl6hYrgeHkO0UJPe9E4LRYFi8UrxMA6o9YyrfvwWg59LnQ+BtiHHVYh9oiFTFXLclj
 TTwjGuH7829K6cPbbEQBI56ThX1LHtyOIVK3qn5seiTpOxrzh3X5DSa+O
X-Gm-Gg: ASbGncu621xBnBXkTM3CASI1LfNTVX+0N6OmEam/46GhzgGYOYd7wYpEk7PsJVjOM99
 Jmmb50RMixnRLqHuicE8x0jqQTxArizbirYsAIczW1CKwHyRkuw+ofL2KVqbj+0hlZmd501rn0m
 FKduiZAs3YN1YdGeT5Np0b84kX/Xlpv/fDRvIShJXfapGj+bW4CrCg+TSbJzo6duKZXZmYF5KFl
 Xxa4RrB7jpK7AOGug9GeD18v8CCnkpQ5TD/nbclblvOp23rJ+C04cW/bxNJfIMIEsDsOmlXwj/j
 g05MyV10ZRTkxHs9YtARGn8qvBCvpAWrOqOnV8aBI0kmmee90wV8JGKmdi5GoCdi6Ts1zli5lmU
 WMrnr5ulamdFq/DY=
X-Received: by 2002:a05:690c:6206:b0:721:5880:6b2 with SMTP id
 00721157ae682-72158800f52mr34200377b3.51.1756369905332; 
 Thu, 28 Aug 2025 01:31:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcOpihqW76xJGlSnqIaMm1wMXRQwApFQ4tgQQYCC6Sgr1aWdK/Bapb5chVNCyHs0YiTErqLg==
X-Received: by 2002:a05:690c:6206:b0:721:5880:6b2 with SMTP id
 00721157ae682-72158800f52mr34200087b3.51.1756369904775; 
 Thu, 28 Aug 2025 01:31:44 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it.
 [79.45.205.118]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71ff18aee78sm37538547b3.57.2025.08.28.01.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 01:31:43 -0700 (PDT)
Date: Thu, 28 Aug 2025 10:31:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] hw/virtio: rename vhost-user-device and make user
 creatable
Message-ID: <esqxhpxnktzn6cvjydryxazzzlyksrlnepmv2a3p352vaf7goy@hs7knct3uk55>
References: <20250820195632.1956795-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250820195632.1956795-1-alex.bennee@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Aug 20, 2025 at 08:56:32PM +0100, Alex Bennée wrote:
>We didn't make the device user creatable in the first place because we
>were worried users might get confused. Rename the device to make its
>nature as a test device even more explicit. While we are at it add a

FYI I just crated this issue https://github.com/rust-vmm/vhost-device/issues/868
since in some device's README we suggest to use `-device 
vhost-user-device-pci` with QEMU (without specifing to patch QEMU to 
enable them). That said, I guess this patch is fine.
I think we can just update the README and suggest to use a new version 
of QEMU.

>Kconfig variable so it can be skipped for those that want to thin out
>their build configuration even further.
>
>Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>---
> docs/system/devices/vhost-user.rst            | 20 +++++++------------
> include/hw/virtio/vhost-user-base.h           |  2 +-
> ...ice-pci.c => vhost-user-test-device-pci.c} | 17 +++++++---------
> ...user-device.c => vhost-user-test-device.c} |  9 +++------
> hw/virtio/Kconfig                             |  5 +++++
> hw/virtio/meson.build                         |  5 +++--
> 6 files changed, 26 insertions(+), 32 deletions(-)
> rename hw/virtio/{vhost-user-device-pci.c => vhost-user-test-device-pci.c} (77%)
> rename hw/virtio/{vhost-user-device.c => vhost-user-test-device.c} (87%)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
>index 35259d8ec7c..bddf8df5ed5 100644
>--- a/docs/system/devices/vhost-user.rst
>+++ b/docs/system/devices/vhost-user.rst
>@@ -62,26 +62,20 @@ platform details for what sort of virtio bus to use.
> The referenced *daemons* are not exhaustive, any conforming backend
> implementing the device and using the vhost-user protocol should work.
>
>-vhost-user-device
>-^^^^^^^^^^^^^^^^^
>+vhost-user-test-device
>+^^^^^^^^^^^^^^^^^^^^^^
>
>-The vhost-user-device is a generic development device intended for
>-expert use while developing new backends. The user needs to specify
>-all the required parameters including:
>+The vhost-user-test-device is a generic development device intended
>+for expert use while developing new backends. The user needs to
>+specify all the required parameters including:
>
>   - Device ``virtio-id``
>   - The ``num_vqs`` it needs and their ``vq_size``
>   - The ``config_size`` if needed
>
> .. note::
>-  To prevent user confusion you cannot currently instantiate
>-  vhost-user-device without first patching out::
>-
>-    /* Reason: stop inexperienced users confusing themselves */
>-    dc->user_creatable = false;
>-
>-  in ``vhost-user-device.c`` and ``vhost-user-device-pci.c`` file and
>-  rebuilding.
>+  While this is a useful device for development it is not recommended
>+  for production use.
>
> vhost-user daemon
> =================
>diff --git a/include/hw/virtio/vhost-user-base.h b/include/hw/virtio/vhost-user-base.h
>index 51d0968b893..387e434b804 100644
>--- a/include/hw/virtio/vhost-user-base.h
>+++ b/include/hw/virtio/vhost-user-base.h
>@@ -44,6 +44,6 @@ struct VHostUserBaseClass {
> };
>
>
>-#define TYPE_VHOST_USER_DEVICE "vhost-user-device"
>+#define TYPE_VHOST_USER_TEST_DEVICE "vhost-user-test-device"
>
> #endif /* QEMU_VHOST_USER_BASE_H */
>diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-test-device-pci.c
>similarity index 77%
>rename from hw/virtio/vhost-user-device-pci.c
>rename to hw/virtio/vhost-user-test-device-pci.c
>index f10bac874e7..d6a9ca2101d 100644
>--- a/hw/virtio/vhost-user-device-pci.c
>+++ b/hw/virtio/vhost-user-test-device-pci.c
>@@ -18,13 +18,13 @@ struct VHostUserDevicePCI {
>     VHostUserBase vub;
> };
>
>-#define TYPE_VHOST_USER_DEVICE_PCI "vhost-user-device-pci-base"
>+#define TYPE_VHOST_USER_TEST_DEVICE_PCI "vhost-user-test-device-pci"
>
>-OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOST_USER_DEVICE_PCI)
>+OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOST_USER_TEST_DEVICE_PCI)
>
> static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> {
>-    VHostUserDevicePCI *dev = VHOST_USER_DEVICE_PCI(vpci_dev);
>+    VHostUserDevicePCI *dev = VHOST_USER_TEST_DEVICE_PCI(vpci_dev);
>     DeviceState *vdev = DEVICE(&dev->vub);
>
>     vpci_dev->nvectors = 1;
>@@ -38,9 +38,6 @@ static void vhost_user_device_pci_class_init(ObjectClass *klass,
>     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
>     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
>
>-    /* Reason: stop users confusing themselves */
>-    dc->user_creatable = false;
>-
>     k->realize = vhost_user_device_pci_realize;
>     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>     pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
>@@ -51,15 +48,15 @@ static void vhost_user_device_pci_class_init(ObjectClass *klass,
>
> static void vhost_user_device_pci_instance_init(Object *obj)
> {
>-    VHostUserDevicePCI *dev = VHOST_USER_DEVICE_PCI(obj);
>+    VHostUserDevicePCI *dev = VHOST_USER_TEST_DEVICE_PCI(obj);
>
>     virtio_instance_init_common(obj, &dev->vub, sizeof(dev->vub),
>-                                TYPE_VHOST_USER_DEVICE);
>+                                TYPE_VHOST_USER_TEST_DEVICE);
> }
>
> static const VirtioPCIDeviceTypeInfo vhost_user_device_pci_info = {
>-    .base_name = TYPE_VHOST_USER_DEVICE_PCI,
>-    .non_transitional_name = "vhost-user-device-pci",
>+    .base_name = TYPE_VHOST_USER_TEST_DEVICE_PCI,
>+    .non_transitional_name = "vhost-user-test-device-pci",
>     .instance_size = sizeof(VHostUserDevicePCI),
>     .instance_init = vhost_user_device_pci_instance_init,
>     .class_init = vhost_user_device_pci_class_init,
>diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-test-device.c
>similarity index 87%
>rename from hw/virtio/vhost-user-device.c
>rename to hw/virtio/vhost-user-test-device.c
>index 3939bdf7552..1b98ea3e488 100644
>--- a/hw/virtio/vhost-user-device.c
>+++ b/hw/virtio/vhost-user-test-device.c
>@@ -1,5 +1,5 @@
> /*
>- * Generic vhost-user-device implementation for any vhost-user-backend
>+ * Generic vhost-user-test-device implementation for any vhost-user-backend
>  *
>  * This is a concrete implementation of vhost-user-base which can be
>  * configured via properties. It is useful for development and
>@@ -25,7 +25,7 @@
>  */
>
> static const VMStateDescription vud_vmstate = {
>-    .name = "vhost-user-device",
>+    .name = "vhost-user-test-device",
>     .unmigratable = 1,
> };
>
>@@ -41,16 +41,13 @@ static void vud_class_init(ObjectClass *klass, const void *data)
> {
>     DeviceClass *dc = DEVICE_CLASS(klass);
>
>-    /* Reason: stop inexperienced users confusing themselves */
>-    dc->user_creatable = false;
>-
>     device_class_set_props(dc, vud_properties);
>     dc->vmsd = &vud_vmstate;
>     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> }
>
> static const TypeInfo vud_info = {
>-    .name = TYPE_VHOST_USER_DEVICE,
>+    .name = TYPE_VHOST_USER_TEST_DEVICE,
>     .parent = TYPE_VHOST_USER_BASE,
>     .class_init = vud_class_init,
> };
>diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
>index 7648a2d68da..10f5c53ac09 100644
>--- a/hw/virtio/Kconfig
>+++ b/hw/virtio/Kconfig
>@@ -126,3 +126,8 @@ config VHOST_USER_SCMI
>     bool
>     default y
>     depends on VIRTIO && VHOST_USER && ARM
>+
>+config VHOST_USER_TEST
>+    bool
>+    default y
>+    depends on VIRTIO && VHOST_USER
>diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
>index 3ea7b3cec83..48b9fedfa56 100644
>--- a/hw/virtio/meson.build
>+++ b/hw/virtio/meson.build
>@@ -22,7 +22,7 @@ if have_vhost
>     system_virtio_ss.add(files('vhost-user-base.c'))
>
>     # MMIO Stubs
>-    system_virtio_ss.add(files('vhost-user-device.c'))
>+    system_virtio_ss.add(when: 'CONFIG_VHOST_USER_TEST', if_true: files('vhost-user-test-device.c'))
>     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('vhost-user-gpio.c'))
>     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true: files('vhost-user-i2c.c'))
>     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user-rng.c'))
>@@ -30,7 +30,8 @@ if have_vhost
>     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files('vhost-user-input.c'))
>
>     # PCI Stubs
>-    system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('vhost-user-device-pci.c'))
>+    system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_TEST'],
>+                         if_true: files('vhost-user-test-device-pci.c'))
>     system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_GPIO'],
>                          if_true: files('vhost-user-gpio-pci.c'))
>     system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_I2C'],
>-- 
>2.47.2
>


