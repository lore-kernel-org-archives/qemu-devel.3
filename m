Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671E3D65C56
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 14:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVsas-0002FD-KX; Wed, 17 Dec 2025 09:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVsao-0002Eo-RD
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:33:30 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVsam-0007NO-Qk
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:33:30 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-477aa218f20so39436805e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 06:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765982005; x=1766586805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yTrLTCQAR+WIjoXDYPtn5NC7w8Km68fucdOgKRYF8+w=;
 b=Sl3Y7HCfeYEvXkubXuwWPKfA1roNEzXQV2ljZdRuRcAhwctvxIfztj0bA9JHdINQxE
 +fKhQ0zE0ljO9GITNQMWNwq9WFJFJbZ0/MqNbvzVlmpuLDAdLjoeyUaMYJ8sgSJxbwic
 n03NlShzU789ozO+s7dYlmU7FcIRi/sZ4pdhWEmcj2tRLUJp07QkzmygPeyaSyGIqOTK
 wGkDCpmZO9kAzEiYyYb5NOvQgGUgSjzewAaKSAIUacLjz2Tn6r8YAQfp8Ktqm84+lP1I
 6oKmGFFE0TOtV6ORlBW/3iTiiDk5oYKt0TVd36uP2ABk630x2wJUJHPMXr+8PYyz2Dt3
 gu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765982005; x=1766586805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yTrLTCQAR+WIjoXDYPtn5NC7w8Km68fucdOgKRYF8+w=;
 b=mPeqTHz+yG9LJSwRCCtrbwbyu/uuXlX2w1pIZztDqqnaW3t3X33Hzjl75dzXPPVdKq
 DFlIwbb8u41+pQE0CODwnKPLnft8UYaAOEGeA/pyExyg8gOXQ1ZLyKuwVELSZj30aVj9
 4/qtR9NHqpQa655uO3+tuM1RKPsyazIi4/Ih3cuY7wmsL6UF8KpDANrlolVerH66z/kY
 XXUlzCL4tYRyW/58fyHUP7tEs4iRqrocYWwytyWyiPukn3xRD5i8+PawbI17L6umeSdO
 zuyFgTB5+kaW82PwfWA4lQAackdvyJq63ejsyd3xHjtCrakpQj/ot8jE4Lu52j9XWl61
 8hcw==
X-Gm-Message-State: AOJu0YwVcrMXrdfHabcguxCj52+iliCc9GyQMPqxBAiLvTwUG50r88wQ
 zTuEat/KGGdT5j0yPLm7kzdatA9NuxXsyeMg2r1SlnrzjHR/FkIuQhJam+77Y8rrG/H4z0crqkN
 ApCp4YotSxQ==
X-Gm-Gg: AY/fxX4oN/fdV0PCbZuVO4xEnO5MxBAOw+4un0f1+7gj7AUaxdhuEaqIhm1jqEyI7Lt
 qCoa8HF3F9mNFIGEzWJcq7TnuuWlxPhyw4XAtm2mh5LWFPuBe9A3RyPf4jud2UGuOVp5STYJ03T
 l5XfyvNBjUWOwFIlyLjgpBy8QaaojQyi4rb7QN3QHlpFSLb45axnJ8bt/Gedydc2N8fwvMa2tnn
 a+mtCskLFuhVu1ukax11Zw5kegBdVHhIAGXXKgci1gy8Jd+Eb4qrf60Qmqo6GCrqYiVuJvCkp60
 mgQAw2/OpGE5A3iHbjzDQ71bOdF8QWgnd7BGvYaCRq/g2UZtXtW7xks0gTQOfNw1Ppvsv8UbfZg
 kH89GnazpL+Ls6uP4ztEoXgQRt0RnfwlRmucBYS6g3UH6IKRnJZ2BcHQfPTeUTnRfrjiJ2JxEi/
 56pqad+pXHanIdLi+L3JXt9503EnrwTgM17MfiKiZjsFpqLguCMDEQcsiEZuFk
X-Google-Smtp-Source: AGHT+IFTin2JM+CLAmSbZODJyBZA4akFudZGUkoGoluWu+1O0xt3/YpAGKNEU8E8K+a+3YdonoBhUA==
X-Received: by 2002:a05:600c:3588:b0:477:9cdb:e337 with SMTP id
 5b1f17b1804b1-47a933a89a1mr190058025e9.7.1765982005321; 
 Wed, 17 Dec 2025 06:33:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47bdc1efda5sm41204055e9.15.2025.12.17.06.33.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Dec 2025 06:33:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@kernel.org>, Peter Xu <peterx@redhat.com>
