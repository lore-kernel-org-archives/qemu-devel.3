Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DE3D65C56
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 14:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVsax-0002Pd-6O; Wed, 17 Dec 2025 09:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVsav-0002Lj-PF
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:33:37 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVsat-0007RF-PR
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:33:37 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-477aa218f20so39438215e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 06:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765982013; x=1766586813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ruVgiLAX4pIcKIdX5Gb+1F0dTqHySf0+5Iyb0GQxoak=;
 b=GH2MbCMP0PC6IENO0Lm9oOlwyptLOlSxFevQ9Rch49qlTmRPy9O3+zMp2iTSRr1zO3
 y88lBzE6INSABm6yOOPTeQApvA4B6JNTQrCGTb+81Ehh5rO0ghy77jxf+pQxRTiCrTYu
 49B5W20Klk/kEX13Gc3LbZLx2housSlmnmk+tPLw/Qgv/afeZvS3I0ufkx/xFzty5jRk
 4P8ak9cQucTfKMchS3m87isIzrztcgCFruKrtOurb97hq0TlxinnjvTIm/ncbhSPJ2T7
 JjeGUdYMW/7hKzlZ4fmGEqXdyWAWV29nFJMaEmPK4U0+Hba2huRKM2ZzmJEkOFnbhDgU
 nzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765982013; x=1766586813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ruVgiLAX4pIcKIdX5Gb+1F0dTqHySf0+5Iyb0GQxoak=;
 b=uhlnyPDSLuM/4+YrCUYJ3vHCPaAx+0hbFRGWxvo4NDdRyvbKPzHTtxiDhr7r+kJ5ud
 7raSjDJF5dwizH2ZPivlcYx+sAyoG3pJrou8qoDUwAwAmrobZdh8guk1fCxdLvdJyrRf
 UWyAS4ZMNlpH4GqFDjKKz8Kk55ewB2bSB5RuO3F6VdPctuBxai6DVj3WcWiXQo4noEJi
 4PEa28y9LRU8RF3B61RuX6/W3lDL0eLYecQEq4V4NMhNcfs86xhz6pdxJ/A3qQ9Ni7ud
 gaQRjb4OenrJWcMNt+sljfnC39xWVr4DrqZLBjCAlmbHfczATkxO9IH7Sk2yoktIrsdD
 ZXpA==
X-Gm-Message-State: AOJu0YyAJuLITT1cA7WVoDmH+CZuBf0SvXe5m6Fb+jVLTgPJYkP7BLDn
 ovFAEGXFHU7i+igbzDQy4znXn9hZ7kF4Ups22Uh5rMq5vnANT906fmuRFpYSQ6EmXZE6Qtk+tP8
 zmAx5+SEMXP/a
X-Gm-Gg: AY/fxX4YB03RWF76hsXCJpVLcYCKTknOYeVH3PlyUaAfMCTinDxvOxQ8qwDyfZz3ruE
 behm/+aMIlKqLZLqHRv+nN46NE/1wATWYADAdTjtVhXVskLe6h5oHuTv5IbTYR2LEgJAnIr/DQW
 uyaDUKzgDkoNo2Ukh7ZHfpPIsfPBAGGEcaKmgDKoIUxqNGdnxvADYLpxuZw2nTW8o7aiPFLbm+L
 jCNw/GtNeD7UXsyHyIvHh71+6+Ow/sM2070GnRu/kKMIeTWogVviGGs19uKZ02+jc8iZ1KUhj/4
 M9lTly1Ra0KhEXsH0RaT7DbZyEetjvKSpX6HjPt29D69z0KLxcZAjHujSYA9OIcj17jE2OxX2KJ
 Lwln1m0N1gl3199FjFWHHWCcM4U0W0Kdo2JAoEmDt7EJlJaO2V/6m5outHcUOYr248ADqIkND7L
 aYzOUnXYtT0Kt7uxdcpAPlDNvG9OAg4f0cg+TtoLFgb3w7tlp6LuEf3GYe19EO
X-Google-Smtp-Source: AGHT+IFbwGs5GMaGym0pvXkgDiFIXfgS0x9fXYvOKPoEBdrV9yaQyQYlbKisrdSkEYf1RQdx6Pp9Ug==
X-Received: by 2002:a05:600c:4711:b0:475:da1a:53f9 with SMTP id
 5b1f17b1804b1-47a8f8c13a4mr158132765e9.14.1765982012772; 
 Wed, 17 Dec 2025 06:33:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47bdc2221e3sm38847355e9.10.2025.12.17.06.33.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Dec 2025 06:33:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@kernel.org>, Peter Xu <peterx@redhat.com>
Subject: [PATCH 13/14] system/memory: Pass device_endian argument as MemOp bit
Date: Wed, 17 Dec 2025 15:31:49 +0100
Message-ID: <20251217143150.94463-14-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217143150.94463-1-philmd@linaro.org>
References: <20251217143150.94463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

