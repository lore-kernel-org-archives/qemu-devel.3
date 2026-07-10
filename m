Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52ED9C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4c8-0002L8-RZ; Fri, 10 Jul 2026 02:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4c6-00026W-5S
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4c3-0004oW-OA
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:29 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nS4P3803904
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K5tsx5MqHcT9cBT77IE2pIkF1JDq6Vkj/UEEY4FGddk=; b=gYbTPGrMC6gFZVH2
 Q6ard5JxC56Nq7bQBZC/MlXSn9yKIs8nqb+1Rm/Ca1APo0Zsi4cVMCd86//gEDcp
 RkW9ea86kXct+8pjiObkoesNrBJk7xeBakRAI366xiBxDVIe2qYLinFUCYWWuzmy
 h9NuElYFkhHEYbhxChKTe7SPM/NDQIzXzZLztK/9dYNRGWTEQMRR+BEBRVhK524z
 iiGUxQc8VDXtY8Cy/M8qJFg8+vX/YwESVcPW35TYPgYctdq+rk+UKFg8/bIIgFxW
 l5bTvEWdMfELQmVRRMGC8qPqFs2DTfuOozDNjtlGsPV+FhNlNHmhYwOGuk9FrgRp
 uQoiYA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf5mtu14-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:26 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cce02cb769so7738675ad.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664486; x=1784269286; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K5tsx5MqHcT9cBT77IE2pIkF1JDq6Vkj/UEEY4FGddk=;
 b=HvXHvsffiv8z4ZN/ICtYZtNpzIInbJyYXI0amgqydirbdW/QndNbj4sxZFt55mMN/Y
 YdKoDYm0X8fs7BlGM6fdL2MYIGRlWATCf8hNxcNTth/N/+sQ8Guq/E6xu+gbMw2qDKOq
 PSJgClRtA7BqaED+6+ZYy85VTiyKFrKENu32/7l2HAZmuBcJ4NjWaGEbCMjvqquxcAGs
 Ah7RKsLCfyqKa9PADtvmcV8h5BrSQRwCMPYaXye+gDXM5XfGzX5KH9ZS9nair+pJO9yk
 YYiWr+VRhrfoJi/llPQsxbj8Sa7noMAX2vZY77o78QpZWbZfVxXDXab5apIIyXkMv2vy
 paKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664486; x=1784269286;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K5tsx5MqHcT9cBT77IE2pIkF1JDq6Vkj/UEEY4FGddk=;
 b=QIlSeBzXb1lRlayxze3J0gstWFI5jnJD78SaGSgPtsokl0ZTUwBg5X2ihIzru33afy
 z0xyh1Ci2TcljrcTq/befBMOq8nXyHfVGCL2LsuqpIJPpE1TIHnW4tn0NkrlBtOT0oHu
 UdjHcE6raMwo6CJJ+yv0PRm1d0iHTbLH18hMGS/VcX0DUJe80hnDOP7eG4rBf++dDUup
 x+VMgZlC7/3gR2KawoLDls5kYGTEtZwrTuOGIB9H2wVasYfVdaJ4lKVa2tykQBY2zYt8
 y32Q/2AvSPdUUz8aJ5comGXKTSC9zUdiWU9m6xtIkye7pvZ3HDAMwQopoWu37I09NEPr
 CPyg==
X-Gm-Message-State: AOJu0YyI1gy024T/YYTHpCtvwMpsgSdQII9MN53ZJ9ZPyMa0J1i8JASf
 tW9c4I1aZt9nGintcF9lKVey+qlwXlHNUexlBkhtkBaqeXhlv0tz7spATfGM2d+mn7DA/Bu3nA5
 fwXUXmTdnFJgXVhIKO38LuZhOMx7YJuwDMFdRXUW2BkbpCpdiDPbcp10yWA2M7XYi6Q==
