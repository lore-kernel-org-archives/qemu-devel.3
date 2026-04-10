Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1014F459EB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBDQZ-0007AA-QH; Fri, 10 Apr 2026 11:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQY-00079j-Ey
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:46 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQX-0002Y1-0s
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:46 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-35c238f1063so1608781a91.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 08:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775833543; x=1776438343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a1Kh3XSHSeM1ZEixAaGnsOegNSycBCR3GL6VS/B2SVg=;
 b=DdL5ohiIU1IvTFomJgwbItORplh48Q4AGjuD0lDDPFPfI6BKwKIrC6vpArhMldJVrW
 EaoMqpOipG81p1c80M7kQT1xaqYV1dt71xn7RoXCRcFawQWKEtBAvct0VQ8HVDh7T7bA
 jsWnid5zVx+XMF2JTcGgFT+NL+SB5MF4OWRDa6vi09ecKuoyG39c3Dhm+EEZ0xd2XzMz
 LundSR+si0PCy5w3N2psXo1rfhETKY7XjwK6u68eYy/I/TXuY7rtZOh4iHgBYg6nFyro
 3bdIOCN94WtILAiOsNDliQ7nbwcctYu7nZORxpbfp0wr+a2vlDFJW5i0js0c4aXD7gR1
 U/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775833543; x=1776438343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a1Kh3XSHSeM1ZEixAaGnsOegNSycBCR3GL6VS/B2SVg=;
 b=gyGMtQj4CJyEutV8lECrUDE4lUWhFMcfw/ocsomrAyIMwxakieokugdEwb7h5BHJrM
 vrpl05RbRtJV7CzLIrD9P/EkG+9CxwTGrPiPBFgdousVG7UYaHVRJ/bQbmsbhbYOqmEo
 QRkzFawel7d1sJqgh/sZlv1EYrc5HjvmPnbgUcmM/fCYBeW77ppBfN7YcM1cEXGse14Q
 Jfdlf6tW6uxlgSOuTn7l5Yn7UHIZxdjZ7ET1uLfiEivS84cYa4fRyu57mWvuqVPJDdNm
 I+pdkmuZ+RfcwVy1E3/q5QxnoTppzugAuSb5bkTYS6SH3XOCp48MhowNQWzrs3LWa9SW
 iIZw==
X-Gm-Message-State: AOJu0YyE7q+iFt8idBZXEaHgJFINm7llExH4vN8V29Dcd7zQjr1/PqJL
 S/rIjpLvfO65X6BxNBFv0oZPHjuXmjH66WZNM92eRxtKI/iLdUUrv43hF9U4QMMz
X-Gm-Gg: AeBDieuvx6kV1s8+AXo/h634XJXzMXs2eY1K01tKm6dGFN5Glx6MsFwvz4Ykjh0Xn4z
 fkzq5n31cfYRJFnV4ZGoAlYbkiO3yzU6e3cUfFjD/htC66zZnosjMQOKUkR2j71Nyi77hXkKqyM
 qDb4A7R478TTuhwFllMwAkNz9Wxlg8eoQWaVE8tRmi/uCRUKUo2lThD/Sq6xDL79j6J+SXA9JID
 zkR9UQoqCpWVn94ETeV4UEtVT/ZDWEQCn5kNC9LXWm79WuEzT8l6gfEcNElFMzoQpPKMH1rPbkT
 7Pt0uCFZPHIM574/26UP/sHT5QL2ZQE69dXdsZm/lK7SGD7Samfl8wi5WxoPXplFlWUjhxfWFvj
 p+PEUymPAZ2CUAgeZn5GM0SWATcO2+Ylg9H5zVQpLoq3lPrZWvdGFNXy5MwpnDRt30bCfpaZilu
 w4abo6424l88GyfPFjiVGLzrhay0cNRDsWXzEKRiV3nh2AlGliTY10
X-Received: by 2002:a17:90b:2e8c:b0:35b:a7be:ae47 with SMTP id
 98e67ed59e1d1-35e428321d5mr3767159a91.21.1775833543121; 
 Fri, 10 Apr 2026 08:05:43 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4131cfacsm3565785a91.10.2026.04.10.08.05.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 08:05:42 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V6 09/14] net/colo: track IOThread references using path-based
 holder
Date: Fri, 10 Apr 2026 23:04:52 +0800
Message-ID: <20260410150457.85190-10-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260410150457.85190-1-zhangckid@gmail.com>
References: <20260410150457.85190-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x102a.google.com
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
index c356419d6a..f3231257d2 100644
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
     CompareState *tmp = NULL;
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


