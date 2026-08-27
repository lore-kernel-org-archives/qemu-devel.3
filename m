Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21736C61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziVX-0003DU-Cw; Thu, 27 Aug 2026 18:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVV-0003A0-Gj
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVT-0000By-Em
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:37 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLclF1358479
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+bvhWdkebx3
 eMmgv9UTgjx8WC3xGIg7vDT+DzHJURLM=; b=HBlZh2HcSrQlWZdrmDDj2jTdNZn
 MssB08hNn+Tc5avZOMjba8x+fEp5UcI0kJ2Q85OZLukRAqe1q1oB8RxrN5/Wb5tq
 Ucu6ZhIuxzkIc4EyzuPUC2BiYomZgGKsCfqZEOswJpX8RJKRwla9Hdg9Kx4X+CqD
 IH6rp3BzIPegBQsJGG3BBVAWVGLNgFxYWlasaIxstYjaVU6Nx0vt6P9CdYzmEpR2
 qjrtK63Os+2kNsQ9w5ZFbgL4J83M78Jl7/d1kOBwNp6TjhxUlKRKlM5ZOLv6IChw
 tIsMXNP9aATCnA8LoYjOKwwkFUCaRZb7kwD269lFNcFBSgYvDhtjECq99wg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gapgvaane-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:33 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc6dd43737so6357265ad.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869413; x=1788474213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+bvhWdkebx3eMmgv9UTgjx8WC3xGIg7vDT+DzHJURLM=;
 b=DqvHgrutkEwnChlflWORKgY79rE/E6iL88v23fBx1042ahLPbB6u8/6k9/KL8Q7EmN
 b81/dtvy2Hz91pEmIKD4ETo3s+tpS03O1LhdGGggVWzpMmTp389rkPVLtiaqQ7yOVDca
 VQQLmKqYiJJN2ZLwlzhz5BAMzU/+jw/+Whj44DKC4bjeeBxVVRwCTv/GoOIiIJrk+5VE
 5OlgRb0k6Y9cbt2k890G04cj05CfGWbEMpfQkEx1nEfu3oxsoApDIWA9xPmYHNDIrM+N
 0WORUhtItPswSk7s9gpWXuRrYpU3EobDvhSTov51sD3Pp5JGp5uM6cQbwciFlohSRRiL
 xsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869413; x=1788474213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+bvhWdkebx3eMmgv9UTgjx8WC3xGIg7vDT+DzHJURLM=;
 b=Xgo3PfJNgar5XZtgqHDpjcyvXda8Y6ozLJ6xsZL0gQc69p6gOGR/BzbkHVIQMZeR1o
 ct6GkQ+9AwSYk7f04LZGx11+Nf3NSRwKy70X3bTD1W6ow4AR/nbOuyDnOnr1U9op/uPZ
 KhaYk4Q4oUQJ8l4w+4L761WG3pVK0ZqkwQu4aoMNxqrMzxWrkL2Aq2yKzJDAbS3zfTMe
 Jy/JmiUUy2UzjFdyXipusksDwZaBVQf7wApWUNbOmV1JkLYlOXyk2YAPnOxeQ7F9HCm5
 YS6qwzBvBoxxYreasfQBq86i46y9t6t22MO7imtenMzU6aIRrcB/5ewJOPUL6DmaRHRE
 +5bA==
X-Gm-Message-State: AFuF++mNKdZoOKQQ0lsHMX7FLi5euW8pukWkFdhUK6y2OHkHb+LU4hwy
 bPXMGa+27NSJuhxrgPn3gOJo0Si8i2zy/vUWBbaOF875DkAQB6QnP19EpR9GhZC1e7EyPOhlgl+
 nDb15frO8iz6ZwgI1x2Ot1P2T0FVNPvIKcXltAfXBTJ5iMJGONg8GblB/ydwhlhKegg==
X-Gm-Gg: AR+sD13e3B4TDgE69p30BVern1oRQX5VW5OSFyjIKGJM7VcaorPvFdffyiAd0NZld6w
 gTbPoUuctBLYaRH//czn7TWVj3PcbvKGToM9tDNYpAHHCB15VWkJKV2yplxDFJ6jXixbU7jW+uw
 gnsERRpXdhoqf5YrIvDLs+IogHrTJV71KlAp00G6JoBbYIM+wAkLkQpMa6ESSsU0T2zXx32wsLk
 tVMveW94/eeEx2wTKs/KBEjSBAC6CQIcmTpiE0kHQQ94ipQGUteaAShpL61kuXh09k7D7qj3Xy9
 1T7pxlH/mJLrJMt6qMVSCeEEfdgrTZ3dBUKxjUbxBd8K6hYe6jSlTLEQ48xBfRtkDQZKOU+gmVg
 pmu/P90OK/ZHG8cu3wd8PZCxCVVntIt/oWyyEAJjx8qPoJ3To+G6/rVPf4CI=
