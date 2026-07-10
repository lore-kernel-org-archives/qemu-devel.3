Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6726CC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ6S-00008m-2Z; Fri, 10 Jul 2026 17:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ6Q-0008Q7-5o
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ6O-00059G-0U
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:45 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3OxX1894407
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=GC5j+dnDVsq
 E68DlnuagrRAr9I+sFwIUTNqxrNwloT4=; b=InVYsYuRONNXv5p3o0/NEW7O1et
 QZ0/C0VmSpmeMMqCyK5OTblx2Bm3DGxbCZEg7WgHbpibEijc/Xql7BEutczGSa7s
 azlYTFZVlWcmfQjiQu2ydps+26TOpBaCa936YQxYYl7zRZ6LCeyfpBDQqdbEfEEk
 QLNFrMNBp0YH/Aknn1aC3Cbp0HRHxznp6KstfXfcfaSpvmDV0+P6TezRQsXXjXrG
 Kadeey5iEChdx8vGYxKSZUjTQM7ORvA7ZiNo0Re2rIj0ARSkOw9KdvfGtyz8GTAt
 qM+rlQq5W5VHiWqetoycMAA0kG5Um538Y95D8XxLWx1zsCEe4g6TZ8daLdA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb3xvs371-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:32 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38dc085b0a7so746744a91.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720172; x=1784324972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GC5j+dnDVsqE68DlnuagrRAr9I+sFwIUTNqxrNwloT4=;
 b=LCGlStYzDG1JqHDOc14xKbRIc9I1KeE61udAYKQIp0iENRwa9z1I9hgXDYS2QFdoU2
 V8QCyhiuNbNjUFFATDLTL/t5/zXmPSM63T/bQDnxvHvWSC4UqPkkTTzHSnsGK1CXQ/ev
 B2cxx/vGUk/8NuugafOkR+H/Av61JV/OzahoSz08E+LTcaEXPxiEqquxcXppg7SxmgYX
 W7VetfYx7yIWXC1x9YV3AFlzSYXFdbmQ3SWFnZ/r5VkZxkKcGhzIKC0HVE6IxzpwIkP5
 P1Al42CmVYXnes0jCnMZytFtk2aiR4/zEfIGIY0pHbgGGZPWAWOsKoKsLab8z/hjgdqC
 2N0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720172; x=1784324972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GC5j+dnDVsqE68DlnuagrRAr9I+sFwIUTNqxrNwloT4=;
 b=bpH0hT9FnJYobtApVgoFmqna7FyJFZKFkNGjbXL0kSAdff8vo2TkYCOxRtuLznh0K6
 qW/1bWFZ773ooXV5xcZIKQ9UEZENc4FZY5qFKHzQFOG8U/fBnoDL2oXz18v26aUXiqL8
 vL8HZupflzL6IpRzCsUsCNTUnLjol+R1zp/K1zgIVws0uH2t8R1OySfAUO9DTOoZypHz
 SfsoqXEMudJRA8v8+LD82ocvvM5HCeLgwiHmd5KZJSAYOmwBwcZV5BUzud/tMZT6pMpV
 WBhVAaNNF2gt2kOY380H3Yodl9Z8J1Yn2uOmqqi5NKqRQV2KHpqh/OBSegJHu5XjZhVW
 sedQ==
X-Gm-Message-State: AOJu0YwFIWpljuEFh/i8qbb0bVtZ3DeulawZ6ql7pRLedS/2LAgvmkE3
 qrAowHXaoq65OHTk4M1GcisqzrKPz0GqZZGfzHoLmKcv8V3MnXY+BaMnNGXAHNxnNmr0vxcecjR
 57+y2wRMoZ2BOx//CyFPO51cl38x43vco0jzcUAynrxz+RhBkzErLHg5jBLTuD2q4VA==
X-Gm-Gg: AfdE7cmFRTzvpq2qfSL7fnhb+jo48esYNXEkltMIavNOy1MZogUTRgQ4EwNJXVan4zW
 wvIdk5lAPVZFGIGWJaVHDZr/73fvjKQLn88gYC2JZ7QPEZKO73c2neFa8+bowGeQ/nn3ObdzB87
 Gg10kdFgb1abCZpzFZLLcHdoec5N8jzH0akowbtcm7JMuMM/5XSEC22OHqSYAOZQzD3CWN1lKrY
 dRgllCOB/MWEuePbTiuYRCHSmMvBfbdulESueuW0GsyXR3uEPDbftFes3OqxvT9gvuCsppj/VFZ
 XlCyfbyyIrIzurFsJxNqbsw9+inInidmTFLzHZX8IpeFkbhIFRkXI54SGj0Q0W1EZX4E4QCJWtv
 AJmn+XmFrsM00CE0xVHUcvGP3V3P2pI23GIRXw3BOjr7DAH6jf868ZDhu52vRvPRnnPtCkPC9iF
 W5ca+i4w==
