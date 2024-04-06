Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED99CD1297
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2024 22:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtEay-0003Oy-TB; Sat, 06 Apr 2024 18:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtEaw-0003OL-HQ
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 18:33:06 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtEav-0006jw-3P
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 18:33:06 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so2769479a12.1
 for <qemu-devel@nongnu.org>; Sat, 06 Apr 2024 15:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712442783; x=1713047583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5EK613jOMt0q5YKINPHaRaY+PjrWQT7TxkM34vbcqwA=;
 b=a6iP+T6rk6iAIhM7d8wsEfyJ9b8hoWyphLncgP0F3l5RAtfzFhS7lSX5B4Egvd5xia
 izFMpUn7jTYbDA1f8nPSx9CnZS8F+ExY7ghF6pkjZCczIcsPZZCHRCZ+fmTimKWb4bYk
 iDaTMphD7594Fvs/wJwpN8g5i8psT1dOaodlGdzfj9IIwpP7cYSE56N0saFkrSaIVMU5
 K6AAMdluwVvj2Lo5GFtbUAggv722x92Y06xNwQIyjspKYoQZf0Jr8dYMPxuPGTAfcYXG
 uBsz8VMGS1WP95GvLRljKtKtVS5OPm4XtN5+UQ3O93sej16DE9FYXT3VviWzrGbX27tL
 LOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712442783; x=1713047583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5EK613jOMt0q5YKINPHaRaY+PjrWQT7TxkM34vbcqwA=;
 b=hi8HQrwodOzJ0UtFAVyJ2hT4DtizfbBVZAzd4ckq38LJNyEkRPXlNx95X+e0uy827H
 dmk7idJb8TG1Ju9ejpenNoaIPdoU3ret6GWsC/ksWkcY8OPgpR0403dRB3LV1035+H8H
 qe2xrmaR7wjYI3V63d0hKJH7Yc+3BbkxoD/ZHyNJL6Ek+u1i9tKDvta8mMkywNlKrpGx
 v48n6h+QwnH/zYt00U6ZWVwa7TGQpnvN0gw7P9PqWCBQtx8+5htaMKN14SeiVoClX9gX
 f4Pce6KG9OuX+HM2pmlM4Sz48EGaPjp9BPwGMYDRwM/H3dUVH8XH7q7BJG2JjYrCgfoN
 M1mA==
X-Gm-Message-State: AOJu0YxBWGSHfIDlRviekjwd5q3oXoxjyPa+KNFPdnnJTuxdIyeOcbPD
 042X9+lxYHJsuNOk3U5AkjBpsS+Wm5QiX34AAF4Ydv3c+Rmq0Cvxms0mimcUIRnq6GBP+/xMzGI
 C
X-Google-Smtp-Source: AGHT+IGy+KLMAwHUSM52vBzPht35ASNrL/VNKIbtrWp2B0kUGRZYRnvr8HGuhMxp9ffDQHEtdbUDuw==
X-Received: by 2002:a05:6a21:8182:b0:1a7:5706:9b96 with SMTP id
 pd2-20020a056a21818200b001a757069b96mr966857pzb.38.1712442783698; 
 Sat, 06 Apr 2024 15:33:03 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a17090ace1700b002a20c0dcebbsm3643279pju.31.2024.04.06.15.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Apr 2024 15:33:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Subject: [PATCH 7/9] target/riscv: Use insn_start from DisasContextBase
Date: Sat,  6 Apr 2024 12:32:46 -1000
Message-Id: <20240406223248.502699-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240406223248.502699-1-richard.henderson@linaro.org>
References: <20240406223248.502699-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

To keep the multiple update check, replace insn_start
with insn_start_updated.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/translate.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9d57089fcc..9ff09ebdb6 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -115,8 +115,7 @@ typedef struct DisasContext {
     bool itrigger;
     /* FRM is known to contain a valid value. */
     bool frm_valid;
-    /* TCG of the current insn_start */
-    TCGOp *insn_start;
+    bool insn_start_updated;
 } DisasContext;
 
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -207,9 +206,9 @@ static void gen_check_nanbox_s(TCGv_i64 out, TCGv_i64 in)
 
 static void decode_save_opc(DisasContext *ctx)
 {
-    assert(ctx->insn_start != NULL);
-    tcg_set_insn_start_param(ctx->insn_start, 1, ctx->opcode);
-    ctx->insn_start = NULL;
+    assert(!ctx->insn_start_updated);
+    ctx->insn_start_updated = true;
+    tcg_set_insn_start_param(ctx->base.insn_start, 1, ctx->opcode);
 }
 
 static void gen_pc_plus_diff(TCGv target, DisasContext *ctx,
@@ -1224,7 +1223,7 @@ static void riscv_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
     }
 
     tcg_gen_insn_start(pc_next, 0);
-    ctx->insn_start = tcg_last_op();
+    ctx->insn_start_updated = false;
 }
 
 static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
-- 
2.34.1


