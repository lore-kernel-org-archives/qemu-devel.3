Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABAFC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAae-0006LM-HV; Tue, 12 Mar 2024 18:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAa7-000520-IC
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAa4-0004Jd-JJ
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TGTA4tkwpu8e0JNzPWdgaIpfsSfnaoNmPizTVrLG4go=;
 b=cStTQd37PQxOU2eOTbVMDzBNMTzfuWuMi77s7MHXDfCS/uecKrB9DkrDjFWoVEQTGMc8EQ
 JUkMEJ0du9xGg7+OHbqq1LrBAV7uZu+McMtW+vBGjiIU9UKl2PfKE9kkY2K4BDGT5NTZlW
 fnvx8/bA6YQzIRD0kpRbT53YqzWiQO0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-eSmXNE-IMeaCBFROcn7zuw-1; Tue, 12 Mar 2024 18:26:42 -0400
X-MC-Unique: eSmXNE-IMeaCBFROcn7zuw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a44143c8908so27826866b.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282401; x=1710887201;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGTA4tkwpu8e0JNzPWdgaIpfsSfnaoNmPizTVrLG4go=;
 b=rkBzv+jIVGA3OZDS0dwFvcJPXoYC47/Z4MLb16H8pRYBOPwFIk2PpQ5aIr6npeBFGv
 MbNT9stpGXNnVGElJvfW5oRvRUuWghttm0cYn44+kNPDucR72U3IazqmR7of2VRXyP4A
 4WCyj262QJliQN5sAoSyZnZyqiFsfDReFC2WILTRuTy2oU3fxWlX90Cqpp4y7qUBn1bL
 R0Xdhj3xT3gVwMEexE84Uv8I5jU2SWoOscidQbvpfpmmrNB34jp2PBaW0v0HC0sYsM7f
 PNYua5OcBGNrZspAqaeOjDGwGBQqFlOiucjoCbIECds2Vp6ilqEjPwAiaeNJaZu8x08R
 FwBQ==
X-Gm-Message-State: AOJu0YwYGxHP7dvnu75+fzcfkoB7q2DU5jCF+eWMMcTWnCcIBmdfhH4g
 uAwD37F1RkVFDXb/lptTqKdogByPJ0WN41vcKxMPda4mNR+K5b9t6Gt75sQFR9oa9dj2LXpEIpI
 AgNf5RcD8TE2e+HDzUx3Ltg340Rg6RWCj6sNy7E5+6O/641zXOjSYgSfYGn6VlgBUbacIPRKGUH
 YmHgbKGETrKpJWOdFWMXugUX3zHxvXbM4e
X-Received: by 2002:a17:906:903:b0:a45:40e4:8c8 with SMTP id
 i3-20020a170906090300b00a4540e408c8mr839495ejd.16.1710282400722; 
 Tue, 12 Mar 2024 15:26:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJL2Ys4/++xwgfi9gFfLtyI/ysDicsbusZ6hZyoKNohXG2YuGDtJ+aUI0y9ZOPv+GM1Kmiyw==
X-Received: by 2002:a17:906:903:b0:a45:40e4:8c8 with SMTP id
 i3-20020a170906090300b00a4540e408c8mr839473ejd.16.1710282400287; 
 Tue, 12 Mar 2024 15:26:40 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 x19-20020a170906135300b00a4644397aa9sm1000340ejb.67.2024.03.12.15.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:26:39 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:26:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [PULL 22/68] libvhost-user: Use most of mmap_offset as fd_offset
Message-ID: <b2b63008b311126ade0a44ddb488d3704dffa51f.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

In the past, QEMU would create memory regions that could partially cover
hugetlb pages, making mmap() fail if we would use the mmap_offset as an
fd_offset. For that reason, we never used the mmap_offset as an offset into
the fd and instead always mapped the fd from the very start.

However, that can easily result in us mmap'ing a lot of unnecessary
parts of an fd, possibly repeatedly.

QEMU nowadays does not create memory regions that partially cover huge
pages -- it never really worked with postcopy. QEMU handles merging of
regions that partially cover huge pages (due to holes in boot memory) since
2018 in c1ece84e7c93 ("vhost: Huge page align and merge").

Let's be a bit careful and not unconditionally convert the
mmap_offset into an fd_offset. Instead, let's simply detect the hugetlb
size and pass as much as we can as fd_offset, making sure that we call
mmap() with a properly aligned offset.

With QEMU and a virtio-mem device that is fully plugged (50GiB using 50
memslots) the qemu-storage daemon process consumes in the VA space
1281GiB before this change and 58GiB after this change.

