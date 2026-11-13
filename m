Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168F1606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ifIcZoNX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRnYd-0000f3-RO; Fri, 13 Nov 2026 04:26:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnYc-0000eY-Gd
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:26:54 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnYa-00060h-S3
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:26:54 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3ac78f4c10bso322517a91.1
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 01:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794562011; x=1795166811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4ILsaE/RbsM3VNE0h9xHp+2rECK8FYcxQRFHjHqHcMg=;
 b=ifIcZoNXOKEZzJIwse5Wngg1eEIyx7Jt7A8GFt2P0p6RNExdoQf8mh6q8Wh2Dc5iU7
 zNN/RjyYIJDMM5Wvag0fjC0sEG3okUkwey8Ti+cQyTWSaqlXxVBjoQhu0gy6DCt092sY
 FY4P/RHNu7UY57iL2Id4GKem9jMh7uPfdi6Vht1xlg9ZlU1ncBaibhO7JGuFHkVzfCL1
 mJvJ6n2N6X7dqSkF1KgVZXp/yCQBlXYnJTkiwnGYdyuIXUvg2rEx4CvKYNEZ7V8dVoeZ
 2enyUeakg90a7Mvvb5Yr+6Pz6RHfvMnRGc2QEzKe/VdIOFmumq94b2+von6EraBfVb5t
 pesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794562011; x=1795166811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4ILsaE/RbsM3VNE0h9xHp+2rECK8FYcxQRFHjHqHcMg=;
 b=B1He1rvcQk6oCtI4d5/VKWUYiFbXxQ1C+HxTpUGPhaKbAoozlNMumpPjQe/CLG24sq
 +C0CRW/8WrFosLMzBvLGku0xqZSXnd/ctZicZUGPoYyij5vF+uyA2fh2BKmk+cZiD6nq
 W6VSAEwgLt+3NqFhXyfoHKW9xktkjdWHjSQJAr6A14G4HlND+sTGIA2SAT4JstLLAcan
 16aERt04oidQ88vajxu5X2jqKVa/HiiBpWAubTzCibx/Eo25AEEAqKR2hEmvMSU5BgWe
 SeGe0nh9BAm260aOZYNIadZJzUynUj06SL5wmWHzMDYr6sZc2JLDa2I7bhOrC4153ZjV
 9qVg==
X-Gm-Message-State: APuU4Z+t7EH9QqqAVZJkgqRoA81Acaf/eS4Xx3RbN8F/rmV1doDYs90Q
 5ugdKiW0/YSYoTDz9CP1FvHE50NqBh0O/CUPQjiaizSkcM4qBA6oaFoqoosVJg==
X-Gm-Gg: AYBFou0RUlOFgOTLChJVWMtaMa1udJ7kuFwGNsxLN6mW7RA2cV4qraWZ3DO2aH+4hQX
 5Wwdwq08iBYcj4AiHS4DrP3qjnNZUjNLfbFrVlfeTBeir9xGLua22PUWFzaokq/oxzuxaez89u8
 3GAZ7CBiTjuan+6sWa4yI0ZqCPrDDSReDfQhn3WVe1fgIy5vdbT5JRJ5tqnQ2cOveVqSbpq1vZd
 4jqQ66WkhleUVzdmqTcUrC9n/10PMyWxKbVHc/PnEZMcZEe7wLMNs2vhqQGBiP6QnkjbENiVU9e
 DF5PS6kLN35fUNpWynFlCZ26DnboLLrPS98rZRqdHATe6vckG+HKHw1kAKkV4r2yHaVDZPEVgeI
 uyQNwtF1klPtuFOT7Vj8CAo+3l1EFJpHVp60CjKd7Q7JajkqgTANw20Zum7IDBUdP+65zVOi/3v
 okR6M+5slNoQkX1niNDYM8G0v8plstskACu+u6nXTnHWPTt5ZdXzqZ2nwDIfGbTYVh8hPWSSUo3
 NuVoXqD1r93iE8cYkl1wAF34F+A+sw4rJusMxYeCMHWY2eZFXSE7fpdcszlMGv5D1b1XdwChaOp
 7i30aocjDGl84Q3W4wXmPfHDpel2Hn5RcDXS14IFlYDfdInf2fd/BhjzjTY=
X-Received: by 2002:a17:90b:4b84:b0:3ac:ad90:7090 with SMTP id
 98e67ed59e1d1-3b1b0ccf3b1mr1914048a91.67.1794562011356; 
 Fri, 13 Nov 2026 01:26:51 -0800 (PST)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee0f7d0887sm7428605ad.32.2026.11.13.01.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 01:26:50 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V20 07/14] net/colo: track IOThread references using
 path-based holder
Date: Fri, 13 Nov 2026 17:25:58 +0800
Message-ID: <20261113092605.942292-8-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113092605.942292-1-zhangckid@gmail.com>
References: <20261113092605.942292-1-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x1031.google.com
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
index 9b04b28484..c462284b99 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -131,6 +131,8 @@ struct CompareState {
     GHashTable *connection_track_table;
 
     IOThread *iothread;
+    char *qom_path;
+    AioContext *iothread_ctx;
     GMainContext *worker_context;
     QEMUTimer *packet_check_timer;
 
@@ -923,9 +925,7 @@ void colo_notify_compares_event(void *opaque, int event, Error **errp)
 
 static void colo_compare_timer_init(CompareState *s)
 {
-    AioContext *ctx = iothread_get_aio_context(s->iothread);
-
-    s->packet_check_timer = aio_timer_new(ctx, QEMU_CLOCK_HOST,
+    s->packet_check_timer = aio_timer_new(s->iothread_ctx, QEMU_CLOCK_HOST,
                                 SCALE_MS, check_old_packet_regular,
                                 s);
     timer_mod(s->packet_check_timer, qemu_clock_get_ms(QEMU_CLOCK_HOST) +
@@ -965,8 +965,15 @@ static void colo_compare_handle_event(void *opaque)
 
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
@@ -982,7 +989,8 @@ static void colo_compare_iothread(CompareState *s)
     }
 
     colo_compare_timer_init(s);
-    s->event_bh = aio_bh_new(ctx, colo_compare_handle_event, s);
+    s->event_bh = aio_bh_new(s->iothread_ctx,
+                             colo_compare_handle_event, s);
 }
 
 static char *compare_get_pri_indev(Object *obj, Error **errp)
@@ -1430,20 +1438,24 @@ static void colo_compare_finalize(Object *obj)
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


