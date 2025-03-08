Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C983DC28B2E
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr39W-0005Gk-Is; Sat, 08 Mar 2025 18:00:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38a-0004dS-JZ
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:20 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38Y-0005O4-Pr
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:20 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22435603572so21548485ad.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741474757; x=1742079557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p/ujorpqouqcIKko4tXnNA5urzRJSLGssu2DzutTfSc=;
 b=p5V5FVfca4F1oqg8C8kBe7SlDGYjAqCOvJla23Z1IAsC0S7zf0zmYoQxYh1c0OLNJb
 i/CEw5umRfKHav4mUH4eqiRaTG1Gjm9HDSUJSXXPcJWjBaNvmLMYAqX6tjcRLkDirj+I
 hzz69clCWLZi/Kg9dieF8xthULnRJLAIN3Nn2vdDeVS4qYcdqQyCO1L2/ixp9z4TsPrG
 aD7Y8A6GQioVJhkD5yfWRFkqKOuU4Od3HvKcMjMCvT2abNPq6ndKPtTy6BndoH8cZnSo
 xM08vuWIjyOwG1EYAootPlFOgJscRbqXbRQimJHRxVHfzGFxByKSLOKCO2IR3zJfiJI5
 yeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741474757; x=1742079557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p/ujorpqouqcIKko4tXnNA5urzRJSLGssu2DzutTfSc=;
 b=fUsJ1vKkP0IZy/RRoNfO7+lBagPIMi6dKSxPYAOgMFdPf0GNR+QfHxL9iYNkXtZWgZ
 yppCspeyxJWDqqRWoZ2MYhttnHRfSSTuOtf6cwRfbQ3AelmXYm3YzNFxdHeaP5p7SgTU
 M21+ileR0B4hBz9XuSn5vNzljDZ1aU1z4984jZjixfhSs+6AnIEhkR+lnAXl/3yh7t2E
 KrQS8BemS45D/wQj3fQL5wJSOuk0suRGDeXdUrF50PS4al0exk7RxVd2Sq2r6g0Gr4V8
 DBK7DYG3/5/dPHl1Ol+Ty8IuOFUczoUZcokdCVr48PKJiUNNeEqhl06PtEMHXfLCNXxr
 AakA==
X-Gm-Message-State: AOJu0YwZa5UUNyA1MDxuVpZ2VHgFart9tRomol6ewHZ45kRzALnpVDcE
 Ns7IK+IVWOmgS3gLJ441OjMbMIbpA/Yo0Jiw3kfJYdlRMiUU0ZBq4dj+dwSJJHUaywQmbYRj8Ek
 c
X-Gm-Gg: ASbGncvT1JbC9dTnRXzduPxIDfnyNz5ZiVaPTzQQYM5e1mFMq8HREcIEhF3FiBrtWLa
 8RBS4zWd9aQeWmIIYpw6b6pKLlaZSev+9Vb/S8pYpN5vFAOgdC8vZ+SAM/CiQRKwZFAd8Syfp7x
 YU9yQaanMdthvu/PbWVftk96ol+PatIofYjOnuy2e9S8DTzVJDFIkZnxlECKfGJJeTIaxYK5DE+
 QQFGayM/2ROos9Ky3aG9tumlUMb/s3fFPlbNcD0AP+FG4y3G5TON2QTWgmBA3TnmYepsiyFBi0v
 qxadC91uL7hWCr1u5sCId1HtOszxn3prNgdxhJkiRke3sG2oZU7TR4rZ2mteLGN9ucG8s7UXw+K
 9
X-Google-Smtp-Source: AGHT+IHX5OKd5NpDdGRwqNR2juOrvA9bVz/7yCfdk7Uj9EupSXlLOB3enWPEi1UiYDtoo2jlDFEQuw==
X-Received: by 2002:a17:902:e5d2:b0:224:e33:8896 with SMTP id
 d9443c01a7336-22428886514mr135961485ad.11.1741474757476; 
 Sat, 08 Mar 2025 14:59:17 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a908a0sm51831175ad.162.2025.03.08.14.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:59:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/23] qemu/atomic: Rename atomic128-ldst.h headers using
 .h.inc suffix
