Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93476C27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 14:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHlIe-0000Kk-Bl; Thu, 13 Jun 2024 10:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sHlIc-0000J9-KA
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 10:19:34 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sHlIa-0003gC-UK
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 10:19:34 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f70131063cso10527965ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 07:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718288371; x=1718893171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oaOaaoMmlyje8Yi3g2JX3kO1iEufFu1UTGhlSxPfEi8=;
 b=BXUH4f7pCPV5ORvQIwND5KBbsQW7iiXimzaQPCYfzpaAwXoNw6ktnXkI2ThLZcp3e5
 DMLHE1qa+AxJu66Apz2nmRArWSmsoSLrlo17w+aOIQs/eSemNJFNCXVkD5B//CehN94D
 ACxk9/JDwt38jj3krmhT8Pxfdftv+bCUEvUblOgER9GTTwRAQOOLa/uvds4bi2aVRVNZ
 UvgCEeDQivmlzg/RFiXfQeQnpGzIOBfGWP4FLo6F4zll7zi5h8FmrfRYlK8gdg2BDDvC
 Qqz7+48HlFYcbj+4FuM4prR70NdnrDo/V0oTYcTy3owYznt/7ou9W7R5K80pCtxuyMa6
 N3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718288371; x=1718893171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oaOaaoMmlyje8Yi3g2JX3kO1iEufFu1UTGhlSxPfEi8=;
 b=TN3kMZ7p354FAkRSrBzWdigbPeXbafmmZKylCT1TZ311ldf5dh2uGKztRXYUePp37Q
 +V9MRGw6kP973o0+u0q8azJx9XYDIVjT1xxuQ58fvYS8Prb4Ak/1CzlirtYMAhrZaQZg
 P/KUe07YPEt38UVUmAFzGoqVNvOac+Qy/1HDrifO+UTz7nWIadMrOK/H+Sx4kiNFQeM6
 nwuuCFwCa7SpfkBAR2neKVn9mdkkThPCPt022kmfkXq/76IPiD7YA424M7L32jERBdif
 V1+jEMyml0m9Y8HjfOVOICirUeRFs6BcZj1fkeJGpKtHNItK81gHQyU3XHInF0DO+ipa
 7nFA==
X-Gm-Message-State: AOJu0Yws1s0FHEv//DPKbCYhLrXLBzXeW/iZrXIwuST3Qsmo6z8MrdwY
 IoKx1IV4JLPuupxQVPpsF5BDSnAw4flEdW6rAcPZZO6rEnXzFSEm6USkT3lwm2jrjNzRWYi+NDx
 UL6yh+/sbEppislppAUH+/8PI3ftRwuhQCbaavjanJp02h3XnOzTUwKoFMc/8k2stE8XFUKEfWa
 W4zOksCDYSK5veJNCubpdhZZEhBPvNkxD8NqkPvw==
X-Google-Smtp-Source: AGHT+IFb068M+3tGjZBVSOt48c82I/e4QkTdKcx/eWMOAvHzhk3dZqkQ1V+tWEOwKFGawG8kclytpQ==
X-Received: by 2002:a17:902:d4cb:b0:1f7:3763:5ffb with SMTP id
 d9443c01a7336-1f83b74d134mr52952515ad.59.1718288371270; 
 Thu, 13 Jun 2024 07:19:31 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855f2fe6dsm14386975ad.257.2024.06.13.07.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 07:19:31 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH v3 5/5] target/riscv: Inline unit-stride ld/st and
 corresponding functions for performance
Date: Thu, 13 Jun 2024 22:19:06 +0800
Message-Id: <20240613141906.1276105-6-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613141906.1276105-1-max.chou@sifive.com>
References: <20240613141906.1276105-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x630.google.com
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
index 09c9b231c3f..4a21064a366 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -408,20 +408,22 @@ typedef void vext_ldst_elem_fn_tlb(CPURISCVState *env, abi_ptr addr,
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
@@ -429,20 +431,22 @@ GEN_VEXT_LD_ELEM(lde_h, uint16_t, H2, lduw)
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
@@ -604,7 +608,7 @@ GEN_VEXT_ST_STRIDE(vsse64_v, int64_t, ste_d_tlb)
  */
 
 /* unmasked unit-stride load and store operation */
-static void
+static inline QEMU_ALWAYS_INLINE void
 vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
              vext_ldst_elem_fn_tlb *ldst_tlb,
              vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
@@ -1006,7 +1010,7 @@ GEN_VEXT_LDFF(vle64ff_v, int64_t, lde_d_tlb)
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


