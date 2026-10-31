Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FAA606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 20:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FTM336Sa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNG6e-0000ma-0M; Sat, 31 Oct 2026 16:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <takano32@gmail.com>)
 id 1xNG6c-0000ls-74
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 16:55:14 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <takano32@gmail.com>)
 id 1xNG6a-0004ix-Gn
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 16:55:13 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3ad41b47541so1525290a91.1
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 13:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793480111; x=1794084911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gFVk3oih9DS0LLY5asZ/G/Ce34H8tbZKr/F/Tvew0YQ=;
 b=FTM336SasaH5oHfS242n9fyaMA8U3yxUSLxiUYomMvJ5X619xO3TNlCcR4zczHr2Kp
 EevFPv/C7v7ZQeYQVBiHpZzhzbodjABy7WGZAvLTShu1FqV92nXIQfAukU5xgxKZoNzO
 uOoCwGAl1oJR7+nKGub6OmdqqP2H96Oon6yvEY47AEDzlX2DqEBT9g/pWYyEpqCW9VNU
 N0w6wypZtmFr3BdOiO/QIT8Z2IJ/0LYfZJp2n767dZkGNEob3+jWPk+SvVFSixH/MDru
 n9bMp34ot2WQj3T2SkUbe6dfZ9mzD9BKSn4zX7qjhiZ3w+/SBp6zqAVsZq3hYOvZE3Nd
 IjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793480111; x=1794084911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gFVk3oih9DS0LLY5asZ/G/Ce34H8tbZKr/F/Tvew0YQ=;
 b=rEHHkab3dCBGYJJIfnJcl09khJmy+b6gKRcjBj4mzrqhxm39TjlaNhWWKxMZWPfP+L
 nHaXa/P9LmyTg42NVfIo4StTFo/8LtAfWlKtqvtOHdtlNOSCVyhn+qQYIfCIby/GZ6s6
 8iVnlHb/xtzXPtB1tfr9qFSW1iq+izkepk7T4A27xkOHVamOLepuxWRv467r7evJnQGE
 mK2ju67JccMGr71ICpE8OPM14zDX6DKFBkxSCpHYiVq7Jm/zl/6Gf6S63MQScxJB82KQ
 YdhiqxsdTJJgMnS6mY0AmtWsfyThfHijUAINd2DFKsrvLHKuwcDP817RYili/n5QqLAp
 IVDg==
X-Gm-Message-State: AFq9FYKrurNAK3Yy29QEtKQjsi+31jElUrx0QsTTeHEktOtWzVfkER2E
 yUc1AC5lpg6tYJ3btdHX3kulP2yxmGRfoA0zbvKYF0iD1UIx+21u8CIIe8mKWQ==
X-Gm-Gg: AYBFou02q4iIRdRn0YyjhrS2418ekQCGOUlgHbaka2gWEPEa/znyTxCi2nfhCwmIkY3
 5UtZ0ACbLqUJjNchR3A9Dwq7vYPvlGagskBYLdk6vB9E6sBkgbosGckncJe56avtPJ01WwETTrM
 HOHmia5NzIJy7Cbfl93Z/zWYmQacSoh3mSif+8AgQkMrdDPa8w098RANrv1a2F7WGs1VDkaxkrR
 mV60Xeh4g08IGIa60y6ADHrQTDGH60+cjSZKlgekkUvbyNCcgPl7YLHNvxz8/y4KqpiEeK94caB
 hmFRFuUA0mi4r+LgVvNdIixe5XviAawUAp/9UTxURMsIhQt4GruGY6Pup2gGfVfw7922utH8eUt
 LUvNysBpY3fUklDCl8dh5tZaHNQ8pzd7hnw922Ln4QitONBIptnqceLxtpcjBpfcyl0bN84Z8Kg
 /c7J3wLWxPHZFtsjMUjjShntdcnz0z1Xs1NBS1KlmFJgmmoaZBfH+6qNELGGbZpc/cbWufX92b5
 eehd6fH/YodeBhqh7+3KWFP5v9lRbfi6Jhmdsy+QADrYmSwHHIEpgZbY5TTxbKs0vHbbMUt7jRI
 kz38Lm0XqvT6brkpCNP6shFTcUbfiyvF5GoA+pNuiA==
