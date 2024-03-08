Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9082AC54E41
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 21:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riiAk-0007XW-6J; Fri, 08 Mar 2024 16:54:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riiAi-0007XA-Od
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:54:32 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riiAe-0001lM-Ma
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:54:32 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dc49b00bdbso10043045ad.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 13:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709934867; x=1710539667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WPv1GnJuf3vxj4lT8MdhVUXk9E54Nc8mHaYKvIc7l6M=;
 b=cBKK1yIkcQ6nvL2K0D9lzTFf+JzDzD1oPD5BNXRfXBK98P1GRcl3bUOdPTsG+voHyG
 uQb9XZjQ2KRKt8XEKywNrQDaVystSZJgh11LnqlOQ+XQkJipFp6dX68rnu6GiF+ZOfrC
 QOrPTUyxqXvKnE4doJbT8mm44kX8b2GQrAOHibHtjcGpXowV0lnbQ2Zm0g7YYk0WuEQ+
 QkRe9uNjrDZQuzMr54BU3WAwsGs7iFnMKVplMnK9DQ3fEbQ/i79cfcavZRwCpahsyXoZ
 kWQ9wq3bh80H97ld1cSaotoLN7tKn/RvBsb2QyQPq1/IwEfXshJDjFgiYFX0Gmlfv2qR
 +k7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709934867; x=1710539667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WPv1GnJuf3vxj4lT8MdhVUXk9E54Nc8mHaYKvIc7l6M=;
 b=KlvmwXq0nwbOSFXcyG/Tg1VsCwK7HrzYpBrorjdWjdTVR6/u921s8mpua1b7THLL39
 e7oBSwScrpTyVcV7qVuNIb35JoZxmaBpZf3uUBTb07fAsMD4gm/7EVPdVtYp8icrQbrH
 qfgP3FnUWEwQNkRkhmrxFy+dohOUx1VWn6zZyBqoqPcWPblBsE/M3IsrtM2rcjAOOvjp
 BWCItI6Myl5DmxS9gMD2nZj9UO/HH4IgVpZLtch6cNBbOb56jSXmrVtd6tt4/2weCJF0
 eLjWVU83Quz3OgCbCXmXE+6YXItlP6wHYXJfWsNKNuctq3ugC96n6V0ksPL+9Eptn7bL
 PrBg==
X-Gm-Message-State: AOJu0YzTyZSxPJv0tE68chRTZpzGoYv2qxNc7h/hwYGme2M1gWeIiPk7
 xylStBpIHtwQ862K8HJiDt8P0eaQXHuRo9C3G0w9P7UjZlGupXf8cUfJEKPPi9DXnIctIuImMcU
 c
X-Google-Smtp-Source: AGHT+IH9t6QCeGUDbSu3GA1F9YOSWj7yLGVMSYJGn6eT9rawFkuWwT1oS6097XfcEnFODg61z+GqbA==
X-Received: by 2002:a17:902:ea94:b0:1dc:16:9000 with SMTP id
 x20-20020a170902ea9400b001dc00169000mr368429plb.16.1709934866636; 
 Fri, 08 Mar 2024 13:54:26 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 d3-20020a170902b70300b001dd66e6ec91sm107702pls.140.2024.03.08.13.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 13:54:26 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 04/10] target/riscv/vector_helper.c: update tail with
 vext_set_tail_elems_1s()
Date: Fri,  8 Mar 2024 18:53:44 -0300
Message-ID: <20240308215402.117405-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308215402.117405-1-dbarboza@ventanamicro.com>
References: <20240308215402.117405-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
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

Change all code that updates tail elems to use vext_set_tail_elems_1s()
instead of vext_set_elems_1s().

Setting 'env->vstart=0' needs to be the very last thing a helper does
because env->vstart is being checked by vext_set_tail_elems_1s().

