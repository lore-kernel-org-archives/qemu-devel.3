Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49479C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4bJ-00013A-SS; Fri, 10 Jul 2026 02:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bG-00010z-Ap
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bD-0004So-Rp
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:38 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3n3Gr3802204
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 onTq3va+MhGUEGt9FlOJqPHYVADDEmy8vhj92p8nZO8=; b=QkH2Z/JfmSbeY7YP
 oIcCQnyJbZPAHkW8+UdpEL7uWP6mYQZaBCWUJHIg/gEg82ITyi+0atHQJV911F6A
 Ct6uJiFWqAbNQCngemXv4e1humYl1WyfGDeYE9g7jeuEll6BN9raeMf04MMMHAKb
 Se3VQ7EwJEaIBa85nyduBJcPFz35c9WVVeipB2lTFLU1i1/7ySVX1AFALgjKlWHv
 cbf1Nddg0adHBquVhzKL016vutlhQol6wDmbPdSt5rwFqP2dZgveF3+3ZT4rkD2Z
 0C8xRuzHbqex2b3ERtiPfpAI/rBDmhhZSAQb/SxxSM6zHCUYiVhV9JXQzAWXdrjV
 A3DGHg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4facqpkn00-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:34 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88aab7c1fcso1030498a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664433; x=1784269233; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=onTq3va+MhGUEGt9FlOJqPHYVADDEmy8vhj92p8nZO8=;
 b=TML/v6Wr5a4eYDdeQ+yebmLRpfEWJzXQ1hNJnDjv56FVBLiBwKDWGc4M++tgVBM2kz
 5SSbGwiJHKGNvvdij1IqTgiDsTUxGjvz8JNkNRjQ8TqF13hNQxK9B1WLBWqdrGjHgqsm
 CRJIbvz+tW/cvo098a2eabgSAGr7hnjDliHUZRFEDqu3fD0eC3DoP/lbgVMtgFHyI60c
 keU0RZgYqiP1W1Tofd6CKxIq7xVEP3iOLkL9+yrquq/F0DP4hzYZDaJiqgst/auI/nDi
 TbRsNVsihXWRuDQzpiaAYdeFkC/9QMAzPCl0EdHi7kE1PJyaG5iPLYBR32RMRrUX0mkQ
 wZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664433; x=1784269233;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=onTq3va+MhGUEGt9FlOJqPHYVADDEmy8vhj92p8nZO8=;
 b=mqDQVtmzxccqdl0wTpEg/8pDxNzINFaYqP2C8wDt9LOcvqKxSwxB8X85jA+l6ec3jo
 TRk1gbagieB9QJ2BeLHPZFAoCxiJHfjjYQvX/VhL57h940xzgKgGomLOerO4VPzSKNoW
 viiCegNewrvbk0FtPho7sEpYj9OyKrNoNAibhZvn9cRtF5IU9cTzOotGA21TIBTpxPep
 AI5M5HTPUDFzmf6nY7B50fnU1cHa5VvyldUhQ6HcyjqOPNLpsEb9g9gvIcxiz8najweM
 G/Uz+fwLP4x63EngoQJkKz35cVTFCoerJhw4rZu4rrpTiR15Atg18Vbux3L9RurhokkE
 1HMw==
X-Gm-Message-State: AOJu0YyV/vZ6HGmXdmfBrm40qgOV/F3pOBMrMW/QGQcfdKPxqx8J2SrO
 n/HfZRF1P9Mb2Hatc+sYDkiJaskDaHSG+c1UuRjxXl5SYCcyaG8b0beEYFSUTijixaFafG700C/
 k4BiXXA/DF8PvwkVaFaBWcDWTJ19Qck+nBn+BUVdEMbpupPF8Pjb1jsQI9JKum7TX7g==
X-Gm-Gg: AfdE7cnsCvqnKcG975tNxBpfbIM1OUbAUDthJ4T7TQDV0vakK13jOrDZwfsa/c75uQq
 X+0m3NpGEaL+6QHxos7aaIy+EBDPjay2d+sSHNUXnrZo/me4FUHfbDKK7FElWW4tLlloBAKGVQo
 hOPrNP1NL1Us+3b+ebrJZcwG0ftZBFSlOQF8NMfndC4Moda3YWbg9xKJntHZwDxZp3Xgo0uwD1s
 ZSjSli0/Kuuf8msNERr+cmP5L24XA7s/dJ4wGWGXsgxsCMIZfIGeERiF88l+9TDuKpYc2Yj0tk3
 Jdih8uZthejXZ94hUe1cIQFOz4Tvrp6v1cIeAIcHI7VaUh1Uhg56tC9lAQsIyqwXTZM7UZklMVj
 q1Rxh++6Xop/FuOHE6gY6rKbbt2swiHZztoFizpupJk73kOCloFvoSV0cuUFfnhzr8a9PKNxKyt
 3jwXA+Cw==
X-Received: by 2002:a05:6a21:3a85:b0:3c0:9c18:d5ac with SMTP id
 adf61e73a8af0-3c0bd237362mr11852172637.73.1783664433270; 
 Thu, 09 Jul 2026 23:20:33 -0700 (PDT)
