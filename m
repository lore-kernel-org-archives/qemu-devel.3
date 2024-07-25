Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E32C3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Lr-00087B-J6; Thu, 25 Jul 2024 19:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8LZ-0006SP-Sz; Thu, 25 Jul 2024 19:58:13 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8LX-0001W7-AA; Thu, 25 Jul 2024 19:58:09 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2cb5787b4a5so293641a91.2; 
 Thu, 25 Jul 2024 16:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951885; x=1722556685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AQAKqLoljGdbIxBw31Wuprqd07PqhNDcpZhqslXNEDU=;
 b=hkhRxGU0uJQZgpgBTZCHO1DMLePi1hDCQfUWzMtP2EAOxzPyg3DChwlF9CnbgOCsm1
 Ml+UnAYyCfZr3LpvttXsXqRO4o+ZjSc4xG1MmaFWYv5CJkAOdnVsimoNdzPUGu4EqdJu
 Pdfsw5pzAeEs3rrAl0ce89f3bRlrK234vc09toKBTDBvt5mi0ZDK1zEEkSwBblEvmZGW
 QLfCuJU77RCCD5wp8jirAwfT9fopB9LgRnQo0jQf7uzrzZfn9wg1r/heKUAXkkdMoub3
 3zMkPNS8pSku7MKW912zOwVJwy4DwBnm34p3mYF9lfvuhJBibszQVyiISKn4+jUYeu3W
 Dp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951885; x=1722556685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AQAKqLoljGdbIxBw31Wuprqd07PqhNDcpZhqslXNEDU=;
 b=uAU1SwNDbzEKO4gdTDg8CBrVU/I3NkLNck/5+c5BFPttdCo5MYFAibwIxVd8ulB9K8
 zzHhxr78T/FAZUdr0DOuvwZgDgpe4Kt9Z0nsmm82FFwSgco7YFkdmy4s58on72QauZD0
 N+Q/yRAn02laCTanLeTz1oOye3eAQRYZQTlh6GJraXBwDOihUA2VePI3NCH6Uazwvf01
 nk0f1p+4+ltmb7TShiMTzVAdTl4Ddtj0o4UlvgVHz9EpKD37qm4iwxPk62GXShiNt0hS
 Z4NjKtyNwB8NLBqhjROZfdDKyx00AB40kYuvQ0x2qGZzeJVKxgK3HDqZstw/+D2YKc6U
 0vFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/AEnRIUOIPhu0GkiO/bXhwygJ+lv8UBMRSfBE1qKCsmz8O2QB3tmQWVIeWdgrvqPXBNKbecYA6WcsXO+cKERxHiu5
X-Gm-Message-State: AOJu0YzpkGyvB2Az0s0lkYJsDQHQd+RCghFUJJkD2XJsrlGPRwSGs7/c
 26N8t02B2K5tNO46FBhBBe7DvmCPgUkfQHH3ghz61rCPFNyaJlpNG1/hDA==
X-Google-Smtp-Source: AGHT+IHtOqSSXIswo7r84MlH2Ge2MmE6EdHNxp/zinp4DHRR/U4IyYNH6a2kIuGam5k4bm4axkpEgw==
X-Received: by 2002:a17:90a:3ea3:b0:2c9:8f14:c02e with SMTP id
 98e67ed59e1d1-2cf23772f87mr5307408a91.1.1721951885169; 
 Thu, 25 Jul 2024 16:58:05 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:58:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 61/96] target/ppc: Move VSX fp compare insns to decodetree.
Date: Fri, 26 Jul 2024 09:53:34 +1000
Message-ID: <20240725235410.451624-62-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Chinmay Rath <rathc@linux.ibm.com>

Moving the following instructions to decodetree specification:

	xvcmp{eq, gt, ge, ne}{s, d}p	: XX3-form

The changes were verified by validating that the tcg-ops generated for those
instructions remain the same which were captured using the '-d in_asm,op' flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/fpu_helper.c             | 16 +++++-----
 target/ppc/helper.h                 | 16 +++++-----
 target/ppc/insn32.decode            | 12 ++++++++
 target/ppc/translate/vsx-impl.c.inc | 46 +++++++++++++----------------
 target/ppc/translate/vsx-ops.c.inc  | 18 -----------
 5 files changed, 48 insertions(+), 60 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 3f2e4f5827..230466a87f 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2527,14 +2527,14 @@ uint32_t helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                     \
     return crf6;                                                          \
 }
 
