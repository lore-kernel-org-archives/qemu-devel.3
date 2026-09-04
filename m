Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07795C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TtH-0005Ui-4i; Fri, 04 Sep 2026 09:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TtF-0005U9-Vr
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:23:34 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TtD-0008I0-BT
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:23:33 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so13202745e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788528210; x=1789133010; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yVlrtz6FLvgmtzellkV9rKjHfmAprdw9W5TnjxfHWaM=;
 b=kynXC2s7PsVxRA+1JEsR7HAfujzCTaksh06mPKf22fEm3Mdeb4DyH+6C/5Oui/etMU
 NR1KMN2iioNLbZzPtD5CaMWS0DLlIfLoEjahDf6fk7zPbu/mHNxOycBkjRYq+EBgJzHs
 Xo9Ld//sUJnz+8uS1LIo6bPccx+67IGernVhJUKBLmQYWd63HmzGwL7iMZiUgTeb4+U7
 rtUhFdYcUJqAChDSPX4Z2k5mdHrXN/cvp1v+9BM7yBEJKc2UPiS3p/QFiA2nS2oNjkE1
 X9io7N7iGjjv89tRJNkaTFcURDdDCSjM1qMMIU//kx7fT/Jew1Rss64tsj834+NFsVzB
 83yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788528210; x=1789133010;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yVlrtz6FLvgmtzellkV9rKjHfmAprdw9W5TnjxfHWaM=;
 b=BKuNdXQ49P2Z4U5eqDC+FbzdvnavD8dM3WSXEmCLMbxOZcsyRlefdXAyQZx3y5/o8s
 DTLKIdCqFwejsigixau+E4t3ggCgY3on1JtZUblANzSciDsW+6E36dCzWl1uDOlCVDtH
 iV9TwKfZp8h6ulmsj/kXdqPVkth7za5l4vEh7ryePRnhUaL2zuPpECc6eB85/vRwXAjC
 xXAzmNaxN5Uy3BRRrUtAtGMDIns367CT/x3f0x7SyaNDUDBJC/bt4x7Oy3+cGjPUfhlk
 a72vgFfdepNoAye0EAurC5M1TIZTOFEaj+fxd8ApedExgLo8RRYZfp+MgzikJPXi8Nr/
 HrNA==
X-Gm-Message-State: AFuF++lPSoo/t84fdu1A79OY+oLapWKxbC1ToC05ksLWVAuj6b2g6eMR
 sT0h2tgcxAWs2BW+aCzJOHuQBhL67D6n4g5ozZmAg+KuBrRgFOh8p+3JxFXWSeebjfk=
X-Gm-Gg: AYBFou3r1+t9mtiaSURqCVArNBX4C5Md2Ftz1Rqc+vkIuBAabJXB25cuFPJKMErdr0o
 /AQ9ECPn0FpoIKT+4DZi/bhvRJbt7i5vEj+8/PIfJRaW+xLP4+DBf82b7H02/StCTDaO/p8WBlF
 2Ytwtuq7o54oqiGA7t7U3QvVBLkss0wu5DeoC7ASJx0V5HYMPwPpNLu0h+AsHKC4D2Fr7EKRxcU
 2EjI8btdmZynd8umIkPlvcS5+ZAnFFGMv/0jm7BsQaEMAa9gJlug7rNEIIfHnSu7v59vLMjkdtS
 LB2L6MbqsrL+m97vIJ9mt0JJf0SFP5fuFk7oV/GM5Pzso8Z8R61KCV8qCp/Kq4+oUqxq8HmNEGc
 e1CUTLbHRrohEbQtpyae0PIGrhO6bM8NwYMnq6uWoh+hvmafsao+/TTm/YsX514RUg3l+Z4u/vP
 7HS6XfTytiEjEgAjHRirDle9Yb0yW2av3YsR+PPYosow/cwwBHH7PH51HzYCxKQdNtsOAByjVCJ
 g==
X-Received: by 2002:a05:600c:1551:b0:49c:fa21:1c89 with SMTP id
 5b1f17b1804b1-49cfa211d5fmr42391505e9.30.1788528209739; 
 Fri, 04 Sep 2026 06:23:29 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee7fec25sm170696855e9.13.2026.09.04.06.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:23:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B959A6006B;
 Fri, 04 Sep 2026 13:46:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 053/105] tests/tcg/hppa: user tests
Date: Fri,  4 Sep 2026 13:45:07 +0100
Message-ID: <20260904124604.2207440-54-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-54-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/hppa/Makefile.target b/tests/tcg/hppa/Makefile.target
deleted file mode 100644
index ea5ae2186df..00000000000
--- a/tests/tcg/hppa/Makefile.target
+++ /dev/null
@@ -1,14 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# HPPA specific tweaks - specifically masking out broken tests
-
-# This triggers failures for hppa-linux about 1% of the time
-# HPPA is the odd target that can't use the sigtramp page;
-# it requires the full vdso with dwarf2 unwind info.
-run-signals: signals
-	$(call skip-test, $<, "BROKEN awaiting vdso support")
-
-VPATH += $(SRC_PATH)/tests/tcg/hppa
-TESTS += stby
-
-stby: CFLAGS += -pthread
diff --git a/tests/tcg/hppa/meson.build b/tests/tcg/hppa/meson.build
new file mode 100644
index 00000000000..9ca8f29fa93
--- /dev/null
+++ b/tests/tcg/hppa/meson.build
@@ -0,0 +1,22 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'stby.c': {'cflags': ['-pthread']},
+}
+
+if 'qemu-hppa' in emulators
+  tcg_tests += {
+    'hppa-linux-user': {
+      'cc': 'hppa-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'hppa',
+      'gdb_arch': 'hppa',
+      'qemu': emulators['qemu-hppa'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 27d7aedb8b8..878a391d8fd 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -141,6 +141,7 @@ subdir('aarch64_be')
 subdir('alpha')
 subdir('arm')
 subdir('hexagon')
+subdir('hppa')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


