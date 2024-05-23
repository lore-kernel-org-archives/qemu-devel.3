Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0886C25B7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 14:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9rr-0002jT-TQ; Thu, 23 May 2024 10:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA9ro-0002bY-BF
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:56:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA9rj-00041A-Fy
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aZ6f2Wy9JZAIyu5wRg6z9P9zvSbVeUQdfiHCy8ESziQ=;
 b=Gzxbb3LOnsRpbxN0D+sfTJ/FP7Swzcdv17IUwHXGZTsv3CqqJeBSHnnO3Q8OgdTR4ICn4p
 P4jj/og3jn2HeENP1kZUvdI3+QSdwlEKfWzR0tJQnvPb0qBjlGMh4T+d0MtI6iGiS3VahD
 wKbAX8z4GduXHi6TTrM47+xXeF/MO30=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-Z2MGVX3CN9CGjLg5sWTOXQ-1; Thu, 23 May 2024 10:56:21 -0400
X-MC-Unique: Z2MGVX3CN9CGjLg5sWTOXQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-43df9a3fc0fso2383831cf.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 07:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476177; x=1717080977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aZ6f2Wy9JZAIyu5wRg6z9P9zvSbVeUQdfiHCy8ESziQ=;
 b=UGU9U8J/zZieXBk74OP4QwyxcgMaYN/MRkWrEW19fLcThOtIf69ZnYBmNUztZdN9mp
 jdvOIcmYf5nE1XxKQOzJ2TIFUZpXr/q5DWVIQmu9+56J0LqTOZacv5JB+UbtZPOYKO3t
 oEDtVrHTZH+E5VPvyOypGrobf3a5085ZSJausGfgrU3+viMQBPwt86qGD4fNFRMRGX+C
 xER4/j1pNr/HPEWfI48ni9gnTm9ZAeQ9j0s6SFy028LydY6B8IN7pR+X9LEGJLujXhyC
 c90pbxDK+8v25zyIUUg8cnk2+MoartGX7ONAWNedDRp1tSMBLxYLPoHyEOs/1dzLwD7y
 Yw2w==
X-Gm-Message-State: AOJu0YxZym20arxOgjnvCm/0wdSPxMGSrTzzwp/OrtaywEz225D/2X6O
 i7+sXoOsQprJDeG/nl0Bvwv5+1Y6KvZ2uBIJDV9MhM55jvrQq4Zph4+zq9ZhcU57YLHfKP8zP2W
 1Wc36xlMkX9iOQUYGLXOL7RCtALhRjuHjbmjP26YwWUqrMLVibpVZwOp3343c8vCEh/7OA+/sS7
 2nltz//WJlIUrP5fKtUbELF06eA4Jhya3QTb1m
X-Received: by 2002:a05:622a:1a1e:b0:43a:ed8b:75b1 with SMTP id
 d75a77b69052e-43f9e0f3220mr60046981cf.43.1716476176884; 
 Thu, 23 May 2024 07:56:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBOgeLvfyvxxo1WQ91OSaQxysuTauL71eZuvZYFDk4b9lBg6eKujg38dT6UQ4V+k2bfI7hQg==
X-Received: by 2002:a05:622a:1a1e:b0:43a:ed8b:75b1 with SMTP id
 d75a77b69052e-43f9e0f3220mr60046581cf.43.1716476176298; 
 Thu, 23 May 2024 07:56:16 -0700 (PDT)
Received: from step1.redhat.com (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43e0a4bdce8sm159322281cf.18.2024.05.23.07.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 07:56:15 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, slp@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>, stefanha@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, gmaglione@redhat.com,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v5 06/13] contrib/vhost-user-*: use QEMU bswap helper functions
Date: Thu, 23 May 2024 16:55:15 +0200
Message-ID: <20240523145522.313012-7-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523145522.313012-1-sgarzare@redhat.com>
References: <20240523145522.313012-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
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
2.45.1


