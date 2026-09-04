Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6D0C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TQT-0001n6-GS; Fri, 04 Sep 2026 08:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQR-0001lU-L4
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:47 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQP-0000lJ-09
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:47 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49cd77e0f95so8552185e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526423; x=1789131223; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WBNqG4GybkncYnaDkTwXM8xIq45fyGnwWtOxupKElFs=;
 b=dOdf7tCLTZac4sB7e4ARjDE6ZYnmm2z/5pQPuj8UO4vRpnTMm9MPI2iy/EhYIPvO8t
 gTbVReZSpNOejs1bmUl8nlzoO3SWRU4ZOAgi3v3/4LNx/ZuX2pLTtnyIIy4oh/QchjCE
 qtuDxu53Epg3WZCY/eBJbc+Dmb/4FS4m1udLhd6KEp2wF9frwimyfL4eJvKe17u8IdC1
 N9i0hT++gNSdUk4Saby7s4DW/rWhwxmJQByj6i8/587AM5LSRaRBpewQVmXbhgBBkCCg
 iaMCufJTD48dh5qGf61OOQ7A7OM64vYLQl823BxVXJRmj5KYsdltRkrcY5GIXoqmPixd
 BvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526423; x=1789131223;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WBNqG4GybkncYnaDkTwXM8xIq45fyGnwWtOxupKElFs=;
 b=VW1fVd2bXAF2y6uYOlz6izKQreQ63ohqa/NPj66eN7zjHcz8+EAXgsZFNWjnCzTWJg
 AtNUMNBvBsTz1nyOrZpYdZsNhzMOYkbd3y9e4EUt1AZby7uNfhC8kHfyhximG65wHduy
 dkfClH+yDb0nJs8bJlPMmGaefX4ycE1iWySMMfdSWF2JyLEdFe8qy/wUh2VpgJ4PD9Hs
 kqXUR+JSzx0IlQcuohEtvo8N8/5LS0Am3tg59X841ARO7ZBdtTLeqzzsPu9j8aS7U7ZT
 B4PiwmDz0mWbHlze09lvGd+b5YytYGpZhgrtdpkFoWKb1+KA2rE9vWuC7FTp7vjZ6WY2
 AHHA==
X-Gm-Message-State: AFuF++m7MLBBWpkGvpE2XM6aYK19ntZSsLN22H4VvuD85pUKuD2vaPy5
 L1mhoCA1yLvS2UPTLmPyLF5z4BYjIqJm8gYo498oYZFfTWHEiuAdYFTXCxtdJzXp5EjpSWcpOhu
 FFWj+p4Q=
X-Gm-Gg: AYBFou1wiwp9jz3FhKTM0n+60EQqiPoVQW7UCN+u3xHtEMyx3vk9wOUoNzT1Me6QfI5
 Uzzj8tI1KbGDIiNwd9gG43vEiNn0rOP8IPTQPcodl7eGrHfnEjn7GTZnJN0nf8Ay32fHhIiZX+1
 QX9WewyDt6X/Qdk6/3SPAVTe1d0QyCiSGFugp6Wrp5ccUp8zhywJcxGp9sO1YDHjCbEhF/XzvL3
 ZJbD0hOTlBf1G5nXD6t9eL4L5EUafDzM/5D4DqO2+Af7YG1pIAi/XUBsum8xJoODMeF0+UQv0Qu
 4ddXvkd88jEUiTqdrbY6WuUUKBNQMCK0+bD9USs24xiW/IrkAY0te/lbSALJeusAYMPGa0YbvRQ
 q96iDkflac894dNY+Xq+eBeJCS2VU5wTpRXICGaDXmiEuEQgq8jOZTsCvjlwuP8+HVxj2gBU2x7
 zztOPiJctjY1MtaD5AhdfrMb6gsQ+VzR6sYNUx9/DInqMgQWn9kvosBIQDqaCQHW7x5oPdTVE=
X-Received: by 2002:a05:600c:310d:b0:49c:dc14:d681 with SMTP id
 5b1f17b1804b1-49cf81e5449mr61041005e9.3.1788526420223; 
 Fri, 04 Sep 2026 05:53:40 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf755c22esm68796225e9.0.2026.09.04.05.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:53:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3FD30618D2;
 Fri, 04 Sep 2026 13:46:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 040/105] tests/tcg/aarch64: user tests
