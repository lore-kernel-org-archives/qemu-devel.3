Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B87FB5183
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9wAl-0007YR-EL; Mon, 06 Apr 2026 22:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAh-0007WR-PS
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:07 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAd-0006wo-M5
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:06 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2addb31945aso33036255ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 19:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775528880; x=1776133680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BpjBN/H+zc8vKXTIC1giYotC0A5eWy62SJygmBUlOkI=;
 b=n5xHA50K9RSXYiCmnK/5bu35ek45XxylVITd7NOsV7r+wks7vq01kaCfn5abTo5svR
 UThUqFk3s572SRRH0a0g6vRSSDpV+5wgd9hFvDSkg+Jy1RBzkG1IL4AIMMWSuzWfVezX
 1i2plfcM8Nl/D9+gdbKJkDPmGejjZwgEAgQTZysRkjWQ5nwJsiGz+6aJYcQiLPaiS9SX
 A8FF7uyShaHOJ4lwbqO6J4ByCCTKLG7AGsRG5V10Keienyj2nJ+lzeHEbDaUesNMsepB
 TlHnJkTHyfwz8EEU+81clq0mMae0gM0Zt1m+kxX/qcO+cS0xSk4ZB/stvT/2oNEG6f0L
 w5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775528880; x=1776133680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BpjBN/H+zc8vKXTIC1giYotC0A5eWy62SJygmBUlOkI=;
 b=hvc8Y5jA90zvOweT82LA05PdxzUxicV+0rhmMe+a4tlDpXqgbg/SOScoidwXSuau+q
 0E0y9S98xy+7fxs+3xvzqAtDfpbo8BZCWTUbk97bI3SiYHjz9q30w3DYWEX5fvk4Yrdm
 m0AgjZza5WBvhDq7QqG0QqtxBP1rQIVzmprv/7xptsHjmUrosiIEVlrF08KM2UdPe0U2
 rkFSQEqdm0r/5rR/nl8VAREDe4svY5SeEuSvCTXCiY0Nef4bwjexBYBdp/0v5rKp8p7l
 14hGiOhFL0JqWgYXWSEMsbrApuJRCTKi7PmLuCp85AWYwxEdNQED/pkkJyHN548F2Rho
 ylgQ==
X-Gm-Message-State: AOJu0YwQqJEiaAzdlb6/B+xIzCSWfWXQmrvOqxopoMnoNlZPIRkl7r6p
 fcfDivyAbJVj7uYml1eOW5ubbOVXIl2hOIZpYrAkdBN8Yf7K1KH7kflpEPTac3jv5uIwMTliJxx
 x+oR9Wg7Vhg==
X-Gm-Gg: AeBDiet7BFc1wNbty2j3UkbCY83LbA7UxvJHE71gr+lODzL5jBKCJYT++wNS/84LBpB
 aXNLXxUZ7sQch5LUHVJd+FlP1OPqKmz//LtE0GBF9SSuD7IxnFWtWWTlkxw07b7f0wJx1hbKJZ7
 0qWm1KnKgo7qsO7bnmClyMIJITUBBYRfYjjaremmMkWBYhn8re+wUuWbeAdfLUoQN6AT+A4rhfv
 Q0lXM9vNo7FymzMlyCCHgfv05HEQF7rONZ7lv10GW/rWFJfzEz/yZNC8RWoX+HkQeGdOduxqGK6
 MxaMC3BFDe0nuu2wNmdZD0xq68y9KpupBrd+HW2oJlhgp+/4YE4N/nvfNhlcP0eCVxaCaAZ09B+
 +RwqbpIUqxi76FJgTSIeZ7W2oSbnMr2gvVyGokY1a6Olbca6SaOJFZfx/npZm6/rsJ2dBBwXpi6
 AGx9djePCl8eGZm3GPeWf1DWCvSN5QUcgNAGn1hTYmPDHzb0V+JPRqXxTlN87C3iDRV/WtfQ4vf
 NntPU/6HuKwi1M=
X-Received: by 2002:a17:903:9ce:b0:2b0:54dc:63e with SMTP id
 d9443c01a7336-2b28193257amr158742665ad.33.1775528880064; 
 Mon, 06 Apr 2026 19:28:00 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749794e8sm161423685ad.53.2026.04.06.19.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 19:27:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
Subject: [PATCH v9 04/20] target/arm/tcg/translate.h: remove TARGET_AARCH64
Date: Mon,  6 Apr 2026 19:27:32 -0700
Message-ID: <20260407022748.57629-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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


