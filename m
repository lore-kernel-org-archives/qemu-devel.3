Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDEDC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZfS-0004rm-0X; Tue, 28 Jul 2026 00:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfR-0004rB-4X
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfP-0001bs-Fb
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:48 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3adTV1527571
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gxvmcb+2DEXpFdcHEYPAvKex0f0zaek+RZkkYIVV6B0=; b=RH8uWqL25g0jSciF
 D56gT/nKUh9hY2L8R/J0vevwFJk5J3Ui7CoRW89pEnAk4+8RuBCZoKWL6eC9DLPC
 8kV/Ike90srTRlLAeMxje861cL1/orWlo+5QlQo8sR8+4bT9HfujWzw3Fn5htnD2
 Oa1VbqBpPpJ3oOQxwx2RnP3Kz/VEcXOCUDmG3WwM+Nudg91qkq3gUzxTy0R01B/U
 NF82NSV07QLG5tWeoo85C/ayzjeothZg0GdJD1jvCrgHae29sHysulo/hTmXHctM
 9dIYa7mqneJAvEWcHQ88aLQonZCrPcosG1TQUUZTKWnRMzPg9JSRWi+RN25wh0OG
 JaMl1w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbn8acv9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:36 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb11535e6a1so2568832a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213815; x=1785818615; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gxvmcb+2DEXpFdcHEYPAvKex0f0zaek+RZkkYIVV6B0=;
 b=Aexxzi9nn4BUbLPZtpQjvIZC1Y7t6bfkTGihJm/gZyxgVVxanZMPAuj8JBXvTxRbtV
 lXq4OvotHtgx/ztgCniI309MHACiNCQJOQnlzmKFxSUyN5lKY7zuu2Sv3z3Pxi2LZTHu
 4zZkn6OC/y6MsgXzEDm9lPrG/Tkmj4GOZGd04R7xAxtRtO2kPLsWEuECLwi2gsuLvSKW
 /PiaBryRc68jSW8Vf1C5Mk6syV7iSOwGZFQmk+Yb0iG/DXvY7Y2PGm0CHMd4uAXkSAzL
 0Z0iOUOg29/3fyRvGzMFx2l7rnVDIaC1KayfAoodzDVuyGIuqzj7I2rABx6YOHO/rMs3
 jtzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213815; x=1785818615;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gxvmcb+2DEXpFdcHEYPAvKex0f0zaek+RZkkYIVV6B0=;
 b=mYMt38TQME1mPIZQzXAYPHClTwXYwbwnhN7WBLbUgdUsgBR+gzTABg6IglJfnrw+TW
 4xH1Mjip7LF00gcbxfct44z5xjKE744csAmf5o5yIYaI4Dtm1CgMhMf0cUpUit9w3Ya9
 s7vwnwzd9Ag/NOXuvCU5FkEde0wOswwCv8+zf/6yf/KHutYrNZ1MN5t7lnWXhOfrYZCF
 HSYi1eg/aqQH2y/GHwxFH2JfuVpOpAEcnEBvz4u/zIIt40ofrc9zzu33yjfztCHt2vdP
 EX7D2Bv1TMEP0MWYWXPg83iNbfck93Thm4VtE4GgT2QETdtT20KUd534p3EEBM32D4nN
 OAPw==
X-Gm-Message-State: AOJu0YwK7RqfaKw/G4HBEOWEx5oQouoy4NJDKtEVudnLS5ZbRG5fDr6l
 BAf3o7BYkMjGCAfbqIuDwDK72IiJYrpT/O/4BNOBb+SEMB+sZF9899sfGPqBgtIFssFAJzYtTQg
 /T8O/Z19QPi5lWfNjPYs+7fXArHJCncXDAvklGppppIwV8zoAFVlGmSutDS9Jv6bntg==
X-Gm-Gg: AR+sD1345gAw90uUl9+y0a3FQro3PRP7Jjev4DcErfrTPjfFcM6ASF4YuRNbjSIytBx
 UnfX8QSQwxQDN1+Dc+lBKtn7I8Ge5lwsAtZ3rWu//J7tKClmsnOU+LyzgGGT5pdGHPIuBR28wiR
 U2FF5E51BtEfXLLIUGYOCweygQF7y+uzlgMc5FdM+lXulDOhlueoXHcAlJZ5NP9EcTYdVzSxBaz
 YLyx3+JVEtGdUwbKkV+NwDFymYpEdqccCSiwys+ZcxYSFjnVMEiE9Vzp77RBu7lLHc4ygGwF9oR
 KqQaGItCDJrYGTIvHnMAn9fU0tD+HuNLm81RRq260DFo+o+bCW6+yunf55IDJVkgialiUTMH1yo
 a86PWXrPkibeb9zhqwMvAHfrPInxd+/T26DeRMDb+wOMKu7bnG13j+UNK38qz7HvhZpDilvc=
X-Received: by 2002:a05:6a21:7308:b0:3c6:3c5b:ff1f with SMTP id
 adf61e73a8af0-3c8ab0e21afmr1164406637.22.1785213815501; 
 Mon, 27 Jul 2026 21:43:35 -0700 (PDT)
X-Received: by 2002:a05:6a21:7308:b0:3c6:3c5b:ff1f with SMTP id
 adf61e73a8af0-3c8ab0e21afmr1164363637.22.1785213815048; 
 Mon, 27 Jul 2026 21:43:35 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:34 -0700 (PDT)
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
Subject: [PATCH v6 022/103] tests/tcg/meson.build: introduce cc_feat and
 cc_feat_cflags
