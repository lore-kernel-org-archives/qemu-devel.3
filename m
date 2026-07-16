Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B8CC44518
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkNJU-0007Gr-QO; Thu, 16 Jul 2026 10:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNHi-00066L-9Y
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:41:58 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNHg-0007F7-K6
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:41:58 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2ceed7018c8so22350475ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 07:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784212915; x=1784817715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LkZHHRIwKtbhpEos181LrxPQpvEgii7xeo4G7ZrlJIo=;
 b=RzP0SjJTsWjsw0K+g8OflhMVohXA4iJo71vP/TDUSk7yleTSmY+UIWkvVYCcvL5PmZ
 eM6sRauRdamScbfNlcgvMLpL6uj1D+o6dAqo9p01Vq3yubIzhEMx9lMq689nqj2FVDRt
 qrgg7HXqY65Q5warIFyZOKsi2E833UFFTIJkY0nNlJUlsoM3HqGrdn5vQvYtNdKS7lgj
 FZnLYIfISmnUEg79RTfSAm9IKPichPQxaM/Pky6h91hPJMRClZCTgavSplhaBoqHUU0R
 eBHKPr0ljSNLe+R3lGpIfpOLkNJRoZSOOOGthGd4rWW//F7CPgIH7b/U8YsWoekitEy9
 qfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784212915; x=1784817715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LkZHHRIwKtbhpEos181LrxPQpvEgii7xeo4G7ZrlJIo=;
 b=JtTliHaT3L3tHf89eyPCyxibMxUCxxgY3rNbNKRyMzoWvIekKB6AikwC/1D8ZOBVvt
 Md1a4q/Gxd5St8MvrwjP/jz2KFzfdR6bgSykRf+Wp8uyR5v5n0Blvg/hHZVQ1diVz7uv
 s2wiqzUQCbnjaFQun7SJPC4i8cqFx7Nr76hAaKYSefs5c+tJgXgbIP0X9VM7P+sK2B6a
 1lQlnrVmzaAgDoOyUlsC9VmO0pdvj5ZaRXpJhyGEnLMlK2+Bbq6FrkCRK0V4+WH35b/9
 rSvBF+hIThIpbyep1MK/VIje15Fx5Wh+rFaNj8MDNmZbKevVSOxUiOX0GRqIIehtCtM4
 a7qg==
X-Gm-Message-State: AOJu0Yyz2cZPxPislgour+6kvm8Da7pK/hW67HNNAy+TFch4qyvbhnzx
 H21Dcg5NyHg18j+BeyJJU2BUh6VwXJ0mxva03viMv2f7DTr9rH35+BlTKYI1pATrYxI=
X-Gm-Gg: AfdE7clgCDyltciPZpR3dSnCgU3YtjLbFOmPGnicmmvyTEgw522/fPuSrJnH1WvWM5u
 4o6PWWag5YitBFXUjB8IhKnVPirM+TLps46BHw4XSd4s6Ere6M+3nmXxVrv7HzMlCOjufS2Hq7J
 HPMv50pfYfJUFp+HcsUT63aVsXtZC0LzYU8ZixoiK4pNGku3/jjN10Qzp9pzzCUaPGk7ut6ERqU
 Nu+URuYg+jkbNa8NGSYW0XYKYlsaG7UxyBfih+mvbmED0awnB4RlS3qT4ipJJXoS7unfgt7pJrq
 KTjw9lQ/XojYqvED/PBTm36EnJev4YrFVXkRSzXQZ9BllpPMOWpqfR53DYQnMU080U2sA0+xDiS
 ji/DK9I1LK+jOqSOKvNGcJIrhXktQzdFLda/9L/w+i9SpR09n2h5Y8SBhFki0wcCuc/5rg84JJJ
 a5B2YNdBy8fBK/RSAjKqn3fKN/shntKRwCBSbK43au
X-Received: by 2002:a17:902:d985:b0:2ca:bf8e:35fe with SMTP id
 d9443c01a7336-2ce9e9ac9b7mr206948305ad.16.1784212915057; 
 Thu, 16 Jul 2026 07:41:55 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::677]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf100e42a1sm20991165ad.15.2026.07.16.07.41.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jul 2026 07:41:54 -0700 (PDT)
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
Subject: [PATCH V10 06/15] monitor: Update tracking iothread users with holder
Date: Thu, 16 Jul 2026 22:40:31 +0800
Message-ID: <20260716144043.76414-7-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260716144043.76414-1-zhangckid@gmail.com>
References: <20260716144043.76414-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62a.google.com
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

Based on monitor QOM path tracking iothread users with holder.
Introduce the AioContext in the Monitor struct to avoid repeated calls to
iothread_get_aio_context() and ensure symmetrical ref/unref during
monitor lifecycle.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 monitor/monitor-internal.h |  3 +++
 monitor/monitor.c          | 22 ++++++++++++++++++++--
 monitor/qmp.c              |  5 +++--
 3 files changed, 26 insertions(+), 4 deletions(-)

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
index ed195fd97b..688bb85c81 100644
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
@@ -732,7 +743,14 @@ static void monitor_complete(UserCreatable *uc, Error **errp)
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
+        ctx = mon->ctx;
     } else {
         ctx = qemu_get_aio_context();
     }
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


