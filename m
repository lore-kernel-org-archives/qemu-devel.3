Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284E1C531D0
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 00:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnnA3-00049X-NS; Sat, 25 Jul 2026 20:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wnnA0-000462-EQ
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 20:56:08 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wnn9y-0007a1-Ep
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 20:56:08 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-51c2b2c9eccso12863921cf.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 17:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785027365; x=1785632165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hTG9Vq5yx09S4tHVZ2AcJ8c9fwuynIWNBzHmdt64gAE=;
 b=h6yIWKmyXkj1TnlkwCh0yZYtJEqpXHCnEa+R1y/TKpreZjQcpy4FE4zA6P2MOhpGOy
 eLH+YTXSp4NaXpBxwumKCXwuRTW+cu0m+ieCgUKJGRfz8ZEScZQKghqp8jQWR5X1ZA2+
 rsath+s1gmK6v3VAChBS6eVV39gMhqV7cuuTpS6pIsuUzki08tBhhE9AMskDA7Cd/c6V
 iG/VOdBTDbA8J9fKWZjISkV5OTw5BGEHwKZvYa79RDI3gwkrMUrrcF5S0szrgV5hQWl7
 HMTZER46ku1zzujZFUmv7QyS/L8EG7PT+cCQa5X1x47eONVnWTAunb9LTBS5LE6qU9EG
 kTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785027365; x=1785632165;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hTG9Vq5yx09S4tHVZ2AcJ8c9fwuynIWNBzHmdt64gAE=;
 b=hlA6it6Y3ctCb6x2/ftej2g88nVBx6KSbGi73UpvgtD3LwHHlWAA9v73xWjtb3kHJp
 fd/UJX8E008DKPN/1l+ued2V4aMgseHaVKElRv0Hvi/9bPNSF0vKMAclcn2FhlrCCbsy
 n4MRbInysapNrvdsQyWkL7tHpHZ6badWhKMeHoDi4hD3g67ajmp1HJhyJblBzwx+iCrm
 khrlcojfqSvf+oSg0t2WPlm2/Kq785IrpTpj2nbcJ2r4aecxeLINdU8NTqA/j+7FFH8d
 Ih9ipx4pAX4wNwaaspDGtmiw8SWgV0j0X4tY60Bx6tG/tiY833AceRfwqXF5IaMdx3g8
 EgJA==
X-Gm-Message-State: AOJu0Yz5QXbbORPTOc+EqpTpQw745O78UVF7pSk2ZpRLqMuiapmYwqby
 bfcHtIWnhUgJ0vIZtAtyw0uuDtYlJkNnjnXa4jecYofujvg9zkRkDoSaiIImUQ==
X-Gm-Gg: AR+sD12h9L6NDvT5xSHy6qkQatnwJTJQLQRo1YKXzLlYDFJXUZTLDGMqs3TQX7okd9E
 e5TCW0tpeKW+i8CFNDNosCwEnmH7oHp4AynaBvn7WDAT0zCGqFIjoqnwzuik/W9e3fszVP/chBr
 b1grWtKrqxrq/NrhVw7cRvzpzCoinF8RuDCGlZjlhQTunLj7+Dm+hC7qkRVADjQ/JYIr/3xtMFy
 iQ/z8euvFxtdwHSQoo49TdHehS9vQ1wgkRsOMY9WeeyZ3tNCee1ibWfRByCcEVFs2qX8Lbpt+2J
 s/2bQY0Shgc9VISak7EwympF0guKhmVQTtmzAvzmvQeIcas6mZH3/7Peq8adDQzPrZqHhVdf609
 i6sWIgygo33CWJN/psCnz5iJ03rfAk9qt3VJl3uddTT+FW8we8DhfRhYljMF+QYcAr5oAussEPi
 GSh+yfOxzJNCA+njPnCUnJdwvhBVVNPNf5Z2eyOq3EC2E=
X-Received: by 2002:ac8:7c44:0:b0:51c:12bf:d4a7 with SMTP id
 d75a77b69052e-529a86ac0a5mr38479141cf.45.1785027365303; 
 Sat, 25 Jul 2026 17:56:05 -0700 (PDT)
Received: from localhost (host05.distrikthotelips2.d.subnet.rcn.com.
 [207.96.107.85]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-529a27cedccsm26413951cf.4.2026.07.25.17.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 17:56:04 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Matt Turner <mattst88@gmail.com>
Subject: [PATCH] target/alpha: do not trap on Inf inputs to bare FP arithmetic
Date: Sat, 25 Jul 2026 20:56:01 -0400
Message-ID: <20260726005601.2513662-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=mattst88@gmail.com; helo=mail-qt1-x833.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

helper_ieee_input is called for each operand of bare (non-/S) T-floating
arithmetic instructions.  It was raising EXC_M_INV for any value with
exp == 0x7ff, which covers both NaN and Infinity.

This is wrong for Infinity.  Infinity is a valid arithmetic operand;
operations like Inf + finite, Inf + Inf, or Inf * finite produce well-
defined IEEE results with no invalid-operation exception.  Only NaN
inputs and indeterminate forms (Inf - Inf, 0 * Inf) are invalid.

Indeterminate forms are already handled: the softfloat helpers set
float_flag_invalid in those cases, which soft_to_fpcr_exc converts to
FPCR_INV in env->error_code, and helper_fp_exc_raise then raises the
trap.  No pre-operation check for Inf is needed.

Change the exp == 0x7ff check to also require frac != 0, matching the
existing behavior of helper_ieee_input_cmp.

Fixes: b99e80694cc6 ("target-alpha: Raise EXC_M_INV properly for fp inputs")
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 target/alpha/fpu_helper.c       |   7 +-
 tests/tcg/alpha/Makefile.target |   2 +-
 tests/tcg/alpha/test-fp-ieee.c  | 173 ++++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+), 5 deletions(-)
 create mode 100644 tests/tcg/alpha/test-fp-ieee.c