A side effect of this change is that a lot of 'vta' local variables got
unused. The reason is that 'vta' was being fetched to be used with
vext_set_elems_1s() but vext_set_tail_elems_1s() doesn't use it - 'vta' is
retrieve inside the helper using 'desc'.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/vector_helper.c | 130 ++++++++++++++---------------------
 1 file changed, 52 insertions(+), 78 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 544234c2d8..2f715fea5e 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -878,7 +878,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     uint32_t esz = sizeof(ETYPE);                             \
     uint32_t total_elems =                                    \
         vext_get_total_elems(env, desc, esz);                 \
-    uint32_t vta = vext_vta(desc);                            \
     uint32_t i;                                               \
                                                               \
     for (i = env->vstart; i < vl; i++) {                      \
@@ -888,9 +887,9 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
                                                               \
         *((ETYPE *)vd + H(i)) = DO_OP(s2, s1, carry);         \
     }                                                         \
-    env->vstart = 0;                                          \
     /* set tail elements to 1s */                             \
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);  \
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);  \
+    env->vstart = 0;                                          \
 }
 
 GEN_VEXT_VADC_VVM(vadc_vvm_b, uint8_t,  H1, DO_VADC)
@@ -910,7 +909,6 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
     uint32_t vl = env->vl;                                               \
     uint32_t esz = sizeof(ETYPE);                                        \
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);         \
-    uint32_t vta = vext_vta(desc);                                       \
     uint32_t i;                                                          \
                                                                          \
     for (i = env->vstart; i < vl; i++) {                                 \
@@ -919,9 +917,9 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
                                                                          \
         *((ETYPE *)vd + H(i)) = DO_OP(s2, (ETYPE)(target_long)s1, carry);\
     }                                                                    \
-    env->vstart = 0;                                                     \
     /* set tail elements to 1s */                                        \
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);             \
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);             \
+    env->vstart = 0;                                                     \
 }
 
 GEN_VEXT_VADC_VXM(vadc_vxm_b, uint8_t,  H1, DO_VADC)
@@ -1078,7 +1076,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
     uint32_t vl = env->vl;                                                \
     uint32_t esz = sizeof(TS1);                                           \
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);          \
-    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vma = vext_vma(desc);                                        \
     uint32_t i;                                                           \
                                                                           \
@@ -1092,9 +1089,9 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
         TS2 s2 = *((TS2 *)vs2 + HS2(i));                                  \
         *((TS1 *)vd + HS1(i)) = OP(s2, s1 & MASK);                        \
     }                                                                     \
-    env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);              \
+    env->vstart = 0;                                                      \
 }
 
 GEN_VEXT_SHIFT_VV(vsll_vv_b, uint8_t,  uint8_t, H1, H1, DO_SLL, 0x7)
@@ -1125,7 +1122,6 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,      \
     uint32_t esz = sizeof(TD);                              \
     uint32_t total_elems =                                  \
         vext_get_total_elems(env, desc, esz);               \
-    uint32_t vta = vext_vta(desc);                          \
     uint32_t vma = vext_vma(desc);                          \
     uint32_t i;                                             \
                                                             \
@@ -1139,9 +1135,9 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,      \
         TS2 s2 = *((TS2 *)vs2 + HS2(i));                    \
         *((TD *)vd + HD(i)) = OP(s2, s1 & MASK);            \
     }                                                       \
-    env->vstart = 0;                                        \
     /* set tail elements to 1s */                           \
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);\
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);\
+    env->vstart = 0;                                        \
 }
 
 GEN_VEXT_SHIFT_VX(vsll_vx_b, uint8_t, int8_t, H1, H1, DO_SLL, 0x7)
@@ -1800,16 +1796,15 @@ void HELPER(NAME)(void *vd, void *vs1, CPURISCVState *env,           \
     uint32_t vl = env->vl;                                           \
     uint32_t esz = sizeof(ETYPE);                                    \
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);     \
-    uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
     for (i = env->vstart; i < vl; i++) {                             \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                           \
         *((ETYPE *)vd + H(i)) = s1;                                  \
     }                                                                \
