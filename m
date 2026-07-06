Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2244C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrtz-0003UD-BZ; Mon, 06 Jul 2026 18:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrt8-0002g7-Le
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrt4-0005Lh-Oh
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:05 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE4gE1626316
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=PPjrxPaosry
 /9ZyAS+MkHVcOT7fKjYeZT3xjMlhDH04=; b=XTITVjoNkIckohRQhP3mIBMMvpR
 roQMLXuA/8dKCcpzHPjHbjJYBQZEXq23BJEgrHuqSw82n9Upv0WTZBkyXPc10RxA
 ykbhX0VeamWkCqgrGwF1Yj+wwxliGye2Z+JOFT6b+qqlM6/5acPW/U/THpGgQCwn
 d3h3Wzx4XJ1tbc65kbL9KO1VvRrovo6BLluUws4ycacS5olAK65nb5kn4vL+FDJv
 4jb27FcFE7NIcbcM9yowIOAcbwOsDo0w/SJfehJIEfYWIo3zUkntEwWgQxm0yOyt
 F53CNqMoUaxywEMen6toYTCtibPNtwTZ/1ErSj8DxWPmi48eDIz9MFL/T6Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h9bn3r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:00 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88aab7c1d4so3022596a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377240; x=1783982040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PPjrxPaosry/9ZyAS+MkHVcOT7fKjYeZT3xjMlhDH04=;
 b=QgY9IyIDVk8wHok8v5TZ4fIJUnRL3PpfpbSdDO3rcAqXDbnKTuUzEiSf0w79M6njE5
 EwZmLjdMlNipsmvsvwXDbsBYOXqG3Y06MpePNqnkAHx2hw71qsOZZwIP9+2uL7R8DEuY
 HGaA9rPQ++OEckd7yPjAet3A1aELFgOOOqMVBn1qAA3f4NFtKtrdNyecB1t4pt9xdR4B
 xmE7Gtodkn7rYT+AlFnq4DyoBV9vYwWTYI3HOXG/sqYu5FfwzWax2KkT9r+KqNVF26qq
 qgB8CdxpWQ8lYaaAmdbdb4Bl3NMz1PlVYciYa/MKJPzL1SrZxoAI78ygmLQwXzKEVnul
 TeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377240; x=1783982040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PPjrxPaosry/9ZyAS+MkHVcOT7fKjYeZT3xjMlhDH04=;
 b=Pp12HU5fw/POfZO+lb85dhRDReA+mGSsoisyFQxvp21hMZpN8MBlqFPMUkjlgByhIA
 BpTmACsr4GvB17D0HvuX14khxc6sQEwj0RZU2tfFDqVwFpVERt3YOvgGju/8KgPp0Ho5
 cvrZra37k9XTAXOEmAtaXMMUkB7lSBO3B+PzSvO0mHO37jPHXwY2Cz+0D3KZ3+mAGROs
 C6wx3nsnAbeFV+astHIGr0HOIrbW9OF8fEjDPDPGG2/h6T6ikA/5mSkVF+/IP2oQsKpI
 rX4XmaEynxzoGZTC9QbO6otMGdHt0WhpR3YI7ph5Jkq7bNjv8rFNCi94nK6WCMFG/kj2
 9aeA==
X-Gm-Message-State: AOJu0Yz8hNwzU2WtrC7SRbh/XW/w1SRfBjMjyZnzKUYyxkDuQd2jrUCR
 7bWdrO/ZurbV1n+32vACL/03jx4EJ1UBrMPm2+TMTOBCYEHLhoNTEd6KVUcp5CZuiMRC1oJY2pV
 2fB358qIV5nTapASlSyyewlPIu5O5MSt1TL4OHahNyoWpPgVTt5dErenFQoAORSs1tA==
X-Gm-Gg: AfdE7ckYCCdCgIDRKwX6sU4Xv/2QuOBXnvAilnQMtU9pb8YwwP8IKMQeg6FypDfTPwH
 nkO0UHQUJ5Ueo9dDYTn2+z0fXUhsG/YkyLTKkM72RUvxZ5RxKbFCK9bnqPX/GJBw9KE0FwyG/lJ
 Nm2An5jnLRxW7frTcsFBxgzy2t38moCjPQvBhxi1UnLuFcad5j442TnwoZIqj4c95uRO0sGH8h3
 8ODhUMnAIPYsJAUK86h15tngJdPqO8VuNRTkbPsJ7qW/neBqID+0+7bTVVzjMbq8n+xgTe1Gkbm
 xK76aXnnEm7CIw2wFHgCrvvRSXznpRUmPKT7FVClER9+iqpWZHHBwFyGR8+c+svDImErOPA5b1Y
 U4Gg7xhWM/v59OlALgVwiOSWCgY2N6gwjh7AxjGhk4hVLT7fs4iFFd153KTAKGJVT2vkHpAhtbp
 zQgknLDw==
X-Received: by 2002:a17:90b:1d52:b0:37f:d9dc:557 with SMTP id
 98e67ed59e1d1-38756ce150bmr2828565a91.16.1783377239676; 
 Mon, 06 Jul 2026 15:33:59 -0700 (PDT)
X-Received: by 2002:a17:90b:1d52:b0:37f:d9dc:557 with SMTP id
 98e67ed59e1d1-38756ce150bmr2828535a91.16.1783377239216; 
 Mon, 06 Jul 2026 15:33:59 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:33:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 04/91] tests/tcg: introduce meson.build
Date: Mon,  6 Jul 2026 15:32:16 -0700
Message-ID: <20260706223343.988769-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: s3T5KTfGoMzdpa7ByRATzwKONaTew0Yk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX/5gyZzI/Cr6M
 LELEbk0TlRPWChJFOaE4NTkblkCoB1DI3jLqApdzwQyb/0m8+Cr4EfjznoQ9bwpHsVuS48Vha8y
 TzBsVNRabPoIc2pYgKRVcfdMLlPvWdo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX6xm9iZZafxrC
 RR+6kpbas7h07NE8nNip68FMQxbE2bu9RUU+nu1k+bY+ntTSQjvokvt+qnhhEKjl25fH69IOZ9j
 613eqhcoG9+RxXVACqFGlJum/RTWp9RGlbKxXYAAqBGT3aLn6Rs5g9lbuUfRv9H34jB/SbEyT/R
 9q7g/SCJ84R0+b3aBgvQUdiePOryySVm3vQ017fJq1ju/QS1VDN0Ou0PcrLihSt42cAe8+rEEmm
 BCg3vaSkB+sYQSTrtBXk95CiOF5PV+hMGSktCjXZTlOhIPqg2aZLJxoQh0A8iOlwaiL8v9a0WIL
 a/TeasiU8b/HbgT1nYGlrZSF4U0eYrY9DpQlT1DZ+oYGx16UtdOi2vi2vBfPjwX3rq/RqGcV5A/
 JL0fS4/XJ/9C3d1eWw8putC1h3AxLRSmYIUlsakCWQu6BIoBZLFuxnW5HR8yqL5iVIeo/IbdbMk
 quOPIZcLRjIk/ebPLPw==
X-Proofpoint-GUID: s3T5KTfGoMzdpa7ByRATzwKONaTew0Yk
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4c2d58 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=abvXrOxmeSwasVr9r6gA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
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


