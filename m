Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E468C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 22:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thz6M-0005k0-3v; Tue, 11 Feb 2025 17:51:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz6K-0005iy-PI
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz6I-00056z-Qo
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739314290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dgza/Y0wiw4u+TyuTMHe0Q7D53LiwmAz3XUt+5camiA=;
 b=KBtg5UphyY2TR7Gs/rYc/TsWt3yMIh4jzu6omDuVoX8IUvVrZSwSNoTvP9zwCIlaVTVfRk
 Ii86kyz8SNdNrKOt9ERCpsoogBoaIywiaRioui7+iAhZrOF/okHTE3uaSU/kqARkTWMu1Q
 QOldWLRdVaePkFG5pkMaOx/6Odj2Vc8=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-UUkp4txgM7uj2fEdB8Rc2w-1; Tue, 11 Feb 2025 17:51:28 -0500
X-MC-Unique: UUkp4txgM7uj2fEdB8Rc2w-1
X-Mimecast-MFC-AGG-ID: UUkp4txgM7uj2fEdB8Rc2w
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-726e862d3b9so1715263a34.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 14:51:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739314287; x=1739919087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dgza/Y0wiw4u+TyuTMHe0Q7D53LiwmAz3XUt+5camiA=;
 b=T7NW+cAOSwReYS1Az+qLebkAXfLbbkINc3iO5TH9L58+0QClFoMMTfHNhavXOfApmz
 GLF1uQx4Bnb0d+VB0plhY5rGEy9KLXu5OzKtDCgzfBOGV3pLLX34zwjqDd2eYvstcx79
 cZYC4IjUYgMcKUn854i+7KuwKroi16153qlIOpRP1CIr7a3U/yuGKuYpp7YneiVHFNIt
 //i2x4VApwKLVQavNrZdLxDEcz9NMtMrJ5um8XQVZhDPUVczpRBqG4P4e897EJHs+b/t
 UZTVAYBsqvesSqWRk3NtfD3wdim3U1iHECZ1JC7NBDoQbScMmknLHhZFr0hAFtk/DqP5
 Fysw==
X-Gm-Message-State: AOJu0YxeWdykk0BDXQtGzrNpJ0W32+iA/C3xo3BpjTFrBKUtQkS2MPt2
 eJE9xVAMZOQXpZT6lc+eNFehTtwqEOYI1yKoqxWCELQ+VaYgRPVxe9b1ZAHi4BznL34MCCr6iEq
 C0tUNqMgLixBx9DYMf7tCIm5pV2iOhb3ObhXdi8kcUHn2cGhiPEOI3IE30gC3H0v/J5cYbWtM2U
 jH+p+VVBnK3wLgDBNPcMLC3NBpZFf7Q/rD9A==
X-Gm-Gg: ASbGncunJBI3U6q0iTEFwIv97h9ZycXt2nkCT1Yakpw/LfFHvDlU/40h5ZdjaaAQj5g
 UbPxIWohkviH3JmLbVwhrbhTyIV4t7QbY5vxtoNTk5geo8IOxXb+iFiF8vuCiG/XAQiEPe29Ub8
 uTcOA3TA9BWQ78Cu+p3zCkjxuKyH2SUHsczwCt+swq5F1jV7oEK07luT7221wTMOtRn8R1VlnE1
 xflR93SprYqNdkIvfns5V7Ikh0lgd0Wy74r9OgC5ghSMMgtiC6czFQe
X-Received: by 2002:a05:6830:65c1:b0:71d:5c89:e505 with SMTP id
 46e09a7af769-726f1c65248mr869333a34.9.1739314286956; 
 Tue, 11 Feb 2025 14:51:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7OsuzvjtstwJBJV5Gac4F2rxsCRoVwXw4UPUEbm8iAol2SkW/oPpc3U2o4S2ieJM+AjRGtw==
X-Received: by 2002:a05:6830:65c1:b0:71d:5c89:e505 with SMTP id
 46e09a7af769-726f1c65248mr869318a34.9.1739314286576; 
 Tue, 11 Feb 2025 14:51:26 -0800 (PST)
Received: from x1.com ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fca0992fd0sm482515eaf.34.2025.02.11.14.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 14:51:25 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 William Roche <william.roche@oracle.com>
Subject: [PULL 13/14] system/physmem: handle hugetlb correctly in
 qemu_ram_remap()
