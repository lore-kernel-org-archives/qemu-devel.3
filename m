Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F18C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgs1t-0005r1-9X; Mon, 06 Jul 2026 18:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgs1r-0005qU-QY
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:43:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgs1n-0000LQ-UL
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:43:07 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEFqe1639590
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=cv8dbPEWYUv
 APfnZDlwYgoXyjBd2Ojt0Im40Ax0WwyA=; b=c6k3ohtld8kl2t72twGIDaPsWbe
 N+6uVsnsAD/3HfLez54GT31k4ktB//+XsQIJoh+JRgTkLRYKYW+4NYm0NJhltNu4
 Abd1JdixJtW5FiSfAiqotqSjPVeFtp0JaGy96aZYH7jRCwHY/NdELfriBJas45kD
 8APpzjJ1UmbKqefmg73AqjkWcwQhbwxg0vL0snxIgbmt46rZV9K9TAGw0Jzc1j09
 PCEDIt464fKPb8chXfFdx+Q/ReWeiodkNGfTqymMQZVT80g6aosC+zpms3mHyJVO
 G1IfFXUWIzp8WlVMyfLLfZbEF5iTHzUilpXZolC59eDBkN4twC+d5gbblqg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r35ru-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:43:02 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-847ac21582cso3780030b3a.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377782; x=1783982582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cv8dbPEWYUvAPfnZDlwYgoXyjBd2Ojt0Im40Ax0WwyA=;
 b=NmJRDfkjHK8oY8ClAktwItni5+MFE/JPv8UdRmvrfgngTc0gi4KQ7CjqusXBMC8Nt5
 jCwINTomRZG2qrTPSjywz8Nun7FBDWaVo9/fOOdy5IhI+HIWiLt2Bm6jN4at7wd/t3zG
 m+NCLB6sac6WNhsICATf2/GUX9+3YHX7KW1P++qEWMcQDtAKTabZuQcSxroDVZqLt+i4
 G4OcbIB6gdKwvlkbf8cpcG/xrQF9UQGi2yCksGJsYBZAxEGV1zl7Jc7n1YLr0ayd5qvQ
 ZvrweXRnCNZKcMUF6yuZR41Y8RIq+PA6eJR91VmpTEygFe4bkK8mfijldBwXJR/WrqQ0
 W6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377782; x=1783982582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cv8dbPEWYUvAPfnZDlwYgoXyjBd2Ojt0Im40Ax0WwyA=;
 b=Qf4aqOubxs2qbvI5TK/tTIHb6u2So0rJ6oU/5AByp4eliAB4t0X12DUxm3G0SttBqf
 VuWdI++g/VjcZWZt5Blhb6UiiRitspRdgnmLLMjINmT5N86MOJud7Ha0zNipmldWbf5m
 Hl8/Bz4rJtoWPYcO72679K9Wk93vFmC46tpNcklLqWTaOZ6mUGm5yuIuMhaJp43p1zrf
 i/1dOR34cTXPXxtpFelViOL9SSq6mNmkpkxK2L6FzjJHOdGUnX1RUXHeRVSPtHT0tK0m
 gnCPx6nXRcSvp9ESKN4Orl2h1p3avttgs8wUQwTB4wDwvfU7m2lIU6BPa8Mm6QwkjTCP
 aTIw==
X-Gm-Message-State: AOJu0YxtpKjS+23xFtHTen6QzCMZXhg6QMRvshAnkdRnwnY06ASib5hp
 2a9KzqmIfEE7IXS0qR/VGwBnjdUjS6OQgJgX6JBTcl2MVNf76pLWkgI5lcfABMBwWqZoWNGmz5M
 ubY7dGMqDpm/XmbR/DIZikXrBc2wzLFLSPMwukeoqEB4Vw0wZEHhawcQHmUmHUNOQyw==
