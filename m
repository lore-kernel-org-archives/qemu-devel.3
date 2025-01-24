Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D8CC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 07:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbECT-0002cu-O6; Fri, 24 Jan 2025 02:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tbECP-0002cN-8T
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 02:33:53 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tbECL-0004Fe-LM
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 02:33:51 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ee8e8e29f6so2618046a91.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 23:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1737704027; x=1738308827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3NG+hueHH6AqupWOSB4OZObJndTP/YUoTxI8e1ofLFc=;
 b=Qu/2opb8HJhmwAxMR3ZUro+eKsoyVWNsEbvwz7New4w3gsE7WJzW0DVEsth8PU/MMT
 wug5qA/vcvuywLUjJ3hRo/4U49EFBlB3Ahgq3dZkFF4oif1Zo7IVTBK8Revxm3ZqM1/j
 45gmc8YpM1GBNjEbLrTck/bi2tMuVCNAHdecUXaTm2rhpqfhsYBcoQ42s1LXG6qBt3xr
 4IqIYi5Eq3QZdFspl1q0Rxm0b4gqblQodSxVNJJmg+u9DGyMRGUBUJ192N63Y968xNzE
 nVAlaO/W1sZWwfOU3opXOYVGs8Ex0s4uQPtmtWcVfhuTpVvMC+clvEmXT/hZ1dCXt6WW
 rSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737704027; x=1738308827;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3NG+hueHH6AqupWOSB4OZObJndTP/YUoTxI8e1ofLFc=;
 b=C/70u0F4r4XzLAveWioVy9sn5BCR7gTywgFh9XhkYEZjVBE7uoi85UvM47PhFPWGfR
 Bg95ZeHs0mQNB1EuudHVL8OI3cYB2JWgp8a8LPxxVpgT1m+/db7GcNZrTBdwv/5n9hgw
 AMxXHB4e5JGW84JbNvEhNYmoerw+YK24l/Roz1dJuUGpgPEc/kBQMTQ9si2q300KU6zP
 KcXOthE4KdBEdF4+B3FEAEOwnP+wRTV+Qs1D4zp1OFyc0e9Xru2s4vkjCJsJ690SH+2D
 LdBygRkw/CwmR4Ck1AnJWcSGKdC1iUDBR7CZcUyUA21s3CvkL3p0ndb5iNNrzf7NTRJ/
 JC9A==
X-Gm-Message-State: AOJu0YwH0mO4nY8tccnbBwyabs9PQtgXDlHhU6wdK+fPKs3Vp39LRYWE
 Ab2Tpoh4QHplgmV/cO5mjMaVh3d67XQqpwHtkPbj1DkToxHNS66jpnWvkD84HqyYptxijwDUThC
 NdR7F0Nj9ZXDfzNDmVfil5QzMlwrOucwcBGxvF80W07mJceaw0BvvmRMVx/32nitMCDsOU3ac+C
 ErS4j4a/mNsfIiYu9fS6UN3v7OGt7Z5VM5IujZDQ==
X-Gm-Gg: ASbGncvQ3/tnGY/Xb/6Zg7xpUMUu6k0/4q/kJnKnBINLtY5LkIbnpSXwPaJ8AWmz5gr
 D+oMEG2/2Z/RNxPlvI3DXSEI90Y0vMn6fMYklhwjR8k+8R/qfiTiOdqyvF9bhvuR8GTr6IsjvCo
 jlo5AAFN0IJ/M9xKLEkNfy1b+l9cv9VhIrcMqr9YcuPaRPtdOzvTiXCKkj/rsrwP5Nkedez+YOz
 GkpCcVDjeKzLcztciMI2RvzUMSdMnscvCizC1+qmiptpZ8SPHsYNgHsZ7HixeT+fXAgIw4a3AZa
 XVkzvT76vVye+suzB1mpIj3wq9y7roKcXsAycBLEsljaPrHZBg==
X-Google-Smtp-Source: AGHT+IHLQdZwBg3jofOPYkFVs1gt7g/0P3VtY/NEZluSWV7hJJ+hUE1Bs0nwYEmqLa9ASGOcLl/GJA==
X-Received: by 2002:a17:90a:c2ce:b0:2ee:a76a:820 with SMTP id
 98e67ed59e1d1-2f782cbfa62mr46861434a91.18.1737704026630; 
 Thu, 23 Jan 2025 23:33:46 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffa77043sm1072755a91.35.2025.01.23.23.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 23:33:46 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/riscv: rvv: Fix vslide1[up|down].vx unexpected result
 when XLEN=32 and SEW=64
Date: Fri, 24 Jan 2025 15:33:22 +0800
Message-Id: <20250124073325.2467664-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1036.google.com
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

When XLEN is 32 and SEW is 64, the original implementation of
vslide1up.vx and vslide1down.vx helper functions fills the 32-bit value
of rs1 into the first element of the destination vector register (rd),
which is a 64-bit element.

This commit attempted to resolve the issue by extending the rs1 value
to 64 bits during the TCG translation phase to ensure that the helper
functions won't lost the higer 32 bits.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/helper.h                   | 16 ++++----
 target/riscv/insn_trans/trans_rvv.c.inc | 50 ++++++++++++++++++++++++-
 target/riscv/vector_helper.c            | 20 +++++-----
 3 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 16ea240d26d..0578d153bdf 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1099,14 +1099,14 @@ DEF_HELPER_6(vslidedown_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vslidedown_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vslidedown_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vslidedown_vx_d, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vslide1up_vx_b, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vslide1up_vx_h, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vslide1up_vx_w, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vslide1up_vx_d, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vslide1down_vx_b, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vslide1down_vx_h, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vslide1down_vx_w, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vslide1down_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslide1up_vx_b, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vslide1up_vx_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vslide1up_vx_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vslide1up_vx_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vslide1down_vx_b, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vslide1down_vx_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vslide1down_vx_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vslide1down_vx_d, void, ptr, ptr, i64, ptr, env, i32)
 
 DEF_HELPER_6(vfslide1up_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfslide1up_vf_w, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index b9883a5d323..775fe1baae7 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3391,7 +3391,6 @@ static bool slideup_check(DisasContext *s, arg_rmrr *a)
 }
 
 GEN_OPIVX_TRANS(vslideup_vx, slideup_check)
