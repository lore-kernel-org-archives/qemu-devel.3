Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CF5C54F53
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZfA-0004W7-Oj; Tue, 28 Jul 2026 00:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZew-0004LW-Lo
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZev-0001TA-0z
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:18 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3ak991673395
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i2MiWWbhqDYF6xVHO+eAm/+uFYBLvnoLDJd6DY2TCFE=; b=ifxcmOElZTLeUScJ
 K/Ve7GKKaER1kwvo1KH+svtawA+WlFj1gzAjPiP5VlBl3VY/zutW6mLcL6O3GODo
 QE4X2TAlak+dCbhGIg5SLuCZ6oHaHxZYcrQCaN29DbKYr/9HySKb8FMhFdGSbEyN
 qDYVMuNiIA5HbvgET4c3iF5c+bNhQU2n5OC7fFoN1TpMWn/R8Ohj9RGkS4ZcEFKy
 KjmsX22OBkaY0Cw2Yc1WQ7eTiOLLroUlU1w9NUSeXotpOYcz1X96Rgl1D98fadlY
 5w6BH73diE/Qw0nMNj4iFfdYBd0BAR5VcM1hZPYUbDpykf1cgGxChT7pGxzBfgKk
 vQVsQQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbrstbuu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cfe48ca1efso34086115ad.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213795; x=1785818595; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i2MiWWbhqDYF6xVHO+eAm/+uFYBLvnoLDJd6DY2TCFE=;
 b=Ia0pC7Kgh9BroLrdz40PW8VYcTPSO97NXoIROq7kTzu8ZIG578058kGDWyBZT+Iedi
 MY/AJXNO2+RKKa1n/w9pUZkmkFUPOOOdm+JADPcASnr96Rq222lIuIxiMAU2ovY+Y/D6
 ekb+MIDrCSBWSIHCDcaFwHQpBAr6LHqLiwbW0ij8v2vsK5JlptuX2NUaCQcLOiQmAffW
 4cWscINNZXFfR5dn7So8F7tpv3CiQBeFE4CM1M9xkmMiFX1nTFBR0e+90/xpjzfVAtgr
 sxLlnuQAAGI71hwmz23JBCXvey4luive2tPat/Vx/Td/7Q1TNw+Kh2nqk3MgitcE3Rrz
 J/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213795; x=1785818595;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i2MiWWbhqDYF6xVHO+eAm/+uFYBLvnoLDJd6DY2TCFE=;
 b=BJVtX+MbNjof1zZv+NgTqq3vdpGORfvJXtz10y1UnhZjBDUuvDu7TlZKswCU5oEWu7
 wSm7e1GLyxoc7Zvot48/56wrxpmFJJF47pS/bC6MBCMM7UwMy8oqNtsTgB0+ncnP23b7
 8/sRa/PKmO582slgJZOiAx1Hf4ozg3rcgE4lADSm/cSD2WD3MQ8WjgWzFowuXfWIMG/z
 amyPlI0WOWQ25SQg7DjYfWILopzc4rnyFMppkaHQ8i0STgTgRhzpPsnCU1m3MzhVJGBz
 GJlFtL6d7lhkDyxAxOHW/73ypaCzd5zeIrz0DbLd9cu1vX3oWYmDpiIKFZJH02l5zCt9
 imIg==
X-Gm-Message-State: AOJu0YzCRJqKqeTjXBTjGpv1o0Q6aSl1GBx3U9f76edb95yBW4CjSRlj
 dbnZz6RlVk7/bMsoNqVrmYImnFNC+oMztQiO5yqprDSfdi/kq86s2wm2/EqiPI7MU3fDRFYuo68
 noVG2ZaM77tkp3UeqHOmJO8a2fRRJnJ709so8HWggTu+JlRZ6OM4jgYB2tFwOheSoCg==
X-Gm-Gg: AR+sD10u8YlCIZzQ4tZ9w1cyw5QinJtCAKdpo/tbqT15nreNxWvMwQfMS998tyk+Rko
 3poLgP+rWc5y/gYhaJ77XBCi6zC8v3P8M8rJVBk7hmtc4m70gxoadvDhIu1TkwwftI/cYlEKtZa
 3FqeV/Q1WIhNDZ14Gf6+5MSzMolr/fFFkgmz0IMLgHrZF6OZKcCyPFzrlK/kA7ivvBTbvFt6Q5/
 Z+A6vU1adH5JJEXHmgS7I0nKtM38Ew31lIiHnSuVi0naeDu+jDhdhTPhCo1O7M/ZxlDQyYaLgB0
 7o68Bvb8Uaq6X0wYLzSz8xD0KK043CHIKEMIJy9azPXz4tjdfr5vpKu8S6s7Kui3yr9ay1n3IMz
 XitKMFSqDv/b43p1h+zAfCE4fnY1uyLFWp0706at3diqXCpYBlgyJrtbRCRorfCDdLhowrlg=
X-Received: by 2002:a05:6a20:d529:b0:3c3:856e:dccd with SMTP id
 adf61e73a8af0-3c8ab0e59b0mr1169754637.23.1785213795191; 
 Mon, 27 Jul 2026 21:43:15 -0700 (PDT)
X-Received: by 2002:a05:6a20:d529:b0:3c3:856e:dccd with SMTP id
 adf61e73a8af0-3c8ab0e59b0mr1169720637.23.1785213794771; 
 Mon, 27 Jul 2026 21:43:14 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 008/103] tests/tcg/meson.build: introduce cflags
Date: Mon, 27 Jul 2026 21:41:12 -0700
Message-ID: <20260728044248.137626-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX4cW53WIp8rog
 c6nW/e4o5KUBB9sC1Q4gnCzL5XDZA3mqUyunbjJaYeMYYSMw1ubVlUzvPyBAI+K0iKJ50smZ4Ea
 lo+OfwfJIHsz9l9iI2PQXtL118oKpwWezxqocezB4nQGvkw1WiTqTymlg3AxoHYcAcisj2zADnP
 l6tLo1JIIWxcLg9NG9y1ixo9JmqDViacbbtt5wmGG/REODYBuP++vBuYvlsL6TZQRn9raHXhWYZ
 dXQHTomFNzW/G5cDNyOWDzdq65OHgHJHdZCAF8omD1CDBKcMmtwgkILtxQNwAg1faA0jR9dgSNs
 TfqOrOrfn7yHz/4MdVMijXzdgTBuLA4wIVbAQtKdOkkr6I1OptHcm4FKQcFcFEXFrXfutPbrT2L
 EBFBbwKyB+4TD6pl2UV1h3weTEErMIndPxUBG4JkSU+PJ2FlpwShrVCwdFccPXgW9+jTRI7Qd9B
 WKL31Hqux1iYNYeVV7Q==
X-Proofpoint-ORIG-GUID: SjsotUfthF31hKg3y_dDaCVXOnIWkrB5
X-Proofpoint-GUID: SjsotUfthF31hKg3y_dDaCVXOnIWkrB5
X-Authority-Analysis: v=2.4 cv=ALkdLnG8 c=1 sm=1 tr=0 ts=6a683364 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=xYeKZKBo3MRtsS0M5EUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX9WsbrDM1WN+/
 99jrWQ4vWucJTn69tDd1hsyZVwgtwLewcpR7IsxeTthL+ZcR3vH3AKp2O+XCheyTxkgeAq6O7ZX
 5QvyQhOQP4zXrLB/h51FNhCgk7W6Zwk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280040
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