Subject: [PATCH 12/14] system/memory: Factor address_space_ldst[M]_internal()
 helper out
Date: Wed, 17 Dec 2025 15:31:48 +0100
Message-ID: <20251217143150.94463-13-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217143150.94463-1-philmd@linaro.org>
References: <20251217143150.94463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

All the LD/ST[W,L,Q] variants use the same template, only
modifying the access size used. Unify as a single pair of
LD/ST methods taking a MemOp argument. Thus use the 'm'
suffix for MemOp.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/memory_ldst.c.inc | 289 ++++++++-------------------------------
 1 file changed, 58 insertions(+), 231 deletions(-)

diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index 823fc3a7561..e0c0c3f5dca 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -20,39 +20,43 @@
  */
 
 /* warning: addr must be aligned */
-static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
-    enum device_endian endian)
+static inline
+uint64_t glue(address_space_ldm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
+                                                  hwaddr addr,
+                                                  MemTxAttrs attrs,
+                                                  MemTxResult *result,
+                                                  enum device_endian endian)
 {
+    const unsigned size = memop_size(mop);
     uint8_t *ptr;
     uint64_t val;
     MemoryRegion *mr;
-    hwaddr l = 4;
+    hwaddr l = size;
     hwaddr addr1;
     MemTxResult r;
     bool release_lock = false;
 
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, false, attrs);
-    if (l < 4 || !memory_access_is_direct(mr, false, attrs)) {
+    if (l < size || !memory_access_is_direct(mr, false, attrs)) {
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
         r = memory_region_dispatch_read(mr, addr1, &val,
-                                        MO_32 | devend_memop(endian), attrs);
+                                        mop | devend_memop(endian), attrs);
     } else {
         /* RAM case */
-        fuzz_dma_read_cb(addr, 4, mr);
+        fuzz_dma_read_cb(addr, size, mr);
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
         switch (endian) {
         case DEVICE_LITTLE_ENDIAN:
-            val = ldl_le_p(ptr);
+            val = ldn_le_p(ptr, size);
             break;
         case DEVICE_BIG_ENDIAN:
-            val = ldl_be_p(ptr);
+            val = ldn_be_p(ptr, size);
             break;
         default:
-            val = ldl_p(ptr);
+            val = ldn_p(ptr, size);
             break;
         }
         r = MEMTX_OK;
@@ -67,87 +71,30 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
     return val;
 }
 
+/* warning: addr must be aligned */
+static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
+    enum device_endian endian)
+{
+    return glue(address_space_ldm_internal, SUFFIX)(ARG1, MO_32, addr,
+                                                    attrs, result, endian);
+}
+
 /* warning: addr must be aligned */
 static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
     enum device_endian endian)
 {
-    uint8_t *ptr;
-    uint64_t val;
-    MemoryRegion *mr;
-    hwaddr l = 8;
-    hwaddr addr1;
-    MemTxResult r;
-    bool release_lock = false;
-
-    RCU_READ_LOCK();
-    mr = TRANSLATE(addr, &addr1, &l, false, attrs);
-    if (l < 8 || !memory_access_is_direct(mr, false, attrs)) {
-        release_lock |= prepare_mmio_access(mr);
-
-        /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val,
-                                        MO_64 | devend_memop(endian), attrs);
-    } else {
-        /* RAM case */
-        fuzz_dma_read_cb(addr, 8, mr);
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
-            val = ldq_le_p(ptr);
-            break;
-        case DEVICE_BIG_ENDIAN:
-            val = ldq_be_p(ptr);
-            break;
-        default:
-            val = ldq_p(ptr);
-            break;
-        }
-        r = MEMTX_OK;
-    }
-    if (result) {
-        *result = r;
-    }
-    if (release_lock) {
-        bql_unlock();
-    }
-    RCU_READ_UNLOCK();
-    return val;
+    return glue(address_space_ldm_internal, SUFFIX)(ARG1, MO_64, addr,
+                                                    attrs, result, endian);
 }
 
 uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
