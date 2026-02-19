Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD200E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Mk-0007MW-DW; Thu, 19 Feb 2026 05:34:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Mj-0007Kr-0X
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:37 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Mf-000683-Iy
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:36 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso6916865e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497268; x=1772102068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U/4/h1gAZ4SVEkj37HthrZibc6nn4aDr8GgBSSnZtj8=;
 b=EGog1bobRUxOVOhqexxBxR9QomYIiaw8MpKUPL+7CCXgY6dLc3QQ9ZBi4rr6bqFiNK
 BePiy7XU8Mj2096I4THaWrTc1jiWuHIbsPIbaRdXqgC+a01DaYsHscFpVx4I8PAiuJ0q
 VnD8iM1wstM424e0iBoQNT060/Nr5e6DIAQb0rswq2vfW+ox34XkQqMZr2PSzXXjyulJ
 DTVuhIRe4jJ9nI3i9YWZ+K+tymhp0Sn0U9RNWqjkkiYYnissBsIc+8Hdc9bnrHrScwdi
 PkeaWEC4NIL0V7ZG8pvZDW/vKdXrYz53jXlT+xK81Kp99uYo2OehgHaLR6jlVheCu+4s
 zUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497268; x=1772102068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U/4/h1gAZ4SVEkj37HthrZibc6nn4aDr8GgBSSnZtj8=;
 b=nGqepQmT+Aw5czXSTJHaNQFNcjU4DrGGnBDzGIJgq3Oz+ykaRe1SkfWkbBW8GPKEuO
 vXxk/zbaCr+GpwuhYGFZn5MUkQ8pJ6PVnoMAJkbaJ2PnpfMuBT9JPgfST5FC9eynXFaO
 14i9QoWY98uW0ufUtQPF4fKY7p2tqyN9uxcPyC+Fglp38jqOqo2QdrR+v/pJGg9jDENG
 6XkHYqW0vcVDoH6lrvl54Dxf9nMD8nddNtYt/CeoIahiBEgNifjUd//aOGLnSKOdjEzu
 bOFV9mVr/+g5KYUQ4yvZIOCmDx75bNO2U0Zrz+xaz+pL7qKI0ua9MCEAygy7Esb6lA6A
 +ahA==
X-Gm-Message-State: AOJu0YzbgmaKhcHXCo+Y6BxL5Fgab0sJbLR91aWcWhfxAlV7J6aytt4w
 Uq+JzsVE3D4uF18ATbSHzMVAerby5vTtnwYu4hyB9gQp3PYEa714JuMIhq/7sEUTxrt/lzhAhwC
 CN3DZ
X-Gm-Gg: AZuq6aK4Jsco/L7fBSRbma1949WVGfPH7VfgqKRorjbRfc/wmFAZU8fQBsNiQ90h/Mj
 2+vrTJx1d40S8g4MPDGz2JKyTXR0uSHLSeMKg8lor21MS+tAJWTR0vRAy5O+Z4mxV0SJrPlYy/g
 71K+7UDfK6ktmphzp0gouoEBsD235nL3QTS5j1Py6xvHOD9g3JrOziJdaT5yCeY2R2Okt0+MzNW
 gOIRvV/eb2VC1GRGP6B+l5M3dCHnIEZ8fMMWwao4YdqGNzFo435kHNWTWUfWjrTCNOb4zupGKKD
 /Nk5foLDRtvVBClK3rkmcb51wCAOx+2OrVTlIe0NAMLzPj3cazRkLPc7v+BweQFIZ7GEb76u1ZI
 TG5n9Jud/DrztnYcf3uXCa5hKl1PPiVytb8xEqmeSzryWjmw52APMKW/g2DDOoMdJKJGTUVkUK5
 GRc4cUfQ35KvMRPXEKfhjhms21HmTIj7wOs0YRhVHe75M7jPNdEOYXzzILHBXjTZeM5DalIT31k
 55xbwOh3gzJI1y1Bi6MfRf5bzP/nPc=
X-Received: by 2002:a05:600c:1f0f:b0:47d:8479:78d5 with SMTP id
 5b1f17b1804b1-48398a42873mr85750495e9.7.1771497268514; 
 Thu, 19 Feb 2026 02:34:28 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/32] target/arm: extract helper-sme.h from helper.h
Date: Thu, 19 Feb 2026 10:33:57 +0000
Message-ID: <20260219103405.3793357-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260219040150.2098396-7-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-sme.h                            | 14 ++++++++++++++
 target/arm/helper.h                                |  4 ----
 target/arm/tcg/{helper-sme.h => helper-sme-defs.h} |  0
 target/arm/tcg/sme_helper.c                        |  3 +++
 target/arm/tcg/translate-a64.c                     |  1 +
 target/arm/tcg/translate-sme.c                     |  1 +
 target/arm/tcg/translate-sve.c                     |  1 +
 target/arm/tcg/vec_helper.c                        |  1 +
 8 files changed, 21 insertions(+), 4 deletions(-)
 create mode 100644 target/arm/helper-sme.h
 rename target/arm/tcg/{helper-sme.h => helper-sme-defs.h} (100%)

diff --git a/target/arm/helper-sme.h b/target/arm/helper-sme.h
new file mode 100644
index 0000000000..27c85fdeef
--- /dev/null
+++ b/target/arm/helper-sme.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef HELPER_SME_H
+#define HELPER_SME_H
+
+#include "exec/helper-proto-common.h"
+#include "exec/helper-gen-common.h"
+
+#define HELPER_H "tcg/helper-sme-defs.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef HELPER_H
+
+#endif /* HELPER_SME_H */
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 2f724643d3..b1e83196b3 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -1,7 +1,3 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
 #include "tcg/helper.h"
-
-#ifdef TARGET_AARCH64
-#include "tcg/helper-sme.h"
-#endif
diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme-defs.h
similarity index 100%
rename from target/arm/tcg/helper-sme.h
rename to target/arm/tcg/helper-sme-defs.h
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 075360d8b8..7729732369 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -22,6 +22,7 @@
 #include "internals.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "exec/helper-proto.h"
+#include "helper-sme.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/helper-retaddr.h"
 #include "qemu/int128.h"
@@ -29,6 +30,8 @@
 #include "vec_internal.h"
 #include "sve_ldst_internal.h"
 
+#define HELPER_H "tcg/helper-sme-defs.h"
+#include "exec/helper-info.c.inc"
 
 static bool vectors_overlap(ARMVectorReg *x, unsigned nx,
                             ARMVectorReg *y, unsigned ny)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 31fb2ea9cc..5d261a5e32 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "exec/target_page.h"
 #include "helper-a64.h"
+#include "helper-sme.h"
 #include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 463ece97ab..7d25ac5a51 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "helper-sme.h"
 #include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index bd6be68d81..5bace3fda1 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "helper-sme.h"
 #include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index bc64c8ff37..a070ac9057 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "helper-a64.h"
+#include "helper-sme.h"
 #include "helper-sve.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
-- 
2.43.0


