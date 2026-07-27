Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96563C53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQsI-0000Lv-OU; Mon, 27 Jul 2026 15:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsH-0000JJ-1m
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsF-0000cq-ET
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785180026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nJ5++lDmKJE8GWzy18k6nmNQiVQ39RoIQiUYRj/hei0=;
 b=KJA/V+XGZdhV/dsyxH2faVlmjwjVorVl9823srq+SnOtovvcCanZVM3RlqOOjNZ1nKbFik
 k5QLFbHQDvbiATDV110CBjGS/t+D4uNOPKvG6s6P9wittAeyEzFeQkEZKhrMwsoxOk9wnP
 fOBVRl9oFhKIn6M/abjdLhOY4VIYJcU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-Vp2TEFQAP4WkdQwsILq0bg-1; Mon, 27 Jul 2026 15:20:23 -0400
X-MC-Unique: Vp2TEFQAP4WkdQwsILq0bg-1
X-Mimecast-MFC-AGG-ID: Vp2TEFQAP4WkdQwsILq0bg_1785180022
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f83999cceso2656004f8f.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785180022; x=1785784822; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nJ5++lDmKJE8GWzy18k6nmNQiVQ39RoIQiUYRj/hei0=;
 b=pjyDI2okzFChCJ3l6KNW89vuEvQdU3BqE4fWeu8xD4IJl4VVngmRN82UN4HFWf3Gvp
 C6cqS2Cbs57fQu7nFsRUYj13MZA64NFzTpNkyJwTd1EBqk2NEVSoTfTrMv/xcIFgiepf
 YxgKGpkGRsfGAcCfT3J4dUJFOUqhDxugjon2LxD6zq33/cP3FPAk9fQ2JOGTaXKBFev2
 s/odSq41OG8ECUSb8HX7vZak9LO3Rh0rbTpdLVbqQ9GKR9Rt3A06pkVno5Wc6uSffzBs
 8wRRrUmJmPE4m7Gs2Yis55D7mrnRJ6KFvwUyY7P4adEVyK1tgsfUAJ16fHcf/2WHoFiP
 UUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785180022; x=1785784822;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nJ5++lDmKJE8GWzy18k6nmNQiVQ39RoIQiUYRj/hei0=;
 b=OUssaxBQ932nmjKfLZgni2coVAlJQ+1cKR2A3jT+fAW0JOvOHnkNSQxUeDZ+Db8nY5
 l/6lC87l+9b73RcrnUVxYTqQtd3688ODZBa/STu62T9NRGPVVLdHCTen+vdQC8wnuCXF
 sDmmaqI74tQ5Xi5q/1XNo8EN5wHiEwrzMTTSPtn+EnTS75sBvAf1EqN4Ds5vjA7nB/mo
 xVJHfAFjgsbYClcZLUFGfYCHh5QjeOjPuBMDgunR4B7uixQKlC1CJy/vQ3rwuKx4pp1+
 cQRd03oVhBqBPrkIwAytiLjyGeynthkQFb5uQHYi0RmRvssl0nZcD/JPZMEM0ayvdaDl
 0x/w==
X-Gm-Message-State: AOJu0Yy4bTQgkbUUbFZ8VV2A6S9F0B0cDAW8563RiUOGLR8ZR1iIO0yw
 8Oy13EHEysk8WPeXc8OZXFTxJPbcOafkW0S4V5KIr/xpkGSSW5G5np18ok9K8hDrEplVArz6no/
 IQEHCW38VE88fbt45YucSOyrvcfPeGi1qILUhrrS97XONqLl+udPJ02pT5xoGEjvUdDcd0kMnLR
 E9vlMmMlnGFKau3QTD3R3+7Pv60qB5wZxUVQ==
