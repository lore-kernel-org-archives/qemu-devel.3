Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD2DC30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 21:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOONL-0008Gu-Qo; Mon, 01 Jul 2024 17:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3gByDZgQKCgEsljshpphmf.dpnrfnv-efwfmopohov.psh@flex--rkir.bounces.google.com>)
 id 1sOONK-00089g-Au
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 17:15:50 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3gByDZgQKCgEsljshpphmf.dpnrfnv-efwfmopohov.psh@flex--rkir.bounces.google.com>)
 id 1sOONI-0008CD-De
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 17:15:50 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-64b49f4232eso51444307b3.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 14:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719868544; x=1720473344; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=aYbw5ZCrnoxe2mSiC7KMmlLnGgDinFgDexio/dDvb2M=;
 b=m6a+FsApeHUiYqpIOX5oz7xebyb0BnRakKKYxqnr6HZISPkooiT1uk36BIVK9qMTO3
 jgcsVGzqqtJuctTdoSGqhzKE6Su5vHWHNZpK/q9y3wMKYb2/r/7e6Vc7LZt/DeODcb4T
 1jw4Vt2xvzAHJRso1OEw+oQ3gjzRNBZENVy81r5zoy20+R+dJTNKUygDk+RKfwEQyc5R
 dX79o2TUrc470WaOmVgB7BQWVg07AylDY0EL1gQC3NRgNyOZdVz2I+GeDpBb48v3IK8e
 rV98AXHuR5dlW/nhETHRZXAk7cKRQJ8JVQcIlA7I2b9ZrP93Hrv54HD1U1+VSRGLz5eR
 lJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719868544; x=1720473344;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aYbw5ZCrnoxe2mSiC7KMmlLnGgDinFgDexio/dDvb2M=;
 b=OXG4067WjjdSUuuuMCBu++06e90P/wh5u60g45G5FUCN1fYh1IxqDZdzMpLji8M2Gd
 mT/Z10ThUwa9Uw5nwoBQwZsKarEw/7xS0G1qBHUKfE4UaCr6eARAZ4w3MypcZ4rk0jTT
 f4JvpHnpNH9yPHZT6ITrYCWK3w1ynOELoXLTV6c9bPRw9zVpzDDBMgLEV+kq1cCwNxTd
 fbWjUtMekWkp3pPc5lB6F1fdcMsotdIQySQ8RJ2iTIXOJ3AjHb5gKeocvFmYGQVTLvxV
 3UMUZ6wR8M4xWxSSYpiYs0CZN7urM9G4yg1z/WDOncJF3xsYgPf6lCmxzeoJv3+ZAc/m
 3W0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmADWT+CkeJIYsbNRPdP5iLN1wOYjXVMEcfzOuGWcvR60sm8obAjg2GLRpy9i2Jd+JVZKA4pipU2dUA+PLit7wUWZqxqc=
X-Gm-Message-State: AOJu0YxlmQ/pi/sIxqEXxU+vxyOzmhEl0UqtnLM0xszgFt2AEpha0YE8
 Ru+o30HNvv/aIhdC7/+Rj6YNICvapC7IQz43Juj7ySlvHzctXDoxmTpwHkGjbjQFvreD+A==
X-Google-Smtp-Source: AGHT+IHX07HSodyhRB/BDSD0DSB++TTMZv+nNGnOKB/oas3WtTsNgDaJvEfOaaF5whk08g/+13Jj53XO
X-Received: from rkir98.kir.corp.google.com
 ([2620:15c:7d:4:2663:745c:fa4e:8650])
 (user=rkir job=sendgmr) by 2002:a81:8481:0:b0:62c:ea0b:a44e with SMTP id
 00721157ae682-64c7502d61cmr205447b3.2.1719868544313; Mon, 01 Jul 2024
 14:15:44 -0700 (PDT)
Date: Mon,  1 Jul 2024 14:15:31 -0700
In-Reply-To: <CABgObfaBjneGy__o_aABdm+60wsg=rxLmgZLthwCoezwnH34ZQ@mail.gmail.com>
Mime-Version: 1.0
References: <CABgObfaBjneGy__o_aABdm+60wsg=rxLmgZLthwCoezwnH34ZQ@mail.gmail.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701211531.97637-1-rkir@google.com>
Subject: [PATCH v4] Add timer_join to avoid racing in timer cleanup
From: Roman Kiryanov <rkir@google.com>
To: pbonzini@redhat.com
Cc: jansene@google.com, jpcottin@google.com, mett@google.com, 
 qemu-devel@nongnu.org, rkir@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3gByDZgQKCgEsljshpphmf.dpnrfnv-efwfmopohov.psh@flex--rkir.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
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

Currently there is no mechanism guaranteeing
that it is safe to delete the object pointed
by opaque in timer_init.

This race condition happens if a timer is
created on a separate thread and timer_del
is called between qemu_mutex_unlock and
cb(opaque) in timerlist_run_timers.

In this case the user thread will continue
executing (once timer_del returns) which could
cause destruction of the object pointed by
opaque while the callback is (or will be)
using it. See the example below:

void myThreadFunc() {
    void *opaque = malloc(42);
    QEMUTimer timer;

    timer_init(&timer, myClockType, myScale,
               &myTimerCallbackFunc, opaque);
    ...
    timer_del(&timer);
    free(opaque);
}

This change adds a function, timer_join,
that makes sure that the timer callback
(all timer callbacks, to be precise; this
is an implementation detail and could be
adjusted later) is done and it is safe to
destroy the object pointed by opaque.

Once this function is available, the example
above will look like this:

    timer_del(&timer);
    timer_join(&timer);
    free(opaque);

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
v2: rebased to the right branch and removed
    Google specific tags from the commit message.

v3: if a timer's callback happens to be running
    (cb_running) wait until all timers are done.
    qatomic_read/qemu_event_reset could be racing
    and timer_del might wait one extra loop of
    timers to be done.

v4: add timer_join implmented via aio_wait_bh_oneshot
    as suggested by pbonzini@redhat.com.

 include/qemu/timer.h | 11 +++++++++++
 util/qemu-timer.c    | 14 ++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 5ce83c7911..5f7d673830 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -635,6 +635,17 @@ void timer_deinit(QEMUTimer *ts);
  */
 void timer_del(QEMUTimer *ts);
 
+/**
+ * timer_join:
+ * @ts: the timer
+ *
+ * Wait for the timer callback to finish (if it is runniing).
+ *
+ * This function is thread-safe but the timer and its timer list must not be
+ * freed while this function is running.
+ */
+void timer_join(QEMUTimer *ts);
+
 /**
  * timer_free:
  * @ts: the timer
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 213114be68..22759be580 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -30,6 +30,8 @@
 #include "sysemu/replay.h"
 #include "sysemu/cpus.h"
 
+#include "block/aio-wait.h"
+
 #ifdef CONFIG_POSIX
 #include <pthread.h>
 #endif
@@ -438,6 +440,18 @@ void timer_del(QEMUTimer *ts)
     }
 }
 
+static void timer_join_noop(void *unused) {}
+
+/* Make sure the timer callback is done */
+void timer_join(QEMUTimer *ts)
+{
+    /* A side effect of aio_wait_bh_oneshot is all
+     * timer callbacks are done once it returns.
+     */
+    aio_wait_bh_oneshot(qemu_get_aio_context(),
+                        &timer_join_noop, NULL);
+}
+
 /* modify the current timer so that it will be fired when current_time
    >= expire_time. The corresponding callback will be called. */
 void timer_mod_ns(QEMUTimer *ts, int64_t expire_time)
-- 
2.45.2.803.g4e1b14247a-goog


