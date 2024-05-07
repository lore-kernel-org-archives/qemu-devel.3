Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45330C25B5F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4LuE-000639-D5; Tue, 07 May 2024 10:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4LuC-0005yU-Dz
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:34:56 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4Lu7-00029z-Uo
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:34:56 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-61c4ebd0c99so2103044a12.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715092491; x=1715697291;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4dzXIuG6mbxMYDWRZr/2iyrriU5kBzpAGlLmbx6+GSg=;
 b=b5gqx2i3QuwaZIkFkFw9dY2Js3rTvTCqDb7qyOjCB7P/wy8wDGKPk7g8knAO87v5d6
 jh5Fr6yNB5R7LefaGTzY11SOgWDQdd99Gfvx09drk+5HiosVtrmX7zUx5zgOCvLdmS4s
 gJ16FHAaPJA/G4rctDIVnk8P6YHWl7SGafccfR96t0JaXczczJKbVvNeyHKOb80d9WAo
 klu2IxCg3DFUv9R5jD2EkzVeeWqey7UXA/GqNiVws/5Xc38LCPM4USzqO+2wI+bq7JBb
 gElbYmWc4c2BLF3FRPpd4m3k95AYox8IiGeNJdosGFgTy0668kVGJeOOXVEYA2Zp9UHC
 VvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715092491; x=1715697291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4dzXIuG6mbxMYDWRZr/2iyrriU5kBzpAGlLmbx6+GSg=;
 b=qT/aIUHVoXaDOp5Mog6jmmzxXAC/ReDuaBvDSajcQdwfts5BIQrsa7xHEOUH73Sqxd
 F5jLbSpH69GWeucdMNaVMxefkpGU8TQbvW00Dq88usNXlXzNe9+lPIAUSbUX4YvyNkfj
 uhN3JZYPHyMwsiNaE5aqAIBuLB/mWuTzrmzB2A7mNyytXkxnCjJioGrdWMMFaCLoiwFi
 kcv6uzxxd0RKYtbIaC6w9mqEVvfkPEEwyd5kzQzpOvi3L/6cz/UP7ABeeMBztj+06sSY
 m/utDYgXkU1ifXv705ojhmBfLXTG5tuEEVfsfSzc9a5b7YoB8G4hDdZx+Qho+FaI4zjV
 qIWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIklIXyZmZhZ14ULovF3DYal5dBz+tyY03Yc+AUmDijDXnmojACXhtQfim0f9RPcHOJysFTkvg9rTVgIAmJ0hsQuHe0ZA=
X-Gm-Message-State: AOJu0Yz2sxbd70ipLlmFopVhxGGA/QYNz6+jn/1rxZF7++h/cj9TbcEI
 5zKhAosey+JNsDgxZTO8svSpgOSWprqJLpGIrD2Ud+JvhxjCqJUnvANElTRAAc8=
X-Google-Smtp-Source: AGHT+IGImNVsygAniT/EdTkq5rAoNKW5T7TYgogN8opjE9nbaT+xzimqRy+/1q60kHj0TBSVGHnz9w==
X-Received: by 2002:a17:90a:9a2:b0:2b4:32ae:7123 with SMTP id
 31-20020a17090a09a200b002b432ae7123mr11684284pjo.32.1715092490681; 
 Tue, 07 May 2024 07:34:50 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 pq10-20020a17090b3d8a00b002af8056917csm11827206pjb.29.2024.05.07.07.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:34:50 -0700 (PDT)
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
Subject: [PATCH v10 3/7] system/physmem: Per-AddressSpace bounce buffering
Date: Tue,  7 May 2024 07:34:27 -0700
Message-ID: <20240507143431.464382-4-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240507143431.464382-1-mnissler@rivosinc.com>
References: <20240507143431.464382-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=mnissler@rivosinc.com; helo=mail-pg1-x531.google.com
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

Instead of using a single global bounce buffer, give each AddressSpace
its own bounce buffer. The MapClient callback mechanism moves to
AddressSpace accordingly.

