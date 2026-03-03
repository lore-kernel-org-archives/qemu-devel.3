Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B37EB362F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 17:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxTxQ-00088X-E9; Tue, 03 Mar 2026 12:54:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vxTxP-00088N-7Z
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:54:55 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vxTxM-0005Jb-DH
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:54:54 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623H0flg4030535
 for <qemu-devel@nongnu.org>; Tue, 3 Mar 2026 17:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=auGzKh1OgnQZBxnWC8H0Xl
 +BHDKLB7nuILop82d2b1g=; b=Ox/yfFbb8SZ0kK37TYOuzT0amZ/pm1Yr1KRBBa
 81nyxYRtJgRp0+dvct5DpmkedzPdu5zH4IepTZuBUJYasaYzZNsCEcNH3lRpd5Hs
 VbHxR7RaBmDCnlki6h9DdA4+8RHmGCznTRQUcprELCkvIH3vI9K0xi0zbFrkxhQ6
 bxbDVjG8tDO0S1UeP+fEl80iOw0WAXYurfwDEQFGFt/ReuRH0+uv5KnsRLRwyJzn
 ios3IhXiSScPC8HPzslTeP29kRdFe2v999YRMopRM2UPc24KNQn+YcApLyh1T4Aw
 9YDqCNBj/k7gueaMNRAKKsJBynhsUAQ0Si3n7l+Zqcf8Y8bg==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnuqu1xgm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 17:54:50 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-463a1cee56aso58367602b6e.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 09:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772560489; x=1773165289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=auGzKh1OgnQZBxnWC8H0Xl+BHDKLB7nuILop82d2b1g=;
 b=ROSfZ/Tyu857ngAsmY4Bi606Yyti9SUG8ChCkszOv/1zWLnEnmISwlEb9Gh5cs+qgh
 QOOp4Mm1nH3WUkZWOVgvJSos9ho2lBNaPFD78DTVFk9DskG1P01q8qdnUYGojDcibC7z
 QUaa99i0/gDyrcDLqM7rJJbZX5yXInncveQiVTsvwj9UE3wy4h8XjdcTHbm6gP/ZK+jK
 N35PBGXtP91YMpZ8KSQ+7TTi+HvCL7QRK57y/ZfEvodouanzdIljhLxoDr+yf8Gg3AdJ
 92y4TxR7oQrqWTMaQMuglHPBgAa4NwU8nGIG7j98KZZH6MzaRZPu5LmoQtPaOcMFem+b
 oyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772560489; x=1773165289;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=auGzKh1OgnQZBxnWC8H0Xl+BHDKLB7nuILop82d2b1g=;
 b=Qqq+bJEQPJR5C3xnrzZyVRZMgfDQoXGw+APamb0NE02Glg3rs82C+pCnpdWWZdCVcX
 g5iurOVlY8VS+WIZ4HFcsDK/TjKYMQbvrdTOdOTLGXhVbdfnn6Hce0QZI7Lse4iDP5TI
 9Xo+1cm50bK9qoSaGZKk8X5I0xf4RLpv+Z6O/xBfxO5pWF1mUTTNN3pObaVEBDAat21x
 KGxUez+TtmhvEO5mLfanHWY1ONanfAqwIoAu1gK3bkY+bp/q/b+KyBsKD0atVqyKoIfb
 qjp1ywAoQnLFsI4EBZ8R6vxx+1LortbDo4BnG3bND3ZxPlHIxwh/4fzLa09qCrTDXqaR
 Rpgw==
X-Gm-Message-State: AOJu0Yyb3SmuWNdP/syRzIEepPASR8nIUHHGvKeNJfk/0GQIvjQNOjwb
 M6JF5jQHYfoCHlhtDetlSn9bcEncNXJr9/ZofnB9tJhqEHCDwkumzTZAFalJxr3+RfIjYWnRPsg
 omXVbovorUyA2Et2jV3KeNuFGtoJU8FlxgiyTCTdhcp8zwbyHWlajGmHv+ar7KbRrmg==
X-Gm-Gg: ATEYQzzHZFUgQsxew+7jU50b9zNry/pFtoQopfn0ccHlYJd5rX2m9/tV4D7aYMo00Jr
 fVNP6Uto2Y5KvYcHRi2Hyig/WleyHkJr4Ry3irF9NHWs3ADhuJzxOGOtRIZf959ku4YQjrZxpIn
 9fVvXoefOyy2taqFb6sSI0R0yDi27uIQKGoR8Lr2397VXEOF+b9LdBR4GNJl4fK1SCXCPrW/FOP
 KVXwzAS1MyKPkL0Is8ORpQ3UeafCqH8FKwIxYBTGw4LRT3Y5cPehb73wmt+dN7LSXVLHa45nsbF
 I2eRaVBYwgtrtjUn4aIBKfeCopW4jc5nUNFTGqxntSw2SpSllyXvXMHiJsUWY/f/dQhghx8+vNm
 JS3FAzQ297/3ZsNh/5lrRQnjsyBlIKeekN7rqAjPIcgXcGpn4FqER32oITX5CZDSZfZo4Cg==
X-Received: by 2002:a05:6808:2205:b0:45f:1b74:2192 with SMTP id
 5614622812f47-464bea41373mr10666953b6e.10.1772560489558; 
 Tue, 03 Mar 2026 09:54:49 -0800 (PST)
