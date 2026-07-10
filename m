Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9D7C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ5W-0002tT-EJ; Fri, 10 Jul 2026 17:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5U-0002cs-53
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:48:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5R-0004no-49
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:48:47 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3Wje1697476
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tYS0fZgWmgz
 tQvmIm9OtOuz/QoJLkOPveogaShtfVCA=; b=JR/Xrz5ZaNnRtmKhbN1FI/tPq1g
 tO5MFyNjzG+NzS/DAxFUvhH28UpqMI0H6CPkeZYxj+sj+K3BhJ5RIvHT1VSiaQ7I
 AGyiKpD7KBipJqgE6LU3rVKZA5nTopOuld3tNjAtxe17Dw7Nx16Yqu5pVZ6BiNsK
 WWOA7YZ1Ec2cV0qWsvR0BRO+AvxV0h8ebvZMBuG8LKVG8FsSJ01053/jdBTHi8bX
 b2nEqo6UTOh6MFhOvsBHEGcv0batd68i/rx5X6aLpApJYyJ8I4Jdzvq6ru+j3s14
 WPgOfl1mJx7aRnZgqGRfJyJWcTGklAzHIT/PkXVVTh+/2s8xVZCo3L7S4Sw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5djh38-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:33 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cce02cb769so15770615ad.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720113; x=1784324913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tYS0fZgWmgztQvmIm9OtOuz/QoJLkOPveogaShtfVCA=;
 b=YgeQgzvjpqzS3y/iNyTKsgv5ePgL22CpsOCKlA3r5cfgYc/96PwYNJ8LztX363iRns
 +IBlI7p5spXxj18Z5zNJrNrmB2utjesIKe8hSwm/52hGA1eH+E642OuCcPZdAVI8ozjh
 1Mno7beoFCmOYGlh2DEkRG2iUkKa87JoGPftTTLt30lhLwek62gb5geskb2OQH4eyG+y
 4mn169Qw5Dv5QNcTu4nijmNTPHA5CFJ3VOVwK4q0blaq+riWLSFrXmLVwozxM52TYd5y
 I28hf3qjgpXN2JwE9cSNT3DRzFWl7deRNqlGk0kXJKZmYYfkq1wVp2PuDSQ0EpYtuQ2h
 HZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720113; x=1784324913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tYS0fZgWmgztQvmIm9OtOuz/QoJLkOPveogaShtfVCA=;
 b=UjIQaSE2hcrC4Q1wzOkuTaTptreGySoMHTf5qsPQ77fHWn1BG9XLWrnVaUkmPyYjR5
 8eBXZ6y1rt1wr/mJFq9RwdrPwMGGUU8CASEiTs5vvvRulICqtGVLHhXn3GGENfRn7/HO
 PdCnMZ1qVeysISJm5TsHsMvN14eBRY9wLovOTdWnf3WInS5yBWGhSTE0xxqWjJeN7xpK
 wemWMCOKOoAEPce10sl3f3aqF+sfTz05ZtNCVtQVl0+opClEfifxAdg8lOmSCf/aH7Z6
 JlUsSzC5yAk13IBDQcvauyS+RgR+p1xKHWRcDdes+OniNfPLdrN5sA1uBmstd03AHaRS
 r4IQ==
X-Gm-Message-State: AOJu0YyWvCv9aPgrbNsyKUJtdnwJ/L6Pv6obSXKq3g5dEjyXzVAYcUAY
 /+vsDRPvWOax7d48gJc5n5zXaE0T382lO3vCWcDsfKgSyxKR2QGL4QUU5Zd/JxNtBVLJkzOHZpy
 rWrkuNOjVkpjLLbjYM+MOSRD4he0go9Cz5qTeDmhEI5cCF9eKlmy/ITCmhHNMq8Xrjw==
