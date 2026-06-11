Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCEFCD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXd00-0006OL-I5; Thu, 11 Jun 2026 06:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wXczt-0006N0-Q0
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 06:50:54 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wXczr-0002Zn-HX
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 06:50:53 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c8585ecdd71so2826124a12.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 03:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1781175049; x=1781779849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Xf9EbghDu/+zZl90ZvHLbea7KFL5XQwN2Ha8WN4yyc=;
 b=Db4wstDhd+zZIABxHrcKVtSfqpN6vb3oCrDdcs2+4Gf4T3vtIypvwK++pc46Hr3nEg
 OT5RJH01Rz3Zbir32L1o11etodDAskvpvl2d2oE6zd9FW843fj5c/lfiB2H3DQ5e8/9v
 YibeKfosTUDtidozDxYBr4iNj/qrsj/a8RhlUgzYOBG1yTKXwXTnq1Wwg8QfDWBuGuEb
 UvLr7/K0yaXOW9lcdy2zuOh5SlBXha10B8bbEWoOSJfDtAGCdD87zBrTo7DZJ37YWmyv
 BKbsGA5oSeULRHjQXfC8bgqNqnTLPi9BLHLwIlEMxuFZwPsGdrCXr93dZ12Vd7q0U55b
 thmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781175049; x=1781779849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2Xf9EbghDu/+zZl90ZvHLbea7KFL5XQwN2Ha8WN4yyc=;
 b=EJcxuSfKJqJRN88vrgiYmCFV+EfW3NQPqKwHDpqh3DDQjc0dF/+rTeafqvC2/sS3wi
 UH+DZJqzZewNFvo2fl+6tdSKHVQ6MpZYOQSncNfOGFk+QHRykCZLy/yJ9YKOcgBpoYXR
 i7zCgSESo9AYhMwg4SIcyoVe3bz5QO7vG9mFIz+7yXP5bJOB1VAEubCc51uRekUm67/b
 Q61657ByubLCUfXznwW4gDHMtFkCdy/pPFLyUZ2apoXMhLeH2JbLVilghy8YrJwtc7Pa
 YqUBJUhQSwyReBY9vE2ItTyS+p3MuUvsfaE/GMv5FZz0aj7x70YeGHbhLXqIqdnTO4vV
 MRlA==
X-Gm-Message-State: AOJu0YwweAMl5Bmqlhuie2rBL3H6GhPb6Uqh9KhLnNCYsudky1iO6GwK
 OATOloHNSPaKVQqYu0Ne3ReXnZ5o5rvp4wKR1e0VD3QhshdgXoZl2UgMH7CwTS41kxtueR7G4n+
 D1HOyWTXgW9OKOhoTz+H1y7W4+X7qnEz6KLGPZaDXyUcXnXxM9RPSfQ2/8pR2tqAB/fhYGrucb9
 VgJXHVcR8RGmLyv/Llc0B/ga/pRILeVsRhbZ+JJqM=
X-Gm-Gg: Acq92OGPXeqAlVc3CQrH1ubN0bSy+9XYaPto4rjFUXUuXiaZbcoQ0O4hyfulmGqSyD6
 QhsW5+sZMlB5s4FNfVRc0EAKc8cSwlCoXZvbj4k5UdVkKUyI60MzMWaSoL0vM2pqx3vieLVPUKo
 RQrRInRLmP1baALacuE65lu3W4PzbIdUM50gWTafELRrbTBDiC1eZg2ZlpfLpsG8kdacoUBs93e
 ebrzGSaQQeGTPu5t8fnrbs7F4mLlDCZPE7BgmQOBYYHKYg3vH3joeS33seGfeCgmOYGk+gpEBUX
 50Hke0aYv/Met0/yP8UR0yCpeVEaKLQq0S+5l5dW3gG+X/Td5X8XVoYzGF82QWfTcP1EiDzgcaA
 ShnaRFP+7hvZ2i5p6mecEtQZqWwaNEVHDD0UHZKYWYcD7KxWYi0qcJrMq1weBvy9P3udwGKmaPM
 eQY/yc8MNNIoMdNEoP6SmFtuOEz4IY8E219LEG6ERfC3NugCbf9WqHyTYQRQJEcWUlKQGJBymg0
 stYajjo1eaSR98t1c6op6fVBR3AzhaZNdCfKVedx+aPOKoT
