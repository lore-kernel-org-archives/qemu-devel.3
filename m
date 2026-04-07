Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F6DFB5183
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9wB2-0007k5-7E; Mon, 06 Apr 2026 22:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAs-0007gw-SK
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:18 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAp-00071s-2U
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:18 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b23f90f53aso41001585ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 19:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775528892; x=1776133692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bkkWjXX1NFf1Ce9oy2vn5af40ysgrY5koOcHNtjg0zY=;
 b=qvHSgIfWdOePf3B0XRDuqc8f0ynBhtrF4ij4lIQ4+R7qtG9yymcaJmRStWmG16nHAo
 QAsPeAdwffZY+zBlxz2yvTEUyoD8mC97PU7p9FSYGyb9fJz+NQ0D36TjkEd4HjlrGo3L
 AHFFqY/QOzyRwNAR/RM+3s1WqbC5lBw0CU8PTidUk9D0R+qVl1wvgSCvMT1P8VrQwj//
 EcdHDNC4XV8QH0d2LIk2rGRizpQjaeR5Y7hDUfhpkqYunmx1AEXaAbd/vmp3vx4zyOIi
 CIIcWN2YCYhpzrFIZ2Jr+cDvHOhrcVSLWN3Zq9/98aPfQYXyhu5xPpiX5Zc/SOJ7puKs
 zfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775528892; x=1776133692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bkkWjXX1NFf1Ce9oy2vn5af40ysgrY5koOcHNtjg0zY=;
 b=ixRJQ1oNV2ZdhcU4gWVS9FP5PjcTIcksxC0TP0izQMiKfo94uMgdXGkQAw6Nqc6rYx
 RbL1rd/oRui4RmrMRMxRSKA3z+e+PyXyVUF1lHfXBQpn+Mv64mrMyhgSNtrF8/VykfmJ
 2EfE+LngxWTSzEF6XbQFxuvM3Ae1VpXVUcbksBpul687hO53/lGipEKde7r1/jCI3/Ky
 gdoizmJ6IaD9dRpDCOJCBJSmUscYdjJa8tPnKJAA228uY/USeT5CaWy1FBLRQR4D6p6u
 5YbgFUMcLw0AWaLLOIC+eTrNcyibmEdSyxLiwkqOElbYsPSZutK63Ug6Hsp9WZXodNVj
 x3NQ==
X-Gm-Message-State: AOJu0YyIOLB0JfuY1MsbcKRQDTRscsUmoG8mYrMKu4sBBQ8LgHl5bmsp
 8jIJ8VQvmSRJWLnrAT8wNVLju7FdXcMcD9kL1gdQAe1u0sSE3eOOqIfT52hilEQwqOezmritZsT
 L8o4bpuP1BA==
X-Gm-Gg: AeBDieu6znYlw+lgTfLDrDd1M3n5CUP3hXatwdx/+RcGMGqxha0XeCJPDsGNsc9/3w9
 kf/MNWJx3+8mDb48/eKmQ7Pe5JSzUhIJNgV0Bp+/KWXfSrPRID847Y6u9+gP5VQOo+ulvPF8DeM
 OhwJtr0MgiVcWk1pATaVzsvAttyC8BjTl0R1dUW7fKBdYSu/vHr2m/OxBKwpdC4HuGvHY97ypCH
 5Sm5kUQ+DYyb64SNscuNPiXpAvi8sLKJAlyOCqrZB9CMAD2y2mWhcQJhw2y/W+uNbqDZUw9n9ks
 MfpjNu93R78LYJ2Ll39bwE3xFFTWsmc8PandPEOY7zZsQNpZKTEnPWc1iKYz1fszY2X4Zaa3AYk
 GLsO8Ix9GNYBzj+rF1hcRnuYrOzZXxEJaFHuQDB/qkymVvb1fnNiXUyHVLKeBHqubW2rjmiMttH
 9RBL/VhJc0+wOQEB02FnhNETI6rkcXZrScnen85cZKiIBuLW1WNfEHqi0QCLF6o5uS4cASe1MZN
 npF
X-Received: by 2002:a17:903:3903:b0:2b0:643b:41c9 with SMTP id
 d9443c01a7336-2b28167325fmr168230265ad.9.1775528891927; 
 Mon, 06 Apr 2026 19:28:11 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749794e8sm161423685ad.53.2026.04.06.19.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 19:28:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
Subject: [PATCH v9 19/20] target/arm/tcg/translate.c: remove target_ulong
Date: Mon,  6 Apr 2026 19:27:47 -0700
Message-ID: <20260407022748.57629-20-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

We can replace it with uint32_t, because we know it's limited to 32-bit
target.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 5b6a80930af..ee3407fbd7f 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6281,7 +6281,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 
 /* Ditto, for a halfword (Thumb) instruction */
 static uint16_t arm_lduw_code(CPUARMState *env, DisasContextBase* s,
-                              target_ulong addr, bool sctlr_b)
+                              uint32_t addr, bool sctlr_b)
 {
     MemOp end = MO_LE;
     if (sctlr_b) {
@@ -6528,7 +6528,7 @@ static void arm_post_translate_insn(DisasContext *dc)
 
 /* Load an instruction and return it in the standard little-endian order */
 static uint32_t arm_ldl_code(CPUARMState *env, DisasContextBase *s,
-                             target_ulong addr, bool sctlr_b)
+                             uint32_t addr, bool sctlr_b)
 {
     return translator_ldl_end(env, s, addr, sctlr_b ? MO_BE : MO_LE);
 }
-- 
2.47.3


