Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EECC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPp-0007XW-UV; Tue, 18 Aug 2026 15:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPo-0007P9-7v
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPm-0006em-8Q
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:03 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH6A01006698
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /s+Mk8furL015lvLqj+bOHWeZcHgkClslOb/k2zsi+k=; b=MvQqTjP/sfPJXo1V
 /sZNn59Ym/zg7WQRTdFYBj0oQWkZBH2IwSB/DFjzwJ4AdHY8Yy7i2pyEQrdcKlGc
 YNlaBeNwfyhJ76N1ORz6iMFhun1MU7F67Rmzr9VCOB1VdN7WmF8g0GgzGkLf3J+T
 2eVx1M6M8k3euAtyBIvDXCEh5+5e1naDU4j8LKrfS1yxKXdwTr3DDG7lCXBG21r4
 +j00TKRV5fmHL5xCQnutC19hRpOnROOXYZgWu7nkt2VSxBEpK/DY+xPZXbo127QX
 q6izhuQ2aaSgsZ3117a1xIjyiY68ndDncidFzhsfYLuHAD5iD9ypmYONifbQv1BG
 93L/MA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4tkmrv6t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:50 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb835525b10so153375a12.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081030; x=1787685830; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/s+Mk8furL015lvLqj+bOHWeZcHgkClslOb/k2zsi+k=;
 b=fzpMuqG/iQ731yFLnxTHq4Uk/jM1jPHPmK53amrkMI16hL3tbtGq4SvmWwzYhpGImG
 ijnY6uGUKl/C0W2T2imPn8Ant02ZAx005vNE3HnbSuy/MNBBRU11brtn/MFlAhkQPu4O
 JfuHMe4Pm7GuIR3RAALPM/sMdRybjKC9Tt0Mz15hqw04bXDfgfkkqBstdsKKABvTFvCL
 d11CJ1YTY5GJ46kkIkH5Qs+Clxm8YvlrpRpoJOlkm3vxD2KjM8qxiG1J+HOeWlfvBcyU
 MRHHps4HU5KoaEAeoqrbhcAf/lqCW/xJSJbhgZREqZ4gNgsl/r5ViNo94WWiPnjSY9sM
 8f6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081030; x=1787685830;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/s+Mk8furL015lvLqj+bOHWeZcHgkClslOb/k2zsi+k=;
 b=rEIEsFJyNMGGim9GOvWmvAa1ywhrqQ7PW4PC5D6Kb1WKKlcG8PlZXmjFpNr28bis8l
 HoJIgiVYQcplI5+e/SI+ORBKJHQEpYcoBR3f11lZ8Rp+l2tn7F1NPb08peY9rHUyHWv3
 iPQ3LYzP/nhbvnnCOnbuQ0II4131nHjga2eyVu5N5WZxRL4dutYyCUMvZzWndDZhfmBT
 ceNsm3caYP9tZ4OXRwOUFeD+m2HhtNbv3hvs5oi1i7ROsqHChcDWP2MM2MiKY4NneC50
 206OPqJ6nnk/cLG+2ft/oysiuku8qLf7sOKk2bVomlRl68VyhenS22v47LNF74BJ4djx
 ugzA==
X-Gm-Message-State: AOJu0YzJvOzG8wxh6bEGFSbgv+vlUIjYs4ygFplxZCGiaU5+CpL6PEAj
 8JTcvqgugdwl2w47Utf5iqFuvaqQYmnVv1Cl91bRdXWZbqtMD5IBNW61xiklUvAh3VaOfUHy98j
 Ok1Ts4gyozh/McaxtKQ4W0ypeOZyNzUowxm/Q/8qNVi6P+P4NncB5MgRxXGGlancKxA==
X-Gm-Gg: AR+sD11LpM8/P8XfahKlu3icwG0JvXAkhcLqHPNHIX3x33Pk43TwzClCpQ+VMdVrhJv
 9PsZK8kkRi0s3bUurvti89m4RETbw9xwhfj6xs2nXwkUlruPoJgKW2ylrAXxBd25qtBc3/pf2MA
 USmUWIoWJrfRo9wM0uduP3G5ZXD+xKdl8Du2ygbWsJgJEmSXPLtMKqcGvJvXC/pSGiX6viUjbWN
 u5roPhixP7rFl3c7JuxMvEuBKSXgRa0SmpnrnuRk2QRoUd7dde1TNQ+iXnqeM9hlA6LAnBVFkJ8
 iAWbEEn6PFH6ia2Pe243FkyWuiz0pgLetkNzV53iLF0RkwuvWru68/hO+Pz/bD+Tf4mudCW+RHo
 wq2hLXj3vC1WQK9CR6wBroKKltiC3yxaCErA8l+34s9hXGNSW7MDoVkgE9MY=
X-Received: by 2002:a05:6a20:cd95:b0:3c4:1c9f:d7e with SMTP id
 adf61e73a8af0-3ccff33dd1fmr74024637.6.1787081029780; 
 Tue, 18 Aug 2026 12:23:49 -0700 (PDT)
X-Received: by 2002:a05:6a20:cd95:b0:3c4:1c9f:d7e with SMTP id
 adf61e73a8af0-3ccff33dd1fmr73956637.6.1787081029400; 
 Tue, 18 Aug 2026 12:23:49 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:48 -0700 (PDT)
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
Subject: [PATCH v7 022/104] tests/tcg/meson.build: introduce cc_feat and
 cc_feat_cflags
Date: Tue, 18 Aug 2026 19:21:46 +0000
Message-ID: <20260818192309.22169-23-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX/+gIkwD1PERX
 JNlKHRMZ9Zx6irvsM8e567lgQyf+E7KJDSMr/xsxKVjdrIrFY999l15GRew+0W8I/FwEXUS9xnw
 54HlKe5BDHiPVggpQg/RZk5WMgwvr4waume/wyDXSH4w18rNAD7G3atEZ/T/uBkLeWfEkBR5E7b
 ivXP1bkLbiIlVSC5xMX5PM9Qb1KbGy/SlKv4LTUlrGgLoJqpoudu1cdGnB+xsoDFoSpF/Q3Lkmo
 f4kQIlgkQnG81+/0Bfbjjoi3cwNRz0dEpWWzJuwAVWvO82KOnfWun/dY+jnER/v3zWP3dE8MbnM
 hLhVk4AF1N8NNxPr0BCMdpP0Oe63Ak5Qd89b3TI16tUx4DeDQ1TmyTE+6PH9qOo2hg4pYPVEL8t
 UuLsq7MYl1WiTqFn+h+zQy8/YNHaEtPp867OYwl1DQKXSGSVZU5bcfo6NXyH7FHxBTlBShQMiZ3
 oKOp2QWKyC8MFqjiXtw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX+1geuBnvd+uU
 E/MhOzB7bBPsMPfqO5Be8htbA4LRI5RWW1ey07w18f9+3yGo2Ruz7+0luzrSZwQ9U1tnzZhgqkh
 rJdTgxEcsPu+gdw5q82setx0kp5TjKw=
X-Proofpoint-GUID: MLm9WKYtdJUz45LJpoKyMsbp0VRpxZJU
X-Proofpoint-ORIG-GUID: MLm9WKYtdJUz45LJpoKyMsbp0VRpxZJU
X-Authority-Analysis: v=2.4 cv=R+Mz39RX c=1 sm=1 tr=0 ts=6a84b146 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=FBTJAdTUffG4L5poSMoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180142
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

We directly move compiler requirements in test definition. This allows
to always declare all tests, and let the main loop filter the ones
that will be available.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
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
2.43.0


