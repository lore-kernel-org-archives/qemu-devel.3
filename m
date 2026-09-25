Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9F3C98321
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 17:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAA89-0008F0-CQ; Fri, 25 Sep 2026 13:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA83-0008CP-OT
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA81-0000ep-44
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:35 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG0A211489508
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WIK2dkYh8wEkLnv9i1o/d86KGGsQ5w3Wu4HR9kL/kug=; b=IahGkfVTvrP+I6O8
 SnMSMa1Ewr4SQjus7RCXYD7fBrNCkQPGo0f3SyjQy3akOyNiMrhb/L/IPpORdwcO
 vWLRyQXNCnhWuzpSWxF7Vl6bh7H3es2NhBpA4L9JhIBB5Cf7iIliiqyAh+ePqhBk
 trCrfPjk7clMaAbqm2MqILzBBOdh7agmFvsQ6cK2zF045h1Ukvd2b8R0Dbx+k33f
 LK2KXsggXG7IZ4X1HKKJYOr433wfbaJb6Mu7egBlhfmI0zIErX6VptHwGzKwD2BB
 Kg/hhgb4hj3oA3GnPFtk9+TgH3HUDan7SGxltXq4dWOJmNz2rjkxPBUEb1dofyvE
 lMi04w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwr101c56-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:22 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33713e5e6daso1812575eec.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 10:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790358861; x=1790963661; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WIK2dkYh8wEkLnv9i1o/d86KGGsQ5w3Wu4HR9kL/kug=;
 b=ManGZKyLBtdFQAcBlRNuKM9rLMIy4iR9ZK+aFY8CsrWdv84x3r2qnEpzqAmfzPdLfl
 /pf71eRmG5d6+mgUyswC0JNz60l4eIAd1SLZlunt4HF4IWcluj3cYFmMN18z2ozVor4S
 qMzG0Uae9woCwg/CLAC7b+KYMKSbZoIYPNrrxnZh47AsPsuE/p3LKXPBwuWfLDWLtPoi
 P0KYXl/s7R3qEpu0LYFBQYtAj3C3Jzwqt2b34OuukHIr01U0BkcGI6Ko2RXI08RC05/5
 M85hqUgJZ9C/v55frJACFIn2EuIGZD7r1zzMWhLqcryPOcdntqlhXcbWkfRmtwyfVuLx
 N5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790358861; x=1790963661;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WIK2dkYh8wEkLnv9i1o/d86KGGsQ5w3Wu4HR9kL/kug=;
 b=xGeaUZpI6i+8zhzONYNEgL9Wp0TlEdraB5I2mveL0vP3mP7lo5tOW3n3JmONio5yg/
 qvox4ZQSeo9YQQzAt39OJoELzF4IMLJpWrSF6xVFkFloAXrmwoxKn8eCMFGw5d0N09oI
 yEIwNfslxh0HgWZXNBtV8BL/RIGxE2Pw/IWLAaNjxT1utWY1OivY7aC5cw4U1dRMkkWI
 +ElZP2kpScPgjGhjvasGGI9jdS6NFZpB9scJ3vhloniMrEuFyQVCEBGwkmJT+BtA1cXm
 3AcItS6LIEb/EklYCp2GpnrT6RfFNwv+RqBTAOrTBwuQBw86BdRcKWMB4N0HhRYs8ila
 MOZw==
X-Gm-Message-State: AFuF++nJVCLK30TNtjOXuE0WR0gIyue4TkPEmsOnRkemIxcKxVAAIx8S
 MfJclCFZxxuABz+10+U6qbCsbwcTiDQVEFrzhHI/hqnM2ovzU2Eae7C7/p+h9kLtjSn8wz3gieA
 Fz1n6hax/TQarQYC4IvLygQxSPBb8pniQav3fnFHN24WzXGpC0MHXGzigiYNg10BGPA==
X-Gm-Gg: AYBFou1FWLKV4cM060kq5oRf/ieS36tCDe1IjWF0qs4WqxRtxf7DqjCo812G9LL8PvZ
 IT7w9AP8JScdzfGAjvPQqV7IgNSmMVZQ6OFrUQaTNy4BYuR1B+0NyU1iJ4FAm3h1gZIqRNe17WW
 6ABnDwuyxrmkoiybNpLAcLCbjTsxQsN2F55ONloC00tQiEwHtqS1c7RAoYOsjZGFIJLj120Yzk7
 1WeRJqvORqd4CDBf1Kdaw1qTlfTwiAP07dQZfnPqH8QUfULpPID+TebhIvj3E5UOibXodbwQWXd
 OpeRsg5UxPzWfBQTBmzVeMGbklWMK1pst51ZM9pEy04qlg3etFy14BVr7AI5fS93nB/5DGtmUal
 RdxAB0AEurmavGF0hSKeAW0yEMJsDWStIFtHn3HqaNx46rmFgZcMJn7rdoQ==
X-Received: by 2002:a05:7301:f05:b0:341:6552:8c39 with SMTP id
 5a478bee46e88-3427374ab62mr779357eec.40.1790358861000; 
 Fri, 25 Sep 2026 10:54:21 -0700 (PDT)
X-Received: by 2002:a05:7301:f05:b0:341:6552:8c39 with SMTP id
 5a478bee46e88-3427374ab62mr779334eec.40.1790358860297; 
 Fri, 25 Sep 2026 10:54:20 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144172de6sm11055128eec.9.2026.09.25.10.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 10:54:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 11/13] tests/tcg/meson.build: introduce cc_alt (alternative
 cross compiler)
