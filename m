Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E14C624A5
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x14SK-0002h9-08; Mon, 31 Aug 2026 12:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x14SA-0002XE-Mi
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 12:01:50 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x14S9-0001dJ-0e
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 12:01:46 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2d9004f39d3so19441335ad.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 09:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788192103; x=1788796903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lKz22n5M1p9e+lq2eACw61LK9eCTpfpP/G3iYA7eH9E=;
 b=LpGeSm7QUk0ux5U1pg0grizm1ysxUlS+HwNJ5yjxmrOc2UXQy+I2T9dfel5RFpl2MS
 O/EkZVRQ5g8ybftUCm0CJDJPJVFYmuP+nyZ2ByAUgtj19LAe4YiqU9qkQkboLuPrWs8u
 5jB0Adhx3G6DUPSAErKTSUWvYDFOi6fMlPii9rQ+EUwnXcfeYG21ybeSxv2+bKqSMZfK
 6a+ec5nf/Cv09VVab2RLuH16iitEOpnEIs8LMpQaz86Y1dURBJXZUe+P7YEzoGsEe4QV
 pRqbjFQZtfE81GbF31ORcAs9155I4imPK7W+sbGTaBA08nnvSMhGQonbm4W4tcR4sCT3
 f3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788192103; x=1788796903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lKz22n5M1p9e+lq2eACw61LK9eCTpfpP/G3iYA7eH9E=;
 b=XkYqvXO6hFVWDSeHHVmzTsAoX77s3YTXBS5PyAvKzGPLepOH589q7HZm6vZPB7CA3g
 FfKPZmTBtrP0P1vMmwT1BNDcH0LWUyzCi71ok95KtvRv0cr3bnnmbfCUhqBM+k6V2yrU
 fkaoltmRdFWBD9aoNEnv5mTaR8sfOWMduE+rgM7m3R6D3Yg2gepOb70djNSaDYx2ites
 5uL5/XJHlebTSt+dhEMpSOE5z1sRAjfOwdCgYceeDR4G0cEAi7/9VUfDnzgPdovbo/cC
 h8HLhqn0B0LOrWjFSKOh9bkx3gSw2ufvfa42bEcT/B/RDYr6VZ1SFJA9EyeN4FG8Faee
 8yzw==
X-Gm-Message-State: AFuF++maeYDIaS8u1ASmW64uCYb61bKSQF11SjCxJGuOZpwC9euSEdud
 0mNXaTZfcqHegZWmOYJugGgYdpwLvD0WqJCyeOev9e2NeR3Qpcf1vXTGULo1JgE49TJcWPbu
X-Gm-Gg: AYBFou1bE86vNicAhMYbWltIKZNJOhRMtW7HVBeRZmFWjMm5SEXfG7uyzR1hHyGw8s8
 NC8uUUBOJlS7+R++zz+zC0oRj9dKJsQK0JmdNEIya9dL5T09JKTDQK6f7WNn6qcAa66U5Io5uXe
 j0ya4SEDDQm+WxswfYUm6gcAUEo5VOsE9dhZvB3Qo90HN9ObeStk4UUtpYl8PxB4Ng9SvvQ69rZ
 wRfmbre/IfAyPWGMUPqaMAR7LSNbpC+4BPNBx5zMcxnPF4UG2S5HSISh2sJSv4PV3ZuXr0vzusH
 eg/jRpslcT5MgWZEHkbnTXhzpRJobvQL0ZOc7avsgHfkj/vKt+OKwVwJsjqBM98tNm4zj4qKTfs
 LhWahQZcENdNRmUcASQGP4pZkx294HPgg5thTpvr8549npdDOTiEyhw01tJNO7Xs61F+RhwUODP
 PNTCmS191LdKQuBv6uCsdZe5CXAAI9wr+LJOsJvH+YghiCtZOnTyDhIhlZCRnr48FqBq5NSzFX9
 uVPm4Zm
X-Received: by 2002:a17:903:38cf:b0:2d9:4358:73ab with SMTP id
 d9443c01a7336-2d94a96743cmr22831435ad.19.1788192103273; 
 Mon, 31 Aug 2026 09:01:43 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32b28ab0571sm22689520eec.4.2026.08.31.09.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:01:42 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V14 09/15] net/colo: track IOThread references using
 path-based holder
Date: Tue,  1 Sep 2026 00:00:30 +0800
Message-ID: <20260831160038.221776-10-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831160038.221776-1-zhangckid@gmail.com>
References: <20260831160038.221776-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x635.google.com
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
2.55.0