X-Received: by 2002:a17:903:22ca:b0:2d6:fd55:3a9d with SMTP id
 d9443c01a7336-2d74dc111bcmr35128925ad.3.1787869413310; 
 Thu, 27 Aug 2026 15:23:33 -0700 (PDT)
X-Received: by 2002:a17:903:22ca:b0:2d6:fd55:3a9d with SMTP id
 d9443c01a7336-2d74dc111bcmr35128345ad.3.1787869412870; 
 Thu, 27 Aug 2026 15:23:32 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d70493f729sm20776155ad.2.2026.08.27.15.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:23:32 -0700 (PDT)
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
Subject: [PATCH v8 089/105] tests/tcg/tricore: system tests
Date: Thu, 27 Aug 2026 22:14:50 +0000
Message-ID: <20260827221506.91574-90-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cObhA-g5QbtG0HXEbV6Bc94FaqZcdJ9C
X-Proofpoint-GUID: cObhA-g5QbtG0HXEbV6Bc94FaqZcdJ9C
X-Authority-Analysis: v=2.4 cv=FpU1OWrq c=1 sm=1 tr=0 ts=6a90b8e5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=4feyZHKGdxcD__gy_rYA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX7PT37yFX5rcy
 azl9X7XpfXwvBOInq4JhuEV5XtEmy0o7OyjoHmu7LAOm5UrmRePeltyJxQ/oJ2peDfD7AbcbU3M
 8NgX574YYZsNN/8WIRhJG4rAaZHpfoMUto06MGxJyViouDF9oMW4AWi3UI5qzabXRKXBnACUMzR
 qksZliubCcWOckMMKU97FlenFba8y82eyIFHciv1gYn4l/Lrq9yhcYI0lr6kIb3atY9fq5TtEh6
 E9R17z5/hUIzAkEitGdjxXAILUSlr6X9bmqhHULp3+QCqztmUi0Slk3V015NK7V3mDeT9+WLbKL
 bH0VOlbMvg77wRIKo6Nu/sG5aWASWwNqypzUZff5eftLgeYunTAwC3+8YAqWMhZlg4e+7VQHPFM
 /DtgiauRcFi13CqjcdTGxXFDmU8N7N7Ti7VlsqVYvgdfAyEan0rx+dmAfZXck8smi3Xd3oGPSqv
 C87ejA5ddtbacnR2LJA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX4YPsK/R5XkHa
 hi0c4OJ6QA8DB8XQ0pd/mDMRmEAobRCWSe8v0znndepltoCGQ0eBnGNNe+Pb1PjW5Hcx0HJsFqh
 FNUGwWx0JLQ+9Sny+GFaO3HSpAddjGE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270190
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
 tests/tcg/meson.build                     |  1 +
 tests/tcg/tricore/Makefile.softmmu-target | 53 ---------------------
 tests/tcg/tricore/meson.build             | 57 +++++++++++++++++++++++
 3 files changed, 58 insertions(+), 53 deletions(-)
 delete mode 100644 tests/tcg/tricore/Makefile.softmmu-target
 create mode 100644 tests/tcg/tricore/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 1c34b8e63c6..4903947a636 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -154,6 +154,7 @@ subdir('ppc64le')
 subdir('riscv64')
 subdir('s390x')
 subdir('sh4')
