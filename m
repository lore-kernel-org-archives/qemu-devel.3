Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B890C28B2E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqfgQ-0004zz-Nm; Fri, 07 Mar 2025 16:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqfgP-0004zJ-78
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:56:41 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqfgN-0001jy-8l
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:56:40 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-223959039f4so49592215ad.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741384598; x=1741989398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sfg9fp/d1PdwCXS3veKjw2zFmzOBBZVU57mmT0JR/f0=;
 b=YYmn9/zuZMOhGFwgKNWqsx9Ax995GFn7L/kLtP6q9okJi8p2DTsDHr/K4/vG7xG+z2
 XNnZQPheP/MBDEry1D2yo7Lnuya6oSxyda4+A+dL+jxXw4/Kbbj7fCLRXejmlr2lj1aC
 iWuqoi96lHuHM95nmtVH9SS4U3P9bapLFpKaQGBBWdBwiRqYdVGCs+en7XaCv4geUOqt
 +/7SW1GNH6Vey2ecMbONR48FlPfnvb9KHbfCF17LJdu/0i2SEZGAAusfYsoeUd2rwPMF
 NMc9u0RTqTVFqz/BnTiQWYrPEFaL3xcOBt90osMU/X4zSz/N1xxuSKfErBlUVH4T/h5g
 UnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741384598; x=1741989398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sfg9fp/d1PdwCXS3veKjw2zFmzOBBZVU57mmT0JR/f0=;
 b=F+cBKta2IMu/vGwWJaPmuPLXS4mjpNzPaS16JxVU2pUjnzWaLo28MsdlRHUR1mHr3H
 D6kWvrf49lzO1XEHraMESrV0Addq9dwagP+jkS22Iky4M+WxVgJ67HcI4iBO+IKedZ7K
 w9nM1UNcaEdMe4WlieP9s7Qq799E3LKkc0hLSipYWQ68gllZJtWl+CJsVGRcmoBkUBsH
 dyBZki/Ak7ddxeEzzWSUyYZU7vy/U14TzkFWvropIe5iW0uM1PXnZmhG8xJf/0UYJFSh
 jqT46PFRIxXj1VHuzVu5Gen/oG74H3AruPUAJT9s7kGcgs5GXcTJB2LvF172uxaoaf9i
 fvRA==
X-Gm-Message-State: AOJu0YzDMTnvv0ryjNtCo7Sxf8zlUhUpctAPleO+3v1ilaUCzeIB5A9J
 5/5+VHzhfCQSYA4OcOVz5DAOLNWg35oQtOjwSRZuobg3OT92kMNw+9Cb/vy2fU1i5Ahk0F8DSCs
 A
X-Gm-Gg: ASbGncvWWfOU8+WfI0GkyZNVIN22xADpcXxoNPojeRpqgafoh85gAX+Xrd0YjAs19YE
 GxmpyijxPfhO3vgRW8cX5Lli/7w1ZOEzCTfoJKbSDLUQ7i1zEegN8FlUeSY/rgmIlMqW40ofcPy
 7d/kGoIZLJNWosyPQo2dp3hFB+LNJ0qhTTbHWcx5sQOa87zxWgBSg7QwLNYjEm+rw9YLEypPh0z
 tENTF4Ga1tEla4OrtDMWt4aANV+ULYbBA8/KxKREAXE6OmvS7dN9BISbRWDdVsEUUt+sh6HEpFs
 PG/8m5YPdlVz6grTS6jYNofFCPCm5YhpejryASV6sLCd
X-Google-Smtp-Source: AGHT+IGX5pfQXW7bvmwqA+NptD1rpRnsLsnmq6044IHwx1QKIiIQW9IhEs7zgPLZDe/E6y36RfvBrw==
X-Received: by 2002:a05:6a00:1817:b0:736:3979:369e with SMTP id
 d2e1a72fcca58-736aa9f1fcdmr6571296b3a.9.1741384596537; 
 Fri, 07 Mar 2025 13:56:36 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736ac9247dcsm2000927b3a.125.2025.03.07.13.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 13:56:36 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 pierrick.bouvier@linaro.org, kvm@vger.kernel.org, alex.bennee@linaro.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 richard.henderson@linaro.org, manos.pitsidianakis@linaro.org
