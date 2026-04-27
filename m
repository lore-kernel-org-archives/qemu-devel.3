Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85438FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHFAZ-00069a-7a; Mon, 27 Apr 2026 02:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wHFAO-0005Xt-17
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:10:00 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wHFAM-0000u7-3j
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:09:59 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35dac556bb2so5532044a91.1
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 23:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777270196; x=1777874996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KjxNDWU2If9xYg8JD6znMLYB0brDZHBk2au51ORrAp4=;
 b=GQiKW7N5MKcJISOQwG1GWDoHRBFTA/SgechQChyLcJyTbm22gZ0J5qzTyqvurPg9ol
 k4+2EyJF2uses0vZIF4uy3KjawAj6772B7hFvlx6Q352IT7ssTEWXMqIBDPzX0SDB8mV
 Jeys4utO1WE9rA1CxrVseg4njyOMcTVy+99qlqDthV8xgQOF8OlMD4qQte6yoB7b8HOq
 uKhuGP3kpqUDMzyAt6NqELjhHmHhEept2j9U0kP3phfaUXlvZtOVhYj/pec3AQewmTGg
 lFYHDZ+jabVOu67FKITDzTJXTSbeVRpdWBusDfTM5QJMJfykU/2RRvL3bpU2gWSgFxmZ
 2wXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777270196; x=1777874996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KjxNDWU2If9xYg8JD6znMLYB0brDZHBk2au51ORrAp4=;
 b=aWkibyW67/p0e9HqNl9B47IAGtTCUIQRs5juIRCos8CgM3h2gZrMDRPuUaXgJ4FSqS
 jTTNXWF+s20yD4PPOPVsA1M+LL1fvqfGn8IuqTkbcWUmgEFTQsso/YDhadkY7fWUMTkG
 z/KGgj8rarQE1CUAqY6J6Te5RGCCeyLKhyk/KB3CRi4e8Pf3wIMosYC4/vjG09RQEi8w
 KSecCSh2awcYOHsm3ofRhL5/1lFHYrkecupPre07i0yp9K4h7ht28xSPbTtMHdslTiCZ
 zv3W8jlOB51EII1s6Wnn3Gno3JhtGSGiNjYiSCBICvimLP8+uJUptxjUySVTzXwRh+9Y
 rRzQ==
X-Gm-Message-State: AOJu0YwmY982l3JuOuINuqGApB3PBsaGehZ2AwlWzq3q4T9w/YPmcC16
 +jk9Si/tXDweaMu3dWnz7PQTNIpjXbdky6HgI2sDkoTN8lsmoAjANzjtQ0AsvK222P9uUsSszhV
 QRJsJ8YFBvALPniMxSxGYwH+eOIk/tvAvpmdDd23k0GdtbfHwssSLNYug2L+UNC45Il3F9NELor
 BstaFpE0na1SsKE3wuUoAZHhg9/r04hlK+FiXSjkA=
X-Gm-Gg: AeBDieuzFo1lYcq1OK3CfRrIpggb4MkxSGgpcoy6PP+6ZcxGxviT6E8SXJMAgvrRjot
 dHGNYH7VauNUSL7PkXozSB+IsBoU21cwV7tgV3DNp+JZpzemkyDmZF39ePe3Wmy/xNXboHOd8vt
 9lQkxIiwP4ISP4m8RZXDyIb6G+8dBrWO7fJyDtLHSSM+EyqkE74KHEBKCU6JFDm+BUTlj5qZiF7
 7UsaYB5RHJnlnQjXN2rAw0+o7Ue+pm8ohN8Wm5+Bu8aGVw4X/Q9mTwu0jM8/0oqwkLlkNpwijmM
 hSdomjo3mqg5mvdFjJez5UPFwg5vZDWD3cBfVPNCebZyLC+J+aAScM1NGPPRmIehcBziG4frc7j
 I3LHTXX0jivAnE10+yEHHALLncqrqaRb/+TuXfWKWN/dqjSfXu7/f9E7nZ305JoeUiMjUqdg2GL
 E6gjB9iFotXgkICNpF1AQCdS19ISJbiVEo77C4KgPmynpf9j0kMbdx4Xi+Ye20CH89Fk7FyPnuS
 PyBx0OG8KgA41mw3olwXwLXZcLTheSGMghlAA==
X-Received: by 2002:a17:90b:524c:b0:354:a57c:65db with SMTP id
 98e67ed59e1d1-3614047a5d4mr44450750a91.20.1777270196398; 
 Sun, 26 Apr 2026 23:09:56 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410bac6dsm30290710a91.14.2026.04.26.23.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 23:09:56 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 7/9] target/riscv: rvv: Add vfncvt.f.f.q and
 vfncvt.sat.f.f.q instructions for Zvfofp8min extension
Date: Mon, 27 Apr 2026 14:09:26 +0800
Message-ID: <20260427060928.2322570-8-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427060928.2322570-1-max.chou@sifive.com>
References: <20260427060928.2322570-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102b.google.com
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

The vfncvt.f.f.q and vfncvt.sat.f.f.q instructions convert a vector of
FP32 elements to a vector of OFP8 elements. The vfncvt.sat.f.fq instruction
converts a vector of FP32 elements to a vector of OFP8 elements with saturation.
The VTYPE.altfmt field is used to select the OFP8 format.
* altfmt = 0: FP32 to OFP8.e4m3
* altfmt = 1: FP32 to OFP8.e5m2

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn32.decode                 |  2 +
 target/riscv/insn_trans/trans_rvofp8.c.inc | 63 ++++++++++++++++++++++
 target/riscv/insn_trans/trans_rvv.c.inc    | 39 ++++++++++++++
 3 files changed, 104 insertions(+)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 49201c0c20..f2b413c7d4 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -974,6 +974,8 @@ vfwmaccbf16_vv    111011 . ..... ..... 001 ..... 1010111 @r_vm
 vfwmaccbf16_vf    111011 . ..... ..... 101 ..... 1010111 @r_vm
 
 # *** Zvfofp8min Extension ***
