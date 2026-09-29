Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA36BC9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBSSb-0003JI-Pq; Tue, 29 Sep 2026 03:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSSU-0003Bu-Ps
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:41:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSSS-0005sJ-E0
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:41:02 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T7ToiJ3435129
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vY/4/WwG+/+
 hLAasWNeNvKwDKOuLlE8eHQqxKdIJYag=; b=P2dHWmPb0IZHxBuEhSiMhWumyGv
 UWsaKDODAYOazZj6NGG0AXK8ihLufvUpcKhtmRY8WMYFygK6OIz3LNnlGZSNOZdc
 GznZy0V+V5lW/vNieIXYeBcFn9IWBTU9CBd86C9RT6q6JOtE/BJLXKbua3C03oZ/
 DZnBaxaKKPCC8KIpuigV/wOJ9p2ULAlIeUMHzrRLwPtgpoFmsNA8kN9ZTBw52TDT
 B6diKIXg3aH2Yao/G3xI46D0L1tu2pVQCUSVbm0dM5akwMdaLNVzH3gWzyzZb+AX
 P9wGeTOXM2V0pzzU7eWkQnKXpa9gWhEpLDVUjxZIxxku2n+7Smuz4XDP7bw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyvwnauap-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:57 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-34318e88ba2so2522308eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 00:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790667657; x=1791272457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vY/4/WwG+/+hLAasWNeNvKwDKOuLlE8eHQqxKdIJYag=;
 b=eddqGWd476067f0g3Yc88boft7JwiXV+cP+sXFzkSkdLZ3rvjkz26IKa64zqcg5uid
 u4mZSVw2XZMVYJ8Tz9nfli9LCJ+G5KBZcXQM8OouLxly5kDW5gg+s26sJKU09e8Rt1KN
 iPIs2sxQkXv1xXg0ZPyOIj/jpc0F76Mk881jW6qrSV4MSdTcIxybB8BMqc9nbCMMyI2S
 PJy4v6PsW6dcQZlsfsbWb8/g95th4SeNSfiQZ27HDIMkO17YTDCkmnYEjTbXGPRZyTyo
 Y7CVDeyRBjB4ZdemjWHjO6uFqfRGPD+GAjs2nTQfsSqrCpvarj7unV6/CyPzqynCxxSO
 83Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790667657; x=1791272457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vY/4/WwG+/+hLAasWNeNvKwDKOuLlE8eHQqxKdIJYag=;
 b=eEKn05Rc43HF3LYFyCMVg0CZ1OvlWbXxbAUvNNDUVIdfNKufsUoCHYDg03eMnx5y5R
 N+GxUSWT5CyGLkAZXHYB9lhjXeEm6Kq5LaUQ8UxhXJdfPsAHQ+eHHiBLbBkl+i721S4v
 jynTcwti8tnTc+TrWRtb9c3n0ibW45oKvA7ueRxZ25pEGXPJmXlvPY8fPvdnJ7mVR+Tu
 m3uE+HNm9si+A7L1dOWc7dGLloFi6m4JFI4fS6oK0gdA+PyRE2uegAmPawFpqLhzkZOP
 6iBxCF0hJ6xqB1vKrX9wrBwuGyMuxktfcN52gU85J0fawjlrynnkqlrVe6bliZ35GpQj
 3qig==
X-Gm-Message-State: AFuF++nLw4frMSzOooYWv94CP5JzYHJaQXfwrfJlQhqQk0WNmsBefPvg
 cvbTexhylOwWhr6sSdZ5jMSbaAmCWYrF68m3b80zJopW3FwOOLVnvLbypZ4Kx8lO/bINs3BkI/Q
 zcADOPLGRAgqnQ84+sLAAK3vR2uDwWfbIMRsdR44V6TCf7WSshaM59fhL660LR+MhpA==
X-Gm-Gg: AYBFou1de5AQfPA6zLwhS2/a+SuMlBIi1n1RoynpOsSz4tk2JDX1WK4lxuz0a259I7B
 dUL87swVZ403YCXQykuxbIEWv7BilAIhsreJo1OBwjasHurMtRkcetIpYzqfe/XsQfDyWKKrJT+
 ugqN35amfoHasZ0UKk+ArPdpu42YsWXsxb4Dyrvo7infnTdyOlhYVByxMJIxqLfcXzuFYkKcpYU
 4qx7xjSqCGY37otu4XJjd6hrA84fz9bfg1/ZOSuDJMHp2ZeX2GWGCuR4xbuAQNDPSafcGEBZbMV
 woHS05HnCwC2zAkWAbweKV57gQhFY2wtLiIJ8eShdKfdMutBG6RMcgldsl+1e06d6Wzm2j7ldrk
 mFmOuB1dAqb/sgiEBmQ3MrHxKA99S4UUHVjPHMFM5P06QaVc2bPdchaWx0Q==
