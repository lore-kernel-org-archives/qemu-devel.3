Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13858C54F52
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZoq-0006hU-FI; Tue, 28 Jul 2026 00:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZo9-0006HU-D6
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZo7-0002Yc-88
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:49 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3ai6r1715002
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rEgdQtZBbrN
 DdmEhN9NgXHptEOcSKQXU4k5dis3iHq4=; b=L7CxfGb+TVsVb9iGP4ADovOT77k
 4YwnU7RiWHRxbnOb9uzX62yP/SZHygy66H1mvFrMue4/wYC1UzlzZxdeQEda4ktO
 vzWqZR9lH8FHjGX04adDrhkNTAbEYML45UB/F6WgAcv1MemoL+JwC/QWNxYGUXpd
 VnXepIvC6/WK+7pt74sPeB8giTo2kPI/VLIjlB0kM1wQWxWUg0+s9oyGSd3gRsqz
 KbebP1vQOfoebz9OJpfN0DwjxJRVukkykbynKP8wgWBLyV57zikWL+C/KU50u93G
 JBcrpGmtCBP4URzSQ/B9Kuck41BrtKARExo+Tyon6sxStTRZQayAOM/K6oQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpadkk01n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:45 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca6bd8a190cso4853650a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214365; x=1785819165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rEgdQtZBbrNDdmEhN9NgXHptEOcSKQXU4k5dis3iHq4=;
 b=MoCW1IEpRKVYGdCXAQztZIIEuihmn7YJk4d5UUZsDMVRYjYQ4+by03kH0VoUYy4pAc
 n6w4fMPDxKT1d9LnsqDN51CCdgoEMxX2eSoyri3Js1Xkm57qLth91SXTzOrA5HdZIZkI
 yO1iCzUyEU+nSiaKJ/rMIwidAmtPvEQv/7Z3GWYGArsorXibuFdfZuZogeBzff8Xua66
 QjDGJBuU1QZl+UmnxORUebDS6UW/syFr9S2DiRPqDz0yyrhPoxwA3Fc/EbQQdgcqI12C
 Q24G64bOukhKCV/20gYBU4kDJ9KGg9u6K2L1sTQSIF37FHM7ktkIr1TGQD8oRSRIXAe8
 Il+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214365; x=1785819165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rEgdQtZBbrNDdmEhN9NgXHptEOcSKQXU4k5dis3iHq4=;
 b=qIkwMXSXSQcG5w+aAvPGgzslGijIjdoS/oBtAdMTYhWk6G4akLF1Qhy5zyMw+SMns+
 VeVykcMwL3tr77A+kgNNw8KT4SFSQaCGYPr6U2NBQVapT605bP+B+gQb94XvfsrvmT0d
 aZYtHhk7/Qwn5oOsgT8XcqVu5+AgcJDXjzSjoYt+ZKBPNOcxpchg0Lz+Rl49aEYhxDZG
 29T3lZOW8GmnILPRHojJrKW8txjRKorCi7zIVSYY/DGsxTGuTEQrN3xWJV4D4PL5cqGZ
 uz9A7V7spOMD21KxGiJR2OB3yvgq+c9ztBpfoPjqVaUrJg0o/50jpy+QDelNseGQlJsd
 tmsQ==
X-Gm-Message-State: AOJu0YzNprFzN3ImRhZTF4c4le1ROVpX7pCKn5RMLx43jZDFEMEtR28C
 IRd3gB/CRKv0aXUDszmcIexqD1AZd3YV+S/7mv0dQOVRIJ5ziKWcN6SWugAVxvQj8GZKTqi6fq+
 +c5ZeMwy6me+uYtUqmxfPRvtF7tKrUcu2TTFsQZ46oIghfwu9IbtDF3bHIiVaxMju8Q==
X-Gm-Gg: AR+sD131tQN4FhHtk5fy6RonhZ86UoXuy4mmftgn6y9myzeKywgUwP6hz4JcLb8ZP8V
 tBOBADqTblmBiSY0G/ZWrdLDys6GnSLHjYxUXnHsyS2T1ukMX0q5fNHgpeJmqogax4QTMXAkJJZ
 hdhzfU6M4qe0lveq34PRKpKZw2hl2hvoXpnPZSUQq+gDlxYDvfOZLw6er8INMbEAIOSFDcSCrMa
 jeYtnADdQkHEqQ7xWJrcQAKL2dg2O8azbnxwxy6XTJTXfHX0rQngqC27a95Qpi++/ynWmCp1F8J
 R2w/ZbQGtyRnpFjabnAcXTWXeWCY5oBLZMZ86r1wg7gx3M6Oubg5qInNQbVTUsS1oTW38hAKdWr
 qbB37JI5RXZVCPloIep7Le1SCkjlzPfANkkCnLTj88Ka0fFS8BXiaZZWM618xTLymaOeW8Ko=
X-Received: by 2002:a05:6300:670e:b0:3c3:a3f4:5485 with SMTP id
 adf61e73a8af0-3c8aafa3350mr1064124637.6.1785214365309; 
 Mon, 27 Jul 2026 21:52:45 -0700 (PDT)
X-Received: by 2002:a05:6300:670e:b0:3c3:a3f4:5485 with SMTP id
 adf61e73a8af0-3c8aafa3350mr1064099637.6.1785214364789; 
 Mon, 27 Jul 2026 21:52:44 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38900559eec.3.2026.07.27.21.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:52:44 -0700 (PDT)
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
Subject: [PATCH v6 094/103] tests/tcg/xtensa: system tests
Date: Mon, 27 Jul 2026 21:42:38 -0700
Message-ID: <20260728044248.137626-95-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ElwPXhCVI9ZER4SVuve108t8qZHuuaWX
X-Proofpoint-GUID: ElwPXhCVI9ZER4SVuve108t8qZHuuaWX
X-Authority-Analysis: v=2.4 cv=Ns7htcdJ c=1 sm=1 tr=0 ts=6a68359d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=g8Azq2kgbW9PJrE6qJUA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX/CA8tmgk41V7
 Q9cUQRfPlxV5QgAptg+hzpIblJLdSf9WA6dXD30WiI7nIOkbQB86tq7ma/SDPgYFI3bGOlNKCud
 3agWy9+MFtUdyKN1tSVMsR/O+67iyWnwtXEGgx7E1vSHlOCBxpYJkvfPAvkJdA12x6zO0YifGUd
 Ysu596Hzz0T3A+CgFRh63SQMHAVu33TAJ9FLQx5WmI+rTD3Sg3nhjMhReoviLFcEJw/JG6pMfeo
 iUZtOemdhfThsH5v5KUVPxqCrDSPKVe05nV1BToI+gYvcKYIr37e2pixd+St8I06np70YKjLCe7
 9yA/lbh3mk8ZE18vjkDN9QwOI3uNuqthq0ira/ys+5yxJ26ZttK50AZUyzXsKVzjVrSnOAtpF0J
 07E+G3cdnY82gyd/oGU1W5A/n0RVzX1IydwvScNRHPrUeRs+ho94YoL69KQ7SU9ymDUcA+phxZG
 RuMJ2Ale5G/LdvY0yyQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX21bkWTR41h0J
 xk2ujOlF4NIU6xrq7kQgvcsXV4d+C0k/KWIUmVpEE/6341NeFoX9S7j2zcZkVNOqNKe78XPQ+b5
 lvGu20agCvyzRsNDbp0gNT+SiV4bCG4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280042
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
index ba79c015557..88b2a6337bb 100644
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
index 00000000000..7c3c4f7cd62
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
+               '-display', 'none',
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
2.47.3


