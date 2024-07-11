Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D13DC3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 21:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS1iu-0004MB-6m; Thu, 11 Jul 2024 17:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1is-0004HG-PZ
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:53:06 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1iq-0005a1-GT
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:53:06 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-703ba2477bdso641050a34.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 14:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720734783; x=1721339583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ksX8+D+3HSKg/c07IUgWYwiC42rzANbtLF+jp56qHU=;
 b=KdQHeebORG91L4nM4R/IM1zSkaBx6yQR8g/2JMI9DPmPGWvI935iY+dMKrARUZ0YD8
 H7XSM19ODKFyFOSIyuqpb7k4V0urdydqPmFQpNpNcmYaUzOb0I5zjyJe3jOyLE7knJeX
 KyttoXuhkhYqKMttzA1qUJpt6RwQq6Cn6jFU90pKpvJ7aELmNNfbu+Cnwo+fwdmOnpAW
 r1xZlWhJfTTzGGjsPlmim0hQbJLtXP09FUhRLaiN5rm6qdZ3gvjVcy6dsYjtaUOP6MwR
 V6+2L416Yc9m1bwhVu10VwosMAlG0hpsvCeiDSQQ3xHvmx65eZ+EzXTLKmS1lN1XFqlj
 5zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720734783; x=1721339583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ksX8+D+3HSKg/c07IUgWYwiC42rzANbtLF+jp56qHU=;
 b=NQ+eM0OddoFIndr/6nprKAaulpO09Dm2VtaA4ggyTIaLRy1eh446AwQPEyGQWicuL3
 kJn/oZwaFzxGnfKccu2w0B/d1YoPrwD6oiXS7VeccLy3w9GhVCKIC/uG5JBEE568hWdV
 /qqq1U8C3+FksPKllnbUy2+lz7om09iWv/dDo+7Lk0uRZoocCg4nKtdb/5JC9GJaq24P
 4SHRYeJwYMlF8dyuzGF1/dLj+YebvYadXcZ6tvulS+mRmYeqjAe6BFAoDPHMeYCE6ruu
 64ykVXR4SZUVM3QoWuSNKqZLU2y5zlVAIVDutS3yNWkowibbslewr5vmm97meQWxQk9f
 Gw9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEF5kcLEMprxeoc22E2ncmO4q2lDOnykiIA7nI2XHoR+rwPlPHtX37pfvDHwUoOobmbWxXXXun3hOUWQu2dd3FBHaljM4=
X-Gm-Message-State: AOJu0YwnfXjUd+Xzhy4RX7zbUxcMf9sLHLykDdbMJ6I22AYUVRd+FSdy
 F38X8MwgsgINpHo4wpkxAgh7lTQwNwIe7HZx8Ps9RQfAUtpV5iyFXgvzzl1y/Kc=
X-Google-Smtp-Source: AGHT+IEVIUXjXQowbbH6rLfMkmeq3YWA3T2pIBuIw7E1mjvhPBgcZHOrcMVzN4BnTmpgo1P4fITLjg==
X-Received: by 2002:a9d:5912:0:b0:703:5f9f:82f2 with SMTP id
 46e09a7af769-70375a0baccmr11210651a34.18.1720734783029; 
 Thu, 11 Jul 2024 14:53:03 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([208.184.112.130])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7044ac2876dsm713125a34.2.2024.07.11.14.53.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jul 2024 14:53:02 -0700 (PDT)
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
Subject: [PATCH v5 06/13] util/dsa: Implement zero page checking in DSA task.
Date: Thu, 11 Jul 2024 14:52:41 -0700
Message-Id: <20240711215244.19237-7-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240711215244.19237-1-yichen.wang@bytedance.com>
References: <20240711215244.19237-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=yichen.wang@bytedance.com; helo=mail-ot1-x335.google.com
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

Create DSA task with operation code DSA_OPCODE_COMPVAL.
Here we create two types of DSA tasks, a single DSA task and
a batch DSA task. Batch DSA task reduces task submission overhead
and hence should be the default option. However, due to the way DSA
hardware works, a DSA batch task must contain at least two individual
tasks. There are times we need to submit a single task and hence a
single DSA task submission is also required.

Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 include/qemu/dsa.h |  18 ++++
 util/dsa.c         | 247 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 244 insertions(+), 21 deletions(-)

diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
index d46a9f42a5..1b4baf1c80 100644
--- a/include/qemu/dsa.h
+++ b/include/qemu/dsa.h
@@ -105,6 +105,24 @@ void qemu_dsa_cleanup(void);
  */
 bool qemu_dsa_is_running(void);
 
+/**
+ * @brief Initializes a buffer zero batch task.
+ *
+ * @param task A pointer to the batch task to initialize.
+ * @param results A pointer to an array of zero page checking results.
+ * @param batch_size The number of DSA tasks in the batch.
+ */
+void
+buffer_zero_batch_task_init(QemuDsaBatchTask *task,
+                            bool *results, int batch_size);
+
+/**
+ * @brief Performs the proper cleanup on a DSA batch task.
+ *
+ * @param task A pointer to the batch task to cleanup.
+ */
+void buffer_zero_batch_task_destroy(QemuDsaBatchTask *task);
+
 #else
 
 static inline bool qemu_dsa_is_running(void)
diff --git a/util/dsa.c b/util/dsa.c
index 1eb85f37f1..f0d8cce210 100644
--- a/util/dsa.c
+++ b/util/dsa.c
@@ -48,6 +48,7 @@ uint32_t max_retry_count;
 static QemuDsaDeviceGroup dsa_group;
 static QemuDsaCompletionThread completion_thread;
 
+static void buffer_zero_dsa_completion(void *context);
 
 /**
  * @brief This function opens a DSA device's work queue and
@@ -180,7 +181,6 @@ dsa_device_group_start(QemuDsaDeviceGroup *group)
  *
  * @param group A pointer to the DSA device group.
  */
