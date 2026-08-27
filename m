Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D70CC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziVz-0004nA-Q9; Thu, 27 Aug 2026 18:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVs-0004JY-1q
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:24:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVp-0000FS-FT
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:59 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLpOF779228
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ckshVDk5gaa
 jI8YhxWcMEeFXmbjZB7uEPi6KziDY8QI=; b=lglI0G0ih7lqxheFuTaSPbyBEtb
 74kP2kp6fE1n2ElR1B0DK9u5wBHhxAZ1zUM9u9a2aWr3B5cnQZCkCVhLleSmoubd
 yccDYNIWzJMpEaqz6dKhWiNVQnBmXvOzkL8mm6kj2AC7qUSvH56lZia8wlFb48Ek
 Mrkvc1Onh5SzcYp8PARK0qzKtyD435OovrOxAFNjmyDj7fuuGZhyLiMBCHJY9YwD
 /g3bygC5euIK/wXd36EbjsA5uNfycFJOFZWcdLTucqqmiAu+neXbktalse/AV74D
 SaBPgNcGAuhz6YlaqukNUZ6Bk2qb4HZGT9al9fcFX+QKOpnJhVGb5p5Jrpg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garee1r6y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:46 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cc640dfde3so3649425ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869425; x=1788474225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ckshVDk5gaajI8YhxWcMEeFXmbjZB7uEPi6KziDY8QI=;
 b=AoiKGQcAXhUME4phYrT1rQNZ5jDUC28otOwixbWmNKMDJR/EpHQ0mBHGjVY7C27iaV
 bY3m1Uv+lAOvft1K9cJE7LKJ+bZbpg5cWFm52p+54yhC2WelTYoF9JEE8Yc7TGiBaFdb
 rmVm0TYdTrtcAVEZ2aP+vKCBQ1SZcsJ38TEoWCPR6nt9f1bQ+vjfyXiGMDU+2H0AU1BE
 J4VwJO6AcIZGBBVJlH+/qLQAYlvgk0w683rJyt5QIWdZuPjGxSZqObRbQDNU3MDT10uK
 TjTtarz4q3SpNpM3AlWGevG269pq/glaFvgeF6j3UrVgdy6aKerge9LV/BUAsJmPt9sw
 +7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869425; x=1788474225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ckshVDk5gaajI8YhxWcMEeFXmbjZB7uEPi6KziDY8QI=;
 b=OZWIDu+SsBzBCYgQeo5IGe85qCpTuZ1T6Sd66MNA/y/z9L2SdUQUHA5yfkj7BNttGz
 4U4TJVkVnuRD5AJt95h8C2tJdAHBDT2k2t+L/sWn4nUMYIsk/JrQNilfgkbRfEQXnEH/
 tX+a6VI+a7EN9Z+M90w97/d3sg32FLV7MLLir/ODC4MeBGeTM8V+O5IiROVZOxzIUaJx
 PbBamd+idMCvNnXuun484fdTg5BAxBTrtZdGWXcnYNqMJg7shCxc+JaDyabjfibJkOE1
 wpjphWRu7t5rhN34WohjGvjAJFpQp2sMqQ5hT67PYzjFyIktkAeXK2nBlbjEwVY0HzQ1
 AXrw==
X-Gm-Message-State: AFuF++ko/8nuhB5YyEcWoI7HcI2451gvlzwFDxFJ1ZwKptqlrtNjPqW5
 Dz7TQdZudV0TO183bnxYI3Ca3HlxbYSNqD0M03+mBEfsmbV9xKWPR1YxDae9nCuw+buXPKu88nQ
 RP/b0gt6ja7d2/EZmJZBx/GsarK+jTUMCz92irOHOhS9VnklKEnmVjahr12lHAEnPEQ==
X-Gm-Gg: AR+sD12B3N7r4JJewhZ0CekkDRTxBrmmA66KbitD/iK8yv4Vc6TUgpRraw95mwGrhM2
 qSaA82pYZH0HNGB6lc0eqqI1r4MA4Yfn3saGn+TBM1q16bTubYpCg+zcSj4RSPbLUI09t5qQsU3
 t3UIM2AjzPgybAlzGyQylmxPORSC1S3n4MkwlXGAu++8JrrCYIBIOJkxj0w5cZOITJUzr7Bcd8/
 qyEEP07hv9upcYF5wNZaLudmH9oHHCY3JSyE4UhcvosFFEd7czxWatdYSrLG6pGOSnIJk4fF77q
 PNb4J9wlwM5qzp/OrGW7KeBfOh4v7lKKBi/m51Z0WDfcTlqXnCThYLg61TIBd3r2NKRH5sfyBYp
 554JPJe4YoQtSkpB0YmdXdaZgAnzTtelRQDQz4AAMAKRFZLfUl+B9rfx4CKg=
X-Received: by 2002:a17:903:2f8b:b0:2d3:160b:c01f with SMTP id
 d9443c01a7336-2d74ddd684cmr36431055ad.6.1787869425334; 
 Thu, 27 Aug 2026 15:23:45 -0700 (PDT)
