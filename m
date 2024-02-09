Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E319FC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYObq-00042W-Fj; Fri, 09 Feb 2024 05:59:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObn-0003yk-QT
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:51 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObm-0000KK-1d
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:51 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6e04fd5e05aso588352b3a.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476388; x=1708081188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RY/W4siSwQBykp7ay66hWabgPBQo3IteY5nKTba779s=;
 b=W3EQdzHbhcqp1VDtzDHt2gg+c2VluhVPP0qoMHPnyX3BstGXLmKEctUrwHueCe/eQZ
 GtdxZERy8ndY+32j4pwDJZx4M4AWokiD4S5laGt3gda7oXgwQxVV2riIMP2cKy0MMFjL
 z0ibrVozdrmIA9T4tzqHtLXa0kQvZ9a6tpMIxrfOKuNRiqsIhITnUEClRfc49kdpJNj5
 nXqA8Z1UIB9HQ4PIIF5imu/U0V9GUyE2q4cNPZVHrZATBUuYKZcvcgc+mSQ4XzAMYdiY
 rM8yS9khZ3PMgKOgoeQ0UP3l9cYZLFg1m0O4c0vBxC5ETBMAWNDifQlr7x05cC5AqVqk
 jX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476388; x=1708081188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RY/W4siSwQBykp7ay66hWabgPBQo3IteY5nKTba779s=;
 b=Dq/xI+eFCIPKlZT7ZY66kw9rlYNspz/CuqXigUpYYY3Hcx3V+l85PLWi6lDsapOsPG
 iCc4fxSDn/TOfcv9SbEgeE7O7nPSgPutjrozeMLSrxaPGuvNm06jpg+02kgsYKZJ9CFN
 pJ0anQe00mP3FdhpYa9VIjcw1Qmiek69uTG1jPimz51q8DMwXnsaJp3Ge1+lrHpb6EPQ
 quTYBr6qi4nAQDrCcQUAw2mfpx4B298pZObEStTMlVfmZkCauZ70aYBdzAkGIiMI+bEg
 695GjXj4NUxLxOVXtnJetS6fOyUK1JxSl57z6mr9zm9qQW1JoST2tGojygMICTd594jI
 WEhQ==
X-Gm-Message-State: AOJu0YwgZliFnxn8PL0D5Dq2emtGWx/8q9laSM60by8x35Fu0fBAvhNh
 hwKGwXYQbXzBq9hbEatJ2tiZEHvQrQaarz2sHXTCMAHYuv0qyNPqMaTiH1VfVliE2w==
X-Google-Smtp-Source: AGHT+IE4xsHNxKZYlk3zv5JHGFnPzZ8LTP78sXRGPj7XXfemc5MQDrEiraqYsMSQ09nEEbGy5dVe2g==
X-Received: by 2002:a05:6a21:918a:b0:19e:a5ae:229b with SMTP id
 tp10-20020a056a21918a00b0019ea5ae229bmr755857pzb.31.1707476388257; 
 Fri, 09 Feb 2024 02:59:48 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXCcfjvdwIhKO4ndvd8Va2XQQL7+RAE3nLb/laoaLC570UxrZPPAkXp/iYAp/F511Lmp2PAUrwCWFUzNJq1PDs1+6u7O+dai2FuJlUlqHmjmAfqYChWdwo9DW/ItgzzIbb+WiDkSbhCbYjsu98qpEvmJfgrTbVigcZ51N8h/aeud2c=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:59:47 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 25/61] target/riscv/insn_trans/trans_rvbf16.c.inc: use
 cpu->cfg.vlenb
Date: Fri,  9 Feb 2024 20:57:37 +1000
Message-ID: <20240209105813.3590056-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x433.google.com
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

Use ctx->cfg_ptr->vlenb instead of ctx->cfg_ptr->vlen / 8.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240122161107.26737-5-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvbf16.c.inc | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/insn_trans/trans_rvbf16.c.inc
index 4e39c00884..8ee99df3f3 100644
--- a/target/riscv/insn_trans/trans_rvbf16.c.inc
+++ b/target/riscv/insn_trans/trans_rvbf16.c.inc
@@ -83,8 +83,8 @@ static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
         data = FIELD_DP32(data, VDATA, VMA, ctx->vma);
         tcg_gen_gvec_3_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
                            vreg_ofs(ctx, a->rs2), tcg_env,
-                           ctx->cfg_ptr->vlen / 8,
-                           ctx->cfg_ptr->vlen / 8, data,
+                           ctx->cfg_ptr->vlenb,
+                           ctx->cfg_ptr->vlenb, data,
                            gen_helper_vfncvtbf16_f_f_w);
         mark_vs_dirty(ctx);
         gen_set_label(over);
@@ -112,8 +112,8 @@ static bool trans_vfwcvtbf16_f_f_v(DisasContext *ctx, arg_vfwcvtbf16_f_f_v *a)
         data = FIELD_DP32(data, VDATA, VMA, ctx->vma);
         tcg_gen_gvec_3_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
                            vreg_ofs(ctx, a->rs2), tcg_env,
-                           ctx->cfg_ptr->vlen / 8,
-                           ctx->cfg_ptr->vlen / 8, data,
+                           ctx->cfg_ptr->vlenb,
+                           ctx->cfg_ptr->vlenb, data,
                            gen_helper_vfwcvtbf16_f_f_v);
         mark_vs_dirty(ctx);
         gen_set_label(over);
@@ -143,8 +143,8 @@ static bool trans_vfwmaccbf16_vv(DisasContext *ctx, arg_vfwmaccbf16_vv *a)
         tcg_gen_gvec_4_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
                            vreg_ofs(ctx, a->rs1),
                            vreg_ofs(ctx, a->rs2), tcg_env,
-                           ctx->cfg_ptr->vlen / 8,
-                           ctx->cfg_ptr->vlen / 8, data,
+                           ctx->cfg_ptr->vlenb,
+                           ctx->cfg_ptr->vlenb, data,
                            gen_helper_vfwmaccbf16_vv);
         mark_vs_dirty(ctx);
         gen_set_label(over);
-- 
2.43.0


