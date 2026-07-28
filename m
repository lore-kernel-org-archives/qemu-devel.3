Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AC6C54F51
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZf5-0004Nm-8V; Tue, 28 Jul 2026 00:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZew-0004Lc-Q7
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZev-0001TK-3y
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:18 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3abqI1527468
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 23clkxE9IGN9MCB+lwrybmPg+FD2HY1IyTolsbBeGnQ=; b=b1CRoUS8aeJER4ta
 a+0fWX+eD1BKke5uEgR0nZKESxli+8XxYYksvYsFFVAJ3DAqoK4lAw9uFm6Gpz85
 O33eRS4nUSpzIJKl8mTLghZ7NiiWVsTb9pCy+F8ycfV/k+bDn1npoT4sTHoULVIE
 kxKByn0PcpeTjVyw2LkePiM+gY/UhAacZHQNL6glS0Sjlidjhtl7wLc0p+eyqYWj
 ZUUQxdMlF3kgpAz5/jWDjwRydU1gfqulPNPsK8UGoLWlOZj2r/ajmlUKJsLtn8nQ
 qEl7oPfv/HI0EpHc9RjUAFDYUG1WsdYSgZXvGMghdDYdjyyAgXmGamGHdmgdLuAw
 d1+Ivw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbn8acu5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:16 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e11baa66eso3683357a91.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213795; x=1785818595; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=23clkxE9IGN9MCB+lwrybmPg+FD2HY1IyTolsbBeGnQ=;
 b=KlzPrlxqMuI2MdfhR5oc8+O3se999zu/CC6DND1WYTGLavEsW1a+vw8BoVIGyoNuwo
 xeoo95921xvzax8kP9Xw9OMDzEun0Cx9u/MwiPBVHDbXB0uEkWCiyl9JpFE9LnrEhmRb
 dj5nrKbZstYan0OxkNmS+0JXaiKNQ4T8vJ7CdKheUTJCDI47ctUPnHGx26lFhMNP1rlR
 7OfcdT3zbongTatBTTVovLrLbbUXz4t8FXRqzb34QHT+Qv2VhA68eKTwl4coX+faIi1S
 3YN38Px6wyTUdsWFei3MbkSgt6PlZW7BNsck+1VETSAZPa/aMm7Bf+eLkNa/rRFNTA5I
 Zqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213795; x=1785818595;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=23clkxE9IGN9MCB+lwrybmPg+FD2HY1IyTolsbBeGnQ=;
 b=lftXcsiGQHyQK02eacrLQVka07N18pryNhyr79aMtlVdz87FICsW/QGyteqTJugOw4
 WShwjqzmO1dyZrtSpnhJoFP2/VCVD6sds+D8zbei7TK1d7jl54bEhl1SDVVc1Y9bnxGT
 1ssvaSzvvcHiEGKdCsdhA+sPsIy0jVHzcP+cozxcYSPDOV96s2itcpCjd+K0O4B+HFCN
 xGyQ8QJTMe92Lalqsr1ZkLIMykqRaNXI2iDB3jSvSUqUk/aL1dXtYQ9YnSOchJHMwyLE
 tbw0vVjjBP3SwA0TQ0etQv0ZgGzAuPtju2EYRV5160XFHoFt1eRw0t1CYbf4eDnVlVh6
 gOmg==
X-Gm-Message-State: AOJu0YxwgEr9kkSJ686cTyPzXMWKKYxFfT4KUynLBORdCylhKKim3P0w
 jDxjCADyTCBlTBjQtGkFIeDEMviGoRYRoYiXRDLJHTcCDtzA9RoXW/7mkcnNFB1A2Bi+LAGEUBw
 C0aI/YeO6FFzCUXo/bGv+mgaxvdbuuEu42csc4N28KmRD3EiWQLGruTZMNY12NI1rwg==
X-Gm-Gg: AR+sD10dc8uEpXEWdYCkNZJ+JNwIq0w7j5dz3iRi5FACOqAq937G4YYZoMVuUXr/x/c
 HYvRExF1z7SbFLeeXYLe9pE0/hWcK/CSz0Bq7CtA+rKe+dtn0tw9JSQQpueY9ANoDRq3pF6C2Ny
 ho9LG1MqQexgm4R3jQg8JaA5Q6R/7rOaw+oD+wNSWvKjHv7WohadYTEuDdERnNJ4WMWx8Qco7Gd
 Ii8mhGQT/FBWyPBtZxS+jYdvMLV97gN/b1bnrH1J7C1m31/yi3GSYK/MC/T+jsxIZG9lD3U0Q7u
 mnX8me6vlSvYkq6Otzlc9dVYypnGrkQwOPy2TAZ7dLV4T21NiOaa+LKoZgd7hCs1YndLlUbmVD8
 TphgRLLpk3vkpn8CFb4n6z8Z5e9FWJcgFRhWaEMoLR86msTrr4rvBhJ7FNfkLR2zJDekNVFY=
X-Received: by 2002:a17:90b:3848:b0:38e:4e62:f998 with SMTP id
 98e67ed59e1d1-38f6a556542mr969725a91.23.1785213794912; 
 Mon, 27 Jul 2026 21:43:14 -0700 (PDT)
X-Received: by 2002:a17:90b:3848:b0:38e:4e62:f998 with SMTP id
 98e67ed59e1d1-38f6a556542mr968955a91.23.1785213784095; 
 Mon, 27 Jul 2026 21:43:04 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:03 -0700 (PDT)
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
Subject: [PATCH v6 005/103] tests/tcg: introduce meson.build
Date: Mon, 27 Jul 2026 21:41:09 -0700
Message-ID: <20260728044248.137626-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX3wCYzfHDiqRW
 ORel4MDlrbfMn8QnalR/KBkJUkVN8KVeXTqVgjvdQxwZ6QfiG9i5e1Bgr4+Rqo6LFdwepRSXapE
 iTDz7RZvOt77ImEYREcXwsSuACT0Mn3yTcCUQZbesu3+edp4Y8Q1++viGmBLT3WxWWQ2oktkmHB
 BOKfUEQEgCVG/BLqPa2o8U5MgqHGCBThA3lNuJFVztY8u6+j+qyIQPNz+ByGNbzeHWYgkiVhD6H
 Y0hyUqVnmGQKmHfUr0wRIMEcy7ogZB+AI3wa/JEcVwZahEXxD/IhVFKxHVr1ow1BVhNFj2npmRy
 A5IKfXLbelIyJD+4R8YrLgpeMjE9vq5BsSMq5V4FldSoiVQZ3ocjcpBa+YWUy/VbW8e5e5m4oz2
 kEWXIuexAVaBGAPVXzQaNJ3igqYR4Tbd3aL0OO/gvonB9E+83Z/ACPAjUyvlCL4haj0473KOLaa
 /BtWu/0gRrvxTIR94AA==
X-Authority-Analysis: v=2.4 cv=RO+D2Yi+ c=1 sm=1 tr=0 ts=6a683364 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=abvXrOxmeSwasVr9r6gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: QPQjHdmMuD_-NSj8Wzx8ZEI1OMhue8aM
X-Proofpoint-GUID: QPQjHdmMuD_-NSj8Wzx8ZEI1OMhue8aM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX7RzjIeXsWVbt
 GyXx0VM9olniErbX+SCW2Td2G+5YeHkf61VBEh8yuFQ6uN1oUBdun6qwMRXzy92UVlhd6tf3xUm
 qygnb0abqJh6wS6yY3nczILsqKFghTY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
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
2.47.3