-VSX_CMP(xvcmpeqdp, 2, float64, VsrD(i), eq, 0, 1)
-VSX_CMP(xvcmpgedp, 2, float64, VsrD(i), le, 1, 1)
-VSX_CMP(xvcmpgtdp, 2, float64, VsrD(i), lt, 1, 1)
-VSX_CMP(xvcmpnedp, 2, float64, VsrD(i), eq, 0, 0)
-VSX_CMP(xvcmpeqsp, 4, float32, VsrW(i), eq, 0, 1)
-VSX_CMP(xvcmpgesp, 4, float32, VsrW(i), le, 1, 1)
-VSX_CMP(xvcmpgtsp, 4, float32, VsrW(i), lt, 1, 1)
-VSX_CMP(xvcmpnesp, 4, float32, VsrW(i), eq, 0, 0)
+VSX_CMP(XVCMPEQDP, 2, float64, VsrD(i), eq, 0, 1)
+VSX_CMP(XVCMPGEDP, 2, float64, VsrD(i), le, 1, 1)
+VSX_CMP(XVCMPGTDP, 2, float64, VsrD(i), lt, 1, 1)
+VSX_CMP(XVCMPNEDP, 2, float64, VsrD(i), eq, 0, 0)
+VSX_CMP(XVCMPEQSP, 4, float32, VsrW(i), eq, 0, 1)
+VSX_CMP(XVCMPGESP, 4, float32, VsrW(i), le, 1, 1)
+VSX_CMP(XVCMPGTSP, 4, float32, VsrW(i), lt, 1, 1)
+VSX_CMP(XVCMPNESP, 4, float32, VsrW(i), eq, 0, 0)
 
 /*
  * VSX_CVT_FP_TO_FP - VSX floating point/floating point conversion
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 85be749004..5a77e761bd 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -476,10 +476,10 @@ DEF_HELPER_5(xvnmadddp, void, env, vsr, vsr, vsr, vsr)
 DEF_HELPER_5(xvnmsubdp, void, env, vsr, vsr, vsr, vsr)
 DEF_HELPER_4(XVMAXDP, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(XVMINDP, void, env, vsr, vsr, vsr)
-DEF_HELPER_FLAGS_4(xvcmpeqdp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
-DEF_HELPER_FLAGS_4(xvcmpgedp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
-DEF_HELPER_FLAGS_4(xvcmpgtdp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
-DEF_HELPER_FLAGS_4(xvcmpnedp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(XVCMPEQDP, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(XVCMPGEDP, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(XVCMPGTDP, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(XVCMPNEDP, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
 DEF_HELPER_3(xvcvdpsp, void, env, vsr, vsr)
 DEF_HELPER_3(xvcvdpsxds, void, env, vsr, vsr)
 DEF_HELPER_3(xvcvdpsxws, void, env, vsr, vsr)
@@ -510,10 +510,10 @@ DEF_HELPER_5(xvnmaddsp, void, env, vsr, vsr, vsr, vsr)
 DEF_HELPER_5(xvnmsubsp, void, env, vsr, vsr, vsr, vsr)
 DEF_HELPER_4(XVMAXSP, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(XVMINSP, void, env, vsr, vsr, vsr)
-DEF_HELPER_FLAGS_4(xvcmpeqsp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
-DEF_HELPER_FLAGS_4(xvcmpgesp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
-DEF_HELPER_FLAGS_4(xvcmpgtsp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
-DEF_HELPER_FLAGS_4(xvcmpnesp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(XVCMPEQSP, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(XVCMPGESP, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(XVCMPGTSP, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(XVCMPNESP, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
 DEF_HELPER_3(xvcvspdp, void, env, vsr, vsr)
 DEF_HELPER_3(xvcvsphp, void, env, vsr, vsr)
 DEF_HELPER_3(xvcvhpsp, void, env, vsr, vsr)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 77869cfb33..e53fd2840d 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -241,6 +241,9 @@
 &XX3            xt xa xb
 @XX3            ...... ..... ..... ..... ........ ...           &XX3 xt=%xx_xt xa=%xx_xa xb=%xx_xb
 
+&XX3_rc         xt xa xb rc:bool
+@XX3_rc         ...... ..... ..... ..... rc:1 ....... ...       &XX3_rc xt=%xx_xt xa=%xx_xa xb=%xx_xb
+
 # 32 bit GER instructions have all mask bits considered 1
 &MMIRR_XX3      xa xb xt pmsk xmsk ymsk
 %xx_at          23:3
@@ -1124,6 +1127,15 @@ XSCMPEQQP       111111 ..... ..... ..... 0001000100 -   @X
 XSCMPGEQP       111111 ..... ..... ..... 0011000100 -   @X
 XSCMPGTQP       111111 ..... ..... ..... 0011100100 -   @X
 
+XVCMPEQSP       111100 ..... ..... ..... . 1000011 ...   @XX3_rc
+XVCMPGTSP       111100 ..... ..... ..... . 1001011 ...   @XX3_rc
+XVCMPGESP       111100 ..... ..... ..... . 1010011 ...   @XX3_rc
+XVCMPNESP       111100 ..... ..... ..... . 1011011 ...   @XX3_rc
+XVCMPEQDP       111100 ..... ..... ..... . 1100011 ...   @XX3_rc
+XVCMPGTDP       111100 ..... ..... ..... . 1101011 ...   @XX3_rc
+XVCMPGEDP       111100 ..... ..... ..... . 1110011 ...   @XX3_rc
+XVCMPNEDP       111100 ..... ..... ..... . 1111011 ...   @XX3_rc
+
 XSMAXDP         111100 ..... ..... ..... 10100000 ...   @XX3
 XSMINDP         111100 ..... ..... ..... 10101000 ...   @XX3
 
diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index e0fb4bad92..26ebf3fedf 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -792,34 +792,28 @@ static bool do_xvcpsgn(DisasContext *ctx, arg_XX3 *a, unsigned vece)
 TRANS(XVCPSGNSP, do_xvcpsgn, MO_32)
 TRANS(XVCPSGNDP, do_xvcpsgn, MO_64)
 
-#define VSX_CMP(name, op1, op2, inval, type)                                  \
-static void gen_##name(DisasContext *ctx)                                     \
-{                                                                             \
-    TCGv_i32 ignored;                                                         \
-    TCGv_ptr xt, xa, xb;                                                      \
-    if (unlikely(!ctx->vsx_enabled)) {                                        \
-        gen_exception(ctx, POWERPC_EXCP_VSXU);                                \
-        return;                                                               \
-    }                                                                         \
-    xt = gen_vsr_ptr(xT(ctx->opcode));                                        \
-    xa = gen_vsr_ptr(xA(ctx->opcode));                                        \
-    xb = gen_vsr_ptr(xB(ctx->opcode));                                        \
-    if ((ctx->opcode >> (31 - 21)) & 1) {                                     \
-        gen_helper_##name(cpu_crf[6], tcg_env, xt, xa, xb);                   \
-    } else {                                                                  \
-        ignored = tcg_temp_new_i32();                                         \
-        gen_helper_##name(ignored, tcg_env, xt, xa, xb);                      \
-    }                                                                         \
+static bool do_cmp(DisasContext *ctx, arg_XX3_rc *a,
+            void (*helper)(TCGv_i32, TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr))
+{
+    TCGv_i32 dest;
+    TCGv_ptr xt, xa, xb;
+    REQUIRE_VSX(ctx);
+    xt = gen_vsr_ptr(a->xt);
+    xa = gen_vsr_ptr(a->xa);
+    xb = gen_vsr_ptr(a->xb);
+    dest = a->rc ? cpu_crf[6] : tcg_temp_new_i32();
+    helper(dest, tcg_env, xt, xa, xb);
+    return true;
 }
 
-VSX_CMP(xvcmpeqdp, 0x0C, 0x0C, 0, PPC2_VSX)
-VSX_CMP(xvcmpgedp, 0x0C, 0x0E, 0, PPC2_VSX)
-VSX_CMP(xvcmpgtdp, 0x0C, 0x0D, 0, PPC2_VSX)
-VSX_CMP(xvcmpnedp, 0x0C, 0x0F, 0, PPC2_ISA300)
-VSX_CMP(xvcmpeqsp, 0x0C, 0x08, 0, PPC2_VSX)
-VSX_CMP(xvcmpgesp, 0x0C, 0x0A, 0, PPC2_VSX)
-VSX_CMP(xvcmpgtsp, 0x0C, 0x09, 0, PPC2_VSX)
-VSX_CMP(xvcmpnesp, 0x0C, 0x0B, 0, PPC2_VSX)
+TRANS_FLAGS2(VSX, XVCMPEQSP, do_cmp, gen_helper_XVCMPEQSP);
+TRANS_FLAGS2(VSX, XVCMPGTSP, do_cmp, gen_helper_XVCMPGTSP);
+TRANS_FLAGS2(VSX, XVCMPGESP, do_cmp, gen_helper_XVCMPGESP);
+TRANS_FLAGS2(ISA300, XVCMPNESP, do_cmp, gen_helper_XVCMPNESP);
+TRANS_FLAGS2(VSX, XVCMPEQDP, do_cmp, gen_helper_XVCMPEQDP);
+TRANS_FLAGS2(VSX, XVCMPGTDP, do_cmp, gen_helper_XVCMPGTDP);
+TRANS_FLAGS2(VSX, XVCMPGEDP, do_cmp, gen_helper_XVCMPGEDP);
+TRANS_FLAGS2(ISA300, XVCMPNEDP, do_cmp, gen_helper_XVCMPNEDP);
 
 static bool trans_XSCVQPDP(DisasContext *ctx, arg_X_tb_rc *a)
 {
diff --git a/target/ppc/translate/vsx-ops.c.inc b/target/ppc/translate/vsx-ops.c.inc
index 91cde088bc..e553b5b8fa 100644
--- a/target/ppc/translate/vsx-ops.c.inc
+++ b/target/ppc/translate/vsx-ops.c.inc
@@ -43,16 +43,6 @@ GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 1, opc3, 1, PPC_NONE, fl2), \
 GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 2, opc3, 1, PPC_NONE, fl2), \
 GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 3, opc3, 1, PPC_NONE, fl2)
 
-#define GEN_XX3_RC_FORM(name, opc2, opc3, fl2)                          \
-GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 0x00, opc3 | 0x00, 0, PPC_NONE, fl2), \
-GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 0x01, opc3 | 0x00, 0, PPC_NONE, fl2), \
-GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 0x02, opc3 | 0x00, 0, PPC_NONE, fl2), \
-GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 0x03, opc3 | 0x00, 0, PPC_NONE, fl2), \
-GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 0x00, opc3 | 0x10, 0, PPC_NONE, fl2), \
-GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 0x01, opc3 | 0x10, 0, PPC_NONE, fl2), \
-GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 0x02, opc3 | 0x10, 0, PPC_NONE, fl2), \
-GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 0x03, opc3 | 0x10, 0, PPC_NONE, fl2)
-
 #define GEN_XX3FORM_DM(name, opc2, opc3) \
 GEN_HANDLER2_E(name, #name, 0x3C, opc2|0x00, opc3|0x00, 0, PPC_NONE, PPC2_VSX),\
 GEN_HANDLER2_E(name, #name, 0x3C, opc2|0x01, opc3|0x00, 0, PPC_NONE, PPC2_VSX),\
@@ -175,10 +165,6 @@ GEN_XX3FORM_NAME(xvnmadddp, "xvnmaddadp", 0x04, 0x1C, PPC2_VSX),
 GEN_XX3FORM_NAME(xvnmadddp, "xvnmaddmdp", 0x04, 0x1D, PPC2_VSX),
 GEN_XX3FORM_NAME(xvnmsubdp, "xvnmsubadp", 0x04, 0x1E, PPC2_VSX),
 GEN_XX3FORM_NAME(xvnmsubdp, "xvnmsubmdp", 0x04, 0x1F, PPC2_VSX),
-GEN_XX3_RC_FORM(xvcmpeqdp, 0x0C, 0x0C, PPC2_VSX),
-GEN_XX3_RC_FORM(xvcmpgtdp, 0x0C, 0x0D, PPC2_VSX),
-GEN_XX3_RC_FORM(xvcmpgedp, 0x0C, 0x0E, PPC2_VSX),
-GEN_XX3_RC_FORM(xvcmpnedp, 0x0C, 0x0F, PPC2_ISA300),
 GEN_XX2FORM(xvcvdpsp, 0x12, 0x18, PPC2_VSX),
 GEN_XX2FORM(xvcvdpsxds, 0x10, 0x1D, PPC2_VSX),
 GEN_XX2FORM(xvcvdpsxws, 0x10, 0x0D, PPC2_VSX),
@@ -207,10 +193,6 @@ GEN_XX3FORM_NAME(xvnmaddsp, "xvnmaddasp", 0x04, 0x18, PPC2_VSX),
 GEN_XX3FORM_NAME(xvnmaddsp, "xvnmaddmsp", 0x04, 0x19, PPC2_VSX),
 GEN_XX3FORM_NAME(xvnmsubsp, "xvnmsubasp", 0x04, 0x1A, PPC2_VSX),
 GEN_XX3FORM_NAME(xvnmsubsp, "xvnmsubmsp", 0x04, 0x1B, PPC2_VSX),
-GEN_XX3_RC_FORM(xvcmpeqsp, 0x0C, 0x08, PPC2_VSX),
-GEN_XX3_RC_FORM(xvcmpgtsp, 0x0C, 0x09, PPC2_VSX),
-GEN_XX3_RC_FORM(xvcmpgesp, 0x0C, 0x0A, PPC2_VSX),
-GEN_XX3_RC_FORM(xvcmpnesp, 0x0C, 0x0B, PPC2_ISA300),
 GEN_XX2FORM(xvcvspdp, 0x12, 0x1C, PPC2_VSX),
 GEN_XX2FORM(xvcvspsxds, 0x10, 0x19, PPC2_VSX),
 GEN_XX2FORM(xvcvspsxws, 0x10, 0x09, PPC2_VSX),
-- 
2.45.2