Date: Mon, 27 Jul 2026 21:41:26 -0700
Message-ID: <20260728044248.137626-23-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX6cgePRRieNhy
 ZlU3ga/AkvHjc9J9+7Y/td5NHzPCUKtBEneHTJFe0XhTsiec+gpUC9d4u/FBeli9rIAd3rO6YJ8
 pPImG1N88rr1107adFh1QyFTq7tT/DwCyLYRhk0ZyOE7fy5EgYB29Ze3H7DhTcT+dSrS1Xy0Pd8
 ebqzt5MFQa9m3oXiPn+waNRD99DuuqBgDVb+0yZy7PKnNyCKI8ntYzBrugZ4QshprddjIAfE+jK
 UA0piXVUPVdJr6zQjWLI8H5sbwTi6BtddT8UtQBt3T56IEZHlJaSAPeLTw/szlgCnoc+MUK89qa
 HschgZFfnr99gwXaEFO50LhCqEswv1RKBp72vl0WDBc8RxRN2Jt/EJ7Y9OnQuZOXVPs1dzwTPWI
 6c3All9Md0euX+g0XMwjylwACW3Y3ekntZXjNYhVqFQfVwZw1AOEwUJpnDd+wzb0JQP4kOU+upB
 K4Y/ZaaHzCPmwWmTH4w==
X-Authority-Analysis: v=2.4 cv=RO+D2Yi+ c=1 sm=1 tr=0 ts=6a683378 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=FBTJAdTUffG4L5poSMoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: LecMl3bOzFgvAAMBklCjFp6OoEuXHfS-
X-Proofpoint-GUID: LecMl3bOzFgvAAMBklCjFp6OoEuXHfS-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX4/jM9/YJe8X3
 s850BJgQYO8N8Z/YCXAw0AJjXwbFNoO98gWw90QDt9SUU2Sj6DVXEbBDp9kI6suw5phRIvIdUOb
 79e8ucTjzqJf7VV+DvHdlxbi3EYaOHs=
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

We directly move compiler requirements in test definition. This allows
to always declare all tests, and let the main loop filter the ones
that will be available.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 7b60ea53825..4487d61ef6c 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -20,6 +20,10 @@ tcg_tests = {}
 # {
 #   'name_of_target': {
 #     'cc': cross_compiler,
+#     'cc_feat_cflags': {
+#       'name': ['feature cflags'],
+#       ...
+#     },
 #     'folder': 'folder_for_test_src_files',
 #     'gdb_arch': 'gdb architecture requirement',
 #     'qemu': emulators['qemu-...'],
@@ -29,6 +33,7 @@ tcg_tests = {}
 #           'exe_name': ['provide an alternative binary name'],
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
+#           'cc_feat': 'feature name, must be present in cc_feat_cflags',
 #           'qemu_args': ['qemu command line flags', ...],
 #           'expected_output': 'file_to_compare_output',
 #           'gdb_test': ['gdb test args'],
@@ -74,10 +79,11 @@ foreach target, plan: tcg_tests
   # choose how to deal with it.
   built_tests = {}
   added_tests = {}
+  cc_has_feat = {}
 
   # return a clear error if user misspell a target entry
   foreach key, _ : plan
-    allowed = ['cc', 'folder', 'gdb_arch', 'qemu', 'tests']
+    allowed = ['cc', 'cc_feat_cflags', 'folder', 'gdb_arch', 'qemu', 'tests']
     if key not in allowed
       error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
             ' (possible: [' + ', '.join(allowed) + '])')
@@ -88,13 +94,17 @@ foreach target, plan: tcg_tests
   folder = plan['folder']
   gdb_arch = plan['gdb_arch']
   qemu = plan['qemu']
+  cc_feat_cflags = {}
+  if 'cc_feat_cflags' in plan
+    cc_feat_cflags = plan['cc_feat_cflags']
+  endif
   tests = plan['tests']
 
   foreach t : tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'env_var', 'expected_output', 'cflags',
+        allowed = ['exe_name', 'env_var', 'expected_output', 'cc_feat', 'cflags',
                    'gdb_test', 'plugin_test', 'qemu_args', 'test_name',
                    'wrapper']
         if key not in allowed
@@ -155,15 +165,36 @@ foreach target, plan: tcg_tests
               'specify a different \'test_name\'')
       endif
 
+      if 'cflags' in setup or 'cc_feat' in setup
+        if exe_name in built_tests
+          error('test ' + exe_name +
+                ' was already built with cflags or cc_feat:' +
+                ' remove cflags, cc_feat, or set \'exe_name\'' +
+                ' (if cflags are different)')
+        endif
+      endif
+
       cflags = []
       if 'cflags' in setup
-        if exe_name in built_tests
-          error('test ' + exe_name + ' was already built with cflags: ' +
-                'remove cflags or set \'exe_name\' (if cflags are different)')
-        endif
         cflags = setup['cflags']
       endif
 
+      if 'cc_feat' in setup
+        cc_feat = setup['cc_feat']
+        if cc_feat not in cc_has_feat
+          cmd = run_command([cc, cc_check_args, cc_feat_cflags[cc_feat]],
+                            check: false)
+          avail = cmd.returncode() == 0
+          cc_has_feat += {cc_feat: avail}
+        endif
+
+        if not cc_has_feat[cc_feat]
+          skip_test = 'compiler feature ' + cc_feat + ' not supported'
+          built_tests += {exe_name: exe_name}
+        endif
+        cflags += cc_feat_cflags[cc_feat]
+      endif
+
       # build executable if needed
       if exe_name not in built_tests
         exe = custom_target(exe_name,
-- 
2.47.3


