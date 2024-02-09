Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90927C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOc3-0005Bn-C7; Fri, 09 Feb 2024 06:00:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOby-0004wh-3H
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:02 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObv-0000Lb-E6
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:01 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e08dd0fa0bso241040b3a.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476398; x=1708081198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FbyF87u8LUy/M+8ImaRUdo0A1O7M58S7SNCAm4BIEwQ=;
 b=mLsWiJIJ04Etu9n/syLi4193gfoXs9zY5ReTeau0p3P6UcJgyEG8nYE7AVaxvSSYAy
 IYsGl9ovhyPZy2NhFLE9nOL9Ia2vX2XPf34j9tn8NDvutVwk60NPYKkT8eJy244sHlsX
 gVBkqlTij7dUXwNlyFq/qMG3++CmE64HZ6EAaSlTy++/EWtbEVMmIZXAL+dhxvmiY5DB
 LGU1HJ/XxcTpKT4o3Wz/ykHH28bQMVmJCVhvjFfm3wOw+qnsL2+Ny/NLS/NbwiaTpjQR
 BDPuOynwMVFqLAXkEIHJck5P1EXdeCLazegbTy8C9kXmXR2LtqWjpgvYqouOsjeZOvBu
 Jcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476398; x=1708081198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FbyF87u8LUy/M+8ImaRUdo0A1O7M58S7SNCAm4BIEwQ=;
 b=T+J23VeM8zYgIW8FptYoVJ9pm9taaenPZFJ+DxSVGFbL1/+jmUGwwhBuWy5sYbmpbW
 dP5XDGfEse8d2ZXTvdP9xoPy4evxXgphw5f+u2inAFDtZBXXtvctuHzXlc/KvqnX7wuD
 TCOXx68lvzhxk3SEl3DwKTTDr0qo6o4bD8Uiy07hETVWO4h+F+5O6dxO6KkRLcPU4dIE
 6eCNhyRS3hwOq3ZIteZybseDXMPJCXovZq/1fI8B+4cww5qpWdan+ACJNrAU5Sm+jJMy
 C6VZG3+xzIsT1BhwSE6PzmWQaAnJ11GCxzKp/Or5L/+PSBJckfA5A2wlGnlp7S9K4vp1
 Jr3A==
X-Gm-Message-State: AOJu0YwBMEKVN2E+nCX1ZQrOm0TIobvtxfxyf3HRZURS44sDiI92wDqj
 nih5mRk60h5/UzUKKzUeXxo+dwwpzkT1Zc6BDw3CEXo5AoZN+M9nvoM2M1thUNYODQ==
X-Google-Smtp-Source: AGHT+IExQb+Y0kmUZc/jB/nqzkckB4L+EaUMwhRa3B3rKg1audl84xnJrWTge/eO0gGxL3T5Rn1Bgw==
X-Received: by 2002:a05:6a00:3d0d:b0:6dd:c23c:ea4f with SMTP id
 lo13-20020a056a003d0d00b006ddc23cea4fmr753175pfb.5.1707476397917; 
 Fri, 09 Feb 2024 02:59:57 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXl6gdKRr5URnf8jTrJ4/P5NiXBSdBYZG8+BMNvyKW3efHdPOpafZMyYA8bsxVSE/JuTvzzc5SbddnvtUVpnJCRot9Zst4lCG6Al9ZtT7Q46eBdmAJvPITAVpkYOVMFvso3cz+eOy/zeI63XdxiMRL+nc+609XXpGe40jLxdyR/jts=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:59:57 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 28/61] target/riscv/vector_helper.c: use 'vlenb'