-    env->vstart = 0;                                                 \
     /* set tail elements to 1s */                                    \
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);         \
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);         \
+    env->vstart = 0;                                                 \
 }
 
 GEN_VEXT_VMV_VV(vmv_v_v_b, int8_t,  H1)
@@ -1824,15 +1819,14 @@ void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVState *env,         \
     uint32_t vl = env->vl;                                           \
     uint32_t esz = sizeof(ETYPE);                                    \
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);     \
-    uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
     for (i = env->vstart; i < vl; i++) {                             \
         *((ETYPE *)vd + H(i)) = (ETYPE)s1;                           \
     }                                                                \
-    env->vstart = 0;                                                 \
     /* set tail elements to 1s */                                    \
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);         \
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);         \
+    env->vstart = 0;                                                 \
 }
 
 GEN_VEXT_VMV_VX(vmv_v_x_b, int8_t,  H1)
@@ -1847,16 +1841,15 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,          \
     uint32_t vl = env->vl;                                           \
     uint32_t esz = sizeof(ETYPE);                                    \
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);     \
-    uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
     for (i = env->vstart; i < vl; i++) {                             \
         ETYPE *vt = (!vext_elem_mask(v0, i) ? vs2 : vs1);            \
         *((ETYPE *)vd + H(i)) = *(vt + H(i));                        \
     }                                                                \
-    env->vstart = 0;                                                 \
     /* set tail elements to 1s */                                    \
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);         \
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);         \
+    env->vstart = 0;                                                 \
 }
 
 GEN_VEXT_VMERGE_VV(vmerge_vvm_b, int8_t,  H1)
@@ -1871,7 +1864,6 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
     uint32_t vl = env->vl;                                           \
     uint32_t esz = sizeof(ETYPE);                                    \
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);     \
-    uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
     for (i = env->vstart; i < vl; i++) {                             \
@@ -1880,9 +1872,9 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
                    (ETYPE)(target_long)s1);                          \
         *((ETYPE *)vd + H(i)) = d;                                   \
     }                                                                \
-    env->vstart = 0;                                                 \
     /* set tail elements to 1s */                                    \
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);         \
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);         \
+    env->vstart = 0;                                                 \
 }
 
 GEN_VEXT_VMERGE_VX(vmerge_vxm_b, int8_t,  H1)
@@ -1938,7 +1930,6 @@ vext_vv_rm_2(void *vd, void *v0, void *vs1, void *vs2,
     uint32_t vm = vext_vm(desc);
     uint32_t vl = env->vl;
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);
-    uint32_t vta = vext_vta(desc);
     uint32_t vma = vext_vma(desc);
 
     switch (env->vxrm) {
@@ -1960,7 +1951,7 @@ vext_vv_rm_2(void *vd, void *v0, void *vs1, void *vs2,
         break;
     }
     /* set tail elements to 1s */
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);
     env->vstart = 0;
 }
 
@@ -2063,7 +2054,6 @@ vext_vx_rm_2(void *vd, void *v0, target_long s1, void *vs2,
     uint32_t vm = vext_vm(desc);
     uint32_t vl = env->vl;
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);
-    uint32_t vta = vext_vta(desc);
     uint32_t vma = vext_vma(desc);
 
     switch (env->vxrm) {
@@ -2085,7 +2075,7 @@ vext_vx_rm_2(void *vd, void *v0, target_long s1, void *vs2,
         break;
     }
     /* set tail elements to 1s */
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);
     env->vstart = 0;
 }
 
@@ -2837,7 +2827,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
     uint32_t vl = env->vl;                                \
     uint32_t total_elems =                                \
         vext_get_total_elems(env, desc, ESZ);             \
-    uint32_t vta = vext_vta(desc);                        \
     uint32_t vma = vext_vma(desc);                        \
     uint32_t i;                                           \
                                                           \
@@ -2850,10 +2839,10 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
         }                                                 \
         do_##NAME(vd, vs1, vs2, i, env);                  \
     }                                                     \
