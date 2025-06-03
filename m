Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1549EC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMkf-0000Nl-Un; Tue, 03 Jun 2025 04:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMkb-0008Q2-Vv
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:12:02 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMkX-0005vF-T5
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:12:01 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a374f727dbso4591811f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938316; x=1749543116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5tIbiNLH/Zb4M+vkarpmZzOW22aZ3EjbIGp7vOL8+9k=;
 b=p+v9+savRPZcej+Tt/mOxGm9ZqxQ9Q4uUzY/r3HkM1kqqDC1VNv5pzoH1ezc9YvFYR
 9cg6r0dzvudiQLICbobNCKUeYWiZJ3q3y8yHxbHJX5IWRxDQ7Eo8rxth97Z3i7Qibuv+
 oXHOfT4S/JYCZ6WFyX0PWcBJB+37SdI30aOaXRQLZDb+WMLluR5nQIW6y1lfWNwJiBkW
 n1E0DHDjgfrwH7diq6E3JMOukGTkVIYT+lbNu/xZN0b1dYctuK8NnsUuyoQTgr30ENia
 sjwokB1bZh306hUnlSN7L57ZZwN0WZxt3B1ca0Val0fCfIRYP9k1baKBQUd4UTqhajFD
 8zDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938316; x=1749543116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5tIbiNLH/Zb4M+vkarpmZzOW22aZ3EjbIGp7vOL8+9k=;
 b=oqqFi8wJVgoYPLFGGp8lJwgYTUx6Gz1hSdxxlQW/I0GN9RqmKO7Nog1UUqxtVy92ti
 sDGybpuHojYcUV9x5vaFU1K7do087KQx3Lq4hOgfpq5Jm3+fWo3LGDlzh9pgXNVZwBts
 y7JrTmQo7FJoNZgu2l81PFn2R1oCJaACizKPTY0i+pdjHDTZ31qIkykpd1xjgL5/w16E
 LOkQglySH4+3k2SSEQbcWOCex+cbEsPdxfgyBO04Y6HVtqVyy1U9hcx1JAQ6de9B3pP7
 wxTx1G3/3y+eF+4pOXBK5pSnfx0Yh7gWTT2usoi0PJx/EjlNxqNTVabWHxZZTN0+/Rjc
 Zf6w==
X-Gm-Message-State: AOJu0Yx+/wPODxk7+emOlSaPwpSutycHPN9sD2hF3ryGr+zIABsWQsJf
 HxyIFg4fzDeoGsFwB0Dbsz2DOdnT3BvOXB6yLarePjBr/uR3ReQjVRUSW8K9rDwoD8I3cb/egL6
 jQMaRfjc=
X-Gm-Gg: ASbGncsJiyYPooHTjtKDZitXXx4xrhXg/8xoCrCxlIv98KCIQdt/D6CHxV0lBc2+7H4
 qvWQ9Kb4VjTn7s83UYVZtlvi8akusTrBb8DBbRkvTGdpuFvQOvnEnzdOfZ9B+BPIz+fAv32uhix
 RztCUg0nRyZuVmBZIPhX0O3p8bCRLrrWtoof0Q4QTjewArJrUfTnZB6hkHgd2LFra96AgRjjzcR
 YnZSQEvy0IVeJr1dTN4VlFlikQfc7bGRrSCGI63pn9mLHhOZ7o8/lNVZTzsceANPWXjGekvJeuo
 d5fbtJI/e7P1IbIfLDGN4sed/0faDLuJ7kb/3x2leyj+Bwpt2OvreE0Fc6oUKaabXMmPGwVKHOs
 2TsLN6Y8Ts1vb0CIrDZOjjJg=
X-Google-Smtp-Source: AGHT+IEGcoyA6UBxYVQEVktmhQm/nmrGFLUErkbfh6vLzBqDGUIWfh5MgRIoi4fG1qr5wowsztUlyA==
X-Received: by 2002:a5d:4082:0:b0:3a4:f8fa:8a3a with SMTP id
 ffacd0b85a97d-3a4f8fa8a6bmr10018522f8f.18.1748938315798; 
 Tue, 03 Jun 2025 01:11:55 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:11:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 26/27] tcg/optimize: Simplify fold_orc constant checks
Date: Tue,  3 Jun 2025 09:09:07 +0100
Message-ID: <20250603080908.559594-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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

If operand 2 is constant, then the computation of z_mask and a_mask
will produce the same results as the explicit check via fold_xi_to_i.
Shift the calls of fold_xx_to_i and fold_ix_to_not down below the
i2->is_const check.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 8d14a38f9d..a48ddd9171 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2326,10 +2326,7 @@ static bool fold_orc(OptContext *ctx, TCGOp *op)
     uint64_t z_mask, o_mask, s_mask, a_mask;
     TempOptInfo *t1, *t2;
 
-    if (fold_const2(ctx, op) ||
-        fold_xx_to_i(ctx, op, -1) ||
-        fold_xi_to_x(ctx, op, -1) ||
-        fold_ix_to_not(ctx, op, 0)) {
+    if (fold_const2(ctx, op)) {
         return true;
     }
 
@@ -2352,7 +2349,10 @@ static bool fold_orc(OptContext *ctx, TCGOp *op)
         op->args[2] = arg_new_constant(ctx, ~ti_const_val(t2));
         return fold_or(ctx, op);
     }
-
+    if (fold_xx_to_i(ctx, op, -1) ||
+        fold_ix_to_not(ctx, op, 0)) {
+        return true;
+    }
     t1 = arg_info(op->args[1]);
 
     z_mask = t1->z_mask | ~t2->o_mask;
-- 
2.43.0


