Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D6ACAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFZ-0002nP-1L; Sun, 05 Oct 2025 15:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEv-0000ak-1C
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEt-0006Z4-6Z
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K0uPqEt6u9YfLfkNfM1cQHFS+f7aPhD9qXs0swcauCo=;
 b=NJeolQGINj6LdYjfBrLRETfwGECrdR44pRmDLPNbZpI4ya3o1UT6tk4SoJRJbDNYcZeJL3
 QpOd/1TesN7eYh70PgcNvhCIAs2IIek0C+j6tp+fUAWylpXbvBHoB9dLL79ZP9F64rcliF
 Tp82sAOXczNpGdcEVtqqEQ1fBS9I5EU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-JKvdfRyXOJKvsOaev5_P9A-1; Sun, 05 Oct 2025 15:17:44 -0400
X-MC-Unique: JKvdfRyXOJKvsOaev5_P9A-1
X-Mimecast-MFC-AGG-ID: JKvdfRyXOJKvsOaev5_P9A_1759691864
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e407c600eso21617175e9.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691863; x=1760296663;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K0uPqEt6u9YfLfkNfM1cQHFS+f7aPhD9qXs0swcauCo=;
 b=mhlS4DfBrUYlXbrJCfM9zu+oTuUkix++JhfNRF0tNCKrqGYfuxUhIgzxiFSHgQkXdi
 KjX/d1aqVQoiokX5HVBF5eRT94euIE60hE02If3cemi8/gksxWj6V3DOrp6gxUFPMVzU
 nqq8+FW82i/8ErM7ndWbyBSLXNhs09ykgJlhenOfKpvklgl7Rq+He7i/8CvOOx4isWj4
 tHBPA6HdRx3g3DiUiLS+Liv/wMkqAmyyPxD6YeiYYaOh5YDJ6EA9uXtUZFAD1SmJI5gb
 dTsi4VoPf4oT2L2S0Oy8Z+eFJoX78OmL1Bs/ax+DKezxfjsZtj+/DQoC5BpTLqzflRK3
 2+Ig==
X-Gm-Message-State: AOJu0YzrvtQC829STzF+AuVyzEAprOnMhniVlj+KeK6cGfLEc9PhViyY
 6J1Rxh9NV8WALPo3VbEyuBQuVLnotHu0dC9WaO4yK/xXFLhmsMzV3STiaLhIPFyqiJij6Qgm+q+
 F7bo3z6BbA81fmviv0wfje7AqAr8FgUcSt4vQib46AVwZEttcOIV4D6xpgxt5af01xgMEJ+zMp/
 YpIcog4TV9be1KpjuHBDQZbteaPfLdJe+Bwg==
X-Gm-Gg: ASbGncv/Kw3+fR5ZA16NEL8RhkW5P/gEzxEvDBFzyMzCXAR0XxLncpfTOzkDGwVMQjP
 gqxQRmjR3IdTIi3a7xUMtiFfGXQlfoOcBGb434OwOz6Wkd4MGmPGIVjN59tf37yXsrSm5WckDJ8
 vA1neN5Qd1CTaQmUTwMahFLpzUmKDtNbluaTh8md0qBTzYYwnnHA8vBAUCMpj+F9nupkziaZeuD
 rlVs625/YNCNloL7XlVUH98X0kwRlAqX7OT5MFhfI0y8cP8P0xf88+ywljJnHRRVdMqvVv0OvzY
 qwvB/1QeoUMaiojPCnIjTbGqVBxlMA1Jd/h/070=
X-Received: by 2002:a05:600c:64c4:b0:46d:45e:3514 with SMTP id
 5b1f17b1804b1-46e7114310amr81609585e9.17.1759691863266; 
 Sun, 05 Oct 2025 12:17:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEz8+QFjI/uSFb/4Des0Mu5TJVk8BaxcHcHYzng7TROCGTP1QwuCkiSx7iS/5INH+HPbSgAyw==
X-Received: by 2002:a05:600c:64c4:b0:46d:45e:3514 with SMTP id
 5b1f17b1804b1-46e7114310amr81609395e9.17.1759691862789; 
 Sun, 05 Oct 2025 12:17:42 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e7236267bsm134197825e9.16.2025.10.05.12.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:42 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org
Subject: [PULL 44/75] virtio: unify virtio_notify_irqfd() and virtio_notify()
Message-ID: <1e9181dc5277f27fcda21f64a399f12bbf578e5e.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The difference between these two functions:
- virtio_notify() uses the interrupt code path (MSI or classic IRQs)
- virtio_notify_irqfd() uses guest notifiers (irqfds)

virtio_notify() can only be called with the BQL held because the
interrupt code path requires the BQL. Device models use
virtio_notify_irqfd() from IOThreads since the BQL is not held.

