Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C760C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkPmj-0005wF-An; Thu, 16 Jul 2026 13:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkPmi-0005w4-71
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:22:08 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkPmg-0000Uy-KF
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:22:07 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-caf707e3a70so405656a12.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 10:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784222525; x=1784827325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jep4VeB1HvWI8khcgjXgo2Z4gQjRgVcwsTHAZ6Dz3LU=;
 b=qBg2w/aFcgXsoA4CBx31eQ6mgr4QDMavmezlwblfIMxGJMlh70fx/RYghM8LW4tplM
 PjOzB8PMWFoaAAGtLoCxbCz5O757pEBIpFmyIhcyDf5MqeFWi6duu8hHxxtHiVXhgSmp
 yi9pRMBtgaDASbfZHzXyQUy7xWlxJvXuQMcLrPh7mTpgRaZCJkMPgVjKhkYpV7g1LRsb
 rA9oizHtcZu7PpM/M0BIHvuhJwGX7FSl7LvRrPu801SIJPokcXoZ74tw52hRGX1T9DGy
 O8mjd+pjGL2FczyXI7XyzYHJ+6FM44eqZ1w0fZip60M4yNItxTDRL8wOxwZ5WZvqPlFO
 i3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784222525; x=1784827325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jep4VeB1HvWI8khcgjXgo2Z4gQjRgVcwsTHAZ6Dz3LU=;
 b=OpInaEA7rVp93JAuuBOG8L8UPg4cNFJeZK93wHQix27KNKQa7S5GSa6fjdGlNbbSWf
 DPpdFj93Ywj6M353N3r6IPvLrEN+F426wgh45TYmQRQWYJutg/BcXjR1vRWjBtfYAC0k
 C2jmlnbODU0JMe7qjMHFah+Pml6jiXs/KcLOJtS9zwFdfzsLr7McEohSNvOeMh9xMN3x
 9EwCbcQo/XIRodh40UNdvJZJMqKpRYHQ5/KUemXYAJVsW8lznNWsFQtHLEzTkcXJ6XI7
 ED5prDlrsseOqMl7Lww27j7l6qPNHMtz7AKav9hhy5ETeaUXA47wq6Vw7h6UfM6wF3B9
 CFGQ==
X-Gm-Message-State: AOJu0Yw3ObBB8IZokjvvcAntyxk9OFJ3cAc77cvo2NcIDicF3slwPk5/
 KfYtvTJGzBsEWh80TY44YDdK2exu+h10VkqmCGz9QpGZK2mk70R0uW3v2t5Yy9Fe7JM=
X-Gm-Gg: AfdE7cnPZyQFiV8qv7QnP2BcIG+YD6ts+GYpe/Z2xRKwmZmIgXREGYt5iyL0lW6KqrZ
 1ApkadO8ca+NgkXfcLrxIktMg0Dzd3spu3BTo/F+Gyn0mGFTwkattPlKSAR6AObWrvUg2PYFmaJ
 F76uWFxnc2/muLVB9FS3ApKTiJHvoYdDRS0Bj6UL6yLia4dhiCAzHWu5oE2A41G7yhdjeSoxq5z
 +kL90zmQ3pdeg7qbpVoT86Lgg9UPbjCIJGuP8Hw5jJ3oPdqMnr4DjZkBs1rrEz/2aiCgVRwWyMS
 vae5idO0kleaHkg71RLgcrrNIzlFWnJyV24Vi38WMUh7ScViCQ8EBDvvoKuWNEpOJrJDsmo8/QC
 QinkzJqcUO75wFdT9t35Cjo90m21zIoe7I+3vPsbSoBkqB3dZtkbZ3is68muscUJrqdH9uXT2s6
 CnVbIXEb5JNl7MTrlAjx6BUcQ4OaNV+w==
X-Received: by 2002:a05:6a20:244c:b0:3bf:a8fa:a7b1 with SMTP id
 adf61e73a8af0-3c38dc1bbd0mr3846227637.37.1784222524935; 
 Thu, 16 Jul 2026 10:22:04 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.28.233.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm16800417eec.11.2026.07.16.10.22.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jul 2026 10:22:04 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [RESEND PATCH V10 09/15] net/colo: track IOThread references using
 path-based holder
Date: Fri, 17 Jul 2026 01:20:50 +0800
Message-ID: <20260716172108.87700-10-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260716172108.87700-1-zhangckid@gmail.com>
References: <20260716172108.87700-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Convert colo-compare to use the iothread_ref_and_get_aio_context()
and iothread_put_aio_context() APIs. This ensures that IOThread
references are tracked using the COLO object's canonical QOM path
as the holder ID.

This refactoring improves IOThread lifecycle traceability and aligns
the code with modern QEMU iothread reference management patterns.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 net/colo-compare.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 5986fb1e88..a7bbb1056d 100644
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
+    IOThreadHolder io_holder = {
+        .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+        .u.qom_object.qom_path = (char *)path,
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
+        IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = (char *)path,
+        };
+        iothread_put_aio_context(s->iothread, &io_holder);
     }
 
     g_queue_clear(&s->conn_list);
-- 
2.49.0


