Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32484C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr270-0003Gx-NC; Sat, 08 Mar 2025 16:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr26x-0003Eh-KV
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:35 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr26v-0000ur-RG
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:35 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so1611655f8f.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741470812; x=1742075612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y7Djw++6bd8H+I5OGX8uaoGwshCQs34Mn3t1BV9txfE=;
 b=gddV4xwYO0d26YaisfWACyGaJXDqG4MOur/ayBmQe++GBadacUvowAz4/mWyG7yv41
 w2zb7VHiw6ien1sdXX80TVCmNJ8NmWyFIbkYB7naKQBbha3vtWufZoY5IgEl7TCvDkId
 WX/fkkFtaclxEDe93k1ah7va30FDW0VGCxW0+W3DsZLRURgOspSo6X4s/Rmpy6tfPJVZ
 /cxU8L0Bk7VKkQpmmarmeMSB9teMXfxgjHUTQF3iAG/mXEDqjDbme4uVkpc8EnPpJZcE
 D2Zove40Xz6oPMFNQtNCcUQtgSIXb/Q2QAkUOhQ+EMFPsKYkxBgd9Noy6LDybGn1kve/
 Dm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741470812; x=1742075612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y7Djw++6bd8H+I5OGX8uaoGwshCQs34Mn3t1BV9txfE=;
 b=xT1exdtz5lnHjSKArPv3BG9YcqkmEnINMDy8KR8e0qkXOxs7mDGsZk4kBUfIUbd98t
 Z5uGshB/F3vSxZzuVOc7guB2di5xRyiJgV2VaRb7LeiWVOUZLjA1xsL9NN4xPiGqU0+j
 Wbi9YBT/t1cOdE8rCR0LygXwikCQg3bMRvL90afwouRqF0sFwjYiKUZN39k7v4j1Grzg
 fF7fi0SwdujITX3VeBWVqKorc4Ewp2nus8suaq+if1VGhEVxiKITUAm5KJAH2AkL1kp1
 rxPw2wQBlXj0qIrEu5dtI/9sdczUSG56UINd8J5yY0QoasPEZ6Dk8zytJkTO1WH0dq3A
 TnIA==
X-Gm-Message-State: AOJu0YxhCP1hfY0yiI31GaBax+RnkIOw2T/eJM9mwM0+KQeZ3GNSRAPI
 f1Xlary8CFrpq1ylZqD67Fyw5nEkXoaL+dh+OY7/HC2KDiTAqQkxO2qV2FZ91U1FOzFHx8Fyqc3
 q
X-Gm-Gg: ASbGncsel+Q7YfL93ceQkjMfW4YorY9yBwU6cYEaQPEcafsTpSfkzngh6HNMN7ODIYD
 piPIQXouatv6p5ydt1XnxE/te6equAr6Or3oKcDDwuw/EhN2mlHjXdPZQaKbcM42wm1WYOGiVNH
 dnXw9JnCNetwDAE2CmanA+fHaLP/KVSd6aN/4l8TphEeDjWqMjf9LxxZ/JssO87kww3H0O9k5Nz
 moTrVBw5lScDo1kZQ3e6eF8Z1Yg3FXufL0JvVXGWn/iIUz9TEMborOr/fPmSDVRHbf0zBTfLT24
 L+35hjdfOl07MVpr87FmQx9yOmF0UydIn3soNbH0m5mz8lk=
X-Google-Smtp-Source: AGHT+IGF76jmOqzOFP094Xg5IDWuxR/XFMMbUElZmXI6vO7Z5tMN4rciOlV4+KqS9K/dsXdjzJ+huw==
X-Received: by 2002:a5d:6d09:0:b0:391:34:4fa9 with SMTP id
 ffacd0b85a97d-39132b56eccmr6458941f8f.0.1741470812144; 
 Sat, 08 Mar 2025 13:53:32 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c103aa5sm10054993f8f.94.2025.03.08.13.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 13:53:31 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6102A60347;
 Sat,  8 Mar 2025 21:53:27 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 09/31] tests/functional: Introduce the dso_suffix() helper
Date: Sat,  8 Mar 2025 21:53:04 +0000
Message-Id: <20250308215326.2907828-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Introduce a helper to get the default shared library
suffix used on the host.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250220080215.49165-3-philmd@linaro.org>
[AJB: dropped whitespace cmd.py damage]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-10-alex.bennee@linaro.org>

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index 5c972843a6..45f7befa37 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -7,7 +7,7 @@
 
 
 from .asset import Asset
-from .config import BUILD_DIR
+from .config import BUILD_DIR, dso_suffix
 from .cmd import is_readable_executable_file, \
     interrupt_interactive_console_until_pattern, wait_for_console_pattern, \
     exec_command, exec_command_and_wait_for_pattern, get_qemu_img, which
diff --git a/tests/functional/qemu_test/config.py b/tests/functional/qemu_test/config.py
index edd75b7fd0..6d4c9c3ce1 100644
--- a/tests/functional/qemu_test/config.py
+++ b/tests/functional/qemu_test/config.py
@@ -13,6 +13,7 @@
 
 import os
 from pathlib import Path
+import platform
 
 
 def _source_dir():
@@ -34,3 +35,14 @@ def _build_dir():
     raise Exception("Cannot identify build dir, set QEMU_BUILD_ROOT")
 
 BUILD_DIR = _build_dir()
+
+def dso_suffix():
+    '''Return the dynamic libraries suffix for the current platform'''
+
+    if platform.system() == "Darwin":
+        return "dylib"
+
+    if platform.system() == "Windows":
+        return "dll"
+
+    return "so"
-- 
2.39.5


