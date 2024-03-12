Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BE6C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAZq-0004fu-Ud; Tue, 12 Mar 2024 18:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZo-0004ad-0z
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZl-0004Gj-B4
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GfiNxS0IofyqjxunoDfGXaaQJGBOsSjO5kFks3IxXfg=;
 b=EQpyx3V2U7nH3XGW/G+LLUl1w1GYtC4FdrpbWLtoirR7fRbvaH0GeCBpcwZ+8bFWDHW1Ov
 aVyWzNzE1Qvdr0/tal1sqWEE7MQtXtFqWYEKaVU4HkKOTU2e5hIYcP6fUsegace2f4ATlU
 JtdCTes1gAJFzrqfvjCt6W1GzdZ+Q28=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-bEJOzdDTOpufj75vcQAnEg-1; Tue, 12 Mar 2024 18:26:23 -0400
X-MC-Unique: bEJOzdDTOpufj75vcQAnEg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a35ef7abe08so328448566b.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282381; x=1710887181;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GfiNxS0IofyqjxunoDfGXaaQJGBOsSjO5kFks3IxXfg=;
 b=Xrwq/lAMeeUMrin2Fa6S+kuTy2ZIUlvq9mRbagLfjo7clRTUpPZjV0NtilKnjVTAws
 Eo3SJX8nzPMbx9FaFcx7pXxj2OTN4Vogf0pOe8mckriqAC/Y1euKgRaaFAPUJbl7ajKn
 PmS3SONBQKVoR9aITZIPy0tiyfON0/u3W2JH3vVB97GenIyld90z4V0a7cOXg6KZ5hL6
 hw4BoZ9RWDouEIHU/VPSdwih7NTomw0nMBBdXs0+UXR0QtOrSXdy8XqAHGcf4XJ2c1OZ
 Q47EY+5iadcqCCFhCioayS8CjYv5grxCqzNflxT6zaxyDZlDyhCOF7PQDKpTPUNrkz7V
 8DIg==
X-Gm-Message-State: AOJu0YwypuAol9LLmGi+1H07neBpRLNriLMfAw89R63Ki6uAajJcMOgb
 jK5r5zqskgchnJkqH2ptBVcVOLmCIWd3l43agRdU90TpFnrUun3CwgqnvVMm3aEtqpj8QEG08VA
 RYZtOny5VLqJ87tEriaqX/exrEgBJ7VxSzD6uDFuh+3Tdvgycd/25z2i3AFtHDwB8w4ARA88DNC
 U1PAhP56dpZ9xX8H4tMB8K6Um/UYDvF1gE
X-Received: by 2002:a17:906:285a:b0:a44:b9e0:8592 with SMTP id
 s26-20020a170906285a00b00a44b9e08592mr5910877ejc.8.1710282381295; 
 Tue, 12 Mar 2024 15:26:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFG+tBRXmTA4GkqOdV3hFiwR5qeOq5fj2yW9+TesCbrbHagKJBG+glQW9tJVNkB6s69QNkcJA==
X-Received: by 2002:a17:906:285a:b0:a44:b9e0:8592 with SMTP id
 s26-20020a170906285a00b00a44b9e08592mr5910861ejc.8.1710282380782; 
 Tue, 12 Mar 2024 15:26:20 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 x17-20020a1709064bd100b00a44f6ce3e7fsm4244893ejv.77.2024.03.12.15.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:26:20 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:26:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [PULL 16/68] libvhost-user: Factor out adding a memory region
Message-ID: <93fec23d8cecebf0e6917044a0c1635df20e350d.1710282274.git.mst@redhat.com>
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

Let's factor it out, reducing quite some code duplication and perparing
for further changes.

If we fail to mmap a region and panic, we now simply don't add that
(broken) region.

Note that we now increment dev->nregions as we are successfully
adding memory regions, and don't increment dev->nregions if anything went
wrong.

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20240214151701.29906-6-david@redhat.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 168 ++++++++--------------
 1 file changed, 60 insertions(+), 108 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index a7bd7de3cd..f43b5096d0 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -256,6 +256,61 @@ vu_remove_all_mem_regs(VuDev *dev)
     dev->nregions = 0;
 }
 
