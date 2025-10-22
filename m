Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFE0CCD1BE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 13:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBYyh-00020X-KQ; Wed, 22 Oct 2025 09:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmaglione@redhat.com>)
 id 1vBYyc-000206-Mr
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 09:34:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmaglione@redhat.com>)
 id 1vBYyZ-0006vR-TU
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 09:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761140041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=phLGD38z5yTEFXoLVnLLmZOQufbUTulf7Ri/M2BZPM0=;
 b=XZa2WWNDB6CNZ8RsJThSjvGUzqAo39zMs9SdxLIMLfXCC4iOUOjpegnbX54bGZMkGWm3wP
 AcwRwZZ58SrMvl9ekYKDMFz6JUQfINbGeJF1PYwDwRTO+xtdEGpCBvhmBSwIO95zZoIrLz
 8nRxwYwcmnI7v5qKp5GikR1EyDQrVt0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-5QqQNk5JPZOJyf_Lp_CueA-1; Wed, 22 Oct 2025 09:32:33 -0400
X-MC-Unique: 5QqQNk5JPZOJyf_Lp_CueA-1
X-Mimecast-MFC-AGG-ID: 5QqQNk5JPZOJyf_Lp_CueA_1761139952
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-471148ad64aso28793715e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 06:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761139952; x=1761744752;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=phLGD38z5yTEFXoLVnLLmZOQufbUTulf7Ri/M2BZPM0=;
 b=NdS2BeBsuK1UOSl/b60qrSrLs2JUS/2Zw0gvJBP/cW4Bn43z/sOH2171mpu1JkhEx6
 yJCwI8ZiN2362wIdGlq1MVcL5nvOeJQRI3VCHPW7f+21UkBX/pqMYx9EQraSXjznBpJW
 5kiRFBA8qsXuqfizNDuhurKo/vsiyJsMddstaVKVwIDOOxgzht3orB/EsY3M0wwEYXAE
 DA/wPaFR/7nwhG4kGSy73VyQNZpjlI08nSZHvd4FcJ4Lz0gEiYKGvKAkAzdhJ6St9k0d
 lEhTawPYhnwp70oA4wkkcQE1xuRaWceWqjW3LxJ85EnyKlgKypOR6AGlLjytww7oXsAU
 V4HQ==
X-Gm-Message-State: AOJu0YzZhSz7YhYl13zCM5HPZ1wBZTKfMBiQGnSk0//tfPxSHU4dufw6
 I8t0YxHOkguiZ04jnOA9qholEF7CCPJUpUSTDzn8vlMXs+L08+lmMh9HnOQWLm6b7ZX1ThqLlrN
 OLoMMpfMBSiFU1fY7ArLHm8X8PJywwHWSguYzVTa0QVBsKorkJj5lbbCgrZWNT9f1tVzVnGeAKc
 bSmeTB5PYFCFC518FHiSSflhZeOuYMiJpW2a/FY64N1vF/
X-Gm-Gg: ASbGncuOTVW3MVhtXg+KXw0hkMntYW+1w4/u5KAI2kiAE4eeT7e4/vSJP3RySrer1sc
 BzXvS11GGhP5i0zGogt9I8WxzuGCi6SvbBC5rWU4ZIbR8TttWSvFbtaGzJDBESxwsbOS0yD4e9g
 tcIZS82xfK7ie6nwi/SbQY+KqlA3EEqjFVRdoqvezveJTnTIR5d3T0J1reu7iSHG1TCU43O8aBl
 g4IFX/iqtZ5SPhSy+gCEGuiKCvLYQmeAdYR0vobVWpjGTL2GeAwNGAR5o+rerXMi/VjKuFgKT2I
 s6gPFQX8mP9plSHgZdW0o35+XqTSrI5Br2qJ9HM5cWmVEByZQ/+5qYk91imzA6QeZJAD9EzMB4y
 k59ZFXw==
X-Received: by 2002:a05:600c:4fd4:b0:456:1b6f:c888 with SMTP id
 5b1f17b1804b1-471179123a2mr140672875e9.23.1761139951757; 
 Wed, 22 Oct 2025 06:32:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt/h1l8yvbwSudwm4xMqdt+EZH+Oe1jyYDZWDwM1zi3eCOEPPq1jZlhBheYYEjsThChCLXTw==
X-Received: by 2002:a05:600c:4fd4:b0:456:1b6f:c888 with SMTP id
 5b1f17b1804b1-471179123a2mr140672545e9.23.1761139951213; 
 Wed, 22 Oct 2025 06:32:31 -0700 (PDT)
Received: from fedora.redhat.com ([66.81.173.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496cf3b51sm36676975e9.9.2025.10.22.06.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 06:32:30 -0700 (PDT)
From: gmaglione@redhat.com
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] Make vhost_set_vring_file() synchronous
Date: Wed, 22 Oct 2025 15:32:28 +0200
Message-ID: <20251022133228.301365-1-gmaglione@redhat.com>
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

From: German Maglione <gmaglione@redhat.com>

QEMU sends all of VHOST_USER_SET_VRING_KICK, _CALL, and _ERR without
setting the NEED_REPLY flag, i.e. by the time the respective
vhost_user_set_vring_*() function returns, it is completely up to chance
whether whether the back-end has already processed the request and
switched over to the new FD for interrupts.

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

Signed-off-by: German Maglione <gmaglione@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 hw/virtio/vhost-user.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 36c9c2e04d..641960293b 100644
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
@@ -1336,13 +1339,26 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
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
+        return process_message_reply(dev, &msg);
+    }
+
+    return 0;
 }
 
 static int vhost_user_set_vring_kick(struct vhost_dev *dev,
-- 
2.49.0


