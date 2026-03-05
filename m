Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180B9F33A71
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9eA-0004Ay-6H; Thu, 05 Mar 2026 09:25:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9e3-00046y-Q3
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:43 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9e1-0001nt-Fw
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:43 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c738d1fa6f1so484519a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 06:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772720739; x=1773325539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MLjnMnNIguZ1QWTyzsc2r821O8rNuUtTvzW3geGi3oI=;
 b=l0X3now/VWRaEBp6Fflt+9jn6GHyb5o1qAmbrkMjTM1mleMXeNsKGK9Du2Qtu57ERJ
 vkNvHUBn58ZqURIeEhpk3MEVfJJotNJDi+YOxBXWvF+95w8Bnmd9266ilVWl1xaLX8Rw
 LBmxy5GDCmzZDM9uiNvtxfW/vausgMrLQuGOdm5nIR/Yu6Q2Ju8bA78bz4tqFX6vCqX5
 HjHgxSMunWPecP9SCOTFdYQjGY80+V7XrA9EYS5ynRjxYwRt/LnXTkdgD5xpDjpAIBZ6
 ztmxjaJJH52VQnn8Bp5M2I/B+7IifmxWRS+mFvVUE0fGGI3vUF6+UF7D0eGPsJ+oRfgC
 cImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772720739; x=1773325539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MLjnMnNIguZ1QWTyzsc2r821O8rNuUtTvzW3geGi3oI=;
 b=IPI1rYQYXLDAsCGLl6SkgzRz3bqy8MG4khs/sLfup7m1GLHJa+xZyagOyZ8VPBj5/F
 wvlq+nSJ7jwJLhCqzXATcYv7f1clzjy1fbsHcCVKAup6szXEffVouJypKpnts6QuQw6v
 338L7Z0OoC7YMh64Q4jA3lkkgftSKY6vAmxoQgGDNIOAHAPdjED1q1V/3npR6PFk9QSh
 OFQMDbOgHh8UZlgObEK9AbWyfP94Prg0tWcaHT5R4Vmwh3FgZymDZ5GMHUwjO+9QMC0x
 uMzhUyyZegLuv6IgZ06CMDm+EGAnbJQGgWrUwYIZ9x87vsxSZVdLn+Vaz6PgKf2tFj+/
 cLjg==
X-Gm-Message-State: AOJu0YxYqfAausBtKT3ShyAqZxnNzOZtxjJNBXJn/yeCF7Q4CsmUcQhL
 f4VrAb2bOiHhYhGZ/DqgOLDRZHlHJcndxQ+E99Pn5YQG1BU6D+/+ZuJ8QHwmA8rFOnUQWw==
X-Gm-Gg: ATEYQzya/UyjaV7rGWpj9ymXJkuNFqGAym6P3hPuJVYtofValQC7OuHNxQ6p6eKJyHt
 QJ/r3IigqoPVyYwsP+Jqb0m2RRucqwtY3OJAjB9lZYHlMQXMCE5BO6dmv3LNDsAw40JybyNeBSa
 l+KB6o60Z32XxKiRF2MDhH6VZN9+djyxKbSVSc51MtfJtFHGFSc5QskhQ1auRt8AvqlY+7mPsWa
 ALxcNly9eYTLrBR5eFkW1/8YirGXFRN14Ucdt5cN0fdeFezf3gzh6bb343iHxtPIQCcA8e5BmHJ
 6YCxfyOqeAHje8lL/OayUDwHJku/TQulj6EUj1Jy6u6HEoH4vTI3uOQq/9ieD9pT5BFuOM3IdRO
 dDmlMS5YVgGme3JgYhQK7Mp6UUYpmMfH47OttLKDusnvTRl8N9jZ3kSQq6mSMS1J2RBlGXkeQIx
 2+D/8ZJPUF+Fk1phUHeLNZuVlcoAU+5GMfJCx/2n9ivwt46KOJ2HOCYa+q62enLNRp4Qs=
X-Received: by 2002:a17:902:f64d:b0:2ae:5598:1da8 with SMTP id
 d9443c01a7336-2ae6ab80a25mr56684315ad.57.1772720738551; 
 Thu, 05 Mar 2026 06:25:38 -0800 (PST)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49:0:1:b277]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae4650000dsm140204835ad.54.2026.03.05.06.25.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Mar 2026 06:25:38 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V5 09/13] monitor: Update tracking iothread users with holder
 name
Date: Thu,  5 Mar 2026 22:24:55 +0800
Message-ID: <20260305142459.52559-10-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260305142459.52559-1-zhangckid@gmail.com>
References: <20260305142459.52559-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x530.google.com
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

Because of monitor create own iothread, and use the
iothread suspend/resume with bh handler and chardev handler.
The QOM lifecycle is hard to track. Update the legacy usage
of "iothread_get_aio_context()" and "iothread_put_aio_context()".

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 monitor/monitor.c | 4 ++--
 monitor/qmp.c     | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index 1273eb7260..5da3c05e8d 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -547,7 +547,7 @@ int monitor_suspend(Monitor *mon)
          * Kick I/O thread to make sure this takes effect.  It'll be
          * evaluated again in prepare() of the watch object.
          */
-        aio_notify(iothread_get_aio_context(mon_iothread));
+        aio_notify(iothread_get_aio_context(mon_iothread, NULL));
     }
 
     trace_monitor_suspend(mon, 1);
@@ -582,7 +582,7 @@ void monitor_resume(Monitor *mon)
         AioContext *ctx;
 
         if (mon->use_io_thread) {
-            ctx = iothread_get_aio_context(mon_iothread);
+            ctx = iothread_get_aio_context(mon_iothread, NULL);
         } else {
             ctx = qemu_get_aio_context();
         }
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 687019811f..93d0328dcd 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -544,12 +544,13 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
          * handling between the main thread and the I/O thread.
          */
         remove_listener_fd_in_watch(chr);
+
         /*
          * We can't call qemu_chr_fe_set_handlers() directly here
          * since chardev might be running in the monitor I/O
          * thread.  Schedule a bottom half.
          */
-        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
+        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread, NULL),
                                 monitor_qmp_setup_handlers_bh, mon);
         /* The bottom half will add @mon to @mon_list */
     } else {
-- 
2.49.0


