Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56992606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.a=rsa-sha256 header.s=kylie header.b=uJfGOs5X
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVWH2-00011N-Gs; Mon, 23 Nov 2026 10:48:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <0fd41b04db688dfbe3b3a85d33fe8eace007ba1c@kylie.crudebyte.com>)
 id 1xVWGx-0000w9-PT
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:48:05 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <0fd41b04db688dfbe3b3a85d33fe8eace007ba1c@kylie.crudebyte.com>)
 id 1xVWGu-0005bv-UN
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:48:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=aQ0ofbPpaNdNTkxGux4vQH0VHiRrgslRoL6gcNhlUm4=; b=uJfGO
 s5XQp3qEga3DZVjubOFPcQlVJCv0tcohJwWVcuw+Q/9GfXuE/RHCvQxwG3F2sSaXFOjV642TPH9Vk
 0bjt7Aylhecg91UoOKi3UEMR//XxLmP1Yr2EVkVS6lciJx0Zu9712DD0Qou1C0goPOe6epLD3E5gn
 f9IxT+EY4NqsAHv5TTiKA5wolls7jyAkcKy7PKdIBki34V5ZSV/w0YnOGhVtuZwvj2QhD+HJu6uv2
 jXq2GSgml2e6F9IODuSO8zXsqkI2SZejBKj+hqnXJDRaanStJMW73sNXMrg7TDmCb+YxlxjXQ/mLm
 ar//mBeXy0N2YxRrdg8B0chCR/3wXHJ4f90Bp0Zml2/pHBCKDE21qfUlxffl3r7DZO7VHX8WWvW1H
 k54Lo/l1nDrrBT8EQw6cKlPBSNCuh0Kv5ieedxXpg6jHdp8PisF03iVB/324ISLX3DHUpbYS6WW+F
 55mMdsxVJ+4SUmqrLeAyK2Ys69MbiCDid718QkSLjxrob7CDmkUVP2FL+E8TvkhraLTAnxFmRZYkW
 dTflGQZJ2xHjJJIWr6mfb3OkLpHltgBj3L2icT1ZaeSoGpInZSXAiOwZ0VVSYIEI7GNW3Qf2CFCt4
 abNV647czgMM3vNuorU81lwz1JtDZ0OWP0d9k1K3wEhC1jEsCdVQhG9zv0v95I=;
Message-ID: <0fd41b04db688dfbe3b3a85d33fe8eace007ba1c.1795447869.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1795447869.git.qemu_oss@crudebyte.com>
References: <cover.1795447869.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 23 Nov 2026 16:25:01 +0100
Subject: [PATCH 5/7] tests/unit: add test-9p-internals.c
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=0fd41b04db688dfbe3b3a85d33fe8eace007ba1c@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Add a new 9pfs test-suite that tests 9pfs server-internal
functions, i.e. by calling these server internal functions directly.

This first patch tests the server internal local_open_nofollow()
function of the 9p local backend, specifically that it would abort
the QEMU process upon illegal FID paths being fed to it.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 MAINTAINERS                    |   1 +
 tests/unit/meson.build         |  22 ++++
 tests/unit/test-9p-internals.c | 197 +++++++++++++++++++++++++++++++++
 3 files changed, 220 insertions(+)
 create mode 100644 tests/unit/test-9p-internals.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f4f1ee442..5daea6d6e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2609,6 +2609,7 @@ X: hw/9pfs/xen-9p*
 F: fsdev/
 F: tests/qtest/virtio-9p-test.c
 F: tests/qtest/virtio-9p-race-test.c
+F: tests/unit/test-9p-internals.c
 F: tests/unit/forktest.h
 F: tests/qtest/libqos/virtio-9p*
 T: git https://github.com/cschoenebeck/qemu.git 9p.next
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 37b561d4a7..6e7dd2829a 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -52,6 +52,28 @@ tests = {
   'test-envlist': [],
 }
 
