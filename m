Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CDDC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPr-0007ZA-DA; Tue, 18 Aug 2026 15:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPp-0007XR-R2
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPo-0006f8-1n
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:05 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH9AD1454264
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AMk1CMU9eBZ9zKutPaQToXQWF2Fw1PQUjMrnTHWhKlo=; b=lCrl+wqmyK03jr/v
 4C29QvXw9e85sjx16XAeJBFuGhqfE0xOqqDWtaQuduG/2tyG01yOXSd2SyU7mwF3
 ixIOJav3OeUtfhL73AAscin3OV4KTi/47VSloqumQFAByJdSUXTAF4okOGzh0+4o
 mo1xIk9V3PiecBTWwxVomyVY/wFK5bdfngu8tMML8v/PoF5UpZJovQcMZnD1koF4
 L8ZWs9Ks0TkUlnA5qUXdPa625H8yzCMrGgV1Tkh0eBIqzc1uSUeGTQT1mfsVywpj
 WkXFEpZBHfovlgwjGWdCEZb1G9ME5dELYTNDrmyjnQd6Fk5mjZFh/cJrkzOB6d97
 e1ajjw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4qxj1ud6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:52 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbee6bb8408so149763a12.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081031; x=1787685831; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AMk1CMU9eBZ9zKutPaQToXQWF2Fw1PQUjMrnTHWhKlo=;
 b=cNNt/cQx/SmwlWqjTwmub6oOahR8EWTI6X5qmZcFPKAc7yD0SRYpxhy8z0BYUKdTum
 HmtSKajKceMFfWkAuH79VgBUR2iLszJHL3DqKzrhcYcXlkVueH1CvrTOh3dlEPeTVMrP
 LTz9hpc3I2NAVxXbmrtY7JTEM4uufehsftGZqXwlv9rM40MOCF6Jj2v4rRApa2tc7xeG
 0/AkoThROqX1vt9Vjp+mIvG08WJapKA3WRmv2xaGAry7MTS/+6rxsb4wmWOdsFK6HjxF
 gUTLU7sxEjnBX1Fc0TIed8Z+FRip/9vtXPz5pGWwn47n8tUxPVXPtifaWfliWW1yVal1
 T/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081031; x=1787685831;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AMk1CMU9eBZ9zKutPaQToXQWF2Fw1PQUjMrnTHWhKlo=;
 b=UugenCmFaD4LdXX9BpA3CEyOS64Ko834u+/oXtCxVEMKUrF5mX8CrzpYCKdpe94hwK
 dPCgECn8EKKBUz8uCix/fwcFvgGddpPabpRfIGu8Vv5VkmzETrYfzUvc3pIt1pP7aqOE
 dcV0xbq3Ar9eNZt569sj3wykFrkYYi5WFnLL/06XeBza0NR3W2ZI1gyDt9XYz5Ad02rN
 xvM+a6mrwMA+jiAaTzHg1VHAt/lz0tPgKFhnOWu6ZO/Qk1yiPdI9LlON1bCSr07PB8z+
 pLmfxhs2lthrWzTq++nt1aNdUC7opCSKSWG2d3TirNrzxhA63U8O0X4doiM3RDdltiyw
 7g9w==
X-Gm-Message-State: AOJu0Yzj1q5rWTUMvt5lrhaXViOalmTMfwrapyoCOOKB6sefbxt+BNRh
 mMb5kuzswuwivGKdKfzZvntgp+t8ucnTH+gL6WqKRE9DzUs4gBvmAE8LZ/sWuGRaXjz1SH6//NW
 XB/CTX1EsrXdhGZNK3iHR3AoV/owOyenhRNRv9G/tK3dRvtQE0xuWHpceRvvouRr2ZQ==
X-Gm-Gg: AR+sD13PXT0/IqhHbYGpQm2z7m0W0mFP4efuBVCpJXWnDFJoCgtdgzCjM8MMxKCP00N
 vseaD28CHvA082Tqu01fcLbh+5wA/ciGta4NcqVfKKJ0AypmkBNoHujUaFxUN1buBbqqnmu4ZWK
 /ljD71w378u2e0EC9IFnmnSM3bX3Kz7yllzQCqKKslVI87C+VjRNUyGQ9+s6VmQbmVLggzgJaZ4
 HSDKH/chh04NIdv7Z2HkG5o+IN9+XBWQSq0kYsWwMdBemocY2jB2XQmgvJ3b+ssPmBmDHd7YvY9
 e4+J0sqHJY1m7j926golpb9o+i2MFJ56Y7vms+bvAai0P3Cct060m3NOej5TNpY0DsevGF5xb9U
 5t8CufYXHJRp1yrvmd/BDx8ztWhQGgwshSi7FyJq7NNg6yca+lOiy+XpzJ4U=
X-Received: by 2002:a05:6a20:12c8:b0:3b2:8685:118b with SMTP id
 adf61e73a8af0-3cc71ec2abdmr39785005637.20.1787081031367; 
 Tue, 18 Aug 2026 12:23:51 -0700 (PDT)
X-Received: by 2002:a05:6a20:12c8:b0:3b2:8685:118b with SMTP id
 adf61e73a8af0-3cc71ec2abdmr39784924637.20.1787081030971; 
 Tue, 18 Aug 2026 12:23:50 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:50 -0700 (PDT)
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
Subject: [PATCH v7 023/104] tests/tcg/meson.build: introduce gdb_feat and
 gdb_feat_version
Date: Tue, 18 Aug 2026 19:21:47 +0000
Message-ID: <20260818192309.22169-24-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXwC5zh6VqLG9A
 qzpSsYXUZFsyPtVVrdDPdr8CFU47xhCNkm0UACqrmkoIszlEuE2vB/RlkUlC1KJD1T15g4bQqDG
 XzJc15j5xHbQAleqyuOGCPbeQJu73iI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX82qaME68mJri
 HtecGwQl3/aQ7PWq6cB6FEpmUdLcg64b9/AKO7lV3xxmXHG4bE9Gm8wJETsxiJ8vuVMQjBM5nPX
 NPPW/SmIu710NbVBXIdVw5qWCTmlmf7bj5oDUgy33oqX2xZcOMNebDV7LiExCfqlID3SdT3Ij6w
 V+4l8SK6n4vBWoV0ExH0RyyqdALrm3J5+pkfTgaAVpf9Sn7FqMltSQO0MCt21Xf12URzj9Xoce/
 HgvRzSFJj6822JMHLtPqtv+/YgpUGSdk1/zyTuxfV75IjFvU4KzeOu7W+sHHVJNGTKO0ayWRFZv
 7b10VZKJaMdC3oP/ljT572PqHnLAZuwQmnanUKcR8DvnfOn03DXAl3WqFhal2UvuTo1xtwQt3GQ
 grhGbaXo9xUyMZulA4ZxvUl6E8kwsag+q/zdaoM6ObwAsDnVo9pjTHpAO6N4hYpplN2yjPefbZj
 AVGIAe8HxwIjaFl2urA==
X-Proofpoint-ORIG-GUID: bekOfIETMzjQ6jxl8-D4Qi4c_A5U9uzP
X-Proofpoint-GUID: bekOfIETMzjQ6jxl8-D4Qi4c_A5U9uzP
X-Authority-Analysis: v=2.4 cv=bvB8wkai c=1 sm=1 tr=0 ts=6a84b148 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=WryKx-XaCgVW6WutTgQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
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


