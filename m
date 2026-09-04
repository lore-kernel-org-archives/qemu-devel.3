Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9647FC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TQF-0001ci-IW; Fri, 04 Sep 2026 08:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQD-0001ap-61
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:33 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQB-0000fe-4r
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:32 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so10187705e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526410; x=1789131210; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=X65c4epXSG6oxrnDyVNWDxY1k67sZHLow79LP0SYYmQ=;
 b=quxGsdxvTYnPBV+DDKrJEatPBo3ZAzEqO/8Te2xTsuejtYNGnyQjzjPJfpFd2E7eNC
 U7NwvTr2a9TwGqlnGyoB2X8mCnJLDxStkLaecR48HR6kYQqT9ARFFUTuJOd/rc7VNvLZ
 4KSCXFe09awDn5LuAYED9MnqeXXI1jDzYaTr4jGEIlg4S/DMGkNirD48P56i586H91Rt
 X7k7tCpNCsHx4FBt/V4ratIKe4MqmrJgIBH+dryXqwr+FjYPW4b82H74b0h/o9l1fiPm
 w9DhJK2ewETXgAaGC7U3lsynW1ywlHy2vUFZxP81P3FKq+FsQ/OZApRlbgb8bkmOGPxm
 rXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526410; x=1789131210;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X65c4epXSG6oxrnDyVNWDxY1k67sZHLow79LP0SYYmQ=;
 b=GbLLsq+x7lJmtFkkl8sMYQfQztLlbzAknBgm/+07yloUAsdFcWBkKpfBjuVay1bj4A
 oIstWOlXxN2OuwyXp+RgXsZGpPw5I0LvlWnj+B07l3TY93BtVVQhsJ6zuxs5yxb56T7C
 as4oIwx7tT2wj1TaV5gl9oTMZeBdJApWIcKjGFYLZM7qNI3248Ass3E7AxOf/0W0Pb9D
 OYGZzjc8vdx0iYGIb2PrAidwFiDFSjHzr/GSYm5egivjJ0Kji2awnBwtFa4VhybGb9JF
 u+qCYWcK4MnaOTuNZqbyPu4m02jAhSVDTzVqwTiLVQ9UT3SocJwM9BuiL12hq5lva79d
 dfBQ==
X-Gm-Message-State: AFuF++nY9xOPu1ibLYCjPLvThjNTYcHwGPaVdxo3K9eq29XpcCgfiHZp
 XdNYXTNpLZn37wFZvIGrG7n7e6VhOTUGWHW9DYyE0kgN1drmv/MK5GismT2lV7ZabBk=
X-Gm-Gg: AYBFou0Xsob3IkBJ90/pwEbtRRvkOsPHpVOa2OP/hx8vmwSmEjKSZi19p8UFGQmOqs3
 VYTCwQExE1wbhsaylgXL6ma9an2IzepYDFX1Rp19k9+iIKxP4NFm9AnKYq3u7DJZqJqt4m1AaOI
 KtPnFdvZACRlpaKydLzAimxYA7RkEnozvxpxb5l5xCdpUlhXx0d5xmXMySqxSBjpgbjdDKN4vJD
 1Aupg560iSXk5YAtg9nPVW15AGZ4JtJ4dA/DbX4DsgiTGI8in0cp6p/svGZoEVKMa1bl189PdnW
 L3RFE3mbpVdsyTN44JlgDxnjObDlNoEFF7ctz4Y//uO0wAAdC3ArfcUqvcDXMT7xsEspJC4B64F
 4WQfBluuDAIyjMFd3EPf5+gspQH50HVbmrECNaSW3kLesdLiTVoLlYT1qYaqOqOjhBjZBtpc9oR
 WEvQEcxbNf8L6njDmedCqtGnL2GSM/E9wENoXfj9qp6jxWH9F69Ol8u6eM9TnEno9XSR79ioBNR
 w==
X-Received: by 2002:a05:600c:6098:b0:49c:fc6c:be05 with SMTP id
 5b1f17b1804b1-49cfc6cbfdbmr33699315e9.28.1788526409508; 
 Fri, 04 Sep 2026 05:53:29 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cfbdacc45sm42034575e9.11.2026.09.04.05.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:53:26 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 29CA961971;
 Fri, 04 Sep 2026 13:46:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 048/105] tests/tcg/arm: system tests
