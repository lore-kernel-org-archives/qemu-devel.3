Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A72C021A1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 22:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thz6P-0005kr-Rs; Tue, 11 Feb 2025 17:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz6N-0005k8-FE
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz6L-00057S-Pl
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739314293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y5xSVhRiQUHuJeHocslUI3HV6Wv1hLUrZwIyEA1RiQE=;
 b=VYrZd3c+hS+uywmhGxYixJ+5woeNlOSSRixipAQj7hf9amoDqqMHrucLvy5OiuapYbN5t8
 NFD+sfUrAR5QFK1oBpvcriYHztoHWPcOH8qVnrnZJNTypA1C/wzAJysKG301IJpeepJeB5
 WNWSBnCR03RXLOveiHFq2+R4eNwW2KE=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-uBO6tYYcNi-xu47RL5k14g-1; Tue, 11 Feb 2025 17:51:30 -0500
X-MC-Unique: uBO6tYYcNi-xu47RL5k14g-1
X-Mimecast-MFC-AGG-ID: uBO6tYYcNi-xu47RL5k14g
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5fc7f76cae8so1864735eaf.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 14:51:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739314289; x=1739919089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y5xSVhRiQUHuJeHocslUI3HV6Wv1hLUrZwIyEA1RiQE=;
 b=l655qWhAWybPccb0V79k1vEjGdEnw6XyUw/h+Lc6vMhkTs7p8B2NIT0hTDjV0miHrX
 Xoj/irexZIyvOhEyIkee2k2rufPVuRoE7M4kUiOB029Kwr3S7NVjhJKunZ8KjDSo0W+Y
 HJWgEWlK8EtNtXuBlMwZfYkSsCQB6NZk5WjPmRUEGcczcrJ/7Wb/v6V0fWk4GqVaf9w2
 ZpIrN74dLu6G7zWeqTuLxXWXCRJBkc8txB6Sj+HCT1u7x8Fm9CSSsmFWFmOjiBFHMVRA
 u4QfSP0YdylNVXQIUqOhkGHpLuPTZHRBrNFJjbVgglpqIQkNxnsNyrL1y6/HR6vG/rMi
 cVRg==
X-Gm-Message-State: AOJu0YzP7NEdNQthQyPdDfAtbYIhtN8zpTKZ3yTYdINf7VhdF5bjV6b6
 1We1fnqT52gFwngNG/v8Iv47W3e7+HmRHxiwbk3GMHFJ5tH6p4f57eVhYIG6ij907LuRN6YRI8C
 xax1hrXvAGPpXMQ7MQnsKzlpN5yoaY6E9028CMHmqilT7ZYCohvrKMTDNw6E1HA1VaRnIpQRfXB
 flInMY7WEqaJG+lmlgXlRlfQt8rIniCPrKAQ==
X-Gm-Gg: ASbGncu1WVR7TGXH4xccXpV3s3uW3T2P2rJ6TNsjBCVhOinkJI1CclzRAtigNOe26tU
 yEq/iyawim06yZ64eRDJ8GjJ7f5qerAtFbBRavi/65sg/Yk9uxq8gonN2dqIGlL5lmIK1sBRLNg
 ol8Rwm84TwDlc6E2P6DAW7AAxRgPojfEB4JSj+e+Posl78KOFXryzYOH0EPpeO1ErLbHKwb4Wnc
 lu7uHvKyMx1gqBokcBBm5WSx8nHxcc48CXTGII64OIHU/yaxwP7uglv
X-Received: by 2002:a05:6820:1f07:b0:5fa:3bf1:f9df with SMTP id
 006d021491bc7-5fca301f2b6mr321843eaf.8.1739314288836; 
 Tue, 11 Feb 2025 14:51:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEa6jrKb3Gv58ndFAt0lsM7U7Kaesv3JiRWt8J6hqSNIqM0hfeScNvVAW30jnDEesyup1soiQ==
X-Received: by 2002:a05:6820:1f07:b0:5fa:3bf1:f9df with SMTP id
 006d021491bc7-5fca301f2b6mr321834eaf.8.1739314288496; 
 Tue, 11 Feb 2025 14:51:28 -0800 (PST)