+subdir('tricore')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/tricore/Makefile.softmmu-target b/tests/tcg/tricore/Makefile.softmmu-target
deleted file mode 100644
index 258aeb40ae8..00000000000
--- a/tests/tcg/tricore/Makefile.softmmu-target
+++ /dev/null
@@ -1,53 +0,0 @@
-TESTS_PATH = $(SRC_PATH)/tests/tcg/tricore
-ASM_TESTS_PATH = $(TESTS_PATH)/asm
-C_TESTS_PATH = $(TESTS_PATH)/c
-
-LDFLAGS = -T$(TESTS_PATH)/link.ld --mcpu=tc162
-ASFLAGS = -mtc162
-CFLAGS = -mtc162 -c -I$(TESTS_PATH)
-
-TESTS += test_abs.asm.tst
-TESTS += test_bmerge.asm.tst
-TESTS += test_clz.asm.tst
-TESTS += test_crcn.asm.tst
-TESTS += test_dextr.asm.tst
-TESTS += test_dvstep.asm.tst
-TESTS += test_fadd.asm.tst
-TESTS += test_fmul.asm.tst
-TESTS += test_ftohp.asm.tst
-TESTS += test_ftoi.asm.tst
-TESTS += test_ftou.asm.tst
-TESTS += test_hptof.asm.tst
-TESTS += test_imask.asm.tst
-TESTS += test_insert.asm.tst
-TESTS += test_ld_bu.asm.tst
-TESTS += test_ld_h.asm.tst
-TESTS += test_madd.asm.tst
-TESTS += test_msub.asm.tst
-TESTS += test_muls.asm.tst
-
-TESTS += test_boot_to_main.c.tst
-TESTS += test_context_save_areas.c.tst
-
-QEMU_OPTS += -M tricore_testboard -cpu tc37x -nographic -kernel
-
-%.pS: $(ASM_TESTS_PATH)/%.S
-	$(CC) -E -o $@ $<
-
-%.o: %.pS
-	$(AS) $(ASFLAGS) -o $@ $<
-
-%.asm.tst: %.o
-	$(LD) $(LDFLAGS) $< -o $@
-
-crt0-tc2x.o: $(C_TESTS_PATH)/crt0-tc2x.S
-	$(AS) $(ASFLAGS) -o $@ $<
-
-%.o: $(C_TESTS_PATH)/%.c
-	$(CC) $(CFLAGS) -o $@ $<
-
-%.c.tst: %.o crt0-tc2x.o
-	$(LD) $(LDFLAGS) -o $@ $^
-
-# We don't currently support the multiarch system tests
-undefine MULTIARCH_TESTS
diff --git a/tests/tcg/tricore/meson.build b/tests/tcg/tricore/meson.build
new file mode 100644
index 00000000000..d0bf55dedce
--- /dev/null
+++ b/tests/tcg/tricore/meson.build
@@ -0,0 +1,57 @@
+tests = []
+
+link_script = files('link.ld')[0]
+crt0 = files('c'/'crt0-tc2x.S')
+asmflags = ['-Wl,--mcpu=tc162',
+            '-Wl,-T', link_script,
+            '-mtc162',
+            '-nostartfiles']
+cflags = [asmflags, crt0]
+qemu_args = ['-display', 'none',
+             '-M', 'tricore_testboard',
+             '-cpu', 'tc37x',
+             '-kernel']
+
+# Multi arch tests are not supported
+# tests += tcg_tests['multiarch-softmmu']['tests']
+
+setup_asm = {'cflags': asmflags, 'qemu_args': qemu_args}
+setup_c = {'cflags': cflags, 'qemu_args': qemu_args}
+
+tests += {
+  'asm/test_abs.S': setup_asm,
+  'asm/test_bmerge.S': setup_asm,
+  'asm/test_clz.S': setup_asm,
+  'asm/test_crcn.S': setup_asm,
+  'asm/test_dextr.S': setup_asm,
+  'asm/test_dvstep.S': setup_asm,
+  'asm/test_fadd.S': setup_asm,
+  'asm/test_fmul.S': setup_asm,
+  'asm/test_ftohp.S': setup_asm,
+  'asm/test_ftoi.S': setup_asm,
+  'asm/test_ftou.S': setup_asm,
+  'asm/test_hptof.S': setup_asm,
+  'asm/test_imask.S': setup_asm,
+  'asm/test_insert.S': setup_asm,
+  'asm/test_ld_bu.S': setup_asm,
+  'asm/test_ld_h.S': setup_asm,
+  'asm/test_madd.S': setup_asm,
+  'asm/test_msub.S': setup_asm,
+  'asm/test_muls.S': setup_asm,
+  'c/test_boot_to_main.c': setup_c,
+  'c/test_context_save_areas.c': setup_c,
+}
+
+if 'qemu-system-tricore' in emulators
+  tcg_tests += {
+    'tricore-softmmu': {
+      'cc': 'tricore-gcc',
+      'cc_dockerfile': 'debian-tricore-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'folder': 'tricore',
+      'gdb_arch': 'tricore',
+      'qemu': emulators['qemu-system-tricore'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.43.0


