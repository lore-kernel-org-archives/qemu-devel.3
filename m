Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B394C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFz-0007Oc-EP; Thu, 27 Aug 2026 18:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFx-0007Nk-Dn
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFv-0003NI-Lt
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:33 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJMcA4850290
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /s+Mk8furL015lvLqj+bOHWeZcHgkClslOb/k2zsi+k=; b=EiT5GHWSWj7Cgq9g
 hwF9Vd92OXKC83rQZEAnQHBSBC5PzHkGMaYxRvjPATnFnFHr5qyqyCPsRWl5iw5l
 1v+avWmKuU3LaKOOfh/XdxN6/XsBPvFTSYz3Ix4TO6o6gbHgqj/2D0Pf0RQBQcYm
 sDSupOzdVZSS8uPSoUtPhzwzxC0ZohMRwoo9HWqkgG9nEL2TbzKHTQo1b0y+LGf9
 HZJC7+ys4N7TBs2ND6PhSQuftFJ6DbB1iQSAfbQfuAb6TrR245kZwuxS6hDqiHi9
 iw64MocSP7dkSUfXQCHmZkRtRucuIDpAZKByyEKHfH0K8944Rd7K6jQAHkjx4gVR
 LzeZHg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ganr6a644-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:20 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84859a64079so604455b3a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868440; x=1788473240; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/s+Mk8furL015lvLqj+bOHWeZcHgkClslOb/k2zsi+k=;
 b=JPsDnK8JridY6r7/Wo4wMLfno3JwZBzKN2SQNe/moPyABosc5Uc3P+S6CNp9DBJTXP
 FQ8HQo/mgM6CzfKoKXBJ/N3AODafHoEtsPW5O08lqEzBLCg2+c6USQWF8fuwOFTgikJM
 /ihCgBEiL3DiBF7awk3gwP+lXeo0aw9BilNyRTLMP76mNFziknAYd0OXjObLgwKIVikd
 mO5rZUdG7ib1jJj4CaycRkLxA3tU6TVaG09VU7PA1itaKj4cXSOh2Lo/awgYAXIDs/z/
 xr9zr4pBq0B4qEmOSUxpUK1JRI1LpUnECv4FI1udm1CEzX+tTIthdSbwyAww7S7bq1E2
 fnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868440; x=1788473240;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/s+Mk8furL015lvLqj+bOHWeZcHgkClslOb/k2zsi+k=;
 b=MGk9uQkhFu+vvk4EY+toBsVzxHXPdceF7dVDceQAErkrHpobkka7RcEu0t2IQArSqX
 C3QdfK7j38adkxECWQJwwI07rb2HVJz4OWehTfSXGyHCOFWNIM1EIt4jWjPT3LIHLa65
 kjU8hdMLaWyUFJSaf/b3WmpazHZOB+WxEGSGS/w/yJirs26amY1k8EDmim6fTQk2uHFw
 2bBHx6FFoSNCHe5nIPWfuS/+JNGXllRFfCqam7ReW1YTgCiK4NygfxskbQRXdbbAO8aU
 Zkw+f3Sw05F0xYFiBcQbTFxNcgooUTsku0tk2czp/iGU7YfL0M8NjkDj3mZsVvitgE/4
 zf3w==
X-Gm-Message-State: AFuF++llpOVp+DBwjIyy8xeDwccO9cUsGkS+wVX1kR3mXXYabXJlCbae
 z4d6HFiE/mn0f9CeGeMWMtrDD91VeGjEctYvoAdrRiPaYb97Mwbl5tVAblxGSbfki/wY0DQ5faz
 gVMWscVbOtsliH2usCw8gVT1ULNyhOE0MkNlFLFEc52xWV9wQ3zMCFFEKaKGU5B+4sA==
X-Gm-Gg: AR+sD11xngVCWM1Ngtvj9eLokjaxT2iaSDWuh9m3+MD/A39g+mPv3QddiGNAe+udhVJ
 ZGqvULf88c+F27Sj3cWL5zREP+tenCCqxl6G3nwCSH5f0A3PhiC3YA3jzFFp69LmPYZsjNO0T+3
 vtvfK3EzWmEGc66ZgPhqyOgbjzYKox6jMx+k7/OICDsvK84cvD8nHjvNfNOzP19BWWw6xpVpIIT
 VuMvqX0+8jC2GWhTHZ1N5+9U3NQ+9AmpF/c80fm/pQO96PkYIZ2k+LJym+imrZ18uw7f4iAN7O/
 B17CZeHc//vdGRQrclWSoGY/lFE26GEVIJOx8ceRR5zVUUI+rRN9fDNRg45wiHiU8V/558f8TRD
 6Wg1D4AQhfIk8diUq06CWNSqcV+gU+xtJfH72H80gkmnReiRIUYRstho16r4=
X-Received: by 2002:a05:6a00:414c:b0:848:4754:28e4 with SMTP id
 d2e1a72fcca58-8562abbefa2mr4530755b3a.15.1787868439725; 
 Thu, 27 Aug 2026 15:07:19 -0700 (PDT)
X-Received: by 2002:a05:6a00:414c:b0:848:4754:28e4 with SMTP id
 d2e1a72fcca58-8562abbefa2mr4530654b3a.15.1787868439254; 
 Thu, 27 Aug 2026 15:07:19 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Song Gao <17746591750@163.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 022/105] tests/tcg/meson.build: introduce cc_feat and
 cc_feat_cflags
Date: Thu, 27 Aug 2026 22:05:16 +0000
Message-ID: <20260827220641.84885-23-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX4GnQ4OV+C2D8
 Hf9g2NT6GAItDnY4IVshvmCpokjV5NHYbXbub9Yj52+XNKeST1WYxUPl0pCojHWb21ahpQJr9d4
 Q5MMZgfCFxc85GMokaah0cHwZlnNblVFK+Xe11+gt+3aq4sQ6S14eiEBqY9MyQoLhRbg04ICGBP
 nj+sSTNqgR9yJWbfs7mCXzrrzNbYm7l5j07rqC5umrf0U/HPD2c3vQFRAjsMJIMQ3KZkYkau6YJ
 +0IyIjb+KD0/A9KOH6zUE0GplkExi0+TI6KNajTxL5cnpNjFIylvDhIh6/I9IvSQyvnPaIGvF5l
 qRoWOWywD2kJnctALUV6OEacxzrov2QLVDrBMajZsmNfDeUUdqC6jlMrbXQjfU7Kz0AKbfSbdBz
 DyxUL7RhzywDnRQEtlW+aCmhWyx6gKAId6ovLkrmwIOVVMmryJgmk16JmtaJMhJOOQ5iCk8c8Sd
 bYlgNK1MZJxukqsK/mA==
X-Authority-Analysis: v=2.4 cv=d5DFDxjE c=1 sm=1 tr=0 ts=6a90b518 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=FBTJAdTUffG4L5poSMoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: nKs0vJRn0iR6TVOdwOSEz4QC_i830QLs
X-Proofpoint-ORIG-GUID: nKs0vJRn0iR6TVOdwOSEz4QC_i830QLs
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX/Hd9MYsMW5nu
 X5oRQIH8LBIp4ZA0wMl/rPWXf2RhRAZS9xVqemTqJ5IU0JIwEcwDX8/muBgr7yV8M9dQFSK1PWz
 QgMfz4Z8u5pEtfpJZvAz8HlwBjXblcg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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


