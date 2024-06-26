Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D4AC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 21:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMaZj-0008T5-N9; Wed, 26 Jun 2024 17:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3uY18ZgQKCgItmktiqqing.eqosgow-fgxgnpqpipw.qti@flex--rkir.bounces.google.com>)
 id 1sMaZh-0008Sc-Mj
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 17:53:09 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3uY18ZgQKCgItmktiqqing.eqosgow-fgxgnpqpipw.qti@flex--rkir.bounces.google.com>)
 id 1sMaZZ-0003OV-0j
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 17:53:02 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-63bca8ce79eso152846497b3.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 14:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719438778; x=1720043578; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=A1M6hh1fjJLf9yHhL6kGnZhNJPFyN4AKEuAqjEw9D04=;
 b=eF+GViRbVwOHSpgm/nOJvZE/w1Xbs101kB9JD65+00p/q9SgTASfzxPOVl47kM4Zuy
 GVW0VkjIBsunc9zYj1Z9Z+RyPE95vpCU/5DNw5OfHabRFcdRzAszxDBVlLWPoR9whww1
 f0g+5Lo3fXT7e5yUx7mM1P6C696PuHQB0r1rhPuzL5B6WFBla4DHlOWBgiIdcWSP97Fo
 8F32hy5zS8335HhWtFRKIrktTE8+lcM8vSUVPCMLMQ/yRHna7NSbxSKIIgxBM6bI8vTm
 6Yez66VwPw8+jQEgpzjs7WtjdlEdHD0kaxlWgDEOFvpMRhSEGT6TkV0GgsMkoToAyLnb
 gdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719438778; x=1720043578;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A1M6hh1fjJLf9yHhL6kGnZhNJPFyN4AKEuAqjEw9D04=;
 b=v1hWhp07dtinm0ppfqbn/Uvpga2EXuHqFMqf13f3XYiXYHq15sGaljc8vxrSs9PVSQ
 wNyGyGg0BxHjrwFxre7K+wpZxBVI/jJvGwsP1xLjhx0qk9KJM2cAWBS3ELq6fCXtHpET
 BZbp+rC87nefdfX1wmEOLdaD/SxGfO+xMQMERkjXESixCcjvwEeq+cfMuWesCM9n8DFT
 EKtW/u7sWFEj05m6KK28+z/rW0orG+7tR6GbxWYOZI2XsycDC7VNupaiWmrwbatRL1Om
 Vn7m5Dopo0k/l3qgm+S7mj2ZY5rnWHOGYCz+/dl8EiQ2+DhrIEJaw1uFRpTEaD5VjNCz
 Cq3A==
X-Gm-Message-State: AOJu0YxKcEejiOoti81twyt3CiT6lOHqLCZnJjmnyGjcA/Q3C9Kr5nuB
 ElNb1hZUJ4qZM2z4NomBl1v4yTemA92HMpYiv2kJVFE9MdbDMiWo2uf8CPBbHvEUJVQM0J5JiZ8
 zF2ijih8W21ZfgrrLXZ9n2a9nkHwa3SDh+0RrLyHUv0S/RXyq6P03Z+I4Gq7Ydz19MWjkaJP4ZE
 JUZYrbDN+1KFQcObI5QDpG
X-Google-Smtp-Source: AGHT+IGG5TuJJenv4I6lMTv3lFDYoWcPIZ3XpExzLGQ3szTU2dXuXfDVrRO1cR1syhxUQXbISpdwgq35
X-Received: from rkir98.kir.corp.google.com
 ([2620:15c:7d:4:e7b4:877a:d463:4598])
 (user=rkir job=sendgmr) by 2002:a05:6902:188a:b0:dfb:5bd:17b2 with SMTP id
 3f1490d57ef6-e0303edb190mr39210276.2.1719438777498; Wed, 26 Jun 2024 14:52:57
 -0700 (PDT)
Date: Wed, 26 Jun 2024 14:52:41 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240626215241.3360246-1-rkir@google.com>
Subject: [PATCH v2] timer: Fix a race condition between timer's callback and
 destroying code
From: Roman Kiryanov <rkir@google.com>
To: qemu-devel@nongnu.org
Cc: jansene@google.com, mett@google.com, jpcottin@google.com, 
 Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3uY18ZgQKCgItmktiqqing.eqosgow-fgxgnpqpipw.qti@flex--rkir.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

`timerlist_run_timers` provides no mechanism to
make sure the data pointed by `opaque` is valid
when calling timer's callback: there could be
another thread running which is destroying
timer's opaque data.

With this change `timer_del` becomes blocking if
timer's callback is running and it will be safe
to destroy timer's data once `timer_del` returns.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
v2: rebased to the right branch and removed
    Google specific tags from the commit message.

 include/qemu/timer.h |  4 ++++
 util/qemu-timer.c    | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 5ce83c7911..efd0e95d20 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -3,6 +3,7 @@
 
 #include "qemu/bitops.h"
 #include "qemu/notify.h"
+#include "qemu/thread.h"
 #include "qemu/host-utils.h"
 
 #define NANOSECONDS_PER_SECOND 1000000000LL
@@ -86,9 +87,12 @@ struct QEMUTimer {
     QEMUTimerList *timer_list;
     QEMUTimerCB *cb;
     void *opaque;
+    QemuMutex opaque_lock;
+    QemuCond cb_done;
     QEMUTimer *next;
     int attributes;
     int scale;
+    bool cb_running;
 };
 
 extern QEMUTimerListGroup main_loop_tlg;
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 213114be68..95af255519 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -369,7 +369,10 @@ void timer_init_full(QEMUTimer *ts,
     ts->opaque = opaque;
     ts->scale = scale;
     ts->attributes = attributes;
+    qemu_mutex_init(&ts->opaque_lock);
+    qemu_cond_init(&ts->cb_done);
     ts->expire_time = -1;
+    ts->cb_running = false;
 }
 
 void timer_deinit(QEMUTimer *ts)
@@ -394,6 +397,12 @@ static void timer_del_locked(QEMUTimerList *timer_list, QEMUTimer *ts)
         }
         pt = &t->next;
     }
+
+    qemu_mutex_lock(&ts->opaque_lock);
+    while (ts->cb_running) {
+        qemu_cond_wait(&ts->cb_done, &ts->opaque_lock);
+    }
+    qemu_mutex_unlock(&ts->opaque_lock);
 }
 
 static bool timer_mod_ns_locked(QEMUTimerList *timer_list,
@@ -571,11 +580,23 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
         cb = ts->cb;
         opaque = ts->opaque;
 
+        /* Mark the callback as running to prevent
+         * destroying `opaque` in another thread.
+         */
+        qemu_mutex_lock(&ts->opaque_lock);
+        ts->cb_running = true;
+        qemu_mutex_unlock(&ts->opaque_lock);
+
         /* run the callback (the timer list can be modified) */
         qemu_mutex_unlock(&timer_list->active_timers_lock);
         cb(opaque);
         qemu_mutex_lock(&timer_list->active_timers_lock);
 
+        qemu_mutex_lock(&ts->opaque_lock);
+        ts->cb_running = false;
+        qemu_cond_broadcast(&ts->cb_done);
+        qemu_mutex_unlock(&ts->opaque_lock);
+
         progress = true;
     }
     qemu_mutex_unlock(&timer_list->active_timers_lock);
-- 
2.45.2.741.gdbec12cfda-goog