X-Gm-Gg: AfdE7cmbUBeODp5h444IeC6YRUbOrr0wduD+LZIrT4S/cohFSfj2H4hgteT5hJ4ZoyE
 VVaV2f1HZ7R6czqi3G3DKqhcwWAm6RJul1k9SU1p+uzchXbhTat/ENKQTWwggRHv3YooM71i7d+
 UF1L2vrUBL9voOZelifeWmK3qF54aMDO1LW8RlIl+sCzDIiLnM86ItYQNCvoA2IK/7rQC9c5rsv
 7U42ufD5qO5w5DzapmX16korGXr4il0DRW83G51ki0ePg81cAfej4qLCRZv3tgMh9IWoVou22jg
 Hi374yMT8TO2u1gAruU0Vl5OaVHngb9H7SotJTrG4Q0zpRCPvxw/yFiqPwqUz+HfBjZ/w24Ze2n
 S7WQFTSxf/8bcXm6OYtAnlZx2ihjzPuut0O/nuRYNifWzVPeSN9CmKk4s933XIfi9sZFx4crlbG
 NamrG8qw==
X-Received: by 2002:a05:6a20:431c:b0:3bf:b927:a8c with SMTP id
 adf61e73a8af0-3c08ec8d9b3mr3010714637.2.1783377781649; 
 Mon, 06 Jul 2026 15:43:01 -0700 (PDT)
X-Received: by 2002:a05:6a20:431c:b0:3bf:b927:a8c with SMTP id
 adf61e73a8af0-3c08ec8d9b3mr3010677637.2.1783377781076; 
 Mon, 06 Jul 2026 15:43:01 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1439200c88.14.2026.07.06.15.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:43:00 -0700 (PDT)
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
Subject: [PATCH v3 91/91] configure: remove --cross-cc* options
Date: Mon,  6 Jul 2026 15:33:43 -0700
Message-ID: <20260706223343.988769-92-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfXz5dyNpRAjcPR
 WzzUIRWlLuq4jyi/vHWjeOh+AKHS+aC8IQ5ye5O0tV/vUtU6WHMZK7N/SKOtBdy2rSsagmS5yRF
 QKzJ3ylNgKXrWamQeUuC5xZo2s5q7tO/OWhKfLxNUykuOD+qRJPWCtIvVJBRwORZxjSA5DBxjCW
 xdhUVAkMpR3ny6pgQZEguk9aH5CV3YY5wLyJ5p0pUbORAXurQ0HvFckppsWa9ozcpIp2KF60dzx
 /CDgr/uAt5ugftA7A5wN7lpYyisjWGtfS2vmLIQddxAtWpxbM/GTqYmEn4im17Om0uiNdFtmpGf
 EF03PUYpvdO43z8XeOSPhY/onpCN8dnzyThvdQrWwoB74R5EfBAsmvWwFUqmfHLplrh8m4Ywsu+
 jN2ipr3DYmmpMSLukSw+layAKpfidxVCiZL0QB1/QPyPJPHXvUkKOyoFMAHoCXTrpdhGcTR2ul1
 32BxF17naWoSLCTMk3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfXzrBvYJfdlal+
 7ylgobKT0i+2XUzxsIabiGniE2JOkenVkr32ByZvB/L/GRB5EoA+fwPRYxsI5z+yKhxhagZhafR
 v6hLXoZzqnFc1Hy1cJUoqiFG12yre7o=
X-Proofpoint-GUID: jdL1HBOp_8RfFwsz-81jKBwgVTLTNmXQ
X-Proofpoint-ORIG-GUID: jdL1HBOp_8RfFwsz-81jKBwgVTLTNmXQ
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4c2f76 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=zSBibQ1pa2fvTUXhR7MA:9 a=2VI0MkxyNR6bbpdq8BZq:22 a=5k9Kp4q2ka107-X1Cztv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060228
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

