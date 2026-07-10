Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7188DC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJAE-0003or-Jt; Fri, 10 Jul 2026 17:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJA4-0002yq-14
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJA1-0006R5-Qw
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:31 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3VLp1714048
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=PeOVB1R+dc8
 AO2mCVCB5tRorQ2tSUFd0s3jfcBemfrA=; b=pAz/fT6b1ImuKTscDVbgIRuOR53
 MhHGUgoJV55TZKJ2s1sfOJ7Z70EVVC35dQt6oECmNluhBzj4FV57WvF+Oz0b5jIn
 pRwiJW6Bxwi78kDT7aAiy16YtkhsnawGlyuMWF5qu8Kex5lK/tt4PzPRFcDatrOM
 p6bhYZ5EvfgOr6OUl1goq2yd7XW12e/Keh5Hu4FY4pCGgdbGkzr2nDBA0Vn5KGnG
 +IOdoE0nx4gPIHGHLd+zyTg8lb/tuO226lY+RDrNoQZgfAb+RraV3JPWjB0UZ6jq
 rtrMJ4shYDB4V1Qr288trSOW9jgRw7RRmKr2eM8t5Txu8MUzdK85AQppbCw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb339sa9s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:53:15 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84865f326efso1457498b3a.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720395; x=1784325195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PeOVB1R+dc8AO2mCVCB5tRorQ2tSUFd0s3jfcBemfrA=;
 b=asKYaLGuOpjfAD5oRYnH3ZR1FYWgse/OA0AZJXJ70qTWRhLmdK5nSVBnFkiXx1fHsP
 lMYL7EeEZ8wmDNdvaPcXsBHlvtQJt/jmTJYgNPhN/GcO2MG6xNjPmTMcFsqdKWCHuiiL
 VNWmXGuJz/oC8ltS3p/jQNDo82jaiQAoh2zyoUM/1iTVrTGzQLEadxaZR6qloYGp8lRA
 YIaldMyDXFxG+cUbEUwgsWPrM9TR87K/gS32J8mT56z949ZZXoVon3SozBGTf8pI8uBp
 O1GPr9BCHXrfPDxK8UOVifeCtHITv1vfpttn9ulqFt9Kknd0ErAHroQGgUE6oUh+C8EN
 MCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720395; x=1784325195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PeOVB1R+dc8AO2mCVCB5tRorQ2tSUFd0s3jfcBemfrA=;
 b=kEVaYeP7AdsbhUWRD4A1BOxAUREfCg4+cHXGWfNn/dtiGjInofAX0YnaAKoL1r3EEU
 srI4D4/VxwXf3luCvcFwJ6VchauM4YD8LIHO1oerO8nm9K+HUbdQtPCs0CQtUoGsxRNj
 Sxfyt203H5GG1PuyFwurjjGPCHt7o/LGe0VHrRmew9zBv8kvgRh6IlE+FlJ3jyGGa4so
 na4o50yde2wQtuxOoqAqKfEA2RtSFTxjzLT3kx4dG4bHwVZn63zsEVSHIJiNTZBqKLcS
 94O9flNlq1k9XwbCR1u0HXjv2Tl85RGohpkwrl8ZICLXn2ZY6E6MiZiEE9IVkw5dNcHP
 TdIw==
X-Gm-Message-State: AOJu0YzYc7yF2iCheyafdRkDS/Ethpq5Y76kKeGA3uDvE4rns7ZSSkqM
 fNfHA3HEIOqDnY67N/XNZ0JuLvzYm4woEmC0fPgltDRNJ24jxCLMhoCbzytPnNPYV31vtyVu7h2
 MkH46bkaI7NUoT+RaqT9ldKDlPNWfK1y5/Q4EYgYiNaOBPBfmPqsNTbNTTI+yqQGOgA==
