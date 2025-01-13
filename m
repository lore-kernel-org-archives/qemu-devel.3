Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0803DE7719F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 13:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXKuO-0005p8-C2; Mon, 13 Jan 2025 08:55:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXKte-0005Ya-En
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:54:28 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXKtX-0007fj-Ex
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:54:22 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4361f796586so44622465e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 05:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736776458; x=1737381258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C07GAu6RWSDUye/+eR4LCu02qedXs1CpujcY5K6FNkQ=;
 b=tPs4dsXppESTLiF3mnHgGzwZtYTKs/75iXxCl8tWkmBOk/KdNIp4igrzTSkMe+M6Pv
 ZOTljuarmmZNt5YvGg2XRYE5xunEzOT3mhnTJ/Qk1+PlX0giL0EspqqRqNeG/0b3dqYH
 05fEy2uNZzB63eOrOft0SDsPLdF4Eae0oSxom0vjbYKGuYq93NjYZ32NQehdDw76/sgA
 3WXn2bAKVuSIhQ2XC9Czxy2gPps0BwDnNAzXviMNK4aimq5Xy9yzmrwIpNcSpNNomlyS
 YzZSjSlq5miVzZN+oucVL6eruH9yVT03/R6yVVuKoF7AMYjYeVsI1MyLWuJq3qIGP9Mf
 UMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736776458; x=1737381258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C07GAu6RWSDUye/+eR4LCu02qedXs1CpujcY5K6FNkQ=;
 b=md5AaQkNJj3NQz55Q0Um8taMbMfhXUowz1tDmPo+9x3dJOGnr3EgXFn4dW/85QLdTX
 yTM0zD8XUOtfIC1XD03f4YQ1tsKuuBMha6gjBDMoYBF/WR4jMLfNhhvGy9U5ZNEAn3M1
 sbDfP3tKX/Sxsi54LvEexz0J6YdXhrvanCHAB65J2RPOP4W7yQU1kjAC3Oy6YEjoeBNJ
 kSbrVZK86lWhxdvNmyC1kenEV1f+lyHJ3jiUpRtQ2Js0OE3q/wbHolZxg1l7DoIg3vKG
 gJ5simfjWBBcIwzblSbZqacPa08N/WQwNbAfd5esipFadhSdnds7bTcVCn2e1UxvK73G
 oicg==
X-Gm-Message-State: AOJu0Yw1RFShOp7+qGaMncx4i4CMF58n+Ecvvj8qu4JaCF0yFKHhhsyZ
 wYNFJm1CQhlW3vDQJLn5qvWMAWLke9ZQAKzlI3uRFBqryFe6r05bbgSbfgDYfnxzpJEBO2nK4iN
 Q
X-Gm-Gg: ASbGncsYvoMLHlAt4XFTKArquG7PVNiocYPVUxlWvWhh3m6OGtentSVgl6lwddD6zMu
 OPrYOGb7IF0qLch92kC9YV0bUmfQCLjIL60NDzktZZBNBpmuKcJxNIGZqZ7fT2Ao5mPl3iep63X
 HEdnBTXklDyduNRj9kazt/wXNggkT/ApAt0X2TqJcDKFvWYd/0P7TFx3Jxn/NIT3E5zsk0Au02S
 sWVkdOS9D3dBTx2eR/c1snrqZboPywAhUrhbei0VornrgXpKrqI8WT3AHhRAHs=
X-Google-Smtp-Source: AGHT+IFfXw0PW2vvyP50lDh31Wst0+/RCJIRupvnRlDNaPQBDNvK55O4n3UiVElae5ITue15GhXYOQ==
X-Received: by 2002:a05:600c:138a:b0:434:f0df:9fd with SMTP id
 5b1f17b1804b1-436e2679a1cmr77104835e9.2.1736776457464; 
 Mon, 13 Jan 2025 05:54:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fba4sm145245205e9.4.2025.01.13.05.54.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 05:54:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/11] target/arm: Move minor arithmetic helpers out of helper.c
Date: Mon, 13 Jan 2025 13:54:04 +0000
Message-Id: <20250113135408.3164401-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113135408.3164401-1-peter.maydell@linaro.org>
References: <20250113135408.3164401-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

helper.c includes some small TCG helper functions used for mostly
arithmetic instructions.  These are TCG only and there's no need for
them to be in the large and unwieldy helper.c.  Move them out to
their own source file in the tcg/ subdirectory, together with the
op_addsub.h multiply-included template header that they use.

