Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D4CC3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 13:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU4t5-00012a-5f; Wed, 17 Jul 2024 09:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sU4t2-0000sw-UD
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:40:05 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sU4t1-0007Tv-0G
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:40:04 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-793a3a79a83so2210438a12.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 06:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1721223600; x=1721828400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YXRnQrR7vltoXSYXHi7IhAgNjpxq9maTne8vi5kmaO0=;
 b=TobRxArKJEkOB3Lwmfv4UXNmkO92uBIZqpXywTZcjWz0iscPFK2liWi0jQpPy3IEiD
 n5eJVwsMYreTdVi9RVHfq2llzTkAHfT9TIYeADWV+VEAXZFhtpYakBh4cwsEFoXCF8HR
 vMcsJLfeJi+IjlGmWJtGhMLQ4rdT69iVknW6HPUNuEKuS8uzV9q7zo0DjC1He5CE5FwM
 2IifLDb3qyL/ORGcK5QjsbhdfGQdrCj/SvqRl0RIkr5P83pONRphsA/JIMAJd6J1tJBD
 ed9glj/W189Ipu/OPVwsGcY6liXvELIofNTscHYufyHp6ipqpkPLlgmqXwQ/DcjMp4+J
 eooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721223600; x=1721828400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YXRnQrR7vltoXSYXHi7IhAgNjpxq9maTne8vi5kmaO0=;
 b=bB+b4bztB8GP2wABTHoQFqQSHf4qYZzp9V9WtGmOJf/1bDequlzuavI6Rq+vWS177I
 soS8GiMGy2RulHzaFJsx7nNSyZ2e80FYviVDw8jqavbta56VOMYBhddAXfT20MHbUJGD
 Slf+Y9akjJQX6IErmcYXYeFhsp3x4nfL8yrIDWMDQ9we8WBg930V5EQ/qqYacREEzheg
 mPdEpAHZ+FYEbclO1788jYI3uKfz+Dj8XaxYciFjSvo4GdTqxFU3dNS4NWPTDvoDjWq/
 MRgZkPrzx66CY2f+jxnClmfEHGRlAb1Oxs13eQUOzZY/m+F1Biq684q4QXZk0PspxxnY
 kViw==
X-Gm-Message-State: AOJu0YwDmCTxS6P8aPNmLZkpe77yU8I9eom1aBbhZ4j7sLxOcby1E8R/
 tFyCIqvlIfYC9napnTbTtVzllzMZStdMJ+sVCT5X9IuTFhVnEt22iLpoHAp2wBhrIBWpvTf3Vd2
 j+pYrUk85Y6HY1zGGPCarV5SApKFIoDhrm6N2Hpalof/mMMRkFBcKR68uvDZJCIOzi+tIR0Rg+V
 h1Xy41139b4yYVZ6ku9i7owtDlZpAIpn7ZgNiwag==
X-Google-Smtp-Source: AGHT+IEhFYiPKAJcmMHCQiAv/RxC9Qf0bgVvf4GhEV0jMHuHpRo9DU2lJ6A2ptelZafr7Wr+zeOkaA==
X-Received: by 2002:a05:6a21:6e4b:b0:1c0:dd3d:ef3a with SMTP id
 adf61e73a8af0-1c3fdcd0ac1mr1943388637.29.1721223599905; 
 Wed, 17 Jul 2024 06:39:59 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bc5aa6esm74903495ad.299.2024.07.17.06.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 06:39:59 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH v5 5/5] target/riscv: Inline unit-stride ld/st and
 corresponding functions for performance
Date: Wed, 17 Jul 2024 21:39:36 +0800
Message-Id: <20240717133936.713642-6-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717133936.713642-1-max.chou@sifive.com>
References: <20240717133936.713642-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x530.google.com
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

In the vector unit-stride load/store helper functions. the vext_ldst_us
& vext_ldst_whole functions corresponding most of the execution time.
Inline the functions can avoid the function call overhead to improve the
helper function performance.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/vector_helper.c | 56 +++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 2e675b4220c..95394c425ed 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -150,18 +150,20 @@ typedef void vext_ldst_elem_fn_tlb(CPURISCVState *env, abi_ptr addr,
                                    uint32_t idx, void *vd, uintptr_t retaddr);
 typedef void vext_ldst_elem_fn_host(void *vd, uint32_t idx, void *host);
 
