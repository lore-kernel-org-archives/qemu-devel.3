Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573F7C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4lQ-00068x-4E; Fri, 10 Jul 2026 02:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4lO-00068Y-Si
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:31:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4lN-000750-A4
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:31:06 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3n3Yo3802185
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LBPavyOuMtC
 DUCMk4lm9ry/r3HScA15blK6AQahVKaU=; b=Qm+a6jGqXbtvSuKb86+zz8qakAQ
 oCaBT2nzNjWSJFuKTfeqoesev8xVCTdVodS/g4SOzz5e0RwBmNTzhuxOMSLJSuoJ
 SF80ZZDMzZixiumR66CTgjHUpNaUa2KkmXBBm/rgCvynrneRjWsN7hL/XjJbAI+8
 cXyoIrWFp2v92WdaaXQnfTxIRe6ErODrr9qrbXMO6BdALl0zUt43MLI3ELFDO1g3
 y8z3q4zH9MBf2wLnEVb/CmcA4RLpJiiDq2gNnoCSVWb3HXkvhk0PCzqUmjd3czYT
 mpWjbxCLwLqtEpBjh7wcAjNSLUv7b3YKpGITe6fyqVF0jyMPsLdnNlO4veA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4facqpkpde-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:31:04 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38827cee19eso778858a91.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783665063; x=1784269863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LBPavyOuMtCDUCMk4lm9ry/r3HScA15blK6AQahVKaU=;
 b=B5h7oiljrC2vu4MUICLsG6ikvxaEUWRX5x0xEIdb9nKjpYLEvuZEX7OuwcJSQF71VU
 YiXmCTlxiXcZQ13fIpS3PR30E6ddVIU+QSiy0eG5wu6JUL2svE8Pvedc0mG0aWW9MWof
 omx9ZCYutsIUfoYfv2yUdrwJ1EgxfMAwKKvuxad76cl7mEHN9EjjWshnY22eLBONSvxY
 K7AF+P+137ieu+qC+mg8OqOcuCHUvkgAcXuPg39kSfWb+RwTUY7O4ecagNJL3hp8ALTk
 6S3Ex8oILZ0yED8xcJxarOLhadoeJRK4R1lWvCUHVQKWN6Kn4W42iW/kMb7ZXm6QEFRk
 fYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783665063; x=1784269863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LBPavyOuMtCDUCMk4lm9ry/r3HScA15blK6AQahVKaU=;
 b=jffF2lqKoqTlSaPP3QpCS3S5q5cgusz1FH/bKVqFR1EE7/VPE0atyJ6CoZNueyjFP5
 8nt2rSzXF8Td/jAanQJsZNaZiswt+AuWLh9AI2v7c5VUj29h38uLfx5QEMR/KPsiZ0xN
 CFGpFQeU2P6T1DUrdH1FN9niy8oV5T8S9wsTZb+bmXf5aYPsl0SDICDaiu6DCgn8QPIa
 0LpbfqI452xbX5DQuqY8kLF6xJtX4Q7/U/Mqg7I82a3MJk0d234o0gbq0TPfBzd1fnvM
 mWLTtYh0+v4Hj+xCBs/YPH1PWEAskovKleQj7343T9PEKsuRkiQeYQVSnHWpjO2E9eHy
 U29w==
X-Gm-Message-State: AOJu0Yy90/fK8K/t+Ecijrrl5i92rOju1LSVVmpzY/Vg1avuaHJEM26K
 fD23u/P+rOYZ8keqbV1CLIt3GEI1qbzKtdcpfIe+OO6QhU1K4CB3DLz/jsJKdbHXtWIFFgbYRlQ
 wlPFTYTJ78BOBF42KHyBZ0bqrh67gRSJqTmjgl8bjR6FeKPaPHiWkXaEuni2SwpgT4Q==