+if have_virtfs
+  tests += {
+    'test-9p-internals': [files('../../hw/9pfs/9p.c',
+                                '../../hw/9pfs/9p-local.c',
+                                '../../hw/9pfs/9p-xattr.c',
+                                '../../hw/9pfs/9p-xattr-user.c',
+                                '../../hw/9pfs/9p-posix-acl.c',
+                                '../../hw/9pfs/' + fs_9p_host_util,
+                                '../../hw/9pfs/9p-util-generic.c',
+                                '../../hw/9pfs/codir.c',
+                                '../../hw/9pfs/cofile.c',
+                                '../../hw/9pfs/cofs.c',
+                                '../../hw/9pfs/coxattr.c',
+                                '../../hw/9pfs/coth.c',
+                                '../../fsdev/9p-marshal.c',
+                                '../../fsdev/9p-iov-marshal.c',
+                                '../../fsdev/qemu-fsdev.c',
+                                '../../hw/9pfs/9p-synth.c',
+                                '../../fsdev/qemu-fsdev-throttle.c')],
+  }
+endif
+
 if have_system or have_tools
   tests += {
     'test-qmp-event': [testqapi],
diff --git a/tests/unit/test-9p-internals.c b/tests/unit/test-9p-internals.c
new file mode 100644
index 0000000000..61c7fc7779
--- /dev/null
+++ b/tests/unit/test-9p-internals.c
@@ -0,0 +1,197 @@
+/*
+ * tests of 9p server's internal functions
+ *
+ * Copyright (c) 2026 Christian Schoenebeck <qemu_oss@crudebyte.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+/*
+ * Not so fast! You might want to read the 9p developer docs first:
+ * https://wiki.qemu.org/Documentation/9p
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "fsdev/file-op-9p.h"
+#include "hw/9pfs/9p-local.h"
+#include "forktest.h"
+#include <stdlib.h>
+
+/* one filesystem entry of this test */
+typedef struct {
+    const char *path;
+    bool is_dir;
+} V9pInternalsFileTreeEntry;
+
+/* the test's filesystem tree */
+static const V9pInternalsFileTreeEntry v9p_internals_file_tree[] = {
+    { "export_root", true },
+    { "export_root/deep_dir", true },
+    { "outside.txt", false },
+    { "export_root/inside.txt", false },
+    { "export_root/...", false },
+    { "export_root/....", false },
+};
+
+/* valid paths expected to be allowed by the test filesystem */
+static const char *v9p_internals_legal_paths[] = {
+    "inside.txt",
+    ".", /* export root */
+    "...",
+    "....",
+};
+
+/* illegal paths expected to cause an abort */
+static const char *v9p_internals_corrupt_paths[] = {
+    /* attempts export root escape via ".." */
+    "deep_dir/../../outside.txt",
+    /* attempts export root escape via absolute path */
+    "/outside.txt",
+    /* empty path component (openat(fd, "")) */
+    "deep_dir//outside.txt",
+    /* trailing slash (openat(fd, "")) */
+    "deep_dir/",
+    /* empty path (openat(fd, "")) */
+    "",
+};
+
+/* shared test-suite state */
+typedef struct {
+    LocalData localdata;
+    FsContext ctx;
+    char *test_dir;
+} V9pInternalsState;
+
+/* create the tmp directory for the test's filesystem tree */
+static char *v9p_internals_create_test_dir(void)
+{
+    char *test_dir = g_dir_make_tmp("9p-internals-XXXXXX", NULL);
+
+    g_assert_nonnull(test_dir);
+    return test_dir;
+}
+
+/* create regular file in the test filesystem */
+static void v9p_internals_create_file(const char *path)
+{
+    int fd = open(path, O_RDWR | O_CREAT | O_TRUNC, 0644);
+
+    g_assert_cmpint(fd, !=, -1);
+    g_assert_cmpint(close(fd), ==, 0);
+}
+
+/* create the filesystem tree for this test */
+static void v9p_internals_create_tree(const char *base)
+{
+    size_t i;
+
+    for (i = 0; i < ARRAY_SIZE(v9p_internals_file_tree); i++) {
+        const V9pInternalsFileTreeEntry *e = &v9p_internals_file_tree[i];
+        g_autofree char *path = g_build_filename(base, e->path, NULL);
+
+        if (e->is_dir) {
+            g_assert_cmpint(g_mkdir_with_parents(path, 0755), ==, 0);
+        } else {
+            v9p_internals_create_file(path);
+        }
+    }
+}
+
+/* prepare to run next test case */
+static void *v9p_internals_setup(void)
+{
+    V9pInternalsState *s = g_new0(V9pInternalsState, 1);
+    g_autofree char *export_root;
+
+    s->test_dir = v9p_internals_create_test_dir();
+    v9p_internals_create_tree(s->test_dir);
+    export_root = g_build_filename(s->test_dir, "export_root", NULL);
+    s->localdata.mountfd = open(export_root, O_RDONLY | O_DIRECTORY);
+    g_assert_cmpint(s->localdata.mountfd, !=, -1);
+    s->ctx.private = &s->localdata;
+    return s;
+}
+
+/* cleanup after running test case */
+static void v9p_internals_teardown(void *data)
+{
+    V9pInternalsState *s = data;
+    g_autofree char *cmd = g_strdup_printf("rm -fr '%s'\n", s->test_dir);
+    int res;
+
+    close(s->localdata.mountfd);
+    res = system(cmd);
+    if (res < 0) {
+        /* ignore any error */
+    }
+    g_free(s->test_dir);
+    g_free(s);
+}
+
+static const ForkTestEnv v9p_internals_env = {
+    .setup_fn = v9p_internals_setup,
+    .teardown_fn = v9p_internals_teardown,
+};
+
+static void v9p_internals_local_open_nofollow_legal_paths(void *data)
+{
+    V9pInternalsState *s = data;
+    size_t i;
+    int fd;
+
+    for (i = 0; i < ARRAY_SIZE(v9p_internals_legal_paths); i++) {
+        const char *path = v9p_internals_legal_paths[i];
+
+        fd = local_open_nofollow(&s->ctx, path, O_RDONLY, 0);
+        g_assert_cmpint(fd, !=, -1);
+        close(fd);
+    }
+}
+
+typedef struct {
+    FsContext *ctx;
+    const char *path;
+} V9pInternalsPathCase;
+
+static void v9p_internals_check_corrupt_path(void *opaque)
+{
+    V9pInternalsPathCase *c = opaque;
+
+    local_open_nofollow(c->ctx, c->path, O_RDONLY, 0);
+    forktest_exit(FORKTEST_EXIT_SURVIVED);
+}
+
+static void v9p_internals_local_open_nofollow_corrupt_paths(void *data)
+{
+    V9pInternalsState *s = data;
+    size_t i;
+
+    for (i = 0; i < ARRAY_SIZE(v9p_internals_corrupt_paths); i++) {
+        const char *path = v9p_internals_corrupt_paths[i];
+        V9pInternalsPathCase c = {
+            .ctx = &s->ctx,
+            .path = path,
+        };
+
+        forktest_run((ForkTest) {
+            .child_fn = v9p_internals_check_corrupt_path,
+            .opaque = &c,
+            .expect_abort = true,
+            .name = path,
+        });
+    }
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    forktest_add("/9p-internals/local_open_nofollow/legal-paths",
+                 v9p_internals_local_open_nofollow_legal_paths,
+                 &v9p_internals_env);
+    forktest_add("/9p-internals/local_open_nofollow/corrupt-paths",
+                 v9p_internals_local_open_nofollow_corrupt_paths,
+                 &v9p_internals_env);
+    return g_test_run();
+}
-- 
2.47.3


