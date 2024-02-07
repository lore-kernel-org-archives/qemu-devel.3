Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F79EC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 09:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXeD9-0003v5-JZ; Wed, 07 Feb 2024 04:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rXeD6-0003tY-A4
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 04:27:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rXeD3-00039N-Ek
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 04:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707298032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2AHfDip28ceCoNEc/Nk5bgpaUjQg31c33ri4gjGsWyk=;
 b=PsaPQ4sUp0QVnPF/C2ZCsKDLzBM9oOfvNchP+S6F//xoKUZF3kkO+Ca87idG58ZzV2N03r
 3Qed06Am2gg00oWqx6KTEy79C9V/owoy+Iy3FsnmjHHraHWYpg6iZFQdr+6yMkvF0uHnuD
 uCr9aKqj+GU8Me/MC+/PkWG/XXG7h0o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-k-HD7a5YNHqUhOCQTdlH4Q-1; Wed, 07 Feb 2024 04:27:11 -0500
X-MC-Unique: k-HD7a5YNHqUhOCQTdlH4Q-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a3120029877so155158566b.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 01:27:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707298030; x=1707902830;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2AHfDip28ceCoNEc/Nk5bgpaUjQg31c33ri4gjGsWyk=;
 b=vlL+rAsKoyeSrDEFSe+ff5zsGcdOE7y8WOs94x1w7Xl0cpbiremaLY6rQm9Nwa2XR2
 98j8GVKm7i1zlMGeOaCqx8v0UtM6W6QvL0570MWLcuGvUqh1N0YkduflPkiiQnAmm06a
 DEp1GUxBhUEw/pf3pCQYyE/GWVBmPIBqswITsJ1u6J5jd3bZenhNAzI2I46nJR0HU1TM
 0Fosc77z8kA0izQLYTkBfZ6n6K6jY6iQRDABD398WxaA0RJ0HFyRANlmpaUqBKI4WsGN
 W7L1ZEdQmSqeJMKxLQQOT9QB4Lb8Mj5Km/YIHX3unVNyiOf6pcwt6Jm4lQ3DDXYaeiI2
 Rpxg==
X-Gm-Message-State: AOJu0YzwF7rCk4zUqAmMAHpap7uOnwi1LArlXrQH5MH6b6vi/bdMXlxm
 rjl9Emmka9QXKfZRxxIve0qUApEbgQjVoNoiT+BdF0mHD5PGUYhXOqQSYOlECyQyrKc3M0zENp+
 x7PeRUb2O8GloJcjzYTFUJgORHgAL4yXeEBnfUZVkWJhuO51rqoIdT5mMGuUErq29xdWgTV3sbh
 JMvegdOVHmkktRSmKjXq0QMdKlVBXOuvXc2CH2
X-Received: by 2002:a17:906:aac9:b0:a38:4634:b922 with SMTP id
 kt9-20020a170906aac900b00a384634b922mr3282190ejb.34.1707298029819; 
 Wed, 07 Feb 2024 01:27:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaD6Q9PY8w2alrSII+6OoT4DeV1pUsM4kIpmzgchotiRIhUlQaYlyBTnmi0v/xM6W9gt5k7g==
X-Received: by 2002:a17:906:aac9:b0:a38:4634:b922 with SMTP id
 kt9-20020a170906aac900b00a384634b922mr3282168ejb.34.1707298029416; 
 Wed, 07 Feb 2024 01:27:09 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX4hv2Lujo+0aJqlyDG6G9x0zAPdRGxgGutRMPjHcWqlLWATkr1Xh8h4PQJcwEzUK/eY43qI31F4VP4iEE5nf0y5ajYKEDpdpHyj4f9MdX4oT8JeqRkLPN2tQuXDF+ifv2SJPJ3nYyadz2TiSENnAcah0wkP2z57bxDBdU1GWMSsn1kVbr0YIfqwIZhC691Wag=
Received: from localhost.localdomain
 (host-87-12-25-87.business.telecomitalia.it. [87.12.25.87])
 by smtp.gmail.com with ESMTPSA id
 vw4-20020a170907a70400b00a3881262235sm310369ejc.78.2024.02.07.01.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 01:27:08 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, lulu@redhat.com, kwolf@redhat.com, eperezma@redhat.com,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vhost-vdpa: check vhost_vdpa_set_vring_ready() return value
Date: Wed,  7 Feb 2024 10:27:02 +0100
Message-ID: <20240207092702.25242-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

vhost_vdpa_set_vring_ready() could already fail, but if Linux's
patch [1] will be merged, it may fail with more chance if
userspace does not activate virtqueues before DRIVER_OK when
VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated.

So better check its return value anyway.

[1] https://lore.kernel.org/virtualization/20240206145154.118044-1-sgarzare@redhat.com/T/#u

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
Note: This patch conflicts with [2], but the resolution is simple,
so for now I sent a patch for the current master, but I'll rebase
this patch if we merge the other one first.

[2] https://lore.kernel.org/qemu-devel/20240202132521.32714-1-kwolf@redhat.com/
---
 hw/virtio/vdpa-dev.c |  8 +++++++-
 net/vhost-vdpa.c     | 15 ++++++++++++---
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index eb9ecea83b..d57cd76c18 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -259,7 +259,11 @@ static int vhost_vdpa_device_start(VirtIODevice *vdev, Error **errp)
         goto err_guest_notifiers;
     }
     for (i = 0; i < s->dev.nvqs; ++i) {
-        vhost_vdpa_set_vring_ready(&s->vdpa, i);
+        ret = vhost_vdpa_set_vring_ready(&s->vdpa, i);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Error starting vring %d", i);
+            goto err_dev_stop;
+        }
     }
     s->started = true;
 
@@ -274,6 +278,8 @@ static int vhost_vdpa_device_start(VirtIODevice *vdev, Error **errp)
 
     return ret;
 
+err_dev_stop:
+    vhost_dev_stop(&s->dev, vdev, false);
 err_guest_notifiers:
     k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
 err_host_notifiers:
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 3726ee5d67..e3d8036479 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -381,7 +381,10 @@ static int vhost_vdpa_net_data_load(NetClientState *nc)
     }
 
     for (int i = 0; i < v->dev->nvqs; ++i) {
-        vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
+        int ret = vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
+        if (ret < 0) {
+            return ret;
+        }
     }
     return 0;
 }
@@ -1213,7 +1216,10 @@ static int vhost_vdpa_net_cvq_load(NetClientState *nc)
 
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
 
-    vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
+    r = vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
+    if (unlikely(r < 0)) {
+        return r;
+    }
 
     if (v->shadow_vqs_enabled) {
         n = VIRTIO_NET(v->dev->vdev);
@@ -1252,7 +1258,10 @@ static int vhost_vdpa_net_cvq_load(NetClientState *nc)
     }
 
     for (int i = 0; i < v->dev->vq_index; ++i) {
-        vhost_vdpa_set_vring_ready(v, i);
+        r = vhost_vdpa_set_vring_ready(v, i);
+        if (unlikely(r < 0)) {
+            return r;
+        }
     }
 
     return 0;
-- 
2.43.0


