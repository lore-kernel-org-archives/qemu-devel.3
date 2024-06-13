Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA464C27C6E
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHobz-00078S-Q1; Thu, 13 Jun 2024 13:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sHoby-00077Z-39
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:51:46 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sHobu-0002eG-QY
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:51:45 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f32a3b9491so12761295ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 10:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718301101; x=1718905901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i0azC50/sTZTZKz6Ls9jt3Za61X+CC0upniJkzZYrcY=;
 b=H+7aIU/buYcfMLrBdBYTf3TZac76rwfUWcEbjsZ/DgTNffhU/ZoBOm4qWZnqbyGkSi
 Y0K3H6AljA3aHKV6BpeyoUxNiQWtHy55w409Lw4TVcecTeNpXQjxrDRblRY6s60GVASC
 VNQ8VNsU8chhL4n+eAmZSSxsffNbVqDMoK65Gmw1mcK10ixECkb0dEsNSgCjIaYAuqaj
 z63aqAGzLybKhcKGWzb3YPHMcBJwaA4do++xLjapTNNvD0iVFgy2lUOjkOAmBpc4bhkz
 3Hu66bB/18qTMgWmZ0h7CVeOYVQO8HqbQWXn2cmx9ZM94EfnRdsSUoLigGBo9rW9nrUa
 n8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718301101; x=1718905901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i0azC50/sTZTZKz6Ls9jt3Za61X+CC0upniJkzZYrcY=;
 b=ReEkyvFdTUckag0B1Hy6jg6+i3FzeRdgbb3Be2nav9Gkd1rwqCt99qWcms2Pi768RV
 viQRsy15E/G8eh/7cRWOl4/Py+1qESxs/5gUeZ/0hzF0jkW6GhShhIvdyEgQQTEYnFzx
 8JUs+jQ1XVDqPXO35bGRv0i0vBxpwbbG5Ig2KPywJcsbLeHY3A6K4uL4A3TMtbyXXA2B
 L/YOSkYgkYJznrSypAi1P/ZdG6S9e7DX9unFp3bNWlXEEIjTqD38aVtHghPS02MVRFJP
 28V9JQGQuu69lTk8WzWsZCgPRMY6sFNzI616JC1CsSPkOGxPziNA+hnVe0ZxtzuPNDVx
 QzMQ==
X-Gm-Message-State: AOJu0YxvcNDBe6VhU76tNB6jKCWbQNMF8GpoKG3W8impqjTDk+Mdn3Np
 ntWF71QRpbB3wKcnh8iU7XukB+3mYfFa0jmIeMiofb/IZdUPvbTU12iAxIlMuaKdafFKcd0lVhS
 nMmeFRDQd6p8iot4kIAjWHZRUcI1gtLjn9d+fYl13cU+/T6T03z+uojosyODMGezM+kcHNfp79F
 91cQr6tcIzFImpQBYvtiNnvI7cgt8bInyvYcQf9w==
X-Google-Smtp-Source: AGHT+IFP0TAMklcxLrPzdRvFOB2dwP0FuB8sxCzgMc04nC9h4spyLXihfc+gxQjed0sTnvwEfJLYZw==
X-Received: by 2002:a17:902:7883:b0:1f6:1780:f7b1 with SMTP id
 d9443c01a7336-1f8625d3880mr3444765ad.17.1718301100918; 
 Thu, 13 Jun 2024 10:51:40 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e55d7dsm16780865ad.14.2024.06.13.10.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 10:51:40 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH v4 4/5] target/riscv: rvv: Provide group continuous ld/st
 flow for unit-stride ld/st instructions
Date: Fri, 14 Jun 2024 01:51:21 +0800
Message-Id: <20240613175122.1299212-5-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613175122.1299212-1-max.chou@sifive.com>
References: <20240613175122.1299212-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The vector unmasked unit-stride and whole register load/store
instructions will load/store continuous memory. If the endian of both
the host and guest architecture are the same, then we can group the
element load/store to load/store more data at a time.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/vector_helper.c | 160 +++++++++++++++++++++++++----------
 1 file changed, 117 insertions(+), 43 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 793337a6f96..cba46ef16a5 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -457,6 +457,69 @@ GEN_VEXT_ST_ELEM(ste_h, uint16_t, H2, stw)
 GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl)
 GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq)
 