X-Gm-Gg: AfdE7cm8/hl6/1SGE9rnjeR3DpEqiwUbGQNeBNiAGwsK1LofonMfqlZMrWLQkxlVoT4
 k+sRe1GEtHNP2d0fIAvGUBfm5DjkUiT1R5+ZETIJJH5YcZyNjTM7qRwPv43VUdM4uHSxMHLoPJ7
 hd+Q9RukfGaA797nsF2pHtx+0r3kE7PAF+mf6JF/bCzck6v88rk8w4hyZO4E3u0hA4yEyE8LhOB
 fRkzsbMokL6cxkIoPhWlSdxQKry4oO8ZZ3gwXXxBNV8ovSPQ2N1evjr79X25pgqe6LMIUDmxAI3
 slDC3cR5y4iXdJtTM6L7owC3Qzdcfx5sf97OtD+E2aG3T9prGaXRDBLL/54mVM5vxwy1EMqMLrD
 wXiNgjrA5IHGPHuCeuDU25rzFYvw786940jHFphbkpzx3/Pt8HoL8w3O/d6fQzifiNZSW6dcF92
 7CXlptsA==
X-Received: by 2002:a05:6300:670e:b0:3c0:9c19:659e with SMTP id
 adf61e73a8af0-3c110b7ee4fmr711818637.70.1783720395114; 
 Fri, 10 Jul 2026 14:53:15 -0700 (PDT)
X-Received: by 2002:a05:6300:670e:b0:3c0:9c19:659e with SMTP id
 adf61e73a8af0-3c110b7ee4fmr711791637.70.1783720394665; 
 Fri, 10 Jul 2026 14:53:14 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311b00048a3sm14268659eec.5.2026.07.10.14.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:53:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 89/98] tests/tcg/x86_64: user tests
Date: Fri, 10 Jul 2026 14:43:33 -0700
Message-ID: <20260710214343.2065491-90-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX0fj6R2kFJzdD
 qM8Z8crLvdkxRLiE3cdEtsX/Ac3PSDxC/s2dQVNfxsLRsUtUvoELmf/3Tqboc80iwhxOfOASY3G
 ZzsUxHFqm2otxIm9wBZtFcs5aHd8t+c=
X-Authority-Analysis: v=2.4 cv=Re6gzVtv c=1 sm=1 tr=0 ts=6a5169cb cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=IqpqXQmEGorsqtzfWrIA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: C0_siQKkItUC0XgrP3NcMOJ5Ng7so8y8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfXw4o6HTJRhSdn
 0N9sT5+iipKtdsx1ZUlm5FVC3bIZmzbNR2r582FginseASZM3qBdat/6I0bk1X36KJwgoRmxR59
 AsVnKodpdWuhxgmmhy6H0hh4He6CW4yWLVCQ06KPjT5fQFh2FdlRruDen3RdM6G4K7MDFrW6yor
 YeTNNfSBcsgX2xI2waHSK1UzxT8tjiBNPwFpkXb4RuNsHvj+xm24/zg9Kf6/vpI03vrkgImlVU0
 OqZ5U+zvrRzh2yPCSd9GmrMJ/iHECST28l4t/hzrI6PiRi5KEHrhgcLs0bIrmPDBRJBY2QK5MfJ
 22/ovUG4hepfWD5osVK77QTa3Dz4dkRbnvGkDpIuxeAuYMn0EHCB/qlerim8n477GhlXcPi73Jc
 /Re9mglBnB+7TYtTN8ym4VoKMxONdeklJAkndckEgLXqw6TqF9FgAWrynCH7qc6AeLNYb658w7j
 Eze3iiqqdKrKc596FDA==
X-Proofpoint-GUID: C0_siQKkItUC0XgrP3NcMOJ5Ng7so8y8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100220
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build            |  1 +
 tests/tcg/x86_64/Makefile.target | 40 ----------------
 tests/tcg/x86_64/meson.build     | 81 ++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 40 deletions(-)
 delete mode 100644 tests/tcg/x86_64/Makefile.target
 create mode 100644 tests/tcg/x86_64/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index a0d629f40a1..d2f73ba655c 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -152,6 +152,7 @@ subdir('riscv64')
 subdir('s390x')
 subdir('sh4')
 subdir('tricore')
