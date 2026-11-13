Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A99B606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MnaXPdMd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRnYY-0000dj-NR; Fri, 13 Nov 2026 04:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnYR-0000YJ-Bx
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:26:44 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnYP-0005zw-EJ
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:26:43 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2e99b1e5b4cso4380495ad.0
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 01:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794562000; x=1795166800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lmSXk9na7HUzn8TADoldzDrCh1LF9ANFf5sI+5rguhU=;
 b=MnaXPdMdUG05L5wDJk0iqbz/kfc/EeU1uH+whpvXHBSG1GAJyGnP+R9ka6I+N+rqTa
 UIDKLT4QNy0DPRV/1WDDooeYzSt15DyoqxRCLuExM34aUX8MDa6a+NdYz3DDsyI1Kx03
 Fve7aQOq7zOywCTo4BJWuNCxSUI9KHPN1CJRI+yzM0tnEtd/XypUh1aNP51tEj/uU+GR
 CrbwvOMw+SIA/2QD37Y36CY7wk5pf3uhrDBZmg/zRDAT/TToe3PDQZfZl8/+Z+a3xpzL
 tZ1wf3jlgLgx4RrWiCklUqiNLc3JZ4ia+ReAi56IgnJnxp1ARK6XoxLIwcCl6fAQ30Kk
 fcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794562000; x=1795166800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lmSXk9na7HUzn8TADoldzDrCh1LF9ANFf5sI+5rguhU=;
 b=1uq7BuneWtu6L2KiBydkUk5Wf9bkY+Sxwih6gwLCgHUT8NWwMgPW0bOUa4TKb2jduC
 0cZwXVqCsx5TpfK7e8ZQ45GcbzNlI8R/yI2nZWqcD9PQ7zodCWURHNpRUh8uLLRj980W
 xPGT87xca3X1XIhqAnkl+u/3LQ0LqEm6rdFquxAv1vSMla7iluvulzEbPkpwq3y4//gr
 oE5tAmCk70yCgfL672Fzqy/iB2GTNFxN3SO02UzHhFU9jeWd6m+tzgBrzPsojoF/Cty0
 62kQSO5a2X95BJznI1qAMuMHsxIlIWGKajiJEUMCgHuDgReaoyx1s7gTEVTQbOVWkyMA
 XpWQ==
X-Gm-Message-State: APuU4Z9V00rX0C/M+2ckQh9Wi1MnMrnkrc6+s9i4y0+Q7KqBFrhml8Iq
 Ipuk1nNnwxo719Nl0qGgwGnu9YFJbmdvpR5EmRy7bAdhk9pqVBXN+pBcv/kbHNts
X-Gm-Gg: AYBFou0z2RonlF39tAzEfHMES0C9blht0BClL1jShHIcdTdwS5ipbmTnVl7wi8LDQJT
 c0SohoxUWAfXkXmvR1whVYFhxXpGzo5ZDohT7V72ixA4eYoP6bqbPMtsGyEDnp4SEPxug1gpWPf
 Dt6ffEzy09vXWGsHKZcz7jBVC0OXCuKSraAzWamKpFHfca/CBIlHo1tE7Z8bZek/jaISqokONQk
 IfluljtSX3F7J2qNGkiltj38TVid5tmNMIyKYExUNksqbdR9s/F6u+ok+FLAaErfgs3CGTKJxSu
 lDf8Q+wAsGQj86pZwUn2B5Nb4depa87a/rkakPaMHhYduoE8up0SAMoQsVGkYPBGlPuDla1Z5vU
 m9EAnhdhBmHp07OowKd8E2gBsegCynwexGLXwPLYb9tehMFIvCn9vnweuRNrfONFqAiQ8mEx61b
 Xt+4QRLRc/jYDmRS0ziTZ/xHd1slMhAsQGmTUEQ3p5whLog9doLNqaYunK1hRmzjZulH0KVD5Ys
 6X2GPIL2qMV5q2yuZcw13FptD2rOegP2l/t/0Bvsb3YougR0UKpghEoGiH38HhGEmUee6zQiRMK
 i3kWJE0qPChONJk+I2BKQF9YrKGPZ/tDOE7YOVnQR7nOJIJjixyutXxiCcY=
X-Received: by 2002:a17:902:d512:b0:2e9:5ec6:bfc9 with SMTP id
 d9443c01a7336-2ee0da7bdc0mr17458705ad.9.1794561999778; 
 Fri, 13 Nov 2026 01:26:39 -0800 (PST)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee0f7d0887sm7428605ad.32.2026.11.13.01.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 01:26:39 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V20 04/14] monitor: track IOThread users with QOM paths
Date: Fri, 13 Nov 2026 17:25:55 +0800
Message-ID: <20261113092605.942292-5-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113092605.942292-1-zhangckid@gmail.com>
References: <20261113092605.942292-1-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x636.google.com
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

Monitors that require an IOThread share the internal mon_iothread.
Account for each monitor explicitly in IOThread holder tracking, using
the monitor's canonical QOM path to distinguish holders.

