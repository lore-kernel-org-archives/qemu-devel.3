Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAC1C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrtw-0003LA-RB; Mon, 06 Jul 2026 18:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrta-0002pl-CO
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtW-0005ca-EM
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:33 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDqEk1664559
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nLSuab0rHT2
 xkwltLAUvtGuyjfFF1jlQvak5fYnfeX0=; b=AZD4buqLM/8r1hUluJQVQzLikt+
 7o269WQGh/mBB/v6LPrv17KRKpRaYEd9z4pkCGV6g4A1UHejPY4YQe7X2wd+1XlD
 yUGZJ/VnKJ/6VALYEM8xa+cI3dcOJwISrC+egteWOKKbLCNiJXdgMcbHgIhFltGz
 zgWxmfwcwTTzs1GfdjziAqvas71tSlplZVEt/BrncguXY9bmy7wMDFLtNJvQKMRp
 CQzbdZIEHDScDhPVA0LDVvUqaUbM5VjeIEdQr6G/ixtAUn9sXU0bmEukYdLUpSiz
 TWOe0shrc5Nkizbyl4pEIEH0Vmi1KYlAvpO+75vYv9ykyrOksPpFd4wDGQw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gu6f8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:28 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-847ad67cc51so3554221b3a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377268; x=1783982068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLSuab0rHT2xkwltLAUvtGuyjfFF1jlQvak5fYnfeX0=;
 b=Tk/W74+Zpfln/vX5ZbETnS+9XSPkDr5vAAnS7mSNuN5nY23alJjhfjHAjSRMF0OT0v
 rrf1MkTpuTVBCCl21YC+V3wSghFaL2fFRy4VIoeo2KZy0K0vzia6mWhdgKVodcfGKoyw
 YlzkNprPSbi46YHcLeVJQIjbRWP9ZzA+51GQCAbUMZGiLADLmQmfU4xgDBY8M9EWD74O
 4glJ/rt8OGM2l6/LGiQlk+cqsnjN2dtRreUlo6rqmkcTpINnJij2d5p3JK4GTVxtIDXF
 FZeoJovAg8S2q5NDa3ggug0NJ1umFe1S7j0uIzjzTd0UZk0AVjvtrHg/RDAZk2ChKg3i
 vl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377268; x=1783982068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nLSuab0rHT2xkwltLAUvtGuyjfFF1jlQvak5fYnfeX0=;
 b=QlIuaRvUb5PZFRSCcEtsDmLveaUzQghSLZ0LykFbol8V2SdP1pQxIxjfoqgg0eYW82
 h/wOoeZ44z2eaqIIH/NZsSnRcDuEc0Nca1KfHM63/Vc3myIDNeTY+g/Eg37Xxp6LJxF4
 tagR7A3C9rdcyQ+0vZ2xzhmyEHS0n258ZkL1agNswKQzqmNdD+Q+4MkqYdfSYN+PVpm9
 TT7945kOmSSR30y+Ol4ALxsZXuT52GJahK27DGizSr/5Tp1Fumtf2sg6c6KMo6yvnzeY
 f6zQFGUcPC7qNPc4dhxjfb8yOVHlrcA9P1EaHADUjIoXrcf/jDghr10UI+MK4tZ0Vy4w
 zLPg==
X-Gm-Message-State: AOJu0YwWiL2nOwVyILWUBVEfkmT6i5cFYQUn3vbgG8FTW9U8PArTzczF
 hXSqHiLActbmZOmdNB3C8TRIx1D/nuRaIZLocSLt9JcjfEOUc99AQNLzhtH3fWsjKT2C37mmlxw
 uiHaoiYlxCl+DuVgf6Xilp8z2y30wAtISB3dqUok/LZgZq2qACwFaGdFG6RqRhYJdBQ==
