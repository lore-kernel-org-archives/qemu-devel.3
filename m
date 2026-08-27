Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBD6C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFX-00079e-Gg; Thu, 27 Aug 2026 18:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFU-00078h-M5
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFS-0003CJ-Ro
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:04 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM2DC795306
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7AMl0GUi9+fOtvTKd5eaYWLQivSCE64ZfxEcdg32zeo=; b=dh7oiH5b6VZtyQ5L
 Ne5ACtWkHQlzgyPedqpcPdoWErkNg+J3PO/8xoRtvokTrKUj+mW05EVTs0im23iT
 auX7hEMk9zCNMZ2tKxE+zbkccBwLnju2dfWiRmBHhg4iru0L3H9SROynG/nunwKm
 Ak7gOHNr4uBK6Yg676QWCK84T9GSdkhuBSHSi2Cjw3vnLfvHrZT+LsxdeBLcgr1g
 1V0wrHE5ME39rWM6UlPUA3YTasNW+JbVXfaWmRQjtr/YN4+8oDMAC613X/xazG+U
 8nMIS+LTM79+rLdIQX6fHrCvTziSZAPKr3Zfeg+yiSuS1uS7gUdm1WqRcWBB1Ri5
 EUkH1g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gam6fjm55-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:01 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84e1da97175so269272b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868421; x=1788473221; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7AMl0GUi9+fOtvTKd5eaYWLQivSCE64ZfxEcdg32zeo=;
 b=Se77ywKES6qL5jfaAwzx+8dLSRoNR8pnu7I88rpYvkUnCDTTpE6cI8MYsCMvp0DwyX
 c07N0HR28i7I1dOsgbVBNZO4IwxigXIX9gFZ+h1q0JG7cSc2/+JkTDjNFi099Szh84t1
 MZ4rRfNTOs5Vg0ZB6F3qqGj1OsnCKDBrgH44Ur9bH9cKqyrj9azkfQjUKu2IWkp4k+PO
 nygbStYys1P9BJrEDoREFljkzw1vNlTI3UYYbLuKog8FyclQcGjoITdIfsZ5t4NoS2Md
 qR1LVqHbdvjzY4BFCkVbko/KEqOBBY5crS67TavS8jTHZigYkOrfosDIlfQg2gAPn2a+
 3JoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868421; x=1788473221;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7AMl0GUi9+fOtvTKd5eaYWLQivSCE64ZfxEcdg32zeo=;
 b=RveaJWs04AGeACmcvlc9czO5bKcfcx1M0NLKoFabBdFN+IAPJQcUY3oVgsvurqPRtT
 jAYAn1phzgjQ9pyM7nIqyUhpEFmgUJeT5YcQd6zhKmJcc6flQNBa/iaMC8zwzuGXL4qY
 j88xm+r51Pyp35+q/fH5jtfcYXKbn/MHDUWDSx16rSRo6mpYacnpkwlfxL5DcbZFalhc
 KyoXpqklvyq8p0IlMUR+ErsGIXLFdMHlDMF4tqi5QU1nIUCf3WgZMqAPcaoBNqBmAGH1
 53QoRVVzUGwZwre7Y2EjaC4UNpXLi0C8inQz5/keN+FxsPM429aJ0g9Ng2TwvqXGN4HL
 8pjw==
X-Gm-Message-State: AFuF++miwHsK4koa1rfvjIeQKlq586G5K8ypOQ9G3BaqeTOlpiaAzsGF
 1nCi/TFkRAb9PM9yxi+SvjKZ4vJZUMZB0aRb/vjGLLYWz+YsBB42MrrUFSQAiGBnxM4tCcrg9I3
 COAXEIzHDat2png6nF1rEDSuhXEHukiOTHBJoL+onmS4nukXcvZ6PHyK8HjBCtDy87Q==