X-Received: by 2002:a05:6a00:8087:b0:842:4982:82a with SMTP id
 d2e1a72fcca58-84336bcdfe8mr2560978b3a.45.1781175048752; 
 Thu, 11 Jun 2026 03:50:48 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-843383197e5sm1657818b3a.52.2026.06.11.03.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 03:50:48 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH 2/2] target/riscv: rvv: Set mstatus.FS dirty when vector FP
 raises exceptions
Date: Thu, 11 Jun 2026 18:50:37 +0800
Message-ID: <20260611105037.157773-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611105037.157773-1-max.chou@sifive.com>
References: <20260611105037.157773-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x534.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

According to the RISC-V privileged spec 3.1.6, any instruction that
modifies FP extension state (FP CSRs including fflags, or f registers)
must set mstatus.FS to Dirty.  Raising fflags bits is modifying fcsr
(an FP CSR).

When a vector FP instruction raises a floating-point exception, it
modifies fflags (an FP CSR), but current implementation was not marking
mstatus.FS dirty in this case.

Fix the issue by snapshot fflags before the element loop and OR
MSTATUS_FS into env->mstatus if any new exception bits are set
afterwards.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/vector_helper.c | 241 +++++++++++++++++++----------------
 1 file changed, 128 insertions(+), 113 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 89012fccb3..e321ca2616 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3172,34 +3172,36 @@ static void do_##NAME(void *vd, void *vs1, void *vs2, int i,   \
     *((TD *)vd + HD(i)) = OP(s2, s1, &env->fp_status);         \
 }
 
-#define GEN_VEXT_VV_ENV(NAME, ESZ)                        \
-void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
-                  void *vs2, CPURISCVState *env,          \
-                  uint32_t desc)                          \
-{                                                         \
-    uint32_t vm = vext_vm(desc);                          \
-    uint32_t vl = env->vl;                                \
-    uint32_t total_elems =                                \
-        vext_get_total_elems(env, desc, ESZ);             \
-    uint32_t vta = vext_vta(desc);                        \
-    uint32_t vma = vext_vma(desc);                        \
-    uint32_t i;                                           \
-                                                          \
-    VSTART_CHECK_EARLY_EXIT(env, vl);                     \
-                                                          \
-    for (i = env->vstart; i < vl; i++) {                  \
-        if (!vm && !vext_elem_mask(v0, i)) {              \
-            /* set masked-off elements to 1s */           \
-            vext_set_elems_1s(vd, vma, i * ESZ,           \
-                              (i + 1) * ESZ);             \
-            continue;                                     \
-        }                                                 \
-        do_##NAME(vd, vs1, vs2, i, env);                  \
-    }                                                     \
-    env->vstart = 0;                                      \
-    /* set tail elements to 1s */                         \
-    vext_set_elems_1s(vd, vta, vl * ESZ,                  \
-                      total_elems * ESZ);                 \
+#define GEN_VEXT_VV_ENV(NAME, ESZ)                           \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,  \
+                  CPURISCVState *env, uint32_t desc)         \
+{                                                            \
+    uint32_t vm = vext_vm(desc);                             \
+    uint32_t vl = env->vl;                                   \
+    uint32_t total_elems =                                   \
+        vext_get_total_elems(env, desc, ESZ);                \
+    uint32_t vta = vext_vta(desc);                           \
+    uint32_t vma = vext_vma(desc);                           \
+    uint32_t i;                                              \
+    FloatExceptionFlags pre_fflag =                          \
+        get_float_exception_flags(&env->fp_status);          \
+                                                             \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                        \
+                                                             \
+    for (i = env->vstart; i < vl; i++) {                     \
+        if (!vm && !vext_elem_mask(v0, i)) {                 \
+            /* set masked-off elements to 1s */              \
+            vext_set_elems_1s(vd, vma, i * ESZ,              \
+                              (i + 1) * ESZ);                \
+            continue;                                        \
+        }                                                    \
+        do_##NAME(vd, vs1, vs2, i, env);                     \
+    }                                                        \
+    env->vstart = 0;                                         \
+    /* set tail elements to 1s */                            \
+    vext_set_elems_1s(vd, vta, vl * ESZ,                     \
+                      total_elems * ESZ);                    \
+    riscv_cpu_check_fflags(env, pre_fflag);                  \
 }
 
 RVVCALL(OPFVV2, vfadd_vv_h_bf16, OP_UUU_H, H2, H2, H2, bfloat16_add)
