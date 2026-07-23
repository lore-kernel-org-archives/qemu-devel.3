Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32122C531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn1wJ-0004H1-U3; Thu, 23 Jul 2026 18:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wI-0004Ek-SH
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:30:50 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wF-0001PI-TK
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:30:49 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-664ce3000e6so1050572d50.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 15:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784845847; x=1785450647; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AkZeRoc3E17YBp5XADn9w+7xUKDSvBeBFuBZM8xExpk=;
 b=JLCvQEML2N67nXIbDmvDG83TxL1ORPfo4u/7HMj/AEZDVklpmMi6bI7ZGCX/4Eh7FP
 1o9caGa7fY0fG5CT83i1eh51gJ4SxEOkeQTj8niwhOj422PQCHdKmeKXoMr4gh/N0VB1
 ouuDd062voUgIIoqkQlvGdg+fGt5ZfSBd9zf3WuS5u+ZX7JSuGV4flq94xQGXKSBp0na
 c+vKw9ebzlJys5DpqE4IjCavCD/N91SnBOUIXaZFoitpf/1iwA/k65Le2RrhNAMjRwHZ
 L60wGaR3bTsUzjLgnph38X4K+JoyhSB/U8d/4tvlHvr5bCn6Cb3ArlQz8UTkRCkYWXMS
 LgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784845847; x=1785450647;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AkZeRoc3E17YBp5XADn9w+7xUKDSvBeBFuBZM8xExpk=;
 b=AtRFJ1FPvEXetEVdsqKyVdM43aEaUbZJjnA5v9BJJcgtDg9+H1Dz/gH1tkDyoeQImv
 VkqFzJrTL61s/9yfqlZ26eoIEM3F1Au2yzvnFbieiKEb/mlq2QZdTdz94QgMMBYXyT44
 tSn7rQ1NCxtwJiOd9ebHJd8HQOTYpfttogp82N/is9PgHM/ZU7tFCWUuYe/8V+ZFWTE1
 ChxnlQqBRSBbburAnAZSeEaWBKVsHMy+Dtt9WAVNeBknuCiTxfZWr7K9fziCLkyG6JE6
 5IHbnzrvfBCbi5ryPDCLCKiPmgHz7FsRDAsOszfD/I340KtXGOolXICqMlctVbM1/XSj
 v6sg==
X-Gm-Message-State: AOJu0YxlheW6I4WM7bQFxeMwEzTnmFDYQ1vWVy7rw0S5Ck5uuQU3URqV
 sVjg2mBa1UJiBRRR5zoeFJEsaUv9PCMU7LXumK3TQu1VRNDOAGu+IfkP
X-Gm-Gg: AR+sD13ruYRaVCOHOn8lWFDr9axx6E5EWPhyH/KnSMxey51QoSYrJylikdbqKUWr3Ji
 KNBmoo2i1QflVcxA4M4tuZI4eh90/Md8o3nEZWqb+z/oM7f6AjsXNuTeObQ4M5TqpTQIc6A6UGO
 SmfZ2/9Z5IOk58pGcqST81hqyyOeawUI1Ss9HMUNnPd2DZxXZxyYT3N0s3I65QLUx5wJ2Ow6QmT
 71ROof/5+F+GqPc1gpT0Ukg+e+Bf72y1KCyi9XJHYjIZBNYNIa7dEtITpjKR5gcZq0+/ZXhS+Oh
 v1EbX/Ocpb4YLC/6kaoWCKW3iXdg7bzsr/JtEVgZVLpl6kV47+tUOanBGhzw0aGfE4jH+zcVGXY
 4KZkWo+MROCpLte7QRHccnmgiIjf8rG4iqyhxD5iEUQI11erchxlPf6CJXy8+xMw6neSqecx+qY
 7p3bDzCxs=
X-Received: by 2002:a05:690e:2497:b0:668:2353:1585 with SMTP id
 956f58d0204a3-668a4bc2664mr970417d50.13.1784845846663; 
 Thu, 23 Jul 2026 15:30:46 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:446f:49ff:37bd:d45a])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f33c3c1c5sm35766777b3.17.2026.07.23.15.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 15:30:46 -0700 (PDT)