Those options were useful a few years ago, before containers were
available as an alternative for missing cross compilers. Simplify the
workflow by removing those options and maintaining only the container
based approach.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 configure                   | 473 ------------------------------------
 docs/devel/testing/main.rst |  22 +-
 2 files changed, 3 insertions(+), 492 deletions(-)

diff --git a/configure b/configure
index d8bc10060e1..e442cf84676 100755
--- a/configure
+++ b/configure
@@ -228,14 +228,6 @@ for opt do
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
   --cross-prefix-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-prefix-FOO option"
   ;;
   --cross-prefix-*) cc_arch=${opt#--cross-prefix-}; cc_arch=${cc_arch%%=*}
@@ -636,8 +628,6 @@ for opt do
   ;;
   --extra-ldflags=*)
   ;;
-  --cross-cc-*)
-  ;;
   --cross-prefix-*)
   ;;
   --enable-docs) docs=enabled
@@ -854,8 +844,6 @@ Advanced options (experts only):
   --extra-cxxflags=CXXFLAGS append extra C++ compiler flags CXXFLAGS
   --extra-objcflags=OBJCFLAGS append extra Objective C compiler flags OBJCFLAGS
   --extra-ldflags=LDFLAGS  append extra linker flags LDFLAGS
-  --cross-cc-ARCH=CC       use compiler when building ARCH guest test cases
-  --cross-cc-cflags-ARCH=  use compiler flags when building ARCH guest tests
   --cross-prefix-ARCH=PREFIX cross compiler prefix when building ARCH guest test cases
   --python=PYTHON          use specified python [$python]
   --ninja=NINJA            use specified ninja [$ninja]
@@ -1288,366 +1276,6 @@ EOF
   fi
 fi
 
