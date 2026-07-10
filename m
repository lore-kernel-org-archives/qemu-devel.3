Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21238C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ13-0004sT-VE; Fri, 10 Jul 2026 17:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ11-0004rF-6z
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ0z-0003Od-6g
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:10 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ALCl6B1931562
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 23clkxE9IGN9MCB+lwrybmPg+FD2HY1IyTolsbBeGnQ=; b=OHq89XijxAj2jeqK
 7bF8QiK9CNC+y+xoPDyYWVXfihjOCn7GVKBBsBm+QeA5jofYzWufxiWBEuxlZsFi
 t2644hWUakOdW+mNNll/kqrRvbC4pAJeH3BAGlJmpZ1MkOkb2fOuOV1+IgK2WEuj
 b6UT6WZFr4RVlqto+2bJsHnF9FcZ5Ynw1m32razwt+p4XujS9yUuGllWXo9YmvGb
 Utt4zmjfSx8ED4yUHPWoV5FysD/LUdPwPoQtOcicVwMxVWR4oOhB0fSAWWG6BsP4
 S1zHhDt5gH/PooXCmZSawqG/0Pk8JU2uOwlEAEYiollJtoj6atWell2uvd8eZzZp
 aIDSeA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb8f2r2hm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:08 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca7c1e22995so2215569a12.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719847; x=1784324647; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=23clkxE9IGN9MCB+lwrybmPg+FD2HY1IyTolsbBeGnQ=;
 b=XhdJjhW8X0crAxwNovapPNX2mJNiStaNHOYiYbQzUY+UbF01kzaDcd5MGnwcFmqZ3p
 EjtL6OmZK1yqI5+GjVCYFXIsftkgHu781tVoeaciuMKMrOPOY7gmbCJSVCyX/efSUXid
 VlyNl4AMvrmKnrddkFK2oH/mK/hnk0bg0/+gouarl0lZLqQvNWEtWbWuhdXsrgWP51+t
 8aLO9WfD0EB50+ikUbnfN3eD/DzlB4eywFzAWxLmPN1cbhAOLJYx8RDwpBaU/qaicB/2
 oRW4w8mVzsDxIroO+b6hGvDhRi7dMUanEVDExCGw1u2yOZZudnWkuy86CcfIe7WTqtDI
 utRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719847; x=1784324647;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=23clkxE9IGN9MCB+lwrybmPg+FD2HY1IyTolsbBeGnQ=;
 b=GYd4zbzuMd6lHQ1UFmADJcGbm1BVbk2R0htxXNr/bo9HnGpsAxfCg7GXHGbFIwCXDG
 K7k6hwrixmfsANe570ALmwDIzxlput7FujfEnNeE6NaoamqnSV3Y+p3WtC63H5W3wxqq
 4WKK1hJ0GVofc3AyMKprP8u6GfkCmsFOE4kCkLGHgjAqE6hz8ja/UyuKnshF09MxZytl
 lwf43DuwsOx0ABYxZrP95Udh67uXfHb/RyNHbxTLRgIGoGUSMFIm9fH1Rs8yvFRm99ux
 C/OdL/5NybWlONn8ZbQSZ2rG1PEcZvFtbdF5AtkGd9bMWM6yChy99tbzQs4VyWMi06KR
 DDlQ==
X-Gm-Message-State: AOJu0YwFyaTWgKg+pqkb8Bwi5qFsw8W8EYwzQSMiHA4m8MVQQ/AHgbrx
 xoL8fAOnjJ7pEH6I1WgHX7GJ9KORIMhfJhsNqouoevAGhKzjXE8FnIKov6MfdulK1x4walY7aic
 5ffQfwxefwH64I0w7EewgcHbZMzGT5himWLM0ZN4sGZGPnV8YcqsMKbgFHGoUg2GtUw==
X-Gm-Gg: AfdE7clq7R7MDTExGXdxFkK+tVrjqVmZ3BlS0iBvIcpoQtJb0m+7QmHISNqvVorbCEI
 YAGKmtfViWYcXtoSMsdgqx72LEpokGEK6ZsXPGHqwEaI+9FqGzNO0GgklRO6imcsMP6OeL5iJgH
 Wyv8tyWo6IjOBllKQnH6UxesaYBA/U+mhQZOcH3GPRzS8rkUHv4py/R9pCIkRS5nl0VgtFqWZLj
 g6O8Qf3jsmz6Fr/bY6KqUymBTVLGiJhnlFdilI9qH5X0ifNWWfUQIZOCb9vcRYRw/ARreb7+opi
 UQ8wzwSiqVno27ve+RzMUVU1JoRGozybfSlZzINVZu+FCYkRp5SB2NXUuAphQbbxz8cTmpk6OEw
 LUEsIoknugvYSgw5dc/Gs7UK9oLX89gh+9FP/lMIwKujd6zFV+BZrLCIVGii9xuFBMd0mEw2vGl
 HAshHPVA==
X-Received: by 2002:a05:6a21:3992:b0:3b3:2703:115 with SMTP id
 adf61e73a8af0-3c110157a21mr723508637.16.1783719847070; 
 Fri, 10 Jul 2026 14:44:07 -0700 (PDT)
X-Received: by 2002:a05:6a21:3992:b0:3b3:2703:115 with SMTP id
 adf61e73a8af0-3c110157a21mr723492637.16.1783719846630; 
 Fri, 10 Jul 2026 14:44:06 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:06 -0700 (PDT)
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
Subject: [PATCH v5 05/98] tests/tcg: introduce meson.build
Date: Fri, 10 Jul 2026 14:42:09 -0700
Message-ID: <20260710214343.2065491-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YLavDxGx c=1 sm=1 tr=0 ts=6a5167a8 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=abvXrOxmeSwasVr9r6gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: vQByA7Vh4k4PNDXud5fhxMUT_wx8mm1x
X-Proofpoint-ORIG-GUID: vQByA7Vh4k4PNDXud5fhxMUT_wx8mm1x
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfXxJ7Nol+1xlR1
 FYkvmChuF9G7niVGMs3uvFW75zbGUDYwBi4UZZvoh1PXoVgpvewo+O6nrydneWFCWob6gN5mYS8
 c+kYRikvNo8GN43ckmQoTYD0QGcCxdc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX3JJenBp4ZRPG
 Ev33FdHoIroSps15jdi4Y+CVIFRP89gu4WvkevCeKv0Hy6b48XSHIEMvYtF+G3xcxZus2w4exdy
 X4g3KaU0Xm2mlB1NKxL4jBVtTiKtcQ0V7FBDc1iT6u89l7HAHhz7aMu6yJB23qAq0+4lbQ3B/Ev
 KZazhnrj9XwfNp7ST7IhteyirB8EaLMWCICdj2SBIEEcQtjkDbmDdrvTTY+wiHKxAnaDcD1OAq9
 KigTIgjueutNvxxigElcJmTwWZso4Cp524M9vgagc+ZOl3ipHCA9expFKAYC8YuSYdmF13kPZ1U
 DNu5JaGSSbxNu01+BHo/xKmeymRaiCOKQQSn+Gb3R9USclNMfaanX83gYw3/GWVJSdOcVytvdN+
 RXvpYf6gdhuYUszfRNwJa4ERFoeOgV+1PH4QZJQanKcHGsNZWTzZn8/IwxhJCGfc024rhZt86Uq
 eRQ1CbbsMPq58KsxVUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100218
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


