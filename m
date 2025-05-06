Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C6CC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKFp-00050k-72; Tue, 06 May 2025 11:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFf-0004SV-3T
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFc-0002FX-MG
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C5Ju4evq2YqeHvMjiYaM16V7/xodF9usCN81W1Yk6wA=;
 b=W4wKIWRyyawPZI2e1URzf8QSxTQNzpBxFVlV1AVFakHRh86gfaiuZCMP+6rc5CKr84XXBj
 PLp37qZUHQBdqEl90PaFu5KdQBBo7j+IUGI94NOFzv0kn3u9cndvayhEqfXdSGFWP54QMS
 9DqLKQwS8Ob6fx4pEQyFbeh7g8ZCi68=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-eIEWwCfyNwGDGDn7UVpVkg-1; Tue, 06 May 2025 11:30:27 -0400
X-MC-Unique: eIEWwCfyNwGDGDn7UVpVkg-1
X-Mimecast-MFC-AGG-ID: eIEWwCfyNwGDGDn7UVpVkg_1746545426
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39c184b20a2so1889155f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545425; x=1747150225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C5Ju4evq2YqeHvMjiYaM16V7/xodF9usCN81W1Yk6wA=;
 b=nOowtAdzV343LgI1KFdR9GrW4/Iwj/hV4oxFPxyRaCiME2KL+dBo//LJVYOOFrd1M7
 TOh/gJWghF/I+CYHAoIHrNV+byTq8jYTE/n4ydB1qwJFXKuNEb6t29DKR+gJ7vJoYcUj
 tD6Jw5mRxmjc5IaHkekf/E4n5/cWJmI3wHr80Rk5++/OPYsPSnDBN0nlR0rLTJX3e/FU
 xzcwiqR95Hmq+6zoOqvSDyJ6fOq+tB8cIJY7ky0ouHv2YsL3N6Ah4yrt5QwIDLsoV8DY
 aX8pzPwwHEqrk3MD6oJ9kPNlvd3gnkCxkPelqnKSK8Lzm1WfGHs98JF0INPg5hWHoPCs
 aJZQ==
X-Gm-Message-State: AOJu0YyqZdmdLHJQN+KfNzZQjHZy5Csuxp6ZJShI8aAkXgGCBr0YUjZA
 7JXX+3i3BjQkMeM6e4h6qIaMB93mSLsqntDODBnFJap/XZ/w5A/URYvXEHxeG0WdxBLGXAEErzf
 bYZxzvcPuJV9oTvYJL5xVNJW5wG+grwEBrm1ozbMtfRLZvEim/cLNdNpLLN1cJnTLPgyjVxaF0t
 nJIkACsW3YEXXBl/MG2nuzekbydiZ3lTcnnG1p
X-Gm-Gg: ASbGncs91SVBtBJoao365byu35A+DfY5okO3u32L9lva6448dbche4K5ZF72QL0jVqA
 fREAWEZmYLZh8mQZikP7FvMqVookTXWLoKz2dDiaAFHf0uW9/HKKq4OmAjoLa3REmScYqBbybeu
 qJbAXdWb3iic8crwQ17LcPYL31tFz0rLyPQOwXDMblDm957w5Ky5zpevgGIC8jEYvud2QbzN28X
 BtfuqKKbx2NQW8yaCS32xw4ar/ErXJDz6ua9+5iXYvv9jHTUsAwS382WMm/uxRmi/wyxFu3YEeF
 c9q3kyIS88cXtqk=
X-Received: by 2002:a05:6000:3101:b0:38d:dd52:1b5d with SMTP id
 ffacd0b85a97d-3a0ac0c9a91mr2943485f8f.4.1746545424917; 
 Tue, 06 May 2025 08:30:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE16vgCupAVsx+zqLbeSEVOxW4cFe8/A+G8Klk28WZ7FwcX6/VPuAd720PaslAVpdC+kcuaQ==
X-Received: by 2002:a05:6000:3101:b0:38d:dd52:1b5d with SMTP id
 ffacd0b85a97d-3a0ac0c9a91mr2943453f8f.4.1746545424350; 
 Tue, 06 May 2025 08:30:24 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b0f09dsm14163236f8f.63.2025.05.06.08.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:30:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: [PULL 26/30] util: exclude mmap-alloc.c from compilation target on
 Emscripten
Date: Tue,  6 May 2025 17:29:21 +0200
Message-ID: <20250506152927.222671-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kohei Tokunaga <ktokunaga.mail@gmail.com>

Emscripten does not support partial unmapping of mmapped memory
regions[1]. This limitation prevents correct implementation of qemu_ram_mmap
and qemu_ram_munmap, which rely on partial unmap behavior.

As a workaround, this commit excludes mmap-alloc.c from the Emscripten
build. Instead, for Emscripten build, this modifies qemu_anon_ram_alloc to
use qemu_memalign in place of qemu_ram_mmap, and disable memory backends
that rely on mmap, such as memory-backend-file and memory-backend-shm.

[1] https://github.com/emscripten-core/emscripten/blob/d4a74336f23214bf3304d9eb0d03966786b30a36/system/lib/libc/emscripten_mmap.c#L61

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Link: https://lore.kernel.org/r/76834f933ee4f14eeb5289d21c59d306886e58e9.1745820062.git.ktokunaga.mail@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 system/memory.c      |  2 +-
 system/physmem.c     |  9 +++++----
 util/oslib-posix.c   | 28 ++++++++++++++++++++++++++++
 backends/meson.build |  6 ++++--
 util/meson.build     |  4 +++-
 5 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 71434e7ad02..63b983efcdb 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1627,7 +1627,7 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
     return true;
 }
 
