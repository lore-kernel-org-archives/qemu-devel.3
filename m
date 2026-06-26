Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DD5C43211
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9k-0004Op-SR; Fri, 26 Jun 2026 19:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9i-0004F8-KO
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9g-0004Ha-4X
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:18 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMxYsF2746797
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=leRkzJZSXcb
 tK0vszzBhM4JakuZho7K1W3lymJlDdbY=; b=Wo8wXmBMxsVokv3dI2ug7vs/ZpB
 gFYvzW+NRWvTzMQ7UxBseQBKQX3NoIBIMU2bxHZucgdz3BB5VzSjHzcptIJXxxPh
 v3SyCFQCkR6rFkQxMEAmVzZN6UbpV9VcZj4s6oILpUFZiyhh29wAJDRfA7Y7C1hi
 lgPeCPcmY3ypvfIJzli5r6MegdkhrYtDR03hWVLCU7+Zt6tlRGWC+gIeN8VPxtzL
 CaKu1r7p4MaMbpiiTfATtg+3iMLC19kOBCFzvVe6riAPF2TM+xMf+ik9x7X2bOXc
 UunZlQnCvS0iBitmCWkAmGsdfew9V92zHF7l4J+zw1pfaHV4QW1M/FMtnzQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1yqv0mys-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:40:05 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c17f62afdso1302295eec.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517204; x=1783122004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=leRkzJZSXcbtK0vszzBhM4JakuZho7K1W3lymJlDdbY=;
 b=VFO4ScUN+I/xFVYrAGgK99ZluJpFHZBA/KZ3LOXxhl4n+Epi/rr6Ra4g/EB+LJpIJt
 HgnYECFEHO860azAoUXG8O3ct4LefTsU0FeuT8dqzXUJlufBnY1+lQQXs125lln0elhV
 Dm3hyGJuZ7gh7YbCL+6pYhPzCi5z2eMfmiTuW8g2sxMAQeDg7V59Gpdjh76077VripuL
 RR1e5Kw2HcwoHgnxcV3gbLK1BIXCpflIQL3mIhlqwLTiBi52UFCSFv+yFUN2H/u+6LBO
 0T9DGU7h7OTROm39NiKGyY/1S9trCzj0XiRj1d+yFqXhrRZK6YFn7n4gl3NsTk4WgpEB
 VxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517204; x=1783122004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=leRkzJZSXcbtK0vszzBhM4JakuZho7K1W3lymJlDdbY=;
 b=Gww5tysZpVODUjqTYadF/LC/g9jxWKi+MyzGUXehSiwzEeyzaOpi3CI66NRneTak6b
 d44dqdvHn6iwk+Nawu8hTHcJjgCQfALyFJABkei+TwluJdv8a01YYKVLOizHd6BhdJpG
 50chn8Gc/0Og5BOZLFM2y6VZW7geF37BBxHZ+G1NuExL0J3Y2Xp0dNG5EleeRaPH6Bfl
 36uyGBGxSikcc2d/MMrWrt7byN/N4XgbsCGfySC3fritKkScShSHGCZkbsQG0Rt/tCMp
 jkVLE/A9M21Pm8ZUPChTs/xEmvdLk5/PknMj4SsRmmvElOqM/DA7lPULa/Z5rptKvNRl
 Kncw==
X-Gm-Message-State: AOJu0YyvXnnFB923KlnjjQz1MVjJP2Uwy85j50wyrJEHhyfbsmk0LWJ1
 5dEFTmc5LYcAvbZhHXQIhSkDj0earHtX/QGbKtikUV2TFzRR08xIn7G1D6JAPlZZ+pdPdYrG1xJ
 YQcXWI0ChmMW7f5Y9m1nogDUhQx47JGRI//CQfjWhdSQOG+88uAtS1EvQJPBS8TkC2g==
