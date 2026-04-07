Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1B0FF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 20:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wACaa-0004Pz-M2; Tue, 07 Apr 2026 15:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaW-0004G2-EZ
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:52 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaU-0007Qq-Tn
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:52 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-35c206f0481so5232708a91.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775591989; x=1776196789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HCYVORL8twjNtHEKHl2JRzrVw/Xl9zax7Xk6iBP1jLc=;
 b=RMliDFAI3A4ky+IsrLyCzt+AsOsDdtbfpUqakZhGKd4ZXofg8otUe8pXBlwm64wx7x
 pb9G+cSaZBVUUiepNzuBPw2LBEJ6tl2lWMdM6O96621x9u+lHzYWC2dr+joIqNVh9c/X
 2jgRVQaRzBvTtpAA9kRpwYeeDirY0m6D5zuseQsHAfVUvXzjOPusbRyYzdISskHm5h57
 p8fq64oSA1gCZdM4Qb8k5peYjx/M3YjE9s4Te2xxbtPvmuxB3g4gAXN5f8L9tcck0UO2
 tprn4WAKbPnIQNqCJ/gfv68KfhGFsy/q986ltbpkNPmvzvI/0sjE9BBoa02UBIzIZYIt
 2tZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591989; x=1776196789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HCYVORL8twjNtHEKHl2JRzrVw/Xl9zax7Xk6iBP1jLc=;
 b=CcOvK1vT8WAbq8hFHnYCD0n0fWCh4cDOyhgExtOFIqKrVqAnyyr9Td/ExwYad5yIBu
 5uysB3gLvMQoHLlbucs7sSORrLHz2b7uusQ+bwLLgIwWcR4VEaLJvDgFStfGOTpA2pny
 Om9hUVuIRJN/z3RQbhY1nEo3EzjmTWsin/RRRKM2SbZGuELdVL0rQjLyISMWSCCD70pl
 lRh5CeSWWkWEeBbYjSxzioRq3OduUbhDbNbAfHjNcKd4W7uxRNyKg3CfOflh9h3UDByX
 7J8SDZTwo/IYR/oG8EzM1SRxAduGJdj8V3fM51zPgtxbQq+xNUzUg7mSFK+JaGLLySaz
 e7aQ==
X-Gm-Message-State: AOJu0YwzAkJw+0rPZyizSpR9PzFcT6mxk/DAV3gUsoL1tT6jT6/++0xC
 14N4mtiQT1i8D8NaZrbjjdbtysIKsbcqA9YJ5LWj0A0Dd8xqlOo5CMqaj8w2/vewBHNAIcq0Ds9
 4AvnUb8o=
X-Gm-Gg: AeBDies01KZjJMv5FRpkNhOXIOlUXWPlC0tNVaajeOg+lGqy06uvtGQ1IP4MoxS4QSE
 EqIsk5vD8QuRHjDQ66m2h/qdOUVzXUORDPEeQtwYuc54DMvH7MfAySzbomb5qCjBDcaJfxcsTFq
 dgC3sfJNq+MLGUPBWqPE7DaUXibn5hEYVF29rqDQzerZHsvNNqv1Tatn7RLodtv610MT7r1PQh8
 gBUC94rwar77Bj2A4UJjAeCKLmtBRwuvYNL9jq3lFP/JG8/iytCNZPN4tczko9wttYcxUnRD4Kx
 jjjlsxYxQtxg7sgsCG3iOp4ize7GWk4SRC5ZBsrCtXnzMd8UKTkDlo8cRl24rRwAMKj9r9jn3YI
 ts2XqIp3EdVbHD8wNd51R5D1Yfzh92btVhFyEjgkzwEI6+0LSbr8UQChbbBY6MnWm0CCYMZPzQa
 vGNusAwoy7sVN9e7dREt5BOX9B3RJF9W4H8olHOlvH93WE3vGY8i9lUZiKAt8U+kAvEDcxpX730
 AQv
X-Received: by 2002:a17:90b:3dcb:b0:35b:e671:a527 with SMTP id
 98e67ed59e1d1-35de679fc26mr17950444a91.3.1775591989559; 
 Tue, 07 Apr 2026 12:59:49 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e27c9855csm126911a91.3.2026.04.07.12.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:59:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v10 20/21] target/arm/tcg/translate.c: remove target_ulong
Date: Tue,  7 Apr 2026 12:59:21 -0700
Message-ID: <20260407195922.196410-21-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

We can replace it with uint32_t, because we know it's limited to 32-bit
target.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index c432de2a268..ce427c5a3ca 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6282,7 +6282,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 
 /* Ditto, for a halfword (Thumb) instruction */
 static uint16_t arm_lduw_code(CPUARMState *env, DisasContextBase* s,
-                              target_ulong addr, bool sctlr_b)
+                              uint32_t addr, bool sctlr_b)
 {
     MemOp end = MO_LE;
     if (sctlr_b) {
@@ -6529,7 +6529,7 @@ static void arm_post_translate_insn(DisasContext *dc)
 
 /* Load an instruction and return it in the standard little-endian order */
 static uint32_t arm_ldl_code(CPUARMState *env, DisasContextBase *s,
-                             target_ulong addr, bool sctlr_b)
+                             uint32_t addr, bool sctlr_b)
 {
     return translator_ldl_end(env, s, addr, sctlr_b ? MO_BE : MO_LE);
 }
-- 
2.47.3


