Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCA8F99367
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFquX-0007Jc-VE; Thu, 23 Apr 2026 06:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtl-0006TM-3p
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:08 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqti-0002A4-O6
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:04 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso27207945e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938581; x=1777543381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w3VRC35u2ZWmI/ezGiXA6Xy2yCIZZPWUICWMZvJnfBw=;
 b=sI0FHZsJT732pd6goc/N39LdyMr8Oy6ka+nutgna2ATd2IKH3anjw+T93ild72T6hx
 2ex1+/Dnsu/RoE1gnFM3lCDfzKTN9A6yrbndj6P/yRnm6ryHvuiYw4q18CBYiSXMpZ0l
 Hmu3BzWD/XfYnLyOkenzTi3NmdsgB/7/WMO6UhbM11wjDEq58R4TX5HUjih1uJwGdA1T
 xEow9r4GtBHc8im5qFhHJiVNOS5XSk3kcVEg43zPxi79rKATel2L1fSj2xUx45KBPqRK
 tVfpicmFiMdcuZrC5MT1/sOzdwqIQ6rUn3ijac1nvYlp1BnQ08GaXB46XjaydycThx8d
 4o3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938581; x=1777543381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=w3VRC35u2ZWmI/ezGiXA6Xy2yCIZZPWUICWMZvJnfBw=;
 b=I/OdvmBozs2CvTPL2iduefn6xlKLHaM4PGmWpzdLIM+O+59v0gjvfpg/LO90mrP3qS
 jBMLWDcOYq1C9xySE1+0P+hC9UR/ITXkEMAlXmtvya0ZtApAfLBKIAuPmZFVDcpG8Ucv
 wFhV6IIytuz6G1TvOciEB9RwCS6wlHNwZbngpy5Ko7DuroHAw//zyFdPqr8PrvBg8ljv
 Ve95apGNFuMerJ37TycyJLJJJ8WRRSWXXIyHvMWQVtIZGgyRoYGRlaAdkroFh+4TimY9
 JQz4T20Sscm6Qfq/e2a7OW3n8rtRDrGkyyUz1oZfaXunUimeem9lfkNlqJ3axNW4EVt3
 hUKA==
X-Gm-Message-State: AOJu0YxXBveDlGz9gO1mQCMYUN2UmcCkDqbvp/kG3zgL4x2M2p8D5Kfe
 3S+UoUMq3zNvNeGmL5RFiB4UkHqRwTLCFxSVSGjTcKlCpSkBE4SUx/h/MVyHDmQ59hJqBZhJOPM
 yTccp
X-Gm-Gg: AeBDievO33ckv4ZUkFti30g5v6HZazcB20sIKknGBlYFf4GQG9mNApd3zt7gz/HV/bC
 tQZH2X5n9xNG+HmOVhEr+G7MTxX6JemQ0JdRNgi0WdSvxhon8MD4dwpvrH//onh9ChkHDzIgitk
 n8eeiGjezXVvJo19GEmSsEt1mGthcvntUMj0W85IoClUGE+cZWIP/uO3nb7i0kYAr7BIlWY31nL
 BJPAY4YJs2qcErDPiI5XrhPTN4fnDHLAg0OkFCbM9biJjplKkDi2HGnpimwxtpEStIfva6XWj0c
 9e5j1mZByicFo6q6QQZVyrR64vsdcuqQy3nJbWDdK/JBwNAU7vVAG3GKNYroLah+PJ76MWmgbdo
 RqjIYsc6OFQshmZ0D4gg0AGiQ76zQuKBVHWq2wRe0faT84LbtgAyuAFTTZ95d1Xo7ycmgQGhlu5
 6lU158GlxNRoDkNiQxvQOMifeqnGV735Lwp8RztA56av4e0omrN2kzA7DJ16Qe12DOS4yoQdyrE
 Wjo3tWipiFidHUKg36+IdqZ1y0bYBg+ZccGd/uzNg==
X-Received: by 2002:a05:600c:4714:b0:48a:5574:3a5d with SMTP id
 5b1f17b1804b1-48a55743e96mr162414795e9.7.1776938581049; 
 Thu, 23 Apr 2026 03:03:01 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.02.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/59] target/arm/tcg/translate.c: replace translator_ldl_swap
 with translator_ldl_end
Date: Thu, 23 Apr 2026 11:01:57 +0100
Message-ID: <20260423100229.2941820-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260407222208.271838-19-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index b6abaff490..c432de2a26 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6284,16 +6284,13 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 static uint16_t arm_lduw_code(CPUARMState *env, DisasContextBase* s,
                               target_ulong addr, bool sctlr_b)
 {
-#ifndef CONFIG_USER_ONLY
-    /*
-     * In big-endian (BE32) mode, adjacent Thumb instructions have been swapped
-     * within each word. Undo that now.
-     */
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
@@ -6534,7 +6531,7 @@ static void arm_post_translate_insn(DisasContext *dc)
 static uint32_t arm_ldl_code(CPUARMState *env, DisasContextBase *s,
                              target_ulong addr, bool sctlr_b)
 {
-    return translator_ldl_swap(env, s, addr, bswap_code(sctlr_b));
+    return translator_ldl_end(env, s, addr, sctlr_b ? MO_BE : MO_LE);
 }
 
 static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
-- 
2.43.0


