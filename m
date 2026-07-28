Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC92C54F53
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZp9-0007xd-3D; Tue, 28 Jul 2026 00:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZoY-0006db-0R
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:53:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZoR-0002au-Pt
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:53:10 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3bA7G1062923
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MJ5YUugwXVi
 0xxjZA+savS2mzOFFsB9Ag0bWMONZGxA=; b=Svwzk5x1oYEAQjP9Xn5bjMiADde
 TGpmRS+J1iXS5ygZKa+lc2Xb8eyhrur7tgYAlWUu5L0I5Lhv3XALvnylXmZi//ua
 evi7x2NZNwcIOLBbVB522lqoPA/u6X4um3jdVT578ksIGziG9DGZgb0SWIu/+VhH
 vpLliJzZbhejL6F8p83UEgakyQp9nA0QzONDdOXwLTP/V99BrM0EttjQKtFCHDGw
 Mu86OKG7ItvtMUEO8mSmOISqnobgDwmEUzckdm3UNCb3NLCg1ixSTFpm3+l2N6sK
 2Wa4NUeZy2jEomMiNdXSiMoKqU2z4Vhq4F60DR+RxKw+CuqTtWxdh8LvWfg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4v6chu3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:56 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb835525b13so3893527a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214376; x=1785819176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MJ5YUugwXVi0xxjZA+savS2mzOFFsB9Ag0bWMONZGxA=;
 b=avo7X4RrplTOpThws9DbDuKvBe5urEzKuqoc1ccTsKXB2SVS8RydrGVFdq+WHGeqb4
 yQO5vV7PyVoEwhWahvS+Jyo3I7r+UggYkuAekb7R2E/Z0pjFRXyiY7NmVzbC8ndGoWue
 nUDDhV3KMXNKflfMCizliiXvuOPFglNsGcKVvs16DbeYf5j2pA6DI4Ki7yZ3s44P21Rb
 S7TBOrnm63dEPjiOWPO/GAYNEM++jpzQG6ZsROqATmS5xq05iZfoyMayfklENENOn+g1
 ib8L4L62ZNHKavzxen5c0aYLJRKz3Dwvt6acKTfZAhoulVfhvppo2JcdGQHm+68BmGk/
 9BzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214376; x=1785819176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MJ5YUugwXVi0xxjZA+savS2mzOFFsB9Ag0bWMONZGxA=;
 b=aU4YAtyaAOV98x2ygm+XiDLh29pi5ERkYqe4RrOZOhnEZhCikSU3ITTSqT5zTRY+TI
 jt0xM7fqqWNBIG5zxdoxVk2gBfoVV/gPFskqwtVwuTObjFLEjmrY3+thfwJKxXJjbmna
 Q+LN4Mwjoal0hlsBFuX0IT7pkBhwQ5RWlHDTnmy/8OhYoU72Mj/w9LVyamr8oLkFCkWj
 fdfZgbnJ/KFBu3VX6gknj4GMOkT3TG6cKn18TY5ve+Umw/DMx8nl9QhzHuJCnA3koqwV
 l5w8iKTBh72QHeE+YXetTO/7Wh5l4S0RWZehgyPy57LHglMXgFFjjTPeQ3MKn3S766rm
 Vo5Q==
X-Gm-Message-State: AOJu0YyM4X8Ed30yLoWuscQKzhqC6f4XbLLCHH6w68ezaYe1E6gWgLmq
 3sxfRgZ9ki22QK6i3hGKJ9TB/k3d282Qs8tztu77ZzHeodXOeL7ZzMdRxhX/GfNm0jeuGohggDn
 mVdbmXDB4DY8MRKToOtl3TXHO/auJ0Fp5jeFnl5w7Pgc6kV0nnn5Fq1NpmQmxXtnN9A==
X-Gm-Gg: AR+sD10reAGBFmbWtP7fM5lZ5b8GlXfVShgCQ26ORZ+lD+ql7eIJlM3HdzHQjYShcFa
 NvWA4wwfWD+SdXouUggeYtFqSL2Ih/oC0Y/+fEEJ0pbnFQ2jN8qERYeq2VYdGXt0e8FrPnjWQBf
 4OQ8nYv8bKp4XpF4p8kShgOHARxnTy76ZtVeDbWw4wlj02RRcXtKuD1cGSraAp5NtKeb/glPr7D
 L6eWyW/SQ+LGQE/bBKknnN4Kag2dTAFP6oAHLfTj5iu7aoRMqDFGnkFmtcfgR8IYn6SAQJ+Mrfs
 h5xwhj+BDguav8VxqbOuZIS55iKxK+sDftddDFzvSd4FtwoyJAdxiPSA1RqYvkLTakahbNbpThN
 8yWdj0xU+Ziix1t0MdXs23ZvWBhGDSv1WpBlaCWce49U7GhSCYS3nFlEL7teLJxf+Qp1nMJQ=
