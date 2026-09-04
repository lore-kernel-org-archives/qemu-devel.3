Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B95C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TaW-0006m1-AG; Fri, 04 Sep 2026 09:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TaF-0006X0-Kh
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:55 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2Ta5-0003CW-2r
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:54 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-482e4998d28so715224f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788527024; x=1789131824; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=79ufYTClA2Zki0fcHzVVYb5ccPOkGeEIREeOR0gRlYQ=;
 b=s7F+J74tu7YTI69bxDLkPWcVwguKwu0LvxrE1iMcJsf1UAoAlGZnwMspHDIQOEXIm3
 NLxQ2fe67jFw3Z1ku9z5Lco1Z2vnE4AtcY/Z6j4A0iLfgWXAkHXktqFwPDEjKam49EbS
 N1fF0PXc8wApHovMX7TYn8rcWM2EIfFHORwXdrkNfIltrc0oYIkedCl21LxFiM6+l1N8
 hfNL14SCYtARp8YvVwKStDc8b5wYtC0h6wv9oDIZ6pQaJ0E4j2a8gxBX+CvamIXIuvrF
 9yRcNKiEf1eg19D0KMZwlHyc1v9MTIW9yAX6W34fo0Ejoz+lSFiOh2WwPuXU0Puz2hPH
 QlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527024; x=1789131824;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=79ufYTClA2Zki0fcHzVVYb5ccPOkGeEIREeOR0gRlYQ=;
 b=f27cz+Z19wJSwz0m5m5mMZ4bkS/fJlJy2YchT0W3EfTucfsfpfIiBFOItTdV2KFmGe
 T8VgwCHYYYIEgSRHn1wzP9RgwIBFeO7qGJOKuQc+9VqWeUQ/9qUrZLKqNnHF0LcLWLIX
 zf5VXw52zFLLWfKuM6anyAH6GU8fwsT/AYJCW6XLa/m/TFzT3IaxwOsRQA0+mrrnXp2v
 82VM9q2wtQWFnrPRrSlhrVvl0N89JYqGK/kMrZOIXCwguXfXeMcDPg+w343YLV83v+8c
 oMjH2jCoKAZ2CAuoQLfvl2fU9CHZaPinsBQAENss+m8AwSgxS+yz3tijlfFGNABK960h
 5cEw==
X-Gm-Message-State: AFuF++lQ6oVfw5Qu16C8UNWnjIz6kfVV67h8jYVriTnROtEjfkU1MyaW
 zZHxNo3jLnxpsaZy6+cEomhjAUoxuiqROSLo6V1yTlVPsUrW1IsxTDi/x+trtm91IIo=
X-Gm-Gg: AYBFou3ZLyAUifxCs7SLB9lSxTGbHM05Gh+8pFBCVnmcCo097Nob5kuZpvJS+ZaFqKD
 i124Q+Wi7QGNKb7GG4gNIhS6IoFuupanLBsdAzKA9eekwoD4Z4hp0nQ8KhpsbiDtb9wubtt3fDd
 xYpkBg/VMi675ZUUINRUrr989PupeMKsk+GIinPoH3uPLAjEpNx0LUyi2jVBkkixb/XOLnybGkI
 E4carI5MKCqBMr7PS69T1jZM2PXts4dx0j1Xr2JJ3TEHsvSXLSjZ6NRttPv2VLSVcrF6HEi/QOx
 JiygRt3n9u+5WyR4xPBgxpbGUNyRlxebstS5pFx2OGQ9sE72OFsyuRCU04QeIkBJIfsT9PssF6c
 dLz4EOtICpVaom5QgW9bIsPaYL3WB10UhYYpHPSU9TXq6aA+6BrN6KEFrYWD9Ywx0w4aOrD17Br
 Mmg70bGpTTgdO0m6MjtQFw6a/0Ttm5C/YxEMjkbKOQ4VmJw8VHEQ4epEIRvt5k
X-Received: by 2002:a05:600c:4f43:b0:49c:fc6e:a3d9 with SMTP id
 5b1f17b1804b1-49cfc6ea7b4mr34576785e9.24.1788527022053; 
 Fri, 04 Sep 2026 06:03:42 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee60bae6sm185291215e9.9.2026.09.04.06.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:03:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E7DBE5F9CF;
 Fri, 04 Sep 2026 13:46:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 046/105] tests/tcg/alpha: system tests
Date: Fri,  4 Sep 2026 13:45:00 +0100
Message-ID: <20260904124604.2207440-47-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
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
Message-ID: <20260827221506.91574-47-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/alpha/Makefile.softmmu-target b/tests/tcg/alpha/Makefile.softmmu-target
deleted file mode 100644
index a944102a3ce..00000000000
--- a/tests/tcg/alpha/Makefile.softmmu-target
+++ /dev/null
@@ -1,34 +0,0 @@
-#
-# Alpha system tests
-#
-
-ALPHA_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/alpha/system
-VPATH+=$(ALPHA_SYSTEM_SRC)
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-ALPHA_TEST_SRCS=$(wildcard $(ALPHA_SYSTEM_SRC)/*.c)
-ALPHA_TESTS = $(patsubst $(ALPHA_SYSTEM_SRC)/%.c, %, $(ALPHA_TEST_SRCS))
-
-CRT_PATH=$(ALPHA_SYSTEM_SRC)
-LINK_SCRIPT=$(ALPHA_SYSTEM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT)
-TESTS+=$(ALPHA_TESTS) $(MULTIARCH_TESTS)
-CFLAGS+=-nostdlib -g -O1 -mcpu=ev6 $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
-
-# building head blobs
-.PRECIOUS: $(CRT_OBJS)
-
-%.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
-
-# Build and link the tests
-%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-memory: CFLAGS+=-DCHECK_UNALIGNED=0 -mbwx
-
-# Running
-QEMU_OPTS+=-serial chardev:output -kernel
diff --git a/tests/tcg/alpha/meson.build b/tests/tcg/alpha/meson.build
index 08e371116c3..fe60ce2496a 100644
--- a/tests/tcg/alpha/meson.build
+++ b/tests/tcg/alpha/meson.build
@@ -2,6 +2,8 @@ cc = 'alpha-linux-gnu-gcc'
 cc_dockerfile = 'debian-all-test-cross'
 cc_docker_host_arch = ['aarch64', 'x86_64']
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/alpha/system/meson.build b/tests/tcg/alpha/system/meson.build
new file mode 100644
index 00000000000..b10f2c3e28d
--- /dev/null
+++ b/tests/tcg/alpha/system/meson.build
@@ -0,0 +1,47 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('kernel.ld')[0]
+boot = files('boot.S')[0]
+cflags = ['-nostdlib',
+          '-ffreestanding',
+          '-Wa,--noexecstack',
+          '-I', minilib_dir, minilib_printf, boot,
+          '-Wl,-T', link_script,
+          '-mcpu=ev6',
+          '-Wl,--no-warn-rwx-segments',
+          '-lgcc']
+qemu_def_args = ['-display', 'none',
+                 '-serial', 'stdio',
+                 '-kernel']
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += ['-DCHECK_UNALIGNED=0', '-mbwx']
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_def_args}}
+  endforeach
+endforeach
+
+if 'qemu-system-alpha' in emulators
+  tcg_tests += {
+    'alpha-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'alpha/system',
+      'gdb_arch': 'alpha',
+      'qemu': emulators['qemu-system-alpha'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


