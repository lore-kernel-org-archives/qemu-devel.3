Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AB210F9976
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYMC-0005PQ-UA; Wed, 08 Apr 2026 15:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAYJc-0000pC-FM
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:11:52 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAEoP-0000n6-1D
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 18:22:23 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2b25cf1b5f0so36709365ad.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 15:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775600539; x=1776205339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BpjBN/H+zc8vKXTIC1giYotC0A5eWy62SJygmBUlOkI=;
 b=qJfd5NFQbj1z7L4zI4ABhoCX+MmEHoXvORwdV7wmNSEeIFochIW9azDftkq3clxmnv
 DU5Vbz+yYnEKg+vKF69C01hlz7kNQPtjPjF/cavFLxRd4HqR0QYcniK+BHRFU+MmVWiV
 AbDQPwZtIs2plNGa423skHFalo68GoUO+iTDYle2SeJPDwXUxTt5sE3Ef+wAeXQj81mv
 DtmnW7OGCIL2NiMBlWCPh72LXxJtJiXJ10P6GWTMnnZrfL5fJLV5+osppmyfxE32meIv
 s5YUU0Dljb1XwQa0g3QDRBXt8T+2lUlLzxDoCQyy5HcDFwwywU/cbMy7myBskcaciXBD
 2qFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775600539; x=1776205339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BpjBN/H+zc8vKXTIC1giYotC0A5eWy62SJygmBUlOkI=;
 b=O5rPX+kVo+GJtdEzxZ5qDvPKoylRzkaIfqFbX/PDokIi+KRqPORMzJKXTOjPNiF6X9
 wxdV3jBRj4WslZ8POQ2OjNFyVp+73bBAyEZJldY8vB59mJF7OGbTcIIBkzOOeOdacjt3
 TOxsceCD6lhfVgnNh8NS6gm70cBAxTNiH5OYRGBns9Tc8QSmE0FhV/yC9Y2Ph9QsGZAs
 xZm3HIfFSwVxCsOga6v9xmY2m5pTApf7ZaL8Fqruhe33O41flHNpcaqG2MQtVWZDhtA1
 dqQmIIfRcCEsVMLWtiNm1j3j8zYuJJz/txel0S3IJFNaKIUlF+dSLwmTYnMagHLnKeDJ
 745g==
X-Gm-Message-State: AOJu0Yw9umWYjWsRaUbDGGSRRhodhdsv7WcOb3UjuE6hFe48B7LzGQZ1
 vFverh/1BHI5g+EFf++7Q1uypRzpnsU3SZz6uzQ3lCuTvs0yhwPEv+rjn941EE6zzxvQGI+guOB
 rGsDYK14=
X-Gm-Gg: AeBDieu7PTHo0pGDaUhebEi6wtu+WMh2o7T7iH6Vs9h1k5QbQuH06HYowYaGkI0cwLS
 Iclg/Fu6cIZMHLKGfh7S15SUdCyl0/U+NgCzg2ncOvuUf6P0CgfXGg1QT487r3DZxPAVGrRbLD+
 y8+Szvea6YItLnqWDL7jAjAUb7Yg6wHhTnjQ2xb0dz46yJ/tN/o/oxDa7NwFt3QQPh7ZiBadRF3
 EHk3V6h3oK2rotZoOJvmIa68fVd+ZqrAGcKjwGAuGQ0kGwyombwIoVl40oo81UPx1LNqPXCiC2N
 /LwLpHARyp51BSk+FpWl4jYCnzrV9Z/Dqyk4q8VJJn8o7EUhMm+03RL5aBa3rlBFMeyTMSDeCuH
 AP+fMQHdgLXq4/68TVS33iZ1HwcpkoN5EBAXKQVo5973l7QOst32hWDuwRwphXzIkjKZLFUIcH3
 oV0R8DtYaXhkBwDfgxzFhauc/QXObxN8rOUCrDGwe+bwQiuh63U3++VBnAWpYGW5iV3rvoGUUyd
 CCG
X-Received: by 2002:a17:902:b48c:b0:2ae:46b9:c653 with SMTP id
 d9443c01a7336-2b2817aecb1mr134979505ad.33.1775600539094; 
 Tue, 07 Apr 2026 15:22:19 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d5csm180412065ad.38.2026.04.07.15.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 15:22:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v11 04/21] target/arm/tcg/translate.h: remove TARGET_AARCH64
Date: Tue,  7 Apr 2026 15:21:51 -0700
Message-ID: <20260407222208.271838-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
References: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
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


