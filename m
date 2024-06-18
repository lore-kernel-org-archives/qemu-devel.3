Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811F0C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 10:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJVi8-0003lA-Fk; Tue, 18 Jun 2024 06:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJVi6-0003i2-Lv
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:05:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJVi4-0001EE-3Y
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718705102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+P1PLaujH+XkcZwoLm4xtgpPOnPZM5w6BOv7shY81Ks=;
 b=QzecCnjaQmfbkuefU8tU3WQ2I1+aos+rv58eyITZXufykKkRFOO1O4yPSJ6vJcC1rU5VFp
 /uPEQSMT9YPlMRivtayEW/QyZlKN3HdtfqCqSOUsKv005ia86pz23er9gWkbLSKPPSqPDD
 pRP8g+/4Taxuevh2k6YQ/eS1QfXQptI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140--36eIY9BPSqtgPVc7THyXg-1; Tue, 18 Jun 2024 06:04:58 -0400
X-MC-Unique: -36eIY9BPSqtgPVc7THyXg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52c9894a547so4275395e87.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 03:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718705093; x=1719309893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+P1PLaujH+XkcZwoLm4xtgpPOnPZM5w6BOv7shY81Ks=;
 b=qZQdhcEv+5QgSMNkNBgOpguvxYAanaOcXz22GZjJFiduOJaDBsXCjaWwz2t6U/P9Zo
 6QRi7T3ZlTzXe98XCswv4gKeV+Q337drRshcph31TKgQ3zitNZhJYKAegMSn3HNm+qf1
 zrcOmASqcyLFXaW9tHRkbLYMpkxANcqemflnEBm6r1YKSY5AOsyvOx5NZKYjP2x9Z6pt
 TcxOfFlhrQ3nzOlKDZfuXO9YFXHiWpU1q06PuMivJ3toBDGj0KVLHClj/MKeFPUo9BfW
 bVIxrKe7W1DQrdkwJKNL6pMVqqjSU5XQ+7FnSP82dc9EE7xXyd8wRE8+73QutV4+yHAa
 N80w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeRSoHN1zsuQPdtxalAXVGAGxkOmoLnJQnP6vOcqz6XTCJaOvtJG6Z3rekJ0TC47ozWOTi66gWqqvqCLvKKGnZPdXjcS8=
X-Gm-Message-State: AOJu0YyoomQMt7GFw3sM9dlbyBkDeqpnjzhJ5ioLv5eiGEbXO0EqXz/k
 TjHz7lpOavdT8MBVzI+tjKNZsmRBEHZdl7RQEQY+LlS8+Sq6FkRK1Qp10U7GjHWgz4S/PMsJ+9N
 wbLldhhlTx+IYvvHSU1rRQgy3N1OGHMqyyHe8Jmd354HRQgatiox+
X-Received: by 2002:a19:7718:0:b0:52c:8449:d82e with SMTP id
 2adb3069b0e04-52ca6e656bdmr7423649e87.15.1718705092906; 
 Tue, 18 Jun 2024 03:04:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECieEGYIai0CEE1d6i+8w18YR6MuyTbNX5DtFji561t2/jvM2DQAiWL3qua+EeZFRDm7TJ5Q==
X-Received: by 2002:a19:7718:0:b0:52c:8449:d82e with SMTP id
 2adb3069b0e04-52ca6e656bdmr7423615e87.15.1718705092484; 
 Tue, 18 Jun 2024 03:04:52 -0700 (PDT)
Received: from step1.redhat.com ([193.207.160.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f61280f6sm184113045e9.27.2024.06.18.03.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 03:04:50 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Brad Smith <brad@comstyle.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <lvivier@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, slp@redhat.com, gmaglione@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, stefanha@redhat.com,
 Raphael Norwitz <raphael@enfabrica.net>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v8 07/13] contrib/vhost-user-*: use QEMU bswap helper functions
Date: Tue, 18 Jun 2024 12:04:47 +0200
Message-ID: <20240618100447.145697-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618100043.144657-1-sgarzare@redhat.com>
References: <20240618100043.144657-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

Let's replace the calls to le*toh() and htole*() with qemu/bswap.h
helpers to make the code more portable.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
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
2.45.2


