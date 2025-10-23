Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C87CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 19:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC0X6-0006Xy-2m; Thu, 23 Oct 2025 14:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vC0X1-0006WE-IF
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:59:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vC0Wz-0003DH-Go
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761245964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wXNchoUnOoPSy+plqVmY72NjzGvh8U57fWb0kC1DiMw=;
 b=FgLc/kAaB57O0rmUiTNdJixWKkK8q1ggAOan/ZpuKevgsql3zViqFboxMhTl8DGzCfoxov
 BCRXFUZY8US2f3dYkwm3L8/jmVv9/+7OR4Pgju+Tc6OhSRgpSPBprBWSqG8uTO+Ome6DWJ
 F/KOf4eQVziJBcYziN82OjmArEZMy98=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-CuNKT0XoPVmOgyr00l-uXg-1; Thu, 23 Oct 2025 14:59:23 -0400
X-MC-Unique: CuNKT0XoPVmOgyr00l-uXg-1
X-Mimecast-MFC-AGG-ID: CuNKT0XoPVmOgyr00l-uXg_1761245963
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8910b0fb780so186180285a.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 11:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761245963; x=1761850763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wXNchoUnOoPSy+plqVmY72NjzGvh8U57fWb0kC1DiMw=;
 b=PNfuRgvOarQGvG7eZpmqqwffdy4DfDvandE3dUyvP90EAilmHag5oKQB2CCne+vYSA
 2qU7/3/J4YmGuCRAr6W6gRTk26E5uKXFDJvc9O3EH1W34LGgKVzwZAitPLPanadzkpQG
 zv6Zo3sXsaui7trMHEWQ57ZhptRzqvwePxtgLxMPDm+ZJe07JFysGQsdbTRNfijqHNE4
 JXCrW824C4vwcv27Wbq7Al3Pq1NPuw4Zg2i/0fzWHOVyjRWa0xEAt2wMxmJt+iwV5Ehl
 pXFstg5DCyN7fkFaG7a2b2wKRPc3PV1bPTIOFJ2MeLWA1iuNBfWUy80dbIcQium3rc2m
 ziEw==
X-Gm-Message-State: AOJu0YxTImb4N6GlEq+nZIh04IUUAijQoMRLYOG2UIlOQMIe02qYfVwI
 CVdGxP5ZJ6VpTtUdBW9Jp/jrjVkIhkoLwKUOELAYtBmlEj5g64Qhj/L2NCdA98C37Yg0FuEOh7p
 jV8AVnC5WPYQMsOeEDyup/GS3oNfANFIebPZxn1NzV5PiknAWqmtSvJ+EKlmIwKcge4sw463/7Y
 yVCo3dmbZE5I9CGMk2BqvsrI1mu0y8TyNGCXWekg==
X-Gm-Gg: ASbGncvBjnrpilUhPwu/qtFI8eBf86LVtaUbp4wwgvmf2YHCSeUgspwnWo/LQF5vU+R
 MJ0xwkihQT+ha2gEGwomKlAGQJ1ti9go0JTkE0eDUquRvnE89gnH368kofNIcqQ+z40ymhkERwZ
 x89mGIH3W/yfiZ5Gj2q2vdrJUxlWK0dJSqPfPavZ0lYaQ+TyBrP+kX/pcUZ2SL9VqwglfIDcwfw
 WcGXrqXEKaLWJbMFe2UxCGKmoRzR5UyY1TQbUyaCAJkBsqzjQMBlGa1DNhKyFe+GFfP4VlwVwTP
 NbRBrhlufI6dOZDs1clANiKYY8A7k/TzzoXv6ipLJPhxRQj4ij3wogW2t5KoMqoS
X-Received: by 2002:a05:620a:2685:b0:891:9a42:af0 with SMTP id
 af79cd13be357-8919a420ba6mr2603409185a.25.1761245962672; 
 Thu, 23 Oct 2025 11:59:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq/z4ltPoLTBhfBNUy0/LnzBNbfaP4+ZaZAXp6VGAqpgFzNb6xddwKB0GzcZrbc8H7kLbStQ==
X-Received: by 2002:a05:620a:2685:b0:891:9a42:af0 with SMTP id
 af79cd13be357-8919a420ba6mr2603404685a.25.1761245962072; 
 Thu, 23 Oct 2025 11:59:22 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89c0ec61770sm213940585a.26.2025.10.23.11.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 11:59:21 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 4/8] memory: Rename RAM_GUEST_MEMFD to RAM_GUEST_MEMFD_PRIVATE
Date: Thu, 23 Oct 2025 14:59:09 -0400
Message-ID: <20251023185913.2923322-5-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251023185913.2923322-1-peterx@redhat.com>
References: <20251023185913.2923322-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This name is too generic, and can conflict with in-place guest-memfd
support.  Add a _PRIVATE suffix to show what it really means: it is always
silently using an internal guest-memfd to back a shared host backend,
rather than used in-place.

