Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5012CA5FAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBTSK-0005p9-00; Tue, 29 Sep 2026 04:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xBTSF-0005oD-Mp
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:44:51 -0400
Received: from mail-pz2-x29.google.com ([2607:f8b0:4864:3b::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xBTSD-0003m8-AZ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:44:50 -0400
Received: by mail-pz2-x29.google.com with SMTP id
 41be03b00d2f7-cc7c4c92477so242891a12.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 01:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790671488; x=1791276288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tgB8UHMviU6AGL0Oo+1NRKolrlklycCTQp3aiug74lo=;
 b=FwS8m4LfWholmarPke8sonN8gf6EDHBHwzVNY2UwEbOrAtYIhQxqb4Ppf+YqxavT3w
 XpW98JnBb0DZcwAEwhScEfRGWwpb8vupRJjPZdOoUdDzDqFPbMifP2v1uK0i788CWuQ3
 fqKDR4Vc7sALLv/iuzFKhW1ObRwE/tYfZstu1YCNEchMHxidu8w/oleMrOzlRKwVmgCG
 P7us4FjFeOnRwMP2PieQG9tC8C2sdtqx2JRQQi496JsY3cUBATrnKxmcY6Ki+HFZoQbW
 2WHkzi1CTsbGfQCvunOfBBFu2V7dcZ+DPJr8A70HJT0mF8e6bJqa69K740uWhmJ0GP29
 qhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790671488; x=1791276288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tgB8UHMviU6AGL0Oo+1NRKolrlklycCTQp3aiug74lo=;
 b=msOTy71eJG4sioaUjDHCMCtEN6PGzmHYy9vHup2OA7P10/o0bOZfsCO+pcBcLR15o7
 f2DJMG9q47Zekm/JNLtSbFzYH1w2+nJ/3ejfckwGra04s2LktM1m3r4dZRqeycKI3AFh
 CRYBAzl61LUrG/ylc9gAoXxLsFOkJ0yy7Z4T6wHlkBvoQwd6rS93VhVAzx+PZJdydkMN
 4UQ4VqfR4l2HE0Xwu3mxEaPOrqDjrH0+4kJ9h4eSHuNlsr1oS4IhqWv9ZwC0td+tnWBk
 P9TkrOw8Hk5/whwTElHeJaf3CCABPHe1cmWHOLMZlkUkULWVfsgIcE3E4bRwxu19btzZ
 /6CQ==
X-Gm-Message-State: AFq9FYKTOOBuXkPs4hFZhS+X04dbblAUyfHnqLLpxPPtYKYzpjHDrGMW
 Qt4pwQqzte43oRB46bNINLiXqR6JnBQpMOKndV7A0GNqPerzc6DMZICt+YttQSYa
X-Gm-Gg: AYBFou1IQ0NBAB4Qy/In6aNDNxqdTCQa2LyyG8QyHMY/XVevd+bvAE33gSq7k8/W8ZD
 f1SvtTQeez1Qb7hnuljYQ+QV8Jk3yamP9Bnfmcl8NoSMsV4ryR/LSdf0w8N5InGjqSsCswGmTc6
 HPDeQdTraIW3ED9BDrYOSZTNR9xgu/k/u+zvW8lxhHiFdKGeR4/Y/rg01q0sgUnr7u4/MwsNS6r
 C0XM2/xUARh1svRdngHCpMpX1sLHj8IAzEaGKJ6oBikWsCpXvVwnrzAN+DicVqw7gVihNztUSza
 eESmw7Woq1RwJhALHDejTZKAcwsuPmv4ISduDLtbFclq1OWp71Jaie+vPRUFR0Y/Jr8fm26uVtC
 m0I8LYLKpUe4Qq5YoDfikHXaJxUGbejWTC+qhWNvN/fMcXgBFSYNvKaiQUnubpEyYkdka6UfXeZ
 DQHyeD/N8Y03mUlmgf0jVJlaGWV0PcMXYzqbP9g94NTrQ0Hz5kry2vF/iFdgs8Q5bGx4Cl0f/Kc
 Tg3UBrV/YUap9sNlM4wlXbFFzvDMbMpRQorGA==
X-Received: by 2002:a17:90a:b81:b0:3a0:a259:c678 with SMTP id
 98e67ed59e1d1-3a0a259c8a6mr8811189a91.28.1790671487812; 
 Tue, 29 Sep 2026 01:44:47 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a497e942eesm5163120a91.4.2026.09.29.01.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 01:44:47 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V18 07/13] net/colo: track IOThread references using
 path-based holder
Date: Tue, 29 Sep 2026 16:44:10 +0800
Message-ID: <20260929084416.1600199-8-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929084416.1600199-1-zhangckid@gmail.com>
References: <20260929084416.1600199-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::29;
 envelope-from=zhangckid@gmail.com; helo=mail-pz2-x29.google.com
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
 net/colo-compare.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 5986fb1e88..4a7e7d8012 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -130,6 +130,8 @@ struct CompareState {
     GHashTable *connection_track_table;
 
     IOThread *iothread;
+    char *qom_path;
+    AioContext *iothread_ctx;
     GMainContext *worker_context;
     QEMUTimer *packet_check_timer;
 
@@ -922,9 +924,7 @@ void colo_notify_compares_event(void *opaque, int event, Error **errp)
 
 static void colo_compare_timer_init(CompareState *s)
 {
-    AioContext *ctx = iothread_get_aio_context(s->iothread);
-
-    s->packet_check_timer = aio_timer_new(ctx, QEMU_CLOCK_HOST,
+    s->packet_check_timer = aio_timer_new(s->iothread_ctx, QEMU_CLOCK_HOST,
                                 SCALE_MS, check_old_packet_regular,
                                 s);
     timer_mod(s->packet_check_timer, qemu_clock_get_ms(QEMU_CLOCK_HOST) +
@@ -964,8 +964,15 @@ static void colo_compare_handle_event(void *opaque)
 
 static void colo_compare_iothread(CompareState *s)
 {
-    AioContext *ctx = iothread_get_aio_context(s->iothread);
-    object_ref(OBJECT(s->iothread));
+    s->qom_path = object_get_canonical_path(OBJECT(s));
+    const IOThreadHolder io_holder = {
+        .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+        .u.qom_object.qom_path = s->qom_path,
+    };
+
+    s->iothread_ctx = iothread_ref_and_get_aio_context(s->iothread,
+                                                       &io_holder);
+
     s->worker_context = iothread_get_g_main_context(s->iothread);
 
     qemu_chr_fe_set_handlers(&s->chr_pri_in, compare_chr_can_read,
@@ -981,7 +988,8 @@ static void colo_compare_iothread(CompareState *s)
     }
 
     colo_compare_timer_init(s);
-    s->event_bh = aio_bh_new(ctx, colo_compare_handle_event, s);
+    s->event_bh = aio_bh_new(s->iothread_ctx,
+                             colo_compare_handle_event, s);
 }
 
 static char *compare_get_pri_indev(Object *obj, Error **errp)
@@ -1429,20 +1437,24 @@ static void colo_compare_finalize(Object *obj)
     colo_compare_timer_del(s);
     g_clear_pointer(&s->event_bh, qemu_bh_delete);
 
-    if (s->iothread) {
-        AioContext *ctx = iothread_get_aio_context(s->iothread);
-
-        AIO_WAIT_WHILE(ctx, !s->out_sendco.done);
+    /* Only wait and release the holder if initialization acquired it. */
+    if (s->iothread_ctx) {
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
+            .u.qom_object.qom_path = s->qom_path,
+        };
+        iothread_unref_and_put_aio_context(s->iothread, &io_holder);
     }
+    g_free(s->qom_path);
 
     g_queue_clear(&s->conn_list);
     g_queue_clear(&s->out_sendco.send_list);
-- 
2.43.0


