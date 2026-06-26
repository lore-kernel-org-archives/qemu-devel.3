Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE957C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9d-0003xE-AP; Fri, 26 Jun 2026 19:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9b-0003tX-9x
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9Z-00046J-2Z
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:11 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMwqZv2098358
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UJ+cVaqbPXu
 plliSMo/9+5gqb3mnPIqNSIZ9WfkbUxY=; b=AYIPDnxHo/iA4rymeQseXFgag89
 kTp1DmNdTYWncNUJmO2axNsWUQZ5+aYdW/yGMoD/ON0eJbzQi3MoBsR19Bh0rNF6
 pc8dH1+9yGFOgcXgH0si/XDgVvMOPORDSG42VNMssaikh5wPyumC2qSJ8SGFOIWN
 kPxyYV07vbvcNEmf1Uc7DKCY2/S6XP7y+UicFOoIIypq3FuJqUhHPKQlCD0wSch4
 P5iixbp+vepmBOB4Lma5jwqDPcX6uT7AvNjRddFFDQeB+q0KdNMKrfqPb788QW2b
 lxrQfQwVpWEpe4HG1l+REhRw3OPCoogihznCpzYRHv4XodnULkl/SBBnmtA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1xxvgtku-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:57 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30cb2bcbf7cso377230eec.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517197; x=1783121997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UJ+cVaqbPXuplliSMo/9+5gqb3mnPIqNSIZ9WfkbUxY=;
 b=RILW2aNK3FZ0L/Vs2gjLJPdXS2FsZk8mRZM8Z99Q6O4YtMqv41hVjD8vXJ9kj/VDQe
 bJ5uhSeyHJWezzc+I/uAwZ5Igz7ROByjuqDwzQJucXpVO3nk+XdGHdfNucXQJJXl++eN
 fK0rAV0uwaob8Lw2Ssvw1yg3NQPEurO8EZPcB8wG14ShqZyATTlImcBiZvF+QXNdGqEF
 gZIBVukesZIpUGc7epAGj3exCLPjr5wZeETnHEaJLKWl33xhQZ/lfDAhZutvsKiAwyxY
 KlNAVo3WF6t2xRuF9L7PEWhuZIYcCjVevRJL4wiwYRTRRWSwvaAcY6Xeq3sf0cQ19vXN
 JNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517197; x=1783121997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UJ+cVaqbPXuplliSMo/9+5gqb3mnPIqNSIZ9WfkbUxY=;
 b=h78ss8p4/1yebMsWFttMPuFjSWTCDWpsQ3fQsnOD3SsvoJKiXSDz08Z8Srh/rWPFD4
 D0V4KIzjzNyWotqyTpMS3CVGF2GESniPNtp0bR4PSn+FImbIQ9qAIrUvlfM9oAZxsUf+
 Q464yy+I/BEpG/oBaLTBkZUHMwFkcsLdBaJVD6S4lY9EqlqBLarMOpnU3wHxzxj15hEV
 r8WsB2TJPxPFtcvWwBDasmMQQnU2PaRzO5cXs7e5s5dWxg5hs2V+CKMNwBTNu9z1Jq/e
 tc/5SC+ilvAIzmn51dtuZi+bsGZM88lZLVtGfeTd8eZYDhkHE0Cc/dB9WNk+CESBdOGO
 zGxQ==
X-Gm-Message-State: AOJu0YwQmdTPdFC9Eo3UGq48PA+YwhvcOZGRLWGiqfek/z4AhNZS925Y
 TZKjT+c9zBhR3rZDm+MRCJlxIQd6mP/S+ZEV3gomdDLMqLJFwmEJ/FOxeRc0PTX9UxDLp+s0sZl
 nyvumIw8iX+xZZEAaXlUTKQdOwVy+P9qpV/b1HvLO8UJNjuk4xMvPO1vDvvMBs7Qyjg==
