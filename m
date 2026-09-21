Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA339C982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 23:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8nEG-0008Fb-PL; Mon, 21 Sep 2026 19:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8nEC-0008BI-Kr
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 19:15:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8nEA-0000F7-DU
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 19:15:16 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LN1VPd1860225
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 23:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5AaSYw0sk2r
 iyBiy5B36JpmZ2l1fHfHw2drO1xDtHDw=; b=GSrG6ugOzqLw3HqiQXnyInLLCsI
 3Ot99maozlmTO/gSSNcsCOCwU0hdrGYijWRBZ3ZKrOiH1E38sZtFenO4cid7R01y
 uhEKMcmkjFDtHrvOU2HliN6fkhIyicwwRUA07teU5StEwLIHpxjCD6rQR9powLqo
 Ie5nUhojAp4FEGt8OksxyQBLNX2Z3fafGl4ynLdhLFo3MSXJI7CqRQ9yZWI9Bc5k
 0+4kf1SGI0Wj1/nHcB0FL1f0BdOq0OKdxhyVbKq2eA8MqtcIvqRD6DYFR+xijqFV
 Q4KrN12dzijgfLh2gJVQfAt2EniIpF7X3vi2FxpW+ecXNkEvKKRdAvZhK1g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gudw0g16a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 23:15:12 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39deb05ef51so5101627a91.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 16:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790032512; x=1790637312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5AaSYw0sk2riyBiy5B36JpmZ2l1fHfHw2drO1xDtHDw=;
 b=hc5Y/KBULqe74peQSXRjCH2ZniJL8G5+QLQspbExqEIMwrT9OSx8WbzWcYHCv3epAW
 hVCxZer/pWLvuBoac8cFTKuI5YLdKxkjzSiOLOeAvpMEJt7w/rN2PUlFqaRVibjxU93t
 rU/PlfmtfVFOp/tx3RT93p/PJAHDAhVRCVbZ7QvSYMD42LLEJXqCpm7YtpQMiGJnOCrb
 dyB/ula7FTsnuUuEdKvE5fVitFFKj382E0GhubumCheD6rn0ubw8KWqlxu+11pItKnII
 VkGxm+VtzpVhiDtqpy6nkfTPYiqETbTFZf8uW/C5skq6xaKkvvN5NTC5nmcxKQgabhql
 kc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790032512; x=1790637312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5AaSYw0sk2riyBiy5B36JpmZ2l1fHfHw2drO1xDtHDw=;
 b=ds9NJgxmnXxYoXytdbKA4oJPxE3ItPzSCCG3fSHwlCiAmGJ9bEIVxtv2nplEnfwO1X
 l8nXO3q2xNS44hKQ/vEB/GofrRJ7DE8+A0zjr3SLiS2U3NTwc59WvVzBeEnSqlWBOkYl
 1AgiTuIe4hUD3L4+GFOGt1N18TCtYhVdBy1zkosNyhaxlLGp4H2rgOKKiC+Orpo26apH
 wmUHR8Sihe205XgOC/IjkXl6c8u+3c9Ut8/Hk8+u2PNIjMFV0q+zuGLsO1TZKNtIy/Yu
 e/Vnq1YW8L11+imnHysAaIPWeGf6IgomCO0RSQ/ieHOQZAUdYWHRB+q681EyEq0DsGrx
 BNnA==
X-Gm-Message-State: AFuF++k8rMyaOHKrdWJkmyIXMshGJrodhJ1zsrOEOPJudaL5YqcRTv8a
 O79Gb2Mv2etAjzcDBOm5Iej7pAVP9GbkGH2lB7S8GdoECM+o0M2E6J3mg0s22phQwF7oy4o+zGT
 ASSRju0FjVL0pbDfmyGtR+wxABG3fxpu0pHriutqo0VagzhlD3V6/fObX820IauZwyg==
