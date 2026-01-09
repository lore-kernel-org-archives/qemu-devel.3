Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6D2D232E9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6yl-0002b9-Iq; Fri, 09 Jan 2026 02:32:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1ve6yj-0002Ti-8A
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:32:13 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1ve6yg-0008ID-JC
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:32:12 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-29f0f875bc5so35181875ad.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 23:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767943929; x=1768548729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/7pYM6lBVFGLLggdXK1nu+u+2Wn2Ym5oWD++g63pIYs=;
 b=PwPmHXLczQE08Y1k+fG2wvyi7AZRegUuuxc+NchAGuSjSiNtGHYAybuJsSEaw09Q0d
 KsEq6VsdfQvmm5rlkL3TyFqEl8xUkUkZ0A7Cn2IUM9odnZfnjWTNKY7GA+vwnjDpS5kC
 TRKGlVhYJV2KZY6p4q3oKF+3Gm9upqFUkXnf2M5sza0xP6CIA5UhdO+F+vkeblUty7AA
 xtrUwwMzga6kiHUCUlU4A4DaORtujN/nZ1lnIUrTWpvUffbWFzoMvZBfrY8RfmBBb7SD
 QxKc2kQ+X08SzylTsVFJIm1vFyexwknowWpEUtD7jhN2bbL0xr28ZwZJpOZXslBMH/Lm
 V1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767943929; x=1768548729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/7pYM6lBVFGLLggdXK1nu+u+2Wn2Ym5oWD++g63pIYs=;
 b=d9Bnq3dSmntNsEXlhSGCP5RqSpde+POd5HqjIGITS9D7C9g19fw64C0wynrkw/iZGg
 c6XYb+0ZxMUi8V2rEZqJkXv65Q2GbE8Hl8mCQpG0z3ekqylYNqcor5DVhI4AW7LxdbuG
 GdmR1dME5IYS1Y+8jzw+/jVDK5COUcsxPrkBlLswtAzM1loUkBDFoXgSCtPC9ohz9mXd
 SMM9sQ/DRlEFftFFjn9XR2ngwtqgJ249ZIgE3xF67dJ1aaxaO6YeI0RnLCg0kxKkytpW
 enwtU0C0KBjvENg+xiijIx8scPCxvYEAYHUsIW0to8FqcmT55lGls+G3cwDXzOnwRmYf
 e1hA==
X-Gm-Message-State: AOJu0Yzio16mzLs/1SPswH7TcgayoNifIp6b6q7Cz3U/RN72t2xOz4UF
 hejwqspegZCG7hFKortN1qXOxwm6SuIPt1Lm5PtSdyZQx2fOjqJOphnCZs4BjCINx3a+1CW2ugB
 oDjtZ9qKB6Xw2EbxPmoQsbq+q9lTPB+IkmREvuO0ya+ZPa2LJvej8hYAwfml64QS+pRtgXMT/me
 U1bxQ2CeIvRkBVBdiyAazSxFaav6mV8ZHpABNZwSU=
X-Gm-Gg: AY/fxX6+zwqZ4VFbZ8Bo8NOHTrAqYzpk7mXBO1PEaHFoYXxnWdIpwxkCzEQcDC5cCkT
 /OVEAcAVSczorgdmOicQXzPy+a1FGCgMbOfkmPwQ72ufQ/L9Om3xKaIeQS05f+6qJpB5B04K7HX
 o/3whX1pRviXT6d2+6/j1d2YWf3CQ1W3pLUVORcTFGR7mJuWNBpRQiWyuJR0S9NXhZxe2fmatR7
 Sln/w+OuaXHgvH7ad8gi+nJR5/ZgRg8I+kTsZl50h5TgHVwg9xymhVng6HJs0oqpiMJ8I++yRsW
 jgtemPhZ/5t+ZLvYW89w/6s6RdN+zWlI5DhkfqYqg06p99zP2bdsKtZsuukFu20O+P2/5vz8SBs
 q0QO+KzKwJPsaSjNl5QK2yBEi92PS9b0U7nNMjV243roMniJWX2Oi3aFGjOdz3haQii/I1R5yT0
 HvYtx5iO9vOf3+PGsi9E+rn9bqfm4NM6aABWpJSGzcJxrZTi/iMRqut+tPTSPYd+jirg==
X-Google-Smtp-Source: AGHT+IHSF68e7Pvhvf9STHeps+ErgF0M7PSY59oLwZS22Fd6Q5AvmcfDtj0L2ph+k6sEpjb4eXdrEQ==
X-Received: by 2002:a17:902:d550:b0:29d:9b39:c05f with SMTP id
 d9443c01a7336-2a3ee465362mr84205955ad.10.1767943928623; 
 Thu, 08 Jan 2026 23:32:08 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c52fd904sm9490421b3a.33.2026.01.08.23.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 23:32:08 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 2/4] target/riscv: rvv: Add Zvqdotq support
Date: Fri,  9 Jan 2026 15:31:52 +0800
Message-ID: <20260109073154.46251-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109073154.46251-1-max.chou@sifive.com>
References: <20260109073154.46251-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x632.google.com
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