-##########################################
-# functions to probe cross compilers
-
-runc="no"
-if test $use_containers = "yes" && (has "docker" || has "podman"); then
-    runc=$($python "$source_path"/tests/docker/docker.py --engine "$container_engine" probe)
-    if test "$runc" != "no"; then
-        docker_py="$python $source_path/tests/docker/docker.py --engine $container_engine"
-    fi
-fi
-
-# cross compilers defaults, can be overridden with --cross-cc-ARCH
-: ${cross_prefix_aarch64="aarch64-linux-gnu-"}
-: ${cross_prefix_aarch64_be="$cross_prefix_aarch64"}
-: ${cross_prefix_alpha="alpha-linux-gnu-"}
-: ${cross_prefix_arm="arm-linux-gnueabihf-"}
-: ${cross_prefix_armeb="$cross_prefix_arm"}
-: ${cross_prefix_hexagon="hexagon-unknown-linux-musl-"}
-: ${cross_prefix_loongarch64="loongarch64-unknown-linux-gnu-"}
-: ${cross_prefix_hppa="hppa-linux-gnu-"}
-: ${cross_prefix_i386="i686-linux-gnu-"}
-: ${cross_prefix_m68k="m68k-linux-gnu-"}
-: ${cross_prefix_microblaze="microblaze-linux-musl-"}
-: ${cross_prefix_mips64el="mips64el-linux-gnuabi64-"}
-: ${cross_prefix_mips64="mips64-linux-gnuabi64-"}
-: ${cross_prefix_mipsel="mipsel-linux-gnu-"}
-: ${cross_prefix_mips="mips-linux-gnu-"}
-: ${cross_prefix_ppc="powerpc-linux-gnu-"}
-: ${cross_prefix_ppc64="powerpc64-linux-gnu-"}
-: ${cross_prefix_ppc64le="$cross_prefix_ppc64"}
-: ${cross_prefix_riscv64="riscv64-linux-gnu-"}
-: ${cross_prefix_s390x="s390x-linux-gnu-"}
-: ${cross_prefix_sh4="sh4-linux-gnu-"}
-: ${cross_prefix_sparc64="sparc64-linux-gnu-"}
-: ${cross_prefix_sparc="$cross_prefix_sparc64"}
-: ${cross_prefix_tricore="tricore-"}
-: ${cross_prefix_x86_64="x86_64-linux-gnu-"}
-
-: ${cross_cc_aarch64_be="$cross_cc_aarch64"}
-: ${cross_cc_cflags_aarch64_be="-mbig-endian"}
-: ${cross_cc_armeb="$cross_cc_arm"}
-: ${cross_cc_cflags_armeb="-mbig-endian"}
-: ${cross_cc_hexagon="hexagon-unknown-linux-musl-clang"}
-: ${cross_cc_cflags_hexagon="-mv73 -O2 -static"}
-: ${cross_cc_cflags_i386="-m32"}
-: ${cross_cc_cflags_ppc="-m32 -mbig-endian"}
-: ${cross_cc_cflags_ppc64="-m64 -mbig-endian"}
-: ${cross_cc_ppc64le="$cross_cc_ppc64"}
-: ${cross_cc_cflags_ppc64le="-m64 -mlittle-endian"}
-: ${cross_cc_cflags_sparc64="-m64 -mcpu=ultrasparc"}
-: ${cross_cc_sparc="$cross_cc_sparc64"}
-: ${cross_cc_cflags_sparc="-m32 -mcpu=supersparc"}
-: ${cross_cc_cflags_x86_64="-m64 -mcx16"}
-
-compute_target_variable() {
-  eval "$2="
-  if eval test -n "\"\${cross_prefix_$1}\""; then
-    if eval has "\"\${cross_prefix_$1}\$3\""; then
-      eval "$2=\"\${cross_prefix_$1}\$3\""
-    fi
-  fi
-}
-
-have_target() {
-  for i; do
-    case " $target_list " in
-      *" $i "*) return 0;;
-      *) ;;
-    esac
-  done
-  return 1
-}
-
-# probe_target_compiler TARGET
-#
-# Look for a compiler for the given target, either native or cross.
-# Set variables target_* if a compiler is found, and container_cross_*
-# if a Docker-based cross-compiler image is known for the target.
-# Set got_cross_cc to yes/no depending on whether a non-container-based
-# compiler was found.
-#
-# If TARGET is a user-mode emulation target, also set build_static to
-# "y" if static linking is possible.
-#
-probe_target_compiler() {
-  # reset all output variables
-  got_cross_cc=no
-  container_image=
-  container_hosts=
-  container_cross_prefix=
-  container_cross_cc=
-  container_cross_ar=
-  container_cross_as=
-  container_cross_ld=
-  container_cross_nm=
-  container_cross_objcopy=
-  container_cross_ranlib=
-  container_cross_strip=
-
-  target_arch=${1%%-*}
-  case $target_arch in
-    aarch64) container_hosts="x86_64 aarch64" ;;
-    aarch64_be) container_hosts="x86_64 aarch64" ;;
-    alpha) container_hosts=x86_64 ;;
-    arm) container_hosts="x86_64 aarch64" ;;
-    hexagon) container_hosts=x86_64 ;;
-    hppa) container_hosts=x86_64 ;;
-    i386) container_hosts=x86_64 ;;
-    loongarch64) container_hosts=x86_64 ;;
-    m68k) container_hosts=x86_64 ;;
-    microblaze) container_hosts=x86_64 ;;
-    mips64el) container_hosts=x86_64 ;;
-    mips64) container_hosts=x86_64 ;;
-    mipsel) container_hosts=x86_64 ;;
-    mips) container_hosts=x86_64 ;;
-    ppc) container_hosts=x86_64 ;;
-    ppc64|ppc64le) container_hosts=x86_64 ;;
-    riscv64) container_hosts=x86_64 ;;
-    s390x) container_hosts=x86_64 ;;
-    sh4) container_hosts=x86_64 ;;
-    sparc64) container_hosts=x86_64 ;;
-    tricore) container_hosts=x86_64 ;;
-    x86_64) container_hosts="aarch64 ppc64le x86_64" ;;
-    xtensa*) container_hosts=x86_64 ;;
-  esac
-
-  for host in $container_hosts; do
-    test "$runc" != no || continue
-    test "$host" = "$cpu" || continue
-    case $target_arch in
-      # debian-all-test-cross architectures
-
-      aarch64_be)
-        container_image=debian-all-test-cross
-        container_cross_prefix=aarch64-linux-gnu-
-        ;;
-      alpha|hppa|m68k|mips|mipsel|riscv64|sh4|sparc64)
-        container_image=debian-all-test-cross
-        ;;
-      mips64)
-        container_image=debian-all-test-cross
-        container_cross_prefix=mips64-linux-gnuabi64-
-        ;;
-      ppc|ppc64|ppc64le)
-        container_image=debian-all-test-cross
-        container_cross_prefix=powerpc${target_arch#ppc}-linux-gnu-
-        ;;
-
-      # architectures with individual containers
-
-      aarch64)
-        # We don't have any bigendian build tools so we only use this for AArch64
-        container_image=debian-arm64-cross
-        ;;
-      arm)
-        # We don't have any bigendian build tools so we only use this for ARM
-        container_image=debian-armhf-cross
-        container_cross_prefix=arm-linux-gnueabihf-
-        ;;
-      hexagon)
-        container_cross_prefix=hexagon-unknown-linux-musl-
-        container_cross_cc=${container_cross_prefix}clang
-        ;;
-      i386)
-        container_image=debian-i686-cross
-        container_cross_prefix=i686-linux-gnu-
-        ;;
-      loongarch64)
-        container_image=debian-loongarch-cross
-        container_cross_prefix=loongarch64-unknown-linux-gnu-
-        ;;
-      microblaze)
-        container_cross_prefix=microblaze-linux-musl-
-        ;;
-      mips64el)
-        container_image=debian-all-test-cross
-        container_cross_prefix=mips64el-linux-gnuabi64-
-        ;;
-      tricore)
-        container_image=debian-tricore-cross
-        container_cross_prefix=tricore-
-        ;;
-      x86_64)
-        container_image=debian-amd64-cross
-        ;;
-      xtensa*)
-        container_image=debian-xtensa-cross
-
-        # default to the dc232b cpu
-        container_cross_prefix=/opt/2020.07/xtensa-dc232b-elf/bin/xtensa-dc232b-elf-
-        ;;
-    esac
-    # Debian and GNU architecture names usually match
-    : ${container_image:=debian-$target_arch-cross}
-    : ${container_cross_prefix:=$target_arch-linux-gnu-}
-    : ${container_cross_cc:=${container_cross_prefix}gcc}
-    : ${container_cross_ar:=${container_cross_prefix}ar}
-    : ${container_cross_as:=${container_cross_prefix}as}
-    : ${container_cross_ld:=${container_cross_prefix}ld}
-    : ${container_cross_nm:=${container_cross_prefix}nm}
-    : ${container_cross_objcopy:=${container_cross_prefix}objcopy}
-    : ${container_cross_ranlib:=${container_cross_prefix}ranlib}
-    : ${container_cross_strip:=${container_cross_prefix}strip}
-  done
-
-  try=cross
-  # For softmmu/roms also look for a bi-endian or multilib-enabled host compiler
-  if [ "${1%softmmu}" != "$1" ] || test "$target_arch" = "$cpu"; then
-      case "$target_arch:$cpu" in
-        aarch64_be:aarch64 | \
-        armeb:arm | \
-        i386:x86_64 | \
-        ppc*:ppc64 | \
-        sparc:sparc64 | \
-        "$cpu:$cpu")
-        try='native cross' ;;
-      esac
-  fi
-  eval "target_cflags=\${cross_cc_cflags_$target_arch}"
-  for thistry in $try; do
-    case $thistry in
-    native)
-      target_cc=$cc
-      target_ccas=$ccas
-      target_ar=$ar
-      target_as=$as
-      target_ld=$ld
-      target_nm=$nm
-      target_objcopy=$objcopy
-      target_ranlib=$ranlib
-      target_strip=$strip
-      ;;
-    cross)
-      target_cc=
-      if eval test -n "\"\${cross_cc_$target_arch}\""; then
-        if eval has "\"\${cross_cc_$target_arch}\""; then
-          eval "target_cc=\"\${cross_cc_$target_arch}\""
-        fi
-      else
-        compute_target_variable $target_arch target_cc gcc
-      fi
-      target_ccas=$target_cc
-      compute_target_variable $target_arch target_ar ar
-      compute_target_variable $target_arch target_as as
-      compute_target_variable $target_arch target_ld ld
-      compute_target_variable $target_arch target_nm nm
-      compute_target_variable $target_arch target_objcopy objcopy
-      compute_target_variable $target_arch target_ranlib ranlib
-      compute_target_variable $target_arch target_strip strip
-      ;;
-    esac
-
-    if test -n "$target_cc"; then
-      case $target_arch in
-        i386|x86_64)
-          if $target_cc --version | grep -qi "clang"; then
-            continue
-          fi
-          ;;
-      esac
-    elif test -n "$target_as" && test -n "$target_ld"; then
-      # Special handling for assembler only targets
-      case $target in
-        tricore-softmmu)
-          build_static=
-          got_cross_cc=yes
-          break
-          ;;
-        *)
-          continue
-          ;;
-      esac
-    else
-      continue
-    fi
-
-    write_c_skeleton
-    case $1 in
-      *-softmmu)
-        if do_compiler "$target_cc" $target_cflags -o $TMPO -c $TMPC &&
-          do_compiler "$target_cc" $target_cflags -r -nostdlib -o "${TMPDIR1}/${TMPB}2.o" "$TMPO" -lgcc; then
-          got_cross_cc=yes
-          break
-        fi
-        ;;
-      *)
-        if do_compiler "$target_cc" $target_cflags -o $TMPE $TMPC -static ; then
-          build_static=y
-          got_cross_cc=yes
-          break
-        fi
-        if do_compiler "$target_cc" $target_cflags -o $TMPE $TMPC ; then
-          build_static=
-          got_cross_cc=yes
-          break
-        fi
-        ;;
-    esac
-  done
-  if test $got_cross_cc != yes; then
-    build_static=
-    target_cc=
-    target_ccas=
-    target_ar=
-    target_as=
-    target_ld=
-    target_nm=
-    target_objcopy=
-    target_ranlib=
-    target_strip=
-  fi
-  test -n "$target_cc"
-}
-
-write_target_makefile() {
-  echo "PYTHON=$python"
-  echo "EXTRA_CFLAGS=$target_cflags"
-  if test -z "$target_cc" && test -z "$target_as"; then
-    test -z "$container_image" && error_exit "Internal error: could not find cross compiler for $1?"
-    echo "$1: docker-image-$container_image" >> Makefile.prereqs
-    if test -n "$container_cross_cc"; then
-      echo "CC=$docker_py cc --cc $container_cross_cc -i qemu/$container_image -s $source_path --"
-      echo "CCAS=$docker_py cc --cc $container_cross_cc -i qemu/$container_image -s $source_path --"
-    fi
-    echo "AR=$docker_py cc --cc $container_cross_ar -i qemu/$container_image -s $source_path --"
-    echo "AS=$docker_py cc --cc $container_cross_as -i qemu/$container_image -s $source_path --"
-    echo "LD=$docker_py cc --cc $container_cross_ld -i qemu/$container_image -s $source_path --"
-    echo "NM=$docker_py cc --cc $container_cross_nm -i qemu/$container_image -s $source_path --"
-    echo "OBJCOPY=$docker_py cc --cc $container_cross_objcopy -i qemu/$container_image -s $source_path --"
-    echo "RANLIB=$docker_py cc --cc $container_cross_ranlib -i qemu/$container_image -s $source_path --"
-    echo "STRIP=$docker_py cc --cc $container_cross_strip -i qemu/$container_image -s $source_path --"
-  else
-    if test -n "$target_cc"; then
-      echo "CC=$target_cc"
-      echo "CCAS=$target_ccas"
-    fi
-    if test -n "$target_ar"; then
-      echo "AR=$target_ar"
-    fi
-    if test -n "$target_as"; then
-      echo "AS=$target_as"
-    fi
-    if test -n "$target_ld"; then
-      echo "LD=$target_ld"
-    fi
-    if test -n "$target_nm"; then
-      echo "NM=$target_nm"
-    fi
-    if test -n "$target_objcopy"; then
-      echo "OBJCOPY=$target_objcopy"
-    fi
-    if test -n "$target_ranlib"; then
-      echo "RANLIB=$target_ranlib"
-    fi
-    if test -n "$target_strip"; then
-      echo "STRIP=$target_strip"
-    fi
-  fi
-}
-
 #######################################
 # cross-compiled firmware targets
 
