Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A195BC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHoc0-00079M-VQ; Thu, 13 Jun 2024 13:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sHobz-00078Q-MT
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:51:47 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sHobx-0002g6-Bd
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:51:47 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f717ee193fso10133605ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718301104; x=1718905904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xcioUVXfeL3EIHP7AWKsep1C5ehKcEX649P/Ggmw2I4=;
 b=nM9MaIqO6fN/IVxS9VeevFze5gxYngXA92D+UftJSkJ24l1Ml8AcojXuN8HeCrQWHQ
 pz+yzusOci1kPQmo9GwMOjkizRo/LTNtClhhJmEJ5xrTrFShtvR28jPNjJ4wzXU6C+sT
 GMn7KWQjCogs6gqNp0I/hyW1Xt2iWUKC1KTDYCgDV7hC7JDLBbAsWLpSAB+XXrzfXOEc
 7XNHcq9MMrbGrLf7cqYFu9k66Gw501AXeuvbgTQZEHu47/JcBxUBKJuwFzoIzsiF5iq3
 wmTFjXlpf6iY/754KK0T0JRJ4ifmXzkPwPVhIhOE/TVhzZOTbyLeZY3ibB63MGqEb2qs
 z1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718301104; x=1718905904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xcioUVXfeL3EIHP7AWKsep1C5ehKcEX649P/Ggmw2I4=;
 b=bA3b6t9UpVvmod9YCplp4T8wB6pNqThXZvrsINqQUokt1rgGKHNyNJCxiSg5qAkrs+
 trwVSDoUYAAWyJ3IMtFUbMqqZjnQMdi041qyoPeDM44fQkKy1X7B9N1UCzVworSqE7/y
 YiqWrRGlQ/icBQs8UgOQbAphW7w4TZVp9jPjByqpsGMRBIGIn18kKQfqrI5sFlZr80Lm
 tEW2Iz5Bh2O1uokeQnwdGOOUoTyiqppi1OhRBVDfIbOKPvv9Rcs9iER09u18QxcbGiCw
 rXuAFu5MGmYskOFpk+BFAK1sgbXATZCxZxWfKypOv3+J2yXNZVWexUsh9gsYtx3DFGxH
 H6dg==
X-Gm-Message-State: AOJu0Yxwz4vUsQw+dl4JgaSNqRCpwLqsc5LoXsvrG0wJhQicmAKdnyPB
 mjuDBUb+PHa1OD7B87/hFUvegpsLmxsfa9wMf71Zra93DfY7pv0PmlTjUAg83m8du/d9R7eQBka
 J1h4ivxfN1RAm+ybVxCh2whsTeodm8vnZuqT+hiVSNfTTe2pQEwjLXhZ2mnSwnFXBbhtz/Odn/c
 IihMDFEokpKHctDxFcVDnyO3kW2CSyvX4iZtq2+Q==
X-Google-Smtp-Source: AGHT+IGMHYyk29K31R4i7vYqjqj2qwXYzzK3m/8F9PTUHUZgOGZNi6aA/LsLXYH09ohNMR6iC7ghJA==
X-Received: by 2002:a17:902:64c9:b0:1f7:1640:cef4 with SMTP id
 d9443c01a7336-1f8629fea9bmr3947895ad.59.1718301103855; 
 Thu, 13 Jun 2024 10:51:43 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e55d7dsm16780865ad.14.2024.06.13.10.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 10:51:43 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH v4 5/5] target/riscv: Inline unit-stride ld/st and
 corresponding functions for performance
Date: Fri, 14 Jun 2024 01:51:22 +0800
Message-Id: <20240613175122.1299212-6-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613175122.1299212-1-max.chou@sifive.com>
References: <20240613175122.1299212-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62a.google.com
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

In the vector unit-stride load/store helper functions. the vext_ldst_us
& vext_ldst_whole functions corresponding most of the execution time.
Inline the functions can avoid the function call overhead to improve the
helper function performance.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/vector_helper.c | 64 +++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index cba46ef16a5..29849a8b66f 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -415,20 +415,22 @@ typedef void vext_ldst_elem_fn_tlb(CPURISCVState *env, abi_ptr addr,
                                    uint32_t idx, void *vd, uintptr_t retaddr);
 typedef void vext_ldst_elem_fn_host(void *vd, uint32_t idx, void *host);
 
