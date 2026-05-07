Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDCFCD37A7
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8OW-0000R3-1l; Thu, 07 May 2026 19:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OS-0000Ni-Cg
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:36 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OQ-00015N-He
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:36 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7dca4debedaso1461298a34.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197473; x=1778802273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nhUX5xUOMWRVB1/C63w1PD2bSynvzORWNQ1wKLfP1/g=;
 b=lI0eHRyxXT1uyC3E8YL6NbHYc71EgSZVlwyaUaHDp9egYOxrwWiKgHdSloJloNsktu
 sU21XF887gyIuEJH51r761ww+xq6CT6If9jUMy7ytypXDNf+C0wF4AlJJWM2kTrKOovk
 BghNVwasDGyd/0sk49PKTOzS9efiDJz5hW6jKAGWtloJF1jMP4uUeKYjSrAMthKt6leV
 yTVfyGAOgc/NESK76JtVIKRwr3eu8o9i0b3X3TGpcwE9kRP2wofmu1+NP2avEJuWCqTT
 fMrIsS3gQ9qDTW8z+HqnweGyXJrdMdeKRecKTr1OKVkQ61pqIDhF2GIYR5sMoxp6diRP
 DadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197473; x=1778802273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nhUX5xUOMWRVB1/C63w1PD2bSynvzORWNQ1wKLfP1/g=;
 b=oMW7XOFtA/uGHydBRDY8u7CeIGGPtIXl51reNSH9HARLtSyPEImKjo/K1mZcwlSoR5
 06C7NsfxSX/n+RiU8jmIC+zKs4tSz8/qB1GT8UYbBQb3wGuY4C0TBD9oGOMcLfFuuiZ7
 ur2xBSroF6xjsXmnncueKLWQxU13spkRWwAGmerQSlbaKRNbDAf/99W3a1Yn2Fo8Ii1v
 hllxHW+MU12yr3H3KLeqjE/vwASsK27QKUA/XDHFnPkotksvacbFtMeLeGcOr4tY3NJX
 kFe8qUtDfmkXoSUNqOgzi0B2vBOHQbDmEzKQvhwZgdE1RuNI667w/ojETQ742EoaLzaJ
 zHjQ==
X-Gm-Message-State: AOJu0Yxyl4/aIQs++JdBnaNqWZ+SBnh3VSs7C2tp+FUSYNgzO9Rb2vZQ
 qHfeR99FDLb5/H2rhk7wL/nkuC3nqG6bVg1jLiPhaeqfjqSmjk9uwPDZ0Kw5d5AhzE93GIszc2w
 ylw25
X-Gm-Gg: AeBDieupe3l3onRMcRsqR9aIY2Xe2oIrqv0xjO1AlR6C718Ie0j24rJieEnejbkPHTn
 k7TQMpB9mMdAUuEJ66ExQX4q9tjcXmCKIRSpnOIGD4ODpXBBIk3975dHG9TmXJXurV2qblXMmFq
 BasINPHfo3xu/vznyn7zMZKpJ53YCPubcDc7YnKPkv+xK0fnpYkRgb7tbY0Agi5Tizxuv9nnXdB
 lum3LY7+mivaqj8FpTADiwzunLWxSl37B0n1FsfYelalan4QUVd2P0YIZ5+PSmnxvssUocApIbw
 yTaU+iETTYpVdN2oaBwmEHemjUI7Q2Oon7i7dMEfvM20FD19TsWnXf0Qs/QU0ylt3aTiZAJfTml
 ++ik6S+WJspWSwNHyE/x4T3JMLarXRFVJcQt6JqwnVEYYdR3twlStIO8C97THV69kJq7N0G7kju
 5dq4wivRLqs0qpJ+czUsIwHOO/abKoLQy4twKSgR9AJkxKWQ==
X-Received: by 2002:a05:6830:6d46:b0:7dc:da80:42c3 with SMTP id
 46e09a7af769-7e1deec854emr6376663a34.1.1778197473410; 
 Thu, 07 May 2026 16:44:33 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm84320a34.23.2026.05.07.16.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:44:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 20/60] target/arm: Split vector-type.h from cpu.h
Date: Thu,  7 May 2026 18:43:33 -0500
Message-ID: <20260507234413.643512-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