Date: Fri, 25 Sep 2026 10:53:58 -0700
Message-ID: <20260925175400.1897574-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfX2q0pL9sJvnGV
 hAECFmFcvpHv8CKglt4zvKoRAMiEOgp7T2fkbjRW+kiMne9pHVhsIxQa+IHkSb6VbazSxeXf613
 bIRV6/8lv3Wcn7diSwpo7/eB6ZgKVTGLbpjh5RT5Q5Ly0A/YrRqw3kexmsfdNM8Wt7o5ICviR0Q
 bhoiH3mFMmPE9wkeH9n7vrXJNkscXlwHVKBnPKJcv7BSubrFOErsddqwW/wZW/8a3Cen1GzI08U
 BP1vNZ0w2M9RBYimqZgR2la5LgqZMgkGwTDF+R4fKgc7jux+uXaXDl1dmuAv69N5MT/sJxF/CeQ
 REbo6PstZQsxrYQJIVOuubzuv/eGSYxtlbTxuLhM7uVhq4neeHSJNlkklBzLVIXEhnD33aEMnBC
 3VGe+Vp5zna8MBCVdiL4s5o9H7tVgDuCv7XskIj1iNqozlb4tOawbEJPEpuSTEhp2F8G/pbAFfc
 tlgTG8irlS8RoMlhPdA==
X-Authority-Analysis: v=2.4 cv=ZfKIpcVA c=1 sm=1 tr=0 ts=6ab6b54e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=mdCkaW5bcXnP46gbEgYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: Ymit1iloLtzTufS6HW3sTR5Oqy0gZi_F
X-Proofpoint-GUID: Ymit1iloLtzTufS6HW3sTR5Oqy0gZi_F
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfXxnK0BUoLCkXn
 3c6SmHlq8p1CQPlKNhn54Fx6QAtNTPKeqQ2tOE1TCNoUBFf3H6pyOSVfva3NHdbJZY0PWvoO0WQ
 K1UvSDGd15N5WtGmp3gxqIHuWUyzwDg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250071
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

This allows each target to provide an additional list of cross
compilers to check. With this, we can detect default cc for common
setups (debian/fedora/macos) without user having to provide a
--cross-cc-* option.

In addition, it allows us to pick up host compilers for various hosts.
(debian and archlinux have $arch-linux-gnu-gcc installed
with gcc package by default, but not fedora).

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260924213942.26491-3-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 46 +++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 24600d087a2..96d5d1249f2 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -21,6 +21,7 @@ tcg_tests = {}
 # {
 #   'name_of_target': {
 #     'cc': 'cross_compiler',
+#     'cc_alt': ['list of alternative cross compilers', ...]
 #     'cc_dockerfile': 'name_of_dockerfile',
 #     'cc_feat_cflags': {
 #       'name': ['feature cflags'],
@@ -210,7 +211,7 @@ foreach target, plan: tcg_tests
 
   # return a clear error if user misspell a target entry
   foreach key, _ : plan
-    allowed = ['cc', 'cc_dockerfile', 'cc_feat_cflags',
+    allowed = ['cc', 'cc_alt', 'cc_dockerfile', 'cc_feat_cflags',
                'folder', 'gdb_arch', 'gdb_feat_version', 'qemu', 'tests']
     if key not in allowed
       error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
@@ -218,15 +219,18 @@ foreach target, plan: tcg_tests
     endif
   endforeach
 
-  cc = find_program(plan['cc'], required : false)
+  cc_list = [plan['cc']]
+  if 'cc_alt' in plan
+    cc_list += plan['cc_alt']
+  endif
+
   cc_cflags = []
-
   check_flags = []
   check_required = false
   cross_cc = get_option('tcg_tests_cross_cc_' + cc_arch)
   if cross_cc != ''
-    # we make sure cross cc exists
-    cc = find_program(cross_cc, required: true)
+    # prepend requested cross_cc
+    cc_list = [cross_cc, cc_list]
     check_required = true
   endif
   cross_cflags = get_option('tcg_tests_cross_cflags_' + cc_arch)
@@ -236,22 +240,26 @@ foreach target, plan: tcg_tests
     check_flags = cc_cflags
     check_required = true
   endif
-
-  cc_from_system = cc.found()
-  has_cc = cc.found()
-  if has_cc
-    if target.endswith('softmmu')
-      check_flags += ['-nostdlib', '-ffreestanding', '-r']
-    else
-      check_flags += ['-static']
-    endif
-
-    cmd = run_command([cc, files('test_cc.c'), check_flags, '-o', '/dev/null'],
-                      check: check_required)
-    has_cc = cmd.returncode() == 0
-    cc_from_system = has_cc
+  if target.endswith('softmmu')
+    check_flags += ['-nostdlib', '-ffreestanding', '-r']
+  else
+    check_flags += ['-static']
   endif
 
+  has_cc = false
+  foreach possible_cc: cc_list
+    cc = find_program(possible_cc, required: check_required)
+    if cc.found()
+      cmd = run_command([cc, files('test_cc.c'), check_flags, '-o', '/dev/null'],
+                        check: check_required)
+      if cmd.returncode() == 0
+        has_cc = true
+        break
+      endif
+    endif
+  endforeach
+
+  cc_from_system = has_cc
   build_test_depends = []
   build_test_depend_files = []
 
-- 
2.47.3


