Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F10AD232E1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56k-0004Ou-MT; Fri, 09 Jan 2026 00:32:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56h-0004Lc-82
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:19 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56f-0003iV-P0
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:18 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-34f634dbfd6so2546927a91.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936736; x=1768541536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rJOkRX+4T7jmjk7vaeQ0w74UJttGKxCXyDvy2p6FgUc=;
 b=WXU2BBfVzbW+CkqJxkIBU9ZbQY5mAMLZWJkgn7PMpwXCnXTcq5wyyotRJTBETYfbcY
 hKxbJBRYHE+dy7LGcrPwrLP4f9e1BctatnKhmsVEpI5v/oKcur0BTd5yCEd8mZfpuaZY
 zQJVBq8E2q1rgDTS4WdpOV2Ig3STVSF9poUjyBvnyFmfGoW1NhZkJk6cl9HbHCdYYHrE
 ow5H+TOMMeIXw92BvCP/7T8jJL2B+ZKP2ygsFZZd1vwE2vEyDFbmJGNnGaxb1jKvsSz/
 vDs439eP5hcKme5AHMCDSrGOISLsY54TI4BKb71eFLWhudJr6RmaFekRc9uUZW43yrl4
 Figg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936736; x=1768541536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rJOkRX+4T7jmjk7vaeQ0w74UJttGKxCXyDvy2p6FgUc=;
 b=q/pcqCTXRybRrpboLPL5wvK+t3Et31qry5i0HXGOvivVxm4sT9o/p9LgWSTG77inoM
 lTSM+BDqzJdKEQxtqi4iHq5qptAnJpFrXzrz3bnjvPbeRFJfPSg4UZgfLCLfrKVexka4
 vzscXOVo6WL1yifJjZC9s64Hc8uGEC6MbB6BfLnZs+M4tVQF2NKym8ER40JG5TZs49Uo
 dV2RefIul9tB+bNvIb43U1oxhBXO+HkA+DT86NnpjvEV4vGFGz9DLdDMmiwRw3Dtwie1
 tiG4wnnfBFm3W9jTY8NAXrmzucFsBauNkH8ngk43WvktcQH765P2A3qVQ0Zz9I7RjFbD
 mmEg==
X-Gm-Message-State: AOJu0YxT2VBieX1hZBqx27EpTpStJJ/gRhCgEypUmxR4PVZnmc2Ysedx
 9H4Q7B23krYTwWhnr0731lYYUIvSnyyNBKGrjFm2DrvVQdaej2fiVP+bze0pvI6bG6U3RZsZCUj
 nKvDQ
X-Gm-Gg: AY/fxX6Aqssq9GJI/Y871ZspcRijXI3GBXso9TCpkVE76sTKl6Dokgxo+/6/bmDZdqg
 Qy2xyZGbhgBpFH1mBBoKiImTFNIqSDWhNgP/pGKrJ9Gf1dvQuLbNKTuanM2BOfZDuN0jt0Ekgog
 2XVIgjXXQbtHRkYeznDHm6c1mRe5VMq5WN+WNjuraHOpdiBdHBYHKHDZwdKv+nz9MuZA12TDuph
 BMprFf1DVm+4AdlHVmeUqikpZCy1F7ALzio19P2aytyoZM0rghkKkU/eQtfZtLvq2K6mDXOCHe2
 Hpkh1xoJ/cALYPXIg3dAEv2m0999EddlZK2vTNhHkYelkf/TSoUtWCvRDrwsIwNdFFmxSmrmlQf
 w6OxQV16MR47Z68amod15uqp6FZxzV/RFzAfQUeZzUNGf4uHMvhAB0JrhMyGoRWZRZRyNyCdVuI
 NXh4W+LNCJ6P3UBxr8IEAoju/iRD0rp/HERk0+l2sAtkRMODtPJ0bcN+GbevpgXQyJ
X-Google-Smtp-Source: AGHT+IH8egQx4NvxPG2wLMuN7gFAOddMiZYMaWnxOshum3mwZkUv2JXrR9TITVZpjnnfCfGZKdIvnw==
X-Received: by 2002:a17:90b:1c07:b0:34a:48ff:694 with SMTP id
 98e67ed59e1d1-34f68cd7668mr8044020a91.31.1767936736220; 
 Thu, 08 Jan 2026 21:32:16 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:15 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 12/29] include/tcg/tcg-op.h: replace target_ulong with uint64_t
Date: Thu,  8 Jan 2026 21:31:41 -0800
Message-ID: <20260109053158.2800705-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/tcg/tcg-op.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 232733cb718..f3fe2d9386a 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -29,7 +29,7 @@
 #endif
 
 #if TARGET_INSN_START_EXTRA_WORDS == 0
-static inline void tcg_gen_insn_start(target_ulong pc)
+static inline void tcg_gen_insn_start(uint64_t pc)
 {
     TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
                             INSN_START_WORDS * 64 / TCG_TARGET_REG_BITS);
@@ -38,7 +38,7 @@ static inline void tcg_gen_insn_start(target_ulong pc)
     tcg_set_insn_start_param(op, 2, 0);
 }
 #elif TARGET_INSN_START_EXTRA_WORDS == 1
-static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1)
+static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1)
 {
     TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
                             INSN_START_WORDS * 64 / TCG_TARGET_REG_BITS);
@@ -47,8 +47,8 @@ static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1)
     tcg_set_insn_start_param(op, 2, 0);
 }
 #elif TARGET_INSN_START_EXTRA_WORDS == 2
-static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1,
-                                      target_ulong a2)
+static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1,
+                                      uint64_t a2)
 {
     TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
                             INSN_START_WORDS * 64 / TCG_TARGET_REG_BITS);
-- 
2.47.3