X-Received: by 2002:a05:6a21:7a8c:b0:3c0:9c19:65c0 with SMTP id
 adf61e73a8af0-3c8ba63bee8mr1117023637.72.1785214375486; 
 Mon, 27 Jul 2026 21:52:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:7a8c:b0:3c0:9c19:65c0 with SMTP id
 adf61e73a8af0-3c8ba63bee8mr1116992637.72.1785214374954; 
 Mon, 27 Jul 2026 21:52:54 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38900559eec.3.2026.07.27.21.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:52:54 -0700 (PDT)
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
Subject: [PATCH v6 101/103] configure: remove cross_cc and gdb detection logic
Date: Mon, 27 Jul 2026 21:42:45 -0700
Message-ID: <20260728044248.137626-102-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX3rYIZrUMDr9W
 LXZLGQclTzA2EwEP0eIcIh06pj8Xg0nqMhYmQCc19fSpTRPMJFjjbZMym42Q7WkDGXne9QcGmtX
 2MZTtp1seq5w0iveGcCUN4iSyi4oQWs=
X-Proofpoint-GUID: qZDEJXNYZy9kY5yhiCXuZSe0gE43wt1e
X-Authority-Analysis: v=2.4 cv=ev3vCIpX c=1 sm=1 tr=0 ts=6a6835a8 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=cXAFiX7rnl1kKfiNz_YA:9 a=bFCP_H2QrGi7Okbo017w:22 a=7vFJDdfgT2TS9Y98Jybz:22
X-Proofpoint-ORIG-GUID: qZDEJXNYZy9kY5yhiCXuZSe0gE43wt1e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX70mFYxHmDqqZ
 aFABKSCia5D+NNnaE5QyVAYRlBbM3ORgx+mVSDMBLXefUNoU9S8nfDbA/usmqFU5EZGow4RrPsW
 3DxaiZuufwj/KjUa/yZIkMg6wZF3ccErYW/xMJ9kKO0rOWzwo9wuuTvyUT1gQW4TSWHKz9n2BP+
 Cfo1KKZz+6Qxdauf4BvJZOZJBEi/ITGOGxJw+6Sby6TkgGaOVAGZPlUIoXDAZHCZ763glsrFQw5
 zkmTpHN/MNeRGrbp65QSmLKhkMHu0RmzqavV0izPQAaePsI+X3HQsw1SMRFNk2ho+ZEanzIvZCT
 azF+NmXLaFYht6sGRwpsvh3Kz4hjOc4T3Vh7MeFJkKJewyy59hqHqRLjfnBVEopxHSBfq0T1aNJ
 72IbEbWIHohv0OeDHQl4GO7GMoNFaYmnuS8qmr3z46xpKVmQEI6f1vpMTEtR+unQq2pU1ShAUnb
 x9kPSTFqKNIiyoXnPwg==
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

We have now implemented the same in meson directly, so no need to keep
it on configure side. Also, we have no more Makefile consumers, so we
don't need to export all those variables anymore.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 configure | 461 ------------------------------------------------------
 1 file changed, 461 deletions(-)

diff --git a/configure b/configure
index c9e2cdcce5f..7798d02a9e1 100755
--- a/configure
+++ b/configure
@@ -1267,366 +1267,6 @@ EOF
   fi
 fi
 
-##########################################
-# functions to probe cross compilers
-
-if test "$container_command" = ""; then
-    container_command=$($python "$source_path"/tests/docker/docker.py probe)
-    test "$container_command" = "no" && container_command=""
-fi
-if test $use_containers = "yes" && test "$container_command" != ""; then
-    docker_py="$python $source_path/tests/docker/docker.py --command $container_command"
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
-    test "$container_command" != "" || continue
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
 
@@ -1660,48 +1300,6 @@ fi
 
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
 
@@ -1728,65 +1326,6 @@ if test "$default_targets" = "yes"; then
   echo "CONFIG_DEFAULT_TARGETS=y" >> $config_host_mak
 fi
 
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
-- 
2.47.3


