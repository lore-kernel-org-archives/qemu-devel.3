Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783FDC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 14:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1razTA-0005hu-DT; Fri, 16 Feb 2024 09:45:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1razT5-0005ai-7A
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:45:36 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1razT2-0005ZI-U7
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:45:34 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a3c2efff32aso255595966b.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 06:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708094730; x=1708699530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XY5FELbVoRsZkyIlZfVy2YYeHbupT+Fi1KqtiQBV2Hs=;
 b=GnCp58i3aABZZnodAwjYxu16Xm0FZUhiA41aj1qio5c8YZQKePoc2iPOyLnPWxlMOu
 gDDWl1XHKk1n2cw/7g1yq+X3/aWrKbLqUjV4EyKAcy0IJ0nR7beITLCQs1EE1xboDAR5
 vFWnN6cBTC+xSTYaOC377eMOvMEdTd17NtM55U/qnxFXU6Ij44RcvydX+8DQFwDR2m29
 PA0AIObfe29bxnT/NSPEJZXJzUIuksQPGRY+6qNHLSiL6np6ihoN4TNnIXvD4mwnxmoO
 jofNH9y0ok5tQ5eq4YAsu8TpkmmHZi2btgKOcss9eIEHMSQzUyLxZJBySGFkEMRKDMo2
 KrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708094730; x=1708699530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XY5FELbVoRsZkyIlZfVy2YYeHbupT+Fi1KqtiQBV2Hs=;
 b=XhiCuUX7gv9hzhcs3rgFJpMhFXvoRQQD/d71tmj5nQ1GpdWyk2Y6L9ulCVMD9nicEq
 S+SmQ5QJNJ0R24c0uPKqagTIO5/bO6OhzzHNUN2ThdlbxyU+c5bFDqS0G9U/38VGiUYQ
 wb4nwVDTL4N6QV8BXXuEY0f77y2dguqiXekLTYH9jvCKKR6k6si5li+1viVBNEv0bF7t
 XMYcYOv5YXWG7Y2onHDAzYrLwTJg8OcbPIWkLT21GRy0EVOFCqEzpskbwn7wCPry01Wy
 ixFMtNxAYKoQkGoQ21mQfv2auoGnG9f8IPPuKQdDKz1Le7ZKi3udWk0us/xpl1MUQA19
 XdrQ==
X-Gm-Message-State: AOJu0Yzps1Fg2YkG2jVEsqCp6iQumAwnyQI7v8aIQAKLevpP2q0gg49m
 JCKTqai6YBvv0ADG6tFXqR/Hf8/grpWIR1kAa/khes3qONRwT3ZMlyxC+bYsZBBx0g95T/cam7h
 o
X-Google-Smtp-Source: AGHT+IEFbmWrtuaPSemLzptcNX68bgxQlvgSv9mQHw+e/d927laZZhubRgE6Dwsxnm7V7B3e1Rzfmw==
X-Received: by 2002:a17:907:b9ca:b0:a3d:2409:aa5a with SMTP id
 xa10-20020a170907b9ca00b00a3d2409aa5amr3596008ejc.52.1708094730395; 
 Fri, 16 Feb 2024 06:45:30 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 cx9-20020a170907168900b00a3d0a6d8a1esm4307ejd.33.2024.02.16.06.45.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 06:45:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Gustavo Romero <gustavo.romero@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anton Kochkov <anton.kochkov@proton.me>, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/6] tests/qtest: Reorganize common code in ivshmem-test
Date: Fri, 16 Feb 2024 15:44:55 +0100
Message-ID: <20240216144456.34992-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216144456.34992-1-philmd@linaro.org>
References: <20240216144456.34992-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Gustavo Romero <gustavo.romero@linaro.org>

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

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <20231127052024.435743-3-gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/ivshmem-utils.h |  56 +++++++++++++
 tests/qtest/ivshmem-test.c  | 113 ++------------------------
 tests/qtest/ivshmem-utils.c | 155 ++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build     |   6 +-
 4 files changed, 221 insertions(+), 109 deletions(-)
 create mode 100644 tests/qtest/ivshmem-utils.h
 create mode 100644 tests/qtest/ivshmem-utils.c

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
diff --git a/tests/qtest/ivshmem-test.c b/tests/qtest/ivshmem-test.c
index 9bf8e78df6..5ce43e2f76 100644
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
index 0000000000..b9578ab554
--- /dev/null
+++ b/tests/qtest/ivshmem-utils.c
@@ -0,0 +1,155 @@
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
+    server_socket_path = g_strdup_printf("/tmp/ivshmem_socket_qtest-%u-%u",
+                                         getpid(), g_test_rand_int());
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
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 2b89e8634b..bc6457220c 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -59,9 +59,9 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_PVPANIC_ISA') ? ['pvpanic-test'] : []) +              \
   (config_all_devices.has_key('CONFIG_PVPANIC_PCI') ? ['pvpanic-pci-test'] : []) +          \
   (config_all_devices.has_key('CONFIG_HDA') ? ['intel-hda-test'] : []) +                    \
-  (config_all_devices.has_key('CONFIG_I82801B11') ? ['i82801b11-test'] : []) +             \
+  (config_all_devices.has_key('CONFIG_I82801B11') ? ['i82801b11-test'] : []) +              \
   (config_all_devices.has_key('CONFIG_IOH3420') ? ['ioh3420-test'] : []) +                  \
-  (config_all_devices.has_key('CONFIG_LPC_ICH9') ? ['lpc-ich9-test'] : []) +              \
+  (config_all_devices.has_key('CONFIG_LPC_ICH9') ? ['lpc-ich9-test'] : []) +                \
   (config_all_devices.has_key('CONFIG_USB_UHCI') ? ['usb-hcd-uhci-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_USB_UHCI') and                                        \
    config_all_devices.has_key('CONFIG_USB_EHCI') ? ['usb-hcd-ehci-test'] : []) +            \
@@ -319,7 +319,7 @@ qtests = {
   'cdrom-test': files('boot-sector.c'),
   'dbus-vmstate-test': files('migration-helpers.c') + dbus_vmstate1,
   'erst-test': files('erst-test.c'),
-  'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
+  'ivshmem-test': ['ivshmem-utils.c', '../../contrib/ivshmem-server/ivshmem-server.c'],
   'migration-test': migration_files,
   'pxe-test': files('boot-sector.c'),
   'qos-test': [chardev, io, qos_test_ss.apply({}).sources()],
-- 
2.41.0


