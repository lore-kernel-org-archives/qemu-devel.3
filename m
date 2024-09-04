Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAC8CD484A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 14:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slr7e-0000eF-7h; Wed, 04 Sep 2024 10:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slr7R-0000Df-Sz
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:36:27 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slr7N-00059x-L0
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:36:25 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42c7bc97423so46967395e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 07:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725460580; x=1726065380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xlU36HlD7PbSLii+q9qc+HFUMn5wYSxKkOmiwKKXu7M=;
 b=d6tD3oLa1lMW6YlGm4yCqmid0Kqum6QiyPiyRSomSAwr0m+DgfUssF+2Fe7hVphqrU
 nmhnKnWG6UpjF+DmkB3MJl38EO7jnJCSuRzQ9aOz8SUfOFxwSqYDiS/fri3n96Ze3Afu
 TUOGvhP46V94InviuTzPUUEDKCGCEmOVXLsUfqPFqhq4Oa1jH2Nj/0V5BXZuPhhsoY1N
 0cQOFars2/CbvHhn80qZ0XEmdk8cprHV27ziJnEndtYybAxBA7fNfG7N2nOsqza9qwAJ
 Ep+OR++m6Zz+vwUD49V9chNqoOfDNCcubMKnqyi5wNfxH0hHo38K8Gq1fdxeZrGupRiK
 FQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725460580; x=1726065380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xlU36HlD7PbSLii+q9qc+HFUMn5wYSxKkOmiwKKXu7M=;
 b=qpY38TRwChE9OmoDOSo5+JmZJvT2w0wCUDMfOJyUcOg8IKRDnahSzgQalJX55In6/j
 dgv+uXOv1MKSOvjUFUTJ8tzADovGMlj1hAYf1dBpEivILcuwcJFlDBWnfQTQP8kFYCJd
 XgCIsd9V3U3MyzGO2Y0nMfugN2utXvD7hY2l26+PM1MrTjNAFUSAp/qEl17au619OMjH
 zb3BSCNNUdMvbdTNNdj1s+cMRHZ6JqvmZBRxjttLpaktCmB/sIBEw0D+eF947UIGL2uN
 9MWH1uDEwPnDWfVYxeBu9iFzZ76+6giqYlJo1zm8iwBV8SDrKwoulrBjRjp5k3eBROUr
 ao0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlutW7Olmheo6jYIJFyoGHgN3cS3pU7sbIyIhiBHZZJAJLZPovCpFZfHh+ej+RugpN+J5+439aGPs5@nongnu.org
X-Gm-Message-State: AOJu0Yz7y9sPwymQnEzTmIcm5ao9qfEV6MCONXl/QB6JmOf4UdPswtZF
 FeitglAqCkk/Aesh47UaBKMdklzqw8Kn9qB4ijVL6c76vmb/FbzwLiAsLnPWm4E=
X-Google-Smtp-Source: AGHT+IG33YKNBtmHmKOnPNOS0zIRK9rp1JYu9Rx4QszmpAcVUU1SRmwOxIuJqLG0kf/6ygVOwEvmoQ==
X-Received: by 2002:a05:600c:a01:b0:426:6857:3156 with SMTP id
 5b1f17b1804b1-42bb01edd50mr197443715e9.27.1725460579273; 
 Wed, 04 Sep 2024 07:36:19 -0700 (PDT)
