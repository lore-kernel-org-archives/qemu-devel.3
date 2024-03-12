Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A180C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAab-0005tj-Qm; Tue, 12 Mar 2024 18:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAa2-000515-8m
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZz-0004JB-8H
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tiNY6DUe9/nrekxQjna/PMEUvIOJcBoh6jUWaAmbJLw=;
 b=dVSp/B2KSGXqpgblI3c0ymG2QPrb3HiO/gAupNrod7E62Y4IUVKLehoOXt+OvM3YEzfOby
 x+yZVEl2LRNOTvhJ8n4bv4pO1pR6QLXzpVKzad7L62BxJiCXwg9RoRuEu3qgk7hSr+tPaU
 3D4gx7DuB74JrYjkUS3JVLxrZ6vxTTI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-1HCqYbXHOi2TeS2xMR8RyQ-1; Tue, 12 Mar 2024 18:26:37 -0400
X-MC-Unique: 1HCqYbXHOi2TeS2xMR8RyQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2d45c064742so13199641fa.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282395; x=1710887195;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tiNY6DUe9/nrekxQjna/PMEUvIOJcBoh6jUWaAmbJLw=;
 b=CcyGZYqaYgtyWp0niopx0wIZr4rzbMN+6ttjdW+EYAEBFX+ACq0Vbeks+VDzGw4Vyn
 ku+Sn2pDAV8o1ZddjLQhJ6hZFwjx+Q2vQqAb6a55JTVo8IHrv6Hk4VWq9r8uB9yLCV9q
 WGaoJlYEHdlLBhzBZ72jvMC/+P4S/V29clcrQQieDFptYqsYkMkGl2nNrgTSXrmboflP
 CswfnQHufjIYkmn7Im8SzdutUzxcGtRWUDGfhHT1Eefed4MOMP0rWl84sLObQzfKh3LE
 jZsKPBTq9sWqlH6f4g8/l3KUJ+PQErEG5IdLnE8YnIsx4hcagEWol7z2T+4YAf9Mmplk
 b3Fw==
X-Gm-Message-State: AOJu0YxiR30a6M38gwqFoNZ+Hti0BaFsfB6TSSwFs9gRLrvtXBQefv1S
 db+cuIo70DGj5hlUymjR0WUrETXxICh5Mso3mzb7QNpIIDvzwm0PVd6qrHooy2VfIpFEDl0k6Gx
 9qczZttS26ycVeta1+sSFYLrk79Ycz5ytlRogmRAhrHVm6Fc/+N0S3VeLuvHbiTriIEnJFjzmVJ
 2M/7TT07qwGhRPSSb3KxjONiIrhwlUFYI+
X-Received: by 2002:a05:651c:c6:b0:2d2:4108:72a with SMTP id
 6-20020a05651c00c600b002d24108072amr1945678ljr.12.1710282394852; 
 Tue, 12 Mar 2024 15:26:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXtvTWfvO2ebBTyTRSa+iWBU1PPnXrcd6I1dON3MnrLYLeO5N8ZJLkUV156h574SXl0pmJBw==
X-Received: by 2002:a05:651c:c6:b0:2d2:4108:72a with SMTP id
 6-20020a05651c00c600b002d24108072amr1945662ljr.12.1710282394296; 
 Tue, 12 Mar 2024 15:26:34 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 h19-20020aa7c613000000b005673e29cc0fsm4296218edq.54.2024.03.12.15.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:26:33 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:26:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [PULL 20/68] libvhost-user: Factor out search for memory region by
 GPA and simplify
Message-ID: <60ccdca42d96f730f57478caaf376da90c3d97f3.1710282274.git.mst@redhat.com>
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

Memory regions cannot overlap, and if we ever hit that case something
would be really flawed.

For example, when vhost code in QEMU decides to increase the size of memory
regions to cover full huge pages, it makes sure to never create overlaps,
and if there would be overlaps, it would bail out.

QEMU commits 48d7c9757749 ("vhost: Merge sections added to temporary
list"), c1ece84e7c93 ("vhost: Huge page align and merge") and
e7b94a84b6cb ("vhost: Allow adjoining regions") added and clarified that
handling and how overlaps are impossible.

Consequently, each GPA can belong to at most one memory region, and
everything else doesn't make sense. Let's factor out our search to prepare
for further changes.

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20240214151701.29906-10-david@redhat.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 79 +++++++++++++----------
 1 file changed, 45 insertions(+), 34 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 7f29e01c30..d72f25396d 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -195,30 +195,47 @@ vu_panic(VuDev *dev, const char *msg, ...)
      */
 }
 
