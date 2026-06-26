Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48CAC43602
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG90-0003Mh-Vp; Fri, 26 Jun 2026 19:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG8y-0003K2-RU
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG8x-0003wk-4Y
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:32 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMxlMq2206944
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=u9B+aWFdu/K
 R04GQlv2bGISTHJgmI2RL2Z3EGgzYl68=; b=Cth+vy22PB7DWjYmHk+9Qa/PZSt
 pXywqwuBiZ3mfEHmzWaiPkV2dwNXFOQ3SOUKsnhlgyU3NUTdwy9XRu0oxJG1JVdR
 NexG61DGNLdVaZZkozvqNvVn2f+Xs87l5Pz1XeqrzDxAB5V81Ru0wv/imUIJmAiV
 0mtHzOBElqCLMpz7TwI0tZlclx1FpWnOATWViiuvXFSIvVDGKacYZp6ywcYHrsu/
 hbPdJLUtkbsVdXQLQzDf/ndXfGjft6hGKvkjn5bsZN/9f+uzpLn6CbLHMqXXOVPm
 N2gUBlPZrhhQvJu1GK1wyTrje3lAZ10jD5mcnZxn9dvQdNtC66NbdsxJnMA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1vm2hc8k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:29 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30ca81e05bfso1093956eec.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517169; x=1783121969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9B+aWFdu/KR04GQlv2bGISTHJgmI2RL2Z3EGgzYl68=;
 b=aVt84FFOf+trxqtNzHH+zkAwR5J4wXqkdTDsZpL4vNu3o6lZfsVziIez362E4oumfn
 D6FRJOPGl8twg1HxZ8PyDqv6em5NiDSiSV7IE8dkq5IPrsOdqFeJMUm+2OF9mdgptQUg
 srJTqjZNu91AuiuT7UgnmUWCQ6IeV7spmm368Eg9RdVq9D033u0a+ZPcjEMP0RrpNQ0C
 tfZFwOnqAwTYTRhUBjBQ1Bv+etxypTqibfraaaVB8x0jN1mkpkRTK78U+xVN8aq8/gfX
 A2cTJn/24GpdWEogAQLcfnZw+knQtPWL+aZEoCOmw68qRiTX+xqzZKhOJlhuThOo1lmv
 xFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517169; x=1783121969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u9B+aWFdu/KR04GQlv2bGISTHJgmI2RL2Z3EGgzYl68=;
 b=IRLys64KByNq5y+MD9nNAoazf2qv/WgEnNz2kKaMolyrloS0fw7iJR7LGkuWmFIg0h
 5O9f8bUIGwd2QsA6DnY6xYE8nxT+9yJHg9XTGL4u8fNyu0owtfgjWQw26o92KEJ+Yabg
 n1pKtWENLSgK6SW495NtSsMPiRGjN2+AAIBw6rGZ2ONMjDlKF+yYtgZwNqipoKxVbP8I
 ljBZJaOR8rqw+jyJbStWVKPnZy0fxv7ocfzKnHn+4O3f/R6nsUL86q0sQ3PzIdyGK/Sy
 melUmGssRjMZJSDT36VhNd0ctfqiDKyY4HsCxVVEpS7+Xd74C3ta9HNrMABTlexfLJfP
 C3aA==
X-Gm-Message-State: AOJu0YywD+BOQZO6gHetMcOFMmT7jMXvnwIS0Ui63GFHSz8AAuLC+hgJ
 ekDNsHnVHCZkjr1Rlr+RpaSneEAd8+exMC3l4yf6e41uWu0BA5exSdJMmxKMDLrbVNimQAFu3tN
 DnfmNXaDjubQ5JpdcfGXFODpO81wWXXeYJPPQQr/ztyGxx/Ne+waqE8RL1HvolyL8UQ==
X-Gm-Gg: AfdE7cnbDtCtKiomTAhJWGbfg0gB+aE3wZDs3ewoSKbp7kV38mranhU03KQV0+IM0Em
 3Rcqe/tDFuazidvTcpaLLMnZa+eoXeIMBdQXzn/wRx63da1xnvlN0SmaIWYEjrHT25jYD/cNEzD
 E5w7EC1UygJGcTqLbreLDXZ6UKfsBmmnVyil7JoO6H8EGUejTNd8qCtsvyISUnsWlUuSvzmOU11
 oyYBZ0NoBpFiNszEAGIcdPiM+iAMYL6Y28kz3E5cQKH+wc0bfoqhFdNA8JeBeSmQtw7im118hsW
 ceLFjRVAfjP9eRrGS125UDF/nUjoNmqwXXvHbwfhZYdHwigz2z0adnpiqD7Bzn9r/ozNa1oIkB/
 2G7ByQLamseXB4V/UkG+sAZJrgY5yBWRtzBYrK06qdqJED0y1xtYuYeyDGER+nDB1rs+X54PTi6
 LcTw+THA==
X-Received: by 2002:a05:7300:7245:b0:304:d92a:e60a with SMTP id
 5a478bee46e88-30c84e0249emr8968048eec.31.1782517168749; 
 Fri, 26 Jun 2026 16:39:28 -0700 (PDT)
X-Received: by 2002:a05:7300:7245:b0:304:d92a:e60a with SMTP id
 5a478bee46e88-30c84e0249emr8968016eec.31.1782517168218; 
 Fri, 26 Jun 2026 16:39:28 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:39:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 04/37] tests/tcg: introduce meson.build
Date: Fri, 26 Jun 2026 16:38:45 -0700
Message-ID: <20260626233918.158740-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX/EEN2SNqYskw
 Ioil3i8R8W01xlCe7ClZwcUhyZG1FOvs5Ux5MoBxS/xTyahF+yPMRcA+A0AxHfz2YCVnf6cNKfT
 wQJ3pjCfNqwhkGwg4YcxJL6Ok+EXRyM6oQNjUlSfndtRQIf2gf8+9vZFWI6GgWuP7b6OvWbymX1
 vmOW3sUOmwZkAgNA4sdNP9L3mXss3Zhb0Db8otUThHf02evypccZm6EpMGuwrOtWO6+u6Dw/aiH
 0ftILDOVkxQUJTgyWdRfYuG7VLn+DbpSf4Dw3Y/fKqDHXWpF5BnbzG1jMDlS6mZKc85Nofm1IcH
 xMB0pQ54rTP1nwyRG/tKIWt92jMh7aZ4vgEiQtU9Ru5AFYYCd8NrLpx64pTwfBmISNjtRYwNee/
 yS0djx/LXI+xYSOB8q22usXYho1vltW7ayXxYByY0y18l27TZ+5pYyEQKWAsJFK+YUWLNFDxRWX
 EOaMkk93Kf6Y+sfnlEw==
X-Proofpoint-GUID: 5clzOK6w-5cOc08nEjrr4yR04rvmVuRc
X-Authority-Analysis: v=2.4 cv=UIvt2ify c=1 sm=1 tr=0 ts=6a3f0db1 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=abvXrOxmeSwasVr9r6gA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: 5clzOK6w-5cOc08nEjrr4yR04rvmVuRc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX6d7qqIUkypJS
 3oC4goPmnmz52sXs7XL9xEPO5aCBTWmRkZ32kiyxq+t9dODAvf5Vsbat4cU2/PSKn8O7l0SKMVW
 tAAPRs4VafUBP1c63OI8mUW9R6BvLZ4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260197
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 00000000000..c54c503eb17
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
+                            build_by_default: true)
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


