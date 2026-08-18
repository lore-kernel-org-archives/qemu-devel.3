Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B57C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:24:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPq-0007Ym-Qh; Tue, 18 Aug 2026 15:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPp-0007Ui-3E
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPn-0006hm-9m
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:04 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHIniv1971920
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VJu5JmIj1s7u4PjoUWGJXmxrTB26Fxyqfrpmk8ehL8w=; b=hf58TowEMaOatj5r
 dBFWz6lGSLJ6Y7SkbvIF57AMOeClqET4p1Q2vYkfOkEja2vd7ox/GQ7Ierg8QGT6
 a2mszgUWlh4dFY/PLIL6vCZyToMNkG9QoWQESOhI7Apz9AJzldyP+WUwXEKuGOBS
 rHrKR64UX/BfJsq4yuIfiANY/9b70gtVdR7yIV464unaGZbtKc/uZEkNIoMwI69k
 SNqA4I1nox1gPaG1UgadOjl0ZWHrSrXwX8ZqZt7oY/+ua5DF3RQ2/XnoYdw7xO8C
 uivUnASlxGjNobGeZ+9oM7dVICvYNhn3sPwp2VoZfS2rlJGJA93hVp+Us4zhcsvz
 mzWfaA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4qyx1sd0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:24:02 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e25e4b41cso342973a91.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081041; x=1787685841; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VJu5JmIj1s7u4PjoUWGJXmxrTB26Fxyqfrpmk8ehL8w=;
 b=JIXXqf5W2JcTusN5dyg2npzlFbZaAffxhQvgONkEFhFBWC7tJOod8TKLEexOSazk8G
 XHZWjSC4lcVQJQoVKaMcQjieaMt72Za3PYJTG+6qh32B9QpA/G9+MrtcKB85Mvu+nqdx
 2TGaRyiCbul7g10nrZot66Xj4uObSLZHuEZAycT7kW2e2lDTxJSRm8MPV4fvNFDvZqOI
 utEevKCS1QCIL6paJUhQ62v00EqHflTrhcOwjamwk2uQ1ZCzqSM2wLfKSr4kux5OEtv4
 jBqR/e9gvfHJqiBmIGnqtsIpnXqvSSVzl1Iie2mjUaaTKxHBjjo21bj6Y8Iol1djrHG3
 Fiaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081041; x=1787685841;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VJu5JmIj1s7u4PjoUWGJXmxrTB26Fxyqfrpmk8ehL8w=;
 b=gCRtk2ozEWjalAC35WUDROdw430Wc+KAa0mnTmvxQ5h4vGVx5GwbyVb1+69W3PcTdz
 4lE6cSyGm8y/HSVRBEP/PaUgdvEzEQHvgMAcPhjIky9fQBCT2eJvVYGld7SdSLdHfAVe
 Fu9Q5k+yKRMGsAnrEnlZc3DT4siiHPbb8r1lA/BED1XP/as2scCoDd5Rml5IxSYAEzZx
 xM4dmYWqf1OHdN1L36WBKkCud9skssnsC6C/0TzVh2ZaS0KL/f3JqG09DBxqmX0x3Aun
 VyFpYJBJIU1ei+BI2yPtvxa1BemXsEh0UuZiilo7uI++mfaC5J6vFoF+k1dPhSQt9ILj
 xFwg==
X-Gm-Message-State: AOJu0Yzt3Y4npoT1jJfAzlhYNOqbLIU85dB6AfPb/bsbdj80S2iQgiK7
 pXttTajratKUfJDyf6ySxqcNQNfKo600XR5QPsmdoBeezfz+Y0q7OtQlW2IaGsL+qEh64zh13Ah
 T5yKMG5Ce9wlkGlaj+KN7XEk3bEEgyHqN76S+eKKkMOWUo4dz0xMYvm5Q4IHmhh9mIA==
X-Gm-Gg: AR+sD13/dyy7lXw5bTp8dYmgVGWJiUVPzTKOAwsqlLN9wofobGtCeUU04ULEDaliy0K
 uAHdVaT7v9DHFJ8TE1StSqr6WupgmpdQ3tSNgyH67ZRZBEvzj1YTwdAG54TldwSNX6Wn96Lvv4l
 b/UqkjQ1XBg/enxAziJMC76yXE6WBV4ULThCSXXtoHRkoG9w2JbCThTs4rjmESGpvIAFuLCte9e
 3wnDxpj0nL0/oUQHJfmmMcqRZ8exWza9er6uqKWMPCriihWrIbVoF+feHyoGmjzELtpzm7J8/7w
 Gc/yS1sUcOj9P1ohcumQqWowOvbqfcu/G3PNslI8KqwogAsInfjjCBckLbM0PGoUvZSPq6t/+2R
 5eadx74yhFpzDwaDlMdXy7aQUVLYP0J7Ed6J+VlVb2VNPHFQLxjjytwgepTk=
