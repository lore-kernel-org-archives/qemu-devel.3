Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6D9C531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn1wn-0004yv-LC; Thu, 23 Jul 2026 18:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wj-0004sk-Te
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:31:18 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wi-0001T9-9a
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:31:17 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-81e6f0b4610so8057007b3.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 15:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784845875; x=1785450675; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3daCLJ1kp7Y+iaqF144Ru8UeiZ4TA3+qTjsGJpJy0rA=;
 b=JYm9QQgyM5B1wbX3K+gpxBgJPnLd6sKHHh8gxuaBQNn8M9SNLAWF9lp5G7ptYqMjQL
 U+JTkWCzeOlR7qneUbqVz8Zr/GvYCuajyx+TwkbbnG8AWlwj0YHGFu1UfiS0pAHlpWq4
 tY7KB1xn9G0s842pJdUYAY2bW78JThq1EAajViqVoC+IT5ouWqYGOilfdvaKWmXUubZP
 T2lJuZl6JC0GO2ILs+YYHrinq92oiirIbW933Kb5aTGToQulk7YfyUrz3Xnqxol4frKC
 op+/tlDuOZfwFQRTReYqLrCQAG939bhezDOEkou9jE+NZcCJQQaq6joB1AvICoXL92kh
 UX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784845875; x=1785450675;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3daCLJ1kp7Y+iaqF144Ru8UeiZ4TA3+qTjsGJpJy0rA=;
 b=GgEJ/KK4m7T7f0oSIpJJQ3jxV9rI4HZgD7kazZbbkaKEW/OvlWbwHuNRrBm7dAAACN
 5Xm7BWDeBuatEkR3PWMCSkDK96ttFn3k+qrePgXyRHED3+GQGEnUUy2PSAqz3/FkL6Jj
 jWFLvEL8iBsA+mEqelK2Lqgf2Cxhae+zfEAdvYICwTO5jq60V84Z7pF905qQuPBz04Q/
 HJDZWkD6gHNUOh2xWwqzOHjFky/5SI9wXgq5NbS6jwAfUSkW7S/A+2Ykqsa6Kj67h/UB
 p9uFSahC1pX9geigmRSc814ECpNr3410jKxqD9/Iq3ZEZQE1axc+edIcWlF50SjpSzhr
 LHHg==
X-Gm-Message-State: AOJu0YwYQ5ES94j+6gLP7goZYqKU8F1CQvkBfJHSgBdAO/h6diV7xPIO
 fuLQ1pTEB9U1HT4O5hMfn3Q9uCjT9tMLIdXiGSuWheWcrIBGgKTHdIF9
X-Gm-Gg: AR+sD11ak1wTrQ48LzAUVe6yW4dSduSEyvx78sJJOYu/RCLyAFbjV36zIZW3Jh0e9nO
 2XiKAW/cW0g5d8JpG6HA4MzoGpUdNrlDkXkji0roZ8z/wQNK4m5es/MbgZfB6xaoGPHaT/yTiJ2
 6rurDDD1bu2+Rg9YopllTpJiMJbD0q6dE+XXvk/piTL96bwnzD1ebuO4XVMvgQmhVqUxZpkNUaW
 6aIv1/67Zpga8FiOR9PUZdafElRqQGhY/9IuN3lOa2SJ/rzICEvAYlzFPGvthHpDxi3jvz2oVSO
 P6nNg+UHbYm5y9LvP3pv/WVB3HQeCRYpzVUxs1U9Q2JwXeoDETjz8vNSROvmf7vzCfnK+n2bSAs
 XMkEym7jQ90bSIxahbA4j3UZyTwA2/9RdpN7JIYj7OPh5PP12PYLfQ1gMWlzqaDfBljI+u52f1e
 0OtSXSOXOD4YtBD7N9xw==
X-Received: by 2002:a05:690c:c4e4:b0:81e:edfb:3194 with SMTP id
 00721157ae682-81f4c351402mr14830007b3.59.1784845875169; 
 Thu, 23 Jul 2026 15:31:15 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:446f:49ff:37bd:d45a])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f33c3c1c5sm35766777b3.17.2026.07.23.15.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 15:31:14 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
Date: Thu, 23 Jul 2026 15:30:08 -0700
Subject: [PATCH RFC 09/15] hw/virtio/vhost-shadow-virtqueue: specified
 vring placement
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-vhost-user-isolated-memory-v1-9-6b97c439eb28@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784845839; l=3241;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=jUAZQS3R6KxjXedQOFVXhZurjmT2dN3NOYDdWrU4F2s=;
 b=IWJbWb4oHeq4FxWn0jL2j3GKcWqBbUU4hHnG/ZyZI07odrLByCvEjJtwoFfYsgny3mm4atw8s
 /1LXUxIIArRCuPgCozwIugnJKZV1NTK95p5EDr/SbrWDmNMoWG6Tvc6
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=connorkite@gmail.com; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

By default svq vrings are placed in an anonymous memory map. As svqs
will be leveraged to enable memory isolation in vhost-user, it is useful
to be able to place the vrings in a shared isolation memory region.

Adds the option to specify vring placement by providing a vring base
address before starting the svq.

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 22 +++++++++++++++-------
 hw/virtio/vhost-shadow-virtqueue.h |  3 +++
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index eb86c1ee37..9e3c359f50 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -857,14 +857,21 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
 
     svq->vring.num = virtio_queue_get_num(vdev, virtio_get_queue_index(vq));
     svq->num_free = svq->vring.num;
-    svq->vring.desc = mmap(NULL, vhost_svq_driver_area_size(svq),
-                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
-                           -1, 0);
     desc_size = sizeof(vring_desc_t) * svq->vring.num;
-    svq->vring.avail = (void *)((char *)svq->vring.desc + desc_size);
-    svq->vring.used = mmap(NULL, vhost_svq_device_area_size(svq),
-                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
-                           -1, 0);
+    if (svq->base_addr == NULL) {
+        svq->vring.desc = mmap(NULL, vhost_svq_driver_area_size(svq),
+                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
+                            -1, 0);
+        svq->vring.avail = (void *)((char *)svq->vring.desc + desc_size);
+        svq->vring.used = mmap(NULL, vhost_svq_device_area_size(svq),
+                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
+                            -1, 0);
+    } else {
+        svq->vring.desc = (void *) svq->base_addr;
+        svq->vring.avail = (void *)((char *)svq->vring.desc + desc_size);
+        svq->vring.used = (void *)((char *)svq->base_addr +
+                          vhost_svq_driver_area_size(svq));
+    }
     svq->desc_state = g_new0(SVQDescState, svq->vring.num);
     if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_IN_ORDER)) {
         svq->batch_last.id = VIRTIO_RING_NOT_IN_BATCH;
@@ -929,6 +936,7 @@ VhostShadowVirtqueue *vhost_svq_new(const VhostShadowVirtqueueOps *ops,
     event_notifier_init_fd(&svq->svq_kick, VHOST_FILE_UNBIND);
     svq->ops = ops;
     svq->ops_opaque = ops_opaque;
+    svq->base_addr = NULL;
     return svq;
 }
 
diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index ccfeee36d7..39f69e6455 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -148,6 +148,9 @@ typedef struct VhostShadowVirtqueue {
 
     /* Size of SVQ vring free descriptors */
     uint16_t num_free;
+
+    /* Location assigned to vrings if not in default anon memory map*/
+    hwaddr *base_addr;
 } VhostShadowVirtqueue;
 
 bool vhost_svq_valid_features(uint64_t features, Error **errp);

-- 
2.43.0


