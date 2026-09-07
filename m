Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BED3C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 06:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3SzX-0005hs-R3; Mon, 07 Sep 2026 02:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x3SzW-0005hf-Kx
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:38:06 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x3SzV-00068c-0g
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:38:06 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2d9b60c652aso37675775ad.1
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 23:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788763083; x=1789367883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A98whTvdVRQzMIBod4u+GjQWUac5pbRmbOiKgjUuYUQ=;
 b=MW5KAkbiT3tqtddThd7p/k8LrUNdr5iOT/Pxng3Y6k15IYhNq0wVTqtegUD4jmMNww
 DO5DMjdowdMgKPvXLOFK30Y38vu1Ai+1vM+UY5ZJ7N7WguJXapi0YrXc4ua0/A0FyK8P
 xE5tvXVD/FGGe1qq2DiOvqaqxIHvR2OgDSwYUMA+PreA7LAvKOz1OPLPy9oWEjiUp7yC
 IAGmK+lkWs8abgaO5XTRJYYNUp7qiDSSWsUOXsYHX4YKM0HN/0JnN9DJscy2hAUCFSv+
 Olt4gkJdzoPNGmWmYANRbyXVNbwZpORIHdxdiaDvE+LHnvbEfdbfiPLysfompWn2Qi1p
 Xgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788763083; x=1789367883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A98whTvdVRQzMIBod4u+GjQWUac5pbRmbOiKgjUuYUQ=;
 b=iKTUeDe9Uqiqp07HNs9NIiwgUl9sqgZe6dr24JFFlGGNPbaPJAGwtNC4jsDbulfjaa
 zkAXeKTlTiiRR7xOl0OG4VWUIoRG1ydk/zkg9tZT7Mu5RNnRQr5yVu/Wrh2JNIbiHi3P
 150sIwJsCe9Y5g84v4hxHV+I5L7wmE2oLzVqGHWOnQaUzNj0PtA66TwHrMDuUAmsqOt5
 FUgk2K+ii/FA+qsHThV0SZ31bdIKnrCkrEmdk+oJ4d6BORkBhOMcQNfuEFI5pbzkur21
 opiYXpkRXcy26gdd9P5H6ehlGmWa2MiI1QTvPpXmGbmkkf5IcfDIwLVzh3ixl5Jx36LZ
 Mh3A==
X-Gm-Message-State: AFuF++nqy4HIbId1EqhCJkys6XH/gcvLB36lSCS1KMoAyeE9t5cJRzvO
 toA6vb6UkCj8lT2cdrRpn6QcBJGOcvQNTodlyfAnyzyM5PF8mHej9FvBoaIilJiBucVbYg==
X-Gm-Gg: AYBFou1c4imOLyzNHtslwxhHG43ujfmjsiE0WAB9xHq3jICtDVCI98E2kMfJ9B/WyNu
 jQ1+IgMfSn1j6p7Rna9QXhvJC38Hh70z2JtB3sn0F88QNa2NuOcerpfqyNbSC7OJf3GmuPA/lYa
 vKFuM5OemnxPfi8r9ywKWnL2Rh8Kg3xY9p5PeC1XU1VHs/sZ0io5JMXzsyqS4gYxzB5VPpMqSlB
 lTVANsi35PEKvBla4DH+IrOTT961QFI674OKPs3XRcIULoJUhYG9nSncTu+34a4XFnTmkHe1+eb
 LJ0y+0EOZFYYRxGp3Y04tFzmSrT7+7FynVsTAFsg8jaQJN8fgRHdyYGUSpg+WV7RT3aJDRozg3F
 5XYJUruptSEcZOTtuN7T5moPSKxnF3AdoQwmoTVAKkNYitcUPDt/SjMvFRx/bVVPd1/toJeMn+H
 stwZQNP7MeEn7bNKvBlYnzuaVH9jx0pT0wHLG4kA/fqPPdxYDZWGhLibCAHEGyns5RG/9BAhu2O
 LsAysRFFEgrOaxo
X-Received: by 2002:a17:902:bb88:b0:2d3:716e:e2ae with SMTP id
 d9443c01a7336-2db1261df71mr223346885ad.6.1788763083303; 
 Sun, 06 Sep 2026 23:38:03 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1499f06fsm38502555ad.54.2026.09.06.23.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 23:38:02 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V15 05/14] monitor: track IOThread users with QOM paths
Date: Mon,  7 Sep 2026 14:37:16 +0800
Message-ID: <20260907063725.626685-6-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907063725.626685-1-zhangckid@gmail.com>
References: <20260907063725.626685-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62c.google.com
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

