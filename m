Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C42C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 00:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMd3S-0004S5-Ji; Wed, 26 Jun 2024 20:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3_LJ8ZgQKCo8A31Az77z4x.v759x5D-wxEx4676z6D.7Az@flex--rkir.bounces.google.com>)
 id 1sMd3Q-0004Rg-Cc
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 20:32:00 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3_LJ8ZgQKCo8A31Az77z4x.v759x5D-wxEx4676z6D.7Az@flex--rkir.bounces.google.com>)
 id 1sMd3O-0002D3-MP
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 20:32:00 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-dfa7a8147c3so15345614276.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 17:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719448316; x=1720053116; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=bSvP8I+isPN5r4WH6q3hW+Emg0Jt88GzjbCndUL05gw=;
 b=AMWsx8jnS7tRHvhWz7saPamY5+MjD8rm5lyWjA0eJJccxtxMt4S7Nfh1w7NB8Hyqsv
 mBNWoxkemPOldyip4iBN3GtiqdihSrQt/+95XQRuORntFna66hJ2eeAxYC90/GrQIMnl
 dQAEIRmBPIYc2kVClVCYvdhqFm3kn01X4SpU7RA13RNKrxZT5I0xMfjUb8EoBnHkpy0Y
 gJT4Hs5A/POjVXp/WrC2BxZRxPRYuIocozdVTHs2IE3vy/klRLjHNvl+xoBnvmPs0BZu
 kBAOtFuM6spxPnQ+z5mlEwZPfjdyAq6X3JfbCn+dz6ET/Ufu3MJWjKBRg13PGkx2N+WK
 xIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719448316; x=1720053116;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bSvP8I+isPN5r4WH6q3hW+Emg0Jt88GzjbCndUL05gw=;
 b=gOFFQ7NziwVmk4H8A07fbAAFrWkvMs7ij6cv9+4USQV3e+R4urT3RAuFyQgv2ShdFi
 XQJUR0AYfazsrg4SnaZ4f50I3SLUatEzCmEHRvbMhgKI4lnDR6r/WawRTyp0zLd0CIx7
 jz+TztZt+tuogaSfoZOpz0tbWIAMai62ze1jQ+jpXiR+ngnuSeIKorxmu8eYR0+OMGXi
 hYPfmeuu0sSm3ADxnnotkYqJgeUEUdp69wnL0Sj5tiFomU/AiDf0xapTBPJ69//ZtpI2
 NF2BusGZLqM2vujrf015eJAIze61AJY89+V04iQzA4EAOL7WJej167i7cRSGtIOFMEz4
 a1Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoERWgdfco7kCxUYD+9oYVYPl4xNp++UQdNyqUnWr0e7hZTOH8wCF1Vxg2MbGfyFk+nd8nyVcaPVA6GXWdUbHqM+/jJ6E=
X-Gm-Message-State: AOJu0YyYITlJKordS1CyG9E5PUf52O6i4S1dBxTZdOFKu7ql755TZxLJ
 KFmwrvYdYcHa5s6jUYnVpwBLkgyV9nYTVuny+ORIfGS/XDbpV0hRNXSnzzyk8xwfNqIGUg==
X-Google-Smtp-Source: AGHT+IFn2APDBRgUqQBqi9B9TB+Ol1qCAla94HAdI/yrul5HyrW2Up6rcOaMbP6w5zR5g0m69H9gtpz0
X-Received: from rkir98.kir.corp.google.com
 ([2620:15c:7d:4:e7b4:877a:d463:4598])
 (user=rkir job=sendgmr) by 2002:a05:6902:2b93:b0:dff:4c99:915 with SMTP id
 3f1490d57ef6-e0303fcf886mr746081276.10.1719448316161; Wed, 26 Jun 2024
 17:31:56 -0700 (PDT)
Date: Wed, 26 Jun 2024 17:31:34 -0700
In-Reply-To: <ad0740c5-9bc2-443c-9caa-a243b3a29108@redhat.com>
Mime-Version: 1.0
References: <ad0740c5-9bc2-443c-9caa-a243b3a29108@redhat.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240627003134.3447175-1-rkir@google.com>
Subject: [PATCH v3] timer: Fix a race condition between timer's callback and
 destroying code
From: Roman Kiryanov <rkir@google.com>
To: pbonzini@redhat.com
Cc: jansene@google.com, jpcottin@google.com, mett@google.com, 
 qemu-devel@nongnu.org, rkir@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3_LJ8ZgQKCo8A31Az77z4x.v759x5D-wxEx4676z6D.7Az@flex--rkir.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
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

v3: if a timer's callback happens to be running
    (cb_running) wait until all timers are done.
    qatomic_read/qemu_event_reset could be racing
    and timer_del might wait one extra loop of
    timers to be done.

 include/qemu/timer.h |  1 +
 util/qemu-timer.c    | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 5ce83c7911..c2c98f79f4 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -89,6 +89,7 @@ struct QEMUTimer {
     QEMUTimer *next;
     int attributes;
     int scale;
+    bool cb_running;
 };
 
 extern QEMUTimerListGroup main_loop_tlg;
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 213114be68..5ec379dc43 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -370,6 +370,7 @@ void timer_init_full(QEMUTimer *ts,
     ts->scale = scale;
     ts->attributes = attributes;
     ts->expire_time = -1;
+    ts->cb_running = false;
 }
 
 void timer_deinit(QEMUTimer *ts)
@@ -435,6 +436,10 @@ void timer_del(QEMUTimer *ts)
         qemu_mutex_lock(&timer_list->active_timers_lock);
         timer_del_locked(timer_list, ts);
         qemu_mutex_unlock(&timer_list->active_timers_lock);
+
+        if (qatomic_read(&ts->cb_running)) {
+            qemu_event_wait(&timer_list->timers_done_ev);
+        }
     }
 }
 
@@ -571,9 +576,15 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
         cb = ts->cb;
         opaque = ts->opaque;
 
+        /* prevent timer_del from returning while cb(opaque)
+         * is still running (by waiting for timers_done_ev).
+         */
+        qatomic_set(&ts->cb_running, true);
+
         /* run the callback (the timer list can be modified) */
         qemu_mutex_unlock(&timer_list->active_timers_lock);
         cb(opaque);
+        qatomic_set(&ts->cb_running, false);
         qemu_mutex_lock(&timer_list->active_timers_lock);
 
         progress = true;
-- 
2.45.2.741.gdbec12cfda-goog


