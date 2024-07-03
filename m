Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4F0C3271E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8mH-0000rH-2b; Wed, 03 Jul 2024 18:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8mF-0000ok-GN
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:48:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8m7-0004IC-NP
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xz1NfthBeUYnFyP8G3rI1icjzqQ87e2k5Q1ZCQ4OJGs=;
 b=MuUTyR34HlBbfbI/A3TUN/Xcp7m8DUVlZiUPms6UYtua67yX8+XMvEKHCzl3Ku8NknB8Xw
 I4NOCG3Y573F7Mm0ywNONYA82Znql1vqXZUHqV/M0L3bJsx+fvzMQfn3yT7ciLqfyNsM7X
 do98T3ejiR8HEfI0pCgzrEh/jJSzdnc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-jcDVhuxxOVS9JHAAY9pobw-1; Wed, 03 Jul 2024 18:48:27 -0400
X-MC-Unique: jcDVhuxxOVS9JHAAY9pobw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a725b0f8ba9so480866b.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046905; x=1720651705;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xz1NfthBeUYnFyP8G3rI1icjzqQ87e2k5Q1ZCQ4OJGs=;
 b=GS10zAQfvYYHW4bcRPqz2pYs1G5ViO+kuXD8yvYzWg0YV+AO9sB5+eJZ9pXYXwG2TE
 msjwbIeLkrJvE/fuZrrS224qTbzrxLts/UBMbpCgQ21wlWVuGa+t4Y/lEjdUEvvw6MOO
 eYTrXBqjBw2QplKoRwnU1sn3Kb3L9VK8XdKoI7ZYlXRG1rH11+BhrU4Y4XlvcTEt3tTi
 3/EXkAr3ZMrhaWIf4bJTX6hnsV6XisyzdsK+DlJ5uerlfeMPg1NGKxVwpPHfZhRsXHeN
 2/aWDlSNGFbziii1bAkzUm6ohhLzUkc6KhZZLiXFiUfN3sUJ/9mcxnoiVR3Z/WlSJsxm
 ez1g==
X-Gm-Message-State: AOJu0Ywmx6CeVQ4M+1zJeKpXnSMehXeJDqf+fbNdDFiGYnApLf97CvKY
 P3rziMWTIyZUBwt19auTTwONDNX8U58yL2Jy5zpqodB9k3KEMSVbuPwvjU/QFYwkLkMt7fyF8K2
 sKRum4VRiPJzw2RI18/1ZBJEOqMK2ZmqF+QFc9a0rD16ErYm9GDvlG1r4/k5nEHkB2KcoTvbM8U
 6dW5UDDRDVga50Dj7oQAcTh0xGRSErww==
X-Received: by 2002:a05:6402:50cc:b0:578:638e:3683 with SMTP id
 4fb4d7f45d1cf-5879ede2742mr12161174a12.5.1720046904896; 
 Wed, 03 Jul 2024 15:48:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF28sHLGiyPyMidKAWw22ItsxN1HRjXNcR2KzSx7Zi3PbVvL8xmzTlcXmNlk2AaajREtXjbNQ==
X-Received: by 2002:a05:6402:50cc:b0:578:638e:3683 with SMTP id
 4fb4d7f45d1cf-5879ede2742mr12161157a12.5.1720046904300; 
 Wed, 03 Jul 2024 15:48:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58613815e1csm7720372a12.44.2024.07.03.15.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:48:23 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:48:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v3 52/85] contrib/vhost-user-*: use QEMU bswap helper functions
Message-ID: <5ab04420c3de11ae4a573b08b53584a2a0c5dd00.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefano Garzarella <sgarzare@redhat.com>

Let's replace the calls to le*toh() and htole*() with qemu/bswap.h
helpers to make the code more portable.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240618100447.145697-1-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/vhost-user-blk/vhost-user-blk.c |  9 +++++----
 contrib/vhost-user-input/main.c         | 16 ++++++++--------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index a8ab9269a2..9492146855 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -16,6 +16,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "standard-headers/linux/virtio_blk.h"
 #include "libvhost-user-glib.h"
 
@@ -194,8 +195,8 @@ vub_discard_write_zeroes(VubReq *req, struct iovec *iov, uint32_t iovcnt,
     #if defined(__linux__) && defined(BLKDISCARD) && defined(BLKZEROOUT)
     VubDev *vdev_blk = req->vdev_blk;
     desc = buf;
-    uint64_t range[2] = { le64toh(desc->sector) << 9,
-                          le32toh(desc->num_sectors) << 9 };
+    uint64_t range[2] = { le64_to_cpu(desc->sector) << 9,
+                          le32_to_cpu(desc->num_sectors) << 9 };
     if (type == VIRTIO_BLK_T_DISCARD) {
         if (ioctl(vdev_blk->blk_fd, BLKDISCARD, range) == 0) {
             g_free(buf);
@@ -267,13 +268,13 @@ static int vub_virtio_process_req(VubDev *vdev_blk,
     req->in = (struct virtio_blk_inhdr *)elem->in_sg[in_num - 1].iov_base;
     in_num--;
 
-    type = le32toh(req->out->type);
+    type = le32_to_cpu(req->out->type);
     switch (type & ~VIRTIO_BLK_T_BARRIER) {
     case VIRTIO_BLK_T_IN:
     case VIRTIO_BLK_T_OUT: {
         ssize_t ret = 0;
         bool is_write = type & VIRTIO_BLK_T_OUT;
-        req->sector_num = le64toh(req->out->sector);
+        req->sector_num = le64_to_cpu(req->out->sector);
         if (is_write) {
             ret  = vub_writev(req, &elem->out_sg[1], out_num);
         } else {
diff --git a/contrib/vhost-user-input/main.c b/contrib/vhost-user-input/main.c
index 081230da54..f3362d41ac 100644
--- a/contrib/vhost-user-input/main.c
+++ b/contrib/vhost-user-input/main.c
@@ -51,8 +51,8 @@ static void vi_input_send(VuInput *vi, struct virtio_input_event *event)
     vi->queue[vi->qindex++].event = *event;
 
     /* ... until we see a report sync ... */
-    if (event->type != htole16(EV_SYN) ||
-        event->code != htole16(SYN_REPORT)) {
+    if (event->type != cpu_to_le16(EV_SYN) ||
+        event->code != cpu_to_le16(SYN_REPORT)) {
         return;
     }
 
@@ -103,9 +103,9 @@ vi_evdev_watch(VuDev *dev, int condition, void *data)
 
         g_debug("input %d %d %d", evdev.type, evdev.code, evdev.value);
 
-        virtio.type  = htole16(evdev.type);
-        virtio.code  = htole16(evdev.code);
-        virtio.value = htole32(evdev.value);
+        virtio.type  = cpu_to_le16(evdev.type);
+        virtio.code  = cpu_to_le16(evdev.code);
+        virtio.value = cpu_to_le32(evdev.value);
         vi_input_send(vi, &virtio);
     }
 }
@@ -124,9 +124,9 @@ static void vi_handle_status(VuInput *vi, virtio_input_event *event)
 
     evdev.input_event_sec = tval.tv_sec;
     evdev.input_event_usec = tval.tv_usec;
-    evdev.type = le16toh(event->type);
-    evdev.code = le16toh(event->code);
-    evdev.value = le32toh(event->value);
+    evdev.type = le16_to_cpu(event->type);
+    evdev.code = le16_to_cpu(event->code);
+    evdev.value = le32_to_cpu(event->value);
 
     rc = write(vi->evdevfd, &evdev, sizeof(evdev));
     if (rc == -1) {
-- 
MST