Date: Fri,  4 Sep 2026 13:44:54 +0100
Message-ID: <20260904124604.2207440-41-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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
Message-ID: <20260827221506.91574-41-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
deleted file mode 100644
index 6cc81bf854f..00000000000
--- a/tests/tcg/aarch64/Makefile.target
+++ /dev/null
@@ -1,211 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# AArch64 specific tweaks
-
-ARM_SRC=$(SRC_PATH)/tests/tcg/arm
-VPATH 		+= $(ARM_SRC)
-
-AARCH64_SRC=$(SRC_PATH)/tests/tcg/aarch64
-VPATH 		+= $(AARCH64_SRC)
-
-# Base architecture tests
-AARCH64_TESTS=fcvt pcalign-a64 lse2-fault
-AARCH64_TESTS += test-2248 test-2150
-
-fcvt: LDFLAGS+=-lm
-
-run-fcvt: fcvt
-	$(call run-test,$<,$(QEMU) $<)
-	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
-
-config-cc.mak: Makefile
-	$(quiet-@)( \
-	    fnia=`$(call cc-test,-fno-integrated-as) && echo -fno-integrated-as`; \
-	    $(call cc-option,-march=armv8.1-a+sve,          CROSS_CC_HAS_SVE); \
-	    $(call cc-option,-march=armv8.1-a+sve2,         CROSS_CC_HAS_SVE2); \
-	    $(call cc-option,-march=armv8.2-a,              CROSS_CC_HAS_ARMV8_2); \
-	    $(call cc-option,-march=armv8.3-a,              CROSS_CC_HAS_ARMV8_3); \
-	    $(call cc-option,-march=armv8.5-a,              CROSS_CC_HAS_ARMV8_5); \
-	    $(call cc-option,-mbranch-protection=standard,  CROSS_CC_HAS_ARMV8_BTI); \
-	    $(call cc-option,-march=armv8.5-a+memtag,       CROSS_CC_HAS_ARMV8_MTE); \
-	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme $$fnia, CROSS_AS_HAS_ARMV9_SME); \
-	    $(call cc-option,-march=armv9-a+fprcvt,         CROSS_CC_HAS_ARMV9_FPRCVT)) 3> config-cc.mak
--include config-cc.mak
-
-ifneq ($(CROSS_CC_HAS_ARMV9_FPRCVT),)
-AARCH64_TESTS += fcvt-fprcvt
-fcvt-fprcvt: LDFLAGS += -lm
-fcvt-fprcvt: CFLAGS += $(CROSS_CC_HAS_ARMV9_FPRCVT) -DFPRCVT
-fcvt-fprcvt: fcvt.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-run-fcvt-fprcvt: fcvt-fprcvt
-	$(call run-test,$<,$(QEMU) $<)
-	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
-endif
-
-ifneq ($(CROSS_CC_HAS_ARMV8_2),)
-AARCH64_TESTS += dcpop
-dcpop: CFLAGS += $(CROSS_CC_HAS_ARMV8_2)
-endif
-ifneq ($(CROSS_CC_HAS_ARMV8_5),)
-AARCH64_TESTS += dcpodp
-dcpodp: CFLAGS += $(CROSS_CC_HAS_ARMV8_5)
-endif
-
-# Pauth Tests
-ifneq ($(CROSS_CC_HAS_ARMV8_3),)
-AARCH64_TESTS += pauth-1 pauth-2 pauth-4 pauth-5 test-2375
-pauth-%: CFLAGS += $(CROSS_CC_HAS_ARMV8_3)
-test-2375: CFLAGS += -march=armv8.3-a
-run-pauth-1: QEMU_OPTS += -cpu max
-run-pauth-2: QEMU_OPTS += -cpu max
-# Choose a cpu with FEAT_Pauth but without FEAT_FPAC for pauth-[45].
-run-pauth-4: QEMU_OPTS += -cpu neoverse-v1
-run-pauth-5: QEMU_OPTS += -cpu neoverse-v1
-endif
-
-# BTI Tests
-# bti-1 tests the elf notes, so we require special compiler support.
-ifneq ($(CROSS_CC_HAS_ARMV8_BTI),)
-AARCH64_TESTS += bti-1 bti-3
-bti-1 bti-3: CFLAGS += -fno-stack-protector $(CROSS_CC_HAS_ARMV8_BTI)
-bti-1 bti-3: LDFLAGS += -nostdlib
-endif
-# bti-2 tests PROT_BTI, so no special compiler support required.
-AARCH64_TESTS += bti-2
-
-# MTE Tests
-ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
-AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7 mte-8 mte-9 mte-10
-mte-%: CFLAGS += $(CROSS_CC_HAS_ARMV8_MTE)
-endif
-
-# SME Tests
-ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
-SME_TESTS = sme-outprod1 sme-smopa-1 sme-smopa-2 sme-fmopa-1 sme-fmopa-2 sme-fmopa-3
-AARCH64_TESTS += $(SME_TESTS)
-$(SME_TESTS): CFLAGS += $(CROSS_AS_HAS_ARMV9_SME)
-endif
-
-# GCS Tests
-GCS_TESTS += gcsstr gcspushm gcsss
-AARCH64_TESTS += $(GCS_TESTS)
-$(GCS_TESTS): gcs.h
-
-# System Registers Tests
-AARCH64_TESTS += sysregs
-
-AARCH64_TESTS += test-aes
-test-aes: CFLAGS += -O -march=armv8-a+aes
-test-aes: test-aes-main.c.inc
-
-# Vector SHA1
-# Work around compiler false-positive warning, as we do for the 'sha1' test
-sha1-vector: CFLAGS=-O3 -Wno-stringop-overread
-sha1-vector: sha1.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-run-sha1-vector: sha1-vector run-sha1
-	$(call run-test, $<, $(QEMU) $(QEMU_OPTS) $<)
-	$(call diff-out, sha1-vector, sha1.out)
-
-TESTS += sha1-vector
-
-# Vector versions of sha512 (-O3 triggers vectorisation)
-sha512-vector: CFLAGS=-O3
-sha512-vector: sha512.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-TESTS += sha512-vector
-
-ifneq ($(CROSS_CC_HAS_SVE),)
-# SVE ioctl test
-AARCH64_TESTS += sve-ioctls
-sve-ioctls: CFLAGS += $(CROSS_CC_HAS_SVE)
-
-sha512-sve: CFLAGS=-O3 -march=armv8.1-a+sve
-sha512-sve: sha512.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-sve-str: CFLAGS=-O1 -march=armv8.1-a+sve
-sve-str: sve-str.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-TESTS += sha512-sve sve-str
-
-ifneq ($(GDB),)
-GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
-
-run-gdbstub-sysregs: sysregs
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve.py, \
-	basic gdbstub SVE support)
-
-run-gdbstub-sve-ioctls: sve-ioctls
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve-ioctl.py, \
-	basic gdbstub SVE ZLEN support)
-
-EXTRA_RUNS += run-gdbstub-sysregs run-gdbstub-sve-ioctls
-
-ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
-# SME gdbstub tests
-
-run-gdbstub-sysregs-sme: sysregs
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sme.py \
-		-- test_sme --gdb_basic_za_test, \
-	basic gdbstub SME support)
-
-ifeq ($(GDB_HAS_SME_TILES),y)
-run-gdbstub-sysregs-sme-tile-slice: sysregs
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sme.py \
-		-- test_sme --gdb_tile_slice_test, \
-	gdbstub SME ZA tile slice support)
-else
-run-gdbstub-sysregs-sme-tile-slice: sysregs
-	$(call skip-test,"gdbstub SME ZA tile slice support", \
-	"selected gdb ($(GDB)) does not support SME ZA tile slices")
-endif
-
-run-gdbstub-sysregs-sme2: sysregs
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sme2.py, \
-	gdbstub SME ZA tile slice support)
-
-EXTRA_RUNS += run-gdbstub-sysregs-sme run-gdbstub-sysregs-sme-tile-slice run-gdbstub-sysregs-sme2
-
-endif
-
-ifeq ($(GDB_HAS_MTE),y)
-run-gdbstub-mte: mte-8
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(AARCH64_SRC)/gdbstub/test-mte.py \
-		-- --mode=user, \
-	gdbstub MTE support)
-
-EXTRA_RUNS += run-gdbstub-mte
-endif
-
-endif
-endif
-
-ifneq ($(CROSS_CC_HAS_SVE2),)
-SVE2_TESTS = test-826 sve-while-ptr
-$(SVE2_TESTS): CFLAGS += $(CROSS_CC_HAS_SVE2)
-AARCH64_TESTS += $(SVE2_TESTS)
-endif
-
-TESTS += $(AARCH64_TESTS)
diff --git a/tests/tcg/aarch64/meson.build b/tests/tcg/aarch64/meson.build
new file mode 100644
index 00000000000..9ec8df169d5
--- /dev/null
+++ b/tests/tcg/aarch64/meson.build
@@ -0,0 +1,208 @@
+cc = 'aarch64-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+cc_docker_host_arch = ['aarch64', 'x86_64']
+
+cc_feat_cflags = {
+  'aes': '-march=armv8-a+aes',
+  'sve': '-march=armv8.1-a+sve',
+  'sve2': '-march=armv8.1-a+sve2',
+  'v8.2': '-march=armv8.2-a',
+  'v8.3': '-march=armv8.3-a',
+  'v8.5': '-march=armv8.5-a',
+  'bti':  '-mbranch-protection=standard',
+  'mte':  '-march=armv8.5-a+memtag',
+  'sme':  '-Wa,-march=armv9-a+sme',
+  'fprcvt': '-march=armv9-a+fprcvt',
+}
+
+gdb_feat_version = {
+  'sme-tiles': '14.1',
+  'mte': '15.1',
+  'mte-baremetal': '16.0',
+}
+
+tests = []
+
+# Multi arch tests
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+# Base architecture tests
+tests += {
+  '../arm/fcvt.c': {'cflags': '-lm', 'expected_output': 'fcvt.ref'},
+  'pcalign-a64.c': {},
+  'lse2-fault.c': {},
+  'test-2248.c': {},
+  'test-2150.c': {},
+}
+
+tests += {'dcpop.c': {'cc_feat': 'v8.2'}}
+tests += {'dcpodp.c': {'cc_feat': 'v8.5'}}
+
+# Pauth Tests
+cpu_max = ['-cpu', 'max']
+cpu_neoverse = ['-cpu', 'neoverse-v1']
+tests += {
+  'test-2375.c': {'cc_feat': 'v8.3'},
+  'pauth-1.c': {'cc_feat': 'v8.3', 'qemu_args': cpu_max},
+  'pauth-2.c': {'cc_feat': 'v8.3', 'qemu_args': cpu_max},
+  # Choose a cpu with FEAT_Pauth but without FEAT_FPAC for pauth-[45].
+  'pauth-4.c': {'cc_feat': 'v8.3', 'qemu_args': cpu_neoverse},
+  'pauth-5.c': {'cc_feat': 'v8.3', 'qemu_args': cpu_neoverse},
+}
+
+# BTI Tests
+# bti-1 tests the elf notes, so we require special compiler support.
+f = ['-fno-stack-protector', '-nostdlib']
+tests += {
+  'bti-1.c': {'cc_feat': 'bti', 'cflags': f},
+  'bti-3.c': {'cc_feat': 'bti', 'cflags': f},
+}
+# bti-2 tests PROT_BTI, so no special compiler support required.
+tests += {'bti-2.c': {}}
+
+# MTE Tests
+tests += {
+  'mte-1.c': {'cc_feat': 'mte'},
+  'mte-2.c': {'cc_feat': 'mte'},
+  'mte-3.c': {'cc_feat': 'mte'},
+  'mte-4.c': {'cc_feat': 'mte'},
+  'mte-5.c': {'cc_feat': 'mte'},
+  'mte-6.c': {'cc_feat': 'mte'},
+  'mte-7.c': {'cc_feat': 'mte'},
+  'mte-8.c': {'cc_feat': 'mte'},
+  'mte-9.c': {'cc_feat': 'mte'},
+  'mte-10.c': {'cc_feat': 'mte'},
+}
+tests += {
+  'mte-8.c': {
+    'gdb_test': ['--test', files('gdbstub/test-mte.py'), '--', '--mode=user'],
+    'gdb_feat': 'mte',
+  }
+}
+
+# SME Tests
+tests += {
+  'sme-outprod1.c': {'cc_feat': 'sme'},
+  'sme-smopa-1.c': {'cc_feat': 'sme'},
+  'sme-smopa-2.c': {'cc_feat': 'sme'},
+  'sme-fmopa-1.c': {'cc_feat': 'sme'},
+  'sme-fmopa-2.c': {'cc_feat': 'sme'},
+  'sme-fmopa-3.c': {'cc_feat': 'sme'},
+}
+sysregs_sme = 'sysregs-sme'
+tests += {
+  'sysregs.c': {
+    'exe_name': sysregs_sme,
+    'cc_feat': 'sme',
+    'gdb_test': ['--test', files('gdbstub/test-sme.py'), '--',
+                 'test_sme', '--gdb_basic_za_test'],
+  }
+}
+tests += {
+  'sysregs.c': {
+    'test_name': 'sysregs-sme-tile-slice',
+    'exe_name': sysregs_sme,
+    'gdb_test': ['--test', files('gdbstub/test-sme.py'), '--',
+                 'test_sme', '--gdb_tile_slice_test'],
+    'gdb_feat': 'sme-tiles',
+  }
+}
+tests += {
+  'sysregs.c': {
+    'test_name': 'sysregs-sme2',
+    'exe_name': sysregs_sme,
+    'gdb_test': ['--test', files('gdbstub/test-sme2.py')],
+  }
+}
+
+# GCS Tests
+tests += {
+  'gcsstr.c': {},
+  'gcspushm.c': {},
+  'gcsss.c': {},
+}
+
+# System Registers Tests
+tests += {'sysregs.c': {}}
+
+# Crypto Tests
+tests += {'test-aes.c': {'cc_feat': 'aes'}}
+
+# Vector SHA1
+# Work around compiler false-positive warning, as we do for the 'sha1' test
+tests += {'../multiarch/sha1.c': {
+            'exe_name': 'sha1-vector',
+            'cflags': ['-O3', '-Wno-stringop-overread'],
+            'expected_output': '../multiarch/sha1.ref',
+         }}
+
+# Vector versions of sha512 (-O3 triggers vectorisation)
+tests += {'../multiarch/sha512.c': {
+            'exe_name': 'sha512-vector',
+            'cflags': ['-O3'],
+         }}
+
+# SVE Tests
+tests += {
+  'sve-ioctls.c': {'cc_feat': 'sve'},
+  '../multiarch/sha512.c': {
+     'exe_name': 'sha512-sve',
+     'cc_feat': 'sve',
+  },
+  'sve-str.c': {'cc_feat': 'sve', 'cflags': ['-O1']},
+}
+tests += {
+  'sysregs.c': {
+    'exe_name': 'sysregs-sve',
+    'cc_feat': 'sve',
+    'gdb_test': ['--test', files('gdbstub/test-sve.py')],
+  },
+  'sve-ioctls.c': {
+    'gdb_test': ['--test', files('gdbstub/test-sve-ioctl.py')],
+  },
+}
+
+# SVE2 Tests
+tests += {
+  'test-826.c': {'cc_feat': 'sve2'},
+  'sve-while-ptr.c': {'cc_feat': 'sve2'},
+}
+
+# FPRCVT test
+tests += {
+  '../arm/fcvt.c': {
+    'exe_name': 'fcvt-fprcvt',
+    'cflags': ['-DFPRCVT', '-lm'],
+    # fprcvt is available only from gcc-16.
+    # Use raw opcode until it's available in cross container.
+    # 'cc_feat': 'fprcvt',
+    'expected_output': 'fcvt.ref'},
+}
+
+# Semihosting tests
+# Add -I path for semicall.h
+semihosting_cflags = ['-I', meson.current_source_dir()]
+
+tests += {
+  '../multiarch/arm-compat-semi/semiconsole.c': {
+    'cflags': semihosting_cflags,
+    'wrapper': [prog_run_with_input, 'X'],
+  },
+  '../multiarch/arm-compat-semi/semihosting.c': {'cflags': semihosting_cflags},
+}
+
+if 'qemu-aarch64' in emulators
+  tcg_tests += {
+    'aarch64-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'aarch64',
+      'gdb_arch': 'aarch64',
+      'gdb_feat_version': gdb_feat_version,
+      'qemu': emulators['qemu-aarch64'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 16292d4d7b0..76d7dbe045b 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -135,6 +135,9 @@ foreach target: ['multiarch-linux-user', 'multiarch-softmmu']
   tcg_tests += {target: {'tests': tests + plugin_tests}}
 endforeach
 
+# Now let's go through all architectures
+subdir('aarch64')
+
 image_targets = {}
 exe_targets = []
 # Finally, we can create all test executables and test targets
-- 
2.47.3


