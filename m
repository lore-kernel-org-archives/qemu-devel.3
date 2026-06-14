Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90192CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqB3-00028w-HO; Sun, 14 Jun 2026 15:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAz-0001sf-6x
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAx-0001w6-6F
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hKLuNmAUmeYJWAvkQ8zFnwwkwbgZSbPam78U8U7/FoM=;
 b=PpyLeajJUTjwMh4tTj5kQFOzixS8RBhnPbbABKJs39RR/ENVV7MZ4v9ybdAkphF27cQJtK
 2kEKSUdUQ3yIxqI1WOtt0XVdNp1bAFxyLNWtVAChnDc+TCvxQ1ZnTAd4l+UbApvacD9RnA
 /y5RjQL5CBgs2q1kj32BJUZ48X+zUiw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-UWh036ZSNQGNV4B4M8PnXg-1; Sun, 14 Jun 2026 15:07:17 -0400
X-MC-Unique: UWh036ZSNQGNV4B4M8PnXg-1
X-Mimecast-MFC-AGG-ID: UWh036ZSNQGNV4B4M8PnXg_1781464036
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490a060eb84so19273885e9.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464036; x=1782068836; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hKLuNmAUmeYJWAvkQ8zFnwwkwbgZSbPam78U8U7/FoM=;
 b=PBTlNis7nVKm0mVJ+qR+RUPcUjZdYCj0q/2BG9ucW24vxqF+9gFEYCryfBv8H6OuY4
 awsfGx8VCfgU48fdndfmhc2plNBUR0bvR0BbzxXUyQK9lRHfz2Ucx52Eizd7KYlrWhZO
 MQT5wkxA14Clyj2gRF2rKBvt2WlqGEzzvLPjCqXCs97Fim1yDAPOvkAXTm2wz9D9OPqd
 L7c+v+8fd5KLwf6MQSnoaOucMGmvA2/4lfSemnRmRkhNIW7QgUC2PgDAeevOlMRO3DBP
 67SZJfhMlKQaxCk1B+IDhYv/PgREuf6ciPHI6NZQpnsGb0kUyPx1UCAbB+9O4uUBvttg
 Z2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464036; x=1782068836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hKLuNmAUmeYJWAvkQ8zFnwwkwbgZSbPam78U8U7/FoM=;
 b=W0FtvGPT6bvWIzWrEMg/nHrQbFgLxSvYiYrMhGlk1GnHqA95qNc5+t4RDJ76thS6OJ
 3D1KYuhGctYssZLMtuH+uEWN4TiK4ni4xH5FCTS+ua8BWoBysWWwf/SFP3jsI+Ol5tNt
 c5upMCqR5npY07cIjyylANsHo+mQ8NUESoRQGBQZxEp7m+Tnd++jyj97g1ZZywqikLLs
 NUs/7VbGyILAjPtDV8oPSj4KYjZOHgncjc/7+E5LbwThqUVO02HfEh0G+c5QP1fW1TE+
 oHEpLERcAv265w3OQZ7p/kIYPBp6GVsGEtYlS0aAG9P3zW3FiLZLYF+siGBngYTYr7uv
 zjRQ==
X-Gm-Message-State: AOJu0YxNeBZ06tMFnP1DyZp2lc3IHh4eZBRAf7xOkDw9vT09p8wCSM8B
 YwD0nBSS+I6C2fpIF8Lq3hSYyDmBRs5alYqjHjy0cy6sjf6H7wLdw3QA3WT1gr27YE++onIwHO7
 nDbzH2CHMLSHZnyPaxlmRfgk7wAVGRdAdF7pzWS74dQUf13nPZlBC+g9ElBc1PQf3qULgZ29jvt
 mVrvJTVuwIq9gNhIDhlntfQmTpQe+54Neo9A==
X-Gm-Gg: Acq92OHVeeB63skip9xHSWVwXq6jMPdUeZhZ/xSY53Qvf4pOUc2/0AXd9WVq9LEO2ia
 QYGmSFeqAelhn9exPDG/MjoEUXgO6lzXzH0bpA39ICPzF2ARCYpR6lrvyNvNMWCSwqtHq6zRLsW
 zkuJ0aohjD1YXOsuD5rG7qFo/t8tGEx4eRH93pf016YPo0+FOtnICsH24HT2633nruGZFaV/QTI
 LVrxlbT7l5bI4A1VlYmPw+L9EOSWvDS8H1yUu+35YXKi2n/cOKkdJnbpD4ZixtntuoVjCUTeQJ2
 zKB0dlcx5VZEQGzk6jsds3UEhR23Yjdi8yky34UaH+1/gvxrKeF6r1ZAICTVELN2ooucaYlyRmK
 zow3Zg6dk0QiNJ1vLtMwBjBl3mtqOnIMk3Quc+/4GYpE=
