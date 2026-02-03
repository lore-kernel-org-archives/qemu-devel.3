Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4764EE7C712
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 11:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnEx2-0007vC-V2; Tue, 03 Feb 2026 06:52:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnEwy-0007sq-No
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:52:10 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnEwv-00057k-Js
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:52:08 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-65808bb859cso8230495a12.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 03:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770119524; x=1770724324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ruv1Ejeh4EyN1qePTlvxJYVwjWJP4ANv3Gjqm9WaH/s=;
 b=ZOWOVQG8O3R3Beyhbr0DfLC+y19xlLLLVcwPaq1axmuijbpfZkKCYBv9K5m6gJmkzQ
 pwYEiYDzyLML9UDfqoHSyOUDkpzTBnH9io+bClImN6JGdeVqY0RRtBFtvAa9zF2rnktS
 PWf+DxqNxB9GN1oMW5KBuNvIn0P0o5o1KsQD07r0STN2AG8IS7HFdOm/I72/QFiAiGbv
 0HWCSQUxV6Amr+tf/WOwIUM/WC/ZCS335oCWaAlse+p9rKRh0/Qjq/yStsRjRhmM2AP5
 7nR3OIKo1E+tkTKwrx13hvly32FUhNg9Zi6wrRfX3Yh8PEP5+Zs8Od82w1+fsme6Fmr6
 DXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770119524; x=1770724324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ruv1Ejeh4EyN1qePTlvxJYVwjWJP4ANv3Gjqm9WaH/s=;
 b=ROD4vH0v2otlVx3GlEcsCkopqp+xpTgmHFMho656fp0lq9fEiH3x/rloMh/uvZNJRn
 FmJbENOhYzdIc308LfSSxCSVNu0rtRr79fbnV5MMFmXALIZcHGGG9gtv7w8UZELM5nGE
 xqPd/2xQaKsAEugnMOJzEZojC75NRG2/5Yb4RI77OjO7ZC0lUkEirBFLGHcpyEcycLY0
 8AwE4cNi4Am75rYTHbDIk0Gu2ftjr66V6KIYUz+fiC/Uya074zmoQCDaxq8rnALTc+kQ
 OCv2HGfvuGb0Q2aTaHz5PkAnhnT86Tnax7Me+FVDgKrpZvArtHWcLRJhOcsNxBZmpHSv
 4djw==
X-Gm-Message-State: AOJu0Yxq1ffeDtYWhRqOitokcb9bU+QqaohZ8FhM5+ZD6eh0oW5B4Akt
 3nVjre7AYIu6pKf/ycegxqXAx1diRHNQ5U2T0SkZPP3YElKSattHuxnHurOv4mVy9IM=
X-Gm-Gg: AZuq6aKsqKyPBq1smLWcgDduzvEuVaUW0Iv3PY1YdQecErkSMhGaCem/SbMN8+biIFz
 U3vtL1lrOy1tkXc2hXG8UEfmyZyjE1N1hE39/hEQPHCJPTYQydMwGEZAm39rRzxZQZCCXLowxZE
 pNTxyAePlP4qNKPOhSKjuf8mIaVntz2l0bQfWPq1v4UVxSVrZi2yGWm1FqQNgukNGmWKaTevG8X
 +bCeTnUwcM+GlXmK0r1L033x6gQCJ9UgICr+2ZKCm4cIMRzQxVh7vx33bh/ued/Iqoesrjz+aDF
 w5nVzZwFxk1/hFnKTn+JPbVO9kzqDvavmXgfy1AwH3XDKB4FECC3iW6diU55XB59wUKRT9fPyFE
 uDa/rfnEk3ckp6/+6eUXZlxatAtWU9ClZKwqYIs6vdiMedELMXcewXCY84z3yUW543tVD12VDYj
 3GRzy1UzW/4SU=
X-Received: by 2002:a17:907:3f17:b0:b8a:f3c0:c14 with SMTP id
 a640c23a62f3a-b8dff721f68mr889105166b.38.1770119523924; 
 Tue, 03 Feb 2026 03:52:03 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8dbf2ecc73sm1039332166b.62.2026.02.03.03.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 03:52:03 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 26F4B5F844;
 Tue, 03 Feb 2026 11:52:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 01/11] meson-buildoptions: Remove duplicated entry of --gdb in
 the help text
Date: Tue,  3 Feb 2026 11:51:51 +0000
Message-ID: <20260203115201.2387721-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203115201.2387721-1-alex.bennee@linaro.org>
References: <20260203115201.2387721-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

Since --gdb has recently been added to meson_options.txt, the help
text shows up twice in the output of "./configure --help":

 $ ./configure --help | grep gdb
   --gdb=GDB-path           gdb to use for gdbstub tests [/usr/bin/gdb]
   --gdb=VALUE              Path to GDB

As the probed value is of interest we want to keep the configure text
so make meson-buildoptions able to handle deferring to configure.

Fixes: b46b3818cf8 ("tests/functional: Provide GDB to the functional tests")
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
---
 scripts/meson-buildoptions.py | 9 ++++++++-
 scripts/meson-buildoptions.sh | 1 -
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/meson-buildoptions.py b/scripts/meson-buildoptions.py
index e636d258e8a..9e3a75c8b11 100644
--- a/scripts/meson-buildoptions.py
+++ b/scripts/meson-buildoptions.py
@@ -53,6 +53,11 @@
     "werror",
 }
 
+# Options that configure prints help for, so we can skip
+CONFIGURE_HELP = {
+    "gdb",
+}
+
 # Builtin options that should be definable via configure.  Some of the others
 # we really do not want (e.g. c_args is defined via the native file, not
 # via -D, because it's a mix of CFLAGS and --extra-cflags); for specific
@@ -189,7 +194,9 @@ def print_help(options):
         key = cli_help_key(opt)
         # The first section includes options that have an arguments,
         # and booleans (i.e., only one of enable/disable makes sense)
-        if require_arg(opt):
+        if opt["name"] in CONFIGURE_HELP:
+            pass
+        elif require_arg(opt):
             metavar = cli_metavar(opt)
             left = f"--{key}={metavar}"
             help_line(left, opt, 27, True)
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 3d0d1323446..e8edc5252a3 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -58,7 +58,6 @@ meson_options_help() {
   printf "%s\n" '  --enable-ubsan           enable undefined behaviour sanitizer'
   printf "%s\n" '  --firmwarepath=VALUES    search PATH for firmware files [share/qemu-'
   printf "%s\n" '                           firmware]'
-  printf "%s\n" '  --gdb=VALUE              Path to GDB'
   printf "%s\n" '  --iasl=VALUE             Path to ACPI disassembler'
   printf "%s\n" '  --includedir=VALUE       Header file directory [include]'
   printf "%s\n" '  --interp-prefix=VALUE    where to find shared libraries etc., use %M for'
-- 
2.47.3