Date: Fri,  4 Sep 2026 13:45:02 +0100
Message-ID: <20260904124604.2207440-49-alex.bennee@linaro.org>
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
Message-ID: <20260827221506.91574-49-pierrick.bouvier@oss.qualcomm.com>
[AJB: fix merge conflict]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
deleted file mode 100644
index 3e8a9b4073e..00000000000
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ /dev/null
@@ -1,80 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# ARM SoftMMU tests - included from tests/tcg/Makefile
-#
-
-ARM_SRC=$(SRC_PATH)/tests/tcg/arm/system
-
-# Set search path for all sources
-VPATH 		+= $(ARM_SRC)
-
-# Specific Test Rules
-
-test-armv6m-undef: test-armv6m-undef.S
-	$(CC) -mcpu=cortex-m0 -mfloat-abi=soft \
-		-Wl,--build-id=none -x assembler-with-cpp \
-		$< -o $@ -nostdlib -static \
-		-T $(ARM_SRC)/$@.ld
-
-run-test-armv6m-undef: QEMU_OPTS=-semihosting-config enable=on,target=native,chardev=output -M microbit -kernel
-
-ARM_TESTS+=test-armv6m-undef
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-ARM_TEST_SRCS=$(wildcard $(ARM_SRC)/*.c)
-ARM_TESTS+=$(patsubst $(ARM_SRC)/%.c, %, $(ARM_TEST_SRCS))
-
-CRT_PATH=$(ARM_SRC)
-LINK_SCRIPT=$(ARM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT)
-CFLAGS+=-march=armv7-a+fp -ffreestanding -nostdlib -ggdb -O0 $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
-
-# building head blobs
-.PRECIOUS: $(CRT_OBJS)
-
-%.o: $(ARM_SRC)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
-
-# Build and link the tests
-%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-memory: CFLAGS+=-DCHECK_UNALIGNED=0
-
-# Running
-QEMU_BASE_MACHINE=-M virt -cpu max -display none
-QEMU_OPTS+=$(QEMU_BASE_MACHINE) -semihosting-config enable=on,target=native,chardev=output -kernel
-
-# console test is manual only
-QEMU_SEMIHOST=-serial none -chardev stdio,mux=on,id=stdio0 -semihosting-config enable=on,chardev=stdio0 -mon chardev=stdio0,mode=readline
-run-semiconsole: QEMU_OPTS=$(QEMU_BASE_MACHINE) $(QEMU_SEMIHOST)  -kernel
-run-semiconsole: semiconsole
-	$(call skip-test, $<, "MANUAL ONLY")
-	$(if $(V),@printf "  %-7s %s %s\n" "TO RUN" $(notdir $(QEMU)) "$(QEMU_OPTS) $<")
-run-plugin-semiconsole-with-%: semiconsole
-	$(call skip-test, $<, "MANUAL ONLY")
-
-# Simple Record/Replay Test
-.PHONY: memory-record
-run-memory-record: memory-record memory
-	$(call run-test, $<, \
-	  $(QEMU) -monitor none -display none \
-		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
-		  -icount shift=5$(COMMA)rr=record$(COMMA)rrfile=record.bin \
-		  $(QEMU_OPTS) memory)
-
-.PHONY: memory-replay
-run-memory-replay: memory-replay run-memory-record
-	$(call run-test, $<, \
-	  $(QEMU) -monitor none -display none \
-		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
-		  -icount shift=5$(COMMA)rr=replay$(COMMA)rrfile=record.bin \
-		  $(QEMU_OPTS) memory)
-
-EXTRA_RUNS+=run-memory-replay
-
-TESTS += $(ARM_TESTS) $(MULTIARCH_TESTS)
-EXTRA_RUNS+=$(MULTIARCH_RUNS)
diff --git a/tests/tcg/arm/meson.build b/tests/tcg/arm/meson.build
index 08a863699fb..1b491cea026 100644
--- a/tests/tcg/arm/meson.build
+++ b/tests/tcg/arm/meson.build
@@ -2,6 +2,8 @@ cc = 'arm-linux-gnueabihf-gcc'
 cc_dockerfile = 'debian-all-test-cross'
 cc_docker_host_arch = ['aarch64', 'x86_64']
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/arm/system/meson.build b/tests/tcg/arm/system/meson.build
new file mode 100644
index 00000000000..4c77b9c3d62
--- /dev/null
+++ b/tests/tcg/arm/system/meson.build
@@ -0,0 +1,69 @@
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
+          '-march=armv7-a+fp',
+          '-lgcc']
+qemu_base_args = ['-display', 'none',
+                  '-semihosting-config', 'enable=on',
+                  '-kernel']
+qemu_def_args = ['-M', 'virt', '-cpu', 'max', qemu_base_args]
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += '-DCHECK_UNALIGNED=0'
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_def_args}}
+  endforeach
+endforeach
+
+tests += {
+  'test-armv6m-undef.S': {
+    'cflags': ['-mcpu=cortex-m0', '-mfloat-abi=soft', '-nostdlib',
+               '-Wl,--build-id=none',
+               '-T', files('test-armv6m-undef.ld')],
+    'qemu_args': ['-M', 'microbit', qemu_base_args],
+  },
+  'semiconsole.c': {
+    'cflags': cflags,
+    'qemu_args': ['-serial', 'none', '-chardev', 'stdio,mux=on,id=stdio0',
+                  '-semihosting-config', 'enable=on,chardev=stdio0',
+                  '-mon', 'chardev=stdio0,mode=readline',
+                  qemu_def_args],
+    'wrapper': [prog_run_with_input, 'X']
+  },
+  '../../multiarch/system/memory.c': {
+    'test_name': 'memory-record-replay',
+    'qemu_args': qemu_def_args,
+    'wrapper': [prog_record_replay],
+  },
+}
+
+if 'qemu-system-arm' in emulators
+  tcg_tests += {
+    'arm-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'arm/system',
+      'gdb_arch': 'arm',
+      'qemu': emulators['qemu-system-arm'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