X-Gm-Gg: AYBFou2OZ8/gX60s8b0T5kybuGS/B8vxmJ1tjhW1ZKlwYNpUieIGY8FcP57L5gWRuMV
 9RZ/KPkjstwMs7e8TkclvbtRWWvP5is93BLrz24VvdxrhBMR25lmpnfruglIZzpFJgQmFeKCj17
 5/eVZoZNKfenR7lCj9lFxoPh/m1vICXv9nW2lRgXOx1L/9ZCrtCogQNB43K2CAHb/f49+qbQ7cX
 p3l/YEEDONGKCIsS/BzB4WIXXRomWQpqTegt1pB5xSqxfhnWYM54rb+9z0eij/EVwI45di4yHan
 AVtn6M3T1RqTnyo0BCUiTd/lgf2hBR4xrOKa/ryK0OVyio2e7SyRVBeF1/iesvWgE0bclGz5YEV
 mZnogHrlNZU1mvopy3tjltbwJOenevl1TMv8MupeGFT/VDHK3vIweIa27gf32uw==
X-Received: by 2002:a17:90b:2b8e:b0:39d:efa9:cd25 with SMTP id
 98e67ed59e1d1-39e54c59c74mr24129679a91.2.1790032512234; 
 Mon, 21 Sep 2026 16:15:12 -0700 (PDT)
X-Received: by 2002:a17:90b:2b8e:b0:39d:efa9:cd25 with SMTP id
 98e67ed59e1d1-39e54c59c74mr24129656a91.2.1790032511703; 
 Mon, 21 Sep 2026 16:15:11 -0700 (PDT)
Received: from localhost.localdomain (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0674c0b4bsm1295939a91.13.2026.09.21.16.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 16:15:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 4/7] tests/docker/dockerfiles: use docker.io/amd64 for
 tcg-tests containers
Date: Mon, 21 Sep 2026 23:14:55 +0000
Message-ID: <20260921231458.3369-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YOEpjda2VbC_4_BgyUPrLOk-DTfDpM3J
X-Proofpoint-GUID: YOEpjda2VbC_4_BgyUPrLOk-DTfDpM3J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDM0MCBTYWx0ZWRfX0XWtSi8l3CJn
 h7RBEz4er93xsmV9Mz4vNzfqjF8y0cEf8Tmb48FHideU9V6rK0ln+zhyqepq1e4Kxw6A9s03od8
 tvN2Qm/btKbtm+y8weynnHcWGgvYviajewbysny4elWT75AaSBcoahlxodmX0U59FJHaSyxkm9o
 nEX8SU2Cf43dQCDCv4YR+JQUCALqFpNU2vvVrt2U7c/65ZkVh0rRX20H7auJQY2OoUuCKZWHupk
 8bneiWSUvofgpJSReL+frug4j7y3fhILWB+fHddf/n8P2bk6h9xOE4ClpiOl1gH7c/PPcMsiXtP
 lEJtAUWtJqWWDlouHbdK0Z7UxHXYIJgIh3SL+19qraJxKOGSdoNG322FExQTGDL7fw00QA7baRW
 Gy8u/xLrVVRcJoLVfE5I45QXWYFqwfivHz89+dMhC9KT6WuFD50DL/GbtbJCnVc+FhDIlj2xyom
 O6PDDBYcTLcWlFJww0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDM0MCBTYWx0ZWRfX+5GnTAPeI71D
 wkZDEotlzIKFnyXwawds0K6u7YLM7r69HHr1KLj/cPWtakBsvlIa417v3vMq/PLeLanke/PFxhU
 uptnxXHzkPcR2mUsJYoBXQ/f4i6Y200=
X-Authority-Analysis: v=2.4 cv=TvFzFzXh c=1 sm=1 tr=0 ts=6ab1ba81 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=p0WdMEafAAAA:8
 a=tz06iiwTAAAA:20 a=YbdBfhNLAAAA:20 a=EUspDBNiAAAA:8 a=wXiljuQ5oshl5nk-mfAA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210340
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

