Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87D5606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 20:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TEP2Iv1q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNG6b-0000lk-Di; Sat, 31 Oct 2026 16:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <takano32@gmail.com>)
 id 1xNG6Z-0000kq-Ax
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 16:55:11 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <takano32@gmail.com>)
 id 1xNG6X-0004ig-LQ
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 16:55:11 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3ab752f6244so2534730a91.2
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 13:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793480108; x=1794084908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=khyefkDvxu9elgvS2Ym6JQ3MKBgTRdap+wvNkxs3UHw=;
 b=TEP2Iv1qhka7sPzOhy8zbQ1zDXJbbjJNsZg3EGeamo/zbxmdsRC7ljllfZ3wnL1xh3
 aR+zzIUSHkIHxXIKp/ucgwdOMm15q393HKfrf+u+CgEpZoQgZGzzibqVpVTkjfyy6UAP
 a/7+/652wpXGMXkSu49ZMutMqDxrGEJpYcbvSrBy8t1NtdaeHpxhioNLHe/ghUSyC2FQ
 qXgkf3FGyroAqKV80AlC3UkhHDYUfqIKO3I7gwlgjCw7IILKKyGJNBFqD0v+SKhn8EtD
 pQN4RCAdzYxQ1YyV0UXyxxPtqUJarj3BiQrz/8UjpVE7/ZA0erNBP8K+53DiIj66LGnN
 W6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793480108; x=1794084908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=khyefkDvxu9elgvS2Ym6JQ3MKBgTRdap+wvNkxs3UHw=;
 b=0t2AyyLGizDv2mkEid7pWS2OKLTt5ZcNvoMVLeTs0p81qNwJF+mY4YJQFuFTtopR0i
 whpcow4c7DdZtF0Oi55gPkcDdn1IyHG4cwfG5YYR17rrMvCzDAgQigoT1Gq7UGFOd7MM
 zri7hqkbl2OAenkCR9i7jwIAMN2StUscqwnk1qVOt3ScVKVc7qdxw18rQwl5HSk2gMR5
 +/HOR9GprmeGMe6se+Vw+a9cKT2WgE4PACwhjjsgrkCsugyL8ePnrj9vDnWxf7dQqABt
 734TFWSCcIwElnkHnEqTexFr9L4ZnFXW34HVlrl/ZzTxigNkfqyPdfuQzy6RpLSNklSq
 J41A==
X-Gm-Message-State: AFq9FYIHZpqLnd6OjPnB5SNY7MP32121tTzkTZttUt6YSKIJz/7GL3lP
 2og4Y/00hWA7Jz6N/UfZrfJ7FfslalmVb4bd/Zv60TPJf/SYNM3n4Q14BLO+UQ==
X-Gm-Gg: AYBFou2JhzkajCIjSR4gZvmMmaKoXwPSR6FE0C1iQgTVpqxkWqVZGlOJNqjHZmo3D77
 ApsIYQvbNaz4a4r50JKkZ+MYmCz4PW/dSl9ZNj7id/IRoqTpw2Y+8yyHSoq/kCLpeDqhLOcsW9M
 BLRAqVx9ueXJkw11/LL7LTvrM9OWK6nzGaJP1soeiypXNa++HbxJ7aXh2Pv2K3022w+ovWN23dC
 o894JeIZaCYx8xW35xsVOXBbbgmsjkXw1kmWwHXPNqvYabqEedT+cHKRVeaOYMNCZfVCNi03maz
 0NjqkDBPMpAgcx1gRBZb+CTYlMh0pq9vW6VQszI9vrKcX9zfG2Q2M1Cz5gMOCbFRx0aZWmVzuWL
 rOmlwe3vv3Djzesbq5sk1gE1ruLbk5JBrD4ArsLaEqdbIRggk9Q/OXpFP+GptBy01zKFV0COQ+g
 JcBoTrl89heefHz73MKi2eowCtNz7AMb73Idn0IjTHO6tevekh/l/mUoFJbft4wOK5i18xQK5nx
 8/XkEnUo2cAe3K0b0en533w8Vk3gblvKk3g9kM8wi9qLAtP8moCApync2JVZJUVjK3pQPSGYssD
 CTNJbZ7nQdjhFfG+9AVm