Acquire the shared monitor IOThread AioContext once and store the
IOThread and canonical QOM path so the holder can be released after the
monitor has been removed from the QOM tree. Use the stored IOThread for
per-monitor checks and accesses after initialization, and reuse the
stored context for later operations.

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
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 monitor/monitor-internal.h |  7 +++++--
 monitor/monitor.c          | 36 ++++++++++++++++++++++++++----------
 monitor/qmp.c              | 14 +++++++-------
 3 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 822a66d06d..856948067b 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -77,6 +77,11 @@ struct Monitor {
     GString *outbuf;
     guint out_watch;
     int mux_out;
+
+    /* iothread context and holder identity */
+    IOThread *iothread;
+    char *qom_path;
+    AioContext *ctx;
 };
 
 struct MonitorQMPClass {
@@ -109,14 +114,12 @@ struct MonitorQMP {
 };
 
 typedef QTAILQ_HEAD(MonitorList, Monitor) MonitorList;
-extern IOThread *mon_iothread;
 extern Coroutine *qmp_dispatcher_co;
 extern bool qmp_dispatcher_co_shutdown;
 extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
 extern QemuMutex monitor_lock;
 extern MonitorList mon_list;
 
-bool monitor_requires_iothread(const Monitor *mon);
 int monitor_can_read(void *opaque);
 void monitor_cancel_out_watch(Monitor *mon);
 void monitor_list_append(Monitor *mon);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 2654b81890..4e2b96b2e8 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -55,7 +55,7 @@ typedef struct {
 } MonitorQAPIEventConf;
 
 /* Shared monitor I/O thread */
-IOThread *mon_iothread;
+static IOThread *mon_iothread;
 
 /* Coroutine to dispatch the requests received from I/O thread */
 Coroutine *qmp_dispatcher_co;
@@ -93,6 +93,16 @@ static void monitor_finalize(Object *obj)
     qemu_chr_fe_deinit(&mon->chr, false);
     g_string_free(mon->outbuf, true);
     qemu_mutex_destroy(&mon->mon_lock);
+
+    if (mon->iothread) {
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = mon->qom_path,
+        };
+
+        iothread_unref_and_put_aio_context(mon->iothread, &io_holder);
+    }
+    g_free(mon->qom_path);
 }
 
 static char *monitor_get_chardev_id(Object *obj, Error **errp)
@@ -164,7 +174,7 @@ Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
     return old_monitor;
 }
 
-bool monitor_requires_iothread(const Monitor *mon)
+static bool monitor_requires_iothread(const Monitor *mon)
 {
     MonitorClass *cls = MONITOR_GET_CLASS(mon);
     return cls->requires_iothread && cls->requires_iothread(mon);
@@ -188,8 +198,8 @@ void monitor_cancel_out_watch(Monitor *mon)
         GMainContext *ctx = NULL;
         GSource *src;
 
-        if (monitor_requires_iothread(mon)) {
-            ctx = iothread_get_g_main_context(mon_iothread);
+        if (mon->iothread) {
+            ctx = iothread_get_g_main_context(mon->iothread);
         }
         src = g_main_context_find_source_by_id(ctx, mon->out_watch);
         if (!src && ctx) {
@@ -516,12 +526,12 @@ void monitor_suspend(Monitor *mon)
 {
     qatomic_inc(&mon->suspend_cnt);
 
-    if (monitor_requires_iothread(mon)) {
+    if (mon->iothread) {
         /*
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
+        mon->qom_path = object_get_canonical_path(OBJECT(mon));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = mon->qom_path,
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
index 2f66257e4a..e3edd17ca8 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -188,7 +188,7 @@ static void monitor_qmp_caps_reset(MonitorQMP *mon)
     memset(mon->capab_offered, 0, sizeof(mon->capab_offered));
     memset(mon->capab, 0, sizeof(mon->capab));
     mon->capab_offered[QMP_CAPABILITY_OOB] =
-        monitor_requires_iothread(MONITOR(mon));
+        MONITOR(mon)->iothread != NULL;
 }
 
 static void qmp_request_free(QMPRequest *req)
@@ -680,8 +680,8 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
     MonitorQMP *mon = opaque;
     GMainContext *context;
 
-    assert(monitor_requires_iothread(MONITOR(mon)));
-    context = iothread_get_g_main_context(mon_iothread);
+    assert(MONITOR(mon)->iothread);
+    context = iothread_get_g_main_context(MONITOR(mon)->iothread);
     assert(context);
     qemu_chr_fe_set_handlers(&mon->parent_obj.chr, monitor_can_read,
                              monitor_qmp_read, monitor_qmp_event,
@@ -719,7 +719,7 @@ static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
 
     qemu_chr_fe_set_echo(&mon->parent_obj.chr, true);
 
-    if (monitor_requires_iothread(MONITOR(mon))) {
+    if (MONITOR(mon)->iothread) {
         /*
          * Make sure the old iowatch is gone.  It's possible when
          * e.g. the chardev is in client mode, with wait=on.
@@ -736,7 +736,7 @@ static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
          * thread.  Schedule a bottom half.
          */
         mon->setup_pending = true;
-        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
+        aio_bh_schedule_oneshot(MONITOR(mon)->ctx,
                                 monitor_qmp_setup_handlers_bh, mon);
         /* The bottom half will add @mon to @mon_list */
     } else {
@@ -790,8 +790,8 @@ static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp)
     }
 
     /* Synchronize with in-flight iothread callbacks. */
-    if (monitor_requires_iothread(mon)) {
-        aio_wait_bh_oneshot(iothread_get_aio_context(mon_iothread),
+    if (mon->iothread) {
+        aio_wait_bh_oneshot(mon->ctx,
                             monitor_qmp_iothread_quiesce, NULL);
     }
 
-- 
2.53.0


