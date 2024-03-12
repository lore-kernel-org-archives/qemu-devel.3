Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77177C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3Hn-0003ZT-GN; Tue, 12 Mar 2024 10:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3HY-0003Wr-2P
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:08 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3HE-0007ik-Hs
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:02 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-29bb3d62949so2882512a91.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710254326; x=1710859126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RnJQyEnXrtZcjBCHyJq+5yv9WO+0xDyYir75PeP3MhY=;
 b=kATDgmQmhJ+Ob75w7trJZRHt1FX2uoW08aQ7rPUJuhsowzunuksXXI8COqL7KFa5q9
 BBMCppjRk6pCRdeycPIBdm21hLl1qCS0rRi1vF8Gw1nVIJJjl6OhqjTsdqtgvBrZFXRx
 xcKyHq0BsU7BA7Qzie4T3H4VImzr6y0DboHps57edol7okikFC1DTNp7scKYLrE5XZFv
 ilzWIN84J1ZpBW3gaMyJItg8xUP2WMv+HbLeeUVkoSJp1tpzG5Feel3NfQSGR1oGMmYB
 oTIwB2WIiSnV4wWF1iGw3ynrHgC0WK/4+NR8EK2OcHIMj56kkgDbtSPbUcTrSdkvyJON
 4p3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710254326; x=1710859126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RnJQyEnXrtZcjBCHyJq+5yv9WO+0xDyYir75PeP3MhY=;
 b=bnvxQpTdBAjd1Fb+epOctBSGskOSC1rzgzToYAsq+mpNRuShxeunHNtR5qRSWEz0oY
 3cxLUbi1L4khgdAKnG8Qypg09jJPMkQTq3nb5qE0vUnsavdm/WxB0MlzK3SbBDt61hvq
 83IL/Dcq1DXQnqpfa4lMTT5/Rdlvqf32oPuro/F8WpTOe8wrgb3h/4+a2oHOYmRJyId7
 HgWUeB30+HODGzwn1+zBMbqUo0GqvAeNHZFpGli8k218ml1mq0btBmhz029qo4E2HZig
 b7et40TY+PFTNlv9owvOw4qHJGmU1eNj41xM8pJbbR5pKa3Fl4P4AY4iHyFUujpunJG2
 aQBw==
X-Gm-Message-State: AOJu0YwAKCg0Xcz3NlzRo/iPTY7BoWstzpkPRFX/hkCEFIP8MnyeX7EI
 NhxiaXgmIoMJ3JPIPNlHcdKSZDDjTSVuyvA2PY/PLSSw4DtERjaHzwCA+sEXReDoqtO/o1blrCW
 s
X-Google-Smtp-Source: AGHT+IHKhVf+TXwzt/cKB0dC0VBh7J2msvqV1qn10M5SoKWsCQIs3Vd5NkaqFfOnjyjiHijls1gydA==
X-Received: by 2002:a17:90a:fb57:b0:29b:af8d:3264 with SMTP id
 iq23-20020a17090afb5700b0029baf8d3264mr1933099pjb.37.1710254326258; 
 Tue, 12 Mar 2024 07:38:46 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 jx15-20020a17090b46cf00b0029baa0b1a6csm7492214pjb.24.2024.03.12.07.38.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:38:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/15] tcg/optimize: Fold orc with immediate to or
Date: Tue, 12 Mar 2024 04:38:26 -1000
Message-Id: <20240312143839.136408-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312143839.136408-1-richard.henderson@linaro.org>
References: <20240312143839.136408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 2ec52df368..5729433548 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2065,6 +2065,15 @@ static bool fold_orc(OptContext *ctx, TCGOp *op)
         return true;
     }
 
+    /* Fold orc r,x,i to or r,x,~i. */
+    if (arg_is_const(op->args[2])) {
+        uint64_t val = ~arg_info(op->args[2])->val;
+
+        op->opc = (ctx->type == TCG_TYPE_I32
+                   ? INDEX_op_or_i32 : INDEX_op_or_i64);
+        op->args[2] = arg_new_constant(ctx, val);
+    }
+
     ctx->s_mask = arg_info(op->args[1])->s_mask
                 & arg_info(op->args[2])->s_mask;
     return false;
-- 
2.34.1


