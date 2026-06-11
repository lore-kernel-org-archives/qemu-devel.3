Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F47CD98D5
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXczu-0006N1-DQ; Thu, 11 Jun 2026 06:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wXczr-0006Mc-PZ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 06:50:52 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wXczo-0002ZI-OI
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 06:50:51 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-8424b6792efso2979078b3a.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 03:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1781175046; x=1781779846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EB4vUS8V/rcoRmWn/J7LdW4MRxw5jGr7RoFTkTMk0Uo=;
 b=OmjijoichJr8hWj4EZhmQQCS5qnsHVSjowsTpe0bPBcmw2NohFeXhHzzpiUePQRklg
 U+8CjO04X5SIuNiyXrlME6AeN5oyrprLDlWWuwiG2J1p7sb9Ors5OXI50+phIWbrO+uA
 m9HtASg8nSm9ljdZlMup3UQF6lKuS34KcCH9KsksS+Z9/8sYAKQT4AfJazWo4ZJfFLgl
 l051xwOVoCxlTjsjc3InXYjVhYuXMMkoD/+IurGBIrN5ZmjIl7oMYGCJIYC8v+ePiQoN
 XlH9PGww61IPFhFeh7oTyc2uILIvlWdsuuea57AyCtmO9aSXrLs+/OKT/Zk07hYh2woy
 +eiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781175046; x=1781779846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EB4vUS8V/rcoRmWn/J7LdW4MRxw5jGr7RoFTkTMk0Uo=;
 b=LEqakizs435O2B3jt9Ami5EwhP5DFDw33oYoQk0i3IMJd7PlntXxvhObnXdwvGPgrJ
 9DrfyMFiTXP/Fi1u6r5GAp/W83uE2RlA4DYVbt1/u6yIPX1cBZN1jhUFSL713CDP+MFy
 N9jpq2DEZ3Blj1y+gurhdZ4adB9GEDxai8ORwf8bAU3mEKvfReOyFxR0AIljE8HimqNn
 ND1TY5jgjA/oYfX1b5t+VHU8j2q47hJVWmKc1pdFwd6/7E+FiwnZqOsks2ELFhD2Q9NL
 OzC5v2uFlfKtyQjwfQnmj6R99QXWQJlpoS/sTMt2R97kFq2WHkNDeeWKtFUxm4gPHI9C
 AGeQ==
X-Gm-Message-State: AOJu0Yx9H7hI0Wd3jxyx4BEHe+qf/Qw/azFqRBoIJH3EiXzqCo/CQeel
 zMuDwpAwd3qsTykCTiDMU6kTJVt6ADtePXd29JXDC1k3f7nGl/60pGSCwv+Q3vW63hhmWqY7gRx
 rNghMGkkAF8nUG3SV31KUANHwwewptTEvFNNo6Yv62H3i5AnH76X6HM78VHw7pgioXxKYKhTa4T
 25DAgirTqrvwt7+nIttvn5xJLxAZ/LtkrVDF5kAdI=
X-Gm-Gg: Acq92OFveicJDfE97s4gEeIjJjGFdB4ErKZmvFTF+k6oGblIAL2ZuZpd6hFshqEMYWs
 ppmPf6NMRuX8cKorR9yLrR6FP5OtktOi0p1zdlZg6l2O4HUGZ/I4l7XqWS5H7aYQmc00Nm4t+zq
 R2Rsb+nQHTqpcTrQ953Ebm9Q9s16qvxQka5f41Xm/ck4i3DfGen8PDlD7kypR8sBXX1eFE91dIg
 6CvSd4KePnuj9+czNSV3iIfF0IRLDvp95fg95onXEraS11ktHP+z+thD9Ux3/Gaa7plHdYIZDJA
 I4aQR5ExxiU55rvBL3UAwtIWr+4zclIYhz/AW5aNlxRz3jL/66x6ZpAJ1N1sAbvrqxSFi4OCYWI
 5dkdNrhjQqcsBOzhjbhJyaekX90QSxhv+GtzyKyAi91m0PlqceNje9LHcZh818pX4nUs4r5DL7c
 8oMRibzU/P+8gJ+ubYT8jPYHbr6m9hzqdTAsmSaTdRRsZuvZqXvcEElEHK8bWbYaJ58pb4I2f+q
 1EXn9D45NvFtspynkAEfY9CoSI68/VR7eHVxg==
X-Received: by 2002:a05:6a00:3997:b0:83a:78ac:edb7 with SMTP id
 d2e1a72fcca58-843367c7b55mr2742516b3a.5.1781175046267; 
 Thu, 11 Jun 2026 03:50:46 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-843383197e5sm1657818b3a.52.2026.06.11.03.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 03:50:45 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH 1/2] target/riscv: Set mstatus.FS dirty when scalar FP raises
 exceptions
Date: Thu, 11 Jun 2026 18:50:36 +0800
Message-ID: <20260611105037.157773-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611105037.157773-1-max.chou@sifive.com>
References: <20260611105037.157773-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x431.google.com
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

Scalar FP instructions that write integer registers (FP comparisons and
FP-to-integer conversions) never call mark_fs_dirty at translation time
to set mstatus.FS to dirty.  However, they can raise FP exception flags
via softfloat functions, which modifies fflags without any mechanism to
dirty mstatus.FS.

The affected helpers:
- Comparisons: fle/fleq/flt/fltq/feq
  — raise NV on NaN operands
- FP-to-integer: fcvt.[w|wu|l|lu]/fcvtmod.w.d
  — raise NX on inexact or NV on out-of-range

