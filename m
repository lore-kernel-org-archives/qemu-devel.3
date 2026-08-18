Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D51C5DF88
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPYV-0004DK-1k; Tue, 18 Aug 2026 15:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPYE-0003ob-1a
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPYB-0000LK-OE
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:45 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHHaJl1944551
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ckshVDk5gaa
 jI8YhxWcMEeFXmbjZB7uEPi6KziDY8QI=; b=JmOb0LyeP6LJC+uadkeFFgzVvd8
 3nlvsJkhdmJzkh+BHDczCffRH4sXnUOURg72bOOiAP4uP8p67BHmaJGw0g2GAuzZ
 LwrALKTdHfeHAguCRa0NJjeCOvnPhfN/U+lwpkiyF99VrBBSJlE53yqfGPWaWpr7
 dYw5U6fW1H/oiEhKp8MxUk4K7HHivF4nstCIQSbBw7oZIf+U/e3CsJkgFEr71UGT
 Iz9Lfm9C11kOOoflleYakwImH6fnGgL8IAmyIrZ+LcL9d2JHXVBkc627jJJFQTum
 mEf7juYuweC0xfX6JvB2dePa+U6XQw9EEQjI8bPfXhwLF+HF1Y9axNT2erw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4prn27xm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:42 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38f5ac7354dso342695a91.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081561; x=1787686361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ckshVDk5gaajI8YhxWcMEeFXmbjZB7uEPi6KziDY8QI=;
 b=U/KUFbiqQs5vn7BD+/BVmiT5Fs8MCDw+KOEc5LY2fZwIJt0pY2IElCtS71lCYqbdJF
 pv4Q9HGkXwgPDGuMPVpPbyzjDbL632zyOrRTpS20+OkK/M3r1eHVdPSdZPbGJrArdnXa
 eY/Hys9bjUCxjMOwV6NoCMyXIF4d4e7v7TvB0YgjgwElxPIMXmHuAgZyWATm0jnBitzg
 SME+lSZSgVIGES8apM08k+3yfcv0w/MNCuD+BVU0Ow5mNQVslziCgpZuX+Q6S6wlxqDu
 YX9kQ9h25Hcp0jkMRct0zvFA385m5L+ituoexSTXKwkiMrA+BWn+2L5l589gAG6kmM8w
 NQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081561; x=1787686361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ckshVDk5gaajI8YhxWcMEeFXmbjZB7uEPi6KziDY8QI=;
 b=pyHmBcdOAmGfTZLVD3Sb7K8QOb8alABDqyWALaL83UiIi6nMOTuFE/in/7qPh/dKrg
 GP7RKKv4r0XXJtYgbEqT0o4RH2BziAHJj57JcWWqDUd4oR0jYWHTVt4oGRKUzvtBaQhQ
 oD6eg6skhjuDGrw0Qv6MtyF0swtDjQKq6Fn9Cw6xQnQq23REfxkhvGWUoeu6NoR+G+AJ
 iL55c5FcRcl9YOjeEirPrn8LbbMz83OyQUq6kxag3pAC5abe7tFR5YPYgN7VD7zsu0tO
 kZ2/z0j4v/J4MrKd9kCSwBvnsRHZpn/2fX5NoVw3E9nuC1kwBG0HykYXoO9Ktwte5PsE
 WsIQ==
X-Gm-Message-State: AOJu0YwXFml//0somOZ//NgVlUQYR52Yxa0+zGhupprl1oT8W91Fx16+
 yuIyKHiBws/73a9jJ81Yj9zKMs2gDb26cMGgsQzwZOAuFLGXn9NJgQ43wZ8ka7fJwikUGuFTAR5
 Yfb4yJ2AUSUKVhmQT2T7AKlo2p045Ury2est4el3/lXOKZhJtKPBwzBauvdeMN0sYcw==
X-Gm-Gg: AR+sD125YtwljaAaAgiMO0EUyJp41CFfpV1Zc0V72ksw2je86sJnLD0QyLYm22Ubh45
 NP+EztDNv6XhyBXsCYhZcUJq7ATZLOYWql1jWT/peu/ljJy7pThUS5701V67XsY7P3843gcncth
 +94Bo2g34rmrEHa4FqO8qrifu0HPtQSj82ZitZWKqom9xs9gxMG+ZJDGGJnrMbl/c5zG9AUl4FJ
 DzM15yj1g8FbdA4g76IrADygn9daCBOQ1ALm4S46S25hqST+7YMbIrAT2OscSCozSSJkzhpeoSk
 j7U0rmaG61TI5KTp6DFF71tKejf547Ovs6EX6ZwXxRX0r9tV3G8RoCc5npyNLfuyQmzdjphuJm6
 uzkPvvX9KSTfNEU66g0W+N8IX9rbaEsqcbmfiLFdFFUJUcA2RU1ViaIoCDL4=
X-Received: by 2002:a17:90b:28c5:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-3957b8dc3e6mr66916a91.14.1787081561355; 
 Tue, 18 Aug 2026 12:32:41 -0700 (PDT)
X-Received: by 2002:a17:90b:28c5:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-3957b8dc3e6mr66832a91.14.1787081560872; 
 Tue, 18 Aug 2026 12:32:40 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326798c566asm21877135eec.11.2026.08.18.12.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:32:40 -0700 (PDT)
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
Subject: [PATCH v7 095/104] tests/tcg/xtensa: system tests
Date: Tue, 18 Aug 2026 19:22:59 +0000
Message-ID: <20260818192309.22169-96-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX/DJdMjSNWG+K
 UJQN/LNaovCnsVqxsMbL9tKRUrv12ZEpQb4VcF6kH37PMwxW56XFMPzcg1pGYznd9TZycbYBs0L
 e5WjCtPAQIyBW80pwIFizqBd3Wz+m8s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXxojeI0l7Nsza
 dHqRfLDcsLzytLKx/61yE+pi6D3HKmRfEa5FoX7wV5nrFxJkedeUStQFhrTJ/snRlkR4Nt+k8LL
 ghGTHm4kPdMs9UkjOf1pqkFrm9Cz3uhgAC2oAUXwGAUiVF//Mjbo39ZKvoI9MNUspv1dl4PCWy/
 7qhgAdb0pKKC6aYYeh5ddFshRhN6utjRcZHDxFsxXrmAGKVsnO1V2epd2T8PGlhZbxqzdjRcmhI
 BF8vrlgchFs9+tIxszj84EiKUX6M3S6s6NZ2DM+zIOBmOjRQgi8mIgAqvprM8fbMj4yR8/jpB6e
 Z7BnfgD2ElAbOFbQ8oHwV0vF/krSw88WyjAkBQAsPzgGaTslFPzljt1OPmi6djyfQR+CRra0jiT
 mvXePgc9f9bCmxvuO4hsuamxhwC7o/t78I0e5vnzqPzLDSohS6P0QFJfH0idWVTLAXuFn2rct0e
 nWDBzUdiqZJ80W02JEw==
X-Proofpoint-ORIG-GUID: HBI6sG4pTBj3ui9UvwpfKtBeJtJbk-bc
X-Authority-Analysis: v=2.4 cv=HNrz0Itv c=1 sm=1 tr=0 ts=6a84b35a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=R9K0oc9ZdQARYiJKlRgA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: HBI6sG4pTBj3ui9UvwpfKtBeJtJbk-bc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
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


