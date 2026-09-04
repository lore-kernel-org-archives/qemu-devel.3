Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89665C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TQI-0001fS-Nj; Fri, 04 Sep 2026 08:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQG-0001dD-8L
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:36 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQE-0000gx-2F
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:35 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48436251906so1062823f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526412; x=1789131212; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Slkp6qUqPuvs+zmMchtKNanQ6N4m3B+Q5NmTSoZ0p1s=;
 b=Qw/5nt18n2fMmMWA5enec9EB0fkQjctiVroeExReFQszcWA3jjM+jhIjBffzxKBKD8
 9ir+r1Xfp6WAvpEOpVEJvVNyTpEMPlqFBRtQ1l3WG+9C8KbmvsznwWlG9zR8IxRE6WN1
 NJANyT1qBCmq7KpbR02G7ltwlhBW7HqTWLFTaUVk0JsO0WtOm4Xj5zWbKUzj5crZboaD
 ygZtZvjVX4jr0ZNlxE6fEhOIMiUwHV4jYs+WhJkSVSE5Qs3pfJh3jXOeuFFD9acbnUET
 dzFmpLa78Z05qtdZ+FYlPxETIygprs2aOC1pwr3Tqk0MMpsR1E2//ULM7fFp2/b5a2cn
 Cu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526412; x=1789131212;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Slkp6qUqPuvs+zmMchtKNanQ6N4m3B+Q5NmTSoZ0p1s=;
 b=AkXX2z3zcKbNsXQbPD+260GTs6XQzg/4qBpYpGpA58zId8jvEyfuUPUzueFtccc4B/
 2IZbQCYhfIcXxo1ydIFjToD337PBX01xowYKxQ5uhio1FsI4L9usM4VXNRflY7RjXR4X
 C/Bvb1I5eHC9RscAKr4f46CI+g+f+XKvUVaaHZne9598KRUGUZj59GK/YyrLfSEiz0nJ
 grh+b8yFsFbcS6+R6zDv+BeO+Ge5ByCsnKd3+X9Cnq+ygSmuaKMLvtY1sMDIOi9K2+RB
 BLT7AmKN18OcQ6jzZExLzu8u5rODzpvhtfrjTIRGiqTsFcqIMiDDIl0tCg3YnX1MJAiJ
 8NFA==
X-Gm-Message-State: AFuF++mc7ZC9ZLdVjXtDf6jN1EvljC8n9cx0MjtYp/0DZ3BkumsQ+gDD
 L/B9yyuferkvRfd5eWymD7KYu3gYGEFIEVK1bFQDkUQ24oP2Rx6YhucdNyMdigX1b48=
X-Gm-Gg: AYBFou0b6a9VzChNsXMBfof+q1B3nseUlVtwTSFvwcY4txBo9+RTqmm4C6euvjcL1jf
 jMAi6laKkzfDOP8tSM76tPrbSH/EKnKM1inuryIl3gAlRPTqgtMd2qRv287hgv1SGvhdBEczNyp
 0iry9zIWGMYdFDoDDxK2o9Kb2hlJDC0WyCXimub9fatpPtTDX0cyuKW3ysIjX1jTFyyeSb9NbCE
 f4S4AqXOBWfbxO7/se4iuG7zFf10nOBi1akr8MIa4ALqaFTadgirWn2bfJR4oLkKIqbstF11zX3
 0oWnwyHmRO3QLiiLtNmNstGaY97w9fGoxKcUNLCNUduD6KSAx5a2LsaPmuE+RBECfsJqOdC8iJF
 5ugtLyRNO1rDXucGtF6NK5F1yf9pbxjBm6nP3AlsI+zgETVGZF/RQWwckuXtU/HYuHE7WOolvvN
 h6hSOlCIlWT1t5ezDG1FXIFMJAW/HdkNhIRJFdFxPIcAQYF5hKqVIO7w0EdVs1
X-Received: by 2002:a05:600c:8b6d:b0:499:a277:e8b5 with SMTP id
 5b1f17b1804b1-49cf7fdd67emr93852345e9.3.1788526412485; 
 Fri, 04 Sep 2026 05:53:32 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf75ce49esm118472095e9.1.2026.09.04.05.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:53:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9863361DF4;
 Fri, 04 Sep 2026 13:46:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 096/105] tests/tcg/xtensa: xtensaeb system tests
Date: Fri,  4 Sep 2026 13:45:50 +0100
Message-ID: <20260904124604.2207440-97-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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
Message-ID: <20260827221506.91574-97-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/xtensa/meson.build b/tests/tcg/xtensa/meson.build
index 339a9a1294e..bb1dd1542e5 100644
--- a/tests/tcg/xtensa/meson.build
+++ b/tests/tcg/xtensa/meson.build
@@ -1,5 +1,5 @@
 tests_per_core = {}
-cores = ['dc232b']
+cores = ['dc232b', 'test_kc705_be']
 
 foreach core: cores
   tests = []
@@ -94,3 +94,17 @@ if 'qemu-system-xtensa' in emulators
     }
   }
 endif
+
+if 'qemu-system-xtensaeb' in emulators
+  tcg_tests += {
+    'xtensaeb-softmmu': {
+      'cc': 'xtensa-test_kc705_be-elf-gcc',
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'xtensa',
+      'gdb_arch': 'xtensaeb',
+      'qemu': emulators['qemu-system-xtensaeb'],
+      'tests': tests_per_core['test_kc705_be'],
+    }
+  }
+endif
diff --git a/tests/tcg/xtensaeb/Makefile.softmmu-target b/tests/tcg/xtensaeb/Makefile.softmmu-target
deleted file mode 100644
index 3df131acea7..00000000000
--- a/tests/tcg/xtensaeb/Makefile.softmmu-target
+++ /dev/null
@@ -1,5 +0,0 @@
-#
-# Xtensa system tests
-#
-
-#include $(SRC_PATH)/tests/tcg/xtensa/Makefile.softmmu-target
-- 
2.47.3


