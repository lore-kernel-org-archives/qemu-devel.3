Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A83C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkNK4-0008Ge-0Z; Thu, 16 Jul 2026 10:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNHy-0006Nl-G7
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:42:14 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNHu-0007Nj-A3
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:42:11 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2cc6dd436c6so41358925ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 07:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784212929; x=1784817729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jep4VeB1HvWI8khcgjXgo2Z4gQjRgVcwsTHAZ6Dz3LU=;
 b=WCU+SYvHVA3t+M+cxi+TFVGUvFRXnUDECXzNGmEieZajuGhgNgFs/Uo7Opu47GVWP6
 8SA/ADRBjDnnQMHflqAV+kJpHiNwOIwkzdgog5tFtnOENeBclgPtRcH4E5dsTzu62cz8
 bvxXYK7bOS8L/Dzsd3EtYwoZIRaEwNL5Fl49whng++gh3iAo6orZ+2GCoBz9ATydECYo
 gN5SpJA4T6Wh/J9egiTG0L+w1qhUHG+4xrdB3LjSSe7j3+2WXFx7714s1Cp9KfwTAZeE
 EZ8ZnRg1xgb7Etjgequ3h474eq4cO4uRaRtuRPUl5z8T2JGQfMyZwndIyzMBmyps9+66
 jAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784212929; x=1784817729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jep4VeB1HvWI8khcgjXgo2Z4gQjRgVcwsTHAZ6Dz3LU=;
 b=dOAxQoPLKt2VWqZzOMPfnKU53hcCHz0jl2pb7BEl813WfhOsqQt5XKtUTlfBcH6iV4
 zonVRWWsfUGlbsiwk6X/RWF4RQKnnNsxx8WwR3ZOAXPVBkI8+Lk/aHahzUcfbh8zcw3S
 Zc3TXqfNMwrUgUF/+AO7TDCYUUyL2bscQJPVEijjUae04wXduRD80aEmAfICsBXPz9q1
 vgaHf8mfIVc6yKYyFM62jCIbB/XNeseR+mn0mdSFYFktChkElMMpxkmNWkrHwgMIb8A2
 lk+W5VYEsnMGd9H6GLq2W94yzbaommarYmoyUQd4dtgsYihyjNFeMRcqx1R144FMxxLh
 XeHg==
X-Gm-Message-State: AOJu0YwB4biQjeXUh42qDFPWL728lawr7ebQybslPE+l6/rWYjfrjp0z
 gOY/LE732APRmGN0I3Snsp1UoB/q+T4fRbBXZ6elAU+WbLC5L+IURpl1A0MAZEMfjRY=
X-Gm-Gg: AfdE7ck5QX2tIR7kBHDmYINHq6HfXSiQrncR1te+quh15EqfnGhZ/dIAuOlHqzs9YAv
 dPm/sHxWvvRCa1fePKmJoSr2R+TNCXIynXCgMxTxnouAsM22DnRnTIEWXUO3G9qLw71y5po4idQ
 A+6YYd2xp0dYhaDsdNmdvYuR9bQJWE/mfahl+WFCN3jiMqm5QjZlfWjKTxLYKxSG0hx4SK9RCvf
 DaMJmCie9ZygGvCw/jF3/wd3NYZNhhNOKHg6EFqI0KqAyJyVj+vixreqbNlMoJ8afLvs8zwLgK0
 5JHNQhl4aJnJhBW582qS0KMyTalbrcvioRT01hStKQOm9Ih/i7vO0PLbN9124YJ+/BCPKseacT+
 5recViJ9FSOnKe+vpzSaNKeysqB/nwqGD++pJPWWlep0TfY2e0gp6bJuhMMxPu8xJXDG0wbjZvO
 rZvGg4dwkNu/JOMGIKK9d2xwJkcLXxCIMggu/Fka7RbdEtXRVOuS8=
X-Received: by 2002:a17:903:13ce:b0:2c9:e5e6:8621 with SMTP id
 d9443c01a7336-2ce9f28515fmr223474305ad.25.1784212928810; 
 Thu, 16 Jul 2026 07:42:08 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::677]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf100e42a1sm20991165ad.15.2026.07.16.07.42.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jul 2026 07:42:08 -0700 (PDT)
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
Subject: [PATCH V10 09/15] net/colo: track IOThread references using
 path-based holder
Date: Thu, 16 Jul 2026 22:40:34 +0800
Message-ID: <20260716144043.76414-10-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260716144043.76414-1-zhangckid@gmail.com>
References: <20260716144043.76414-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x635.google.com
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


