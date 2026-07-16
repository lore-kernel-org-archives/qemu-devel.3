Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF91C44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkPmW-0005uB-9l; Thu, 16 Jul 2026 13:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkPmT-0005rD-Fi
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:21:53 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkPmR-0000Tp-OX
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:21:53 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so6024750a91.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 10:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784222510; x=1784827310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OwhaShlw/IWfkBAfx4ou1fQ8uxLJg9u4MtK/P7v+CQQ=;
 b=lPFKfHK/a3seb7rhrS2CtU2x89sQuRSrsW+j1O6N69v1Ia+cjOzYdFpb/V0XQ1y4Vx
 7hIfjalszUVzPd8TRsEpjXKYrdI47IkPbvr6vQ6Q327aVqHvlJZFtwJYcVqZdljlEyk9
 WF84rRp+cEIreSMhyI9GUssXBJYIrA2XNA8ZyGSuTvCDIp34iJrEVh881vxZGalXTlJr
 +NOL+ntLDmfaTH4iePFhF2QUu3ChVPZmrad3tl6P6J5KLFTjZyXl8cBQAtKfhcLdVUFp
 4WJb2vjK61XxA04HurI9YNp+9jRiCSfWOJWGuVpF9w0fvAolMrn/nilCfGiOV5M+cV4T
 ebNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784222510; x=1784827310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OwhaShlw/IWfkBAfx4ou1fQ8uxLJg9u4MtK/P7v+CQQ=;
 b=JGqtce4JrMwI6KjRa6iPEVdDW/qe00eKBNL7Or/1aC3EBGXHOzn6Mul2pYDCLsqEec
 87s3d3gDXzEQnOuQofY662bNEyhgPb03naXRAG8cbJvYJlqScaat7Xg3LbQlH/pnSHHL
 47syp3GXgEfybY7uG+BJyt5esDHeDfiwM0ezbzKiygseh4jkSmu97Pkauvl7eJdP1Mvf
 1cq1XpqmkilpdjOCnw/3VuAc5bbNy1kmbqUzeHj+mNm0qeukqvvAD2BZ1XTtfK+Eox2H
 Yqebjbul6fIUqfyZLVyq6wR2RbblBUUObcLucrhN4xmGOD9iyPpPkmcvw11wzS73aoUB
 jmyw==
X-Gm-Message-State: AOJu0Yx0tnq3g0B2zs82hh8BShY35D9gdsSoWSqwbFcEpFu2BrLsKjL9
 MVm5+VRcl/heUfEuuF30KtrRU7AnE+RQJquF0LIy9mF/lhTubK1IUQI1UwAnpaSA2DE=
X-Gm-Gg: AfdE7ckHhPWcTobQdvVT3cYX4Sz3ZNndlYXIPlOzdegDjfMRv2NXkblJQT3+pDTB3jS
 b03OApI6ByRNhoTj8bFUkxU2ml1j9gznZ7mWLC4ROicdcMGR5mXJ0mTSA1abqHPPNZlebdOLYXV
 uiUA718n+BUrvgwclSzvY5qZ4cR7bUEcDrvNaIbWROn2BXy+vp466I6no2TaC+6wZuTn1lCFY/K
 UKiK+blN7A41VE/x86NiqrRZIDchSbxEqhC9UlypD7CwCoRpfCj6USy2ynqSGeWlpiNbl8uN/9h
 GYuPxUpjY96va1JpDJ7tCUSsA1YSp1H8SamQZQ+FRpBnWfS1negDYrXhtHRKT05CWhValenfXU3
 vkUnu4QLGqTdHD1LoDnB22l340gB425NW7KALgnzoxTFaF8y50wMRnfHsd80Sl+ZtWIvHDZe9sw
 wayU5h2JoBPb86NjA7CSER5iaavLUHOA==
X-Received: by 2002:a17:90b:4f8a:b0:38e:e9b:ffa7 with SMTP id
 98e67ed59e1d1-38e2a0cbae2mr7318751a91.28.1784222510275; 
 Thu, 16 Jul 2026 10:21:50 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.28.233.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm16800417eec.11.2026.07.16.10.21.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jul 2026 10:21:49 -0700 (PDT)
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
Subject: [RESEND PATCH V10 06/15] monitor: Update tracking iothread users with
 holder