@@ -1681,48 +1309,6 @@ fi
 
 echo "# Automatically generated by configure - do not modify" > Makefile.prereqs
 
-# Mac OS X ships with a broken assembler
-if have_target i386-softmmu x86_64-softmmu && \
-        test "$host_os" != "darwin" && test "$host_os" != "sunos" && \
-        test "$host_os" != "haiku" && \
-        probe_target_compiler i386-softmmu; then
-    subdirs="$subdirs pc-bios/optionrom"
-    config_mak=pc-bios/optionrom/config.mak
-    echo "# Automatically generated by configure - do not modify" > $config_mak
-    echo "TOPSRC_DIR=$source_path" >> $config_mak
-    write_target_makefile >> $config_mak
-fi
-
-if have_target ppc-softmmu ppc64-softmmu && \
-        probe_target_compiler ppc-softmmu; then
-    subdirs="$subdirs pc-bios/vof"
-    config_mak=pc-bios/vof/config.mak
-    echo "# Automatically generated by configure - do not modify" > $config_mak
-    echo "SRC_DIR=$source_path/pc-bios/vof" >> $config_mak
-    write_target_makefile >> $config_mak
-fi
-
-# Only build s390-ccw bios if the compiler has -march=z900 or -march=z10
-# (which is the lowest architecture level that Clang supports)
-if have_target s390x-softmmu && probe_target_compiler s390x-softmmu && \
-    GIT=git "$source_path/scripts/git-submodule.sh" "$git_submodules_action" roms/SLOF >> config.log 2>&1; then
-  write_c_skeleton
-  do_compiler "$target_cc" $target_cc_cflags -march=z900 -o $TMPO -c $TMPC
-  has_z900=$?
-  if [ $has_z900 = 0 ] || do_compiler "$target_cc" $target_cc_cflags -march=z10 -msoft-float -Werror -o $TMPO -c $TMPC; then
-    if [ $has_z900 != 0 ]; then
-      echo "WARNING: Your compiler does not support the z900!"
-      echo "         The s390-ccw bios will only work with guest CPUs >= z10."
-    fi
-    subdirs="$subdirs pc-bios/s390-ccw"
-    config_mak=pc-bios/s390-ccw/config-host.mak
-    echo "# Automatically generated by configure - do not modify" > $config_mak
-    echo "SRC_PATH=$source_path/pc-bios/s390-ccw" >> $config_mak
-    echo "GIT_SUBMODULES_ACTION=$git_submodules_action" >> $config_mak
-    write_target_makefile >> $config_mak
-  fi
-fi
-
 #######################################
 # generate config-host.mak
 
