Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FE4CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 20:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3rM-0005ch-RM; Fri, 29 May 2026 16:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wT3rJ-0005bd-3H
 for qemu-devel@nongnu.org; Fri, 29 May 2026 16:31:09 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wT3rH-0007gv-FU
 for qemu-devel@nongnu.org; Fri, 29 May 2026 16:31:08 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-842273a2c4dso124745b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 13:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780086666; x=1780691466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Ty6h0d35x4g+W1Vc5lJ0weoc9xaWAtRx0HaQeYSiqo=;
 b=aHnMzJNrFenzhFsQW9IqT+68XV1dQOtr4n71ZUaMzQxZqtna+UIUvY19vF9REdpfu2
 0q3g6AwhgbvYCbn/LZkWFkZQJbio0hLwWP7wGd9l8chPtfmhkXfKhP4iKrhBxbi8BVxT
 NAbxToEGUWF5DUp8ENjoZthgZygUZv3dr6ZdgubNdcTsV2QDZ2IPfFWcv/Q3riGHGGoh
 cBdsJ+8x+8fu6E4nuxwKy6hgUX2MpHEUq8UZhNx/eOASfaAxQW7l8w7JFuObxBP9WjQl
 4jnPSP78XW+DqM59lId9643FXWBDF8apdial4ppqvklNU8QzRrFIsw9SP5is1iSyOEjB
 GiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780086666; x=1780691466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5Ty6h0d35x4g+W1Vc5lJ0weoc9xaWAtRx0HaQeYSiqo=;
 b=R7KMnsk1XVehSDVIvI0HJgpm8BRN/UkzHjoDa+K732TILhBkB76zEp+FxWw5VNxWUh
 rvWPsBP+w2+N6qcQiR1zYuJ3U/uWEDgqXIJfOSKA+vrxXc82+sDetdwrdmmxejqUpybk
 d7c2zmCTtgD8wC2EMsSVSKhUrgj4SffH95TWvfwxaGBKG/OxKKlrg8ekPxV3kkqRBIbd
 i2p5n6J2sqjQLu14/pxT8vpQex6wyjtnkDMOXPc0C5V/DStt0k/Z32hbFQcSqT+apGG2
 42Dn1Ns+77AWdo2SqR8jsQf/qT6goWqghVOhFKahen45YqjrdkgzRiDz8I6hTI5uFxFV
 sdqw==
X-Gm-Message-State: AOJu0YwRD7X0vrUXgPwswtvftRS5WnPd8fnavttN8hzRpvKur9vlZZ7l
 AVoNC8CkVa8PS5UBkazBYnPrxLMDpv+OzjdoSruXUxzEkiK3xChkweRguAqd5LFbXby1/GwJc4f
 RMYB+4y8=
X-Gm-Gg: Acq92OFf1DL6h2ytrHUh23lC3Z2rwehl5XZ8CLtKMmRQKTl1AEE9yPUduDoVoWp57xD
 A6Q9CgNv/2/8ySIpC+u0sOxa9FterScvQovtoZ8aZdBxxq1pyNBF6+laumRmJwTWKkVDN1eloeM
 +rZDxXH0Jqj8LExRqWCpHDFxxN39q4DqAG8xecEl12kdPuuselrsGfJ6kNYlYWR/F00mQTMrxi6
 BIUR6W0E1ryLNJ7DK8f35Cz/op+swsvDlRApvOfCXQaqxs58jQQj7w/32M2qg/2aW6gmnRl09Ik
 W6IJ+R7zRF1F8Vh0ClMUG2nPO+tIbBhZxQDs7mAPD0tuqHZNkM8iIY4coZK/e8ke08Rm6HIojg4
 YHc5hgEx3nnnMuCczNk1e207giKTul4uAL4LQXbSF8Gd3mkzfpiPcTSzMfSj6MT6y0PcENIL1zb
 2G2G2caul3isSea/NRdO1deCUDLxoHgy6lQoO3o4Q=
X-Received: by 2002:a05:6a00:32cb:b0:83e:c8f8:cec7 with SMTP id
 d2e1a72fcca58-84225492890mr1101900b3a.35.1780086665755; 
 Fri, 29 May 2026 13:31:05 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214b02365sm2720237b3a.8.2026.05.29.13.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 13:31:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/3] tcg: Optimize INDEX_op_mul[us]2 for 0 and 1
Date: Fri, 29 May 2026 13:31:01 -0700
Message-ID: <20260529203101.290947-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529203101.290947-1-richard.henderson@linaro.org>
References: <20260529203101.290947-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Zero operands produce a zero high and low product. One operands produce
a copy of the other operand and a zero or sign extension in the high
half.

Fold those cases during TCG optimization so wide-multiply idioms used by
target translators can collapse before code generation.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260520125139.13352-3-philmd@linaro.org>
---
 tcg/optimize.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index ef5eb2cf17..fcdef25bee 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2212,6 +2212,34 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
             tcg_opt_gen_movi(ctx, op2, rh, h);
             return true;
         }
+
+        if (b == 0) {
+            op2 = opt_insert_before(ctx, op, 0, 2);
+            tcg_opt_gen_movi(ctx, op2, rl, 0);
+            tcg_opt_gen_movi(ctx, op, rh, 0);
+            return true;
+        }
+        if (b == 1) {
+            op2 = opt_insert_before(ctx, op, 0, 2);
+            tcg_opt_gen_mov(ctx, op2, rl, op->args[2]);
+
+            switch (op->opc) {
+            case INDEX_op_mulu2:
+                tcg_opt_gen_movi(ctx, op, rh, 0);
+                break;
+            case INDEX_op_muls2:
+                op->opc = INDEX_op_sar;
+                op->args[0] = rh;
+                op->args[1] = rl;
+                op->args[2] =
+                    arg_new_constant(ctx, tcg_type_size(ctx->type) * 8 - 1);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+
+            return true;
+        }
     }
     return finish_folding(ctx, op);
 }
-- 
2.43.0


