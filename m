Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3C9C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziG9-0007ZQ-6B; Thu, 27 Aug 2026 18:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziG6-0007XT-7n
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziG3-0003cV-R5
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:41 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJMFBW1803870
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 roqeW8uzlbpnQeFHMKS4AkFBS/5Go1KklxqPoQ+RGdc=; b=UPrc1tHJjzpfmX2I
 Ua4F8lkTxZ41MxzQI/J3tgXdJiiJkJ2pv68fNd/YHcqO39dhSVhuff6zkWHA8DZm
 oUpf/7WO74bSkTRp4CHsrPKLkGYxjStEGBtGjne1Nu8h3FviPCrVrVIWFtMN0hBO
 KxIU4aoCiNAV1NbyA3YmW1v4elcX3Uvznj5zaz5PAGFkqYTV1LxEHeSDvGpHLKqM
 EhqGk1hpWljKazASTlDb3vlEyCKTr6Vbea9/6pp+KV1lUZCxz2oTbL83VC3ZS1ea
 kl1p1yh5rGGNgjVOcERDt2D+8kYFt3PqcRSzenbZbZKgo7zkJNU4DML7Mn7kq78T
 1dlnTA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatfxgu7a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:38 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc1b6f65dacso202039a12.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868458; x=1788473258; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=roqeW8uzlbpnQeFHMKS4AkFBS/5Go1KklxqPoQ+RGdc=;
 b=QqgL+uqRyw/GAwOPtSWBpbvJlRlLElwTwiBespUFdIh3PZd3ueK0uywuNmgNg4cvuJ
 D6wr1Ewu10/gfNpXyscV+xbiGWYIgZPZe/BjYQE/3E4QGuv0ZyTH4OZbrd3pIftwjkdO
 LpOA3YO2CdqC2jEUrhKm5kWWZ3/u6KR4M1msjreZKWpihvX0u85aDdui+VJ1hlT/pFvu
 M1BoiqPzVUAa92UmS3g8U22vv4AyiwK5ddhHn8CTdAdZz5Hz1Ut6ihFBYgzJe2dDRvJq
 ByolXB8ewSIp2E/2v4K2C4w+Tf3/r1LybPtEI3k+7nTIzYc+ylsgMx/oC/2rgOwWCMMV
 NbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868458; x=1788473258;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=roqeW8uzlbpnQeFHMKS4AkFBS/5Go1KklxqPoQ+RGdc=;
 b=K1ApvzFIYZn/+jeQCKXJ/oVVTC+7yKIPnTs8VkC4IdHAhFenNhofAmCZ6TESrDN1wd
 GGtWiocEMRQ9v60Bo3Q2B1SY5C2J57nUJ48F8GSFez+FoGDR1xAZFB2qqO7cUW/+LUqM
 /dgCZEaQVzHYSTgzB1xeZCmMlWsp2xrsp5/9az2WMFPEvOsoq1Obk8eBXegmAvuZsx7N
 KwC8iryMYaI4ZQsqubgezvU1OhJdCAqRSY6kNDxly8OljmWfjT5ieQk7MLbDnPFYGpkB
 3bPrT5TcRDgmmfMzUTjLiTJ5QWtI7gikMHQEPBAHdajkUsSWOTOIiNyZl8g8Oegjl4lz
 YZYg==
X-Gm-Message-State: AFuF++lNmBsuEV1ny0sqdenR0igU03VpcSoitF+B/fAltLb7cU/wnGkO
 7g++7QmZUcGZaM5bNubJlzTMDz86cTAgNngq88JozIDPcz3bzwODQbo+NLEw6sHZsRsbkccQZbx
 ZVrPlAQNDjrEDeeKifD6Ycse2gudq1iMb4UoihRDrS9e39XGwvs64nzAivFQbn9tLmA==
X-Gm-Gg: AR+sD12I7Q2xGhqGtrN8Zy8/s4oQF+BP7tXY1RkSzEgthzJfA6OJTSqt63s0GyD8r6n
 6iO40v7Jmd+39rVvCZnMnbwQz3ATlEw7iCZJXVUojs1P489sWfmT5XrBwyfHnd6dCane9i+d6M1
 YBVHmBbklLwWLhon9DU9VWp9mAXYj7qJ+kBCzjC0Hd8gWHcz1JGOn3jhprGvlzW4xqE7nqWJmDC
 Bf8dDpwnxqQdY0/qUBQg84Oo5nbwE4XyLgPhVVm8Z2WBfbouApOiRSpntLkvTWgOXa6YBb6SMFx
 1QMcUTExrAiDNgeQqLjwvMSf8Mi8wM7WcNCpRS2mdT83Noilj2E9EkIuCwQQ3wir+nCWKH/Hxtr
 b/zJ41uUzRPWlqkkp//scISX1iYdQkcbVkz9HDHDamktRAjxctl+8YP+OycA=
X-Received: by 2002:a05:6a00:4fca:b0:846:8b22:4933 with SMTP id
 d2e1a72fcca58-8562c24568cmr3516557b3a.17.1787868457579; 
 Thu, 27 Aug 2026 15:07:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:4fca:b0:846:8b22:4933 with SMTP id
 d2e1a72fcca58-8562c24568cmr3516480b3a.17.1787868457079; 
 Thu, 27 Aug 2026 15:07:37 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Song Gao <17746591750@163.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 036/105] tests/tcg/multiarch: declare user tests
Date: Thu, 27 Aug 2026 22:05:30 +0000
Message-ID: <20260827220641.84885-37-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UKLt2ify c=1 sm=1 tr=0 ts=6a90b52a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=mDV3o1hIAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8
 a=uKfjV-O4eVn7gy5AOlIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: G7-t0I7vZHmDPnVU6jjQIuI3ANQXMv5f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXyul2OCCAeY4A
 Kd4PGtYwWKFCiZpXV787QuCI8q2YTEXNmuuJkLIOyjdLlRoV0Q1c/vOj6DyYAwkIrNub6uzHuNs
 FQ9xDgZZUiB0vRd1pph5Fo+nEKaHl378zmr2g4XGfcajRevyjTrgZ+bubHxh8HEugtDEou1JXfn
 /HPLN1e38SpUROvi58NobxndW9hkSy1P+wHjJ/T0H3mliwrlIsgkgwyRyzmW2Qd3oXHepY01E04
 YdLcg4IcK1ZzdAKD1+WbSHV53YRPMx4w/vlVzCwpQgK+0NN0X8GQu7jN19X0vRKn8jgVcpHwHtj
 Oso3nvq2GEWdT1NRy2ev4A31qHOv/XecgQOCNczZ7rElFwDgahOJ/7zoW7Hh0LYwkNr/Hf1r8o0
 MKuD/rhxQHFI+v35sIc7QgoiWaL4Fjv2E45OVbW9MJra73SvJLaHkhoJjN3caAQuVVa0K3VpALJ
 3UksZKhnQ0k6mQ4GdnQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX0PmxU+jFmG3Z
 dFRv2iUIaQngaSu0CDmucGGtZZn8nXyVBgz+9UONkvbQeabpfot2vEwjpe5NihgN89osnhu2mPY
 F1Ygm0pE3HkAAN/VacfA82dvnuK/Yx8=
X-Proofpoint-ORIG-GUID: G7-t0I7vZHmDPnVU6jjQIuI3ANQXMv5f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
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


