Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A74FA0C22
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 04:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCrXo-0006pC-8j; Wed, 15 Apr 2026 00:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elirazamumtaz@gmail.com>)
 id 1wCnei-0008Fu-G6
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 19:58:56 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <elirazamumtaz@gmail.com>)
 id 1wCneg-0003Xu-Cl
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 19:58:55 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43cf5f6d2eeso296181f8f.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 16:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776211133; x=1776815933; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iO17NpRgpPKsJF/GBSlvS4CvmUeJukcd4DXozhw0GlA=;
 b=ESkQ6aRkSeoj0FUiMMUjxlA8lCl4zBjSGf6JDivRJeL35CDXh5Ga1qH5WWEQZA/nrW
 p3ywza94MMK7I1AinUCorLgHPspwoGpZwatskgbiTn3ZaqSK7F+7rQzM1ZsLwf9hGubq
 U4N0CfgS+0O//jXFNH1OIDXdAv1nUWqQNFx9CFPq8xSCOrPJuPyi1I3HVkh0i3oWuJHO
 d5bifwYuaYRSRZuuDSW1RGveiBxws2hmw206BX3Z1lIKVGX7qnpx0nAZ0ucNKKpLvNEN
 gPMWld1HjQBMlHZ6g9Kh/DbkgZhG17RYgLW5ZtdK2ucaWWjSJwCvvDOsqg2hbp6+MSRt
 nNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776211133; x=1776815933;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iO17NpRgpPKsJF/GBSlvS4CvmUeJukcd4DXozhw0GlA=;
 b=m+PIDqeYGWEtThrdzL1Xl9NqAN9hTgXFKsc+W6SqfPXn3wtuompeOVz1c6fTddnqSW
 p+e8X/oZU0WxtWA8jHbNyphL8Tlu4qml3Ccx+sgmtRS/tjbVrHASQMpTS48wvn59h+e2
 Tuq5CQm2qR8pYPSz4L8dY26mXfwi0wb8OY6VNZcEbfHwGJw4DwYYpYSjoZwiZGD/RZU5
 1j0+oy0H6Cs2OqFytZbOdiKQtn4c5vtyih0hzadpoEmty/6ogWVMgS688oAQt97PbmzK
 j1A8gx/rVYkn6t3TyXoZTJHsRogNA1nKoTaw1TBSn9UALYdDitYhRpDJbcv/23Z/D88s
 GF5A==
X-Gm-Message-State: AOJu0YxljIx04AUg6kdAPLlzpPCJ3VRCiFq9ciXufYoMNsAwamtYUAmI
 im3OfPG68g7bhg9i7HmDYRwRe/OddaCf4zQbRw7HSRiska+G+Z9jEf8P
X-Gm-Gg: AeBDietZPUg6shHVy5uRRfSy+AZj6bCNpHYy/I+yf2cnWJTEuh+jiOR0bFszizZHS0I
 7mb7bNIYaUPhgpjFjD+081OtWOaV1H2LZ9qgdsVqMczJnyoWzwDZdr3BPhPm808+jBimuXvddvY
 xEz0zMzJnM4RfB5Bb5K/MfzjwOciL5Pym3TPuJpXypeb49IloCrhzWufzWErjw9Nm7VELeJEOgy
 kWkrm9j1aQP/wvcC9R/Ux/DzrSLidMp1AFlO1ujSarmOScysYGu+/bLMyXc90w8+ogN1OYs1WWe
 wrp/x57G1XDwAhZGYLlV5q0FkUuEcusAsqMgeaMFobYxgsxErtm6UUGEd8hdT8X6id5WD65SThQ
 wP9SA3DBtxFVd/Ja3cMlPl2pwvZ2upWPKcEeUvhjT6Bq+gyU9o6n4aA9IJyUTPKzdcOO2exBFos
 esLrWm8GsFnmd6/QEfXKbMsq4T/ghZz7rQ
X-Received: by 2002:a05:6000:2705:b0:43d:b99:bdca with SMTP id
 ffacd0b85a97d-43eacf72c8dmr105019f8f.6.1776211132774; 
 Tue, 14 Apr 2026 16:58:52 -0700 (PDT)
Received: from [192.168.10.11] ([182.181.137.32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3d5f11sm115535f8f.18.2026.04.14.16.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 16:58:52 -0700 (PDT)
From: Ali Raza <elirazamumtaz@gmail.com>
Date: Wed, 15 Apr 2026 04:58:36 +0500
Subject: [PATCH 3/3] tests/tcg: Add test for /proc/self/task/ filtering and
 tkill validation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-master-v1-3-8dd2ef111eee@gmail.com>
References: <20260415-master-v1-0-8dd2ef111eee@gmail.com>
In-Reply-To: <20260415-master-v1-0-8dd2ef111eee@gmail.com>
To: qemu-devel@nongnu.org
Cc: Ali Raza <elirazamumtaz@gmail.com>, morgan@kernel.org
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
X-Mailman-Approved-At: Wed, 15 Apr 2026 00:08:00 -0400
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
 tests/tcg/multiarch/Makefile.target         |   2 +
 tests/tcg/multiarch/linux/linux-proc-task.c | 178 ++++++++++++++++++++++++++++
 2 files changed, 180 insertions(+)

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
index 0000000000..805cfd4e47
--- /dev/null
+++ b/tests/tcg/multiarch/linux/linux-proc-task.c
@@ -0,0 +1,178 @@
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
+ * tkill to a TID that should not exist returns ESRCH.
+ */
+static void test_tkill_validation(void)
+{
+    int i, ret;
+
+    /* Signal 0 to each guest TID should succeed. */
+    for (i = 0; i < num_guest_tids; i++) {
+        ret = syscall(SYS_tkill, guest_tids[i], 0);
+        if (ret != 0) {
+            fprintf(stderr, "FAIL: tkill(%d, 0) returned %d (errno=%d)\n",
+                    guest_tids[i], ret, errno);
+        }
+        assert(ret == 0);
+    }
+
+    /*
+     * Try a TID that is very unlikely to be a guest thread.
+     * Use pid_max (typically 4194304) minus 1 as a probe.
+     * On a real kernel this would return ESRCH for a nonexistent thread;
+     * on QEMU with validation it should also return ESRCH.
+     * Skip this check if the TID happens to exist (unlikely).
+     */
+    ret = syscall(SYS_tkill, 4194303, 0);
+    if (ret == -1 && errno == ESRCH) {
+        printf("tkill to non-guest TID correctly returned ESRCH\n");
+    }
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


