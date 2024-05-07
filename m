Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EB3C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 12:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Jyr-00067B-46; Tue, 07 May 2024 08:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4Jy2-0005oj-Oq
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:30:49 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4Jy0-00077B-L7
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:30:46 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2e3e18c240fso10556681fa.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 05:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715085043; x=1715689843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIvNhuB8BogFmSNK+pezmWU5o0wMBR++47H4xs8QF94=;
 b=BMJqW8piKwWif7MKrUayL4mzeegZv4kLRma6wuMLD4/cx58uk6SYbA4FTfN74PHP7O
 5kWChpLdtm+P9TrTTHMoRSsgQBk9KN6mYLDakJ9dqMKb47Cjd0pafyWZiJjQb6KGCtYR
 JwSmfVBNqrVrII1EH6cuP4fv7VFzaJnRycEdI7IMN2o4Pz0L2oGkc0xs34UQuqEN/kD2
 37SopcVDZCsSbANY5WTtByNqP7G1x1i681Tw2OqWq2JKa423lhjK+G/lGuUrKScSJcTn
 MzXEDmfWIFp+N3leoeg9s7LKyDIhtGMV3EKwp9m2G1eXX4t5DMZhldwwxcDke6ZVxV9p
 w5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715085043; x=1715689843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nIvNhuB8BogFmSNK+pezmWU5o0wMBR++47H4xs8QF94=;
 b=SX8jk3k5F2nt5GpTiXQcT5N4/s9QhqgYwKAyswoO9/mhVXCYcu8YmP0APPZ8iiOOo9
 OFANDlnKfnN2VlMMF8WwgfEIDTlRl87LdeAwA8V1zMSoI/qaQZBrFSEw24V1LEGrMQNS
 TvY6pBNalbo207pq+k4F4QdbtJstq3NBFazDW4NLyQK1C9s3MtM5NGDsLq16Clq9c6kg
 46yS4ZYIcFIAapPv2pSSgXnYwg1QtXrixBt/jwcbeetRyiaVcxnLmaFdyWm+h/BSA91Y
 rYiI9C29xx7d1Dw6SiMtJ4OIQxkgE/ZEYACWGpAjS/7f8t7pe1mT4y5gqkhWRPipnShb
 0zUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzwcn7C22UpsOnpD/LPjf0uiNwO7nX2M2vV16q2u7pSmi9M43OULwPonzRUDPRtoi0yRIbkxEDt9tWTyESSRgcN22jc6o=
X-Gm-Message-State: AOJu0YzJkqeRuuZ3lLUeHZvEtlzwWUyrN4fnvT+Uz1YLWBRGLniI4u6/
 guTv+eatbGpEU0oZwKMGK8k1uxLkeHCCFRgrD16TEgzO4L1t3XaauoIX4kcF9u4=
X-Google-Smtp-Source: AGHT+IFSzqfBWSMj7MDgQqjANWWCQG7BRDNA1M2eTvzVOZi8B86128Yz7zWy2NO1snYXgUTc/5CZMg==
X-Received: by 2002:a2e:b8d2:0:b0:2da:7944:9547 with SMTP id
 s18-20020a2eb8d2000000b002da79449547mr14086789ljp.5.1715085042794; 
 Tue, 07 May 2024 05:30:42 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.177.243])
 by smtp.gmail.com with ESMTPSA id
 h4-20020adff4c4000000b0034cee43238fsm12830670wrp.27.2024.05.07.05.30.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 May 2024 05:30:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Mattias Nissler <mnissler@rivosinc.com>,
	qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, john.levon@nutanix.com,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 "Elena Ufimtseva" <elena.ufimtseva@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] system/physmem: Propagate AddressSpace to MapClient
 helpers
Date: Tue,  7 May 2024 14:30:24 +0200
Message-ID: <20240507123025.93391-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240507123025.93391-1-philmd@linaro.org>
References: <20240507123025.93391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

From: Mattias Nissler <mnissler@rivosinc.com>

Propagate AddressSpace handler to following helpers:
- register_map_client()
- unregister_map_client()
- notify_map_clients[_locked]()

Rename them using 'address_space_' prefix instead of 'cpu_'.

The AddressSpace argument will be used in the next commit.

Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
Message-ID: <20240507094210.300566-2-mnissler@rivosinc.com>
[PMD: Split patch, part 1/2]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-common.h |  2 --
 include/exec/memory.h     | 26 ++++++++++++++++++++++++--
 system/dma-helpers.c      |  4 ++--
 system/physmem.c          | 24 ++++++++++++------------
 4 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 8bc397e251..815342d043 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -147,8 +147,6 @@ void *cpu_physical_memory_map(hwaddr addr,
                               bool is_write);
 void cpu_physical_memory_unmap(void *buffer, hwaddr len,
                                bool is_write, hwaddr access_len);
-void cpu_register_map_client(QEMUBH *bh);
-void cpu_unregister_map_client(QEMUBH *bh);
 
 bool cpu_physical_memory_is_io(hwaddr phys_addr);
 
diff --git a/include/exec/memory.h b/include/exec/memory.h
index dadb5cd65a..e1e0c5a3de 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2946,8 +2946,8 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr, hwaddr len,
  * May return %NULL and set *@plen to zero(0), if resources needed to perform
  * the mapping are exhausted.
  * Use only for reads OR writes - not for read-modify-write operations.
