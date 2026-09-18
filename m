Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34EFC982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7ZWe-0006BD-GG; Fri, 18 Sep 2026 10:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZW7-0005mY-Kj
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:44 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZW5-0007pp-Su
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:43 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ccff31419so7020565e9.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 07:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789741480; x=1790346280; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oWAJUZu655m1aKS80ThOnRI0ZvPTEOFh17G+teRw+uQ=;
 b=zoQddMPKbi4DVYgsrDW6l61WskPk2NAFT+qC+G6SCdkWRB6F4spdKOpfhhQWgYu6iw
 DvOMFqCMccWKDDuW2ygI7KdEumVQMd4ckdJ980yQEUswpEFNo8qku/KqfPh7gPnkNMSZ
 48hhKF7RJTtXaYCmptx1ZfDkPrhXfo4usli66ujLnXRbbRB4kuIg0jCnQVnHBTaUBkzz
 Qx39ej+q9AKyzen9HtMh9QhLwdM2CAmQ4xBZQBPKQl6nMV8jsM4++MGD7vAwEDAbDAB8
 2NkBR/xSZoywM6pvPYALEpn6kkTVpNsAaN6KSNKdikGUxN5k5EyrZIccYXOO9BmvcyjV
 7i0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789741480; x=1790346280;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oWAJUZu655m1aKS80ThOnRI0ZvPTEOFh17G+teRw+uQ=;
 b=ScYRmDJe2L4pnlGTDHh7rIk4HikyvA3z2jhfVHftDS6J9QodqW2YtJd9CpZBK8mNEk
 EUBi4DPnTbLMeZ4nGYFs9UdSlHaa/dXQG6OOwUKNWHY+t0uRV1iBOa27P+z0S75HkbLI
 ml7FZAu2KqPgLx7qfx0FRddA+xPxrDwbyuUzIGxchsuOh3HxOzCkUdNol+rm7si5c+NP
 jlouewrzKjEyqyWhUkvbhTm9eRoQ6ggPOQXMuJymE8dCyKfWYIp4e2VYip9LXjMeh6qg
 HVVP4wO9+FwaW5QMnNCih2r0PcQVsxhjk/CfhMpxH9j3qCTDv+mO7vOhi1avGu0IzojN
 Ugfg==
X-Gm-Message-State: AFuF++mCYXM+8vGPhOELsymdh9j0d6hXMJbjnnj2S5mFjPVLfhvO0VXu
 i8lrOtPPMYxgJMMFOqqZ7xU9l08B2Q+ueiZ2V1cHBOZzxXK8NpH5R7VQbpvZ3LVyhJg=
X-Gm-Gg: AYBFou2TYEe7ry5DqlOUk3w2WNx8ZTaVN8v3DxU9Use2ZRM6RtgAy/xxw7tMKyHgnkL
 StFsicIsgjJOAZwMMud9/f5/pcSOA7gC6Wf87Ti+K6zrrxqYyJmFHGjeLc5cprqarphySWyTsiD
 kKhNn+ykb6I4tWC2B/LVCOJQCwp859AG8frSzAu+ocb2pDeiFz25YCFrhtCcFoRlAO7sK553PBN
 rN9jkFnnqaLgnWzZKakFZjWjNXnRMPxWuW5AuUSuH0N6057JKq13U7Uq2/kyXjIDGX+TkfbBY9R
 Cc1aioKqNinsKWlobSUvwSt9fTHYhHBskj8TxCZUaT3oHvX1dg510zHLJkjVLSjeQhLW00+mRmA
 4ZABgKuLu35pDjWWJMDwEKhWPIOYp8moi0jqlN2bdBqxbrrMbEyYADJ1rfmFWrlap6aRUMvKIFl
 rE1DXqx1msG7yjKHMHYye4i9dmmn2Br5zsB4CPkuQD9Myr+NypMdXwQO6qpPzO5dv9t5VG0Iw=
X-Received: by 2002:a05:600c:1f87:b0:49d:99:1d98 with SMTP id
 5b1f17b1804b1-49fc56ae924mr39995105e9.9.1789741480487; 
 Fri, 18 Sep 2026 07:24:40 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc7cfd1dasm60818585e9.9.2026.09.18.07.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 07:24:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 446405FA8E;
 Fri, 18 Sep 2026 15:24:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs)
Subject: [PULL 06/17] tests/tcg/s390x: Provide the libc bits needed by the
 system tests
Date: Fri, 18 Sep 2026 15:24:17 +0100
Message-ID: <20260918142429.336497-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918142429.336497-1-alex.bennee@linaro.org>
References: <20260918142429.336497-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

The meson conversion dropped the SLOF libc include path that commit
3fa010d5317 ("tests/tcg/s390x: Use the SLOF libc headers for the
multiarch tests") had added, breaking the build on systems without a
cross-libc, such as Fedora.

Rather than reintroducing a dependency on the SLOF submodule, which no
other tcg test has, declare the three functions that the reused pc-bios
code actually needs: memcpy(), memset(), and printf().

Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Closes: https://patchew.org/QEMU/20260910100120.2076092-1-berrange@redhat.com/
Suggested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Fixes: cd81cf86834 ("tests/tcg/s390x: system tests")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260915110959.492195-1-iii@linux.ibm.com>
Message-ID: <20260917165602.3405537-6-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/s390x/libc/stdio.h b/tests/tcg/s390x/libc/stdio.h
new file mode 100644
index 00000000000..c3e45995f65
--- /dev/null
+++ b/tests/tcg/s390x/libc/stdio.h
@@ -0,0 +1,11 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef QEMU_TESTS_S390X_STDIO_H
+#define QEMU_TESTS_S390X_STDIO_H
+
+#include <minilib.h>
+
+#define printf ml_printf
+
+#endif
diff --git a/tests/tcg/s390x/libc/string.h b/tests/tcg/s390x/libc/string.h
new file mode 100644
index 00000000000..1cabeb90adf
--- /dev/null
+++ b/tests/tcg/s390x/libc/string.h
@@ -0,0 +1,12 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef QEMU_TESTS_S390X_STRING_H
+#define QEMU_TESTS_S390X_STRING_H
+
+#include <stddef.h>
+
+void *memcpy(void *dest, const void *src, size_t n);
+void *memset(void *dest, int c, size_t size);
+
+#endif
diff --git a/tests/tcg/s390x/system/meson.build b/tests/tcg/s390x/system/meson.build
index ca07f503058..1e360e70821 100644
--- a/tests/tcg/s390x/system/meson.build
+++ b/tests/tcg/s390x/system/meson.build
@@ -6,11 +6,13 @@ link_script = files('../softmmu.ld')[0]
 head64 = files('../head64.S')[0]
 console = files('../console.c')[0]
 ipl_inc = meson.project_source_root()/'include'/'hw'/'s390x'/'ipl'
+libc_inc = meson.current_source_dir()/'..'/'libc'
 cflags = ['-nostdlib',
           '-ffreestanding',
           '-Wa,--noexecstack',
           '-I', minilib_dir, minilib_printf,
           '-I', ipl_inc,
+          '-I', libc_inc,
           '-march=z13',
           head64, console]
 asmflags = ['-nostdlib',
-- 
2.47.3


