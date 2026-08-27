Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78350C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziVr-0004IT-Ep; Thu, 27 Aug 2026 18:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVq-0004Ep-B2
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVn-0000Hl-41
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:58 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLwEu1117704
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=APkdoH/+ANg
 UeVJbvD4XxSWqXwEzoYtDjec5S14Z1Fg=; b=PwLPWWX0hQtsChAanyFQ34rdTD3
 hEKtsJAfMqOyIqkCfeYOmS/MtYxFoeyIKpUKI1ecEGHYyf2x30pxe8HIsq/skMFH
 3eTqqyyzyTremmklsclqpXFUpbkI4x5SqQ3skKcoQzzRsXFzb8gfvdiY8Z4er9X/
 3JqLIj+8lD8Lk4pn7/iXU2MM4M4L9po7C5pT7BF7VmhSMU17w7E0oNcZ0LfKfVA3
 O15gUF12Nu3auX4uZohq4Mq2+rbbVQDsc8PqU1xAVnjmfqWIDbITll4hfmgv+Gmq
 e0RGtZOooG+ChL6XRqIxJFD5FAmMjE//5ryb2IF3/baqduqR1PbvFk15jAQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garn0hgau-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cfc52ddc55so5563345ad.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869433; x=1788474233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=APkdoH/+ANgUeVJbvD4XxSWqXwEzoYtDjec5S14Z1Fg=;
 b=hQTx5ZvGh4eAxpfQ1nLhvUvPxZEnNuM7n8fo/NrAyDvtbOUFpHZTCNBMfwdfEfhOq7
 SLH6zYxV0Vv+mj4Q0caAyXdrdzK3XhCqXJ0Yfe/a6TTSnrvNNdwebbi4FvKnAqctYfDo
 +3ExbmIYn9ssU8Zp8zShszCuVaUeg/k0ONXM8EgiJafVbLIVanrSFqlb3YySm6ucmZLp
 2lBO4AJrrky+IK1BS17aK31qbaOzH77nY0r+M0250l/v5BNtKeY1w4M80szSZ7tEKmoq
 SH4oZWQ3USpx+jeiI4pJ5ipklVePaS8Ve2gtcnfCFc9sNg+7EHq61Hebjr66lQO3bCE4
 lFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869433; x=1788474233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=APkdoH/+ANgUeVJbvD4XxSWqXwEzoYtDjec5S14Z1Fg=;
 b=JaABME1sXNwL/SF6eSEX0DE9R9pdlQtiGMZUYfnmEWtLujTjSFfdQ3f+OaiUvzLJZO
 KDXkBijaeJHDTJRGcbHUPFRUvr1uiV23oQJU/4MNPqT4+U/M82JPkbYZrzZtUw0NphH6
 KhDKd6vQqso2G6/Ti6Z5uaSeUGe9NW8Nfl6b+dNiAAo4EJscVgROqM4NhxWvlLqF4pCe
 Tt34lumQjA4MXS55Zl6Zhn24bNUycevAVOCCM+bkO6ICEt+PMOVCd/F8u7n6FlnqYEGC
 LOCXMqz5kDk0loIErkdiddpIWJnS1h56GNkkv1X1GNsKH/ZpDC0Q7sPpwKqANM9jUXDe
 W/KA==
X-Gm-Message-State: AFuF++nPnuZFkIVrfnoIqbAriC7JjCSisvlFXzFkoxTBr+wbWPaaK1cx
 CXYhVog0qC3Wju8CoQiuZayXB7AtA67pWUI5kIyDESeS096FO9DdCktvzmhOqFt8inGyEyaibzB
 r4JFxqVX1EwaBT+/DColoHo3YhUT25QuldOjJHa2JO0oTe/7/l9CUcseSrUNeKd8QMA==
