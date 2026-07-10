Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8478FC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ1h-0005Pm-JS; Fri, 10 Jul 2026 17:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1e-0005LF-6U
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1c-0003VK-B2
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:49 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ALCwpI1931878
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kQimGDNuKiuhuIEEHQFQxGLGl1a+/tf+bL985DPbqZw=; b=B0BwkPyPvEHh33pl
 O+uQpf/55FH3SUd6pPWW3Flkl8etIuKal2MhYwaDezfzKtRlnt8SDHeDzzrUGIgn
 jyFoflhb/0hr4c3VCpQslwZfG3m8D20GM0q/Se5FPm2l/k+lroyMmqwc1pELgu9k
 bJkdfAPv3tcaPNJ6vvO1gbktU8UnfLq6A1z9nfXVkMhm3oS4ca2Oi314QsEHuv+/
 K8h8Z8Fg2RqiquJf4cg6bjs5d/wAGt7osdxw7xIzVP3aQtluSY7CbxHPM0pvNM5R
 QAJ6X3+fE+7Rek+13Z109g5tk2K0bEHNFuDO1oQGKDnciZet39Nv7Uc8aZcuL76r
 GrLnpg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb8f2r2kj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:37 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cab041eced3so294572a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719876; x=1784324676; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kQimGDNuKiuhuIEEHQFQxGLGl1a+/tf+bL985DPbqZw=;
 b=J36E+UPLGzQd5cegJCM6GZ0/+ry756JWqgw4ys+Qgobu2MqutWyu5CQIH4GqW7Bu2m
 fqG82dTpYxSIlANlngXQfHAPD71dZH3IOWYn48uUWYSabMsl2qWQGd/ffVwG+BLlqgbJ
 RfWveRK3yLZGPgJsISIFZv4iJqfIEuI63KzxfH2vFddKDLT8Suo2t6FySymiA0KLxDab
 kb8BHDeOLitFubn+PHEQR9WY8HdWi/3qiyiKLiiGtkJZvqx1zxev54ltVDkZ12kjQm1H
 7+KGBdRbRLLkwXpENkWaiJDzyvJ/Yl1p1a0I6H+XlXZ+s8wmglhn1YhVNEKi6fBDppuF
 7Adg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719876; x=1784324676;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kQimGDNuKiuhuIEEHQFQxGLGl1a+/tf+bL985DPbqZw=;
 b=e6wX3Y6geTPHDbS95a8Ct/HcnDvtFmv8MzZWglmYIcPqdYdd1ULjzraNsIymHnaB1J
 OdXpyqwK5HyA7dAWHfexTOONdq3VfUKsjXAJnYKyLIZrGOPkrDEcYFXTEMkMy8BnB7Od
 txvsiAmze2rF0GRoe7039pb8rhNuNmVTP9A8Mh3AxP6T5cpYRu/lkXdYZ1uqS6vKPNRT
 8225sAckUX6nZXRwUzRt9JokrtUYpzORwUVg431Nkg9vgDSfoEk61LObpkYr4S56OyvQ
 Ij7qsv7e14SVknRAGt6mGqKWYXPbYpoU8xfS4rD6WlBf/8/6x+/VWq8rDu7Px+xtwpTC
 S9mw==
X-Gm-Message-State: AOJu0YwBCpC1N0/Mb4iTngdrGspT2RbkJO/HlIM6cW+MzYqteF0j3/hj
 zRocmV/V8jIIjYUBIujmXlTDEoGE7lZW0tXuEB4/s6zY/b3IWtMEPJkVzw+jXZ0kJFEDJeiHsFE
 fG4+CHu+JI5wgSkbCEQXkWBGV2fooc9uAb8cOXX8gT5Q8XuA/HDdQRtSehrOjdseELg==
X-Gm-Gg: AfdE7clhSHZnWwWQrjapJcJc2m7hkQumlZs4ejzTk97FukutfKyvj2Jcu1kyJVaoYgs
 Vp1EcK0lSZicHVshkI2BwV51rzYdeSdC3t+2ue92wMp3qhQA5LrXp3snj4+ufYMgJOJDCJB1krX
 fajJXo6Bk/0NDyJafI5Wmvqw/4LbPiX7CFBWUQwgab301Ez5Z3kyyGWgQ9ge9AWZDj6L5RzZo2w
 7MRsa8zr+iCtIXNZL+H+9uX+k/bm91lFCE1oTT6pg7vEH2okQnDo2ENiJpM+PtF8aKYlNMgtssX
 rVPXsuajKr1dJC2m/Ty3ai2XwS/HtIxEjUZXoU10LLfPHBitRrrva/K4hX+t/qCqbRpFoiWHAGn
 Hny/7U8f5VVhtdyKqMRnGMKb0co7malkQ5yXWXB5D6/w1pHJ+LL1caQfBmjaEQE4rh3WVN/futm
 882lXAqQ==