-    uint8_t *ptr;
-    uint64_t val;
-    MemoryRegion *mr;
-    hwaddr l = 1;
-    hwaddr addr1;
-    MemTxResult r;
-    bool release_lock = false;
-
-    RCU_READ_LOCK();
-    mr = TRANSLATE(addr, &addr1, &l, false, attrs);
-    if (!memory_access_is_direct(mr, false, attrs)) {
-        release_lock |= prepare_mmio_access(mr);
-
-        /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val, MO_8, attrs);
-    } else {
-        /* RAM case */
-        fuzz_dma_read_cb(addr, 1, mr);
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        val = ldub_p(ptr);
-        r = MEMTX_OK;
-    }
-    if (result) {
-        *result = r;
-    }
-    if (release_lock) {
-        bql_unlock();
-    }
-    RCU_READ_UNLOCK();
-    return val;
+    return glue(address_space_ldm_internal, SUFFIX)(ARG1, MO_8, addr,
+                                                    attrs, result,
+                                                    DEVICE_NATIVE_ENDIAN);
 }
 
 /* warning: addr must be aligned */
@@ -155,37 +102,46 @@ static inline uint16_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
     enum device_endian endian)
 {
+    return glue(address_space_ldm_internal, SUFFIX)(ARG1, MO_16, addr,
+                                                    attrs, result, endian);
+}
+
+static inline
+void glue(address_space_stm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
+                                              hwaddr addr, uint64_t val,
+                                              MemTxAttrs attrs,
+                                              MemTxResult *result,
+                                              enum device_endian endian)
+{
+    const unsigned size = memop_size(mop);
     uint8_t *ptr;
-    uint64_t val;
     MemoryRegion *mr;
-    hwaddr l = 2;
+    hwaddr l = size;
     hwaddr addr1;
     MemTxResult r;
     bool release_lock = false;
 
     RCU_READ_LOCK();
-    mr = TRANSLATE(addr, &addr1, &l, false, attrs);
-    if (l < 2 || !memory_access_is_direct(mr, false, attrs)) {
+    mr = TRANSLATE(addr, &addr1, &l, true, attrs);
+    if (l < size || !memory_access_is_direct(mr, true, attrs)) {
         release_lock |= prepare_mmio_access(mr);
-
-        /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val,
-                                        MO_16 | devend_memop(endian), attrs);
+        r = memory_region_dispatch_write(mr, addr1, val,
+                                         mop | devend_memop(endian), attrs);
     } else {
         /* RAM case */
-        fuzz_dma_read_cb(addr, 2, mr);
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
         switch (endian) {
         case DEVICE_LITTLE_ENDIAN:
-            val = lduw_le_p(ptr);
+            stn_le_p(ptr, size, val);
             break;
         case DEVICE_BIG_ENDIAN:
-            val = lduw_be_p(ptr);
+            stn_be_p(ptr, size, val);
             break;
         default:
-            val = lduw_p(ptr);
+            stn_p(ptr, size, val);
             break;
         }
+        invalidate_and_set_dirty(mr, addr1, size);
         r = MEMTX_OK;
     }
     if (result) {
@@ -195,7 +151,6 @@ static inline uint16_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
         bql_unlock();
     }
     RCU_READ_UNLOCK();
-    return val;
 }
 
 /* warning: addr must be aligned */
