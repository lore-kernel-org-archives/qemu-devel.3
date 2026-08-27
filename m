Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6707EC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziNW-0004v5-Me; Thu, 27 Aug 2026 18:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNS-0004sv-JW
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNQ-0005zj-QW
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:18 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLvtL795155
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uIoY4rvTGP55FLHZ/NlkTsMOtsIeXWkIny18AEhws2o=; b=DgFdALtsB3uICvwp
 tnZUJuP+Vgf8bw04FqpJqm57+T3Uuwk47Ip3V4/DjG7N2QY9Rxk+qp6vgSSezyo9
 II/go0sVvHlUkpR1cQYjfoGf7un7N1IzIE/OeQibB3reOKMdlqD1CQoD11MQ6wu/
 AbvE8hkktLtxDaA31WdbZVenVwliXbRwujg3rzTy0/ljCAKiysVFVdi63BnQNArN
 8NH5RFi5235PZCjHXe5Qn0VtqdlK5u1NXaI6Dv7HwZCJIF0UiinHgIbV7Vr1jX8T
 aTo6mqTV8Vjkfhbj9hOc/VAYxtLy11/39QhLM148CoCM1G/vy9zT7S1idlGM2kaP
 Qo8rfg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gam6fjn3p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:15 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc1b6f65dacso210751a12.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868915; x=1788473715; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uIoY4rvTGP55FLHZ/NlkTsMOtsIeXWkIny18AEhws2o=;
 b=HFoj1fLLjMYi1smcMNg78Rwxxfr2YWO/3s0mZ1PCvWPmb/dSzUJCa6dsg9Hgl8PSYw
 PmwMKw1joL37DX0qJtlQow5ctcu1qj1PPvZUxscwWAn8Lg08adhp6TNI5+Rpvl1oOARK
 ph9uZnrs4ODx9Lnq2kyE0LQz6KJKsC6Q575bk6neat67qVSSJ3bEwd5Pv/0lNNPDojF3
 Up6haH3n68iWwZHr77PND8cbfaJf9ZPkUNusTTW6mE6HGdP3jb3A1NOdzndZ8b74iIXd
 crwQWZ2zp50dUC2e53E2/Ftai4aYK3duHfyK+zfD9iEf7PRFs0J7dTReZQji1pDjljsf
 ZDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868915; x=1788473715;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uIoY4rvTGP55FLHZ/NlkTsMOtsIeXWkIny18AEhws2o=;
 b=XGPOdH6JONO+d0HwJC+LmuMR7JAuZUgoBvqCJfdG3F7+6qFWMaSNYXhYrF811kufa7
 d2BfK83IKTVulzJhmbJ5NvqiRjsDVx/LNyQ+fCcC90I0W+99PFxDbG5R14ng9O37ZZTD
 zfMI1w/sOZ+m/jjB3KN+waWvSHgFiCvdyM6I0bs8fZjnwigd7nZZNEaCoHIWOM+UujNc
 eUJdkrg1ImE1jzp7d9FD3vm/jzLQRgguquHIWdvIqsP3zWDHx/uNtolzcs7ydYTY7w+C
 ijSma7mBSmannwEPLdw3E1BC80N+4fR/MvHR4FYzRFbCAAvY8OLi7EX1D/FZLt7vekZA
 ao0g==
X-Gm-Message-State: AFuF++mUxMIxG5txaAlJJDtptq10qtLWiB/QQ6hp2hd3pSQV/b4NSVvW
 CKkdHGwWotsE4fm25g9hVOT8mLEilzjdhTCU/VYEiYGc75BOJjVuOhZ7qmscqPyfGp1NiZuW69t
 TJFLfBQk+xbHOlwhZkF3JAP7MoFgTIL/pLNJiSeyVDpMNc1VdlXN+T099TDMmF6Vadw==
X-Gm-Gg: AR+sD13fbZj+2JMd4BTPNM37fNteFd/Nm4Bl3IVGk5fzuYUWgojbnMKCUOaHapj6+YI
 GlroLySnyI9OQUBkHYNXUpxxzx5xsMwuPi5cQCBT4yhPjmMLbZC0Gd9vrWivVr5pCuRcgZp+vzF
 nLjOkk9t7u7iTEvyraIwbI3BxzsbhCL44ET+1IwnYFoxMTypQ3wRqiYY99/025bY5zQ+oG/yVRY
 CHhJC29zgKzabHNfgSR7hMz3v8VjayQBYJJ7RRtn7jZaonzvL7AO5Kvm6v40IsU6EXCmUozcSax
 MEOW7MJwkQE+VF5e9sWpUuvKHcneqEwNEFh/9URoPkz5D5mI53V1KIiqo+m/Tfuo3lYLYBm4aAt
 Xi3FQz4qzc/o25/tBAPFpHa+ueKxlIUmaIAIiRCNJ/hCd4HC7gnJ/GaD43fw=
X-Received: by 2002:a05:6a00:9a6:b0:851:8bde:7873 with SMTP id
 d2e1a72fcca58-8562a1fa70fmr3769961b3a.8.1787868914523; 
 Thu, 27 Aug 2026 15:15:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:9a6:b0:851:8bde:7873 with SMTP id
 d2e1a72fcca58-8562a1fa70fmr3769858b3a.8.1787868914002; 
 Thu, 27 Aug 2026 15:15:14 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 005/105] tests/tcg: introduce meson.build
Date: Thu, 27 Aug 2026 22:13:26 +0000
Message-ID: <20260827221506.91574-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX48N8xFitDmEy
 CwDWwGviL7By/imm2NAIyKFlVD4GEce1KgYsxKtGRsTNNMxUN++Zs9Q3KVnN9I3d/AEjIBfRtHl
 cxaogPV4AEgPPs5EMabU59BcGFMuK/8=
X-Proofpoint-GUID: OAJq8uNNGcZ9th0sWyG5o7bXeS4jRQko
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX2AZfu/w+6x3g
 c2mEZGFvZ4zzSlFK+3FxdRm4PY6ZPo8Df7Qps9fhLlgClNeVeP7TIqA0ygVORmj+2hWWDZSsWF8
 1ra0HtiQlQ5ojXagcJNixcXihmn6j1tGzLoTru8wkWPdXpdMfIJnx6xquPUPE7saS6wuuZoTSW3
 DcOmL455noY/bEnYkFHGJ0cAioMpqRyN/GQh4m2kRVxL5SXjPEiju4dvVoQri59nPGtA96C3ti3
 6GMXD1zobsBJ/6w3yxC7ykpTCS9zuol0u9P4BIjD/v1A9SsoLs1Tvv/bsr6c32aGFK4/VFnLujp
 3ZJyuMD/EK15uqHx4cXiOErcXLfui/2YAEQWGSvFB5+YPDEcmpNFHX6eE8zxqY9+/8uNV8gFb0P
 TUrkXgjFvqn5ImHY0GGUoCYEzrffR44R/rO53EyBS49A5q1cptDADnkCTjdsdLAzKVxY+APbUZ7
 AQbwNJzy1EEtIM91vXg==
X-Authority-Analysis: v=2.4 cv=eIgjSnp1 c=1 sm=1 tr=0 ts=6a90b6f3 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=v_12uhcQQg0w4xMxk_YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: OAJq8uNNGcZ9th0sWyG5o7bXeS4jRQko
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
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


