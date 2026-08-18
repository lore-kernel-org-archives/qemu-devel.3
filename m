Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43C9C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPH-0006aS-0p; Tue, 18 Aug 2026 15:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPE-0006Zp-RX
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPC-0006YT-Ul
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:28 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH4v53003284
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uIoY4rvTGP55FLHZ/NlkTsMOtsIeXWkIny18AEhws2o=; b=JzfrU2yxymmXEsh+
 933/FVH6SP4kHxFx5xEKg687pZ3J/ll57rI+RTSu45uHrS54HjF0Rn720Uto1miR
 Ng0imrCatc1id7lxc1ULvUtDC+/KcNzAu3HyQJAzoptiwHNttDHeI3Ot9bUoKCuD
 QcquMxrydRcWIzH3IxfD4OxUfDbQjYniFR7k1n0MND65w3wTEPaRs/+EF4h0agSt
 rtQz7Ig/9MjbkIjXOwZOhBB0SOR6KaJ+Wes0TUClfIxsc1LvHTDCOy1m/dyKXgyA
 TdvmIcCwjP27mBo1X1xDsgDlG0W/SDLC11xa9EFbxgcEnq7jQWd/8HAEemg1IVqY
 UabScQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4frmv3b8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:25 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2caf4173b1cso2369935ad.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081005; x=1787685805; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uIoY4rvTGP55FLHZ/NlkTsMOtsIeXWkIny18AEhws2o=;
 b=GfIAKjCExbOVgD7lADD2V8xXGgMlX3hJR5D4S8xC5v6AM2VzbTSyQaQLh1Mzsafbag
 eOiOAQEzav/so5rGtXf9f0GbqABVlzdQWoZFO840v4kdTTe2DjpaYoviT/u0nA3gqhTE
 JsSgxpoNnQaGxwP9xFPyslh25rEonDUI+ujOqoYfaeBhfeClCvXwOm4azrPhO9QELXJZ
 stvIHl2AlaamrNKECzVyEK+RlYQcXPn+ifm6aQt0GoV5ANnBHEETMOchEZNj9Acj3l9+
 b7cho/FY2E/kQaMN2wpWLhosB9t9sdIOddX+IZn4+cvdVGASiwqLaxqHZQL3SgB9anyg
 tHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081005; x=1787685805;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uIoY4rvTGP55FLHZ/NlkTsMOtsIeXWkIny18AEhws2o=;
 b=VIg/fzOEDE5ebO/RjOFHmA4EcMAsl24BxU2npCPzKIKt7fvPLH/VjdO4bp2PDdtV1C
 oQyOXQcfahqJDhz6i4Eo8DGBz4xkUEld9Fw/k0ZPn8UHf1RWygqDniZt5w1NZmKy1sXr
 fKYyN+2jRWxbiqoUftNV7l+YvkvTjzWSiMCH50FGTWZa4iN7idW57xiYoly8N3p0UCbV
 WCxiTibkanMX5G03PDsfWdb1Ul/hq3NP4dGXgwQM2HbdQn6irhBiczmhaTsyAMafjtyR
 KzBVOA2dG9mwMOzap543c62UGPnS+Y25rcWg/0HRLLERDw76Q3UC+4yan+Tf94b5CizW
 cYdg==
X-Gm-Message-State: AOJu0YzimmDOI0AKGBcsZLksP4Qedx/8PBRLZzg/r8bmxDtOQCx4wCQ9
 Lj2Yw0tBGtFBpE3vJlZd+7SX48JCn7e36DvtuduLVQZiBDBTTNCqrtJ4xNQgLome7s6dXUqEwMQ
 ATIsxkJjt5wDdZzDF0kFug8d0e8I7ly0RdHZco53eF9vO3oEe0i8+Mohg3+90FKYgpA==
