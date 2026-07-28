Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB200C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZjL-0000td-Sa; Tue, 28 Jul 2026 00:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZj8-0000az-CT
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZj6-00024E-9b
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:38 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3ajnd2693067
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=r9QchCSosnj
 1qGs+q2nSPDuw2HEhKOEg4uc9aKkHDY8=; b=HoNiBbYSYuv9N6wBaOpvAejB3y3
 S58E+N3srMeZzYYdOvrbtTf2VQgsTpG9reV4UoYnHiDLylDQ/k3kOVfjNLS0r4x3
 nHRRTvA3FF45zyAK+LU0LaGqEr7xk6TrSSik+W3dO9KbI61Qc24sYCSmx3VGkJVn
 2w+BmnfTAbQlymWEIB7qZS5o2aJKUOmXHr6XNGW+c52iKFhOOxhqLB1CHzMqdFtI
 bfE4hIE8lxKtJkBe+1jUPUlsGk/YYRjDTQsN6xQpfORPOBAGNtk9Cm6f9DHl2fhX
 xKtKIUTwCsrWMLnorXdsNtbyuWb3skSGv6E2VGG+iwYJ3TQ35W46Oz6vaIA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbp5jf01-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:34 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e63de75aaso5835257a91.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214054; x=1785818854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r9QchCSosnj1qGs+q2nSPDuw2HEhKOEg4uc9aKkHDY8=;
 b=Jj4qGU4VS/0wEl42BZ4YlFhmwtaKt14SefeM9Ako3ud23KCLeIUb2nRmM8YX2KYhSD
 ZVtooR+K9sNzNak9t7awv8sHS2mL0f+7b/AQEGyxl9FdQzvzGtaX3UcEQRgQe/rEv++O
 1mjMPsG/p3unKsI9oycbV1qP68Lmr0yqVoQDq9qWGllazH1gJD9Q0vGvBrlQC9EeSL3x
 rFVvlBPbTYyTtE941geQKmBIp1o5545uqSP4RonWDbzGW21mIAacyTwHZlhTcYU/0sxc
 Jsz1yLwwrl+M1QX2+nh6+A13OyD03sGSnnU1Cse9dKMajf52qrr/FDjACY6L3lGIVaLQ
 QxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214054; x=1785818854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=r9QchCSosnj1qGs+q2nSPDuw2HEhKOEg4uc9aKkHDY8=;
 b=fUVCnfJqZljmR/O8UHBR8KDyz9+KT2+K6x0rwGVkCoKaayilli/v53gjDecIKSHwc+
 vUWa0SazKUcFiTtxxFcTQODkTZa2j9PIL10q/F7MqIrWw9CSGNfvxkBRDAqY72/DNFDD
 D+3sGRkyzI7BtSo8xu/D45AST9irP2ixI4WrNAODRgrVW/aze7aoBoO/dzw1u4pVjjsK
 hi9sLlPPiAh0OCSfPur731Uy5OZltGp4AUJhobC6G19VWAUpzUURd8krkMpElVq5FXSq
 vGskKrX0SyZzJGq0/M2RS70iWI3OtTVl3W0nc9NDWSEEDtxoz2fpdG0+RlwKORC2QiJQ
 NCfw==
X-Gm-Message-State: AOJu0YwGwCqqDwspAaR+W5cr++crCXYUnK/P2d2N+6kwfEqZp3dHRkad
 4vt+X45Va0IHFWAzFJ5VHIC8spP9b56n2/yaZhC/Es4LcNzRE6mayr49YASIfnZOX5jr8920Bf7
 fB7oy0vnF5OzRSFAHVWwQol5KU7rqfA0ccjeIL3HMxnr5Wpbjvnbm3LjzdZk84oxnpw==
X-Gm-Gg: AR+sD12xehHpq6l9pcrVBr9CwnFGZQYcYYm2zwYob2GX2I2DgdRnmSOJI8xC/xIAXff
 cwln2tjKCy2CG5b5GXKwAkHcCsNEzS/3lxK/ps7H0FYgnFgf1+N7yZ7ZEW9ir9Wt7M9nvY7lF1Y
 YLn8z4DQVrxUty/rzF9iWwH7kHkjeno3wdfFo+b1S1a/anmg7R+21cwJ8pLxlTDvEoYM7ANS5s+
 rGIOkmbRvjkTnkBpktjfskWY0msJ7AvbuDjLpmUe8pljpRt+2jr02Yfy67Zs6FkXpDxoufpLP6w
 b/Y15W5j5ZT18JP1fEmslB0gOmkzTqFNel5fnMr+aOcIhYwVc0GOiCBOl5QVfFIsB6uakTMjI+x
 4EqYZWMyw66E2Q0SG+x5F6ElReb1Bu7UX18S+QBeZXmJk7kb4HSwacNz3uhPGYiLeMTe6U7A=
