Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687DECD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRHW-0002hG-Bu; Mon, 11 May 2026 10:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRG6-0000Xg-H1
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:05:22 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRG4-0007Gq-Ad
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:05:22 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2b9705613ddso26658095ad.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508317; x=1779113117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uuSnosvKOTz8eJA5oflodvBe0T0VjN/x4jx6Aoy2gcU=;
 b=Ja0ZSqQSTEs8F1f9UUiWhp9EXOm4mOv8yydf3KibyUWTVDm/sJiBH4BtxIH+eBZaU/
 E3raFYTQFdEFsEH4d20L1Dgv8aGuKnQX7CSeH+dbZ+X3Mxa2vZ/AlqWPifRIBhD3Ra+k
 JUcn2iEZxvs3ZsVXDDaFw1HuIurDMiFRDWaN5NM5VJcrGHFsMgSDqGAMDWV78sbf1GdJ
 9pT0/xn/GJedXCuxzsSyuSNSk6fkf+FhIVE3XvMN4Udqt4RSIxodqTYH6gaan30NMYmn
 Acd+IwZcvjrTGzYEfjDMkpRcAHRncK0bNfgLabWNyn4NRDFHiuKI/MDcM5augoPXBfvR
 DknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508317; x=1779113117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uuSnosvKOTz8eJA5oflodvBe0T0VjN/x4jx6Aoy2gcU=;
 b=BFrx2KTHPGagMB3EnGLU7F2nz07tzEmw7nfg7m1FsgB0VjvU5zl0slYLxKJowntuG7
 W5vYV4Pe5jAqFeIuqMhJpM1+iRpnQmfP9OvQ/d7vqqy2ZY8Aonpc0+Qsanb5hp+We2Yy
 5N8njSLAVVBA/l6L/uSSPl/n2dhSaoreOXVeEg2n1qyR94cBCC1mI2jf171TOKk5czsX
 zZ1cRKdMevPBg2UsLhhrINxvqpgQIEpDqdyGnt/K+ICZbMxyvWDwU9stV+szTKSdRTBT
 6ahgzoqipIcSoxqQQycefGQWeMXJaLY9QMYsNyCpIwSmzSwliRxbpZ+UJ6QMlxq9bsIb
 gW9w==
X-Gm-Message-State: AOJu0Yyave6bA5/PvNOk15p9fDIZU04cOT2QgiMe+lZfrlt4CUrBvOnO
 aZ6UY7Z/wNb65fSXU4d1srcwmO9SFNm1CPbLmJ8RnF8UBAsDJn5rmP8OjxzXUr6Cqxo=
X-Gm-Gg: Acq92OExCcsKDKfx8o47zf2Qkh2Tt13Xd2DZ+B916Nr4pYHyWKkwqgl+MOW9oRngIAc
 AgBKPpGaFkgOUmcxXhKq/9p6BKYRzxqdst1JRhBsTjwPysHKPgcDy5ua2gQkk/aHofpZ4Nfi/lz
 P+QIE0peFYzpE4fsRT9DVz5uwluFgJZkhMxrEGoxJyUTXMPEacA5UxALt/KsU/U/jb/a+GhhNLm
 5Cm7OCjrZLoRQHqXXAtJZ1wtJ5xsVmJ9wKXgr8Cn9pVP0F/yMSP6waNA3AEhYpVXSjHNuX/QVSE
 DyJjIk6w0zibPYlEutzFSSHJL9DYGNB59Ex6VZrpoHkFWl6zeQrUGMW0HFTcIWlHWs98okr3saj
 w1dI6Hl1d1NjXI1cjr5nDe8EgqTfDH54qUBeIKC8oe8XgR3fTa6RAozwPVnKZ2QS6rXtMmgzmOq
 PGIiOOnlyM6yotd/xs3DVim2/fNrzo0rqHu/hCVwS/H1YkZQ==
X-Received: by 2002:a17:903:380d:b0:2bc:e2ed:fd03 with SMTP id
 d9443c01a7336-2bce2edfee0mr27144555ad.39.1778508317518; 
 Mon, 11 May 2026 07:05:17 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([115.108.63.147])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1e90854sm105113435ad.66.2026.05.11.07.05.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 07:05:16 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V7 09/14] net/colo: track IOThread references using path-based
 holder
Date: Mon, 11 May 2026 22:04:11 +0800
Message-ID: <20260511140416.28271-10-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260511140416.28271-1-zhangckid@gmail.com>
References: <20260511140416.28271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62f.google.com
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

Convert colo-compare to use the iothread_ref_and_get_aio_context()
and iothread_put_aio_context() APIs. This ensures that IOThread
references are tracked using the COLO object's canonical QOM path
as the holder ID.

This refactoring improves IOThread lifecycle traceability and aligns
the code with modern QEMU iothread reference management patterns.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 net/colo-compare.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index abc1326b70..8c83da95e8 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -130,6 +130,7 @@ struct CompareState {
     GHashTable *connection_track_table;
 
     IOThread *iothread;
+    AioContext *iothread_ctx;
     GMainContext *worker_context;
     QEMUTimer *packet_check_timer;
 
@@ -926,9 +927,7 @@ void colo_notify_compares_event(void *opaque, int event, Error **errp)
 
 static void colo_compare_timer_init(CompareState *s)
 {
-    AioContext *ctx = iothread_get_aio_context(s->iothread);
-
-    s->packet_check_timer = aio_timer_new(ctx, QEMU_CLOCK_HOST,
+    s->packet_check_timer = aio_timer_new(s->iothread_ctx, QEMU_CLOCK_HOST,
                                 SCALE_MS, check_old_packet_regular,
                                 s);
     timer_mod(s->packet_check_timer, qemu_clock_get_ms(QEMU_CLOCK_HOST) +
@@ -968,8 +967,10 @@ static void colo_compare_handle_event(void *opaque)
 
 static void colo_compare_iothread(CompareState *s)
 {
-    AioContext *ctx = iothread_get_aio_context(s->iothread);
-    object_ref(OBJECT(s->iothread));
+    g_autofree char *path = object_get_canonical_path(OBJECT(s));
+    AioContext *ctx = iothread_ref_and_get_aio_context(s->iothread, path);
+
+    s->iothread_ctx = ctx;
     s->worker_context = iothread_get_g_main_context(s->iothread);
 
     qemu_chr_fe_set_handlers(&s->chr_pri_in, compare_chr_can_read,
@@ -1408,6 +1409,7 @@ static void colo_compare_finalize(Object *obj)
 {
     CompareState *s = COLO_COMPARE(obj);
     CompareState *tmp;
+    g_autofree char *path = object_get_canonical_path(OBJECT(s));
 
     qemu_mutex_lock(&colo_compare_mutex);
     QTAILQ_FOREACH(tmp, &net_compares, next) {
@@ -1434,11 +1436,11 @@ static void colo_compare_finalize(Object *obj)
 
     qemu_bh_delete(s->event_bh);
 
-    AioContext *ctx = iothread_get_aio_context(s->iothread);
-    AIO_WAIT_WHILE(ctx, !s->out_sendco.done);
+    AIO_WAIT_WHILE(s->iothread_ctx, !s->out_sendco.done);
     if (s->notify_dev) {
-        AIO_WAIT_WHILE(ctx, !s->notify_sendco.done);
+        AIO_WAIT_WHILE(s->iothread_ctx, !s->notify_sendco.done);
     }
+    iothread_put_aio_context(s->iothread, path);
 
     /* Release all unhandled packets after compare thead exited */
     g_queue_foreach(&s->conn_list, colo_flush_packets, s);
-- 
2.49.0


