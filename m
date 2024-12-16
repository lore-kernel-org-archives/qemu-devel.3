Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B5EE77186
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 14:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNBwO-0004MZ-Tb; Mon, 16 Dec 2024 09:19:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tNBwI-0004Ek-5D
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:19:14 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tNBwC-0000Do-As
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:19:13 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-728ea1e0bdbso3142687b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 06:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734358746; x=1734963546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kbeCxXsp2YfolLUVna933Z0x0ot4sPvr4NnCfzB4h0=;
 b=ogIYuIQn4hyKoEaSMpJIg7zjyE8H170XMw0d5+fLbcOVTvGcsfq8ydEP3Ne+aZH4sw
 8nDNgVjiGCcF1hU0o3fIkHPu67YhBIfZd6qu77ep6FS+ZVERLXfVsDisjrq9p/6szNBo
 g+yqmcMhGiu0QOkGCSClcKhdfMjlFJao+DhFvZkP+oTrVqXFZ1ORPnvbgU+kvAJMmUts
 CREibkN9z+XByjGOl9TKGYAO2GMxzLImWZH/0//u89L+DVzmKa6+q8bDRCvEsmfdWug+
 Z2Hg68veMbIYp3b8PYkjvR5K+YAWF9cd9Sfzs6KlrF+P4SftFhqJDI3Iq8PCzwGj017I
 xWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734358746; x=1734963546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+kbeCxXsp2YfolLUVna933Z0x0ot4sPvr4NnCfzB4h0=;
 b=m+3RwyjiKJUG0TUDYt+T1+6jPfS4iveOVcwcOGw0HCXjC/lFjH9lru+uOoMZkf3H+y
 tDK7hGkyAC9cLsQ1sb5CN4N79UCpKZ8dk5QCjArY2TkUDWblDUqRtTs+ofY5wIBi3Irp
 IYYS3NXQYL1pRNrbScJFqY57NH/vLzyZP/N1WrtlynLo/AqklZKj4qxjdXL6W3XenkLD
 qTLmzhUUOf4SZh3yIhPeLEu3uGGX4cpQK2At5U6Dc0STHqGW1C1dn8lgxTfYOhIqS4ar
 8cIizV4ZgzgvHX4KScXPGg4Ry1NodbSs5F+135Jtr4tbQrTUlaCNfo22ozbWpzb+29Db
 CU/g==
X-Gm-Message-State: AOJu0YzAYkn0wP/LL4t2Lx+L3lptjFDeU+eKdS5YNZrVML3fkCzpwWdS
 gOpb0sdvl+Hb6o2zCebRD6kp7kyJLiQVKW0N353jbMgvWKZVFpAUY9FUOaGFQclqJsfMqlRQcY2
 0
X-Gm-Gg: ASbGncsGR8qI9lfdFGBkEOIc36z2pW3+YslAfwo3ODpcrK9JuPcfx5pMF079hpZcVtM
 EN/kss39soqtpDNkeukD+5BH0ucRi5P/XFoaHkNKShYQ/YWbD8oDXxr2oLpf3uYmXtO3poYPy7p
 +ej4tlSEz74gL1vVXhxtu59bXZT3TvkCvkfnmu9ZRqdWEX79GMLeQVNsJtzdgdDwMnh86jT4/qN
 gmuSKEHRuuehci/BQD9Llo1hQBF7TOGvifVsb1LLrXLJGdoZz0OkiERBG2ZP3Q=
X-Google-Smtp-Source: AGHT+IE1Y03JFJtLtujYIY034aFgO+B6A64qf2TGdWFj2UivboS+OXCawj+omYooIRMBTdfmyAcAgw==
X-Received: by 2002:a05:6a21:8905:b0:1e2:2e4:6b2a with SMTP id
 adf61e73a8af0-1e202e4efa4mr9206859637.5.1734358746447; 
 Mon, 16 Dec 2024 06:19:06 -0800 (PST)
