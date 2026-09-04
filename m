Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19856C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TQE-0001bA-1B; Fri, 04 Sep 2026 08:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQA-0001Ys-LF
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:30 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQ8-0000eb-Cs
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:30 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-482e4998d28so706270f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526407; x=1789131207; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zf7fGwfw3SJ42pxAXUZwss0DZND93n/SNZvyCRo8fZw=;
 b=U65uPL/M5V+lez1Zp+wAfnsDbzeSZ6jyg1UCjCXaVVRq20kyDDsF0Ck4bYiAFFnU46
 adQKIxQKxEuxhnOnncG4YCcEUfymnwfvVnqRWIU+9nY9R1VW6nE7efkPdZM5+r5fq7LB
 jKcqI7VFc2Gp3gTQezMAdf+Iz3sgPJnU0FbeyuDGIN5f7dmROCS2wwQHpi10x/W4OyFy
 k+Wrw+MajncyFMfSDPLu0nP+jQQg0BMCeIpmtTJDXzhqkpas2p6cyFICzE6iSUUCcnNz
 Q0AL9sV/KDPmgNi0ZSobSrVPXTEMK3bwbHnhOaM6K3QMV3RY9uYTQXQKYDgwMH0w7qsU
 D2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526407; x=1789131207;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zf7fGwfw3SJ42pxAXUZwss0DZND93n/SNZvyCRo8fZw=;
 b=B+mRqK8XWaHGuRrNyISOyfd8e0eratF8YaglkvnNBYP8V6lJY434nlgWpeKTOPBu8J
 eCdHYxKWLxcVw+79BurvmWSlVNUS+124u/gptffFUOIyBAUYzgpzRoqh8YKK0hm5kQNV
 crsoNaxnG+rkaRDeMXZYSzMu5Y7fmzwXgkrbwhHk3CZ00nW1wBfxq4AwN1JYgZCBtbGz
 cCeN2XSvIoc9PegYNWblYtSLCRm1xTVmHg7wjCrAePZMwY5IER8+l4csmKPgcuLGw293
 jNFEYuQ2kNzYTsQKXNHUSRIs2/H/x3lI3ba9tK/luZFYOFzV0EhboOdBwTQvzrRU6AJD
 tPuw==
X-Gm-Message-State: AFuF++mfz1h0695WXXcDBM5roj3vRLbRbzRDg4feT6DC0vQk/SnFwwN0
 ozOsCp0J72VMt2q+ubq2U8dOM7BOpb8klm+92wzwqC79BeLYmmSlO2YgfJD6QKVJu7U=
X-Gm-Gg: AYBFou1/v4g0T9dclmJCGkGiVyjN9SeGx0yZLMoRA7OA3BKaC4zj/dfTrKGtTCfMQbG
 3NAJZWBmIyINbqvqm4jbO3iL9/k/YfMX0ui97uSua6f5ENI94HsI2ilzGfidQJ1podtYF3i1jch
 Qr9VESzrs9F7mAG15B0I3bi9OGfRmrCaZet+UJRNR2W5uG42jqJro0a+o1HI1GpepgEUO8XiQPd
 ixPXJU3VCDLRBNAD08FrOps0fJ4bz0WqV7r5DqI4sfIY0UYEfvIidU/HF9HhwrHljiiutPlgMFf
 4YYxUpMQ7TyO+1kd/emFlZDNpzq8/BKBt5bTEzbCFT4eAvMkOvjqctk5h3cT6Wn1pILRHVxF+wT
 /ZWk0ISlzIgxoqn6Fy0D7TmkTIWsuTrlaryxX7xTrkmTsmB0ig9QssJzpRvS7RItEdDfNMGgNZ4
 hLQhsTDD1uDF3rSF1G6XCFmTDdmLVDL0W9u7tVZ05Ca1IEjltX0BL3OnBlbIbW
X-Received: by 2002:a05:600d:864a:10b0:49c:fc89:59cb with SMTP id
 5b1f17b1804b1-49cfc8960ccmr23254945e9.5.1788526406851; 
 Fri, 04 Sep 2026 05:53:26 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5941cb4sm89439825e9.4.2026.09.04.05.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:53:23 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5C5E761D76;
 Fri, 04 Sep 2026 13:46:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs)
Subject: [PULL 084/105] tests/tcg/s390x: user tests
Date: Fri,  4 Sep 2026 13:45:38 +0100
Message-ID: <20260904124604.2207440-85-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-85-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 1a48b37f75c..6bc2829ba92 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -152,6 +152,7 @@ subdir('or1k')
 subdir('ppc64')
 subdir('ppc64le')
 subdir('riscv64')