X-Received: by 2002:a17:903:2f8b:b0:2d3:160b:c01f with SMTP id
 d9443c01a7336-2d74ddd684cmr36430285ad.6.1787869424860; 
 Thu, 27 Aug 2026 15:23:44 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d70493f729sm20776155ad.2.2026.08.27.15.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:23:44 -0700 (PDT)
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
Subject: [PATCH v8 095/105] tests/tcg/xtensa: system tests
Date: Thu, 27 Aug 2026 22:14:56 +0000
Message-ID: <20260827221506.91574-96-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX6POrV4nhFg1c
 Qns2CMesfy5Rxt00HlxfjI3bCN56bDSvV+sOJTysnS94IghxzO7CKzVCd52WZJ2nbaZrxFLD0qB
 hekWL+/gW7QrchB9vMwapMRyZisxFLF6qOpoDwjfg9ATp9A71NQEZSQ5cr/qr7kaGRM8DtZf7ux
 dlCF1/KdJ3xRh9E3F4BQnbBFyyddtReTQsRej+1ahUdsxF0q7lEW7xnxgADRGel7Zj7z0MytgsJ
 4Ai2b2MsqAH2jLVqa30yHbJXdP6/tEdd7s9SuNgU2O7Ie4s+0Dorvaq4XHNo5LFORFzBzKC8jlQ
 eMtng2seCU4rkOK3maa8+B2QO/05T0cmRLFmCXk7UAgsd6tKajb8sh+eRQzKshhWdgJHa7KLI4T
 ewR9onYnLsNVNlFHIb6jBjycIwdllrriaEm43vxc3Ukvqd2zQqLWa1gM7d17+ZRk4w2aTNzeCQC
 rKUpNbEAyudCtCTL46g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX3q1GjArdQMkc
 qX80xePt61nvVgqsMmag0Sja4BdqfDsc+of/MDk3F10HgOpdV6KZ2nG7HkBihx9hMbqQRKHlUVh
 kFr6OfBKaqF4p8+5sz5liJAMwY1C0gw=
X-Proofpoint-ORIG-GUID: 9TQYFp85fWlQpsQbB2XArCexb8b_kj9U
X-Proofpoint-GUID: 9TQYFp85fWlQpsQbB2XArCexb8b_kj9U
X-Authority-Analysis: v=2.4 cv=e8E2j6p/ c=1 sm=1 tr=0 ts=6a90b8f2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=R9K0oc9ZdQARYiJKlRgA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
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

We prepare structure to be able to test multiple cores.

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build                      |  1 +
 tests/tcg/xtensa/Makefile.softmmu-target   | 46 -----------
 tests/tcg/xtensa/meson.build               | 96 ++++++++++++++++++++++
 tests/tcg/xtensaeb/Makefile.softmmu-target |  2 +-
 4 files changed, 98 insertions(+), 47 deletions(-)
 delete mode 100644 tests/tcg/xtensa/Makefile.softmmu-target
 create mode 100644 tests/tcg/xtensa/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 163e0a96753..76f8f3e6e02 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -156,6 +156,7 @@ subdir('s390x')
 subdir('sh4')
 subdir('tricore')
 subdir('x86_64')
