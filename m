Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AD4E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQB9w-0002mj-T3; Tue, 24 Dec 2024 15:05:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9l-0002jY-Ey
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:30 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9k-0002X3-1p
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:29 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so64868855ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070727; x=1735675527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kwAmrbK+z6InFUYOYJQouqu9jlEe2zkE3MrW95sabRA=;
 b=hptUS2Qc/0PzPXBWt5iKl0AuHcyGIEIHu5iwdrsBDtFbZ+QdI17AJc2Ng3BTTZicLG
 sPW1v6qbPRtWPW0NkBdxU4h5P/cPA/49xDZoX52xYxz3Qi+Yg8ve0ejz+0Hx+etUTTBP
 WCkdlLbUN2mQuSJJzmNrhk4xT59qAa5uPxxrfhh5SVezQn6nifCfZ1WSKBTfiBcAU+5O
 whxC0wZi1LTGUKqKMeB08UDUJsREP0wKTIsLlqRCZPnOAVtz5O0uCenS8KgnDudSdsGy
 DT3ykdXyOU/7gW4ErlWh/lzMRrVMn+ZfenMYMjpYDyUDrSqDTM+p1P/rI91HqvU9JVpS
 QReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070727; x=1735675527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kwAmrbK+z6InFUYOYJQouqu9jlEe2zkE3MrW95sabRA=;
 b=qpMVj8oiDI/OoWStCDjlpQB6kLsItzQ5cAN6/RqXuHYwIn5Rm5sh3sZybamuCeK+AF
 0qoLJ7hqUU2uFRUkEwgl9CSy2f1esccHg4aAv8ZumKHZPJq7cclWCssuYhmslWyO56Xx
 eesOaAxb7TK+PODsiDhfvK4p+NukTY3IFfdMC3EMF44AtPm8vDgN091HI4lBf4tbo4V5
 eYO0lc+oQRtmAB2xh6/d2Ef2TNuTbrXi4TfcyXn1eg+9VfP3e/KtDM+lObuIN8bam/vs
 xNaaNPmmnWlq/VHVtEyeHPELKpjuXx6hVC4BW/eQxN2/gshBwC0dCNBZ2G5nr+b7w59R
 CNNg==
X-Gm-Message-State: AOJu0YyAAbQHa0AjoZEXLFejItzTjkNGYtCV/pnx8hw01kl3PZao6N43
 3IN1em8p8eJ51gwaxNiWhxlXwQ/HW6CIP9K0X9lRJOofa4aIzjTlzFw0dpzvv4Dq6Sn6+0ueDuk
 SNfY=
X-Gm-Gg: ASbGncuUYC2FfbM2NRE+Er3sNTbaVtRP7o83W06JpMnu+Eh5fBY9Pviv9c9GKo1ky4+
 ak3/8E88F2JBEIFWD8u3XGA2Bs79nawKgn6a/F+Ofw3exSz0FQYZPx2L9PvF7ejNGATiGoRHMWz
 x7L33ElOTw9Optqk1Va6H4odC99LXKydItgclH733l8U7Jna+pB7gYj+9MNoqtfn/OfJSHHp0Kk
 KJL1J0w6vpdXMCi1McBUNkdSKWU57d+rh0ctWbCVnwzlTO60wCLUMUfW/GQsvmhN80KHq6S9Jea
 gHbJ4GrYcXoLDqN+TYXN3VZMVA==
X-Google-Smtp-Source: AGHT+IFCi+I/DGuultM+PzXQifT0v2IbJhVOIiEoqreS4k/Vpz0TfuHlStaFDtW3zlQKnwy8l1aNxQ==
X-Received: by 2002:a05:6a00:69ad:b0:725:f1e9:5334 with SMTP id
 d2e1a72fcca58-72aa9ade355mr28645965b3a.8.1735070726851; 
 Tue, 24 Dec 2024 12:05:26 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 05/72] tcg/optimize: Copy mask writeback to fold_masks
Date: Tue, 24 Dec 2024 12:04:14 -0800
Message-ID: <20241224200521.310066-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Use of fold_masks should be restricted to those opcodes that
can reliably make use of it -- those with a single output,
and from higher-level folders that set up the masks.
Prepare for conversion of each folder in turn.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 6757fe0036..2aa57afd64 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1048,6 +1048,12 @@ static bool fold_masks(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask = ctx->z_mask;
     uint64_t s_mask = ctx->s_mask;
+    const TCGOpDef *def = &tcg_op_defs[op->opc];
+    TCGTemp *ts;
+    TempOptInfo *ti;
+
+    /* Only single-output opcodes are supported here. */
+    tcg_debug_assert(def->nb_oargs == 1);
 
     /*
      * 32-bit ops generate 32-bit results, which for the purpose of
@@ -1059,14 +1065,19 @@ static bool fold_masks(OptContext *ctx, TCGOp *op)
     if (ctx->type == TCG_TYPE_I32) {
         z_mask = (int32_t)z_mask;
         s_mask |= MAKE_64BIT_MASK(32, 32);
-        ctx->z_mask = z_mask;
-        ctx->s_mask = s_mask;
     }
 
     if (z_mask == 0) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], 0);
     }
-    return false;
+
+    ts = arg_temp(op->args[0]);
+    reset_ts(ctx, ts);
+
+    ti = ts_info(ts);
+    ti->z_mask = z_mask;
+    ti->s_mask = s_mask;
+    return true;
 }
 
 /*
-- 
2.43.0


