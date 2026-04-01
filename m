Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4420107639C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 19:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8186-0006gX-2z; Wed, 01 Apr 2026 15:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w817p-0006Th-2N
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:21:14 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w817m-0002z9-9H
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:21:12 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-35da01fc0baso35499a91.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 12:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775071268; x=1775676068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BpjBN/H+zc8vKXTIC1giYotC0A5eWy62SJygmBUlOkI=;
 b=P4MUwBpSRXqj8y8v1dldHoq+Sqr3rbIEK7Nx6LZG4CUmNmTDVw7gcPyc4681GK5sLj
 3CAGyOafon/m6m2brTPsX79m9fOpfOMAcuEAtRCL+45RO6NfwyXuN4JduDpBHxzXYmzX
 bbWku0n7rjmypQB6QuUMn2+jELGuDmfnPY6YfueLfNsRrJRBOL+N+7RJa58qb7Qxm2cB
 vHD5wAA9m28N0cJISuXqO8B+gRqgQCH6JffKjbRgKLEJoidsGLC/TjpQNExx4ng4ekVT
 Qmi8K2V0YOqI1fdH0ob/O3QV5j85otHqROWFNwpZygJUTdE593PmiibXowqpfAlZUCWi
 DBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775071268; x=1775676068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BpjBN/H+zc8vKXTIC1giYotC0A5eWy62SJygmBUlOkI=;
 b=gLyKQU172lqeVBlZRkeXmusUIQoF9iAilzmlpHiBa6p1B/H1X8nE0lusWRBlqKBjda
 XiMH9CZLv6Oq2Gf+qjQ6pnZYwTLpuNqFniF/Mmdz6cYRuGYNPkgnIhsfv5ZPf6fEPWOY
 QGxlM24z5U39bxcEi+wzYP0UpHidvqwxnp26E1VATVvEBkjG8NJdhvuWq9ICu7fpoRvk
 QBTvBVUZo/PwhVz5V+OXDFeZDaUxBxyblxkLyIVbpbqzpX1NoiM1a2UAl54v6QLg1jlC
 fc1o95W0YJ3ETc3x7rGZACGaagsagKCt+F3R7JQIJXBkmoS7WRCcEnp/8geQJiRnm4mf
 p/8g==
X-Gm-Message-State: AOJu0YyXTHd68xskS0uDMgnjJFy6QU6hlin3o+agrIS0j/OxFsxu02yZ
 fck/GYKk8dli4k3OiQwweTm/DIJjkXuYWRcEcsd9SpnLhUGmWa1jigbB0D44IRaBLqOwNVoGDES
 47cA9RWX3Tw==
X-Gm-Gg: ATEYQzyJmcGS6InToEuz1mMWtWRNsoBMbN+Klhn5asEUeym/B/l7h0H7J5FoKiojUP3
 2VHS2mfLsX8JND6uo1Sv3ufOi9X7Z1b3Nhe5TRrUuozyFcbA/bbTHEZQxQd7MPVNJ3F2/JO4PBU
 Hf0FbZiKWOrpfWeIUIYO12HFYYlk4REmEdnFRi5W7/9eZcjHZiwTmidpxscv4lnhSqbHVHh7inA
 Tg0PfX58//Ib3TrsBdt2ZlhzE1AXjSgajjPNKyRvqD/RZARbuU2YtbL4Y94sQTGWrnrb1Vun0yV
 93eYstdA8JZme4JYIR3pEzBrw8oi1LasQE+CNkWaWRWhhyCDL/7Z8gx0QiCw7S3Sqevor3vY7zQ
 c1qaNlrDOajarIXq1s+hPqrPUYraXtD+IIjcubWvAo4oaToZR8/tH9yXcuSCV5hVrbK8Vj8JPmG
 h7svOjWynfuawygB7xzFVvF6zNiHZFKD9UdgnRpzMApo9GdmbVVFZXDutX+KrBgIdHTDqUybaCY
 +1M
X-Received: by 2002:a17:90b:2d8b:b0:35c:30a8:31f with SMTP id
 98e67ed59e1d1-35dc6e7ab92mr4887381a91.2.1775071267787; 
 Wed, 01 Apr 2026 12:21:07 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe41b11fsm5633113a91.0.2026.04.01.12.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 12:21:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 jim.macarthur@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 04/12] target/arm/tcg/translate.h: remove TARGET_AARCH64
Date: Wed,  1 Apr 2026 12:20:49 -0700
Message-ID: <20260401192057.1182724-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
References: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
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


