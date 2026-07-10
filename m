Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D63C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ19-0004tg-ID; Fri, 10 Jul 2026 17:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ18-0004tP-5D
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ16-0003QI-Hj
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:17 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ALCliI1931565
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i2MiWWbhqDYF6xVHO+eAm/+uFYBLvnoLDJd6DY2TCFE=; b=fTjKdkwg/LiOzoNx
 iVFQGl+IN7q5hS8qNwKQOPfNJfr7ZS/pdmGP6sVaXvwgXYoEakMSNwwpuzsMkjcX
 heTGhYnNcG9NkPg98KQ9e6CXMByGMVf+2affL5C/wyPspDSpgAQtCcANfmFnKLfh
 DtB70SkkT+GinToCfTHOPHfh9blzDxrkEv1dpUywAFKAGXMAc+0iKb5UI8roHCX4
 Snumf8yka9jZBKPPiSHwCFDIjl3xDRYqsYz8H9YGd4k5LQmNdU7+WDYIWO2wrBPT
 fqbf26uiiZ+fIO3dOBtGiKZZzPWBUL1UhN4x5564VhAjtbPowVRSqbDCIq14oxjJ
 +7dOAw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb8f2r2hy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:15 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88e0d11a3fso1276279a12.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719855; x=1784324655; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i2MiWWbhqDYF6xVHO+eAm/+uFYBLvnoLDJd6DY2TCFE=;
 b=P3Vnq9sSODU2bcHdjcogBfUQ6XjiHaLNRoZBFu4ni2Fw8O8YIeqzmPeq/cjVALomB2
 Eq6giDzdTMR0oj/31paaMZgw74/1daIco7FvT8g/WB16DBG02I+NePZs1FV+G5qXcmNX
 1vh/Ad5eiYfxSLPDh5kbvVPnq3y7mjdnpRmytTIww55gwliKTOi9w4lOUAea2YjFprxi
 ctXLlikOB/eANmQbBtPF/+mT/wZFmZMa+yW/TDyRDoefHCPXwdGrHqDyBaniBtNpbQxU
 OKZ1evVCMexuziy5qCcPhRMLNMvvN+Foa8kHz+ZBWRN4ebYVeKP+evjyx4AzVvvo/rx8
 /aBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719855; x=1784324655;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i2MiWWbhqDYF6xVHO+eAm/+uFYBLvnoLDJd6DY2TCFE=;
 b=lPtR8Qf+snmAIMfP+EcBPn0jeC801r31l0Y4xrGdfczXpy0LNsK8ysgYU4FTrTI8iF
 n6CB/YzpoRkgUYhljJVt9KfprsjfhhurK2cvNh3btCJ2VkdtVRI1i7wxpLekkYV9p4I0
 IoDNcfRiAc7kZn3KqZwTbgp57sv2eyuFLZpgKKmNMvgkLLDfawSay16vIiOb9X2hw1me
 ktQwBcTm9JXD7wxhuvYZd3tivYRW9F6r5h38JLcMveUUOH0WBAH7zFARKHFSMadxisfN
 YWhANnmg7ymJJ9J5SsvO0w2zeIE3Ed2E9C3P9pWa4Er4TSD0jVIxkJ6C3HPr10JPH/oW
 XF6A==
X-Gm-Message-State: AOJu0Yxk3ItcwoRfay4FiM4M1eAZdvCjonIX1rhNLVbW0CDm1trzRZoM
 jhVVVQ9yPZV6hjE6TYxqfbJzuQivPiE3ZOm9aNysindbvRwBv82mGDUfYunV14sUz2jlzPnAWaO
 Ni3RHS/Ihu28+8neNjIVvK/U46ZYMbfbH00+J8oJRIDtmFS5cggjDxtfqpGNCa96dng==
X-Gm-Gg: AfdE7cnYoO8EkEa95/RwH0nEUNlhC4roHhKlTQHWeY36hO8RfsnSF+I2x+/4bFe+J6u
 41YwOEanqqUgiVQIOlwEP0CB6xD1A85ZG0i4HHwg8cjmy6syr6uxo80QUQKD5CjQWPK/FDD+ht5
 v3wOOIVC9bnzzFtx/4drHqG9EQVsQr0PuS1TDS/p+pMXEgcEabllCTYQGAhoTpyl1F91UrQMAnc
 VoeX40dWSNm+iTkZQtVXHarOY+8BWZ3P/SeNC6Puyg6M3KfLOcYZXFYK6qlRtLDo9xC/FCNju7S
 bjbhFrFuAPJOT5SPDkJ7Mg46ugEgVK/2KuQ1gAAO/OuhVGJXhWqvL6xbjbMOMdrMnoHL+HwUBNJ
 Hp5oZeGuxitWrjgANPMSIgwqaQ4T5oiWGw2IpLFr//3Bl3Ksoks9aLFCoFvG3RpyIse9eAsfeMn
 yLdm18ng==
