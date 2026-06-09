Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B274CD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4JP-0007JW-6K; Tue, 09 Jun 2026 17:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4JK-00077V-9a
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4JI-0008EQ-9X
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:38 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659K4i2Q3229341
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 21:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=43cztZbf9Hh
 hgQ3gnC+t7MMvQlX7rNnkJ209vKS44xg=; b=CtyXrLWoo8bJxYlNEuqOjpNwV6h
 /vZhyhY7EErW3Q1i7buYxrnOQu9Fva66FC8kZK6cKKfoex5pYgCszRUjnfh8fTNI
 ebTdfCWzNTlXgIVkXXtvbbHNJ1HbnZf/Z4N5XrzpWMdSGPBLk0ixZJsMB/tIsLJZ
 BQQl8rM97cd4YJ9oEjWsvmO+bkdtPewqLpaqpObTX6w0M4myjXu6M4LF+Yfeh6LE
 LneFnTxz6OWFYWLXrrcdvYc2I+N8pT5uynh6/0cQn9TYT9+p6zdV/z5CiSl7AKs0
 5BbNe4ZPV3NqHfEh5JzpIUL1ViRYCV73uIn5HZ3Zr/rQfDE5QKn2amvz2vg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3wkg3b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 21:48:18 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1382674ba2eso4033519c88.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 14:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781041698; x=1781646498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=43cztZbf9HhhgQ3gnC+t7MMvQlX7rNnkJ209vKS44xg=;
 b=S5RTtinjVyUUs0Q8b/RzMVj/cvX8c87S2NxUQkMIGiccMy96ejJC/199pUOQPBXED4
 0We+Po5Sau5g8/F0CaSrqnS50QDMCBxYW3ok+RKNp9OSdK6e9cWVMLgev8/NbsDYS5++
 sepPoZkdL7oTvSTWEgjqTyGt8Oqmwyyq3bpdTe6TKiWsNQ0ju1XQqqUzUgDLi3BdpFsv
 aIQ0EuoPf6fIEx2iwk2ZqtGg4augmlxd8wXbD9on4GX/MdjMLiDjRZfowL7qhxXamT1z
 pbk1WI47N2wwI01P8gK4RY+J7VFTE9wedlHmUrjRNEEm/UptxKE3zKKooBBVFQyAVKsn
 XTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781041698; x=1781646498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=43cztZbf9HhhgQ3gnC+t7MMvQlX7rNnkJ209vKS44xg=;
 b=bsXUI7HNnFZMMnecp60lbSEeGER4zMqjTxMpJEBRg+ZCnAkYmwV8mvESyPFpcYqWaA
 K6Q3jkx+9FviDAETpYTZbXS9fXh7hGUlLsDnuMGSmYjqrbP5X/S7qNeTOqpApjxjo9HR
 pubY6x/H9bh0Ekt9b4+bq0Rts6PVCUM/DdTSUCttD3s31U1t3XguY8TjjAvn7azVjoFJ
 HsixEdUzFCWXe5+oQKcztq3vrQyYr5L/w8qJe26/uDl0jB76R5mfCUhTPldzkiE78Ny9
 o0rHtu7xUxsUOmTKgzVSiULAcn51lNVk3xE30bvyTL9K+A9E+hmylpvrJZMr4K2a46Rv
 vU5w==
X-Gm-Message-State: AOJu0YzcfKEM2NmRrTnvxF/Wy61uWl6WFbxjzTGw20hASc43BwhDoBma
 nENCcwlM8xRUq99xhXCAZgQ8x+D27f8iVSkJIVpb5f4Zho21AF2nQ4/4lKmPzjKvCokTPguTSj/
 fxo+6H4hnm/INYBCq63ZutjZQiXneTGEaO7IfMndALeBRRe8fK1Oz627AJ3eu2SIOjuLa
X-Gm-Gg: Acq92OG7MV+k5c+pw2lnV+Ym8Due6mnvKnvFVNz5agCXw+c1iq+9FWgDQmTm+4KaizB
 UIX2V07/IE2yYG1ACMZZl+nJfhhQz32tVmfLL2t6wU65GtvKcKGfRtjRoJZ7+1YIiHuR/NVbeQE
 vtpqt+jwKSFGlIi6wABqjAchvQ5cJbKBEvPDYzh4XMB66F/kvuUyF4jSuokY6ljs180DJKO0pwZ
 j+UTF1I82ugCEtXqNPo0PNYWU8jf9U68/aHdS8860qU/SAkVTT0pgR3989lsymPXUSRJDfWFFY+
 7ef54QSLW61Z2A2Uzn4w5ibMD3jvFqSQE7AFQm7SZLu5TCBTFs4vrUHtqsVksnd/TTpB2QtMrbr
 pTSyInOdH8JoKPuevLPOuIN62t7QI0Yb3SS7MXcazqaGuVwuKAzzcfkAs2wDmjLZsABgLY1xUFs
 4v6kYQVkPs9F4PLNe7
X-Received: by 2002:a05:7022:402:b0:137:ae1d:5b41 with SMTP id
 a92af1059eb24-138066b5977mr9694054c88.2.1781041697562; 
 Tue, 09 Jun 2026 14:48:17 -0700 (PDT)
X-Received: by 2002:a05:7022:402:b0:137:ae1d:5b41 with SMTP id
 a92af1059eb24-138066b5977mr9694032c88.2.1781041696889; 
 Tue, 09 Jun 2026 14:48:16 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm17095895c88.14.2026.06.09.14.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:48:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 23/27] tests/tcg/multiarch: declare user tests
Date: Tue,  9 Jun 2026 14:47:41 -0700
Message-ID: <20260609214745.772536-24-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNSBTYWx0ZWRfX8sG6OjehiVXq
 XcyLPNOpGKzlelzTCFZSmWx3s5V0hxeKRqBOS/GBMLYp+KGctvDpwLO7trcKsq+vZW5kXt26kDl
 MEq0VI3ghrjwhStQNugT1dlnoKoD4mB/qDw8XrdtxXPnH4jmm7jaXeXhLMqOBZQ1KyYR65qWRFm
 anklh8rN8t6h2FNSFuaK68/hgSNgj439n63BWx80d+LFMlbwcAxgUh0zivYzXGcIEqR6ixHx0Ev
 PC1MWIOkSUTGzo6s2ODvkGDcfR/XU1Lj4/+cOmALbsTWPbjA844xL6ijvdHop1h8KU+M3t83BSH
 olHiYfotS0t3haNeZ6nIDdsXw36OjNN2FKxgz6Wr9cX8r4EWD4Am3g+SVcWutAiKVhSAxzwRqnQ
 Cmu4riBW0necsLHgPXW3fMFwqcHFH/Dwo3qzVcmoUrRAkk8R48XwZ7kM4Zzluo/p6QXlpP9fs2n
 f7HTFxhpOul/wdpCP5w==
X-Authority-Analysis: v=2.4 cv=csWrVV4i c=1 sm=1 tr=0 ts=6a288a22 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=mDV3o1hIAAAA:8
 a=EUspDBNiAAAA:8 a=a29YhttJ29ErjWDLLsgA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: -Zmt7EiFUQQToVxlRAckvxE8dbbWiqXv
X-Proofpoint-ORIG-GUID: -Zmt7EiFUQQToVxlRAckvxE8dbbWiqXv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090205
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
index 8633c58459b..9ec33739884 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -67,12 +67,19 @@ endif
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
2.43.0


