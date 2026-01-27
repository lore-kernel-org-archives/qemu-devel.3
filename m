Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5F7D2594B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 06:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkci7-0002sd-3G; Tue, 27 Jan 2026 01:38:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkci2-0002ra-IT
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:37:54 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkci0-0006jb-51
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:37:53 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3530715386cso4617711a91.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 22:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769495871; x=1770100671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FIZ+8DhFMV5di51oJwROCHq2vvo+jCjrZCBVlKzi/NE=;
 b=DOR6fOZw4/ZfK/dQsNqyzDPZvqGziZemqGuxNC8vW2Wk46r2eXHRe6Pp+iMNs9TB5D
 DrSp6S40mG8r2WriNaCXGm4W0uWuzYXItbipM04W9lVU5AddEUvjxIn348Q+jPBOzfnh
 0nbVLHPlVjsEJ0DTLcko1GO14a1QT10TA5Nx9SlVeEsKonejPC2/4pQo06pGMYPLhkJG
 9+st1yZvz7vfqtJ2JoqO9SNnh5l0vssnn07tWsAuwqqkd6iF0z/Tir3MWv74cPXOWPcL
 MW3f6ucxxpcDbBafVoXhzrhub1c7iAEuBM+OkNVdBRyJz2ElL6hlJbHNF9SxHbudPGh8
 7ihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769495871; x=1770100671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FIZ+8DhFMV5di51oJwROCHq2vvo+jCjrZCBVlKzi/NE=;
 b=j/lWY9QsZ22VvpRy/DvJr424cQ+lvSrVvTFXsObLZl8Pd9Xdg3xa3lfIl3i8wCzzX0
 616nEmstISlKu4yFXI01FG67pOtoGOZ8BdnqPKsXwDpOLATySmISyaAJfTDZSRggWQcs
 XXc5c1OOWb8iHcdTOu6d4KskTbnIuuJWF24jvGM4/6z8K5tFw1lUhZUx4PyZGDqyzBM+
 FGls6k7JoZmoImejfnbVd/I57rSRSu/QGhcBmZPFEZBuo+sJXxwKKcvLVb9cT84oUdxW
 io6ah1W3+pTcg03O7QX1bQhxZHwVE+oAmmVgNelDxSmLiiJmhFy8UUbRkDWdNZkV27gt
 yrhg==
X-Gm-Message-State: AOJu0Ywx1jlJwV6PY+CS5vRVWiGwH0aWoVTj3iJy1uhllWNhRN7C2C00
 M46a0rcIWqSWacZdmVZMubzy1ZGC6hl2huALU9Dc46jaiymNuwB/XRMsKLe3DRZoNHmpKqzc/oh
 HcnxP62AwO2K3YU8mRzueXXIBzSeFEn5R14DqWDh0zh8eR6xNnmYtLVU9dwPaySqXhmveiLYVIP
 Go83Ms9phkSkVETFsItPHmVvRPJipL8ZiG3p5xFT22+A==
X-Gm-Gg: AZuq6aJWkTJ0E8YxZHZMSZcd4vcttg+0+M5gOv0Mv+iDK7Dip95RUx0trKwiWsWZkwp
 h0N/3xDMN3so1fCisccVF1fWGXeBfv/QaCV2vswvo2a+LbSAK0hhX1T8yRHOTDzxWax1GlzSKm4
 2WAmKyB306g/XS41vQ/wuxpoZxh1hrMo9oK/9vlNaEf9uf8BjI1PJyBSyxDwlTSE/+jx3pU8LrL
 vuQEu2q5h86Kk+E0nP2DvG6TVVSrFXb95LUzB5PTvxDV0yn4APVh2gcsnBaaeb8wVUxOUHToFJe
 51GmaroxxnxxAVvEqJHRU3C5G9t8CPNknKbyz4I0aETg811+pOhtupN+aYZMnXQGubXLT7cEXqa
 s8GvWERGZP0Ga6hGWaVkXoSch7O/QrmzG6lIYzYM3e/6M2RSf04xxq5jGtmtyQV9g5J85QoklHX
 qcdGVHYJ7b8K3dH/TqcgN01IqM9nyMvXGzPrjCsYkCu0ikFJs5r6iYtdN802nJoB64U/F8EXbAp
 Os7Nn17DdLr3fIobxIwNNcR0A==
X-Received: by 2002:a17:90b:2541:b0:33b:8ac4:1ac4 with SMTP id
 98e67ed59e1d1-353fed945bbmr916050a91.35.1769495870685; 
 Mon, 26 Jan 2026 22:37:50 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f5f96293sm1414175a91.0.2026.01.26.22.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 22:37:50 -0800 (PST)
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
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 08/17] target/riscv: rvv: Make vfncvtbf16.f.f.w support
 BF16 to OFP8 conversion for Zvfofp8min extension
Date: Tue, 27 Jan 2026 14:37:14 +0800
Message-ID: <20260127063723.442734-9-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127063723.442734-1-max.chou@sifive.com>
References: <20260127063723.442734-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1031.google.com
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


