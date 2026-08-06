Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6C7C5AC67
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 20:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws4gB-00043A-OM; Thu, 06 Aug 2026 16:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4g1-0003wk-O0
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:26:55 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4g0-00050H-0v
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:26:53 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c981c2c37cbso2006102a12.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 13:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786048011; x=1786652811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LoaJlgwcktjHXrOouiKAsKzyyrNL0yFJ17NEbpvvh8M=;
 b=aMQjxIEze4TSPpa2/Iz8l+FUNehWASyAepvEKKn0mUne3sXcYDwH7O6M4r+dlHPQDp
 8XU6wDitka95BAMaA5O/6nkQTmc49fE2rT8vj6mKhpnM0xSb13e+WGIa4/3ivHt+Amx5
 CGIHU0KKmAy/RMCD8WsPiWfKjFIjHuo3nRJH4rOQofm0NHiVgWMI0mtlxy6bddfsJEqj
 VRqZRMFFaSxBnoTIZK/zcWxylUwyBJBkfPbV2UVvYolTJMqDV0xPCmel2uQ86ZoFfJzP
 b6BTlJJw5gqytxKpgmrsPDLNFCNvdudIPyljvioxlunPGDZASKhG3DGidJIH9K4p4NsJ
 aNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786048011; x=1786652811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LoaJlgwcktjHXrOouiKAsKzyyrNL0yFJ17NEbpvvh8M=;
 b=oIxq0hF5PQCTI09+ZFE5Gc033iLtQHfFhaNrPdwhX25xll44v0f7AztPkiWNJx0+Np
 tf40S6mx75bYSb1XHjXsquP6HZCG10kBop/EGs++DVbW+fGioKZCgrT5nPo2LIHjgjAW
 6DKUZS7b8BQQYgZj0ePCGAyJfDSpE6KJCdxxJ0dFBRpsRGb31SjlHvvS+4nzORCMOcrh
 mMbD/vkj4tZA6+A+76NyAcWxX2C7Q9wjNOrlbzADScellDZCtIXyvxetWYjADbpFyEnn
 8MsGZHMS+3gc4Cau/EQHutIwY/C+3nKPeC70FMQ/bOzNNxPyNIi0pT4xDDp0DjdKVgBu
 iZHA==
X-Gm-Message-State: AOJu0Yz2H1jtZVut5m9zbRdsjthXt+GcdQma8u83eepc4q6d4BIb2NMM
 Tm9VNi3W6a99W6tHeWZvmdhioapJMTmBNb9r5nKKa8l7s3Zcj09OOsG60td6NBTdSW8nSqdn
X-Gm-Gg: AR+sD12f9wRUVPBJQvsJyptmLvq5KEfxEWmqi86oYJ9qGnsYMk0gcdWc3bX3YO7oJsx
 UISRcJkSsuoR+buikErCsSR3HKHShEBNdAvSFPJcryeCi1vqwEcd8L2gHkOmujM4XmDm0oX9PI5
 YwiJMfo0j/8g6Ij3g/uWMkIkP0LTFyO/3FvuDct/dL5T+hgRE5gX05vUWetpSyjMx3+NPFVXsYF
 BUUm0PPtVEKeHkM0kmBksLlrq06MSa8HDHW8zhp2FUeUm4ZgwRlDflwIhzJOgOxUOPUlQOXqWWw
 2fEsO6JdGNuhcgMe2ikHvKeyzyhrgI/jtqdL2mtKuMRMvzwm6E4k0wjaHWQrB0eaG7jvCgpSXy5
 Ln1qfAiFfElrzUyBXays15yVXTHSnGviyVuqVrIr0eRmuUQCIZo0ULNDuMCWATo5StCWzn42DZc
 9wPXQ/jaAN1b76fQomUx7RPsaVP4s22MWgcrkbpCVk3Ppgz9FZWmOBueysY9f4I2S8VIRWt/0bA
 0GnxByBsKHwOrSQ
X-Received: by 2002:a05:6a20:9e48:b0:3c3:875d:704d with SMTP id
 adf61e73a8af0-3cb85ee77c2mr23474694637.25.1786048010668; 
 Thu, 06 Aug 2026 13:26:50 -0700 (PDT)
Received: from t-kidd-X299-AORUS-Gaming-3-Pro.lan ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863fd2b3sm33140471eec.7.2026.08.06.13.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 13:26:50 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V11 06/15] monitor: track IOThread users with QOM paths
Date: Fri,  7 Aug 2026 04:25:15 +0800
Message-ID: <20260806202531.243806-7-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806202531.243806-1-zhangckid@gmail.com>
References: <20260806202531.243806-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

Acquire the shared monitor IOThread AioContext once, using the monitor
QOM path as the holder, and reuse the stored context for later
operations.

Release the holder during global cleanup and dynamic QMP monitor
deletion to provide an explicit acquire/release lifecycle.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 monitor/monitor-internal.h |  3 +++
 monitor/monitor.c          | 26 +++++++++++++++++++++-----
 monitor/qmp.c              | 16 ++++++++++++++--
 3 files changed, 38 insertions(+), 7 deletions(-)

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
index ed195fd97b..840a579247 100644
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
+        if (monitor_requires_iothread(mon)) {
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
index 338d37cb7e..51a724d545 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -733,7 +733,8 @@ static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
          * thread.  Schedule a bottom half.
          */
         mon->setup_pending = true;
-        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
+
+        aio_bh_schedule_oneshot(MONITOR(mon)->ctx,
                                 monitor_qmp_setup_handlers_bh, mon);
         /* The bottom half will add @mon to @mon_list */
     } else {
@@ -788,7 +789,7 @@ static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp)
 
     /* Synchronize with in-flight iothread callbacks. */
     if (monitor_requires_iothread(mon)) {
-        aio_wait_bh_oneshot(iothread_get_aio_context(mon_iothread),
+        aio_wait_bh_oneshot(MONITOR(mon)->ctx,
                             monitor_qmp_iothread_quiesce, NULL);
     }
 
@@ -796,6 +797,17 @@ static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp)
     monitor_qmp_drain_queue(qmp);
     monitor_fdsets_cleanup();
 
+    if (monitor_requires_iothread(mon)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(mon));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+
+        iothread_put_aio_context(mon_iothread, &io_holder);
+        mon->ctx = NULL;
+    }
+
     return true;
 }
 
-- 
2.53.0