X-Received: by 2002:a05:600c:190b:b0:490:bcf6:469f with SMTP id
 5b1f17b1804b1-490ec33898fmr140709175e9.0.1781464035502; 
 Sun, 14 Jun 2026 12:07:15 -0700 (PDT)
X-Received: by 2002:a05:600c:190b:b0:490:bcf6:469f with SMTP id
 5b1f17b1804b1-490ec33898fmr140708895e9.0.1781464034946; 
 Sun, 14 Jun 2026 12:07:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922034c1cbsm151813485e9.10.2026.06.14.12.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:07:14 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:07:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>
Subject: [PULL 034/106] virtio: drop *_set_guest_notifier_fd_handler() helpers
Message-ID: <a443f8a671ed7ac8441d3739c42ca7b74433d843.1781463125.git.mst@redhat.com>
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Now they don't make code more readable. Let's better put the whole
logic into virtio_queue_set_guest_notifier().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420200339.708640-9-vsementsov@yandex-team.ru>
---
 hw/virtio/virtio.c | 75 +++++++++++-----------------------------------
 1 file changed, 17 insertions(+), 58 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 3780e86039..fb7f7f0f06 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3836,73 +3836,32 @@ static void virtio_config_guest_notifier_read(EventNotifier *n)
     }
 }
 
-static void virtio_queue_set_guest_notifier_fd_handler(VirtQueue *vq,
-                                                       bool assign,
-                                                       bool with_irqfd)
-{
-    if (assign && !with_irqfd) {
-        event_notifier_set_handler(&vq->guest_notifier,
-                                   virtio_queue_guest_notifier_read);
-    } else {
-        event_notifier_set_handler(&vq->guest_notifier, NULL);
-    }
-    if (!assign) {
-        /* Test and clear notifier before closing it,
-         * in case poll callback didn't have time to run. */
-        virtio_queue_guest_notifier_read(&vq->guest_notifier);
-    }
-}
-
-static void virtio_config_set_guest_notifier_fd_handler(VirtIODevice *vdev,
-                                                 bool assign, bool with_irqfd)
-{
-    EventNotifier *n;
-    n = &vdev->config_notifier;
-    if (assign && !with_irqfd) {
-        event_notifier_set_handler(n, virtio_config_guest_notifier_read);
-    } else {
-        event_notifier_set_handler(n, NULL);
-    }
-    if (!assign) {
-        /* Test and clear notifier before closing it,*/
-        /* in case poll callback didn't have time to run. */
-        virtio_config_guest_notifier_read(n);
-    }
-}
-
-static void virtio_set_guest_notifier_fd_handler(VirtIODevice *vdev,
-                                                 VirtQueue *vq,
-                                                 int n, bool assign,
-                                                 bool with_irqfd)
-{
-    if (n == VIRTIO_CONFIG_IRQ_IDX) {
-        virtio_config_set_guest_notifier_fd_handler(vdev, assign, with_irqfd);
-    } else {
-        virtio_queue_set_guest_notifier_fd_handler(vq, assign, with_irqfd);
-    }
-}
-
 int virtio_set_guest_notifier(VirtIODevice *vdev, int n, bool assign,
                               bool with_irqfd)
 {
-    VirtQueue *vq = NULL;
-    EventNotifier *notifier = NULL;
-
-    if (n == VIRTIO_CONFIG_IRQ_IDX) {
-        notifier = virtio_config_get_guest_notifier(vdev);
-    } else {
-        vq = virtio_get_queue(vdev, n);
-        notifier = virtio_queue_get_guest_notifier(vq);
-    }
+    bool is_config = n == VIRTIO_CONFIG_IRQ_IDX;
+    VirtQueue *vq = is_config ? NULL : virtio_get_queue(vdev, n);
+    EventNotifier *notifier = is_config ?
+        virtio_config_get_guest_notifier(vdev) :
+        virtio_queue_get_guest_notifier(vq);
+    EventNotifierHandler *read_fn = is_config ?
+        virtio_config_guest_notifier_read :
+        virtio_queue_guest_notifier_read;
 
     if (assign) {
         int r = event_notifier_init(notifier, 0);
         if (r < 0) {
             return r;
         }
-        virtio_set_guest_notifier_fd_handler(vdev, vq, n, true, with_irqfd);
-    } else {
-        virtio_set_guest_notifier_fd_handler(vdev, vq, n, false, with_irqfd);
+    }
+
+    event_notifier_set_handler(notifier,
+                               (assign && !with_irqfd) ? read_fn : NULL);
+
+    if (!assign) {
+        /* Test and clear notifier before closing it,*/
+        /* in case poll callback didn't have time to run. */
+        read_fn(notifier);
         event_notifier_cleanup(notifier);
     }
 
-- 
MST


