Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC0FC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAZn-0004aJ-NY; Tue, 12 Mar 2024 18:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZj-0004Zo-An
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZh-0004GU-ND
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C3gI7KDqXQ5rJjw/W3xZ/HO2un4Jd+r+mgG1cVGay/M=;
 b=MrH8KAAfG3MhI/RZcrGm6BL9i7bgSRNRmRw0NsYNLa5fmr74aHnFQOLzQOxw8iQtQwWaH9
 FmL84UpZlRcK72Cmzzqjv+pUk5PUepCFHaCsUxNQPUAobd245HErjAnlUh+wxgZP3GnDG4
 5d5Af+wYQsvbW9oe2VD4JuhaM/3FDrE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-lEcBUeg-Nv6LRmcvceGBBQ-1; Tue, 12 Mar 2024 18:26:19 -0400
X-MC-Unique: lEcBUeg-Nv6LRmcvceGBBQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a449be9db59so337053366b.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282378; x=1710887178;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C3gI7KDqXQ5rJjw/W3xZ/HO2un4Jd+r+mgG1cVGay/M=;
 b=EMbODWtGo+OM3gfubJ3DL+DXIbI6lGtwLzkYR7UIKRSQZi4aRGE47EAmlst90BwDbu
 Fv+OPuhMo6a00yLtAiIHDOnE5rnHRxo/FF+PYYig7sJW+Kb4/iETYJlT/fN4VwRqSRQU
 5hzOBQEjbnpyFD+GBPAbJtXEjMKjblabVN7rdXmiyFd1gk1hALfOD9smJUGgJKlF8mFU
 qENtyR1g6+nGv2sPReHUt1TcrnvcPyae0/9PN1Y+S/hALZNFRK28jpNMC/g3EUaqzp/y
 cNlGLuvmw00KPyMBf2JjavdrOxcPz4gdvu4LF7Ttl3kE18+22F1jzeq8z0dQw6HN3Fa1
 ZA1g==
X-Gm-Message-State: AOJu0YyZOIk04Pc438FTin1OhZPreQrtD6dmSvaxpzSif7rP2Ma1UEx3
 Rk4ZBBuNwDnTnC8tCS866Ew/uhCATnY63J7BFP+A0U1ZsHPj36TomdulptKCA0j4lXPNKmpu+uI
 lGPhrANOujSun2LsnJnzuMij57tcgOBs0JxdJdBo55czHIYG7Oo4W8O2rzzQrHc3nvWFxaIk+Vv
 VZI0gzo3QpxW3W0bbvrTPI2/NUwuHSWL/j
X-Received: by 2002:a17:907:1606:b0:a45:efb1:d4d8 with SMTP id
 cw6-20020a170907160600b00a45efb1d4d8mr9023424ejd.53.1710282377995; 
 Tue, 12 Mar 2024 15:26:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhc5iBBmaqN8PXAOg2HvOoy0Hk+iVvTJ+DcQyoxX0LLfqkbxsOogKZD1/2h+Sc4hdIXRpBog==
X-Received: by 2002:a17:907:1606:b0:a45:efb1:d4d8 with SMTP id
 cw6-20020a170907160600b00a45efb1d4d8mr9023406ejd.53.1710282377462; 
 Tue, 12 Mar 2024 15:26:17 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 zn6-20020a170906ff0600b00a3e643e61e1sm4226442ejb.214.2024.03.12.15.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:26:16 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:26:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [PULL 15/68] libvhost-user: Merge vu_set_mem_table_exec_postcopy()
 into vu_set_mem_table_exec()
Message-ID: <05a58ce47167a95b554f9afc47f78f267c394c6e.1710282274.git.mst@redhat.com>
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

Let's reduce some code duplication and prepare for further changes.

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20240214151701.29906-5-david@redhat.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 119 +++++++---------------
 1 file changed, 39 insertions(+), 80 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index e4907dfc26..a7bd7de3cd 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -937,95 +937,23 @@ vu_get_shared_object(VuDev *dev, VhostUserMsg *vmsg)
 }
 
 static bool
-vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
+vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
-    unsigned int i;
     VhostUserMemory m = vmsg->payload.memory, *memory = &m;
-    dev->nregions = memory->nregions;
+    int prot = PROT_READ | PROT_WRITE;
+    unsigned int i;
 
