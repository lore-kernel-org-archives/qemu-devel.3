Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC08F46C70
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 18:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9oeb-0007N9-U3; Mon, 06 Apr 2026 14:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oeW-0007JZ-CY
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:24 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oeU-0002LG-SX
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:24 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c757a9251faso1372756a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 11:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775499981; x=1776104781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BpjBN/H+zc8vKXTIC1giYotC0A5eWy62SJygmBUlOkI=;
 b=GAEt0K0inw/NN0Tz+V5hATXwZqX0AgdqQmw3MMHrctUiBx++Z7sU44xSwBfaVIjMCe
 muBxmJz2Jy7ABVYzFvVg5m6YeGdXWKqL5v13PrSQbtdZasGABMo1scu8uKi2120zqhwz
 makjxvPHAx2gBp1K+kRLzU/alsWMx3LnXKCZadTZkb7XZ25PhFrDrzNM7rTXdh0o9pzQ
 e2bO3f4QfFryxtPvLs7+bus2WrhREGxUMug3A1/STKk3L2nmlM7WMobJX97hxDR/Zi+P
 UX2nGKyq0WxVQKodgMhhiv6NdwwIkqfLzYdDEWqtW4epTVUd+g7xczHSyZ6JNKNd9BTv
 9tgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775499981; x=1776104781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BpjBN/H+zc8vKXTIC1giYotC0A5eWy62SJygmBUlOkI=;
 b=eqkeRuNRP7egc3cRAGMnBMr+6bq0h7izlkx6PN762b6N8NcoytLfjYEWkWf3wYljGU
 XCyXy8+8iX7KCZuVW8nF3KEFE8nGwF/2b8X9wXfF9TWYCNpAf6RtcX9LG3NNx/Nlu1PM
 q3/H17Ydytm041kvvCyvsqY1H0SlheaoZ9oIOvdMrbtL1DQmgrsb58RiWiA4ihOj5TGV
 WdBuE7EeqlNaVnZg/v2u1HJ/q6KwvsiTQKwYr4xg9YmoEomj/gGRneyXzpDmTWt5S3Ow
 jASOMyEQewk3V5MQl2JK5md3cWTl426LewziCVBBpid9dxRSdRWxaszjBkwllj94XfnH
 BMTA==
X-Gm-Message-State: AOJu0YxHK2eziZKbXZCYCOHyH1pK49nYWvH2WDsddWX5UM9mtjlLHtun
 16nyuwS0YiXGJBIEbhHwlzJJojg50XGLoUmaaWLix5ChnN2P9gQht4nzUmrwBzZ+yAKo5XGwD8u
 uVZIh+Hj4iQ==
X-Gm-Gg: AeBDievJS15cdi8CM0m3+dnNzx2iZKcf59mY3isJ/dMxt1+0wq68KmrSw7JjAwqJa+j
 2daj6jOzoElUaenBR6zIHSsIx93fqp6rUqXnnl0TFmAdtA1navvr6fE85tJwTlC5yJZo1oMj3zT
 GJgFtH7YSxC4q1TCU74+pembVO8YRIEjyaOE8VQ9XtNKaUxF1fz5eFZb2mgbAsZCdM8l052GfxC
 mHqKiH4+UhUZhNGyKc47yovKXAx+hSUntxuPR5LdEQZe5MTj0L+K8QJ21so/UL737KwE9dUWp25
 sg0h6jt8Jt4NSIRFfP523S//ra9no/8M4MW+UKxif1vyoKS5+DIBs/PcyR4JYqMMWz6FThuzKPy
 6c2qsskbLC92z33dawZxENOaf2+lFNeRBSxR0p21tWLITvRu+RznxpAsxWsQ0ROYzBv+XBvtnEU
 v7kPOSdiHCpMsKkqDahBtSkWL2OJA3T213DEp6r2pSEj42Jz+sZsIsWgVyj8qVFZlyHTyeRawyu
 0N5
X-Received: by 2002:a05:6a20:7346:b0:39f:24ad:ad11 with SMTP id
 adf61e73a8af0-39f2f046df4mr13667699637.9.1775499981265; 
 Mon, 06 Apr 2026 11:26:21 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6561fe9sm12765080a12.15.2026.04.06.11.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 11:26:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-arm@nongnu.org
Subject: [PATCH v8 04/20] target/arm/tcg/translate.h: remove TARGET_AARCH64
Date: Mon,  6 Apr 2026 11:25:53 -0700
Message-ID: <20260406182609.193886-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
References: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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


