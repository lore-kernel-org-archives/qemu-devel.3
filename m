Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9BED232E1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56t-0004oZ-IX; Fri, 09 Jan 2026 00:32:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56q-0004in-AE
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:28 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56o-0003ko-Sg
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:28 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-34c2f335681so2386070a91.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936745; x=1768541545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WmfFVcMtzYnR8N3S8tOZaDOZ/EmC6gFRWJV8lK9mH4o=;
 b=jHbvd6aE0hq9a40ObIeqjBx/Dd09ULBeJcDneiQuS7NVeYdfPzaY1isjs1itYpev/k
 z41k76xRm0tl35lCzO0iXc2/ZAUSdTanrSIRvg1murg6S0Pqb4C3FZtF8Dvqx9hRegDk
 5hH3yJFVp1rWk2I+SOcPi3H7mRPLoVlpEnjF+vttu7ol6d5887faVX0OqyuTtTdIt6DU
 jaJt1MnAIGhmKVLtru8VFUDb5JQ3uspnFZqX2JwW7NFde2AQ/fq2qm/OQisoSpo6DyNu
 e+5kPMvll+RAbTF9DkOJmK4lQP2WEXVIhZSeHUcasaR56DWVUA9jRhGnYXpU1FT+Kkhx
 puZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936745; x=1768541545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WmfFVcMtzYnR8N3S8tOZaDOZ/EmC6gFRWJV8lK9mH4o=;
 b=KD2FPk7jZ09Ff9aSScgGbeADmJ+8hBVQJTIdUiYv9vnkOiNs7l32mIXzqG9X9rixp2
 MvcjF1slQLkkVJ27z2GplQivK2WD3fT+yqHWHr7yQi0FRlTO+skZ94P77XYB+CU8lJjK
 vEsuYxpahJPwC1jweNV1FJHOV1nAHdAaffhgU0Jui+5VMDEwOPzVnhb28ZNxsVKvouxZ
 RLDUCSmgdG5moU+ReYb66+wvceUBwI2G3LUJzvNMJW39FZieH4asG7FLtw9frS5lXpu2
 3DA6iKRiLFbbuysRBgLyKDRIOMOUWkoikmuPd/YAx3enymhneDvxo+dVDziaZCy5Er96
 29og==
X-Gm-Message-State: AOJu0YzqcgIyrIDeZao1I7QQs6chVEZt70ITCIV6LgUnkytJ4DB0YBJ7
 /c9lZCg0X70noTLxHeUwuAnubpYVG0LnTC9ps+Cb7YYW3grGAhyDqmONFc/3BATVJsG2qOhy7Vd
 nvDXs
X-Gm-Gg: AY/fxX7JATLTJgms2pGVPl3YkABe/A7W00SUhsN/z+7ZKhrh03abQ2hdQYTIKIitbZW
 p2OSIcaBuT/hU/2XjhtnvLcLF5yB/qv5mVOVfTkWrP9jH4r4enquwlSB7cC89kXv7l1+bJKcrir
 gjs8kiX7s9gUBxfmFapNlt8GKQKQGh7FjyZ0h0v5wVm3WLGHWMKPNqKCPrZK0Fchb+9A/oFV87k
 nRSs2z8OEyi+Wt0BHHLtEXGPZe745gEJr8ygU9TRFmQNAQgBUuT8O/9A0DYNdbjRP4erwYa1FYK
 EcHQYdF68ra2oN3vXC7OTMK/Ea9vGJl5i6jUt9UxZDqClcGQO7V5ubaSfAvA14C9Da2m8rdgory
 ErUCoSXC4uNqirKqNqvtBfUHLzJBc74nivHvbAiUiWur9hKvjq1JLpYxr8zFN8WEdCKG5u+y8NS
 Uwl0vdwZC60aOFiYwJG+qt3wRiQSahDC2fILFonJY2+X0cGdERAR2EIzndbIMiVkUss1Ctj96wK
 Ys=
X-Google-Smtp-Source: AGHT+IH0YuWeUTgethgNOaOxMET4pXlxG3A3o+3c+egcvWrocsvcTM6lGoJrrTOsSsWo7uMjPZpRvQ==
X-Received: by 2002:a17:90b:5211:b0:340:54a1:d703 with SMTP id
 98e67ed59e1d1-34f68cefbedmr7732317a91.35.1767936745254; 
 Thu, 08 Jan 2026 21:32:25 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:24 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 24/29] target/arm/tcg/arm_ldst.h: replace target_ulong with
 uint64_t
Date: Thu,  8 Jan 2026 21:31:53 -0800
Message-ID: <20260109053158.2800705-25-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
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

Allows to include this header without target specifics.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/arm_ldst.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/arm_ldst.h b/target/arm/tcg/arm_ldst.h
index cee0548a1c7..0252e3b0ea9 100644
--- a/target/arm/tcg/arm_ldst.h
+++ b/target/arm/tcg/arm_ldst.h
@@ -25,14 +25,14 @@
 
 /* Load an instruction and return it in the standard little-endian order */
 static inline uint32_t arm_ldl_code(CPUARMState *env, DisasContextBase *s,
-                                    target_ulong addr, bool sctlr_b)
+                                    uint64_t addr, bool sctlr_b)
 {
     return translator_ldl_swap(env, s, addr, bswap_code(sctlr_b));
 }
 
 /* Ditto, for a halfword (Thumb) instruction */
 static inline uint16_t arm_lduw_code(CPUARMState *env, DisasContextBase* s,
-                                     target_ulong addr, bool sctlr_b)
+                                     uint64_t addr, bool sctlr_b)
 {
 #ifndef CONFIG_USER_ONLY
     /* In big-endian (BE32) mode, adjacent Thumb instructions have been swapped
-- 
2.47.3


