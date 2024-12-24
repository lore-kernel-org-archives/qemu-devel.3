Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3585E7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQB9o-0002kP-8p; Tue, 24 Dec 2024 15:05:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9i-0002jE-Fr
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:26 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9g-0002Ud-Sh
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:26 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2166360285dso57544885ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070723; x=1735675523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+v7eNfvrqQSZE5BwDanDqUsLKy4GSW+67YoWGKlQXJ4=;
 b=NZ1TpG3XefX4+yahtm2rKAHsAgCFQQfi3/2BYhmdRSZuG3Xp8cIualiwE2pyABvbvg
 LezyPHKOyczli27mnNGmLaYKsOpGpPG1+O9LWJpU4yo4cqtnj1To1fodCWrS+8ahj8FF
 WpQPHp/9fVthfu/dSjVNjy6Qqgftq+4uNq21qyyH+VG1ttzl3H0chq8VfpND3MBU8OFH
 lkO2E/7sn+vXmUI1nKn5QBuvFwzn2+anCktpYkBCLPW8rK9y9cwcnn7lnR+LTfZLCmd3
 43jOyPVEi9z5dqlmESVN9qDGApwt1Tlgx/rptIamBLHytigpOahyB0m0nvyXqbu0opJp
 XhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070723; x=1735675523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+v7eNfvrqQSZE5BwDanDqUsLKy4GSW+67YoWGKlQXJ4=;
 b=Cpcr5ctZGdZ7bPO8BrYQFHIUQwmJ34uwocNdFSX/ndPafC1903qnEjK3JHC2p47bEE
 C+Yzmu2V4DteAedBRZDkiujXb3t2GH2C+HPFeimNX9SeaCUWUcYx/4CCMn7c5DqEL6cc
 4coFO/21xpjSzW2di1winO3Fazmaan7BU6sSyFFtk+XtvgSFzYXwJksZSoG4OUkcuf5f
 gZHk3SrtJrBiW20SPD0MRovMtpuwIlWLC5qvdJ8bT7Dm8tLJ4YyyP6Jh3N7arFavz28k
 yofQzx8R4n1XIPDPkykl2fZA2JtkaD2G0uGKB8PLrzRR1n9BjslSBOTWRSKWycAqcPD/
 nXOQ==
X-Gm-Message-State: AOJu0YztmSeIJL9dre06sLOfFURr+gl/7lxFAR1i4cQ+O6dJnYQRBiPn
 1XHUitIfECWfg+pnbhgjv5KWzJ+DXxW605deLy8RhjiC/8Q4hbyVn3KzWoZjlVvcbgrSQyId3xz
 XF2w=
X-Gm-Gg: ASbGncsh/8UM35HlcCN31bGB55WAdnUg5QVa0ykCFiHP0cOnKK2+3ivYE1DhLs/i36F
 +x3tBwPz1N2kUwDSrmD/LDKi3IB3k70M63rcC3BrQskOMryILwDnLEYqqt2FrnGuFSoZ98+sifW
 j80qr93cXbCBRrSxTYl6L34E2lV5Z2FgWDKELl9oGdj90brHpRq99zvLjr2H0SNF3GqvCDdPWkm
 Is62jMG7nblPbP6vF/q73lWjvfinrsK8dH0rtOzE7ukq3nzjMioZZvYiI9Tyfp6upPR36ANIejd
 JILZaGT1903nrBABNYwDoLOf9g==
X-Google-Smtp-Source: AGHT+IE5br+fXAv0BqRRd2AqdrFaSlgjeIaohIQa8ZYlAySt/S5VFuX8jjSY62EVYOYlGWyJE7NRXw==
X-Received: by 2002:a05:6a20:841d:b0:1e1:b19a:fb58 with SMTP id
 adf61e73a8af0-1e5e0480dc7mr31260952637.13.1735070723567; 
 Tue, 24 Dec 2024 12:05:23 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 01/72] tests/tcg: Do not use inttypes.h in
 multiarch/system/memory.c
Date: Tue, 24 Dec 2024 12:04:10 -0800
Message-ID: <20241224200521.310066-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

make check-tcg fails on Fedora with the following error message:

    alpha-linux-gnu-gcc [...] qemu/tests/tcg/multiarch/system/memory.c -o memory [...]
    qemu/tests/tcg/multiarch/system/memory.c:17:10: fatal error: inttypes.h: No such file or directory
       17 | #include <inttypes.h>
          |          ^~~~~~~~~~~~
    compilation terminated.

The reason is that Fedora has cross-compilers, but no cross-glibc
headers. Fix by hardcoding the format specifiers and dropping the
include.

An alternative fix would be to introduce a configure check for
inttypes.h. But this would make it impossible to use Fedora
cross-compilers for softmmu tests, which used to work so far.

Fixes: ecbcc9ead2f8 ("tests/tcg: add a system test to check memory instrumentation")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20241010085906.226249-1-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/multiarch/system/memory.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/multiarch/system/memory.c b/tests/tcg/multiarch/system/memory.c
index 65a6038a24..7508f6b916 100644
--- a/tests/tcg/multiarch/system/memory.c
+++ b/tests/tcg/multiarch/system/memory.c
@@ -14,7 +14,6 @@
 
 #include <stdint.h>
 #include <stdbool.h>
-#include <inttypes.h>
 #include <minilib.h>
 
 #ifndef CHECK_UNALIGNED
@@ -511,8 +510,8 @@ int main(void)
     int i;
     bool ok = true;
 
-    ml_printf("Test data start: 0x%"PRIxPTR"\n", &test_data[0]);
-    ml_printf("Test data end: 0x%"PRIxPTR"\n", &test_data[TEST_SIZE]);
+    ml_printf("Test data start: 0x%lx\n", (unsigned long)&test_data[0]);
+    ml_printf("Test data end: 0x%lx\n", (unsigned long)&test_data[TEST_SIZE]);
 
     /* Run through the unsigned tests first */
     for (i = 0; i < ARRAY_SIZE(init_ufns) && ok; i++) {
@@ -529,8 +528,8 @@ int main(void)
         ok = do_signed_reads(true);
     }
 
-    ml_printf("Test data read: %"PRId32"\n", test_read_count);
-    ml_printf("Test data write: %"PRId32"\n", test_write_count);
+    ml_printf("Test data read: %lu\n", (unsigned long)test_read_count);
+    ml_printf("Test data write: %lu\n", (unsigned long)test_write_count);
     ml_printf("Test complete: %s\n", ok ? "PASSED" : "FAILED");
     return ok ? 0 : -1;
 }
-- 
2.43.0


