Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005EFD1D478
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdrm9-0001YJ-P3; Thu, 08 Jan 2026 10:18:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrlY-00015X-1j
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:41 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrlW-0003bR-8g
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:35 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7baf61be569so2245916b3a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 07:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767885451; x=1768490251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m0aTJbNlL9KZs7WjXY/+Go/wD74fcQhsCJqmty/0+W8=;
 b=jh6ovYgFqzwFQFfrOmm/IagcBL0WMFsO4ZDmVbSxrlaSNTGtrggUGB377Zs1uamsVo
 gbzh9YP+OlgihyTEUYgfXMPXSQ+lB3uDvgyLmTEJ+BjQmOHhbHsWBBe7sX4JYayu/aNJ
 kF6+mxPZLvO/CEgIxbqIHqNBp/dGin3uk2pQJ5qu/1TrnUw237bY8GebFe8Z/CSmNiVl
 OwGxKkIekcpVmcAiiyVbwGCJxMD0WXN4M+JxMxv6w0kOnx7KKcVttsHb/rH0MWqmSGED
 xfVy20eudpDsI70f0y9+5U/Y87lcx3jqgQwHGM35B5eClvgUScF83/Z7XqgmDrwcjStG
 EmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767885451; x=1768490251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m0aTJbNlL9KZs7WjXY/+Go/wD74fcQhsCJqmty/0+W8=;
 b=jqRo23XaWH9RNjd0REFOEjg1eNG878w+XrD+9PN6/qqjGmx0tJhpyL0jEztHNuoZUu
 BcjONAv0/35Q1gUKYnMvLrYRpX5yeDKlHSjRJ7DmSEDZQHRFC0+2nfSL09lLSqr6ZaJP
 y4FH3lUVYhjkx33nZp6NivUgQNAZrUkhTatNsmHWWIIOds8jZq3nn9dcZdVzCZbED6Ad
 v8Hi4/VEbDveMkayJZMr0cw9JIv4QDbJfoVyOTkTi49khxpJ0wL70U1zqt8xzEDzuoU3
 zbQxHXukLvwExEzWWkKKrR3EhUTWkLhd7J5KNUZm93UbksTg+9CGl+lZ5ft458Ros3bU
 vqdg==
X-Gm-Message-State: AOJu0Yy+um7pnwPd2IXxHf0DkJ2ge2boBGlJshSRuI7JqCa6jGSUIYW5
 TWzsTBGbrIY6F5P1R4dKH1TIHnT8Q4yAzC0AyCFQ/uayqCw9Oe6YF2EE4sCt4WC4OHjAqXG1WxZ
 /Pw2mBtgATYTeXS37Zme/eROWLefP0sDC38o4gAh4fh3ORGzK8kokGSNZhv0t9neZ1qa0AE/2Xe
 wFZvNYqXP3K5YSV64G2RPOJPjb6MdA0mTrcsdlh0s=
X-Gm-Gg: AY/fxX7F6CZ8KQ7tP4abEF/IHXhT35/iALZBwQ7HFr0BlvHb9tqxteFPWeHb0op3FKn
 yGZA4UB5fAt96GquiomIXklkfLNCEv0yY4h0I/hRRAaQ6FbhWJJHm48xdJSbQlEPErJGRO8qyoG
 67+xvODGsV3OzvdXSKMEDmZvseNDJFFINTSWHged6Uo6/uEpRTin1b+yC9xyXFbWGnYgB4t4Iyo
 vkHp9KqPXu2adqurtwImwzzx5xrjysJSRIHh/zwp9f+SoePoQlV+Er6ivucpc2w+sN10lOsafnU
 vprf2dTYkpvXepnblNH/Emd8iO8pY4OXs2HKjyTPahPZszMOKINDoP9a8XClN7Xo05/KK89kyfB
 fgPeG6LfYj0CcZ1IWAog7snk8ByAYUQpIjV6WdteYEos0UxpCP782uxijOavHOSN9JQFmnneycQ
 yEOJQwCvLnX4C3CMfsB5GjeIBpsxfcrQPxEZPM+vZmMxcD+WMK7Z/9l1oIkv41is0HUw==
X-Google-Smtp-Source: AGHT+IHhCHPiDemNPSFL1mpgpbOm8EUfkAUTkk6fmz5GKj5MpIFIh1rA7Zdb44v14IboKGldHo1Vdg==
X-Received: by 2002:a05:6a00:4003:b0:7e8:4471:ae72 with SMTP id
 d2e1a72fcca58-81b7ffc23damr6147433b3a.62.1767885450851; 
 Thu, 08 Jan 2026 07:17:30 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81d87955bb6sm1060239b3a.50.2026.01.08.07.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 07:17:30 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 11/18] target/riscv: rvv: Add vfncvt.f.f.q and
 vfncvt.sat.f.f.q instructions for Zvfofp8min extension
Date: Thu,  8 Jan 2026 23:16:42 +0800
Message-ID: <20260108151650.16329-12-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108151650.16329-1-max.chou@sifive.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x432.google.com
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

The vfncvt.f.f.q and vfncvt.sat.f.f.q instructions convert a vector of
FP32 elements to a vector of OFP8 elements. The vfncvt.sat.f.fq instruction
converts a vector of FP32 elements to a vector of OFP8 elements with saturation.
The VTYPE.altfmt field is used to select the OFP8 format.
* altfmt = 0: FP32 to OFP8.e4m3
* altfmt = 1: FP32 to OFP8.e5m2

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn32.decode                 |  2 +
 target/riscv/insn_trans/trans_rvofp8.c.inc | 62 ++++++++++++++++++++++
 target/riscv/insn_trans/trans_rvv.c.inc    | 39 ++++++++++++++
 3 files changed, 103 insertions(+)

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
index 70a22616dc..4b44417c47 100644
--- a/target/riscv/insn_trans/trans_rvofp8.c.inc
+++ b/target/riscv/insn_trans/trans_rvofp8.c.inc
@@ -22,6 +22,13 @@
     } \
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
@@ -51,3 +58,58 @@ static bool trans_vfncvtbf16_sat_f_f_w(DisasContext *ctx, arg_rmr *a)
     return false;
 }
 
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
index bcd45b0aa3..93c0761171 100644
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
2.43.7