Received: from x1.com ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fca0992fd0sm482515eaf.34.2025.02.11.14.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 14:51:27 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 William Roche <william.roche@oracle.com>
Subject: [PULL 14/14] system/physmem: poisoned memory discard on reboot
Date: Tue, 11 Feb 2025 17:50:58 -0500
Message-ID: <20250211225059.182533-15-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250211225059.182533-1-peterx@redhat.com>
References: <20250211225059.182533-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
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

From: William Roche <william.roche@oracle.com>

Repair poisoned memory location(s), calling ram_block_discard_range():
punching a hole in the backend file when necessary and regenerating
a usable memory.
If the kernel doesn't support the madvise calls used by this function
and we are dealing with anonymous memory, fall back to remapping the
location(s).

Signed-off-by: William Roche <william.roche@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20250211212707.302391-3-william.roche@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/physmem.c | 57 ++++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 21 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index af1175a57c..67bdf631e6 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2275,6 +2275,23 @@ void qemu_ram_free(RAMBlock *block)
 }
 
 #ifndef _WIN32
+/* Simply remap the given VM memory location from start to start+length */
+static int qemu_ram_remap_mmap(RAMBlock *block, uint64_t start, size_t length)
+{
+    int flags, prot;
+    void *area;
+    void *host_startaddr = block->host + start;
+
+    assert(block->fd < 0);
+    flags = MAP_FIXED | MAP_ANONYMOUS;
+    flags |= block->flags & RAM_SHARED ? MAP_SHARED : MAP_PRIVATE;
+    flags |= block->flags & RAM_NORESERVE ? MAP_NORESERVE : 0;
+    prot = PROT_READ;
+    prot |= block->flags & RAM_READONLY ? 0 : PROT_WRITE;
+    area = mmap(host_startaddr, length, prot, flags, -1, 0);
+    return area != host_startaddr ? -errno : 0;
+}
+
 /*
  * qemu_ram_remap - remap a single RAM page
  *
@@ -2292,9 +2309,7 @@ void qemu_ram_remap(ram_addr_t addr)
 {
     RAMBlock *block;
     uint64_t offset;
-    int flags;
-    void *area, *vaddr;
-    int prot;
+    void *vaddr;
     size_t page_size;
 
     RAMBLOCK_FOREACH(block) {
@@ -2310,24 +2325,24 @@ void qemu_ram_remap(ram_addr_t addr)
             } else if (xen_enabled()) {
                 abort();
             } else {
-                flags = MAP_FIXED;
-                flags |= block->flags & RAM_SHARED ?
-                         MAP_SHARED : MAP_PRIVATE;
-                flags |= block->flags & RAM_NORESERVE ? MAP_NORESERVE : 0;
-                prot = PROT_READ;
-                prot |= block->flags & RAM_READONLY ? 0 : PROT_WRITE;
-                if (block->fd >= 0) {
-                    area = mmap(vaddr, page_size, prot, flags, block->fd,
-                                offset + block->fd_offset);
-                } else {
-                    flags |= MAP_ANONYMOUS;
-                    area = mmap(vaddr, page_size, prot, flags, -1, 0);
-                }
-                if (area != vaddr) {
-                    error_report("Could not remap RAM %s:%" PRIx64 "+%" PRIx64
-                                 " +%zx", block->idstr, offset,
-                                 block->fd_offset, page_size);
-                    exit(1);
+                if (ram_block_discard_range(block, offset, page_size) != 0) {
+                    /*
+                     * Fall back to using mmap() only for anonymous mapping,
+                     * as if a backing file is associated we may not be able
+                     * to recover the memory in all cases.
+                     * So don't take the risk of using only mmap and fail now.
+                     */
+                    if (block->fd >= 0) {
+                        error_report("Could not remap RAM %s:%" PRIx64 "+%"
+                                     PRIx64 " +%zx", block->idstr, offset,
+                                     block->fd_offset, page_size);
+                        exit(1);
+                    }
+                    if (qemu_ram_remap_mmap(block, offset, page_size) != 0) {
+                        error_report("Could not remap RAM %s:%" PRIx64 " +%zx",
+                                     block->idstr, offset, page_size);
+                        exit(1);
+                    }
                 }
                 memory_try_enable_merging(vaddr, page_size);
                 qemu_ram_setup_dump(vaddr, page_size);
-- 
2.47.0


