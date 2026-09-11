Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C711C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4yAy-0006fq-T8; Fri, 11 Sep 2026 06:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4yAk-0006X2-IM
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:07:59 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4yAi-0007I2-Qe
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:07:54 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-39b9a99469fso674483a91.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 03:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789121270; x=1789726070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yEaJNJW0M3RfOG4LVNk4cR5m8NBuIru80hqnsp5wPiU=;
 b=ikICaOg1F4GzRDUKCnM65Zt77kPA//VA163ijJ94vBQ7OF9ab+yVU66xJ7e6twkK+U
 ffvOHigOBj0dsAAwmAesBSJFaafwJV0cdGRTpQHK8WrI/mA/reMTeuaa0vEKP7v7MqD6
 M1CDVKHepzwnwtKUMxOpAZpQBehGrsSDRnzUSLW7puGUhqQ4C3CksfosT6EXu+nrYZCl
 Zsl2nua+zwrD3rUwKjYHbnmdKLxOCGZ8ZT2f/zP4/8UirjGQhERjHbnjaKefl6FtaDR/
 fJCKpcnk+n6n/8wOtjdQT0dD30vOZEp0SDvOqdsMvINSKV6m+nc4qeFTjfmFnBbP6t/v
 3sXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789121270; x=1789726070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yEaJNJW0M3RfOG4LVNk4cR5m8NBuIru80hqnsp5wPiU=;
 b=IQQimTBsRbMKrY7o2P0vLk+Q0KS7nDE9qFyk6epkbUEw5F5PT1IS8xIvJiVc1a8l4i
 TiZ2RvJ5YwZ4G2EXCmN2CXtcfIfxeX+GAdmHKiaB9J1SRzpcUxd9BLWIlmLPL7BIeILh
 lIsVYrn+zNOJni+c55Hsf0C2/7t80JtHkBvp/Zpm5HVnOJVl3dK3U9eboEv8B084++af
 ZeAVYG5T/px5AeAW7p0K7efNMzvuXHhrUcSr3NQ2wHROtS6HgAaozapr+sh0ie9q+b8W
 TupMKFS4wOSqEzVpjzDMtKTpHpxVxHjQWstKFn1/jwzhnHNUIAlX9Izl+mfofZZHjLVR
 A2wg==
X-Gm-Message-State: AFuF++kpDwTe9lnROckVJ7xUJP/WmCvs9AEffz6hYg08Tcq1G3+cVzgJ
 gdBWvdl/ttMraaidofErazU2jS2mTrYlszbNx6RfFgLq+uPbVF0qkNZE7OQdPQ==
X-Gm-Gg: AYBFou1JfVieFAse1rwa6Hm47h4YBa9kRVamUjK5gY6LXp8d0ZCGXI1iVnBjf18pSsv
 1JHNgC5y13QPBwNvt7e/QdVdRZgym3/DlOhYo66SRXbUNtswcnR+dxhbmUtnSqqZx6CfgArGmfb
 geBWExHEZ9MpVB8Ezz8qfUmCfXnKJ5P2IVy5fCwaEbl6/TtaoBvfja0C7W9i02aEUguuw3z/XDe
 zfgBk/rFKRsM5WpwsTbK/7RwP9+HW4b1Bfy1r0+cftIkxOrg3VSk2VI/xZkrpD7ZoK+3ytCKPlK
 KUaips8VD8KFyWXPCTVFLsPqX/MynMqD+GlAhjBD456sHP4agGkTPSGzIdXL3DZqlyDJaHc7vJI
 fUyQwq0SXRfBfsAfgUAAjJd0suU0bBkiQzzWahTrJ7ZiSF3d4ZD8rMUmSKTF+o8g0uwZd75I6Xj
 +xgCe3cdHWppPDWElBp1MODfWWjSJV7WsyC5n3yyKtEFSrt+KumssO22nUx2dmscMEATBMjcwoB
 wNcivkHXN07KjmNSIuUwE50JRU=