X-Gm-Gg: AfdE7cnnnD6HnaAQQvkKf56iyHQO8HUoshj0jdAbKsYDZZAcs/AuuNWl0G1n+/nx1go
 T4R00EXPeAE+SihXRBXA1hGnBIqm9uJmXQBtHJiq95I+ckJ9xPF5Ac79u2e8BHdX2wtET39nvqn
 MKyt1JQiO6Q8GrWT0QMT+oswyG4p7WfHWcydda4/wRGAW0UIvjuZsjHSA9Pxxkv9jeQPmqUigxR
 tj9+ohOfmczbW5RKddrn/wFfdtIbgFHt+jlTppSSo9Hs43skqqEDvebaigGsJce1580MACpN2v/
 yZClMAsyl99zKMz6nxKNWTyIve1cgaRgOoAb89gPEiVZp/voSge769pZZ42vApoutG4JZih1fuT
 II7jDc9lPEUE8g70me5FXGcimPiaPgOk00uMZ1fc9I+8PDshjAkf06L3rtq8LfpfbVVXUPbDHGp
 nFuuDtWA==
X-Received: by 2002:a17:90b:3ec7:b0:37f:464d:ea38 with SMTP id
 98e67ed59e1d1-38dc72a4995mr580530a91.0.1783720112832; 
 Fri, 10 Jul 2026 14:48:32 -0700 (PDT)
X-Received: by 2002:a17:90b:3ec7:b0:37f:464d:ea38 with SMTP id
 98e67ed59e1d1-38dc72a4995mr580503a91.0.1783720112180; 
 Fri, 10 Jul 2026 14:48:32 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:48:29 -0700 (PDT)
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
Subject: [PATCH v5 46/98] tests/tcg/arm: system tests
Date: Fri, 10 Jul 2026 14:42:50 -0700
Message-ID: <20260710214343.2065491-47-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX2e4R1kTR0tM2
 acBUhBer39iBr3efTTYXY9wYf9Wgyl5jzvoIqjvlDbpDAucbwkyvvLnQfS0xWHFfgYKaqIM51Ou
 FUedqmMp6I6Y/VaTmlsv5MaY+RlIhb0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX2r5ypdJ3BPdg
 qLzIesXx/YpRjNGaDg8yWUQZfxVHbZWS2qTq4lA4VlEL/FtB5VWl+aIxcnRF4s2GTRsO9MRmHcm
 Y1duxiOb/KABOY3coVGEB+GbE9mJvII6NaZVjQb/uAyPDotv8tSg8hzUI9tS6n+LAVz2QjTRHSF
 VSwj9MhSi6Rz50FL4zgoaJzlPX/e41eYjj0/iHMAZHkLtePU8VMbGAut60T13urWUzbFoN/M9Uo
 JC5XTWjTVoBzqRUMfKJuAIMnsAbqTW7u+II5HNWAXltJxNLPzrdp6yjKb2vkVQgh6WeMPFWAui8
 v5ETgrMrWs3qZwY7oO1mLTN1eOQ4BC2gvlC1hQlP1cG1V0TMiUe3NY1LXXgeRo47HlACt8K8/m0
 AOmR6ipQLDMJK8/6pwEPfjuwokFOaiCg3NoXYTgXJVA2PO5+AZtclIRQ68kEaAKvGizUH4qz5G5
 34xiswxnwVTeF9bje+A==
X-Proofpoint-GUID: nIi3w482-q4OrR6_QF6TdT7WOv7VdC75
X-Proofpoint-ORIG-GUID: nIi3w482-q4OrR6_QF6TdT7WOv7VdC75
X-Authority-Analysis: v=2.4 cv=M/x97Sws c=1 sm=1 tr=0 ts=6a5168b1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=7m_YixJVTNSDrcG_JfQA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
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
 tests/tcg/arm/Makefile.softmmu-target | 80 ---------------------------
 tests/tcg/arm/meson.build             |  2 +
 tests/tcg/arm/system/meson.build      | 66 ++++++++++++++++++++++
 3 files changed, 68 insertions(+), 80 deletions(-)
 delete mode 100644 tests/tcg/arm/Makefile.softmmu-target
 create mode 100644 tests/tcg/arm/system/meson.build

diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
deleted file mode 100644
index b66074b0b43..00000000000
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
-CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
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
index 00000000000..d507cf980f6
--- /dev/null
+++ b/tests/tcg/arm/system/meson.build
@@ -0,0 +1,66 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('kernel.ld')[0]
+boot = files('boot.S')[0]
+cflags = ['-nostdlib',
+          '-Wa,--noexecstack',
+          '-I', minilib_dir, minilib_printf, boot,
+          '-Wl,-T', link_script,
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