- * Use cpu_register_map_client() to know when retrying the map operation is
- * likely to succeed.
+ * Use address_space_register_map_client() to know when retrying the map
+ * operation is likely to succeed.
  *
  * @as: #AddressSpace to be accessed
  * @addr: address within that address space
@@ -2972,6 +2972,28 @@ void *address_space_map(AddressSpace *as, hwaddr addr,
 void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
                          bool is_write, hwaddr access_len);
 
+/*
+ * address_space_register_map_client: Register a callback to invoke when
+ * resources for address_space_map() are available again.
+ *
+ * address_space_map may fail when there are not enough resources available,
+ * such as when bounce buffer memory would exceed the limit. The callback can
+ * be used to retry the address_space_map operation. Note that the callback
+ * gets automatically removed after firing.
+ *
+ * @as: #AddressSpace to be accessed
+ * @bh: callback to invoke when address_space_map() retry is appropriate
+ */
+void address_space_register_map_client(AddressSpace *as, QEMUBH *bh);
+
+/*
+ * address_space_unregister_map_client: Unregister a callback that has
+ * previously been registered and not fired yet.
+ *
+ * @as: #AddressSpace to be accessed
+ * @bh: callback to unregister
+ */
+void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh);
 
 /* Internal functions, part of the implementation of address_space_read.  */
 MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
diff --git a/system/dma-helpers.c b/system/dma-helpers.c
index 9b221cf94e..74013308f5 100644
--- a/system/dma-helpers.c
+++ b/system/dma-helpers.c
@@ -169,7 +169,7 @@ static void dma_blk_cb(void *opaque, int ret)
     if (dbs->iov.size == 0) {
         trace_dma_map_wait(dbs);
         dbs->bh = aio_bh_new(ctx, reschedule_dma, dbs);
-        cpu_register_map_client(dbs->bh);
+        address_space_register_map_client(dbs->sg->as, dbs->bh);
         return;
     }
 
@@ -197,7 +197,7 @@ static void dma_aio_cancel(BlockAIOCB *acb)
     }
 
     if (dbs->bh) {
-        cpu_unregister_map_client(dbs->bh);
+        address_space_unregister_map_client(dbs->sg->as, dbs->bh);
         qemu_bh_delete(dbs->bh);
         dbs->bh = NULL;
     }
diff --git a/system/physmem.c b/system/physmem.c
index 5486014cf2..27e754ff57 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3065,24 +3065,24 @@ QemuMutex map_client_list_lock;
 static QLIST_HEAD(, MapClient) map_client_list
     = QLIST_HEAD_INITIALIZER(map_client_list);
 
-static void cpu_unregister_map_client_do(MapClient *client)
+static void address_space_unregister_map_client_do(MapClient *client)
 {
     QLIST_REMOVE(client, link);
     g_free(client);
 }
 
-static void cpu_notify_map_clients_locked(void)
+static void address_space_notify_map_clients_locked(AddressSpace *as)
 {
     MapClient *client;
 
     while (!QLIST_EMPTY(&map_client_list)) {
         client = QLIST_FIRST(&map_client_list);
         qemu_bh_schedule(client->bh);
-        cpu_unregister_map_client_do(client);
+        address_space_unregister_map_client_do(client);
     }
 }
 
-void cpu_register_map_client(QEMUBH *bh)
+void address_space_register_map_client(AddressSpace *as, QEMUBH *bh)
 {
     MapClient *client = g_malloc(sizeof(*client));
 
@@ -3092,7 +3092,7 @@ void cpu_register_map_client(QEMUBH *bh)
     /* Write map_client_list before reading in_use.  */
     smp_mb();
     if (!qatomic_read(&bounce.in_use)) {
-        cpu_notify_map_clients_locked();
+        address_space_notify_map_clients_locked(as);
     }
 }
 
@@ -3112,23 +3112,23 @@ void cpu_exec_init_all(void)
     qemu_mutex_init(&map_client_list_lock);
 }
 
-void cpu_unregister_map_client(QEMUBH *bh)
+void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh)
 {
     MapClient *client;
 
     QEMU_LOCK_GUARD(&map_client_list_lock);
     QLIST_FOREACH(client, &map_client_list, link) {
         if (client->bh == bh) {
-            cpu_unregister_map_client_do(client);
+            address_space_unregister_map_client_do(client);
             break;
         }
     }
 }
 
-static void cpu_notify_map_clients(void)
+static void address_space_notify_map_clients(AddressSpace *as)
 {
     QEMU_LOCK_GUARD(&map_client_list_lock);
-    cpu_notify_map_clients_locked();
+    address_space_notify_map_clients_locked(as);
 }
 
 static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr len,
@@ -3195,8 +3195,8 @@ flatview_extend_translation(FlatView *fv, hwaddr addr,
  * May map a subset of the requested range, given by and returned in *plen.
  * May return NULL if resources needed to perform the mapping are exhausted.
  * Use only for reads OR writes - not for read-modify-write operations.
- * Use cpu_register_map_client() to know when retrying the map operation is
- * likely to succeed.
+ * Use address_space_register_map_client() to know when retrying the map
+ * operation is likely to succeed.
  */
 void *address_space_map(AddressSpace *as,
                         hwaddr addr,
@@ -3279,7 +3279,7 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
     memory_region_unref(bounce.mr);
     /* Clear in_use before reading map_client_list.  */
     qatomic_set_mb(&bounce.in_use, false);
-    cpu_notify_map_clients();
+    address_space_notify_map_clients(as);
 }
 
 void *cpu_physical_memory_map(hwaddr addr,
-- 
2.41.0


