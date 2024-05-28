Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45103C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 04:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBoT7-0005lY-Ri; Tue, 28 May 2024 00:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBoT6-0005l7-C3; Tue, 28 May 2024 00:29:48 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBoT4-0003nx-Cf; Tue, 28 May 2024 00:29:48 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2bf8824cd16so303322a91.0; 
 Mon, 27 May 2024 21:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716870584; x=1717475384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ktm7SzllZPbBUSHzdWmoA5HoIOcY67cVV8mFxWyLprw=;
 b=O2vTsTDB4BdlYEYkk/RMkjiDUlZpvSAN19V0a3n1Gr433zOS3BuFGBlhcURydZUmc6
 ryWlrfwHiS4zz5m9vSD0XyIwjwP0xDn/GXIH6wzAxIDbJkA9obaRT+azkoit14590Kz4
 dmozwxkne3dHfi/ySgPqQbd2qbe0D7B/AM06Qt3SV5CbWLH0Sy21W9o5hAGmNjtiX1bp
 QqxUU1wdb8jCXWwNXSlwLm9awnD/BQLoQsFYmxupvqtF2cM48homIzB4OXNTtnjKXhAT
 jHx6m/cwjuiqWS0Kam/MPEjzBbIOtX2rN7cxj8exWnul7mXtLwikoLU+SGwLPcCz1gyB
 D+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716870584; x=1717475384;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ktm7SzllZPbBUSHzdWmoA5HoIOcY67cVV8mFxWyLprw=;
 b=QNEJ/TOagdiO3Wux+4OAC1B6Ugf6QeI6l15gi24P9LEX0z7Eei+tTydEFF+BQ2ctlS
 1W+Tl+1aIr3PBzDYhooEExmZ0KjOA3JT8Ms+ezHA5+T8QgQM+Y+kBfe7NBH0RK/v6NZe
 DkqFx8WM4hFnfXE4Q0IhanrkthCgMbGZ5rk9ztalKJNYPQEUQVf844p5vkXNpjehvV/g
 Vfe5GUGDicxwum/I17h2r3VVWdcEc8tqmEWCLMnVrEASna2lAMJvvjnZkEu7n+OXPtJv
 pDG8i1pE0Scn1RkHH4sj23of3RPEjvytaLJ9mufYOOG3U7TZm4EHTBBt3ySdkxlhsVTW
 u2HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKFiGcU4Wa0VDVs8sKxNerzMmCUwkJ7u5Ccum+s8VKsHXCwksgGhCNsbmv2ouWnDWiiP27Ibw6zBqPji29G1JAq7wW
X-Gm-Message-State: AOJu0YyVE7r8fIMlWTD61ljk4c6eaINMBfD9gxatvUWZTA8FYdYIAhcf
 wfTLC9a+ifHyx/OBfuXwW2Zc/O9ldOcz4TuRZ9EuRgb80sVlpvRxXBRprQ==
X-Google-Smtp-Source: AGHT+IHs45hZClWKe4hQcp7EuIxF77H2RfTIwHf7PpWfB/xBKkMzxUzRvC7Gv8R5JQtDIUezymuL7Q==
X-Received: by 2002:a17:90a:68c7:b0:2bd:e639:686c with SMTP id
 98e67ed59e1d1-2bf5e568830mr10037674a91.23.1716870583912; 
 Mon, 27 May 2024 21:29:43 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bf5f30aa1bsm6678564a91.7.2024.05.27.21.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 21:29:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH] tests/qtest/migrate-test: Use regular file file for
 shared-memory tests
Date: Tue, 28 May 2024 14:27:57 +1000
Message-ID: <20240528042758.621589-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

There is no need to use /dev/shm for file-backed memory devices, and
it is too small to be usable in gitlab CI. Switch to using a regular
file in /tmp/ which will usually have more space available.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Am I missing something? AFAIKS there is not even any point using
/dev/shm aka tmpfs anyway, there is not much special about it as a
filesystem. This applies on top of the series just sent, and passes
gitlab CI qtests including aarch64.