X-Gm-Gg: AfdE7cko+wYJFP0t8qs14cwplTMHV8dPC+D0ti4IDJDqyCktWueeulK0q7DpEwGd6q0
 jVrQSHaZkLMSI3MxEEwhsSXPcaoidIHF/VWaN7tytyHs0aKjS01cgyxQn9L0WHQVxsmz5dpn4Mr
 zqVGfvhPBPfu19onfqAxqXg1QmCtNjiy9xap8FFJIpgAS9QASwC/vFGeR4NKNbZGLXWSzkH2HvK
 +H8MWipRchqlO74zjEP+dJAm7ldCC8sqr5WlnygiQSaOc7AKs4E1/7T/VINjMNnwXuMUhvwYcWE
 mQhu4eiwSuziAplcvBEfg6xlsYIF5IJOcqxjI5OV7aTQw5A5bN8QCXFkn0SZ39jOrxDRSjz/sbk
 WILPCKSccUH5vKVL2VhsfGavyrv+YWJYJiSsrq8B1Exvd0gGOCuyrm8gzYXrhQ74AoXgc8HJPjx
 gC54XlYw==
X-Received: by 2002:a17:90b:270b:b0:380:9d0d:7af8 with SMTP id
 98e67ed59e1d1-389416e69c5mr10365720a91.20.1783665063492; 
 Thu, 09 Jul 2026 23:31:03 -0700 (PDT)
X-Received: by 2002:a17:90b:270b:b0:380:9d0d:7af8 with SMTP id
 98e67ed59e1d1-389416e69c5mr10365659a91.20.1783665062973; 
 Thu, 09 Jul 2026 23:31:02 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3120c8e41fcsm6258960eec.15.2026.07.09.23.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:31:02 -0700 (PDT)
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
Subject: [PATCH v4 88/97] tests/tcg/x86_64: user tests
Date: Thu,  9 Jul 2026 23:20:06 -0700
Message-ID: <20260710062016.1818125-89-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfX0gZ1Jy040CFd
 qzE/rTbjT5aHB5ScEFoaGJ3QymyCv9BIeqf892+KCh2ldVTvqBZkU4C5scrg5O2H/bHcpiPtPCU
 eU8mQGrB7DZbdydBPAmsaY53UMh5dLSqXKaoz7w5evbQvcA5NZ9Sx0RRgj5ESmBfb3l2e3LThTb
 UhtR9i3PX/3RmBU37tV06MUBL/jq/af0na2OvMM3tKL3Q2aktjedtzhwxgrfkFmsOyXTAByITFO
 H/qfm6QXEulqEXN0O+cd5BfA2xx0Qecco1Gg17MKp0SuwHAYO/JAnplO+ScciaKw924FFcc/RKB
 /dQKqSwaG//RuDp9HdIrdmLZgpD3+us8jZ4FM9eTuuqXr95HkODv8dg6nFO3CzyHebol4OkvBXS
 2LbhyZgXigD5IanXlCNhHVqOnQNlgRgqPD86gR7r7Txoaq0LV7At1vo6j4I/JYSKgYr2uub1+L5
 i5mqXQg1r+Rymc9J3hQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfXzDgTxvra05Xs
 evdRNq71cDlDmOGaM8vaLliyeSlnPMz9ChNsGxPByD2wXpZzcBnvSFlFXx9R4qPMXCRuz/Au1go
 K/UK4PvC7mz/yiuKv+bwnqd3c+NU8HQ=
X-Proofpoint-GUID: cvg29IXCb84-SKanQ0d7Dt-mfQOVroHn
X-Proofpoint-ORIG-GUID: cvg29IXCb84-SKanQ0d7Dt-mfQOVroHn
X-Authority-Analysis: v=2.4 cv=GJ441ONK c=1 sm=1 tr=0 ts=6a5091a8 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=TgUO9q9VmvSWxa5ljMkA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100060
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build        |  1 +
 tests/tcg/x86_64/meson.build | 81 ++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)
 create mode 100644 tests/tcg/x86_64/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 4e81091cb6a..b7a8ea7f564 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -152,6 +152,7 @@ subdir('riscv64')
 subdir('s390x')
 subdir('sh4')
 subdir('tricore')
+subdir('x86_64')
 
 image_targets = {}
 exe_targets = []
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


