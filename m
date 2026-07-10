Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3221FC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4bz-0001Sv-IM; Fri, 10 Jul 2026 02:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bo-0001F8-3H
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bm-0004iU-81
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:11 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3n3X73802185
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 91s2lXW5Q3sqG8gx65z5N+fWAZDzArxvugpDfNcyepo=; b=AN8+A/aFqMGqjn0h
 LX7KYDuhfnjMYcwstenTwZlD1yadGyeOcvFpFjI6783pwz7RXDkCS+8KaqCp+r77
 wxSke5VvctjnBtTOVHAwc0T8Ct+OPBdxJs8n5dJLy/rOrrzdYbWuvRbaygkSbnpa
 4BXTyrpe0S8dH1q66w0mNEXsTheBoM5wmR+UsEF0RBi87tAcVaIVwiz0bZOlG+nQ
 Vgy+kyMJZOVAAEQAS1pvSzD80I9n3J67nr60vSTqnI5m+0wJbmPsp+suT7X/VNg9
 uodUTs2Z7CduYidLtbMSx4bbQI5Fb/mL2uax/HoLGrFsxN3gxNsOEkSHmml4Iq5j
 bVv5wA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4facqpkn32-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:09 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ca3b314193so11698905ad.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664468; x=1784269268; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=91s2lXW5Q3sqG8gx65z5N+fWAZDzArxvugpDfNcyepo=;
 b=j787Z7kk6T4RCUsQGz4xA0AGaa2M1f1b3/3U6a/foxMxVp4SAVKdz2jKAXCJfyQq5O
 giHr2LKST8aqCzucJhlwfCvaheU4EXgeT9XQKvtzF5UshqnsLxgY4SNg/maFa5HvShLy
 PRkGgYTmn+019rujxN+zrCXuJz8SiaSed9b4/ZA+yQXsWESJElwE1qUsplScpzDohf/e
 dWFYnFe7XBi+u/4kS7V9XPbS4popksLeJqzXmtfmV8vK1YeHrdidSBhCwD5+2AeoNFzU
 j8YT5qG1YyqKVPXkrq051raDN7P/6AcasPUhzIEagLQspqi1fas9+XoRu5uqIXnqscWH
 ntmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664468; x=1784269268;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=91s2lXW5Q3sqG8gx65z5N+fWAZDzArxvugpDfNcyepo=;
 b=OF39TD2oVY4bpiKBg4z68b1R6Flz77xt7G3REYKxNfyqJO7wpTciGzu7eDh2n9TsSX
 vk1tC+GZI04JrTJYwbY8g9ERB0i/H0E2SnFyceWPNqdyjsr4jBYuey5GcKTUPeK16U08
 v9222Q5neOOPt9HP7kZO/dNmy3sX2ztG/ZC9ONJCEju7nRf6W7LW3Za4sXI2x/3TeF2m
 GG9OHHLFta1VHde6hfuZBStE4a3PgmLRL8whvRUQ3WQQ8+hnBR5+ZnmJKGxos+JWEJ1x
 rbxlx813ruqUOJz7fMoewZzPgIsr0EN+Z1LWDLLQXPXixyIk8U3czds5g/Ao1nOfdhuc
 NrpA==
X-Gm-Message-State: AOJu0YynTQIRcyLYei+AqC/578TBuw4mRwpGySZtr+Fx/9E+lAXl5R+d
 +63Pypu9xjcfrc//X9cXnWfbKE3GoSkErklMeooeCHO2JPO6FbvBRTKSHFaiSQWgAvTGFyBiHsP
 wSpKkqUXb6Klc2uEsXxZnyS2cano+OVHOchGldJXZa73M7vb9Qc5UDwYIP/c/cVr3Hg==
X-Gm-Gg: AfdE7cmqWPsbr/CFh7HdUl0Ufqt1EjalTSmwLjgc5WXW+PBZlI+3E5kybnxm+4nPCza
 tjQTJKJcrWsjEMMvobH3j+rTEjnUcg5IFEtfYFScp1ZrMBVxBgM/q3hjOuDYXSO+dEtvfiNZOdd
 ME4dJrYxLbK9f+F8y0tjMUtHRxLqS5+hf/nmOQNeBsUrSK8xiTBdHY1mVWFO0otp1zUMEeex9IM
 NRlXWxeXck6mj6Qox9L8gxm68d97FTOf+qVzoUeBDeCeVQbg5Fgn52XaHVFl5p+DG+lOlWGSBem
 LtDeQDMAWZo8xaDKZFTEw60bGKgY17pkRH3ktgZ0BC7WVxYxrJ/isyrhTi4m9uBq2cOO+LM/uu5
 6+je7PW+zLbHzYHDiJxau4dyZJDjCqCle8K5WC8eNuOT8ZjOg7M8zNkMqFumCYd1QgIhXtPsEcL
 2s/Iuxsg==
X-Received: by 2002:a17:903:1786:b0:2c9:e261:95ce with SMTP id
 d9443c01a7336-2ccea445692mr109099665ad.30.1783664468252; 
 Thu, 09 Jul 2026 23:21:08 -0700 (PDT)
X-Received: by 2002:a17:903:1786:b0:2c9:e261:95ce with SMTP id
 d9443c01a7336-2ccea445692mr109099165ad.30.1783664467710; 
 Thu, 09 Jul 2026 23:21:07 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:21:07 -0700 (PDT)
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
Subject: [PATCH v4 23/97] tests/tcg/meson.build: introduce gdb_feat and
 gdb_feat_version
Date: Thu,  9 Jul 2026 23:19:01 -0700
Message-ID: <20260710062016.1818125-24-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX/0kVVQg5oyqJ
 tBx3Fj2cUGr+7nseQipWSrJqfn10BopRP2bI1fIyj5Yc+ehRtUQKKmppXB0vTmFiYVv4IGeqQWY
 +zb993nCGg1/OW9OYxxUPYPsRF+Qk+2/NN6aKfh1xUeodTxLBkiZlnZZm21VBH3iRHbwRPRXj8v
 leLAU31rJW2hPCFgaceuWBbhA0nYNRp0C4v5jyGO7CfNjTOmgTXgYs8wyQQTt29heeiahPEGxYR
 cJiiUo5s0LcGwUplMj6Nl4VwXhPXoP7VD4+pVDLdhnMpAM72o4ZdcI7W9j/wm9sUE+yTnDNcUbX
 vDnGaryEG9Z2u7ocYTibc8IpRVBlk6cLZgDScZkb2JHt7uvWs/1k21hM+KB0cMOUOtbOOnNdHHW
 d9MNcyedeXyzyq1QxG4YhzTenJAgVOK8hNWqIpM0woR+OwL40jT5KZYgVDyDci3aONH8BZxTCUh
 o2Mr3L3SfpmCa+2Ef8Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX3QJRIEFXjZ3H
 qaqIUYt6NmggxZgqBa3kKPuRVXj/Nou7uHeLuxRZma3gq09tyKz2KhOThfVoBBxYjFpEZk9zKds
 WNNfGvULzIwgPSFNUU5cucJ6uDwr9Ko=
X-Proofpoint-GUID: 34skcQzeUVp9igchqzAvImFEyTLbfcAK
X-Proofpoint-ORIG-GUID: 34skcQzeUVp9igchqzAvImFEyTLbfcAK
X-Authority-Analysis: v=2.4 cv=GJ441ONK c=1 sm=1 tr=0 ts=6a508f55 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=WryKx-XaCgVW6WutTgQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100058
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 26eb17fe17a..993a948bb80 100644
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