Date: Tue, 11 Feb 2025 17:50:57 -0500
Message-ID: <20250211225059.182533-14-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250211225059.182533-1-peterx@redhat.com>
References: <20250211225059.182533-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: William Roche <william.roche@oracle.com>

The list of hwpoison pages used to remap the memory on reset
is based on the backend real page size.
To correctly handle hugetlb, we must mmap(MAP_FIXED) a complete
hugetlb page; hugetlb pages cannot be partially mapped.

Signed-off-by: William Roche <william.roche@oracle.com>
Co-developed-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20250211212707.302391-2-william.roche@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/cpu-common.h |  2 +-
 accel/kvm/kvm-all.c       |  2 +-
 system/physmem.c          | 38 +++++++++++++++++++++++++++++---------
 3 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index b1d76d6985..3771b2130c 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -67,7 +67,7 @@ typedef uintptr_t ram_addr_t;
 
 /* memory API */
 
-void qemu_ram_remap(ram_addr_t addr, ram_addr_t length);
+void qemu_ram_remap(ram_addr_t addr);
 /* This should not be used by devices.  */
 ram_addr_t qemu_ram_addr_from_host(void *ptr);
 ram_addr_t qemu_ram_addr_from_host_nofail(void *ptr);
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c65b790433..f89568bfa3 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1288,7 +1288,7 @@ static void kvm_unpoison_all(void *param)
 
     QLIST_FOREACH_SAFE(page, &hwpoison_page_list, list, next_page) {
         QLIST_REMOVE(page, list);
-        qemu_ram_remap(page->ram_addr, TARGET_PAGE_SIZE);
+        qemu_ram_remap(page->ram_addr);
         g_free(page);
     }
 }
diff --git a/system/physmem.c b/system/physmem.c
index d3efdf13d3..af1175a57c 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2275,17 +2275,35 @@ void qemu_ram_free(RAMBlock *block)
 }
 
 #ifndef _WIN32
-void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
+/*
+ * qemu_ram_remap - remap a single RAM page
+ *
+ * @addr: address in ram_addr_t address space.
+ *
+ * This function will try remapping a single page of guest RAM identified by
+ * @addr, essentially discarding memory to recover from previously poisoned
+ * memory (MCE). The page size depends on the RAMBlock (i.e., hugetlb). @addr
+ * does not have to point at the start of the page.
+ *
+ * This function is only to be used during system resets; it will kill the
+ * VM if remapping failed.
+ */
+void qemu_ram_remap(ram_addr_t addr)
 {
     RAMBlock *block;
-    ram_addr_t offset;
+    uint64_t offset;
     int flags;
     void *area, *vaddr;
     int prot;
+    size_t page_size;
 
     RAMBLOCK_FOREACH(block) {
         offset = addr - block->offset;
         if (offset < block->max_length) {
+            /* Respect the pagesize of our RAMBlock */
+            page_size = qemu_ram_pagesize(block);
+            offset = QEMU_ALIGN_DOWN(offset, page_size);
+
             vaddr = ramblock_ptr(block, offset);
             if (block->flags & RAM_PREALLOC) {
                 ;
@@ -2299,21 +2317,23 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
                 prot = PROT_READ;
                 prot |= block->flags & RAM_READONLY ? 0 : PROT_WRITE;
                 if (block->fd >= 0) {
-                    area = mmap(vaddr, length, prot, flags, block->fd,
+                    area = mmap(vaddr, page_size, prot, flags, block->fd,
                                 offset + block->fd_offset);
                 } else {
                     flags |= MAP_ANONYMOUS;
-                    area = mmap(vaddr, length, prot, flags, -1, 0);
+                    area = mmap(vaddr, page_size, prot, flags, -1, 0);
                 }
                 if (area != vaddr) {
-                    error_report("Could not remap addr: "
-                                 RAM_ADDR_FMT "@" RAM_ADDR_FMT "",
-                                 length, addr);
+                    error_report("Could not remap RAM %s:%" PRIx64 "+%" PRIx64
+                                 " +%zx", block->idstr, offset,
+                                 block->fd_offset, page_size);
                     exit(1);
                 }
-                memory_try_enable_merging(vaddr, length);
-                qemu_ram_setup_dump(vaddr, length);
+                memory_try_enable_merging(vaddr, page_size);
+                qemu_ram_setup_dump(vaddr, page_size);
             }
+
+            break;
         }
     }
 }
-- 
2.47.0


