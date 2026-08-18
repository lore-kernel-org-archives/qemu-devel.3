Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1169FC5DF8A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 05:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwZFe-0001S5-0y; Wed, 19 Aug 2026 01:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3PcSEagcKCjQZQSaobYWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--jackyli.bounces.google.com>)
 id 1wwQg1-0005zi-Jp
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:44:53 -0400
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3PcSEagcKCjQZQSaobYWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--jackyli.bounces.google.com>)
 id 1wwQfw-0007L9-ID
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:44:50 -0400
Received: by mail-pl1-x648.google.com with SMTP id
 d9443c01a7336-2cfa55c9430so2324745ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 13:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787085886; x=1787690686; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XSfBO46rQqbTNTbJ8xMsfzE0sjSykEikLSHsdbiM95o=;
 b=wDkJ5/vxoINJvcQEUVriaNpNFmk/cKSYKjeq6Q/TqodTysmCIU0MCiefYUQ0JDJjd0
 +ByArmvqfAS4TkaCPlUep8ozubfnlgjuLQvAYlWSIE8NcS/As0KPMSw1bk5FppeHlP9X
 j//9XzXHiXZ9WganUhmtS97Id7LWNAgRGjnBW1xAirQWuIOMxVV6xZFkdHUrUPAITd5I
 NqySrTCR0mRY4QkmPLdptvldf34OP70aEyFVo9xhAFYCMv8YNN65kPViB9bSso5KGbt1
 CIDsfGWvz6biHIhNVUhhdFj2nrV7wzVQdR/HiBCRSAw9OsgCPx4HjyG4ieLYimQxmjgf
 Y6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787085886; x=1787690686;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XSfBO46rQqbTNTbJ8xMsfzE0sjSykEikLSHsdbiM95o=;
 b=J1SuC9UxiaZeNUrQiOxMahsdpLrm+aKx5blHDsejDwVj+PM+aDLwY2c+AGXqasucBE
 lGF66UIyfNOdVNpx42+VWsbTtsqBi3YfKYh+5qEoq2sNNA6Fu6s654lxPGItvtYm7GXe
 9TpeG05fBdxf229KmzZsn8gLCH2HTf3nRx3FfzA0k6r8lRceqbShADFPdlp812iMAlaE
 jbONwue/3qHEs8J3/+jc15ihS643LqpPdet6V3H3sep73irAc9lC+L7RXvM0KihNO0Xd
 ZgDKCeo45o0eake8xmMQZ4NzJMUkFc70q7cBAPvRmgcPhvSA+5znHZsopa81cWSYf4tH
 BX8A==
X-Gm-Message-State: AOJu0YwZ30enAaX9HtT+6Ei5zr2XtNC8ddmTYqPBlqcDWX2ga2n6o+hA
 fLOWVvANqqdPlaiEG/+AoTGsPbdkPSAUmT79xmSiF1fBjOHpC9m2Pn/ObTzrtYlnK+e4KEwmZEv
 isSljBzPH7s0zwKv5axCS+4AYnn7HC42xkGVEGgfdHejLa7rVUxEhlr0HIZ4Oi3C80KjgjufzuU
 ceYXpO3fywwhs5fQ52BCrfxvmY4DCS2VAX8vWGnco=
X-Received: from pglg36.prod.google.com ([2002:a63:1124:0:b0:cc1:522f:464c])
 (user=jackyli job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:cd96:b0:3bf:6d96:ac40
 with SMTP id adf61e73a8af0-3ccfef7af73mr837294637.12.1787085885436; Tue, 18
 Aug 2026 13:44:45 -0700 (PDT)
Date: Tue, 18 Aug 2026 20:44:17 +0000
In-Reply-To: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
Mime-Version: 1.0
References: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260818-feature-pkey-dev-v1-3-8c0ef96a4da9@google.com>
Subject: [RFC PATCH 3/6] physmem: Tag guest RAMBlocks with Protection Key
From: Jacky Li <jackyli@google.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "=?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=" <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, 
 James Houghton <jthoughton@google.com>, Mingwei Zhang <mizhang@google.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>,
 Brendan Jackman <jackmanb@google.com>, 
 Reiji Watanabe <reijiw@google.com>, Jacky Li <jackyli@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::648;
 envelope-from=3PcSEagcKCjQZQSaobYWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--jackyli.bounces.google.com;
 helo=mail-pl1-x648.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Aug 2026 01:54:07 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Apply the allocated guest memory protection key to all guest RAMBlocks
using `pkey_mprotect()` to enforce hardware-assisted access control.

This ensures that guest physical RAM mappings are tagged with our
dedicated Pkey in the host page tables, allowing the PKRU register to
dynamically permit or block access to guest memory.

Signed-off-by: Jacky Li <jackyli@google.com>
---
 include/exec/cpu-common.h |  1 +
 include/qemu/mmap-alloc.h |  5 +++++
 system/physmem.c          | 16 ++++++++++++++--
 util/mmap-alloc.c         |  3 +--
 util/pkey.c               | 16 ++++++++++++++++
 5 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 5ede0c65dc..28399088f6 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -113,4 +113,5 @@ static inline CPUState *env_cpu(CPUArchState *env)
 }
 
 void qemu_init_guest_memory_pkey(void);
