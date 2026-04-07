Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0479FFB5181
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9wAz-0007j7-2f; Mon, 06 Apr 2026 22:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAr-0007eU-A4
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:17 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAn-00071b-5H
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:16 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b258576d8cso28601765ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 19:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775528891; x=1776133691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R5wUMeUC70TmuX0cGGi9R36EmECJwVrRpC4SX+WBHac=;
 b=Kwglm87B85KfK4w56rWkfyc5z/rG3n7QB1ui2USVvp6XF8ckr4sQXaUVnx040+7p9w
 jJs4j1AD7/2OoFuyIe2YOJf9awpKphlI7fX1sNO5FA/W2VCdpJB63CscsqVKzzar8u72
 H/C7Z1nBnBQUuHXKJB2STGGmYajGuJI7nUJeJCX7Dq6E780G8+IGN/Jzt4/+IvXpAzjv
 Ec8i2svRX0iMtr3sQz3pJ4k+6F3kM6lPefgDL72qSSAl0Gnk4VrtV2KqiUhYN+43ogzO
 6OHJ4HY9HrNTMNQOBMxZwtb3Tv/bspFl622u/mstVhNFIDyeT4mscCTGitLpPg6S3FJM
 QtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775528891; x=1776133691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R5wUMeUC70TmuX0cGGi9R36EmECJwVrRpC4SX+WBHac=;
 b=n+GdTTTI3TqFuE4Ot9ZF5jmhtkfzEpXS1c/0X5JU+0eTghe/tYgNl2TqZNUyrbHBcE
 luekKfddnqomwkoGDiVHGXdQPSXcA4qKqixJbmr+43otxLq9PTI8yErJDWjgpr+kRpj0
 ifNCujEOPNsRDceL4NJyuza65KiZ0eTWugIK3BeUp4haTvZW0AhHjMRf5k8ku5MBxrGz
 1eyt66LCP60cuj+Kcoe4KmQZTCqBKRGH7gg8F8IfuLC4hWppT+PL48R0cfAiqqNNYSSW
 SoOLZBK8btS9ityfnJGv0u16OP/27R5fkkn29tI+m+me7iT9bfkPwxjiBqBboixJwUQs
 hf3g==
X-Gm-Message-State: AOJu0YwNGzqW019TANcudV4Lsom+V6gzIEhKbZTB4S1hZXB2/EJ9zPmv
 duDRgHodTlkqKBuX6LHffeyEcPdJSa6mOu4gSyGOdujWeGucPxwHR49kjWs3hvqCXkxvrB2oZmb
 JaVimAKMWoQ==
X-Gm-Gg: AeBDieuJXei6iNfsIbqF0Xjs7ipKx4ir0g9UHn7E2Grk60O+2FgTQV0nOt9L0YnXJE1
 xbeBVSrbNx+Lf6yrYHPJ/sTSYnXUfezuNODIX1Q5qhE2G3DAGeNSi3P1VoGOib6KCa82dsndpri
 OM3+3opTlmXoYS03iSRLB3TNSUkq1faYQdncRu34NF8eoMu4a+a2oUIi5Ey6h4YYpEqJZFtai3e
 BhI8TcQdQZUIxVuoqK3dHG5FJ0hPLBQbxCflvIONHPQ/q5NQmGeKlnsHgQkOHSPqzw3yhT83OTF
 6Aj4ZtQ/J3FPCGQS3/+RJZLF0K7RcaRy6OtOHRQfZxLuORLWLCx/na/yfvsxCRo0HpO9/AQfu92
 ozuTYVgtx3uea2oH0s208qNWy3ctvx+TdhlMhMishzdEUQhpNEPTHX57iuBn/whJWKWakeENgpP
 Iy+E05DkcUkao4cG0O7TIS6Dvx/7xyyG4mahsGWfgo3IF9eANx02gLLojWjIC+8niWcHLQox3Ox
 MSe
X-Received: by 2002:a17:903:32cd:b0:2b0:41bf:ca83 with SMTP id
 d9443c01a7336-2b2818b40b8mr153387035ad.23.1775528891195; 
 Mon, 06 Apr 2026 19:28:11 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749794e8sm161423685ad.53.2026.04.06.19.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 19:28:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
Subject: [PATCH v9 18/20] target/arm/tcg/translate.c: replace
 translator_ldl_swap with translator_ldl_end
Date: Mon,  6 Apr 2026 19:27:46 -0700
Message-ID: <20260407022748.57629-19-pierrick.bouvier@linaro.org>
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c           |  6 +-----
 target/arm/tcg/translate.c | 11 +++++------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ccc47c8a9ad..b62de8addff 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -828,15 +828,11 @@ static void arm_disas_set_info(const CPUState *cpu, disassemble_info *info)
     }
 
     info->endian = BFD_ENDIAN_LITTLE;
-    if (bswap_code(sctlr_b)) {
-        info->endian = target_big_endian() ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
-    }
     info->flags &= ~INSN_ARM_BE32;
-#ifndef CONFIG_USER_ONLY
     if (sctlr_b) {
+        info->endian |= BFD_ENDIAN_BIG;
         info->flags |= INSN_ARM_BE32;
     }
-#endif
 }
 
 static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 1fbe41ec643..5b6a80930af 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6283,14 +6283,13 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 static uint16_t arm_lduw_code(CPUARMState *env, DisasContextBase* s,
                               target_ulong addr, bool sctlr_b)
 {
-#ifndef CONFIG_USER_ONLY
-    /* In big-endian (BE32) mode, adjacent Thumb instructions have been swapped
-       within each word.  Undo that now.  */
+    MemOp end = MO_LE;
     if (sctlr_b) {
+        /* In BE32 mode, adjacent Thumb instructions are swapped. */
         addr ^= 2;
+        end = MO_BE;
     }
-#endif
-    return translator_lduw_swap(env, s, addr, bswap_code(sctlr_b));
+    return translator_lduw_end(env, s, addr, end);
 }
 
 static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
@@ -6531,7 +6530,7 @@ static void arm_post_translate_insn(DisasContext *dc)
 static uint32_t arm_ldl_code(CPUARMState *env, DisasContextBase *s,
                              target_ulong addr, bool sctlr_b)
 {
-    return translator_ldl_swap(env, s, addr, bswap_code(sctlr_b));
+    return translator_ldl_end(env, s, addr, sctlr_b ? MO_BE : MO_LE);
 }
 
 static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
-- 
2.47.3


