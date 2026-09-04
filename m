Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734A0C79F87
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TQO-0001jl-SW; Fri, 04 Sep 2026 08:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQM-0001iN-SU
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:42 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQJ-0000j2-Ka
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:42 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so653503f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526418; x=1789131218; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tSGS0QY0qxFrueseQGf85D55r9ldCZWLznsFFW+Fs7o=;
 b=PtLDyWFOdJDyDSYM3QBSj7HbFlmpbQkjLCmZuDaQw6Cv4M216Fwt7aOFDbV7qp/tJH
 JALr+0jWx2mLeNWX0JLwMAYhuPsfzOmyWQbqNrMQFPW19crtO64gnDMnV6lWRMoNAhe+
 0WLjdQOpfWK8ZsK9fKHrMzcLYc76ANrqp1GxjPZlSQ6A1pcrQ662cH0skmIc6tjXjfgE
 MDmGnfx7ZR+kcKla5OxTDMzPKI5m3dnBQsKYPRp20GpbUibGt+DcCqyRjILKemVhtiCt
 pAqH3aU93WdZcoB6/SmADlHIsw8PmzKeII3eoboO3YPaFxPor6voUUYNCL+HFshrBpif
 wDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526418; x=1789131218;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tSGS0QY0qxFrueseQGf85D55r9ldCZWLznsFFW+Fs7o=;
 b=OtKsKh4AzpoPEDaRb0dnh+YZ9iwhv6i7A4tg1X0QthJBLIaknoCZK5eOEQaZgUp2mS
 izlMIbMlDIPE2TVFF9xX3K0fjpmOinH0ANizQHpPZd8ds0VbTiNTW9BeIdPXCQH3bdh0
 APPoliH/SOwYXUHNYYfKX/8kQH+aO7k3g818A0G/liYwillAlJylYcAji9yEMhqqWf+G
 CWHUGzXmKTMVb4+LTqcbeenMArq3WagfdyF1hLRbNtrv7EWgffdS7Uu/rR7XbWuhZiaQ
 dB9HfHYVfdUGUTvbdSf2rENi2oKk+xKIItzKvwQprhz8C3ELbdOrSP9B4Knjb733pkR7
 jBcg==
X-Gm-Message-State: AFuF++lbvsk7lvrurF7/8a/QZO/5FpxZWrfoPdxPmidG3fYS1DPu2Iii
 KCLIaY/gS90EdLEQggQa8bNH7Ht2tXPRLJbHe7taGojh5clfC5i3r7vxC/YyjomGK7s=
X-Gm-Gg: AYBFou2KqF7XcjIezNxXz0A9FWtFhvKs4QmrRXHl5k7pHljuQc78qnCihFL9EA0XCYx
 KIeChU5jjvPbHU9Y9n1SQBfbQXnQHgawN6V7Ttehpj705DyE6AL3QdRCzvrNAe1Qy/oGEUDSC3F
 evt5drCmvhxJQb6cJktKjPf1r+G80sqf97hNSJsSOlTx/qncuVctxC0Gv5Ov+mC+aV3jsz5sxlU
 PjjSOPgmOT3HLjJ5iSsszTu+g/80LwT0Ly7RszsGgjilsQ13iaMNohePK/ZjtRczgYZTyDT+9Yv
 IDNiyLSGCXXwAMnK59BdAhSh/SFQWpqQFSQFNsfyI+Cvey8rhx+gcZ18ZezxlN3s+HhkEZhPxgB
 O8ozaUBuNsc3w3ghdLbGCCo7718fMzl+PpNW0HEqm6jhXS3PdcAp1xpWDzgMseLehclGfU0qTxc
 BM+xEMIrBybaLqJ0u6rT+1Bar1U8u+Awp+wJED0SyicLxrc4tmYX+MSY9ASm8fHf3RXLL0LOg=
X-Received: by 2002:a05:6000:388:b0:485:8c75:48fb with SMTP id
 ffacd0b85a97d-4858c75598cmr2776819f8f.50.1788526417991; 
 Fri, 04 Sep 2026 05:53:37 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885c5bbdsm5799346f8f.36.2026.09.04.05.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:53:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3F81961CEA;
 Fri, 04 Sep 2026 13:46:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PULL 065/105] tests/tcg/mips64: user tests
Date: Fri,  4 Sep 2026 13:45:19 +0100
Message-ID: <20260904124604.2207440-66-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-66-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 3d7438245dc..0102e74e8a7 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -146,6 +146,7 @@ subdir('i386')
 subdir('loongarch64')
 subdir('m68k')
 subdir('mips')
+subdir('mips64')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/mips64/Makefile.target b/tests/tcg/mips64/Makefile.target
deleted file mode 100644
index 042855844a8..00000000000
--- a/tests/tcg/mips64/Makefile.target
+++ /dev/null
@@ -1,20 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# SPDX-License-Identifier: GPL-2.0-or-later
-#
-# MIPS64 - included from tests/tcg/Makefile.target
-#
-
-MIPS64_SRC=$(SRC_PATH)/tests/tcg/mips64
-MIPS_OCTEON_SRC=$(SRC_PATH)/tests/tcg/mips/user/isa/octeon
-
-# Set search path for all sources
-VPATH 		+= $(MIPS64_SRC) $(MIPS_OCTEON_SRC)
-
-MIPS64_TESTS=octeon-insns
-
-TESTS += $(MIPS64_TESTS)
-
-$(MIPS64_TESTS): CFLAGS+=-mabi=64
-
-run-octeon-insns: QEMU_OPTS+=-cpu Octeon68XX
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
new file mode 100644
index 00000000000..69391c23187
--- /dev/null
+++ b/tests/tcg/mips64/meson.build
@@ -0,0 +1,27 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  '../mips/user/isa/octeon/octeon-insns.c': {
+    'qemu_args': ['-cpu', 'Octeon68XX'],
+  },
+}
+
+# export tests for mips64el
+tcg_tests_mips64 = tests
+
+if 'qemu-mips64' in emulators
+  tcg_tests += {
+    'mips64-linux-user': {
+      'cc': 'mips64-linux-gnuabi64-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'mips64',
+      'gdb_arch': 'mips64',
+      'qemu': emulators['qemu-mips64'],
+      'tests': tcg_tests_mips64,
+    }
+  }
+endif
diff --git a/tests/tcg/mips64el/Makefile.target b/tests/tcg/mips64el/Makefile.target
index dbc5f8dc5fe..78c722a583d 100644
--- a/tests/tcg/mips64el/Makefile.target
+++ b/tests/tcg/mips64el/Makefile.target
@@ -5,4 +5,4 @@
 # MIPS64 little-endian - included from tests/tcg/Makefile.target
 #
 
-include $(SRC_PATH)/tests/tcg/mips64/Makefile.target
+#include $(SRC_PATH)/tests/tcg/mips64/Makefile.target
-- 
2.47.3


