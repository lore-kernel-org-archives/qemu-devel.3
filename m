Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2477D232E1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56h-0004Lp-HJ; Fri, 09 Jan 2026 00:32:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56d-0004GN-I8
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:15 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56b-0003hJ-FC
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:15 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-34ccdcbe520so1320267a91.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936732; x=1768541532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GLPfdmhylIgX6nfX4OdRRUnfm7zzB+KSHASixl5iY8Q=;
 b=InUjiuSxyFED6znf2uW7Cx3EKNg0aDftGWhViONX7RCGBGWbCOpm9gliJFbg/ThMRA
 oLFV3TgZC7/tVHC42IvUswZNvznRRbVHO2ZZ4aDet8AvfmfC9IdsQhgxvhJkoMN3pOdj
 Az+7grYJd7RnBhHgKltimpm8nHAYKIXsyLI6gHoQG7VxIvDTip9c3lgvWd6r0km5as5q
 YlJggr5t39JQylIjDrwZnmofnrLgxR1BnyK3nd0D9pVfrufUPtzS5EYMmnprQ9S0tipR
 DO7wANcZ2QolF2ruesd84m4dRJaSq/pAJTAVK2XdypZEh9/hPKktlJyFxgnxANX7rGjb
 C2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936732; x=1768541532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GLPfdmhylIgX6nfX4OdRRUnfm7zzB+KSHASixl5iY8Q=;
 b=HMBKCF4SPQYO9QPl9AzaOL7zCQSH1VHJHg5vAt98lFCV1q/94IBQOaEbs1I1zWRqsx
 0OLMWmVcyq3QeFEPYWeWqDoM8OHEGx+z8HbMZwqVkqJfddoHu5zorkxRMGCZYEStni7g
 bjpJilpHgVkfTVaVmTDFLg+G2azMVXUmCP6AJJPjCLMEZHfCM5QKxmIiaQbEbAfvK1Q0
 JTYJmbJi7hxIQ0arCU+ZwRYEWLGUygAGe7/E4/5fQEsKGIrreTuL06tPEjxaxht3THeh
 C4TR1T0nbw0SNCBQNS12xFbZILJJ5MdDVxajGJIvinIv1V+4fIT/dciKdfTzRrZ841U5
 RIbA==
X-Gm-Message-State: AOJu0YyxuLFhFxI/KTJsU4KDhl/lxwP1dibHO/t7KBn/onTk/WNFqnaD
 ECn0kQjs0vzs3cwwWcGjLQZ3B3ZBEGS6OloI323fetdW+R+hoo8XSfattklL9yQJ4/S7IGmxJqe
 BnWCG
X-Gm-Gg: AY/fxX7Q70Al+BtahERMReUxPD9ZUs/11dIKYJY+ENfpOpM1+GXQ1sQkf3YdnOXNYAh
 Gx56yny5v0vLL2eTBf4htFhvXYQSQQYGwnJmCtPP/NEcs9hAMoPOmvCHa40G2/CsXC1IDdCFn6t
 W8+skT3sBn7ahQSSpPs7MOS6PU2v4cN31AC0VBSj2Y5IKrMk68aP9jluru1RrPJTTf+ziYIzOwC
 aFoJq5UshZrib9OVqOYVlNdzyk8SvEGwivwTqyJ4iEONDZxaY1Xph9GdTL1qgChRcPLzuftSTW7
 9kOLRkw3skcD5TxzsvUnCCOLJ1R6jqBoUggMSZp9A4uTteOxTypy6v16FdV+4ZResxsZk5HnCc2
 zzXQo8wjd4Bp3RhJrWW2X2X0zfQltSVFYqxrLb6bSQlZ60mc9XYeHlUvfIsB9OGaD6QOxTgkA96
 A9hYJfvCASh4TjymKt8ZM6CPJ+nd0Lu09l7dVJEbrKeT/kycz0Ha7f8hYdpK4/RLZl
X-Google-Smtp-Source: AGHT+IFAtwGDvwt/rrtUGU/Z2nvtsH6tyR+ykcMLTn4GR20oHY6xGJoO39+fW4Ay9pKmP83FNqREYg==
X-Received: by 2002:a17:90b:4f81:b0:34f:5039:5ac7 with SMTP id
 98e67ed59e1d1-34f5f84a94dmr11384205a91.6.1767936731542; 
 Thu, 08 Jan 2026 21:32:11 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:11 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 06/29] target/arm: extract helper64.h
Date: Thu,  8 Jan 2026 21:31:35 -0800
Message-ID: <20260109053158.2800705-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

