Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A319C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZp7-0007nx-TP; Tue, 28 Jul 2026 00:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZoS-0006bg-KD
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:53:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZoQ-0002al-9V
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:53:08 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3bBA41063022
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Llyx+GAo6Tz
 6nQax+EXoeV0xdgIizfDawA2ljyeqniU=; b=KAY9e1BUIMXp0z5YD54V/4ENUUl
 LKS72xFbHYApxX1+XPWhYyCIuokJuREcG7gIB0+hetWHeMBIwfp9Iqe0kZst7FpE
 q4Qa0IhzvkPgTcp6vafoue5IMrVK0VsfTH+RxHWyh7o3v2DzeL693HsdKa8YClfZ
 waQaAhJQLnFWr3SVZhfED7rscspnzMCvt7Kk97tjRtuyw+q95YAWDSLFRYSxs8gF
 lL/5HMGVSmRQp+fzoTpsPALUK+wjH4WX/5dHSoI6v+u5uMfs4TyAKc/OyUE96511
 wg9E5btrJVqmxLucJUvqvUcln8COMnVnnYSVNCBgQsEx66+ZeX7kWB3fBqg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4v6chtw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:54 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb835525b13so3893506a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214374; x=1785819174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Llyx+GAo6Tz6nQax+EXoeV0xdgIizfDawA2ljyeqniU=;
 b=C5ceg1fpGxsPquyeWAbj0x23YdsP6IDty+Pr3S5qncWRMdKnuEMIT7KiFIsGrLxgWT
 l5nJF159RcCoiU3ALdgiXTMYvvP0G+cSePY/M+QYRQB2Qj+7AeauDn1ECQCM9KYn/sAh
 9AYX7WSiEJyO8lOaAb0l/lNzDg48nM4HgCsUskypg8rr+8Pq+bmcdkVq9P3vi2scDUi2
 VV9uRHdG3tVstr8k4yZYV3tlBniwohs2ZN5uVMv49ZC2oW1oIC3pNHo94/EuCLKu10qW
 aRttMhV+zr+zKL2I5SscgJElPWVe++afrqwAKi0tIGxbZ8RtGIK9kU0xvv1mGOeCZ54J
 nmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214374; x=1785819174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Llyx+GAo6Tz6nQax+EXoeV0xdgIizfDawA2ljyeqniU=;
 b=A3ZnLmLpiK/QMBvv3C5WibCNLN5ScqW0FtXoBzwcXfyfTfGcVsnsq9NwICX69zod23
 tolviYdptb0IM9F6ZBYRjpKcqf/xRM6pb7C4yCkGgbc6FAdxUjyBNBxN+pBRDM1gCBWE
 ym3SjLGpNs5tqM8xpk7LjGPjXPyGlRDFP43f69Qfm3v3ETxeYitj6lrZoaGoX9LXuHgX
 9rb5JQCePRVpom6fYRpAy3iyyJtPamYkHbf1CK29Y1Fj8ie23Hv3k+CqZ83typFvze2A
 ctbORpziq4ks48otJXW/og4kdr6uhRNSkvMFa5P+1OiuHrWjqGAJ0PJ9QRcz61GmlHfn
 QXkg==
X-Gm-Message-State: AOJu0YzqHzirg12TEsDD0TbB4sIAOl7Pxi0wgm2LEGra2m5XCshA2F0u
 jKkRHX6MAdaDkts0ExPF8F03PLdFviAErzkYvYOXJEakFE+D/2QGOsZhvusZh+5DfB9mBL7L2kj
 jacM0oPwaeg1hGEmbhXEnAfOBbLPbGEwP05DYn/fn/AoPUKFrDp/ip6ydJIKLj4yAJQ==