X-Gm-Gg: AR+sD10VB2zMn6CfHNxn00reWf4bOX/dQgrTrLvJ0HKe0MJuug3b78KJQVB5FmB5Egg
 gk4T3dqJSHhEWSprJkW7DkCetRX2bZ8FPRaJQTg5XLmlmNWlUCOsMTolUP+IWr0gJ8JmrbRlF1g
 xfqksFL1SxKZhRnaOU9FCc4nOlhc5tzfGr9s/SR5F3bsvOmX/zGotS4DZwdYnJ0DXVdvpsFrAE7
 9QPe3udiPzsbm1ytSXxLig9FTGEsDrx5TTbs3kh2nXhK7l8eT4O1SjR64rFvuzNNNfs3VX8shVI
 /kSfaR9kjf/hcGFp4D0MWw5O9FglYQq41Ea6PMLhjJH8P40rmR6wMFc2BxTopR58LJHHi5Ou+X8
 t0Q9QojlOYf2hW+dz48+SAoaUXyexw00A+mBwWSyHNsKjVJswjevaqkO2qH8=
X-Received: by 2002:a17:902:fc8d:b0:2cc:aa36:c046 with SMTP id
 d9443c01a7336-2d5f6b6ef1cmr1700505ad.14.1787081004639; 
 Tue, 18 Aug 2026 12:23:24 -0700 (PDT)
X-Received: by 2002:a17:902:fc8d:b0:2cc:aa36:c046 with SMTP id
 d9443c01a7336-2d5f6b6ef1cmr1698675ad.14.1787081003469; 
 Tue, 18 Aug 2026 12:23:23 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:23 -0700 (PDT)
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
Subject: [PATCH v7 005/104] tests/tcg: introduce meson.build
Date: Tue, 18 Aug 2026 19:21:29 +0000
Message-ID: <20260818192309.22169-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXzjg7mLFJgCV5
 T4iFvm5xvJoAOLoqm1R0UWARpeRwf6CBSvoSu36KxtG7aHPsYEExxeJBbHb++ej74/M43tuztux
 DAKDVC+bh5iZKX/p0sYuk4FbbS1+V1/wfKS96LaGaUyQ8bckKlSstlfNEMPkvMjB+J9qYi7H5ld
 Pg1HHjnJzls7hZXPH6kllJlpSvELbzpAojwB7CbAh1Kw7jsOjbuhFZ/6SCyP7WikvD+feu2xkAh
 sbv+uwIW+vbljhYrItVcDTT8kuoctxdvfHX5AEAwYt5rF2YVZTSMieMPW0uDQdNC4M89oLTVfMM
 wE306iIHAbfhnj67/Xtbf+zQxSZ6zuRjCiV/cQbBmyvIpLKbycM5NdY78BfKFfi3l9gSwsIZVB3
 zHVSdu6EwfTtt+Pyw8L2J+LyEGFFqJChnD7Q3Hpp1gDVFt6DIxE7OLNYh28MHnHDd/ZFhjPBsHd
 Yz8Lg60aICWBTb0Il1w==
X-Proofpoint-GUID: OD7dmuxzJGNDaizEjR48PiJL-20GUjbv
X-Proofpoint-ORIG-GUID: OD7dmuxzJGNDaizEjR48PiJL-20GUjbv
X-Authority-Analysis: v=2.4 cv=GtlyPE1C c=1 sm=1 tr=0 ts=6a84b12d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=v_12uhcQQg0w4xMxk_YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX8UH808W7VKIP
 nqYBtByj0KwNwjzRrD9rtwlvg0clBkXgiX+siXsPU/huJYR/4LButJ543AC4sFhuLpzBaROkx3L
 57K/BV539/bOJCnAeopt9IvI7ExytYk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
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

Every target declare its tests, and add them in global tcg_tests
dictionary, indexed by target name. See comment for full description.

We make sure that if a user repeats a test several time it won't result
in duplicated executables or tests. In next commits, we'll introduce
what's needed to deal with that.

A test is compiled from a single source file (and later, a single set of
compile flags). We make sure dependencies are correctly handled by
generating a depfile.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/meson.build     |  2 +-
 tests/tcg/meson.build | 96 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+), 1 deletion(-)
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
index 00000000000..5758c7cc0b7
--- /dev/null
+++ b/tests/tcg/meson.build
@@ -0,0 +1,96 @@
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
+           timeout: 120,
+           suite: ['tcg', 'tcg-' + target])
+      added_tests += {test_name: true}
+    endforeach
+  endforeach
+endforeach
-- 
2.43.0