X-Received: by 2002:a05:7301:438a:b0:34a:dfa6:a9f0 with SMTP id
 5a478bee46e88-34adfa6adc9mr2535518eec.5.1790667656719; 
 Tue, 29 Sep 2026 00:40:56 -0700 (PDT)
X-Received: by 2002:a05:7301:438a:b0:34a:dfa6:a9f0 with SMTP id
 5a478bee46e88-34adfa6adc9mr2535488eec.5.1790667656137; 
 Tue, 29 Sep 2026 00:40:56 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3444fd04d93sm14647822eec.12.2026.09.29.00.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:40:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 19/19] tests/tcg/mips64: add mips64r6(el) tests
Date: Tue, 29 Sep 2026 07:40:07 +0000
Message-ID: <20260929074007.118970-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ukU2nifmDeh9c8DTbLUKQK3GQLoM4MmC
X-Authority-Analysis: v=2.4 cv=W42txhWk c=1 sm=1 tr=0 ts=6abb6b89 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=wCgUcsEHi0jYncpm0KkA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX7Lrp12rf2T3w
 sgxOhrjLNno4DJwJmt8zSxj++F6G5tnpyW5FmnCrRArpsWVV4ixTaBQGXddjDKQQhnJxgaMNrQu
 sMJjtq+Zb9nFNqTMCzBE0OdYIf8BELfRSptBOxHBWApnuSA/GPY82xjz2vZ2tcMBfHuVEAS52ZT
 XgJv6v1pA4Q3QDw27ATvJO+RNhS6sz/cWpj4rFJBQDBI5ernVstwqBFoNm2aA3F0jOtyrGHzMHe
 2z+ktv6+fI9sF+IgIKMul80Vw6Enhjk9vR72/CUqDp5Gxv99a0HhArROpNoNLtoPuaBixp1OA3a
 rstIk073aKxKiWgL/KBaMWdX29zHxF96EsixkIuR3P9BNTSw9MuJAqhcok/ad0GERpLbp8ssc7r
 PHiu2NPbPJq5zrudroVkpMlPpQRTrjULVFLGE0kkJeU1znOpxmHJKWne8YJN5W9DuOHQ0hylNHl
 Q4lnWP6rWrwGjIy6KLg==
X-Proofpoint-GUID: ukU2nifmDeh9c8DTbLUKQK3GQLoM4MmC
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX7ICJC7diubcg
 h0N5HrZZonwpHLoE1uSRe3oLe7xUlzAwOzAfO3aFQYn8yh7LAOJieI+akwSBQzJ0dMoUEmzuQ9W
 DNHIzNz4o2m1FRuBHSVYebtrnkD7AKY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290030
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

We need to define two new test suites mips64r6-linux-user and
mips64r6el-linux-user to be able to use a different compiler from
mips64-linux-user, as cc is setup only once per suite.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson_options.txt              |  8 +++++
 scripts/meson-buildoptions.sh  |  4 +++
 tests/tcg/mips64/meson.build   | 57 ++++++++++++++++++++++++++++++++++
 tests/tcg/mips64el/meson.build | 11 +++++++
 4 files changed, 80 insertions(+)

diff --git a/meson_options.txt b/meson_options.txt
index e6dd64b5a87..07b016c0fd4 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -445,6 +445,14 @@ option('tcg_tests_cross_cc_mips64', type: 'string',
        description: 'cc for mips64 tcg tests')
 option('tcg_tests_cross_cflags_mips64', type: 'string',
        description: 'cflags for mips64 tcg tests')
+option('tcg_tests_cross_cc_mips64r6', type: 'string',
+       description: 'cc for mips64r6 tcg tests')
+option('tcg_tests_cross_cflags_mips64r6', type: 'string',
+       description: 'cflags for mips64r6 tcg tests')
+option('tcg_tests_cross_cc_mips64r6el', type: 'string',
+       description: 'cc for mips64r6el tcg tests')
+option('tcg_tests_cross_cflags_mips64r6el', type: 'string',
+       description: 'cflags for mips64r6el tcg tests')
 option('tcg_tests_cross_cc_mips64el', type: 'string',
        description: 'cc for mips64el tcg tests')
 option('tcg_tests_cross_cflags_mips64el', type: 'string',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index b46005ee96c..4076a7f6b59 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -540,6 +540,8 @@ _meson_option_parse() {
     --tcg-tests-cross-cc-mips=*) quote_sh "-Dtcg_tests_cross_cc_mips=$2" ;;
     --tcg-tests-cross-cc-mips64=*) quote_sh "-Dtcg_tests_cross_cc_mips64=$2" ;;
     --tcg-tests-cross-cc-mips64el=*) quote_sh "-Dtcg_tests_cross_cc_mips64el=$2" ;;