+subdir('xtensa')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/xtensa/Makefile.softmmu-target b/tests/tcg/xtensa/Makefile.softmmu-target
deleted file mode 100644
index a29571b367c..00000000000
--- a/tests/tcg/xtensa/Makefile.softmmu-target
+++ /dev/null
@@ -1,46 +0,0 @@
-#
-# Xtensa system tests
-#
-
-CORE=dc232b
-ifneq ($(shell $(QEMU) -cpu help | grep -w $(CORE)),)
-
-XTENSA_SRC = $(SRC_PATH)/tests/tcg/xtensa
-XTENSA_ALL = $(filter-out $(XTENSA_SRC)/linker.ld.S,$(wildcard $(XTENSA_SRC)/*.S))
-XTENSA_TESTS = $(patsubst $(XTENSA_SRC)/%.S, %, $(XTENSA_ALL))
-# Filter out common blobs and broken tests
-XTENSA_BROKEN_TESTS  = crt vectors
-XTENSA_USABLE_TESTS = $(filter-out $(XTENSA_BROKEN_TESTS), $(XTENSA_TESTS))
-
-# add to the list of tests
-TESTS += $(XTENSA_USABLE_TESTS)
-VPATH += $(XTENSA_SRC)
-
-QEMU_OPTS+=-M sim -cpu $(CORE) -nographic -semihosting -icount 6 $(EXTFLAGS) -kernel
-
-INCLUDE_DIRS = $(SRC_PATH)/target/xtensa/core-$(CORE)
-XTENSA_INC = $(addprefix -I,$(INCLUDE_DIRS))
-
-vectors_ASFLAGS = -mtext-section-literals
-ASFLAGS = -Wa,--no-absolute-literals
-LDFLAGS = -Tlinker.ld -nostartfiles -nostdlib
-
-CRT        = crt.o vectors.o
-CLEANFILES += linker.ld
-
-linker.ld: linker.ld.S
-	$(CC) $(XTENSA_INC) -E -P $< -o $@
-
-$(XTENSA_USABLE_TESTS): linker.ld macros.inc $(CRT) Makefile.softmmu-target
-
-# special rule for common blobs
-%.o: %.S
-	$(CC) $(XTENSA_INC) $($*_ASFLAGS) $(ASFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
-
-%: %.S
-	$(CC) $(XTENSA_INC) $(ASFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) $(NOSTDFLAGS) $(CRT)
-
-endif
-
-# We don't currently support the multiarch system tests
-undefine MULTIARCH_TESTS
diff --git a/tests/tcg/xtensa/meson.build b/tests/tcg/xtensa/meson.build
new file mode 100644
index 00000000000..339a9a1294e
--- /dev/null
+++ b/tests/tcg/xtensa/meson.build
@@ -0,0 +1,96 @@
+tests_per_core = {}
+cores = ['dc232b']
+
+foreach core: cores
+  tests = []
+  core_dir = meson.project_source_root() / 'target' / 'xtensa' / 'core-' + core
+  link_script_src = files('linker.ld.S')[0]
+  link_script = custom_target('xtensa_linker.ld.' + core,
+    command: [meson.get_compiler('c').cmd_array(),
+              '-E', '-P', '-I', core_dir,
+              '@INPUT@',
+              '-o', '@OUTPUT@'],
+    input: link_script_src,
+    output: 'xtensa_linker.ld' + core,
+  )
+  crt = files('crt.S')[0]
+  vectors = files('vectors.S')[0]
+  cflags = ['-nostdlib',
+            '-nostartfiles',
+            '-mtext-section-literals',
+            crt, vectors,
+            '-I', core_dir,
+            '-Wa,--no-absolute-literals',
+            '-Wl,-T', link_script,
+            '-lgcc']
+  qemu_args = ['-M', 'sim', '-cpu', core,
+               '-nographic',
+               '-semihosting',
+               '-kernel']
+  setup = {'cflags': cflags, 'qemu_args': qemu_args}
+
+  # Multi arch tests are not supported
+  # tests += tcg_tests['multiarch-softmmu']['tests']
+
+  tests += {
+    'test_b.S': setup,
+    'test_bi.S': setup,
+    'test_boolean.S': setup,
+    'test_break.S': setup,
+    'test_bz.S': setup,
+    'test_cache.S': setup,
+    'test_clamps.S': setup,
+    'test_dfp0_arith.S': setup,
+    'test_exclusive.S': setup,
+    'test_extui.S': setup,
+    'test_flix.S': setup,
+    'test_fp0_arith.S': setup,
+    'test_fp0_conv.S': setup,
+    'test_fp0_div.S': setup,
+    'test_fp0_sqrt.S': setup,
+    'test_fp1.S': setup,
+    'test_fp_cpenable.S': setup,
+    'test_interrupt.S': setup,
+    'test_load_store.S': setup,
+    'test_loop.S': setup,
+    'test_lsc.S': setup,
+    'test_mac16.S': setup,
+    'test_max.S': setup,
+    'test_min.S': setup,
+    'test_mmu.S': setup,
+    'test_mul16.S': setup,
+    'test_mul32.S': setup,
+    'test_nsa.S': setup,
+    'test_phys_mem.S': setup,
+    'test_quo.S': setup,
+    'test_rem.S': setup,
+    'test_rst0.S': setup,
+    'test_s32c1i.S': setup,
+    'test_sar.S': setup,
+    'test_sext.S': setup,
+    'test_shift.S': setup,
+    'test_sr.S': setup,
+    # test_timer is time sensitive, use icount to control time
+    'test_timer.S': setup + {'qemu_args': ['-icount', '8'] + qemu_args},
+    'test_windowed.S': setup,
+  }
+
+  tests_per_core += {core: tests}
+endforeach
+
+cc_dockerfile = 'debian-xtensa-cross'
+cc_docker_host_arch = ['x86_64']
+
+if 'qemu-system-xtensa' in emulators
+  tcg_tests += {
+    'xtensa-softmmu': {
+      'cc': 'xtensa-dc232b-elf-gcc',
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'xtensa',
+      'gdb_arch': 'xtensa',
+      'qemu': emulators['qemu-system-xtensa'],
+      'tests': tests_per_core['dc232b'],
+    }
+  }
+endif
diff --git a/tests/tcg/xtensaeb/Makefile.softmmu-target b/tests/tcg/xtensaeb/Makefile.softmmu-target
index 95d0528c372..3df131acea7 100644
--- a/tests/tcg/xtensaeb/Makefile.softmmu-target
+++ b/tests/tcg/xtensaeb/Makefile.softmmu-target
@@ -2,4 +2,4 @@
 # Xtensa system tests
 #
 
-include $(SRC_PATH)/tests/tcg/xtensa/Makefile.softmmu-target
+#include $(SRC_PATH)/tests/tcg/xtensa/Makefile.softmmu-target
-- 
2.43.0