This is in preparation for generalizing bounce buffer handling further
to allow multiple bounce buffers, with a total allocation limit
configured per AddressSpace.

Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
Message-ID: <20240507094210.300566-2-mnissler@rivosinc.com>
[PMD: Split patch, part 2/2]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mattias Nissler <mnissler@rivosinc.com>
---
 include/exec/memory.h | 19 +++++++++++
 system/memory.c       |  7 +++++
 system/physmem.c      | 73 ++++++++++++++++---------------------------
 3 files changed, 53 insertions(+), 46 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e1e0c5a3de..d417d7f363 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1112,6 +1112,19 @@ struct MemoryListener {
     QTAILQ_ENTRY(MemoryListener) link_as;
 };
 
+typedef struct AddressSpaceMapClient {
+    QEMUBH *bh;
+    QLIST_ENTRY(AddressSpaceMapClient) link;
+} AddressSpaceMapClient;
+
+typedef struct {
+    MemoryRegion *mr;
+    void *buffer;
+    hwaddr addr;
+    hwaddr len;
+    bool in_use;
+} BounceBuffer;
+
 /**
  * struct AddressSpace: describes a mapping of addresses to #MemoryRegion objects
  */
@@ -1129,6 +1142,12 @@ struct AddressSpace {
     struct MemoryRegionIoeventfd *ioeventfds;
     QTAILQ_HEAD(, MemoryListener) listeners;
     QTAILQ_ENTRY(AddressSpace) address_spaces_link;
+
+    /* Bounce buffer to use for this address space. */
+    BounceBuffer bounce;
+    /* List of callbacks to invoke when buffers free up */
+    QemuMutex map_client_list_lock;
+    QLIST_HEAD(, AddressSpaceMapClient) map_client_list;
 };
 
 typedef struct AddressSpaceDispatch AddressSpaceDispatch;
diff --git a/system/memory.c b/system/memory.c
index 49f1cb2c38..642a449f8c 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3174,6 +3174,9 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     as->ioeventfds = NULL;
     QTAILQ_INIT(&as->listeners);
     QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
+    as->bounce.in_use = false;
+    qemu_mutex_init(&as->map_client_list_lock);
+    QLIST_INIT(&as->map_client_list);
     as->name = g_strdup(name ? name : "anonymous");
     address_space_update_topology(as);
     address_space_update_ioeventfds(as);
@@ -3181,6 +3184,10 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
 
 static void do_address_space_destroy(AddressSpace *as)
 {
+    assert(!qatomic_read(&as->bounce.in_use));
+    assert(QLIST_EMPTY(&as->map_client_list));
+    qemu_mutex_destroy(&as->map_client_list_lock);
+
     assert(QTAILQ_EMPTY(&as->listeners));
 
     flatview_unref(as->current_map);
diff --git a/system/physmem.c b/system/physmem.c
index 27e754ff57..62758202cf 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3046,26 +3046,8 @@ void cpu_flush_icache_range(hwaddr start, hwaddr len)
                                      NULL, len, FLUSH_CACHE);
 }
 
