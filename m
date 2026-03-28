Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722D510F3DE2
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2026 12:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6SWv-0000MF-LU; Sat, 28 Mar 2026 08:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w6SWf-0000Kt-W9
 for qemu-devel@nongnu.org; Sat, 28 Mar 2026 08:12:26 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w6SWe-00022n-3l
 for qemu-devel@nongnu.org; Sat, 28 Mar 2026 08:12:25 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-35d9749c26dso248578a91.2
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2026 05:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774699942; x=1775304742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P94kZ6gNvJnQQgGZCSXhoFOZYrayE3/o+VsQAx7U6uA=;
 b=ZRE+Dp6Bo3CD0/0wxNCLGBceW6FupFTpS/iQ91JfOiPMzN6rnmTGs9fz59r/RnS1Sl
 nNUEgejWNB1WbC5brfmtHMhyNnBlOArUReOq1SrkgrCRcDQjnZzrv0oUje2JT2LSrxRC
 bd2z1zCaKw9j3AYQ1fKAJkLUwUaUWgQ/C7yI4kQstYjbTt+kf+SwTT0Tu4GrWwn3tsOS
 ajg7rJJRRpEZHRJd3h123mU0ocEw9CQxgxjVJa4nmNa081sfg3e3zDyynfQQZlckd31o
 jSb/ooPTI2ctsb3xk+stvCap45whYsQJMMLwWyOpe+ltw1GZo3NRqnRATDck/HZbDsp6
 KRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774699942; x=1775304742;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P94kZ6gNvJnQQgGZCSXhoFOZYrayE3/o+VsQAx7U6uA=;
 b=W/hEWuOSO9gX9bugGI4pGM8ryh5pqrSzSZx6gLbct2WkvsZ7D1FUOixdw0meabIwq5
 ak6ruyS8Ya5a9k5zF5JqQUVtguAAEbVeP3hWJwy8gfCILspUyVq4o0GJmSNIUsAmxLGn
 oVyi6dVUflSWVYQ/bsgAgB4CWiqcsV4OgJFtONKOyOsi26A9E+3Clm/7g9YRhcC+QobN
 OlOuOjB891xoOA8NtIcOArQ3xd8y0sxKwIYwkQqr/oIhM+KxU1JageQ/W3gfcvNaQO3o
 uxxI5M9jC+ttJ/mspPAmSgpqAfN/HDZaOAUqEwmrO34vbrI5uaquGrWCddaNaLFEt9g8
 Hukg==
X-Gm-Message-State: AOJu0YyMrDEyqA0B7q56JfsWKjp3zYX5z+veYvhFZrSJXYQIooJu11gH
 rAWU2SgUNo6zmE1WTjvqLAsVUNEp9UTAciwhbhF3eVBOFgMI01N4jjBXmakZJGer
X-Gm-Gg: ATEYQzwP1E92CLI6MyBrZaNqsktee2cFxpPUnyTTKhkHT/EUv1dMTKoGJBSGRM630CU
 9zxM//KC96QlCh2QCbRAEQTwlz/m0H2GhPO+xVYLc1p73jxJ1DvZ5NLFeOf2ZaezCPwfaiLJkeV
 HGwvGrIqLuc9lvL/AoRRIs58jvnnvWe9rkCSXLyDzQnHSiEIonAOUaaRwDpyURF22wGqDIIDPZq
 L/A2RQa9jRsa93u/ZzotFYrZP8wkg0CXJij/27RExXhKQKg1ujihuIIDjhaB239Lmakru0gsruT
 nnQyeu3PJObw4Oqe1HorCMIoB6S+AxSP+U4zyW9irjyAr3hl2S8RYjhr3S79Lzr48VuLp4VoKd5
 hAxycwpx9p+UD46SKTmdAkXLwcFKrWU+Gp2SJrah+We+wCuB8ijjHp08zWasIx4AHnicssRLLau
 mtYVmkmp6JZe4tqYU3Oxa9M9NYc+PkEGDJbgv9xepENn/jgzsTLlkGyIkTlcx4hmDgrOK975MN/
 97pHIFToXzZ3a3tWbY5
