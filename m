Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98AA6C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPUg-0001Mc-TQ; Tue, 18 Aug 2026 15:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPUe-0001Cv-PY
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:29:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPUc-0007dY-Ky
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:29:04 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH9WP1454263
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=B8PIYzUPGrn
 h9ZlIQ+5ceZdzxfZXxRrnzNbAp7M2M4g=; b=OQXe2yWTgp5SQjn86RloB/rFXS6
 5NeLCap87IwPQMJ0zvsKJcgg30xhTjeNaOesicJst4nI7nqfNlv0543xbQ+j6c1t
 IexMQeEMkq8sYy6BOzcrDiiZQ1vb5288XE5hFHEPL4WNOFraMreV0/XaFxg9vWeV
 NITIIyLyNZXzwkcV9w9wWG30ruL8ze8+xk72AV3P9YFS1f5v18z3arQjur1zljBV
 fhhc1YGST8/LekrbwgiA7lpm97Q2iAl4G0BXkZXlDWm6aocx4lwUljj1e+DnEBuq
 f6ZCpk0uQodrdhzmMFy6on/w7+tdZr0lNW2OOQJnS24i+nVizKdDm+sZGfw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4qxj1v2c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:51 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cce14a21faso1836095ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081330; x=1787686130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B8PIYzUPGrnh9ZlIQ+5ceZdzxfZXxRrnzNbAp7M2M4g=;
 b=fWcpNou4LAErx8m21V2iXH2f3j4bhSvdmwT5gJTuAFZFvdNP8sD+D926g0+RkuRzF6
 ARiEJMqPLqfrxW7rL2ILtGYx+tu+lRPW3FDF8W7G6MwY/uoHfbLQKlNUJF2rRnvxrtaX
 pAnX+Qs/0ErAzwLs5WGniuXuCgN4u2BqWSARA/bXMngA5bNvWVcZLBrfuHF0x+954hK3
 6hQvrcuV5+r1gakJYfKBhQdI3k9NsFPZXOG1ALnHc8FOsuduixtDX8i2XEUZ3pSipg/6
 bfQfcwVMUGivYTND7nIF/foxwmdNEmvHDtTFxEMdrWjgfulpikaZuvYBLL6Y1/FyLz4q
 Hv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081330; x=1787686130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B8PIYzUPGrnh9ZlIQ+5ceZdzxfZXxRrnzNbAp7M2M4g=;
 b=mFaLrKAI7Qp6MHvZRO+CeqUNDBp5TeVTSPBq1Lw9NeF/8f1ffHEbm5bJQXYmC3uvk0
 BUfIgtPrfUzOkumpK6bnDkupwQsxffc6aDorVQM/YTTxL+nII9z1wqddBToDrI2o7kvQ
 FFyoV0+DwT89/IPGcvJbcjKGxgzRIM7KKlofpSNOvw1ohJ9pawWKmX5CR7HVXpnauYw6
 1fNU2nyweZoj0Jx/QB0/JW8feox1/rf+T0yOXbDHoH4yBaTZdqQACM2nvZ6nYZURAixJ
 SctW1/A4pAZFcxSA29zQ6VIEUK0eEOfmEPhDrt7QqvpEwYl5MNDsUK4v6mbsMKSw56qH
 y/IA==
X-Gm-Message-State: AOJu0Yx8q+BddMrq6giv7xzjkP3cQgTm3PVqwCS9nGuHHhGWh4Fijye8
 Dcqp793M+XXSXQArhy7R4IL3bWbuhp9JY537W4IDuM1HCrDeSwuQxiIyKTNpmIHHCywlil+sIsw
 ZwHP3Idm+kFDOK4O6B7rcft0zQMZU71IS0GzbSFqodikse4POkh9O9IZu1CZ7d9GpGA==
X-Gm-Gg: AR+sD12slX1qXWlE8v5Y1uKeZiWZW0ZFhljhLd9MaheebrOS+6QVe8RQCeZaWMJ1VA6
 HbTZOLXgfG5c2YJ5dHO2gmC/ksIODYIOI7NF5dp2oidEh18e+P5XvNM3WYGQflKkWVtn4/nyfDw
 Yx304XVGG3ynMLLwEQw/d92rWK0kcO2gNWEfJqa39ervJ/FfPfn4ldYmZlsKI8zJvLNttXk6RBy
 2AUTybDoXG+ocBd5qT48/oP7Pp0g+MlGp1vIT0T7/nA2wWMLYEWY9MrX5m3bA/lF3ABF8PO/9A/
 Tkj+83TAj5MT3penAe2cVLF+8e6KTLGu04SZdQE6s2jY+HzJ626NvGryDlOCI7DfUMYZP2iHKQz
 tUprICWvSjYSslcsxcrZJdKFLFymBSFH6lCqGWyceP8Y8Ct9RkkXkccopHJ4=
X-Received: by 2002:a17:902:fd88:b0:2cf:7ea3:7cf1 with SMTP id
 d9443c01a7336-2d5cac260eamr99139915ad.5.1787081330242; 
 Tue, 18 Aug 2026 12:28:50 -0700 (PDT)
X-Received: by 2002:a17:902:fd88:b0:2cf:7ea3:7cf1 with SMTP id
 d9443c01a7336-2d5cac260eamr99139325ad.5.1787081329663; 
 Tue, 18 Aug 2026 12:28:49 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:28:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 076/104] tests/tcg/ppc64: user tests
Date: Tue, 18 Aug 2026 19:22:40 +0000
Message-ID: <20260818192309.22169-77-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX/J9qZJ28NjsN
 BNzqZyEqnluZAR3iUfYyIkOJEor7Z5KeCeexdIW71vYo0GIMB337H7F6hOuBSqvYD6VfRpLps0e
 n7QBXyk6l2s4aIflZ+cqC/CpuqN4l0U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX6+kMXcg75TJe
 2sUnxZSsHOlVKiPuOaGX56uhWWEW5n3BCyoOfIs3TJMTqmpOBUeVPYHjekZT2JBB2IB8zGSxNsS
 y76k6Q+saf1GbEPm34sn0FrX/2yeJEaDaVGUYbkkOslhDOfB58i+wWzzCqbWCVLsC05AvP4eF7w
 hM/QDRZJ8qHEcHDrJ+z2gNH0zg6tys4tPQYoQmolya+TlpKZucLQ5/aNbaCVqJ8MhRs/Wkc5cHT
 j3o+/vwFFFlpXQPNY2Mo/EaAx5sgZSIZPtGhooq8khKkgkBkWhukTIU8dqMfPo7OZJAw2W7Punv
 Y0yUDVGMSP2XvDUyh1ErSorL1TKQW6mPJHc0Ul51yabgAcHtqarWF6M2SAAqkQDH5K4Rvrvclrx
 qAg7RpiudjgYj/b+qslACZNKzmSL0pSBM3YLBnGlrLM6xpwbTCLqZ2V6L52xJjwO8htMzvtUGi3
 zx/GQlabMQaoHM4h+Kw==
X-Proofpoint-ORIG-GUID: Nj5I2z96cgs13mx6z7sjWCEXKc2KLfuY
X-Proofpoint-GUID: Nj5I2z96cgs13mx6z7sjWCEXKc2KLfuY
X-Authority-Analysis: v=2.4 cv=bvB8wkai c=1 sm=1 tr=0 ts=6a84b273 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=7oZrJYRkATaSZigH0PwA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
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
index d6406b5cb59..1d1986f5c1b 100644
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
2.43.0


