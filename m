Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BECE7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 16:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVuz4-0000w3-EL; Thu, 09 Jan 2025 11:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <craig.blackmore@embecosm.com>)
 id 1tVuz2-0000sw-Iv
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:02:08 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <craig.blackmore@embecosm.com>)
 id 1tVuz0-00044r-PZ
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:02:08 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-306007227d3so5685571fa.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 08:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1736438525; x=1737043325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DxDSvpqW+yXwUGu1fKSUsVB2+c5fcQmxW9MS04Ps9NQ=;
 b=XPJYCcdZc3dYShXKtJn4EPDQ8UZ7BfMB8nAlpKTx3txe0ahLrl2WgY8D/VMx89KVmR
 K/7uRvU4fvCIYJH0vNhHwqwQQ3cK0IGi7kyRmOfjZaNCKC2khr3FR/fOdDu+IX7/mR2z
 cwsUajGE4xVv6RCWNWgksSc1TV8w3ugMXW16DDhPETkJvP3YR0bbrd6xfRsusFmZtwQG
 KevjhUen0NKLD9yxa6nhQCQuqDUcBdUgw9y6xyEo4scDJz0r7K9WUqKWNRQY/gSYqWAx
 31FnEeL9RmNjrgRgT26sb6hraCB1wsQfoeUHiQkq1e26LRknFMfiwMfk2giNhdMmkXdi
 n4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736438525; x=1737043325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DxDSvpqW+yXwUGu1fKSUsVB2+c5fcQmxW9MS04Ps9NQ=;
 b=lIRMK0XjHEEcwRjKqX8RtJ0XrURR9DyU3duCz3BfCe29SfacYSwQShAiAalhByGaif
 3959RI7AJsDUIxDGf+SK2wEaFIRpTVwTf0kD0x21jIUDGgRwBjjlyqRgg0HsYtd+go+w
 n+omRLLbzxsduQVV4+hygLQ9kbUDcROEN1GFh78a23ywBpn+kkejRhAaX93uPLtIa5eL
 Z+Qrj7bYpOjY+nALe2QnhDQADTuGfvUeCTjkGL/bSifWc1fARNvVmZJUqm5EJPu/CFpz
 hG+fqLc+CNVTeUKJOM/AZZsRwiQFJF4AlNg3EyvgjEWe2mo4f7FVUAik/tbcTGntQcKU
 K3fw==
X-Gm-Message-State: AOJu0YwueRNZF7bDyEhvbtcLeoIjakFTnLZ3Rqsqn16ZfJ+kzTguEa6E
 neYcGawpICYjE1iNntrK/I/qUyLBEpJAJld4WR2RPMn4YUxEOFPCQ3R1w8HFFkD+tPyRLS+2Jgs
 PjHo=
X-Gm-Gg: ASbGncu6FWIjsa42f3gIljbSrC2NJiKZ+mvfuGln2Qm6j/o1wU/f6EjwXbUPYDqbotv
 6qlSuD+nkUybZdaYZwdvlO/5N6SQuTdIWCNZgXdbaAc6ltZRkYj3x7OcDPgt1J0nWXgLM5z2Nsl
 wn/zdYjbtEfu747FcmB7ck/Ne232v73uLOJ6xDSZI7jSqOqnR+mo+yaxUEu1MA7y7Bo5EmzWN4K
 Qs+snMvYLZEjgxQcE/u2Pg9fvSMlaMw0910xZE3h0pkeV7Pkv/k2+I4pQ4Es0+ReYJJ87gmY5YQ
 Sk26J9szKAzk
X-Google-Smtp-Source: AGHT+IGmQZl+qYIJWste12ROoqcbpwkrfohVBc4AqSyCO17ZlzOkD8Suu1/zE1eDRKdYaixkO/Ym6A==
X-Received: by 2002:a05:6000:1ac9:b0:385:df73:2f42 with SMTP id
 ffacd0b85a97d-38a873213dfmr6765776f8f.32.1736438513106; 
 Thu, 09 Jan 2025 08:01:53 -0800 (PST)
Received: from dorian.sou.embecosm-corp.com ([212.69.42.53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e383654sm2201524f8f.30.2025.01.09.08.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 08:01:52 -0800 (PST)
From: Craig Blackmore <craig.blackmore@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Craig Blackmore <craig.blackmore@embecosm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>, Paolo Savini <paolo.savini@embecosm.com>
Subject: [PATCH v10 1/1] target/riscv: rvv: Use wider accesses for unit stride
 load/store
Date: Thu,  9 Jan 2025 16:01:22 +0000
Message-ID: <20250109160122.129409-2-craig.blackmore@embecosm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250109160122.129409-1-craig.blackmore@embecosm.com>
References: <20250109160122.129409-1-craig.blackmore@embecosm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=craig.blackmore@embecosm.com; helo=mail-lj1-x233.google.com
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

Use atomic load/store functions to access multiple elements from host.

Co-authored-by: Paolo Savini <paolo.savini@embecosm.com>

Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
Signed-off-by: Craig Blackmore <craig.blackmore@embecosm.com>
---
 target/riscv/vector_helper.c | 95 +++++++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 8 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index a85dd1d200..f9228270b1 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -206,29 +206,108 @@ vext_continus_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
     }
 }
 
