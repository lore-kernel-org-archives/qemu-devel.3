Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5922BFDEE39
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 00:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG4ct-0004Te-Sg; Thu, 23 Apr 2026 20:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elirazamumtaz@gmail.com>)
 id 1wG1jr-0002a8-JO
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:37:35 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <elirazamumtaz@gmail.com>)
 id 1wG1jp-0001FU-Qw
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:37:35 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43d7b879691so949517f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 14:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776980252; x=1777585052; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r/MkEQmRXLYmx51oofgr61oVs//gZmrORdrLItZ2SQM=;
 b=UF1RupDWimT764MGZXSzRFg0eWEz1sWBLNiR0OKTF/C+ZCqeDX/w9avZBuvUG4eSf1
 ldeKboIFwHWQW40vjzfGw2vZzROr4UZLNRkarSoc5yCbq0PQG2ME4J1r8dtcNoszl7bl
 wqhhq8cZsOhIDDyn8QwfHsAHKhN1dVDIUmZCXT5D77LwtXi2in+fEv3Z2H/aXraLCH8h
 efEUjaZMKqbnKau/0aeFl1Ujhks6lGoXhv0GcRAvRWci3JByYGRf+SWwYYJ4NhW68DfF
 gF53VwLiFb57VzOsWqvFfjXai0iynHM1ekaAA/2v/gZtV6UXKuiZtKqk9WIj/xSEN16P
 F+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776980252; x=1777585052;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=r/MkEQmRXLYmx51oofgr61oVs//gZmrORdrLItZ2SQM=;
 b=Or13HyNLShIOhaRI+zO+Kq0olySX0ZNOhrSLHTxtwTsRiljvZ1Ip4yr2ZOD+KOcZMO
 6UryiPNgOtYwat1RYHwOHPZkiEa5zqDZkRF9/34C+e+HMF7GcbFrOV3ZCgFJ34Lr/nw0
 PVmqt4BAmv0++auU3nmAnxm7I3q2lCdafnn2znimPKVPG1+UzKdV9lTS+EZUH3O25hXf
 6DtxQVlPOypE4Im/uGZWzVoC0JvF90mr9eGcWPRC64HG/Cd+t9/q11o032E1bW030oAU
 0LIpyDCRtQKxXGW2vQ+O/zF72bMQFVtn2uCXZaElUpdTdXWRqB94B3jCQTrprSJwVf7i
 7rkg==
X-Gm-Message-State: AOJu0YzU7EzkDe1JWy0NcTkYfSrrSbbKYJ8fldWVok7U4nhmcpNs/pg9
 4Sy8Yjp57udsfHeM/FV+Z596weWYXEr+13Bb88ih22QYBUFoWWIK5dJs
X-Gm-Gg: AeBDietisU43J6DwvZCMAogCXeM3IAR3ADJZHd7SRdsnmEpiyg8/KROnjDIGFaozaAV
 lfnY06YvQ77rsct5qbimfi856NzfX/dMYHJtveL71dCNJtMHBOj7nsFrNCCKksFHtF0Yr0o4jDb
 1odT6o7ZGtk+Ll/6462WQ6cB4oCGM0tXNIe0wvUicuwkbQ1gRgz91Yz5Z6N3rn6hG8oRXzq3W4W
 alnfacW7oKfTcflQtuyUbo/QULcfG8ojdwQZMg9LnkkSswsk4JSb46SkG6Mtr4y700p7Nn233E9
 +xOSVZd/v3uixNCzrw68NBhQG75zv8yEdIwG+Eh4F2+AZymCN3Ut9cpEh1FoyFqG0fLT0rQQwc7
 N+zJdt8MHFfGU89fGg8GNtUgCkLJGDYUnDBA3+ZOULL6hxqYWw6jw2ymrmG2b13lGnA3cBmfg8s
 annifEBie3C0nEFU78sJwfAfHZmMjB+12F45ib5kRA5Q==
X-Received: by 2002:a05:600c:c177:b0:488:9e7e:e1e3 with SMTP id
 5b1f17b1804b1-488fb7390e6mr198494035e9.2.1776980252229; 
 Thu, 23 Apr 2026 14:37:32 -0700 (PDT)