-GEN_OPIVX_TRANS(vslide1up_vx, slideup_check)
 GEN_OPIVI_TRANS(vslideup_vi, IMM_ZX, vslideup_vx, slideup_check)
 
 static bool slidedown_check(DisasContext *s, arg_rmrr *a)
@@ -3402,9 +3401,56 @@ static bool slidedown_check(DisasContext *s, arg_rmrr *a)
 }
 
 GEN_OPIVX_TRANS(vslidedown_vx, slidedown_check)
-GEN_OPIVX_TRANS(vslide1down_vx, slidedown_check)
 GEN_OPIVI_TRANS(vslidedown_vi, IMM_ZX, vslidedown_vx, slidedown_check)
 
+typedef void gen_helper_vslide1_vx(TCGv_ptr, TCGv_ptr, TCGv_i64, TCGv_ptr,
+                                TCGv_env, TCGv_i32);
+
+#define GEN_OPIVX_VSLIDE1_TRANS(NAME, CHECK)                            \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
+{                                                                       \
+    if (CHECK(s, a)) {                                                  \
+        static gen_helper_vslide1_vx * const fns[4] = {                 \
+            gen_helper_##NAME##_b, gen_helper_##NAME##_h,               \
+            gen_helper_##NAME##_w, gen_helper_##NAME##_d,               \
+        };                                                              \
+                                                                        \
+        TCGv_ptr dest, src2, mask;                                      \
+        TCGv_i64 src1;                                                  \
+        TCGv_i32 desc;                                                  \
+        uint32_t data = 0;                                              \
+                                                                        \
+        dest = tcg_temp_new_ptr();                                      \
+        mask = tcg_temp_new_ptr();                                      \
+        src2 = tcg_temp_new_ptr();                                      \
+        src1 = tcg_temp_new_i64();                                      \
+                                                                        \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                      \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                  \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);                    \
+        data = FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);  \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);                    \
+        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,            \
+                                s->cfg_ptr->vlenb, data));              \
+                                                                        \
+        tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));            \
+        tcg_gen_addi_ptr(src2, tcg_env, vreg_ofs(s, a->rs2));           \
+        tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));                \
+        tcg_gen_ext_tl_i64(src1, get_gpr(s, a->rs1, EXT_SIGN));         \
+                                                                        \
+        fns[s->sew](dest, mask, src1, src2, tcg_env, desc);             \
+                                                                        \
+        tcg_gen_movi_tl(cpu_vstart, 0);                                 \
+        finalize_rvv_inst(s);                                           \
+                                                                        \
+        return true;                                                    \
+    }                                                                   \
+    return false;                                                       \
+}
+
+GEN_OPIVX_VSLIDE1_TRANS(vslide1up_vx, slideup_check)
+GEN_OPIVX_VSLIDE1_TRANS(vslide1down_vx, slidedown_check)
+
 /* Vector Floating-Point Slide Instructions */
 static bool fslideup_check(DisasContext *s, arg_rmrr *a)
 {
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 5386e3b97c5..c7fe3424c47 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -5145,11 +5145,11 @@ GEN_VEXT_VSLIE1UP(16, H2)
 GEN_VEXT_VSLIE1UP(32, H4)
 GEN_VEXT_VSLIE1UP(64, H8)
 
-#define GEN_VEXT_VSLIDE1UP_VX(NAME, BITWIDTH)                     \
-void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2, \
-                  CPURISCVState *env, uint32_t desc)              \
-{                                                                 \
-    vslide1up_##BITWIDTH(vd, v0, s1, vs2, env, desc);             \
+#define GEN_VEXT_VSLIDE1UP_VX(NAME, BITWIDTH)                   \
+void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,   \
+                  CPURISCVState *env, uint32_t desc)            \
+{                                                               \
+    vslide1up_##BITWIDTH(vd, v0, s1, vs2, env, desc);           \
 }
 
 /* vslide1up.vx vd, vs2, rs1, vm # vd[0]=x[rs1], vd[i+1] = vs2[i] */
@@ -5196,11 +5196,11 @@ GEN_VEXT_VSLIDE1DOWN(16, H2)
 GEN_VEXT_VSLIDE1DOWN(32, H4)
 GEN_VEXT_VSLIDE1DOWN(64, H8)
 
-#define GEN_VEXT_VSLIDE1DOWN_VX(NAME, BITWIDTH)                   \
-void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2, \
-                  CPURISCVState *env, uint32_t desc)              \
-{                                                                 \
-    vslide1down_##BITWIDTH(vd, v0, s1, vs2, env, desc);           \
+#define GEN_VEXT_VSLIDE1DOWN_VX(NAME, BITWIDTH)                 \
+void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,   \
+                  CPURISCVState *env, uint32_t desc)            \
+{                                                               \
+    vslide1down_##BITWIDTH(vd, v0, s1, vs2, env, desc);         \
 }
 
 /* vslide1down.vx vd, vs2, rs1, vm # vd[i] = vs2[i+1], vd[vl-1]=x[rs1] */
-- 
2.34.1


