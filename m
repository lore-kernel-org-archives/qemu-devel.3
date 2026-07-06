Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0A9C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrtz-0003Sj-9L; Mon, 06 Jul 2026 18:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrta-0002pk-BX
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtY-0005ck-77
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:33 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDnlR1649860
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Hv7Ev9Zz5Tw
 1SEEtTonJZf1TnaHCzr0RTiIFgALDt+0=; b=oLqMY5KtRCK2LOTNq+xRNVd8ivC
 fw1sVOaD0YYRa1mmUdm6QcTDuwSDwsluaeIcec9gat1NBVqHCHzTTPCN9yxY3Pyf
 jBoqHLWXy29n5I2gvjxRNyZqpJtteK09ffWB9bim4t7crs5SB2ADkMG2bd5BTEaf
 Hx7kEHVKppZB7qYSZ6uznBi+ENKfMnhak8db7StXGbvDbcPqGihibtKWNEeAZBdo
 bw4m/TnTlp6daTMOwzZ0ztcJlZiqEjYTJZ2ht45vg2HvUslvJce3DWOdxHC7pvpx
 DOJ6/SIQKxT63vsB1uHJvHjT6veDN8REzM4x4K8IRcv4spqmDbxdtDTTxyA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kguan2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:29 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3810960140eso5625233a91.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377269; x=1783982069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hv7Ev9Zz5Tw1SEEtTonJZf1TnaHCzr0RTiIFgALDt+0=;
 b=azuGm7ZI5EonidIVh8u9pAtlN4NWvDkSi54G71r7PLgZu7ZaoatsxF5zv211rms1h3
 lAIv99l/Xc8e3r2qOifCDH3W9VO5LcwSBkjwT5UGpU/UxrSjFUUHdU8prQ6bHTh2sjMw
 7+tWcyXpx8bxt7djWzzpopqazx2lCZ0nH1mn4+MHb2NZJHGMrKjCNKw610G79ExmPSqA
 sr1qBMuO3TM7a2kd+PtwHQUon2Cpt42Wh5dUmACsPH3ju2e02X5S5xlRz9nsG+wIjhjP
 iv8BgLeJPWD+lVACt4hTbmK9dj3Sr0Ybz6O6v5SyIg+Dh+JqIFHNJIi1V6d2PWhiA5i6
 DCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377269; x=1783982069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hv7Ev9Zz5Tw1SEEtTonJZf1TnaHCzr0RTiIFgALDt+0=;
 b=TKns0IKX7T2fEY0IEACPgx/Oh0MS89SzP8jqpnwiaFV65feru7Y+V8TS+j9vcT8ss6
 JXfJsywieHACtFxkzMZqd7tBSCKGxXWSDV/9mAXtX48OiUSnXA281lYvKS9ajN3+jBjB
 t+FAG/bh6iUEd4DRUp7A68bkQv2l8szvTKCd/M7yjHYP+8e3Tuu4f96HqtyAZtka+/Ev
 PB6lKMWp8l9/QXZt6gwxDdd5WGSuia3Hno6/zF6GDW0EqCWkEjGA4aqEqvwmql7XZMPl
 sfPb0Bnunh3Mxrxx1d22raw6wTnHuB95JhHqYBN3D6e4Kv9FLkQIXWbNzFDDAMeEh/7W
 Kl9A==
X-Gm-Message-State: AOJu0Ywn2rRKxSwu0yPcrbqyvTc6YUCzNtfPDJVB2wBw755WgEwdtGIH
 UlX9PT0Bfe3A+GKQcLb67nV+3rBsTMXYjDI9YVpMr3oceOuUZeaeBRjFczkGf6SlOjP7LXHtgl+
 mYVOY2YDcGdAwtEwi7bt5hERAQxHXloJRgi6FhHdeQgpMi7s5gzi4WoSEx+9uZd15gw==
X-Gm-Gg: AfdE7cl948lwN9gG6JBRjmywvlGJufH4v12cOvMhghWh2bSGIGTwD6JuYOEIFSDPly4
 hqfHpOPCoPcg3MrdJyR26PhNkkqqZyyM2moKA22A+fZul7B99wAK4uspw53BhoeO2WWWK+iM+bk
 oZYcRDu6CTTbnMPR51ZgrEmb5vsqfn9hEDZPVyqH0sN2Ar3yXUP5QqKaPFUdyviMkIDBFpakn9z
 B7Z59WZvhBOLig4k8RCwK7pjj3eKcvget68tUTLD6Jc4fO7avG1pPQiQsutvziVFXYg0EFqZ7jB
 WUIP1Wxyvpiy4gFEbE1l6mFSZ0MAhCw7e1eWpxyvSUu12JBMdKL+k6KYnsYJpFZ0oiDZ649bVhl
 +H3W7ZzvzJdDDg3oJBP4xRnqZPR6n22qfFs/3IV54XttY0TKYdz+45dP/fG5DrTLxnnq8nU5B2W
 vN+MgRgA==
X-Received: by 2002:a17:90b:1a86:b0:37d:ee77:78ac with SMTP id
 98e67ed59e1d1-387573b2d1dmr2450012a91.19.1783377269028; 
 Mon, 06 Jul 2026 15:34:29 -0700 (PDT)
