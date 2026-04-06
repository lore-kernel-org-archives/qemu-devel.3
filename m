Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80191F46C47
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9lVW-0002uw-OM; Mon, 06 Apr 2026 11:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVS-0002tY-N2
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:04:51 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVQ-0003qk-75
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:04:50 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2b2469e5117so20970655ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 08:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775487887; x=1776092687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BpjBN/H+zc8vKXTIC1giYotC0A5eWy62SJygmBUlOkI=;
 b=dI63pOJagXq5djUcRyMXxIbsJ/tDaE2YVI2ZBzp8YlikhSpHZSmt74SmTf9kO6RORR
 me6PLlIE/WPvM7acdEwJvmmdT0H4GGB9EihCGewsSbjOFviO/0rnnPDHRx4t5e9eYLhF
 8pzXKa0ocRW2fKruQYrQPEdc0dSgnaBUyAOjAclqe2Balmn19pBcY+bj21gGlmGc4rh6
 KfUcI/OqTzf9Dwh1xKohCAea0TcIe6klYs80upXWhY7xM5Ff4qceMNhZVgXs0jFVPH8J
 2ZWvlIPxsGmPZzBRaE60Bhzj3HGMBwZM84GaVk6gxB1o42hZ/t5k793VkDQYSp1CngfN
 bs6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775487887; x=1776092687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BpjBN/H+zc8vKXTIC1giYotC0A5eWy62SJygmBUlOkI=;
 b=YjZV2uNEf4aNtnPe+If/Fc1I+apFt3oQiwU8AXrWTyR6Ya6kbQJM7VyW0pwv9tGRVe
 7Xipwn5ACtw8pLRHefU4r/Ny3NWMROggfMQJS+SHDe6QG0XS/4kR5efT/6ya+QwMIIOx
 Z0gin3fZF+r8YrvmJjBY0bex4aZVbanpG5pQVdgm5v05iI4NIXStpBoLiiOLf74kxvC5
 JmQmvnG/EkXQY1HPzAJ2xBhKizrehEzNjekiQUTkSIr6QhKd2EuK4YtkhhcgsT00CbfF
 0rqj+tO3//VeQWsoHIT+rUWYuicveTPyidvk20Uxpb/1hG8RpAnJGTq96jJCa+hAGTPI
 2ybA==
X-Gm-Message-State: AOJu0YxeYW2zUof7jtsX1Wvu03x6nGECtHI2H+ck+ghye90uRu7NCVZn
 Oy9/bd073yPQRSQlPZd3+95c9o2cBx6CQTyMMKjC/hbc/pMiTA/w1hXwVLXcoSKlM2yG6OrmsSo
 GIA9jO6/Lmw==
X-Gm-Gg: AeBDietE6jJafCjKHiGobl09rhKsrWWbSxNfbVdg9UZ+4ZG90+p3oBhX7kcWbsKfW0n
 NGpg46nCyg2XBzAEt7MmshayISMUvnmqaBdI8eSKryCgGBo1dHugqtxUfsPCfsKXSbwp2+rEMvb
 Mg6wp7jx94jmIFR+pIEK6RdckoRxAbplsI2wzg1a8H0XpNGAewKPRJ/jq15sIsKcvABw3p9aquL
 KXA4ZfE3VjsfBoz95aRmGDkai664Ga6VqlZsDn1bXYCfSZX0RAFABDEfoABW/llPTWa5K7/4oTJ
 L2KE+AK3nfAQjc1maqGKkImbFx1b3V5Ezsph51gfHrGcdDwmIF7DQduiU39OBpnpuIhG6GsQ8sm
 UTjCPkp+2pKIoDab11gDMl5Tc4ZqmFMxaeITYPH0mN6L5PwYcoTqwUywRDE9Z5rtu9MAwebHj3T
 Wi8Y8K+p9ctCQRRznegRoJUgCuas0rAV1/6n+PMlpoZIEl1s86NCfSVwaD+pXPl/Cm1bMr8H7cC
 JPr
X-Received: by 2002:a17:903:32c3:b0:2ae:5350:3a4e with SMTP id
 d9443c01a7336-2b2821ca1e7mr111285575ad.21.1775487886612; 
 Mon, 06 Apr 2026 08:04:46 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d72sm137770075ad.51.2026.04.06.08.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 08:04:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org,
 jim.macarthur@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 04/14] target/arm/tcg/translate.h: remove TARGET_AARCH64
Date: Mon,  6 Apr 2026 08:04:24 -0700
Message-ID: <20260406150434.407201-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
References: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

We need to stub a64_translate_init and gen_a64_update_pc.
At this point, we don't need to do anything for aarch64_translator_ops
since it's just an external symbol.

We can now include target/arm/tcg/translate.h from common code, since
all target specific bits have been removed, or can be specialized with
specific defines.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.h | 10 ----------
 target/arm/tcg/stubs32.c   | 17 +++++++++++++++++
 target/arm/tcg/meson.build |  1 +
 3 files changed, 18 insertions(+), 10 deletions(-)
 create mode 100644 target/arm/tcg/stubs32.c

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index e28eac54afb..77fdc5f3a17 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -357,19 +357,9 @@ static inline int curr_insn_len(DisasContext *s)
 /* CPU state was modified dynamically; no need to exit, but do not chain. */
 #define DISAS_UPDATE_NOCHAIN  DISAS_TARGET_10
 
-#ifdef TARGET_AARCH64
 void a64_translate_init(void);
 void gen_a64_update_pc(DisasContext *s, int64_t diff);
 extern const TranslatorOps aarch64_translator_ops;
-#else
-static inline void a64_translate_init(void)
-{
-}
-
-static inline void gen_a64_update_pc(DisasContext *s, int64_t diff)
-{
-}
-#endif
 
 void arm_test_cc(DisasCompare *cmp, int cc);
 void arm_jump_cc(DisasCompare *cmp, TCGLabel *label);
diff --git a/target/arm/tcg/stubs32.c b/target/arm/tcg/stubs32.c
new file mode 100644
index 00000000000..c5a0bc61f47
--- /dev/null
+++ b/target/arm/tcg/stubs32.c
@@ -0,0 +1,17 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "target/arm/tcg/translate.h"
+
+
+void gen_a64_update_pc(DisasContext *s, int64_t diff)
+{
+    g_assert_not_reached();
+}
+
+void a64_translate_init(void)
+{
+    /* Don't initialize for 32 bits. Call site will be fixed later. */
+}
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 5f591560551..3e96c77df73 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -21,6 +21,7 @@ gen_a32 = [
 
 arm_ss.add(gen_a32)
 arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64)
+arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
 
 arm_ss.add(files(
   'cpu32.c',
-- 
2.47.3


