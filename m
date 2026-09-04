Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A092EC79F89
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TaU-0006hv-3a; Fri, 04 Sep 2026 09:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TZw-0006P7-KI
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:39 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TZt-000376-56
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:35 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-485843aeab8so1040250f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788527011; x=1789131811; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1OyClSiUQGhlrq69uGLg9gfnp27Lnq50REsl/LVAYXA=;
 b=wqRCQ6WUHQkwx/GSDQUCowCmHWHsvAPvNNis3jkxBjgDYG+awVmHnde696HqqCLHBP
 O5Ofee8ThnfEYPe4W8D1kme6mNe7IXYOqsXEv8u9S2sJ3gnD2E0FkUjR17ODzqVlQB3x
 bgVKnnbUwRZ95huY5szhT24GaWzCoincmwtk73RBhs2b/xbrRAxjFXs2cg8J7BluwaBy
 Sp6DAarT70EASQ1LwVlf+aBTjDHVLVpCugujss7kSWZoO4Tlm1KAO4oYiReFtKbA+tvc
 YWXORB7ILWPVb9eS2CBQZbmNhKsMmAlvI7UCa1Ypf+8yA3PFoS3DlJoMjiTdgcqSGfzl
 5IKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527011; x=1789131811;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1OyClSiUQGhlrq69uGLg9gfnp27Lnq50REsl/LVAYXA=;
 b=TZgmD80mPhqhQ5P3Orcwo4bzbbVNG6bv7vY0rHbA0EkeHVfzsieJZez1rNQJ3FykwR
 zNtx4hDYLS3qEuVH7z6rkGm5nAjdfML6EToN7Uribx9sV87kdAe209HDlphvsvqVf5LZ
 7yaft6BhOtq24uI9cmKlJX9QnDK4U+xIgFI3D7VTlFRscEjOI1xE+L2bB7+Tv4MlhW8A
 yzEMaEHCRr2H4x3zdsLPH5WLr2GJoqtXj9r3+gvQJd5s/825svqGIA9BwhCcx4sTUtUZ
 QjXqSEZgVwOD6BjCyQkEciHfV1TzlnaAM2udZWhrXfWsAIBxh2rP+J6UGbvJv303le44
 LQSA==
X-Gm-Message-State: AFuF++lyCy9WFAZ4SmZvUNZF82zD1w4AYu9htLOrgE8iVQ7NCIlsTD0I
 uhMeYdIIGpxd0cAsfpTfOCIcD7p84UJiotfDGbr+sQCRtHmDKuQbRAiu/krEILURwQE=
X-Gm-Gg: AYBFou2W+2GU0BYoDesS7DyRY5olHpn5a8P+CkOna76fhzE4NkFrmCIadop5xAOoPUb
 /0QTLMm1rd83ClE9dnPZDdJgSv8fDAqHT4XO7LuV0wj7crkO+Og/35uXmuzye9fMw7U9rYktsrI
 tmLoEJzLPm2xm2jMTowPRy0LGJcmvJ9GsT2/ae/2cjAtMMceh+t44SDYADwIT4LZP6irwNmjsiP
 YiRLfToaYyMQPKJDrbVtK9QUFjj2cU+lE2fBtydkBVVYwfWbJQWnBCPRCWxttPEAPb4fDMcQ2gM
 EAXvqMNQaZSXH/MGDEYlkeKffUkqx9jLud5eiQ9WIQyyPfb4e/tnIqLdd5I/EaAAs6Wcq/+NrSe
 1ucCEm2c1U23s2df/1/R2VAmGfE0j1n7Z8dDNvlDvQrtFoiLLG4i4pDhhhYcvNkauOAyS1cy1el
 sci5j99Y9O+ov5QSRgL4AJWqP7peBXIJxxVBAIYDpDdyCCnx7hjTuc2rfWcAKUzSe2Oms2j8k=
X-Received: by 2002:a05:600c:4f89:b0:49c:f617:7cf with SMTP id
 5b1f17b1804b1-49cf7f32d0amr80969675e9.0.1788527011321; 
 Fri, 04 Sep 2026 06:03:31 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858791bddasm6723804f8f.0.2026.09.04.06.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:03:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 79FE261D4B;
 Fri, 04 Sep 2026 13:46:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
Subject: [PULL 076/105] tests/tcg/ppc64: user tests
Date: Fri,  4 Sep 2026 13:45:30 +0100
Message-ID: <20260904124604.2207440-77-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Message-ID: <20260827221506.91574-77-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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
2.47.3