Since we are moving op_addsub.h, we take the opportunity to
give it a name which matches our convention for files which
are not true header files but which are #included from other
C files: op_addsub.c.inc.

(Ironically, this means that helper.c no longer contains
any TCG helper function definitions at all.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250110131211.2546314-1-peter.maydell@linaro.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper.c                           | 285 -----------------
 target/arm/tcg/arith_helper.c                 | 296 ++++++++++++++++++
 .../arm/{op_addsub.h => tcg/op_addsub.c.inc}  |   0
 target/arm/tcg/meson.build                    |   1 +
 4 files changed, 297 insertions(+), 285 deletions(-)
 create mode 100644 target/arm/tcg/arith_helper.c
 rename target/arm/{op_addsub.h => tcg/op_addsub.c.inc} (100%)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5b595f951b4..63997678513 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -17,11 +17,9 @@
 #include "qemu/main-loop.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
-#include "qemu/crc32c.h"
 #include "qemu/qemu-print.h"
 #include "exec/exec-all.h"
 #include "exec/translation-block.h"
-#include <zlib.h> /* for crc32 */
 #include "hw/irq.h"
 #include "system/cpu-timers.h"
 #include "system/kvm.h"
@@ -10984,289 +10982,6 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
     };
 }
 
-/*
- * Note that signed overflow is undefined in C.  The following routines are
- * careful to use unsigned types where modulo arithmetic is required.
- * Failure to do so _will_ break on newer gcc.
- */
-
-/* Signed saturating arithmetic.  */
-
-/* Perform 16-bit signed saturating addition.  */
-static inline uint16_t add16_sat(uint16_t a, uint16_t b)
-{
-    uint16_t res;
-
-    res = a + b;
-    if (((res ^ a) & 0x8000) && !((a ^ b) & 0x8000)) {
-        if (a & 0x8000) {
-            res = 0x8000;
-        } else {
-            res = 0x7fff;
-        }
-    }
-    return res;
-}
-
-/* Perform 8-bit signed saturating addition.  */
-static inline uint8_t add8_sat(uint8_t a, uint8_t b)
-{
-    uint8_t res;
-
-    res = a + b;
-    if (((res ^ a) & 0x80) && !((a ^ b) & 0x80)) {
-        if (a & 0x80) {
-            res = 0x80;
-        } else {
-            res = 0x7f;
-        }
-    }
-    return res;
-}
-
-/* Perform 16-bit signed saturating subtraction.  */
-static inline uint16_t sub16_sat(uint16_t a, uint16_t b)
-{
-    uint16_t res;
-
-    res = a - b;
-    if (((res ^ a) & 0x8000) && ((a ^ b) & 0x8000)) {
-        if (a & 0x8000) {
-            res = 0x8000;
-        } else {
-            res = 0x7fff;
-        }
-    }
-    return res;
-}
-
-/* Perform 8-bit signed saturating subtraction.  */
-static inline uint8_t sub8_sat(uint8_t a, uint8_t b)
-{
-    uint8_t res;
-
-    res = a - b;
-    if (((res ^ a) & 0x80) && ((a ^ b) & 0x80)) {
-        if (a & 0x80) {
-            res = 0x80;
-        } else {
-            res = 0x7f;
-        }
-    }
-    return res;
-}
-
-#define ADD16(a, b, n) RESULT(add16_sat(a, b), n, 16);
-#define SUB16(a, b, n) RESULT(sub16_sat(a, b), n, 16);
-#define ADD8(a, b, n)  RESULT(add8_sat(a, b), n, 8);
-#define SUB8(a, b, n)  RESULT(sub8_sat(a, b), n, 8);
-#define PFX q
-
-#include "op_addsub.h"
-
-/* Unsigned saturating arithmetic.  */
-static inline uint16_t add16_usat(uint16_t a, uint16_t b)
-{
-    uint16_t res;
-    res = a + b;
-    if (res < a) {
-        res = 0xffff;
-    }
-    return res;
-}
-
-static inline uint16_t sub16_usat(uint16_t a, uint16_t b)
-{
-    if (a > b) {
-        return a - b;
-    } else {
-        return 0;
-    }
-}
-
-static inline uint8_t add8_usat(uint8_t a, uint8_t b)
-{
-    uint8_t res;
-    res = a + b;
-    if (res < a) {
-        res = 0xff;
-    }
-    return res;
-}
-
-static inline uint8_t sub8_usat(uint8_t a, uint8_t b)
-{
-    if (a > b) {
-        return a - b;
-    } else {
-        return 0;
-    }
-}
-
-#define ADD16(a, b, n) RESULT(add16_usat(a, b), n, 16);
-#define SUB16(a, b, n) RESULT(sub16_usat(a, b), n, 16);
-#define ADD8(a, b, n)  RESULT(add8_usat(a, b), n, 8);
-#define SUB8(a, b, n)  RESULT(sub8_usat(a, b), n, 8);
-#define PFX uq
-
-#include "op_addsub.h"
-
-/* Signed modulo arithmetic.  */
-#define SARITH16(a, b, n, op) do { \
-    int32_t sum; \
-    sum = (int32_t)(int16_t)(a) op (int32_t)(int16_t)(b); \
-    RESULT(sum, n, 16); \
-    if (sum >= 0) \
-        ge |= 3 << (n * 2); \
-    } while (0)
-
-#define SARITH8(a, b, n, op) do { \
-    int32_t sum; \
-    sum = (int32_t)(int8_t)(a) op (int32_t)(int8_t)(b); \
-    RESULT(sum, n, 8); \
-    if (sum >= 0) \
-        ge |= 1 << n; \
-    } while (0)
-
-
-#define ADD16(a, b, n) SARITH16(a, b, n, +)
-#define SUB16(a, b, n) SARITH16(a, b, n, -)
-#define ADD8(a, b, n)  SARITH8(a, b, n, +)
-#define SUB8(a, b, n)  SARITH8(a, b, n, -)
-#define PFX s
-#define ARITH_GE
-
-#include "op_addsub.h"
-
-/* Unsigned modulo arithmetic.  */
-#define ADD16(a, b, n) do { \
-    uint32_t sum; \
-    sum = (uint32_t)(uint16_t)(a) + (uint32_t)(uint16_t)(b); \
-    RESULT(sum, n, 16); \
-    if ((sum >> 16) == 1) \
-        ge |= 3 << (n * 2); \
-    } while (0)
-
-#define ADD8(a, b, n) do { \
-    uint32_t sum; \
-    sum = (uint32_t)(uint8_t)(a) + (uint32_t)(uint8_t)(b); \
-    RESULT(sum, n, 8); \
-    if ((sum >> 8) == 1) \
-        ge |= 1 << n; \
-    } while (0)
-
-#define SUB16(a, b, n) do { \
-    uint32_t sum; \
-    sum = (uint32_t)(uint16_t)(a) - (uint32_t)(uint16_t)(b); \
-    RESULT(sum, n, 16); \
-    if ((sum >> 16) == 0) \
-        ge |= 3 << (n * 2); \
-    } while (0)
-
-#define SUB8(a, b, n) do { \
-    uint32_t sum; \
-    sum = (uint32_t)(uint8_t)(a) - (uint32_t)(uint8_t)(b); \
-    RESULT(sum, n, 8); \
-    if ((sum >> 8) == 0) \
-        ge |= 1 << n; \
-    } while (0)
-
-#define PFX u
-#define ARITH_GE
-
-#include "op_addsub.h"
-
-/* Halved signed arithmetic.  */
-#define ADD16(a, b, n) \
-  RESULT(((int32_t)(int16_t)(a) + (int32_t)(int16_t)(b)) >> 1, n, 16)
-#define SUB16(a, b, n) \
-  RESULT(((int32_t)(int16_t)(a) - (int32_t)(int16_t)(b)) >> 1, n, 16)
-#define ADD8(a, b, n) \
-  RESULT(((int32_t)(int8_t)(a) + (int32_t)(int8_t)(b)) >> 1, n, 8)
-#define SUB8(a, b, n) \
-  RESULT(((int32_t)(int8_t)(a) - (int32_t)(int8_t)(b)) >> 1, n, 8)
-#define PFX sh
-
-#include "op_addsub.h"
-
-/* Halved unsigned arithmetic.  */
-#define ADD16(a, b, n) \
-  RESULT(((uint32_t)(uint16_t)(a) + (uint32_t)(uint16_t)(b)) >> 1, n, 16)
-#define SUB16(a, b, n) \
-  RESULT(((uint32_t)(uint16_t)(a) - (uint32_t)(uint16_t)(b)) >> 1, n, 16)
-#define ADD8(a, b, n) \
-  RESULT(((uint32_t)(uint8_t)(a) + (uint32_t)(uint8_t)(b)) >> 1, n, 8)
-#define SUB8(a, b, n) \
-  RESULT(((uint32_t)(uint8_t)(a) - (uint32_t)(uint8_t)(b)) >> 1, n, 8)
-#define PFX uh
-
-#include "op_addsub.h"
-
-static inline uint8_t do_usad(uint8_t a, uint8_t b)
-{
-    if (a > b) {
-        return a - b;
-    } else {
-        return b - a;
-    }
-}
-
-/* Unsigned sum of absolute byte differences.  */
-uint32_t HELPER(usad8)(uint32_t a, uint32_t b)
-{
-    uint32_t sum;
-    sum = do_usad(a, b);
-    sum += do_usad(a >> 8, b >> 8);
-    sum += do_usad(a >> 16, b >> 16);
-    sum += do_usad(a >> 24, b >> 24);
-    return sum;
-}
-
-/* For ARMv6 SEL instruction.  */
-uint32_t HELPER(sel_flags)(uint32_t flags, uint32_t a, uint32_t b)
-{
-    uint32_t mask;
-
-    mask = 0;
-    if (flags & 1) {
-        mask |= 0xff;
-    }
-    if (flags & 2) {
-        mask |= 0xff00;
-    }
-    if (flags & 4) {
-        mask |= 0xff0000;
-    }
-    if (flags & 8) {
-        mask |= 0xff000000;
-    }
-    return (a & mask) | (b & ~mask);
-}
-
-/*
- * CRC helpers.
- * The upper bytes of val (above the number specified by 'bytes') must have
- * been zeroed out by the caller.
- */
-uint32_t HELPER(crc32)(uint32_t acc, uint32_t val, uint32_t bytes)
-{
-    uint8_t buf[4];
-
-    stl_le_p(buf, val);
-
-    /* zlib crc32 converts the accumulator and output to one's complement.  */
-    return crc32(acc ^ 0xffffffff, buf, bytes) ^ 0xffffffff;
-}
-
-uint32_t HELPER(crc32c)(uint32_t acc, uint32_t val, uint32_t bytes)
-{
-    uint8_t buf[4];
-
-    stl_le_p(buf, val);
-
-    /* Linux crc32c converts the output to one's complement.  */
-    return crc32c(acc, buf, bytes) ^ 0xffffffff;
-}
 
 /*
  * Return the exception level to which FP-disabled exceptions should
diff --git a/target/arm/tcg/arith_helper.c b/target/arm/tcg/arith_helper.c
new file mode 100644
index 00000000000..9a555c7966c
--- /dev/null
+++ b/target/arm/tcg/arith_helper.c
@@ -0,0 +1,296 @@
+/*
+ * ARM generic helpers for various arithmetical operations.
+ *
+ * This code is licensed under the GNU GPL v2 or later.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/helper-proto.h"
+#include "qemu/crc32c.h"
+#include <zlib.h> /* for crc32 */
+
+/*
+ * Note that signed overflow is undefined in C.  The following routines are
+ * careful to use unsigned types where modulo arithmetic is required.
+ * Failure to do so _will_ break on newer gcc.
+ */
+
+/* Signed saturating arithmetic.  */
+
+/* Perform 16-bit signed saturating addition.  */
+static inline uint16_t add16_sat(uint16_t a, uint16_t b)
+{
+    uint16_t res;
+
+    res = a + b;
+    if (((res ^ a) & 0x8000) && !((a ^ b) & 0x8000)) {
+        if (a & 0x8000) {
+            res = 0x8000;
+        } else {
+            res = 0x7fff;
+        }
+    }
+    return res;
+}
+
+/* Perform 8-bit signed saturating addition.  */
+static inline uint8_t add8_sat(uint8_t a, uint8_t b)
+{
+    uint8_t res;
+
+    res = a + b;
+    if (((res ^ a) & 0x80) && !((a ^ b) & 0x80)) {
+        if (a & 0x80) {
+            res = 0x80;
+        } else {
+            res = 0x7f;
+        }
+    }
+    return res;
+}
+
+/* Perform 16-bit signed saturating subtraction.  */
+static inline uint16_t sub16_sat(uint16_t a, uint16_t b)
+{
+    uint16_t res;
+
+    res = a - b;
+    if (((res ^ a) & 0x8000) && ((a ^ b) & 0x8000)) {
+        if (a & 0x8000) {
+            res = 0x8000;
+        } else {
+            res = 0x7fff;
+        }
+    }
+    return res;
+}
+
+/* Perform 8-bit signed saturating subtraction.  */
+static inline uint8_t sub8_sat(uint8_t a, uint8_t b)
+{
+    uint8_t res;
+
+    res = a - b;
+    if (((res ^ a) & 0x80) && ((a ^ b) & 0x80)) {
+        if (a & 0x80) {
+            res = 0x80;
+        } else {
+            res = 0x7f;
+        }
+    }
+    return res;
+}
+
+#define ADD16(a, b, n) RESULT(add16_sat(a, b), n, 16);
+#define SUB16(a, b, n) RESULT(sub16_sat(a, b), n, 16);
+#define ADD8(a, b, n)  RESULT(add8_sat(a, b), n, 8);
+#define SUB8(a, b, n)  RESULT(sub8_sat(a, b), n, 8);
+#define PFX q
+
+#include "op_addsub.c.inc"
+
+/* Unsigned saturating arithmetic.  */
+static inline uint16_t add16_usat(uint16_t a, uint16_t b)
+{
+    uint16_t res;
+    res = a + b;
+    if (res < a) {
+        res = 0xffff;
+    }
+    return res;
+}
+
+static inline uint16_t sub16_usat(uint16_t a, uint16_t b)
+{
+    if (a > b) {
+        return a - b;
+    } else {
+        return 0;
+    }
+}
+
+static inline uint8_t add8_usat(uint8_t a, uint8_t b)
+{
+    uint8_t res;
+    res = a + b;
+    if (res < a) {
+        res = 0xff;
+    }
+    return res;
+}
+
+static inline uint8_t sub8_usat(uint8_t a, uint8_t b)
+{
+    if (a > b) {
+        return a - b;
+    } else {
+        return 0;
+    }
+}
+
+#define ADD16(a, b, n) RESULT(add16_usat(a, b), n, 16);
+#define SUB16(a, b, n) RESULT(sub16_usat(a, b), n, 16);
+#define ADD8(a, b, n)  RESULT(add8_usat(a, b), n, 8);
+#define SUB8(a, b, n)  RESULT(sub8_usat(a, b), n, 8);
+#define PFX uq
+
+#include "op_addsub.c.inc"
+
+/* Signed modulo arithmetic.  */
+#define SARITH16(a, b, n, op) do { \
+    int32_t sum; \
+    sum = (int32_t)(int16_t)(a) op (int32_t)(int16_t)(b); \
+    RESULT(sum, n, 16); \
+    if (sum >= 0) \
+        ge |= 3 << (n * 2); \
+    } while (0)
+
+#define SARITH8(a, b, n, op) do { \
+    int32_t sum; \
+    sum = (int32_t)(int8_t)(a) op (int32_t)(int8_t)(b); \
+    RESULT(sum, n, 8); \
+    if (sum >= 0) \
+        ge |= 1 << n; \
+    } while (0)
+
+
+#define ADD16(a, b, n) SARITH16(a, b, n, +)
+#define SUB16(a, b, n) SARITH16(a, b, n, -)
+#define ADD8(a, b, n)  SARITH8(a, b, n, +)
+#define SUB8(a, b, n)  SARITH8(a, b, n, -)
+#define PFX s
+#define ARITH_GE
+
+#include "op_addsub.c.inc"
+
+/* Unsigned modulo arithmetic.  */
+#define ADD16(a, b, n) do { \
+    uint32_t sum; \
+    sum = (uint32_t)(uint16_t)(a) + (uint32_t)(uint16_t)(b); \
+    RESULT(sum, n, 16); \
+    if ((sum >> 16) == 1) \
+        ge |= 3 << (n * 2); \
+    } while (0)
+
+#define ADD8(a, b, n) do { \
+    uint32_t sum; \
+    sum = (uint32_t)(uint8_t)(a) + (uint32_t)(uint8_t)(b); \
+    RESULT(sum, n, 8); \
+    if ((sum >> 8) == 1) \
+        ge |= 1 << n; \
+    } while (0)
+
+#define SUB16(a, b, n) do { \
+    uint32_t sum; \
+    sum = (uint32_t)(uint16_t)(a) - (uint32_t)(uint16_t)(b); \
+    RESULT(sum, n, 16); \
+    if ((sum >> 16) == 0) \
+        ge |= 3 << (n * 2); \
+    } while (0)
+
+#define SUB8(a, b, n) do { \
+    uint32_t sum; \
+    sum = (uint32_t)(uint8_t)(a) - (uint32_t)(uint8_t)(b); \
+    RESULT(sum, n, 8); \
+    if ((sum >> 8) == 0) \
+        ge |= 1 << n; \
+    } while (0)
+
+#define PFX u
+#define ARITH_GE
+
+#include "op_addsub.c.inc"
+
+/* Halved signed arithmetic.  */
+#define ADD16(a, b, n) \
+  RESULT(((int32_t)(int16_t)(a) + (int32_t)(int16_t)(b)) >> 1, n, 16)
+#define SUB16(a, b, n) \
+  RESULT(((int32_t)(int16_t)(a) - (int32_t)(int16_t)(b)) >> 1, n, 16)
+#define ADD8(a, b, n) \
+  RESULT(((int32_t)(int8_t)(a) + (int32_t)(int8_t)(b)) >> 1, n, 8)
+#define SUB8(a, b, n) \
+  RESULT(((int32_t)(int8_t)(a) - (int32_t)(int8_t)(b)) >> 1, n, 8)
+#define PFX sh
+
+#include "op_addsub.c.inc"
+
+/* Halved unsigned arithmetic.  */
+#define ADD16(a, b, n) \
+  RESULT(((uint32_t)(uint16_t)(a) + (uint32_t)(uint16_t)(b)) >> 1, n, 16)
+#define SUB16(a, b, n) \
+  RESULT(((uint32_t)(uint16_t)(a) - (uint32_t)(uint16_t)(b)) >> 1, n, 16)
+#define ADD8(a, b, n) \
+  RESULT(((uint32_t)(uint8_t)(a) + (uint32_t)(uint8_t)(b)) >> 1, n, 8)
+#define SUB8(a, b, n) \
+  RESULT(((uint32_t)(uint8_t)(a) - (uint32_t)(uint8_t)(b)) >> 1, n, 8)
+#define PFX uh
+
+#include "op_addsub.c.inc"
+
+static inline uint8_t do_usad(uint8_t a, uint8_t b)
+{
+    if (a > b) {
+        return a - b;
+    } else {
+        return b - a;
+    }
+}
+
+/* Unsigned sum of absolute byte differences.  */
+uint32_t HELPER(usad8)(uint32_t a, uint32_t b)
+{
+    uint32_t sum;
+    sum = do_usad(a, b);
+    sum += do_usad(a >> 8, b >> 8);
+    sum += do_usad(a >> 16, b >> 16);
+    sum += do_usad(a >> 24, b >> 24);
+    return sum;
+}
+
+/* For ARMv6 SEL instruction.  */
+uint32_t HELPER(sel_flags)(uint32_t flags, uint32_t a, uint32_t b)
+{
+    uint32_t mask;
+
+    mask = 0;
+    if (flags & 1) {
+        mask |= 0xff;
+    }
+    if (flags & 2) {
+        mask |= 0xff00;
+    }
+    if (flags & 4) {
+        mask |= 0xff0000;
+    }
+    if (flags & 8) {
+        mask |= 0xff000000;
+    }
+    return (a & mask) | (b & ~mask);
+}
+
+/*
+ * CRC helpers.
+ * The upper bytes of val (above the number specified by 'bytes') must have
+ * been zeroed out by the caller.
+ */
+uint32_t HELPER(crc32)(uint32_t acc, uint32_t val, uint32_t bytes)
+{
+    uint8_t buf[4];
+
+    stl_le_p(buf, val);
+
+    /* zlib crc32 converts the accumulator and output to one's complement.  */
+    return crc32(acc ^ 0xffffffff, buf, bytes) ^ 0xffffffff;
+}
+
+uint32_t HELPER(crc32c)(uint32_t acc, uint32_t val, uint32_t bytes)
+{
+    uint8_t buf[4];
+
+    stl_le_p(buf, val);
+
+    /* Linux crc32c converts the output to one's complement.  */
+    return crc32c(acc, buf, bytes) ^ 0xffffffff;
+}
diff --git a/target/arm/op_addsub.h b/target/arm/tcg/op_addsub.c.inc
similarity index 100%
rename from target/arm/op_addsub.h
rename to target/arm/tcg/op_addsub.c.inc
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 09238989c5a..1f9077c372c 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -40,6 +40,7 @@ arm_ss.add(files(
   'tlb_helper.c',
   'vec_helper.c',
   'tlb-insns.c',
+  'arith_helper.c',
 ))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
-- 
2.34.1