X-Received: by 2002:a17:90b:4a8c:b0:398:9c0c:7c72 with SMTP id
 98e67ed59e1d1-39d9c3891d8mr5771997a91.25.1789121270103; 
 Fri, 11 Sep 2026 03:07:50 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d951d6b08sm4514800a91.8.2026.09.11.03.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 03:07:49 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V16 07/13] net/colo: track IOThread references using
 path-based holder
Date: Fri, 11 Sep 2026 18:07:03 +0800
Message-ID: <20260911100709.726366-8-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911100709.726366-1-zhangckid@gmail.com>
References: <20260911100709.726366-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x1033.google.com
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

Convert colo-compare to use the iothread_ref_and_get_aio_context() and
iothread_unref_and_put_aio_context() APIs. This ensures that
IOThread references are tracked using the COLO object's canonical
QOM path as the holder ID.

This refactoring improves IOThread lifecycle traceability and aligns
the code with modern QEMU iothread reference management patterns.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 net/colo-compare.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 5986fb1e88..361ee32729 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -130,6 +130,7 @@ struct CompareState {
     GHashTable *connection_track_table;
 
     IOThread *iothread;
+    AioContext *iothread_ctx;
     GMainContext *worker_context;
     QEMUTimer *packet_check_timer;
 
@@ -922,9 +923,7 @@ void colo_notify_compares_event(void *opaque, int event, Error **errp)
 
 static void colo_compare_timer_init(CompareState *s)
 {
-    AioContext *ctx = iothread_get_aio_context(s->iothread);
-
-    s->packet_check_timer = aio_timer_new(ctx, QEMU_CLOCK_HOST,
+    s->packet_check_timer = aio_timer_new(s->iothread_ctx, QEMU_CLOCK_HOST,
                                 SCALE_MS, check_old_packet_regular,
                                 s);
     timer_mod(s->packet_check_timer, qemu_clock_get_ms(QEMU_CLOCK_HOST) +
@@ -964,8 +963,15 @@ static void colo_compare_handle_event(void *opaque)
 
 static void colo_compare_iothread(CompareState *s)
 {
-    AioContext *ctx = iothread_get_aio_context(s->iothread);
-    object_ref(OBJECT(s->iothread));
+    g_autofree char *path = object_get_canonical_path(OBJECT(s));
+    const IOThreadHolder io_holder = {
+        .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+        .u.qom_object.qom_path = path,
+    };
+
+    AioContext *ctx = iothread_ref_and_get_aio_context(s->iothread, &io_holder);
+
+    s->iothread_ctx = ctx;
     s->worker_context = iothread_get_g_main_context(s->iothread);
 
     qemu_chr_fe_set_handlers(&s->chr_pri_in, compare_chr_can_read,
@@ -1404,6 +1410,7 @@ static void colo_compare_finalize(Object *obj)
 {
     CompareState *s = COLO_COMPARE(obj);
     CompareState *tmp;
+    g_autofree char *path = object_get_canonical_path(OBJECT(s));
 
     qemu_mutex_lock(&colo_compare_mutex);
     QTAILQ_FOREACH(tmp, &net_compares, next) {
@@ -1430,18 +1437,20 @@ static void colo_compare_finalize(Object *obj)
     g_clear_pointer(&s->event_bh, qemu_bh_delete);
 
     if (s->iothread) {
-        AioContext *ctx = iothread_get_aio_context(s->iothread);
-
-        AIO_WAIT_WHILE(ctx, !s->out_sendco.done);
+        AIO_WAIT_WHILE(s->iothread_ctx, !s->out_sendco.done);
         if (s->notify_dev) {
-            AIO_WAIT_WHILE(ctx, !s->notify_sendco.done);
+            AIO_WAIT_WHILE(s->iothread_ctx, !s->notify_sendco.done);
         }
 
         /* Release all unhandled packets after compare thread exited */
         g_queue_foreach(&s->conn_list, colo_flush_packets, s);
         AIO_WAIT_WHILE(NULL, !s->out_sendco.done);
 
-        object_unref(OBJECT(s->iothread));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+        iothread_unref_and_put_aio_context(s->iothread, &io_holder);
     }
 
     g_queue_clear(&s->conn_list);
-- 
2.43.0