X-Received: by 2002:a17:90b:3b85:b0:3ab:188b:c5b1 with SMTP id
 98e67ed59e1d1-3ae897e4182mr5100681a91.56.1793480110720; 
 Sat, 31 Oct 2026 13:55:10 -0700 (PDT)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae87ee7765sm4772952a91.2.2026.10.31.13.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 13:55:09 -0700 (PDT)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/2] linux-user: report EFAULT for a NULL sysinfo/getitimer
 buffer
Date: Sat, 31 Oct 2026 20:55:01 +0000
Message-ID: <20261031205501.1988785-3-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261031205501.1988785-1-takano32@gmail.com>
References: <20261031205501.1988785-1-takano32@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=takano32@gmail.com; helo=mail-pj1-x1030.google.com
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

Both handlers skip the copy-out when the guest pointer is zero and return
success, so a caller that forgets the buffer gets an uninitialised result
instead of the EFAULT the kernel reports for a NULL address.

Copy unconditionally: a NULL pointer then fails in lock_user_struct() and
in copy_to_user_timeval() like any other unusable address.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 linux-user/syscall.c                          |  4 +--
 tests/tcg/multiarch/linux/linux-null-buffer.c | 35 +++++++++++++++++--
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 59cbf5feaad..2fc61b3eabc 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11551,7 +11551,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             struct itimerval value;
 
             ret = get_errno(getitimer(arg1, &value));
-            if (!is_error(ret) && arg2) {
+            if (!is_error(ret)) {
                 if (copy_to_user_timeval(arg2,
                                          &value.it_interval)
                     || copy_to_user_timeval(arg2 + sizeof(struct target_timeval),
@@ -11666,7 +11666,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             struct target_sysinfo *target_value;
             struct sysinfo value;
             ret = get_errno(sysinfo(&value));
-            if (!is_error(ret) && arg1)
+            if (!is_error(ret))
             {
                 if (!lock_user_struct(VERIFY_WRITE, target_value, arg1, 0))
                     return -TARGET_EFAULT;
diff --git a/tests/tcg/multiarch/linux/linux-null-buffer.c b/tests/tcg/multiarch/linux/linux-null-buffer.c
index 6246e477070..b099803c574 100644
--- a/tests/tcg/multiarch/linux/linux-null-buffer.c
+++ b/tests/tcg/multiarch/linux/linux-null-buffer.c
@@ -1,6 +1,15 @@
 /*
- * A zero-length getrandom() needs no valid buffer: the kernel never looks at
- * the pointer, so getrandom(NULL, 0, 0) succeeds.
+ * Degenerate buffer pointers must behave like they do in the kernel.
+ *
+ * A zero-length getrandom() needs no valid buffer: the pointer is never
+ * used, so getrandom(NULL, 0, 0) succeeds.  A required output buffer, on
+ * the other hand, must not be silently skipped: sysinfo() and getitimer()
+ * have to report EFAULT for a NULL pointer.
+ *
+ * The NULL cases go through syscall() rather than the libc wrappers: on
+ * 32-bit x86, for example, getitimer() hands the kernel a local structure
+ * and copies the result out itself, so it would follow the NULL pointer
+ * before the kernel's answer could be seen.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
@@ -9,11 +18,31 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <sys/random.h>
+#include <sys/syscall.h>
+#include <sys/sysinfo.h>
+#include <sys/time.h>
+#include <unistd.h>
 
 int main(void)
 {
+    char buf[8];
+    struct itimerval it;
+    struct sysinfo si;
+
+    /* A zero-length request is not rejected for a NULL buffer. */
     errno = 0;
-    assert(getrandom(NULL, 0, 0) == 0);
+    assert(syscall(SYS_getrandom, NULL, 0, 0) == 0);
+
+    /* A NULL output pointer is reported, not silently skipped. */
+    errno = 0;
+    assert(syscall(SYS_sysinfo, NULL) == -1 && errno == EFAULT);
+    errno = 0;
+    assert(syscall(SYS_getitimer, ITIMER_REAL, NULL) == -1 && errno == EFAULT);
+
+    /* The ordinary calls still work. */
+    assert(getrandom(buf, sizeof(buf), 0) == sizeof(buf));
+    assert(sysinfo(&si) == 0);
+    assert(getitimer(ITIMER_REAL, &it) == 0);
 
     return EXIT_SUCCESS;
 }
-- 
2.53.0


