Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE20CCCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 16:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBbdH-0001CK-4t; Wed, 22 Oct 2025 12:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmaglione@redhat.com>)
 id 1vBbdF-0001C9-IJ
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 12:24:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmaglione@redhat.com>)
 id 1vBbdD-0001yf-7A
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 12:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761150250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BhCoB7kpxWSu7IUPBewvXVV8G2oilzloaR4zlKcUl10=;
 b=a40r0n1Am5F+qEVN+uXFerJNUO8hr/KJBZmJzfRCtRRZiZ5q6gdRRatb+j++wX/N98WEzi
 yASGUyCb4omv//pBZ/OdHEbbyaLHmjEAv1ypSlBWJETeUhE+RbJdBOnjzB9iYCtx86vIfh
 +iSUeL7feeb9QIjwxS3sHjFQCZaCYDo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-YVKkfr_uPumusiYHBExiqA-1; Wed, 22 Oct 2025 12:24:09 -0400
X-MC-Unique: YVKkfr_uPumusiYHBExiqA-1
X-Mimecast-MFC-AGG-ID: YVKkfr_uPumusiYHBExiqA_1761150248
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-471005f28d2so27154365e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 09:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761150248; x=1761755048;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BhCoB7kpxWSu7IUPBewvXVV8G2oilzloaR4zlKcUl10=;
 b=oWGcrIJrvoWnjQcA6Zo2Y/NGvF3VFRb/Tjgf+bUfdwG9iGBCS3iS115YYMXJ2HVclU
 SlJMnnHwfDbKaPxqjMQX5tH8yoryAHiT76DJbA7Bxb1zLAAR5VD7i707Vf1rU3KSLFI5
 QfBia6T7bFw/6e2EBaUIQYGD8o+QSAlUyfTKO5C3FUKhcTB7rhcf6ZHM8J2+zBjIx8dv
 52hqepbYqvgEjb75BpE2V61dWhSOdqO+cZdfYe6B3YLR38c+KNXJhPzULK4c5R1vwtzB
 SX9JQR47zkp7CCqNKpo6m8cbzKxtE/cYCgjGesHmWnB4RiAwXAsnu8km7gXSh6Dz0YRu
 NYvA==
X-Gm-Message-State: AOJu0YzL7y9PbG/dnmR6qxeTgINjSsxGRYsYXtJS5ilehsWiVGBToMEC
 dZ3AaCxqGkjleOw7iydeic42/Mthj8Pfq+8doDeOEV1kHkebsT/g292EfApsYIYpQEgKB6Du+cx
 vRqRUoxXnNPLYwaDYcKILBeGeA8w9t34uSiJVIYxIX4bgyjzffnd4fRAoyOnhxan9c+Vo2Y5D0c
 glv0yb5VPqdt2zs8pZSADs4EqPgWYgczRhrkS/j967IpSs
X-Gm-Gg: ASbGncur/S6zzP0Nc2Y5RHqKUKGVlavb5qwrvUQRm8Ld1YgQn1JeNkWH4IaeV0wFO6f
 c8OCn/2TnNNDi7dUsl3FlJSWATxrDIjpGoyrZWuyq9IM3EXCySLnkUqRj5dcJS0uT/QvRdplLXO
 pHQ1YqcEX6CUrW3k87mJQEm5oj0evY/LIvhRXwqea20MIAgIjgzVOXJTgiARzq1sJ8kV0r3Kd7+
 PmDTNffwANfvv5SxWLXkUFa61+waUwvuPdTUiSKHZtlbiepAFyWI0FcwVjqIxjFMx/mwwaBiP4Q
 ufToSdmdBCDA0lkKUNhTDaPgcCWFzUp4Cx/IEbjUbOwC8+1fTpj3SCxFlLd+YNxeSLnkttt6/Y5
 VRiFh0g==
X-Received: by 2002:a05:600c:3149:b0:470:bcc4:b0a0 with SMTP id
 5b1f17b1804b1-47117925919mr183477955e9.34.1761150247814; 
 Wed, 22 Oct 2025 09:24:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLHfDb8UBdSi0MdRK2CEkLmKdBgRyvEW87L0mhilCMkUgdh5ErPlMn6HxwJpQcbhqG+Al+WA==
