Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF39C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 21:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS1ip-00046I-Te; Thu, 11 Jul 2024 17:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1in-0003wv-2X
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:53:01 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1ij-0005Z2-5N
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:53:00 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-706dea920f3so708276a34.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 14:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720734775; x=1721339575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g36O2jlhRF6JWB+BcC9DsTu4cbuPShYgI3NtvZMuOF4=;
 b=cIdvR/IP9afshpESdtFB361N+tU7JJaPPhpLjjbT+bAf6kONPG+wuEf+rtKmNE3Ikp
 PnpqrcL89z2M4e7DQL24gs+4m76fUNcmnrKG2u8Tt2SKMGa0Bwc22v6B1J1YBHjX8NRW
 6Iv//AkGl+MnkxPov88Xee+sL8pzQX7vqeGIKi0GjgfJ8iBcmI139fXxb0Jf6ofa1MB8
 62XzTVkFeaY0r6SglSmQ4uO7OG23wiNXW9sqQotSFFWEsxAAVU7A8ZON5rJgtADvbUj/
 g8YJdvAsZydQVHYcrrzAGzXXtrV1yRh4KzxSozX6A4Mdo7eqNYlETyT87Wvfx/XPzjou
 K+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720734775; x=1721339575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g36O2jlhRF6JWB+BcC9DsTu4cbuPShYgI3NtvZMuOF4=;
 b=AgNJR8IMBwbOpCI1llfxYxbHh40C491uq8YR/Lpca+T9Nqg+z4NBOsd8y4j9jczd3S
 OETxTprL3El3YohlB+qTqaeAOb6723D8ILlr5x8HtjMyL/8/CGK0uKyN5ytnKwz1jr0S
 9zsglYk5bxZtMdIBisws4EAUQa3G9R5Tm31ZbzPR/DOy+C19OqykOZ3ZHZFyeBrVC/Xp
 aywUi1rCmORZImoY2Pbj6/KDEzdBPYbK2He9Oqf1tVM+pBCuGC86NMA3ToiDZRMXahaD
 g+8nOlPQ9P5MGqiYPNNtbYZAf5FAaoNbrr0uojOD0v1IOIfD0VaJbMu6/kJ1Af6nU42H
 78cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx3lU47QjTdXW5plxQgkdWS4OzFqD+tvhxQEiDYqhjEbnS+/L6niCWnoHRt1MdXLWSOyGLG7bSNjZhMmj1dAH5UwFa240=
X-Gm-Message-State: AOJu0Yxr44OKOyJW18ZWLYPSI27Y/f6VZYfGQsdMz+9pOek6h6tYOoz6
 HC8mbB9tU+wH47EvNFUtWq77049sEx5QEW7q5tfiPLHsidqUcHbRddWtkMvF56Gg5sjQPpI8c4a
 i2uc=
X-Google-Smtp-Source: AGHT+IGPleItq9Gp5o2Ob4TLwKEyNHgk3mWYcyTg6L9hpiKMvWNil1MHaqSsKviTXe93LGLKGL6UiA==
X-Received: by 2002:a05:6830:148:b0:704:4bb7:c99a with SMTP id
 46e09a7af769-708b521adedmr523021a34.0.1720734775201; 
 Thu, 11 Jul 2024 14:52:55 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([208.184.112.130])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7044ac2876dsm713125a34.2.2024.07.11.14.52.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jul 2024 14:52:54 -0700 (PDT)
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
Subject: [PATCH v5 03/13] util/dsa: Implement DSA device start and stop logic.
Date: Thu, 11 Jul 2024 14:52:38 -0700
Message-Id: <20240711215244.19237-4-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240711215244.19237-1-yichen.wang@bytedance.com>
References: <20240711215244.19237-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=yichen.wang@bytedance.com; helo=mail-ot1-x336.google.com
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