X-Gm-Gg: AR+sD10+Zf6u5b/dUFIRbZwXqqJdvlo4cU767Kht4geIVdtXqLQi1JTDMPQLXlDa4n4
 Wm4y+93ORutNz0ZIs60+xUd7No5tE0HK9lUXIJ0IHhdsDBQsLY3gXOP5HgEeVOzsOIGsmMZ58Ey
 m/FWYW4QYR+VVotvs/OTpWfkD0euRzq/Re6m5W35lU7ZuvZvSY5GIvG3r7M6Zqt84g6VYwbk+Yr
 qlfPaMm+uZ5OVUccackwk9SqOosgg/QJhhy8zQB3fM/HvRgn+tGEt0gpFhCp0KAHEs9IvOHpZET
 rwPHyOVnbUl/Pnf+npUkOU5VskRRvf+axYQyWNHN8jQ/ssZ+hSLoaYPjZ2tOD5XTDn5qVxE/xGa
 EWxQ/IE7Bw77p4TkgJFaX8Q==
X-Received: by 2002:a05:6000:480c:b0:47f:93b6:8d08 with SMTP id
 ffacd0b85a97d-47f9fc99455mr12110422f8f.21.1785180022068; 
 Mon, 27 Jul 2026 12:20:22 -0700 (PDT)
X-Received: by 2002:a05:6000:480c:b0:47f:93b6:8d08 with SMTP id
 ffacd0b85a97d-47f9fc99455mr12110394f8f.21.1785180021497; 
 Mon, 27 Jul 2026 12:20:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bd850asm50550911f8f.15.2026.07.27.12.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:20:20 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:20:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v2 20/30] virtio-snd: check for overflow before g_malloc0
Message-ID: <fa9c0c9f716e39309ffdd95a5b7afc33cc0692d8.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Coverity points out one g_malloc0 overflow, but it seems to be a false
positive. Add a check to it regardless to fortify the code, and also add
checks for every other g_malloc0 use.

Resolves: Coverity CID 1547527
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260420-virtio-fixups-v3-2-07aef1eff9d2@linaro.org>
---
 hw/audio/virtio-snd.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 93fbcfb43f..694bcebb60 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -850,7 +850,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
     VirtIOSound *vsnd = VIRTIO_SND(vdev);
     VirtIOSoundPCMBuffer *buffer;
     VirtQueueElement *elem;
-    size_t msg_sz, size;
+    size_t msg_sz, size, tmp;
     virtio_snd_pcm_xfer hdr;
     uint32_t stream_id;
     /*
@@ -880,6 +880,8 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         if (msg_sz != sizeof(virtio_snd_pcm_xfer)) {
             goto tx_err;
         }
+        assert(iov_size(elem->out_sg, elem->out_num) >= msg_sz);
+        size = iov_size(elem->out_sg, elem->out_num) - msg_sz;
         stream_id = le32_to_cpu(hdr.stream_id);
 
         if (stream_id >= vsnd->snd_conf.streams
@@ -892,9 +894,11 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
             goto tx_err;
         }
 
+        /* Check for g_malloc0 overflow. */
+        if (!g_size_checked_add(&tmp, sizeof(VirtIOSoundPCMBuffer), size)) {
+            goto tx_err;
+        }
         WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-            size = iov_size(elem->out_sg, elem->out_num) - msg_sz;
-
             buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
             buffer->elem = elem;
             buffer->populated = false;
@@ -932,7 +936,7 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
     VirtIOSound *vsnd = VIRTIO_SND(vdev);
     VirtIOSoundPCMBuffer *buffer;
     VirtQueueElement *elem;
-    size_t msg_sz, size;
+    size_t msg_sz, size, tmp;
     virtio_snd_pcm_xfer hdr;
     uint32_t stream_id;
     /*
@@ -977,6 +981,10 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
             goto rx_err;
         }
         size -= sizeof(virtio_snd_pcm_status);
+        /* Check for g_malloc0 overflow. */
+        if (!g_size_checked_add(&tmp, sizeof(VirtIOSoundPCMBuffer), size)) {
+            goto rx_err;
+        }
         WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
             buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
             buffer->elem = elem;
-- 
MST