Monitors that require an IOThread share the internal mon_iothread.
Account for each monitor explicitly in IOThread holder tracking, using
the monitor's canonical QOM path to distinguish holders.

Acquire the shared monitor IOThread AioContext once and store the
IOThread and canonical QOM path so the holder can be released after the
monitor has been removed from the QOM tree. Reuse the stored context for
later operations.

Release the holder from monitor_finalize(), after resources associated
with the AioContext have been destroyed. This pairs the reference taken
in complete() with instance finalization and keeps the IOThread alive
throughout monitor teardown.

The internal mon_iothread remains hidden from query-iothreads, as before.
Management applications therefore cannot use it to determine which
monitors are using the IOThread. Nevertheless, track the monitor
holders so that they follow the same explicit holder and
IOThread reference lifecycle as other AioContext users.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 monitor/monitor-internal.h |  5 +++++
 monitor/monitor.c          | 26 +++++++++++++++++++++-----
 monitor/qmp.c              |  5 +++--
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 822a66d06d..1d5aeae5e6 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -77,6 +77,11 @@ struct Monitor {
     GString *outbuf;
     guint out_watch;
     int mux_out;
+
+    /* iothread context and holder identity */
+    IOThread *iothread;
+    char *iothread_qom_path;
+    AioContext *ctx;
 };
 
 struct MonitorQMPClass {
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 2654b81890..cc7f6785b5 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -93,6 +93,16 @@ static void monitor_finalize(Object *obj)
     qemu_chr_fe_deinit(&mon->chr, false);
     g_string_free(mon->outbuf, true);
     qemu_mutex_destroy(&mon->mon_lock);
+
+    if (mon->iothread) {
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = mon->iothread_qom_path,
+        };
+
+        iothread_unref_and_put_aio_context(mon->iothread, &io_holder);
+    }
+    g_free(mon->iothread_qom_path);
 }
 
 static char *monitor_get_chardev_id(Object *obj, Error **errp)
@@ -521,7 +531,7 @@ void monitor_suspend(Monitor *mon)
          * Kick I/O thread to make sure this takes effect.  It'll be
          * evaluated again in prepare() of the watch object.
          */
-        aio_notify(iothread_get_aio_context(mon_iothread));
+        aio_notify(mon->ctx);
     }
 
     trace_monitor_suspend(mon, 1);
@@ -661,7 +671,6 @@ char *monitor_compat_id(void)
 static void monitor_complete(UserCreatable *uc, Error **errp)
 {
     Monitor *mon = MONITOR(uc);
-    AioContext *ctx;
 
     if (mon->chardev_id) {
         Chardev *chr = qemu_chr_find(mon->chardev_id);
@@ -680,11 +689,18 @@ static void monitor_complete(UserCreatable *uc, Error **errp)
             mon_iothread = iothread_create("mon_iothread", &error_abort);
         }
 
-        ctx = iothread_get_aio_context(mon_iothread);
+        mon->iothread = mon_iothread;
+        mon->iothread_qom_path = object_get_canonical_path(OBJECT(mon));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = mon->iothread_qom_path,
+        };
+
+        mon->ctx = iothread_ref_and_get_aio_context(mon->iothread, &io_holder);
     } else {
-        ctx = qemu_get_aio_context();
+        mon->ctx = qemu_get_aio_context();
     }
-    mon->accept_input_bh = aio_bh_new(ctx, monitor_accept_input, mon);
+    mon->accept_input_bh = aio_bh_new(mon->ctx, monitor_accept_input, mon);
 }
 
 int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
diff --git a/monitor/qmp.c b/monitor/qmp.c
index aec0315775..de56345456 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -734,7 +734,8 @@ static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
          * thread.  Schedule a bottom half.
          */
         mon->setup_pending = true;
-        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
+
+        aio_bh_schedule_oneshot(MONITOR(mon)->ctx,
                                 monitor_qmp_setup_handlers_bh, mon);
         /* The bottom half will add @mon to @mon_list */
     } else {
@@ -789,7 +790,7 @@ static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp)
 
     /* Synchronize with in-flight iothread callbacks. */
     if (monitor_requires_iothread(mon)) {
-        aio_wait_bh_oneshot(iothread_get_aio_context(mon_iothread),
+        aio_wait_bh_oneshot(MONITOR(mon)->ctx,
                             monitor_qmp_iothread_quiesce, NULL);
     }
 
-- 
2.43.0