+subdir('s390x')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
deleted file mode 100644
index 97c0f021902..00000000000
--- a/tests/tcg/s390x/Makefile.target
+++ /dev/null
@@ -1,129 +0,0 @@
-S390X_SRC=$(SRC_PATH)/tests/tcg/s390x
-VPATH+=$(S390X_SRC)
-CFLAGS+=-march=zEC12 -m64
-
-%.o: %.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
-
-config-cc.mak: Makefile
-	$(quiet-@)( \
-	    $(call cc-option,-march=z14, CROSS_CC_HAS_Z14); \
-	    $(call cc-option,-march=z15, CROSS_CC_HAS_Z15)) 3> config-cc.mak
--include config-cc.mak
-
-TESTS+=hello-s390x
-TESTS+=csst
-TESTS+=ipm
-TESTS+=exrl-trt
-TESTS+=exrl-trtr
-TESTS+=pack
-TESTS+=mie3-compl
-TESTS+=mie3-mvcrl
-TESTS+=mie3-sel
-TESTS+=mvo
-TESTS+=mvc
-TESTS+=shift
-TESTS+=trap
-TESTS+=signals-s390x
-TESTS+=branch-relative-long
-TESTS+=noexec
-TESTS+=div
-TESTS+=clst
-TESTS+=long-double
-TESTS+=cdsg
-TESTS+=chrl
-TESTS+=rxsbg
-TESTS+=ex-relative-long
-TESTS+=ex-branch
-TESTS+=mxdb
-TESTS+=epsw
-TESTS+=larl
-TESTS+=mdeb
-TESTS+=cgebra
-TESTS+=clgebr
-TESTS+=clc
-TESTS+=laalg
-TESTS+=add-logical-with-carry
-TESTS+=lae
-TESTS+=cvd
-TESTS+=cvb
-TESTS+=ts
-TESTS+=ex-smc
-TESTS+=divide-to-integer
-TESTS+=stckf
-
-cdsg: CFLAGS+=-pthread
-cdsg: LDFLAGS+=-pthread
-
-# The following tests contain inline assembly that requires inlining,
-# and thus cannot be built with -O0.
-rxsbg: CFLAGS+=-O2
-divide-to-integer: CFLAGS+=-O2
-
-cgebra: LDFLAGS+=-lm
-clgebr: LDFLAGS+=-lm
-divide-to-integer: LDFLAGS+=-lm
-
-include $(S390X_SRC)/pgm-specification.mak
-$(PGM_SPECIFICATION_TESTS): pgm-specification-user.o
-$(PGM_SPECIFICATION_TESTS): LDFLAGS+=pgm-specification-user.o
-TESTS += $(PGM_SPECIFICATION_TESTS)
-
-Z13_TESTS=vistr
-Z13_TESTS+=lcbb
-Z13_TESTS+=locfhr
-Z13_TESTS+=vcksm
-Z13_TESTS+=vstl
-Z13_TESTS+=vrep
-Z13_TESTS+=precise-smc-user
-Z13_TESTS+=prno-trng
-$(Z13_TESTS): CFLAGS+=-march=z13 -O2
-TESTS+=$(Z13_TESTS)
-
-ifneq ($(CROSS_CC_HAS_Z14),)
-Z14_TESTS=fma vfminmax
-fma: float.h
-fma: LDFLAGS+=-lm
-vfminmax: LDFLAGS+=-lm
-vfminmax: float.h
-$(Z14_TESTS): CFLAGS+=-march=z14 -O2
-TESTS+=$(Z14_TESTS)
-endif
-
-ifneq ($(CROSS_CC_HAS_Z15),)
-Z15_TESTS=vxeh2_vs
-Z15_TESTS+=vxeh2_vcvt
-Z15_TESTS+=vxeh2_vlstr
-Z15_TESTS+=vxeh2_vstrs
-$(Z15_TESTS): CFLAGS+=-march=z15 -O2
-TESTS+=$(Z15_TESTS)
-endif
-
-ifneq ($(GDB),)
-GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
-
-run-gdbstub-signals-s390x: signals-s390x
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(S390X_SRC)/gdbstub/test-signals-s390x.py, \
-	mixing signals and debugging)
-
-hello-s390x-asm: CFLAGS+=-nostdlib
-
-run-gdbstub-svc: hello-s390x-asm
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(S390X_SRC)/gdbstub/test-svc.py, \
-	single-stepping svc)
-
-EXTRA_RUNS += run-gdbstub-signals-s390x run-gdbstub-svc
-endif
-
-# MVX versions of sha512
-sha512-mvx: CFLAGS=-march=z13 -mvx -O3
-sha512-mvx: sha512.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-TESTS+=sha512-mvx
diff --git a/tests/tcg/s390x/meson.build b/tests/tcg/s390x/meson.build
new file mode 100644
index 00000000000..dcbbb463c43
--- /dev/null
+++ b/tests/tcg/s390x/meson.build
@@ -0,0 +1,140 @@
+cc = 's390x-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+cc_docker_host_arch = ['aarch64', 'x86_64']
+
+cc_feat_cflags = {
+  'z14': '-march=z14',
+  'z15': '-march=z15',
+}
+
+tests_s390x_pgm = [
+  'br-odd.S',
+  'cgrl-unaligned.S',
+  'clrl-unaligned.S',
+  'crl-unaligned.S',
+  'ex-odd.S',
+  'lgrl-unaligned.S',
+  'llgfrl-unaligned.S',
+  'lpswe-unaligned.S',
+  'lrl-unaligned.S',
+  'stgrl-unaligned.S',
+  'strl-unaligned.S',
+]
+
+tests = []
+
+# Multi arch tests
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  # The following tests contain inline assembly that requires inlining,
+  # and thus cannot be built with -O0.
+  'rxsbg.c': {'cflags': ['-O2']},
+  'divide-to-integer.c': {'cflags': ['-O2', '-lm']},
+
+  'hello-s390x.c': {},
+  'hello-s390x-asm.S': {'cflags': ['-nostdlib']},
+  'csst.c': {},
+  'ipm.c': {},
+  'exrl-trt.c': {},
+  'exrl-trtr.c': {},
+  'pack.c': {},
+  'mie3-compl.c': {},
+  'mie3-mvcrl.c': {},
+  'mie3-sel.c': {},
+  'mvo.c': {},
+  'mvc.c': {},
+  'shift.c': {},
+  'trap.c': {},
+  'signals-s390x.c': {},
+  'branch-relative-long.c': {},
+  'noexec.c': {},
+  'div.c': {},
+  'clst.c': {},
+  'long-double.c': {},
+  'cdsg.c': {},
+  'chrl.c': {},
+  'ex-relative-long.c': {},
+  'ex-branch.c': {},
+  'mxdb.c': {},
+  'epsw.c': {},
+  'larl.c': {},
+  'mdeb.c': {},
+  'cgebra.c': {'cflags': ['-lm']},
+  'clgebr.c': {'cflags': ['-lm']},
+  'clc.c': {},
+  'laalg.c': {},
+  'add-logical-with-carry.c': {},
+  'lae.c': {},
+  'cvd.c': {},
+  'cvb.c': {},
+  'stckf.c': {},
+  'ts.c': {},
+  'ex-smc.c': {'cflags': ['-Wl,--no-warn-rwx-segments']},
+}
+
+foreach src: tests_s390x_pgm
+  tests += {
+    src: {'cflags': [files('pgm-specification-user.c'), '-Wa,--noexecstack']}
+  }
+endforeach
+
+setup_z13 = {'cflags': ['-O2', '-march=z13']}
+tests += {
+  'vistr.c': setup_z13,
+  'lcbb.c': setup_z13,
+  'locfhr.c': setup_z13,
+  'vcksm.c': setup_z13,
+  'vstl.c': setup_z13,
+  'vrep.c': setup_z13,
+  'precise-smc-user.c': setup_z13,
+  'prno-trng.c': setup_z13,
+  '../multiarch/sha512.c': {
+    'exe_name': 'sha512-mvx',
+    'cflags': setup_z13['cflags'] + ['-mvx', '-O3'],
+  }
+}
+
+setup_z14 = {
+  'cc_feat': 'z14',
+  'cflags': ['-O2', '-lm', '-Wl,--no-warn-rwx-segments']
+}
+tests += {
+  'fma.c': setup_z14,
+  'vfminmax.c': setup_z14,
+}
+
+setup_z15 = {'cc_feat': 'z15', 'cflags': ['-O2']}
+tests += {
+  'vxeh2_vs.c': setup_z15,
+  'vxeh2_vcvt.c': setup_z15,
+  'vxeh2_vlstr.c': setup_z15,
+  'vxeh2_vstrs.c': setup_z15,
+}
+
+tests += {
+  'signals-s390x.c': {
+    'test_name': 'signals',
+    'gdb_test': ['--test', files('gdbstub/test-signals-s390x.py')],
+  },
+  'hello-s390x-asm.S': {
+    'test_name': 'svc',
+    'gdb_test': ['--test', files('gdbstub/test-svc.py')],
+  },
+}
+
+if 'qemu-s390x' in emulators
+  tcg_tests += {
+    's390x-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 's390x',
+      'gdb_arch': 's390x',
+      'gdb_feat_version': gdb_feat_version,
+      'qemu': emulators['qemu-s390x'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


