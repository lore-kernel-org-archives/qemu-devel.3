Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A4FC47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 19:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUX2o-0002AN-KJ; Mon, 29 Jan 2024 14:11:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rUX2m-00029Z-Ff
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:11:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rUX2k-0000t3-04
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706555500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VCZC6smY2gGXADyNHdmRdRUo+tx4mVqnu27PiO3AZkA=;
 b=d/9DsO3kzp9YXtueSC5aT6qEl5rLvkmA/h1XzDEY3+a80NY4Rneu7bTsUsQQAQjBrq1wrE
 qmaj0Hez9d6ZebfEb+AuADv7FMxAjKYs6K2bjr/vp0T9tteyg/yDGDuB6CYJ0h3HL8VoxG
 N94m6TLI3kG03MvA5VAzB/StHfkmEAE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-Gw0MOdUqP5K1EH-hn6_NKA-1; Mon, 29 Jan 2024 14:11:38 -0500
X-MC-Unique: Gw0MOdUqP5K1EH-hn6_NKA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-337a9795c5cso2305785f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 11:11:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706555497; x=1707160297;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VCZC6smY2gGXADyNHdmRdRUo+tx4mVqnu27PiO3AZkA=;
 b=kEqyKnEx0YFzjRN595FudEXZOmz8l+zkSpDB/IBZsAgYYPhTBPxRH/c1DrLNZb34cc
 AZzQPVsDl3CDhcj38aHJ85ibJPqvZE4izmOP8mBZc9vPXUEN1t02yOcYHElJ86tDE//i
 lWYR38G7R1ZBcgDiPgk6zR0jTlnM61wNx587jymW+xESfnzaGxgeObtzj7kp6iZXBH5g
 RXge+ZVcWjdSrV4c+iVD8lz3JoctCxI+TEj4MkMT0xbIvqGEbYi6rwuvA9NXwMeMQURk
 JfaaNdfMcVpmcR9TxsSGcjMWkiqo5tqIo+NyYare/5dzdyR2LlA3wc8LlHJnVB31wHMc
 3mdQ==
X-Gm-Message-State: AOJu0YykWPhz76xd2P8ewYWHQKVerqRMvZ97BXXUMEKOr8pckBeH6prK
 SRJXQLde4gliPFXxDMP8hauToqJYREBCYSBjWYy+xVxDSlpFfcJyPEHijo3FrlQiqjak93GqDja
 ekre5nif6BUyp0NUtZc9+MPnAsY7r7kdbVecYDywy8QNp5OGxt2hR
X-Received: by 2002:adf:e748:0:b0:33a:e504:9fe0 with SMTP id
 c8-20020adfe748000000b0033ae5049fe0mr4940495wrn.64.1706555497604; 
 Mon, 29 Jan 2024 11:11:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKl/QU4MZVwbdjXRtLifFB1aQ3Ud1tlR3aZaNhZJYibqB7dzx8mR5cdaesc/kW9F/dzAV0fA==
X-Received: by 2002:adf:e748:0:b0:33a:e504:9fe0 with SMTP id
 c8-20020adfe748000000b0033ae5049fe0mr4940480wrn.64.1706555497182; 
 Mon, 29 Jan 2024 11:11:37 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:aa00:3221:f685:1200:6d03?
 (p200300cbc721aa003221f68512006d03.dip0.t-ipconnect.de.
 [2003:cb:c721:aa00:3221:f685:1200:6d03])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a5d4a47000000b0033aef37ec94sm2782643wrs.113.2024.01.29.11.11.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 11:11:36 -0800 (PST)
Message-ID: <c15161eb-f52c-4a82-8b4b-0ba03842188c@redhat.com>
Date: Mon, 29 Jan 2024 20:11:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Initialize backend memory objects in parallel
Content-Language: en-US
To: Mark Kanda <mark.kanda@oracle.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com
References: <20240122153219.2885749-1-mark.kanda@oracle.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240122153219.2885749-1-mark.kanda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 22.01.24 16:32, Mark Kanda wrote:
> v2:
> - require MADV_POPULATE_WRITE (simplify the implementation)
> - require prealloc context threads to ensure optimal thread placement
> - use machine phase 'initialized' to detremine when to allow parallel init
> 
> QEMU initializes preallocated backend memory when parsing the corresponding
> objects from the command line. In certain scenarios, such as memory being
> preallocated across multiple numa nodes, this approach is not optimal due to
> the unnecessary serialization.
> 
> This series addresses this issue by initializing the backend memory objects in
> parallel.