This allows to get rid of TARGET_AARCH64 in target/arm/helper.h.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.h            | 6 ------
 target/arm/helper64.h          | 5 +++++
 target/arm/tcg/gengvec64.c     | 1 +
 target/arm/tcg/helper-a64.c    | 1 +
 target/arm/tcg/mte_helper.c    | 1 +
 target/arm/tcg/pauth_helper.c  | 1 +
 target/arm/tcg/sme_helper.c    | 1 +
 target/arm/tcg/sve_helper.c    | 1 +
 target/arm/tcg/translate-a64.c | 1 +
 target/arm/tcg/translate-sme.c | 1 +
 target/arm/tcg/translate-sve.c | 1 +
 target/arm/tcg/translate.c     | 9 +++++++++
 target/arm/tcg/vec_helper.c    | 3 +++
 13 files changed, 26 insertions(+), 6 deletions(-)
 create mode 100644 target/arm/helper64.h

diff --git a/target/arm/helper.h b/target/arm/helper.h
index f340a49a28a..2af4ee4b51b 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -2,10 +2,4 @@
 
 #include "tcg/helper.h"
 
-#ifdef TARGET_AARCH64
-#include "tcg/helper-a64.h"
-#include "tcg/helper-sve.h"
-#include "tcg/helper-sme.h"
-#endif
-
 #include "tcg/helper-mve.h"
diff --git a/target/arm/helper64.h b/target/arm/helper64.h
new file mode 100644
index 00000000000..b6829779662
--- /dev/null
+++ b/target/arm/helper64.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "tcg/helper-a64.h"
+#include "tcg/helper-sve.h"
+#include "tcg/helper-sme.h"
diff --git a/target/arm/tcg/gengvec64.c b/target/arm/tcg/gengvec64.c
index 2429cab1b88..e0276426874 100644
--- a/target/arm/tcg/gengvec64.c
+++ b/target/arm/tcg/gengvec64.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#define HAS_HELPER64
 #include "translate.h"
 #include "translate-a64.h"
 
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index ba1d775d818..e78bc5acaf4 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -21,6 +21,7 @@
 #include "qemu/units.h"
 #include "cpu.h"
 #include "gdbstub/helpers.h"
+#define HAS_HELPER64
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 #include "qemu/log.h"
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index bb48fe359b8..3b63fd11eb6 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -31,6 +31,7 @@
 #endif
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
+#define HAS_HELPER64
 #include "exec/helper-proto.h"
 #include "exec/tlb-flags.h"
 #include "accel/tcg/cpu-ops.h"
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index c591c3052c3..7073023d001 100644
--- a/target/arm/tcg/pauth_helper.c
+++ b/target/arm/tcg/pauth_helper.c
@@ -22,6 +22,7 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "accel/tcg/cpu-ldst.h"
+#define HAS_HELPER64
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "qemu/xxhash.h"
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 075360d8b8a..0ae0f80a892 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "internals.h"
 #include "tcg/tcg-gvec-desc.h"
+#define HAS_HELPER64
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/helper-retaddr.h"
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index c442fcb540d..e432a853d96 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "internals.h"
 #include "exec/page-protection.h"
+#define HAS_HELPER64
 #include "exec/helper-proto.h"
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index cde22a5cca7..b066da37891 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "exec/target_page.h"
+#define HAS_HELPER64
 #include "translate.h"
 #include "translate-a64.h"
 #include "qemu/log.h"
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 091c56da4f4..f667b4374f9 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#define HAS_HELPER64
 #include "translate.h"
 #include "translate-a64.h"
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 07b827fa8e8..96bef4bbccd 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#define HAS_HELPER64
 #include "translate.h"
 #include "translate-a64.h"
 #include "fpu/softfloat.h"
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 63735d97898..8988c852983 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -26,6 +26,9 @@
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
 #include "cpregs.h"
+#ifdef TARGET_AARCH64
+#define HAS_HELPER64
+#endif
 #include "exec/helper-proto.h"
 #include "exec/target_page.h"
 
@@ -33,6 +36,12 @@
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
+#ifdef TARGET_AARCH64
+#define HELPER_H "helper64.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+#endif
+
 #define ENABLE_ARCH_4T    arm_dc_feature(s, ARM_FEATURE_V4T)
 #define ENABLE_ARCH_5     arm_dc_feature(s, ARM_FEATURE_V5)
 /* currently all emulated v5 cores are also v5TE, so don't bother */
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 33a136b90a6..c85983f5313 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -19,6 +19,9 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#ifdef TARGET_AARCH64
+#define HAS_HELPER64
+#endif
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
-- 
2.47.3


