Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD07C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ1P-0004vy-E0; Fri, 10 Jul 2026 17:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1O-0004vq-23
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1M-0003Rp-FX
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:33 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3w7O1753816
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SJvp+gWG0lccHw0Gtl9HYeD8Iut779BkJs4LnH7izrw=; b=HLytCYJcREDjzV37
 rPDhV4cL1O1B1WtkLltm/Ja75hUdS85rb6FX4VTrdYLSXYoLrLAZZE2A/FqIPQnH
 hF73+cUOv1yq9qJ6pLW0gH+V52uW4MZU5Y8gyrNtB27bLXRAwDPQpV2CdI82vaJ1
 kBWcrCXlxVpQUGyPY5K+YpHQ7WCkEO9ILYIz+wz/Dnx/ZxMcB8rDKjmUPaJacpCl
 i11uGj76VjZ5nJb2mL2qC1ftzpJVV3k+di9C75BHAqgNr507rkaZSMWuq5xH5RbN
 gyDyCZBfBQvYboAuRSEe82UXyAcuXUDS1WvfadK8FIfDy9Gr4IB2EndVJKaTzmET
 F+EOLw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2pc9ghw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc640dfde3so18277285ad.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719860; x=1784324660; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SJvp+gWG0lccHw0Gtl9HYeD8Iut779BkJs4LnH7izrw=;
 b=WthlwGq1fnhD0m00OJaLMmPhBakSDko8GUCrEyUBir9zEr3TRQJ4eGf+nG2rlyxXyn
 j0Rj+w9o3+CHycdO50hW2ma8YcPuSCrTZN+hMzGLvP4d3ovQgseT7KzqWp0iF1LAElYS
 dTEstmHa1bneCpjjwBI+/8Xd08AKXNrPGknjiNnk9e+/IpUmT+TFFRYLSZZ09wkat76W
 RM5MKk8s/oYb18uI8ZfKLWErfW9l6UoFqPijnbQy+uu8lD9O4jaIuWorcPOC/QfQyBfj
 ZMrBkJNa8S57T4nOISWR5pZKraPyM/q4w+M6s2XbGZnYlRpXQPwpQX2qEKxRIRyHQPCP
 A/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719860; x=1784324660;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SJvp+gWG0lccHw0Gtl9HYeD8Iut779BkJs4LnH7izrw=;
 b=EGOq985a3lY8kErBO/Ar7a3x+ziKWhddTdw1/ukH7cKDUh5gp/yRrg6DocE8A+XukR
 tVkNVEIE9DZV7c6eFag1YPpj0mJa9EnOI/4fuBappdVrhKJc+8krSUz93H7OWY4PPnPo
 kHxQDniQ4YKoCFCe4DH3iIq4spjgR6Y/VZPDFAAZq3FW2gT4GvEUATPsi8s6ZbUEt6YD
 LFC1+rhy7GpR5d8ZSqWyb0Qrqw9eJGBOw60TyI+I3SCt3VE9U1XaGsCWM0M5hC+hgTEW
 hlrujF0HbvQAyaW1/jgGWbjcz4UZQ55AzBVHmxDxuI/Pz/IQ00VmNrvW+JUDrdMERyfD
 URfQ==
X-Gm-Message-State: AOJu0YySaHZoj43C7YCXSV28e29RkiZ8HetY1zfn+eu5ClpBX6NOiRBl
 NpMjSnvn5t1UWZ4TX5ll2DzMZS7VV8Wuz/91T+y0FyO31b2b/X6c4HlyHv1a5yrLtRfGThweewp
 1Tq1DFH7OIvi4nK2Xkwe59hvR+ul4o1KfROuNebsi4HKwkZWpG+2cpImfYyJ2jbFHOw==
X-Gm-Gg: AfdE7cnoZ3v2Ak9XbCVGVjJAXsf45U8QbtGF/du1yjxPWOhgigFr08OA+alFKYhz2HV
 EXxiR0MEpUi29g1jqUpiUZXnUbwfl5UtsmfEm/jrMvBMLCGaLFnkf6J3MthF1zAeHINwMP64UKP
 oxXRpy0wvTppqeb1HlUo5ubRWod4sfZcJ5XLXEoSahT+HPHRseIShgfmJ9v886Ad8uq4KKCh/HD
 +fZTRkyCcGvAaRdo8QiVe8o8cqpLBei3reJzG+Ums5xyJznkvp12GFQitQu0DQVjmITcnjosCQZ
 KQ3qY7VyHecZvwYltTiPvSdPJwtoHy/wNbFlVEC00CEWd1aeIfR59pYQIzqj46JgMU7IEabi3vO
 k9cxAU5EZoyPNWluEgrf9Mm6kkNaLaNM5vo8z2u8NZWc0435j17bvpXw0JljtSyMrS13Mm+6KXw
 0Jj4Di9A==
X-Received: by 2002:a05:6a20:2450:b0:3bf:bd62:75bd with SMTP id
 adf61e73a8af0-3c1102d7c3cmr744625637.4.1783719860475; 
 Fri, 10 Jul 2026 14:44:20 -0700 (PDT)
