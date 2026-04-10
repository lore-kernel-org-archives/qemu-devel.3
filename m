Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C3AF459EB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBDQO-0006yv-Ty; Fri, 10 Apr 2026 11:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQN-0006yX-6e
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:35 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQL-0002S0-Gy
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:34 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3590042fa8eso1729726a91.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 08:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775833532; x=1776438332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x69ooA9/Ciku7C9KOIVP3A4OcWl7JOZ863rt2HmRx3I=;
 b=a1FslxY2KL7qIN8v4urhyxoTiSB8Eg6C5Bvd1Gzt/gAgdfwYdCOaguX9bf2kW/Be9k
 7qQ2kODsxP92AbAhPRVSozVNXwtom6GYhhkJjTEtA6x/FfriIUnSdRTDA5Y1holLjcCP
 nBqao/7qDrh7S2Ms1eutxqpRKkTVrZA+fvtZVxiWL+Qkl+8veYaCDlbf17JT7JfIn3+k
 OwL2WjuvMwWSGbdJ90CY0uwX8UZELBhFHDhEcwNqfISAMLHxxvZZaCeJCgj1UaBmaLmm
 2aqqFD0lYxXDz/K7lIbzEuHaEac4Fn4mT67yXlMjqwQD83BLKLt2ZzKgBg/FFrC/zD3s
 ckdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775833532; x=1776438332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x69ooA9/Ciku7C9KOIVP3A4OcWl7JOZ863rt2HmRx3I=;
 b=dEFIQMOLsaMebT8zUbKuwBaQGr0/BJMJWxNh+LjeaTY2Fp13x3H7K+5ElUBAWfAFm9
 mVaWZRvGIdANmrSU9jxHxiooh7kxOAgMlWuDlmg0hNLfRSRQ4AxIdSxxCuEF+ixBSRSN
 w6LNufpZSQD6Xqw9/c2jPErmwCMFL2X6AO3Av9IY3JCA000xw72qzAnhpDh4XwIGuxzY
 kORngbT7hMHqpe8m0gKawja8BnPMZB4nxqMTNy8i5TUXFD4dxxyG7DRcmUGX6EiAIGl8
 LAzANRiH0QsL7OuqVJB1JUItTWtPfvSN3w9WnGuvSNjlo3YaVs0GyvBbsfnhZbE95k1b
 KKaA==
X-Gm-Message-State: AOJu0YzqTdWGuQoe0zf4SKrNpxvjJlHp6BEvJ2sqP72ipKP91XhkkrFl
 V5ksaj+/M3d3XpKkA6EJ1W25NFPHlYY668EuhOrKs3bSBTgFw5/UF88OJ206UeCJ
X-Gm-Gg: AeBDietEMkzYHSfgEUHeiswluUAGR4NIj0zOGZCR//Yr9zIdJupWvtvzQ4guskC8hOp
 VutF0KQ3iH/9K+qOJP+YLU6lLq92ufBki82agvpxd1ih0zaliUGd5L/V5Q8kDwjhOWaloFQel8D
 XTxFPJinm303tsf8ipNU+qYjDQ7zJ3sGdzPp+gdKrpHYtY9Qy9tsPbV6X3EWS2cBaTv1hKI0B7k
 Y5UIgkt102tg7+rPIyp+nWUUCB8s5g2/fyLO0DmS8wS9mXC+BnC3LKMfusn+1L0s2YurcivWTvr
 4Oypu7fqwZuy9ZxAAxYugyoEX2xFBRMnX1lrFeieQ68gVK36vI0nfgot1DnBWLkxWi7na0+hL8o
 rl8KxFFfKNfex2lZN/+20YCt2Y9jHz6O+0JJx7ym7HuFGQeR6q9W5b7fFl6BehCoqy2Wqqu10JD
 uNPG7u8GDCSSWhpv1eQyOdSyf1vjQx0V3EdiNe1FhuBF7sZx3MWKUm
