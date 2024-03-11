Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F8BC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjngX-0000Uu-NU; Mon, 11 Mar 2024 17:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngV-0000Pc-IW
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngT-00040L-8f
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZYSgvTN7t6/1mUzIu1ZJuxJpeE9c58Iqz1Li8XbeIy4=;
 b=KKTDBxKP9w1swh+96f3iWCgnaXYD1IwHoVgyzaNB4bRAe2a9rCYxiXuysTNlv9z/hSDBnC
 UNq8sbAo6Sui651+6VYmUUT76AZgWdCSA0kt/Pu1G1/CG3ZLiYxSnFTS1/5x2PCVMahOr6
 zCdnkhl1i8aJd19cjVuP/FNjSlu5OcU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-Q6qJFhJuMdqhnQ7aF5jtYQ-1; Mon, 11 Mar 2024 17:59:47 -0400
X-MC-Unique: Q6qJFhJuMdqhnQ7aF5jtYQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-690ab2b0de1so15043976d6.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 14:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194386; x=1710799186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZYSgvTN7t6/1mUzIu1ZJuxJpeE9c58Iqz1Li8XbeIy4=;
 b=M276jH+59TL7jDehxmzzBveTBDSTPL2QOQE7c4v/lps7Mamv0gBaCLBWWGNNT7gK6o
 gpCYmGDQEJEYShDl7feOiSinMSFpC/4jOttvNXCydiKVPnBt1t1jL95MnS4h65HwXsBN
 qeLcj1SBrU81VKJnykGr7n7UVf05fAa9up7r2c2GX2b3oQPF8E4ka83uTqG9HyHrTg3t
 uhRIFUSfdOLHX525fbCtvt/GzC0fBNyb3UgJjVDrnn+WgjTcVlDQMgvaX5AhkrzR7qjz
 XQKubzshNDN1Z7N9iFoqHnOtiUZ3r1kjCERRRi+HIuW/Jg7LUNlJ3MfHblZvgkQBOfiV
 Gxjw==
X-Gm-Message-State: AOJu0Yyd8gw9eQthwvvGy2rPIIyEj/liwfrZ3Tw4TvWqegfGgABUuemj
 o6lG9E1bUE6qG6xpI0lfOCLfXLv2pr/Ld5G1WaGrBGQzR7p+b7r+2UkHf6543nIaaSRiGuFmvPs
 WOW/kz8zC/TcXAXoqD83LCx4sEjcEMhJ/e2GvBX0wpQtT2RQlPaTMOGiz667BRHHFw9LL5YPByB
 c6hE4r1d2c4eOej9XWuR2WdPom4Ah3c8o0+A==
X-Received: by 2002:a0c:eb83:0:b0:68f:e779:70f2 with SMTP id
 x3-20020a0ceb83000000b0068fe77970f2mr136347qvo.3.1710194386549; 
 Mon, 11 Mar 2024 14:59:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEq9hjgHMwGjne1kqoTLcdFTY7SEPw50PVak5JmXopJTgKo+USkUHX9sc6GXJ1EBqsSqdrBA==
X-Received: by 2002:a0c:eb83:0:b0:68f:e779:70f2 with SMTP id
 x3-20020a0ceb83000000b0068fe77970f2mr136314qvo.3.1710194385967; 
 Mon, 11 Mar 2024 14:59:45 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.14.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:59:45 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 13/34] physmem: Factor out body of
 flatview_read/write_continue() loop
Date: Mon, 11 Mar 2024 17:59:04 -0400
Message-ID: <20240311215925.40618-14-peterx@redhat.com>
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

This code will be reused for the address_space_cached accessors
shortly.

Also reduce scope of result variable now we aren't directly
calling this in the loop.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20240307153710.30907-4-Jonathan.Cameron@huawei.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/physmem.c | 169 +++++++++++++++++++++++++++--------------------
 1 file changed, 99 insertions(+), 70 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index e35aa29343..737869a3f5 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2681,6 +2681,56 @@ static bool flatview_access_allowed(MemoryRegion *mr, MemTxAttrs attrs,
     return false;
 }
 
+static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
+                                                const uint8_t *buf,
+                                                hwaddr len, hwaddr mr_addr,
+                                                hwaddr *l, MemoryRegion *mr)
+{
+    if (!flatview_access_allowed(mr, attrs, mr_addr, *l)) {
+        return MEMTX_ACCESS_ERROR;
+    }
+
+    if (!memory_access_is_direct(mr, true)) {
+        uint64_t val;
+        MemTxResult result;
+        bool release_lock = prepare_mmio_access(mr);
+
+        *l = memory_access_size(mr, *l, mr_addr);
+        /*
+         * XXX: could force current_cpu to NULL to avoid
+         * potential bugs
+         */
+
+        /*
+         * Assure Coverity (and ourselves) that we are not going to OVERRUN
+         * the buffer by following ldn_he_p().
+         */
+#ifdef QEMU_STATIC_ANALYSIS
+        assert((*l == 1 && len >= 1) ||
+               (*l == 2 && len >= 2) ||
+               (*l == 4 && len >= 4) ||
+               (*l == 8 && len >= 8));
+#endif
+        val = ldn_he_p(buf, *l);
+        result = memory_region_dispatch_write(mr, mr_addr, val,
+                                              size_memop(*l), attrs);
+        if (release_lock) {
+            bql_unlock();
+        }
+
+        return result;
+    } else {
+        /* RAM case */
+        uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
+                                               false);
+
+        memmove(ram_ptr, buf, *l);
+        invalidate_and_set_dirty(mr, mr_addr, *l);
+
+        return MEMTX_OK;
+    }
+}
+
 /* Called within RCU critical section.  */
 static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
                                            MemTxAttrs attrs,