X-Gm-Gg: AR+sD10L11xM2buum/+Q/JRN9nsYQoiCeuGEXXsbIjphOm0UijI17BxmAyjT2KecZx+
 3k/kT9hg70oT6+sBHPl5zXJnoksiHLvnh0c+Np8QzxBHF2KkwCXYIOPSG95h1lfHlvNkWqj0DAH
 mnHi7YJUUzPGKF2yUK0J71Ten4f5kWX4FDhtA5zm6Jmxyc6mq919C1LLjptRLestry/JH1zZTTG
 wwxQSQiMVRoLA+TH4cSeXLuhnR056BQBffOA2SILNet4iXcn3MDUpVEbnFEdNvm2atia5//FAgb
 JZEusXnZLKRZ0jdfcHPCYB0doUVqxG4xw1PVaMvbtD8Pn4zmS8nfT4/sqWkhlvP/0w0koFcJIvR
 3rdmq2vrgE6C3WXlwsBfgzZ2IJrC6uqx8DzP5xNxDc3CV1Qc1z9hT1QlFW+BlQXKa8ZYHX6E=
X-Received: by 2002:a05:6a21:9983:b0:3c3:6f6c:aa21 with SMTP id
 adf61e73a8af0-3c8aafa3dc7mr1156909637.11.1785214374004; 
 Mon, 27 Jul 2026 21:52:54 -0700 (PDT)
X-Received: by 2002:a05:6a21:9983:b0:3c3:6f6c:aa21 with SMTP id
 adf61e73a8af0-3c8aafa3dc7mr1156876637.11.1785214373489; 
 Mon, 27 Jul 2026 21:52:53 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38900559eec.3.2026.07.27.21.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:52:53 -0700 (PDT)
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
Subject: [PATCH v6 100/103] tests/tcg/meson.build: implement ./configure
 -cross-cc-* options
Date: Mon, 27 Jul 2026 21:42:44 -0700
Message-ID: <20260728044248.137626-101-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX3YuFCh+Hg+EF
 j3O35gZQ2Z5RhSWSPzwKIF5AmqOA6MD9IJ+kNjdUzlpKCGWvoTvTuL0kgpS/Qr4ez7sEy5mVOwN
 jElK2IY94ZaJKZYqrCfbkrpUMjDr8p4=
X-Proofpoint-GUID: h5p0gav40osz4Q14Yp_QD0J8CHOTGh0e
X-Authority-Analysis: v=2.4 cv=ev3vCIpX c=1 sm=1 tr=0 ts=6a6835a6 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=tyAHEfYSJY4UUqYVGV0A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: h5p0gav40osz4Q14Yp_QD0J8CHOTGh0e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX7M1W80wf4mVB
 tpA0PWGmzxLmdvrXn0Lg5CooKCzKpjqEayp+26ssFYxLt7k2kHA8cXpNlj+YJiVUAG1ZCsY2qAD
 j/8TCmulI1ALL4zZ20gEAahVHwcIlUCDWS98AmXkY/qnwDbrg+8t+KZh5dlHHFcMjfPP/N6QdAi
 gxh6ufddNBoponH2/2RLiSJZzNs3LHa90lXI7WV0o2UQhOZ7kGODaVvs/G6n0JaVUoaurjemsFs
 HchMS+4pdWKIvvTjrLISGRCWyBqZOPIUzYEdhp4wWiLjnvsUc2zkRQdgT0bG3/LAIRGIAsu5ob8
 G3zkX/mTIs4Tay2de4oTUo58zpXLrhocRojSarVFGxK7w12GotSGtiUGiYLfaSHSIoaxOIfz96p
 De52PH2L6QxVbqMsWIHU+nLXsOjX67atWsG302TzJQt51GLSj+9VjVk5u2RungEueikOzFNGlxV
 oszhWrBuL5A7cAYwDyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280042
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

When a user set explicit cross cc, we ensure it's available and working.
When a user set explicit cross cflags, we ensure they work with default
or overriden cross_cc.