+vfncvt_f_f_q          010010 . ..... 11001 001 ..... 1010111 @r2_vm
+vfncvt_sat_f_f_q      010010 . ..... 11011 001 ..... 1010111 @r2_vm
 vfncvtbf16_sat_f_f_w  010010 . ..... 11111 001 ..... 1010111 @r2_vm
 
 # *** Zvbc vector crypto extension ***
diff --git a/target/riscv/insn_trans/trans_rvofp8.c.inc b/target/riscv/insn_trans/trans_rvofp8.c.inc
index d28f92e050..619ee4d773 100644
--- a/target/riscv/insn_trans/trans_rvofp8.c.inc
+++ b/target/riscv/insn_trans/trans_rvofp8.c.inc
@@ -12,6 +12,13 @@
     }                                       \
 } while (0)
 
+static bool zvfofp8min_narrow_quad_check(DisasContext *s, arg_rmr *a)
+{
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_sq(s, a->rd, a->rs2, a->vm) &&
+           (s->sew == MO_8);
+}
 
 static bool trans_vfncvtbf16_sat_f_f_w(DisasContext *ctx, arg_rmr *a)
 {
@@ -40,3 +47,59 @@ static bool trans_vfncvtbf16_sat_f_f_w(DisasContext *ctx, arg_rmr *a)
     }
     return false;
 }
+
+static bool trans_vfncvt_f_f_q(DisasContext *ctx, arg_rmr *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZVFOFP8MIN(ctx);
+
+    if (zvfofp8min_narrow_quad_check(ctx, a)) {
+        gen_helper_gvec_3_ptr *fn;
+        uint32_t data = 0;
+
+        fn = ctx->altfmt ? gen_helper_vfncvt_f_f_q_ofp8e5m2 :
+                           gen_helper_vfncvt_f_f_q_ofp8e4m3;
+
+        gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
+
+        data = FIELD_DP32(data, VDATA, VM, a->vm);
+        data = FIELD_DP32(data, VDATA, LMUL, ctx->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, ctx->vta);
+        data = FIELD_DP32(data, VDATA, VMA, ctx->vma);
+        tcg_gen_gvec_3_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
+                           vreg_ofs(ctx, a->rs2), tcg_env,
+                           ctx->cfg_ptr->vlenb,
+                           ctx->cfg_ptr->vlenb, data, fn);
+        finalize_rvv_inst(ctx);
+        return true;
+    }
+    return false;
+}
+
+static bool trans_vfncvt_sat_f_f_q(DisasContext *ctx, arg_rmr *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZVFOFP8MIN(ctx);
+
+    if (zvfofp8min_narrow_quad_check(ctx, a)) {
+        gen_helper_gvec_3_ptr *fn;
+        uint32_t data = 0;
+
+        fn = ctx->altfmt ? gen_helper_vfncvt_sat_f_f_q_ofp8e5m2 :
+                           gen_helper_vfncvt_sat_f_f_q_ofp8e4m3;
+
+        gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
+
+        data = FIELD_DP32(data, VDATA, VM, a->vm);
+        data = FIELD_DP32(data, VDATA, LMUL, ctx->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, ctx->vta);
+        data = FIELD_DP32(data, VDATA, VMA, ctx->vma);
+        tcg_gen_gvec_3_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
+                           vreg_ofs(ctx, a->rs2), tcg_env,
+                           ctx->cfg_ptr->vlenb,
+                           ctx->cfg_ptr->vlenb, data, fn);
+        finalize_rvv_inst(ctx);
+        return true;
+    }
+    return false;
+}
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 5b72926b3c..2108a0fd4c 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -621,6 +621,45 @@ static bool vext_check_sds(DisasContext *s, int vd, int vs1, int vs2, int vm)
            require_align(vs1, s->lmul);
 }
 
+/*
+ * Common check function for vector narrowing instructions
+ * of single-width result (SEW) and quad-width source (4*SEW).
+ *
+ * Rules to be checked here:
+ *   1. The largest vector register group used by an instruction
+ *      can not be greater than 8 vector registers
+ *      (Section 31.5.2)
+ *   2. Quad-width SEW cannot greater than ELEN.
+ *      (Section 31.2)
+ *   3. Source vector register number is multiples of 4 * LMUL.
+ *      (Section 31.3.4.2)
+ *   4. Destination vector register number is multiples of LMUL.
+ *      (Section 31.3.4.2)
+ *   5. Destination vector register group for a masked vector
+ *      instruction cannot overlap the source mask register (v0).
+ *      (Section 31.5.3)
+ * risc-v unprivileged spec
+ */
+static bool vext_quad_narrow_check_common(DisasContext *s, int vd, int vs2,
+                                          int vm)
+{
+    return (s->lmul <= 1) &&
+           (s->sew < MO_32) &&
+           ((s->sew + 2) <= (s->cfg_ptr->elen >> 4)) &&
+           require_align(vs2, s->lmul + 2) &&
+           require_align(vd, s->lmul) &&
+           require_vm(vm, vd);
+}
+
+static bool vext_check_sq(DisasContext *s, int vd, int vs, int vm)
+{
+    bool ret = vext_quad_narrow_check_common(s, vd, vs, vm);
+    if (vd != vs) {
+        ret &= require_noover(vd, s->lmul, vs, s->lmul + 2);
+    }
+    return ret;
+}
+
 /*
  * Check function for vector reduction instructions.
  *
-- 
2.52.0


