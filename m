Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC031C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZh0-0007oU-ES; Tue, 28 Jul 2026 00:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfk-0005TS-16
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:44:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfi-0001e9-0l
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:44:07 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3b2621424076
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kxogDd10zwGDqZNFdPrjOgXovLkSDF6mgXIDntF6HN4=; b=l6w8Bj8xBpTHWTn1
 vtWXHl34zc1Pin5YVPJFkTOfPVEKDWSxnlkYtYf1/kPxTnm/v7U8+IQgyxs7wS1m
 qTSE8mHJLdKwlLPkDbkYPle8qk9OLpfTW4b0HEWe9ToN+g0o2QJjr0EizuSp29Ao
 4YwP8UB1xaOy4APPqqfnjv8e+omL3ZHYQJgVJZ14B1NFGw9h/ZuDxnzpsV3Q03ca
 eAwM1+eHXMq/+jAMCM9GAs12SUOvvQjChjaq/eih0ENQPspJQeACp6UVlwzbyhcP
 HHvADpzdOgVCp7i5KBm35gghNoelgrpSOAasA7MyqZwohjwrTEsRWZ6fiF0gG5mP
 yxbA3w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp3v2mpew-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:54 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cec4226c70so64034865ad.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213834; x=1785818634; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kxogDd10zwGDqZNFdPrjOgXovLkSDF6mgXIDntF6HN4=;
 b=aJPAzYqUsOnJLkcA9v9Ql+8l8kdsnM4/LgzmqWPntjqHlOSGBCduxJtM2xTruuV0v8
 UQNRWxAMDFAW8tcvxz3/j1Kf4edrzX7CIm0w8mPkljUGcMg2SFd2NydcUN+MDhHwzjia
 OHLVKefwHW27jvKm5Q4SnpPT7FSBIHtIaBx/k9N7mcx9pwzoPt4hbNT9C6BrUPBDVh8Y
 k+bVZveWDbp12kAL0fEUBZZj1qd/wUymTJoMQcrv9Ayik2hrcsImeOBJPf0mS5IbF/kZ
 ZLKwYSWm8tpofECHgeGwIH+Yqhf3XKWX9h9DyJ9PpJIzsIyiuEFjoOurcSD6OjXzkn2V
 xB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213834; x=1785818634;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kxogDd10zwGDqZNFdPrjOgXovLkSDF6mgXIDntF6HN4=;
 b=G3qxu/RQpGIJurz6EjS2VwphDt/Fw+Ni11lQadMvCmBy2twUBBopq0/Rgrierwi/6y
 XLHRTyQVrElXHAjQGu+bigdQdLXHLsm0MQufljNQOFrTP/rncEFmGVNrvWpTnQ/07HdU
 bvyFH8/EZ5wAf2Sq+Bi7LvALvlfQ9x+0qgFeTcNyB0AMzNwkigIJY7vhmQuwR0TShCdZ
 ZSCO4QWvA8mqp5FNcI7DvEBAWPBCOyMReyOo66Q4WE+hiCCTW8MftqpdBdgouyfMcC0O
 rNlzMCXgKuuwLHTXrwsSe4o8KVOlhfd5ljpzdQs9I/WOCOGRqfP6H24ZULCOale3NbC5
 KGVQ==
X-Gm-Message-State: AOJu0YwEJvK6nM6jFhHk6F5gcyzlzEGLNA78A3M59HlLr2x/cq95Sf+o
 jWg+Z01+Py+oOiRPPoQKlcbENOWQFOEfe6KH1ZkhrTeL/TkTADy4eoR1jKovXa+RLdInFFxQDrV
 zi4ZJWjJDQECsZvmUJHH1RHupuG4KXnmzeUvMFVRiTPUqJ7u1csXy6QZZU4ZszjnMhw==
X-Gm-Gg: AR+sD13wfdP1tWiuEauuhccfbe7xIqQid15DDTwJu5fyIRr2Ow0SdNfs2o9dNoIsNJl
 uD6+aeYPPbP9VsimQq1NkRJOBeQfP+aE4VqttnxzbmAz1t3FMmnfc/xoz8Xder0ivYQXcNy59AZ
 6WVBdsPfsDLnGqEtrbIlSO0Mr/2XTzAxLVLeEFwQIFLvOxuGsv42okzYm/c5azx4PefM5txm3E8
 qUIb4WynvZsR0pk0lm19+GjPPhRNAynVCz0L2M3ctEoPMKs5B5JSTLhwkdUmbGt39To7L59WWvI
 iVBNL1lKJ9x5+7M03Bu1MGAfuyDgyuvz8lkJlxxn5ZkXiR5WD4mgXqlIe918gapDsaInlojzjpH
 30E5YPBHVxkYGZfavmz1fF1AulfWj7C+AmDN2VF4fevrW2jnYVyXW0K0cV57IvdWyNVq5pKg=
X-Received: by 2002:a17:903:2ca:b0:2cc:85a7:36ee with SMTP id
 d9443c01a7336-2d015c6a151mr8312785ad.32.1785213833714; 
 Mon, 27 Jul 2026 21:43:53 -0700 (PDT)
X-Received: by 2002:a17:903:2ca:b0:2cc:85a7:36ee with SMTP id
 d9443c01a7336-2d015c6a151mr8312435ad.32.1785213833267; 
 Mon, 27 Jul 2026 21:43:53 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:52 -0700 (PDT)
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
Subject: [PATCH v6 035/103] tests/tcg/multiarch: declare user tests
Date: Mon, 27 Jul 2026 21:41:39 -0700
Message-ID: <20260728044248.137626-36-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX9K2zs9NGk2Tr
 AOyX8s8wIDevSTu9iqfxOHvFBTxiWLuCc/1CdXqSfy5AVtHa0NG3BhxLxGbAaIYjk530YyvqiE6
 CzEUiFUU6cqhaxtLlwJWUS/8XpnJMTo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX6wUmnhMewycI
 piLXBQr8Oc27SYUOB78MV17hMfQ5MsAR8BR3cvuiMppYj9yn8pQulgcDkRCiobV7OljtBMzYeSv
 MJWThaOAL3OJlj6Y8cfK1GBB3qilSMg2Xt6KiKZLD8QTHhEw9qTan0PlanhuMyOT6QePX2sNupi
 0OomLmC8sE4+N2zLcpT6MCQHhe0/4aw8D6RFfQpJpvUZN4WDj6LeY4TJassUnNuxy7D/6cluULi
 7xsjVVmRRqxy71IHyHp1w7WJ1ELL3Sq1d2vfbqrwQfhg/Qe4NUkD9cqwlvm0SXJA/Ipf8ruXj8w
 Nr6euZb0pKn4xFbBxuBdNsNKoLhoZkey4Lq9CyI2+y6Mem4QIpXN/mH2mQsi1hpsfPf5c1wXwB2
 pVRx09nJ4Oy1lVdgWAkebruHNLsT4vEBtLYjAoa+HaQW0w4fINO6v00htO6hkgA4GzC0EicOvyv
 6J1SRJJ+kFcesvGB6ww==
X-Proofpoint-GUID: Au07RXv4z38qh-hiXAtyLqfxfMr2te9N
X-Authority-Analysis: v=2.4 cv=KJ9qylFo c=1 sm=1 tr=0 ts=6a68338a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=mDV3o1hIAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=uKfjV-O4eVn7gy5AOlIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Au07RXv4z38qh-hiXAtyLqfxfMr2te9N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280040
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
index da0f5a69771..4b3a9d2fd72 100644
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
2.47.3