-__attribute__((unused))
 static void
 dsa_device_group_stop(QemuDsaDeviceGroup *group)
 {
@@ -216,7 +216,6 @@ dsa_device_group_cleanup(QemuDsaDeviceGroup *group)
  * @return struct QemuDsaDevice* A pointer to the next available DSA device
  *         in the group.
  */
-__attribute__((unused))
 static QemuDsaDevice *
 dsa_device_group_get_next_device(QemuDsaDeviceGroup *group)
 {
@@ -289,7 +288,6 @@ dsa_task_enqueue(QemuDsaDeviceGroup *group,
  * @param group A pointer to the DSA device group.
  * @return QemuDsaBatchTask* The DSA task being dequeued.
  */
-__attribute__((unused))
 static QemuDsaBatchTask *
 dsa_task_dequeue(QemuDsaDeviceGroup *group)
 {
@@ -344,22 +342,6 @@ submit_wi_int(void *wq, struct dsa_hw_desc *descriptor)
     return 0;
 }
 
-/**
- * @brief Synchronously submits a DSA work item to the
- *        device work queue.
- *
- * @param wq A pointer to the DSA work queue's device memory.
- * @param descriptor A pointer to the DSA work item descriptor.
- *
- * @return int Zero if successful, non-zero otherwise.
- */
-__attribute__((unused))
-static int
-submit_wi(void *wq, struct dsa_hw_desc *descriptor)
-{
-    return submit_wi_int(wq, descriptor);
-}
-
 /**
  * @brief Asynchronously submits a DSA work item to the
  *        device work queue.
@@ -368,7 +350,6 @@ submit_wi(void *wq, struct dsa_hw_desc *descriptor)
  *
  * @return int Zero if successful, non-zero otherwise.
  */
-__attribute__((unused))
 static int
 submit_wi_async(QemuDsaBatchTask *task)
 {
@@ -397,7 +378,6 @@ submit_wi_async(QemuDsaBatchTask *task)
  *
  * @return int Zero if successful, non-zero otherwise.
  */
-__attribute__((unused))
 static int
 submit_batch_wi_async(QemuDsaBatchTask *batch_task)
 {
@@ -679,6 +659,231 @@ static void dsa_completion_thread_stop(void *opaque)
     qemu_sem_destroy(&thread_context->sem_init_done);
 }
 
+/**
+ * @brief Initializes a buffer zero comparison DSA task.
+ *
+ * @param descriptor A pointer to the DSA task descriptor.
+ * @param completion A pointer to the DSA task completion record.
+ */
+static void
+buffer_zero_task_init_int(struct dsa_hw_desc *descriptor,
+                          struct dsa_completion_record *completion)
+{
+    descriptor->opcode = DSA_OPCODE_COMPVAL;
+    descriptor->flags = IDXD_OP_FLAG_RCR | IDXD_OP_FLAG_CRAV;
+    descriptor->comp_pattern = (uint64_t)0;
+    descriptor->completion_addr = (uint64_t)completion;
+}
+
+/**
+ * @brief Initializes a buffer zero batch task.
+ *
+ * @param task A pointer to the batch task to initialize.
+ * @param results A pointer to an array of zero page checking results.
+ * @param batch_size The number of DSA tasks in the batch.
+ */
+void
+buffer_zero_batch_task_init(QemuDsaBatchTask *task,
+                            bool *results, int batch_size)
+{
+    int descriptors_size = sizeof(*task->descriptors) * batch_size;
+    memset(task, 0, sizeof(*task));
+
+    task->descriptors =
+        (struct dsa_hw_desc *)qemu_memalign(64, descriptors_size);
+    memset(task->descriptors, 0, descriptors_size);
+    task->completions = (struct dsa_completion_record *)qemu_memalign(
+        32, sizeof(*task->completions) * batch_size);
+    task->results = results;
+    task->batch_size = batch_size;
+
+    task->batch_completion.status = DSA_COMP_NONE;
+    task->batch_descriptor.completion_addr = (uint64_t)&task->batch_completion;
+    /* TODO: Ensure that we never send a batch with count <= 1 */
+    task->batch_descriptor.desc_count = 0;
+    task->batch_descriptor.opcode = DSA_OPCODE_BATCH;
+    task->batch_descriptor.flags = IDXD_OP_FLAG_RCR | IDXD_OP_FLAG_CRAV;
+    task->batch_descriptor.desc_list_addr = (uintptr_t)task->descriptors;
+    task->status = QEMU_DSA_TASK_READY;
+    task->group = &dsa_group;
+    task->device = dsa_device_group_get_next_device(&dsa_group);
+
+    for (int i = 0; i < task->batch_size; i++) {
+        buffer_zero_task_init_int(&task->descriptors[i],
+                                  &task->completions[i]);
+    }
+
+    qemu_sem_init(&task->sem_task_complete, 0);
+    task->completion_callback = buffer_zero_dsa_completion;
+}
+
+/**
+ * @brief Performs the proper cleanup on a DSA batch task.
+ *
+ * @param task A pointer to the batch task to cleanup.
+ */
+void
+buffer_zero_batch_task_destroy(QemuDsaBatchTask *task)
+{
+    qemu_vfree(task->descriptors);
+    qemu_vfree(task->completions);
+    task->results = NULL;
+
+    qemu_sem_destroy(&task->sem_task_complete);
+}
+
+/**
+ * @brief Resets a buffer zero comparison DSA batch task.
+ *
+ * @param task A pointer to the batch task.
+ * @param count The number of DSA tasks this batch task will contain.
+ */
+static void
+buffer_zero_batch_task_reset(QemuDsaBatchTask *task, size_t count)
+{
+    task->batch_completion.status = DSA_COMP_NONE;
+    task->batch_descriptor.desc_count = count;
+    task->task_type = QEMU_DSA_BATCH_TASK;
+    task->status = QEMU_DSA_TASK_READY;
+}
+
+/**
+ * @brief Sets a buffer zero comparison DSA task.
+ *
+ * @param descriptor A pointer to the DSA task descriptor.
+ * @param buf A pointer to the memory buffer.
+ * @param len The length of the buffer.
+ */
+static void
+buffer_zero_task_set_int(struct dsa_hw_desc *descriptor,
+                         const void *buf,
+                         size_t len)
+{
+    struct dsa_completion_record *completion =
+        (struct dsa_completion_record *)descriptor->completion_addr;
+
+    descriptor->xfer_size = len;
+    descriptor->src_addr = (uintptr_t)buf;
+    completion->status = 0;
+    completion->result = 0;
+}
+
+/**
+ * @brief Resets a buffer zero comparison DSA batch task.
+ *
+ * @param task A pointer to the DSA batch task.
+ */
+static void
+buffer_zero_task_reset(QemuDsaBatchTask *task)
+{
+    task->completions[0].status = DSA_COMP_NONE;
+    task->task_type = QEMU_DSA_TASK;
+    task->status = QEMU_DSA_TASK_READY;
+}
+
+/**
+ * @brief Sets a buffer zero comparison DSA task.
+ *
+ * @param task A pointer to the DSA task.
+ * @param buf A pointer to the memory buffer.
+ * @param len The buffer length.
+ */
+static void
+buffer_zero_task_set(QemuDsaBatchTask *task,
+                     const void *buf,
+                     size_t len)
+{
+    buffer_zero_task_reset(task);
+    buffer_zero_task_set_int(&task->descriptors[0], buf, len);
+}
+
+/**
+ * @brief Sets a buffer zero comparison batch task.
+ *
+ * @param batch_task A pointer to the batch task.
+ * @param buf An array of memory buffers.
+ * @param count The number of buffers in the array.
+ * @param len The length of the buffers.
+ */
+static void
+buffer_zero_batch_task_set(QemuDsaBatchTask *batch_task,
+                           const void **buf, size_t count, size_t len)
+{
+    assert(count > 0);
+    assert(count <= batch_task->batch_size);
+
+    buffer_zero_batch_task_reset(batch_task, count);
+    for (int i = 0; i < count; i++) {
+        buffer_zero_task_set_int(&batch_task->descriptors[i], buf[i], len);
+    }
+}
+
+/**
+ * @brief Asychronously perform a buffer zero DSA operation.
+ *
+ * @param task A pointer to the batch task structure.
+ * @param buf A pointer to the memory buffer.
+ * @param len The length of the memory buffer.
+ *
+ * @return int Zero if successful, otherwise an appropriate error code.
+ */
+__attribute__((unused))
+static int
+buffer_zero_dsa_async(QemuDsaBatchTask *task,
+                      const void *buf, size_t len)
+{
+    buffer_zero_task_set(task, buf, len);
+
+    return submit_wi_async(task);
+}
+
+/**
+ * @brief Sends a memory comparison batch task to a DSA device and wait
+ *        for completion.
+ *
+ * @param batch_task The batch task to be submitted to DSA device.
+ * @param buf An array of memory buffers to check for zero.
+ * @param count The number of buffers.
+ * @param len The buffer length.
+ */
+__attribute__((unused))
+static int
+buffer_zero_dsa_batch_async(QemuDsaBatchTask *batch_task,
+                            const void **buf, size_t count, size_t len)
+{
+    assert(count <= batch_task->batch_size);
+    buffer_zero_batch_task_set(batch_task, buf, count, len);
+
+    return submit_batch_wi_async(batch_task);
+}
+
+/**
+ * @brief The completion callback function for buffer zero
+ *        comparison DSA task completion.
+ *
+ * @param context A pointer to the callback context.
+ */
+static void
+buffer_zero_dsa_completion(void *context)
+{
+    assert(context != NULL);
+
+    QemuDsaBatchTask *task = (QemuDsaBatchTask *)context;
+    qemu_sem_post(&task->sem_task_complete);
+}
+
+/**
+ * @brief Wait for the asynchronous DSA task to complete.
+ *
+ * @param batch_task A pointer to the buffer zero comparison batch task.
+ */
+__attribute__((unused))
+static void
+buffer_zero_dsa_wait(QemuDsaBatchTask *batch_task)
+{
+    qemu_sem_wait(&batch_task->sem_task_complete);
+}
+
 /**
  * @brief Check if DSA is running.
  *
-- 
Yichen Wang


