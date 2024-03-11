Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF50CC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjngV-0000PJ-F2; Mon, 11 Mar 2024 17:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngR-0000JS-Rx
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngP-0003zp-V0
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fORkuH4iwhGbcpUM2sVmTdxDf+BTT9cK7aj0xk3UAko=;
 b=UJIJrSWuXGreveEez2e1i1yVjbIRxluuivHRxDrVV8NvplMocNQzhINnBd/T8TQ2vFVN4b
 UK5f9rd7bAGtpensIs7zPjDSJyNf7ROKjt3odnC4RggQqFte7E6bhP3OaNkZqgyyJTvACO
 JKXmQuX+35P1Y797mSvJW70V5P0nsxc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558--Qy2BHw6MdanaiylZR3Ppw-1; Mon, 11 Mar 2024 17:59:44 -0400
X-MC-Unique: -Qy2BHw6MdanaiylZR3Ppw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6818b8cb840so15027036d6.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 14:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194383; x=1710799183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fORkuH4iwhGbcpUM2sVmTdxDf+BTT9cK7aj0xk3UAko=;
 b=I/a/K00dDoa1swJlMXp1x4ExiARvAhAklVEJk+sZMB9m/77v5+dLL6SoOgT1k8MuSK
 pHAgrKMA9awp4RKa6LnKDDjqGmL5PPD/KlSqLkoviuaI7Luohii2kKJSGTS82OVH7Bz1
 QuC7TqzNCL0UTlmONdcYFbLxzi5usfuUT2azA4rKFgkhCNmlJv+Obah3a7wrTkrSXVfX
 iGHO6rIWcABIMmUXSL9IEl/tYeRQT7dyDJPTqw47hOogxqIWRaW9554rsO8KY6+xQFyH
 sVkJrIzQEryked/8TzKg8Ev/tnaHV1T+Hh6WjByVCBtAui9iOnSp/5C7BXQdQTRE7jxS
 B/sg==
X-Gm-Message-State: AOJu0YyuIiNOfXq0xv7WImGkDNagnwHf3c6jLPfH3YMt/heVcJLiLew/
 EqSPOKXFtz29eH2UW18W38QvJok/JMgg1oZD3Mhvz5P3xFCkOPZWyNJflVog6I4lTMTqmgwwuNO
 7PC2XL+xmUDV8jG+2U3NZdBbMdkSyjLcTUHkkIp95MGLXtgT+vBRXPw9LaqUxZWcgBWWxyTUlYw
 beo2gI2Qt2xBTkkveiU1wz9oU/i9TUfNmNKA==
X-Received: by 2002:a0c:fa91:0:b0:690:d74d:7e6d with SMTP id
 o17-20020a0cfa91000000b00690d74d7e6dmr3080639qvn.3.1710194383292; 
 Mon, 11 Mar 2024 14:59:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmdq+BOAUDzA64mgLIx0/PUFj+sclgG3c+haYlxJyrE3DpgckObm3ja+I7jM1qU9HKSAqrzg==
X-Received: by 2002:a0c:fa91:0:b0:690:d74d:7e6d with SMTP id
 o17-20020a0cfa91000000b00690d74d7e6dmr3080610qvn.3.1710194382810; 
 Mon, 11 Mar 2024 14:59:42 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.14.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:59:41 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 11/34] physmem: Rename addr1 to more informative mr_addr in
 flatview_read/write() and similar