+subdir('x86_64')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
deleted file mode 100644
index 8ed44b08793..00000000000
--- a/tests/tcg/x86_64/Makefile.target
+++ /dev/null
@@ -1,40 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# x86_64 tests - included from tests/tcg/Makefile.target
-#
-# Currently we only build test-x86_64 and test-i386-ssse3 from
-# $(SRC_PATH)/tests/tcg/i386/
-#
-
-#include $(SRC_PATH)/tests/tcg/i386/Makefile.target
-
-X86_64_TESTS += test-2413
-
-ifeq ($(filter %-linux-user, $(TARGET)),$(TARGET))
-X86_64_TESTS += vsyscall
-X86_64_TESTS += noexec
-X86_64_TESTS += cmpxchg
-X86_64_TESTS += adox
-X86_64_TESTS += test-1648
-X86_64_TESTS += test-2175
-X86_64_TESTS += cross-modifying-code
-X86_64_TESTS += fma
-TESTS=$(MULTIARCH_TESTS) $(X86_64_TESTS) #test-x86_64
-else
-TESTS=$(MULTIARCH_TESTS)
-endif
-
-adox: CFLAGS=-O2
-
-run-test-i386-ssse3: QEMU_OPTS += -cpu max
-run-plugin-test-i386-ssse3-%: QEMU_OPTS += -cpu max
-
-cross-modifying-code: CFLAGS+=-pthread
-cross-modifying-code: LDFLAGS+=-pthread
-
-#test-x86_64: LDFLAGS+=-lm -lc
-#test-x86_64: test-i386.c test-i386.h test-i386-shift.h test-i386-muldiv.h
-#	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
-
-%: $(SRC_PATH)/tests/tcg/x86_64/%.c
-	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
new file mode 100644
index 00000000000..9d655a466d4
--- /dev/null
+++ b/tests/tcg/x86_64/meson.build
@@ -0,0 +1,81 @@
+cc = 'x86_64-linux-gnu-gcc'
+cc_dockerfile = 'debian-amd64-cross'
+cc_docker_host_arch = ['x86_64']
+
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+test_3dnow_h = custom_target('test_3dnow_h',
+                             command: [files('../i386/test-mmx.py'),
+                                       files('../i386/x86.csv'),
+                                       '@OUTPUT@',
+                                       '3DNOW'],
+                             output: 'test-3dnow.h')
+
+test_avx_h = custom_target('test_avx_h',
+                           command: [files('../i386/test-avx.py'),
+                                     files('../i386/x86.csv'),
+                                     '@OUTPUT@'],
+                           output: 'test-avx.h')
+
+test_mmx_h = custom_target('test_mmx_h',
+                           command: [files('../i386/test-mmx.py'),
+                                     files('../i386/x86.csv'),
+                                     '@OUTPUT@',
+                                     'MMX', 'SSE', 'SSE2', 'SSE3', 'SSSE3'],
+                           output: 'test-mmx.h')
+
+tests += {
+  '../i386/test-i386-ssse3.c': {},
+  '../i386/test-3dnow.c': {
+    'cflags': ['-I', meson.current_build_dir(),
+               '-masm=intel', '-O'],
+    'depends': [test_3dnow_h],
+  },
+  '../i386/test-avx.c': {
+    'cflags': ['-I', meson.current_build_dir(),
+               '-mavx', '-masm=intel', '-O'],
+    'depends': [test_avx_h],
+  },
+  '../i386/test-flags.c': {},
+  '../i386/test-mmx.c': {
+    'cflags': ['-I', meson.current_build_dir(),
+               '-masm=intel', '-O'],
+    'depends': [test_mmx_h],
+  },
+  '../i386/test-i386.c': {
+    'cflags': ['-lm', '-lc'],
+    'exe_name': 'test-x86_64'
+  },
+  '../i386/test-i386-adcox.c': {'cflags': ['-O2']},
+  '../i386/test-i386-bmi2.c': {'cflags': ['-O2', '-fwrapv']},
+}
+
+tests += {
+  'adox.c': {'cflags': ['-O2']},
+  'cmpxchg.c': {},
+  'cross-modifying-code.c': {
+    'cflags': ['-pthread', '-Wl,--no-warn-rwx-segments']
+  },
+  'fma.c': {},
+  'noexec.c': {},
+  'test-1648.c': {},
+  'test-2175.c': {},
+  'test-2413.c': {},
+  'vsyscall.c': {},
+}
+
+if 'qemu-x86_64' in emulators
+  tcg_tests += {
+    'x86_64-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'x86_64',
+      'gdb_arch': 'x86_64',
+      'qemu': emulators['qemu-x86_64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


