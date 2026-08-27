Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74079C61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFT-000782-74; Thu, 27 Aug 2026 18:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFS-00077r-HR
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFQ-0003BS-Oi
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:02 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLr5l547167
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uIoY4rvTGP55FLHZ/NlkTsMOtsIeXWkIny18AEhws2o=; b=SCYy+GktAXkXlPwp
 ylcUAno0gFC8Gl0n5iOr5UQi78PnMB/Wv3dnbA0yjQIurcGU4kGc54VAGGUQXKeK
 8aUgFxYaFy+l+OmDUuNMknpCJpczx1N8x7cybMHwDFjeqBN6MJ1l2PjOu+qE8K6L
 36sROm5pZrQwRhnmERX1SNXuLWDVNOWvSeGIcb/CT/9Ti5nEQelZjOqBWBaymlED
 surwJm5njqj3RwU6xFenHakTylm51Xuggg7eKQghOnn4sZs4ynPgKvnI6ZiAAtzY
 vv1AjA/ethsC9gMSmRd8XFSNmUyRNzi1quEttjebtG7HvYf0N2ops/msTXi2Jusb
 6AODsA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gak562skx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:06:57 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-854f274dd69so750602b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868417; x=1788473217; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uIoY4rvTGP55FLHZ/NlkTsMOtsIeXWkIny18AEhws2o=;
 b=YCvNKiiXBKqJDuIkLzSkNGoZtNE0vNAI+HsmDQX5igRvjsNKQXFn//aTakMI8iAmHY
 S/wH7Ln6u5D6HJNS4JuzAxIVibbFAL+csLD34iS++EhQFkNlcicvGgIYb0yCNjLklNZB
 EE3Z4dzPnResYZGCzxFGnkZAtF70qGZjJqgMfvOrxoeLWzMItOl99hiRGLU9LJ6/a1cd
 ljcU3Y/usGcg4QWKUSwansaW+KFCAihBRoEFAuz4hHWMj5WPRzZ4EIcUnmvi+tYEasZd
 nE+n3uQOF2J61dSfsi9vVbF8J3gxupHm784vlM0kc3rGRb9Y0zcdOC/u/inVQFDdUO3K
 IewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868417; x=1788473217;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uIoY4rvTGP55FLHZ/NlkTsMOtsIeXWkIny18AEhws2o=;
 b=mVVGS7f5bYau8o9xNZFvNNK0sp7IeMSxStLi5EzgGFYbEPMqiBFkJXO8GDSjKJG9tC
 xXfjCMR2O4FQ9N+x3nR/HGrc8QphweNxTt3tPft4YwOIpe0K8GJupszk939HiGgYx1XS
 r6WejiYh4wDE+/5m5T/tKVCdCLcqDR+nW5anD1TZUqhUm2JZ+JWfN8DO++xm63YhwzXa
 GiucA59N9k0c6ldgoNig+6UOS7nLHcyYHzE0vQQlRDf2LfzluWx7LZ8qicW2mwDSK1mI
 pwlXQo/2poKWjRRwaWAjtHnrIFLAx+jBvZ8TzY52p3xx+1D15NoTXTWknXRGngsD98EY
 zdOw==
X-Gm-Message-State: AFuF++la4eW52pTeBuGkF1DJ6c+UYMQWViOTEzF1aXf04xOYrg6c8qDY
 Kw3ZkZay6Dn3cU18gaOJlVpwLCGcZi3K5Zy6mGpcKAqAnb0jJSM7I+IzaVvE2xm0atYZaSCcYjT
 EoNzkhGmcAC2y4AnKn9XEzTgA6dEBZlxPkFK9zl/jTtadoq/W3dBjI1MYNI9+l1jSrg==
X-Gm-Gg: AR+sD11GOvmyjqK3AfmyI+o+9RqFZ+SGDBUu2bJAB2rbdZeSXWfVm9JR619PZhVUU8O
 e+S9QrCsJsPRG3U0m9reIDLu1ol/Szgdbk3vL3bQSgYf8XymEkC6DirSC0KxCXsgXDc8yXdtmgZ
 PL2scwhJB5a8TvjTdVsCqPhTJOlnO3PN1UVHxzFEsXxq+dUD+gGA8ylubE9H04w2rEDHlPY8KeT
 9Ompmgjb3fRb/PNs2T2226lLVSZXe7NM2j68QOX86jAihdfLaHRScJz8Q7eH6UxnFSCly+R3WxG
 QzjOK0Pfn/Oxv3kpBLBpQsVezKnv4S/761CIsFgfrDEfSXKeyFZANxYC2/UOmJeZoawHRakFdRm
 YiJhEeMkTKGPSnGSo1GV6u/38Na7pgL4Q9hWMw5gUVMFaPFjCRMWwhcPzc+0=
X-Received: by 2002:a05:6a00:4109:b0:852:38ea:3fd with SMTP id
 d2e1a72fcca58-85629a252e3mr4294969b3a.11.1787868416783; 
 Thu, 27 Aug 2026 15:06:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:4109:b0:852:38ea:3fd with SMTP id
 d2e1a72fcca58-85629a252e3mr4294873b3a.11.1787868416273; 
 Thu, 27 Aug 2026 15:06:56 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:06:55 -0700 (PDT)
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
Subject: [PATCH v8 005/105] tests/tcg: introduce meson.build
Date: Thu, 27 Aug 2026 22:04:59 +0000
Message-ID: <20260827220641.84885-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX1eaYy6yMxkjV
 FC5R6bCI5QAxxDXltx2aOhiYl3Nq6iP4amhHzH7XbaapEuXKfcLl+tPZa6QEf38f1yRyJv++zYl
 UElacjK7US9PttpZarNe+W3WCGATg9Y=
X-Proofpoint-ORIG-GUID: vxlfT4ks4KS5SrXtahQAdZRGkCE9ICzm
X-Proofpoint-GUID: vxlfT4ks4KS5SrXtahQAdZRGkCE9ICzm
X-Authority-Analysis: v=2.4 cv=G+Ms1dk5 c=1 sm=1 tr=0 ts=6a90b501 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=v_12uhcQQg0w4xMxk_YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX6P95MnxWgDW5
 uj8fKGdxHfB2f2iNKVjpMkd1uV3o5sM2CovI+jaenLjyEID+oX14hwLEWcDVq+ZqFuYae9R/0Wn
 SUaolGCI2Ly6zpB6W0Rgs5BVbucSBIRDqO+fHD5Kyhp7RZL0H+lZA3UaEpXoH45rwmYcT39e3D5
 u6ONmlq0VfYZsmLGrxEgn1vCh8U68g6Nn0c6GT2MhQk3bQrgTNz14Gs1gkKpKotlkwzkn3Y49WA
 dqlQX58fF5QabXiJOYLwXllvi5IbHw4T4a1ADYMd9epGO+W1YX6XH+C78ou8bwWh2DBwYZxhk5+
 z1ua9r4IpnH2VadaL0Ur8MzWmQFt3CI4giduKUOESLA5RcKLO2PXLQ2VJw11a44nQC1n1+EIn0U
 p8mcO7rh6ykdC9Pn5uaP1jgRgT89Bh2xrZKKJI2LT6zvPbVrPcyZ6miW8KF4RYF4au+Qs8CxlWf
 0r7ejChG+gzj5eIzGpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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


