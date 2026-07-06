Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57ECDC44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgru3-0003mg-Uz; Mon, 06 Jul 2026 18:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtv-0003Gn-Hr
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtt-0005el-AY
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:55 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEDZX1665496
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7jTe2F8wXYX
 ezGaAD2OjYhElMvD/jt/evY/DpV8G1gM=; b=Q+WUJO3YxnsbZAUVKvlsavwaEOs
 zX+y98vrKDy9xYrD5S8Uhjc+1sSX3kgbKxLZc6/vTqDfk60VmYnjfdzC1SAchKNs
 N1F9QqmaORJcHL8hkAITSWgEKlopKNdC+ytWRdZWPnQkUqp3NOWtR+JIs9ENi5FC
 GcnJXnMM47eR/B21xbCaPQTFDM12sF+YHsLDLf3PJPN7myu6or2isWYCip6wMFO9
 HgIz5Zy3TwqlwFPuKnTh1UKeOZK0agURtT9mGi2k0mEKTGsGlZaCXF/JNPc/XT2L
 vVIr5z8evpTyera8nw4OzMGqfjB3kYg+q5TSC13dLcK6V40BXQ8R06PGRHQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gu6g4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:41 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3810e5c5871so6294846a91.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377280; x=1783982080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jTe2F8wXYXezGaAD2OjYhElMvD/jt/evY/DpV8G1gM=;
 b=jBUUEStgg8TMRL9TxgJB9zRM50obT/UrGuRTuk14Q+zKrCNbptN8n78CiJH+HQVJe9
 x5KrKzIAMGNRtYtFqyeOydzJR9bznwM18xlUs/3Cs2Gy67lHSg59goTBKp3zfSAoqDio
 eEOL1wBAONnHUCvKvl+oMqpYrecW1hFJUGwhJ6ppOZrCELm//hBW6srb2w1ia+Ldp+l4
 1vkkKzw6ws6LY96q0ZouO9NBi4UC1L9jTTznIlTpkdRNbxPnb0YCWaleJ+uHlmXR2gyO
 OOpPmi4vgrGJ4ZIux/qihND7Nf+P0eGDv2z4VFvSKQ22LHblvLTy632sqD2ZCl8gid2q
 jHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377280; x=1783982080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7jTe2F8wXYXezGaAD2OjYhElMvD/jt/evY/DpV8G1gM=;
 b=AKyUo9DBV5dHFElYB+C6S+QhkMAmRSDbJkllaxaY/bt9yx+hSgbjl6RWbWMyAtFzjz
 i/L8/eiPsk1Xm9j4NIHs2b5lx+ivt4Pn13aNPSzEKoHaNmGQe2qyNU8HNlKzeglI/yyi
 gS/owqUdbVhQx53ao0AEHKOz0hwRyoTa8iTMTUwb4mDnQ/9EFd00nhec3hfVzWGz87tG
 jmPx3Ll9l3eA9Wiv+exx12giy7e7UDr8Js3cdqIF7+Ov3EN55XIl+efam+IUs1dDKZFL
 /oSdAvZVgTbdbY9vVVqorH9m7gm0NIot2zK3QwVymqfZMyQuiw6+9/H31bjp8bxRXQ15
 6c2Q==
X-Gm-Message-State: AOJu0YzAeXNZyERZuLhFrr++B4C4P/waMj6KSDziLM8AJlOByfAr/UPQ
 LHqxzhO90YokuOjDQJc845wkz+wY2O3nexme3EI1H7k8aw2YExs7MU8XwISGQ4QpLV8SqMEVMcd
 XxJfCPnaEqC4v6nSZTc42U35nXssVk+I28T40bns8Ba8SwGtclugQH99FWRGDVeQArQ==
