Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B8AC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPYW-0004Jy-03; Tue, 18 Aug 2026 15:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPYO-00041q-45
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPYK-0000NJ-Tw
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:55 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH4WD3003269
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=n9BV8fVDjUZ
 aN3ST2NBgBhpXkDWDodo2Cot0LpEumTI=; b=nQhjw4FdkdR6ocwKGwXNB9i2mnJ
 YO393KMmoKjIQ4lWIwLnyN6klFJHsvk6Ss7okjHfC4u6+I7SiBxBRJKydTFlcf5a
 CsOoev6+fi7t23o9/eQPYeL4Z9Y9q7NBj1Wz1+77ZcILwLNzKMV7GaNYlhgKq+Je
 SItAiADN/YeOa0ThkgLZ282Novrk5ZNxwHoMvuPJhpnfZ3REcBdQdPirmel27x45
 QbmNEbkvsShTuR1SlaV9+5KSqipYmp6zWk2dTtp5bySByUrMZrAgP42R3mAHJUHl
 uKYBtlwwU2tZpa26GIkfrwqjVCLBYsy6Wfa7qyuwynmHXGmf1+6zh8bSLtg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4frmv50c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:50 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cf1c86963bso12700295ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081570; x=1787686370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n9BV8fVDjUZaN3ST2NBgBhpXkDWDodo2Cot0LpEumTI=;
 b=jjXEn/XYJqs+89G0LcHDfj/JsdDNincxjRJzYKqLqKoL1a9cRbfJWI7ER3DIBYmsvN
 xRYHI8OxtHaKr9BryRldbWAyuFwPeG6eMCIt2JhLLS7Qk+vsW5RXum5tmwhOkagoBpI6
 A7CZrgpiD2JdyJYq4iebsiGOXGJvhfC3nZEjmhH45pQRVZjBJZAVccb5r8WSoQT7CbVy
 DYUBlf+oNqFwio91egZGJOzqN+WekC/0g9ZSbPW6LKF0h47gh9Cpf3kwplUqS6q/XDpF
 ShD+YJjk34R+H9kN2qh5fh4Lz0PjFUPtp3Et+nYWUrteDsdCorFbN2YQquxq/rgfMqtI
 p28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081570; x=1787686370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=n9BV8fVDjUZaN3ST2NBgBhpXkDWDodo2Cot0LpEumTI=;
 b=VD7g55Vhihf1XSwnD+NsQaFGu/JKXFm0XSaCaGJiBkYOtPNBMxPVmO3Vs2gUb3BAJT
 Z4aVsm6pTtRPPmc3kNnwSZVJ2bgSFTbCeeS6EN2rwEkFCeODD6GuQ4crcBQUSXwBuhQy
 VDY9is5y+iZZesrEGkt2fkrrCgzmbGxrR85ArD8bf9BZUPjomplask25WD+IGzeySOpM
 StBTlJtt4UvtY5PKf2mNBO01GqasNFfCV/6dwzlQnNaPeiqFn5EVLn/RaZ3urWbMtClm
 PoKq7f46WPpvb01PeK7vnb+xYEFA+cHFBbaMFPSkKJ797FLqNuHbt3zKyfaWQWF9cDRV
 rOQw==
X-Gm-Message-State: AOJu0YxdUHeglvcvkBQLvJhU6g0kFII8TnqHaOZqCBfF+nqrdBcD/w17
 pfR2BbYZRsGsHnLS7oRo/zHFEJICYA5rFojANWW/yWfrCYtKnFc9EtsPU/1M3h+3th4E709duul
 zSZN1fTNJV5x7LIztdYCkpTxbJWuxoS3afHng6WacsJ2WG2TpyfjWIHEP5oP9D85CJA==