X-Received: by 2002:a17:90b:5687:b0:36a:8240:2477 with SMTP id
 98e67ed59e1d1-38dc7608a0fmr626940a91.19.1783720171540; 
 Fri, 10 Jul 2026 14:49:31 -0700 (PDT)
X-Received: by 2002:a17:90b:5687:b0:36a:8240:2477 with SMTP id
 98e67ed59e1d1-38dc7608a0fmr626914a91.19.1783720171071; 
 Fri, 10 Jul 2026 14:49:31 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:49:30 -0700 (PDT)
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
Subject: [PATCH v5 74/98] tests/tcg/ppc64: user tests
Date: Fri, 10 Jul 2026 14:43:18 -0700
Message-ID: <20260710214343.2065491-75-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ncgJcx_q7krr3iIsX09wuBP0-wHWB5_q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX2flP4mXxrHHU
 v0LAKvNe0fyqfiRPJt2up1lWFmA6ujHYxqlH+WNvq7zjKENNj9IiGDHvE9Z5aF+Zklf1IzyclZd
 ERl5FsUxlcN8WmSvzSpr/b7b7xbIBMG0KQM8RvNk9s4UCDKcqlBau/zTTob+U5yphyFKqUrbPtL
 TFgR5mZvh6ShD8fWlexftRM9N0twpTBYZd/h1rqfm4OjiJZz/7r5lJbKH3z31qffUi7Q88Rg8qO
 C0I5ZVhBw1xNok+C5oD7hyDKg70N+73ygl9o996QOMjcfBKL4tvmPmTLfvyQk0A6x/VK2kSO/eW
 uhKZQeOzEO+PnYd3GFrDlIg3xHVHwZzWfiS+yxqu06rZ5VQ25SyEbDC3ax1vKQtdaeG+kvAGO8M
 Y3oeykApV5+m8FugdSFkefmPFdm+qyJ7duWcdADpQlJBQlCZ9LU9JU+E+H1HbOGrqbKHGheBp+n
 E9OyaKCtnKN9MN8oQsA==
X-Proofpoint-GUID: ncgJcx_q7krr3iIsX09wuBP0-wHWB5_q
X-Authority-Analysis: v=2.4 cv=HInz0Itv c=1 sm=1 tr=0 ts=6a5168ec cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=7oZrJYRkATaSZigH0PwA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX00fIQOeV8/c3
 ZA4MWzHxu11oPHzEs4YcqbgzpztW9lg435MejXyyB0vHpMTyp7pf25V11fo1sVWXZWQkiLpzjOY
 +eb8jQh019HJbji1HIx21L8joB5n5EM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
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
 tests/tcg/meson.build             |  1 +
 tests/tcg/ppc64/Makefile.target   | 63 -------------------------------
 tests/tcg/ppc64/meson.build       | 56 +++++++++++++++++++++++++++
 tests/tcg/ppc64le/Makefile.target |  4 +-
 4 files changed, 59 insertions(+), 65 deletions(-)
 delete mode 100644 tests/tcg/ppc64/Makefile.target
 create mode 100644 tests/tcg/ppc64/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 0dbf92c2d9c..0013620c364 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -146,6 +146,7 @@ subdir('mips')
 subdir('mips64')
 subdir('mips64el')
 subdir('or1k')