X-Gm-Gg: AfdE7cn27jqbUEJjBXjEhMiy73Dq8q/DGbXJyeBVXZksLvwJcTqmTXBaSkqotm5KFRh
 EhCBMCd9P+HRIeoyP91n8gAR+MP4qwWLtWWhTCaZ36VkzEwtMh1ozNMcpJ5z944B09fuYFQxSyi
 A9V4DN4BPizC+u2UwDlcOQIg4/nJUwUCZ4TnM6ez0s1fOSyrvxWdvJvMa1d/6mXV2//8cIzvRLC
 pfFlYdKn0awmni3GJxnT0UYA/BkYIASv3p+O2Fd7OkBb7kkCwmfkEN4FRguNo7uzUAX/HsxrP3C
 9NKBx6/oZ7DRMWSjxAkRrcHExit+NYMUAISdO5NlOd3WEAz2CPpwPf5bt0TUbmyHPgYv2rGPT5e
 vnW8mg9+Nw2WhoBbp9aqx16vaM11bnwbmpzl/1t3UqtFPFe1gcWQclWx0Y6sOSnkhKODXnotjav
 nC2qjFJQ==
X-Received: by 2002:a05:7301:e0c9:b0:30c:ab96:7307 with SMTP id
 5a478bee46e88-30cab967712mr1224357eec.22.1782517204257; 
 Fri, 26 Jun 2026 16:40:04 -0700 (PDT)
X-Received: by 2002:a05:7301:e0c9:b0:30c:ab96:7307 with SMTP id
 5a478bee46e88-30cab967712mr1224334eec.22.1782517203712; 
 Fri, 26 Jun 2026 16:40:03 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:40:03 -0700 (PDT)
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
Subject: [PATCH v2 29/37] tests/tcg/meson.build: introduce cc_feat and
 cc_feat_cflags
Date: Fri, 26 Jun 2026 16:39:10 -0700
Message-ID: <20260626233918.158740-30-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aoiCzyZV c=1 sm=1 tr=0 ts=6a3f0dd5 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=WryKx-XaCgVW6WutTgQA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: qatVe3oxmp8YaoImh3s6pIGccUcqyZG8
X-Proofpoint-ORIG-GUID: qatVe3oxmp8YaoImh3s6pIGccUcqyZG8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX/tlKEtO5XhvI
 QVF96rncXrDCFALNveTo+Za+EV4OZWnH13k+5Vcf464R7V41PQfk64BctBopqfE25SHSLBROQB4
 tpTjtAPPeFnANjWb4s9HGPdxovlOYc8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfXz6o2/Wg42Yu0
 /dEXjT0reXVezfdBI81LSHxaMzHo8YFNtNEmW4RZbTaJlQz8e3RDh0fF53fA08FdNWw3VXQEUqh
 j7lY13Q9a5adnK52DdK6+AM4yaUDZ2n77kC4EI1e7tJVE2aM/ax+0X/dFvmFYqb+CIyfhtgXCvE
 9r2zclue/w+y+RSykS2xJgvj4ybjVulo5PpBU4j+DBA/0stbK7P2oEhduL/JPpRsiP9MphbgfMB
 FaZaZRcHS2czHdkO2idy7oCC/nEQ5ToAj7gtDNX1TBsxasaWRXahcT2KfiqC3X1UeReEC844V2N
 xWwRde6amvMfTUtk4GQerOka9szbZFdEwpcOintpeLzngJGnDD8NRftAmXiMqshcumWniC/c4F+
 TCyL9JVhP1IieTkVJEpwwZ6bRZ2gvIzkE3RgyG5361oI6aOLZiXCWKvqd8FseeOfct1n8dLX4Xq
 HVXYs3WS5E9UUGWNyQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260197
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 17996561798..f4ccfb0bd84 100644
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
@@ -121,10 +126,11 @@ foreach target, plan: tcg_tests
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
@@ -135,13 +141,17 @@ foreach target, plan: tcg_tests
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
@@ -202,15 +212,36 @@ foreach target, plan: tcg_tests
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