We now restrict those containers to amd64 variants only.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/debian-all-test-cross.docker  | 2 +-
 tests/docker/dockerfiles/debian-amd64-cross.docker     | 2 +-
 tests/docker/dockerfiles/debian-hexagon-cross.docker   | 2 +-
 tests/docker/dockerfiles/debian-i686-cross.docker      | 2 +-
 tests/docker/dockerfiles/debian-loongarch-cross.docker | 2 +-
 tests/docker/dockerfiles/debian-tricore-cross.docker   | 2 +-
 tests/docker/dockerfiles/debian-xtensa-cross.docker    | 2 +-
 tests/lcitool/refresh                                  | 6 ++++++
 8 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index c0ab05a5ff3..b6aba26c0c8 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -4,7 +4,7 @@
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:13-slim
+FROM docker.io/amd64/debian:13-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 975b9f346e6..728803aeaa1 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -4,7 +4,7 @@
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:13-slim
+FROM docker.io/amd64/debian:13-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
index e07a2be37e2..7753eab9706 100644
--- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
+++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
@@ -5,7 +5,7 @@
 # needs to be able to build QEMU itself in CI we include its
 # build-deps.
 #
-FROM docker.io/library/debian:13-slim
+FROM docker.io/amd64/debian:13-slim
 
 # Add deb-src repository sources
 RUN sed -i "s/^Types: deb$/Types: deb deb-src/" \
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index a60b72e05b9..1b8f9609b2a 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -4,7 +4,7 @@
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:13-slim
+FROM docker.io/amd64/debian:13-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
diff --git a/tests/docker/dockerfiles/debian-loongarch-cross.docker b/tests/docker/dockerfiles/debian-loongarch-cross.docker
index d2ba07972ce..a053486cf3b 100644
--- a/tests/docker/dockerfiles/debian-loongarch-cross.docker
+++ b/tests/docker/dockerfiles/debian-loongarch-cross.docker
@@ -4,7 +4,7 @@
 # This docker target uses prebuilt toolchains for LoongArch64 from:
 # https://github.com/loongson/build-tools/releases
 #
-FROM docker.io/library/debian:13-slim
+FROM docker.io/amd64/debian:13-slim
 
 # Add deb-src repository sources
 RUN sed -i "s/^Types: deb$/Types: deb deb-src/" \
diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
index 9e7ff321677..94273e498b1 100644
--- a/tests/docker/dockerfiles/debian-tricore-cross.docker
+++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
@@ -9,7 +9,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
-FROM docker.io/library/debian:13-slim
+FROM docker.io/amd64/debian:13-slim
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
index 0eb6d98cc75..801768ce11d 100644
--- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
+++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
@@ -5,7 +5,7 @@
 # using a prebuilt toolchains for Xtensa cores from:
 # https://github.com/foss-xtensa/toolchain/releases
 #
-FROM docker.io/library/debian:13-slim
+FROM docker.io/amd64/debian:13-slim
 
 RUN apt-get update && \
     DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 4e3cbb81acf..ceabb9e978a 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -240,6 +240,8 @@ def cross_build(prefix, targets):
 # Please keep each group sorted alphabetically for easy reading.
 #
 
+DOCKER_IO_AMD64 = "docker.io/amd64"
+
 try:
     #
     # Standard native builds
@@ -264,6 +266,7 @@ try:
     # Cross compiling builds
     #
     generate_dockerfile("debian-amd64-cross", "debian-13",
+                        registry_path=DOCKER_IO_AMD64,
                         cross="x86_64",
                         trailer=cross_build("x86_64-linux-gnu-",
                                             "x86_64-softmmu,"
@@ -281,6 +284,7 @@ try:
                                             "arm-softmmu,arm-linux-user"))
 
     generate_dockerfile("debian-i686-cross", "debian-13",
+                        registry_path=DOCKER_IO_AMD64,
                         cross="i686",
                         trailer=cross_build("i686-linux-gnu-",
                                             "i386-softmmu,i386-linux-user"))
@@ -313,10 +317,12 @@ try:
     # tests.
 
     generate_dockerfile("debian-all-test-cross", "debian-13",
+                        registry_path=DOCKER_IO_AMD64,
                         project="qemu-minimal",
                         enable_rust=False,
                         trailer=debian_all_test_cross_compilers)
 
+
     #
     # GitLab packages lists
     #
-- 
2.43.0