@@ -3219,34 +3221,36 @@ static void do_##NAME(void *vd, uint64_t s1, void *vs2, int i, \
     *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)s1, &env->fp_status);\
 }
 
-#define GEN_VEXT_VF(NAME, ESZ)                            \
-void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
-                  void *vs2, CPURISCVState *env,          \
-                  uint32_t desc)                          \
-{                                                         \
-    uint32_t vm = vext_vm(desc);                          \
-    uint32_t vl = env->vl;                                \
-    uint32_t total_elems =                                \
-        vext_get_total_elems(env, desc, ESZ);             \
-    uint32_t vta = vext_vta(desc);                        \
-    uint32_t vma = vext_vma(desc);                        \
-    uint32_t i;                                           \
-                                                          \
-    VSTART_CHECK_EARLY_EXIT(env, vl);                     \
-                                                          \
-    for (i = env->vstart; i < vl; i++) {                  \
-        if (!vm && !vext_elem_mask(v0, i)) {              \
-            /* set masked-off elements to 1s */           \
-            vext_set_elems_1s(vd, vma, i * ESZ,           \
-                              (i + 1) * ESZ);             \
-            continue;                                     \
-        }                                                 \
-        do_##NAME(vd, s1, vs2, i, env);                   \
-    }                                                     \
-    env->vstart = 0;                                      \
-    /* set tail elements to 1s */                         \
-    vext_set_elems_1s(vd, vta, vl * ESZ,                  \
-                      total_elems * ESZ);                 \
+#define GEN_VEXT_VF(NAME, ESZ)                                   \
+void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,    \
+                  CPURISCVState *env, uint32_t desc)             \
+{                                                                \
+    uint32_t vm = vext_vm(desc);                                 \
+    uint32_t vl = env->vl;                                       \
+    uint32_t total_elems =                                       \
+        vext_get_total_elems(env, desc, ESZ);                    \
+    uint32_t vta = vext_vta(desc);                               \
+    uint32_t vma = vext_vma(desc);                               \
+    uint32_t i;                                                  \
+    FloatExceptionFlags pre_fflag =                              \
+        get_float_exception_flags(&env->fp_status);              \
+                                                                 \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                            \
+                                                                 \
+    for (i = env->vstart; i < vl; i++) {                         \
+        if (!vm && !vext_elem_mask(v0, i)) {                     \
+            /* set masked-off elements to 1s */                  \
+            vext_set_elems_1s(vd, vma, i * ESZ,                  \
+                              (i + 1) * ESZ);                    \
+            continue;                                            \
+        }                                                        \
+        do_##NAME(vd, s1, vs2, i, env);                          \
+    }                                                            \
+    env->vstart = 0;                                             \
+    /* set tail elements to 1s */                                \
+    vext_set_elems_1s(vd, vta, vl * ESZ,                         \
+                      total_elems * ESZ);                        \
+    riscv_cpu_check_fflags(env, pre_fflag);                      \
 }
 
 RVVCALL(OPFVF2, vfadd_vf_h_bf16, OP_UUU_H, H2, H2, bfloat16_add)