================ Vhost user message ================
Request: VHOST_USER_ADD_MEM_REG (37)
Flags:   0x9
Size:    40
Fds: 59
Adding region 4
    guest_phys_addr: 0x0000000200000000
    memory_size:     0x0000000040000000
    userspace_addr:  0x00007fb73bffe000
    old mmap_offset: 0x0000000080000000
    fd_offset:       0x0000000080000000
    new mmap_offset: 0x0000000000000000
    mmap_addr:       0x00007f02f1bdc000
Successfully added new region
================ Vhost user message ================
Request: VHOST_USER_ADD_MEM_REG (37)
Flags:   0x9
Size:    40
Fds: 59
Adding region 5
    guest_phys_addr: 0x0000000240000000
    memory_size:     0x0000000040000000
    userspace_addr:  0x00007fb77bffe000
    old mmap_offset: 0x00000000c0000000
    fd_offset:       0x00000000c0000000
    new mmap_offset: 0x0000000000000000
    mmap_addr:       0x00007f0284000000
Successfully added new region

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20240214151701.29906-12-david@redhat.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 54 ++++++++++++++++++++---
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index ef6353d847..55aef5fcc6 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -43,6 +43,8 @@
 #include <fcntl.h>
 #include <sys/ioctl.h>
 #include <linux/vhost.h>
+#include <sys/vfs.h>
+#include <linux/magic.h>
 
 #ifdef __NR_userfaultfd
 #include <linux/userfaultfd.h>
@@ -281,12 +283,32 @@ vu_remove_all_mem_regs(VuDev *dev)
     dev->nregions = 0;
 }
 
+static size_t
+get_fd_hugepagesize(int fd)
+{
+#if defined(__linux__)
+    struct statfs fs;
+    int ret;
+
+    do {
+        ret = fstatfs(fd, &fs);
+    } while (ret != 0 && errno == EINTR);
+
+    if (!ret && (unsigned int)fs.f_type == HUGETLBFS_MAGIC) {
+        return fs.f_bsize;
+    }
+#endif
+    return 0;
+}
+
 static void
 _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
 {
     const uint64_t start_gpa = msg_region->guest_phys_addr;
     const uint64_t end_gpa = start_gpa + msg_region->memory_size;
     int prot = PROT_READ | PROT_WRITE;
+    uint64_t mmap_offset, fd_offset;
+    size_t hugepagesize;
     VuDevRegion *r;
     void *mmap_addr;
     int low = 0;
@@ -300,7 +322,7 @@ _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
            msg_region->memory_size);
     DPRINT("    userspace_addr:  0x%016"PRIx64"\n",
            msg_region->userspace_addr);
-    DPRINT("    mmap_offset:     0x%016"PRIx64"\n",
+    DPRINT("    old mmap_offset: 0x%016"PRIx64"\n",
            msg_region->mmap_offset);
 
     if (dev->postcopy_listening) {
@@ -335,11 +357,31 @@ _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
     idx = low;
 
     /*
-     * We don't use offset argument of mmap() since the mapped address has
-     * to be page aligned, and we use huge pages.
+     * Convert most of msg_region->mmap_offset to fd_offset. In almost all
+     * cases, this will leave us with mmap_offset == 0, mmap()'ing only
+     * what we really need. Only if a memory region would partially cover
+     * hugetlb pages, we'd get mmap_offset != 0, which usually doesn't happen
+     * anymore (i.e., modern QEMU).
+     *
+     * Note that mmap() with hugetlb would fail if the offset into the file
+     * is not aligned to the huge page size.
      */
-    mmap_addr = mmap(0, msg_region->memory_size + msg_region->mmap_offset,
-                     prot, MAP_SHARED | MAP_NORESERVE, fd, 0);
+    hugepagesize = get_fd_hugepagesize(fd);
+    if (hugepagesize) {
+        fd_offset = ALIGN_DOWN(msg_region->mmap_offset, hugepagesize);
+        mmap_offset = msg_region->mmap_offset - fd_offset;
+    } else {
+        fd_offset = msg_region->mmap_offset;
+        mmap_offset = 0;
+    }
+
+    DPRINT("    fd_offset:       0x%016"PRIx64"\n",
+           fd_offset);
+    DPRINT("    new mmap_offset: 0x%016"PRIx64"\n",
+           mmap_offset);
+
+    mmap_addr = mmap(0, msg_region->memory_size + mmap_offset,
+                     prot, MAP_SHARED | MAP_NORESERVE, fd, fd_offset);
     if (mmap_addr == MAP_FAILED) {
         vu_panic(dev, "region mmap error: %s", strerror(errno));
         return;
@@ -354,7 +396,7 @@ _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
     r->size = msg_region->memory_size;
     r->qva = msg_region->userspace_addr;
     r->mmap_addr = (uint64_t)(uintptr_t)mmap_addr;
-    r->mmap_offset = msg_region->mmap_offset;
+    r->mmap_offset = mmap_offset;
     dev->nregions++;
 
     if (dev->postcopy_listening) {
-- 
MST


