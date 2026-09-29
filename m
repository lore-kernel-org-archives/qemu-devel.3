Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461DBCA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBTSU-0005rK-Io; Tue, 29 Sep 2026 04:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xBTSI-0005pK-ND
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:44:55 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xBTSH-0003nY-6a
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:44:54 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc4c08393b0so1647141a12.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 01:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790671491; x=1791276291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FlA2nQmoOrWyu92q9uY7bri1KbAe5YqKC3sra4MmyoI=;
 b=JpuyrkXBXJVbKEHT482Tq1eYbSQN+xVK5cggZwCd429EPyhBBHgKgV32niKDC9Evta
 Y8mzqw/5qFg1OlTmpAG0wjAnHIcFLMziwdjSuOpykcYEMLJFmWyZcRp20C54TzQdxLD6
 IjfrkB2yC1L3hO6vFLWJwtp1E23CXXkFb062fXDth6ayD0QS6+DIVC1Ya9XFQfi2q0J8
 hNZxTIHYAakWQO7m9tOynYiWW9dKbmf4gWufcQLMltJ4tAL/7amAHR0cxgtGVQka5QRE
 SX+mkkPdb+K0JDRr1VMQpR6ptx0jjmFrjhbBamvwyX86jK641u0mGtjfNltOO643G1+A
 QWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790671491; x=1791276291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FlA2nQmoOrWyu92q9uY7bri1KbAe5YqKC3sra4MmyoI=;
 b=AU5oQITHs87YevnZHBxNDf+AKT7Psk4ZWc5ZG2qWIFW/9wyGu3BFOsbfK7TUiGKVq0
 ijGFZhNyxtRNMtDNs8yftSGRXdqvDEWT1mXVlKCDtNzT9NYwBavNeofPveSXDWnsKNU+
 DIRrrw1J3srwXCveaCXR9ZYVq7Dq8pJ5ITBfVR3XwnZOpOtTplrveTwwgObxmz9JIYek
 d+1lrt9CcYhRZmGwG9h3PEXH9sCCKxAw++JN0Xnc7qdxc6ael/pxDHKpeoNm+Orz6Svq
 rZUSNyaqFBkqIn19BuPcGqtjdFwksourlwHl9VF6xnlF3+0KcDeITHNvYD+OvVYjDSPY
 +uow==
X-Gm-Message-State: AFq9FYKuhCiEvPAgTiwTspCXJwqHWuHESPGZCJANyVjkq95LCPLTr2+B
 em3Wn29B+IMbeFGY/KmQrwklddfCDIyxt1hzo5XKjfvO4bcpSpFz+rgMWWTrLpzH
X-Gm-Gg: AYBFou2Zp6LqvMyESiaZvUy1tHZB7NDd0iBWzU79MIH+46p8uFCuP7nJRKkXZV4Gj2o
 FwG42w5OihoEnQapJcudzjljp6bG6Jes3oAzg3fwjit7wJTmJP/XMGRfDyGzGq94XaePM1IrKBK
 NGorpkmz7k1921+L/AGBI40EH7Mssl5Aud3GEYZyrPG5JTge0xEhetf0yXIuNAwF5Flj9E3KTO2
 b1VeHD90QM1l/UVTDMA2lhnPyE6u8djVpWNJPqYSFtJ47KbKSaeagFdgDwFI9iwTkhjiVl95x/C
 El5KadkIepLxXv4ec4zGztIn8piuCM4JgiCTdSb0MCjmaqFYg5paYzlITfszNBu0m0qW0U5QBBV
 Y/DKT5Z0i/Zr+/JcrJX5b+TU4tZHAVUK+LfumAFBx01NvtMGRXFNrhihcj+qTXi2B/DUyB2U/W/
 K99fAzKn+oTvtVdgIxZEvXzHOPi4q2jkrULrp1UgNxgsm6/9NgX+aydyAhFGkwG2hBEj9u8lilf
 fzCsYYaKEZqcfvz8RsUmDDKkzU=
X-Received: by 2002:a17:90b:1c8a:b0:39e:6c69:34d5 with SMTP id
 98e67ed59e1d1-3a098e900e7mr14307870a91.57.1790671491637; 
 Tue, 29 Sep 2026 01:44:51 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a497e942eesm5163120a91.4.2026.09.29.01.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 01:44:51 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V18 08/13] virtio-balloon: Update tracking iothread users with
 holder
Date: Tue, 29 Sep 2026 16:44:11 +0800
Message-ID: <20260929084416.1600199-9-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929084416.1600199-1-zhangckid@gmail.com>
References: <20260929084416.1600199-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=zhangckid@gmail.com; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Replace raw object_ref/unref calls with
iothread_ref_and_get/unref_and_put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/virtio-balloon.c         | 21 ++++++++++++++++-----
 include/hw/virtio/virtio-balloon.h |  1 +
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 07d519cf6d..cfc581940e 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -896,12 +896,19 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
     s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
 
     if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+
         s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
                                            virtio_balloon_handle_free_page_vq);
         precopy_add_notifier(&s->free_page_hint_notify);
 
-        object_ref(OBJECT(s->iothread));
-        s->free_page_bh = aio_bh_new_guarded(iothread_get_aio_context(s->iothread),
+        s->free_page_ctx = iothread_ref_and_get_aio_context(s->iothread,
+                                                          &io_holder);
+        s->free_page_bh = aio_bh_new_guarded(s->free_page_ctx,
                                              virtio_ballloon_get_free_page_hints, s,
                                              &dev->mem_reentrancy_guard);
     }
@@ -928,7 +935,11 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
 
     qemu_unregister_resettable(OBJECT(dev));
     if (s->free_page_bh) {
-        AioContext *ctx = iothread_get_aio_context(s->iothread);
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
 
         qemu_bh_delete(s->free_page_bh);
 
@@ -936,9 +947,9 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
         s->free_page_hint_status = FREE_PAGE_HINT_S_UNREALIZE;
         qemu_cond_signal(&s->free_page_cond);
         qemu_mutex_unlock(&s->free_page_lock);
-        aio_wait_bh_oneshot(ctx, dummy_bh, NULL);
+        aio_wait_bh_oneshot(s->free_page_ctx, dummy_bh, NULL);
 
-        object_unref(OBJECT(s->iothread));
+        iothread_unref_and_put_aio_context(s->iothread, &io_holder);
         precopy_remove_notifier(&s->free_page_hint_notify);
     }
     balloon_stats_destroy_timer(s);
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 53bbaa4c9a..5c3731b3e9 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -54,6 +54,7 @@ struct VirtIOBalloon {
     size_t stats_vq_offset;
     QEMUTimer *stats_timer;
     IOThread *iothread;
+    AioContext *free_page_ctx;
     QEMUBH *free_page_bh;
     /*
      * Lock to synchronize threads to access the free page reporting related
-- 
2.43.0