+/* Search for a memory region that covers this guest physical address. */
+static VuDevRegion *
+vu_gpa_to_mem_region(VuDev *dev, uint64_t guest_addr)
+{
+    unsigned int i;
+
+    /*
+     * Memory regions cannot overlap in guest physical address space. Each
+     * GPA belongs to exactly one memory region, so there can only be one
+     * match.
+     */
+    for (i = 0; i < dev->nregions; i++) {
+        VuDevRegion *cur = &dev->regions[i];
+
+        if (guest_addr >= cur->gpa && guest_addr < cur->gpa + cur->size) {
+            return cur;
+        }
+    }
+    return NULL;
+}
+
 /* Translate guest physical address to our virtual address.  */
 void *
 vu_gpa_to_va(VuDev *dev, uint64_t *plen, uint64_t guest_addr)
 {
-    unsigned int i;
+    VuDevRegion *r;
 
     if (*plen == 0) {
         return NULL;
     }
 
-    /* Find matching memory region.  */
-    for (i = 0; i < dev->nregions; i++) {
-        VuDevRegion *r = &dev->regions[i];
-
-        if ((guest_addr >= r->gpa) && (guest_addr < (r->gpa + r->size))) {
-            if ((guest_addr + *plen) > (r->gpa + r->size)) {
-                *plen = r->gpa + r->size - guest_addr;
-            }
-            return (void *)(uintptr_t)
-                guest_addr - r->gpa + r->mmap_addr + r->mmap_offset;
-        }
+    r = vu_gpa_to_mem_region(dev, guest_addr);
+    if (!r) {
+        return NULL;
     }
 
-    return NULL;
+    if ((guest_addr + *plen) > (r->gpa + r->size)) {
+        *plen = r->gpa + r->size - guest_addr;
+    }
+    return (void *)(uintptr_t)guest_addr - r->gpa + r->mmap_addr +
+           r->mmap_offset;
 }
 
 /* Translate qemu virtual address to our virtual address.  */
@@ -854,8 +871,8 @@ static inline bool reg_equal(VuDevRegion *vudev_reg,
 static bool
 vu_rem_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
     VhostUserMemoryRegion m = vmsg->payload.memreg.region, *msg_region = &m;
-    unsigned int i;
-    bool found = false;
+    unsigned int idx;
+    VuDevRegion *r;
 
     if (vmsg->fd_num > 1) {
         vmsg_close_fds(vmsg);
@@ -882,28 +899,22 @@ vu_rem_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
     DPRINT("    mmap_offset      0x%016"PRIx64"\n",
            msg_region->mmap_offset);
 
-    for (i = 0; i < dev->nregions; i++) {
-        if (reg_equal(&dev->regions[i], msg_region)) {
-            VuDevRegion *r = &dev->regions[i];
-
-            munmap((void *)(uintptr_t)r->mmap_addr, r->size + r->mmap_offset);
-
-            /* Shift all affected entries by 1 to close the hole at index. */
-            memmove(dev->regions + i, dev->regions + i + 1,
-                    sizeof(VuDevRegion) * (dev->nregions - i - 1));
-            DPRINT("Successfully removed a region\n");
-            dev->nregions--;
-            i--;
-
-            found = true;
-            break;
-        }
-    }
-
-    if (!found) {
+    r = vu_gpa_to_mem_region(dev, msg_region->guest_phys_addr);
+    if (!r || !reg_equal(r, msg_region)) {
+        vmsg_close_fds(vmsg);
         vu_panic(dev, "Specified region not found\n");
+        return false;
     }
 
+    munmap((void *)(uintptr_t)r->mmap_addr, r->size + r->mmap_offset);
+
+    idx = r - dev->regions;
+    assert(idx < dev->nregions);
+    /* Shift all affected entries by 1 to close the hole. */
+    memmove(r, r + 1, sizeof(VuDevRegion) * (dev->nregions - idx - 1));
+    DPRINT("Successfully removed a region\n");
+    dev->nregions--;
+
     vmsg_close_fds(vmsg);
 
     return false;
-- 
MST