Subject: [PATCH v4 3/7] hw/hyperv/vmbus: common compilation unit
Date: Fri,  7 Mar 2025 13:56:19 -0800
Message-Id: <20250307215623.524987-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
References: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Replace TARGET_PAGE.* by runtime calls.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/hyperv/vmbus.c     | 50 +++++++++++++++++++++----------------------
 hw/hyperv/meson.build |  2 +-
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 12a7dc43128..109ac319caf 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -18,7 +18,7 @@
 #include "hw/hyperv/vmbus.h"
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/sysbus.h"
-#include "cpu.h"
+#include "exec/target_page.h"
 #include "trace.h"
 
 enum {
@@ -309,7 +309,7 @@ void vmbus_put_gpadl(VMBusGpadl *gpadl)
 
 uint32_t vmbus_gpadl_len(VMBusGpadl *gpadl)
 {
-    return gpadl->num_gfns * TARGET_PAGE_SIZE;
+    return gpadl->num_gfns * qemu_target_page_size();
 }
 
 static void gpadl_iter_init(GpadlIter *iter, VMBusGpadl *gpadl,
@@ -323,14 +323,14 @@ static void gpadl_iter_init(GpadlIter *iter, VMBusGpadl *gpadl,
 
 static inline void gpadl_iter_cache_unmap(GpadlIter *iter)
 {
-    uint32_t map_start_in_page = (uintptr_t)iter->map & ~TARGET_PAGE_MASK;
-    uint32_t io_end_in_page = ((iter->last_off - 1) & ~TARGET_PAGE_MASK) + 1;
+    uint32_t map_start_in_page = (uintptr_t)iter->map & ~qemu_target_page_mask();
+    uint32_t io_end_in_page = ((iter->last_off - 1) & ~qemu_target_page_mask()) + 1;
 
     /* mapping is only done to do non-zero amount of i/o */
     assert(iter->last_off > 0);
     assert(map_start_in_page < io_end_in_page);
 
-    dma_memory_unmap(iter->as, iter->map, TARGET_PAGE_SIZE - map_start_in_page,
+    dma_memory_unmap(iter->as, iter->map, qemu_target_page_size() - map_start_in_page,
                      iter->dir, io_end_in_page - map_start_in_page);
 }
 
@@ -348,17 +348,17 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void *buf, uint32_t len)
     assert(iter->active);
 
     while (len) {
-        uint32_t off_in_page = iter->off & ~TARGET_PAGE_MASK;
-        uint32_t pgleft = TARGET_PAGE_SIZE - off_in_page;
+        uint32_t off_in_page = iter->off & ~qemu_target_page_mask();
+        uint32_t pgleft = qemu_target_page_size() - off_in_page;
         uint32_t cplen = MIN(pgleft, len);
         void *p;
 
         /* try to reuse the cached mapping */
         if (iter->map) {
             uint32_t map_start_in_page =
-                (uintptr_t)iter->map & ~TARGET_PAGE_MASK;
-            uint32_t off_base = iter->off & ~TARGET_PAGE_MASK;
-            uint32_t mapped_base = (iter->last_off - 1) & ~TARGET_PAGE_MASK;
+                (uintptr_t)iter->map & ~qemu_target_page_mask();
+            uint32_t off_base = iter->off & ~qemu_target_page_mask();
+            uint32_t mapped_base = (iter->last_off - 1) & ~qemu_target_page_mask();
             if (off_base != mapped_base || off_in_page < map_start_in_page) {
                 gpadl_iter_cache_unmap(iter);
                 iter->map = NULL;
@@ -368,10 +368,10 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void *buf, uint32_t len)
         if (!iter->map) {
             dma_addr_t maddr;
             dma_addr_t mlen = pgleft;
-            uint32_t idx = iter->off >> TARGET_PAGE_BITS;
+            uint32_t idx = iter->off >> qemu_target_page_bits();
             assert(idx < iter->gpadl->num_gfns);
 
-            maddr = (iter->gpadl->gfns[idx] << TARGET_PAGE_BITS) | off_in_page;
+            maddr = (iter->gpadl->gfns[idx] << qemu_target_page_bits()) | off_in_page;
 
             iter->map = dma_memory_map(iter->as, maddr, &mlen, iter->dir,
                                        MEMTXATTRS_UNSPECIFIED);
@@ -382,7 +382,7 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void *buf, uint32_t len)
             }
         }
 
-        p = (void *)(uintptr_t)(((uintptr_t)iter->map & TARGET_PAGE_MASK) |
+        p = (void *)(uintptr_t)(((uintptr_t)iter->map & qemu_target_page_mask()) |
                 off_in_page);
         if (iter->dir == DMA_DIRECTION_FROM_DEVICE) {
             memcpy(p, buf, cplen);
@@ -591,9 +591,9 @@ static void ringbuf_init_common(VMBusRingBufCommon *ringbuf, VMBusGpadl *gpadl,
                                 uint32_t begin, uint32_t end)
 {
     ringbuf->as = as;
-    ringbuf->rb_addr = gpadl->gfns[begin] << TARGET_PAGE_BITS;
-    ringbuf->base = (begin + 1) << TARGET_PAGE_BITS;
-    ringbuf->len = (end - begin - 1) << TARGET_PAGE_BITS;
+    ringbuf->rb_addr = gpadl->gfns[begin] << qemu_target_page_bits();
+    ringbuf->base = (begin + 1) << qemu_target_page_bits();
+    ringbuf->len = (end - begin - 1) << qemu_target_page_bits();
     gpadl_iter_init(&ringbuf->iter, gpadl, as, dir);
 }
 
@@ -734,7 +734,7 @@ static int vmbus_channel_notify_guest(VMBusChannel *chan)
     unsigned long *int_map, mask;
     unsigned idx;
     hwaddr addr = chan->vmbus->int_page_gpa;
-    hwaddr len = TARGET_PAGE_SIZE / 2, dirty = 0;
+    hwaddr len = qemu_target_page_size() / 2, dirty = 0;
 
     trace_vmbus_channel_notify_guest(chan->id);
 
@@ -743,7 +743,7 @@ static int vmbus_channel_notify_guest(VMBusChannel *chan)
     }
 
     int_map = cpu_physical_memory_map(addr, &len, 1);
-    if (len != TARGET_PAGE_SIZE / 2) {
+    if (len != qemu_target_page_size() / 2) {
         res = -ENXIO;
         goto unmap;
     }
@@ -1038,14 +1038,14 @@ static int sgl_from_gpa_ranges(QEMUSGList *sgl, VMBusDevice *dev,
         }
         len -= sizeof(range);
 
-        if (range.byte_offset & TARGET_PAGE_MASK) {
+        if (range.byte_offset & qemu_target_page_mask()) {
             goto eio;
         }
 
         for (; range.byte_count; range.byte_offset = 0) {
             uint64_t paddr;
             uint32_t plen = MIN(range.byte_count,
-                                TARGET_PAGE_SIZE - range.byte_offset);
+                                qemu_target_page_size() - range.byte_offset);
 
             if (len < sizeof(uint64_t)) {
                 goto eio;
@@ -1055,7 +1055,7 @@ static int sgl_from_gpa_ranges(QEMUSGList *sgl, VMBusDevice *dev,
                 goto err;
             }
             len -= sizeof(uint64_t);
-            paddr <<= TARGET_PAGE_BITS;
+            paddr <<= qemu_target_page_bits();
             paddr |= range.byte_offset;
             range.byte_count -= plen;
 
@@ -1804,7 +1804,7 @@ static void handle_gpadl_header(VMBus *vmbus, vmbus_message_gpadl_header *msg,
      * anything else and simplify things greatly.
      */
     if (msg->rangecount != 1 || msg->range[0].byte_offset ||
-        (msg->range[0].byte_count != (num_gfns << TARGET_PAGE_BITS))) {
+        (msg->range[0].byte_count != (num_gfns << qemu_target_page_bits()))) {
         return;
     }
 
@@ -2240,10 +2240,10 @@ static void vmbus_signal_event(EventNotifier *e)
         return;
     }
 
-    addr = vmbus->int_page_gpa + TARGET_PAGE_SIZE / 2;
-    len = TARGET_PAGE_SIZE / 2;
+    addr = vmbus->int_page_gpa + qemu_target_page_size() / 2;
+    len = qemu_target_page_size() / 2;
     int_map = cpu_physical_memory_map(addr, &len, 1);
-    if (len != TARGET_PAGE_SIZE / 2) {
+    if (len != qemu_target_page_size() / 2) {
         goto unmap;
     }
 
diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
index f4aa0a5ada9..c855fdcf04c 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -1,6 +1,6 @@
 specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
 specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
-specific_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
+system_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
 specific_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
 specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
 system_ss.add(when: 'CONFIG_HV_BALLOON', if_false: files('hv-balloon-stub.c'))
-- 
2.39.5


