Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C664D232DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56u-0004pt-21; Fri, 09 Jan 2026 00:32:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56r-0004lX-Mq
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:29 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56q-0003l5-6H
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:29 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a0c20ee83dso37029975ad.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936747; x=1768541547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7w6tD/iFB3O8oQteGnahCPdidqHMlo4+dO1sLwAk+Y=;
 b=B0BUeUWBpnnkEb7LqelPQBXtbrWEstFu9tv71ZNiXNXGSQD47ix4e21ci+zvWf9jHl
 fiRgiVE7MdYqVm2igdUVBh++Tdh7hCl6+y4bgtv3I+bl4T6ytrD73bqZuVIoYMZITPgm
 6l+hI+2CENnOTK2d0EovZ733gWeeSYp2xRlIO69s8H54y4eSCbg/wpbiKa/Cvyygi3QB
 Z4sDtcOdKIyS4xdsLivhqkTh5GB4N4SBr6Kmen7ZHx0QPjwLJNGrm0q5wQ4416GyANJQ
 8Ya+2iypJvWnJnk7CUu0FKUuA28NYpGLur98Mf726s1T8bGvBZSrL1Agv5o9gSMKpJVm
 jFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936747; x=1768541547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c7w6tD/iFB3O8oQteGnahCPdidqHMlo4+dO1sLwAk+Y=;
 b=w8gJzsLcgJovmyze6Map4hPg6X4p62BoaHmi4W0HD3ooDoUay0dXaM8Qz3OjeDf9IR
 dhrGZUXbYonRIEmcIOhxfpOK6MIQRkDcGnfKur7N1TFeJn76BgemYl5v980FHI/1qJO9
 LmiOSY3Ef60c9fQ+MSuBAdpInvq1HywCqLJYwOoePf2BYukWVgNmna2m2K7J1D5KE+v7
 zDwfLN4NpSU9+khpMxkVjMOiOFMNK77vy0k+FmkzAfzsxsUNG9PnNflo0GcjIqTc3rye
 Nt9ZNX+VKI2eZWp+oZ00wok/YvA5nUy474HBDxMEU8TsncMljO9GJIWmZLr2xmSsUQGn
 yKHg==
X-Gm-Message-State: AOJu0YwIg/8m1KH6OTNlICxOFCuHKSmoNkV99eslPIlo0fhwMUH35sCR
 oL3v9hagmR7M5QnzVshoOzLaU9WFkFkZU2ApQaknBlgGTridjB7FhZtTbrLk0W5okXJWUungz2L
 bZA5C
X-Gm-Gg: AY/fxX5k9/pV+f0EnhkiYUDtuqhKMdlFMPYIBhzVtxAyVzAd4eX2BCLno3eAgGsMkF+
 MrG1LeqLUX2n+sv1agrPr7sbOGPE4cDrXXEC1uumoQInLysfLwoz2mvN/pikSesla+KqspOZVgx
 VnvBRTdltJz10Ec7M3ex48TTafcrbe+/9Fi6F1JJ3+IuePErjtZxMrw5Tkl4awFaT80vSjjNt7y
 Fje0/uCdEhp9ZDft+qKgJqaY2ZWrWJZsYepZH4jWJaca07JJVr9wxZHVSWYY8d7jkKKF8h6cfll
 YhhEzn/mQ3kxyCUuMXt9RtrSkEfvufBMkfwnmCdAF0Qg7bobVHS3QL3PFAHRjuF3nesjyDtFRm/
 7x7qWI0VbIc+xozCyn7R4MSN5ZoF4Ce2rujWZZCbx+FJ3//s3+hBHHXA+xXQRC2KdtO/RYQgLXA
 mWLtMBKymdLHqPkKKJM47nHSTJL3do9ZZWPbO23CgzQYDrRYsJ27m6FPSywClziomv
X-Google-Smtp-Source: AGHT+IGmG69ffWORCaq5eTq5+z9jihAG4/yZeAvFBwMwa9m+p1dkU7N0cvFyeebvU4skoO8MpG2h1g==
X-Received: by 2002:a17:903:234a:b0:2a0:b066:3f55 with SMTP id
 d9443c01a7336-2a3ee4151fbmr79792205ad.10.1767936746570; 
 Thu, 08 Jan 2026 21:32:26 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:26 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 25/29] target/arm/tcg/arm_ldst.h: use translator_ld*_end
 variants
Date: Thu,  8 Jan 2026 21:31:54 -0800
Message-ID: <20260109053158.2800705-26-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

This is needed to call this header from common code.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/arm_ldst.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/arm_ldst.h b/target/arm/tcg/arm_ldst.h
index 0252e3b0ea9..0b49b09958f 100644
--- a/target/arm/tcg/arm_ldst.h
+++ b/target/arm/tcg/arm_ldst.h
@@ -21,13 +21,21 @@
 #define ARM_LDST_H
 
 #include "exec/translator.h"
+#include "target/arm/internals.h"
 #include "qemu/bswap.h"
 
+static inline MemOp arm_memop_endian_swap(bool sctlr_b)
+{
+    MemOp t = target_big_endian() ? MO_BE : MO_LE;
+    bool do_swap = bswap_code(sctlr_b);
+    return t ^ (do_swap * MO_BSWAP);
+}
+
 /* Load an instruction and return it in the standard little-endian order */
 static inline uint32_t arm_ldl_code(CPUARMState *env, DisasContextBase *s,
                                     uint64_t addr, bool sctlr_b)
 {
-    return translator_ldl_swap(env, s, addr, bswap_code(sctlr_b));
+    return translator_ldl_end(env, s, addr, arm_memop_endian_swap(sctlr_b));
 }
 
 /* Ditto, for a halfword (Thumb) instruction */
@@ -41,7 +49,7 @@ static inline uint16_t arm_lduw_code(CPUARMState *env, DisasContextBase* s,
         addr ^= 2;
     }
 #endif
-    return translator_lduw_swap(env, s, addr, bswap_code(sctlr_b));
+    return translator_lduw_end(env, s, addr, arm_memop_endian_swap(sctlr_b));
 }
 
 #endif
-- 
2.47.3


