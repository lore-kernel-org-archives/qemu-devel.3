Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AEFE9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Mi-0007K2-6h; Thu, 19 Feb 2026 05:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Mg-0007IP-2Y
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:34 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MZ-00067A-OQ
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:33 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso6916565e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497266; x=1772102066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m8XAwLErH5Rcrg8uudfF2MM7yDSTJj5Y5UUFSlFxuTA=;
 b=XcGPTiiTd3faOn8bIRSRd4AG4trlt74Tdq4eZAIoLRRjYtjAT8XR1s8f0FjBJyZWGa
 c2fMJQhvzsHrkeAYryM1azAL5iM1cmnqYOJSfioRUd9bU8DiMr7/UBiqLAcSoC1EH7V7
 kQ9WRNeWyKXmg8rUr3roKVsc2ZqONfRwkdS/3Lx86L+NKOyyX7B5+lD8Zx2YQO8J1FMa
 32tl/Z5RuC0qOCKunEyZ3bqXYKl6zeDJB3eVgdkGpoHDnj0jezJe8GGYqKb0DvDBGtIm
 Lii5nK/S3SnMW1TmZh455JtcFOjv6RXOrNy+79feoa8LDPwp6YL0yKU86GcqiR0ZuZKn
 cOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497266; x=1772102066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m8XAwLErH5Rcrg8uudfF2MM7yDSTJj5Y5UUFSlFxuTA=;
 b=n2Fr0BPO8jPEzS0swI9Aq/cZcVAub0ahDb9yprt5fG4RDTgvucwhyyPaRFdW8+cu9Z
 bl0xqfx2aVgIi32CwOjdMnSfnJf8uezase0NXz3SLRMEGRFbKTHzhZJw90Vi71FKHOPK
 wja1WhjybXYPrZbruQLNEM6XHVWA+4YmUqxjme1poaofFCXuDaSXgc7vGO2lu0s+E0NF
 cngoOedOspGoUyUDqIz9Qu79oS4pCPOFUX1MOcnANI0+kNEpRn672eN0KOScxAIg2ex4
 LpPgZrZZQmapWwdOficraGVYrvFZ97vRrdvLkx39/AgP/Zuv8ORhBuW8K0y5bbui50rx
 nQrg==
X-Gm-Message-State: AOJu0YySrK8mjdcjTkMJ4BbhHxap7+Fa6qHtgp4HeASZ2mSjeUUpKsRR
 lQ2lnsRFfFj+TzlRL4MapVHGuDTnq13qHbvdvuLWYYIkc+KU1Lk1pL0hZC1Ll/DILeDlsow1toY
 37dKx
X-Gm-Gg: AZuq6aL5pe2+/6HXV4rYSm5IYnvEMlb+kCTuot/kXmD2zkOHo44pa/NgdADJvqUuQz1
 /xcbeekGSmKabG8eeISECOvCBKe97l5yuES+BU2fcXMzWE4Ifuok2kNIH9eYavdg1BW5sOHSrHW
 r3LikYOO2YZWVmGd1nkj4zCLhbEUD7eAwcKyQTuuCOhP0toMn3ueZQq1LUgRpOJAqdAlgBAdKgI
 SIO+aip2VlSonoeghLuveNIUfIEsqGPvN+SDpGfOfaRJsTx/yAwUFOr66IlsjgBeEtIYJ2gMzZi
 rjuP05gWXglO6NAGIzQ/G7hAA9qcM+O8DbPJ/LeBPt8nGWqkDiNrqqGuuNz1ZsZq4Qx+YKVwYRP
 QObSF9tguxUzzLOFMOcsgJIyhIUgDB+kzUbvInqDeh2vS4RcEOUq1GbIqtvxjzXcIxynxWOChU4
 tjFNnhOaYs4meOwOBwZwOKEpgQD8Df7/S4k2v4sQcq166tEL+gGQxHFub7kYNXNqMsNGdFUZ6Gi
 7EUon9wKdrwUQpIElrprkqfVcxyqZU=
X-Received: by 2002:a05:600c:c176:b0:483:6a8d:b2fc with SMTP id
 5b1f17b1804b1-48398a425bbmr68682385e9.8.1771497265864; 
 Thu, 19 Feb 2026 02:34:25 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/32] target/arm: extract helper-mve.h from helper.h
Date: Thu, 19 Feb 2026 10:33:54 +0000
Message-ID: <20260219103405.3793357-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

A few points to mention:
- We mix helper prototypes and gen_helper definitions in a single header
for convenience and to avoid headers boilerplate.
- We rename existing tcg/helper-mve.h to helper-mve-defs.h to avoid
conflict when including helper-mve.h.
- We move mve helper_info definitions to tcg/mve_helper.c

We'll repeat the same for other helpers.
This allow to get rid of TARGET_AARCH64 in target/arm/helper.h.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260219040150.2098396-4-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-mve.h                            | 14 ++++++++++++++
 target/arm/helper.h                                |  2 --
 target/arm/tcg/{helper-mve.h => helper-mve-defs.h} |  0
 target/arm/tcg/mve_helper.c                        |  4 ++++
 target/arm/tcg/translate-mve.c                     |  1 +
 target/arm/tcg/translate.c                         |  1 +
 6 files changed, 20 insertions(+), 2 deletions(-)
 create mode 100644 target/arm/helper-mve.h
 rename target/arm/tcg/{helper-mve.h => helper-mve-defs.h} (100%)

diff --git a/target/arm/helper-mve.h b/target/arm/helper-mve.h
new file mode 100644
index 0000000000..32ef3f6466
--- /dev/null
+++ b/target/arm/helper-mve.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef HELPER_MVE_H
+#define HELPER_MVE_H
+
+#include "exec/helper-proto-common.h"
+#include "exec/helper-gen-common.h"
+
+#define HELPER_H "tcg/helper-mve-defs.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef HELPER_H
+
+#endif /* HELPER_MVE_H */
diff --git a/target/arm/helper.h b/target/arm/helper.h
index f340a49a28..44c7f3ed75 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -7,5 +7,3 @@
 #include "tcg/helper-sve.h"
 #include "tcg/helper-sme.h"
 #endif
-
-#include "tcg/helper-mve.h"
diff --git a/target/arm/tcg/helper-mve.h b/target/arm/tcg/helper-mve-defs.h
similarity index 100%
rename from target/arm/tcg/helper-mve.h
rename to target/arm/tcg/helper-mve-defs.h
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 63ddcf3fec..f33642df1f 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "helper-mve.h"
 #include "internals.h"
 #include "vec_internal.h"
 #include "exec/helper-proto.h"
@@ -27,6 +28,9 @@
 #include "fpu/softfloat.h"
 #include "crypto/clmul.h"
 
+#define HELPER_H "tcg/helper-mve-defs.h"
+#include "exec/helper-info.c.inc"
+
 static uint16_t mve_eci_mask(CPUARMState *env)
 {
     /*
diff --git a/target/arm/tcg/translate-mve.c b/target/arm/tcg/translate-mve.c
index b1a8d6a65c..4ca88f4d3a 100644
--- a/target/arm/tcg/translate-mve.c
+++ b/target/arm/tcg/translate-mve.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "helper-mve.h"
 #include "translate.h"
 #include "translate-a32.h"
 
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index c90b0106f7..580ec86c68 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -28,6 +28,7 @@
 #include "cpregs.h"
 #include "exec/helper-proto.h"
 #include "exec/target_page.h"
+#include "helper-mve.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
-- 
2.43.0