-    DPRINT("Nregions: %u\n", memory->nregions);
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
-         * pages.
+    if (dev->postcopy_listening) {
+        /*
          * In postcopy we're using PROT_NONE here to catch anyone
          * accessing it before we userfault
          */
-        mmap_addr = mmap(0, dev_region->size + dev_region->mmap_offset,
-                         PROT_NONE, MAP_SHARED | MAP_NORESERVE,
-                         vmsg->fds[i], 0);
-
-        if (mmap_addr == MAP_FAILED) {
-            vu_panic(dev, "region mmap error: %s", strerror(errno));
-        } else {
-            dev_region->mmap_addr = (uint64_t)(uintptr_t)mmap_addr;
-            DPRINT("    mmap_addr:       0x%016"PRIx64"\n",
-                   dev_region->mmap_addr);
-        }
-
-        /* Return the address to QEMU so that it can translate the ufd
-         * fault addresses back.
-         */
-        msg_region->userspace_addr = (uintptr_t)(mmap_addr +
-                                                 dev_region->mmap_offset);
-        close(vmsg->fds[i]);
+        prot = PROT_NONE;
     }
 
-    /* Send the message back to qemu with the addresses filled in */
-    vmsg->fd_num = 0;
-    if (!vu_send_reply(dev, dev->sock, vmsg)) {
-        vu_panic(dev, "failed to respond to set-mem-table for postcopy");
-        return false;
-    }
-
-    /* Wait for QEMU to confirm that it's registered the handler for the
-     * faults.
-     */
-    if (!dev->read_msg(dev, dev->sock, vmsg) ||
-        vmsg->size != sizeof(vmsg->payload.u64) ||
-        vmsg->payload.u64 != 0) {
-        vu_panic(dev, "failed to receive valid ack for postcopy set-mem-table");
-        return false;
-    }
-
-    /* OK, now we can go and register the memory and generate faults */
-    (void)generate_faults(dev);
-
-    return false;
-}
-
-static bool
-vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
-{
-    unsigned int i;
-    VhostUserMemory m = vmsg->payload.memory, *memory = &m;
-
     vu_remove_all_mem_regs(dev);
     dev->nregions = memory->nregions;
 
-    if (dev->postcopy_listening) {
-        return vu_set_mem_table_exec_postcopy(dev, vmsg);
-    }
-
     DPRINT("Nregions: %u\n", memory->nregions);
     for (i = 0; i < dev->nregions; i++) {
         void *mmap_addr;
@@ -1051,8 +979,7 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
          * mapped address has to be page aligned, and we use huge
          * pages.  */
         mmap_addr = mmap(0, dev_region->size + dev_region->mmap_offset,
-                         PROT_READ | PROT_WRITE, MAP_SHARED | MAP_NORESERVE,
-                         vmsg->fds[i], 0);
+                         prot, MAP_SHARED | MAP_NORESERVE, vmsg->fds[i], 0);
 
         if (mmap_addr == MAP_FAILED) {
             vu_panic(dev, "region mmap error: %s", strerror(errno));
@@ -1062,9 +989,41 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
                    dev_region->mmap_addr);
         }
 
+        if (dev->postcopy_listening) {
+            /*
+             * Return the address to QEMU so that it can translate the ufd
+             * fault addresses back.
+             */
+            msg_region->userspace_addr = (uintptr_t)(mmap_addr +
+                                                     dev_region->mmap_offset);
+        }
         close(vmsg->fds[i]);
     }
 
+    if (dev->postcopy_listening) {
+        /* Send the message back to qemu with the addresses filled in */
+        vmsg->fd_num = 0;
+        if (!vu_send_reply(dev, dev->sock, vmsg)) {
+            vu_panic(dev, "failed to respond to set-mem-table for postcopy");
+            return false;
+        }
+
+        /*
+         * Wait for QEMU to confirm that it's registered the handler for the
+         * faults.
+         */
+        if (!dev->read_msg(dev, dev->sock, vmsg) ||
+            vmsg->size != sizeof(vmsg->payload.u64) ||
+            vmsg->payload.u64 != 0) {
+            vu_panic(dev, "failed to receive valid ack for postcopy set-mem-table");
+            return false;
+        }
+
+        /* OK, now we can go and register the memory and generate faults */
+        (void)generate_faults(dev);
+        return false;
+    }
+
     for (i = 0; i < dev->max_queues; i++) {
         if (dev->vq[i].vring.desc) {
             if (map_ring(dev, &dev->vq[i])) {
-- 
MST


