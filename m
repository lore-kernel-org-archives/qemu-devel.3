Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF513C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 12:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Jyt-0006Ga-HW; Tue, 07 May 2024 08:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4Jy9-0005q2-GL
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:30:55 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4Jy7-000785-CL
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:30:53 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41dc9f98e8dso30258365e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 05:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715085049; x=1715689849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ObHVYohrlZDRKitLEsGTx0PDw1Uh/6I7bCMcmj67Ys=;
 b=VeNgHs7lcfHiohDOzeWkrLbb2MOW+1R4U0uvFddp9wMt7+fpM92bC8BLXtDMH4I1LA
 MdykV0POf+MZG7Cpg2tIPkN+HhECgp31UzpsHEaw7QDt5kdCXcJpOpShWeHvVTUiZQdW
 ork9D+UKLMem69cMcUyHQyZOjh/8fhW8sXszDc18n7BKK4n35DvbhNqeQ4XIHCsKWgCB
 HF3CFGTyMloTJlIMindXt4HOCqDv7quL3YLUnIRfZzZ5vBTyPwrs88HSjL+mANk7cm4m
 yFEdo0R+vGZoGDjHLFdn+QT9vcxYo8E1raent0QsB1BG5UpqKji8NqOculOkMeGXDFjZ
 MHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715085049; x=1715689849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ObHVYohrlZDRKitLEsGTx0PDw1Uh/6I7bCMcmj67Ys=;
 b=s0J/O1fOcsEB5aW5eQsKTNarcTtYRgil7MqjJqug6IP00vA59N/BtpGmQ/a60gRPbx
 C1Im2WtfxYx/9C5LJApgaR0aG29DXBApYa9hv7ew9spHkb3B0EWkjGkdmrVPGOkUfw9z
 4jJK56crW77V+TvabnUO8I77jJBv7RUG8FCdgN2EnqGge6qbeye0+Xa1qe5lSst7AV3N
 FeNMkadB1SDQr+6lBQErlcAF9/6ithZiAF4XI5AU7TVMw5ECySiw+4s4sLvA9+1B1WCe
 pXskndlFzmGKFet0nCoDxvHHlcyi0rr/uNWBy+dr3V/KVNrDCQDR8vyxATGbt1BDgJID
 FvZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVckaizpsiOWOLQWLHJGnLFgfcAwj5XAY/AByYLkEbj5/bcfKxnU6jASOyRmLvS+TO/g29+PDiMaEptxETPCv9sMlLbGM0=
X-Gm-Message-State: AOJu0YyXWVKEP/Pz5cusLJUntE42xi3Zih+rTSPc8a1TDngTLpk6Elsr
 FGTcFsxYRnSSLPTMXhbboHoO+t8XAyxsEGISwKEHfNb0hE+SaGvhMSC/0jHdP0hUlCzZkFrm2rC
 u
X-Google-Smtp-Source: AGHT+IFwo3AhvMPDMiLr4fbk6xAeUBUgipcUkehoKg93D86niPRGSAYZu0Sjn/RdFobt8J3hRsK01A==
X-Received: by 2002:a5d:58d7:0:b0:34d:93c1:c7d8 with SMTP id
 o23-20020a5d58d7000000b0034d93c1c7d8mr2319410wrf.4.1715085049534; 
 Tue, 07 May 2024 05:30:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.177.243])
 by smtp.gmail.com with ESMTPSA id
 s8-20020adfecc8000000b0034dda041ccasm12908426wro.102.2024.05.07.05.30.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 May 2024 05:30:48 -0700 (PDT)
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
Subject: [PATCH 3/3] system/physmem: Per-AddressSpace bounce buffering
Date: Tue,  7 May 2024 14:30:25 +0200
Message-ID: <20240507123025.93391-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240507123025.93391-1-philmd@linaro.org>
References: <20240507123025.93391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
2.41.0


