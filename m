Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDEAC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziOR-0007MZ-Ma; Thu, 27 Aug 2026 18:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziOM-00072C-FO
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:16:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziOJ-0006Dy-57
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:16:14 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM78Y236425
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 roqeW8uzlbpnQeFHMKS4AkFBS/5Go1KklxqPoQ+RGdc=; b=fA9vJp1YpZJUlMlT
 /TaABvkfgmkL7H5H5YCUYniMEOW5liA8iU5hbWJyanOHHm91psDCQN4NvmFkTCUu
 4KsnG8M3zymOyWTzdon2e+xYF5hcaHl0vwboMFYtszL9X5JsrWuYnvjLxuUNd9qz
 Hr4KoirqOi7moYKCoer7ZpLF6aESj8A/AfLE8sifdPy3fHorvaG0aZRQ8VIPpXmi
 Xp+BxLu+81DPnVHXpAU8ZVhAjwAQeAd+KFAx3cbkXJKgp7uWP88wkqHIh/m55oyo
 5V3DZUQjSI/VfdQHlQhiYPEpQ3qkZAwHxew2ePVsgXPko2Ps17EXgvV43mXQnM7b
 4xOceg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatkjgtvf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:55 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8485d853b08so629277b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868955; x=1788473755; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=roqeW8uzlbpnQeFHMKS4AkFBS/5Go1KklxqPoQ+RGdc=;
 b=A/S5RANnPG1RSkq3djRV4vcqeaJrk4T8FXcSLXDloygFpr7aHAi92WTGeFy0FogZ4+
 i5gyz4CBRw7kFpbUMUagYGpe9k+ei7vXegT2pcBHmepx4ij8eL0CObIela3ROcDaHnF4
 UI91jpbET2InnBY7bz+kk6ChvBnXX0E7HjXzjzi8SZvLqFdTJ7K3M6na40TAxl9oyODz
 w9lkKaJ3AMNTlCCqsK0wmthDhRZ32d9NTPi26EnW7HX2KjHrhatoXI7daSoPpVgmYO7u
 qxX4DhY3y+Dwu5oTaiaq2+Y90XOVFgSbzLX6zJvDZ6moVmOdrU30O7owArQCuITlICIV
 sUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868955; x=1788473755;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=roqeW8uzlbpnQeFHMKS4AkFBS/5Go1KklxqPoQ+RGdc=;
 b=Wd3iVWFXchZR20ua1krDuE6/sKGZe4Wm/5qo5xXuuCuKlKzNGOgdi5X7o9IeTQNyfo
 loePqT5rle7L+SHa2nsecjUVvZ+n8VFgRJuhhDreuLGHE9K4TgQn6efJLAhToCxy1mbd
 h62fRGJn1sFCkhCIKTZpAqlfrCHd+Cv5DNTEZ6/1HfIzkV5w0UNjEgTq/KmB3dzOr1hx
 8/d6Dpm+FLgWvbNAGxBTTP2sa4hpJZgzK7tVdZMsUdHSs4ssCHZjuDG55/5T0UQQL7tt
 5bcsCBBGT70JWcxULZLB/gvui5Dpe5FcJWtUyWrPvgWfI+WSdAC7umqKyy9nlpDEbsMN
 uDZA==
X-Gm-Message-State: AFuF++lt0UV+O/FMFW5Q60WUX/nkQqqaJ6VJDPGElIY4zVRDER9d4aVE
 aWmSU3VTJ9SgOR+11ofilXc3eddQAUyI9+aOZGJp+ARIEflRgdXvLL3vIrvCR6ysx0cNKmv3Ix+
 +7xzmpqFCbbQohH6n7BUOFSDPs+OIS39U1sHpSUH6p4eeg14/FYNxWOaBuea+Wq8IqQ==
X-Gm-Gg: AR+sD13Km6XT9wqFa5ty1y9+QOiSBhTJjMCaJrsFZZtXtB+bafMfVPCsFJ57+Ss4eJS
 geGzGz/uPNPGfo3/SDkEQJn0UyyBcZN0OHzy51M1Bgp+CnN83KQuaV9FnG0HTZpY8Y+NgPJ89Ha
 vkGiLBP2M/gwz6lxTdnkUtIG/v4tmJZ8AiMQw202+cBdifTGf2uWi8H/Tc6KABuomLlBcoHbFXr
 iyj1QBGZp4+2wzjaykYlmjcyBPF54RPJu86brOG3LvYDTT+sDLdxbpmpCH7T4Mz1Ix5DpzlHz49
 lZiVSEXG4cYy/90qumsRQNkp7GsMaUMnLdw8/E5IQgDIaxb/827mtxaTsQOKvRVHOx25IQ9iQ9A
 xsXRsI89ITZSLDGbABMUqTt6g+/kryZRqMloATyNaXAPC1pw1kDfV1hVYDCE=
