Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19C2D1CDA1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 06:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t38i1-0008RA-Qj; Tue, 22 Oct 2024 02:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t38hw-0008QO-41
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 02:49:32 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t38hu-0006C9-AD
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 02:49:31 -0400
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a39cabb9b8so18002945ab.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 23:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729579767; x=1730184567;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xtxi+373Xn3WrnjU6r1osJNLDcoJXZeTp5+73x6cVVA=;
 b=0Xc5Thq585tt9n+RY0HZtT57NbssBIGxPwuvfZeQiZk7TfvlkCqul+mm3hmjfkdq3s
 rur0iTCX39wnFtJp2CLpgcG0yrresmuK/ci5GTlJ4jdEwlPprS/9K7EPykF6PEDFJHW6
 Zy/xWOjlyMcBnMOvEGhKgW2NSEW7uzQp0O3KByIQyCe60ZoIK6ytRGcHGsw7TZDyOs3X
 2VWdEfOHZD2SH0hqN1MiuOsckhMfYlD7d5uFnXtWilrRG2AKf5g8JBuxAT3l/OKL8lMJ
 ISsUfaEkAGTyQgKLIqdBKkkEDtaHnul3Q3clxjqgGZzUHLrZiGo1OnZkpYbtrafB8Apb
 g9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729579767; x=1730184567;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xtxi+373Xn3WrnjU6r1osJNLDcoJXZeTp5+73x6cVVA=;
 b=rviqTVKH0jXWJlwcJ+J+Gy6fFQ6cxJ6gkJx+0wnHwRySdNOTtPaPFoXod6b5fLuNKs
 P+d7if74u3uJsP2QpDsrQoY2dsQzdj0jQxRmzpywMx9zIU4BREak1KwSYiEBUrGYX4vk
 dfbK89EhQLqwkfmIZOQs5H0skg/Ab+OM0EtoG97Oy5FwCPKUZ0hhMTg1RUO2sRvUMw/O
 +rq1+Lssgp/JBadzvvTTsjE1kRPTnMHwZn3wvHm8ZMQa6jmYHi7EBqw4I0uPSdPZqJAn
 kOnKy27OevvGvdaTEW0Pcdj2r7cxezKYCpiiNl2igjp1zUOCS74dgA93xbU2NZ17aekG
 WfAA==
X-Gm-Message-State: AOJu0Yz7jHUzUxh3pvOBQT8jz70paM7nioZa5ejtHaVzbd+p8SAHY316
 kYd7wDj/YYJJq4kVxlEqH3ErsqWOQVoZnk52CEDkQG835SdYlQ62+oN+e9TACLA=
X-Google-Smtp-Source: AGHT+IFrYXzQNWryjLpxGyOPNSeWfZjxLFnqAicOdLbTowAN6ez9UJlcnTQ8cHCshpAVxRSvZ/wJMg==
X-Received: by 2002:a92:cda4:0:b0:3a3:b4ec:b3f1 with SMTP id
 e9e14a558f8ab-3a3f40ab54cmr125363275ab.17.1729579767447; 
 Mon, 21 Oct 2024 23:49:27 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-7eaeabb8ff3sm4211541a12.69.2024.10.21.23.49.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 23:49:27 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 22 Oct 2024 15:49:01 +0900
Subject: [PATCH] virtio-net: Add queues before loading them
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-load-v1-1-99df0bff7939@daynix.com>
X-B4-Tracking: v=1; b=H4sIANxKF2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0Nz3Zz8xBTdtCRTUxMTE1OzFCMLJaDSgqLUtMwKsDHRsbW1AL4jcrt
 WAAAA
To: Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::129;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x129.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

Call virtio_net_set_multiqueue() to add queues before loading their
states. Otherwise the loaded queues will not have handlers and elements
in them will not be processed.

Cc: qemu-stable@nongnu.org
Fixes: 8c49756825da ("virtio-net: Add only one queue pair when realizing")
Reported-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/virtio/virtio.h |  2 ++
 hw/net/virtio-net.c        | 10 ++++++++++
 hw/virtio/virtio.c         |  7 +++++++
 3 files changed, 19 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index f526ecc8fcc0..638691028050 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -210,6 +210,8 @@ struct VirtioDeviceClass {
     void (*guest_notifier_mask)(VirtIODevice *vdev, int n, bool mask);
     int (*start_ioeventfd)(VirtIODevice *vdev);
     void (*stop_ioeventfd)(VirtIODevice *vdev);
+    /* Called before loading queues. Useful to add queues before loading. */
+    int (*pre_load_queues)(VirtIODevice *vdev);
     /* Saving and loading of a device; trying to deprecate save/load
      * use vmsd for new devices.
      */
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index fb84d142ee29..c467ef130016 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3032,6 +3032,15 @@ static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue)
     virtio_net_set_queue_pairs(n);
 }
 
+static int virtio_net_pre_load_queues(VirtIODevice *vdev)
+{
+    virtio_net_set_multiqueue(VIRTIO_NET(vdev),
+                              virtio_has_feature(vdev->guest_features, VIRTIO_NET_F_RSS) ||
+                              virtio_has_feature(vdev->guest_features, VIRTIO_NET_F_MQ));
+
+    return 0;
+}
+
 static int virtio_net_post_load_device(void *opaque, int version_id)
 {
     VirtIONet *n = opaque;
@@ -4025,6 +4034,7 @@ static void virtio_net_class_init(ObjectClass *klass, void *data)
     vdc->guest_notifier_mask = virtio_net_guest_notifier_mask;
     vdc->guest_notifier_pending = virtio_net_guest_notifier_pending;
     vdc->legacy_features |= (0x1 << VIRTIO_NET_F_GSO);
+    vdc->pre_load_queues = virtio_net_pre_load_queues;
     vdc->post_load = virtio_net_post_load_virtio;
     vdc->vmsd = &vmstate_virtio_net_device;
     vdc->primary_unplug_pending = primary_unplug_pending;
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index a26f18908ea5..f12c4aa81eb5 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3255,6 +3255,13 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         config_len--;
     }
 
+    if (vdc->pre_load_queues) {
+        ret = vdc->pre_load_queues(vdev);
+        if (ret) {
+            return ret;
+        }
+    }
+
     num = qemu_get_be32(f);
 
     if (num > VIRTIO_QUEUE_MAX) {

---
base-commit: 7e3b6d8063f245d27eecce5aabe624b5785f2a77
change-id: 20241017-load-fb5544456d28

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