X-Received: by 2002:a17:90b:1b07:b0:38d:e5d0:9bd with SMTP id
 98e67ed59e1d1-38f6a51ba7bmr905710a91.26.1785214054006; 
 Mon, 27 Jul 2026 21:47:34 -0700 (PDT)
X-Received: by 2002:a17:90b:1b07:b0:38d:e5d0:9bd with SMTP id
 98e67ed59e1d1-38f6a51ba7bmr905675a91.26.1785214053530; 
 Mon, 27 Jul 2026 21:47:33 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:47:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 046/103] tests/tcg/arm: user tests
Date: Mon, 27 Jul 2026 21:41:50 -0700
Message-ID: <20260728044248.137626-47-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX24U29sSoEYZn
 foSzCv+hA9fQ0qwgIiFXlRGovbO5ebK0ho6LtvZ0yOTLp8bJDDnedZyXLPnqE78nm7XlqgSx3na
 /ShjGxxyGePrg4PluV2eEjOOsBsN758=
X-Authority-Analysis: v=2.4 cv=XuDK/1F9 c=1 sm=1 tr=0 ts=6a683466 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=RSOb7l6czOOF-PCRW5oA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX7HRYWPfTKttG
 FHensrieGdZCshuMXzPERmYr7BTmQdbI8J8YRIyb17bDf49CqdNHjl9YvXsqZqEvzBrI3oXb+jh
 InX+gSHuVSsagptrimYX8p6+hu1CG3hZdKIqyakMOcBbXY06DZCCvOTxHO3+VKOkfaNcCuOszX2
 0poc+5eZHC+IkKzmfIKWieW9VEOf61/qnz1xUvpdsr/YKFdj/cgEEdL/ttuyocPrG85zRvU1iWM
 JQPZyjSgKz15iGEwGSIOWZgEpMhuyAFsRYJYGLA5KyYv2h40YdfLlMekL8jpw3HwsZMEIdV6UAU
 bRUjrBoHJ1ttDql/hMwIIiC1ROIQxldwXrHTx+dN3rWc/IL2zhBjyq+x7GeRdlxNOYo9MzqCQFc
 cq7NN9K4L0WzTFQoaLRrqywJGvrLbyEvX71QrV3IiSV9rg3Z3J8/qsEPHBPhlt7qZ2fP3RKprTx
 oNou+GuEgkPRxJEXsKA==
X-Proofpoint-ORIG-GUID: a020Nrs5BvARNzjnUH_Wu0EXrC75KfsL
X-Proofpoint-GUID: a020Nrs5BvARNzjnUH_Wu0EXrC75KfsL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280041
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/arm/Makefile.target | 87 -----------------------------------
 tests/tcg/arm/meson.build     | 78 +++++++++++++++++++++++++++++++
 tests/tcg/meson.build         |  1 +
 3 files changed, 79 insertions(+), 87 deletions(-)
 delete mode 100644 tests/tcg/arm/Makefile.target
 create mode 100644 tests/tcg/arm/meson.build

diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
deleted file mode 100644
index 613bbf0939a..00000000000
--- a/tests/tcg/arm/Makefile.target
+++ /dev/null
@@ -1,87 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# ARM - included from tests/tcg/Makefile
-#
-
-ARM_SRC=$(SRC_PATH)/tests/tcg/arm
-
-# Set search path for all sources
-VPATH 		+= $(ARM_SRC)
-
-config-cc.mak: Makefile
-	$(quiet-@)( \
-	    $(call cc-option,-fno-integrated-as, CROSS_CC_HAS_FNIA)) 3> config-cc.mak
--include config-cc.mak
-
-float_madds: CFLAGS+=-mfpu=neon-vfpv4
-
-# Basic Hello World
-ARM_TESTS = hello-arm
-hello-arm: CFLAGS+=-marm -ffreestanding -fno-stack-protector
-hello-arm: LDFLAGS+=-nostdlib
-
-# Float-convert Tests
-ARM_TESTS += fcvt
-fcvt: LDFLAGS += -lm
-fcvt: CFLAGS += -march=armv8.2-a+fp16 -mfpu=neon-fp-armv8
-run-fcvt: fcvt
-	$(call run-test,fcvt,$(QEMU) $<)
-	$(call diff-out,fcvt,$(ARM_SRC)/fcvt.ref)
-
-# PC alignment test
-ARM_TESTS += pcalign-a32
-pcalign-a32: CFLAGS+=-marm
-
-ifeq ($(CONFIG_ARM_COMPATIBLE_SEMIHOSTING),y)
-
-# Semihosting smoke test for linux-user
-semihosting: CFLAGS += -mthumb
-
-ARM_TESTS += semihosting-arm
-semihosting-arm: CFLAGS += -marm -I$(SRC_PATH)/tests/tcg/$(TARGET_NAME)
-semihosting-arm: semihosting.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-run-semihosting-arm: semihosting-arm
-	$(call run-test,$<,$(QEMU) $< 2> $<.err)
-
-ARM_TESTS += semiconsole-arm
-
-semiconsole: CFLAGS += -mthumb
-
-semiconsole-arm: CFLAGS += -marm -I$(SRC_PATH)/tests/tcg/$(TARGET_NAME)
-semiconsole-arm: semihosting.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-run-semiconsole-arm: semiconsole-arm
-	$(call skip-test, $<, "MANUAL ONLY")
-
-endif
-
-ARM_TESTS += commpage
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
-ARM_TESTS += sha1-vector
-
-# Vector versions of sha512 (-O3 triggers vectorisation)
-sha512-vector: CFLAGS=-O3
-sha512-vector: sha512.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-ARM_TESTS += sha512-vector
-
-ifeq ($(CONFIG_PLUGIN),y)
-# Require emitting arm32 instructions, otherwise the vCPU might accidentally
-# try to execute Thumb instructions in arm32 mode after qemu_plugin_set_pc()
-test-plugin-set-pc: CFLAGS+=-marm
-endif
-
-TESTS += $(ARM_TESTS)
diff --git a/tests/tcg/arm/meson.build b/tests/tcg/arm/meson.build
new file mode 100644
index 00000000000..08a863699fb
--- /dev/null
+++ b/tests/tcg/arm/meson.build
@@ -0,0 +1,78 @@
+cc = 'arm-linux-gnueabihf-gcc'
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
+    if fs.stem(src) == 'float_madds'
+      new_cflags += ['-mfpu=neon-vfpv4']
+    elif fs.stem(src) == 'test-plugin-set-pc'
+      # Require emitting arm32 insns, otherwise the vCPU might accidentally
+      # try to execute Thumb insns in arm32 mode after qemu_plugin_set_pc()
+      new_cflags += ['-marm']
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
+  'commpage.c': {},
+  'hello-arm.c': {
+    'cflags': ['-marm', '-nostdlib', '-ffreestanding', '-fno-stack-protector'],
+  },
+  'fcvt.c': {
+    'cflags': ['-lm', '-march=armv8.2-a+fp16', '-mfpu=neon-fp-armv8'],
+    'expected_output': 'fcvt.ref',
+  },
+  'pcalign-a32.c': {'cflags': ['-marm']},
+}
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
+# Semihosting tests
+semihosting_cflags = ['-marm', '-mthumb', '-I', meson.current_source_dir()]
+tests += {
+  '../multiarch/arm-compat-semi/semiconsole.c': {
+    'cflags': semihosting_cflags,
+    'wrapper': [prog_run_with_input, 'X'],
+  },
+  '../multiarch/arm-compat-semi/semihosting.c': {'cflags': semihosting_cflags},
+}
+
+if 'qemu-arm' in emulators
+  tcg_tests += {
+    'arm-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'arm',
+      'gdb_arch': 'arm',
+      'qemu': emulators['qemu-arm'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index e0d4e04f974..351d4c8b021 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -139,6 +139,7 @@ endforeach
 subdir('aarch64')
 subdir('aarch64_be')
 subdir('alpha')
+subdir('arm')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