+    --tcg-tests-cross-cc-mips64r6=*) quote_sh "-Dtcg_tests_cross_cc_mips64r6=$2" ;;
+    --tcg-tests-cross-cc-mips64r6el=*) quote_sh "-Dtcg_tests_cross_cc_mips64r6el=$2" ;;
     --tcg-tests-cross-cc-mipsel=*) quote_sh "-Dtcg_tests_cross_cc_mipsel=$2" ;;
     --tcg-tests-cross-cc-or1k=*) quote_sh "-Dtcg_tests_cross_cc_or1k=$2" ;;
     --tcg-tests-cross-cc-ppc64=*) quote_sh "-Dtcg_tests_cross_cc_ppc64=$2" ;;
@@ -563,6 +565,8 @@ _meson_option_parse() {
     --tcg-tests-cross-cflags-mips=*) quote_sh "-Dtcg_tests_cross_cflags_mips=$2" ;;
     --tcg-tests-cross-cflags-mips64=*) quote_sh "-Dtcg_tests_cross_cflags_mips64=$2" ;;
     --tcg-tests-cross-cflags-mips64el=*) quote_sh "-Dtcg_tests_cross_cflags_mips64el=$2" ;;
+    --tcg-tests-cross-cflags-mips64r6=*) quote_sh "-Dtcg_tests_cross_cflags_mips64r6=$2" ;;
+    --tcg-tests-cross-cflags-mips64r6el=*) quote_sh "-Dtcg_tests_cross_cflags_mips64r6el=$2" ;;
     --tcg-tests-cross-cflags-mipsel=*) quote_sh "-Dtcg_tests_cross_cflags_mipsel=$2" ;;
     --tcg-tests-cross-cflags-or1k=*) quote_sh "-Dtcg_tests_cross_cflags_or1k=$2" ;;
     --tcg-tests-cross-cflags-ppc64=*) quote_sh "-Dtcg_tests_cross_cflags_ppc64=$2" ;;
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index f08d1182576..37c4ed71c2d 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -23,3 +23,60 @@ if 'qemu-mips64' in emulators
     }
   }
 endif
+
+tests = []
+
+tests_mips64r6 = [
+  '../mips64/test_mips64r6_and.c',
+  '../mips64/test_mips64r6_bitswap.c',
+  '../mips64/test_mips64r6_clo.c',
+  '../mips64/test_mips64r6_clz.c',
+  '../mips64/test_mips64r6_crc32b.c',
+  '../mips64/test_mips64r6_crc32cb.c',
+  '../mips64/test_mips64r6_crc32cd.c',
+  '../mips64/test_mips64r6_crc32ch.c',
+  '../mips64/test_mips64r6_crc32cw.c',
+  '../mips64/test_mips64r6_crc32d.c',
+  '../mips64/test_mips64r6_crc32h.c',
+  '../mips64/test_mips64r6_crc32w.c',
+  '../mips64/test_mips64r6_dbitswap.c',
+  '../mips64/test_mips64r6_dclo.c',
+  '../mips64/test_mips64r6_dclz.c',
+  '../mips64/test_mips64r6_dmuh.c',
+  '../mips64/test_mips64r6_dmuhu.c',
+  '../mips64/test_mips64r6_dmul.c',
+  '../mips64/test_mips64r6_dmulu.c',
+  '../mips64/test_mips64r6_dsllv.c',
+  '../mips64/test_mips64r6_dsrav.c',
+  '../mips64/test_mips64r6_dsrlv.c',
+  '../mips64/test_mips64r6_muh.c',
+  '../mips64/test_mips64r6_muhu.c',
+  '../mips64/test_mips64r6_mul.c',
+  '../mips64/test_mips64r6_mulu.c',
+  '../mips64/test_mips64r6_nor.c',
+  '../mips64/test_mips64r6_or.c',
+  '../mips64/test_mips64r6_sllv.c',
+  '../mips64/test_mips64r6_srav.c',
+  '../mips64/test_mips64r6_srlv.c',
+  '../mips64/test_mips64r6_xor.c',
+]
+
+foreach src: tests_mips64r6
+  tests += {src: {'cflags': '-march=mips64r6'}}
+endforeach
+
+# export tests for mips64el
+tcg_tests_mips64el = tests
+
+if 'qemu-mips64' in emulators
+  tcg_tests += {
+    'mips64r6-linux-user': {
+      'cc': 'mipsisa64r6-linux-gnuabi64-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'folder': 'mips64',
+      'gdb_arch': 'mips64',
+      'qemu': emulators['qemu-mips64'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/mips64el/meson.build b/tests/tcg/mips64el/meson.build
index d74c7de9b7a..9398eb3e775 100644
--- a/tests/tcg/mips64el/meson.build
+++ b/tests/tcg/mips64el/meson.build
@@ -9,4 +9,15 @@ if 'qemu-mips64el' in emulators
       'tests': tcg_tests_mips64,
     }
   }
+
+  tcg_tests += {
+    'mips64r6el-linux-user': {
+      'cc': 'mipsisa64r6el-linux-gnuabi64-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'folder': 'mips64el',
+      'gdb_arch': 'mips64el',
+      'qemu': emulators['qemu-mips64el'],
+      'tests': tcg_tests_mips64el,
+    }
+  }
 endif
-- 
2.43.0