-    env->vstart = 0;                                      \
     /* set tail elements to 1s */                         \
-    vext_set_elems_1s(vd, vta, vl * ESZ,                  \
-                      total_elems * ESZ);                 \
+    vext_set_tail_elems_1s(env, vd, desc, ESZ,            \
+                           total_elems);                  \
+    env->vstart = 0;                                      \
 }
 
 RVVCALL(OPFVV2, vfadd_vv_h, OP_UUU_H, H2, H2, H2, float16_add)
@@ -2880,7 +2869,6 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
     uint32_t vl = env->vl;                                \
     uint32_t total_elems =                                \
         vext_get_total_elems(env, desc, ESZ);             \
-    uint32_t vta = vext_vta(desc);                        \
     uint32_t vma = vext_vma(desc);                        \
     uint32_t i;                                           \
                                                           \
@@ -2893,10 +2881,10 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
         }                                                 \
         do_##NAME(vd, s1, vs2, i, env);                   \
     }                                                     \
-    env->vstart = 0;                                      \
     /* set tail elements to 1s */                         \
-    vext_set_elems_1s(vd, vta, vl * ESZ,                  \
-                      total_elems * ESZ);                 \
+    vext_set_tail_elems_1s(env, vd, desc, ESZ,            \
+                           total_elems);                  \
+    env->vstart = 0;                                      \
 }
 
 RVVCALL(OPFVF2, vfadd_vf_h, OP_UUU_H, H2, H2, float16_add)
@@ -3466,7 +3454,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
     uint32_t vl = env->vl;                             \
     uint32_t total_elems =                             \
         vext_get_total_elems(env, desc, ESZ);          \
-    uint32_t vta = vext_vta(desc);                     \
     uint32_t vma = vext_vma(desc);                     \
     uint32_t i;                                        \
                                                        \
@@ -3482,9 +3469,9 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
         }                                              \
         do_##NAME(vd, vs2, i, env);                    \
     }                                                  \
+    vext_set_tail_elems_1s(env, vd, desc, ESZ,         \
+                           total_elems);               \
     env->vstart = 0;                                   \
-    vext_set_elems_1s(vd, vta, vl * ESZ,               \
-                      total_elems * ESZ);              \
 }
 
 RVVCALL(OPFVV1, vfsqrt_v_h, OP_UU_H, H2, H2, float16_sqrt)
@@ -4221,7 +4208,6 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
     uint32_t esz = sizeof(ETYPE);                             \
     uint32_t total_elems =                                    \
         vext_get_total_elems(env, desc, esz);                 \
-    uint32_t vta = vext_vta(desc);                            \
     uint32_t i;                                               \
                                                               \
     for (i = env->vstart; i < vl; i++) {                      \
@@ -4229,9 +4215,9 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
         *((ETYPE *)vd + H(i)) =                               \
             (!vm && !vext_elem_mask(v0, i) ? s2 : s1);        \
     }                                                         \
-    env->vstart = 0;                                          \
     /* set tail elements to 1s */                             \
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);  \
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);  \
+    env->vstart = 0;                                          \
 }
 
 GEN_VFMERGE_VF(vfmerge_vfm_h, int16_t, H2)
@@ -4386,7 +4372,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
     uint32_t vl = env->vl;                                \
     uint32_t esz = sizeof(TD);                            \
     uint32_t vlenb = simd_maxsz(desc);                    \
-    uint32_t vta = vext_vta(desc);                        \
     uint32_t i;                                           \
     TD s1 =  *((TD *)vs1 + HD(0));                        \
                                                           \
@@ -4398,9 +4383,9 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
         s1 = OP(s1, (TD)s2);                              \
     }                                                     \
     *((TD *)vd + HD(0)) = s1;                             \
-    env->vstart = 0;                                      \
     /* set tail elements to 1s */                         \
