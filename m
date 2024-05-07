Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCE1C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4LuB-0005ui-Af; Tue, 07 May 2024 10:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4Lu9-0005mX-EJ
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:34:53 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4Lu6-00029d-Vf
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:34:52 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-61be599ab77so1284485a12.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715092489; x=1715697289;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sbl6Cn/2SrMdVp5f3zSpmcxRHU/zOlM5ad+nfpeWxEI=;
 b=p1TucNDFm1yz5YTJE0XXJFcD0/nLRZ7uoH0ezXEEZXHsB7oAGXCvvKnAT9hs7rpYqs
 pxnoPwjUpyX+kFTC9H0abGkfBaoIfHvqXxEQ66wEtF2NxhS9pWYtFKEcpv4wgROTbDY7
 tt8FouP6UEbQ6sCuJRZgH2JBDiaEHBP0Mxax4ARffdre03O0gO+H20mUr8RV5qsW3x95
 /MPiUBf7gYTf9UOHs2w6DSKBR8n7IngxUfvd/g+cbYQh7OlsCNHNaWuC/c++J6jAwocr
 AAVj2soLSdS2PAvCp4Fj+lCEBoi4lgMK4fv/4cdFlIOzs24LLJT5LwzYmPI0Xupvdvve
 ufyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715092489; x=1715697289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sbl6Cn/2SrMdVp5f3zSpmcxRHU/zOlM5ad+nfpeWxEI=;
 b=AhSHFob0/rDmyJ9/d1EkqAO3TJ7zm/S+oR6Xrvmmk57SMq3YI9VLhXWroqMKmWHhmE
 7Dt5qRfNzuw/mnR+JAXzxFt2KiqIWUEtXWRbrrhHG19Uc+JW+YL8xn0u5JW+pRg2G/JL
 8Kgkx0siVL7zqX6E/s8xpulpENuEI59E8LKBRlOT4yPnfLBT6SSfYbDzh3/pnqLSe+C8
 9D+F14VUGa36r0QN7WYBmOKROwVGhfPFaIb3vM7AIgqqwHvG9YFg+iNGmmsRvByGI0t/
 ZhiG+oYKFJrQnmdxHMLDwf2n5ku0HONPKBynEw2PFH4u68Pawa1ybCUuWNJopz9QSP0A
 Y4gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbLF3eeCIvg49P4nUVyjkinIwk7RFcBndxCkW7MnryTUWAqk4h/Y8HV4llXNhWeEKrV/4F/w3aD18MwM4XRSvv2FWZRpA=
X-Gm-Message-State: AOJu0YyidnmWTrcAO0xA6gmF4YKRGgVQmuG/ojQJqkpq2NMJKVSwqLOX
 arka/1tbEwwoVdbqddfB282xtNYpCeQq7sk9ZUhtttjcHUI6Y72ivOZQjRJcOfE=
X-Google-Smtp-Source: AGHT+IHdlMQCs6zcK93GNzEvvKDxWklWZXVFDJ6lpxj36R68laHWvEnFnnTAounX3BP/kW8UScNp4Q==
X-Received: by 2002:a17:90b:400b:b0:2b2:9b67:198a with SMTP id
 ie11-20020a17090b400b00b002b29b67198amr13356767pjb.34.1715092489324; 
 Tue, 07 May 2024 07:34:49 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 pq10-20020a17090b3d8a00b002af8056917csm11827206pjb.29.2024.05.07.07.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:34:49 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: jag.raman@oracle.com, peterx@redhat.com, stefanha@redhat.com,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mattias Nissler <mnissler@rivosinc.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v10 2/7] system/physmem: Propagate AddressSpace to MapClient
 helpers
Date: Tue,  7 May 2024 07:34:26 -0700
Message-ID: <20240507143431.464382-3-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240507143431.464382-1-mnissler@rivosinc.com>
References: <20240507143431.464382-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=mnissler@rivosinc.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reviewed-by: Mattias Nissler <mnissler@rivosinc.com>
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
2.43.2