The two functions can be unified by pushing down the if
(qemu_in_iothread()) check from virtio-blk and virtio-scsi into core
virtio code. This is in preparation for the next commit that will add
irqfd support to virtio_notify_config() and where it's unattractive to
introduce another irqfd-only API for device model callers.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250922220149.498967-3-stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h |  1 -
 hw/block/virtio-blk.c      |  6 +-----
 hw/scsi/virtio-scsi.c      |  6 +-----
 hw/virtio/virtio.c         | 28 +++++++++++++---------------
 hw/virtio/trace-events     |  1 -
 5 files changed, 15 insertions(+), 27 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 2aeb021fb3..d97529c3f1 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -294,7 +294,6 @@ int virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
                               unsigned int *out_bytes, unsigned max_in_bytes,
                               unsigned max_out_bytes);
 
-void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq);
 void virtio_notify(VirtIODevice *vdev, VirtQueue *vq);
 
 int virtio_save(VirtIODevice *vdev, QEMUFile *f);
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 9bab2716c1..64efce4846 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -62,11 +62,7 @@ void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
     iov_discard_undo(&req->inhdr_undo);
     iov_discard_undo(&req->outhdr_undo);
     virtqueue_push(req->vq, &req->elem, req->in_len);
-    if (qemu_in_iothread()) {
-        virtio_notify_irqfd(vdev, req->vq);
-    } else {
-        virtio_notify(vdev, req->vq);
-    }
+    virtio_notify(vdev, req->vq);
 }
 
 static int virtio_blk_handle_rw_error(VirtIOBlockReq *req, int error,
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 34ae14f7bf..d817fc42b4 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -116,11 +116,7 @@ static void virtio_scsi_complete_req(VirtIOSCSIReq *req, QemuMutex *vq_lock)
     }
 
     virtqueue_push(vq, &req->elem, req->qsgl.size + req->resp_iov.size);
-    if (s->dataplane_started && !s->dataplane_fenced) {
-        virtio_notify_irqfd(vdev, vq);
-    } else {
-        virtio_notify(vdev, vq);
-    }
+    virtio_notify(vdev, vq);
 
     if (vq_lock) {
         qemu_mutex_unlock(vq_lock);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 34f977a3c9..6ce5823898 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -31,6 +31,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-access.h"
 #include "system/dma.h"
+#include "system/iothread.h"
 #include "system/runstate.h"
 #include "virtio-qmp.h"
 
@@ -2654,16 +2655,8 @@ static void virtio_notify_irqfd_deferred_fn(void *opaque)
     event_notifier_set(notifier);
 }
 
-void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
+static void virtio_irq(VirtQueue *vq)
 {
-    WITH_RCU_READ_LOCK_GUARD() {
-        if (!virtio_should_notify(vdev, vq)) {
-            return;
-        }
-    }
-
-    trace_virtio_notify_irqfd(vdev, vq);
-
     /*
      * virtio spec 1.0 says ISR bit 0 should be ignored with MSI, but
      * windows drivers included in virtio-win 1.8.0 (circa 2015) are
@@ -2680,13 +2673,18 @@ void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
      * to an atomic operation.
      */
     virtio_set_isr(vq->vdev, 0x1);
-    defer_call(virtio_notify_irqfd_deferred_fn, &vq->guest_notifier);
-}
 
-static void virtio_irq(VirtQueue *vq)
-{
-    virtio_set_isr(vq->vdev, 0x1);
-    virtio_notify_vector(vq->vdev, vq->vector);
+    /*
+     * The interrupt code path requires the Big QEMU Lock (BQL), so use the
+     * notifier instead when in an IOThread. This assumes that device models
+     * have already called ->set_guest_notifiers() sometime before calling this
+     * function.
+     */
+    if (qemu_in_iothread()) {
+        defer_call(virtio_notify_irqfd_deferred_fn, &vq->guest_notifier);
+    } else {
+        virtio_notify_vector(vq->vdev, vq->vector);
+    }
 }
 
 void virtio_notify(VirtIODevice *vdev, VirtQueue *vq)
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 76f0d458b2..658cc365e7 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -75,7 +75,6 @@ virtqueue_flush(void *vq, unsigned int count) "vq %p count %u"
 virtqueue_pop(void *vq, void *elem, unsigned int in_num, unsigned int out_num) "vq %p elem %p in_num %u out_num %u"
 virtio_queue_notify(void *vdev, int n, void *vq) "vdev %p n %d vq %p"
 virtio_notify_irqfd_deferred_fn(void *vdev, void *vq) "vdev %p vq %p"
-virtio_notify_irqfd(void *vdev, void *vq) "vdev %p vq %p"
 virtio_notify(void *vdev, void *vq) "vdev %p vq %p"
 virtio_set_status(void *vdev, uint8_t val) "vdev %p val %u"
 
-- 
MST