X-Gm-Gg: AR+sD13rhjK7KvJjTL2zRf5SWKaWFQy2yXK0B64SAJ3LWc0q0T2eLY8xCQgcWMnQ8NU
 as20Y7+hv6VXqDNNzIpjsCAwoEZfs7v+40IpYQY2945qmoPEmJ/sAU7ory9A0L9iS99CcWuayEz
 R64wuUH7USAtfcLW+uMCeyhMT4TdbyFX5SqAjcVAQwkfwm6Gak5XDPcENePlAzVeEalGDlVV9lC
 jGVlJ3dyiw6Vvx4Y/dOj9peWC+9B98I/DrgoSUlQrzy60WbTic5jtZ+gZPUJu0NEq+Kf5WKVYhF
 iMG6/uTPuBxY6LWCLG0xtWtguoAoCeXWlZWZeYLD88u6hCkk0XBGmDPV4mWGPorQcn5Qdw+kdhv
 VL5y8GzYsjzEXBYh4E3bsOMgdevrOls4O1fzFKKFDnM0k7TbL2OnDLJP9J/k=
X-Received: by 2002:a05:6a00:3398:b0:845:e8b9:347 with SMTP id
 d2e1a72fcca58-8562aeaafd9mr4861221b3a.13.1787868420987; 
 Thu, 27 Aug 2026 15:07:00 -0700 (PDT)
X-Received: by 2002:a05:6a00:3398:b0:845:e8b9:347 with SMTP id
 d2e1a72fcca58-8562aeaafd9mr4861121b3a.13.1787868420535; 
 Thu, 27 Aug 2026 15:07:00 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:06:59 -0700 (PDT)
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
Subject: [PATCH v8 008/105] tests/tcg/meson.build: introduce cflags
Date: Thu, 27 Aug 2026 22:05:02 +0000
Message-ID: <20260827220641.84885-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX2EJpmuM4PilW
 e80jFquBZxfPR2vTjiLaE51Kkk/qoiHpYed8NfqusHio/XRg6Muo1XWlr1JbZgIOgxfb88loJQl
 yt3qY/kgqskA5qC+RY+BUAsG0Q3L7as=
X-Proofpoint-GUID: vt50j-bNFILwpijVmkUO7Z-ch1PApvfw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX4/gYBrzgKFw1
 ATkXNTABSgMEkjS6lhmgO61QBJbkVmy0uwwZ+JdjkHFPjZ+ESgQsDMba6mSRh1wM2VRnDKsF/9T
 XJCVPuthdD4ISmPOrbq80UCuYSnWOMc0n7bCq11sEtq2CizGG6c6YouScb+7cQvgK2+C9wDiOd2
 ZVwZJ69A+0ogyXggYC06JPYEy4CiJ+8bS+be6ieAMaVbd8arVdkaZIu+vNZ6wVOUf+8dlD3GZp1
 RXypRWb+/hFXeAdnYMOFUx2DVSXmkxj1xrWltmdzJ1/t2CxPRG3+aiyVrmNHw9T8B96RCQVhxJO
 7Ok3n+7Kda1+Jh59n7DHZOEgTid8o2jLA0Nw704amtNIgXxRXbBR8r/tYNbI5RPciMB292039oQ
 MzF70cve+JFaqGxwBGxVViDDpoehXzrZm8OOy+ZmhIfHmHFMIdYDRingaPhppi0EWYpAORmpZ67
 LuhMjmsIkmCA/oGahqw==
X-Authority-Analysis: v=2.4 cv=eIgjSnp1 c=1 sm=1 tr=0 ts=6a90b505 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=_Ry-N6Gx1nrijpWpWVgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: vt50j-bNFILwpijVmkUO7Z-ch1PApvfw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
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

We add possibility to declare cflags for a given test. Since we want to
preserve the uniqueness of test binaries, we prevent repeating those
cflags later, for an existing binary.

This ensures one executable == one set of cflags, and if dev needs
duplication, they can use a custom 'exe_name' to override this.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
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
2.43.0