X-Gm-Gg: AR+sD11p0tQ66LSw8et0L2F+quf3Kwl+hNkuV9/RyC7szseb85VrF2qajtw1cIbUF9X
 uhg3cmb1P75MFn+Pba4CqbDrvUIhtvblXLpHR/i03cMdRcRET9QYXc/KhuqFsO9VmOWhYVd8JrK
 VKGYM06DQrd3Iwz47VDPyqmVFCyilwyYQ1bDBMFBtuLHZSiMghE7RGUWB7PK1gfNAKf10Mez8qo
 tKth5sRi9HAe+LyCk6l27ljo9W5S2/Gn+JTk5SvYao77WTQ6/8Gw4k9+2Xow5Lb7umdMOo9E3JA
 Imr8mdoJiK4RFR5v5wP9k934NFH9se2KWLLztnRTJljm3fRrl64uWyH2VAFiXxVi5iGQ+ja7BJk
 MNK/30w25BEJQH0w2FNAU2xRBwuFCJDukCm5mEkMitFGNvs1f7PIsocxjwrU=
X-Received: by 2002:a17:903:228a:b0:2d2:72b6:556b with SMTP id
 d9443c01a7336-2d5cadc7719mr75205765ad.13.1787081569901; 
 Tue, 18 Aug 2026 12:32:49 -0700 (PDT)
X-Received: by 2002:a17:903:228a:b0:2d2:72b6:556b with SMTP id
 d9443c01a7336-2d5cadc7719mr75205405ad.13.1787081569414; 
 Tue, 18 Aug 2026 12:32:49 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326798c566asm21877135eec.11.2026.08.18.12.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:32:48 -0700 (PDT)
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
Subject: [PATCH v7 101/104] tests/tcg/meson.build: implement ./configure
 -cross-cc-* options
Date: Tue, 18 Aug 2026 19:23:05 +0000
Message-ID: <20260818192309.22169-102-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX/CSuDljP+gRd
 Nv1Ox53QaS00hzhYJFxk6NG7XuMbjs6zmvwcXzT52gdaTfzQqEcV/ZLkemH8Dn97pw0zXwh2G8Z
 lWnW+aHiTgAsl+Cq4zd18/unZMnRy00ItE3nIIWuN9BCR0WQal5aD2Y+Bl6/RNHuPRggrBvzpz4
 RfBZSXpxjs+lVYdGotkJ5w8fQjr0mU6YINJHSr1wn44fM2GVTV45kjeyO51GJ2QGTHZro6N0eeD
 o6bxqEA/kpN17FpekUzLBt4MpVQYBqO7hujb1bg9IR4x79+gcQOJOWDPGEcy0mmVd/UYRfP652g
 JqEDonUSlNAW28XXb6Ri3vSdh0w/hKCP0dEp5j9VXgy3j+WEvl6g2p4eq2UxqOMlXeaefdqMW15
 OxR0+8rjJNKwW9uozQQqvQFNCrrcyIakFeh2NIXIX47vsWSZmj4J0n7AnxkmGkInCjccuQd+XHS
 YGApVyc74O8vXzi24zA==
X-Proofpoint-GUID: KY0zhis8RZl6gLFoqvzAU5u4wvHLwtpe
X-Proofpoint-ORIG-GUID: KY0zhis8RZl6gLFoqvzAU5u4wvHLwtpe
X-Authority-Analysis: v=2.4 cv=GtlyPE1C c=1 sm=1 tr=0 ts=6a84b363 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=tyAHEfYSJY4UUqYVGV0A:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXzW5fEkQ22EgN
 BOMrA3P/VzQ++YMLqH5nqckC5fyw81y3eESHJxeTxDsTWHvBbcJgIkLaPC59HvJw7F3PAk96xA4
 XU7HZRlIMhMWuHxCKg935KkWGB6PsDA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 configure             | 27 ++++++-------
 meson_options.txt     | 89 +++++++++++++++++++++++++++++++++++++++++++
 tests/tcg/meson.build | 31 ++++++++++++---
 3 files changed, 127 insertions(+), 20 deletions(-)

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


