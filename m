Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDCCC79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TQR-0001lS-Fp; Fri, 04 Sep 2026 08:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQQ-0001kJ-5T
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:46 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQO-0000l8-BV
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:45 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso9038765e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526423; x=1789131223; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fEpiMCX5c1LEj+yVlkZvbJZSIzMATPO1z46HiNdFhtw=;
 b=yk+yuB34QCJi3N4Tz59p6BeM1rNKD4gz/8tWOs1vSiKMeP5IC9cylSr5H2P3esTPSx
 XFgC6ZArCFQYcoMzNC7biNxksXa4wO+c46zQTRfGdfBwqHV/QudsLxGvW/m9uR5UiMxx
 4PsaHnoyUpKyCeGKPG3u8NWqoMqgaDU0PFWMh+8KcGsSbpzHZXCnG8NFIQUw3lceSu1x
 FDGQY51S7RjhSCev56aWN/oNFruyW7yg4JqFiXIwmC5QX93jT5qhreU6OukDDLjX22pT
 W0OHBCvF6K2dsg52yp87mvohHMvXs7OcKNvR5EE73q9VPUAEkxYdYgxKqOWQ7g42wPdg
 dVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526423; x=1789131223;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fEpiMCX5c1LEj+yVlkZvbJZSIzMATPO1z46HiNdFhtw=;
 b=EP1g9r6HCOfphvprGpTWk9PS/FIO8Q5Nr7diA0m4mQb8GWtnzf9V1GfL4SwnTQVe72
 aEI3+GnJtM8aS9K17xhXSkq4L71czZdtm2N8mvfYmbWQbbs0Z18RE7sNMj4hBSYnkiTG
 JZxjTe13yz3an5RHutI19mfsasITOswnZOzzCPSqZPuGxByQ8ZSceayzxCEnM2Fz1Gsl
 wuJ2Jmu5r4etRELETHzD4/dWed+z9Y3RSd9/j3NCJfNS83FpMWjOMTvWi0O2X+hKsMaS
 y3X/rZKBSQ9CC35lylINHOAqauQ1JQKC8GJO/cDh+VeqSFhJjxiIN0oWON4+azS5Cgfy
 kN2A==
X-Gm-Message-State: AFuF++lgjh/KJ7Lni5hVgbXroQVoyRgVIvY+iC70ln73Cxcz2oSyOiCO
 QZckkGi/UOqA5hsv9XJ3rQk+Z1ElA5D/yITSvTSp80jxA2Xyu+3Hsq30GQhTqakQKeI=
X-Gm-Gg: AYBFou1TLWm4OWYd9+trvuEIfsSelUtQGuCMldX8NSeccgvTkA0/04b6Q+fTQmosYdX
 1e6d1BCLLLsIgCH9Tl4kI8Bv7iISxjI7vHMaivW+nGHcpYqzSTDqcVNqFsykR+FUzU0mUU6ILEl
 tWNIuYdbDMp/MM1vfG8JiscvkR42xA6DJTTruYtpSqj00HGl0o/BXItfAscOe0NuZ8WhpyBDblX
 DXc4iqRO1kiGOY0deuECos/bsb3AsM08eVoheb0minMcvb0lw4frK8/0RztRDUbHmM9IxGVBnOk
 uKaF4fjmQ3KF0BjWqm0famPgwCiRaJCJb8YDzKhZ/U/7ondJXhn4dj1ew5CZ/mpn3Om/mONaKlW
 QlPQNNgbDug5zNOfARxeqjdQVags0OdwS/KrcJ8K/EyrxPM3awXQtf+u9soS528PYtAa/DOizHI
 P/RdyGjBAWu2fFXm0G0nBbvJNmyxjfXujm2iqflCeg50drctFo8QnxaIvwRxQqsaJ/EumwcJY=
X-Received: by 2002:a05:600c:190e:b0:49c:fa21:1c82 with SMTP id
 5b1f17b1804b1-49cfa211d3dmr37257265e9.23.1788526422868; 
 Fri, 04 Sep 2026 05:53:42 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d476esm169041705e9.1.2026.09.04.05.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:53:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CCFC361926;
 Fri, 04 Sep 2026 13:46:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 045/105] tests/tcg/alpha: user tests
Date: Fri,  4 Sep 2026 13:44:59 +0100
Message-ID: <20260904124604.2207440-46-alex.bennee@linaro.org>
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260827221506.91574-46-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/alpha/Makefile.target b/tests/tcg/alpha/Makefile.target
deleted file mode 100644
index 36d8ed1eaea..00000000000
--- a/tests/tcg/alpha/Makefile.target
+++ /dev/null
@@ -1,18 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# Alpha specific tweaks
-
-ALPHA_SRC=$(SRC_PATH)/tests/tcg/alpha
-VPATH+=$(ALPHA_SRC)
-
-ALPHA_TESTS=hello-alpha test-cond test-cmov test-ovf test-cvttq
-TESTS+=$(ALPHA_TESTS)
-
-test-cmov: EXTRA_CFLAGS=-DTEST_CMOV
-test-cmov: test-cond.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-# Force generation of byte read/write
-test-plugin-mem-access: CFLAGS+=-mbwx
-
-run-test-cmov: test-cmov
diff --git a/tests/tcg/alpha/meson.build b/tests/tcg/alpha/meson.build
new file mode 100644
index 00000000000..08e371116c3
--- /dev/null
+++ b/tests/tcg/alpha/meson.build
@@ -0,0 +1,53 @@
+cc = 'alpha-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+cc_docker_host_arch = ['aarch64', 'x86_64']
+
+tests = []
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-linux-user']['tests']
+  foreach src, setup: t
+    new_cflags = []
+    if 'cflags' in setup
+      new_cflags = setup['cflags']
+    endif
+    # Force generation of byte read/write
+    if fs.stem(src) == 'test-plugin-mem-access'
+      new_cflags += ['-mbwx']
+    endif
+    if src not in multi_src
+      setup += {'cflags': new_cflags}
+      multi_src += src
+    endif
+    tests += {src: setup}
+  endforeach
+endforeach
+
+tests += {
+  'hello-alpha.c': {},
+  'test-cond.c': {},
+  'test-cvttq.c': {},
+  'test-ovf.c': {},
+}
+
+tests += {
+  'test-cond.c': {
+    'cflags': ['-DTEST_CMOV'],
+    'exe_name': 'test-cmov'
+  },
+}
+
+if 'qemu-alpha' in emulators
+  tcg_tests += {
+    'alpha-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'alpha',
+      'gdb_arch': 'alpha',
+      'qemu': emulators['qemu-alpha'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index d878581b660..e0789d9c1eb 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -138,6 +138,7 @@ endforeach
 # Now let's go through all architectures
 subdir('aarch64')
 subdir('aarch64_be')
+subdir('alpha')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


