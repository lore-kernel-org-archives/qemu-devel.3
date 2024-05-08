Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1679C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 07:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4c01-000493-Pa; Wed, 08 May 2024 03:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4bzi-0003b0-OO
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4bzh-0000zF-46
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715154340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f9/pSe/RtLHFpk03BlIEeBTC9MFrpAeOA+hs4I40IHM=;
 b=KLOof4oF5hmFyIv311jVL4LyOwxYwHS7epfJUqX9f5B5BZ+yknW5+HtIZ6/jHmznqsJ3c4
 mwwmWrAdEKcyHttJBto5mA01V6nrisDhzsP663R+zKrhWPjiz0SkWD9Ob7HGndu5VADLy6
 cmgLJ1h2FNNRu9aLnC/sbqSDtC3+2lQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-AZNxO1iZOfyrpZy4hjUvTg-1; Wed, 08 May 2024 03:45:39 -0400
X-MC-Unique: AZNxO1iZOfyrpZy4hjUvTg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59d0fb7731so220493366b.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 00:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715154333; x=1715759133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f9/pSe/RtLHFpk03BlIEeBTC9MFrpAeOA+hs4I40IHM=;
 b=ZE8MC7ugR7vTkgNbX2zATpxNjiWs9GLaDZXaWu2zvA1PaFTDYwg0E9kRnMNJV962UE
 LXU1rVbVKF4+S8a7vitJwJWy4wXh0zpPFcHIvrWBtagQ0gjXZKEIfDg/e19o/mWMv7aK
 MWaeT2ete1Uz1KYQqlPj+iJ2q6ApigXG89dbDfWpTooLs/z0iq4C3Vi7GP8+brjwtb8y
 u9+2kgeS1kUM6YSHiv3HUhbE/Y2Jm6Xlyokkny4sEp9WqvFlPV3JmNW3qyYZ72yXyFJ3
 CM2JwS2jQHDKoE3RhowBmOOf7rc3TKuW1AR2ohSJ9vZVtqd/grsklduP7VbBoQhEUafO
 vqkg==
X-Gm-Message-State: AOJu0Yzsf/21nm3ly1B/MoTnuFJXL+72u+UnVQfE9lfIYr2uma+Exjpb
 6J6LSJHTBRLnptTHJ1BpqamsJqofcZnsk93cVlNhSibWrd1ci9gxiMtwSkdS0mVa473bktCf/9r
 KGUwuMJ0+ga/LZf+kaSRkEFS+MLIedMYP6AgrQb7ntkMv8LBnuSH+wUJMrgyKGXjkhTDneULLRh
 x7hv8zoj+biPc0O9zyqImV5kliRFE78KZldhEV
X-Received: by 2002:a17:906:e297:b0:a59:a7b7:2b9e with SMTP id
 a640c23a62f3a-a59fb94b8d7mr94667266b.8.1715154332785; 
 Wed, 08 May 2024 00:45:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlQS93Md9pICqCOE6XzARyKyU8jaFnTv8bnyOTZCC2t6mEPXCkjojl4lLJr5zCzVB9vRmEXA==
X-Received: by 2002:a17:906:e297:b0:a59:a7b7:2b9e with SMTP id
 a640c23a62f3a-a59fb94b8d7mr94661666b.8.1715154331935; 
 Wed, 08 May 2024 00:45:31 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-12-25-56.business.telecomitalia.it. [87.12.25.56])
 by smtp.gmail.com with ESMTPSA id
 b18-20020a170906039200b00a59d9e71778sm2890528eja.111.2024.05.08.00.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 00:45:31 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, gmaglione@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, stefanha@redhat.com,
 David Hildenbrand <david@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 06/12] contrib/vhost-user-*: use QEMU bswap helper functions
Date: Wed,  8 May 2024 09:44:50 +0200
Message-ID: <20240508074457.12367-7-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240508074457.12367-1-sgarzare@redhat.com>
References: <20240508074457.12367-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PP_MIME_FAKE_ASCII_TEXT=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Let's replace the calls to le*toh() and htole*() with qemu/bswap.h
helpers to make the code more portable.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
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
2.45.0