+int qemu_pkey_mprotect_guest_memory(void *addr, size_t len, int prot);
 #endif /* CPU_COMMON_H */
diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
index 8344daaa03..82fe7f0c3d 100644
--- a/include/qemu/mmap-alloc.h
+++ b/include/qemu/mmap-alloc.h
@@ -63,4 +63,9 @@ void qemu_ram_munmap(int fd, void *ptr, size_t size);
  */
 #define QEMU_MAP_NORESERVE  (1 << 3)
 
+static inline int qemu_map_flags_to_prot(uint32_t qemu_map_flags)
+{
+  return PROT_READ | ((qemu_map_flags & QEMU_MAP_READONLY) ? 0 : PROT_WRITE);
+}
+
 #endif
diff --git a/system/physmem.c b/system/physmem.c
index 362a00f76c..9f5a0f194c 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2144,6 +2144,12 @@ static void dirty_memory_extend(ram_addr_t new_ram_size)
     ram_list.num_dirty_blocks = new_num_blocks;
 }
 
+static inline int ramblock_get_prot(const RAMBlock *rb)
+{
+  uint32_t map_flags = (rb->flags & RAM_READONLY) ? QEMU_MAP_READONLY : 0;
+  return qemu_map_flags_to_prot(map_flags);
+}
+
 static void ram_block_add(RAMBlock *new_block, Error **errp)
 {
     const bool noreserve = qemu_ram_is_noreserve(new_block);
@@ -2282,6 +2288,13 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         }
         ram_block_notify_add(new_block->host, new_block->used_length,
                              new_block->max_length);
+        int prot = ramblock_get_prot(new_block);
+        int ret = qemu_pkey_mprotect_guest_memory(new_block->host,
+                                                  new_block->max_length, prot);
+        if (ret != 0) {
+            error_report("qemu_pkey_mprotect failed for guest RAMBlock: %s",
+                         strerror(errno));
+        }
     }
     return;
 
@@ -2624,8 +2637,7 @@ static int qemu_ram_remap_mmap(RAMBlock *block, uint64_t start, size_t length)
     flags = MAP_FIXED | MAP_ANONYMOUS;
     flags |= block->flags & RAM_SHARED ? MAP_SHARED : MAP_PRIVATE;
     flags |= block->flags & RAM_NORESERVE ? MAP_NORESERVE : 0;
-    prot = PROT_READ;
-    prot |= block->flags & RAM_READONLY ? 0 : PROT_WRITE;
+    prot = ramblock_get_prot(block);
     area = mmap(host_startaddr, length, prot, flags, -1, 0);
     return area != host_startaddr ? -errno : 0;
 }
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index ed14f9c64d..0dc8e8275d 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -185,10 +185,9 @@ static void *mmap_activate(void *ptr, size_t size, int fd,
                            uint32_t qemu_map_flags, off_t map_offset)
 {
     const bool noreserve = qemu_map_flags & QEMU_MAP_NORESERVE;
-    const bool readonly = qemu_map_flags & QEMU_MAP_READONLY;
     const bool shared = qemu_map_flags & QEMU_MAP_SHARED;
     const bool sync = qemu_map_flags & QEMU_MAP_SYNC;
-    const int prot = PROT_READ | (readonly ? 0 : PROT_WRITE);
+    const int prot = qemu_map_flags_to_prot(qemu_map_flags);
     int map_sync_flags = 0;
     int flags = MAP_FIXED;
     void *activated_ptr;
diff --git a/util/pkey.c b/util/pkey.c
index 249e36d508..0151714f32 100644
--- a/util/pkey.c
+++ b/util/pkey.c
@@ -106,6 +106,17 @@ __attribute__((target("pku"))) void qemu_init_guest_memory_pkey(void)
     }
 }
 
+__attribute__((target("pku"))) int qemu_pkey_mprotect_guest_memory(void *addr,
+                                                                   size_t len,
+                                                                   int prot)
+{
+    int pkey = guest_memory_pkey;
+    if (pkey == -1) {
+        return 0;
+    }
+    return pkey_mprotect(addr, len, prot, pkey);
+}
+
 #else
 /* Dummy implementations for all other configurations (non-x86_64 Linux, */
 /* Windows, macOS, etc.) */
@@ -116,4 +127,9 @@ __attribute__((target("pku"))) void qemu_init_guest_memory_pkey(void)
 
 void qemu_init_guest_memory_pkey(void)
 {}
+
+int qemu_pkey_mprotect_guest_memory(void *addr, size_t len, int prot)
+{
+    return 0;
+}
 #endif

-- 
2.55.0.737.g08866a6d13-goog