X-Gm-Gg: AR+sD11HXUpULoPww3nlS70gLulALPaS6ZmmXA6RjHwyVSlkZ75ogctX0uZsCiJzT54
 JJa6khc+Ad1hmT+tux2RnSCa3RqW6JY+b/QE+M9oh+mZs2TF7alhMySrrmxaj3NFOcpOU+M97pZ
 OsvV8pwwTmsus1xpy2LOGKNEhIObEjwVz/yhTiKLi/D6rkYeGQzlnI6mZncPxZAaEvmO+D31d6R
 Ux1PjQyjhM82kceyoFLy1Y91FZX5LiA64RqBBbvHZ7skqBr8iBqvCLHtuQkTyyYVu1USOJEbP2s
 42ZpJGR0doqjzjLbcopiW++V8CS7XsUCi86kH3fswpQO9n95m8X6OVUrKw6ctVE7sx84+ohWvgP
 L+Cg1n1Y4HfIXRt2h9C+lOKn2kTVAECD5ZDOjfw8ngF0R0EHFJ5rH/nSXMWc=
X-Received: by 2002:a17:902:6a87:b0:2cc:777f:d67c with SMTP id
 d9443c01a7336-2d74df04b55mr22261115ad.13.1787869432955; 
 Thu, 27 Aug 2026 15:23:52 -0700 (PDT)
X-Received: by 2002:a17:902:6a87:b0:2cc:777f:d67c with SMTP id
 d9443c01a7336-2d74df04b55mr22260665ad.13.1787869432414; 
 Thu, 27 Aug 2026 15:23:52 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d70493f729sm20776155ad.2.2026.08.27.15.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:23:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 101/105] tests/tcg/meson.build: implement ./configure
 -cross-cc-* options
Date: Thu, 27 Aug 2026 22:15:02 +0000
Message-ID: <20260827221506.91574-102-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX7LL75J7+wFBc
 rlmz2kFVAsLZcAxEm5KDHUDfFWM2M5DzC6pRKrgIW3T2X1EUVnZgsYQPdJrnKWbV7RgMdnhrVlI
 hEO0lMhzhH/q4kGimF+kP0shhdm/+N6+lYsn+LsSx55CC9gxTvqaUntW3XXhIvy1vVsa2RuzCv/
 iuF8TO3CmS3IZwnPmCTHyKvS6fnWoCjx3SLCGBaCRJEhqCThS7wKSrMxGRZbPVVrOoTSO/n//ag
 5T+UNXgOHK7ocY7BF01yyuEOPVCIlvc7oMwqBYzehZUfcLpPagJwvSAAS+ZHGhtwfPk3aybactO
 UlTym7z3tH8AV1UcX+7Sine7Fv+2tQv6IuR+p40Ak1lZPlpaYV5rL6jcGK3xTbOPut5+1PSIr2g
 pifoGUru/WAd8iSBaooPanRNlvT5lPu6TgkXbJ+rhV6gLZf97qAU60yOMwEeutWbd2SZrJfg6u7
 O66lmeW4RDfNi2d4DoA==
X-Proofpoint-GUID: 6OAYCsXQQiUEB2Sngj0Te40UpA3wfkSL
X-Authority-Analysis: v=2.4 cv=C+3ZDwP+ c=1 sm=1 tr=0 ts=6a90b8fa cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=tyAHEfYSJY4UUqYVGV0A:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 6OAYCsXQQiUEB2Sngj0Te40UpA3wfkSL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfXyqxF+DYqJadk
 pe7MlGat1J2IE7m5JQkkq2kUVO2ZPgSZ/9pQFHf1FpXVfghGumJQwFMPkhieorHlLPhYSf3+2g1
 LCfSWHbmbF561xiocsSzXUy9DIawWEA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270190
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 configure             | 27 ++++++-------
 meson_options.txt     | 89 +++++++++++++++++++++++++++++++++++++++++++
 tests/tcg/meson.build | 31 ++++++++++++---
 3 files changed, 127 insertions(+), 20 deletions(-)

diff --git a/configure b/configure
index d173ab93068..9f37675eb7e 100755
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
index 2458a231f5f..9cf632d2717 100644
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
@@ -197,16 +199,35 @@ foreach target, plan: tcg_tests
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
     if target.endswith('softmmu')
-      check_flags = ['-nostdlib', '-ffreestanding', '-r']
+      check_flags += ['-nostdlib', '-ffreestanding', '-r']
+    else
+      check_flags += ['-static']
     endif
 
     cmd = run_command([cc, files('test_cc.c'), check_flags, '-o', '/dev/null'],
-                      check: false)
+                      check: check_required)
     has_cc = cmd.returncode() == 0
     cc_from_system = has_cc
   endif
@@ -333,9 +354,9 @@ foreach target, plan: tcg_tests
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
2.43.0