We want to be able to reference ARMVectorType etc from
common code, so move it out of cpu.h.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h         | 38 +---------------------------------
 target/arm/vector-type.h | 44 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 37 deletions(-)
 create mode 100644 target/arm/vector-type.h

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 24707ac085..5c98a07f70 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -34,6 +34,7 @@
 #include "target/arm/gtimer.h"
 #include "target/arm/cpu-sysregs.h"
 #include "target/arm/mmuidx.h"
+#include "target/arm/vector-type.h"
 
 #define EXCP_UDEF            1   /* undefined instruction */
 #define EXCP_SWI             2   /* software interrupt */
@@ -139,43 +140,6 @@ typedef struct ARMGenericTimer {
     uint64_t ctl; /* Timer Control register */
 } ARMGenericTimer;
 
-/* Define a maximum sized vector register.
- * For 32-bit, this is a 128-bit NEON/AdvSIMD register.
- * For 64-bit, this is a 2048-bit SVE register.
- *
- * Note that the mapping between S, D, and Q views of the register bank
- * differs between AArch64 and AArch32.
- * In AArch32:
- *  Qn = regs[n].d[1]:regs[n].d[0]
- *  Dn = regs[n / 2].d[n & 1]
- *  Sn = regs[n / 4].d[n % 4 / 2],
- *       bits 31..0 for even n, and bits 63..32 for odd n
- *       (and regs[16] to regs[31] are inaccessible)
- * In AArch64:
- *  Zn = regs[n].d[*]
- *  Qn = regs[n].d[1]:regs[n].d[0]
- *  Dn = regs[n].d[0]
- *  Sn = regs[n].d[0] bits 31..0
- *  Hn = regs[n].d[0] bits 15..0
- *
- * This corresponds to the architecturally defined mapping between
- * the two execution states, and means we do not need to explicitly
- * map these registers when changing states.
- *
- * Align the data for use with TCG host vector operations.
- */
-
-#define ARM_MAX_VQ    16
-
-typedef struct ARMVectorReg {
-    uint64_t d[2 * ARM_MAX_VQ] QEMU_ALIGNED(16);
-} ARMVectorReg;
-
-/* In AArch32 mode, predicate registers do not exist at all.  */
-typedef struct ARMPredicateReg {
-    uint64_t p[DIV_ROUND_UP(2 * ARM_MAX_VQ, 8)] QEMU_ALIGNED(16);
-} ARMPredicateReg;
-
 /* In AArch32 mode, PAC keys do not exist at all.  */
 typedef struct ARMPACKey {
     uint64_t lo, hi;
diff --git a/target/arm/vector-type.h b/target/arm/vector-type.h
new file mode 100644
index 0000000000..d94c0d986e
--- /dev/null
+++ b/target/arm/vector-type.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef TARGET_ARM_VECTOR_TYPE_H
+#define TARGET_ARM_VECTOR_TYPE_H
+
+/*
+ * Define a maximum sized vector register.
+ * For 32-bit, this is a 128-bit NEON/AdvSIMD register.
+ * For 64-bit, this is a 2048-bit SVE register.
+ *
+ * Note that the mapping between S, D, and Q views of the register bank
+ * differs between AArch64 and AArch32.
+ * In AArch32:
+ *  Qn = regs[n].d[1]:regs[n].d[0]
+ *  Dn = regs[n / 2].d[n & 1]
+ *  Sn = regs[n / 4].d[n % 4 / 2],
+ *       bits 31..0 for even n, and bits 63..32 for odd n
+ *       (and regs[16] to regs[31] are inaccessible)
+ * In AArch64:
+ *  Zn = regs[n].d[*]
+ *  Qn = regs[n].d[1]:regs[n].d[0]
+ *  Dn = regs[n].d[0]
+ *  Sn = regs[n].d[0] bits 31..0
+ *  Hn = regs[n].d[0] bits 15..0
+ *
+ * This corresponds to the architecturally defined mapping between
+ * the two execution states, and means we do not need to explicitly
+ * map these registers when changing states.
+ *
+ * Align the data for use with TCG host vector operations.
+ */
+
+#define ARM_MAX_VQ    16
+
+typedef struct ARMVectorReg {
+    uint64_t d[2 * ARM_MAX_VQ] QEMU_ALIGNED(16);
+} ARMVectorReg;
+
+/* In AArch32 mode, predicate registers do not exist at all.  */
+typedef struct ARMPredicateReg {
+    uint64_t p[DIV_ROUND_UP(2 * ARM_MAX_VQ, 8)] QEMU_ALIGNED(16);
+} ARMPredicateReg;
+
+#endif
-- 
2.43.0


