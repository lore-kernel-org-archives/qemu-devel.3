Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0D8C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeCh-0001Yc-NR; Tue, 02 Jul 2024 10:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCd-0001DB-Sl
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCV-0008Q3-0u
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xz1NfthBeUYnFyP8G3rI1icjzqQ87e2k5Q1ZCQ4OJGs=;
 b=iesPMSZOZ448A7LwL8kkCpHTuLkFpOn9fehi9Lhgk2u8hKsv5FomO4ywIe1Vtx8ma0je/h
 tAcLCuWzDiNsAL11upucVk6PF7L/RQF2jsG1qRBkW1i/QIUAYO83718aHnh8GxSiZIsevn
 qvwY2YJ0w+EvGqa2D/ZAETNSx29MnSQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-CK9KUdqUOmmgrM5FA4Jp1g-1; Tue, 02 Jul 2024 10:09:41 -0400
X-MC-Unique: CK9KUdqUOmmgrM5FA4Jp1g-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3634a634f8aso2402458f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929378; x=1720534178;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xz1NfthBeUYnFyP8G3rI1icjzqQ87e2k5Q1ZCQ4OJGs=;
 b=SJI6LuOxnLuXHUxZZPp+ePo3p5g+jIH88fplIzxfqJqg4UOrgvYRwuHd/NKFxgLAxu
 VlwoU0oG1krcWy5mhWvTVedxa2j+lwqAd1s6Y5fwNDwlnBfvtICGs8G1nG9sf0rawswA
 uU14lBUyA3Wwflw3qsue3tU7nNVTg1JikYAehKDuqSL+MGRvSB5b763guD1qILUoAa9E
 Xhk4dU8fue1Wnmrw06wqo+xCl9xOA51b4E95jXDLCzDmAfXmiT9BIV+S5B2jayW6OnfE
 baFbPdoJUE7nrj621vQbtQ4lP0QzLpILqno7kZpxaEX94KWboOva/OZibFvEcDKpvbym
 y+1A==
X-Gm-Message-State: AOJu0YyuyphfDkgjymOopNOknywhLlhf1SRQC9VZQK1hpL6yTyJtwCvV
 tiupRigZ7rtlCGF2qQpxz+yLh0KjpnuMOZPsyklFUtXELZc9A52OOZ9/YHYbZceq5XATRrtLtLp
 lS+jaoZk9V1vtc7dGqvuQSYj8UGR5K38JWCeQXTI11kxEtJSm1FAo8RKZuJ9MvBk7z+JB/gsR8u
 ywwJhvDhZq1id8l/60uzJ6GUKSGmZnOQ==
X-Received: by 2002:a05:6000:4582:b0:35f:159e:5ec2 with SMTP id
 ffacd0b85a97d-367756c73aamr4163386f8f.39.1719929378247; 
 Tue, 02 Jul 2024 07:09:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG18+wNbjXzPcHYme9fmFSpAsLrQL4G8+P/wjcq4DrMt+mI+Y9O1ECFeECgs1yZOHPWbSER1Q==
X-Received: by 2002:a05:6000:4582:b0:35f:159e:5ec2 with SMTP id
 ffacd0b85a97d-367756c73aamr4163363f8f.39.1719929377622; 
 Tue, 02 Jul 2024 07:09:37 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3678aa3caccsm1095845f8f.35.2024.07.02.07.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:09:37 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:09:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 52/91] contrib/vhost-user-*: use QEMU bswap helper functions
Message-ID: <0e951d36e4852e161438a27eddecf62db0a302e7.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


