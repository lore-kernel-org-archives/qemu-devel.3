Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00BFC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 22:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS1uj-0002Rc-T8; Thu, 11 Jul 2024 18:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1ug-0002N2-HH
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:05:18 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1uQ-0000L8-8U
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:05:10 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3d9ddfbbc58so805012b6e.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 15:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720735501; x=1721340301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VJ68XmNRUjWRQT4cS7/rlxhPmFKSGh8Da+hZaqurBZ8=;
 b=R90E3VBRayagvmS8sxZ+49LifYw1q9ScgxzCxNKJK3oNY0yGacfGceXMuARXH/SqJG
 +BiW8MsFTBzO4CSCz5O4zsqPnjNwN4aG+cpFXMP4PdjQCRHXbDPaJLnSsSpkPvsgcGgq
 mUhkukrgbY19FQPR40wlHF7Uw0WG7ducancibVR99WcArTWZgmIZ8EoxdOg75vbbr8tZ
 +nPIbnEIyNIySGh2Zucr+fzXbysEUqP0Vos47m4Zd509Iqu5VpVOY89uYoAo8iFk6NDi
 FfBIH3Dhddei584lzwXEKEjbaBkmgoyjZf/MlxJ/FNjQbe03QIfftiYdHoKVTzvbdKM8
 6YhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720735501; x=1721340301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VJ68XmNRUjWRQT4cS7/rlxhPmFKSGh8Da+hZaqurBZ8=;
 b=QLvQe68Fu/InCXcZG8A8/s8Es6RTaCQFxRM5Lz+y4oljpobea1w8vBy0GX5Ybvej8k
 KWZS1Xa+DBR8/eoyqxGjbD12WGrbCqv3iA3UkMZAW4ORhVne6sYNdg5PpF+Bj2g0Flzt
 f6QdTIxx3CjzcGvMG81AZRq28cKp1ar6OEWe6A/pu/zVFPXSjXrE9sQo5IeJLDTa9mb6
 6hql0vHK2NpcfrcAiCNBFwkpU9LmdWJG4sL86HaPBpj7+cDr4v2d2D/xr8PHgAlevXPI
 6SkQqV8ZWB7p6fxkkjS8jyHuNOK4Tf4bE7U73ewlh9sJI4jLxqPI0ZC9DqW1aKdL4eU6
 wgyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEiwatImrluSXKaLBzaUPWCNHWZNOUI8zs/APsrXxD5Adif01P0x56I4/a94P4/ZvS6X33wXVWDojJJ8QVEgtUwX5/IFY=
X-Gm-Message-State: AOJu0YzkcC5vqxsyrOwuCkL6MHcjweQBwfXEp3R+numGqX+FFFFOfFti
 NZR8tQtuSUjngyeWah2AYAgvh8Zgi61uxJ0QJe4wVPn/asQt9MiB+hLdbgsgr+M=
X-Google-Smtp-Source: AGHT+IEydHSpwAcXmjBpWdVvkuoH+rjr5/xfXqx8Kgrl2CWb4nPWuCiwILLQ7YdwODc69O+dX+oBLg==
X-Received: by 2002:a05:6808:218a:b0:3d5:5c77:fc2f with SMTP id
 5614622812f47-3d93c097a16mr13345967b6e.48.1720735500857; 
 Thu, 11 Jul 2024 15:05:00 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([208.184.112.130])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d93acff4d9sm1218578b6e.5.2024.07.11.15.04.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jul 2024 15:05:00 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v5 12/13] util/dsa: Add unit test coverage for Intel DSA task
 submission and completion.
Date: Thu, 11 Jul 2024 15:04:50 -0700
Message-Id: <20240711220451.19780-3-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240711220451.19780-1-yichen.wang@bytedance.com>
References: <20240711220451.19780-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=yichen.wang@bytedance.com; helo=mail-oi1-x230.google.com
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

From: Hao Xiang <hao.xiang@linux.dev>

* Test DSA start and stop path.
* Test DSA configure and cleanup path.
* Test DSA task submission and completion path.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 tests/unit/meson.build |   6 +
 tests/unit/test-dsa.c  | 503 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 509 insertions(+)
 create mode 100644 tests/unit/test-dsa.c

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 26c109c968..1d4d48898b 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -49,6 +49,12 @@ tests = {
   'test-interval-tree': [],
 }
 