Date: Sat,  8 Mar 2025 14:58:59 -0800
Message-ID: <20250308225902.1208237-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250308225902.1208237-1-richard.henderson@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since commit 139c1837db ("meson: rename included C source files
to .c.inc"), QEMU standard procedure for included C files is to
use *.c.inc.

Besides, since commit 6a0057aa22 ("docs/devel: make a statement
about includes") this is documented in the Coding Style:

  If you do use template header files they should be named with
  the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
  being included for expansion.

Therefore rename 'atomic128-ldst.h' as 'atomic128-ldst.h.inc'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241212141018.59428-3-philmd@linaro.org>
---
 include/qemu/atomic128.h                                        | 2 +-
 .../aarch64/host/{atomic128-ldst.h => atomic128-ldst.h.inc}     | 0
 .../generic/host/{atomic128-ldst.h => atomic128-ldst.h.inc}     | 0
 .../loongarch64/host/{atomic128-ldst.h => atomic128-ldst.h.inc} | 0
 .../x86_64/host/{atomic128-ldst.h => atomic128-ldst.h.inc}      | 2 +-
 host/include/x86_64/host/load-extract-al16-al8.h.inc            | 2 +-
 6 files changed, 3 insertions(+), 3 deletions(-)
 rename host/include/aarch64/host/{atomic128-ldst.h => atomic128-ldst.h.inc} (100%)
 rename host/include/generic/host/{atomic128-ldst.h => atomic128-ldst.h.inc} (100%)
 rename host/include/loongarch64/host/{atomic128-ldst.h => atomic128-ldst.h.inc} (100%)
 rename host/include/x86_64/host/{atomic128-ldst.h => atomic128-ldst.h.inc} (96%)

diff --git a/include/qemu/atomic128.h b/include/qemu/atomic128.h
index 03c27022f0..448fb64479 100644
--- a/include/qemu/atomic128.h
+++ b/include/qemu/atomic128.h
@@ -59,6 +59,6 @@
  */
 
 #include "host/atomic128-cas.h.inc"
-#include "host/atomic128-ldst.h"
+#include "host/atomic128-ldst.h.inc"
 
 #endif /* QEMU_ATOMIC128_H */
diff --git a/host/include/aarch64/host/atomic128-ldst.h b/host/include/aarch64/host/atomic128-ldst.h.inc
similarity index 100%
rename from host/include/aarch64/host/atomic128-ldst.h
rename to host/include/aarch64/host/atomic128-ldst.h.inc
diff --git a/host/include/generic/host/atomic128-ldst.h b/host/include/generic/host/atomic128-ldst.h.inc
similarity index 100%
rename from host/include/generic/host/atomic128-ldst.h
rename to host/include/generic/host/atomic128-ldst.h.inc
diff --git a/host/include/loongarch64/host/atomic128-ldst.h b/host/include/loongarch64/host/atomic128-ldst.h.inc
similarity index 100%
rename from host/include/loongarch64/host/atomic128-ldst.h
rename to host/include/loongarch64/host/atomic128-ldst.h.inc
diff --git a/host/include/x86_64/host/atomic128-ldst.h b/host/include/x86_64/host/atomic128-ldst.h.inc
similarity index 96%
rename from host/include/x86_64/host/atomic128-ldst.h
rename to host/include/x86_64/host/atomic128-ldst.h.inc
index 8d6f909d3c..4c698e3246 100644
--- a/host/include/x86_64/host/atomic128-ldst.h
+++ b/host/include/x86_64/host/atomic128-ldst.h.inc
@@ -69,7 +69,7 @@ static inline void atomic16_set(Int128 *ptr, Int128 val)
 }
 #else
 /* Provide QEMU_ERROR stubs. */
-#include "host/include/generic/host/atomic128-ldst.h"
+#include "host/include/generic/host/atomic128-ldst.h.inc"
 #endif
 
 #endif /* X86_64_ATOMIC128_LDST_H */
diff --git a/host/include/x86_64/host/load-extract-al16-al8.h.inc b/host/include/x86_64/host/load-extract-al16-al8.h.inc
index baa506b7b5..b837c37868 100644
--- a/host/include/x86_64/host/load-extract-al16-al8.h.inc
+++ b/host/include/x86_64/host/load-extract-al16-al8.h.inc
@@ -9,7 +9,7 @@
 #define X86_64_LOAD_EXTRACT_AL16_AL8_H
 
 #ifdef CONFIG_INT128_TYPE
-#include "host/atomic128-ldst.h"
+#include "host/atomic128-ldst.h.inc"
 
 /**
  * load_atom_extract_al16_or_al8:
-- 
2.43.0