Support instructions for vector dot-product extension (Zvqdotq)
- vqdot.[vv,vx]
- vqdotu.[vv,vx]
- vqdotsu.[vv,vx]
- vqdotus.vx

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/helper.h                         | 10 +++
 target/riscv/insn32.decode                    |  9 +++
 target/riscv/insn_trans/trans_rvzvqdotq.c.inc | 61 +++++++++++++++++++
 target/riscv/translate.c                      |  1 +
 target/riscv/vector_helper.c                  | 57 +++++++++++++++++
 5 files changed, 138 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzvqdotq.c.inc

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index b785456ee0..701fa938dc 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1285,6 +1285,16 @@ DEF_HELPER_5(vsm4k_vi, void, ptr, ptr, i32, env, i32)
 DEF_HELPER_4(vsm4r_vv, void, ptr, ptr, env, i32)
 DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
 
+/* Vector dot-product functions */
+DEF_HELPER_6(vqdot_vv, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vqdotu_vv, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vqdotsu_vv, void, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(vqdot_vx, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vqdotu_vx, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vqdotsu_vx, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vqdotus_vx, void, ptr, ptr, tl, ptr, env, i32)
+
 /* CFI (zicfiss) helpers */
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(ssamoswap_disabled, void, env)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6e35c4b1e6..bae59678cd 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1084,3 +1084,12 @@ sb_aqrl  00111 . . ..... ..... 000 ..... 0101111 @atom_st
 sh_aqrl  00111 . . ..... ..... 001 ..... 0101111 @atom_st
 sw_aqrl  00111 . . ..... ..... 010 ..... 0101111 @atom_st
 sd_aqrl  00111 . . ..... ..... 011 ..... 0101111 @atom_st
+
+# *** Zvqdotq Vector Dot-Product Extension ***
+vqdot_vv    101100 . ..... ..... 010 ..... 1010111 @r_vm
+vqdot_vx    101100 . ..... ..... 110 ..... 1010111 @r_vm
+vqdotu_vv   101000 . ..... ..... 010 ..... 1010111 @r_vm
+vqdotu_vx   101000 . ..... ..... 110 ..... 1010111 @r_vm
+vqdotsu_vv  101010 . ..... ..... 010 ..... 1010111 @r_vm
+vqdotsu_vx  101010 . ..... ..... 110 ..... 1010111 @r_vm
+vqdotus_vx  101110 . ..... ..... 110 ..... 1010111 @r_vm
diff --git a/target/riscv/insn_trans/trans_rvzvqdotq.c.inc b/target/riscv/insn_trans/trans_rvzvqdotq.c.inc
new file mode 100644
index 0000000000..80134874e9
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvzvqdotq.c.inc
@@ -0,0 +1,61 @@
+/*
+ * RISC-V translation routines for the Zvqdotq vector dot-product extension
+ *
+ * Copyright (C) 2025 SiFive, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+static bool vext_zvqdotq_base_check(DisasContext *s)
+{
+    return s->cfg_ptr->ext_zvqdotq && s->sew == MO_32;
+}
+
+static bool vext_vqdotq_opivv_check(DisasContext *s, arg_rmrr *a)
+{
+    return vext_zvqdotq_base_check(s) && opivv_check(s, a);
+}
+
+#define GEN_VQDOTQ_OPIVV_TRANS(NAME, CHECK)              \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)   \
+{                                                        \
+    if (CHECK(s, a)) {                                   \
+        return opivv_trans(a->rd, a->rs1, a->rs2, a->vm, \
+                           gen_helper_##NAME, s);        \
+    }                                                    \
+    return false;                                        \
+}
+
+GEN_VQDOTQ_OPIVV_TRANS(vqdot_vv, vext_vqdotq_opivv_check)
+GEN_VQDOTQ_OPIVV_TRANS(vqdotu_vv, vext_vqdotq_opivv_check)
+GEN_VQDOTQ_OPIVV_TRANS(vqdotsu_vv, vext_vqdotq_opivv_check)
+
+static bool vext_vqdotq_opivx_check(DisasContext *s, arg_rmrr *a)
+{
+    return vext_zvqdotq_base_check(s) && opivx_check(s, a);
+}
+
+#define GEN_VQDOTQ_OPIVX_TRANS(NAME, CHECK)              \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)   \
+{                                                        \
+    if (CHECK(s, a)) {                                   \
+        return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, \
+                           gen_helper_##NAME, s);        \
+    }                                                    \
+    return false;                                        \
+}
+
+GEN_VQDOTQ_OPIVX_TRANS(vqdot_vx, vext_vqdotq_opivx_check)
+GEN_VQDOTQ_OPIVX_TRANS(vqdotu_vx, vext_vqdotq_opivx_check)
+GEN_VQDOTQ_OPIVX_TRANS(vqdotsu_vx, vext_vqdotq_opivx_check)
+GEN_VQDOTQ_OPIVX_TRANS(vqdotus_vx, vext_vqdotq_opivx_check)
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index f687c75fe4..3d8eaeecb7 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1207,6 +1207,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_rvzfh.c.inc"
 #include "insn_trans/trans_rvk.c.inc"
 #include "insn_trans/trans_rvvk.c.inc"
+#include "insn_trans/trans_rvzvqdotq.c.inc"
 #include "insn_trans/trans_privileged.c.inc"
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 2de3358ee8..0666ab8855 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -921,6 +921,10 @@ GEN_VEXT_ST_WHOLE(vs8r_v, int8_t, ste_b_tlb, ste_b_host)
 #define WOP_SSU_B int16_t, int8_t, uint8_t, int16_t, uint16_t
 #define WOP_SSU_H int32_t, int16_t, uint16_t, int32_t, uint32_t
 #define WOP_SSU_W int64_t, int32_t, uint32_t, int64_t, uint64_t
+#define QOP_SSS_B int32_t, int8_t, int8_t, int32_t, int32_t
+#define QOP_SUS_B int32_t, uint8_t, int8_t, uint32_t, int32_t
+#define QOP_SSU_B int32_t, int8_t, uint8_t, int32_t, uint32_t
+#define QOP_UUU_B uint32_t, uint8_t, uint8_t, uint32_t, uint32_t
 #define NOP_SSS_B int8_t, int8_t, int16_t, int8_t, int16_t
 #define NOP_SSS_H int16_t, int16_t, int32_t, int16_t, int32_t
 #define NOP_SSS_W int32_t, int32_t, int64_t, int32_t, int64_t
@@ -5473,3 +5477,56 @@ GEN_VEXT_INT_EXT(vsext_vf2_d, int64_t, int32_t, H8, H4)
 GEN_VEXT_INT_EXT(vsext_vf4_w, int32_t, int8_t,  H4, H1)
 GEN_VEXT_INT_EXT(vsext_vf4_d, int64_t, int16_t, H8, H2)
 GEN_VEXT_INT_EXT(vsext_vf8_d, int64_t, int8_t,  H8, H1)
+
+
+/* Vector dot-product instructions. */
+
+#define OPMVV_VQDOTQ(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2)          \
+static void do_##NAME(void *vd, void *vs1, void *vs2, int i)            \
+{                                                                       \
+    int idx;                                                            \
+    TX1 *r1_buf = (TX1 *)vs1 + HD(i);                                   \
+    TX2 *r2_buf = (TX2 *)vs2 + HD(i);                                   \
+    TD acc = ((TD *)vd)[HD(i)];                                         \
+                                                                        \
+    for (idx = 0; idx < 4; ++idx) {                                     \
+        T1 r1 = ((T1 *)r1_buf)[HS1(idx)];                               \
+        T2 r2 = ((T2 *)r2_buf)[HS2(idx)];                               \
+        acc += (TD)r1 * (TD)r2;                                         \
+    }                                                                   \
+    ((TD *)vd)[HD(i)] = acc;                                            \
+}
+
+RVVCALL(OPMVV_VQDOTQ, vqdot_vv, QOP_SSS_B, H4, H1, H1)
+RVVCALL(OPMVV_VQDOTQ, vqdotu_vv, QOP_UUU_B, H4, H1, H1)
+RVVCALL(OPMVV_VQDOTQ, vqdotsu_vv, QOP_SUS_B, H4, H1, H1)
+
+GEN_VEXT_VV(vqdot_vv, 4)
+GEN_VEXT_VV(vqdotu_vv, 4)
+GEN_VEXT_VV(vqdotsu_vv, 4)
+
+#define OPMVX_VQDOTQ(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2)          \
+static void do_##NAME(void *vd, target_long s1, void *vs2, int i)       \
+{                                                                       \
+    int idx;                                                            \
+    TX1 *r1_buf = (TX1 *)&s1;                                           \
+    TX2 *r2_buf = (TX2 *)vs2 + HD(i);                                   \
+    TD acc = ((TD *)vd)[HD(i)];                                         \
+                                                                        \
+    for (idx = 0; idx < 4; ++idx) {                                     \
+        T1 r1 = ((T1 *)r1_buf)[HS1(idx)];                               \
+        T2 r2 = ((T2 *)r2_buf)[HS2(idx)];                               \
+        acc += (TD)r1 * (TD)r2;                                         \
+    }                                                                   \
+    ((TD *)vd)[HD(i)] = acc;                                            \
+}
+
+RVVCALL(OPMVX_VQDOTQ, vqdot_vx, QOP_SSS_B, H4, H1, H1)
+RVVCALL(OPMVX_VQDOTQ, vqdotu_vx, QOP_UUU_B, H4, H1, H1)
+RVVCALL(OPMVX_VQDOTQ, vqdotsu_vx, QOP_SUS_B, H4, H1, H1)
+RVVCALL(OPMVX_VQDOTQ, vqdotus_vx, QOP_SSU_B, H4, H1, H1)
+
+GEN_VEXT_VX(vqdot_vx, 4)
+GEN_VEXT_VX(vqdotu_vx, 4)
+GEN_VEXT_VX(vqdotsu_vx, 4)
+GEN_VEXT_VX(vqdotus_vx, 4)
-- 
2.43.7


