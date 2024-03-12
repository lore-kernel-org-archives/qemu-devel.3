Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70580C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAae-0006Gx-2D; Tue, 12 Mar 2024 18:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAa2-00051P-NL
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAa1-0004JF-5Y
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kuEw/qjyX67TtnsTtkeQbRtswvxdOIF5Wj6N4Z6tg+M=;
 b=iK/WIe37bcei/guxfc8Y1nuH0IFwXkXo62qnaXJd9FHxP4WvtbK9Zfj74BXjVYbhsML1r+
 X2DPtfbaUIBYMnceV2Kbo0wSOOBIvFXLKpCg0yXAr6QEuwbumHi/82uEKaftFioTjVhyVO
 OtFtwYv+vYwPOTiyqSfVDD2kmUcG/v8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-zCpsfkUuPW2rz_ozc5U20Q-1; Tue, 12 Mar 2024 18:26:39 -0400
X-MC-Unique: zCpsfkUuPW2rz_ozc5U20Q-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5684650b00bso197339a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282398; x=1710887198;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuEw/qjyX67TtnsTtkeQbRtswvxdOIF5Wj6N4Z6tg+M=;
 b=CROg71ORa7E1VLk20Oj3f32w60LM8ToAonJDlFGwiK7MdLzR2H3B6UBueKOP/WlkrS
 hz2Xmj6VDRzfqRS4reCCjxZ6Vls2LxIXeaiKvnkgtOjOc9zMAmj0X9AAoKRw9ZjU/3JA
 C8W84ZLe01zoMe1vHib4jHG6hNhs4VLGQYRr2xVqqvQJ1fQKYlVKUVFWsyxQIh4OPUsu
 Vi/RAqehBOMPqusxFqgqiLPZvC77I5qfZmNTEaj+DMSWQeOARcNkQ9oTXkxl5UOOsdn2
 J6U3zAJHMRC/9iy7kBopR8gsRAUkugeqog8kdp+b+9N8jmHnwKdJd8Lv581OESe8nzvo
 ST/Q==
X-Gm-Message-State: AOJu0Yw0C0wvIZV+ytfR/GlDnfJR6uxXSB3RQWvB6bQYdwpjD1gdtp0v
 as5Y7Jf52LJaDgI2wvuQzCv06O1+ogNoeE55k2IEtnlv2LFrd+ffrAgsQBCZZYwC5VF5f/ZWcux
 6MIfxD0ziJ8KzwtWlcrOUH7YhzWpbFfR7rdDezFjzzEbb62IiWZkr8kMrLCoFDWBvMSzztsx9QZ
 IvH7I02pga79uTNR6goLIPyYj0L0im1afV
X-Received: by 2002:a50:cd07:0:b0:567:c0ac:b31d with SMTP id
 z7-20020a50cd07000000b00567c0acb31dmr3239045edi.37.1710282397762; 
 Tue, 12 Mar 2024 15:26:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzKExrWXvkSicF1QyPBfmJJoUhq+5gI90oLC/H9I9Cz8E4q6klZu+4vvB9XFTQaSLFR8qadg==
X-Received: by 2002:a50:cd07:0:b0:567:c0ac:b31d with SMTP id
 z7-20020a50cd07000000b00567c0acb31dmr3239026edi.37.1710282397223; 
 Tue, 12 Mar 2024 15:26:37 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 f21-20020a50d555000000b0056835320f76sm4582789edj.8.2024.03.12.15.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:26:36 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:26:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [PULL 21/68] libvhost-user: Speedup gpa_to_mem_region() and
 vu_gpa_to_va()
Message-ID: <a3c0118c5a1e64d32a2208388b5ea90e2ec9d214.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: David Hildenbrand <david@redhat.com>

Let's speed up GPA to memory region / virtual address lookup. Store the
memory regions ordered by guest physical addresses, and use binary
search for address translation, as well as when adding/removing memory
regions.

Most importantly, this will speed up GPA->VA address translation when we
have many memslots.

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20240214151701.29906-11-david@redhat.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 49 +++++++++++++++++++++--
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index d72f25396d..ef6353d847 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -199,19 +199,30 @@ vu_panic(VuDev *dev, const char *msg, ...)
 static VuDevRegion *
 vu_gpa_to_mem_region(VuDev *dev, uint64_t guest_addr)
 {
-    unsigned int i;
+    int low = 0;
+    int high = dev->nregions - 1;
 
     /*
      * Memory regions cannot overlap in guest physical address space. Each
      * GPA belongs to exactly one memory region, so there can only be one
      * match.
+     *
+     * We store our memory regions ordered by GPA and can simply perform a
+     * binary search.
      */
-    for (i = 0; i < dev->nregions; i++) {
-        VuDevRegion *cur = &dev->regions[i];
+    while (low <= high) {
+        unsigned int mid = low + (high - low) / 2;
+        VuDevRegion *cur = &dev->regions[mid];
 
         if (guest_addr >= cur->gpa && guest_addr < cur->gpa + cur->size) {
             return cur;
         }
+        if (guest_addr >= cur->gpa + cur->size) {
+            low = mid + 1;
+        }
+        if (guest_addr < cur->gpa) {
+            high = mid - 1;
+        }
     }
     return NULL;
 }
@@ -273,9 +284,14 @@ vu_remove_all_mem_regs(VuDev *dev)
 static void
 _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
 {
+    const uint64_t start_gpa = msg_region->guest_phys_addr;
+    const uint64_t end_gpa = start_gpa + msg_region->memory_size;
     int prot = PROT_READ | PROT_WRITE;
     VuDevRegion *r;
     void *mmap_addr;
+    int low = 0;
+    int high = dev->nregions - 1;
+    unsigned int idx;
 
     DPRINT("Adding region %d\n", dev->nregions);
     DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
@@ -295,6 +311,29 @@ _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
         prot = PROT_NONE;
     }
 
+    /*
+     * We will add memory regions into the array sorted by GPA. Perform a
+     * binary search to locate the insertion point: it will be at the low
+     * index.
+     */
+    while (low <= high) {
+        unsigned int mid = low + (high - low)  / 2;
+        VuDevRegion *cur = &dev->regions[mid];
+
+        /* Overlap of GPA addresses. */
+        if (start_gpa < cur->gpa + cur->size && cur->gpa < end_gpa) {
+            vu_panic(dev, "regions with overlapping guest physical addresses");
+            return;
+        }
+        if (start_gpa >= cur->gpa + cur->size) {
+            low = mid + 1;
+        }
+        if (start_gpa < cur->gpa) {
+            high = mid - 1;
+        }
+    }
+    idx = low;
+
     /*
      * We don't use offset argument of mmap() since the mapped address has
      * to be page aligned, and we use huge pages.
@@ -308,7 +347,9 @@ _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
     DPRINT("    mmap_addr:       0x%016"PRIx64"\n",
            (uint64_t)(uintptr_t)mmap_addr);
 
-    r = &dev->regions[dev->nregions];
+    /* Shift all affected entries by 1 to open a hole at idx. */
+    r = &dev->regions[idx];
+    memmove(r + 1, r, sizeof(VuDevRegion) * (dev->nregions - idx));
     r->gpa = msg_region->guest_phys_addr;
     r->size = msg_region->memory_size;
     r->qva = msg_region->userspace_addr;
-- 
MST