From: ConKite <connorkite@gmail.com>
Date: Thu, 23 Jul 2026 15:30:00 -0700
Subject: [PATCH RFC 01/15] vhost-user: Consolidate chardev property definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-vhost-user-isolated-memory-v1-1-6b97c439eb28@gmail.com>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Haixu Cui <quic_haixcui@quicinc.com>, Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>, 
 Connor Kite <connorkite@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784845839; l=8233;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=y46aEYYWs6g66G1yduLOZWbS9jprmJN0wGotjR+n/g4=;
 b=//WY7dSmSnB3vYw09xpugMmsjQh3QQRotc/Sm/xroedRqBJKHANludIn3yXkteT9VmhDUo2F9
 RgBJ+b+nnEZAzVg7m+KzvXlHZiONuJjhqqtLr7tWJGPc6Oif6hkx8wF
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=connorkite@gmail.com; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move chardev qdev property definitions from children into
VHostUserBase. This reduces code duplication and allows children
to simply inherit the property during initialization.

Signed-off-by: Connor Kite <connorkite@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/vhost-user-base.c        | 9 +++++++++
 hw/virtio/vhost-user-gpio.c        | 4 ----
 hw/virtio/vhost-user-i2c.c         | 5 -----
 hw/virtio/vhost-user-input.c       | 5 -----
 hw/virtio/vhost-user-rng.c         | 5 -----
 hw/virtio/vhost-user-rtc.c         | 4 ----
 hw/virtio/vhost-user-snd.c         | 1 -
 hw/virtio/vhost-user-spi.c         | 5 -----
 hw/virtio/vhost-user-test-device.c | 1 -
 9 files changed, 9 insertions(+), 30 deletions(-)

diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 478ec68f09..90bd2903db 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -407,9 +407,16 @@ static void vub_device_unrealize(DeviceState *dev)
     do_vhost_user_cleanup(vdev, vub);
 }
 