Date: Mon, 11 Mar 2024 17:59:02 -0400
Message-ID: <20240311215925.40618-12-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The calls to flatview_read/write[_continue]() have parameters addr and
addr1 but the names give no indication of what they are addresses of.
Rename addr1 to mr_addr to reflect that it is the translated address
offset within the MemoryRegion returned by flatview_translate().
Similarly rename the parameter in address_space_read/write_cached_slow()

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20240307153710.30907-2-Jonathan.Cameron@huawei.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/physmem.c | 50 ++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 6e9ed97597..e92bed50a6 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2685,7 +2685,7 @@ static bool flatview_access_allowed(MemoryRegion *mr, MemTxAttrs attrs,
 static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
                                            MemTxAttrs attrs,
                                            const void *ptr,
-                                           hwaddr len, hwaddr addr1,
+                                           hwaddr len, hwaddr mr_addr,
                                            hwaddr l, MemoryRegion *mr)
 {
     uint8_t *ram_ptr;
@@ -2695,12 +2695,12 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
     const uint8_t *buf = ptr;
 
     for (;;) {
-        if (!flatview_access_allowed(mr, attrs, addr1, l)) {
+        if (!flatview_access_allowed(mr, attrs, mr_addr, l)) {
             result |= MEMTX_ACCESS_ERROR;
             /* Keep going. */
         } else if (!memory_access_is_direct(mr, true)) {
             release_lock |= prepare_mmio_access(mr);
-            l = memory_access_size(mr, l, addr1);
+            l = memory_access_size(mr, l, mr_addr);
             /* XXX: could force current_cpu to NULL to avoid
                potential bugs */
 
@@ -2715,13 +2715,13 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
                    (l == 8 && len >= 8));
 #endif
             val = ldn_he_p(buf, l);
-            result |= memory_region_dispatch_write(mr, addr1, val,
+            result |= memory_region_dispatch_write(mr, mr_addr, val,
                                                    size_memop(l), attrs);
         } else {
             /* RAM case */
-            ram_ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
+            ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, &l, false);
             memmove(ram_ptr, buf, l);
-            invalidate_and_set_dirty(mr, addr1, l);
+            invalidate_and_set_dirty(mr, mr_addr, l);
         }
 
         if (release_lock) {
@@ -2738,7 +2738,7 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
         }
 
         l = len;
-        mr = flatview_translate(fv, addr, &addr1, &l, true, attrs);
+        mr = flatview_translate(fv, addr, &mr_addr, &l, true, attrs);
     }
 
     return result;
@@ -2749,22 +2749,22 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
                                   const void *buf, hwaddr len)
 {
     hwaddr l;
-    hwaddr addr1;
+    hwaddr mr_addr;
     MemoryRegion *mr;
 
     l = len;
-    mr = flatview_translate(fv, addr, &addr1, &l, true, attrs);
+    mr = flatview_translate(fv, addr, &mr_addr, &l, true, attrs);
     if (!flatview_access_allowed(mr, attrs, addr, len)) {
         return MEMTX_ACCESS_ERROR;
     }
     return flatview_write_continue(fv, addr, attrs, buf, len,
-                                   addr1, l, mr);
+                                   mr_addr, l, mr);
 }
 
 /* Called within RCU critical section.  */
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    MemTxAttrs attrs, void *ptr,
-                                   hwaddr len, hwaddr addr1, hwaddr l,
+                                   hwaddr len, hwaddr mr_addr, hwaddr l,
                                    MemoryRegion *mr)
 {
     uint8_t *ram_ptr;
@@ -2775,14 +2775,14 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
 
     fuzz_dma_read_cb(addr, len, mr);
     for (;;) {
-        if (!flatview_access_allowed(mr, attrs, addr1, l)) {
+        if (!flatview_access_allowed(mr, attrs, mr_addr, l)) {
             result |= MEMTX_ACCESS_ERROR;
             /* Keep going. */
         } else if (!memory_access_is_direct(mr, false)) {
             /* I/O case */
             release_lock |= prepare_mmio_access(mr);
-            l = memory_access_size(mr, l, addr1);
-            result |= memory_region_dispatch_read(mr, addr1, &val,
+            l = memory_access_size(mr, l, mr_addr);
+            result |= memory_region_dispatch_read(mr, mr_addr, &val,
                                                   size_memop(l), attrs);
 
             /*
@@ -2798,7 +2798,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
             stn_he_p(buf, l, val);
         } else {
             /* RAM case */
-            ram_ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
+            ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, &l, false);
             memcpy(buf, ram_ptr, l);
         }
 
@@ -2816,7 +2816,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
         }
 
         l = len;
-        mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
+        mr = flatview_translate(fv, addr, &mr_addr, &l, false, attrs);
     }
 
     return result;
@@ -2827,16 +2827,16 @@ static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
                                  MemTxAttrs attrs, void *buf, hwaddr len)
 {
     hwaddr l;
-    hwaddr addr1;
+    hwaddr mr_addr;
     MemoryRegion *mr;
 
     l = len;
-    mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
+    mr = flatview_translate(fv, addr, &mr_addr, &l, false, attrs);
     if (!flatview_access_allowed(mr, attrs, addr, len)) {
         return MEMTX_ACCESS_ERROR;
     }
     return flatview_read_continue(fv, addr, attrs, buf, len,
-                                  addr1, l, mr);
+                                  mr_addr, l, mr);
 }
 
 MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
@@ -3348,15 +3348,15 @@ MemTxResult
 address_space_read_cached_slow(MemoryRegionCache *cache, hwaddr addr,
                                    void *buf, hwaddr len)
 {
-    hwaddr addr1, l;
+    hwaddr mr_addr, l;
     MemoryRegion *mr;
 
     l = len;
-    mr = address_space_translate_cached(cache, addr, &addr1, &l, false,
+    mr = address_space_translate_cached(cache, addr, &mr_addr, &l, false,
                                         MEMTXATTRS_UNSPECIFIED);
     return flatview_read_continue(cache->fv,
                                   addr, MEMTXATTRS_UNSPECIFIED, buf, len,
-                                  addr1, l, mr);
+                                  mr_addr, l, mr);
 }
 
 /* Called from RCU critical section. address_space_write_cached uses this
@@ -3366,15 +3366,15 @@ MemTxResult
 address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
                                     const void *buf, hwaddr len)
 {
-    hwaddr addr1, l;
+    hwaddr mr_addr, l;
     MemoryRegion *mr;
 
     l = len;
-    mr = address_space_translate_cached(cache, addr, &addr1, &l, true,
+    mr = address_space_translate_cached(cache, addr, &mr_addr, &l, true,
                                         MEMTXATTRS_UNSPECIFIED);
     return flatview_write_continue(cache->fv,
                                    addr, MEMTXATTRS_UNSPECIFIED, buf, len,
-                                   addr1, l, mr);
+                                   mr_addr, l, mr);
 }
 
 #define ARG1_DECL                MemoryRegionCache *cache
-- 
2.44.0