Received: from gromero0.. ([177.189.100.90]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918bad8acsm4948815b3a.146.2024.12.16.06.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 06:19:05 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, philmd@linaro.org,
 alex.bennee@linaro.org, thuth@redhat.com, armbru@redhat.com
Cc: gustavo.romero@linaro.org
Subject: [PATCH v3 5/7] tests/qtest: Reorganize common code in ivshmem-test
Date: Mon, 16 Dec 2024 14:18:16 +0000
Message-Id: <20241216141818.111255-6-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216141818.111255-1-gustavo.romero@linaro.org>
References: <20241216141818.111255-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This commit reorganizes the ivshmem-test qtest by moving common structs,
functions, and code that can be utilized by other ivshmem qtests into
two new files: ivshmem-utils.h and ivshmem-utils.c.

Enum Reg, struct ServerThread, and mktempshm() have been relocated to
these new files. Two new functions have been introduced to handle the
ivshmem server start/stop: test_ivshmem_server_{start,stop}.

To accommodate the new way for starting/stopping the ivshmem server,
struct ServerThread now includes two new members: 'server', previously
present but not a member of any struct; and 'status', a new member of a
new type, ServerStartStatus, used to track and handle service
termination properly.

Additionally, a new function, mktempsocket(), has been added to help
create a unix socket filename, similar to what mktempshm() does for the
creation of a shm file.

Finally, the ivshmem-test qtest has been adapted to use the new ivhsmem
utils. Adjustments in that sense have also been made to meson.build;
also 'rt' have been removed as a lib dependency for ivhsmem-test.c.

Two lines unrelated to these changes have had their line indentation
also fixed in meson.build.

Message-ID: <20231127052024.435743-3-gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/qtest/ivshmem-test.c  | 113 ++------------------------
 tests/qtest/ivshmem-utils.c | 156 ++++++++++++++++++++++++++++++++++++
 tests/qtest/ivshmem-utils.h |  56 +++++++++++++
 tests/qtest/meson.build     |   4 +-
 4 files changed, 221 insertions(+), 108 deletions(-)
 create mode 100644 tests/qtest/ivshmem-utils.c
 create mode 100644 tests/qtest/ivshmem-utils.h

diff --git a/tests/qtest/ivshmem-test.c b/tests/qtest/ivshmem-test.c
index fb45fdeb07..d4443b46f2 100644
--- a/tests/qtest/ivshmem-test.c
+++ b/tests/qtest/ivshmem-test.c
@@ -3,17 +3,17 @@
  *
  * Copyright (c) 2014 SUSE LINUX Products GmbH
  * Copyright (c) 2015 Red Hat, Inc.
+ * Copyright (c) 2023 Linaro Ltd.
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
 
-#include "qemu/osdep.h"
-#include <glib/gstdio.h>
-#include "contrib/ivshmem-server/ivshmem-server.h"
+#include "ivshmem-utils.h"
 #include "libqos/libqos-pc.h"
 #include "libqos/libqos-spapr.h"
-#include "libqtest.h"
+
+static ServerThread thread;
 
 #define TMPSHMSIZE (1 << 20)
 static char *tmpshm;
@@ -45,13 +45,6 @@ typedef struct _IVState {
     QPCIDevice *dev;
 } IVState;
 
-enum Reg {
-    INTRMASK = 0,
-    INTRSTATUS = 4,
-    IVPOSITION = 8,
-    DOORBELL = 12,
-};
-
 static const char* reg2str(enum Reg reg) {
     switch (reg) {
     case INTRMASK:
@@ -241,54 +234,6 @@ static void test_ivshmem_pair(void)
     g_free(data);
 }
 
-typedef struct ServerThread {
-    GThread *thread;
-    IvshmemServer *server;
-    int pipe[2]; /* to handle quit */
-} ServerThread;
-
-static void *server_thread(void *data)
-{
-    ServerThread *t = data;
-    IvshmemServer *server = t->server;
-
-    while (true) {
-        fd_set fds;
-        int maxfd, ret;
-
-        FD_ZERO(&fds);
-        FD_SET(t->pipe[0], &fds);
-        maxfd = t->pipe[0] + 1;
-
-        ivshmem_server_get_fds(server, &fds, &maxfd);
-
-        ret = select(maxfd, &fds, NULL, NULL, NULL);
-
-        if (ret < 0) {
-            if (errno == EINTR) {
-                continue;
-            }
-
-            g_critical("select error: %s\n", strerror(errno));
-            break;
-        }
-        if (ret == 0) {
-            continue;
-        }
-
-        if (FD_ISSET(t->pipe[0], &fds)) {
-            break;
-        }
-
-        if (ivshmem_server_handle_fds(server, &fds, maxfd) < 0) {
-            g_critical("ivshmem_server_handle_fds() failed\n");
-            break;
-        }
-    }
-
-    return NULL;
-}
-
 static void setup_vm_with_server(IVState *s, int nvectors)
 {
     char *cmd;
@@ -304,27 +249,12 @@ static void setup_vm_with_server(IVState *s, int nvectors)
 
 static void test_ivshmem_server(void)
 {
-    g_autoptr(GError) err = NULL;
     IVState state1, state2, *s1, *s2;
-    ServerThread thread;
-    IvshmemServer server;
     int ret, vm1, vm2;
     int nvectors = 2;
     guint64 end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
 
-    ret = ivshmem_server_init(&server, tmpserver, tmpshm, true,
-                              TMPSHMSIZE, nvectors,
-                              g_test_verbose());
-    g_assert_cmpint(ret, ==, 0);
-
-    ret = ivshmem_server_start(&server);
-    g_assert_cmpint(ret, ==, 0);
-
-    thread.server = &server;
-    g_unix_open_pipe(thread.pipe, FD_CLOEXEC, &err);
-    g_assert_no_error(err);
-    thread.thread = g_thread_new("ivshmem-server", server_thread, &thread);
-    g_assert(thread.thread != NULL);
+    test_ivshmem_server_start(&thread, tmpserver, tmpshm, nvectors);
 
     setup_vm_with_server(&state1, nvectors);
     s1 = &state1;
@@ -367,15 +297,7 @@ static void test_ivshmem_server(void)
     cleanup_vm(s2);
     cleanup_vm(s1);
 
-    if (qemu_write_full(thread.pipe[1], "q", 1) != 1) {
-        g_error("qemu_write_full: %s", g_strerror(errno));
-    }
-
-    g_thread_join(thread.thread);
-
-    ivshmem_server_close(&server);
-    close(thread.pipe[1]);
-    close(thread.pipe[0]);
+    test_ivshmem_server_stop(&thread);
 }
 
 static void test_ivshmem_hotplug_q35(void)
@@ -454,31 +376,10 @@ static void cleanup(void)
 
 static void abrt_handler(void *data)
 {
+    test_ivshmem_server_stop(&thread);
     cleanup();
 }
 
-static gchar *mktempshm(int size, int *fd)
-{
-    while (true) {
-        gchar *name;
-
-        name = g_strdup_printf("/qtest-%u-%u", getpid(), g_test_rand_int());
-        *fd = shm_open(name, O_CREAT|O_RDWR|O_EXCL,
-                       S_IRWXU|S_IRWXG|S_IRWXO);
-        if (*fd > 0) {
-            g_assert(ftruncate(*fd, size) == 0);
-            return name;
-        }
-
-        g_free(name);
-
-        if (errno != EEXIST) {
-            perror("shm_open");
-            return NULL;
-        }
-    }
-}
-
 int main(int argc, char **argv)
 {
     int ret, fd;
diff --git a/tests/qtest/ivshmem-utils.c b/tests/qtest/ivshmem-utils.c
new file mode 100644
index 0000000000..c2fc3463dd
--- /dev/null
+++ b/tests/qtest/ivshmem-utils.c
@@ -0,0 +1,156 @@
+/*
+ * Common utilities for testing ivshmem devices
+ *
+ * SPDX-FileCopyrightText: 2012 SUSE LINUX Products GmbH
+ * SPDX-FileCopyrightText: 2021 Red Hat, Inc.
+ * SPDX-FileCopyrightText: 2023 Linaro Ltd.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "ivshmem-utils.h"
+
+gchar *mktempshm(int size, int *fd)
+{
+    while (true) {
+        /* Relative path to the shm filesystem, e.g. '/dev/shm'. */
+        gchar *shm_rel_path;
+
+        shm_rel_path = g_strdup_printf("/ivshmem_qtest-%u-%u", getpid(),
+                                       g_test_rand_int());
+        *fd = shm_open(shm_rel_path, O_CREAT | O_RDWR | O_EXCL,
+                       S_IRWXU | S_IRWXG | S_IRWXO);
+        if (*fd > 0) {
+            g_assert(ftruncate(*fd, size) == 0);
+            return shm_rel_path;
+        }
+
+        g_free(shm_rel_path);
+
+        if (errno != EEXIST) {
+            perror("shm_open");
+            return NULL;
+        }
+    }
+}
+
+gchar *mktempsocket(void)
+{
+    gchar *server_socket_path;
+
+    server_socket_path = g_strdup_printf("%s/ivshmem_socket_qtest-%u-%u",
+                                         g_get_tmp_dir(), getpid(),
+                                         g_test_rand_int());
+    return server_socket_path;
+}
+
+static void *server_thread(void *data)
+{
+    ServerThread *t = data;
+    IvshmemServer *server = &t->server;
+
+    while (true) {
+        fd_set fds;
+        int maxfd, ret;
+
+        FD_ZERO(&fds);
+        FD_SET(t->pipe[0], &fds);
+        maxfd = t->pipe[0] + 1;
+
+        ivshmem_server_get_fds(server, &fds, &maxfd);
+
+        ret = select(maxfd, &fds, NULL, NULL, NULL);
+
+        if (ret < 0) {
+            if (errno == EINTR) {
+                continue;
+            }
+
+            g_critical("select error: %s\n", strerror(errno));
+            break;
+        }
+        if (ret == 0) {
+            continue;
+        }
+
+        if (FD_ISSET(t->pipe[0], &fds)) {
+            break;
+        }
+
+        if (ivshmem_server_handle_fds(server, &fds, maxfd) < 0) {
+            g_critical("ivshmem_server_handle_fds() failed\n");
+            break;
+        }
+    }
+
+    return NULL;
+}
+
+void test_ivshmem_server_start(ServerThread *thread,
+                               const char *server_socket_path,
+                               const char *shm_rel_path, unsigned num_vectors)
+{
+    g_autoptr(GError) err = NULL;
+    int ret;
+    struct stat shm_st;
+    char *shm_path;
+
+    g_assert(thread != NULL);
+    g_assert(server_socket_path != NULL);
+    g_assert_cmpint(num_vectors, >, 0);
+    g_assert(shm_rel_path != NULL);
+
+    /*
+     * Find out shm size. shm_open() deals with relative paths but stat() needs
+     * the full path to the shm file.
+     */
+    shm_path = g_strdup_printf("/dev/shm%s", shm_rel_path);
+    ret = stat(shm_path, &shm_st);
+    g_assert_cmpint(ret, ==, 0);
+    g_assert_cmpint(shm_st.st_size, >, 0);
+
+    ret = ivshmem_server_init(&thread->server, server_socket_path, shm_rel_path,
+    true, shm_st.st_size, num_vectors, g_test_verbose());
+    g_assert_cmpint(ret, ==, 0);
+    ret = ivshmem_server_start(&thread->server);
+    g_assert_cmpint(ret, ==, 0);
+    thread->status = SERVER;
+
+    g_unix_open_pipe(thread->pipe, FD_CLOEXEC, &err);
+    g_assert_no_error(err);
+    thread->status |= PIPE;
+
+    thread->thread = g_thread_new("ivshmem-server", server_thread, thread);
+    g_assert(thread->thread != NULL);
+    thread->status |= THREAD;
+}
+
+void test_ivshmem_server_stop(ServerThread *thread)
+{
+    /*
+     * This function can be called any time on a test error/abort (e.g., it can
+     * be called from the abort handler), including from the
+     * test_ivshmem_server_start(). Therefore, the start steps (server started,
+     * pipe created, and thread created) are tracked when the server starts and
+     * then checked below accordingly for proper termination.
+     */
+
+    if (thread->status & THREAD) {
+        /* Ask to exit from thread. */
+        if (qemu_write_full(thread->pipe[1], "q", 1) != 1) {
+            g_error("qemu_write_full: %s", g_strerror(errno));
+        }
+
+        /* Wait thread to exit. */
+        g_thread_join(thread->thread);
+     }
+
+    if (thread->status & PIPE)  {
+        close(thread->pipe[1]);
+        close(thread->pipe[0]);
+    }
+
+    if (thread->status & SERVER) {
+        ivshmem_server_close(&thread->server);
+    }
+}
diff --git a/tests/qtest/ivshmem-utils.h b/tests/qtest/ivshmem-utils.h
new file mode 100644
index 0000000000..c43661caac
--- /dev/null
+++ b/tests/qtest/ivshmem-utils.h
@@ -0,0 +1,56 @@
+/*
+ * Common utilities for testing ivshmem devices
+ *
+ * SPDX-FileCopyrightText: 2012 SUSE LINUX Products GmbH
+ * SPDX-FileCopyrightText: 2021 Red Hat, Inc.
+ * SPDX-FileCopyrightText: 2023 Linaro Ltd.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef QTEST_IVSHMEM_UTILS_H
+#define QTEST_IVSHMEM_UTILS_H
+
+#include "qemu/osdep.h"
+#include <glib/gstdio.h>
+#include "contrib/ivshmem-server/ivshmem-server.h"
+#include "libqtest.h"
+
+enum Reg {
+    INTRMASK = 0,
+    INTRSTATUS = 4,
+    IVPOSITION = 8,
+    DOORBELL = 12,
+};
+
+enum ServerStartStatus {
+    SERVER = 1, /* Ivshmem server started */
+    THREAD = 2, /* Thread for monitoring fds created */
+    PIPE = 4,   /* Pipe created */
+};
+
+typedef struct ServerThread {
+    GThread *thread;
+    IvshmemServer server;
+    /*
+     * Pipe is used to communicate with the thread, asking it to terminate on
+     * receiving 'q'.
+     */
+    int pipe[2];
+    /*
+     * Server statuses are used to keep track of thread/server/pipe start since
+     * test_ivshmem_server_stop can be called at any time on a test error,
+     * even from test_ivshmem_server_start itself, therefore, they are used for
+     * proper service termination.
+     */
+    enum ServerStartStatus status;
+} ServerThread;
+
+gchar *mktempshm(int size, int *fd);
+gchar *mktempsocket(void);
+void test_ivshmem_server_start(ServerThread *thread,
+                               const char *server_socket_path,
+                               const char *shm_rel_path, unsigned num_vectors);
+void test_ivshmem_server_stop(ServerThread *thread);
+
+#endif /* QTEST_IVSHMEM_UTILS_H */
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c5a70021c5..bf1fd12a9e 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -71,7 +71,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_PVPANIC_ISA') ? ['pvpanic-test'] : []) +              \
   (config_all_devices.has_key('CONFIG_PVPANIC_PCI') ? ['pvpanic-pci-test'] : []) +          \
   (config_all_devices.has_key('CONFIG_HDA') ? ['intel-hda-test'] : []) +                    \
-  (config_all_devices.has_key('CONFIG_I82801B11') ? ['i82801b11-test'] : []) +             \
+  (config_all_devices.has_key('CONFIG_I82801B11') ? ['i82801b11-test'] : []) +              \
   (config_all_devices.has_key('CONFIG_IOH3420') ? ['ioh3420-test'] : []) +                  \
   (config_all_devices.has_key('CONFIG_LPC_ICH9') ? ['lpc-ich9-test'] : []) +              \
   (config_all_devices.has_key('CONFIG_MC146818RTC') ? ['rtc-test'] : []) +                  \
@@ -361,7 +361,7 @@ qtests = {
   'dbus-vmstate-test': files('migration/migration-qmp.c',
                              'migration/migration-util.c') + dbus_vmstate1,
   'erst-test': files('erst-test.c'),
-  'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
+  'ivshmem-test': ['ivshmem-utils.c', '../../contrib/ivshmem-server/ivshmem-server.c'],
   'migration-test': migration_files + migration_tls_files,
   'pxe-test': files('boot-sector.c'),
   'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c'),
-- 
2.34.1