X-Received: by 2002:a05:6808:2205:b0:45f:1b74:2192 with SMTP id
 5614622812f47-464bea41373mr10666920b6e.10.1772560489081; 
 Tue, 03 Mar 2026 09:54:49 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb59b656sm9621444b6e.12.2026.03.03.09.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 09:54:48 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v2] tests/docker: Update hexagon cross toolchain to 22.1.0
Date: Tue,  3 Mar 2026 09:54:44 -0800
Message-Id: <20260303175444.1540049-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=M85A6iws c=1 sm=1 tr=0 ts=69a7206a cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=ovJmrJClAAAA:8 a=qC_FGOx9AAAA:8 a=EUspDBNiAAAA:8 a=-sABcnEt6TUt-BKrMGoA:9
 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22 a=brTEhlvMp4NY0_u118I2:22
 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-GUID: CtybIaTK1neCcNW9UqE7wMbZHxqGUwXA
X-Proofpoint-ORIG-GUID: CtybIaTK1neCcNW9UqE7wMbZHxqGUwXA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE0NCBTYWx0ZWRfX40akdGrtoAtZ
 fs0Qg5mSWk26nX2EdWGIbMQZx+M11beX4VZdaJ+q/pB2X7XJotvz1KJ5ECHP2UFBGeW2bnKBFfQ
 am+n5oWtgYrBEXDt6WeBAp6qg3+onwvoEDdeGFmHJFuuscO4kq1twlHS9yqI/zXAM6yrpjLJlpn
 cy/Iov1fLMzlQJ53WY/H8F+bKaWxc26Xg6Cg8h316GY3C/hElghLVVhhBLCFKB9wbygqOoAfzRm
 b7pOEQg7rxWJtKFqkTZaqb4n/tlOpZEzzDb1xNPWcpsasOQ0AJ9FHD4iNU7zVR6x6HTMcX1KLip
 hLyLvz2SNwcW45LteRmIh+mavoQX1SI/TZBBN/fa0XN8vcBeMg16LXKAD9CYxZq/0tj3iPLdtMU
 1k79nDCLwpV16dXGCro+aBoJMyuZtAtFBWnL4/Ow3ZL+6hNtfsbsAQkJWz+Qhe7DhNA33zyvJsX
 x521PUqYGZX6AhIT0CA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603030144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Update the hexagon cross-compiler Docker container to use toolchain
version 22.1.0, replacing the previous 12.Dec.2023 release.  This release
has valuable compiler and linker bugfixes, but more importantly it will
enable us to target DSP arches up to v81.

This requires upgrading the base image from Debian 11 to Debian 12
because the new toolchain needs glibc >= 2.34. Additional changes
to accommodate the new base image and toolchain:

* Use DEB822 format for enabling deb-src
* Add libc++1, libc++abi1, libunwind-14 runtime deps for the new
toolchain
* Add zstd for the new .tar.zst archive format
* Replace pip3 install tomli with python3-tomli system package
(Debian 12 enforces PEP 668)

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 .../dockerfiles/debian-hexagon-cross.docker   | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
index 23152b4918..00d7834506 100644
--- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
+++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
@@ -5,10 +5,10 @@
 # needs to be able to build QEMU itself in CI we include its
 # build-deps.
 #
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:12-slim
 
-# Duplicate deb line as deb-src
-RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
+# Enable deb-src for build-dep support
+RUN sed -i 's/^Types: deb$/Types: deb deb-src/' /etc/apt/sources.list.d/debian.sources
 RUN apt-get update && \
     DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
@@ -17,7 +17,11 @@ RUN apt-get update && \
         curl \
         ccache \
         xz-utils \
+        zstd \
         ca-certificates \
+        libc++1 \
+        libc++abi1 \
+        libunwind-14 \
         bison \
         flex \
         git \
@@ -25,6 +29,7 @@ RUN apt-get update && \
         python3-pip \
         python3-setuptools \
         python3-venv \
+        python3-tomli \
         python3-wheel && \
 # Install QEMU build deps for use in CI
     DEBIAN_FRONTEND=noninteractive eatmydata \
@@ -36,15 +41,13 @@ RUN apt-get update && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
-RUN /usr/bin/pip3 install tomli
-
 ENV TOOLCHAIN_INSTALL /opt
-ENV TOOLCHAIN_RELEASE 12.Dec.2023
+ENV TOOLCHAIN_RELEASE 22.1.0
 ENV TOOLCHAIN_BASENAME "clang+llvm-${TOOLCHAIN_RELEASE}-cross-hexagon-unknown-linux-musl"
-ENV TOOLCHAIN_URL https://codelinaro.jfrog.io/artifactory/codelinaro-toolchain-for-hexagon/${TOOLCHAIN_RELEASE}/${TOOLCHAIN_BASENAME}.tar.xz
+ENV TOOLCHAIN_URL https://artifacts.codelinaro.org/artifactory/codelinaro-toolchain-for-hexagon/${TOOLCHAIN_RELEASE}_/${TOOLCHAIN_BASENAME}.tar.zst
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 
-RUN curl -#SL "$TOOLCHAIN_URL" | tar -xJC "$TOOLCHAIN_INSTALL"
+RUN curl -#SL "$TOOLCHAIN_URL" | tar --zstd -xC "$TOOLCHAIN_INSTALL"
 ENV PATH $PATH:${TOOLCHAIN_INSTALL}/${TOOLCHAIN_BASENAME}/x86_64-linux-gnu/bin
 ENV MAKE /usr/bin/make
 # As a final step configure the user (if env is defined)
-- 
2.34.1


