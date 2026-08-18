Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B46C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPQB-0008AF-Re; Tue, 18 Aug 2026 15:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPQ8-0007yK-MC
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPQ5-0006jp-Lj
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:24 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHGxFw1549012
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 roqeW8uzlbpnQeFHMKS4AkFBS/5Go1KklxqPoQ+RGdc=; b=U/wxoYuBeHBTnYDs
 fbXKtrlOleBcP4wHn0ioOn556G12VwhQsSwjgLI2jC1utq94EH879UNy/tQmT1Br
 HY3jT2NrHtC2zi9q5vlVKAeenfya2kYFwgrxFPdDxroDCD2DL4Z8HwWyYe51ULOa
 KtO2rlsGzGyMvzjft5gDrLOyN6nDDccjWgTDSTHE98TfnndVTK16DQNwK5X2Qkh8
 83dTpE8U28u1+WQZnTstro/TDgk4ni5L7IAuTa6ezeB7q6GIrrOeEoHCBxd5nICW
 WZakGfOABpkcEbuPW4jvGQFEHCVFu5r9JulqnUnQY+hw7Is0zWQsa0DYQdNSFMdd
 ViOmEw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4uj1gpdh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:24:10 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38dbf293831so556928a91.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081049; x=1787685849; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=roqeW8uzlbpnQeFHMKS4AkFBS/5Go1KklxqPoQ+RGdc=;
 b=WIAcCjk7nWBnftcRrLItwSAzZ/GmvyAFUFkgjHUsCvD1gFXxeyQiAKlhFB7nUioBNQ
 phKJnsetg8JkuqitP8cRqgYjbGNtCzj2X8hxj3g4RYo3lXVn3vUjSUzWEqNS+dit94nc
 AQl+e0+t7sfksS8KLcNiN1D6JD6jXB8iFoiBC26w03yLbTNJa2s5We4PEOncrIKUqVOv
 633lPUEODNnbNohbKmHyLiT6jqn52Os+aZeOK/cCAo4Y7NbgTSkB6NYh+zKM/BqsQV6X
 tmAN8PQAjld5iA6CqiCOWjUVGNzdPEhP6ih+ARTGk5TkGpIdG8iWfViwOpby+6hs2GgW
 imbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081049; x=1787685849;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=roqeW8uzlbpnQeFHMKS4AkFBS/5Go1KklxqPoQ+RGdc=;
 b=oc0Wkygn9rwveMArO2iQqac3xt3DTwOjJLjGS5PLaquIzAAwfuf0Qj0ogKUkVQ9R9k
 RcbgYakdX8E+vGv6E7RLn4Kg4Zi3VgL2A/hdc4igrEX1gRf7p+UvJSAlWq34pdIY3Oym
 3PoiUEal1Xw//NRbUE6H7pTcLC1rDcvsx0Anow5HxFsc6V3NAc66eZ8MIFIvApOh+cz7
 /LyxOJYxetLa6A2xJw4tfhcc/E3iiqE1KVCqX1tKLu5/ZmCSij6EVD9EhPczv/Z9Jolu
 AvgTuo3eXxNtXa4ZR0woJdvLRtCBw64zhsVP9Gm0DeHSNEsD8M13VsPZT8FFqRFVb9pB
 SB1g==
X-Gm-Message-State: AOJu0Yzrl3lnxEgXuAzCDVNbL2LFNtvYF9oAYKRjuXIJLOeETif3lfDr
 ze4Yq5R6I6zKVv4LR1uLZmXxcHFiqXB+PEXo+ADgatfchgiojy5WqyqUWuAO554MfSLC/xXwr+V
 u0c6ikbZQL8ukQfkaR8clZB6sz+yRAvkKaPphUia/axkjS2Sx3jpD0wrpWkkW7xbugg==
X-Gm-Gg: AR+sD10z1ZxZc/y/SQUFBWhEXxlxl9azFQ/JTo85+uVzvNkbKjKWKH7O8pmsZx9Vu6S
 e8EFN2lVM+l7z2SGusy4Q2tfYJeM7geoEm0J48Cb5qoL6DJW4L14D/dOHm4hoJ2Pv7TLVXwVkSt
 5xNyoNtVQEnueUI6MkLp+m2+vgWLAQj0kfIOmu7kxWerj9NTSXHWdddVGJgeULVMKDCtTYwEhKa
 JInaoGZcsydQbU7ZMD/DXihpbgWUi5ABaOuM1smElaBVDFUG7G+7V7AZ+kPbxYanBfLw67u2uWj
 Qo0xuFGpGRiYcEGm7RQynG5us978whgalqCwqwbFdyltNtVLAImOW4DeCM4iptRBFm0AGh8XXUq
 XbfI/LJRmlwpTX4sJKdKzw7x2Roj1KYlsa74pDxDEim3Oglk5hum3s1S2RuQ=
X-Received: by 2002:a17:90a:da84:b0:38e:4f41:83df with SMTP id
 98e67ed59e1d1-3957b382dd6mr12521a91.15.1787081049362; 
 Tue, 18 Aug 2026 12:24:09 -0700 (PDT)
X-Received: by 2002:a17:90a:da84:b0:38e:4f41:83df with SMTP id
 98e67ed59e1d1-3957b382dd6mr12442a91.15.1787081048871; 
 Tue, 18 Aug 2026 12:24:08 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:24:08 -0700 (PDT)
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
Subject: [PATCH v7 036/104] tests/tcg/multiarch: declare user tests
Date: Tue, 18 Aug 2026 19:22:00 +0000
Message-ID: <20260818192309.22169-37-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: litoowg1Awi5keGmVK75uAUJNUVAKRX0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX+lu/3FLSFmLb
 8l/hvsQ3RmIt/chTuWfgQRrvwhiehrtDOok8SJWTz52mnP0XiBHWLdM02azfsiOAnKX7hQKhTGe
 QqoRG2XBYYzXZad/c81KTfkjv3wAhoU=
X-Proofpoint-ORIG-GUID: litoowg1Awi5keGmVK75uAUJNUVAKRX0
X-Authority-Analysis: v=2.4 cv=VNLtWdPX c=1 sm=1 tr=0 ts=6a84b15a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=mDV3o1hIAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8
 a=uKfjV-O4eVn7gy5AOlIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX1UxkxFPJIK7u
 rSdAgNhCoRUY8gXmEantJWrcslM5guOwCMIc2DUTERIAgPsrWcq+uofKUMliVcrfQN3eQ05CNzA
 YB0ldX3kv2MP1ZWwuxPmamh9TEpYtKt/1AlE1WspVSFbspn4+lDEFrZ2jLh1dr2p5HOXCh25m7N
 WOsddfEdseLja8gzPdbebEpmbaMcStFz3oH9pheJxExXeZvVCe7jZGoWrnI3U292iGtAunKZnnm
 W7E0nBnDx3RlEtWIo0XA8FlqgGZk8JFvZ5J9YWuDbQdKUq3GtTO4s0zkIdjqK56xDrpiUnoDwsy
 QV98/CtnBNTpVJjgMmIKORtOslx9YI5TPp0f/UlPuBgU5WBkbwqaYHA+5asiXPRnJAbewa8O5gh
 NrUwG9eNODeAPLmhm5rapAjQGd3Eg58roySys2v2HzJzYpb9DrYmTVoK5gLayw7rz3sSXPowOjk
 foXlJYGHe9NRxRE6gxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