diff --git ./target/alpha/fpu_helper.c ./target/alpha/fpu_helper.c
index 5b7e4bd5eb..6c26e3349f 100644
--- ./target/alpha/fpu_helper.c
+++ ./target/alpha/fpu_helper.c
@@ -105,8 +105,7 @@ void helper_fp_exc_raise_s(CPUAlphaState *env, uint32_t ignore, uint32_t regno)
     }
 }
 
-/* Input handing without software completion.  Trap for all
-   non-finite numbers.  */
+/* Input handling without software completion.  Trap for NaN and denormals.  */
 void helper_ieee_input(CPUAlphaState *env, uint64_t val)
 {
     uint32_t exp = (uint32_t)(val >> 52) & 0x7ff;
@@ -117,8 +116,8 @@ void helper_ieee_input(CPUAlphaState *env, uint64_t val)
         if (frac != 0) {
             arith_excp(env, GETPC(), EXC_M_INV, 0);
         }
-    } else if (exp == 0x7ff) {
-        /* Infinity or NaN.  */
+    } else if (exp == 0x7ff && frac) {
+        /* NaN.  */
         env->fpcr |= FPCR_INV;
         arith_excp(env, GETPC(), EXC_M_INV, 0);
     }
diff --git ./tests/tcg/alpha/Makefile.target ./tests/tcg/alpha/Makefile.target
index 36d8ed1eae..2636921aeb 100644
--- ./tests/tcg/alpha/Makefile.target
+++ ./tests/tcg/alpha/Makefile.target
@@ -5,7 +5,7 @@
 ALPHA_SRC=$(SRC_PATH)/tests/tcg/alpha
 VPATH+=$(ALPHA_SRC)
 
-ALPHA_TESTS=hello-alpha test-cond test-cmov test-ovf test-cvttq
+ALPHA_TESTS=hello-alpha test-cond test-cmov test-ovf test-cvttq test-fp-ieee
 TESTS+=$(ALPHA_TESTS)
 
 test-cmov: EXTRA_CFLAGS=-DTEST_CMOV
