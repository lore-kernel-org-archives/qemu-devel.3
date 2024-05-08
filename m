Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEFDC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lNC-0000UH-5J; Wed, 08 May 2024 13:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lMb-0000Ns-53
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:46:00 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lMX-0007Ni-SB
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:45:55 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a599af16934so1180246366b.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190352; x=1715795152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5lktyPwSdogYq1V7RF7t2acOl5Fh5GZ/5DfcLGKL7zg=;
 b=YzpOrQFuaeQqyqX6sZe0r5BZhXKlyVOqlpFuSoSM3m6Gl81zhcEj8vsetO1cAFDPKa
 B5xE+GR3j6EX93d2f1W7jJ3vhAn1m7uC5fOW8zF7Yzz3Qotym2MCSB2o6ZL1FNQ+pNeD
 D8lw/R3JQk9F4dUJXpHBgXwl/kG6ssuBVZ/oe3fkbmkufN8tNL/pmStG4n9oJaUavrXw
 HHolvLxhVzGMjl5XI1z/wb2RjAm57EfgohQLFxoMe+aI66pQ/caD6dWRUY80B+kTVDgy
 P2LaaB4mT+ao2cp4QphCSUhh+j71sD8X6fmXm6Ud2PLPgcr8vy0rQoEb60RQfBFWWy8o
 g1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190352; x=1715795152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5lktyPwSdogYq1V7RF7t2acOl5Fh5GZ/5DfcLGKL7zg=;
 b=YpiYKMn+zG7Du9aZp8NNOCVm4B6JL+pzgTFuAyQo0eG1xY0ux1e00Tbwc7eFrR1a0N
 uP4zJkIGc4WsZJFgFvCOiVhgXqp+UxWtJtAc4N1vwbHEF3rg+webg7jaCjXr85g0daLT
 bs1GvaRoT47HB7OavDMJF1MHcn/VmoUWUp6MYQr+vViwbQjwhFWH4E+wM7mHV8djITgq
 9ZduStrjTz4mpwq0Qxw7SLs4LU9QrYO6DBHcU1qvp9xIzQIbiZJ9+GIY5BF6YbtBLyXs
 LZHmtmcnggFo6JE1t81GliuZH9LTvH7IR5p0jPYIj9LNT06FeTj3MfltSiZiNBvfDxAw
 aKJw==
X-Gm-Message-State: AOJu0YyMRacVC9F2l9Z+2J61xCZu3kIWgibB5pPUXIhdNrPDjDJPO9PO
 FGN4ncPujABok4zmca4cUeONr7OBsGtMXyy49IjaZr3C9tlTrCDfEG+DQNCGEO1B8G6Kvy8CUHr
 G
X-Google-Smtp-Source: AGHT+IFpxYtpvvjIAPbwjQ7E9FKZ8PKEF2GK78u9RdTl4bxTQGYd4uazaImGyjkE0Dv7Hs5sw7/2YQ==
X-Received: by 2002:a17:907:1c92:b0:a59:c9ce:338b with SMTP id
 a640c23a62f3a-a59fb969048mr282928166b.35.1715190351913; 
 Wed, 08 May 2024 10:45:51 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 y24-20020a170906071800b00a59cec38bf3sm3866148ejb.52.2024.05.08.10.45.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 10:45:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mattias Nissler <mnissler@rivosinc.com>, Peter Xu <peterx@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/26] system/physmem: Propagate AddressSpace to MapClient
 helpers
Date: Wed,  8 May 2024 19:44:51 +0200
Message-ID: <20240508174510.60470-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508174510.60470-1-philmd@linaro.org>
References: <20240508174510.60470-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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
index 26f42f4a6f..b76b3d2184 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3066,24 +3066,24 @@ QemuMutex map_client_list_lock;
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
 
@@ -3093,7 +3093,7 @@ void cpu_register_map_client(QEMUBH *bh)
     /* Write map_client_list before reading in_use.  */
     smp_mb();
     if (!qatomic_read(&bounce.in_use)) {
-        cpu_notify_map_clients_locked();
+        address_space_notify_map_clients_locked(as);
     }
 }
 
@@ -3113,23 +3113,23 @@ void cpu_exec_init_all(void)
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
@@ -3196,8 +3196,8 @@ flatview_extend_translation(FlatView *fv, hwaddr addr,
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
@@ -3280,7 +3280,7 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
     memory_region_unref(bounce.mr);
     /* Clear in_use before reading map_client_list.  */
     qatomic_set_mb(&bounce.in_use, false);
-    cpu_notify_map_clients();
+    address_space_notify_map_clients(as);
 }
 
 void *cpu_physical_memory_map(hwaddr addr,
-- 
2.41.0