@@ -203,74 +158,16 @@ static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs,
     MemTxResult *result, enum device_endian endian)
 {
-    uint8_t *ptr;
-    MemoryRegion *mr;
-    hwaddr l = 4;
-    hwaddr addr1;
-    MemTxResult r;
-    bool release_lock = false;
-
-    RCU_READ_LOCK();
-    mr = TRANSLATE(addr, &addr1, &l, true, attrs);
-    if (l < 4 || !memory_access_is_direct(mr, true, attrs)) {
-        release_lock |= prepare_mmio_access(mr);
-        r = memory_region_dispatch_write(mr, addr1, val,
-                                         MO_32 | devend_memop(endian), attrs);
-    } else {
-        /* RAM case */
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
-            stl_le_p(ptr, val);
-            break;
-        case DEVICE_BIG_ENDIAN:
-            stl_be_p(ptr, val);
-            break;
-        default:
-            stl_p(ptr, val);
-            break;
-        }
-        invalidate_and_set_dirty(mr, addr1, 4);
-        r = MEMTX_OK;
-    }
-    if (result) {
-        *result = r;
-    }
-    if (release_lock) {
-        bql_unlock();
-    }
-    RCU_READ_UNLOCK();
+    glue(address_space_stm_internal, SUFFIX)(ARG1, MO_32, addr, val,
+                                             attrs, result, endian);
 }
 
 void glue(address_space_stb, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result)
 {
-    uint8_t *ptr;
-    MemoryRegion *mr;
-    hwaddr l = 1;
-    hwaddr addr1;
-    MemTxResult r;
-    bool release_lock = false;
-
-    RCU_READ_LOCK();
-    mr = TRANSLATE(addr, &addr1, &l, true, attrs);
-    if (!memory_access_is_direct(mr, true, attrs)) {
-        release_lock |= prepare_mmio_access(mr);
-        r = memory_region_dispatch_write(mr, addr1, val, MO_8, attrs);
-    } else {
-        /* RAM case */
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        stb_p(ptr, val);
-        invalidate_and_set_dirty(mr, addr1, 1);
-        r = MEMTX_OK;
-    }
-    if (result) {
-        *result = r;
-    }
-    if (release_lock) {
-        bql_unlock();
-    }
-    RCU_READ_UNLOCK();
+    glue(address_space_stm_internal, SUFFIX)(ARG1, MO_8, addr, val,
+                                             attrs, result,
+                                             DEVICE_NATIVE_ENDIAN);
 }
 
 /* warning: addr must be aligned */
@@ -278,86 +175,16 @@ static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint16_t val, MemTxAttrs attrs,
     MemTxResult *result, enum device_endian endian)
 {
-    uint8_t *ptr;
-    MemoryRegion *mr;
-    hwaddr l = 2;
-    hwaddr addr1;
-    MemTxResult r;
-    bool release_lock = false;
-
-    RCU_READ_LOCK();
-    mr = TRANSLATE(addr, &addr1, &l, true, attrs);
-    if (l < 2 || !memory_access_is_direct(mr, true, attrs)) {
-        release_lock |= prepare_mmio_access(mr);
-        r = memory_region_dispatch_write(mr, addr1, val,
-                                         MO_16 | devend_memop(endian), attrs);
-    } else {
-        /* RAM case */
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
-            stw_le_p(ptr, val);
-            break;
-        case DEVICE_BIG_ENDIAN:
-            stw_be_p(ptr, val);
-            break;
-        default:
-            stw_p(ptr, val);
-            break;
-        }
-        invalidate_and_set_dirty(mr, addr1, 2);
-        r = MEMTX_OK;
-    }
-    if (result) {
-        *result = r;
-    }
-    if (release_lock) {
-        bql_unlock();
-    }
-    RCU_READ_UNLOCK();
+    glue(address_space_stm_internal, SUFFIX)(ARG1, MO_16, addr, val,
+                                             attrs, result, endian);
 }
 
 static inline void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs,
     MemTxResult *result, enum device_endian endian)
 {
-    uint8_t *ptr;
-    MemoryRegion *mr;
-    hwaddr l = 8;
-    hwaddr addr1;
-    MemTxResult r;
-    bool release_lock = false;
-
-    RCU_READ_LOCK();
-    mr = TRANSLATE(addr, &addr1, &l, true, attrs);
-    if (l < 8 || !memory_access_is_direct(mr, true, attrs)) {
-        release_lock |= prepare_mmio_access(mr);
-        r = memory_region_dispatch_write(mr, addr1, val,
-                                         MO_64 | devend_memop(endian), attrs);
-    } else {
-        /* RAM case */
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
-            stq_le_p(ptr, val);
-            break;
-        case DEVICE_BIG_ENDIAN:
-            stq_be_p(ptr, val);
-            break;
-        default:
-            stq_p(ptr, val);
-            break;
-        }
-        invalidate_and_set_dirty(mr, addr1, 8);
-        r = MEMTX_OK;
-    }
-    if (result) {
-        *result = r;
-    }
-    if (release_lock) {
-        bql_unlock();
-    }
-    RCU_READ_UNLOCK();
+    glue(address_space_stm_internal, SUFFIX)(ARG1, MO_64, addr, val,
+                                             attrs, result, endian);
 }
 
 #define ENDIANNESS
-- 
2.52.0


