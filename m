Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B28BCAC5BB
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 02:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v48hr-0006xI-DZ; Wed, 01 Oct 2025 22:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v48hh-0006tU-Mf
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 22:05:57 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v48h3-0004uL-Nu
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 22:05:55 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-28e7cd6dbc0so6060915ad.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 19:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759370710; x=1759975510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hFvkW3z/PAnkLcAJE9Ay4t0rDH7kBttYpIpnByYXZUc=;
 b=SELQBk4clIH3LLIsMcUxIpc5PEdgIX+HmTl9qdIjsp5dWpODku3/L5ssTLa5135QXI
 f2nWxzIZ1bRyV/y+jYOYCPhymPgUcWyV3uBqSon6M0JeI1Pvnyb0TxWWL2gLb0XcGk/F
 r6dpiOZzMvfvl1hz0cxUgCvQSQEAt1Udt+YvTmQ5a6fEawWkUkKwI1G9HQfNqPOLbfEq
 08UZqFRKUm/MuwFHkjTTFwzm6X+FXsbTLPClzdYgXuu7JMAe7sFT7zDtg4ju6rgQStln
 IKD0Bvnw8XMERP55d5pk/P1RdSb4BiqiePaYQNUFzV5Nup+sLE8MhdvyLnqsCtlWAsGL
 eZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759370710; x=1759975510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hFvkW3z/PAnkLcAJE9Ay4t0rDH7kBttYpIpnByYXZUc=;
 b=utzdpNiJnpHsT+RMW17nLbgKTBMWKeRcuz1daRywxgA5Qr7LqLJUKOxBONOmFCojK8
 0/gueLAsCAMPlg034s2+1i103BxQzvyQBt8EAGfOnKfhZRDvq628oIOAJvYYd1EqLYPp
 29DK8i4XJPbU/k33j0Ikkv7u/y53CDvBRX8ocxhAgzhnRC9s/QJUh/VSi40roBENpgJd
 KfdXbHFilj10bZJl+HisGzanZIiIvET1oMM5vlwTYuDdn174Pb9ZE+v/q8xf/7I8M5Wj
 raqViuF7R+blqg/NzAHhmNL5tZ97Lpg/g9QyIc040fWU3ZRnNQh0LXlhzUMTI4cPPea5
 Ka+g==
X-Gm-Message-State: AOJu0YwfhfR5Ci86XmgY20HWGmtcFjAOifEjV5vUNXmzT94K0D/57Gx7
 B5sgDrKYUksXBjXRWJMisrdIxVUwhZFQM3SGSRLjPsCdzr/R6qVr0sKF3eEkgOOSPJeHJv4uXSZ
 Dr9OQ
X-Gm-Gg: ASbGncsgg47UXowsoQWQejMIEUjFfuGTnKSFgLTa/NSOfwzieEn49OGF74ldyVuzQyN
 taqM1D4Eg4c/l0o+FCG32pA0j4qaAbqnk7H2C5Q0E0wiyusBzKdLkz5OViJEMdev3X5+vg+zof0
 duMS4v1L0YeBR4O3WybVeOGACpkfKNs6e1z8nOobWUGIdxE4Je1A5PYS9094FM+mc7yW78+m53U
 XBpyCg9SOfI6D9Aplni9ntBUC+Wffgv0hea3T0PQtKFYv6vthGblCmtOJrSnfFIKe8UWk2m1qQo
 ql9GMSDUJuaNFKV/LXwPl6knCXZbBSrI6Oczo2hRWbn8jeMITY4YT/srMhLzeeVaJ2XIjw02Fzd
 +q3DxPmna9d+QgtQnyyNIqecdGLhIkeLlxvgMCPEzzCCV7wS9zoZGS5YE
X-Google-Smtp-Source: AGHT+IER39CB5C5lEIYhSjtI+zFL2q832SgequQubJHbr1j253ZoIunNnAEO7q6+2njrV+Cfm5dVXw==
X-Received: by 2002:a17:902:f64f:b0:269:b2ff:5c0e with SMTP id
 d9443c01a7336-28e7f328e5bmr65831415ad.46.1759370710284; 
 Wed, 01 Oct 2025 19:05:10 -0700 (PDT)
Received: from gromero0.. ([186.215.59.111]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1d95bdsm9476735ad.119.2025.10.01.19.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 19:05:09 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v5 7/9] tests/functional: Add decorator to skip test on
 missing env vars
Date: Thu,  2 Oct 2025 02:04:30 +0000
Message-Id: <20251002020432.54443-8-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251002020432.54443-1-gustavo.romero@linaro.org>
References: <20251002020432.54443-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Add a decorator to skip tests on missing env variable(s). Multiple
variable names can be provided and if one or more of them are not set in
the test environment the test is skipped and the missing vars are
printed out.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/functional/qemu_test/__init__.py   |  3 ++-
 tests/functional/qemu_test/decorators.py | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index 60d19891bf..320193591b 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -15,7 +15,8 @@
 from .linuxkernel import LinuxKernelTest
 from .decorators import skipIfMissingCommands, skipIfNotMachine, \
     skipFlakyTest, skipUntrustedTest, skipBigDataTest, skipSlowTest, \
-    skipIfMissingImports, skipIfOperatingSystem, skipLockedMemoryTest
+    skipIfMissingImports, skipIfOperatingSystem, skipLockedMemoryTest, \
+    skipIfMissingEnv
 from .archive import archive_extract
 from .uncompress import uncompress
 from .gdb import GDB
diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
index c0d1567b14..b239295804 100644
--- a/tests/functional/qemu_test/decorators.py
+++ b/tests/functional/qemu_test/decorators.py
@@ -11,6 +11,24 @@
 from .cmd import which
 
 '''
+Decorator to skip execution of a test if the provided
+environment variables are not set.
+Example:
+
+  @skipIfMissingEnv("QEMU_ENV_VAR0", "QEMU_ENV_VAR1")
+'''
+def skipIfMissingEnv(*vars_):
+    missing_vars = []
+    for var in vars_:
+        if os.getenv(var) == None:
+            missing_vars.append(var)
+
+    has_vars = True if len(missing_vars) == 0 else False
+
+    return skipUnless(has_vars, f"Missing env var(s): {', '.join(missing_vars)}")
+
+'''
+
 Decorator to skip execution of a test if the list
 of command binaries is not available in $PATH.
 Example:
-- 
2.34.1


