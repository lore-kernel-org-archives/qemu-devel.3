Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E906C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 13:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU4t2-0000pM-20; Wed, 17 Jul 2024 09:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sU4t0-0000j7-Bc
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:40:02 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sU4sx-0007TS-Nb
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:40:01 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fc5239faebso4441335ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 06:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1721223597; x=1721828397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z6Ehnl/PC6i+F6ruu+0LWnyhe2hlKO/B5I8PcWhvJ30=;
 b=WgiDzTO3lA8bwV4C5/rbaL8uK6neHuEvI99B9Uvy2dxQ+ec6GiVdTbFgCzmYkFVpJM
 Kwfddj3LyozTTJyWEiZrZ5M7QQLq3BHCx65z8JrnfLR9g2fHaDoR8K1pR1WKDpALPBnv
 6XAviYUcB0Yqn4jlnM4/Ce8sTteyPpGznBSvxR5aiarKR2vhLQntEV9dM9BfKqvw1F/h
 eEREntaWO3+f+vHx62QSiPMlg0iCbOYO5nF7ZSEotihsiThs7ZWHHGiSeUKxGyMUET9w
 flwdfF5lUvQS+kAkt6obUrQwpwkKhydZmy4YX2pR8aCgBJ1rKKaHgKCh5NP6fyW9yonI
 7P+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721223597; x=1721828397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z6Ehnl/PC6i+F6ruu+0LWnyhe2hlKO/B5I8PcWhvJ30=;
 b=K+hFCiW8wYYBOXB12ajZqsYetw2Wb6X4NEAOuIMtlqkZpmqLNS5uHy0gbcUl6+CBTc
 I1BoDRTTMPVwR4ZoDNaIJXfz1bROKqBPQ2RUr2UxIy0wEurRP7CAC7L9geHlOWEghJBq
 ZxHDcR3HiYQczFQXLvefTyvCeum1jdBFo6cD+XBy+CE86DPv6Y3iA8MpcG5md8BGcFca
 YRVFtSG9kW4tc+nZgG37hkHah/U+/bkNPp2ALG239WLTXBJHkMD6brbBVtbcZainqcdf
 S7P+IBy+QpJg+/Cn/lbYs4TvOM7qot5Rww+CLT7DLD7Cb2ItIxf0nRxAlGorJ2cMNyWw
 7/BQ==
X-Gm-Message-State: AOJu0YxZYu3OR3xp8WP+oLeDJJ23CNoq4Mma18AyusYC4vwxappLR+5h
 n8eVmdkw+sGXv89/bWo1kTMGWb7S55kCVOzXOJd1KWUM4mt+X7LdPrKe5Oh/PJLXeNRUSsO+10T
 6d1vgCib+xIBj0u4vMDtyAItjZ3Zhj0mW0R9AMBi7ZyUgxyGhdWvKeQpkx5avhS0xeoqpvE7+Ei
 kwgx0IAiLsVjtCqhdyZvo5EHZkpDA/sbfXnINAEA==
X-Google-Smtp-Source: AGHT+IGjRLPU/NirqcygJsnHY63Eon2tLPCacB2JY4snTGbeP50DBiB2/Q1kbCiRn6LIwIDFXYoLRw==
X-Received: by 2002:a17:903:1211:b0:1f6:fcd9:5b86 with SMTP id
 d9443c01a7336-1fc4e121a48mr13418155ad.12.1721223597024; 
 Wed, 17 Jul 2024 06:39:57 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bc5aa6esm74903495ad.299.2024.07.17.06.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 06:39:56 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH v5 4/5] target/riscv: rvv: Provide group continuous ld/st
 flow for unit-stride ld/st instructions
Date: Wed, 17 Jul 2024 21:39:35 +0800
Message-Id: <20240717133936.713642-5-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717133936.713642-1-max.chou@sifive.com>
References: <20240717133936.713642-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62c.google.com
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

The vector unmasked unit-stride and whole register load/store
instructions will load/store continuous memory. If the endian of both
the host and guest architecture are the same, then we can group the
element load/store to load/store more data at a time.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/vector_helper.c | 72 +++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 14 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 5343a08e6ad..2e675b4220c 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -188,6 +188,40 @@ GEN_VEXT_ST_ELEM(ste_h, uint16_t, H2, stw)
 GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl)
 GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq)
 
+static inline QEMU_ALWAYS_INLINE void
+vext_continus_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
+                       void *vd, uint32_t evl, target_ulong addr,
+                       uint32_t reg_start, uintptr_t ra, uint32_t esz,
+                       bool is_load)
+{
+    uint32_t i;
+    for (i = env->vstart; i < evl; env->vstart = ++i, addr += esz) {
+        ldst_tlb(env, adjust_addr(env, addr), i * esz, vd, ra);
+    }
+}
+
+static inline QEMU_ALWAYS_INLINE void
+vext_continus_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host *ldst_host,
+                        void *vd, uint32_t evl, uint32_t reg_start, void *host,
+                        uint32_t esz, bool is_load)
+{
+#if TARGET_BIG_ENDIAN != HOST_BIG_ENDIAN
+    for (; reg_start < evl; reg_start++, host += esz) {
+        uint32_t byte_off = reg_start * esz;
+        ldst_host(vd, byte_off, host);
+    }
+#else
+    uint32_t byte_offset = reg_start * esz;
+    uint32_t size = (evl - reg_start) * esz;
+
+    if (is_load) {
+        memcpy(vd + byte_offset, host, size);
+    } else {
+        memcpy(host, vd + byte_offset, size);
+    }
+#endif
+}
+
 static void vext_set_tail_elems_1s(target_ulong vl, void *vd,
                                    uint32_t desc, uint32_t nf,
                                    uint32_t esz, uint32_t max_elems)
@@ -299,24 +333,34 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
                                mmu_index, true, &host, ra);
 
     if (host && flags == 0) {
-        for (i = env->vstart; i < evl; ++i) {
-            k = 0;
-            while (k < nf) {
-                ldst_host(vd, (i + k * max_elems) << log2_esz, host);
-                host += esz;
-                k++;
+        if (nf == 1) {
+            vext_continus_ldst_host(env, ldst_host, vd, evl, env->vstart, host,
+                                    esz, is_load);
+        } else {
+            for (i = env->vstart; i < evl; ++i) {
+                k = 0;
+                while (k < nf) {
+                    ldst_host(vd, (i + k * max_elems) << log2_esz, host);
+                    host += esz;
+                    k++;
+                }
             }
         }
         env->vstart += elems;
     } else {
-        /* load bytes from guest memory */
-        for (i = env->vstart; i < evl; env->vstart = ++i) {
-            k = 0;
-            while (k < nf) {
-                ldst_tlb(env, adjust_addr(env, addr),
-                         (i + k * max_elems) << log2_esz, vd, ra);
-                addr += esz;
-                k++;
+        if (nf == 1) {
+            vext_continus_ldst_tlb(env, ldst_tlb, vd, evl, addr, env->vstart,
+                                   ra, esz, is_load);
+        } else {
+            /* load bytes from guest memory */
+            for (i = env->vstart; i < evl; env->vstart = ++i) {
+                k = 0;
+                while (k < nf) {
+                    ldst_tlb(env, adjust_addr(env, addr),
+                            (i + k * max_elems) << log2_esz, vd, ra);
+                    addr += esz;
+                    k++;
+                }
             }
         }
     }
-- 
2.34.1