Made the first implementation with a single meson option (array), which
proved to be absolutely unreadable.
By having one option per target, we directly detect issue at configure
time, either for user, or when iterating on all our targets. This
ensures user can't mispell any target name, and that we can't forget any
new one in the future.
Also, it shows them in the configuration summary, which is a bonus.

Since we now only need to know compiler to write tcg tests, we can
simply alias -cross-prefix-* options to compiler override.

Examples
--------

wrong architecture:
$ ./configure --cross-cc-bad='cc'
../meson.build:1:0: ERROR: Unknown option: "tcg_tests_cross_cc_bad"

wrong option:
$ ./configure --cross-cc-cflags-aarch64='-bad-option'
../tests/tcg/meson.build:228:10: ERROR: Command `/usr/bin/aarch64-linux-gnu-gcc /home/pbouvier/.work/qemu/tests/tcg/test_cc.c -bad-option -static -nostdlib -r -o /dev/null` failed with status 1.
A full log can be found at /qemu/build/meson-logs/meson-log.txt

cross compile with clang (fails at the moment, since some tests have
compilation errors with it):
$ ./configure --target-list=aarch64-linux-user --cross-cc-aarch64='clang' --cross-cc-cflags-aarch64='-target aarch64-linux-gnu'
  User defined options
  ...
    tcg_tests_cross_cc_aarch64      : clang
    tcg_tests_cross_cflags_aarch64  : -target aarch64-linux-gnu

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 configure             | 27 ++++++-------
 meson_options.txt     | 89 +++++++++++++++++++++++++++++++++++++++++++
 tests/tcg/meson.build | 30 ++++++++++++---
 3 files changed, 126 insertions(+), 20 deletions(-)

diff --git a/configure b/configure
index 568de41dadd..c9e2cdcce5f 100755
--- a/configure
+++ b/configure
@@ -227,19 +227,6 @@ for opt do
   ;;
   --extra-ldflags=*) EXTRA_LDFLAGS="$EXTRA_LDFLAGS $optarg"
   ;;
-  --cross-cc-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-cc-FOO option"
-  ;;
-  --cross-cc-cflags-*) cc_arch=${opt#--cross-cc-cflags-}; cc_arch=${cc_arch%%=*}
-                      eval "cross_cc_cflags_${cc_arch}=\$optarg"
-  ;;
-  --cross-cc-*) cc_arch=${opt#--cross-cc-}; cc_arch=${cc_arch%%=*}
-                eval "cross_cc_${cc_arch}=\$optarg"
-  ;;
-  --cross-prefix-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-prefix-FOO option"
-  ;;
-  --cross-prefix-*) cc_arch=${opt#--cross-prefix-}; cc_arch=${cc_arch%%=*}
-                    eval "cross_prefix_${cc_arch}=\$optarg"
-  ;;
   --without-default-features) default_feature="no"
   ;;
   --wasm64-32bit-address-limit) wasm64_memory64="2"
@@ -632,9 +619,19 @@ for opt do
   ;;
   --extra-ldflags=*)
   ;;
-  --cross-cc-*)
+  --cross-cc-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-cc-FOO option"
   ;;
-  --cross-prefix-*)
+  --cross-cc-cflags-*) arch=${opt#--cross-cc-cflags-}; arch=${arch%%=*}
+                       meson_option_add "-Dtcg_tests_cross_cflags_${arch}=${optarg}"
+  ;;
+  --cross-cc-*) arch=${opt#--cross-cc-}; arch=${arch%%=*}
+                meson_option_add "-Dtcg_tests_cross_cc_${arch}=${optarg}"
+  ;;
+  --cross-prefix-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-prefix-FOO option"
+  ;;
+  # cross-prefix is just used as a syntactic sugar for -cross-cc.
+  --cross-prefix-*) arch=${opt#--cross-prefix-}; arch=${arch%%=*}
+                    meson_option_add "-Dtcg_tests_cross_cc_${arch}=${optarg}gcc"
   ;;
   --enable-docs) docs=enabled
   ;;
