Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346D0C44508
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4by-0001R2-RT; Fri, 10 Jul 2026 02:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bo-0001F7-2A
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bm-0004gI-2i
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:11 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3orqD3854964
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qBYzkUoIFK7nI4XfIwOHqzmQBAtgWrUZlpV7i8HE7NA=; b=bQZr1Ss0Grh7IdJQ
 8jeH4ZvtBTLsBCHXNz0jsPt+yYC+sKL5qrgv2G5I9O5c12rcXB+f84xYg8z2VFAK
 E63phwz7FMWkZASyCHZceayyY5F7hT4xp+1dzQ+PoOLApxdOROP+gQwLMszJ0v5U
 hGLQsZESSNeeCY+lro8nuYIo45kHXgr4lfYdXqEjvqWUOzzPIvWlHBFfU4TUaI5L
 QLLUglRW9bAx/fwuOlKM7r3OcxRmR7mYIRYk6NPHEw1cbMPrA6qjUvy5x4R5lgOz
 t8x5Tq5iwMVal9s9IMiWPVuxAzzPDADHT0WnLV0AvZJZ2u3G4VfUVmT+yLan77YC
 9TS27w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fas6n0h71-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:07 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca7c1e22995so1085585a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664467; x=1784269267; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qBYzkUoIFK7nI4XfIwOHqzmQBAtgWrUZlpV7i8HE7NA=;
 b=UWRprd4NNQ4pomBfFxS8t+a52UU+3S3O2Es6lumj+3lqhhx0tByxBMxsoJaiN6L1B1
 pTf10oksyu+/K7Wm6dHi8kaJ+IaGiIBCkAVKZM3zEQosyrj/duL6Aaxa1LZyKhYyonkh
 29OaWHWdLocfIDKecvioh8YXgmonkgHJvP7+KWejhn0petvdeDKlXycqVzLAKzjdXXQo
 z0ahtkbprFlngRYR4b9HO3GsLU+BGEMfsdwjfUtJPI+2BAYF1AqrHXss2EAk9Ep1aIoS
 Nzcs5jz9AU4cco9ODSnhovkleOv0WZzKRiOXdfZ9QzTHlg27TLBfvKIeOVH3oS9uMDBi
 0L5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664467; x=1784269267;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qBYzkUoIFK7nI4XfIwOHqzmQBAtgWrUZlpV7i8HE7NA=;
 b=Ht0e60v87YnKRxa0+H+TQdtzWmMupbJ3sd50rwQ77q1TDRZoEnGsgO6t6Yek95a08i
 01/vEi4p/Pto9KsT8ttT/v9CTpYvmmUsVDzLvdbRyRsHjiaVNFY097gQjgOsENXxIFk8
 yu5I4SGUDZ4Eil+rsGvXZ1rmunkeAwsX0HEZSpBs+gfneicaxGs9FLuJAmB9VT3VJeh/
 oR4oKPwq39Ss1CuXyLciIim/lzAH29q5/nMIL/oDpDfl++U3Ei02c+LfCEUs5vETAv6B
 6DfLZOC1NE5uRjZC1W+LPmqL86S3zzaIxJSJduPCKKssgpq0f0btqSnc489Qm2mBrD0d
 Eb6g==
X-Gm-Message-State: AOJu0YxRsU3zwae7IRRfmPgbdZ9pSWoMhyW3CDlgoJGUltShS7ig7DnF
 yjkMxryR7JWune9fSqtpY87AtHiYtTBqwigigakoNGaoIqClPuft+UoNjnItHmpOFsb/ah5nt7a
 xywlyxUTkZxcPML61BNyiSx5oAZorbQYtdLjiSftRttc3FU8eZ3rwUX87XQBAG8qOHg==
X-Gm-Gg: AfdE7ckmGNiP53zezpleHE1D9f3c75Lrnd5Esu1LDsrJrg3Kf821j18X3jEiZnlvNu9
 vNOSMmxJ08kyVnOEc2Y004ntijDypW5p+9z/5p5EUVKkgjRPa6jmMu98cA2ji8bLa2aTdHA62N3
 HwPErkpQpQxy6W2nH28hWLwpt2Wac07F+b90NyxEekkSSNxrU08MJRpD1r7o0PQ9UjL2Lz1deUz
 Fv3ycE1gl6DxrDPl2LvzEizlzXXKJZgEm2LO/VMkR/CpLqTGOWvQJ5q+f9WctdJi24xVLxt2mj3
 //hnNjZo3Ch/d3TA8mGueJdih1t0RLQRdXFYRgfjaasVwYRjuEQfCRtcRZ855nvjHBjK0bkDeGY
 b6XHPTmFCknlGQ+AY7bHIXg05dyKTaar9JTFReP9yrn9QjydxHlWPtsWXI1B1P0hNkVJHG/2P08
 Y+dxwf4A==
X-Received: by 2002:a05:6a21:10e:b0:3c0:9c19:65b1 with SMTP id
 adf61e73a8af0-3c0bd3acfb6mr11784488637.73.1783664466802; 
 Thu, 09 Jul 2026 23:21:06 -0700 (PDT)
X-Received: by 2002:a05:6a21:10e:b0:3c0:9c19:65b1 with SMTP id
 adf61e73a8af0-3c0bd3acfb6mr11784452637.73.1783664466309; 
 Thu, 09 Jul 2026 23:21:06 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:21:05 -0700 (PDT)
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
Subject: [PATCH v4 22/97] tests/tcg/meson.build: introduce cc_feat and
 cc_feat_cflags
Date: Thu,  9 Jul 2026 23:19:00 -0700
Message-ID: <20260710062016.1818125-23-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX/x8rErAcqpNk
 NZykcmSFm6S5io1B7rBBLlvS5edapyDMEFw76z5nsFgb3bt2qQvYtHb93YhaEgpzSUw6vGvdwlA
 EG8HeHPpVkrd1s8DfcQK/tfNPOsABaU=
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a508f53 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=FBTJAdTUffG4L5poSMoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: pmHmM1YPdMmV6Z99MjTHL9DOnoBReoU1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX0AryReuKxLM3
 qptEcOsdcTaS78kxzjSnU71qwB5ft3nJuyQtC2MXApjoENNHEaTccajGuT8pnbjpitZeTG7IKmn
 L4Ay40jquwy91KGtTDkHLgQGemEUOqOKt9PXXIBJ482l5WQRlC9WlAJdfFtMrtYeEqlNzjcjocO
 4hPEbsUJBi+uYMPWRJChjbNNkIo8Hvnj54BDBXtptdVXbUXyd+QSssRD4URlmMAWVKYzj1J7oTO
 WjnV3HsFrCJaHSRevCaziK/t2P1ST5WcccXm8GV5lNB2EdeUMhrF0Kc6Oecp+nlybyZHJsEemNb
 0K0Vca6wMyXGcNONADeXZee9cI+kxHA0GU6h7t6SC/IyL9cBI7ZJfvxPf7mzRmXzsIiOn1JFaUI
 Pt2NU7oOldGiwmQyX8wPIGDc9KlZI2MoTOuiOl7WL5dbr3rYM2UNL5JPy9L135bO3NtACaWAWqA
 7HOVEfAG3PASR4rrVsw==
X-Proofpoint-GUID: pmHmM1YPdMmV6Z99MjTHL9DOnoBReoU1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100058
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 05d54093709..26eb17fe17a 100644
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