X-Gm-Gg: AfdE7ckeCCiVsWC9E+DVDe4ndZzXFK7zSxiwkINIQ+JGPIO2OXDKLjreMQoHRLbw2Gu
 Km3melOqJO8cAo6rtkNzNmuvL1KoZWD32VN7owE7shHM0D8gWU4KP1l6QxDpH7uLUAggS7BB4/E
 Qt2mHGx/ahyC0avejHzzsrP9pSl2ypt/IaeAGbWeVL4VJ0ZmU/REfadwhKu2DA2cIOD7AkonYC4
 dLz74vYktqgs+4mZCEem/BjRYa51xantgu4DBCLXAwcAeZi80vWCjwekljvlTDrvvasVG37BGID
 8NFh1wjECaNBnAQRsyIFj8xd47+qfDPria7kXLKhCyG+e0KhaTvsCCD4f8o9Eiosg+GMAZAfhod
 PnerNuUj//VJRMi4yVNL5mkzZZqBe7yJE3TrjK2SzyHmF1EjACN08B0C9gzf8Hhts/oQRWwjEKf
 Kvd3JOyg==
X-Received: by 2002:a05:7300:e8a9:b0:304:bce8:fa30 with SMTP id
 5a478bee46e88-30c84b2c0c8mr8745870eec.5.1782517196293; 
 Fri, 26 Jun 2026 16:39:56 -0700 (PDT)
X-Received: by 2002:a05:7300:e8a9:b0:304:bce8:fa30 with SMTP id
 5a478bee46e88-30c84b2c0c8mr8745855eec.5.1782517195738; 
 Fri, 26 Jun 2026 16:39:55 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:39:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 23/37] tests/tcg/multiarch: declare user tests
Date: Fri, 26 Jun 2026 16:39:04 -0700
Message-ID: <20260626233918.158740-24-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 61n5jueT77iASMQAqsUhckFpsQuZp1hD
X-Proofpoint-GUID: 61n5jueT77iASMQAqsUhckFpsQuZp1hD
X-Authority-Analysis: v=2.4 cv=BLyDalQG c=1 sm=1 tr=0 ts=6a3f0dcd cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=mDV3o1hIAAAA:8
 a=EUspDBNiAAAA:8 a=a29YhttJ29ErjWDLLsgA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX++n/QWu1vggz
 m/RL0qa15tzPKODpkkqppcDzWs09cqIPdmFTFqXtTCxKQ6w8cDnsD4w/r83LW0wPkeaSkogNZuR
 yVcqnV85/w1cLWLokR70+gkuUjBoy9+J5ICU08qtS8A00kUdqgUp/dugALSrKJi8aVD7cKXii8b
 AdjCzEWZqg9dztHb1vEPN6v6YS7lBUPo7b7drRtls5kEHTyUkdWYnX15ZfHm9zDALrsd2k8+RBi
 8j7wiTu4V+FofxXs3O9+qwAewlQX7JFtACj1eLLpC0PqKuV0HpF+Dzl/8IAPapEXW7zE/Ap7o5h
 /SHWqZfaSwgNfenGJPB0tgNcc+EgsX9R6ZUAXhu2iAsvANitLw9XWpats1/T8zfjLlPQ7YQLUCY
 7irZde3liFSVX6H2us25YNlxX1KjBIDpKF8LAMul2yVUA1m1xkcwD3pZDw+LKdw9M28liM4yLQW
 fGjhqsK8O1hcf7MyBlA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX3X4B25b+6FJ2
 p5M2sjd8qfFtvFds8TQnayKagBnq/yALxhewyL/gcYXLUYBf1nTIlWRmWV/SUIO2ddTJHhmNDKE
 aaCc43OJ8uB3RGKALoFIJ2KbaeT4Mo0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260197
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
index 0036203a311..f8234ccf393 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -68,12 +68,19 @@ endif
 # plugins come first, as we need to build the list
 test_plugins = {}
 subdir('plugins')
+# multiarch comes second, so it can be referenced by other arch after
+subdir('multiarch')
 
 # Now let's go through all architectures
 subdir('aarch64')
 
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