-    vext_set_elems_1s(vd, vta, esz, vlenb);               \
+    vext_set_tail_elems_1s(env, vd, desc, esz, vlenb);    \
+    env->vstart = 0;                                      \
 }
 
 /* vd[0] = sum(vs1[0], vs2[*]) */
@@ -4472,7 +4457,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
     uint32_t vl = env->vl;                                 \
     uint32_t esz = sizeof(TD);                             \
     uint32_t vlenb = simd_maxsz(desc);                     \
-    uint32_t vta = vext_vta(desc);                         \
     uint32_t i;                                            \
     TD s1 =  *((TD *)vs1 + HD(0));                         \
                                                            \
@@ -4484,9 +4468,9 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
         s1 = OP(s1, (TD)s2, &env->fp_status);              \
     }                                                      \
     *((TD *)vd + HD(0)) = s1;                              \
-    env->vstart = 0;                                       \
     /* set tail elements to 1s */                          \
-    vext_set_elems_1s(vd, vta, esz, vlenb);                \
+    vext_set_tail_elems_1s(env, vd, desc, esz, vlenb);     \
+    env->vstart = 0;                                       \
 }
 
 /* Unordered sum */
@@ -4703,7 +4687,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2, CPURISCVState *env,      \
     uint32_t vl = env->vl;                                                \
     uint32_t esz = sizeof(ETYPE);                                         \
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);          \
-    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vma = vext_vma(desc);                                        \
     uint32_t sum = 0;                                                     \
     int i;                                                                \
@@ -4719,9 +4702,9 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2, CPURISCVState *env,      \
             sum++;                                                        \
         }                                                                 \
     }                                                                     \
-    env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);              \
+    env->vstart = 0;                                                      \
 }
 
 GEN_VEXT_VIOTA_M(viota_m_b, uint8_t,  H1)
@@ -4737,7 +4720,6 @@ void HELPER(NAME)(void *vd, void *v0, CPURISCVState *env, uint32_t desc)  \
     uint32_t vl = env->vl;                                                \
     uint32_t esz = sizeof(ETYPE);                                         \
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);          \
-    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vma = vext_vma(desc);                                        \
     int i;                                                                \
                                                                           \
@@ -4749,9 +4731,9 @@ void HELPER(NAME)(void *vd, void *v0, CPURISCVState *env, uint32_t desc)  \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = i;                                        \
     }                                                                     \
-    env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);              \
+    env->vstart = 0;                                                      \
 }
 
 GEN_VEXT_VID_V(vid_v_b, uint8_t,  H1)
@@ -4772,7 +4754,6 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
     uint32_t vl = env->vl;                                                \
     uint32_t esz = sizeof(ETYPE);                                         \
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);          \
-    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vma = vext_vma(desc);                                        \
     target_ulong offset = s1, i_min, i;                                   \
                                                                           \
@@ -4785,9 +4766,9 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
     }                                                                     \
-    env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);              \
+    env->vstart = 0;                                                      \
 }
 
 /* vslideup.vx vd, vs2, rs1, vm # vd[i+rs1] = vs2[i] */
@@ -4805,7 +4786,6 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
     uint32_t vl = env->vl;                                                \
     uint32_t esz = sizeof(ETYPE);                                         \
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);          \
-    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vma = vext_vma(desc);                                        \
     target_ulong i_max, i_min, i;                                         \
                                                                           \
@@ -4826,9 +4806,9 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
         }                                                                 \
     }                                                                     \
                                                                           \
-    env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);              \
+    env->vstart = 0;                                                      \
 }
 
 /* vslidedown.vx vd, vs2, rs1, vm # vd[i] = vs2[i+rs1] */
@@ -4847,7 +4827,6 @@ static void vslide1up_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
     uint32_t vl = env->vl;                                                  \
     uint32_t esz = sizeof(ETYPE);                                           \
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);            \
-    uint32_t vta = vext_vta(desc);                                          \
     uint32_t vma = vext_vma(desc);                                          \
     uint32_t i;                                                             \
                                                                             \