X-Received: by 2002:a05:6a20:6f03:b0:3bf:7ab7:98a4 with SMTP id
 adf61e73a8af0-3c1109d42b5mr763004637.27.1783719854531; 
 Fri, 10 Jul 2026 14:44:14 -0700 (PDT)
X-Received: by 2002:a05:6a20:6f03:b0:3bf:7ab7:98a4 with SMTP id
 adf61e73a8af0-3c1109d42b5mr762981637.27.1783719854065; 
 Fri, 10 Jul 2026 14:44:14 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:13 -0700 (PDT)
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
Subject: [PATCH v5 08/98] tests/tcg/meson.build: introduce cflags
Date: Fri, 10 Jul 2026 14:42:12 -0700
Message-ID: <20260710214343.2065491-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YLavDxGx c=1 sm=1 tr=0 ts=6a5167af cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=xYeKZKBo3MRtsS0M5EUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: EOyJ3C7yH9LEl_4F807cnAfvTAcJ7vVH
X-Proofpoint-ORIG-GUID: EOyJ3C7yH9LEl_4F807cnAfvTAcJ7vVH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfXwN65Wv6TLB2z
 n9tf8/0r8xFpZOqGTckLnDUyRbD/eU9bjPrCE4FyUYAvssYINkNPq/9ODf9fOuSF0hF74JGymkO
 4OqeaRzg0/DwOs+WjOVQLQvRFWeywIU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX+RkNZzIuCqo5
 yyOkFiD5sZ5UU54eP8WNg535LZE8UdKxkeMQUOiGKV2/MhOZ8xCLIim0RxecmSeZdcycEjKmwXx
 9w328Vz8bNTfhon3bfOtRHhwaoHxck0BlT3w2sM5k9j75BIni6ZzuMoz8/d7Fc020htgpRkmd8b
 3aYe6KQ2Dv6gpNk+X7xW8HGd9R9jytDLAUGBnBWde3hGEnvx1DRAN6BmpIAsaAToSfe+TvY2r3x
 IGdFrYCGRt2LPOJ+01PvikWVy/qFT86BFcZ4UqbWtlmIxWXY8HRvsonLp2NbnYPWRA+Y3qCk72c
 mWTiZd3mSnwPqS/vRSikc0+Dfza8t0TLSec5ZmRYuah6Z2+esDJcyOQAy7QCc31s8QZh8eW5vhS
 BCVdb7d+U3TlwI7NGkEzryN9o0UymY57w47s7wNL7kK/o1UKAoKlnFtRX8yRLC+likPNjWKmUrA
 vogoiM36r9I7edsZeag==
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

We add possibility to declare cflags for a given test. Since we want to
preserve the uniqueness of test binaries, we prevent repeating those
cflags later, for an existing binary.

This ensures one executable == one set of cflags, and if dev needs
duplication, they can use a custom 'exe_name' to override this.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index ae7ec998f63..e8d8cfbcf88 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -13,6 +13,7 @@ tcg_tests = {}
 #         'src_file': {
 #           'exe_name': ['provide an alternative binary name'],
 #           'test_name': ['provide an alternative test name'],
+#           'cflags': ['additional cflags to compile test', ...],
 #         }
 #       },
 #       ...
@@ -20,7 +21,8 @@ tcg_tests = {}
 #   }
 # }
 #
-# Every test executable, identified by 'exe_name' is built only once.
+# Every test executable, identified by 'exe_name' is built only once, and we
+# ensure cflags are specified only once, on first declaration.
 # Tests for a given src use the same executable by default, and their definition
 # is guaranteed to be unique also. Several tests for the same executable can
 # declared using 'test_name'.
@@ -54,7 +56,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'test_name']
+        allowed = ['exe_name', 'cflags', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -82,6 +84,15 @@ foreach target, plan: tcg_tests
               'specify a different \'test_name\'')
       endif
 
+      cflags = []
+      if 'cflags' in setup
+        if exe_name in built_tests
+          error('test ' + exe_name + ' was already built with cflags: ' +
+                'remove cflags or set \'exe_name\' (if cflags are different)')
+        endif
+        cflags = setup['cflags']
+      endif
+
       # build executable if needed
       if exe_name not in built_tests
         exe = custom_target(exe_name,
@@ -91,7 +102,7 @@ foreach target, plan: tcg_tests
                                       '-MMD', '-MF', '@DEPFILE@',
                                       '-Wall', '-Werror',
                                       '-O0', '-g', '-fno-strict-aliasing',
-                                      ],
+                                      cflags],
                             depfile: exe_name + '.d',
                             output: exe_name + '.test',
                             build_by_default: false)
-- 
2.47.3