-#define GEN_VEXT_LD_ELEM(NAME, ETYPE, H, LDSUF)                         \
-static void NAME##_tlb(CPURISCVState *env, abi_ptr addr,                \
-                       uint32_t byte_off, void *vd, uintptr_t retaddr)  \
-{                                                                       \
-    ETYPE *cur = vd + byte_off;                                         \
-    *cur = cpu_##LDSUF##_data_ra(env, addr, retaddr);                   \
-}                                                                       \
-                                                                        \
-static void NAME##_host(void *vd, uint32_t byte_off, void *host)        \
-{                                                                       \
-    ETYPE val = LDSUF##_p(host);                                        \
-    *(ETYPE *)(vd + byte_off) = val;                                    \
+#define GEN_VEXT_LD_ELEM(NAME, ETYPE, H, LDSUF)                 \
+static inline QEMU_ALWAYS_INLINE                                \
+void NAME##_tlb(CPURISCVState *env, abi_ptr addr,               \
+                uint32_t byte_off, void *vd, uintptr_t retaddr) \
+{                                                               \
+    ETYPE *cur = vd + byte_off;                                 \
+    *cur = cpu_##LDSUF##_data_ra(env, addr, retaddr);           \
+}                                                               \
+                                                                \
+static inline QEMU_ALWAYS_INLINE                                \
+void NAME##_host(void *vd, uint32_t byte_off, void *host)       \
+{                                                               \
+    ETYPE val = LDSUF##_p(host);                                \
+    *(ETYPE *)(vd + byte_off) = val;                            \
 }
 
 GEN_VEXT_LD_ELEM(lde_b, uint8_t,  H1, ldub)
@@ -169,18 +171,20 @@ GEN_VEXT_LD_ELEM(lde_h, uint16_t, H2, lduw)
 GEN_VEXT_LD_ELEM(lde_w, uint32_t, H4, ldl)
 GEN_VEXT_LD_ELEM(lde_d, uint64_t, H8, ldq)
 
-#define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)                         \
-static void NAME##_tlb(CPURISCVState *env, abi_ptr addr,                \
-                       uint32_t byte_off, void *vd, uintptr_t retaddr)  \
-{                                                                       \
-    ETYPE data = *(ETYPE *)(vd + byte_off);                             \
-    cpu_##STSUF##_data_ra(env, addr, data, retaddr);                    \
-}                                                                       \
-                                                                        \
-static void NAME##_host(void *vd, uint32_t byte_off, void *host)        \
-{                                                                       \
-    ETYPE val = *(ETYPE *)(vd + byte_off);                              \
-    STSUF##_p(host, val);                                               \
+#define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)                 \
+static inline QEMU_ALWAYS_INLINE                                \
+void NAME##_tlb(CPURISCVState *env, abi_ptr addr,               \
+                uint32_t byte_off, void *vd, uintptr_t retaddr) \
+{                                                               \
+    ETYPE data = *(ETYPE *)(vd + byte_off);                     \
+    cpu_##STSUF##_data_ra(env, addr, data, retaddr);            \
+}                                                               \
+                                                                \
+static inline QEMU_ALWAYS_INLINE                                \
+void NAME##_host(void *vd, uint32_t byte_off, void *host)       \
+{                                                               \
+    ETYPE val = *(ETYPE *)(vd + byte_off);                      \
+    STSUF##_p(host, val);                                       \
 }
 
 GEN_VEXT_ST_ELEM(ste_b, uint8_t,  H1, stb)
@@ -366,7 +370,7 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
     }
 }
 
-static void
+static inline QEMU_ALWAYS_INLINE void
 vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
              vext_ldst_elem_fn_tlb *ldst_tlb,
              vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
@@ -695,7 +699,7 @@ GEN_VEXT_LDFF(vle64ff_v, int64_t, lde_d_tlb)
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