X-Received: by 2002:a05:6a00:b48:b0:852:38ff:b4b6 with SMTP id
 d2e1a72fcca58-8562aeaaf1cmr4326231b3a.17.1787868954562; 
 Thu, 27 Aug 2026 15:15:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:b48:b0:852:38ff:b4b6 with SMTP id
 d2e1a72fcca58-8562aeaaf1cmr4326146b3a.17.1787868954145; 
 Thu, 27 Aug 2026 15:15:54 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:53 -0700 (PDT)
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
Subject: [PATCH v8 036/105] tests/tcg/multiarch: declare user tests
Date: Thu, 27 Aug 2026 22:13:57 +0000
Message-ID: <20260827221506.91574-37-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uI2UYNm0j4hmq87TwuKCq58IuX8kqKzV
X-Proofpoint-ORIG-GUID: uI2UYNm0j4hmq87TwuKCq58IuX8kqKzV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXxXMx2oDC3HUD
 AkODeU4iVJlGXX0qfQXIaG1+WNjixgNpbf3qwzygp3lHfdUkW1oPP3o99IvaaUgCnh+Y0P+0Q9y
 GzTx4ANTgBH/+/TD8DuX3cNDVFDKp0vPxszsLn0L5SxcMTcKY7OnrfGmoW1iPvCX38+zOCPTUWq
 SqDLitrsz4i63wHxEvxME8KOhAoYkDNNlOKH5J30h/7Az/AHHkR4JycNeZpm9o5KMquZCxkl2HW
 i6EQlMXO7yrpDPOH4NJ8fZIxAnYkOwCgKC8yDREVGTWsM1R6eEcG2Gih7YbUT3dNU5c6tULs6H9
 BaxMWZRAZafg0YduPXS2LaP7j1Qc69/dxipI1Z9qOUc2mN+0slz1wYeS9yT1VhWgz4VX/A3dlmO
 sjaDpFAzzrPP/LUf5dbotkBc+EV76aktuJnoik5DgcV4YQ4HwK8ToRYN6j2IHiK14gB3iiZwgVy
 EogYcHEaeMp4LqdVU9w==
X-Authority-Analysis: v=2.4 cv=Rsn16imK c=1 sm=1 tr=0 ts=6a90b71b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=mDV3o1hIAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8
 a=uKfjV-O4eVn7gy5AOlIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX5XbJhW55DW6J
 Y/d2JitQYpjrOwm1dST9nefBk1YERYvu6HDkcjF9XAPPFuRn2eRAUdz4ecedh+D8pk28oU3cZ9O
 jbetxxhLPcYFs4FVaafs6FMlrVxku6M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

At this point, those tests are just declared and not used yet.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build           |   7 ++
 tests/tcg/multiarch/meson.build | 147 ++++++++++++++++++++++++++++++++
 tests/tcg/multiarch/sha1.ref    |   1 +
 3 files changed, 155 insertions(+)
 create mode 100644 tests/tcg/multiarch/meson.build
 create mode 100644 tests/tcg/multiarch/sha1.ref

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index d16772d498d..536def60b44 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -87,11 +87,18 @@ endif
 # plugins come first, as we need to build the list
 test_plugins = {}
 subdir('plugins')
+# multiarch comes second, so it can be referenced by other arch after
+subdir('multiarch')
 
 image_targets = {}
 exe_targets = []
 # Finally, we can create all test executables and test targets
 foreach target, plan: tcg_tests
+  if target.startswith('multiarch-')
+    # those tests are included by architecture files if needed
+    continue
+  endif
+
   # Detect duplicated executables/tests, and report an error to force user to
   # choose how to deal with it.
   built_tests = {}