+static inline uint32_t
+vext_group_ldst_host(CPURISCVState *env, void *vd, uint32_t byte_end,
+                     uint32_t byte_offset, void *host, uint32_t esz,
+                     bool is_load)
+{
+    uint32_t group_size;
+    static vext_ldst_elem_fn_host * const fns[2][4] = {
+        /* Store */
+        { ste_b_host, ste_h_host, ste_w_host, ste_d_host },
+        /* Load */
+        { lde_b_host, lde_h_host, lde_w_host, lde_d_host }
+    };
+    vext_ldst_elem_fn_host *fn;
+
+    if (byte_offset + 8 < byte_end) {
+        group_size = MO_64;
+    } else if (byte_offset + 4 < byte_end) {
+        group_size = MO_32;
+    } else if (byte_offset + 2 < byte_end) {
+        group_size = MO_16;
+    } else {
+        group_size = MO_8;
+    }
+
+    fn = fns[is_load][group_size];
+    fn(vd, byte_offset, host + byte_offset);
+
+    return 1 << group_size;
+}
+
+static inline void
+vext_continus_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
+                       void *vd, uint32_t evl, target_ulong addr,
+                       uint32_t reg_start, uintptr_t ra, uint32_t esz,
+                       bool is_load)
+{
+    for (; reg_start < evl; reg_start++, addr += esz) {
+        ldst_tlb(env, adjust_addr(env, addr), reg_start * esz, vd, ra);
+    }
+}
+
+static inline void
+vext_continus_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host *ldst_host,
+                        void *vd, uint32_t evl, uint32_t reg_start, void *host,
+                        uint32_t esz, bool is_load)
+{
+#if TARGET_BIG_ENDIAN != HOST_BIG_ENDIAN
+    for (; reg_start < evl; reg_start++) {
+        uint32_t byte_off = reg_start * esz;
+        ldst_host(vd, byte_off, host + byte_off);
+    }
+#else
+    uint32_t group_byte;
+    uint32_t byte_start = reg_start * esz;
+    uint32_t byte_end = evl * esz;
+    while (byte_start < byte_end) {
+        group_byte = vext_group_ldst_host(env, vd, byte_end, byte_start, host,
+                                          esz, is_load);
+        byte_start += group_byte;
+    }
+#endif
+}
+
 static void vext_set_tail_elems_1s(target_ulong vl, void *vd,
                                    uint32_t desc, uint32_t nf,
                                    uint32_t esz, uint32_t max_elems)
@@ -555,6 +618,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
              uint32_t evl, uintptr_t ra, bool is_load)
 {
     RVVContLdSt info;
+    target_ulong addr;
     void *host;
     int flags;
     intptr_t reg_start, reg_last;
@@ -587,13 +651,19 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
         }
         reg_last += 1;
 