This paves way for in-place guest-memfd, which means we can have a ramblock
that allocates pages completely from guest-memfd (private or shared).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h   | 8 ++++----
 include/system/ram_addr.h | 2 +-
 backends/hostmem-file.c   | 2 +-
 backends/hostmem-memfd.c  | 2 +-
 backends/hostmem-ram.c    | 2 +-
 system/memory.c           | 2 +-
 system/physmem.c          | 8 ++++----
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 3bd5ffa5e0..2c1a5e06b4 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -263,7 +263,7 @@ typedef struct IOMMUTLBEvent {
 #define RAM_READONLY_FD (1 << 11)
 
 /* RAM can be private that has kvm guest memfd backend */
-#define RAM_GUEST_MEMFD   (1 << 12)
+#define RAM_GUEST_MEMFD_PRIVATE   (1 << 12)
 
 /*
  * In RAMBlock creation functions, if MAP_SHARED is 0 in the flags parameter,
@@ -1401,7 +1401,7 @@ bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
  *        must be unique within any device
  * @size: size of the region.
  * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_NORESERVE,
- *             RAM_GUEST_MEMFD.
+ *             RAM_GUEST_MEMFD_PRIVATE.
  * @errp: pointer to Error*, to store an error if it happens.
  *
  * Note that this function does not do anything to cause the data in the
@@ -1463,7 +1463,7 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
  *         (getpagesize()) will be used.
  * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
  *             RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
- *             RAM_READONLY_FD, RAM_GUEST_MEMFD
+ *             RAM_READONLY_FD, RAM_GUEST_MEMFD_PRIVATE
  * @path: the path in which to allocate the RAM.
  * @offset: offset within the file referenced by path
  * @errp: pointer to Error*, to store an error if it happens.
@@ -1493,7 +1493,7 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr,
  * @size: size of the region.
  * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
  *             RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
- *             RAM_READONLY_FD, RAM_GUEST_MEMFD
+ *             RAM_READONLY_FD, RAM_GUEST_MEMFD_PRIVATE
  * @fd: the fd to mmap.
  * @offset: offset within the file referenced by fd
  * @errp: pointer to Error*, to store an error if it happens.
diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index 683485980c..930d3824d7 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -92,7 +92,7 @@ static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
  *  @resized: callback after calls to qemu_ram_resize
  *  @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
  *              RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
- *              RAM_READONLY_FD, RAM_GUEST_MEMFD
+ *              RAM_READONLY_FD, RAM_GUEST_MEMFD_PRIVATE
  *  @mem_path or @fd: specify the backing file or device
  *  @offset: Offset into target file
  *  @grow: extend file if necessary (but an empty file is always extended).
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 8e3219c061..1f20cd8fd6 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -86,7 +86,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     ram_flags |= fb->readonly ? RAM_READONLY_FD : 0;
     ram_flags |= fb->rom == ON_OFF_AUTO_ON ? RAM_READONLY : 0;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
+    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
     ram_flags |= fb->is_pmem ? RAM_PMEM : 0;
     ram_flags |= RAM_NAMED_FILE;
     return memory_region_init_ram_from_file(&backend->mr, OBJECT(backend), name,
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 923239f9cf..3f3e485709 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -60,7 +60,7 @@ have_fd:
     backend->aligned = true;
     ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
+    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
     return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
                                           backend->size, ram_flags, fd, 0, errp);
 }
diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
index 062b1abb11..96ad29112d 100644
--- a/backends/hostmem-ram.c
+++ b/backends/hostmem-ram.c
@@ -30,7 +30,7 @@ ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     name = host_memory_backend_get_name(backend);
     ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
+    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
     return memory_region_init_ram_flags_nomigrate(&backend->mr, OBJECT(backend),
                                                   name, backend->size,
                                                   ram_flags, errp);
diff --git a/system/memory.c b/system/memory.c
index 8b84661ae3..006b03ce1c 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3755,7 +3755,7 @@ bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
     DeviceState *owner_dev;
 
     if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
-                                                RAM_GUEST_MEMFD, errp)) {
+                                                RAM_GUEST_MEMFD_PRIVATE, errp)) {
         return false;
     }
     /* This will assert if owner is neither NULL nor a DeviceState.
diff --git a/system/physmem.c b/system/physmem.c
index a340ca3e61..1a186739a8 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2203,7 +2203,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         }
     }
 
-    if (new_block->flags & RAM_GUEST_MEMFD) {
+    if (new_block->flags & RAM_GUEST_MEMFD_PRIVATE) {
         int ret;
 
         if (!kvm_enabled()) {
@@ -2333,7 +2333,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
     /* Just support these ram flags by now. */
     assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
                           RAM_PROTECTED | RAM_NAMED_FILE | RAM_READONLY |
-                          RAM_READONLY_FD | RAM_GUEST_MEMFD |
+                          RAM_READONLY_FD | RAM_GUEST_MEMFD_PRIVATE |
                           RAM_RESIZEABLE)) == 0);
     assert(max_size >= size);
 
@@ -2490,7 +2490,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     ram_flags &= ~RAM_PRIVATE;
 
     assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
-                          RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
+                          RAM_NORESERVE | RAM_GUEST_MEMFD_PRIVATE)) == 0);
     assert(!host ^ (ram_flags & RAM_PREALLOC));
     assert(max_size >= size);
 
@@ -2573,7 +2573,7 @@ RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
 RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags,
                          MemoryRegion *mr, Error **errp)
 {
-    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_GUEST_MEMFD |
+    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_GUEST_MEMFD_PRIVATE |
                           RAM_PRIVATE)) == 0);
     return qemu_ram_alloc_internal(size, size, NULL, NULL, ram_flags, mr, errp);
 }
-- 
2.50.1