X-Gm-Gg: AfdE7cklGyAdFlK0WRXkQjvxbRK7B5dhgn0Aj9/JJQ9hNSH2Y71uy0AtCjmxR/BBz5V
 eTGIEqjy+nGE2JYBxXuWN9DSaWAYY2MkhsEuJx3Eemr9tBuA4v5NM00jXWjQ4ss+RK7qT9//ubK
 x8EgzFs8ohdEDoQE/UMmAQplev78EURPevCNtpOwIjx+7bgYuIvgT0maBIZQNc8ivbQitD6eesp
 W9VgCdv9mIyJiizxOKy6eG8QZY3PKzcUSh90Vxab8c/TveZttQaGLTRMGqJE5gJZqDhByd7A45Z
 KEDcW+OzSTTs80aQhFFc02dNGnduY5jlYrEYqZAwIxrmlQzhIxlOt0b00lUVSsrOs0BYrpBP2wR
 3V7GL0YnVG6zNxeX5EkDcmAKkMz2LRfE9B2gpvU05eF88g9fE0we+3mLhNRlHzmCvciB4Qu0DiX
 7GUhhyLQ==
X-Received: by 2002:a05:6a21:50f:b0:3bf:b68f:4682 with SMTP id
 adf61e73a8af0-3c08ec8d9f5mr3159721637.7.1783377267586; 
 Mon, 06 Jul 2026 15:34:27 -0700 (PDT)
X-Received: by 2002:a05:6a21:50f:b0:3bf:b68f:4682 with SMTP id
 adf61e73a8af0-3c08ec8d9f5mr3159697637.7.1783377267170; 
 Mon, 06 Jul 2026 15:34:27 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:26 -0700 (PDT)
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
Subject: [PATCH v3 22/91] tests/tcg/meson.build: introduce cc_feat and
 cc_feat_cflags
Date: Mon,  6 Jul 2026 15:32:34 -0700
Message-ID: <20260706223343.988769-23-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EJ-pgEjrObLSGwG9VP3_DBjyERdWpOwe
X-Proofpoint-ORIG-GUID: EJ-pgEjrObLSGwG9VP3_DBjyERdWpOwe
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4c2d74 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=WryKx-XaCgVW6WutTgQA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX/+1bUVM2Ivch
 WCjL1x6MyIG/Ii7On9LQFJXnlyEpq9HRd2+cg70sBInCu/w4wftPRXH48+5e6ERDchrA6uU/YYA
 3ve6WNUCRe+m1S1Ak3OQZLb07Srmu62wtSWF0JLeaYqQ/Qi0SyW47bqLfebd2+sVIQvSFm2CGii
 /ojGMlfvoXE90O2hjvw5mZNfnmGl6IR3LjibcVXHVMjTx6pwByWAQtEN+HD11hssiaf0bQYQW7I
 zUE+HvFpHIbRrpLjru2kQ9Xghe7tIFLLvstBQdcOGUuwxEtRnP06JIHoRvE/4O7gTqpYZE5q3p6
 4EMWtnoIkf2/jgPJbdLRGN0sCJV9qV/u9Ymxhr9FYqyacporJ7TUu5BkUofw6yTjuP8AtmF8QXe
 74N7mvsadA2tkljrLIG4OI4pXCf20WRyJgphD+x/KLsSE3cv659QEhOVnQBB110HjUz1dZtc9jA
 oLFBLMT8qHWjicvIPtA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX32CF4gMIJIn/
 f3Nd9q7HUrad+UJsmi8FhEc+oNz0no6W9XLP9VBCAyyNG3dJgIZrOhLDwJzsoKAYel47WgZVohK
 7E7IX+Ys7TYFpxg88MKBjjjn0jY5S6U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 2bc1fc77775..91e71ac40f2 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -21,6 +21,10 @@ tcg_tests = {}
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
@@ -30,6 +34,7 @@ tcg_tests = {}
 #           'exe_name': ['provide an alternative binary name'],
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
+#           'cc_feat': 'feature name, must be present in cc_feat_cflags',
 #           'qemu_args': ['qemu command line flags', ...],
 #           'expected_output': 'file_to_compare_output',
 #           'gdb_test': ['gdb test args'],
@@ -75,10 +80,11 @@ foreach target, plan: tcg_tests
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
@@ -89,13 +95,17 @@ foreach target, plan: tcg_tests
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
@@ -156,15 +166,36 @@ foreach target, plan: tcg_tests
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