I just played with the code, some comments:

* I suggest squashing both patches. It doesn't make things clearer if we
   factor out unconditionally adding contexts to a global list.

* Keep the functions MT-capable, at least as long as async=false. That
   is, don't involve the global list if async=false. virtio-mem will
   perform preallocation from other threads at some point, where we could
   see concurrent preallocations for different devices. I made sure that
   qemu_mem_prealloc() can handle that.

* Rename wait_mem_prealloc() to qemu_finish_async_mem_prealloc() and let
   it report the error / return true/false like qemu_prealloc_mem().
   Especially, don't change the existing
   "qemu_prealloc_mem: preallocating memory failed" error message.

* Do the conditional async=false fixup in touch_all_pages(). That means,
   in qemu_prealloc_mem(), only route the async parameter through.


One thing I don't quite like is what happens when multiple threads would try
issuing "async=true". It will currently not happen, but we should catch
whenever that happens and require that only one thread at a time can
perform async preallocs. Maybe we can assert in qemu_prealloc_mem()/
qemu_finish_async_mem_prealloc() that we hold the BQL. Hopefully, that
is the case when we start creating memory backends, before starting the
main loop. If not, maybe we should just document that async limitation.

Ideally, we'd have some async_start(), prealloc(), prealloc(),
async_finish() interface, where async_start() would block until
another thread called async_finish(), so we never have a mixture.
But that would currently be over-engineering.


I'll attach the untested, likely broken, code I played with to see
what it could look like. Observe how I only conditionally add the
context to the list at the end of touch_all_pages().


 From fe26cc5252f1284efa8e667310609a22c6166324 Mon Sep 17 00:00:00 2001
From: Mark Kanda <mark.kanda@oracle.com>
Date: Mon, 22 Jan 2024 09:32:18 -0600
Subject: [PATCH] oslib-posix: initialize selected backend memory objects in
  parallel

QEMU initializes preallocated backend memory as the objects are parsed from
the command line. This is not optimal in some cases (e.g. memory spanning
multiple NUMA nodes) because the memory objects are initialized in series.

Allow the initialization to occur in parallel. In order to ensure optimal
thread placement, parallel initialization requires prealloc context threads
to be in use.

Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
  backends/hostmem.c     |   8 ++-
  hw/virtio/virtio-mem.c |   4 +-
  include/qemu/osdep.h   |  19 +++++-
  system/vl.c            |   8 +++
  util/oslib-posix.c     | 130 +++++++++++++++++++++++++++++++----------
  util/oslib-win32.c     |   8 ++-
  6 files changed, 140 insertions(+), 37 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 30f69b2cb5..8f602dc86f 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -20,6 +20,7 @@
  #include "qom/object_interfaces.h"
  #include "qemu/mmap-alloc.h"
  #include "qemu/madvise.h"
+#include "hw/qdev-core.h"
  
  #ifdef CONFIG_NUMA
  #include <numaif.h>
@@ -235,9 +236,10 @@ static void host_memory_backend_set_prealloc(Object *obj, bool value,
          int fd = memory_region_get_fd(&backend->mr);
          void *ptr = memory_region_get_ram_ptr(&backend->mr);
          uint64_t sz = memory_region_size(&backend->mr);
+        bool async = !phase_check(PHASE_MACHINE_INITIALIZED);
  
          if (!qemu_prealloc_mem(fd, ptr, sz, backend->prealloc_threads,
-                               backend->prealloc_context, errp)) {
+                               backend->prealloc_context, async, errp)) {
              return;
          }
          backend->prealloc = true;
@@ -323,6 +325,7 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
      HostMemoryBackendClass *bc = MEMORY_BACKEND_GET_CLASS(uc);
      void *ptr;
      uint64_t sz;
