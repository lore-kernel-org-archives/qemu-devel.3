Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334FBE9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 04:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsvFD-0008R2-OZ; Wed, 18 Feb 2026 23:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsvF4-0008MA-6q
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 23:02:18 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsvEz-0001DO-8B
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 23:02:17 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so4162255ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 20:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771473732; x=1772078532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZBh+fW1mApPtLG6aGnrKPAIWmAmzNuN5929rjSWR418=;
 b=jubqbz5CatuhHK8bQ74J/CFroNI+AdO0ysG2eVHg7AxEvc30juLYDAgp6YlaaLt0SE
 RRNs3oenEIdaMccQmLIvPYsd0L2mkwgPbn/v4arTkuoM6h8uCvbyPfVT5NHv3ZGcCvsx
 BZbUTD5Cotdw58oHoLuEDzMDuQ6jbCFWiRlFqpsmx9VBXbmmc/Y4LYqhTic8x7xwmH7Y
 J0NC+VFl3yUxO772wLZ+HhytVNBdqSFuiNPekgCesG/wV0yJMph2gwqv74F3q3jkghWY
 xGPGUWYrIrZVn2RdaQYf7QvYnr5Xczo6W4inhslfoAckq0WddPe8/DanMg6ZLZK6n6pN
 Ytpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771473732; x=1772078532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZBh+fW1mApPtLG6aGnrKPAIWmAmzNuN5929rjSWR418=;
 b=Z2xslFMdTd3h2kNIlOtsDlC2ekl7gxqnzKfq8n1ZYTiHiSj8snX6MHU8HOBbKq8n4V
 95wB2Pau6MPIsTisgcb8oJ+efn37ErAv3HLu1dPuqvbPI3UVAfUwfsRvtr6EpQGXLp5p
 ifgdI9yC1yBeOTr4ckwjYu0lAXIyfBJ+/R4xviMKGjYPo1HB/C5y9zeJ172zqxA9RXWZ
 vaCsC9924sYXq8WSGhfS8LyLUsQ0PlIXM39AgeuZ9KGLSCKGPjUzoxLZNxd37VmYieFm
 rcfo6bwDM8uBUkmpeyZlCjWslC960wbkJob3fcKlNHD71lPZc+CGLK7v6XT5BgQ1ElOx
 fjxQ==
X-Gm-Message-State: AOJu0YzAlPGDd1B4r7Mdf/MQ4ujsSDE8GUFjjhMMSOnVebbXe3x3A/6/
 Klne9pDXusHGHV2aN2Lf7ZUBBK8KMPFh4LDbsVLIzdU0Oz/cvr6SIkAs36lcyYbD2fJW1lBNut4
 LXO3O
X-Gm-Gg: AZuq6aKBx2FxUcL9WB6ru+ZvtaBUImTW9O4M/mx/AiEIX2dnonPPO8/X4tVcsGgUT5f
 i7N9E6CQtZhT085tTI1+o9doSv/abiKP0nIq1yVEyQMlcbj/ZaPGDn5rOcrh1YYsZjuUH9GI7n7
 G0hmAN86k5uoChMLIuR1lFulKny7BlF4uN/3043aaeDPJPzp4GSK0nthwPaLy/fvtntv9rGZMhz
 6PrZEPTS+cwCopWetJu4TuN4ovYzlOuEdr84U1NL2kawYm61czwq3GIrB1V1jUE42VerJRpLMTS
 saqFuaVDaupoT8YXAnpuvgSYCz/7YIQ/b8Bw+ZmnVTBp6pxWXSpq4ObTsXnVMZy9zAL1Bsq2qNM
 UvM6IumfWsDkSyFiru+NnWqpV0NF/Jt6dcKr8/tyY3qlx9PQHCTfwCegbnDeZ6If5QV6Dm85AE0
 1LuSKxVOW+K+xZg6DaNBv4kevS76Vi0jo+i8ZJMWrx2JcxN4YbvLQsBacWjaPhz+LUhf53JyTy3
 jvM
X-Received: by 2002:a17:903:46cc:b0:2a9:48ce:b5f5 with SMTP id
 d9443c01a7336-2ad50f8e23cmr33186185ad.51.1771473731894; 
 Wed, 18 Feb 2026 20:02:11 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a73200asm147636225ad.36.2026.02.18.20.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 20:02:11 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH v4 03/14] target/arm: extract helper-mve.h from helper.h
Date: Wed, 18 Feb 2026 20:01:39 -0800
Message-ID: <20260219040150.2098396-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219040150.2098396-1-pierrick.bouvier@linaro.org>
References: <20260219040150.2098396-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
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
index 00000000000..32ef3f64661
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
index f340a49a28a..44c7f3ed751 100644
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
index 63ddcf3fecf..f33642df1f9 100644
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
index b1a8d6a65c0..4ca88f4d3a3 100644
--- a/target/arm/tcg/translate-mve.c
+++ b/target/arm/tcg/translate-mve.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "helper-mve.h"
 #include "translate.h"
 #include "translate-a32.h"
 
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index c90b0106f75..580ec86c68c 100644
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
2.47.3