Fix this issue by
1. Save float_exception_flags before the softfloat operation
2. Perform the operation
3. If any new exception bits are set, set fs to dirty

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.h        |   1 +
 target/riscv/fpu_helper.c | 157 +++++++++++++++++++++++++++++++-------
 2 files changed, 130 insertions(+), 28 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c98652cd62..9961815ec3 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -675,6 +675,7 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
 
 uint8_t riscv_cpu_get_fflags(CPURISCVState *env);
 void riscv_cpu_set_fflags(CPURISCVState *env, uint8_t);
+void riscv_cpu_check_fflags(CPURISCVState *env, FloatExceptionFlags);
 
 #ifndef CONFIG_USER_ONLY
 void cpu_set_exception_base(int vp_index, uint64_t address);
diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index e6d1ffb1d6..db1475271b 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -50,6 +50,22 @@ void riscv_cpu_set_fflags(CPURISCVState *env, uint8_t hard)
     set_float_exception_flags(soft, &env->fp_status);
 }
 
+#ifndef CONFIG_USER_ONLY
+void riscv_cpu_check_fflags(CPURISCVState *env,
+                            FloatExceptionFlags pre_fflag)
+{
+    if (get_float_exception_flags(&env->fp_status) & ~pre_fflag) {
+        env->mstatus |= MSTATUS_FS;
+        if (env->virt_enabled) {
+            env->mstatus_hs |= MSTATUS_FS;
+        }
+    }
+}
+#else
+void riscv_cpu_check_fflags(CPURISCVState *env,
+                            FloatExceptionFlags pre_fflag) {}
+#endif
+
 void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
 {
     FloatRoundMode softrm;
@@ -286,59 +302,86 @@ target_ulong helper_fle_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
-    return float32_le(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float32_le(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fleq_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
-    return float32_le_quiet(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float32_le_quiet(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_flt_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
-    return float32_lt(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float32_lt(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fltq_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
-    return float32_lt_quiet(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float32_lt_quiet(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_feq_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
-    return float32_eq_quiet(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float32_eq_quiet(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fcvt_w_s(CPURISCVState *env, uint64_t rs1)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
-    return float32_to_int32(frs1, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float32_to_int32(frs1, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fcvt_wu_s(CPURISCVState *env, uint64_t rs1)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
-    return (int32_t)float32_to_uint32(frs1, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = (int32_t)float32_to_uint32(frs1, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fcvt_l_s(CPURISCVState *env, uint64_t rs1)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
-    return float32_to_int64(frs1, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float32_to_int64(frs1, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fcvt_lu_s(CPURISCVState *env, uint64_t rs1)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
-    return float32_to_uint64(frs1, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float32_to_uint64(frs1, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 uint64_t helper_fcvt_s_w(CPURISCVState *env, target_ulong rs1)
@@ -453,52 +496,83 @@ uint64_t helper_fsqrt_d(CPURISCVState *env, uint64_t frs1)
 
 target_ulong helper_fle_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
-    return float64_le(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float64_le(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fleq_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
-    return float64_le_quiet(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float64_le_quiet(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_flt_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
-    return float64_lt(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float64_lt(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fltq_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
-    return float64_lt_quiet(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float64_lt_quiet(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_feq_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
-    return float64_eq_quiet(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float64_eq_quiet(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fcvt_w_d(CPURISCVState *env, uint64_t frs1)
 {
-    return float64_to_int32(frs1, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float64_to_int32(frs1, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 uint64_t helper_fcvtmod_w_d(CPURISCVState *env, uint64_t value)
 {
-    return float64_to_int32_modulo(value, float_round_to_zero, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    uint64_t ret = float64_to_int32_modulo(value, float_round_to_zero,
+                                           &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fcvt_wu_d(CPURISCVState *env, uint64_t frs1)
 {
-    return (int32_t)float64_to_uint32(frs1, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = (int32_t)float64_to_uint32(frs1, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fcvt_l_d(CPURISCVState *env, uint64_t frs1)
 {
-    return float64_to_int64(frs1, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float64_to_int64(frs1, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fcvt_lu_d(CPURISCVState *env, uint64_t frs1)
 {
-    return float64_to_uint64(frs1, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float64_to_uint64(frs1, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 uint64_t helper_fcvt_d_w(CPURISCVState *env, target_ulong rs1)
@@ -619,35 +693,50 @@ target_ulong helper_fle_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     float16 frs2 = check_nanbox_h(env, rs2);
-    return float16_le(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float16_le(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fleq_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     float16 frs2 = check_nanbox_h(env, rs2);
-    return float16_le_quiet(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float16_le_quiet(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_flt_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     float16 frs2 = check_nanbox_h(env, rs2);
-    return float16_lt(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float16_lt(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fltq_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     float16 frs2 = check_nanbox_h(env, rs2);
-    return float16_lt_quiet(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float16_lt_quiet(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_feq_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     float16 frs2 = check_nanbox_h(env, rs2);
-    return float16_eq_quiet(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float16_eq_quiet(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fclass_h(CPURISCVState *env, uint64_t rs1)
@@ -683,25 +772,37 @@ uint64_t helper_froundnx_h(CPURISCVState *env, uint64_t rs1)
 target_ulong helper_fcvt_w_h(CPURISCVState *env, uint64_t rs1)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
-    return float16_to_int32(frs1, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float16_to_int32(frs1, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fcvt_wu_h(CPURISCVState *env, uint64_t rs1)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
-    return (int32_t)float16_to_uint32(frs1, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = (int32_t)float16_to_uint32(frs1, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fcvt_l_h(CPURISCVState *env, uint64_t rs1)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
-    return float16_to_int64(frs1, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float16_to_int64(frs1, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fcvt_lu_h(CPURISCVState *env, uint64_t rs1)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
-    return float16_to_uint64(frs1, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float16_to_uint64(frs1, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 uint64_t helper_fcvt_h_w(CPURISCVState *env, target_ulong rs1)
-- 
2.43.7