Thanks,
Nick

 tests/qtest/migration-test.c | 41 ++++++++++++------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 45830eb213..86eace354e 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -552,7 +552,7 @@ typedef struct {
      * unconditionally, because it means the user would like to be verbose.
      */
     bool hide_stderr;
-    bool use_shmem;
+    bool use_memfile;
     /* only launch the target process */
     bool only_target;
     /* Use dirty ring if true; dirty logging otherwise */
@@ -672,29 +672,14 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     g_autofree gchar *cmd_source = NULL;
     g_autofree gchar *cmd_target = NULL;
     const gchar *ignore_stderr;
-    g_autofree char *shmem_opts = NULL;
-    g_autofree char *shmem_path = NULL;
+    g_autofree char *memfile_opts = NULL;
+    g_autofree char *memfile_path = NULL;
     const char *kvm_opts = NULL;
     const char *arch = qtest_get_arch();
     const char *memory_size;
     const char *machine_alias, *machine_opts = "";
     g_autofree char *machine = NULL;
 
-    if (args->use_shmem) {
-        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
-            g_test_skip("/dev/shm is not supported");
-            return -1;
-        }
-        if (getenv("GITLAB_CI")) {
-            /*
-             * Gitlab runners are limited to 64MB shm size. See:
-             * https://lore.kernel.org/all/87ttq5fvh7.fsf@suse.de/
-             */
-            g_test_skip("/dev/shm is not supported in Gitlab CI environment");
-            return -1;
-        }
-    }
-
     dst_state = (QTestMigrationState) { };
     src_state = (QTestMigrationState) { };
     bootfile_create(tmpfs, args->suspend_me);
@@ -754,12 +739,12 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         ignore_stderr = "";
     }
 
-    if (args->use_shmem) {
-        shmem_path = g_strdup_printf("/dev/shm/qemu-%d", getpid());
-        shmem_opts = g_strdup_printf(
+    if (args->use_memfile) {
+        memfile_path = g_strdup_printf("/%s/qemu-%d", tmpfs, getpid());
+        memfile_opts = g_strdup_printf(
             "-object memory-backend-file,id=mem0,size=%s"
             ",mem-path=%s,share=on -numa node,memdev=mem0",
-            memory_size, shmem_path);
+            memory_size, memfile_path);
     }
 
     if (args->use_dirty_ring) {
@@ -788,7 +773,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  memory_size, tmpfs,
                                  arch_opts ? arch_opts : "",
                                  arch_source ? arch_source : "",
-                                 shmem_opts ? shmem_opts : "",
+                                 memfile_opts ? memfile_opts : "",
                                  args->opts_source ? args->opts_source : "",
                                  ignore_stderr);
     if (!args->only_target) {
@@ -810,7 +795,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  memory_size, tmpfs, uri,
                                  arch_opts ? arch_opts : "",
                                  arch_target ? arch_target : "",
-                                 shmem_opts ? shmem_opts : "",
+                                 memfile_opts ? memfile_opts : "",
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr);
     *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target);
@@ -822,8 +807,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
      * Remove shmem file immediately to avoid memory leak in test failed case.
      * It's valid because QEMU has already opened this file
      */
-    if (args->use_shmem) {
-        unlink(shmem_path);
+    if (args->use_memfile) {
+        unlink(memfile_path);
     }
 
     return 0;
@@ -1875,7 +1860,7 @@ static void test_ignore_shared(void)
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
     MigrateStart args = {
-        .use_shmem = true,
+        .use_memfile = true,
     };
 
     if (test_migrate_start(&from, &to, uri, &args)) {
@@ -2033,7 +2018,7 @@ static void test_mode_reboot(void)
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
     MigrateCommon args = {
-        .start.use_shmem = true,
+        .start.use_memfile = true,
         .connect_uri = uri,
         .listen_uri = "defer",
         .start_hook = test_mode_reboot_start
-- 
2.43.0