-#ifdef CONFIG_POSIX
+#if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
 bool memory_region_init_ram_from_file(MemoryRegion *mr,
                                       Object *owner,
                                       const char *name,
diff --git a/system/physmem.c b/system/physmem.c
index 16cf557d1a1..4a7a2e5e12b 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1243,7 +1243,7 @@ long qemu_maxrampagesize(void)
     return pagesize;
 }
 
-#ifdef CONFIG_POSIX
+#if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
 static int64_t get_file_size(int fd)
 {
     int64_t size;
@@ -1978,7 +1978,7 @@ out_free:
     }
 }
 
-#ifdef CONFIG_POSIX
+#if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
 RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
                                  qemu_ram_resize_cb resized, MemoryRegion *mr,
                                  uint32_t ram_flags, int fd, off_t offset,
@@ -2158,7 +2158,8 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     assert(!host ^ (ram_flags & RAM_PREALLOC));
     assert(max_size >= size);
 
-#ifdef CONFIG_POSIX         /* ignore RAM_SHARED for Windows */
+    /* ignore RAM_SHARED for Windows and emscripten*/
+#if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
     if (!host) {
         if (!share_flags && current_machine->aux_ram_share) {
             ram_flags |= RAM_SHARED;
@@ -2255,7 +2256,7 @@ static void reclaim_ramblock(RAMBlock *block)
         ;
     } else if (xen_enabled()) {
         xen_invalidate_map_cache_entry(block->host);
-#ifndef _WIN32
+#if !defined(_WIN32) && !defined(EMSCRIPTEN)
     } else if (block->fd >= 0) {
         qemu_ram_munmap(block->fd, block->host, block->max_length);
         close(block->fd);
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index a697c602c60..4ff577e5de6 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -58,6 +58,7 @@
 #include <lwp.h>
 #endif
 
+#include "qemu/memalign.h"
 #include "qemu/mmap-alloc.h"
 
 #define MAX_MEM_PREALLOC_THREAD_COUNT 16
@@ -210,11 +211,21 @@ void *qemu_anon_ram_alloc(size_t size, uint64_t *alignment, bool shared,
     const uint32_t qemu_map_flags = (shared ? QEMU_MAP_SHARED : 0) |
                                     (noreserve ? QEMU_MAP_NORESERVE : 0);
     size_t align = QEMU_VMALLOC_ALIGN;
+#ifndef EMSCRIPTEN
     void *ptr = qemu_ram_mmap(-1, size, align, qemu_map_flags, 0);
 
     if (ptr == MAP_FAILED) {
         return NULL;
     }
+#else
+    /*
+     * qemu_ram_mmap is not implemented for Emscripten. Use qemu_memalign
+     * for the anonymous allocation. noreserve is ignored as there is no swap
+     * space on Emscripten, and shared is ignored as there is no other
+     * processes on Emscripten.
+     */
+    void *ptr = qemu_memalign(align, size);
+#endif
 
     if (alignment) {
         *alignment = align;
@@ -227,7 +238,16 @@ void *qemu_anon_ram_alloc(size_t size, uint64_t *alignment, bool shared,
 void qemu_anon_ram_free(void *ptr, size_t size)
 {
     trace_qemu_anon_ram_free(ptr, size);
+#ifndef EMSCRIPTEN
     qemu_ram_munmap(-1, ptr, size);
+#else
+    /*
+     * qemu_ram_munmap is not implemented for Emscripten and qemu_memalign
+     * was used for the allocation. Use the corresponding freeing function
+     * here.
+     */
+    qemu_vfree(ptr);
+#endif
 }
 
 void qemu_socket_set_block(int fd)
@@ -588,7 +608,15 @@ bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
 {
     static gsize initialized;
     int ret;
+#ifndef EMSCRIPTEN
     size_t hpagesize = qemu_fd_getpagesize(fd);
+#else
+    /*
+     * mmap-alloc.c is excluded from Emscripten build, so qemu_fd_getpagesize
+     * is unavailable. Fallback to the lower level implementation.
+     */
+    size_t hpagesize = qemu_real_host_page_size();
+#endif
     size_t numpages = DIV_ROUND_UP(sz, hpagesize);
     bool use_madv_populate_write;
     struct sigaction act;
diff --git a/backends/meson.build b/backends/meson.build
index da714b93d1e..9b88d226851 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -12,8 +12,10 @@ system_ss.add([files(
 
 if host_os != 'windows'
   system_ss.add(files('rng-random.c'))
-  system_ss.add(files('hostmem-file.c'))
-  system_ss.add([files('hostmem-shm.c'), rt])
+  if host_os != 'emscripten'
+    system_ss.add(files('hostmem-file.c'))
+    system_ss.add([files('hostmem-shm.c'), rt])
+  endif
 endif
 if host_os == 'linux'
   system_ss.add(files('hostmem-memfd.c'))
diff --git a/util/meson.build b/util/meson.build
index 780b5977a89..e5cd327e276 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -11,7 +11,9 @@ if host_os != 'windows'
   endif
   util_ss.add(files('compatfd.c'))
   util_ss.add(files('event_notifier-posix.c'))
-  util_ss.add(files('mmap-alloc.c'))
+  if host_os != 'emscripten'
+    util_ss.add(files('mmap-alloc.c'))
+  endif
   freebsd_dep = []
   if host_os == 'freebsd'
     freebsd_dep = util
-- 
2.49.0


