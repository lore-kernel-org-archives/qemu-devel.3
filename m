Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D4E606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YhhJWOsE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLzvv-0006wZ-8n; Wed, 28 Oct 2026 05:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLzvt-0006w1-NZ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:26:57 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLzvr-0006hi-Ve
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:26:57 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2e812e2b31bso3885025ad.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 02:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793179614; x=1793784414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KGU/bxQqqI8Jedr+C0vr2XVXdkAsXqpI/Tim4ReJeJc=;
 b=YhhJWOsEAy/HtxCRjMQ3YjvPCZgOz3+qqp8e0Ji1I46xdVx85+qfKcLo4vkKyClGJT
 PsRZTD6eiePPHEVDlyqat+PlySZ8tvxoxe1SbsyxD00SGXHgFag/FX/UfofiZs+0eyTD
 9JBLQ7/O8slLHsK80RpNHTkubDCT9TcpNWroe35yEXqBywoSdAktoz1SqDfxG34LWxWf
 grvmJv2RKccRfSJWD6B3IY6z6zV920d9DW4evILk28OEsZcPb6iu4voI3gbAPzzcRReq
 8KhWQ4WebeIevOYdCF9uKTgAxzEF4bmvuL4QrAiN1nicTED1Gehy1HKqzlMSKGOs+h+E
 /EUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793179614; x=1793784414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KGU/bxQqqI8Jedr+C0vr2XVXdkAsXqpI/Tim4ReJeJc=;
 b=rsZHEyErBXSGrGkc9i63MZOA8Xrp/9uEo/YaiutqTd6IkHJwc5yO/Pc03or5H8PYI4
 0FdPOBm7vPtbo5X/23OXt4LrfoVcfhJmk8TAsJAcVvc+vU8GydcS3OF4ztL+k393Jia3
 ge0UqG80nwkys2mF6q2Y+bn8jSd7CgOihLhjWY4uZdOwh/6NfSNuP1+2LxrZKXamtkmr
 Y9y80u+SvplVIEff4GegIvDp0cs0FxUuS20ZWn2gs6W7ChIJGSINiitBF5iey0aZJWEA
 tGtFQ4k6xW/uy/YZi9cen05Gq5dTn23k1V1CvO7KBnvbG4e3cLoak+Lf1BiviKdlqpu3
 kRfg==
X-Gm-Message-State: AFq9FYIuJQLaKnuGtA7jY5pY3HEGbIsfho9lHCdK7I5QHLRysuY+QVuu
 AqSFg0aTGArPg7ABlGlQxhFuaHU9nWm262mS2XGbGDA2IUkxeIkxC6OBj8XOaOF5
X-Gm-Gg: AYBFou1cuLr50UBucg2twQeSWz8ZRX/9B/9YPL6qYk3yZ+myj3w/uY2nIX44GvoS/wk
 FBTK778ZEk+DCwiccF/QbLlLLCdZb/7m1IL2TCjwXATjnw5KBZUGp68MbaAV8+ary11aFatMIzn
 W+mz26Q9mYRcFDPPADbo/bH20Rc6NQ8o+DulWLXDNQLJ11CJZlKX0nv6mTA/SNUUqfvzUw7dYlg
 TtulBsOAso2DBLY9w2Q2/KUUHDhBv9GPVZdO+iN8cQDJ4Rk7Ba1EXkIF2SCSkMyi+VkDZvzoa7B
 8+VUrLvilzM7zcfGcvNp9zgSnK85eygf8fl9vrn7FqFnu7KZ2heQVRkWdojEzUsgVveXczdF6QW
 tsTf6pYrJi9q924nrmpdhSGvgX1LDHj/PGr5fhZnJ0cUOOg5/GHax3gApu0AyDwHGLYiYEuR86g
 FuiGelRHUkLumv4k0NGdRIOLXqMafw7O2EGp2Ve9eshqz5+EtqD7vru/ZJZm8M1I3gsf0HdSlA3
 8DOTjotJ5TWxEeDZGC8wK5dNxwZ8zgoH4FDMTsM8MPlaFtlsYCXgv01qfO62XvFaigDEYQ18UKW
 /AKKqeqClDV+DGTNRa1qey+4bYgE20ic4iJBn0Bw5qavJb9KMK0u2HjHg9s=
X-Received: by 2002:a17:902:d4c4:b0:2e6:4e5:b399 with SMTP id
 d9443c01a7336-2eb003763c3mr17992315ad.26.1793179614344; 
 Wed, 28 Oct 2026 02:26:54 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6b7a691sm19481635ad.26.2026.10.28.02.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 02:26:53 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V19 07/14] net/colo: track IOThread references using
 path-based holder
Date: Wed, 28 Oct 2026 17:26:12 +0800
Message-ID: <20261028092619.1654474-8-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028092619.1654474-1-zhangckid@gmail.com>
References: <20261028092619.1654474-1-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Convert colo-compare to use the iothread_ref_and_get_aio_context() and
iothread_unref_and_put_aio_context() APIs. This ensures that
IOThread references are tracked using the COLO object's canonical
QOM path as the holder ID.

This refactoring improves IOThread lifecycle traceability and aligns
the code with modern QEMU iothread reference management patterns.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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
2.53.0