@@ -2692,44 +2742,8 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
     const uint8_t *buf = ptr;
 
     for (;;) {
-        if (!flatview_access_allowed(mr, attrs, mr_addr, l)) {
-            result |= MEMTX_ACCESS_ERROR;
-            /* Keep going. */
-        } else if (!memory_access_is_direct(mr, true)) {
-            uint64_t val;
-            bool release_lock = prepare_mmio_access(mr);
-
-            l = memory_access_size(mr, l, mr_addr);
-            /* XXX: could force current_cpu to NULL to avoid
-               potential bugs */
-
-            /*
-             * Assure Coverity (and ourselves) that we are not going to OVERRUN
-             * the buffer by following ldn_he_p().
-             */
-#ifdef QEMU_STATIC_ANALYSIS
-            assert((l == 1 && len >= 1) ||
-                   (l == 2 && len >= 2) ||
-                   (l == 4 && len >= 4) ||
-                   (l == 8 && len >= 8));
-#endif
-            val = ldn_he_p(buf, l);
-            result |= memory_region_dispatch_write(mr, mr_addr, val,
-                                                   size_memop(l), attrs);
-            if (release_lock) {
-                bql_unlock();
-            }
-
-
-        } else {
-            /* RAM case */
-
-            uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, &l,
-                                                   false);
-
-            memmove(ram_ptr, buf, l);
-            invalidate_and_set_dirty(mr, mr_addr, l);
-        }
+        result |= flatview_write_continue_step(attrs, buf, len, mr_addr, &l,
+                                               mr);
 
         len -= l;
         buf += l;
@@ -2763,6 +2777,52 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
                                    mr_addr, l, mr);
 }
 
+static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
+                                               hwaddr len, hwaddr mr_addr,
+                                               hwaddr *l,
+                                               MemoryRegion *mr)
+{
+    if (!flatview_access_allowed(mr, attrs, mr_addr, *l)) {
+        return MEMTX_ACCESS_ERROR;
+    }
+
+    if (!memory_access_is_direct(mr, false)) {
+        /* I/O case */
+        uint64_t val;
+        MemTxResult result;
+        bool release_lock = prepare_mmio_access(mr);
+
+        *l = memory_access_size(mr, *l, mr_addr);
+        result = memory_region_dispatch_read(mr, mr_addr, &val, size_memop(*l),
+                                             attrs);
+
+        /*
+         * Assure Coverity (and ourselves) that we are not going to OVERRUN
+         * the buffer by following stn_he_p().
+         */
+#ifdef QEMU_STATIC_ANALYSIS
+        assert((*l == 1 && len >= 1) ||
+               (*l == 2 && len >= 2) ||
+               (*l == 4 && len >= 4) ||
+               (*l == 8 && len >= 8));
+#endif
+        stn_he_p(buf, *l, val);
+
+        if (release_lock) {
+            bql_unlock();
+        }
+        return result;
+    } else {
+        /* RAM case */
+        uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
+                                               false);
+
+        memcpy(buf, ram_ptr, *l);
+
+        return MEMTX_OK;
+    }
+}
+
 /* Called within RCU critical section.  */
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    MemTxAttrs attrs, void *ptr,
@@ -2774,38 +2834,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
 
     fuzz_dma_read_cb(addr, len, mr);
     for (;;) {
-        if (!flatview_access_allowed(mr, attrs, mr_addr, l)) {
-            result |= MEMTX_ACCESS_ERROR;
-            /* Keep going. */
-        } else if (!memory_access_is_direct(mr, false)) {
-            /* I/O case */
-            uint64_t val;
-            bool release_lock = prepare_mmio_access(mr);
-
-            l = memory_access_size(mr, l, mr_addr);
-            result |= memory_region_dispatch_read(mr, mr_addr, &val,
-                                                  size_memop(l), attrs);
-
-            /*
-             * Assure Coverity (and ourselves) that we are not going to OVERRUN
-             * the buffer by following stn_he_p().
-             */
-#ifdef QEMU_STATIC_ANALYSIS
-            assert((l == 1 && len >= 1) ||
-                   (l == 2 && len >= 2) ||
-                   (l == 4 && len >= 4) ||
-                   (l == 8 && len >= 8));
-#endif
-            stn_he_p(buf, l, val);
-            if (release_lock) {
-                bql_unlock();
-            }
-        } else {
-            /* RAM case */
-            uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, &l,
-                                                   false);
-            memcpy(buf, ram_ptr, l);
-        }
+        result |= flatview_read_continue_step(attrs, buf, len, mr_addr, &l, mr);
 
         len -= l;
         buf += l;
-- 
2.44.0