X-Received: by 2002:a05:6a21:9cc8:b0:3bf:b960:6fc4 with SMTP id
 adf61e73a8af0-3c110a0e99bmr675136637.30.1783719876365; 
 Fri, 10 Jul 2026 14:44:36 -0700 (PDT)
X-Received: by 2002:a05:6a21:9cc8:b0:3bf:b960:6fc4 with SMTP id
 adf61e73a8af0-3c110a0e99bmr675098637.30.1783719875914; 
 Fri, 10 Jul 2026 14:44:35 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 23/98] tests/tcg/meson.build: introduce gdb_feat and
 gdb_feat_version
Date: Fri, 10 Jul 2026 14:42:27 -0700
Message-ID: <20260710214343.2065491-24-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YLavDxGx c=1 sm=1 tr=0 ts=6a5167c5 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=WryKx-XaCgVW6WutTgQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: tXQNbUtK8d3OT8XK_PPttwyMM6cl5yRo
X-Proofpoint-ORIG-GUID: tXQNbUtK8d3OT8XK_PPttwyMM6cl5yRo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX/5XveM/Jc2Sm
 Fy+nBfPp40EZTQ2H2Mhk6okROvuQ35uQnbm6mGt3t79/7RPu7eOLubmO/Z0Lp514KWHa/3Z1/fI
 OWZ53ih1SGdcIGvHD7De3fkmt6UnHxs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX2DYxoQ3H5pBT
 Gm2xgpgmmJ8jjK/YyWMSXCY2cTb4y+Lpy8weOllsdi0TWlG+hySvz1mSFmsQIkCV9Ji2Nl+0ADF
 sjXTDYpDw8KBrdt5HkEzfSV7Ww3PLwNBHjk6wUo9bht972F4USELgv38KdMpACNC/ca2kfP4tTO
 t7BVe5FNvaZtABxYIq/cPlCKWCvCQcrCjSusE8Zlg97ArRgC/mVjr6v0qIj0rR3wSHpfZR2ivyW
 OPywPcDlG+C+1GBHZ1DloOw68u3fuHMf0Gw+tmD6gU2UZTNwZeHYvjg+1MDtk9DupHXU0CNbukZ
 kN7mjisde/VtvPfR+JatcMOE2qUpDgY2WQvb6078FjgJ+p5MIJrgoAfnOrgKRxSTXVXiSsdPSHj
 x5aExbhh1HFjqkQ1r5V09JQa0omVX6vUCIctvi2kjwGznJu17yvDVgjIUqkhDJEWJefN0PzpStj
 ajKGG+LXO4JtT11cZEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100218
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

Similar to cc features, we declare the same for gdb. With both
available, we can now declare all tests inconditionally.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 4487d61ef6c..7384786f7f8 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -26,6 +26,10 @@ tcg_tests = {}
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
@@ -37,6 +41,7 @@ tcg_tests = {}
 #           'qemu_args': ['qemu command line flags', ...],
 #           'expected_output': 'file_to_compare_output',
 #           'gdb_test': ['gdb test args'],
+#           'gdb_feat': ['feature name, must be present in gdb_feat_version'],
 #           'env_var': ['VAR=value', ...],
 #           'wrapper': [program_to_launch_test, 'args'...],
 #           'plugin_test': {
@@ -83,7 +88,8 @@ foreach target, plan: tcg_tests
 
   # return a clear error if user misspell a target entry
   foreach key, _ : plan
-    allowed = ['cc', 'cc_feat_cflags', 'folder', 'gdb_arch', 'qemu', 'tests']
+    allowed = ['cc', 'cc_feat_cflags', 'folder', 'gdb_arch', 'gdb_feat_version',
+               'qemu', 'tests']
     if key not in allowed
       error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
             ' (possible: [' + ', '.join(allowed) + '])')
@@ -98,6 +104,11 @@ foreach target, plan: tcg_tests
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
@@ -105,8 +116,8 @@ foreach target, plan: tcg_tests
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
@@ -261,6 +272,18 @@ foreach target, plan: tcg_tests
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


