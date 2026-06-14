Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA42CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqBQ-0003Av-WD; Sun, 14 Jun 2026 15:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBP-00035n-FU
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBN-000227-SR
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N+FoHQ4zhVNsmAgFquV7vxNfd5ZYY6tnJT/LNwUhRdU=;
 b=MjbOmdHxtzDql8ogZ+Pvx56mOTJWkIXoekNstcdQ/ghuU+30oQSbjA4x0CFwSaRE322E+V
 KYJqph87huaqPhrZKrwbplfFh71DxUBQzXSh+Ljqf05SQgexgkN0ZGUbT8th/tqVCjZgTj
 c7+k9j2PDmMyLO7mxdyEiN/Xcbtu46g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-5_ebVQgRMFGQyj6RS5N6og-1; Sun, 14 Jun 2026 15:07:42 -0400
X-MC-Unique: 5_ebVQgRMFGQyj6RS5N6og-1
X-Mimecast-MFC-AGG-ID: 5_ebVQgRMFGQyj6RS5N6og_1781464061
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490a767c7dcso16786515e9.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464061; x=1782068861; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N+FoHQ4zhVNsmAgFquV7vxNfd5ZYY6tnJT/LNwUhRdU=;
 b=plRQqSgaMJ5BXv0J19CHoXchd6MUFE53xDpt0b9QwsEx8wcFjrAITUkT+WW8oDtuQT
 ZK7M4MxCBjLulPqXgzuoAqNcCdwg9Q2Z1EzpPxRth6jN8dx3Bdw51/S98ytiPjChFmR2
 b4ewylr1W6OrjTkoebXPDw9N76mUq7u+RZ3mXtufw3l3WRdf58tofkxdMeCs4sVD/6SO
 m/XLBpbxxGlSAieDihJXrmJf+LnbMMDMx+tLfDULfPSLsaa9bXf9B6vU+S1oy30M1QsU
 5D9fyMWjmAGnDMvAQHpr2w4zllnMrAWtNZfEJtmhArgUu9zK/MPSOtZWvB3rRgF60Gsg
 WWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464061; x=1782068861;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N+FoHQ4zhVNsmAgFquV7vxNfd5ZYY6tnJT/LNwUhRdU=;
 b=H4O92UeDkH10ykT2HS8IrEC8gKdBU2O94JvhtOqd/NFfpajDS1Qhu0uS20St6Qrzie
 2GDwjcAn3t5Y9jn240QN/Vo/IPI/KpJt6TANssgBhaXdaZ4cUrmom9w+AlPFKbCiOJpH
 p/RshrzmM2s+2xGM7N7JnbF+FYPfHqoxn1h8FixsmOLFZDwE/6iWEu83h3vpXGYtXTqS
 2T5WDi9zwcNySdQyto4DSSwfi176vOGns9gbkkXbDeSsG3fRcaT9+6uwv90iG1Rc893I
 6AuFv2U7caXl2pra7AIiut5qZfcvoDeWQ1Ku1mDDkfQU5ONi8GRWW0Ewm2fWeMFmbTZD
 5Bkw==
X-Gm-Message-State: AOJu0YwMPDJQ/BWpXsQofjyd3IBZmXhU1R4UXoZRzJS/GWO76+06LV2l
 Wf47ECtAaLNb9LRhIKQaTzNQZD0fMmlDF3HFMwIOc4uWd7rO14GffDpzO9oAFOotbMQPqhkRQ5V
 R6FstIjB3v5EpBbTOLgVW4QSToJODGPb55YyYqrNouZmKY7sub37UtxIs40Jq4+aNMseOdP4D2o
 07HLKNll64XE+xK84l5UaOpDXJDSF/kUPXKQ==
X-Gm-Gg: Acq92OFPRzKCs6EjzDeBkwklum6sQirnkuDEMkNH5PaA3v2xOH51G5y7rQ2xz9eTylc
 HrsJRzVYuYV/e2rrUsw7BCo3pUeYB5lPjmydgP6yoEXwRfYGXCgey3KUKLeNHObbm64y/S+I3ni
 ir1E1NAPr5OuYCUcTvGBmVYM2VdD+WXFRiHC0cfrBgOTNjeaX1FrKCAHMvaf51ZF9+UORFW5YNI
 GQIphss6HEGnFPxRzdkh/noLrCyGriOfSh4i51NLZQjAcsTTZkS45vfDqohbHHYwElQhH67TX4C
 2eBK8e8qCEIGzNwUS5IPdobV55VxJiye3FIMb7qeN+YPX+QGbeKAx1Puacd394zmgWPCGobJk/U
 R8AZF+9bCbSURhEvKVTCjRPFWc0Th1eAbUQJ5ZUE4V24=
X-Received: by 2002:a05:600c:3650:b0:490:d354:bd0a with SMTP id
 5b1f17b1804b1-49220143bd1mr64997955e9.31.1781464061069; 
 Sun, 14 Jun 2026 12:07:41 -0700 (PDT)
X-Received: by 2002:a05:600c:3650:b0:490:d354:bd0a with SMTP id
 5b1f17b1804b1-49220143bd1mr64997745e9.31.1781464060653; 
 Sun, 14 Jun 2026 12:07:40 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492202e5d61sm170264725e9.1.2026.06.14.12.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:07:40 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:07:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>, Lei Yang <leiyang@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 043/106] vhost: move busyloop timeout initialization to
 vhost_virtqueue_init()
Message-ID: <2c943949d76b9b273de1e4b0f42d3671b8240a37.1781463125.git.mst@redhat.com>
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

Let's all per-virtqueue initializations be in one place.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420200339.708640-18-vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 7f370f393e..55ce7ae977 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1496,7 +1496,8 @@ static void vhost_virtqueue_error_notifier(EventNotifier *n)
 }
 
 static int vhost_virtqueue_init(struct vhost_dev *dev,
-                                struct vhost_virtqueue *vq, int n)
+                                struct vhost_virtqueue *vq, int n,
+                                bool busyloop_timeout)
 {
     int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, n);
     struct vhost_vring_file file = {
@@ -1533,6 +1534,14 @@ static int vhost_virtqueue_init(struct vhost_dev *dev,
                                    vhost_virtqueue_error_notifier);
     }
 
+    if (busyloop_timeout) {
+        r = vhost_virtqueue_set_busyloop_timeout(dev, n, busyloop_timeout);
+        if (r < 0) {
+            VHOST_OPS_DEBUG(r, "Failed to set busyloop timeout");
+            goto fail_err;
+        }
+    }
+
     return 0;
 
 fail_err:
@@ -1611,24 +1620,14 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     }
 
     for (i = 0; i < hdev->nvqs; ++i, ++n_initialized_vqs) {
-        r = vhost_virtqueue_init(hdev, hdev->vqs + i, hdev->vq_index + i);
+        r = vhost_virtqueue_init(hdev, hdev->vqs + i, hdev->vq_index + i,
+                                 busyloop_timeout);
         if (r < 0) {
             error_setg_errno(errp, -r, "Failed to initialize virtqueue %d", i);
             goto fail;
         }
     }
 
-    if (busyloop_timeout) {
-        for (i = 0; i < hdev->nvqs; ++i) {
-            r = vhost_virtqueue_set_busyloop_timeout(hdev, hdev->vq_index + i,
-                                                     busyloop_timeout);
-            if (r < 0) {
-                error_setg_errno(errp, -r, "Failed to set busyloop timeout");
-                goto fail;
-            }
-        }
-    }
-
     virtio_features_copy(hdev->_features_ex, features);
 
     hdev->memory_listener = (MemoryListener) {
-- 
MST