diff --git ./tests/tcg/alpha/test-fp-ieee.c ./tests/tcg/alpha/test-fp-ieee.c
new file mode 100644
index 0000000000..caeeaea7a3
--- /dev/null
+++ ./tests/tcg/alpha/test-fp-ieee.c
@@ -0,0 +1,173 @@
+/*
+ * Test IEEE T-floating (double) arithmetic exception behavior.
+ */
+#include <signal.h>
+#include <setjmp.h>
+#include <stdio.h>
+
+#define FPCR_INED       (1UL << 62)
+#define FPCR_UNFD       (1UL << 61)
+#define FPCR_DYN_NORMAL (2UL << 58)
+#define FPCR_IOV        (1UL << 57)
+#define FPCR_INE        (1UL << 56)
+#define FPCR_UNF        (1UL << 55)
+#define FPCR_OVF        (1UL << 54)
+#define FPCR_DZE        (1UL << 53)
+#define FPCR_INV        (1UL << 52)
+#define FPCR_OVFD       (1UL << 51)
+#define FPCR_DZED       (1UL << 50)
+#define FPCR_INVD       (1UL << 49)
+#define FPCR_STATUS_MASK (FPCR_IOV | FPCR_INE | FPCR_UNF \
+                          | FPCR_OVF | FPCR_DZE | FPCR_INV)
+
+static long run_addt_su(long *exc_out, double a, double b)
+{
+    unsigned long reset = FPCR_INED | FPCR_UNFD | FPCR_OVFD | FPCR_DZED
+                          | FPCR_INVD | FPCR_DYN_NORMAL;
+    double r;
+    long e;
+
+    asm ("excb\n\t"
+         "mt_fpcr %4\n\t"
+         "excb\n\t"
+         "addt/su %2,%3,%0\n\t"
+         "excb\n\t"
+         "mf_fpcr %1\n\t"
+         "excb\n\t"
+         : "=f"(r), "=f"(e)
+         : "f"(a), "f"(b), "f"(reset));
+
+    *exc_out = e & FPCR_STATUS_MASK;
+    long ri;
+    __builtin_memcpy(&ri, &r, 8);
+    return ri;
+}
+
+static long run_mult_su(long *exc_out, double a, double b)
+{
+    unsigned long reset = FPCR_INED | FPCR_UNFD | FPCR_OVFD | FPCR_DZED
+                          | FPCR_INVD | FPCR_DYN_NORMAL;
+    double r;
+    long e;
+
+    asm ("excb\n\t"
+         "mt_fpcr %4\n\t"
+         "excb\n\t"
+         "mult/su %2,%3,%0\n\t"
+         "excb\n\t"
+         "mf_fpcr %1\n\t"
+         "excb\n\t"
+         : "=f"(r), "=f"(e)
+         : "f"(a), "f"(b), "f"(reset));
+
+    *exc_out = e & FPCR_STATUS_MASK;
+    long ri;
+    __builtin_memcpy(&ri, &r, 8);
+    return ri;
+}
+
+static sigjmp_buf jmpbuf;
+static volatile int got_sigfpe;
+
+static void sigfpe_handler(int sig)
+{
+    got_sigfpe = 1;
+    siglongjmp(jmpbuf, 1);
+}
+
+static int test_bare_inf_add_finite(void)
+{
+    double a = __builtin_inf();
+    double b = 1.0;
+    double r = 0.0;
+
+    got_sigfpe = 0;
+    signal(SIGFPE, sigfpe_handler);
+    if (sigsetjmp(jmpbuf, 1) == 0) {
+        asm volatile ("addt %1,%2,%0" : "=f"(r) : "f"(a), "f"(b));
+    }
+    signal(SIGFPE, SIG_DFL);
+
+    if (got_sigfpe) {
+        printf("FAIL bare addt Inf+1.0: spurious SIGFPE\n");
+        return 1;
+    }
+    unsigned long ri;
+    __builtin_memcpy(&ri, &r, 8);
+    if (ri != 0x7ff0000000000000ul) {
+        printf("FAIL bare addt Inf+1.0: result %016lx (expected 7ff0000000000000)\n", ri);
+        return 1;
+    }
+    return 0;
+}
+
+static int test_su_inf_add_finite(void)
+{
+    double a = __builtin_inf();
+    double b = 1.0;
+    double r = 0.0;
+
+    got_sigfpe = 0;
+    signal(SIGFPE, sigfpe_handler);
+    if (sigsetjmp(jmpbuf, 1) == 0) {
+        asm volatile ("addt/su %1,%2,%0" : "=f"(r) : "f"(a), "f"(b));
+    }
+    signal(SIGFPE, SIG_DFL);
+
+    if (got_sigfpe) {
+        printf("FAIL addt/su Inf+1.0: spurious SIGFPE\n");
+        return 1;
+    }
+    unsigned long ri;
+    __builtin_memcpy(&ri, &r, 8);
+    if (ri != 0x7ff0000000000000ul) {
+        printf("FAIL addt/su Inf+1.0: result %016lx (expected 7ff0000000000000)\n", ri);
+        return 1;
+    }
+    return 0;
+}
+
+int main(void)
+{
+    static const struct {
+        double a, b;
+        long r;           /* expected result bit pattern; 0 when result is NaN */
+        long e;           /* expected FPCR exception bits */
+        long (*func)(long *, double, double);
+    } T[] = {
+        /* addt/su: Inf + finite = Inf, no exception */
+        { __builtin_inf(),  1.0,             0x7ff0000000000000l, 0,        run_addt_su },
+        /* addt/su: Inf + Inf = Inf, no exception */
+        { __builtin_inf(),  __builtin_inf(), 0x7ff0000000000000l, 0,        run_addt_su },
+        /* addt/su: Inf + (-Inf) = NaN, invalid operation */
+        { __builtin_inf(), -__builtin_inf(), 0,                   FPCR_INV, run_addt_su },
+        /* mult/su: Inf * finite = Inf, no exception */
+        { __builtin_inf(),  2.0,             0x7ff0000000000000l, 0,        run_mult_su },
+        /* mult/su: 0 * Inf = NaN, invalid operation */
+        { 0.0,              __builtin_inf(), 0,                   FPCR_INV, run_mult_su },
+    };
+
+    int i, err = 0;
+
+    err |= test_bare_inf_add_finite();
+    err |= test_su_inf_add_finite();
+
+    for (i = 0; i < sizeof(T) / sizeof(T[0]); i++) {
+        long e, r = T[i].func(&e, T[i].a, T[i].b);
+
+        /* NaN payload is implementation-defined; skip result check. */
+        int result_ok = (T[i].e & FPCR_INV) ? 1 : (r == T[i].r);
+        if (!result_ok || e != T[i].e) {
+            printf("Fail %a %a: expect (%016lx : %04lx) got (%016lx : %04lx)\n",
+                   T[i].a, T[i].b,
+                   T[i].r, T[i].e >> 48,
+                   r, e >> 48);
+            err = 1;
+        }
+    }
+
+    if (!err) {
+        puts("OK");
+    }
+    return err;
+}
-- 
2.54.0