Use the MemOp argument to hold both the access size and
its endianness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/memory_ldst.c.inc        | 86 ++++++++++++---------------------
 system/memory_ldst_endian.c.inc | 20 +++-----
 2 files changed, 38 insertions(+), 68 deletions(-)

diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index e0c0c3f5dca..6387bb9d332 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -24,8 +24,7 @@ static inline
 uint64_t glue(address_space_ldm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
                                                   hwaddr addr,
                                                   MemTxAttrs attrs,
-                                                  MemTxResult *result,
-                                                  enum device_endian endian)
+                                                  MemTxResult *result)
 {
     const unsigned size = memop_size(mop);
     uint8_t *ptr;
@@ -42,22 +41,15 @@ uint64_t glue(address_space_ldm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val,
-                                        mop | devend_memop(endian), attrs);
+        r = memory_region_dispatch_read(mr, addr1, &val, mop, attrs);
     } else {
         /* RAM case */
         fuzz_dma_read_cb(addr, size, mr);
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
+        if ((mop & MO_BSWAP) == MO_LE) {
             val = ldn_le_p(ptr, size);
-            break;
-        case DEVICE_BIG_ENDIAN:
+        } else {
             val = ldn_be_p(ptr, size);
-            break;
-        default:
-            val = ldn_p(ptr, size);
-            break;
         }
         r = MEMTX_OK;
     }
@@ -73,45 +65,40 @@ uint64_t glue(address_space_ldm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
 
 /* warning: addr must be aligned */
 static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
-    enum device_endian endian)
+    MemOp mop, hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
-    return glue(address_space_ldm_internal, SUFFIX)(ARG1, MO_32, addr,
-                                                    attrs, result, endian);
+    return glue(address_space_ldm_internal, SUFFIX)(ARG1, mop | MO_32, addr,
+                                                    attrs, result);
 }
 
 /* warning: addr must be aligned */
 static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
-    enum device_endian endian)
+    MemOp mop, hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
-    return glue(address_space_ldm_internal, SUFFIX)(ARG1, MO_64, addr,
-                                                    attrs, result, endian);
+    return glue(address_space_ldm_internal, SUFFIX)(ARG1, mop | MO_64, addr,
+                                                    attrs, result);
 }
 
 uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
     return glue(address_space_ldm_internal, SUFFIX)(ARG1, MO_8, addr,
-                                                    attrs, result,
-                                                    DEVICE_NATIVE_ENDIAN);
+                                                    attrs, result);
 }
 
 /* warning: addr must be aligned */
 static inline uint16_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
-    enum device_endian endian)
+    MemOp mop, hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
-    return glue(address_space_ldm_internal, SUFFIX)(ARG1, MO_16, addr,
-                                                    attrs, result, endian);
+    return glue(address_space_ldm_internal, SUFFIX)(ARG1, mop | MO_16, addr,
+                                                    attrs, result);
 }
 
 static inline
 void glue(address_space_stm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
                                               hwaddr addr, uint64_t val,
                                               MemTxAttrs attrs,
-                                              MemTxResult *result,
-                                              enum device_endian endian)
+                                              MemTxResult *result)
 {
     const unsigned size = memop_size(mop);
     uint8_t *ptr;
@@ -125,21 +112,14 @@ void glue(address_space_stm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
     if (l < size || !memory_access_is_direct(mr, true, attrs)) {
         release_lock |= prepare_mmio_access(mr);
-        r = memory_region_dispatch_write(mr, addr1, val,
-                                         mop | devend_memop(endian), attrs);
+        r = memory_region_dispatch_write(mr, addr1, val, mop, attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
+        if ((mop & MO_BSWAP) == MO_LE) {
             stn_le_p(ptr, size, val);
-            break;
-        case DEVICE_BIG_ENDIAN:
+        } else {
             stn_be_p(ptr, size, val);
-            break;
-        default:
-            stn_p(ptr, size, val);
-            break;
         }
         invalidate_and_set_dirty(mr, addr1, size);
         r = MEMTX_OK;
@@ -155,48 +135,44 @@ void glue(address_space_stm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
 
 /* warning: addr must be aligned */
 static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint32_t val, MemTxAttrs attrs,
-    MemTxResult *result, enum device_endian endian)
+    MemOp mop, hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
 {
-    glue(address_space_stm_internal, SUFFIX)(ARG1, MO_32, addr, val,
-                                             attrs, result, endian);
+    glue(address_space_stm_internal, SUFFIX)(ARG1, mop | MO_32, addr, val,
+                                             attrs, result);
 }
 
 void glue(address_space_stb, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result)
 {
     glue(address_space_stm_internal, SUFFIX)(ARG1, MO_8, addr, val,
-                                             attrs, result,
-                                             DEVICE_NATIVE_ENDIAN);
+                                             attrs, result);
 }
 
 /* warning: addr must be aligned */
 static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint16_t val, MemTxAttrs attrs,
-    MemTxResult *result, enum device_endian endian)
+    MemOp mop, hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result)
 {
-    glue(address_space_stm_internal, SUFFIX)(ARG1, MO_16, addr, val,
-                                             attrs, result, endian);
+    glue(address_space_stm_internal, SUFFIX)(ARG1, mop | MO_16, addr, val,
+                                             attrs, result);
 }
 
 static inline void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs,
-    MemTxResult *result, enum device_endian endian)
+    MemOp mop, hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
 {
-    glue(address_space_stm_internal, SUFFIX)(ARG1, MO_64, addr, val,
-                                             attrs, result, endian);
+    glue(address_space_stm_internal, SUFFIX)(ARG1, mop | MO_64, addr, val,
+                                             attrs, result);
 }
 
 #define ENDIANNESS
