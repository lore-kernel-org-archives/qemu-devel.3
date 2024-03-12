Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A13C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAag-0006i1-M6; Tue, 12 Mar 2024 18:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAaZ-0005bo-RZ
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAaX-0004MR-Nt
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E/KhWbfbprqpAcQoWcPKeg1kaPY6b8jfhMedPQoGKm8=;
 b=iC1cdtnfNXiGKwMaCc9Kru5rtNL7QUCcG0FoTiEX3XDMlVgqSp33rPEs1L0DzdZfbef0Gf
 bJdnJeqaBZZo341zTY8hfjJKVM7ihuZorBJ6t31oYl4h7PhJBECWWjvKuhyQNsq/VKBfCw
 4r0Oy19GrZ5+/jJSXOIbd+BvpBW3AIU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-tQTwYCJ7MUKcnc-jK0zWFQ-1; Tue, 12 Mar 2024 18:27:11 -0400
X-MC-Unique: tQTwYCJ7MUKcnc-jK0zWFQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-513b2e92c19so2692681e87.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282430; x=1710887230;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E/KhWbfbprqpAcQoWcPKeg1kaPY6b8jfhMedPQoGKm8=;
 b=gpICx4q33SRuXyp2KQQleH+R/O+8bshcDWSFjYhqvaQ4rHfiMaXH4nzPz70Xdqw/RJ
 i5/JaDc17K+rGM3zJSP0tBC/It1krZZA9pDa64Ry93mQQHEuW7LwxErj/6d9xML6YW6t
 sMOQUTzXDUmdEKk9JV7pBv6Jjm4k2mMqp7k6DXSvFPkxFLHUPXQCLa9TPZ2MNIK8LQNq
 71t50Hcopo4DW2w87NRleovbh/oHodWGmRhYFWg+z+/7u7ZnUsMoDtXIJtxZcRxUmMaV
 4gWbmXEh1sGdx9UbrpGSjppItx3rqgCinkJ57i5kXrE35fxoLxEpf5zrfnGYO8I6lZjZ
 7BkA==
X-Gm-Message-State: AOJu0YzvxtMYys6fM8JfdfNVnb0t714JL1NIZZMXzRCJ7ozE7fi2Mf15
 5eIO9RIHR7HGGePFOmPjwDEUiU8059rW0yuhI30ueXJ9aBJkw8HB+Maf7najjOz1QxQ34pI/FqS
 YoXHph6gvJH8BNgLVh2jCuAR7akO1m786y+nXLsxeEdpIDJ1EQU1wkRZ3OFS0lqlwLKYq6QnbfH
 1Zd9fm0WhzDd9Z0QEBimvUbaDzLTRxKD4b
X-Received: by 2002:a19:7607:0:b0:513:1561:af08 with SMTP id
 c7-20020a197607000000b005131561af08mr6854754lff.60.1710282429658; 
 Tue, 12 Mar 2024 15:27:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKgJmjKml6kZ20bxUvmvsQSjKMsRjxuZ3sy0MwxgT1LG4tuunvV/OHWfgWZQN60VvmzpRn1Q==
X-Received: by 2002:a19:7607:0:b0:513:1561:af08 with SMTP id
 c7-20020a197607000000b005131561af08mr6854742lff.60.1710282429129; 
 Tue, 12 Mar 2024 15:27:09 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 k13-20020a1709065fcd00b00a44f0d99d58sm4209874ejv.208.2024.03.12.15.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:27:08 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:27:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Albert Esteve <aesteve@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 31/68] hw/virtio: check owner for removing objects
Message-ID: <043e127a126bb3ceb5fc753deee27d261fd0c5ce.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Albert Esteve <aesteve@redhat.com>

Shared objects lack spoofing protection.
For VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE messages
received by the vhost-user interface, any backend was
allowed to remove entries from the shared table just
by knowing the UUID. Only the owner of the entry
shall be allowed to removed their resources
from the table.

To fix that, add a check for all
*SHARED_OBJECT_REMOVE messages received.
A vhost device can only remove TYPE_VHOST_DEV
entries that are owned by them, otherwise skip
the removal, and inform the device that the entry
has not been removed in the answer.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20240219143423.272012-2-aesteve@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c      | 21 +++++++++++++++++++--
 docs/interop/vhost-user.rst |  4 +++-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index a1eea8547e..9d654efd3d 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1611,11 +1611,27 @@ vhost_user_backend_handle_shared_object_add(struct vhost_dev *dev,
 }
 
 static int
-vhost_user_backend_handle_shared_object_remove(VhostUserShared *object)
+vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,
+                                               VhostUserShared *object)
 {
     QemuUUID uuid;
 
     memcpy(uuid.data, object->uuid, sizeof(object->uuid));
+    switch (virtio_object_type(&uuid)) {
+    case TYPE_VHOST_DEV:
+    {
+        struct vhost_dev *owner = virtio_lookup_vhost_device(&uuid);
+        if (dev != owner) {
+            /* Not allowed to remove non-owned entries */
+            return 0;
+        }
+        break;
+    }
+    default:
+        /* Not allowed to remove non-owned entries */
+        return 0;
+    }
+
     return virtio_remove_resource(&uuid);
 }
 
@@ -1794,7 +1810,8 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
         ret = vhost_user_backend_handle_shared_object_add(dev, &payload.object);
         break;
     case VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE:
-        ret = vhost_user_backend_handle_shared_object_remove(&payload.object);
+        ret = vhost_user_backend_handle_shared_object_remove(dev,
+                                                             &payload.object);
         break;
     case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
         ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index d1ed39dfa0..d8419fd2f1 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -1839,7 +1839,9 @@ is sent by the front-end.
   When the ``VHOST_USER_PROTOCOL_F_SHARED_OBJECT`` protocol
   feature has been successfully negotiated, this message can be submitted
   by the backend to remove themselves from to the virtio-dmabuf shared
-  table API. The shared table will remove the back-end device associated with
+  table API. Only the back-end owning the entry (i.e., the one that first added
+  it) will have permission to remove it. Otherwise, the message is ignored.
+  The shared table will remove the back-end device associated with
   the UUID. If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and the
   back-end sets the ``VHOST_USER_NEED_REPLY`` flag, the front-end must respond
   with zero when operation is successfully completed, or non-zero otherwise.
-- 
MST


