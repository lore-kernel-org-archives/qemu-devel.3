Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4FEC88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Zs7-0001Q3-8y; Tue, 15 Sep 2026 16:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6Zs1-0001L2-7P
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:35:13 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6Zrz-0005cH-2e
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:35:12 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-48583cc7ab1so57850f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789504510; x=1790109310; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oBBGUd0tnUmZGDjKutUwl1+Hd5+Ihg+QY1Fkbe3I8cQ=;
 b=Q74wUeo2y4bUX7JLVnaGp6F3EWg4c1/gi9iCwH5zfw7h6qw/oHZu02yZ/z3IUJZzBe
 6pq5w0GbwBzOg8eiK189CFse7POC9Da4m5LXpYTP8kDMmcKBVX4LXVgSgPjwmhBf6aEf
 DCotP4gi/sqB/7Oa6SnVUyBqt62oD+zVFQGogBKl5rYcHF5ns0wgfIuzqBiSa9UZ4Y56
 TCBIOCnTf9zT08KvzvnTKdSoZ/mM/L+bYkV+CUjfwT2e5lXvAUkxTxSMicgekVRKaxfG
 B+XgkP648sDHg28DOrD7gemOJeS5XElj4l4ZuEkGusctd1eyMa1MjWMlujbJhVognamR
 UA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504510; x=1790109310;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oBBGUd0tnUmZGDjKutUwl1+Hd5+Ihg+QY1Fkbe3I8cQ=;
 b=isQrd6zusOvI4k92y6vN9gNz5elcKLkfDfr8z8SE8FPiwtRM6sTjyTatUALi+p1J8v
 bUGEmWPh6Ly77jLXHFba7WJlV9ytD2MnfRyEtJCm3RYStcCWZxKgewZGP6XacgsgSwzQ
 NgIZm7aFhkdZCiLxZNyZw4cDCefLyVROCNpEfnheb+HzyCppiRTuIdEHf5Bp9YW7X/wv
 NehY3Qh2VJEryWjfnSB5C283G5xbCqObPU6qSUnZfbXkXumn+aDyQbFIkPenTEr4PR3w
 2hPlJJa2ccDkp8mVll37dCamtolbS7P09y1BG0zWiXTNWMKQro3ojGMnzLnSVSIQcyyL
 YPBQ==
X-Gm-Message-State: AFuF++nbCw7+4WsbUsV5QCXxwStsTNCOG3Q57PHvoyyuCOqwznWmybbZ
 WvidwSYXSQNOAlfCt6+Sx17vjfExh0jeXqbHHofxQ/L0FlLJ2cHFQYHUql3MKUuY1ea3hG0fYrF
 vqQxt
X-Gm-Gg: AYBFou1WlQugaRRXrdYHawMt8pe9fNuuAj1LNGTcn1LXaYGCKtlxMMRL8YER+nRAF8D
 fdJiD4NZuHaWxqURJ8DsyrXKknksW1VApxdtUpazN/nwgMDlWU1UsjKS6dmYrvJM1U1VnhhzVlW
 WbBNgLzJldv1ZiyJNXDwz9kQ+jg+D09XUSA7VYPWk2I6ALcyTIOoHBxolwYB7THlwPXWeZ70ELa
 IctwwSQaXO633G5x7JRN1mD4mWbD0IHQLi+rPfhLHOcVcgRk4mckhu8oFt3SAjBmq01ZqI78xmv
 pQBmHnaNXOpgMlL5prl7G5ZAdkr77NS8qM/F038wwb0V2SyjJqVVmSvgUpIgw8C8zG7AMn1FeiG
 fmSQqyLJ8s7slhblXw2nw+x2yq1Uy+q9RKh1Ld8wyNic2M+ECkz6wVxDazgAqXkCifySoY4B4xE
 AZ0lwBA2o0NqWLXQw2WkwyKRNzPvwlyfCqtuUpYns+2JqQQXLz3SQ1HCaTj0B4DsXt+pBmbg==
X-Received: by 2002:a05:6000:200e:b0:487:c4b:71c5 with SMTP id
 ffacd0b85a97d-4870cf0498cmr155019f8f.17.1789504509614; 
 Tue, 15 Sep 2026 13:35:09 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:f0fe:c7ed:403d:e487])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf37e69sm1504073f8f.29.2026.09.15.13.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:35:09 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 07/10] system/cpus: report a BQL held past a deadline
Date: Tue, 15 Sep 2026 22:34:51 +0200
Message-ID: <20260915203455.580999-8-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915203455.580999-1-den@openvz.org>
References: <20260915203455.580999-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=den@openvz.org; helo=mail-wr2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Denis V. Lunev <den@openvz.org>

A vCPU thread reacquires the BQL on every exit that needs userspace, so
a lock held for tens of seconds stops those vCPUs dead and the guest
reports its own soft lockup. Nothing in qemu records that this
happened, which leaves a guest panic as the only evidence and no way to
tell a stuck holder from a guest that wedged on its own.