Date: Fri, 17 Jul 2026 01:20:47 +0800
Message-ID: <20260716172108.87700-7-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260716172108.87700-1-zhangckid@gmail.com>
References: <20260716172108.87700-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x1033.google.com
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

Based on monitor QOM path tracking iothread users with holder.
Introduce the AioContext in the Monitor struct to avoid repeated calls to
iothread_get_aio_context() and ensure symmetrical ref/unref during
monitor lifecycle.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 monitor/monitor-internal.h |  3 +++
 monitor/monitor.c          | 26 +++++++++++++++++++++-----
 monitor/qmp.c              |  5 +++--
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 23829f32f9..caecceec93 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -153,6 +153,9 @@ struct Monitor {
     guint out_watch;
     int mux_out;
     int reset_seen;
+
+    /* iothread context */
+    AioContext *ctx;
 };
 
 struct MonitorHMPClass {
diff --git a/monitor/monitor.c b/monitor/monitor.c
index ed195fd97b..ce9b2b90fe 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -573,7 +573,7 @@ void monitor_suspend(Monitor *mon)
          * Kick I/O thread to make sure this takes effect.  It'll be
          * evaluated again in prepare() of the watch object.
          */
-        aio_notify(iothread_get_aio_context(mon_iothread));
+        aio_notify(mon->ctx);
     }
 
     trace_monitor_suspend(mon, 1);
@@ -668,6 +668,17 @@ void monitor_cleanup(void)
         qemu_mutex_unlock(&monitor_lock);
         monitor_flush(mon);
         qemu_mutex_lock(&monitor_lock);
+
+        if (mon_iothread) {
+            g_autofree char *path = object_get_canonical_path(OBJECT(mon));
+            const IOThreadHolder io_holder = {
+                .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+                .u.qom_object.qom_path = path,
+            };
+
+            iothread_put_aio_context(mon_iothread, &io_holder);
+            mon->ctx = NULL;
+        }
         object_unparent(OBJECT(mon));
     }
     qemu_mutex_unlock(&monitor_lock);
@@ -713,7 +724,6 @@ char *monitor_compat_id(void)
 static void monitor_complete(UserCreatable *uc, Error **errp)
 {
     Monitor *mon = MONITOR(uc);
-    AioContext *ctx;
 
     if (mon->chardev_id) {
         Chardev *chr = qemu_chr_find(mon->chardev_id);
@@ -732,11 +742,17 @@ static void monitor_complete(UserCreatable *uc, Error **errp)
             mon_iothread = iothread_create("mon_iothread", &error_abort);
         }
 
-        ctx = iothread_get_aio_context(mon_iothread);
+        g_autofree char *path = object_get_canonical_path(OBJECT(mon));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+
+        mon->ctx = iothread_ref_and_get_aio_context(mon_iothread, &io_holder);
     } else {
-        ctx = qemu_get_aio_context();
+        mon->ctx = qemu_get_aio_context();
     }
-    mon->accept_input_bh = aio_bh_new(ctx, monitor_accept_input, mon);
+    mon->accept_input_bh = aio_bh_new(mon->ctx, monitor_accept_input, mon);
 }
 
 int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 223e0643c2..b16bd77688 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -732,7 +732,8 @@ static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
          * thread.  Schedule a bottom half.
          */
         mon->setup_pending = true;
-        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
+
+        aio_bh_schedule_oneshot(MONITOR(mon)->ctx,
                                 monitor_qmp_setup_handlers_bh, mon);
         /* The bottom half will add @mon to @mon_list */
     } else {
@@ -787,7 +788,7 @@ static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp)
 
     /* Synchronize with in-flight iothread callbacks. */
     if (monitor_requires_iothread(mon)) {
-        aio_wait_bh_oneshot(iothread_get_aio_context(mon_iothread),
+        aio_wait_bh_oneshot(MONITOR(mon)->ctx,
                             monitor_qmp_iothread_quiesce, NULL);
     }
 
-- 
2.49.0