Received: from localhost.localdomain (56.red-95-127-44.staticip.rima-tde.net.
 [95.127.44.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bba3f2875sm186989255e9.41.2024.09.04.07.36.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Sep 2024 07:36:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/15] tests/tcg: Remove CRIS libc test files
Date: Wed,  4 Sep 2024 16:35:49 +0200
Message-ID: <20240904143603.52934-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904143603.52934-1-philmd@linaro.org>
References: <20240904143603.52934-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We never compiled / ran these tests.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/tcg/cris/libc/crisutils.h               |  76 ----------
 tests/tcg/cris/libc/sys.h                     |  18 ---
 tests/tcg/cris/libc/check_abs.c               |  40 -----
 tests/tcg/cris/libc/check_addc.c              |  58 -------
 tests/tcg/cris/libc/check_addcm.c             |  85 -----------
 tests/tcg/cris/libc/check_addo.c              | 125 ---------------
 tests/tcg/cris/libc/check_addoq.c             |  44 ------
 tests/tcg/cris/libc/check_bound.c             | 142 ------------------
 tests/tcg/cris/libc/check_ftag.c              |  37 -----
 .../cris/libc/check_gcctorture_pr28634-1.c    |  15 --
 .../tcg/cris/libc/check_gcctorture_pr28634.c  |  15 --
 .../tcg/cris/libc/check_glibc_kernelversion.c | 116 --------------
 tests/tcg/cris/libc/check_hello.c             |   7 -
 tests/tcg/cris/libc/check_int64.c             |  47 ------
 tests/tcg/cris/libc/check_lz.c                |  49 ------
 tests/tcg/cris/libc/check_mapbrk.c            |  39 -----
 tests/tcg/cris/libc/check_mmap1.c             |  48 ------
 tests/tcg/cris/libc/check_mmap2.c             |  48 ------
 tests/tcg/cris/libc/check_mmap3.c             |  33 ----
 tests/tcg/cris/libc/check_moveq.c             |  51 -------
 tests/tcg/cris/libc/check_openpf1.c           |  38 -----
 tests/tcg/cris/libc/check_openpf2.c           |  16 --
 tests/tcg/cris/libc/check_openpf3.c           |  49 ------
 tests/tcg/cris/libc/check_openpf5.c           |  56 -------
 tests/tcg/cris/libc/check_settls1.c           |  45 ------
 tests/tcg/cris/libc/check_sigalrm.c           |  26 ----
 tests/tcg/cris/libc/check_stat1.c             |  16 --
 tests/tcg/cris/libc/check_stat2.c             |  20 ---
 tests/tcg/cris/libc/check_stat3.c             |  25 ---
 tests/tcg/cris/libc/check_stat4.c             |  27 ----
 tests/tcg/cris/libc/check_swap.c              |  76 ----------
 tests/tcg/cris/libc/check_time2.c             |  18 ---
 32 files changed, 1505 deletions(-)
 delete mode 100644 tests/tcg/cris/libc/crisutils.h
 delete mode 100644 tests/tcg/cris/libc/sys.h
 delete mode 100644 tests/tcg/cris/libc/check_abs.c
 delete mode 100644 tests/tcg/cris/libc/check_addc.c
 delete mode 100644 tests/tcg/cris/libc/check_addcm.c
 delete mode 100644 tests/tcg/cris/libc/check_addo.c
 delete mode 100644 tests/tcg/cris/libc/check_addoq.c
 delete mode 100644 tests/tcg/cris/libc/check_bound.c
 delete mode 100644 tests/tcg/cris/libc/check_ftag.c
 delete mode 100644 tests/tcg/cris/libc/check_gcctorture_pr28634-1.c
 delete mode 100644 tests/tcg/cris/libc/check_gcctorture_pr28634.c
 delete mode 100644 tests/tcg/cris/libc/check_glibc_kernelversion.c
 delete mode 100644 tests/tcg/cris/libc/check_hello.c
 delete mode 100644 tests/tcg/cris/libc/check_int64.c
 delete mode 100644 tests/tcg/cris/libc/check_lz.c
 delete mode 100644 tests/tcg/cris/libc/check_mapbrk.c
 delete mode 100644 tests/tcg/cris/libc/check_mmap1.c
 delete mode 100644 tests/tcg/cris/libc/check_mmap2.c
 delete mode 100644 tests/tcg/cris/libc/check_mmap3.c
 delete mode 100644 tests/tcg/cris/libc/check_moveq.c
 delete mode 100644 tests/tcg/cris/libc/check_openpf1.c
 delete mode 100644 tests/tcg/cris/libc/check_openpf2.c
 delete mode 100644 tests/tcg/cris/libc/check_openpf3.c
 delete mode 100644 tests/tcg/cris/libc/check_openpf5.c
 delete mode 100644 tests/tcg/cris/libc/check_settls1.c
 delete mode 100644 tests/tcg/cris/libc/check_sigalrm.c
 delete mode 100644 tests/tcg/cris/libc/check_stat1.c
 delete mode 100644 tests/tcg/cris/libc/check_stat2.c
 delete mode 100644 tests/tcg/cris/libc/check_stat3.c
 delete mode 100644 tests/tcg/cris/libc/check_stat4.c
 delete mode 100644 tests/tcg/cris/libc/check_swap.c
 delete mode 100644 tests/tcg/cris/libc/check_time2.c

diff --git a/tests/tcg/cris/libc/crisutils.h b/tests/tcg/cris/libc/crisutils.h
deleted file mode 100644
index bbbe6c5540..0000000000
--- a/tests/tcg/cris/libc/crisutils.h
+++ /dev/null
@@ -1,76 +0,0 @@
-#ifndef CRISUTILS_H
-#define CRISUTILS_H 1
-
-static char *tst_cc_loc = NULL;
-
-#define cris_tst_cc_init() \
-do { tst_cc_loc = "test_cc failed at " CURRENT_LOCATION; } while(0)
-
-/* We need a real symbol to signal error.  */
-void _err(void) {
-	if (!tst_cc_loc)
-		tst_cc_loc = "tst_cc_failed\n";
-	_fail(tst_cc_loc);
-}
-
-static always_inline void cris_tst_cc_n1(void)
-{
-	asm volatile ("bpl _err\n"
-		      "nop\n");
-}
-static always_inline void cris_tst_cc_n0(void)
-{
-	asm volatile ("bmi _err\n"
-		      "nop\n");
-}
-
-static always_inline void cris_tst_cc_z1(void)
-{
-	asm volatile ("bne _err\n"
-		      "nop\n");
-}
-static always_inline void cris_tst_cc_z0(void)
-{
-	asm volatile ("beq _err\n"
-		      "nop\n");
-}
-static always_inline void cris_tst_cc_v1(void)
-{
-	asm volatile ("bvc _err\n"
-		      "nop\n");
-}
-static always_inline void cris_tst_cc_v0(void)
-{
-	asm volatile ("bvs _err\n"
-		      "nop\n");
-}
-
-static always_inline void cris_tst_cc_c1(void)
-{
-	asm volatile ("bcc _err\n"
-		      "nop\n");
-}
-static always_inline void cris_tst_cc_c0(void)
-{
-	asm volatile ("bcs _err\n"
-		      "nop\n");
-}
-
-static always_inline void cris_tst_mov_cc(int n, int z)
-{
-	if (n) cris_tst_cc_n1(); else cris_tst_cc_n0();
-	if (z) cris_tst_cc_z1(); else cris_tst_cc_z0();
-	asm volatile ("" : : "g" (_err));
-}
-
-static always_inline void cris_tst_cc(const int n, const int z,
-			       const int v, const int c)
-{
-	if (n) cris_tst_cc_n1(); else cris_tst_cc_n0();
-	if (z) cris_tst_cc_z1(); else cris_tst_cc_z0();
-	if (v) cris_tst_cc_v1(); else cris_tst_cc_v0();
-	if (c) cris_tst_cc_c1(); else cris_tst_cc_c0();
-	asm volatile ("" : : "g" (_err));
-}
-
-#endif
diff --git a/tests/tcg/cris/libc/sys.h b/tests/tcg/cris/libc/sys.h
deleted file mode 100644
index 3dd47bb673..0000000000
--- a/tests/tcg/cris/libc/sys.h
+++ /dev/null
@@ -1,18 +0,0 @@
-#include <unistd.h>
-
-#define STRINGIFY(x) #x
-#define TOSTRING(x) STRINGIFY(x)
-
-#define always_inline inline __attribute__((always_inline))
-
-#define CURRENT_LOCATION __FILE__ ":" TOSTRING(__LINE__)
-
-#define err()                         \
-{                                     \
-  _fail("at " CURRENT_LOCATION " ");  \
-}
-
-#define mb() asm volatile ("" : : : "memory")
-
-void pass(void);
-void _fail(char *reason);
diff --git a/tests/tcg/cris/libc/check_abs.c b/tests/tcg/cris/libc/check_abs.c
deleted file mode 100644
index 08b67b6ef0..0000000000
--- a/tests/tcg/cris/libc/check_abs.c
+++ /dev/null
@@ -1,40 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdint.h>
-#include "sys.h"
-#include "crisutils.h"
-
-static always_inline int cris_abs(int n)
-{
-	int r;
-	asm ("abs\t%1, %0\n" : "=r" (r) : "r" (n));
-	return r;
-}
-
-static always_inline void
-verify_abs(int val, int res,
-	   const int n, const int z, const int v, const int c)
-{
-	int r;
-
-	cris_tst_cc_init();
-	r = cris_abs(val);
-	cris_tst_cc(n, z, v, c);
-	if (r != res)
-		err();
-}
-
-int main(void)
-{
-	verify_abs(-1, 1, 0, 0, 0, 0);
-	verify_abs(0x80000000, 0x80000000, 1, 0, 0, 0);
-	verify_abs(0x7fffffff, 0x7fffffff, 0, 0, 0, 0);
-	verify_abs(42, 42, 0, 0, 0, 0);
-	verify_abs(1, 1, 0, 0, 0, 0);
-	verify_abs(0xffff, 0xffff, 0, 0, 0, 0);
-	verify_abs(0xffff, 0xffff, 0, 0, 0, 0);
-	verify_abs(-31, 0x1f, 0, 0, 0, 0);
-	verify_abs(0, 0, 0, 1, 0, 0);
-	pass();
-	return 0;
-}
diff --git a/tests/tcg/cris/libc/check_addc.c b/tests/tcg/cris/libc/check_addc.c
deleted file mode 100644
index fc3fb1faa8..0000000000
--- a/tests/tcg/cris/libc/check_addc.c
+++ /dev/null
@@ -1,58 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdint.h>
-#include "sys.h"
-#include "crisutils.h"
-
-static always_inline int cris_addc(int a, const int b)
-{
-	asm ("addc\t%1, %0\n" : "+r" (a) : "r" (b));
-	return a;
-}
-
-#define verify_addc(a, b, res, n, z, v, c)  \
-{                                           \
-	int r;                              \
-	r = cris_addc((a), (b));            \
-	cris_tst_cc((n), (z), (v), (c));    \
-	if (r != (res))                     \
-		err();                      \
-}
-
-int main(void)
-{
-	cris_tst_cc_init();
-	asm volatile ("clearf cz");
-	verify_addc(0, 0, 0, 0, 0, 0, 0);
-
-	cris_tst_cc_init();
-	asm volatile ("setf z");
-	verify_addc(0, 0, 0, 0, 1, 0, 0);
-
-	cris_tst_cc_init();
-	asm volatile ("setf cz");
-	verify_addc(0, 0, 1, 0, 0, 0, 0);
-	cris_tst_cc_init();
-	asm volatile ("clearf c");
-	verify_addc(-1, 2, 1, 0, 0, 0, 1);
-
-	cris_tst_cc_init();
-	asm volatile ("clearf nzv");
-	asm volatile ("setf c");
-	verify_addc(-1, 2, 2, 0, 0, 0, 1);
-
-	cris_tst_cc_init();
-	asm volatile ("setf c");
-	verify_addc(0xffff, 0xffff, 0x1ffff, 0, 0, 0, 0);
-
-	cris_tst_cc_init();
-	asm volatile ("clearf nzvc");
-	verify_addc(-1, -1, 0xfffffffe, 1, 0, 0, 1);
-
-	cris_tst_cc_init();
-	asm volatile ("setf c");
-	verify_addc(0x78134452, 0x5432f789, 0xcc463bdc, 1, 0, 1, 0);
-
-	pass();
-	return 0;
-}
diff --git a/tests/tcg/cris/libc/check_addcm.c b/tests/tcg/cris/libc/check_addcm.c
deleted file mode 100644
index b355ba164f..0000000000
--- a/tests/tcg/cris/libc/check_addcm.c
+++ /dev/null
@@ -1,85 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdint.h>
-#include "sys.h"
-#include "crisutils.h"
-
-/* need to avoid acr as source here.  */
-static always_inline int cris_addc_m(int a, const int *b)
-{
-	asm volatile ("addc [%1], %0\n" : "+r" (a) : "r" (b));
-	return a;
-}
-
-/* 'b' is a crisv32 constrain to avoid postinc with $acr.  */
-static always_inline int cris_addc_pi_m(int a, int **b)
-{
-	asm volatile ("addc [%1+], %0\n" : "+r" (a), "+b" (*b));
-	return a;
-}
-
-#define verify_addc_m(a, b, res, n, z, v, c)  \
-{                                           \
-	int r;                              \
-	r = cris_addc_m((a), (b));            \
-	cris_tst_cc((n), (z), (v), (c));    \
-	if (r != (res))                     \
-		err();                      \
-}
-
-#define verify_addc_pi_m(a, b, res, n, z, v, c)  \
-{                                           \
-	int r;                              \
-	r = cris_addc_pi_m((a), (b));            \
-	cris_tst_cc((n), (z), (v), (c));    \
-	if (r != (res))                     \
-		err();                      \
-}
-
-int x[] = { 0, 0, 2, -1, 0xffff, -1, 0x5432f789};
-
-int main(void)
-{
-	int *p = (void *)&x[0];
-#if 1
-	cris_tst_cc_init();
-	asm volatile ("clearf cz");
-	verify_addc_m(0, p, 0, 0, 0, 0, 0);
-
-	cris_tst_cc_init();
-	asm volatile ("setf z");
-	verify_addc_m(0, p, 0, 0, 1, 0, 0);
-
-	cris_tst_cc_init();
-	asm volatile ("setf c");
-	verify_addc_m(0, p, 1, 0, 0, 0, 0);
-
-	cris_tst_cc_init();
-	asm volatile ("clearf c");
-	verify_addc_pi_m(0, &p, 0, 0, 1, 0, 0);
-
-	p = &x[1];
-	cris_tst_cc_init();
-	asm volatile ("setf c");
-	verify_addc_pi_m(0, &p, 1, 0, 0, 0, 0);
-
-	if (p != &x[2])
-		err();
-
-	cris_tst_cc_init();
-	asm volatile ("clearf c");
-	verify_addc_pi_m(-1, &p, 1, 0, 0, 0, 1);
-
-	if (p != &x[3])
-		err();
-#endif
-	p = &x[3];
-	/* TODO: investigate why this one fails.  */
-	cris_tst_cc_init();
-	asm volatile ("setf c");
-	verify_addc_m(2, p, 2, 0, 0, 0, 1);
-	p += 4;
-
-	pass();
-	return 0;
-}
diff --git a/tests/tcg/cris/libc/check_addo.c b/tests/tcg/cris/libc/check_addo.c
deleted file mode 100644
index 4235e5fc65..0000000000
--- a/tests/tcg/cris/libc/check_addo.c
+++ /dev/null
@@ -1,125 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdint.h>
-#include "sys.h"
-#include "crisutils.h"
-
-/* this would be better to do in asm, it's an orgy in GCC inline asm now.  */
-
-#define cris_addo_b(o, v) \
-	asm volatile ("addo.b\t[%0], %1, $acr\n" : : "r" (o), "r" (v) : "acr");
-#define cris_addo_w(o, v) \
-	asm volatile ("addo.w\t[%0], %1, $acr\n" : : "r" (o), "r" (v) : "acr");
-#define cris_addo_d(o, v) \
-	asm volatile ("addo.d\t[%0], %1, $acr\n" : : "r" (o), "r" (v) : "acr");
-#define cris_addo_pi_b(o, v) \
-	asm volatile ("addo.b\t[%0+], %1, $acr\n" \
-                         : "+b" (o): "r" (v) : "acr");
-#define cris_addo_pi_w(o, v) \
-	asm volatile ("addo.w\t[%0+], %1, $acr\n" \
-                         : "+b" (o): "r" (v) : "acr");
-#define cris_addo_pi_d(o, v) \
-	asm volatile ("addo.d\t[%0+], %1, $acr\n" \
-                         : "+b" (o): "r" (v) : "acr");
-
-struct {
-	uint32_t v1;
-	uint16_t v2;
-	uint32_t v3;
-	uint8_t v4;
-	uint8_t v5;
-	uint16_t v6;
-	uint32_t v7;
-} y = {
-	32769,
-	-1,
-	5,
-	3, -4,
-	2,
-	-76789887
-};
-
-static int x[3] = {0x55aa77ff, 0xccff2244, 0x88ccee19};
-
-int main(void)
-{
-	int *r;
-	unsigned char *t, *p;
-
-	/* Note, this test-case will trig an unaligned access, partly
-	   to x[0] and to [x1].  */
-	t = (unsigned char *)x;
-	t -= 32768;
-	p = (unsigned char *) &y.v1;
-	mb(); /* don't reorder anything beyond here.  */
-	cris_tst_cc_init();
-	asm volatile ("setf\tzvnc\n");
-	cris_addo_pi_d(p, t);
-	cris_tst_cc(1, 1, 1, 1);
-	asm volatile ("move.d\t$acr, %0\n" : "=r" (r));
-	if (*r != 0x4455aa77)
-		err();
-
-
-	t += 32770;
-	mb(); /* don't reorder anything beyond here.  */
-	cris_tst_cc_init();
-	asm volatile ("setf\tzvnc\n");
-	cris_addo_pi_w(p, t);
-	cris_tst_cc(1, 1, 1, 1);
-	asm volatile ("move.d\t$acr, %0\n" : "=r" (r));
-	if (*r != 0x4455aa77)
-		err();
-
-	mb(); /* don't reorder anything beyond here.  */
-	cris_tst_cc_init();
-	asm volatile ("setf\tzvnc\n");
-	cris_addo_d(p, r);
-	cris_tst_cc(1, 1, 1, 1);
-	p += 4;
-	asm volatile ("move.d\t$acr, %0\n" : "=r" (r));
-	if (*r != 0xee19ccff)
-		err();
-
-	mb(); /* don't reorder anything beyond here.  */
-	cris_tst_cc_init();
-	asm volatile ("setf\tzvnc\n");
-	cris_addo_pi_b(p, t);
-	cris_tst_cc(0, 0, 0, 0);
-	asm volatile ("move.d\t$acr, %0\n" : "=r" (r));
-	if (*(uint16_t*)r != 0xff22)
-		err();
-
-	mb(); /* don't reorder anything beyond here.  */
-	cris_tst_cc_init();
-	asm volatile ("setf\tzvnc\n");
-	cris_addo_b(p, r);
-	cris_tst_cc(1, 1, 1, 1);
-	p += 1;
-	asm volatile ("move.d\t$acr, %0\n" : "=r" (r));
-	if (*r != 0x4455aa77)
-		err();
-
-	mb(); /* don't reorder anything beyond here.  */
-	cris_tst_cc_init();
-	asm volatile ("setf\tzvnc\n");
-	cris_addo_w(p, r);
-	cris_tst_cc(1, 1, 1, 1);
-	p += 2;
-	asm volatile ("move.d\t$acr, %0\n" : "=r" (r));
-	if (*r != 0xff224455)
-		err();
-
-	mb(); /* don't reorder anything beyond here.  */
-	cris_tst_cc_init();
-	asm volatile ("setf\tzvnc\n");
-	cris_addo_pi_d(p, t);
-	cris_tst_cc(0, 0, 0, 0);
-	asm volatile ("move.d\t$acr, %0\n" : "=r" (r));
-	r = (void*)(((char *)r) + 76789885);
-	if (*r != 0x55aa77ff)
-		err();
-
-	pass();
-	return 0;
-}
diff --git a/tests/tcg/cris/libc/check_addoq.c b/tests/tcg/cris/libc/check_addoq.c
deleted file mode 100644
index ed509e27e0..0000000000
--- a/tests/tcg/cris/libc/check_addoq.c
+++ /dev/null
@@ -1,44 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdint.h>
-#include "sys.h"
-#include "crisutils.h"
-
-/* this would be better to do in asm, it's an orgy in GCC inline asm now.  */
-
-/* ACR will be clobbered.  */
-#define cris_addoq(o, v) \
-	asm volatile ("addoq\t%1, %0, $acr\n" : : "r" (v), "i" (o) : "acr");
-
-
-int main(void)
-{
-	int x[3] = {0x55aa77ff, 0xccff2244, 0x88ccee19};
-	int *p, *t = x + 1;
-
-	cris_tst_cc_init();
-	asm volatile ("setf\tzvnc\n");
-	cris_addoq(0, t);
-	cris_tst_cc(1, 1, 1, 1);
-	asm volatile ("move.d\t$acr, %0\n" : "=r" (p));
-	if (*p != 0xccff2244)
-		err();
-
-	cris_tst_cc_init();
-	asm volatile ("setf\tzvnc\n");
-	cris_addoq(4, t);
-	cris_tst_cc(0, 0, 0, 0);
-	asm volatile ("move.d\t$acr, %0\n" : "=r" (p));
-	if (*p != 0x88ccee19)
-		err();
-
-	cris_tst_cc_init();
-	asm volatile ("clearf\tzvnc\n");
-	cris_addoq(-8, t + 1);
-	cris_tst_cc(0, 0, 0, 0);
-	asm volatile ("move.d\t$acr, %0\n" : "=r" (p));
-	if (*p != 0x55aa77ff)
-		err();
-	pass();
-	return 0;
-}
diff --git a/tests/tcg/cris/libc/check_bound.c b/tests/tcg/cris/libc/check_bound.c
deleted file mode 100644
index d956ab9ade..0000000000
--- a/tests/tcg/cris/libc/check_bound.c
+++ /dev/null
@@ -1,142 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdint.h>
-#include "sys.h"
-#include "crisutils.h"
-
-static always_inline int cris_bound_b(int v, int b)
-{
-	int r = v;
-	asm ("bound.b\t%1, %0\n" : "+r" (r) : "ri" (b));
-	return r;
-}
-
-static always_inline int cris_bound_w(int v, int b)
-{
-	int r = v;
-	asm ("bound.w\t%1, %0\n" : "+r" (r) : "ri" (b));
-	return r;
-}
-
-static always_inline int cris_bound_d(int v, int b)
-{
-	int r = v;
-	asm ("bound.d\t%1, %0\n" : "+r" (r) : "ri" (b));
-	return r;
-}
-
-int main(void)
-{
-	int r;
-
-	cris_tst_cc_init();
-	r = cris_bound_d(-1, 2);
-	cris_tst_cc(0, 0, 0, 0);
-	if (r != 2)
-		err();
-
-	cris_tst_cc_init();
-	r = cris_bound_d(2, 0xffffffff);
-	cris_tst_cc(0, 0, 0, 0);
-	if (r != 2)
-		err();
-
-	cris_tst_cc_init();
-	r = cris_bound_d(0xffff, 0xffff);
-	cris_tst_cc(0, 0, 0, 0);
-	if (r != 0xffff)
-		err();
-
-	cris_tst_cc_init();
-	r = cris_bound_d(-1, 0xffffffff);
-	cris_tst_cc(1, 0, 0, 0);
-	if (r != 0xffffffff)
-		err();
-
-	cris_tst_cc_init();
-	r = cris_bound_d(0x78134452, 0x5432f789);
-	cris_tst_cc(0, 0, 0, 0);
-	if (r != 0x5432f789)
-		err();
-
-	cris_tst_cc_init();
-	r = cris_bound_w(-1, 2);
-	cris_tst_cc(0, 0, 0, 0);
-	if (r != 2)
-		err();
-
-	cris_tst_cc_init();
-	r = cris_bound_w(-1, 0xffff);
-	cris_tst_cc(0, 0, 0, 0);
-	if (r != 0xffff)
-		err();
-
-	cris_tst_cc_init();
-	r = cris_bound_w(2, 0xffff);
-	cris_tst_cc(0, 0, 0, 0);
-	if (r != 2)
-		err();
-
-	cris_tst_cc_init();
-	r = cris_bound_w(0xfedaffff, 0xffff);
-	cris_tst_cc(0, 0, 0, 0);
-	if (r != 0xffff)
-		err();
-
-	cris_tst_cc_init();
-	r = cris_bound_w(0x78134452, 0xf789);
-	cris_tst_cc(0, 0, 0, 0);
-	if (r != 0xf789)
-		err();
-
-	cris_tst_cc_init();
-	r = cris_bound_b(-1, 2);
-	cris_tst_cc(0, 0, 0, 0);
-	if (r != 2)
-		err();
-
-	cris_tst_cc_init();
-	r = cris_bound_b(2, 0xff);
-	cris_tst_cc(0, 0, 0, 0);
-	if (r != 2)
-		err();
-
-	cris_tst_cc_init();
-	r = cris_bound_b(-1, 0xff);
-	cris_tst_cc(0, 0, 0, 0);
-	if (r != 0xff)
-		err();
-
-	cris_tst_cc_init();
-	r = cris_bound_b(0xff, 0xff);
-	cris_tst_cc(0, 0, 0, 0);
-	if (r != 0xff)
-		err();
-
-	cris_tst_cc_init();
-	r = cris_bound_b(0xfeda49ff, 0xff);
-	cris_tst_cc(0, 0, 0, 0);
-	if (r != 0xff)
-		err();
-
-	cris_tst_cc_init();
-	r = cris_bound_b(0x78134452, 0x89);
-	cris_tst_cc(0, 0, 0, 0);
-	if (r != 0x89)
-		err();
-
-	cris_tst_cc_init();
-	r = cris_bound_w(0x78134452, 0);
-	cris_tst_cc(0, 1, 0, 0);
-	if (r != 0)
-		err();
-
-	cris_tst_cc_init();
-	r = cris_bound_b(0xffff, -1);
-	cris_tst_cc(0, 0, 0, 0);
-	if (r != 0xff)
-		err();
-
-	pass();
-	return 0;
-}
diff --git a/tests/tcg/cris/libc/check_ftag.c b/tests/tcg/cris/libc/check_ftag.c
deleted file mode 100644
index aaa5c97115..0000000000
--- a/tests/tcg/cris/libc/check_ftag.c
+++ /dev/null
@@ -1,37 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdint.h>
-#include "sys.h"
-#include "crisutils.h"
-
-static always_inline void cris_ftag_i(unsigned int x)
-{
-	register unsigned int v asm("$r10") = x;
-	asm ("ftagi\t[%0]\n" : : "r" (v) );
-}
-static always_inline void cris_ftag_d(unsigned int x)
-{
-	register unsigned int v asm("$r10") = x;
-	asm ("ftagd\t[%0]\n" : : "r" (v) );
-}
-static always_inline void cris_fidx_i(unsigned int x)
-{
-	register unsigned int v asm("$r10") = x;
-	asm ("fidxi\t[%0]\n" : : "r" (v) );
-}
-static always_inline void cris_fidx_d(unsigned int x)
-{
-	register unsigned int v asm("$r10") = x;
-	asm ("fidxd\t[%0]\n" : : "r" (v) );
-}
-
-
-int main(void)
-{
-	cris_ftag_i(0);
-	cris_ftag_d(0);
-	cris_fidx_i(0);
-	cris_fidx_d(0);
-	pass();
-	return 0;
-}
diff --git a/tests/tcg/cris/libc/check_gcctorture_pr28634-1.c b/tests/tcg/cris/libc/check_gcctorture_pr28634-1.c
deleted file mode 100644
index 45ecd159b3..0000000000
--- a/tests/tcg/cris/libc/check_gcctorture_pr28634-1.c
+++ /dev/null
@@ -1,15 +0,0 @@
-/* PR rtl-optimization/28634.  On targets with delayed branches,
-   dbr_schedule could do the next iteration's addition in the
-   branch delay slot, then subtract the value again if the branch
-   wasn't taken.  This can lead to rounding errors.  */
-int x = -1;
-int y = 1;
-int
-main (void)
-{
-  while (y > 0)
-    y += x;
-  if (y != x + 1)
-    abort ();
-  exit (0);
-}
diff --git a/tests/tcg/cris/libc/check_gcctorture_pr28634.c b/tests/tcg/cris/libc/check_gcctorture_pr28634.c
deleted file mode 100644
index a0c525497d..0000000000
--- a/tests/tcg/cris/libc/check_gcctorture_pr28634.c
+++ /dev/null
@@ -1,15 +0,0 @@
-/* PR rtl-optimization/28634.  On targets with delayed branches,
-   dbr_schedule could do the next iteration's addition in the
-   branch delay slot, then subtract the value again if the branch
-   wasn't taken.  This can lead to rounding errors.  */
-double x = -0x1.0p53;
-double y = 1;
-int
-main (void)
-{
-  while (y > 0)
-    y += x;
-  if (y != x + 1)
-    abort ();
-  exit (0);
-}
diff --git a/tests/tcg/cris/libc/check_glibc_kernelversion.c b/tests/tcg/cris/libc/check_glibc_kernelversion.c
deleted file mode 100644
index 7aada89911..0000000000
--- a/tests/tcg/cris/libc/check_glibc_kernelversion.c
+++ /dev/null
@@ -1,116 +0,0 @@
-/*
- * Check the lz insn.
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdint.h>
-#include "sys.h"
-
-#define __LINUX_KERNEL_VERSION 131584
-
-#define DL_SYSDEP_OSCHECK(FATAL) \
-  do {                                                                        \
-    /* Test whether the kernel is new enough.  This test is only              \
-       performed if the library is not compiled to run on all                 \
-       kernels.  */                                                           \
-    if (__LINUX_KERNEL_VERSION > 0)                                           \
-      {                                                                       \
-        char bufmem[64];                                                      \
-        char *buf = bufmem;                                                   \
-        unsigned int version;                                                 \
-        int parts;                                                            \
-        char *cp;                                                             \
-        struct utsname uts;                                                   \
-                                                                              \
-        /* Try the uname syscall */                                           \
-        if (__uname (&uts))                                                   \
-          {                                                                   \
-            /* This was not successful.  Now try reading the /proc            \
-               filesystem.  */                                                \
-            ssize_t reslen;                                                   \
-            int fd = __open ("/proc/sys/kernel/osrelease", O_RDONLY);         \
-            if (fd == -1                                                      \
-                || (reslen = __read (fd, bufmem, sizeof (bufmem))) <= 0)      \
-              /* This also didn't work.  We give up since we cannot           \
-                 make sure the library can actually work.  */                 \
-              FATAL ("FATAL: cannot determine library version\n");            \
-            __close (fd);                                                     \
-            buf[MIN (reslen, (ssize_t) sizeof (bufmem) - 1)] = '\0';          \
-          }                                                                   \
-        else                                                                  \
-          buf = uts.release;                                                  \
-                                                                              \
-        /* Now convert it into a number.  The string consists of at most      \
-           three parts.  */                                                   \
-        version = 0;                                                          \
-        parts = 0;                                                            \
-        cp = buf;                                                             \
-        while ((*cp >= '0') && (*cp <= '9'))                                  \
-          {                                                                   \
-            unsigned int here = *cp++ - '0';                                  \
-                                                                              \
-            while ((*cp >= '0') && (*cp <= '9'))                              \
-              {                                                               \
-                here *= 10;                                                   \
-                here += *cp++ - '0';                                          \
-              }                                                               \
-                                                                              \
-            ++parts;                                                          \
-            version <<= 8;                                                    \
-            version |= here;                                                  \
-                                                                              \
-            if (*cp++ != '.')                                                 \
-              /* Another part following?  */                                  \
-              break;                                                          \
-          }                                                                   \
-                                                                              \
-        if (parts < 3)                                                        \
-          version <<= 8 * (3 - parts);                                        \
-                                                                              \
-        /* Now we can test with the required version.  */                     \
-        if (version < __LINUX_KERNEL_VERSION)                                 \
-          /* Not sufficient.  */                                               \
-          FATAL ("FATAL: kernel too old\n");                                  \
-                                                                              \
-        _dl_osversion = version;                                              \
-      }                                                                       \
-  } while (0)
-
-int main(void)
-{
-        char bufmem[64] = "2.6.22";
-        char *buf = bufmem;
-        unsigned int version;
-        int parts;
-        char *cp;
-
-        version = 0;
-        parts = 0;
-        cp = buf;
-        while ((*cp >= '0') && (*cp <= '9'))
-          {
-            unsigned int here = *cp++ - '0';
-
-            while ((*cp >= '0') && (*cp <= '9'))
-              {
-                here *= 10;
-                here += *cp++ - '0';
-              }
-
-            ++parts;
-            version <<= 8;
-            version |= here;
-
-            if (*cp++ != '.')
-              /* Another part following?  */
-              break;
-          }
-
-        if (parts < 3)
-          version <<= 8 * (3 - parts);
-        if (version < __LINUX_KERNEL_VERSION)
-                err();
-        pass();
-        exit(0);
-}
diff --git a/tests/tcg/cris/libc/check_hello.c b/tests/tcg/cris/libc/check_hello.c
deleted file mode 100644
index fb403ba996..0000000000
--- a/tests/tcg/cris/libc/check_hello.c
+++ /dev/null
@@ -1,7 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-int main ()
-{
-  printf ("pass\n");
-  exit (0);
-}
diff --git a/tests/tcg/cris/libc/check_int64.c b/tests/tcg/cris/libc/check_int64.c
deleted file mode 100644
index 69caec1bb2..0000000000
--- a/tests/tcg/cris/libc/check_int64.c
+++ /dev/null
@@ -1,47 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdint.h>
-#include "sys.h"
-#include "crisutils.h"
-
-
-static always_inline int64_t add64(const int64_t a, const int64_t b)
-{
-	return a + b;
-}
-
-static always_inline int64_t sub64(const int64_t a, const int64_t b)
-{
-	return a - b;
-}
-
-int main(void)
-{
-	int64_t a = 1;
-	int64_t b = 2;
-
-	/* FIXME: add some tests.  */
-	a = add64(a, b);
-	if (a != 3)
-		err();
-
-	a = sub64(a, b);
-	if (a != 1)
-		err();
-
-	a = add64(a, -4);
-	if (a != -3)
-		err();
-
-	a = add64(a, 3);
-	if (a != 0)
-		err();
-
-	a = 0;
-	a = sub64(a, 1);
-	if (a != -1)
-		err();
-
-	pass();
-	return 0;
-}
diff --git a/tests/tcg/cris/libc/check_lz.c b/tests/tcg/cris/libc/check_lz.c
deleted file mode 100644
index bf051a6b55..0000000000
--- a/tests/tcg/cris/libc/check_lz.c
+++ /dev/null
@@ -1,49 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdint.h>
-#include "sys.h"
-
-static always_inline int cris_lz(int x)
-{
-	int r;
-	asm ("lz\t%1, %0\n" : "=r" (r) : "r" (x));
-	return r;
-}
-
-void check_lz(void)
-{
-	int i;
-
-	if (cris_lz(0) != 32)
-		err();
-	if (cris_lz(1) != 31)
-		err();
-	if (cris_lz(2) != 30)
-		err();
-	if (cris_lz(4) != 29)
-		err();
-	if (cris_lz(8) != 28)
-		err();
-
-	/* try all positions with a single bit.  */
-	for (i = 1; i < 32; i++) {
-		if (cris_lz(1 << (i-1)) != (32 - i))
-			err();
-	}
-
-	/* try all positions with all bits.  */
-	for (i = 1; i < 32; i++) {
-		/* split up this computation to clarify it.  */
-		uint32_t val;
-		val = (unsigned int)-1 >> (32 - i);
-		if (cris_lz(val) != (32 - i))
-			err();
-	}
-}
-
-int main(void)
-{
-	check_lz();
-	pass();
-	exit(0);
-}
diff --git a/tests/tcg/cris/libc/check_mapbrk.c b/tests/tcg/cris/libc/check_mapbrk.c
deleted file mode 100644
index 1aff7622bc..0000000000
--- a/tests/tcg/cris/libc/check_mapbrk.c
+++ /dev/null
@@ -1,39 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-
-/* Basic sanity check that syscalls to implement malloc (brk, mmap2,
-   munmap) are trivially functional.  */
-
-int main ()
-{
-  void *p1, *p2, *p3, *p4, *p5, *p6;
-
-  if ((p1 = malloc (8100)) == NULL
-      || (p2 = malloc (16300)) == NULL
-      || (p3 = malloc (4000)) == NULL
-      || (p4 = malloc (500)) == NULL
-      || (p5 = malloc (1023*1024)) == NULL
-      || (p6 = malloc (8191*1024)) == NULL)
-  {
-    printf ("fail\n");
-    exit (1);
-  }
-
-  free (p1);
-  free (p2);
-  free (p3);
-  free (p4);
-  free (p5);
-  free (p6);
-
-  p1 = malloc (64000);
-  if (p1 == NULL)
-  {
-    printf ("fail\n");
-    exit (1);
-  }
-  free (p1);
-
-  printf ("pass\n");
-  exit (0);
-}
diff --git a/tests/tcg/cris/libc/check_mmap1.c b/tests/tcg/cris/libc/check_mmap1.c
deleted file mode 100644
index b803f0c431..0000000000
--- a/tests/tcg/cris/libc/check_mmap1.c
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
-#notarget: cris*-*-elf
-*/
-
-#define _GNU_SOURCE
-#include <string.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <sys/mman.h>
-
-int main (int argc, char *argv[])
-{
-  int fd = open (argv[0], O_RDONLY);
-  struct stat sb;
-  int size;
-  void *a;
-  const char *str = "a string you'll only find in the program";
-
-  if (fd == -1)
-    {
-      perror ("open");
-      abort ();
-    }
-
-  if (fstat (fd, &sb) < 0)
-    {
-      perror ("fstat");
-      abort ();
-    }
-
-  size = sb.st_size;
-
-  /* We want to test mmapping a size that isn't exactly a page.  */
-  if ((size & 8191) == 0)
-    size--;
-
-  a = mmap (NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
-
-  if (memmem (a, size, str, strlen (str) + 1) == NULL)
-    abort ();
-
-  printf ("pass\n");
-  exit (0);
-}
diff --git a/tests/tcg/cris/libc/check_mmap2.c b/tests/tcg/cris/libc/check_mmap2.c
deleted file mode 100644
index 35139a0ed9..0000000000
--- a/tests/tcg/cris/libc/check_mmap2.c
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
-#notarget: cris*-*-elf
-*/
-
-#define _GNU_SOURCE
-#include <string.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <sys/mman.h>
-
-int main (int argc, char *argv[])
-{
-  int fd = open (argv[0], O_RDONLY);
-  struct stat sb;
-  int size;
-  void *a;
-  const char *str = "a string you'll only find in the program";
-
-  if (fd == -1)
-    {
-      perror ("open");
-      abort ();
-    }
-
-  if (fstat (fd, &sb) < 0)
-    {
-      perror ("fstat");
-      abort ();
-    }
-
-  size = sb.st_size;
-
-  /* We want to test mmapping a size that isn't exactly a page.  */
-  if ((size & 8191) == 0)
-    size--;
-
-  a = mmap (NULL, size, PROT_READ, MAP_SHARED, fd, 0);
-
-  if (memmem (a, size, str, strlen (str) + 1) == NULL)
-    abort ();
-
-  printf ("pass\n");
-  exit (0);
-}
diff --git a/tests/tcg/cris/libc/check_mmap3.c b/tests/tcg/cris/libc/check_mmap3.c
deleted file mode 100644
index cb890ef120..0000000000
--- a/tests/tcg/cris/libc/check_mmap3.c
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
-#notarget: cris*-*-elf
-*/
-
-#define _GNU_SOURCE
-#include <string.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <sys/mman.h>
-
-int main (int argc, char *argv[])
-{
-  volatile unsigned char *a;
-
-  /* Check that we can map a non-multiple of a page and still get a full page.  */
-  a = mmap (NULL, 0x4c, PROT_READ | PROT_WRITE | PROT_EXEC,
-            MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-  if (a == NULL || a == (unsigned char *) -1)
-    abort ();
-
-  a[0] = 0xbe;
-  a[8191] = 0xef;
-  memset ((char *) a + 1, 0, 8190);
-
-  if (a[0] != 0xbe || a[8191] != 0xef)
-    abort ();
-
-  printf ("pass\n");
-  exit (0);
-}
diff --git a/tests/tcg/cris/libc/check_moveq.c b/tests/tcg/cris/libc/check_moveq.c
deleted file mode 100644
index 80f2dff6ab..0000000000
--- a/tests/tcg/cris/libc/check_moveq.c
+++ /dev/null
@@ -1,51 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdint.h>
-#include "sys.h"
-#include "crisutils.h"
-
-#define cris_moveq(dst, src) \
-               asm volatile ("moveq %1, %0\n" : "=r" (dst) : "i" (src));
-
-
-
-int main(void)
-{
-	int t;
-
-	cris_tst_cc_init();
-	asm volatile ("setf\tzvnc\n");
-	cris_moveq(t, 10);
-	cris_tst_cc(1, 1, 1, 1);
-	if (t != 10)
-		err();
-
-	/* make sure moveq doesn't clobber the zflag.  */
-	cris_tst_cc_init();
-	asm volatile ("setf vnc\n");
-	asm volatile ("clearf z\n");
-	cris_moveq(t, 0);
-	cris_tst_cc(1, 0, 1, 1);
-	if (t != 0)
-		err();
-
-	/* make sure moveq doesn't clobber the nflag.
-	   Also check large immediates  */
-	cris_tst_cc_init();
-	asm volatile ("setf zvc\n");
-	asm volatile ("clearf n\n");
-	cris_moveq(t, -31);
-	cris_tst_cc(0, 1, 1, 1);
-	if (t != -31)
-		err();
-
-	cris_tst_cc_init();
-	asm volatile ("setf nzvc\n");
-	cris_moveq(t, 31);
-	cris_tst_cc(1, 1, 1, 1);
-	if (t != 31)
-		err();
-
-	pass();
-	return 0;
-}
diff --git a/tests/tcg/cris/libc/check_openpf1.c b/tests/tcg/cris/libc/check_openpf1.c
deleted file mode 100644
index 251d26eec2..0000000000
--- a/tests/tcg/cris/libc/check_openpf1.c
+++ /dev/null
@@ -1,38 +0,0 @@
-/* Check that --sysroot is applied to open(2).
-#sim: --sysroot=@exedir@
-
-   We assume, with EXE being the name of the executable:
-   - The simulator executes with cwd the same directory where the executable
-     is located (so argv[0] contains a plain filename without directory
-     components).
-   - There's no /EXE on the host file system.  */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <errno.h>
-int main (int argc, char *argv[])
-{
-  char *fnam = argv[0];
-  FILE *f;
-  if (argv[0][0] != '/')
-    {
-      fnam = malloc (strlen (argv[0]) + 2);
-      if (fnam == NULL)
-        abort ();
-      strcpy (fnam, "/");
-      strcat (fnam, argv[0]);
-    }
-
-  f = fopen (fnam, "rb");
-  if (f == NULL)
-    abort ();
-  fclose(f);
-
-  /* Cover another execution path.  */
-  if (fopen ("/nonexistent", "rb") != NULL
-      || errno != ENOENT)
-    abort ();
-  printf ("pass\n");
-  return 0;
-}
diff --git a/tests/tcg/cris/libc/check_openpf2.c b/tests/tcg/cris/libc/check_openpf2.c
deleted file mode 100644
index 5d56189f8e..0000000000
--- a/tests/tcg/cris/libc/check_openpf2.c
+++ /dev/null
@@ -1,16 +0,0 @@
-/* Check that the simulator has chdir:ed to the --sysroot argument
-#sim: --sysroot=@srcdir@
-   (or that  --sysroot is applied to relative file paths).  */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <errno.h>
-int main (int argc, char *argv[])
-{
-  FILE *f = fopen ("check_openpf2.c", "rb");
-  if (f == NULL)
-    abort ();
-  fclose(f);
-  printf ("pass\n");
-  return 0;
-}
diff --git a/tests/tcg/cris/libc/check_openpf3.c b/tests/tcg/cris/libc/check_openpf3.c
deleted file mode 100644
index 557adee92d..0000000000
--- a/tests/tcg/cris/libc/check_openpf3.c
+++ /dev/null
@@ -1,49 +0,0 @@
-/* Basic file operations (rename, unlink); once without sysroot.  We
-   also test that the simulator has chdir:ed to PREFIX, when defined.  */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-
-#ifndef PREFIX
-#define PREFIX
-#endif
-
-void err (const char *s)
-{
-  perror (s);
-  abort ();
-}
-
-int main (int argc, char *argv[])
-{
-  FILE *f;
-  struct stat buf;
-
-  unlink (PREFIX "testfoo2.tmp");
-
-  f = fopen ("testfoo1.tmp", "w");
-  if (f == NULL)
-    err ("open");
-  fclose (f);
-
-  if (rename (PREFIX "testfoo1.tmp", PREFIX "testfoo2.tmp") != 0)
-    err ("rename");
-
-  if (stat (PREFIX "testfoo2.tmp", &buf) != 0
-      || !S_ISREG (buf.st_mode))
-    err ("stat 1");
-
-  if (stat ("testfoo2.tmp", &buf) != 0
-      || !S_ISREG (buf.st_mode))
-    err ("stat 2");
-
-  if (unlink (PREFIX "testfoo2.tmp") != 0)
-    err ("unlink");
-
-  printf ("pass\n");
-  return 0;
-}
diff --git a/tests/tcg/cris/libc/check_openpf5.c b/tests/tcg/cris/libc/check_openpf5.c
deleted file mode 100644
index 1f86ea283d..0000000000
--- a/tests/tcg/cris/libc/check_openpf5.c
+++ /dev/null
@@ -1,56 +0,0 @@
-/* Check that TRT happens when error on too many opened files.
-#notarget: cris*-*-elf
-#sim: --sysroot=@exedir@
-*/
-#include <stddef.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <errno.h>
-#include <limits.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <string.h>
-
-int main (int argc, char *argv[])
-{
-  int i;
-  int filemax;
-
-#ifdef OPEN_MAX
-  filemax = OPEN_MAX;
-#else
-  filemax = sysconf (_SC_OPEN_MAX);
-#endif
-
-  char *fn = malloc (strlen (argv[0]) + 2);
-  if (fn == NULL)
-    abort ();
-  strcpy (fn, "/");
-  strcat (fn, argv[0]);
-
-  for (i = 0; i < filemax + 1; i++)
-    {
-      if (open (fn, O_RDONLY) < 0)
-	{
-	  /* Shouldn't happen too early.  */
-	  if (i < filemax - 3 - 1)
-	    {
-	      fprintf (stderr, "i: %d\n", i);
-	      abort ();
-	    }
-	  if (errno != EMFILE)
-	    {
-	      perror ("open");
-	      abort ();
-	    }
-	  goto ok;
-	}
-    }
-  abort ();
-
-ok:
-  printf ("pass\n");
-  exit (0);
-}
diff --git a/tests/tcg/cris/libc/check_settls1.c b/tests/tcg/cris/libc/check_settls1.c
deleted file mode 100644
index 3abc3a9ea8..0000000000
--- a/tests/tcg/cris/libc/check_settls1.c
+++ /dev/null
@@ -1,45 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <unistd.h>
-
-#include <sys/syscall.h>
-
-#ifndef SYS_set_thread_area
-#define SYS_set_thread_area 243
-#endif
-
-int main (void)
-{
-    unsigned long tp, old_tp;
-    int ret;
-
-    asm volatile ("move $pid,%0" : "=r" (old_tp));
-    old_tp &= ~0xff;
-
-    ret = syscall (SYS_set_thread_area, 0xf0);
-    if (ret != -1 || errno != EINVAL) {
-        syscall (SYS_set_thread_area, old_tp);
-        perror ("Invalid thread area accepted:");
-        abort();
-    }
-
-    ret = syscall (SYS_set_thread_area, 0xeddeed00);
-    if (ret != 0) {
-        perror ("Valid thread area not accepted: ");
-        abort ();
-    }
-
-    asm volatile ("move $pid,%0" : "=r" (tp));
-    tp &= ~0xff;
-    syscall (SYS_set_thread_area, old_tp);
-
-    if (tp != 0xeddeed00) {
-        * (volatile int *) 0 = 0;
-        perror ("tls2");
-        abort ();
-    }
-
-    printf ("pass\n");
-    return EXIT_SUCCESS;
-}
diff --git a/tests/tcg/cris/libc/check_sigalrm.c b/tests/tcg/cris/libc/check_sigalrm.c
deleted file mode 100644
index 39fa8d9bac..0000000000
--- a/tests/tcg/cris/libc/check_sigalrm.c
+++ /dev/null
@@ -1,26 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <signal.h>
-#include <unistd.h>
-
-#define MAGIC (0xdeadbeef)
-
-int s = 0;
-void sighandler(int sig)
-{
-	s = MAGIC;
-}
-
-int main(int argc, char **argv)
-{
-	int p;
-
-	p = getpid();
-	signal(SIGALRM, sighandler);
-	kill(p, SIGALRM);
-	if (s != MAGIC)
-		return EXIT_FAILURE;
-
-	printf ("passed\n");
-	return EXIT_SUCCESS;
-}
diff --git a/tests/tcg/cris/libc/check_stat1.c b/tests/tcg/cris/libc/check_stat1.c
deleted file mode 100644
index 2e2cae51df..0000000000
--- a/tests/tcg/cris/libc/check_stat1.c
+++ /dev/null
@@ -1,16 +0,0 @@
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <stdio.h>
-#include <stdlib.h>
-
-int main (void)
-{
-  struct stat buf;
-
-  if (stat (".", &buf) != 0
-      || !S_ISDIR (buf.st_mode))
-    abort ();
-  printf ("pass\n");
-  exit (0);
-}
diff --git a/tests/tcg/cris/libc/check_stat2.c b/tests/tcg/cris/libc/check_stat2.c
deleted file mode 100644
index e36172ed25..0000000000
--- a/tests/tcg/cris/libc/check_stat2.c
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
-#notarget: cris*-*-elf
-*/
-
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <stdio.h>
-#include <stdlib.h>
-
-int main (void)
-{
-  struct stat buf;
-
-  if (lstat (".", &buf) != 0
-      || !S_ISDIR (buf.st_mode))
-    abort ();
-  printf ("pass\n");
-  exit (0);
-}
diff --git a/tests/tcg/cris/libc/check_stat3.c b/tests/tcg/cris/libc/check_stat3.c
deleted file mode 100644
index 36a9d5d274..0000000000
--- a/tests/tcg/cris/libc/check_stat3.c
+++ /dev/null
@@ -1,25 +0,0 @@
-/* Simulator options:
-#sim: --sysroot=@exedir@
-*/
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-
-int main (int argc, char *argv[])
-{
-  char path[1024] = "/";
-  struct stat buf;
-
-  strncat(path, argv[0], sizeof(path) - 2);
-  if (stat (".", &buf) != 0
-      || !S_ISDIR (buf.st_mode))
-    abort ();
-  if (stat (path, &buf) != 0
-      || !S_ISREG (buf.st_mode))
-    abort ();
-  printf ("pass\n");
-  exit (0);
-}
diff --git a/tests/tcg/cris/libc/check_stat4.c b/tests/tcg/cris/libc/check_stat4.c
deleted file mode 100644
index 04f21fe7c4..0000000000
--- a/tests/tcg/cris/libc/check_stat4.c
+++ /dev/null
@@ -1,27 +0,0 @@
-/* Simulator options:
-#notarget: cris*-*-elf
-#sim: --sysroot=@exedir@
-*/
-
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-
-int main (int argc, char *argv[])
-{
-  char path[1024] = "/";
-  struct stat buf;
-
-  strncat(path, argv[0], sizeof(path) - 2);
-  if (lstat (".", &buf) != 0
-      || !S_ISDIR (buf.st_mode))
-    abort ();
-  if (lstat (path, &buf) != 0
-      || !S_ISREG (buf.st_mode))
-    abort ();
-  printf ("pass\n");
-  exit (0);
-}
diff --git a/tests/tcg/cris/libc/check_swap.c b/tests/tcg/cris/libc/check_swap.c
deleted file mode 100644
index 9a68c1e5d7..0000000000
--- a/tests/tcg/cris/libc/check_swap.c
+++ /dev/null
@@ -1,76 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdint.h>
-#include "sys.h"
-#include "crisutils.h"
-
-#define N 8
-#define W 4
-#define B 2
-#define R 1
-
-static always_inline int cris_swap(const int mode, int x)
-{
-	switch (mode)
-	{
-		case N: asm ("swapn\t%0\n" : "+r" (x) : "0" (x)); break;
-		case W: asm ("swapw\t%0\n" : "+r" (x) : "0" (x)); break;
-		case B: asm ("swapb\t%0\n" : "+r" (x) : "0" (x)); break;
-		case R: asm ("swapr\t%0\n" : "+r" (x) : "0" (x)); break;
-		case B|R: asm ("swapbr\t%0\n" : "+r" (x) : "0" (x)); break;
-		case W|R: asm ("swapwr\t%0\n" : "+r" (x) : "0" (x)); break;
-		case W|B: asm ("swapwb\t%0\n" : "+r" (x) : "0" (x)); break;
-		case W|B|R: asm ("swapwbr\t%0\n" : "+r" (x) : "0" (x)); break;
-		case N|R: asm ("swapnr\t%0\n" : "+r" (x) : "0" (x)); break;
-		case N|B: asm ("swapnb\t%0\n" : "+r" (x) : "0" (x)); break;
-		case N|B|R: asm ("swapnbr\t%0\n" : "+r" (x) : "0" (x)); break;
-		case N|W: asm ("swapnw\t%0\n" : "+r" (x) : "0" (x)); break;
-		default:
-			err();
-			break;
-	}
-	return x;
-}
-
-/* Made this a macro to be able to pick up the location of the errors.  */
-#define verify_swap(mode, val, expected, n, z)          \
-do {                                                    \
-        int r;                                          \
-        cris_tst_cc_init();                             \
-	r = cris_swap(mode, val);                       \
-        cris_tst_mov_cc(n, z);                          \
-	if (r != expected)                              \
-		err();                                  \
-} while(0)
-
-void check_swap(void)
-{
-	/* Some of these numbers are borrowed from GDB's cris sim
-	   testsuite.  */
-	if (cris_swap(N, 0) != 0xffffffff)
-		err();
-	if (cris_swap(W, 0x12345678) != 0x56781234)
-		err();
-	if (cris_swap(B, 0x12345678) != 0x34127856)
-		err();
-
-	verify_swap(R, 0x78134452, 0x1ec8224a, 0, 0);
-	verify_swap(B, 0x78134452, 0x13785244, 0, 0);
-	verify_swap(B|R, 0x78134452, 0xc81e4a22, 1, 0);
-	verify_swap(W, 0x78134452, 0x44527813, 0, 0);
-	verify_swap(W|R, 0x78134452, 0x224a1ec8, 0, 0);
-	verify_swap(W|B|R, 0x78134452, 0x4a22c81e, 0, 0);
-	verify_swap(N, 0x78134452, 0x87ecbbad, 1, 0);
-	verify_swap(N|R, 0x78134452, 0xe137ddb5, 1, 0);
-	verify_swap(N|B, 0x78134452, 0xec87adbb, 1, 0);
-	verify_swap(N|B|R, 0x78134452, 0x37e1b5dd, 0, 0);
-	verify_swap(N|W, 0x78134452, 0xbbad87ec, 1, 0);
-	verify_swap(N|B|R, 0xffffffff, 0, 0, 1);
-}
-
-int main(void)
-{
-	check_swap();
-	pass();
-	return 0;
-}
diff --git a/tests/tcg/cris/libc/check_time2.c b/tests/tcg/cris/libc/check_time2.c
deleted file mode 100644
index 20b69b4f60..0000000000
--- a/tests/tcg/cris/libc/check_time2.c
+++ /dev/null
@@ -1,18 +0,0 @@
-/* CB_SYS_time doesn't implement the Linux time syscall; the return
-   value isn't written to the argument.  */
-
-#include <time.h>
-#include <stdio.h>
-#include <stdlib.h>
-
-int
-main (void)
-{
-  time_t x = (time_t) -1;
-  time_t t = time (&x);
-
-  if (t == (time_t) -1 || t != x)
-    abort ();
-  printf ("pass\n");
-  exit (0);
-}
-- 
2.45.2


