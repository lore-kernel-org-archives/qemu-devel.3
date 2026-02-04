Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212D0E8B39B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVHw-0007md-7m; Wed, 04 Feb 2026 00:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHq-0007b7-L3
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:48 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHm-00082q-FK
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:44 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-34f2a0c4574so6137421a91.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 21:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770182321; x=1770787121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sJSEG1iIZzEKOd/uP+q0Ia0xnPXmB0ZXfsMVcmphdno=;
 b=Shv7m1k+DRmg/kJe/wjiL85T0D1WD4UwuB/OixUp59jR3y7tQ8rqT9RmyfrLqiXPl/
 ZSeSwp7DcMcP14um8j+Ytn8a+mZfA5b2oSTVurBknvFu4P8Ua77wQDoUMZb5++fOoh0+
 MTBvOyrXJMKgJwgB/ox6L82A1mdPqTxvvO5tfzDRX5wY2cUe8QO54WetYtr1NJuHYB6m
 Ne3kHgo4pYpYGisH0sCr5J9G/nCPwZ/MEn1l+L8ZsnRzwQGDPX2f/IczBM5x9QsLX2uc
 p/RYeWC8WJKNmtgiUchOws+PGFnC9fIJfHPaOajnoSSp/mRMQ/WeVlohaF4Qqys/EGZp
 urHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770182321; x=1770787121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sJSEG1iIZzEKOd/uP+q0Ia0xnPXmB0ZXfsMVcmphdno=;
 b=vZli60RBCYq4KdxdCk+Ru8SbTNFO/DUxH1URlQ9pSuDhyo7YtLUqP7ts0F5ZhNrMCL
 yutCN80e+hIBXb2F87ZoxOdt9rFXqXDqZUU1k2VnPXOGdvGGpVb2yZDA2+hvXcWqdGlB
 StGSLXI+Nb0C3tHmRe+QEiWsCVYMVpdtylH/H1EoKemZCrWewKft6OpmkNiZ+bcBG6by
 eVWP65Rmx/SjMmZ1HD9dUzI/l2J5xiytNEm9xI2etZ51cBng/k8NiVTsTxcYqMLr0PZF
 TtqfbnTpuBMcBsO8NKUxNMKN9z/gvyFcPYmQoP0gBh9oy/N87xluM8r9Ve7WhowIBz0X
 rzTA==
X-Gm-Message-State: AOJu0Yw9bz/PKtVrbXLMmkBMK12RgsIwwnWiuOXRZCO3I6HCOk6TFN+s
 XHRPAaWHhOb2spz72hs6uSBONExnSZg5gUkpzIDL+mxnt4gkLkvGUtAwuDoKCnaMzXOmLNYkxxm
 GmUrxSyu353J1pgzoDHzWcIqMPVS9btCothL/SvmFx2YenU8oy9MdJvJaT5HiDH2VW/3GisCHVn
 jCmoc3lGucWJhMmru3Z/DE/o8ioGOdzA5bgtgSn8lMmm0i
X-Gm-Gg: AZuq6aKc8NuXDFLNeV/ynuTtNzYIXuWNPcLzKi558tCrMBzLycrW8rPRfwHub1N7sea
 5nBFdFOcRYqxaHA4mCMJL5Qj2nddiUHgbycjmc87jdtCLhUqXV5rNymK6s1CCJaiH9Jw4O9dyaz
 SWg6vzFCqxV+jaFAn2nooyVC8MQ5kMYpkJrOmOZL77AVvu7UsufDgRSlE3nhvdzGtkwwud5ezDz
 NA4/GXQLJA6ONr3IGQGIF9XrPqA82FW2+colQcwtbznae+UavW93/cSrqq6I8+DIl2V2QIzg6/a
 tvrB2XN9lxp8RVJlBhZ1RZb/Ap7QhhuIgakjr8KXxeuF0k1q9CAKBQPCX+vvVAo3m/KSfuCPz+M
 J0oWomF8bexOTZSM9wWkD+7zX75oxvAEmouahzV2JfIk+4EzsGVIGKkJHr3UmpFgpyKE9nyxnfm
 /3LTOeEiPQ1bxr7nyFxxOpZ7Mb9CVIRMQSGAZH7ugdqNwTjh5Ot6hnRfHkpXcQjbXBWGVc17r3l
 vpeAkj2h3kbLv8=
X-Received: by 2002:a17:90a:c10f:b0:349:9d63:8511 with SMTP id
 98e67ed59e1d1-354871b7051mr1364053a91.25.1770182321032; 
 Tue, 03 Feb 2026 21:18:41 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35485eb8d90sm1266314a91.12.2026.02.03.21.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 21:18:40 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 12/19] target/riscv: rvv: Add vfncvt.f.f.q and
 vfncvt.sat.f.f.q instructions for Zvfofp8min extension
Date: Wed,  4 Feb 2026 13:17:48 +0800
Message-ID: <20260204051756.667397-13-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204051756.667397-1-max.chou@sifive.com>
References: <20260204051756.667397-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1035.google.com
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
index bcd45b0aa3..9053b9fb57 100644
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