+if config_host_data.get('CONFIG_DSA_OPT')
+  tests += {
+    'test-dsa': [],
+  }
+endif
+
 if have_system or have_tools
   tests += {
     'test-qmp-event': [testqapi],
diff --git a/tests/unit/test-dsa.c b/tests/unit/test-dsa.c
new file mode 100644
index 0000000000..181a547528
--- /dev/null
+++ b/tests/unit/test-dsa.c
@@ -0,0 +1,503 @@
+/*
+ * Test DSA functions.
+ *
+ * Copyright (C) Bytedance Ltd.
+ *
+ * Authors:
+ *  Hao Xiang <hao.xiang@bytedance.com>
+ *  Bryan Zhang <bryan.zhang@bytedance.com>
+ *  Yichen Wang <yichen.wang@bytedance.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/host-utils.h"
+
+#include "qemu/cutils.h"
+#include "qemu/memalign.h"
+#include "qemu/dsa.h"
+
+/*
+ * TODO Communicate that DSA must be configured to support this batch size.
+ * TODO Alternatively, poke the DSA device to figure out batch size.
+ */
+#define batch_size 128
+#define page_size 4096
+
+#define oversized_batch_size (batch_size + 1)
+#define num_devices 2
+#define max_buffer_size (64 * 1024)
+
+/* TODO Make these not-hardcoded. */
+static const strList path1[] = {
+    {.value = (char *)"/dev/dsa/wq4.0", .next = NULL}
+};
+static const strList path2[] = {
+    {.value = (char *)"/dev/dsa/wq4.0", .next = (strList*)&path2[1]},
+    {.value = (char *)"/dev/dsa/wq4.1", .next = NULL}
+};
+
+static Error **errp;
+
+static QemuDsaBatchTask *task;
+
+/* A helper for running a single task and checking for correctness. */
+static void do_single_task(void)
+{
+    task = buffer_zero_batch_task_init(batch_size);
+    char buf[page_size];
+    char *ptr = buf;
+
+    buffer_is_zero_dsa_batch_sync(task,
+                                  (const void **)&ptr,
+                                  1,
+                                  page_size);
+    g_assert(task->results[0] == buffer_is_zero(buf, page_size));
+
+    buffer_zero_batch_task_destroy(task);
+}
+
+static void test_single_zero(void)
+{
+    g_assert(!qemu_dsa_init(path1, errp));
+    qemu_dsa_start();
+
+    task = buffer_zero_batch_task_init(batch_size);
+
+    char buf[page_size];
+    char *ptr = buf;
+
+    memset(buf, 0x0, page_size);
+    buffer_is_zero_dsa_batch_sync(task,
+                                  (const void **)&ptr,
+                                  1, page_size);
+    g_assert(task->results[0]);
+
+    buffer_zero_batch_task_destroy(task);
+
+    qemu_dsa_cleanup();
+}
+
+static void test_single_zero_async(void)
+{
+    test_single_zero();
+}
+
+static void test_single_nonzero(void)
+{
+    g_assert(!qemu_dsa_init(path1, errp));
+    qemu_dsa_start();
+
+    task = buffer_zero_batch_task_init(batch_size);
+
+    char buf[page_size];
+    char *ptr = buf;
+
+    memset(buf, 0x1, page_size);
+    buffer_is_zero_dsa_batch_sync(task,
+                                  (const void **)&ptr,
+                                  1, page_size);
+    g_assert(!task->results[0]);
+
+    buffer_zero_batch_task_destroy(task);
+
+    qemu_dsa_cleanup();
+}
+
+static void test_single_nonzero_async(void)
+{
+    test_single_nonzero();
+}
+
+/* count == 0 should return quickly without calling into DSA. */
+static void test_zero_count_async(void)
+{
+    char buf[page_size];
+    buffer_is_zero_dsa_batch_sync(task,
+                                  (const void **)&buf,
+                                  0,
+                                  page_size);
+}
+
+static void test_null_task_async(void)
+{
+    if (g_test_subprocess()) {
+        g_assert(!qemu_dsa_init(path1, errp));
+
+        char buf[page_size * batch_size];
+        char *addrs[batch_size];
+        for (int i = 0; i < batch_size; i++) {
+            addrs[i] = buf + (page_size * i);
+        }
+
+        buffer_is_zero_dsa_batch_sync(NULL, (const void **)addrs,
+                                      batch_size,
+                                      page_size);
+    } else {
+        g_test_trap_subprocess(NULL, 0, 0);
+        g_test_trap_assert_failed();
+    }
+}
+
+static void test_oversized_batch(void)
+{
+    g_assert(!qemu_dsa_init(path1, errp));
+    qemu_dsa_start();
+
+    task = buffer_zero_batch_task_init(batch_size);
+
+    char buf[page_size * oversized_batch_size];
+    char *addrs[batch_size];
+    for (int i = 0; i < oversized_batch_size; i++) {
+        addrs[i] = buf + (page_size * i);
+    }
+
+    int ret = buffer_is_zero_dsa_batch_sync(task,
+                                            (const void **)addrs,
+                                            oversized_batch_size,
+                                            page_size);
+    g_assert(ret != 0);
+
+    buffer_zero_batch_task_destroy(task);
+
+    qemu_dsa_cleanup();
+}
+
+static void test_oversized_batch_async(void)
+{
+    test_oversized_batch();
+}
+
+static void test_zero_len_async(void)
+{
+    if (g_test_subprocess()) {
+        g_assert(!qemu_dsa_init(path1, errp));
+
+        task = buffer_zero_batch_task_init(batch_size);
+
+        char buf[page_size];
+
+        buffer_is_zero_dsa_batch_sync(task,
+                                      (const void **)&buf,
+                                      1,
+                                      0);
+
+        buffer_zero_batch_task_destroy(task);
+    } else {
+        g_test_trap_subprocess(NULL, 0, 0);
+        g_test_trap_assert_failed();
+    }
+}
+
+static void test_null_buf_async(void)
+{
+    if (g_test_subprocess()) {
+        g_assert(!qemu_dsa_init(path1, errp));
+
+        task = buffer_zero_batch_task_init(batch_size);
+
+        buffer_is_zero_dsa_batch_sync(task, NULL, 1, page_size);
+
+        buffer_zero_batch_task_destroy(task);
+    } else {
+        g_test_trap_subprocess(NULL, 0, 0);
+        g_test_trap_assert_failed();
+    }
+}
+
+static void test_batch(void)
+{
+    g_assert(!qemu_dsa_init(path1, errp));
+    qemu_dsa_start();
+
+    task = buffer_zero_batch_task_init(batch_size);
+
+    char buf[page_size * batch_size];
+    char *addrs[batch_size];
+    for (int i = 0; i < batch_size; i++) {
+        addrs[i] = buf + (page_size * i);
+    }
+
+    /*
+     * Using whatever is on the stack is somewhat random.
+     * Manually set some pages to zero and some to nonzero.
+     */
+    memset(buf + 0, 0, page_size * 10);
+    memset(buf + (10 * page_size), 0xff, page_size * 10);
+
+    buffer_is_zero_dsa_batch_sync(task,
+                                  (const void **)addrs,
+                                  batch_size,
+                                  page_size);
+
+    bool is_zero;
+    for (int i = 0; i < batch_size; i++) {
+        is_zero = buffer_is_zero((const void *)&buf[page_size * i], page_size);
+        g_assert(task->results[i] == is_zero);
+    }
+
+    buffer_zero_batch_task_destroy(task);
+
+    qemu_dsa_cleanup();
+}
+
+static void test_batch_async(void)
+{
+    test_batch();
+}
+
+static void test_page_fault(void)
+{
+    g_assert(!qemu_dsa_init(path1, errp));
+    qemu_dsa_start();
+
+    char *buf[2];
+    int prot = PROT_READ | PROT_WRITE;
+    int flags = MAP_SHARED | MAP_ANON;
+    buf[0] = (char *)mmap(NULL, page_size * batch_size, prot, flags, -1, 0);
+    assert(buf[0] != MAP_FAILED);
+    buf[1] = (char *)malloc(page_size * batch_size);
+    assert(buf[1] != NULL);
+
+    for (int j = 0; j < 2; j++) {
+        task = buffer_zero_batch_task_init(batch_size);
+
+        char *addrs[batch_size];
+        for (int i = 0; i < batch_size; i++) {
+            addrs[i] = buf[j] + (page_size * i);
+        }
+
+        buffer_is_zero_dsa_batch_sync(task,
+                                      (const void **)addrs,
+                                      batch_size,
+                                      page_size);
+
+        bool is_zero;
+        for (int i = 0; i < batch_size; i++) {
+            is_zero = buffer_is_zero((const void *)&buf[j][page_size * i],
+                                      page_size);
+            g_assert(task->results[i] == is_zero);
+        }
+        buffer_zero_batch_task_destroy(task);
+    }
+
+    assert(!munmap(buf[0], page_size * batch_size));
+    free(buf[1]);
+    qemu_dsa_cleanup();
+}
+
+static void test_various_buffer_sizes(void)
+{
+    g_assert(!qemu_dsa_init(path1, errp));
+    qemu_dsa_start();
+
+    char *buf = malloc(max_buffer_size * batch_size);
+    char *addrs[batch_size];
+
+    for (int len = 16; len <= max_buffer_size; len *= 2) {
+        task = buffer_zero_batch_task_init(batch_size);
+
+        for (int i = 0; i < batch_size; i++) {
+            addrs[i] = buf + (len * i);
+        }
+
+        buffer_is_zero_dsa_batch_sync(task,
+                                      (const void **)addrs,
+                                      batch_size,
+                                      len);
+
+        bool is_zero;
+        for (int j = 0; j < batch_size; j++) {
+            is_zero = buffer_is_zero((const void *)&buf[len * j], len);
+            g_assert(task->results[j] == is_zero);
+        }
+
+        buffer_zero_batch_task_destroy(task);
+    }
+
+    free(buf);
+
+    qemu_dsa_cleanup();
+}
+
+static void test_various_buffer_sizes_async(void)
+{
+    test_various_buffer_sizes();
+}
+
+static void test_double_start_stop(void)
+{
+    g_assert(!qemu_dsa_init(path1, errp));
+    /* Double start */
+    qemu_dsa_start();
+    qemu_dsa_start();
+    g_assert(qemu_dsa_is_running());
+    do_single_task();
+
+    /* Double stop */
+    qemu_dsa_stop();
+    g_assert(!qemu_dsa_is_running());
+    qemu_dsa_stop();
+    g_assert(!qemu_dsa_is_running());
+
+    /* Restart */
+    qemu_dsa_start();
+    g_assert(qemu_dsa_is_running());
+    do_single_task();
+    qemu_dsa_cleanup();
+}
+
+static void test_is_running(void)
+{
+    g_assert(!qemu_dsa_init(path1, errp));
+
+    g_assert(!qemu_dsa_is_running());
+    qemu_dsa_start();
+    g_assert(qemu_dsa_is_running());
+    qemu_dsa_stop();
+    g_assert(!qemu_dsa_is_running());
+    qemu_dsa_cleanup();
+}
+
+static void test_multiple_engines(void)
+{
+    g_assert(!qemu_dsa_init(path2, errp));
+    qemu_dsa_start();
+
+    QemuDsaBatchTask *tasks[num_devices];
+    char bufs[num_devices][page_size * batch_size];
+    char *addrs[num_devices][batch_size];
+
+    /*
+     *  This is a somewhat implementation-specific way
+     *  of testing that the tasks have unique engines
+     *  assigned to them.
+     */
+    tasks[0] = buffer_zero_batch_task_init(batch_size);
+    tasks[1] = buffer_zero_batch_task_init(batch_size);
+    g_assert(tasks[0]->device != tasks[1]->device);
+
+    for (int i = 0; i < num_devices; i++) {
+        for (int j = 0; j < batch_size; j++) {
+            addrs[i][j] = bufs[i] + (page_size * j);
+        }
+
+        buffer_is_zero_dsa_batch_sync(tasks[i],
+                                      (const void **)addrs[i],
+                                      batch_size, page_size);
+
+        bool is_zero;
+        for (int j = 0; j < batch_size; j++) {
+            is_zero = buffer_is_zero((const void *)&bufs[i][page_size * j],
+                                     page_size);
+            g_assert(tasks[i]->results[j] == is_zero);
+        }
+    }
+
+    buffer_zero_batch_task_destroy(tasks[0]);
+    buffer_zero_batch_task_destroy(tasks[1]);
+
+    qemu_dsa_cleanup();
+}
+
+static void test_configure_dsa_twice(void)
+{
+    g_assert(!qemu_dsa_init(path2, errp));
+    g_assert(!qemu_dsa_init(path2, errp));
+    qemu_dsa_start();
+    do_single_task();
+    qemu_dsa_cleanup();
+}
+
+static void test_configure_dsa_bad_path(void)
+{
+    const strList *bad_path = &(strList) {
+        .value = (char *)"/not/a/real/path", .next = NULL
+    };
+    g_assert(qemu_dsa_init(bad_path, errp));
+}
+
+static void test_cleanup_before_configure(void)
+{
+    qemu_dsa_cleanup();
+    g_assert(!qemu_dsa_init(path2, errp));
+}
+
+static void test_configure_dsa_num_devices(void)
+{
+    g_assert(!qemu_dsa_init(path1, errp));
+    qemu_dsa_start();
+
+    do_single_task();
+    qemu_dsa_stop();
+    qemu_dsa_cleanup();
+}
+
+static void test_cleanup_twice(void)
+{
+    g_assert(!qemu_dsa_init(path2, errp));
+    qemu_dsa_cleanup();
+    qemu_dsa_cleanup();
+
+    g_assert(!qemu_dsa_init(path2, errp));
+    qemu_dsa_start();
+    do_single_task();
+    qemu_dsa_cleanup();
+}
+
+static int check_test_setup(void)
+{
+    const strList *path[2] = {path1, path2};
+    for (int i = 0; i < sizeof(path) / sizeof(strList *); i++) {
+        if (qemu_dsa_init(path[i], errp)) {
+            return -1;
+        }
+        qemu_dsa_cleanup();
+    }
+    return 0;
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    if (check_test_setup() != 0) {
+        /*
+         * This test requires extra setup. The current
+         * setup is not correct. Just skip this test
+         * for now.
+         */
+        exit(0);
+    }
+
+    if (num_devices > 1) {
+        g_test_add_func("/dsa/multiple_engines", test_multiple_engines);
+    }
+
+    g_test_add_func("/dsa/async/batch", test_batch_async);
+    g_test_add_func("/dsa/async/various_buffer_sizes",
+                    test_various_buffer_sizes_async);
+    g_test_add_func("/dsa/async/null_buf", test_null_buf_async);
+    g_test_add_func("/dsa/async/zero_len", test_zero_len_async);
+    g_test_add_func("/dsa/async/oversized_batch", test_oversized_batch_async);
+    g_test_add_func("/dsa/async/zero_count", test_zero_count_async);
+    g_test_add_func("/dsa/async/single_zero", test_single_zero_async);
+    g_test_add_func("/dsa/async/single_nonzero", test_single_nonzero_async);
+    g_test_add_func("/dsa/async/null_task", test_null_task_async);
+    g_test_add_func("/dsa/async/page_fault", test_page_fault);
+
+    g_test_add_func("/dsa/double_start_stop", test_double_start_stop);
+    g_test_add_func("/dsa/is_running", test_is_running);
+
+    g_test_add_func("/dsa/configure_dsa_twice", test_configure_dsa_twice);
+    g_test_add_func("/dsa/configure_dsa_bad_path", test_configure_dsa_bad_path);
+    g_test_add_func("/dsa/cleanup_before_configure",
+                    test_cleanup_before_configure);
+    g_test_add_func("/dsa/configure_dsa_num_devices",
+                    test_configure_dsa_num_devices);
+    g_test_add_func("/dsa/cleanup_twice", test_cleanup_twice);
+
+    return g_test_run();
+}
-- 
Yichen Wang