@@ -4863,9 +4842,9 @@ static void vslide1up_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
             *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - 1));             \
         }                                                                   \
     }                                                                       \
-    env->vstart = 0;                                                        \
     /* set tail elements to 1s */                                           \
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);                \
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);                \
+    env->vstart = 0;                                                        \
 }
 
 GEN_VEXT_VSLIE1UP(8,  H1)
@@ -4896,7 +4875,6 @@ static void vslide1down_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
     uint32_t vl = env->vl;                                                    \
     uint32_t esz = sizeof(ETYPE);                                             \
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);              \
-    uint32_t vta = vext_vta(desc);                                            \
     uint32_t vma = vext_vma(desc);                                            \
     uint32_t i;                                                               \
                                                                               \
@@ -4912,9 +4890,9 @@ static void vslide1down_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
             *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + 1));               \
         }                                                                     \
     }                                                                         \
-    env->vstart = 0;                                                          \
     /* set tail elements to 1s */                                             \
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);                  \
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);                  \
+    env->vstart = 0;                                                          \
 }
 
 GEN_VEXT_VSLIDE1DOWN(8,  H1)
@@ -4970,7 +4948,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
     uint32_t vl = env->vl;                                                \
     uint32_t esz = sizeof(TS2);                                           \
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);          \
-    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vma = vext_vma(desc);                                        \
     uint64_t index;                                                       \
     uint32_t i;                                                           \
@@ -4988,9 +4965,9 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
             *((TS2 *)vd + HS2(i)) = *((TS2 *)vs2 + HS2(index));           \
         }                                                                 \
     }                                                                     \
-    env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);              \
+    env->vstart = 0;                                                      \
 }
 
 /* vd[i] = (vs1[i] >= VLMAX) ? 0 : vs2[vs1[i]]; */
@@ -5013,7 +4990,6 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
     uint32_t vl = env->vl;                                                \
     uint32_t esz = sizeof(ETYPE);                                         \
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);          \
-    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vma = vext_vma(desc);                                        \
     uint64_t index = s1;                                                  \
     uint32_t i;                                                           \
@@ -5030,9 +5006,9 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
             *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(index));           \
         }                                                                 \
     }                                                                     \
-    env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);              \
+    env->vstart = 0;                                                      \
 }
 
 /* vd[i] = (x[rs1] >= VLMAX) ? 0 : vs2[rs1] */
@@ -5049,7 +5025,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
     uint32_t vl = env->vl;                                                \
     uint32_t esz = sizeof(ETYPE);                                         \
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);          \
-    uint32_t vta = vext_vta(desc);                                        \
     uint32_t num = 0, i;                                                  \
                                                                           \
     for (i = env->vstart; i < vl; i++) {                                  \
@@ -5059,9 +5034,9 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
         *((ETYPE *)vd + H(num)) = *((ETYPE *)vs2 + H(i));                 \
         num++;                                                            \
     }                                                                     \
-    env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);              \
+    env->vstart = 0;                                                      \
 }
 
 /* Compress into vd elements of vs2 where vs1 is enabled */
@@ -5095,7 +5070,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,                 \
     uint32_t vm = vext_vm(desc);                                 \
     uint32_t esz = sizeof(ETYPE);                                \
     uint32_t total_elems = vext_get_total_elems(env, desc, esz); \
-    uint32_t vta = vext_vta(desc);                               \
     uint32_t vma = vext_vma(desc);                               \
     uint32_t i;                                                  \
                                                                  \
@@ -5107,9 +5081,9 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,                 \
         }                                                        \
         *((ETYPE *)vd + HD(i)) = *((DTYPE *)vs2 + HS1(i));       \
     }                                                            \
-    env->vstart = 0;                                             \
     /* set tail elements to 1s */                                \
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);     \
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);     \
+    env->vstart = 0;                                             \
 }
 
 GEN_VEXT_INT_EXT(vzext_vf2_h, uint16_t, uint8_t,  H2, H1)
-- 
2.43.2