X-Received: by 2002:a05:600c:3149:b0:470:bcc4:b0a0 with SMTP id
 5b1f17b1804b1-47117925919mr183477645e9.34.1761150247346; 
 Wed, 22 Oct 2025 09:24:07 -0700 (PDT)
Received: from fedora.redhat.com ([66.81.173.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496c2c9dasm40722945e9.4.2025.10.22.09.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 09:24:06 -0700 (PDT)
From: German Maglione <gmaglione@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>
Subject: [PATCH v2] vhost-user: make vhost_set_vring_file() synchronous
Date: Wed, 22 Oct 2025 18:24:05 +0200
Message-ID: <20251022162405.318672-1-gmaglione@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gmaglione@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

QEMU sends all of VHOST_USER_SET_VRING_KICK, _CALL, and _ERR without
setting the NEED_REPLY flag, i.e. by the time the respective
vhost_user_set_vring_*() function returns, it is completely up to chance
whether the back-end has already processed the request and switched over
to the new FD for interrupts.

At least for vhost_user_set_vring_call(), that is a problem: It is
called through vhost_virtqueue_mask(), which is generally used in the
VirtioDeviceClass.guest_notifier_mask() implementation, which is in turn
called by virtio_pci_one_vector_unmask().  The fact that we do not wait
for the back-end to install the FD leads to a race there:

Masking interrupts is implemented by redirecting interrupts to an
internal event FD that is not connected to the guest.  Unmasking then
re-installs the guest-connected IRQ FD, then checks if there are pending
interrupts left on the masked event FD, and if so, issues an interrupt
to the guest.

Because guest_notifier_mask() (through vhost_user_set_vring_call())
doesn't wait for the back-end to switch over to the actual IRQ FD, it's
possible we check for pending interrupts while the back-end is still
using the masked event FD, and then we will lose interrupts that occur
before the back-end finally does switch over.

Fix this by setting NEED_REPLY on those VHOST_USER_SET_VRING_* messages,
so when we get that reply, we know that the back-end is now using the
new FD.

We have a few reports of a virtiofs mount hanging:
- https://gitlab.com/virtio-fs/virtiofsd/-/issues/101
- https://gitlab.com/virtio-fs/virtiofsd/-/issues/133
- https://gitlab.com/virtio-fs/virtiofsd/-/issues/213

This is quite difficult bug to reproduce, even for the reporters.
It only happens on production, every few weeks, and/or on 1 in 300 VMs.
So, we are not 100% sure this fixes that issue. However, we think this
is still a bug, and at least we have one report that claims this fixed
the issue:

https://gitlab.com/virtio-fs/virtiofsd/-/issues/133#note_2743209419

Signed-off-by: German Maglione <gmaglione@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 hw/virtio/vhost-user.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 36c9c2e04d..1605485396 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1327,8 +1327,11 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
                                 VhostUserRequest request,
                                 struct vhost_vring_file *file)
 {
+    int ret;
     int fds[VHOST_USER_MAX_RAM_SLOTS];
     size_t fd_num = 0;
+    bool reply_supported = virtio_has_feature(dev->protocol_features,
+                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
     VhostUserMsg msg = {
         .hdr.request = request,
         .hdr.flags = VHOST_USER_VERSION,
@@ -1336,13 +1339,32 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
         .hdr.size = sizeof(msg.payload.u64),
     };
 
+    if (reply_supported) {
+        msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
+    }
+
     if (file->fd > 0) {
         fds[fd_num++] = file->fd;
     } else {
         msg.payload.u64 |= VHOST_USER_VRING_NOFD_MASK;
     }
 
-    return vhost_user_write(dev, &msg, fds, fd_num);
+    ret = vhost_user_write(dev, &msg, fds, fd_num);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (reply_supported) {
+        /*
+         * wait for the back-end's confirmation that the new FD is active,
+         * otherwise guest_notifier_mask() could check for pending interrupts
+         * while the back-end is still using the masked event FD, losing
+         * interrupts that occur before the back-end installs the FD
+         */
+        return process_message_reply(dev, &msg);
+    }
+
+    return 0;
 }
 
 static int vhost_user_set_vring_kick(struct vhost_dev *dev,
-- 
2.49.0