@@ -3993,35 +3997,38 @@ static void do_##NAME(void *vd, void *vs2, int i,      \
     *((TD *)vd + HD(i)) = OP(s2, &env->fp_status);     \
 }
 
-#define GEN_VEXT_V_ENV(NAME, ESZ)                      \
-void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
-                  CPURISCVState *env, uint32_t desc)   \
-{                                                      \
-    uint32_t vm = vext_vm(desc);                       \
-    uint32_t vl = env->vl;                             \
-    uint32_t total_elems =                             \
-        vext_get_total_elems(env, desc, ESZ);          \
-    uint32_t vta = vext_vta(desc);                     \
-    uint32_t vma = vext_vma(desc);                     \
-    uint32_t i;                                        \
-                                                       \
-    VSTART_CHECK_EARLY_EXIT(env, vl);                  \
-                                                       \
-    if (vl == 0) {                                     \
-        return;                                        \
-    }                                                  \
-    for (i = env->vstart; i < vl; i++) {               \
-        if (!vm && !vext_elem_mask(v0, i)) {           \
-            /* set masked-off elements to 1s */        \
-            vext_set_elems_1s(vd, vma, i * ESZ,        \
-                              (i + 1) * ESZ);          \
-            continue;                                  \
-        }                                              \
-        do_##NAME(vd, vs2, i, env);                    \
-    }                                                  \
-    env->vstart = 0;                                   \
-    vext_set_elems_1s(vd, vta, vl * ESZ,               \
-                      total_elems * ESZ);              \
+#define GEN_VEXT_V_ENV(NAME, ESZ)                            \
+void HELPER(NAME)(void *vd, void *v0, void *vs2,             \
+                  CPURISCVState *env, uint32_t desc)         \
+{                                                            \
+    uint32_t vm = vext_vm(desc);                             \
+    uint32_t vl = env->vl;                                   \
+    uint32_t total_elems =                                   \
+        vext_get_total_elems(env, desc, ESZ);                \
+    uint32_t vta = vext_vta(desc);                           \
+    uint32_t vma = vext_vma(desc);                           \
+    uint32_t i;                                              \
+    FloatExceptionFlags pre_fflag =                          \
+        get_float_exception_flags(&env->fp_status);          \
+                                                             \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                        \
+                                                             \
+    if (vl == 0) {                                           \
+        return;                                              \
+    }                                                        \
+    for (i = env->vstart; i < vl; i++) {                     \
+        if (!vm && !vext_elem_mask(v0, i)) {                 \
+            /* set masked-off elements to 1s */              \
+            vext_set_elems_1s(vd, vma, i * ESZ,              \
+                              (i + 1) * ESZ);                \
+            continue;                                        \
+        }                                                    \
+        do_##NAME(vd, vs2, i, env);                          \
+    }                                                        \
+    env->vstart = 0;                                         \
+    vext_set_elems_1s(vd, vta, vl * ESZ,                     \
+                      total_elems * ESZ);                    \
+    riscv_cpu_check_fflags(env, pre_fflag);                  \
 }
 
 RVVCALL(OPFVV1, vfsqrt_v_h, OP_UU_H, H2, H2, float16_sqrt)
@@ -4610,6 +4617,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     uint32_t vta_all_1s = vext_vta_all_1s(desc);              \
     uint32_t vma = vext_vma(desc);                            \
     uint32_t i;                                               \
+    FloatExceptionFlags pre_fflag =                           \
+        get_float_exception_flags(&env->fp_status);           \
                                                               \
     VSTART_CHECK_EARLY_EXIT(env, vl);                         \
                                                               \
@@ -4636,6 +4645,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
             vext_set_elem_mask(vd, i, 1);                     \
         }                                                     \
     }                                                         \
+    riscv_cpu_check_fflags(env, pre_fflag);                   \
 }
 
 GEN_VEXT_CMP_VV_ENV(vmfeq_vv_h_bf16, uint16_t, H2, bfloat16_eq_quiet)
@@ -4653,6 +4663,8 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
     uint32_t vta_all_1s = vext_vta_all_1s(desc);                    \
     uint32_t vma = vext_vma(desc);                                  \
     uint32_t i;                                                     \