-typedef struct {
-    MemoryRegion *mr;
-    void *buffer;
-    hwaddr addr;
-    hwaddr len;
-    bool in_use;
-} BounceBuffer;
-
-static BounceBuffer bounce;
-
-typedef struct MapClient {
-    QEMUBH *bh;
-    QLIST_ENTRY(MapClient) link;
-} MapClient;
-
-QemuMutex map_client_list_lock;
-static QLIST_HEAD(, MapClient) map_client_list
-    = QLIST_HEAD_INITIALIZER(map_client_list);
-
-static void address_space_unregister_map_client_do(MapClient *client)
+static void
+address_space_unregister_map_client_do(AddressSpaceMapClient *client)
 {
     QLIST_REMOVE(client, link);
     g_free(client);
@@ -3073,10 +3055,10 @@ static void address_space_unregister_map_client_do(MapClient *client)
 
 static void address_space_notify_map_clients_locked(AddressSpace *as)
 {
-    MapClient *client;
+    AddressSpaceMapClient *client;
 
-    while (!QLIST_EMPTY(&map_client_list)) {
-        client = QLIST_FIRST(&map_client_list);
+    while (!QLIST_EMPTY(&as->map_client_list)) {
+        client = QLIST_FIRST(&as->map_client_list);
         qemu_bh_schedule(client->bh);
         address_space_unregister_map_client_do(client);
     }
@@ -3084,14 +3066,14 @@ static void address_space_notify_map_clients_locked(AddressSpace *as)
 
 void address_space_register_map_client(AddressSpace *as, QEMUBH *bh)
 {
-    MapClient *client = g_malloc(sizeof(*client));
+    AddressSpaceMapClient *client = g_malloc(sizeof(*client));
 
-    QEMU_LOCK_GUARD(&map_client_list_lock);
+    QEMU_LOCK_GUARD(&as->map_client_list_lock);
     client->bh = bh;
-    QLIST_INSERT_HEAD(&map_client_list, client, link);
+    QLIST_INSERT_HEAD(&as->map_client_list, client, link);
     /* Write map_client_list before reading in_use.  */
     smp_mb();
-    if (!qatomic_read(&bounce.in_use)) {
+    if (!qatomic_read(&as->bounce.in_use)) {
         address_space_notify_map_clients_locked(as);
     }
 }
@@ -3109,15 +3091,14 @@ void cpu_exec_init_all(void)
     finalize_target_page_bits();
     io_mem_init();
     memory_map_init();
-    qemu_mutex_init(&map_client_list_lock);
 }
 
 void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh)
 {
-    MapClient *client;
+    AddressSpaceMapClient *client;
 
-    QEMU_LOCK_GUARD(&map_client_list_lock);
-    QLIST_FOREACH(client, &map_client_list, link) {
+    QEMU_LOCK_GUARD(&as->map_client_list_lock);
+    QLIST_FOREACH(client, &as->map_client_list, link) {
         if (client->bh == bh) {
             address_space_unregister_map_client_do(client);
             break;
@@ -3127,7 +3108,7 @@ void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh)
 
 static void address_space_notify_map_clients(AddressSpace *as)
 {
-    QEMU_LOCK_GUARD(&map_client_list_lock);
+    QEMU_LOCK_GUARD(&as->map_client_list_lock);
     address_space_notify_map_clients_locked(as);
 }
 
@@ -3219,25 +3200,25 @@ void *address_space_map(AddressSpace *as,
     mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
 
     if (!memory_access_is_direct(mr, is_write)) {
-        if (qatomic_xchg(&bounce.in_use, true)) {
+        if (qatomic_xchg(&as->bounce.in_use, true)) {
             *plen = 0;
             return NULL;
         }
         /* Avoid unbounded allocations */
         l = MIN(l, TARGET_PAGE_SIZE);
-        bounce.buffer = qemu_memalign(TARGET_PAGE_SIZE, l);
-        bounce.addr = addr;
-        bounce.len = l;
+        as->bounce.buffer = qemu_memalign(TARGET_PAGE_SIZE, l);
+        as->bounce.addr = addr;
+        as->bounce.len = l;
 
         memory_region_ref(mr);
-        bounce.mr = mr;
+        as->bounce.mr = mr;
         if (!is_write) {
             flatview_read(fv, addr, MEMTXATTRS_UNSPECIFIED,
-                               bounce.buffer, l);
+                          as->bounce.buffer, l);
         }
 
         *plen = l;
-        return bounce.buffer;
+        return as->bounce.buffer;
     }
 
 
@@ -3255,7 +3236,7 @@ void *address_space_map(AddressSpace *as,
 void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
                          bool is_write, hwaddr access_len)
 {
-    if (buffer != bounce.buffer) {
+    if (buffer != as->bounce.buffer) {
         MemoryRegion *mr;
         ram_addr_t addr1;
 
@@ -3271,14 +3252,14 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
         return;
     }
     if (is_write) {
-        address_space_write(as, bounce.addr, MEMTXATTRS_UNSPECIFIED,
-                            bounce.buffer, access_len);
+        address_space_write(as, as->bounce.addr, MEMTXATTRS_UNSPECIFIED,
+                            as->bounce.buffer, access_len);
     }
-    qemu_vfree(bounce.buffer);
-    bounce.buffer = NULL;
-    memory_region_unref(bounce.mr);
+    qemu_vfree(as->bounce.buffer);
+    as->bounce.buffer = NULL;
+    memory_region_unref(as->bounce.mr);
     /* Clear in_use before reading map_client_list.  */
-    qatomic_set_mb(&bounce.in_use, false);
+    qatomic_set_mb(&as->bounce.in_use, false);
     address_space_notify_map_clients(as);
 }
 
-- 
2.43.2


