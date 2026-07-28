Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E138FC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZlS-0004nB-MB; Tue, 28 Jul 2026 00:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZk9-0002ns-GL
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZk7-0002Ai-Jz
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:41 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3adUF1527571
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UJYtBuX0wRZ
 jk0rFhHcTkBV+7pDu/ZCqY5DAw/blplc=; b=C4BhSwk9/2IcWA0btD8fEnW/F5I
 Y2f1KzDEPOFzsd9IkZhIAsh0Et4kga+N1+aTiqJzk6OJN8dghaAUdO6I4bYhWsjc
 UEGKeErNoMvWfWKsqlqDBwnHw2AAofbf/6nEisYYe6/rJHXlN6KQsTtwMzwJ1XgB
 GRNCrtWlLvSz/P1YZ6LL4usMIYJ7tbQqb9KSSpcnD/RR0ZQW0TXZ8YRG46017il/
 iwYFWkJLxbka0LoJawBiEvinjAH7MWJ83DtZoHtvIPuoVOcCsrgKRODP1+HNF6sb
 w18rLOM1qNH/lE7d74Of9AbYyJz8xdmAssiZysLAIw9z//8U+PnOlV+YT7A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbn8adcw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:37 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb48f41343aso486851a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214117; x=1785818917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UJYtBuX0wRZjk0rFhHcTkBV+7pDu/ZCqY5DAw/blplc=;
 b=F1VvhAt4nxFb28fMfl/Eo1avkOEHQGWNyW+OMrtfyQozBd+3Sjuen1A/MBeCTLYXc5
 Ojj7D4uJWUJIE9EfqOpRUGssDdRq0NdPjDIZFYJBHDJ9VGpGSs9TXsUZO2UohQZJXPCG
 QXkS5Zt1Gbor9QUKVTBjRaQNWHtmrbaZYzNjGcKnvyw85LOWiUphdeXXmYGnQtEgC8jD
 hdGIclymGSnhmHwpIEzMZbSz8gqc5nm+LQ1ghqP9cRJoL55FaSrhTBkDh9gIJvlD3zZi
 LaQGT9mUPfJuJgm/pSDCstCggGlxOZEAoFFD7V2boxJhmZ2A7iMJ9ljJQbAIAnMbvzbz
 yUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214117; x=1785818917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UJYtBuX0wRZjk0rFhHcTkBV+7pDu/ZCqY5DAw/blplc=;
 b=H9UknNqcHLvBK+WascOeqL9WLQDuOWpjo4MHWYF4wXjoVy8F7CQsfyJKpWo9k3xjvO
 j352bwYiSztapA8Idruax2ZzBwl+9uoNXU/8OuRYfnK/DxS5A9H8COm4GAn94z9hkO4Q
 N8fwO1BcYhgwf52AiMv4ze9m58Fti8HJ2q4zXKwKdH4/jhbDjCGSUjBkKasO5avx0U30
 b0WdEj8Y9LXqrtIBU3f1CqI8bkDW9pYw5CIIi9dfBGj6n7kGNcAF3BobixzXJSR7BDYj
 K1d9I1DBpHXvYvYOFISuA8H6HnvCI2pst98CD3TiskQrb4iDOPOtcfw5P3nUp1D6QiPt
 tJmw==
X-Gm-Message-State: AOJu0Yw0sWWjqf/Mhk9TYV995VDUHOJ1TvEf48C9bV29k/x+6UTtsRh7
 r946icbA7BZOoOW6tcpXqXL+ZA6m1Jyp5vSU1iC2YngUxjcPyc0+5uHT4h2aCtcn1nDgVMSxBb/
 NFIxv2rfDLsregepJBBywa65HJUbxxhhSdOZbklogVnJm11GGNUik4JKSPcBMR5YCrQ==
X-Gm-Gg: AR+sD11H7SkiKttjTUS3OD7W1ByACusxe4WNkDWVVtfZ+4N1CUwL3JsSRzmg++9wVT+
 /2OX1D7NMM2qZaCO5ShR9OXPItX7T90GUiezW/Usdyqu+ma63DcAwr9ev0eGT9+firbyM9IuLXM
 P5iwbUx88Ntu69GCFd6ys/xROtSkJje3lfspYP2EqmBLy1JSIEzY9ISXBUxqJkPyCtN3XsUljF+
 yrOB3SRLSixzqaLxCkmRF1gzfo5ctYo6HbEBB3XXg+jydon+Q6B6xTs6dAGI3glyRniGKdN+d25
 VAja3B8SG01xZuGA6HYu+2FI5CP5NjRzwtq8u2ct+VG05K6Bh5az2u4ak2/T0G9ZReYWRBirRvU
 CdQx5LWK8iC+CI2Fx0sUhx1k4ZCvW+QdnjpHSlxz01hjLWcGRf/7zYXaZ0iilj0uzHQSa7yI=
X-Received: by 2002:a05:6a21:698:b0:3b3:a66e:3911 with SMTP id
 adf61e73a8af0-3c8ba5f2a8bmr1050741637.19.1785214116871; 
 Mon, 27 Jul 2026 21:48:36 -0700 (PDT)
X-Received: by 2002:a05:6a21:698:b0:3b3:a66e:3911 with SMTP id
 adf61e73a8af0-3c8ba5f2a8bmr1050687637.19.1785214116411; 
 Mon, 27 Jul 2026 21:48:36 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:48:35 -0700 (PDT)
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
Subject: [PATCH v6 075/103] tests/tcg/ppc64: user tests
Date: Mon, 27 Jul 2026 21:42:19 -0700
Message-ID: <20260728044248.137626-76-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX6VhKSbCJJrWd
 pPYIY+3ZApWtnCvv2SQhWCtGlIc50W72jWFQ5sMwIU6tt3Bc9ZjKK8aPTgz0fDrITwxOAB7cmVR
 +YQv7Bb5MCazMlOE7wF5nNIVEftXO8Z6frbXIWgoTDU+LA8HOl5PlleRdYNzPXJ0JcLWdeAgeFM
 VLr9TVlptXg6j9r5XsAL2K23tjfdWdAmmRuhfMvHdyPtlxjbjYnCHEpwP61EoWvh8Jz61Q7al2D
 gfXm0FDYkdKJGUS+eIokHy+UO4gPAy6RRZZTYKG85tx1sOXapRV0KyaH0ycu+/pdKEehTrgvJd/
 0xfRYX7/vjyhu3NhPF0q0+o6u/xGQhM1Q1bqo8vUG4cD58KMdPDUZ/RsUF+FzUVsH54P+AOZlAX
 Z/qBLpFcLe3/clKG1/U0KAD+y3QaY4lm4iP+PJWlcRZKzhGx0SSMCPDCFacesKnVsCBPutNHTEl
 AV7e31yTt3J6RrjJ2yA==
X-Authority-Analysis: v=2.4 cv=RO+D2Yi+ c=1 sm=1 tr=0 ts=6a6834a5 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=7oZrJYRkATaSZigH0PwA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: J-yh3GRiXBnjhc9RqTzyGMSi_JMpCqQs
X-Proofpoint-GUID: J-yh3GRiXBnjhc9RqTzyGMSi_JMpCqQs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX/aK6QeVDhIXD
 grYiBhX8elhSwbNuOG0EhP2spHYt2al74ULJrY+6INm9I0vocJj/w+1mcGDGwvrFEuspn7jaE/6
 cQoCL1UfYx/LGv+fvzSp2NeRZZA5ung=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280041
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
index 310948c3f91..f8166615f76 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -149,6 +149,7 @@ subdir('mips')
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