X-Gm-Gg: AfdE7cmPOCIlbMnxcB0qCnJAH1i+uiL4hEQL4TStYRpHsi0wHIJNzPHa9xmXEOGFwzv
 BATBHWjIu2Nml/ofAF+JvJwx9y5f9hRXmuEvvPqO/e+7CPukZA+juEXtTMqN8YVftFsY6WdJw9t
 fYqzvzSdpHNxAH2xgb8ln/zbC5MUfiujIGf6ScHPFgZDiuGsLhM7JzyNVxRhs1GuOH9ZOdOLd0p
 d22rrSPcAq9OjlQeNqaQl/C9VjbAuWiGXybqEyXmNI+HBeHYBdyhHtCRF99TtkQEjsyDQkXdIUw
 puL9/34boa+0LWfYFHIEi5GDs87qLNCnHSyMf8udh8feEHnHCMWe12z6plLbspaeUwWKFzUpoeC
 zFj1o4TnWPVEdfbtdAPJw2sIYxKZGPwN0S15oB9vTm3hmz5lrWykgRzrn9R9fGTTxCGJQBrSFGJ
 f036M5IA==
X-Received: by 2002:a17:90b:2805:b0:387:e0db:3d8c with SMTP id
 98e67ed59e1d1-387e0db439fmr72653a91.39.1783377280476; 
 Mon, 06 Jul 2026 15:34:40 -0700 (PDT)
X-Received: by 2002:a17:90b:2805:b0:387:e0db:3d8c with SMTP id
 98e67ed59e1d1-387e0db439fmr72622a91.39.1783377279893; 
 Mon, 06 Jul 2026 15:34:39 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 31/91] tests/tcg/multiarch: declare user tests
Date: Mon,  6 Jul 2026 15:32:43 -0700
Message-ID: <20260706223343.988769-32-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TAsg0eJAwkudbqpV5MIfMer3O-UwgIcE
X-Proofpoint-ORIG-GUID: TAsg0eJAwkudbqpV5MIfMer3O-UwgIcE
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4c2d81 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=mDV3o1hIAAAA:8
 a=EUspDBNiAAAA:8 a=uKfjV-O4eVn7gy5AOlIA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX2Xh6dqWN2cxx
 NFpn6vxbYAwdGNdjxSeaBt0pXU8XQYXLVxPnmqHo6SskiolLmcLJZx6CNJrUjdPJeB5AeV3drjh
 6mbIrnxiizQhwJtkFrBS0ZF1aZdzqUJcRqD9xZULuNnRAIsffW3F3WFpxH/DIYsNj9vS5R/EupS
 r6Uk8OYkg6ulg7GTy7xRBg7PsQZzy+pn3PQUW+UUkt8mActJtwYEU8px48t2Q7gskyPVAqL0WMJ
 ig4Oc2BSP1O99xB2hLAIE8RFaznPAHEcBBZdmM9YCH69Pq4eix3AcIv19Gh2lTy3XKoTA4dNTJd
 yzG5se5xEZOMJOzT+4YPlp+Tbw5iD+vuvv9oebakv5gWajE1z+xp1EMGHL6rpWlhjOlWtMNc8K8
 nwxXmis9PaOXjbd7L3ymLyS2D5BHYffSXPLtZywlz7Iv2nXZw9EXRSh2mL5/6u4EjUf3r2xJ1hy
 EnE6ZEb+XI54whjQwlQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX1clOePUzuP2e
 IJOO6ilRzRHUKWFtXzAEjbylHuPRdO6mCPIIwzoDdBndNQBgwlKmB+jxi6kdBxvE9HakqJ+9YFa
 mBrjNjNbveA1YJTQ/E53M3je2yLO0B0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build           |   7 ++
 tests/tcg/multiarch/meson.build | 147 ++++++++++++++++++++++++++++++++
 tests/tcg/multiarch/sha1.ref    |   1 +
 3 files changed, 155 insertions(+)
 create mode 100644 tests/tcg/multiarch/meson.build
 create mode 100644 tests/tcg/multiarch/sha1.ref

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 9fa97627eec..0dd0efb92dc 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -85,11 +85,18 @@ docker_supported = run_command(docker_wrapper, 'probe',
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
2.47.3