diff --git a/tests/tcg/multiarch/meson.build b/tests/tcg/multiarch/meson.build
new file mode 100644
index 00000000000..99af41b3fcc
--- /dev/null
+++ b/tests/tcg/multiarch/meson.build
@@ -0,0 +1,147 @@
+tests = []
+
+float_helpers = files('libs/float_helpers.c')[0]
+float_cflags = [float_helpers, '-lm']
+
+# GCC versions 12/13/14/15 at least incorrectly complain about
+# "'SHA1Transform' reading 64 bytes from a region of size 0"; see the gcc bug
+# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106709
+# Since this is just a standard piece of library code we've borrowed for a
+# TCG test case, suppress the warning rather than trying to modify the
+# code to work around the compiler.
+sha1_cflags = ['-Wno-stringop-overread', '-Wno-unknown-warning-option']
+
+# multiarch src path are written to be included from any other arch folder,
+# so all arch can directly add those tests without any modification.
+multiarch = meson.current_source_dir()
+
+tests += {
+  multiarch/'catch-syscalls.c': {},
+  multiarch/'float_convd.c': {
+    'cflags': float_cflags,
+    'expected_output': 'float_convd.ref',
+  },
+  multiarch/'float_convs.c': {
+    'cflags': float_cflags,
+    'expected_output': 'float_convs.ref',
+  },
+  multiarch/'float_madds.c': {
+    'cflags': float_cflags,
+    'expected_output': 'float_madds.ref',
+  },
+  multiarch/'fnmsub.c': {'cflags': ['-lm']},
+  multiarch/'follow-fork-mode.c': {},
+  multiarch/'late-attach.c': {},
+  multiarch/'munmap-pthread.c': {'cflags': ['-lpthread']},
+  multiarch/'overflow.c': {},
+  multiarch/'prot-none.c': {},
+  multiarch/'segfault.c': {},
+  multiarch/'sha1.c': {
+    'cflags': sha1_cflags,
+    'expected_output': multiarch/'sha1.ref'
+  },
+  multiarch/'sha512.c': {},
+  multiarch/'sigbus.c': {},
+  multiarch/'signals.c': {'cflags': ['-lrt', '-lpthread']},
+  multiarch/'sigreturn-sigmask.c': {'cflags': ['-lpthread']},
+  multiarch/'tb-link.c': {'cflags': ['-lpthread']},
+  multiarch/'test-mmap.c': {},
+  multiarch/'testthread.c': {'cflags': ['-lpthread']},
+  multiarch/'threadcount.c': {'cflags': ['-lpthread']},
+}
+
+# Linux tests
+tests += {
+  multiarch/'linux/linux-madvise.c': {},
+  multiarch/'linux/linux-shmat-maps.c': {},
+  multiarch/'linux/linux-shmat-null.c': {},
+  multiarch/'linux/linux-sigrtminmax.c': {},
+  multiarch/'linux/linux-test.c': {},
+  multiarch/'linux/test-vma.c': {},
+}
+
+# GDB tests
+tests += {
+  multiarch/'sha1.c': {
+    'gdb_test': ['--test', files('gdbstub/sha1.py')],
+  },
+}
+tests += {
+  multiarch/'sha1.c': {
+    'test_name': 'qxfer-auxv-read',
+    'gdb_test': ['--test', files('gdbstub/test-qxfer-auxv-read.py')],
+  },
+}
+tests += {
+  multiarch/'sha1.c': {
+    'test_name': 'proc-mappings',
+    'gdb_test': ['--test', files('gdbstub/test-proc-mappings.py')],
+  },
+}
+tests += {
+  multiarch/'segfault.c': {
+    'test_name': 'qxfer-siginfo-read',
+    'gdb_test': ['--test', files('gdbstub/test-qxfer-siginfo-read.py')],
+  },
+  multiarch/'testthread.c': {
+    'test_name': 'thread-breakpoint',
+    'gdb_test': ['--test', files('gdbstub/test-thread-breakpoint.py')],
+  },
+  multiarch/'sha512.c': {
+    'test_name': 'registers',
+    'gdb_test': ['--test', files('gdbstub/registers.py')],
+  },
+  multiarch/'prot-none.c': {
+    'gdb_test': ['--test', files('gdbstub/prot-none.py')],
+    'env_var': 'PROT_NONE_PY=1',
+  },
+  multiarch/'catch-syscalls.c': {
+    'gdb_test': ['--test', files('gdbstub/catch-syscalls.py')],
+  },
+  multiarch/'late-attach.c': {
+    'gdb_test': ['--no-suspend', '--test', files('gdbstub/late-attach.py')],
+    'env_var': 'LATE_ATTACH_PY=1',
+  },
+}
+
+tests += {
+  multiarch/'follow-fork-mode.c': {
+    'test_name': 'follow-fork-mode-child',
+    'gdb_test': ['--test', files('gdbstub/follow-fork-mode-child.py')],
+  },
+}
+tests += {
+  multiarch/'follow-fork-mode.c': {
+    'test_name': 'follow-fork-mode-parent',
+    'gdb_test': ['--test', files('gdbstub/follow-fork-mode-parent.py')],
+  },
+}
+
+# Specific plugin tests
+# Test plugin memory access instrumentation
+tests += {
+  multiarch/'plugin/test-plugin-mem-access.c': {
+    'plugin_test': {
+      'plugin': 'mem',
+      'args': ['print-accesses=true']
+    },
+    'wrapper': [prog_check_plugin_output,
+                find_program('plugin/regex-compare.sh')],
+  },
+  multiarch/'plugin/test-plugin-set-pc.c': {
+    'plugin_test': {
+      'plugin': 'setpc',
+    }
+  },
+  multiarch/'test-plugin-syscall-filter.c': {
+    'plugin_test': {
+      'plugin': 'syscall',
+    }
+  },
+}
+
+tcg_tests += {
+  'multiarch-linux-user': {
+    'tests': tests
+  }
+}
diff --git a/tests/tcg/multiarch/sha1.ref b/tests/tcg/multiarch/sha1.ref
new file mode 100644
index 00000000000..4a8a114634f
--- /dev/null
+++ b/tests/tcg/multiarch/sha1.ref
@@ -0,0 +1 @@
+SHA1=15dd99a1991e0b3826fede3deffc1feba42278e6
-- 
2.43.0