+#if !HOST_BIG_ENDIAN
+/* Atomic operations for load/store */
+
+#define GEN_VEXT_LDST_ATOMIC_HOST(SIZE, TYPE)                             \
+static inline QEMU_ALWAYS_INLINE void                                     \
+vext_ldst_atom_##SIZE##_host(void *vd, uint32_t byte_offset, TYPE *host,  \
+                             bool is_load)                                \
+{                                                                         \
+    TYPE *vd_ptr = (TYPE *) (vd + byte_offset);                           \
+    if (is_load) {                                                        \
+        *vd_ptr = qatomic_read__nocheck(host);                            \
+    } else {                                                              \
+        qatomic_set__nocheck(host, *vd_ptr);                              \
+    }                                                                     \
+}                                                                         \
+
+GEN_VEXT_LDST_ATOMIC_HOST(2, uint16_t)
+GEN_VEXT_LDST_ATOMIC_HOST(4, uint32_t)
+#ifdef CONFIG_ATOMIC64
+GEN_VEXT_LDST_ATOMIC_HOST(8, uint64_t)
+#endif
+
+static inline QEMU_ALWAYS_INLINE void
+vext_ldst_atom_16_host(void *vd, uint32_t byte_offset, Int128 *host,
+                       bool is_load)
+{
+    Int128 *vd_ptr = (Int128 *) (vd + byte_offset);
+    if (is_load) {
+        *vd_ptr = atomic16_read_ro(host);
+    } else {
+        atomic16_set(host, *vd_ptr);
+    }
+}
+#endif
+
 static inline QEMU_ALWAYS_INLINE void
 vext_continus_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host *ldst_host,
                         void *vd, uint32_t evl, uint32_t reg_start, void *host,
-                        uint32_t esz, bool is_load)
+                        uint32_t esz, bool is_load, uint32_t log2_esz)
 {
 #if HOST_BIG_ENDIAN
     for (; reg_start < evl; reg_start++, host += esz) {
         ldst_host(vd, reg_start, host);
     }
 #else
-    if (esz == 1) {
-        uint32_t byte_offset = reg_start * esz;
-        uint32_t size = (evl - reg_start) * esz;
+    uint32_t size = (evl - reg_start) * esz;
+    uint32_t test = (uintptr_t) host;
 
+    /* Misaligned load/stores do not require any atomicity */
+    if (esz == 1 || unlikely(test % esz != 0)) {
+        uint32_t byte_offset = reg_start * esz;
         if (is_load) {
             memcpy(vd + byte_offset, host, size);
         } else {
             memcpy(host, vd + byte_offset, size);
         }
-    } else {
-        for (; reg_start < evl; reg_start++, host += esz) {
-            ldst_host(vd, reg_start, host);
+        return;
+    }
+
+    /*
+     * At this point esz > 1 and host is aligned to at least esz, so the ldst
+     * can be completed in atomic chunks of at least esz if the atomic operation
+     * is available.
+     */
+
+    /* Test that both alignment and size are multiples of the atomic width. */
+    test |= size;
+
+    /*
+     * If !HAVE_ATOMIC128_RO, then atomic16_set may be implemented with a
+     * 16-byte compare and store loop, which is expensive, so prefer two 8-byte
+     * stores in this case.
+     */
+    if (HAVE_ATOMIC128_RO && (is_load || HAVE_ATOMIC128_RW)
+        && (test % 16 == 0)) {
+        for (; reg_start < evl; reg_start += 16 >> log2_esz, host += 16) {
+            vext_ldst_atom_16_host(vd, reg_start * esz, host, is_load);
+        }
+        return;
+    }
+#ifdef CONFIG_ATOMIC64
+    if (test % 8 == 0) {
+        for (; reg_start < evl; reg_start += 8 >> log2_esz, host += 8) {
+            vext_ldst_atom_8_host(vd, reg_start * esz, host, is_load);
+        }
+        return;
+    }
+#endif
+    if (test % 4 == 0) {
+        for (; reg_start < evl; reg_start += 4 >> log2_esz, host += 4) {
+            vext_ldst_atom_4_host(vd, reg_start * esz, host, is_load);
+        }
+        return;
+    }
+    if (test % 2 == 0) {
+        for (; reg_start < evl; reg_start += 2 >> log2_esz, host += 2) {
+            vext_ldst_atom_2_host(vd, reg_start * esz, host, is_load);
         }
+        return;
+    }
+    for (; reg_start < evl; reg_start++, host += esz) {
+        ldst_host(vd, reg_start, host);
     }
 #endif
 }
@@ -343,7 +422,7 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
     if (flags == 0) {
         if (nf == 1) {
             vext_continus_ldst_host(env, ldst_host, vd, evl, env->vstart, host,
-                                    esz, is_load);
+                                    esz, is_load, log2_esz);
         } else {
             for (i = env->vstart; i < evl; ++i) {
                 k = 0;
-- 
2.43.0