X-Gm-Gg: AfdE7cnFIlQdcGimg4PvvAYstzWONmo+u7E/ZN8o/jTBf7hs4uOYwQvLZrlG3Dq6G3x
 wmcIy2P5Zlzt4gDF36D2/PiPBykKcEG3tqcF15QjyQRni2kRwjqUPawOecxJ2sCL2vGFytwRXXo
 sXotoj0d394rZrlbQCIZUmr3Pc0J5+09YAZ0vMSqiMxM8Lf1Q1Ijs5azQyfL9JmpgbqhEHm4/rx
 dhTGU4XybIgAMe7UOOwIT+K5u6H8iWyUiYkRkanzHkeCfdZCoFfFjQiaq+ccWM8Uv1+8eiHbjFr
 3cUuoYBD2kdN4QaSqQDPUNpjqZmjhh3PkwMQ6rU2DPbRHC0VAG+AIi4VRQJLHfTCuRD9b718hdd
 2v4Q/5eRZlOGy0mCYJKMIK/5e36FELZkDrRjuHKWh7/JFq8STdAOzyBZmK+l1ad0eghOYIooCjw
 /65B++7w==
X-Received: by 2002:a05:6a21:690:b0:3b3:fc6:622d with SMTP id
 adf61e73a8af0-3c0bcb7e418mr10551103637.38.1783664485374; 
 Thu, 09 Jul 2026 23:21:25 -0700 (PDT)
X-Received: by 2002:a05:6a21:690:b0:3b3:fc6:622d with SMTP id
 adf61e73a8af0-3c0bcb7e418mr10551059637.38.1783664484738; 
 Thu, 09 Jul 2026 23:21:24 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:21:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 33/97] tests/tcg/multiarch: declare user tests
Date: Thu,  9 Jul 2026 23:19:11 -0700
Message-ID: <20260710062016.1818125-34-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QfarA9aycLlN30TlO3oGGnLKBOF9XXIy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfXzH5xajBOI3Op
 Og1EYfiveRC80m8jqVKWxcV7c3lWmp0XaT5yi5jD13kH4WiPU5HV8cZRAELw5q0Env8RBu5UhOK
 GlvdKBbNNSrQPjVBpyo6JXat1qkhFWc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfXyCqSCC5rX0dm
 fGJe8UyGMsboctUEcCkiqdqhxOqVy3wtrqDECV6BgUkw9tH193LpvRGrYzkPtHDjSoon3nu+DPd
 pmqtVDYdc1Xh2wgq8jFipopag5/gmTDxuogxNb0XE2eTc1yfIyioky0j3lMUzGQ3gZR5N+fVHeU
 NgxvfNCUmo2U0dd18Z01kDtzVrXiz/ODBxPSYP6lgcOQ2y2ytjooAHEsw8WGJ4q1b0gD/Ey30Hv
 L23of4cyrZlyKPrWlzyCJGyR1T+p4If7mxWYQoS1ceaPXg8bCEnAw1wC/OcYBl/ELvsep55Ck7/
 WKa77fw7kXnvVUAtA4Wx0LhAMPoIMQqw/pR+dI7MCmAB2LoLCVixtfIC6UB8dmvUYsZUfARakdm
 rqQYsZTpJN8z4zK8plMU7R/u3KTQfbyhox9KJxxg4w/Q5Y2FMK9fvoxzsz9krggPIHTPyj5eie8
 5sO8+nsFIbZkAM5uAEA==
X-Proofpoint-GUID: QfarA9aycLlN30TlO3oGGnLKBOF9XXIy
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6a508f66 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=mDV3o1hIAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=uKfjV-O4eVn7gy5AOlIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100058
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

At this point, those tests are just declared and not used yet.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build           |   7 ++
 tests/tcg/multiarch/meson.build | 147 ++++++++++++++++++++++++++++++++
 tests/tcg/multiarch/sha1.ref    |   1 +
 3 files changed, 155 insertions(+)
 create mode 100644 tests/tcg/multiarch/meson.build
 create mode 100644 tests/tcg/multiarch/sha1.ref

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index f0a1d9aebef..dc488a32e6f 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -84,11 +84,18 @@ docker_supported = run_command(docker_wrapper, 'probe',
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


