Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4412DFF5138
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 20:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wACaO-00044u-Ka; Tue, 07 Apr 2026 15:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaH-0003xW-Bn
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:37 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaF-0007JL-Ka
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:36 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35d932cc948so3255980a91.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775591974; x=1776196774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BpjBN/H+zc8vKXTIC1giYotC0A5eWy62SJygmBUlOkI=;
 b=nNapWmkHYA9gcMW77wSnA4XxFyzJsPTAYy5VlLeTf+Ol3CY49aebZejiVvwsCj87qW
 zFp3U8pBB150yRtnFzv+r4BfX6BJ+zhrLerMveob1NoBSAp2oQMr+DlHdHG915GP50aa
 3g+13+uc1W00dSESrzeWfmgmPsWc7Y+FuUHd+rzRtanAs4Jh/zjdHZVkpW35dJHDPsG/
 eiNfuOqRCAe/+OyN+uQ9ln8i8DrwZ3pcqo0ab6ttP8R6dJynMVq+LDYxf7O9Kys7qClE
 0vzJLBgyc96PcB6ptYCEkP7bwnx/pHBapWAaTkxfP6n+OedSN6GWruDTnrpYMK1jiwjT
 Iilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591974; x=1776196774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BpjBN/H+zc8vKXTIC1giYotC0A5eWy62SJygmBUlOkI=;
 b=aQy8ejsT3CG7DaRsayEWA8raH/tWzQ6/3Y9I6+/ZNdc6FarV6vQV3HncZZPMVVId8x
 5b4RZJgJA3oNdRKgT8q1FCo5z5vcXudXhfZA6YontMyb6xmfOF6rkcgE6X/5nKXo61K+
 ZZE+6I5iv/PmTk85bSJb2K5b1TqbC6Yn7qp3um9wjgW6ERE1pS20Em1OpOWld36SlJMj
 /2KQV0Xfg4ynDD0Dq+HhC9yT2zu0G93q5yFRdRN5ZdcjFAklabZQ8EvyRnuFQXWrbfvd
 Q+6OeQ8V+qExmtkoefJLu2zbcKbtLmFoaPhofXR4yEH/1T9942fkoch0g2d+jrKchDNb
 RGOA==
X-Gm-Message-State: AOJu0Yz+Yl1aIWc0HZP6vyABOatHyGkUOw9ccifXEAXjjwBuLOsRcC56
 7lpCKG9tmijGtbmURiaqRp6vCbvzQUalGlCqelhArOle9Pfi5FcbAs7tRLJgnv/bnEwh/vD9N1K
 WZTamHls=
X-Gm-Gg: AeBDieu7KgTb+2QLeKMmEbSJmANfu5zRk9gEiPh3OjvXtbcUDf5VHuHtWmGX5g4FcOD
 CaZnhR6wfJr9uW5kniPPf2izl55D85t+44qfVPY1J736ivLV7QgEX7it9t0Ma+2wzoomrb5SqHv
 YvXBL322Kac2CC9kSAm5eYXtfDgDZ/ofVpU41rxOkM5w60xKkqgRuES885Zqr1U2KPPdJB2tTVW
 Jsu2uVVFaCJjiIJQKuMAsIyWWfn4Cikm23Wx+EGbKWwd+MT3xhDh+ffokFJiBk22ExS0eCwG4t2
 1EtnyuJ6spJryA0SaLZ1KaTzu1cjZ+ii22iHCGmscQ96SKWJxSzR+iam23YrwJi9cWYDX8rKaT9
 Phh7f0brO28Q9MOm0uCEWMXSGjju/ljL6WfSX8AgxVyQgnq7ji9wNqv+v1xsIH/ATjeB8yTrGai
 BZeIQdxZQO0Bw0qj/FGdLZ9rsVJAQ4FAhSZAmzUc6jaMohgIdtnQtV2whsnAbTeXDpVD1xje0Pb
 Yg6
X-Received: by 2002:a17:90b:2b4d:b0:35b:a8cf:7969 with SMTP id
 98e67ed59e1d1-35de687180emr17904131a91.11.1775591974131; 
 Tue, 07 Apr 2026 12:59:34 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e27c9855csm126911a91.3.2026.04.07.12.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:59:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v10 04/21] target/arm/tcg/translate.h: remove TARGET_AARCH64
Date: Tue,  7 Apr 2026 12:59:05 -0700
Message-ID: <20260407195922.196410-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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