X-Received: by 2002:a17:90b:3c11:b0:38c:a59b:5189 with SMTP id
 98e67ed59e1d1-3957b391616mr14782a91.15.1787081041107; 
 Tue, 18 Aug 2026 12:24:01 -0700 (PDT)
X-Received: by 2002:a17:90b:3c11:b0:38c:a59b:5189 with SMTP id
 98e67ed59e1d1-3957b391616mr14710a91.15.1787081040576; 
 Tue, 18 Aug 2026 12:24:00 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:24:00 -0700 (PDT)
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
Subject: [PATCH v7 030/104] tests/tcg/meson.build: introduce depends
Date: Tue, 18 Aug 2026 19:21:54 +0000
Message-ID: <20260818192309.22169-31-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX9YTrpinVq/P4
 keA4SMrqDcdQwQP5px069BqsAjD8q1fZuddPvY+cKE3KPqwpszhg/RntiI7eSItQC7YZiqW0cS9
 cEffzk3ZEFe3eiHLY9nZM1LsuDuRDak=
X-Proofpoint-GUID: vcFP1W7bWMRGh54HpaLlZLi6anBZO6Ms
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX1RYl5UAFja5t
 dForI6dZDrAzkLla7yFma+FmioLBjq1HHEkh0yLt4MpUs6TVqj84b7TKWT/fiLT0T1yxHbniygP
 6OuYH/YkAvtDIGR+D4y9OTyp586AcPS4fHtVeN7a7m3yTlfg28S9PSo/kc13hYLCQNvUqqa6wKh
 KsMlUaz7FZgRLg8l8AGtIex6NpI7/VOgHz1qlOUn6wpZS4aFganIFaHQ2F1Te8Z3nrkxlyGZkkX
 6zDX5Xtwkm5jLoxNzSn7F01YyIoddN8rwu85Lcr12EzRIaUQJ5ovW1fmdYpJ0KCNO4VOY0kKLJc
 /ISJ2YfHgw6SElnY+v+LDl8JA9ur4MSo05uBtmm/dEJ3DjoobEdcLzct1hzKZ4WMKvihqXz9YrC
 CkabpQEIHDet2V73xW1x6SfeI7SDbZ80uU4MSksAOvRlGRVtfRsrwNQrcD1Uf3F0os036K6sRI8
 yfbPcP+Atmun44Pf6ag==
X-Authority-Analysis: v=2.4 cv=Ad+B2XXG c=1 sm=1 tr=0 ts=6a84b152 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=aZLzzxQjhWCqgOQfChsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: vcFP1W7bWMRGh54HpaLlZLi6anBZO6Ms
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

This can be used to declare dependencies for a given test executable.
Useful when generating headers (like x86_64 does).

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 9809695f3b8..ea17a947628 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -40,6 +40,7 @@ tcg_tests = {}
 #           'exe_name': ['provide an alternative binary name'],
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
+#           'depends': [meson_dependency, ...],
 #           'cc_feat': 'feature name, must be present in cc_feat_cflags',
 #           'qemu_args': ['qemu command line flags', ...],
 #           'expected_output': 'file_to_compare_output',
@@ -178,7 +179,7 @@ foreach target, plan: tcg_tests
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
         allowed = ['exe_name', 'env_var', 'expected_output', 'cc_feat', 'cflags',
-                   'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
+                   'depends', 'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
                    'test_name', 'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
@@ -277,6 +278,11 @@ foreach target, plan: tcg_tests
         built_tests += {exe_name: exe_name}
       endif
 
+      exe_depends = build_test_depends
+      if 'depends' in setup
+        exe_depends += setup['depends']
+      endif
+
       # build executable if needed
       if exe_name not in built_tests
         exe = custom_target(exe_name,
@@ -289,13 +295,13 @@ foreach target, plan: tcg_tests
                                       cflags],
                             depfile: exe_name + '.d',
                             output: exe_name + '.test',
-                            depends: build_test_depends,
+                            depends: exe_depends,
                             depend_files: build_test_depend_files,
                             build_by_default: false)
         built_tests += {exe_name: exe}
       endif
 
-      depends = []
+      test_depends = []
       qemu_args = []
       if 'qemu_args' in setup
         qemu_args = setup['qemu_args']
@@ -312,7 +318,7 @@ foreach target, plan: tcg_tests
         plugin_args = ','.join(plugin_args)
 
         # since we turn plugin into a string, add dependency explicitly
-        depends += plugin
+        test_depends += plugin
         qemu_args = ['-plugin', plugin.full_path() + plugin_args, qemu_args]
       endif
 
@@ -367,7 +373,7 @@ foreach target, plan: tcg_tests
       endif
 
       test(test_name, env, args: cmd,
-           depends: depends,
+           depends: test_depends,
            timeout: 120,
            suite: ['tcg', 'tcg-' + target])
       added_tests += {test_name: true}
-- 
2.43.0