diff --git a/meson_options.txt b/meson_options.txt
index 5e91969414a..fd9ff0df893 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -389,3 +389,92 @@ option('containers', type: 'boolean', value: true,
        description: 'use containers to cross compile tcg tests')
 option('container_command', type: 'string',
        description: 'command to build/run containers')
+
+option('tcg_tests_cross_cc_aarch64', type: 'string',
+       description: 'cc for aarch64 tcg tests')
+option('tcg_tests_cross_cflags_aarch64', type: 'string',
+       description: 'cflags for aarch64 tcg tests')
+option('tcg_tests_cross_cc_aarch64_be', type: 'string',
+       description: 'cc for aarch64_be tcg tests')
+option('tcg_tests_cross_cflags_aarch64_be', type: 'string',
+       description: 'cflags for aarch64_be tcg tests')
+option('tcg_tests_cross_cc_alpha', type: 'string',
+       description: 'cc for alpha tcg tests')
+option('tcg_tests_cross_cflags_alpha', type: 'string',
+       description: 'cflags for alpha tcg tests')
+option('tcg_tests_cross_cc_arm', type: 'string',
+       description: 'cc for arm tcg tests')
+option('tcg_tests_cross_cflags_arm', type: 'string',
+       description: 'cflags for arm tcg tests')
+option('tcg_tests_cross_cc_hexagon', type: 'string',
+       description: 'cc for hexagon tcg tests')
+option('tcg_tests_cross_cflags_hexagon', type: 'string',
+       description: 'cflags for hexagon tcg tests')
+option('tcg_tests_cross_cc_hppa', type: 'string',
+       description: 'cc for hppa tcg tests')
+option('tcg_tests_cross_cflags_hppa', type: 'string',
+       description: 'cflags for hppa tcg tests')
+option('tcg_tests_cross_cc_i386', type: 'string',
+       description: 'cc for i386 tcg tests')
+option('tcg_tests_cross_cflags_i386', type: 'string',
+       description: 'cflags for i386 tcg tests')
+option('tcg_tests_cross_cc_loongarch64', type: 'string',
+       description: 'cc for loongarch64 tcg tests')
+option('tcg_tests_cross_cflags_loongarch64', type: 'string',
+       description: 'cflags for loongarch64 tcg tests')
+option('tcg_tests_cross_cc_m68k', type: 'string',
+       description: 'cc for m68k tcg tests')
+option('tcg_tests_cross_cflags_m68k', type: 'string',
+       description: 'cflags for m68k tcg tests')
+option('tcg_tests_cross_cc_mips', type: 'string',
+       description: 'cc for mips tcg tests')
+option('tcg_tests_cross_cflags_mips', type: 'string',
+       description: 'cflags for mips tcg tests')
+option('tcg_tests_cross_cc_mips64', type: 'string',
+       description: 'cc for mips64 tcg tests')
+option('tcg_tests_cross_cflags_mips64', type: 'string',
+       description: 'cflags for mips64 tcg tests')
+option('tcg_tests_cross_cc_mips64el', type: 'string',
+       description: 'cc for mips64el tcg tests')
+option('tcg_tests_cross_cflags_mips64el', type: 'string',
+       description: 'cflags for mips64el tcg tests')
+option('tcg_tests_cross_cc_or1k', type: 'string',
+       description: 'cc for or1k tcg tests')
+option('tcg_tests_cross_cflags_or1k', type: 'string',
+       description: 'cflags for or1k tcg tests')
+option('tcg_tests_cross_cc_ppc64', type: 'string',
+       description: 'cc for ppc64 tcg tests')
+option('tcg_tests_cross_cflags_ppc64', type: 'string',
+       description: 'cflags for ppc64 tcg tests')
+option('tcg_tests_cross_cc_ppc64le', type: 'string',
+       description: 'cc for ppc64le tcg tests')
+option('tcg_tests_cross_cflags_ppc64le', type: 'string',
+       description: 'cflags for ppc64le tcg tests')
+option('tcg_tests_cross_cc_riscv64', type: 'string',
+       description: 'cc for riscv64 tcg tests')
+option('tcg_tests_cross_cflags_riscv64', type: 'string',
+       description: 'cflags for riscv64 tcg tests')
+option('tcg_tests_cross_cc_s390x', type: 'string',
+       description: 'cc for s390x tcg tests')
+option('tcg_tests_cross_cflags_s390x', type: 'string',
+       description: 'cflags for s390x tcg tests')
+option('tcg_tests_cross_cc_sh4', type: 'string',
+       description: 'cc for sh4 tcg tests')
+option('tcg_tests_cross_cflags_sh4', type: 'string',
+       description: 'cflags for sh4 tcg tests')
+option('tcg_tests_cross_cc_tricore', type: 'string',
+       description: 'cc for tricore tcg tests')
+option('tcg_tests_cross_cflags_tricore', type: 'string',
+       description: 'cflags for tricore tcg tests')
+option('tcg_tests_cross_cc_x86_64', type: 'string',
+       description: 'cc for x86_64 tcg tests')
+option('tcg_tests_cross_cflags_x86_64', type: 'string',
+       description: 'cflags for x86_64 tcg tests')
+option('tcg_tests_cross_cc_xtensa', type: 'string',
+       description: 'cc for xtensa tcg tests')
+option('tcg_tests_cross_cflags_xtensa', type: 'string',
+       description: 'cflags for xtensa tcg tests')
+option('tcg_tests_cross_cc_xtensaeb', type: 'string',
+       description: 'cc for xtensaeb tcg tests')
+option('tcg_tests_cross_cflags_xtensaeb', type: 'string',
+       description: 'cflags for xtensaeb tcg tests')
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index ba73eecf1c9..8dd6623ad1d 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -180,6 +180,8 @@ foreach target, plan: tcg_tests
     continue
   endif
 