-        for (i = reg_start; i < reg_last; ++i) {
-            k = 0;
-            while (k < nf) {
-                target_ulong addr = base + ((i * nf + k) << log2_esz);
-                ldst_tlb(env, adjust_addr(env, addr),
-                         (i + k * max_elems) << log2_esz, vd, ra);
-                k++;
+        if (nf == 1) {
+            addr = base + reg_start * esz;
+            vext_continus_ldst_tlb(env, ldst_tlb, vd, reg_last, addr,
+                                   reg_start, ra, esz, is_load);
+        } else {
+            for (i = reg_start; i < reg_last; ++i) {
+                k = 0;
+                while (k < nf) {
+                    addr = base + ((i * nf + k) * esz);
+                    ldst_tlb(env, adjust_addr(env, addr),
+                             (i + k * max_elems) << log2_esz, vd, ra);
+                    k++;
+                }
             }
         }
 
@@ -607,12 +677,17 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     reg_last = info.reg_idx_last[0] + 1;
     host = info.page[0].host;
 
-    for (i = reg_start; i < reg_last; ++i) {
-        k = 0;
-        while (k < nf) {
-            ldst_host(vd, (i + k * max_elems) << log2_esz,
-                      host + ((i * nf + k) << log2_esz));
-            k++;
+    if (nf == 1) {
+        vext_continus_ldst_host(env, ldst_host, vd, reg_last, reg_start, host,
+                                esz, is_load);
+    } else {
+        for (i = reg_start; i < reg_last; ++i) {
+            k = 0;
+            while (k < nf) {
+                ldst_host(vd, (i + k * max_elems) << log2_esz,
+                          host + ((i * nf + k) * esz));
+                k++;
+            }
         }
     }
 
@@ -624,7 +699,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
         reg_start = info.reg_idx_split;
         k = 0;
         while (k < nf) {
-            target_ulong addr = base + ((reg_start * nf + k) << log2_esz);
+            addr = base + ((reg_start * nf + k) << log2_esz);
             ldst_tlb(env, adjust_addr(env, addr),
                      (reg_start + k * max_elems) << log2_esz, vd, ra);
             k++;
@@ -636,12 +711,17 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
         reg_last = info.reg_idx_last[1] + 1;
         host = info.page[1].host;
 
-        for (i = reg_start; i < reg_last; ++i) {
-            k = 0;
-            while (k < nf) {
-                ldst_host(vd, (i + k * max_elems) << log2_esz,
-                          host + ((i * nf + k) << log2_esz));
-                k++;
+        if (nf == 1) {
+            vext_continus_ldst_host(env, ldst_host, vd, reg_last, reg_start,
+                                    host, esz, is_load);
+        } else {
+            for (i = reg_start; i < reg_last; ++i) {
+                k = 0;
+                while (k < nf) {
+                    ldst_host(vd, (i + k * max_elems) << log2_esz,
+                              host + ((i * nf + k) << log2_esz));
+                    k++;
+                }
             }
         }
     }
@@ -974,20 +1054,17 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
              * load/store rest of elements of current segment pointed by vstart
              */
             addr = base + (reg_start << log2_esz);
-            for (; reg_start < evl; reg_start++, addr += esz) {
-                ldst_tlb(env, adjust_addr(env, addr), reg_start << log2_esz,
-                         vd, ra);
-            }
+            vext_continus_ldst_tlb(env, ldst_tlb, vd, evl, addr, reg_start, ra,
+                                   esz, is_load);
             idx_nf++;
         }
 
         /* load/store elements for rest of segments */
         evl = nf * max_elems;
         addr = base + (reg_start << log2_esz);
-        for (; reg_start < evl; reg_start++, addr += esz) {
-            ldst_tlb(env, adjust_addr(env, addr), reg_start << log2_esz, vd,
-                     ra);
-        }
+        reg_start = idx_nf * max_elems;
+        vext_continus_ldst_tlb(env, ldst_tlb, vd, evl, addr, reg_start, ra,
+                               esz, is_load);
 
         env->vstart = 0;
         return;
@@ -1003,17 +1080,16 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
 
     if (off) {
         /* load/store rest of elements of current segment pointed by vstart */
-        for (; reg_start < evl; reg_start++) {
-            ldst_host(vd, reg_start << log2_esz,
-                      host + (reg_start << log2_esz));
-        }
+        vext_continus_ldst_host(env, ldst_host, vd, evl, reg_start, host, esz,
+                                is_load);
         idx_nf++;
     }
 
     /* load/store elements for rest of segments */
-    for (; reg_start < reg_last; reg_start++) {
-        ldst_host(vd, reg_start << log2_esz, host + (reg_start << log2_esz));
-    }
+    evl = reg_last;
+    reg_start = idx_nf * max_elems;
+    vext_continus_ldst_host(env, ldst_host, vd, evl, reg_start, host, esz,
+                            is_load);
 
     /*
      * Use the slow path to manage the cross-page misalignment.
@@ -1037,18 +1113,16 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
             /*
              * load/store rest of elements of current segment pointed by vstart
              */
-            for (; reg_start < evl; reg_start++) {
-                ldst_host(vd, reg_start << log2_esz,
-                          host + (reg_start << log2_esz));
-            }
+            vext_continus_ldst_host(env, ldst_host, vd, evl, reg_start, host,
+                                    esz, is_load);
             idx_nf++;
         }
 
         /* load/store elements for rest of segments */
-        for (; reg_start < reg_last; reg_start++) {
-            ldst_host(vd, reg_start << log2_esz,
-                      host + (reg_start << log2_esz));
-        }
+        evl = reg_last;
+        reg_start = idx_nf * max_elems;
+        vext_continus_ldst_host(env, ldst_host, vd, evl, reg_start, host, esz,
+                                is_load);
     }
 
     env->vstart = 0;
-- 
2.34.1


