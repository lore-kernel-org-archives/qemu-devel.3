Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE62C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrtI-0002ix-37; Mon, 06 Jul 2026 18:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtA-0002gk-KO
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrt8-0005MH-Cm
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:08 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEM1x1613913
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=c9W6UvVxURn
 UOoTJosEKANIEzMTsHU6RXAKrMC0gko8=; b=etTc9jf8WXA+Fby68/wspC62N6N
 vfyfy6hSgAP067b3G6yrP4YlW7MCc8lLXTyEdymuYUK2QpCQmIeV5KLlriT7tKzv
 fvWMHr9wShyhIQH00+IcGSizDNxfMgM3hle5c5ayJKO1Ow6BtyR+zaMV/gbWh6dq
 Ia76vE7odFSoRvgnIwGkd0Ii3Og0WCf10VbIa1eJNHwLSh+kZa9T8rnfzPQDQ/H5
 4ATTWcDIZgJYBiW4VMs7sL8AJpY8nWFfy50YaON6e5pfAUm8RTW6AItkNvyDV6mC
 YNNtjaRDan8yvk6Z58es9mrrirR4LqNvrZRUgP6QALSDUhzB/E+czVfaFsg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h53jr4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:04 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38101e6fc6cso6649855a91.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377244; x=1783982044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c9W6UvVxURnUOoTJosEKANIEzMTsHU6RXAKrMC0gko8=;
 b=X+6eB90sELBOtZWAFgziulQ+3vlyUB/Kmq/RlWpmIozaJ3e+MJgvpnOvbNHOpwrokx
 yxU9hbj42LEuJ4dz4yGx/5r0/qu6jx5EG+3CiaPOybdlRo8t4l0kbCMzs05u+Z64eCkq
 DNhMZRXcUCrchT9l10qdl5vwdIf10R3sZNncFu2y6F0cxHG0QPrk5gNzc4kQqQ4FqeiW
 HihTjTJDDMzAzYCFHuVOqiNzWbbyBh2YR6eD0yGL7bdXPF3Ks0PAqLWLnK8hgvNlkLkb
 rrnlctUYIih6mJm7fliGrNFwWWXujJ1/bApHkke/IO6wmaUClX0QYCm5GlkLsxYeXu48
 7GAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377244; x=1783982044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c9W6UvVxURnUOoTJosEKANIEzMTsHU6RXAKrMC0gko8=;
 b=rwzjEctVvRYmzvSCz4KYNus0E0rEqP+50SRL487EQR/7IxDfkYAVZeR7nDQHw5WdEz
 Cyml4xExbvD309NC5O/nrNqe+D83kjqobVzuiWKmsxs7V4gVT1qg81bfNpb+X/5CKRsH
 Pmu9G2j1NBTE3YC/IQDlPoiE3gxE0w5YdzpTSRCHn8TqsBE4eOZNpEKQisDKVfGMxCNz
 RVnk2nctbOA81EZg5qA6kTEx9hzFlxzwi8BX3KIJjtVF+y7y2EEjAOQ7/EiR1e+6ahS9
 C3VXS5/RCAOdHuwJ+Tn1QghzxWrBFhALBqbIaHaXpvBORfdKF7pC1JUi5t8toOw2oxSl
 stFA==
X-Gm-Message-State: AOJu0YwtJ+ThQMuigi1lk9PJN6+eee5bpQMK24aHNA8O+zRQ5jzOiHk8
 w7cPDds2AYNZjNGb6G98PMWbkXBCGVl2dL+zKj0FAjIjzWAo4HuCpr4mo4HMxGIRS4MfIUxFmtR
 frgmS8J/OguJwh4IYKFXqnjKTMXBbwIX139SyeM7apLCQxnYn0KQlpajl9k3HHWJbmQ==
X-Gm-Gg: AfdE7clArG2gnnIbyc8Se13wtXpfyq8TUqwOyS2MAlyzUZsm+rk0E7S6xMFMHdxB0xq
 87YsQ5TAsZSyZ3Gl4eAHYV0YjxgqDX5FrRcw9T/0AiUoug+0i/u3SZSAdGi/JmVBiZcvS9Rd5t2
 w+16JDS6OFDS/Z1ktCPAw/bqipf7teZny5J8xE+iyTmDlB4KAulB/8jTmLk2L/yYlDJJ6kIvoxb
 RuxRfqWyGKcOMJQ+smvnaHhOfzkQwTxEvgVAKLK+aBac4yVtusbev/3aI3FVz1U8FoM31DazA9q
 4r6vp0a0AITtI9BU6WGjchv7g1KKhi0EYwu9JdXz70lB48zguUCyDcw/sc+s851mtqPhL44YqX+
 19jukMYW9kOeCRPstJlUUXhb/HDiYs35fk0y1ufFIlE6v0rjUXEjYCMsqahwqh75565y6mpc0WN
 tD0KYNRg==
X-Received: by 2002:a17:90b:1cc8:b0:387:e0db:3fb1 with SMTP id
 98e67ed59e1d1-387e0db45bfmr109321a91.42.1783377243847; 
 Mon, 06 Jul 2026 15:34:03 -0700 (PDT)
X-Received: by 2002:a17:90b:1cc8:b0:387:e0db:3fb1 with SMTP id
 98e67ed59e1d1-387e0db45bfmr109277a91.42.1783377243395; 
 Mon, 06 Jul 2026 15:34:03 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:02 -0700 (PDT)
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
Subject: [PATCH v3 07/91] tests/tcg/meson.build: introduce cflags
Date: Mon,  6 Jul 2026 15:32:19 -0700
Message-ID: <20260706223343.988769-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WkWzceHwKjaiD5cq_9Bon4jPcEx5ktvI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX9HjyjNdAdi97
 ciUSlNDvQCnX029FSVZLWzu5aA4TCge5Oqw7qRRZ1SeO03/v0PiLt3d6ngJ6OPept/VFVZ/tJYy
 bHoUxTQf9nKzOPFm8zv5pYJH89qK5mk=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4c2d5c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=xYeKZKBo3MRtsS0M5EUA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX59M48AR0WgN8
 Shw4Ly6YAXqcDuaNU2glwvZ7dG5p0ykMBL2Te+EpqCuHbAaro/M44o29fAv1FiVccEvqgix4jtx
 n9efOBBLa8x2S27iMvTV5rHANkY47gtBrOqcpjZKpZntrw+TNM+drBgXmPaC1UjPRaWahO3jCki
 q2LXFf5UCbG4cXiaIKBPXDoJdoxY7PnELA2U0OhDagsBSrYkVVzBhwv3elWK6BD7x6NDEHy0GBt
 VuMEYOJMn8IclngQRyZyTKRFAnKT2/JDWkt3fvWwEZnB66K6GTjFPi0d4cr70hIv61WfUdr1JjK
 /FDqewBpIB53BjjWke/bFydV0i5aIRKbT/IqgAqpOpBKrKDsJypyYLflshn8TWxkMqakiTaxaiM
 6crcvsoq5rQ5JfV3gOIYxkHRfUEem6VjN1HlJ9kHnArZ6TYNMqE0H5vEXuU9ER5ohOFKwdEaGjP
 LXsTxkZi/HZKlaVBoPw==
X-Proofpoint-ORIG-GUID: WkWzceHwKjaiD5cq_9Bon4jPcEx5ktvI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060227
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 3eee3847b58..495c1d672f0 100644
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


