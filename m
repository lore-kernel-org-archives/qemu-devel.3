Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8E0EF8FEA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmTh-0007ao-K7; Wed, 04 Mar 2026 08:41:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmSt-00076N-NJ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:40:43 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmSp-0005Gq-Kd
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:40:39 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-827390e8a3cso4441547b3a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772631634; x=1773236434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X1mPbNrkbZhdEdy+7HQVJMcKS2lnobOrz3f6ZLgHC1g=;
 b=Nai1XJ8GbEmAGhNblmV3a4Z/whrCrw79WVO0yk54a8CQCk4ZX3MzNFO1GJKqLCktGO
 hmOPBovGWCYUmjZtEJObxmxbS1vh7igbIh3oE0Cx2C1zr8W/sh0eUe8xWYO3y0oAcT58
 Z8V+20FdHi1OWcav/gtt9ALuztkccu2/xT2BOwawrqI4tWsvFXdru3UKuXH19U7kKTzG
 DACkArIRiaXUm53/moOWFw7nzOSo/Xt5vSk+KW2lJZLtdINF7EQRInhbeOJlEGniyvBS
 gyW0aFACT9EH2/WWCf32/00jqlZ/fSQE7ybA4ThQ1GTSwW/iCpdWGhiuI7BDmfVHGCky
 TzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772631634; x=1773236434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X1mPbNrkbZhdEdy+7HQVJMcKS2lnobOrz3f6ZLgHC1g=;
 b=nXgKSf++Bspd7iNbECu4B8XdFebkRzutnPoEHkSzrn8Ou8Eg7nBzYvpfp+bstPx2Yw
 lSDFCgeL+8CwiepwRGQnvj4Ij6kqN+m6dcQL1wpq+eU9Gf4dSnS8XxxtnGlTZRGppyh9
 ONqbjvEJID0Jo8VXZAqWCo3FQUn2rRT4AVS8xZ75BcByNWH5JkCj3ffigPoTPjV+Wy8D
 oO7xO4WZEWlJkblzD1KV+tvjqyaUnLyIdAFDLq6fl7hbNMk+yyoHF5aClDiyvnGqhVZe
 3FLrXALGsHvgbWwLqn2D3gUE1cGo2XFcR9w2/3Inmrx3p17c+2DAGZAJNJKjlVLI71E3
 16ng==
X-Gm-Message-State: AOJu0Yw7XoRL4NbO8pj14Ul21oH7+pCw20+F/xJt0qDeCSqw9LDTTE0r
 rLnvVCj5ctFW2p8JLm1LEcy4Aq1pFyiIJpWHfXg6cBzmL6CXc87PTF7MeLJoY98Bn2k0NOV4ug3
 AEo1CF/8roCUdCsMMmC5S0MfTPOb4zqmwyXrN9Jdc5jWsG1V17VuYN0NYX4O0r4sdH6C4mloXIN
 pyk1KG0y+Wnqc4kt2HFc/Y6Ce8d5NF1m22PuJ75D9zkg==
X-Gm-Gg: ATEYQzxHnm/D2kfr3k0jRBRIRpVmiOSUlWHM5ofO1L4/OEUlHxVHSyWpGJexortbs5x
 UALxDGAYTWGrBe7G4S5f9J4TZHzsGPBFjf4MbrOZsJzX3o5of1HytmlqrGkWYzdDRjG+eMbpAyN
 undPYmR3wiMPM28dYXcGN7X1QmViNsEpTEYV8wXKw+ZE5adfW5B6Vkv4i2VsTbjAV+lRKkGx51T
 rKN2G1iQCt3HQtMMXwKhu7RPygB1umvFb4LNXVT57S6d8sMUhsshxyGuEoMudQ1G5AZbNoCfVDU
 1Mj7qplIz7mjW3mrip/zpYVZ4lOzZpw312mlpZb3ijgfrkFTinXhLHdGP1HfqXI8/AGjPSLf9GI
 LmgUvbBa+vGL67MA7RYWEicjyVv48KZaunswnrqXIDbge96/+s78kIXrlK2WkS8JbTOCPUfQH4o
 9ylL+/ZBt/210xzR/67JHjUZGsaWNuq2AIilywXxe7J0XfNzHqsew96YX1czrWyR5pL75PbTAWZ
 nibaeUlOHur3h/wZf7pOGk1Km4=
X-Received: by 2002:a05:6a00:4613:b0:823:5729:a125 with SMTP id
 d2e1a72fcca58-8297276cb2fmr1980093b3a.30.1772631633872; 
 Wed, 04 Mar 2026 05:40:33 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8297e11bf5dsm251921b3a.28.2026.03.04.05.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:40:33 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 05/14] target/riscv: rvv: Make vfncvtbf16.f.f.w support
 BF16 to OFP8 conversion for Zvfofp8min extension
Date: Wed,  4 Mar 2026 21:39:57 +0800
Message-ID: <20260304134006.2908449-6-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304134006.2908449-1-max.chou@sifive.com>
References: <20260304134006.2908449-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42c.google.com
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

According to the Zvfofp8min extension, the vfncvtbf16.f.f.w instruction
supports BF16 to OFP8 conversion without satuation when SEW is 8.
And the VTYPE.altfmt field is used to select the OFP8 format.
* altfmt = 0: BF16 to OFP8.e4m3
* altfmt = 1: BF16 to OFP8.e5m2

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvbf16.c.inc | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/insn_trans/trans_rvbf16.c.inc
index 9aafd4d2ef..16f4403909 100644
--- a/target/riscv/insn_trans/trans_rvbf16.c.inc
+++ b/target/riscv/insn_trans/trans_rvbf16.c.inc
@@ -67,11 +67,20 @@ static bool trans_fcvt_s_bf16(DisasContext *ctx, arg_fcvt_s_bf16 *a)
 static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
 {
     REQUIRE_FPU;
-    REQUIRE_ZVFBFMIN(ctx);
 
-    if (opfv_narrow_check(ctx, a) && (ctx->sew == MO_16)) {
+    if (opfv_narrow_check(ctx, a) &&
+        ((ctx->sew == MO_16 && ctx->cfg_ptr->ext_zvfbfmin) ||
+         (ctx->sew == MO_8 && ctx->cfg_ptr->ext_zvfofp8min))) {
+        gen_helper_gvec_3_ptr *fn;
         uint32_t data = 0;
 
+        if (ctx->sew == MO_16) {
+            fn = gen_helper_vfncvtbf16_f_f_w;
+        } else {
+            fn = ctx->altfmt ? gen_helper_vfncvtbf16_f_f_w_ofp8e5m2 :
+                               gen_helper_vfncvtbf16_f_f_w_ofp8e4m3;
+        }
+
         gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
@@ -81,8 +90,7 @@ static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
         tcg_gen_gvec_3_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
                            vreg_ofs(ctx, a->rs2), tcg_env,
                            ctx->cfg_ptr->vlenb,
-                           ctx->cfg_ptr->vlenb, data,
-                           gen_helper_vfncvtbf16_f_f_w);
+                           ctx->cfg_ptr->vlenb, data, fn);
         finalize_rvv_inst(ctx);
         return true;
     }
-- 
2.52.0