X-Received: by 2002:a17:90b:3d4b:b0:3ad:eb4c:26fb with SMTP id
 98e67ed59e1d1-3ae897c87acmr5003008a91.23.1793480108162; 
 Sat, 31 Oct 2026 13:55:08 -0700 (PDT)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae87ee7765sm4772952a91.2.2026.10.31.13.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 13:55:07 -0700 (PDT)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/2] linux-user: allow a zero-length getrandom with a NULL
 buffer
Date: Sat, 31 Oct 2026 20:55:00 +0000
Message-ID: <20261031205501.1988785-2-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261031205501.1988785-1-takano32@gmail.com>
References: <20261031205501.1988785-1-takano32@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=takano32@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The kernel never looks at the buffer of a zero-length request, so
getrandom(NULL, 0, 0) returns 0.  qemu-user hands the request to
lock_user() unconditionally, and a NULL or otherwise unusable address
fails there with EFAULT even though nothing is copied.

read(), write(), pread64() and pwrite64() already special-case the
zero-length request; do the same here.  The address plays no part in it:
with a zero length it is never dereferenced, whatever value the caller
passes.

Fixes: f894efd19917 ("linux-user: add getrandom() syscall")
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 linux-user/syscall.c                          |  8 ++++++++
 tests/tcg/multiarch/linux/linux-null-buffer.c | 19 +++++++++++++++++++
 tests/tcg/multiarch/meson.build               |  1 +
 3 files changed, 28 insertions(+)
 create mode 100644 tests/tcg/multiarch/linux/linux-null-buffer.c

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9d85a193efe..59cbf5feaad 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11456,6 +11456,14 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #endif
 #if defined(TARGET_NR_getrandom) && defined(__NR_getrandom)
     case TARGET_NR_getrandom:
+        if (arg2 == 0) {
+            /*
+             * A zero-length request has no buffer to lock, and the kernel
+             * never looks at the pointer for it, so pass the call through
+             * instead of failing on a NULL or otherwise unusable address.
+             */
+            return get_errno(getrandom(NULL, 0, arg3));
+        }
         p = lock_user(VERIFY_WRITE, arg1, arg2, 0);
         if (!p) {
             return -TARGET_EFAULT;
diff --git a/tests/tcg/multiarch/linux/linux-null-buffer.c b/tests/tcg/multiarch/linux/linux-null-buffer.c
new file mode 100644
index 00000000000..6246e477070
--- /dev/null
+++ b/tests/tcg/multiarch/linux/linux-null-buffer.c
@@ -0,0 +1,19 @@
+/*
+ * A zero-length getrandom() needs no valid buffer: the kernel never looks at
+ * the pointer, so getrandom(NULL, 0, 0) succeeds.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#define _GNU_SOURCE
+#include <assert.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <sys/random.h>
+
+int main(void)
+{
+    errno = 0;
+    assert(getrandom(NULL, 0, 0) == 0);
+
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/multiarch/meson.build b/tests/tcg/multiarch/meson.build
index e60a0527007..8f2f57d9ab4 100644
--- a/tests/tcg/multiarch/meson.build
+++ b/tests/tcg/multiarch/meson.build
@@ -57,6 +57,7 @@ tests += {
 # Linux tests
 tests += {
   multiarch/'linux/linux-madvise.c': {},
+  multiarch/'linux/linux-null-buffer.c': {},
   multiarch/'linux/linux-shmat-maps.c': {},
   multiarch/'linux/linux-shmat-null.c': {},
   multiarch/'linux/linux-sigrtminmax.c': {},
-- 
2.53.0