+  cc_arch = target.replace('-linux-user', '').replace('-softmmu', '')
+
   # Detect duplicated executables/tests, and report an error to force user to
   # choose how to deal with it.
   built_tests = {}
@@ -197,16 +199,34 @@ foreach target, plan: tcg_tests
   endforeach
 
   cc = find_program(plan['cc'], required : false)
+  cc_cflags = []
+
+  check_flags = []
+  check_required = false
+  cross_cc = get_option('tcg_tests_cross_cc_' + cc_arch)
+  if cross_cc != ''
+    # we make sure cross cc exists
+    cc = find_program(cross_cc, required: true)
+    check_required = true
+  endif
+  cross_cflags = get_option('tcg_tests_cross_cflags_' + cc_arch)
+  if cross_cflags != ''
+    cc_cflags = cross_cflags.split()
+    # and that cross cc can compile programs
+    check_flags = cc_cflags
+    check_required = true
+  endif
+
   cc_from_system = cc.found()
   has_cc = cc.found()
   if has_cc
-    check_flags = ['-static']
+    check_flags += ['-static']
     if target.endswith('softmmu')
-      check_flags = ['-nostdlib', '-r']
+      check_flags += ['-nostdlib', '-r']
     endif
 
     cmd = run_command([cc, files('test_cc.c'), check_flags, '-o', '/dev/null'],
-                      check: false)
+                      check: check_required)
     has_cc = cmd.returncode() == 0
     cc_from_system = has_cc
   endif
@@ -333,9 +353,9 @@ foreach target, plan: tcg_tests
         endif
       endif
 
-      cflags = []
+      cflags = cc_cflags
       if 'cflags' in setup
-        cflags = setup['cflags']
+        cflags += setup['cflags']
       endif
 
       if 'cc_feat' in setup
-- 
2.47.3