X-Received: by 2002:a17:90b:268b:b0:35c:30a8:322 with SMTP id
 98e67ed59e1d1-35e4245a667mr3694581a91.0.1775833531337; 
 Fri, 10 Apr 2026 08:05:31 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4131cfacsm3565785a91.10.2026.04.10.08.05.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 08:05:30 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V6 06/14] monitor: Update tracking iothread users with holder
 name
Date: Fri, 10 Apr 2026 23:04:49 +0800
Message-ID: <20260410150457.85190-7-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260410150457.85190-1-zhangckid@gmail.com>
References: <20260410150457.85190-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x1036.google.com
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

Since the Monitor struct is not a QOM Object, we cannot use
object_get_canonical_path(). Instead, this patch uses the monitor's
name (or a default type-based name) as the holder identifier.

Cache the AioContext in the Monitor struct to avoid repeated calls to
iothread_get_aio_context() and ensure symmetrical ref/unref during
monitor lifecycle.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 monitor/monitor-internal.h |  3 +++
 monitor/monitor.c          | 24 ++++++++++++++++++++++--
 monitor/qmp.c              |  3 ++-
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index feca111ae3..51cedf90e4 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -116,6 +116,9 @@ struct Monitor {
     guint out_watch;
     int mux_out;
     int reset_seen;
+
+    /* iothread context */
+    AioContext *ctx;
 };
 
 struct MonitorHMP {
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 00b93ed612..b6efe776d6 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -529,7 +529,7 @@ int monitor_suspend(Monitor *mon)
          * Kick I/O thread to make sure this takes effect.  It'll be
          * evaluated again in prepare() of the watch object.
          */
-        aio_notify(iothread_get_aio_context(mon_iothread));
+        aio_notify(mon->ctx);
     }
 
     trace_monitor_suspend(mon, 1);
@@ -564,7 +564,7 @@ void monitor_resume(Monitor *mon)
         AioContext *ctx;
 
         if (mon->use_io_thread) {
-            ctx = iothread_get_aio_context(mon_iothread);
+            ctx = mon->ctx;
         } else {
             ctx = qemu_get_aio_context();
         }
@@ -612,6 +612,18 @@ void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
 {
     if (use_io_thread && !mon_iothread) {
         monitor_iothread_init();
+        /*
+         * Because of current Monitor is not a QOM Object,
+         * so using OBJECT(mon) is undefined behavior and may crash.
+         * Try using a hard-coded future implementation of the qom path instead.
+         * (Like the name of the "mon_iothread").
+         * long-term solution would be making Monitor QOM, after that change
+         * here to:
+         * g_autofree path = object_get_canonical_path(OBJECT(mon));
+         */
+        g_autofree char *path = g_strdup(is_qmp ? "/monitor/qmp_mon0" :
+                                                  "/monitor/hmp_mon0");
+        mon->ctx = iothread_ref_and_get_aio_context(mon_iothread, path);
     }
     qemu_mutex_init(&mon->mon_lock);
     mon->is_qmp = is_qmp;
@@ -631,6 +643,14 @@ void monitor_data_destroy(Monitor *mon)
     }
     g_string_free(mon->outbuf, true);
     qemu_mutex_destroy(&mon->mon_lock);
+
+    if (mon->ctx && mon_iothread) {
+        g_autofree char *path = g_strdup(monitor_is_qmp(mon) ?
+                                        "/monitor/qmp_mon0" :
+                                        "/monitor/hmp_mon0");
+        iothread_put_aio_context(mon_iothread, path);
+        mon->ctx = NULL;
+    }
 }
 
 void monitor_cleanup(void)
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 687019811f..8e4a775fac 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -549,7 +549,8 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
          * since chardev might be running in the monitor I/O
          * thread.  Schedule a bottom half.
          */
-        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
+        Monitor *mon_p = &mon->common;
+        aio_bh_schedule_oneshot(mon_p->ctx,
                                 monitor_qmp_setup_handlers_bh, mon);
         /* The bottom half will add @mon to @mon_list */
     } else {
-- 
2.49.0