X-Received: by 2002:a05:6a21:3a85:b0:3c0:9c18:d5ac with SMTP id
 adf61e73a8af0-3c0bd237362mr11852149637.73.1783664432826; 
 Thu, 09 Jul 2026 23:20:32 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:20:32 -0700 (PDT)
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
Subject: [PATCH v4 05/97] tests/tcg: introduce meson.build
Date: Thu,  9 Jul 2026 23:18:43 -0700
Message-ID: <20260710062016.1818125-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX22D+i8uwVuYB
 JJ4WjdmxIMr8zcLtjPA1dWGxzvj0gNybfQDcGb6UxEbuBAh9DKrB7wYyHxMbEB1qynTF/RPGw5T
 cuC1dm5mh/yYEmikKK51ZtVWq3dXPBPJR45iyCNT6AZC/w+Gv34X1mnUTjE6haXFN4wGH2d3Sds
 Chv1/eh26FgD1UvCBzQ8iMP4p8AtkakNLiiHTffR5lb8bZHOFvff/439lOli1GncVuW7jvFx/9a
 qNTn2O5pKutrC7p9sBhTBHuwv7YdNRo+rJ4ofukHh0RVgapqciKTJwOLszJ9OT3v4gbtEUu+egJ
 pkL4SmdXiELClrz/F4jJG6+LdmCQzVoBut2+aoD/BLnCt2QMzxBDSSLaGGBaWALcfHFVkpRl1BF
 anPxevqZpLYdUNeoBoiznIWoHy2ZsiEhA/dnHBmt2fWd6ahZDiWAsEvQiDW0y75fNBmgLBLQEFf
 jp+OcHYvHFUAOU15ALw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX9r4H5hxnOZmq
 0XWMyOUlVFQRQRGlfTNQw5sgQRHBQGUG6IoLxfbmkZpL4K/uvwrriL+rP7uloczkAFDQtiXIj8G
 1rEAYIQPwPGlPdJKlLQuVnqRKI+12VY=
X-Proofpoint-GUID: wrBtuePqaocur7KWjUET3_iuopGI78u-
X-Proofpoint-ORIG-GUID: wrBtuePqaocur7KWjUET3_iuopGI78u-
X-Authority-Analysis: v=2.4 cv=GJ441ONK c=1 sm=1 tr=0 ts=6a508f32 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=abvXrOxmeSwasVr9r6gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100058
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

Every target declare its tests, and add them in global tcg_tests
dictionary, indexed by target name. See comment for full description.

We make sure that if a user repeats a test several time it won't result
in duplicated executables or tests. In next commits, we'll introduce
what's needed to deal with that.

A test is compiled from a single source file (and later, a single set of
compile flags). We make sure dependencies are correctly handled by
generating a depfile.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/meson.build     |  2 +-
 tests/tcg/meson.build | 95 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/meson.build

diff --git a/tests/meson.build b/tests/meson.build
index 9ba04bbedd3..5877d2f60b1 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -74,7 +74,7 @@ subdir('decode')
 
 if 'CONFIG_TCG' in config_all_accel
   subdir('fp')
-  subdir('tcg/plugins')
+  subdir('tcg')
 endif
 
 subdir('audio')
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
new file mode 100644
index 00000000000..0cfb39b0902
--- /dev/null
+++ b/tests/tcg/meson.build
@@ -0,0 +1,95 @@
+env = find_program('env')
+
+tcg_tests = {}
+# tcg_tests is a dictionary with following structure:
+#
+# {
+#   'name_of_target': {
+#     'cc': cross_compiler,
+#     'folder': 'folder_for_test_src_files',
+#     'qemu': emulators['qemu-...'],
+#     'tests': [
+#       {
+#         'src_file': {
+#         }
+#       },
+#       ...
+#     ]
+#   }
+# }
+#
+# Every test executable, is built only once.
+# Tests for a given src use the same executable by default, and their definition
+# is guaranteed to be unique also.
+# Default name is derived from src.
+
+# plugins come first, as we need to build the list
+subdir('plugins')
+
+# Finally, we can create all test executables and test targets
+foreach target, plan: tcg_tests
+  # Detect duplicated executables/tests, and report an error to force user to
+  # choose how to deal with it.
+  built_tests = {}
+  added_tests = {}
+
+  # return a clear error if user misspell a target entry
+  foreach key, _ : plan
+    allowed = ['cc', 'folder', 'qemu', 'tests']
+    if key not in allowed
+      error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
+            ' (possible: [' + ', '.join(allowed) + '])')
+    endif
+  endforeach
+
+  cc = plan['cc']
+  folder = plan['folder']
+  qemu = plan['qemu']
+  tests = plan['tests']
+
+  foreach t : tests
+    foreach src, setup: t
+      # meson '/' operator drops left operand if right is an absolute path
+      src = folder / src
+      file = files(src)
+      exe_name = fs.stem(src)
+
+      exe_name = target + '-' + exe_name
+      test_name = exe_name
+
+      if test_name in added_tests
+        error('test ' + test_name + ' was already added: ' +
+              'specify a different \'test_name\'')
+      endif
+
+      # build executable if needed
+      if exe_name not in built_tests
+        exe = custom_target(exe_name,
+                            input: file,
+                            command: [cc, '@INPUT@',
+                                      '-o', '@OUTPUT@', '-static',
+                                      '-MMD', '-MF', '@DEPFILE@',
+                                      '-Wall', '-Werror',
+                                      '-O0', '-g', '-fno-strict-aliasing',
+                                      ],
+                            depfile: exe_name + '.d',
+                            output: exe_name + '.test',
+                            build_by_default: false)
+        built_tests += {exe_name: exe}
+      endif
+
+      depends = []
+
+      exe = built_tests[exe_name]
+      cmd = [qemu, exe]
+
+      # some tests expect QEMU env var to be set
+      cmd = ['QEMU=' + qemu.full_path(), cmd]
+
+      test(test_name, env, args: cmd,
+           depends: depends,
+           suite: ['tcg', 'tcg-' + target])
+      added_tests += {test_name: true}
+    endforeach
+  endforeach
+endforeach
-- 
2.47.3