Add a BQL watchdog. A thread of its own samples a counter advanced on
every acquire and every release, so it is odd while the lock is held.
One odd value seen throughout the window means a single owner held the
lock for the whole window, because any handover would have advanced the
counter twice.

Advance it in bql_update_status(), which the mutex hooks already call
for exactly those two transitions, so a cond-wait that drops and
retakes the lock is covered without the wrappers knowing, and so is any
caller that reaches the BQL through the plain mutex API. Record the
holder's tid beside it, under the same lock, because the thread listing
alone cannot tell a thread parked on its own condvar from one blocked
on the BQL. Cache the tid per thread, since gettid is a syscall and
this is the lock path.

On expiry, name the holder and list every thread's state. The listing
separates a thread blocked on the BQL, which waits in a futex, from one
idle inside KVM, which waits in kvm_vcpu_block, and names the syscall a
wedged holder is stuck in. Report once per episode, or a lock held for
a minute buries the log in copies of one answer. Put the time on the
line unless -msg timestamp=on already does: a hold is only worth
reporting if it can be lined up against what the guest saw, and that
option has to be asked for in advance.

The deadline has to clear the longest legitimate hold, and migration
setup can hold the BQL for a while, so the watchdog stays off unless
asked for. The bql-watchdog-ms machine property is the whole interface:
it sets the deadline, on the command line or over qom-set at any time,
and 0 turns the watchdog off. Reject a deadline above a minute: a hold
that long has already shown up as a soft lockup inside the guest.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/core/machine.c     |  27 ++++++++++
 include/system/cpus.h |   4 ++
 qemu-options.hx       |   6 +++
 system/cpus.c         | 120 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 157 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 8939ae1666..b55af89516 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -382,6 +382,27 @@ static void machine_set_dump_guest_core(Object *obj, bool value, Error **errp)
     ms->dump_guest_core = value;
 }
 
+static void machine_get_bql_watchdog_ms(Object *obj, Visitor *v,
+                                        const char *name, void *opaque,
+                                        Error **errp)
+{
+    uint64_t value = bql_watchdog_get_timeout_ms();
+
+    visit_type_uint64(v, name, &value, errp);
+}
+
+static void machine_set_bql_watchdog_ms(Object *obj, Visitor *v,
+                                        const char *name, void *opaque,
+                                        Error **errp)
+{
+    uint64_t value;
+
+    if (!visit_type_uint64(v, name, &value, errp)) {
+        return;
+    }
+    bql_watchdog_set_timeout_ms(value, errp);
+}
+
 static bool machine_get_new_accel_vmfd_on_reset(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -1147,6 +1168,12 @@ static void machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "dump-guest-core",
         "Include guest memory in a core dump");
 
+    object_class_property_add(oc, "bql-watchdog-ms", "uint64",
+        machine_get_bql_watchdog_ms, machine_set_bql_watchdog_ms, NULL, NULL);
+    object_class_property_set_description(oc, "bql-watchdog-ms",
+        "Watchdog deadline for a Big QEMU Lock hold, in ms. "
+        "Default: 0 (disabled)");
+
     object_class_property_add_bool(oc, "x-change-vmfd-on-reset",
         machine_get_new_accel_vmfd_on_reset,
         machine_set_new_accel_vmfd_on_reset);
diff --git a/include/system/cpus.h b/include/system/cpus.h
index bf36b82376..0e1e63bd85 100644
--- a/include/system/cpus.h
+++ b/include/system/cpus.h
@@ -40,4 +40,8 @@ void cpu_synchronize_all_post_reset(void);
 void cpu_synchronize_all_post_init(void);
 void cpu_synchronize_all_pre_loadvm(void);
 
+/* Watchdog deadline for a BQL hold. 0 disables the watchdog. */
+bool bql_watchdog_set_timeout_ms(uint64_t ms, Error **errp);
+uint64_t bql_watchdog_get_timeout_ms(void);
+
 #endif
diff --git a/qemu-options.hx b/qemu-options.hx
index 2f6863180b..9600620d34 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -32,6 +32,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
     "                dump-guest-core=on|off include guest memory in a core dump (default=on)\n"
     "                mem-merge=on|off controls memory merge support (default: on)\n"
+    "                bql-watchdog-ms=ms report a Big QEMU Lock held longer than ms (default: 0, off)\n"
     "                aes-key-wrap=on|off controls support for AES key wrapping (default=on)\n"
     "                dea-key-wrap=on|off controls support for DEA key wrapping (default=on)\n"
     "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
@@ -88,6 +89,11 @@ SRST
         supported by the host, de-duplicates identical memory pages
         among VMs instances (enabled by default).
 
+    ``bql-watchdog-ms=ms``
+        Report when the Big QEMU Lock has been held for more than ``ms``
+        milliseconds, up to a minute. The default is 0, which disables the
+        watchdog.
+
     ``aes-key-wrap=on|off``
         Enables or disables AES key wrapping support on s390-ccw hosts.
         This feature controls whether AES wrapping keys will be created