-#define DEVICE_ENDIANNESS       DEVICE_NATIVE_ENDIAN
+#define MO_ENDIAN               (target_big_endian() ? MO_BE : MO_LE)
 #include "memory_ldst_endian.c.inc"
 
 #define ENDIANNESS              _le
-#define DEVICE_ENDIANNESS       DEVICE_LITTLE_ENDIAN
+#define MO_ENDIAN               MO_LE
 #include "memory_ldst_endian.c.inc"
 
 #define ENDIANNESS              _be
-#define DEVICE_ENDIANNESS       DEVICE_BIG_ENDIAN
+#define MO_ENDIAN               MO_BE
 #include "memory_ldst_endian.c.inc"
 
 #undef ARG1_DECL
diff --git a/system/memory_ldst_endian.c.inc b/system/memory_ldst_endian.c.inc
index 16d686b50f7..8a4b4a3d220 100644
--- a/system/memory_ldst_endian.c.inc
+++ b/system/memory_ldst_endian.c.inc
@@ -22,43 +22,37 @@
 uint16_t ADDRESS_SPACE_LD(uw)(ARG1_DECL, hwaddr addr,
                               MemTxAttrs attrs, MemTxResult *result)
 {
-    return ADDRESS_SPACE_LD_INTERNAL(uw)(ARG1, addr, attrs, result,
-                                         DEVICE_ENDIANNESS);
+    return ADDRESS_SPACE_LD_INTERNAL(uw)(ARG1, MO_ENDIAN, addr, attrs, result);
 }
 
 uint32_t ADDRESS_SPACE_LD(l)(ARG1_DECL, hwaddr addr,
                              MemTxAttrs attrs, MemTxResult *result)
 {
-    return ADDRESS_SPACE_LD_INTERNAL(l)(ARG1, addr, attrs, result,
-                                        DEVICE_ENDIANNESS);
+    return ADDRESS_SPACE_LD_INTERNAL(l)(ARG1, MO_ENDIAN, addr, attrs, result);
 }
 
 uint64_t ADDRESS_SPACE_LD(q)(ARG1_DECL, hwaddr addr,
                              MemTxAttrs attrs, MemTxResult *result)
 {
-    return ADDRESS_SPACE_LD_INTERNAL(q)(ARG1, addr, attrs, result,
-                                        DEVICE_ENDIANNESS);
+    return ADDRESS_SPACE_LD_INTERNAL(q)(ARG1, MO_ENDIAN, addr, attrs, result);
 }
 
 void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
                          MemTxAttrs attrs, MemTxResult *result)
 {
-    ADDRESS_SPACE_ST_INTERNAL(w)(ARG1, addr, val, attrs, result,
-                                 DEVICE_ENDIANNESS);
+    ADDRESS_SPACE_ST_INTERNAL(w)(ARG1, MO_ENDIAN, addr, val, attrs, result);
 }
 
 void ADDRESS_SPACE_ST(l)(ARG1_DECL, hwaddr addr, uint32_t val,
                          MemTxAttrs attrs, MemTxResult *result)
 {
-    ADDRESS_SPACE_ST_INTERNAL(l)(ARG1, addr, val, attrs, result,
-                                 DEVICE_ENDIANNESS);
+    ADDRESS_SPACE_ST_INTERNAL(l)(ARG1, MO_ENDIAN, addr, val, attrs, result);
 }
 
 void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr, uint64_t val,
                          MemTxAttrs attrs, MemTxResult *result)
 {
-    ADDRESS_SPACE_ST_INTERNAL(q)(ARG1, addr, val, attrs, result,
-                                 DEVICE_ENDIANNESS);
+    ADDRESS_SPACE_ST_INTERNAL(q)(ARG1, MO_ENDIAN, addr, val, attrs, result);
 }
 
 #undef ADDRESS_SPACE_LD
@@ -67,4 +61,4 @@ void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr, uint64_t val,
 #undef ADDRESS_SPACE_ST_INTERNAL
 
 #undef ENDIANNESS
-#undef DEVICE_ENDIANNESS
+#undef MO_ENDIAN
-- 
2.52.0


