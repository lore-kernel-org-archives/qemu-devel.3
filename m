Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40D6C982C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6rbC-0002QL-P0; Wed, 16 Sep 2026 11:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6rau-0002EY-Dw
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:30:47 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6raq-0001UR-9O
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:30:43 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd38e0e5dso12080555e9.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 08:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789572639; x=1790177439; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TzPZ0Kw3U1piRUlkV8dXwbUvUko3iq9aG6DE/6nhXq4=;
 b=Dds+l+TskSFa7o8JjBl69tRXoBqkqhq1BYZ8cxlgx33VGI6ZDtA+Mc6CiWInKpwBd6
 J70D0Rnr6NQVowenB5lHKzxSzyjdlKReTgTqkFTahmEi4YAE9Y39oxhjXa/hzCEEbOph
 tzc9J0A7Vpkyf1bn5C1Ec+j5UcvAwKHl5LGefgnOvkOxZLyCjxZPSA6NSQx9RPT8mOEo
 CB96wxV4WXSFTQD+v1DkLKViB9vY+GTkh+e/nR+k7tfaSk02JkJJIXAg+OxivuGnwiW2
 evzspFCmnJPzxUQJeMJ3o8oXZxT/89aXnOCYIrlZchuynyfeEr/zzitFx+rVlfKt39yU
 LwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789572639; x=1790177439;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TzPZ0Kw3U1piRUlkV8dXwbUvUko3iq9aG6DE/6nhXq4=;
 b=x4CYhVROowcOvWtJsaVHCcy4KLNtRSfZrTmZ/qsU7bRQ88bt/pfCi+NuyIbodrgPFC
 43YB1UYWeUd7Ja7uJhKqh/wFXaRch/qHcqq154BdCVGXPBe5fmCdtcYM6o4Tb1R/6KvH
 a3SIA79iQ/OQ3/mCX0fYw4hj84UTYi4oLMI7MOcV58Jff2SuewAKfe13eZWVI1MYFXda
 L0yM46+qHne0SDs1DvuQvnR7HOv4lwG0Pq1c149K4cBH5PGUWFFXWAYt5WGABqqaGqS2
 3fS+m3Lj9hjswrc7zuAfRYj4h/ltir0QetmfGg4LHRjy+M2cXNIZ9v3pnLI5H5QsNtVY
 BM7A==
X-Gm-Message-State: AFuF++m7CUJbdeLNoyAas0M4otew5KNgmo4RdT6zMUhv7Iug8ubF+/MX
 MW+RPOff7H49Hy3cDT5JsxGCK8bgB9JCqns2ZKvwwOWI6NpN7ux+GNIiCfbBcYH/928=
X-Gm-Gg: AYBFou2sO3DxUdlfhfnF8Y4oJ1Dm0Ziu699Ic2Dujh/d/MzzF/hncSSGrUvj4shqHKD
 L7tH/jeAhsQP3mhmD2e5axnyibCmr7JegFHfc2uKBlINJWxXDoD6S4Dq9tE4XiX8ZNAgxiZHGFt
 A78jtDxkdH/0wzRC8Umv/h9PmI6T0ogwZovI9A1KbjeR8tbd6nvXbfV8XYnjYlQIg/7/kLUiIym
 RFaWpjsClEAQdHdo4RRd/slBzj9fOqK7m5dtKXzo3Wxwsb3hiBALYyJeJETqA1AdMbI3Es7PHOT
 teyprFnKWk/bbop9+4bCs7PwmVnJPzbCGV78WrGfeYo+Tb8vJBqgKEqK0hnCCFcaCeRxJTzjudr
 WukreypnFJViYnDrtN2++K5/0XFxsvboe3zt5lKGnPLlSGxenFsdbAgdW/J7ZW5enns6G9jXA+L
 muw6te6p4BuERJ5e/zbZMepV0lWkFtzHP4bVkBPuF2BUyYYeOrsLgVBkoZ+S9qLj60FpWR2Os=
X-Received: by 2002:a05:600c:c16a:b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-49eb7302175mr82400805e9.7.1789572638711; 
 Wed, 16 Sep 2026 08:30:38 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e847fcbdfsm51415865e9.4.2026.09.16.08.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 08:30:22 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D93176191C;
 Wed, 16 Sep 2026 16:30:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-arm@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Kyle Evans <kevans@freebsd.org>,
 Eric Farman <farman@linux.ibm.com>, Brad Smith <brad@comstyle.com>,
 Fabiano Rosas <farosas@suse.de>, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 06/19] tests/tcg/s390x: Provide the libc bits needed by the
 system tests
Date: Wed, 16 Sep 2026 16:29:59 +0100
Message-ID: <20260916153013.2134555-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916153013.2134555-1-alex.bennee@linaro.org>
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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
Message-ID: <20260915110959.492195-1-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/s390x/libc/stdio.h       | 11 +++++++++++
 tests/tcg/s390x/libc/string.h      | 12 ++++++++++++
 tests/tcg/s390x/system/meson.build |  2 ++
 3 files changed, 25 insertions(+)
 create mode 100644 tests/tcg/s390x/libc/stdio.h
 create mode 100644 tests/tcg/s390x/libc/string.h

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