@@ -1763,65 +1349,6 @@ if test "$plugins" = "yes" ; then
 fi
 echo "PYTHON=$python" >> tests/tcg/$config_host_mak
 
-tcg_tests_with_compilers=
-for target in $target_list; do
-  arch=${target%%-*}
-
-  case $target in
-    xtensa*-linux-user)
-      # the toolchain is not complete with headers, only build system tests
-      continue
-      ;;
-    *-softmmu)
-      test -f "$source_path/tests/tcg/$arch/Makefile.softmmu-target" || continue
-      qemu="qemu-system-$arch"
-      ;;
-    *-linux-user|*-bsd-user)
-      qemu="qemu-$arch"
-      ;;
-  esac
-
-  if probe_target_compiler $target || test -n "$container_image"; then
-      test -n "$container_image" && build_static=y
-      mkdir -p "tests/tcg/$target"
-      config_target_mak=tests/tcg/$target/config-target.mak
-      ln -sf "$source_path/tests/tcg/Makefile.target" "tests/tcg/$target/Makefile"
-      echo "# Automatically generated by configure - do not modify" > "$config_target_mak"
-      echo "TARGET_NAME=$arch" >> "$config_target_mak"
-      echo "TARGET=$target" >> "$config_target_mak"
-      write_target_makefile "build-tcg-tests-$target" >> "$config_target_mak"
-      echo "BUILD_STATIC=$build_static" >> "$config_target_mak"
-      echo "QEMU=$PWD/$qemu" >> "$config_target_mak"
-
-      # will GDB work with these binaries?
-      if test "${gdb_arches#*$arch}" != "$gdb_arches"; then
-          echo "GDB=$gdb_bin" >> $config_target_mak
-      fi
-
-      if test "${gdb_arches#*$arch}" != "$gdb_arches" && version_ge $gdb_version 14.1; then
-          echo "GDB_HAS_SME_TILES=y" >> $config_target_mak
-      else
-          echo "GDB_HAS_SME_TILES=n" >> $config_target_mak
-      fi
-
-      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 15.1; then
-          echo "GDB_HAS_MTE=y" >> $config_target_mak
-      fi
-
-      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 16.0; then
-          # GDB has to support MTE in baremetal to allow debugging MTE in QEMU system mode
-          echo "GDB_SUPPORTS_MTE_IN_BAREMETAL=y" >> $config_target_mak
-      fi
-
-      echo "run-tcg-tests-$target: $qemu\$(EXESUF)" >> Makefile.prereqs
-      tcg_tests_with_compilers="$tcg_tests_with_compilers $target"
-  fi
-done
-
-if test "$tcg" = "enabled"; then
-    echo "TCG_TESTS_WITH_COMPILERS=$tcg_tests_with_compilers" >> $config_host_mak
-fi
-
 if test "$skip_meson" = no; then
   cross="config-meson.cross.new"
   meson_quote() {
diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index c6821a36d99..9b5e3b6ccda 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -1010,25 +1010,9 @@ simple as::
 
   apt install gcc-aarch64-linux-gnu
 
-The configure script will automatically pick up their presence.
-Sometimes compilers have slightly odd names so the availability of
-them can be prompted by passing in the appropriate configure option
-for the architecture in question, for example::
-
-  $(configure) --cross-cc-aarch64=aarch64-cc
-
-There is also a ``--cross-cc-cflags-ARCH`` flag in case additional
-compiler flags are needed to build for a given target.
-
-If you have the ability to run containers as the user the build system
-will automatically use them where no system compiler is available. For
-architectures where we also support building QEMU we will generally
-use the same container to build tests. However there are a number of
-additional containers defined that have a minimal cross-build
-environment that is only suitable for building test cases. Sometimes
-we may use a bleeding edge distribution for compiler features needed
-for test cases that aren't yet in the LTS distros we support for QEMU
-itself.
+Meson will automatically pick up their presence. In case a cross compiler is
+missing, if podman or docker are available, we'll automatically build
+images containing cross compilers and execute those.
 
 See :ref:`container-ref` for more details.
 
-- 
2.47.3