X-Received: by 2002:a05:6a20:2450:b0:3bf:bd62:75bd with SMTP id
 adf61e73a8af0-3c1102d7c3cmr744604637.4.1783719860031; 
 Fri, 10 Jul 2026 14:44:20 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:19 -0700 (PDT)
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
Subject: [PATCH v5 12/98] tests/tcg/meson.build: introduce plugin_test
Date: Fri, 10 Jul 2026 14:42:16 -0700
Message-ID: <20260710214343.2065491-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX0iQ1iLrGDqdu
 p9wNZG42LLL73Yp7u21rQRpbsX8OSQoMIOxrcXKcc9qJsRjhE4MYoiYKFOuoPNHpPO5BlT+U1cG
 EBa0AF1Qj2RNnI4GnZeXF3tizJzkoUPqTla7hnrSW+Z2X4tu+16JnItggXugZrx9gyeCPq2Nuw8
 XY7ZQztHjATAKyMzmrCcyl/SMgtpinIoriZIBfVAZtbS7o31z/2//I6GxxMnT/UaYBP1DS0Aszo
 WHp9mwEMswB1xMjRVapIt190SMWoUaEtK9mAFSNzkn8Y21rY6qZtqJvDh2cpWPaVaj6K/63UVZv
 eHna2HaQJpNzzAFOmjarc6XZ5EPMncmGYkIpOLtxTM0vyl1xpdIoENpsAFCFrhT3JcYNyFJImUP
 e1IGfwCNfivwLYcTMviPCF9K/0pkkYBUGQSLvjssK+EK2jeBeRp2jMHSXcx0tc3mt5F2WPsMyr8
 uMiOba7KzL4G+X8/juQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX0oXfOtl6uNLc
 WxAnmjAeRGq/Im0nQSNzdWKnRQayJ9WKhbbf2dOUo5h93WzdEw7wbmACCAO8CjZ4ugB8uLtBlgA
 NUSomKVyS9XIovC9BG+B24V3a6rIgB0=
X-Proofpoint-ORIG-GUID: ibJ0SuHSEpgSBuzZH-q5ba0BL9EOl7I1
X-Authority-Analysis: v=2.4 cv=J9SaKgnS c=1 sm=1 tr=0 ts=6a5167b5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=f31TsGN4npWs9EMxSNoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ibJ0SuHSEpgSBuzZH-q5ba0BL9EOl7I1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
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

We add possibility to declare a test that is based on a plugin.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 9940bae80a4..7b51750b016 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -16,6 +16,10 @@ tcg_tests = {}
 #           'cflags': ['additional cflags to compile test', ...],
 #           'qemu_args': ['qemu command line flags', ...],
 #           'env_var': ['VAR=value', ...],
+#           'plugin_test': {
+#             'plugin': 'plugin_name',
+#             'args': ['plugin_args', ...],
+#           },
 #         }
 #       },
 #       ...
@@ -59,13 +63,29 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'env_var', 'cflags', 'qemu_args', 'test_name']
+        allowed = ['exe_name', 'env_var', 'cflags', 'plugin_test',
+                   'qemu_args', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
         endif
       endforeach
 
+      # return a clear error if user misspell a plugin entry
+      if 'plugin_test' in setup
+        foreach key, _ : setup['plugin_test']
+          allowed = ['args', 'plugin']
+          if key not in allowed
+            error('unknown tcg plugin entry \'' + key + '\' for test ' + src +
+                  ' (possible: [' + ', '.join(allowed) + '])')
+          endif
+        endforeach
+      endif
+
+      if 'plugin_test' in setup and not get_option('plugins')
+        continue
+      endif
+
       # meson '/' operator drops left operand if right is an absolute path
       src = folder / src
       file = files(src)
@@ -78,6 +98,12 @@ foreach target, plan: tcg_tests
       if 'test_name' in setup
         test_name = setup['test_name']
       endif
+      if 'plugin_test' in setup
+        plugin = test_plugins[setup['plugin_test']['plugin']]
+        # remove 'lib' prefix
+        plugin_name = fs.stem(plugin).substring(3)
+        test_name = 'plugin-' + plugin_name + '-with-' + test_name
+      endif
 
       exe_name = target + '-' + exe_name
       test_name = target + '-' + test_name
@@ -118,6 +144,21 @@ foreach target, plan: tcg_tests
         qemu_args = setup['qemu_args']
       endif
 
+      if 'plugin_test' in setup
+        plugin_setup = setup['plugin_test']
+        plugin = test_plugins[plugin_setup['plugin']]
+        plugin_args = []
+        if 'args' in plugin_setup
+          # add empty arg to generate an additional comma
+          plugin_args = ['', plugin_setup['args']]
+        endif
+        plugin_args = ','.join(plugin_args)
+
+        # since we turn plugin into a string, add dependency explicitly
+        depends += plugin
+        qemu_args = ['-plugin', plugin.full_path() + plugin_args, qemu_args]
+      endif
+
       exe = built_tests[exe_name]
       cmd = [qemu, qemu_args, exe]
 
-- 
2.47.3