+    bool async = !phase_check(PHASE_MACHINE_INITIALIZED);
  
      if (!bc->alloc) {
          return;
@@ -398,7 +401,8 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
      if (backend->prealloc && !qemu_prealloc_mem(memory_region_get_fd(&backend->mr),
                                                  ptr, sz,
                                                  backend->prealloc_threads,
-                                                backend->prealloc_context, errp)) {
+                                                backend->prealloc_context,
+                                                async, errp)) {
          return;
      }
  }
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 99ab989852..ffd119ebac 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -605,7 +605,7 @@ static int virtio_mem_set_block_state(VirtIOMEM *vmem, uint64_t start_gpa,
          int fd = memory_region_get_fd(&vmem->memdev->mr);
          Error *local_err = NULL;
  
-        if (!qemu_prealloc_mem(fd, area, size, 1, NULL, &local_err)) {
+        if (!qemu_prealloc_mem(fd, area, size, 1, NULL, false, &local_err)) {
              static bool warned;
  
              /*
@@ -1248,7 +1248,7 @@ static int virtio_mem_prealloc_range_cb(VirtIOMEM *vmem, void *arg,
      int fd = memory_region_get_fd(&vmem->memdev->mr);
      Error *local_err = NULL;
  
-    if (!qemu_prealloc_mem(fd, area, size, 1, NULL, &local_err)) {
+    if (!qemu_prealloc_mem(fd, area, size, 1, NULL, false, &local_err)) {
          error_report_err(local_err);
          return -ENOMEM;
      }
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index c9692cc314..ed48f3d028 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -680,6 +680,8 @@ typedef struct ThreadContext ThreadContext;
   * @area: start address of the are to preallocate
   * @sz: the size of the area to preallocate
   * @max_threads: maximum number of threads to use
+ * @tc: prealloc context threads pointer, NULL if not in use
+ * @async: request asynchronous preallocation, requires @tc
   * @errp: returns an error if this function fails
   *
   * Preallocate memory (populate/prefault page tables writable) for the virtual
@@ -687,10 +689,25 @@ typedef struct ThreadContext ThreadContext;
   * each page in the area was faulted in writable at least once, for example,
   * after allocating file blocks for mapped files.
   *
+ * When setting @async, allocation might be performed asynchronously.
+ * qemu_finish_async_mem_prealloc() must be called to finish any asyncronous
+ * preallocation, reporting any preallocation error.
+ *
   * Return: true on success, else false setting @errp with error.
   */
  bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
-                       ThreadContext *tc, Error **errp);
+                       ThreadContext *tc, bool async, Error **errp);
+
+/**
+ * qemu_finish_async_mem_prealloc:
+ * @errp: returns an error if this function fails
+ *
+ * Finish any outstanding memory prealloc to complete, reporting any error
+ * like qemu_prealloc_mem() would.
+ *
+ * Return: true on success, else false setting @errp with error.
+ */
+bool qemu_finish_async_mem_prealloc(Error **errp);
  
  /**
   * qemu_get_pid_name:
diff --git a/system/vl.c b/system/vl.c
index 788d88ea03..290bb3232b 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2009,6 +2009,14 @@ static void qemu_create_late_backends(void)
  
      object_option_foreach_add(object_create_late);
  
+    /*
+     * Wait for any outstanding memory prealloc from created memory
+     * backends to complete.
+     */
+    if (!qemu_finish_async_mem_prealloc(&error_fatal)) {
+        exit(1);
+    }
+
      if (tpm_init() < 0) {
          exit(1);
      }
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 7c297003b9..c37548abdc 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -42,6 +42,7 @@
  #include "qemu/cutils.h"
  #include "qemu/units.h"
  #include "qemu/thread-context.h"
+#include "qemu/main-loop.h"
  
  #ifdef CONFIG_LINUX
  #include <sys/syscall.h>
@@ -63,11 +64,15 @@
  
  struct MemsetThread;
  
+static QLIST_HEAD(, MemsetContext) memset_contexts =
+    QLIST_HEAD_INITIALIZER(memset_contexts);
+
  typedef struct MemsetContext {
      bool all_threads_created;
      bool any_thread_failed;
      struct MemsetThread *threads;
      int num_threads;
+    QLIST_ENTRY(MemsetContext) next;
  } MemsetContext;
  
  struct MemsetThread {
@@ -412,19 +417,44 @@ static inline int get_memset_num_threads(size_t hpagesize, size_t numpages,
      return ret;
  }
  
+static int wait_and_free_mem_prealloc_context(MemsetContext *context)
+{
+    int i, ret = 0, tmp;
+
+    for (i = 0; i < context->num_threads; i++) {
+        tmp = (uintptr_t)qemu_thread_join(&context->threads[i].pgthread);
+
+        if (tmp) {
+            ret = tmp;
+        }
+    }
+    g_free(context->threads);
+    g_free(context);
+    return ret;
+}
+
  static int touch_all_pages(char *area, size_t hpagesize, size_t numpages,
-                           int max_threads, ThreadContext *tc,
+                           int max_threads, ThreadContext *tc, bool async,
                             bool use_madv_populate_write)
  {
      static gsize initialized = 0;
-    MemsetContext context = {
-        .num_threads = get_memset_num_threads(hpagesize, numpages, max_threads),
-    };
+    MemsetContext *context = g_new0(MemsetContext, 1);
      size_t numpages_per_thread, leftover;
      void *(*touch_fn)(void *);
-    int ret = 0, i = 0;
+    int ret, i = 0;
      char *addr = area;
  
+    /*
+     * Async prealloc is only allowed when using MADV_POPULATE_WRITE and
+     * prealloc context (to ensure optimal thread placement).
+     */
+    if (!use_madv_populate_write || !tc) {
+        async = false;
+    }
+
+    context->num_threads = get_memset_num_threads(hpagesize, numpages,
+                                                  max_threads);
+
      if (g_once_init_enter(&initialized)) {
          qemu_mutex_init(&page_mutex);
          qemu_cond_init(&page_cond);
@@ -432,8 +462,11 @@ static int touch_all_pages(char *area, size_t hpagesize, size_t numpages,
      }
  
      if (use_madv_populate_write) {
-        /* Avoid creating a single thread for MADV_POPULATE_WRITE */
-        if (context.num_threads == 1) {
+        /*
+         * Avoid creating a single thread for MADV_POPULATE_WRITE when
+         * preallocating synchronously.
+         */
+        if (context->num_threads == 1 && !async) {
              if (qemu_madvise(area, hpagesize * numpages,
                               QEMU_MADV_POPULATE_WRITE)) {
                  return -errno;
@@ -445,50 +478,85 @@ static int touch_all_pages(char *area, size_t hpagesize, size_t numpages,
          touch_fn = do_touch_pages;
      }
  
-    context.threads = g_new0(MemsetThread, context.num_threads);
-    numpages_per_thread = numpages / context.num_threads;
-    leftover = numpages % context.num_threads;
-    for (i = 0; i < context.num_threads; i++) {
-        context.threads[i].addr = addr;
-        context.threads[i].numpages = numpages_per_thread + (i < leftover);
-        context.threads[i].hpagesize = hpagesize;
-        context.threads[i].context = &context;
+    context->threads = g_new0(MemsetThread, context->num_threads);
+    numpages_per_thread = numpages / context->num_threads;
+    leftover = numpages % context->num_threads;
+    for (i = 0; i < context->num_threads; i++) {
+        context->threads[i].addr = addr;
+        context->threads[i].numpages = numpages_per_thread + (i < leftover);
+        context->threads[i].hpagesize = hpagesize;
+        context->threads[i].context = context;
          if (tc) {
-            thread_context_create_thread(tc, &context.threads[i].pgthread,
+            thread_context_create_thread(tc, &context->threads[i].pgthread,
                                           "touch_pages",
-                                         touch_fn, &context.threads[i],
+                                         touch_fn, &context->threads[i],
                                           QEMU_THREAD_JOINABLE);
          } else {
-            qemu_thread_create(&context.threads[i].pgthread, "touch_pages",
-                               touch_fn, &context.threads[i],
+            qemu_thread_create(&context->threads[i].pgthread, "touch_pages",
+                               touch_fn, &context->threads[i],
                                 QEMU_THREAD_JOINABLE);
          }
-        addr += context.threads[i].numpages * hpagesize;
+        addr += context->threads[i].numpages * hpagesize;
+    }
+
+    if (async) {
+        /*
+         * async requests currently require the BQL. Add it to the list and kick
+         * preallocation off during qemu_finish_async_mem_prealloc().
+         */
+        assert(bql_locked());
+        QLIST_INSERT_HEAD(&memset_contexts, context, next);
+        return 0;
      }
  
      if (!use_madv_populate_write) {
-        sigbus_memset_context = &context;
+        sigbus_memset_context = context;
      }
  
      qemu_mutex_lock(&page_mutex);
-    context.all_threads_created = true;
+    context->all_threads_created = true;
      qemu_cond_broadcast(&page_cond);
      qemu_mutex_unlock(&page_mutex);
+    ret = wait_and_free_mem_prealloc_context(context);
  
-    for (i = 0; i < context.num_threads; i++) {
-        int tmp = (uintptr_t)qemu_thread_join(&context.threads[i].pgthread);
+    if (!use_madv_populate_write) {
+        sigbus_memset_context = NULL;
+    }
+    return ret;
+}
+
+bool qemu_finish_async_mem_prealloc(Error **errp)
+{
+    int ret, tmp;
+    MemsetContext *context, *next_context;
+
+    /* Waiting for preallocation requires the BQL. */
+    assert(bql_locked());
+    if (QLIST_EMPTY(&memset_contexts)) {
+        return 0;
+    }
+
+    qemu_mutex_lock(&page_mutex);
+    QLIST_FOREACH(context, &memset_contexts, next) {
+        context->all_threads_created = true;
+    }
+    qemu_cond_broadcast(&page_cond);
+    qemu_mutex_unlock(&page_mutex);
  
+    QLIST_FOREACH_SAFE(context, &memset_contexts, next, next_context) {
+        QLIST_REMOVE(context, next);
+        tmp = wait_and_free_mem_prealloc_context(context);
          if (tmp) {
              ret = tmp;
          }
      }
  
-    if (!use_madv_populate_write) {
-        sigbus_memset_context = NULL;
+    if (ret) {
+        error_setg_errno(errp, -ret,
+                         "qemu_prealloc_mem: preallocating memory failed");
+        return false;
      }
-    g_free(context.threads);
-
-    return ret;
+    return true;
  }
  
  static bool madv_populate_write_possible(char *area, size_t pagesize)
@@ -498,7 +566,7 @@ static bool madv_populate_write_possible(char *area, size_t pagesize)
  }
  
  bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
-                       ThreadContext *tc, Error **errp)
+                       ThreadContext *tc, bool async, Error **errp)
  {
      static gsize initialized;
      int ret;
@@ -540,7 +608,7 @@ bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
      }
  
      /* touch pages simultaneously */
-    ret = touch_all_pages(area, hpagesize, numpages, max_threads, tc,
+    ret = touch_all_pages(area, hpagesize, numpages, max_threads, tc, async,
                            use_madv_populate_write);
      if (ret) {
          error_setg_errno(errp, -ret,
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index c4a5f05a49..107f0efe37 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -265,7 +265,7 @@ int getpagesize(void)
  }
  
  bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
-                       ThreadContext *tc, Error **errp)
+                       ThreadContext *tc, bool async, Error **errp)
  {
      int i;
      size_t pagesize = qemu_real_host_page_size();
@@ -278,6 +278,12 @@ bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
      return true;
  }
  
+bool qemu_finish_async_mem_prealloc(Error **errp)
+{
+    /* async prealloc not supported, there is nothing to finish */
+    return true;
+}
+
  char *qemu_get_pid_name(pid_t pid)
  {
      /* XXX Implement me */
-- 
2.43.0



-- 
Cheers,

David / dhildenb