-#define GEN_VEXT_LD_ELEM(NAME, ETYPE, H, LDSUF)                         \
-static void NAME##_tlb(CPURISCVState *env, abi_ptr addr,                \
-                       uint32_t byte_off, void *vd, uintptr_t retaddr)  \
-{                                                                       \
-    uint8_t *reg = ((uint8_t *)vd + byte_off);                          \
-    ETYPE *cur = ((ETYPE *)reg);                                        \
-    *cur = cpu_##LDSUF##_data_ra(env, addr, retaddr);                   \
-}                                                                       \
-                                                                        \
-static void NAME##_host(void *vd, uint32_t byte_off, void *host)        \
-{                                                                       \
-    ETYPE val = LDSUF##_p(host);                                        \
-    uint8_t *reg = (uint8_t *)(vd + byte_off);                          \
-    *(ETYPE *)(reg) = val;                                              \
+#define GEN_VEXT_LD_ELEM(NAME, ETYPE, H, LDSUF)                 \
+static inline QEMU_ALWAYS_INLINE                                \
+void NAME##_tlb(CPURISCVState *env, abi_ptr addr,               \
+                uint32_t byte_off, void *vd, uintptr_t retaddr) \
+{                                                               \
+    uint8_t *reg = ((uint8_t *)vd + byte_off);                  \
+    ETYPE *cur = ((ETYPE *)reg);                                \
+    *cur = cpu_##LDSUF##_data_ra(env, addr, retaddr);           \
+}                                                               \
+                                                                \
+static inline QEMU_ALWAYS_INLINE                                \
+void NAME##_host(void *vd, uint32_t byte_off, void *host)       \
+{                                                               \
+    ETYPE val = LDSUF##_p(host);                                \
+    uint8_t *reg = (uint8_t *)(vd + byte_off);                  \
+    *(ETYPE *)(reg) = val;                                      \
 }
 
 GEN_VEXT_LD_ELEM(lde_b, uint8_t,  H1, ldub)
@@ -436,20 +438,22 @@ GEN_VEXT_LD_ELEM(lde_h, uint16_t, H2, lduw)
 GEN_VEXT_LD_ELEM(lde_w, uint32_t, H4, ldl)
 GEN_VEXT_LD_ELEM(lde_d, uint64_t, H8, ldq)
 
-#define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)                         \
-static void NAME##_tlb(CPURISCVState *env, abi_ptr addr,                \
-                       uint32_t byte_off, void *vd, uintptr_t retaddr)  \
-{                                                                       \
-    uint8_t *reg = ((uint8_t *)vd + byte_off);                          \
-    ETYPE data = *((ETYPE *)reg);                                       \
-    cpu_##STSUF##_data_ra(env, addr, data, retaddr);                    \
-}                                                                       \
-                                                                        \
-static void NAME##_host(void *vd, uint32_t byte_off, void *host)        \
-{                                                                       \
-    uint8_t *reg = ((uint8_t *)vd + byte_off);                          \
-    ETYPE val = *(ETYPE *)(reg);                                        \
-    STSUF##_p(host, val);                                               \
+#define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)                 \
+static inline QEMU_ALWAYS_INLINE                                \
+void NAME##_tlb(CPURISCVState *env, abi_ptr addr,               \
+                uint32_t byte_off, void *vd, uintptr_t retaddr) \
+{                                                               \
+    uint8_t *reg = ((uint8_t *)vd + byte_off);                  \
+    ETYPE data = *((ETYPE *)reg);                               \
+    cpu_##STSUF##_data_ra(env, addr, data, retaddr);            \
+}                                                               \
+                                                                \
+static inline QEMU_ALWAYS_INLINE                                \
+void NAME##_host(void *vd, uint32_t byte_off, void *host)       \
+{                                                               \
+    uint8_t *reg = ((uint8_t *)vd + byte_off);                  \
+    ETYPE val = *(ETYPE *)(reg);                                \
+    STSUF##_p(host, val);                                       \
 }
 
 GEN_VEXT_ST_ELEM(ste_b, uint8_t,  H1, stb)
@@ -611,7 +615,7 @@ GEN_VEXT_ST_STRIDE(vsse64_v, int64_t, ste_d_tlb)
  */
 
 /* unmasked unit-stride load and store operation */
-static void
+static inline QEMU_ALWAYS_INLINE void
 vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
              vext_ldst_elem_fn_tlb *ldst_tlb,
              vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
@@ -1013,7 +1017,7 @@ GEN_VEXT_LDFF(vle64ff_v, int64_t, lde_d_tlb)
 /*
  * load and store whole register instructions
  */
-static void
+static inline QEMU_ALWAYS_INLINE void
 vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
                 vext_ldst_elem_fn_tlb *ldst_tlb,
                 vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
-- 
2.34.1