Date: Fri,  9 Feb 2024 20:57:40 +1000
Message-ID: <20240209105813.3590056-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Use 'cpu->cfg.vlenb' instead of 'cpu->cfg.vlen >> 3'.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240122161107.26737-8-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index fe0d5d053c..908e69d073 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -559,7 +559,7 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
 {
     uint32_t i, k, off, pos;
     uint32_t nf = vext_nf(desc);
-    uint32_t vlenb = riscv_cpu_cfg(env)->vlen >> 3;
+    uint32_t vlenb = riscv_cpu_cfg(env)->vlenb;
     uint32_t max_elems = vlenb >> log2_esz;
 
     k = env->vstart / max_elems;
@@ -930,7 +930,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
 {                                                             \
     uint32_t vl = env->vl;                                    \
     uint32_t vm = vext_vm(desc);                              \
-    uint32_t total_elems = riscv_cpu_cfg(env)->vlen;          \
+    uint32_t total_elems = riscv_cpu_cfg(env)->vlenb << 3;    \
     uint32_t vta_all_1s = vext_vta_all_1s(desc);              \
     uint32_t i;                                               \
                                                               \
@@ -968,7 +968,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,          \
 {                                                               \
     uint32_t vl = env->vl;                                      \
     uint32_t vm = vext_vm(desc);                                \
-    uint32_t total_elems = riscv_cpu_cfg(env)->vlen;            \
+    uint32_t total_elems = riscv_cpu_cfg(env)->vlenb << 3;      \
     uint32_t vta_all_1s = vext_vta_all_1s(desc);                \
     uint32_t i;                                                 \
                                                                 \
@@ -1172,7 +1172,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
 {                                                             \
     uint32_t vm = vext_vm(desc);                              \
     uint32_t vl = env->vl;                                    \
-    uint32_t total_elems = riscv_cpu_cfg(env)->vlen;          \
+    uint32_t total_elems = riscv_cpu_cfg(env)->vlenb << 3;    \
     uint32_t vta_all_1s = vext_vta_all_1s(desc);              \
     uint32_t vma = vext_vma(desc);                            \
     uint32_t i;                                               \
@@ -1237,7 +1237,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,   \
 {                                                                   \
     uint32_t vm = vext_vm(desc);                                    \
     uint32_t vl = env->vl;                                          \
-    uint32_t total_elems = riscv_cpu_cfg(env)->vlen;                \
+    uint32_t total_elems = riscv_cpu_cfg(env)->vlenb << 3;          \
     uint32_t vta_all_1s = vext_vta_all_1s(desc);                    \
     uint32_t vma = vext_vma(desc);                                  \
     uint32_t i;                                                     \
@@ -3972,7 +3972,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
 {                                                             \
     uint32_t vm = vext_vm(desc);                              \
     uint32_t vl = env->vl;                                    \
-    uint32_t total_elems = riscv_cpu_cfg(env)->vlen;          \
+    uint32_t total_elems = riscv_cpu_cfg(env)->vlenb << 3;    \
     uint32_t vta_all_1s = vext_vta_all_1s(desc);              \
     uint32_t vma = vext_vma(desc);                            \
     uint32_t i;                                               \
@@ -4012,7 +4012,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
 {                                                                   \
     uint32_t vm = vext_vm(desc);                                    \
     uint32_t vl = env->vl;                                          \
-    uint32_t total_elems = riscv_cpu_cfg(env)->vlen;                \
+    uint32_t total_elems = riscv_cpu_cfg(env)->vlenb << 3;          \
     uint32_t vta_all_1s = vext_vta_all_1s(desc);                    \
     uint32_t vma = vext_vma(desc);                                  \
     uint32_t i;                                                     \
@@ -4529,7 +4529,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
                   uint32_t desc)                          \
 {                                                         \
     uint32_t vl = env->vl;                                \
-    uint32_t total_elems = riscv_cpu_cfg(env)->vlen;      \
+    uint32_t total_elems = riscv_cpu_cfg(env)->vlenb << 3;\
     uint32_t vta_all_1s = vext_vta_all_1s(desc);          \
     uint32_t i;                                           \
     int a, b;                                             \
@@ -4616,7 +4616,7 @@ static void vmsetm(void *vd, void *v0, void *vs2, CPURISCVState *env,
 {
     uint32_t vm = vext_vm(desc);
     uint32_t vl = env->vl;
-    uint32_t total_elems = riscv_cpu_cfg(env)->vlen;
+    uint32_t total_elems = riscv_cpu_cfg(env)->vlenb << 3;
     uint32_t vta_all_1s = vext_vta_all_1s(desc);
     uint32_t vma = vext_vma(desc);
     int i;
-- 
2.43.0


