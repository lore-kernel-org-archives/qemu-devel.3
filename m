Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF090E9129D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 04:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voDM9-0004Kz-5n; Thu, 05 Feb 2026 23:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voDM7-0004JY-2U
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 23:22:07 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voDM3-0003Q1-8X
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 23:22:06 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c61343f82d7so95317a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 20:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770351722; x=1770956522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SLG6GFjz6gMYPUgqxMsYfEaJwPICYaIcXQ6XuIJ4wGg=;
 b=TUOTn8GEggHHjtDWJ9x7FP7zDZGoct7wP0HprIrwdy1nHlxftdD+rPymEbwCAsctKi
 K/eYxDrZggOkB61uwlRtiB0OUfO6xyaBnrVPeVedYaa870bwqRfmeSL/IOY01236oYaW
 fB+xybqeik8fv4TRQ0dNRFWhAovA8/YgiaVdUQrDu6PhxES+xaL/qFfMvx7GJhcl15vl
 cgOaQRPBQJTPIBRrZLlWGtedn9sAuBlpukhyGRlQRr8dcXiPnOuOiDI2JqN40W/eBSCa
 bAs2PucrE5WTJXZVskagMLSzkOsMOxEc2GV6gccR3Ceg2oDu8S0o+nnVLSvM+skpVAFk
 SSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770351722; x=1770956522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SLG6GFjz6gMYPUgqxMsYfEaJwPICYaIcXQ6XuIJ4wGg=;
 b=OpOBZUzxjiD3HzKGOag1vQvR4E4z58K6dP90ban/CMvoGbkiwDwtOrhZ15bptpPA6V
 QP0Ajb0RucpxClwqSSiR8pgm13sGoXb8noBQxiz8LHibe3g5potvGyisA638lVWzzI7P
 s7XBH7LdE/vh1qgZb60cVre+Qn1EsdukFqfP5ZGJIYI0Fm0OX6uyjlSgkVHDeVnertCa
 9sgcbLVUWPRKXkfZbrDmq7Mv0+QlcjXqGKSWQ3MoLImKYB5unZhuH4UlX84pSXpDFKyF
 k+ISwqiEhkjlQEcuEpq7XDuBhDSRGeAJOTfpe2Mz2bEjLV/ZzQsySDn9nQqwBD9oGdUi
 hzjw==
X-Gm-Message-State: AOJu0YzI/2fYmeY2k+agU83WjDZ+qQSQYL+Pm1euF6CdXQelYO6I7JdF
 b1r3HotBQEgQwYCvA63cMQIj7GqlOY0vFfBiOtBYN0/kdu8vi3yCuj3tPRLpTTSFFZyi3/O5Ebu
 jMuJ+
X-Gm-Gg: AZuq6aK1nI3WL/DAYE7jxsm+m55mQfmBWfJnq9jjDuXKAzXsGTf/M5OpiQWCnfDRiHM
 drLyx/pRwqtBVM9BVf9KMzwB33CwVuplPW9Wme5G9ew2+t+sTtqWAYbOBgtzpP5E4Q86L9Ss/rr
 sP5/RLrGeqR2SWdbOrRGOw/x9n3fRkaoV2t/icVSasuuCp7eIDsylgfmk1roosblToJiBjOOkY9
 etSma8W8HavPEcW8s7YUaTiRQhGvQPKeUCGarIIqRRLxDrjeoqchekAgs6/eoTRo9nDtMSclOuq
 /9c3SmtNwGMHj40xZsNWOP+5T3tLv5Wt0G2wEJ07bqkzxACnQ0Zp8K58CytEchuBrzP1p7IgztA
 cOk7c8eOJE6iurxhGQCTKp+66RWFZld9yyRoyumZjaDJzVmPFxKgbUWEmKr4TqrmG3keGS2/ggx
 zeQxYQiHovdHQncjZfcthT5k5Dl47Xs/yVcnN3uNQrbsC4ZredNW9AD5Q5kL04VY8G
X-Received: by 2002:a17:90b:3a05:b0:33b:a906:e40 with SMTP id
 98e67ed59e1d1-354b3c3823amr1156910a91.2.1770351721846; 
 Thu, 05 Feb 2026 20:22:01 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8244168fdf5sm926914b3a.17.2026.02.05.20.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 20:22:01 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Richard Henderson <richard.henderson@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 02/12] target/arm: extract helper-mve.h from helper.h
Date: Thu,  5 Feb 2026 20:21:40 -0800
Message-ID: <20260206042150.912578-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206042150.912578-1-pierrick.bouvier@linaro.org>
References: <20260206042150.912578-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
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
index 63735d97898..febb7f1532a 100644
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