* DSA device open and close.
* DSA group contains multiple DSA devices.
* DSA group configure/start/stop/clean.

Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 include/qemu/dsa.h |  86 +++++++++++++
 util/dsa.c         | 303 +++++++++++++++++++++++++++++++++++++++++++++
 util/meson.build   |   3 +
 3 files changed, 392 insertions(+)
 create mode 100644 include/qemu/dsa.h
 create mode 100644 util/dsa.c

diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
new file mode 100644
index 0000000000..29b60654e9
--- /dev/null
+++ b/include/qemu/dsa.h
@@ -0,0 +1,86 @@
+/*
+ * Interface for using Intel Data Streaming Accelerator to offload certain
+ * background operations.
+ *
+ * Copyright (C) Bytedance Ltd.
+ *
+ * Authors:
+ *  Hao Xiang <hao.xiang@bytedance.com>
+ *  Yichen Wang <yichen.wang@bytedance.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_DSA_H
+#define QEMU_DSA_H
+
+#include "qemu/error-report.h"
+#include "qemu/thread.h"
+#include "qemu/queue.h"
+
+#ifdef CONFIG_DSA_OPT
+
+#pragma GCC push_options
+#pragma GCC target("enqcmd")
+
+#include <linux/idxd.h>
+#include "x86intrin.h"
+
+/**
+ * @brief Initializes DSA devices.
+ *
+ * @param dsa_parameter A list of DSA device path from migration parameter.
+ *
+ * @return int Zero if successful, otherwise non zero.
+ */
+int qemu_dsa_init(const char *dsa_parameter, Error **errp);
+
+/**
+ * @brief Start logic to enable using DSA.
+ */
+void qemu_dsa_start(void);
+
+/**
+ * @brief Stop the device group and the completion thread.
+ */
+void qemu_dsa_stop(void);
+
+/**
+ * @brief Clean up system resources created for DSA offloading.
+ */
+void qemu_dsa_cleanup(void);
+
+/**
+ * @brief Check if DSA is running.
+ *
+ * @return True if DSA is running, otherwise false.
+ */
+bool qemu_dsa_is_running(void);
+
+#else
+
+static inline bool qemu_dsa_is_running(void)
+{
+    return false;
+}
+
+static inline int qemu_dsa_init(const char *dsa_parameter, Error **errp)
+{
+    if (dsa_parameter != NULL && strlen(dsa_parameter) != 0) {
+        error_setg(errp, "DSA is not supported.");
+        return -1;
+    }
+
+    return 0;
+}
+
+static inline void qemu_dsa_start(void) {}
+
+static inline void qemu_dsa_stop(void) {}
+
+static inline void qemu_dsa_cleanup(void) {}
+
+#endif
+
+#endif
diff --git a/util/dsa.c b/util/dsa.c
new file mode 100644
index 0000000000..cdb0b9dda2
--- /dev/null
+++ b/util/dsa.c
@@ -0,0 +1,303 @@
+/*
+ * Use Intel Data Streaming Accelerator to offload certain background
+ * operations.
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
+#include "qapi/error.h"
+#include "qemu/queue.h"
+#include "qemu/memalign.h"
+#include "qemu/lockable.h"
+#include "qemu/cutils.h"
+#include "qemu/dsa.h"
+#include "qemu/bswap.h"
+#include "qemu/error-report.h"
+#include "qemu/rcu.h"
+
+#pragma GCC push_options
+#pragma GCC target("enqcmd")
+
+#include <linux/idxd.h>
+#include "x86intrin.h"
+
+#define DSA_WQ_SIZE 4096
+#define MAX_DSA_DEVICES 16
+
+typedef QSIMPLEQ_HEAD(dsa_task_queue, dsa_batch_task) dsa_task_queue;
+
+typedef struct {
+    void *work_queue;
+} QemuDsaDevice;
+
+typedef struct {
+    QemuDsaDevice *dsa_devices;
+    int num_dsa_devices;
+    /* The index of the next DSA device to be used. */
+    uint32_t device_allocator_index;
+    bool running;
+    QemuMutex task_queue_lock;
+    QemuCond task_queue_cond;
+    dsa_task_queue task_queue;
+} QemuDsaDeviceGroup;
+
+uint64_t max_retry_count;
+static QemuDsaDeviceGroup dsa_group;
+
+
+/**
+ * @brief This function opens a DSA device's work queue and
+ *        maps the DSA device memory into the current process.
+ *
+ * @param dsa_wq_path A pointer to the DSA device work queue's file path.
+ * @return A pointer to the mapped memory, or MAP_FAILED on failure.
+ */
+static void *
+map_dsa_device(const char *dsa_wq_path)
+{
+    void *dsa_device;
+    int fd;
+
+    fd = open(dsa_wq_path, O_RDWR);
+    if (fd < 0) {
+        error_report("Open %s failed with errno = %d.",
+                dsa_wq_path, errno);
+        return MAP_FAILED;
+    }
+    dsa_device = mmap(NULL, DSA_WQ_SIZE, PROT_WRITE,
+                      MAP_SHARED | MAP_POPULATE, fd, 0);
+    close(fd);
+    if (dsa_device == MAP_FAILED) {
+        error_report("mmap failed with errno = %d.", errno);
+        return MAP_FAILED;
+    }
+    return dsa_device;
+}
+
+/**
+ * @brief Initializes a DSA device structure.
+ *
+ * @param instance A pointer to the DSA device.
+ * @param work_queue A pointer to the DSA work queue.
+ */
+static void
+dsa_device_init(QemuDsaDevice *instance,
+                void *dsa_work_queue)
+{
+    instance->work_queue = dsa_work_queue;
+}
+
+/**
+ * @brief Cleans up a DSA device structure.
+ *
+ * @param instance A pointer to the DSA device to cleanup.
+ */
+static void
+dsa_device_cleanup(QemuDsaDevice *instance)
+{
+    if (instance->work_queue != MAP_FAILED) {
+        munmap(instance->work_queue, DSA_WQ_SIZE);
+    }
+}
+
+/**
+ * @brief Initializes a DSA device group.
+ *
+ * @param group A pointer to the DSA device group.
+ * @param dsa_parameter A list of DSA device path from are separated by space
+ * character migration parameter. Multiple DSA device path.
+ *
+ * @return Zero if successful, non-zero otherwise.
+ */
+static int
+dsa_device_group_init(QemuDsaDeviceGroup *group,
+                      const char *dsa_parameter,
+                      Error **errp)
+{
+    if (dsa_parameter == NULL || strlen(dsa_parameter) == 0) {
+        return 0;
+    }
+
+    int ret = 0;
+    char *local_dsa_parameter = g_strdup(dsa_parameter);
+    const char *dsa_path[MAX_DSA_DEVICES];
+    int num_dsa_devices = 0;
+    char delim[2] = " ";
+
+    char *current_dsa_path = strtok(local_dsa_parameter, delim);
+
+    while (current_dsa_path != NULL) {
+        dsa_path[num_dsa_devices++] = current_dsa_path;
+        if (num_dsa_devices == MAX_DSA_DEVICES) {
+            break;
+        }
+        current_dsa_path = strtok(NULL, delim);
+    }
+
+    group->dsa_devices =
+        g_new0(QemuDsaDevice, num_dsa_devices);
+    group->num_dsa_devices = num_dsa_devices;
+    group->device_allocator_index = 0;
+
+    group->running = false;
+    qemu_mutex_init(&group->task_queue_lock);
+    qemu_cond_init(&group->task_queue_cond);
+    QSIMPLEQ_INIT(&group->task_queue);
+
+    void *dsa_wq = MAP_FAILED;
+    for (int i = 0; i < num_dsa_devices; i++) {
+        dsa_wq = map_dsa_device(dsa_path[i]);
+        if (dsa_wq == MAP_FAILED) {
+            error_setg(errp, "map_dsa_device failed MAP_FAILED.");
+            ret = -1;
+            goto exit;
+        }
+        dsa_device_init(&dsa_group.dsa_devices[i], dsa_wq);
+    }
+
+exit:
+    g_free(local_dsa_parameter);
+    return ret;
+}
+
+/**
+ * @brief Starts a DSA device group.
+ *
+ * @param group A pointer to the DSA device group.
+ */
+static void
+dsa_device_group_start(QemuDsaDeviceGroup *group)
+{
+    group->running = true;
+}
+
+/**
+ * @brief Stops a DSA device group.
+ *
+ * @param group A pointer to the DSA device group.
+ */
+__attribute__((unused))
+static void
+dsa_device_group_stop(QemuDsaDeviceGroup *group)
+{
+    group->running = false;
+}
+
+/**
+ * @brief Cleans up a DSA device group.
+ *
+ * @param group A pointer to the DSA device group.
+ */
+static void
+dsa_device_group_cleanup(QemuDsaDeviceGroup *group)
+{
+    if (!group->dsa_devices) {
+        return;
+    }
+    for (int i = 0; i < group->num_dsa_devices; i++) {
+        dsa_device_cleanup(&group->dsa_devices[i]);
+    }
+    g_free(group->dsa_devices);
+    group->dsa_devices = NULL;
+
+    qemu_mutex_destroy(&group->task_queue_lock);
+    qemu_cond_destroy(&group->task_queue_cond);
+}
+
+/**
+ * @brief Returns the next available DSA device in the group.
+ *
+ * @param group A pointer to the DSA device group.
+ *
+ * @return struct QemuDsaDevice* A pointer to the next available DSA device
+ *         in the group.
+ */
+__attribute__((unused))
+static QemuDsaDevice *
+dsa_device_group_get_next_device(QemuDsaDeviceGroup *group)
+{
+    if (group->num_dsa_devices == 0) {
+        return NULL;
+    }
+    uint32_t current = qatomic_fetch_inc(&group->device_allocator_index);
+    current %= group->num_dsa_devices;
+    return &group->dsa_devices[current];
+}
+
+/**
+ * @brief Check if DSA is running.
+ *
+ * @return True if DSA is running, otherwise false.
+ */
+bool qemu_dsa_is_running(void)
+{
+    return false;
+}
+
+static void
+dsa_globals_init(void)
+{
+    max_retry_count = UINT64_MAX;
+}
+
+/**
+ * @brief Initializes DSA devices.
+ *
+ * @param dsa_parameter A list of DSA device path from migration parameter.
+ *
+ * @return int Zero if successful, otherwise non zero.
+ */
+int qemu_dsa_init(const char *dsa_parameter, Error **errp)
+{
+    dsa_globals_init();
+
+    return dsa_device_group_init(&dsa_group, dsa_parameter, errp);
+}
+
+/**
+ * @brief Start logic to enable using DSA.
+ *
+ */
+void qemu_dsa_start(void)
+{
+    if (dsa_group.num_dsa_devices == 0) {
+        return;
+    }
+    if (dsa_group.running) {
+        return;
+    }
+    dsa_device_group_start(&dsa_group);
+}
+
+/**
+ * @brief Stop the device group and the completion thread.
+ *
+ */
+void qemu_dsa_stop(void)
+{
+    QemuDsaDeviceGroup *group = &dsa_group;
+
+    if (!group->running) {
+        return;
+    }
+}
+
+/**
+ * @brief Clean up system resources created for DSA offloading.
+ *
+ */
+void qemu_dsa_cleanup(void)
+{
+    qemu_dsa_stop();
+    dsa_device_group_cleanup(&dsa_group);
+}
+
diff --git a/util/meson.build b/util/meson.build
index 5d8bef9891..3360f62923 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -88,6 +88,9 @@ if have_block or have_ga
 endif
 if have_block
   util_ss.add(files('aio-wait.c'))
+  if config_host_data.get('CONFIG_DSA_OPT')
+    util_ss.add(files('dsa.c'))
+  endif
   util_ss.add(files('buffer.c'))
   util_ss.add(files('bufferiszero.c'))
   util_ss.add(files('hbitmap.c'))
-- 
Yichen Wang