+subdir('ppc64')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile.target
deleted file mode 100644
index 0d058b26006..00000000000
--- a/tests/tcg/ppc64/Makefile.target
+++ /dev/null
@@ -1,63 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# ppc64 specific tweaks
-
-VPATH += $(SRC_PATH)/tests/tcg/ppc64
-
-config-cc.mak: Makefile
-	$(quiet-@)( \
-	    $(call cc-option,-mcpu=power8,      CROSS_CC_HAS_CPU_POWER8); \
-	    $(call cc-option,-mpower10,         CROSS_CC_HAS_POWER10)) 3> config-cc.mak
-
--include config-cc.mak
-
-# multi-threaded tests are known to fail (e.g., clang-user CI job)
-# See: https://gitlab.com/qemu-project/qemu/-/issues/2456
-run-signals: signals
-	$(call skip-test, $<, "BROKEN (flaky with clang) ")
-run-plugin-signals-with-%:
-	$(call skip-test, $<, "BROKEN (flaky with clang) ")
-
-run-threadcount: threadcount
-	$(call skip-test, $<, "BROKEN (flaky with clang) ")
-run-plugin-threadcount-with-%:
-	$(call skip-test, $<, "BROKEN (flaky with clang) ")
-
-ifneq ($(CROSS_CC_HAS_CPU_POWER8),)
-PPC64_TESTS=bcdsub non_signalling_xscv
-endif
-$(PPC64_TESTS): CFLAGS += -mcpu=power8
-
-ifneq ($(CROSS_CC_HAS_CPU_POWER8),)
-PPC64_TESTS += vsx_f2i_nan
-endif
-vsx_f2i_nan: CFLAGS += -mcpu=power8 -I$(SRC_PATH)/include
-
-PPC64_TESTS += mtfsf
-PPC64_TESTS += mffsce
-
-ifneq ($(CROSS_CC_HAS_POWER10),)
-PPC64_TESTS += byte_reverse sha512-vector vector
-endif
-byte_reverse: CFLAGS += -mcpu=power10
-run-byte_reverse: QEMU_OPTS+=-cpu POWER10
-
-sha512-vector: CFLAGS +=-mcpu=power10 -O3
-sha512-vector: sha512.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-run-sha512-vector: QEMU_OPTS+=-cpu POWER10
-
-vector: CFLAGS += -mcpu=power10 -I$(SRC_PATH)/include
-run-vector: QEMU_OPTS += -cpu POWER10
-
-PPC64_TESTS += signal_save_restore_xer
-PPC64_TESTS += xxspltw
-PPC64_TESTS += test-aes
-
-# ppc64 ABI uses function descriptors, and thus, QEMU can't find symbol for a
-# given instruction. Thus, we don't check output of mem-access plugin.
-run-plugin-test-plugin-mem-access-with-libmem.so: \
- CHECK_PLUGIN_OUTPUT_COMMAND=
-
-TESTS += $(PPC64_TESTS)
diff --git a/tests/tcg/ppc64/meson.build b/tests/tcg/ppc64/meson.build
new file mode 100644
index 00000000000..c7e495f3d34
--- /dev/null
+++ b/tests/tcg/ppc64/meson.build
@@ -0,0 +1,56 @@
+cc_feat_cflags = {
+  'power8': '-mcpu=power8',
+  'power10': '-mcpu=power10',
+}
+
+tests = []
+
+# Multi arch tests
+foreach t: tcg_tests['multiarch-linux-user']['tests']
+  foreach src, setup: t
+    # ppc64 ABI uses function descriptors, and thus, QEMU can't find symbol
+    # for a given instruction. Thus, skip this test.
+    if fs.stem(src) == 'test-plugin-mem-access' and 'wrapper' in setup
+      continue
+    endif
+    tests += {src: setup}
+  endforeach
+endforeach
+
+tests += {
+  '../ppc64/bcdsub.c': {'cc_feat': 'power8'},
+  '../ppc64/byte_reverse.c': {'cc_feat': 'power10', 'qemu_args': ['-cpu', 'POWER10']},
+  '../ppc64/mffsce.c': {},
+  '../ppc64/mtfsf.c': {},
+  '../ppc64/non_signalling_xscv.c': {'cc_feat': 'power8'},
+  '../ppc64/signal_save_restore_xer.c': {},
+  '../ppc64/test-aes.c': {},
+  '../ppc64/vector.c': {'cc_feat': 'power10', 'qemu_args': ['-cpu', 'POWER10']},
+  '../ppc64/vsx_f2i_nan.c': {'cc_feat': 'power8'},
+  '../ppc64/xxspltw.c': {},
+  '../multiarch/sha512.c': {
+    'exe_name': 'sha512-vector',
+    'cc_feat': 'power10',
+    'cflags': ['-O3'],
+    'qemu_args': ['-cpu', 'POWER10'],
+  }
+}
+
+# export tests for ppc64le
+tcg_tests_ppc64 = tests
+
+if 'qemu-ppc64' in emulators
+  tcg_tests += {
+    'ppc64-linux-user': {
+      'cc': 'powerpc64-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'ppc64',
+      'gdb_arch': 'ppc64',
+      'gdb_feat_version': gdb_feat_version,
+      'qemu': emulators['qemu-ppc64'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/ppc64le/Makefile.target b/tests/tcg/ppc64le/Makefile.target
index daad5118a56..00a0cdba295 100644
--- a/tests/tcg/ppc64le/Makefile.target
+++ b/tests/tcg/ppc64le/Makefile.target
@@ -2,6 +2,6 @@
 #
 # ppc64le specific tweaks
 
-VPATH += $(SRC_PATH)/tests/tcg/ppc64le
+#VPATH += $(SRC_PATH)/tests/tcg/ppc64le
 
-include $(SRC_PATH)/tests/tcg/ppc64/Makefile.target
+#include $(SRC_PATH)/tests/tcg/ppc64/Makefile.target
-- 
2.47.3