+static void
+_vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
+{
+    int prot = PROT_READ | PROT_WRITE;
+    VuDevRegion *r;
+    void *mmap_addr;
+
+    DPRINT("Adding region %d\n", dev->nregions);
+    DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
+           msg_region->guest_phys_addr);
+    DPRINT("    memory_size:     0x%016"PRIx64"\n",
+           msg_region->memory_size);
+    DPRINT("    userspace_addr:  0x%016"PRIx64"\n",
+           msg_region->userspace_addr);
+    DPRINT("    mmap_offset:     0x%016"PRIx64"\n",
+           msg_region->mmap_offset);
+
+    if (dev->postcopy_listening) {
+        /*
+         * In postcopy we're using PROT_NONE here to catch anyone
+         * accessing it before we userfault
+         */
+        prot = PROT_NONE;
+    }
+
+    /*
+     * We don't use offset argument of mmap() since the mapped address has
+     * to be page aligned, and we use huge pages.
+     */
+    mmap_addr = mmap(0, msg_region->memory_size + msg_region->mmap_offset,
+                     prot, MAP_SHARED | MAP_NORESERVE, fd, 0);
+    if (mmap_addr == MAP_FAILED) {
+        vu_panic(dev, "region mmap error: %s", strerror(errno));
+        return;
+    }
+    DPRINT("    mmap_addr:       0x%016"PRIx64"\n",
+           (uint64_t)(uintptr_t)mmap_addr);
+
+    r = &dev->regions[dev->nregions];
+    r->gpa = msg_region->guest_phys_addr;
+    r->size = msg_region->memory_size;
+    r->qva = msg_region->userspace_addr;
+    r->mmap_addr = (uint64_t)(uintptr_t)mmap_addr;
+    r->mmap_offset = msg_region->mmap_offset;
+    dev->nregions++;
+
+    if (dev->postcopy_listening) {
+        /*
+         * Return the address to QEMU so that it can translate the ufd
+         * fault addresses back.
+         */
+        msg_region->userspace_addr = r->mmap_addr + r->mmap_offset;
+    }
+}
+
 static void
 vmsg_close_fds(VhostUserMsg *vmsg)
 {
@@ -727,10 +782,7 @@ generate_faults(VuDev *dev) {
 static bool
 vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
     int i;
-    bool track_ramblocks = dev->postcopy_listening;
     VhostUserMemoryRegion m = vmsg->payload.memreg.region, *msg_region = &m;
-    VuDevRegion *dev_region = &dev->regions[dev->nregions];
-    void *mmap_addr;
 
     if (vmsg->fd_num != 1) {
         vmsg_close_fds(vmsg);
@@ -760,69 +812,20 @@ vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
      * we know all the postcopy client bases have been received, and we
      * should start generating faults.
      */
-    if (track_ramblocks &&
+    if (dev->postcopy_listening &&
         vmsg->size == sizeof(vmsg->payload.u64) &&
         vmsg->payload.u64 == 0) {
         (void)generate_faults(dev);
         return false;
     }
 
-    DPRINT("Adding region: %u\n", dev->nregions);
-    DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
-           msg_region->guest_phys_addr);
-    DPRINT("    memory_size:     0x%016"PRIx64"\n",
-           msg_region->memory_size);
-    DPRINT("    userspace_addr   0x%016"PRIx64"\n",
-           msg_region->userspace_addr);
-    DPRINT("    mmap_offset      0x%016"PRIx64"\n",
-           msg_region->mmap_offset);
-
-    dev_region->gpa = msg_region->guest_phys_addr;
-    dev_region->size = msg_region->memory_size;
-    dev_region->qva = msg_region->userspace_addr;
-    dev_region->mmap_offset = msg_region->mmap_offset;
-
-    /*
-     * We don't use offset argument of mmap() since the
-     * mapped address has to be page aligned, and we use huge
-     * pages.
-     */
-    if (track_ramblocks) {
-        /*
-         * In postcopy we're using PROT_NONE here to catch anyone
-         * accessing it before we userfault.
-         */
-        mmap_addr = mmap(0, dev_region->size + dev_region->mmap_offset,
-                         PROT_NONE, MAP_SHARED | MAP_NORESERVE,
-                         vmsg->fds[0], 0);
-    } else {
-        mmap_addr = mmap(0, dev_region->size + dev_region->mmap_offset,
-                         PROT_READ | PROT_WRITE, MAP_SHARED | MAP_NORESERVE,
-                         vmsg->fds[0], 0);
-    }
-
-    if (mmap_addr == MAP_FAILED) {
-        vu_panic(dev, "region mmap error: %s", strerror(errno));
-    } else {
-        dev_region->mmap_addr = (uint64_t)(uintptr_t)mmap_addr;
-        DPRINT("    mmap_addr:       0x%016"PRIx64"\n",
-               dev_region->mmap_addr);
-    }
-
+    _vu_add_mem_reg(dev, msg_region, vmsg->fds[0]);
     close(vmsg->fds[0]);
 
-    if (track_ramblocks) {
-        /*
-         * Return the address to QEMU so that it can translate the ufd
-         * fault addresses back.
-         */
-        msg_region->userspace_addr = (uintptr_t)(mmap_addr +
-                                                 dev_region->mmap_offset);
-
+    if (dev->postcopy_listening) {
         /* Send the message back to qemu with the addresses filled in. */
         vmsg->fd_num = 0;
         DPRINT("Successfully added new region in postcopy\n");
-        dev->nregions++;
         return true;
     } else {
         for (i = 0; i < dev->max_queues; i++) {
@@ -835,7 +838,6 @@ vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
         }
 
         DPRINT("Successfully added new region\n");
-        dev->nregions++;
         return false;
     }
 }
@@ -940,63 +942,13 @@ static bool
 vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
     VhostUserMemory m = vmsg->payload.memory, *memory = &m;
-    int prot = PROT_READ | PROT_WRITE;
     unsigned int i;
 
-    if (dev->postcopy_listening) {
-        /*
-         * In postcopy we're using PROT_NONE here to catch anyone
-         * accessing it before we userfault
-         */
-        prot = PROT_NONE;
-    }
-
     vu_remove_all_mem_regs(dev);
-    dev->nregions = memory->nregions;
 
     DPRINT("Nregions: %u\n", memory->nregions);
-    for (i = 0; i < dev->nregions; i++) {
-        void *mmap_addr;
-        VhostUserMemoryRegion *msg_region = &memory->regions[i];
-        VuDevRegion *dev_region = &dev->regions[i];
-
-        DPRINT("Region %d\n", i);
-        DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
-               msg_region->guest_phys_addr);
-        DPRINT("    memory_size:     0x%016"PRIx64"\n",
-               msg_region->memory_size);
-        DPRINT("    userspace_addr   0x%016"PRIx64"\n",
-               msg_region->userspace_addr);
-        DPRINT("    mmap_offset      0x%016"PRIx64"\n",
-               msg_region->mmap_offset);
-
-        dev_region->gpa = msg_region->guest_phys_addr;
-        dev_region->size = msg_region->memory_size;
-        dev_region->qva = msg_region->userspace_addr;
-        dev_region->mmap_offset = msg_region->mmap_offset;
-
-        /* We don't use offset argument of mmap() since the
-         * mapped address has to be page aligned, and we use huge
-         * pages.  */
-        mmap_addr = mmap(0, dev_region->size + dev_region->mmap_offset,
-                         prot, MAP_SHARED | MAP_NORESERVE, vmsg->fds[i], 0);
-
-        if (mmap_addr == MAP_FAILED) {
-            vu_panic(dev, "region mmap error: %s", strerror(errno));
-        } else {
-            dev_region->mmap_addr = (uint64_t)(uintptr_t)mmap_addr;
-            DPRINT("    mmap_addr:       0x%016"PRIx64"\n",
-                   dev_region->mmap_addr);
-        }
-
-        if (dev->postcopy_listening) {
-            /*
-             * Return the address to QEMU so that it can translate the ufd
-             * fault addresses back.
-             */
-            msg_region->userspace_addr = (uintptr_t)(mmap_addr +
-                                                     dev_region->mmap_offset);
-        }
+    for (i = 0; i < memory->nregions; i++) {
+        _vu_add_mem_reg(dev, &memory->regions[i], vmsg->fds[i]);
         close(vmsg->fds[i]);
     }
 
-- 
MST


