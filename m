Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777E7C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziRb-0002zn-1S; Thu, 27 Aug 2026 18:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRI-0002M0-Mp
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRD-00076D-Ik
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:13 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM72H654752
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xPfzHjBdrINyY991NGiVoGNnWdsfLfz8Q1u5eUclq8o=; b=Y1tVX6C3+fRtkONg
 WytX49D0Hh5i8+VPYbdLtGwRYRFdjhg1C1sY2Xw3gQqdfLNRVPyt+trUsZ4ZB1I3
 1o9qcTF+hiRoC6KIqYEaQh6Zsmb00TjeafIrFKi9da8pmF5hH0pCNyEimmGpxyQT
 unFscvtZvtS0T5u/KTuX5Wv9c82yIgD15mhNaebj2MfFAfJl7dr4goFaoxb5UUD4
 CDwB6F9QyObgsVy82CRE86BkXsPGkMmRd5mNSGcU4Pb6YxxX/hw91ia2BZ0UvmuO
 Ga17gw4mJQD0gVzeXc2OMACOpxWhmG6Oc+Z7c+BjHbtMHrssBODfbVMXp/0nfbox
 uK+1uQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gagjfuke0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e1118e4abso394181a91.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869149; x=1788473949; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xPfzHjBdrINyY991NGiVoGNnWdsfLfz8Q1u5eUclq8o=;
 b=Vz7AV9pOZdMdQ8zEjEMt3bNWrR0a5DmOYWRcJydUJMwVQx/kPvhLCNBY3eFhIZjron
 GC0ib3/pGzx+FuoocmVOVRAMzJWUsYaiwQEaJ3egBR0gUrqh0k379qo4xNb89uFdTgKr
 A1l0IS4hBXsozPNy6lxm1c9xbZV4YK/AZC9neox1dfZzElxYPWr7Tkvcy9Em4tNoePIb
 xba6qBWVn6OLFe0eAg2ogaGUENz8S2qiVIMtnR5f0WLkqaNcjCicNzmhPKzrHOLKbIC0
 KqSalSthIVMwtpIdKMzmYmfzqOiwHosBb13dDLDMtJoIbJqhuIxuUM1Us1bATgJ/iKaj
 8lkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869149; x=1788473949;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xPfzHjBdrINyY991NGiVoGNnWdsfLfz8Q1u5eUclq8o=;
 b=N4IY+I+iA/gLUoW5ZlMgY/78CEDEDFrAnLkVDYMG+3RECtmZOFZJycbSQXR8mLgQje
 LFiUJRJXuubzz0aa7CdsybRbCyVMvfwBtlhaMP2Vj0Qjw2fer1/HdUge3jdX75cwTo6N
 UQsA5KfYRzkrRFDilq8Ygh62lbvz8ZBGpcBdeYgfmxLC6LcnhhloPJ6dqy6Tn3rpucRv
 OANyOMwAd8JABxFAFauo9ncmkJca01fJ8TOVn83TqeFiqwxo2hXeY8uCjnrVSzpBR7MN
 4BuOLF3Dy4h7TEjeGlN5i7qsacFvtb2PpoPPRhW9Vd7/dE4gpEYdQ7EobV3Z+aHhcst8
 LUNw==
X-Gm-Message-State: AFuF++nWclNPX9qcxFGLF7oUNKDll+aAKZswAA80/cUkE+tsjuUxr8o9
 XJq+mleuuxJnpblG1BqHR5VlOC7JhsRFC9My2ZjAd6/irBKQ3hwApz4UGOEFxEAB6YND+o0VqNY
 gzlxqAsworrPWHFDSKuF9szBulSF2M54Ew9mg24rFMoHpSEQA91u1rLLZJPY6WnhQzg==
X-Gm-Gg: AR+sD12ql+xu9Nqc8JuQzR5NkwmVErPTNmcvHwIk4Q46FEWuHqx1lCzlzc/GpceX3Nd
 glNKX/+CEVn4Eo2whpP4JOGVh9lmzXzkfGaA1F2Ru9ADE1tsUqH/6hSW2wcJezvna4m+evNghRM
 z1eQxx7lUMvFeggOlZAH4Vy2mqu2jzd1A4prrZqUxEQDOa2fbkjFnT1heJjvSohO6hqogcvH921
 Zhb6uwAFYEuBDoGMBa/IPl6Zd77ja8uTdjzx1S41NfPPW09BLrAd8fM3oXaNdBRkAH5VEML67k2
 gd2rCuE8jfpANlmXWpY7PfHYjr6k12kef9xq25mHq8wI5Vwl5Pllxj//aoFvSkLZF2zGXkPogUw
 Js7++Jj15Ok606AfvNHxN0lDlKgu+olCG19CrIVIQmzdYLOsTKWXdR1A9y1s=
X-Received: by 2002:a17:90a:e7cf:b0:38f:dec8:f7e9 with SMTP id
 98e67ed59e1d1-396d0fccec0mr3966925a91.12.1787869149323; 
 Thu, 27 Aug 2026 15:19:09 -0700 (PDT)
X-Received: by 2002:a17:90a:e7cf:b0:38f:dec8:f7e9 with SMTP id
 98e67ed59e1d1-396d0fccec0mr3966834a91.12.1787869148894; 
 Thu, 27 Aug 2026 15:19:08 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:19:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 047/105] tests/tcg/arm: user tests
Date: Thu, 27 Aug 2026 22:14:08 +0000
Message-ID: <20260827221506.91574-48-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: IifhJblw8f107QiKHbuTqGY7_picgyyG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX6LU8pKBclYtk
 msOJtTKGkTQ6eETDHhpuc3YuUEIGgZvWPTq2f1BRvu5oemDIwU8iG6jcZnzX96RXnrl+d7amVrc
 SQecHSGDZr/d1ho6g5ZESw5cUaYwjxjuhfuR6daJOdO/TMqc+rH+cvPuDNJInXWhWWF/+1J1Mgp
 ji5bIKudBTznB59hWFhztNUD13KvxjmVIYGhhsqF/0aL+DXu4i2gSoUbeW6PSdijVOA08VE2dU9
 2MzNnDOMy+W8w1gqKbo06eNQHEZC2lEUQWBGkdz4oApJAmPakq9CGvcnbm4Won7CxYTMKL4Jw5t
 OmF+g5IgiZ4U9+ux5HuePexmgXgVs55QZ5ULqVSAVT8XNhZRHKnWidQPQryvhRPybQfbK85WvnV
 2IlkYZ5RBgc2fSvPuyKET4ReOybHo52gQgVgxquXU59MfYrEGIUoVTWfX3ETpcBziaDWPoj2/gF
 PNjPQsjnqByM8Ypp2yA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfXyAr5XPI2PA0c
 UGEEE3qTjBRhJboVnX8TxtPubI+FdwyrmaRgIa3APWsTB5mW0ovmXWbqCWsJwIhWgrMV8hLzNH+
 Z8P7/7fN0KWa0trpyBqQqP6kUw6yNGo=
X-Proofpoint-GUID: IifhJblw8f107QiKHbuTqGY7_picgyyG
X-Authority-Analysis: v=2.4 cv=dd+wG3Xe c=1 sm=1 tr=0 ts=6a90b7de cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=RSOb7l6czOOF-PCRW5oA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270189
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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
index e0789d9c1eb..17f48bebf98 100644
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
2.43.0