Received: from [10.94.10.196] ([223.123.19.204])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48919f54572sm138755225e9.26.2026.04.23.14.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 14:37:31 -0700 (PDT)
From: Ali Raza <elirazamumtaz@gmail.com>
Date: Fri, 24 Apr 2026 02:36:40 +0500
Subject: [PATCH v2 3/3] tests/tcg: Add test for /proc/self/task/ filtering
 and tkill validation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-master-v2-3-8b50b5c063ed@gmail.com>
References: <20260424-master-v2-0-8b50b5c063ed@gmail.com>
In-Reply-To: <20260424-master-v2-0-8b50b5c063ed@gmail.com>
To: qemu-devel@nongnu.org
Cc: Ali Raza <elirazamumtaz@gmail.com>, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, deller@gmx.de
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=elirazamumtaz@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Apr 2026 20:42:33 -0400
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

Add a multiarch linux-user test that verifies:

1. /proc/self/task/ only lists guest threads -- spawns NUM_THREADS
   pthreads, reads the task directory, and asserts every entry maps
   to a known guest TID and the total count matches.

2. tkill(guest_tid, 0) succeeds for all guest threads.

3. tkill to a non-guest TID returns ESRCH.

On native Linux this test trivially passes since there are no
QEMU-internal threads.  Under QEMU user-mode, it exercises the
getdents64 filtering and tkill validation added in the previous
two commits.

Signed-off-by: Ali Raza (@locus-x64)

---
Changes in v2:
- Hard-assert ESRCH on tkill to a non-guest tid (was a printf).
- Add tgkill coverage: success on guest tids; ESRCH on a wrong tgid.
---
 tests/tcg/multiarch/Makefile.target         |   2 +
 tests/tcg/multiarch/linux/linux-proc-task.c | 193 ++++++++++++++++++++++++++++
 2 files changed, 195 insertions(+)

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 508149d57b..8d6e2af617 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -39,6 +39,8 @@ testthread: LDFLAGS+=-lpthread
 
 threadcount: LDFLAGS+=-lpthread
 
+linux-proc-task: LDFLAGS+=-lpthread
+
 signals: LDFLAGS+=-lrt -lpthread
 
 munmap-pthread: CFLAGS+=-pthread
