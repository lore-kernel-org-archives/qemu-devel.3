Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4901CC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TQG-0001dZ-N2; Fri, 04 Sep 2026 08:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQE-0001cK-TE
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:34 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQD-0000gQ-5G
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:34 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49b8f86c6deso6382785e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526412; x=1789131212; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Bq7/bBVHMX4neHA7eeRRgfN06htohj1B67tRUHuq5gc=;
 b=vy7JRmPKNdayg74mBpIxYKwgACm6/KLdO8tWBV4JLNhM6hecU25920oqvcGupi4J5n
 bZ0oSoAZHJ8I02egeO8PJuoHKRp3XT6vwnf0XkYPsPxTxvchaqUuDYs0mHcOQuBReoaP
 GqCfESU0KCNM3GzQxPQ1MLsM9t7ApSU3cuWcVpfRGFRivBREQooubVINnFilxGM4llRy
 5Lus4mncrh/t7VwPudpQNil6mtilYBFS0Hl0B3aj6mrErb9v8cTM3gy5S4sFLJZstnS8
 1wEgQHtoa/e1SXaGg9679yUpca6hvdldSNdU6tlAkV9709DdEKmU4R7hT5lkhilvI+hj
 +nGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526412; x=1789131212;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bq7/bBVHMX4neHA7eeRRgfN06htohj1B67tRUHuq5gc=;
 b=Yrk6h3Uor+Oj/foNJVcmQO/qmYkNBSyWI322LwTfnJkK6F3RE9wu+8SwRowL7+CvEd
 huf52XJrP4U6ft76HhDUJLd3ON88ylAmw8DYMCANcX26/J63uh2vgQtxZ8SpiiZT3EcF
 bJnYk0uvx3mx2G5cjDCw4gF5T4CGMJ2ctPn4IPV5fykpIkbOYGAFB4ELCmJWBmT+818w
 LTBfOHIFd0ScJ6jKUDrmD56tEEWoBRS6g0l8z1SgnDM3/cpeqZBBh76XgQQf3wUf/nKz
 wWFJwFkxORPcRrSBy6YcPCj47eeMyBg/4uPRx1Mh/cmvLpytQgr7qjY6++K6vbOBbh4s
 QbZw==
X-Gm-Message-State: AFuF++myFX3QEpQIfqMbRWnZPIAIUH10kU/FaJh/5mYjTklS1UbafUDi
 Q+9zjimC5CDOysBnaA5GjjfZwkiMs3L8t0Y4zgKI8mWPyjNpYu7IRTPRU348y6v8G/U=
X-Gm-Gg: AYBFou1S9pPkuL2GDFY1gy96vs41Pjee7pwuLZF4OVYSrUIkgLzbgtCtWu/RCLHzuOO
 MzovhuOJ7gK6vFwYE81xvd4O1gwrTmIHkTR8++4wdrmiOV8dW+FI+9dBx7LNOhprDj/ANVzGN3o
 wJuzS9r7+OUsPq6AdrfEQMLIz4YP9kpNFgdcLx6WWiJunyCFrc2TkK38FMkz/Sq9MwlAQ8t7NoN
 WF7eUUIcDoQ2MGe+zw2wwiNG/Lrdsq/0DK39TCMbhugxp4tP2iY8GjvffbxV4XAdrjJYC8V8jCB
 ZFmPfUEcHEE1N6GhvGZ1FmTwaVH/5Nt9u+3nx1rt5O4qya+YjYIgxueidGH2m+M/S8OUoDW29qm
 z8qSCESi57Yg5n3fFpYKugB8nwYa3YwUeVevQhu+9yPCQPWUwAllytiKAWGmJeI16dmjPEfiBDA
 ppCBb5jiywlPFuSqihPUOjzGxGU8N24HZAMgCtvufhW7XFRzNqJTjqyZMrYQqm
X-Received: by 2002:a05:600c:a01:b0:499:7219:122f with SMTP id
 5b1f17b1804b1-49cf8222d53mr58014925e9.4.1788526411855; 
 Fri, 04 Sep 2026 05:53:31 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf75cd8d0sm62087115e9.2.2026.09.04.05.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:53:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3CAA861AE2;
 Fri, 04 Sep 2026 13:46:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>, Song Gao <17746591750@163.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>
Subject: [PULL 057/105] tests/tcg/loongarch64: user tests
Date: Fri,  4 Sep 2026 13:45:11 +0100
Message-ID: <20260904124604.2207440-58-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Song Gao <17746591750@163.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-58-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/loongarch64/Makefile.target b/tests/tcg/loongarch64/Makefile.target
deleted file mode 100644
index 00030a10266..00000000000
--- a/tests/tcg/loongarch64/Makefile.target
+++ /dev/null
@@ -1,20 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# LoongArch64 specific tweaks
-
-# Loongarch64 doesn't support gdb, so skip the EXTRA_RUNS
-EXTRA_RUNS =
-
-LOONGARCH64_SRC=$(SRC_PATH)/tests/tcg/loongarch64
-VPATH += $(LOONGARCH64_SRC)
-
-LDFLAGS+=-lm
-
-LOONGARCH64_TESTS  = test_bit
-LOONGARCH64_TESTS  += test_div
-LOONGARCH64_TESTS  += test_fclass
-LOONGARCH64_TESTS  += test_fpcom
-LOONGARCH64_TESTS  += test_pcadd
-LOONGARCH64_TESTS  += test_fcsr
-
-TESTS += $(LOONGARCH64_TESTS)
diff --git a/tests/tcg/loongarch64/meson.build b/tests/tcg/loongarch64/meson.build
new file mode 100644
index 00000000000..209179fd96c
--- /dev/null
+++ b/tests/tcg/loongarch64/meson.build
@@ -0,0 +1,30 @@
+cc = 'loongarch64-unknown-linux-gnu-gcc'
+cc_dockerfile = 'debian-loongarch-cross'
+cc_docker_host_arch = ['x86_64']
+
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'test_bit.c': {},
+  'test_fclass.c': {},
+  'test_fcsr.c': {},
+  'test_fpcom.c': {},
+  'test_div.c': {},
+  'test_pcadd.c': {},
+}
+
+if 'qemu-loongarch64' in emulators
+  tcg_tests += {
+    'loongarch64-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'loongarch64',
+      'gdb_arch': 'loongarch64',
+      'qemu': emulators['qemu-loongarch64'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 4d74891a30b..70aaa86afbf 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -143,6 +143,7 @@ subdir('arm')
 subdir('hexagon')
 subdir('hppa')
 subdir('i386')
+subdir('loongarch64')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