diff --git a/system/cpus.c b/system/cpus.c
index e11a5aab6a..9e03f303f2 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -31,6 +31,7 @@
 #include "exec/cpu-common.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
+#include "qemu/error-report.h"
 #include "qemu/plugin.h"
 #include "system/cpus.h"
 #include "qemu/guest-random.h"
@@ -367,12 +368,129 @@ static QemuCond qemu_cpu_cond;
 /* system init */
 static QemuCond qemu_pause_cond;
 
+/*
+ * Advanced by bql_update_status() below, so odd while the BQL is held and
+ * even while it is free. A sampler that sees one odd value throughout its
+ * window knows a single owner held the lock for the whole window: any
+ * handover would have advanced it twice.
+ */
+static unsigned int bql_seq;
+
+/* Who advanced bql_seq to its current odd value, 0 while the BQL is free */
+static int bql_owner_tid;
+
+static int bql_this_tid(void)
+{
+    static __thread int tid;
+
+    if (tid) {
+        return tid;
+    }
+    tid = qemu_get_thread_id();
+    return tid;
+}
+
+/* Poll this many times per timeout, to bound how late the watchdog reacts */
+#define BQL_WATCHDOG_POLLS 4
+
+#define BQL_WATCHDOG_MAX_MS (60 * 1000)
+
+static QemuThread bql_watchdog_thread;
+static QemuSemaphore bql_watchdog_sem;
+static uint64_t bql_watchdog_timeout_ms;
+
+static void bql_report_thread_states(void)
+{
+    g_autofree char *states = qemu_thread_states();
+
+    if (!states) {
+        return;
+    }
+    qemu_flockfile(stderr);
+    fputs(states, stderr);
+    qemu_funlockfile(stderr);
+}
+
+static void *bql_watchdog_fn(void *opaque)
+{
+    unsigned int last = qatomic_read(&bql_seq);
+    unsigned int reported = 0;
+    int stuck_polls = 0;
+
+    for (;;) {
+        uint64_t timeout_ms = qatomic_read(&bql_watchdog_timeout_ms);
+        g_autofree char *when = NULL;
+        unsigned int seq;
+
+        if (!timeout_ms) {
+            /* Park rather than exit, so re-arming needs no new thread */
+            qemu_sem_wait(&bql_watchdog_sem);
+            last = qatomic_read(&bql_seq);
+            stuck_polls = 0;
+            continue;
+        }
+        qemu_sem_timedwait(&bql_watchdog_sem,
+                           MAX(timeout_ms / BQL_WATCHDOG_POLLS, 1));
+
+        seq = qatomic_read(&bql_seq);
+        if (seq != last || !(seq & 1)) {
+            last = seq;
+            stuck_polls = 0;
+            continue;
+        }
+        if (++stuck_polls < BQL_WATCHDOG_POLLS) {
+            continue;
+        }
+        if (seq == reported) {
+            continue;
+        }
+        reported = seq;
+        if (!message_with_timestamp) {
+            when = real_time_iso8601();
+        }
+        error_report("%s%sBQL held for more than %" PRIu64 " ms by thread %d",
+                     when ?: "", when ? " " : "", timeout_ms,
+                     qatomic_read(&bql_owner_tid));
+        bql_report_thread_states();
+    }
+}
+
+uint64_t bql_watchdog_get_timeout_ms(void)
+{
+    return qatomic_read(&bql_watchdog_timeout_ms);
+}
+
+bool bql_watchdog_set_timeout_ms(uint64_t ms, Error **errp)
+{
+    static bool started;
+
+    assert(bql_locked());
+    if (ms > BQL_WATCHDOG_MAX_MS) {
+        error_setg(errp, "BQL watchdog deadline must not exceed %d ms",
+                   BQL_WATCHDOG_MAX_MS);
+        return false;
+    }
+    qatomic_set(&bql_watchdog_timeout_ms, ms);
+    if (!ms) {
+        return true;
+    }
+    if (!started) {
+        started = true;
+        qemu_thread_create(&bql_watchdog_thread, "bql-watchdog",
+                           bql_watchdog_fn, NULL, QEMU_THREAD_DETACHED);
+    } else {
+        qemu_sem_post(&bql_watchdog_sem);
+    }
+    return true;
+}
+
 void qemu_init_cpu_loop(void)
 {
     qemu_init_sigbus();
     qemu_cond_init(&qemu_cpu_cond);
     qemu_cond_init(&qemu_pause_cond);
     qemu_mutex_init(&bql);
+    qemu_sem_init(&bql_watchdog_sem, 0);
 
     qemu_thread_get_self(&io_thread);
 }
@@ -477,6 +595,8 @@ void bql_update_status(bool locked)
     /* This function should only be used when an update happened.. */
     assert(bql_locked() != locked);
     set_bql_locked(locked);
+    qatomic_set(&bql_owner_tid, locked ? bql_this_tid() : 0);
+    qatomic_set(&bql_seq, qatomic_read(&bql_seq) + 1);
 }
 
 static uint32_t bql_unlock_blocked;
-- 
2.53.0


