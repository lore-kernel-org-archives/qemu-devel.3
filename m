Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6E2C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziO0-0005uj-Rg; Thu, 27 Aug 2026 18:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNt-0005dH-Af
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNn-00066s-M6
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:45 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJMJOH3849193
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AMk1CMU9eBZ9zKutPaQToXQWF2Fw1PQUjMrnTHWhKlo=; b=iF6dc/fV0fBwS8rf
 Rzvmqj1m/1s3UoJC+i1Ow5VvprNeK/0BJaHu3bEuUAYn5pvNoOxNX/EljoFJ0Yo5
 TQ3mvFf+/4dxmOY7hZHbifPKJbo+x21IXId8tBVrj7R8F0O4HTDiKZ5K6S93pcWd
 nvV2L3Sk3P/SRPgS3tyJ4q3nvXw1S2qVQAjq7P92iVMQyEoZCBwWTt1iqVTiiwwc
 F1gt96wjKsTn9a0p5ySM/nRsQLRbDMsv5dxPcqzCt7hGzC6XDoVpZ3Po/8f+DYCt
 OsR2cRsLfUBgJf6wHjwxvFsUtKZ3O6PV7lYUYWBTJbe5kXmEKsNMoUYEtmu5ELYK
 +MNmKg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatnc0tw0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:38 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-848d21bbb55so647470b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868937; x=1788473737; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AMk1CMU9eBZ9zKutPaQToXQWF2Fw1PQUjMrnTHWhKlo=;
 b=Z9k4b7hCPnsm1jlmSDHKVm4+j2LdJEXcaoKY0YFzzNJ/gpPmzJ/qchFlgb7AsDaIPL
 fMmgj4pKN+QoGhYczsjGOKdkDvSWif7gxvgOAwl27tdJIne+HdPhWQi+TugUguR0kig5
 6Zfoc7gc6K+xOWzRQABFgG3lchz+oOnNjd0c9HNRS/PfcSgSQbfZhkQATh0z9vcEyblJ
 2BwgNHbiOvZEIoVKx1zkGKE9qlkHRiaEentMrLbqSrzGd8Zol0sYVkAeM64rHCpyS5/c
 Bjn/b1SP8w4RKmq1YBYpW07jqXaLnsUt5sVBC/PV8Xr3Ggh0ORYalevn4TvF5vQwY/J1
 /gJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868937; x=1788473737;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AMk1CMU9eBZ9zKutPaQToXQWF2Fw1PQUjMrnTHWhKlo=;
 b=GkJBK8oLHGPjWIfz8w2lsfsJvik7xYt05i9B65P+5s+dxA62CGvtzHhPWq9dr5y4QK
 Pmad11peE83AaQftjKaIiThMRdr3XAhDLXt4CghOpt50cAOfOjlZN8+GQUu8b0apMfNb
 R4T5K+kZuPS4dMj+N2l/ntthyxwlnajWbzoaEuA2wPPOCX1e1UV3+amfFqaLvziVsMgM
 B2ZPGyVfT5Nx8UKFQLzdvyakI0sbmDu3lqA9SRvhIl+oJXuHgWZkN3KCO6gkbF099kPm
 h+RkWjwv+LRO27q8SUz0v8g0dTwuEQUPSR361r3cFwdj7dqpI3my7x7eniKq2XBlqg3l
 XcOQ==
X-Gm-Message-State: AFuF++l4K0hSK2vStgpwCrl5apTpfVrfhFPebUMa1sPTeXYwvVAh9Q5j
 dFGDqnkrW/4zgf3yevxXq5TPUuipuXF1HoVgIv4u3bVyzj4Wnj8xfXIca4Ngy4WFPEUnP99E/yJ
 sq9eySAZUKt3rMkJqHqSM/dvri9Y+pS3zymd/hnaw6K442xsRgSSXacm3n5xUHZILNQ==
X-Gm-Gg: AR+sD10Sx6ajyMFbMnqdGoPXh+exiAAVFCUl3esXIytJcnA/Ic2CvyZh4+0/wT+KhA4
 oIn9qBkYE9GYgFz+/X8QqbewyL+2pbwk5dsAH3q7nxLTPsAuMjLIPjgoZfUSyN15pSvPX+MdqYc
 oPsME1BsrQSJd32jcDA3eq6MFhzH+xxGl14ShT5MAQio6Hk3sDPoGeWwrHvy25JepJKjXXSrDvu
 BhL6JGTEPGh1+cA2gRxdis+dZy8wRaW5MShPW6csRG2aobDheveJnz3MUakK5wKVYmSpvL1MCo8
 Zpib+NCV9lENWw+46ksv/HE3Jx3wui8nrEhekZjYv1btjmyDD1yFf3XY8ce83oSShe9H85X+uqp
 YhNTb0eqKCWZEJDt12W8DRoIdXGMl/P7TzVATO6ZHcymHepe+V602vpJXzHk=
X-Received: by 2002:a05:6a00:414c:b0:848:4754:28e4 with SMTP id
 d2e1a72fcca58-8562abbefa2mr4619728b3a.15.1787868937434; 
 Thu, 27 Aug 2026 15:15:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:414c:b0:848:4754:28e4 with SMTP id
 d2e1a72fcca58-8562abbefa2mr4619641b3a.15.1787868937020; 
 Thu, 27 Aug 2026 15:15:37 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:36 -0700 (PDT)
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
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 023/105] tests/tcg/meson.build: introduce gdb_feat and
 gdb_feat_version
Date: Thu, 27 Aug 2026 22:13:44 +0000
Message-ID: <20260827221506.91574-24-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX33C9uAVV8Fes
 KqG0ZjQugJ8JlcvmrxZ4AEq3/WRfW54w6r7ZwyunFrzt8b6nbzBCViOsrmN59sox56xqrgo/xS7
 SX+8v1j1WLzzA8uWGDHxbPU5m5/fYSECngGzYXU55oaiulFK3DV85tKn6cTIGFU4NFgxcNIXs3S
 cawE4osBbtKA/odMtAGUQktJMTE7qCfZE9j2O1lTDLE93Rd+wgdHryMETIIvsrNg4vueZvVuoug
 0PbBdO6+zfw056u2b/OSu8Cperv+yNuNb5xzlZDiA1zAVrVmHuXuTipsTozMTQpriP3jFYQoNRh
 6Ia3yAOulzo+uOiNyc5D3ziDIzg48joHwuP9evmSSpkbEy0eHU/cgxIBCNKval92trF4Cl+XBb/
 6zQNQOfTepQdWz9TQvA+zXsjwHE6zWYD+Yd/i3dG5SRV1afzzJI1qC7j13Zt0iZArjsQgT+ApOE
 5HZbkatHqI5EIiAdFgQ==
X-Proofpoint-ORIG-GUID: tVrrkvRkOCVtv9QbuFmglyOqt0pAMEhd
X-Authority-Analysis: v=2.4 cv=HfUkiCE8 c=1 sm=1 tr=0 ts=6a90b70a cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=WryKx-XaCgVW6WutTgQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX1hBk4icPjVMD
 gdvvJQlZ8oXwGlYB5foqPkRC5ncbM0DSf7G8vD3cwn2kwdaco9ghA0VVWuW5hnFj6Z5o/AaAQVv
 0QDW8/kwRHSYa2FLVbhACfxv8wDiDVs=
X-Proofpoint-GUID: tVrrkvRkOCVtv9QbuFmglyOqt0pAMEhd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
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
2.43.0


