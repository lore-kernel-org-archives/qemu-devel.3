Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFA0C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ5T-0002VY-Ez; Fri, 10 Jul 2026 17:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5Q-0002Gy-Vy
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:48:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5N-0004lD-A6
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:48:44 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3Fg21841579
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nF4KCxlQZc3
 ypBxPoTRcEH1NCHVnUJJnkzIsU7y6PDk=; b=hnTARTYOZWojiSxiW8mPAoWmI4m
 ywBTOMUS/6i/4Btu+bYfIApS/5r5P73XQOTluhQB/WqONjLRuTAdxnb3IwEszuNr
 rZdTf+i+Tma4HWn+v8sMlhuwDDIPvpgGJ7Wv5GIH4ikAp+fenkq2s0mOOOXx6rsf
 4tuZvxtaVVuUUFjOd+oRO4eMLNkVhSNS7FTDqGiVAqzdTghpXG4GVeuEo5mBbKpm
 d7013Zmohbw4oeKDRrLI5Idr7VyzoE9bT60xqArjteaK4VYns9T9cj/73J+FOs0W
 +hWprFCdmsG67t02pvgzzscJDZYg+RBJ1ZRVV7z0i/JykEJMN+dQ9tQB9Sg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb3xn13b4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:29 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-37e24235ce1so2564108a91.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720109; x=1784324909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nF4KCxlQZc3ypBxPoTRcEH1NCHVnUJJnkzIsU7y6PDk=;
 b=bdFLpMR3jyBof5li/tyJGIeK5M/It4J8HbsWZ6wRSXsRURwUbFUtOwIKwcaJB5eQG9
 MqVfpmpXSqdYl3zAbDo2jj+HglGMm3M6g0KK020BqVHrJDaJAiqPHyT/IjtcslKH+6DS
 Y78M+Ruh8FVKlZ4UAQvootWVk+eMqqliMlCQQUjJbprcYQo8ZKL2Rc1GOpVgJVNeyNd0
 VMIhSRbXHey3E/7lt/hRHFjM8ktnlZh/+AwN0uqK5kIsCOJPgAYe8GLsT2D2OXkNqq44
 fgV45+2k8qUf3sM1KWzWAIfEdYOS1FS73Ld9rsgZXonvTLO3fPLJorhJIPuujTVECV5G
 DY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720109; x=1784324909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nF4KCxlQZc3ypBxPoTRcEH1NCHVnUJJnkzIsU7y6PDk=;
 b=XDwLhf8vMnrcaEQFA6OcBwBXNwVyiABAs7SUI1ciIIF4COVWe7dGRS8Sg6r7p57Ahm
 c6j7/MplFUAp2NKmCsHMSIjuQol+uju1lGftQxmWFbWEobC0AKvcl1g6e9d55zCPYJwN
 SOOOknzKT0KLmnB56WG2i99qzxkjudhiby0q+mEP5nBls5FJzLiBTOu403CG0ugRH9o8
 fj7VBHFh2tfhy7C9lHPiNySjljX5n5FIX+bQ+pzUm6v4vdDRU+tmamYYrULKLAXFbnTW
 wx0aAAhqeGYz9V/EcLa6LX7YAS8fQBCa4T422zpo8Co1KqEFQN4m6UygmkG2QKQRYz24
 D8Uw==
X-Gm-Message-State: AOJu0YwPaYtS9HxKJcyvJrcAwhvCO86Tu0UOUeq5o4E7d/ABYJrxIDF0
 Cre319jsrMjYbjsRDfOVhbZFtAQDtrLJsq8IetgwxAbBy8yr+OqDqcDPx+xwJvYLwwAgFzu6rAL
 Gffquwr/Go2CbetAtjkG5tWpV4uTt+qF1Zy3GQV6ysL/iCpj0navROHh8OGbm7OBKlA==
X-Gm-Gg: AfdE7clIuwFsvkWr7VtThHNdi0O+x79kimE3GIFOTdjo5Fjom1ebKDoAGxxPFh1QU84
 PV3kvGmCclXk3aX6BQp61ANOmtEatYYtwE4ot/cyxS3YExEIlx0qR8EpbDR6cw6dRXtKLATuwLf
 m3Nf33vEC6suDVjQuSH7Ev1BbrdIkgLXYwu9YeUjPijp6mDo6PCAttbD/YmImBWCGyqAB/M9gTF
 rSOUNH3GvChMhyYPYpOGGL9hDU9pgqLyZqEg49toqISD3Pn6V/F8PIF3znywVRrIAUWReCY7WTY
 nkR4Bu5oiy/g3O+Jo887CEFUIKfr6KKqOl1YauRlsIfdES9h1ET/7e7ErbSf49OBr1aY6rgbeJt
 Z4ZWtQY1Qn8I7N5pWigGqZi5HHEJ9bNhRjw2r4bJh3s4Si7QRRgu4je5THBBlvEPRmZzlKeqO2Z
 O5MQA4lQ==
X-Received: by 2002:a17:90b:3903:b0:387:df8f:1409 with SMTP id
 98e67ed59e1d1-38dc77d8a8fmr567396a91.42.1783720109162; 
 Fri, 10 Jul 2026 14:48:29 -0700 (PDT)
X-Received: by 2002:a17:90b:3903:b0:387:df8f:1409 with SMTP id
 98e67ed59e1d1-38dc77d8a8fmr567373a91.42.1783720108687; 
 Fri, 10 Jul 2026 14:48:28 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:48:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 45/98] tests/tcg/arm: user tests
Date: Fri, 10 Jul 2026 14:42:49 -0700
Message-ID: <20260710214343.2065491-46-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JJYLdcKb c=1 sm=1 tr=0 ts=6a5168ad cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=RSOb7l6czOOF-PCRW5oA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 6tgPCmA2nK6m2Q_YCnOw1cHr-j2VA6F-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX4nQ451zPjrSj
 OCGNFJWFznGzSjRjNJMtE533r98yFLewrBhzDyAE/8RvWu3mSwPtRVdP38z6pIUt7lnWVKufGYQ
 NcrKyIMiuwbDSvihzv8JkkDblrRYtno=
X-Proofpoint-GUID: 6tgPCmA2nK6m2Q_YCnOw1cHr-j2VA6F-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX4f+8TO1RWBr9
 kz6ScpPIy8voKupgtWtVCDaqzM/nw/TrtrNSgPBE5JeFCsazRFHwFch0v21YVljeKakj14gEITG
 CRVD6r9ER9J8jlakhkC7y2aJDQdCaGjuq/5ilKE9SPoD5/cGqDcycl0/iM0zYEVg3pKM+LzloYJ
 qjftKyFRwSHR+9teIaonjVNX+rlLQgcKLi54x0GOm4n0emwRRjGheG3nfE173uuW+LlGbLmEm9k
 I+OOow113lEvDEtLkmYxoK641DEzlHuRCo/zFq8hi3hlUieAU5ZQGSlQJCoh7jKAAEhw3TP1Vq1
 HL5fGQZdN8eLsG36/RsANprQuph/oA/3Z+asPBaup1xxh4dBFbA1Jdl3xgFW34xI/KNWn5uO46K
 eslu+WwsagQq6GvPq18W0Wu/Ug6OdIN+KCZdH58SLM83KHNcpwCg9DDbOvNqR8++Q76ftdjvcwk
 ZsVUTRAb+f8RH+szOWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100219
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
index 45f53fbd8df..e2bc582ab5b 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -136,6 +136,7 @@ endforeach
 subdir('aarch64')
 subdir('aarch64_be')
 subdir('alpha')
+subdir('arm')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


