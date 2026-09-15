Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC115C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6QEn-0003Nb-OO; Tue, 15 Sep 2026 06:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x6QEk-0003N3-7l
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:18:02 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x6QEO-00033k-Ob
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:18:00 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1ceb47d53so432393a12.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 03:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789467454; x=1790072254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yEaJNJW0M3RfOG4LVNk4cR5m8NBuIru80hqnsp5wPiU=;
 b=LtcSUylcFuK8zBL5h/42SU1UIJzfk337zjL8xgHq0+xKA/C8wlakwrf6bW0d1/gKkc
 ck0dsi3K0wUBajdFJ2Uh4xyS0r2F6PL8+lEzQELmpnb+MGVfIJnaBQn3DjQkQaBUDbHR
 IjRUnT60wWOzKjDfFv5IUTm7hEVerkBxfn9qy0Xtea92RxESuui+jOTaPROkR5iWolpV
 YKOkKLv2uFQknlIxXaGh256q5CQmyA13nPH9raEM1uO79v+XxxvFMpHyqDoc3C5DbrA9
 3PkNDbxhBZ0YyTryKhQs9RSg+pYM6ipZzSxF+dx23UwS2eHWhk5aYf8APq4vnbkr9cm3
 ik0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789467454; x=1790072254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yEaJNJW0M3RfOG4LVNk4cR5m8NBuIru80hqnsp5wPiU=;
 b=rb0zCOTzT9UPnwaksTauQohfkYP5id/rBp4wrcFRxflT85wgbIxqDZJQpI/HWQNIwf
 tXX2h7w4uGBKa6fnLYoNGBwcI1sg4hmVsWUGiQcSvBqzUEXDCyxsXieFLC8ZYpX48gza
 5I3d7AWIQjLI85i7E+IcOrLcGLORqf93zTc3MdjVwytacdzrrbikn4Ds7bJs24x8FlFn
 XSNNd+VFZvTgRh5owJd4OeIoSqnBrpuxqtsNdwYEUuS6PxHsk9V5DUD5nxWMBWWZw6Yy
 QTJRiRcEaKjoumQUz+1+QmedJUJob5BiLCCHf+GXJrbAd8xtFB/2SbQ0zEBaUZzGNsiN
 wHvw==
X-Gm-Message-State: AFuF++nRYeq2eUIozy9LQHlmVKfhk/8DP8eMKWKyYroeAXpkpjOhMrmX
 6IFGEozOitfKM5SgH1cVVpZGVCQ4UghWcmjUaL0nB/ECYGoBAKITSVSv+CNnrw==
X-Gm-Gg: AYBFou2ulxu6Ip54r4BLqkiR/7GKRavG1gTHgCeF7OrSuonIY5R2i6XiVUoOIdB7nnB
 T/fsQ1I18j4Bl7UKe+u/bEFaVyt/qXdg9T189O94Jl9ra4horp0wnvYMdkw6UqmACLPLq/TnpoO
 2MuU4iNqRJaeEpToiBVJ29EUOsaoElg8bB1yWM0/TUvAz7ajj5xWfywgcCfCmyA9yOF0P/gRkFP
 meR3SMkBbY5YaNFAaklSDJs71Xuh7ACBrP27kxFe3PcfwANzzyki0PZf+r4yUduyKoopLLkPYQ2
 9yK12zZqhG+mlyzUfaABjsTyySnYs62usuQUWfnfWfT6B3qGQj/uYUknsoftsEghd59YNGl+TqX
 tXnvvDRDJcKVJzpAffc2EtMG97Xl+q0PZCQ9Lhb15j8v2Nf/nULpbzUHJRlYRqv8+od7KkWYVv5
 CRCJzfHpyqZnTXm672pyzaA0Ir9cdnGP2fTBkBsb3OmITnLNXSzYrv7+LgAdd1TBCly8fTVdtS9
 dgN9mJ5BdCxjjaENl+7bm27xTM=
X-Received: by 2002:a17:90b:5646:b0:390:84db:888e with SMTP id
 98e67ed59e1d1-39dfe097622mr3817911a91.7.1789467453747; 
 Tue, 15 Sep 2026 03:17:33 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdacba6bsm4416868a91.14.2026.09.15.03.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 03:17:33 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V17 07/13] net/colo: track IOThread references using
 path-based holder
Date: Tue, 15 Sep 2026 18:16:49 +0800
Message-ID: <20260915101655.3216101-8-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915101655.3216101-1-zhangckid@gmail.com>
References: <20260915101655.3216101-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=zhangckid@gmail.com; helo=mail-pz2-x10.google.com
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