X-Received: by 2002:a17:90a:d44c:b0:35b:e844:3bf with SMTP id
 98e67ed59e1d1-35c300bec56mr5848803a91.29.1774699941747; 
 Sat, 28 Mar 2026 05:12:21 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local
 ([27.122.242.65]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35d94d289f5sm2611535a91.5.2026.03.28.05.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 05:12:21 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] migration: fix QIOChannelFile leak on error in
 file_connect_outgoing
Date: Sat, 28 Mar 2026 21:12:14 +0900
Message-ID: <20260328121215.159532-1-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=vikingtc4@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Commit 03a680c978 changed g_autoptr(QIOChannelFile) to a plain pointer
but failed to restore the necessary object_unref() calls on error paths.
Previously, these were handled implicitly by the g_autoptr cleanup
mechanism.

Two error paths currently leak the QIOChannelFile object and its
underlying file descriptor:

  1. When ftruncate() fails (e.g., on character or block devices).
  2. When qio_channel_io_seek() fails after the channel is created.

In environments that retry migration automatically (e.g., libvirt),
these FDs accumulate until QEMU hits RLIMIT_NOFILE and fails with
EMFILE (Too many open files).

Add the missing object_unref() calls to both error paths to ensure
resources are properly released.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 migration/file.c                   |  2 ++
 tests/qtest/migration/file-tests.c | 48 ++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/migration/file.c b/migration/file.c
index 5618aced49..962b4b3a1b 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -112,6 +112,7 @@ QIOChannel *file_connect_outgoing(MigrationState *s,
         error_setg_errno(errp, errno,
                          "failed to truncate migration file to offset %" PRIx64,
                          offset);
+        object_unref(OBJECT(fioc));
         goto out;
     }
 
@@ -119,6 +120,7 @@ QIOChannel *file_connect_outgoing(MigrationState *s,
 
     ioc = QIO_CHANNEL(fioc);
     if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
+        object_unref(OBJECT(fioc));
         ioc = NULL;
         goto out;
     }
diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index 5d1b861cf6..fef172068f 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -20,6 +20,51 @@
 
 static char *tmpfs;
 
+static int count_proc_fds(pid_t pid)
+{
+    g_autofree char *fddir = g_strdup_printf("/proc/%d/fd", (int)pid);
+    GDir *dir = g_dir_open(fddir, 0, NULL);
+    int count = 0;
+
+    if (!dir) {
+        return -1;
+    }
+    while (g_dir_read_name(dir)) {
+        count++;
+    }
+    g_dir_close(dir);
+    return count;
+}
+
+static void test_file_connect_outgoing_fd_leak(char *name, MigrateCommon *args)
+{
+    QTestState *from, *to;
+    int fd_before, fd_after;
+    const int retries = 5;
+    int i;
+    if (!g_file_test("/dev/full", G_FILE_TEST_EXISTS)) {
+        g_test_skip("/dev/full not available");
+        return;
+    }
+
+    args->listen_uri = "defer";
+    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
+        return;
+    }
+
+    fd_before = count_proc_fds(qtest_pid(from));
+    g_assert_cmpint(fd_before, >, 0);
+    for (i = 0; i < retries; i++) {
+        migrate_qmp_fail(from, "file:/dev/full", NULL, "{}");
+        migration_event_wait(from, "failed");
+    }
+
+    fd_after = count_proc_fds(qtest_pid(from));
+    g_assert_cmpint(fd_after, >, 0);
+    g_assert_cmpint(fd_after, ==, fd_before);
+    migrate_end(from, to, false);
+}
+
 static void test_precopy_file(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
@@ -314,6 +359,9 @@ void migration_test_add_file(MigrationTestEnv *env)
     migration_test_add("/migration/precopy/file/offset/bad",
                        test_precopy_file_offset_bad);
 
+    migration_test_add("/migration/precopy/file/connect-outgoing-fd-leak",
+                       test_file_connect_outgoing_fd_leak);
+
     migration_test_add("/migration/precopy/file/mapped-ram",
                        test_precopy_file_mapped_ram);
     migration_test_add("/migration/precopy/file/mapped-ram/live",
-- 
2.43.0


