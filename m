Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED5EC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 18:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMX68-00047r-CJ; Wed, 26 Jun 2024 14:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3iFl8ZgQKCmcWPNWLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--rkir.bounces.google.com>)
 id 1sMX66-00047Z-J6
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 14:10:22 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3iFl8ZgQKCmcWPNWLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--rkir.bounces.google.com>)
 id 1sMX64-0002zy-SI
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 14:10:22 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-648cabfaeecso10570407b3.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 11:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719425417; x=1720030217; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FldijschhLQ+XaonRMFWfUWX1O0P0VnZhMNiod+FW8k=;
 b=UNvUhReaRNPgEo4IbHZWmutN99wYC4L63allfG7StgqWOVb/qnG2SgYpi+AoONKJaY
 0qCTXhTbP/IjMhri0Ng7QnR8K3ZC+aZWzq2WXo9Q23Q/aP7G6nkMHhEsMzkFptFt4NH5
 RFrxdFQ6/I9lnc5M1w+hgdMqgkkOQMoRwNJGquCFYLuvf871rjnLLCApQ2laBqAY8j+i
 HLeit8fAb5E6bcG6VpnT5419J0SFOyp83cuM0fBtprFrihgfswkzj0h+hO1Q2yqE/qZK
 0tYiKXhisahKK1H8hCY+uIoPl32BSEgihQHLG6iCQ/rT1Rs12whwcTpKPahuL/awWqtG
 jVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719425417; x=1720030217;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FldijschhLQ+XaonRMFWfUWX1O0P0VnZhMNiod+FW8k=;
 b=pf5cVCCou9ORnMQwrmkodEsahlbrUwbefj4kirDga1r8bimo6nI+m9xm6MZuGSEQJt
 tmywu7duvg02tD6werY5k/cZhDn/m8X1VNPxHz/xtMLsGosOmm8cX7CwfQZWypuEl3M/
 r3mexW6rGN2kHIgoAQfCwLStWfqj3+1aYvD0zTNO+7fRRhrtoW/9ymWQHwQvHzDhlzW7
 H7GqBWbtYXJlXcoTj+ms9hwAoV6uZ09Vkg/v0eDk1nFkUfKoWROg+/Kqnue9ER/4vQLB
 Ulo3VVJww2yCddusTnFgkLhfmlPyeh+46JMZu8YuHbbjukrcm5xbIdNNe2YtuI0rquTj
 oF3Q==
X-Gm-Message-State: AOJu0YxIcKLiwwffmLoDxlAWpruYmTgITkKYEVAUWummiziMlFJyOfdt
 a0vbQUvGYqocAtVJ7Z1IYCiAxzppDULO5c/aWXft/zogQDnt3DNh4g0gUBPHBpY2DBCUajIfzk/
 V95qydvrqWIdUrBEIZloPy10jdAT66OcbshBTCZMXo3ECc5sGdt2ifdcImh5DEHZuZdzKrkmwNI
 yMp6o4jaOqw7kl2T0VZSiH
X-Google-Smtp-Source: AGHT+IE6rncvHu/b1HiG7lnftLgvaBJdBnVVeZXN5KoMOiDbOe9nj6gW5SppnCUX8hiIZN7VzfvYz+Dg
X-Received: from rkir98.kir.corp.google.com
 ([2620:15c:7d:4:e7b4:877a:d463:4598])
 (user=rkir job=sendgmr) by 2002:a05:690c:4909:b0:62f:5d17:3628 with SMTP id
 00721157ae682-643a8a205b4mr4590557b3.0.1719425416975; Wed, 26 Jun 2024
 11:10:16 -0700 (PDT)
Date: Wed, 26 Jun 2024 11:10:12 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240626181012.3321084-1-rkir@google.com>
Subject: [PATCH] timer: Fix a race condition between timer's callback and
 destroying code
From: Roman Kiryanov <rkir@google.com>
To: qemu-devel@nongnu.org
Cc: jansene@google.com, mett@google.com, jpcottin@google.com, 
 Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3iFl8ZgQKCmcWPNWLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--rkir.bounces.google.com;
 helo=mail-yw1-x1149.google.com
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

Google-Bug-Id: 348598513
Change-Id: I3cd6350587fb67c73bbee7b934d2c0c1acb27229
Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 include/qemu/timer.h |  4 ++++
 util/qemu-timer.c    | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 9a366e551f..de82ed78ae 100644
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
index 6a0de33dd2..9eb6fca5fa 100644
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
@@ -571,9 +580,22 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
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
+
+        qemu_mutex_lock(&ts->opaque_lock);
+        ts->cb_running = false;
+        qemu_cond_broadcast(&ts->cb_done);
+        qemu_mutex_unlock(&ts->opaque_lock);
+
         qemu_mutex_lock(&timer_list->active_timers_lock);
 
         progress = true;
-- 
2.45.2.741.gdbec12cfda-goog