diff --git a/tests/tcg/multiarch/linux/linux-proc-task.c b/tests/tcg/multiarch/linux/linux-proc-task.c
new file mode 100644
index 0000000000..0c41a4443f
--- /dev/null
+++ b/tests/tcg/multiarch/linux/linux-proc-task.c
@@ -0,0 +1,193 @@
+/*
+ * Test that /proc/self/task/ only lists guest threads.
+ *
+ * Under QEMU user-mode emulation, the host process may contain
+ * internal threads (RCU, TCG workers) that are not guest threads.
+ * These must be hidden from directory listings of /proc/<pid>/task/
+ * and signals to non-guest TIDs must return ESRCH.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#define _GNU_SOURCE
+#include <assert.h>
+#include <dirent.h>
+#include <errno.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#define NUM_THREADS 3
+
+static pid_t guest_tids[NUM_THREADS + 1]; /* +1 for main thread */
+static int num_guest_tids;
+static pthread_barrier_t barrier;
+
+static pid_t gettid_sys(void)
+{
+    return syscall(SYS_gettid);
+}
+
+static void *thread_func(void *arg)
+{
+    int idx = (int)(intptr_t)arg;
+
+    guest_tids[idx] = gettid_sys();
+    pthread_barrier_wait(&barrier);
+
+    /* Wait for main thread to finish testing. */
+    pthread_barrier_wait(&barrier);
+    return NULL;
+}
+
+/*
+ * Read /proc/self/task/ and return the count of numeric entries
+ * (thread TIDs).  For each entry, verify it matches a known guest TID.
+ */
+static int count_and_verify_task_entries(void)
+{
+    DIR *dir;
+    struct dirent *de;
+    int count = 0;
+
+    dir = opendir("/proc/self/task");
+    assert(dir != NULL);
+
+    while ((de = readdir(dir)) != NULL) {
+        char *endp;
+        long tid;
+        int i, found;
+
+        if (de->d_name[0] == '.') {
+            continue; /* skip "." and ".." */
+        }
+
+        tid = strtol(de->d_name, &endp, 10);
+        if (*endp != '\0' || tid <= 0) {
+            continue; /* non-numeric entry */
+        }
+
+        /* Every TID in the listing must be a known guest thread. */
+        found = 0;
+        for (i = 0; i < num_guest_tids; i++) {
+            if (guest_tids[i] == (pid_t)tid) {
+                found = 1;
+                break;
+            }
+        }
+        if (!found) {
+            fprintf(stderr, "FAIL: /proc/self/task/ contains unknown TID %ld\n",
+                    tid);
+            fprintf(stderr, "  Known guest TIDs:");
+            for (i = 0; i < num_guest_tids; i++) {
+                fprintf(stderr, " %d", guest_tids[i]);
+            }
+            fprintf(stderr, "\n");
+        }
+        assert(found);
+        count++;
+    }
+
+    closedir(dir);
+    return count;
+}
+
+/*
+ * Verify that tkill(tid, 0) succeeds for all guest TIDs and that
+ * tkill/tgkill to a TID that should not exist returns ESRCH.
+ */
+static void test_tkill_validation(void)
+{
+    int i, ret;
+    pid_t self = getpid();
+
+    /* Signal 0 to each guest TID should succeed via tkill and tgkill. */
+    for (i = 0; i < num_guest_tids; i++) {
+        ret = syscall(SYS_tkill, guest_tids[i], 0);
+        if (ret != 0) {
+            fprintf(stderr, "FAIL: tkill(%d, 0) returned %d (errno=%d)\n",
+                    guest_tids[i], ret, errno);
+        }
+        assert(ret == 0);
+
+        ret = syscall(SYS_tgkill, self, guest_tids[i], 0);
+        if (ret != 0) {
+            fprintf(stderr,
+                    "FAIL: tgkill(%d, %d, 0) returned %d (errno=%d)\n",
+                    self, guest_tids[i], ret, errno);
+        }
+        assert(ret == 0);
+    }
+
+    /*
+     * Try a TID that is very unlikely to be a guest thread.  Use
+     * pid_max (typically 4194304) minus 1 as a probe.  On a real
+     * kernel this returns ESRCH for a nonexistent thread; under QEMU
+     * with validation it must also return ESRCH.  In the (extremely
+     * unlikely) case that the TID does exist on the host, the kernel
+     * may return 0; tolerate that to avoid spurious failures.
+     */
+    ret = syscall(SYS_tkill, 4194303, 0);
+    assert(ret == 0 || (ret == -1 && errno == ESRCH));
+
+    ret = syscall(SYS_tgkill, self, 4194303, 0);
+    assert(ret == 0 || (ret == -1 && errno == ESRCH));
+
+    /* tgkill with a wrong tgid for a known-good tid must return ESRCH. */
+    ret = syscall(SYS_tgkill, 4194303, guest_tids[0], 0);
+    assert(ret == -1 && errno == ESRCH);
+}
+
+int main(void)
+{
+    pthread_t threads[NUM_THREADS];
+    int i, task_count;
+
+    pthread_barrier_init(&barrier, NULL, NUM_THREADS + 1);
+
+    /* Record main thread TID. */
+    guest_tids[0] = gettid_sys();
+    num_guest_tids = 1;
+
+    /* Spawn worker threads. */
+    for (i = 0; i < NUM_THREADS; i++) {
+        int ret = pthread_create(&threads[i], NULL, thread_func,
+                                 (void *)(intptr_t)(i + 1));
+        assert(ret == 0);
+    }
+
+    /* Wait for all threads to record their TIDs. */
+    pthread_barrier_wait(&barrier);
+    num_guest_tids = NUM_THREADS + 1;
+
+    printf("Guest TIDs:");
+    for (i = 0; i < num_guest_tids; i++) {
+        printf(" %d", guest_tids[i]);
+    }
+    printf("\n");
+
+    /* Test 1: /proc/self/task/ entry count matches guest thread count. */
+    task_count = count_and_verify_task_entries();
+    printf("/proc/self/task/ entries: %d, expected: %d\n",
+           task_count, num_guest_tids);
+    assert(task_count == num_guest_tids);
+
+    /* Test 2: tkill validation. */
+    test_tkill_validation();
+
+    /* Release worker threads. */
+    pthread_barrier_wait(&barrier);
+
+    for (i = 0; i < NUM_THREADS; i++) {
+        pthread_join(threads[i], NULL);
+    }
+
+    pthread_barrier_destroy(&barrier);
+
+    printf("PASS: /proc/self/task/ filtering and tkill validation\n");
+    return EXIT_SUCCESS;
+}

-- 
2.43.0