X-Received: by 2002:a17:90b:1a86:b0:37d:ee77:78ac with SMTP id
 98e67ed59e1d1-387573b2d1dmr2449982a91.19.1783377268561; 
 Mon, 06 Jul 2026 15:34:28 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:28 -0700 (PDT)
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
Subject: [PATCH v3 23/91] tests/tcg/meson.build: introduce gdb_feat and
 gdb_feat_version
Date: Mon,  6 Jul 2026 15:32:35 -0700
Message-ID: <20260706223343.988769-24-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KIbx-LSaQu6w5y6nPmVbUJdOZ07FclBS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX4nc3K3nxTIaN
 /4icOuGj7tZm8KxB6PXo1+Sf3kkdkOc7VSnc/N9EJNHKtSLHrBZ9g4E6hS2YZlaJ/np42o0ykhu
 HCWCbPn7KK+av6zfmOSYuxhA5F7/shE9ayOaf7KZ+UMjIIl/idq8w1xtOzQQ+L0Hx3h3D5j7YQg
 JDmvNuD8WiWJKJJGlZqNEbScBbhhPmY9H+DK9aXQU7HrbXXcoGkZY6Hd0A/otjuydgkxFnwNEJH
 OQZ368AoU3IqsmFJwwWVxdaiPjAHAHq/rzgdtCnMwlvC4Ym2tna4ku6uAo9wsK6xO/w/zHEUkxp
 nUQgDnxEU0w5qFYy7dmwHboecvlwkwrAm3IHTDbPJYjICX0mqG1OgT2M1IeKTqZgVvkHI8m3nHT
 ulWDqe7tOUG49VJEr0FalsaRw2i8kEhL59a+WTLfMcpJzq+5riGkHyTqy2hdYIiBDKSCEFVeKwM
 4hH0uFQE0qy4/vC7CLA==
X-Proofpoint-ORIG-GUID: KIbx-LSaQu6w5y6nPmVbUJdOZ07FclBS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfXxOtPHfBQgla5
 92w6mOQ/+fhtmlMmWB5YfLqHLM2VBuY5qyURCr500tGn9eD4Z1IUUP+gxDD4D94K0uDVCeCPnmG
 gCjsBwF5ib7fPnOCOmxYtoxM48PJ/f4=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4c2d75 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=WryKx-XaCgVW6WutTgQA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060227
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

Similar to cc features, we declare the same for gdb. With both
available, we can now declare all tests inconditionally.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 91e71ac40f2..3b1c72a0f8d 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -27,6 +27,10 @@ tcg_tests = {}
 #     },
 #     'folder': 'folder_for_test_src_files',
 #     'gdb_arch': 'gdb architecture requirement',
+#     'gdb_feat_version': {
+#       'name': ['minimal gdb version supporting feature'],
+#       ...
+#     },
 #     'qemu': emulators['qemu-...'],
 #     'tests': [
 #       {
@@ -38,6 +42,7 @@ tcg_tests = {}
 #           'qemu_args': ['qemu command line flags', ...],
 #           'expected_output': 'file_to_compare_output',
 #           'gdb_test': ['gdb test args'],
+#           'gdb_feat': ['feature name, must be present in gdb_feat_version'],
 #           'env_var': ['VAR=value', ...],
 #           'wrapper': [program_to_launch_test, 'args'...],
 #           'plugin_test': {
@@ -84,7 +89,8 @@ foreach target, plan: tcg_tests
 
   # return a clear error if user misspell a target entry
   foreach key, _ : plan
-    allowed = ['cc', 'cc_feat_cflags', 'folder', 'gdb_arch', 'qemu', 'tests']
+    allowed = ['cc', 'cc_feat_cflags', 'folder', 'gdb_arch', 'gdb_feat_version',
+               'qemu', 'tests']
     if key not in allowed
       error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
             ' (possible: [' + ', '.join(allowed) + '])')
@@ -99,6 +105,11 @@ foreach target, plan: tcg_tests
   if 'cc_feat_cflags' in plan
     cc_feat_cflags = plan['cc_feat_cflags']
   endif
+  gdb_feat_version = {}
+  if 'gdb_feat_version' in plan
+    gdb_feat_version = plan['gdb_feat_version']
+  endif
+
   tests = plan['tests']
 
   foreach t : tests
@@ -106,8 +117,8 @@ foreach target, plan: tcg_tests
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
         allowed = ['exe_name', 'env_var', 'expected_output', 'cc_feat', 'cflags',
-                   'gdb_test', 'plugin_test', 'qemu_args', 'test_name',
-                   'wrapper']
+                   'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
+                   'test_name', 'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -262,6 +273,18 @@ foreach target, plan: tcg_tests
         cmd = [setup['env_var'], cmd]
       endif
 
+      if 'gdb_feat' in setup
+        if 'gdb_test' not in setup
+          error('test ' + test_name + ' is not a gdb test, but it requires ' +
+                'a gdb feature')
+        endif
+        gdb_feat = setup['gdb_feat']
+
+        if not gdb_version.version_compare('>=' + gdb_feat_version[gdb_feat])
+          skip_test = 'gdb feature ' + gdb_feat + ' not supported'
+        endif
+      endif
+
       if skip_test != ''
         # still declare test, but skip it and print reason
         cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
-- 
2.47.3


