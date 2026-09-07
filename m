Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9988BC79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 06:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Szj-0005jf-0T; Mon, 07 Sep 2026 02:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x3Szh-0005jJ-Qt
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:38:17 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x3Szg-00069N-7j
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:38:17 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2db18e5cb56so28404265ad.0
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 23:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788763095; x=1789367895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yEaJNJW0M3RfOG4LVNk4cR5m8NBuIru80hqnsp5wPiU=;
 b=LvIrDQ8Iou+29XBm0h5ONDwJDGEkeW1knRyQU9iApGqX0otrvpT/NKo4aEMEX2/foY
 N3I/QBQzNfl5pKcJDC46zO4bHo5k44ZzYEoS5VQgFDX/SMI/sAg+IfAzVhK1YUOL/dC9
 LBdUq5UVY7UR6WCvLCAhtire50YempHF31dVgv9zIv7dsgAKrCWsTZoBSqFBp9YaWOsr
 363X/G6PqhqjP5O7fEtmKD06Mk4kmEPG3+/rdcBPVeLN+fRbIAsUzdsnpUndb1rekLkh
 tudbtBBNgaajff14Yr3RiXJI9CHxB0RYJYBukzI+Sg+SIoyqYHuVaLJIXzHtfxLcYVYh
 Wp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788763095; x=1789367895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yEaJNJW0M3RfOG4LVNk4cR5m8NBuIru80hqnsp5wPiU=;
 b=Dpz7PmF8Qo/+bx+3S2cPdNZSOJoE8x/ELrad3JRndOAfIsOj04vStTeVOg+0xvfKBU
 cM3X4rQUKBMNHSwXG/ss4QZXscabs4gZJWQU0gCt7o0RLn8n/JmM/l4GG4LvDzQ3NPPG
 buuXOm9bnC2Wrz8htHvaPmXOxOWB1Uhev1LVR1NkvHI4B3X13R+ZcolN3FwsyS7B14di
 vkCr0Sfp6AEPuMpPY/QDzO75JWxCWnZ2vSXa+P1pjn8tXVy4rF9dVEZkg74u83kajzeJ
 IsYxxamfvLMes6tK7Y0ziqYdDb2vjUy6LsAS2F9Idi7omnJaGLkH1XfZLaOdUBdJwdsf
 zRSA==
X-Gm-Message-State: AFuF++mX+723De1m9Uvj+PLtFJlBo9a9ZDBFR4+m4ZGHbpYP8FKKenBo
 7N2aZwM1EKANsT4T+hzrywaw4ntQLLShBEPoUS15Krq3Z8xHQ7svmJPcShz4YlinYtLYlw==
X-Gm-Gg: AYBFou2jRMfidRqMKbLERbCrYvYD4XZ+dwFLREQB5iIMp/lJkVd29xTeO1H9QOBhpiA
 YoVb2wQYad1Xf5tiHMABlPdB1XmASfaDuyoBezuIfjzjDCTYz26YJOgskya1QnWS5TdOXpaWMdo
 ZmH42pftkdAo1Tntz/9eguYIDIbkSsZve4K7FzC3a1LfOmFKOCMY7j5MVRPd8Xsm8E+XVLRuVos
 6np/1dMG0zimo+xykWxpUZEymDdeRjkceBYMClcjqsRmIbFnuKSbXgsFZ5+L9Z3q0Age6fgL+K+
 H5CGA8Hi7KZWbB/ajAN4fQbwXrnOFl50wfiOKtHLkdPvAA7IZPlvLnvDw/QxpTZ65L8L/Of1MuJ
 qrpsWHEHivycqDgVLnRgokEAl59EVOE5rw0A9QzpERULSzKadIPUpHYvvCOP/gjVHW6/H9Ltp0K
 j3plfrcrMJvQM4PrEQu1LB0sCHRqnkqAX0G+0LEGQinaGjDgJ0RS6hoOyReP8/FHULRGU1iIBcp
 dO/zA9L78M4DjxK
X-Received: by 2002:a17:902:c1d4:b0:2d8:d4d0:792e with SMTP id
 d9443c01a7336-2db128816cdmr198036915ad.18.1788763094905; 
 Sun, 06 Sep 2026 23:38:14 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1499f06fsm38502555ad.54.2026.09.06.23.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 23:38:14 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V15 08/14] net/colo: track IOThread references using
 path-based holder
Date: Mon,  7 Sep 2026 14:37:19 +0800
Message-ID: <20260907063725.626685-9-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907063725.626685-1-zhangckid@gmail.com>
References: <20260907063725.626685-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x632.google.com
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