+    FloatExceptionFlags pre_fflag =                                 \
+        get_float_exception_flags(&env->fp_status);                 \
                                                                     \
     VSTART_CHECK_EARLY_EXIT(env, vl);                               \
                                                                     \
@@ -4678,6 +4690,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
             vext_set_elem_mask(vd, i, 1);                           \
         }                                                           \
     }                                                               \
+    riscv_cpu_check_fflags(env, pre_fflag);                         \
 }
 
 GEN_VEXT_CMP_VF(vmfeq_vf_h_bf16, uint16_t, H2, bfloat16_eq_quiet)
@@ -5151,34 +5164,36 @@ GEN_VEXT_RED(vwredsumu_vs_h, uint32_t, uint16_t, H4, H2, DO_ADD)
 GEN_VEXT_RED(vwredsumu_vs_w, uint64_t, uint32_t, H8, H4, DO_ADD)
 
 /* Vector Single-Width Floating-Point Reduction Instructions */
-#define GEN_VEXT_FRED(NAME, TD, TS2, HD, HS2, OP)          \
-void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
-                  void *vs2, CPURISCVState *env,           \
-                  uint32_t desc)                           \
-{                                                          \
-    uint32_t vm = vext_vm(desc);                           \
-    uint32_t vl = env->vl;                                 \
-    uint32_t esz = sizeof(TD);                             \
-    uint32_t vlenb = simd_maxsz(desc);                     \
-    uint32_t vta = vext_vta(desc);                         \
-    uint32_t i;                                            \
-    TD s1 =  *((TD *)vs1 + HD(0));                         \
-                                                           \
-    VSTART_CHECK_EARLY_EXIT(env, vl);                      \
-                                                           \
-    for (i = env->vstart; i < vl; i++) {                   \
-        TS2 s2 = *((TS2 *)vs2 + HS2(i));                   \
-        if (!vm && !vext_elem_mask(v0, i)) {               \
-            continue;                                      \
-        }                                                  \
-        s1 = OP(s1, (TD)s2, &env->fp_status);              \
-    }                                                      \
-    if (vl > 0) {                                          \
-        *((TD *)vd + HD(0)) = s1;                          \
-    }                                                      \
-    env->vstart = 0;                                       \
-    /* set tail elements to 1s */                          \
-    vext_set_elems_1s(vd, vta, esz, vlenb);                \
+#define GEN_VEXT_FRED(NAME, TD, TS2, HD, HS2, OP)            \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,  \
+                  CPURISCVState *env, uint32_t desc)         \
+{                                                            \
+    uint32_t vm = vext_vm(desc);                             \
+    uint32_t vl = env->vl;                                   \
+    uint32_t esz = sizeof(TD);                               \
+    uint32_t vlenb = simd_maxsz(desc);                       \
+    uint32_t vta = vext_vta(desc);                           \
+    uint32_t i;                                              \
+    FloatExceptionFlags pre_fflag =                          \
+        get_float_exception_flags(&env->fp_status);          \
+    TD s1 =  *((TD *)vs1 + HD(0));                           \
+                                                             \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                        \
+                                                             \
+    for (i = env->vstart; i < vl; i++) {                     \
+        TS2 s2 = *((TS2 *)vs2 + HS2(i));                     \
+        if (!vm && !vext_elem_mask(v0, i)) {                 \
+            continue;                                        \
+        }                                                    \
+        s1 = OP(s1, (TD)s2, &env->fp_status);                \
+    }                                                        \
+    if (vl > 0) {                                            \
+        *((TD *)vd + HD(0)) = s1;                            \
+    }                                                        \
+    env->vstart = 0;                                         \
+    /* set tail elements to 1s */                            \
+    vext_set_elems_1s(vd, vta, esz, vlenb);                  \
+    riscv_cpu_check_fflags(env, pre_fflag);                  \
 }
 
 /* Unordered sum */
-- 
2.43.7