+/*Define common qdev properties.  Inherited by all children*/
+static const Property vub_properties[] = {
+    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev)
+};
+
+
 static void vub_class_init(ObjectClass *klass, const void *data)
 {
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
     vdc->realize = vub_device_realize;
     vdc->unrealize = vub_device_unrealize;
@@ -417,6 +424,8 @@ static void vub_class_init(ObjectClass *klass, const void *data)
     vdc->get_config = vub_get_config;
     vdc->set_config = vub_set_config;
     vdc->set_status = vub_set_status;
+
+    device_class_set_props(dc, vub_properties);
 }
 
 static const TypeInfo vub_types[] = {
diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
index d473f87077..33b8752282 100644
--- a/hw/virtio/vhost-user-gpio.c
+++ b/hw/virtio/vhost-user-gpio.c
@@ -14,9 +14,6 @@
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_gpio.h"
 
-static const Property vgpio_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
-};
 
 static void vgpio_realize(DeviceState *dev, Error **errp)
 {
@@ -42,7 +39,6 @@ static void vu_gpio_class_init(ObjectClass *klass, const void *data)
     VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
 
     dc->vmsd = &vu_gpio_vmstate;
-    device_class_set_props(dc, vgpio_properties);
     device_class_set_parent_realize(dc, vgpio_realize,
                                     &vubc->parent_realize);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
diff --git a/hw/virtio/vhost-user-i2c.c b/hw/virtio/vhost-user-i2c.c
index 152b1f6740..3f5427b5b2 100644
--- a/hw/virtio/vhost-user-i2c.c
+++ b/hw/virtio/vhost-user-i2c.c
@@ -14,10 +14,6 @@
 #include "qemu/error-report.h"
 #include "standard-headers/linux/virtio_ids.h"
 
-static const Property vi2c_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
-};
-
 static void vi2c_realize(DeviceState *dev, Error **errp)
 {
     VHostUserBase *vub = VHOST_USER_BASE(dev);
@@ -42,7 +38,6 @@ static void vu_i2c_class_init(ObjectClass *klass, const void *data)
     VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
 
     dc->vmsd = &vu_i2c_vmstate;
-    device_class_set_props(dc, vi2c_properties);
     device_class_set_parent_realize(dc, vi2c_realize,
                                     &vubc->parent_realize);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
diff --git a/hw/virtio/vhost-user-input.c b/hw/virtio/vhost-user-input.c
index 5cfc5bbb56..8fe6349ffc 100644
--- a/hw/virtio/vhost-user-input.c
+++ b/hw/virtio/vhost-user-input.c
@@ -7,10 +7,6 @@
 #include "qemu/osdep.h"
 #include "hw/virtio/virtio-input.h"
 
-static const Property vinput_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
-};
-
 static void vinput_realize(DeviceState *dev, Error **errp)
 {
     VHostUserBase *vub = VHOST_USER_BASE(dev);
@@ -36,7 +32,6 @@ static void vhost_input_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_vhost_input;
-    device_class_set_props(dc, vinput_properties);
     device_class_set_parent_realize(dc, vinput_realize,
                                     &vubc->parent_realize);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
diff --git a/hw/virtio/vhost-user-rng.c b/hw/virtio/vhost-user-rng.c
index 106c8f211a..664aee403d 100644
--- a/hw/virtio/vhost-user-rng.c
+++ b/hw/virtio/vhost-user-rng.c
@@ -20,10 +20,6 @@ static const VMStateDescription vu_rng_vmstate = {
     .unmigratable = 1,
 };
 
-static const Property vrng_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
-};
-
 static void vu_rng_base_realize(DeviceState *dev, Error **errp)
 {
     VHostUserBase *vub = VHOST_USER_BASE(dev);
@@ -43,7 +39,6 @@ static void vu_rng_class_init(ObjectClass *klass, const void *data)
     VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
 
     dc->vmsd = &vu_rng_vmstate;
-    device_class_set_props(dc, vrng_properties);
     device_class_set_parent_realize(dc, vu_rng_base_realize,
                                     &vubc->parent_realize);
 
diff --git a/hw/virtio/vhost-user-rtc.c b/hw/virtio/vhost-user-rtc.c
index 88b0c70b90..6d80cb6263 100644
--- a/hw/virtio/vhost-user-rtc.c
+++ b/hw/virtio/vhost-user-rtc.c
@@ -19,9 +19,6 @@ static const VMStateDescription vu_rtc_vmstate = {
     .unmigratable = 1,
 };
 
-static const Property vrtc_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
-};
 
 static void vu_rtc_base_realize(DeviceState *dev, Error **errp)
 {
@@ -42,7 +39,6 @@ static void vu_rtc_class_init(ObjectClass *klass, const void *data)
     VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
 
     dc->vmsd = &vu_rtc_vmstate;
-    device_class_set_props(dc, vrtc_properties);
     device_class_set_parent_realize(dc, vu_rtc_base_realize,
                                     &vubc->parent_realize);
 
diff --git a/hw/virtio/vhost-user-snd.c b/hw/virtio/vhost-user-snd.c
index 7129b77d9c..3663450aed 100644
--- a/hw/virtio/vhost-user-snd.c
+++ b/hw/virtio/vhost-user-snd.c
@@ -34,7 +34,6 @@ static const VMStateDescription vu_snd_vmstate = {
 };
 
 static const Property vsnd_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
     DEFINE_PROP_BIT64("controls", VHostUserBase,
                       parent_obj.host_features, VIRTIO_SND_F_CTLS, false),
 };
diff --git a/hw/virtio/vhost-user-spi.c b/hw/virtio/vhost-user-spi.c
index 707f96c250..fb6168d391 100644
--- a/hw/virtio/vhost-user-spi.c
+++ b/hw/virtio/vhost-user-spi.c
@@ -15,10 +15,6 @@
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_spi.h"
 
-static const Property vspi_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
-};
-
 static void vspi_realize(DeviceState *dev, Error **errp)
 {
     VHostUserBase *vub = VHOST_USER_BASE(dev);
@@ -44,7 +40,6 @@ static void vu_spi_class_init(ObjectClass *klass, const void *data)
     VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
 
     dc->vmsd = &vu_spi_vmstate;
-    device_class_set_props(dc, vspi_properties);
     device_class_set_parent_realize(dc, vspi_realize,
                                     &vubc->parent_realize);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
diff --git a/hw/virtio/vhost-user-test-device.c b/hw/virtio/vhost-user-test-device.c
index a2f963fdf6..91e23bf07a 100644
--- a/hw/virtio/vhost-user-test-device.c
+++ b/hw/virtio/vhost-user-test-device.c
@@ -30,7 +30,6 @@ static const VMStateDescription vud_vmstate = {
 };
 
 static const Property vud_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
     DEFINE_PROP_UINT16("virtio-id", VHostUserBase, virtio_id, 0),
     DEFINE_PROP_UINT32("vq_size", VHostUserBase, vq_size, 64),
     DEFINE_PROP_UINT32("num_vqs", VHostUserBase, num_vqs, 1),

-- 
2.43.0


