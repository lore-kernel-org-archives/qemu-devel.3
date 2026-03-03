Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA2DEDEBF5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 21:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWwW-0001iu-4l; Tue, 03 Mar 2026 16:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vxWwS-0001ef-Dc
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 16:06:08 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vxWwQ-0006Xy-Oh
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 16:06:08 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623KSpEW4011588
 for <qemu-devel@nongnu.org>; Tue, 3 Mar 2026 21:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FAGsVaaJraqAQ8Pio4Tq8MqVMy+7WeNkrwfUlu3Vc1Y=; b=mI8nRC/IbCOVOZsm
 qjBGkwf8kVJ9UyQxzdvSzvA9bTd713GzL5sNI/UUXYF8+O5fT/XsCWgVRNwtwcy1
 eQ7+vSWZS2Dt20guTkSvvso8oEV2ez+WyLs5Oc0BTH7A+ifAMUOkBWm++CGc99Yu
 FHnvuakjZ6tkpi3Cvhg/+LJqWzAvTm46OhV/IHjLulVhOSFX1HRSBhQI1SPk0Q4n
 gKJg6QpQOEw7Bxvp157PoBewJiLVML/S3uBMTzX2DvTttVd89WEnlOiYh3OuPBpY
 eSfFNjrt+kKfub040S9Xm3JZHViRaLJc+t75KJYktWrOgvBnAnDbrDbhEkc5AUWQ
 EHRlcg==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp6qg8447-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 21:06:05 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-45f0bfd68a3so30392658b6e.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 13:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772571964; x=1773176764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FAGsVaaJraqAQ8Pio4Tq8MqVMy+7WeNkrwfUlu3Vc1Y=;
 b=XKaDVo6r+O2Tobh3kJHaGgNckR64mAwO7bO0ZwKmOPdjPkpDur0cWKG2tiHJynquEE
 nD+S5AP/78n3OetN+GphqfGWJlz0V7b3umbqdMCaCRezXiV8jOB2uiy8r7aoAUb8j7rl
 rDD8mH5LD7V3hqfGVG+HcctVFTIWA1P5L2/Gu8abL0cHR9uIdGo8K3rwYS+2MElZxxsC
 rqTeKZ5swCQ7sfqfRtKbPvOLFObD5ji+6z+U9NPJEcbU1i34jiJoFzx24fD+qVXj6qGT
 Urj+ATd5fRDB1ga2rSAhBC1Q6MGotzjQG7uSXBGogRyP7H41Gm4Ws1JFY18vBTmjRloj
 uWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772571964; x=1773176764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FAGsVaaJraqAQ8Pio4Tq8MqVMy+7WeNkrwfUlu3Vc1Y=;
 b=IPxirtj4TUsVyWYEiVf+FrN8PSWlreQKVDvOTPa6DcboOEJM1JPopgrHq1nab7ODUh
 SxfAUNx9f4T9ibpCMXbCkV7/N1vsZ7iNW8NOqCoqPxsjXkSKvwZAUcwOt62gJgRkoW6/
 i0Vim0eNnme2XvAZhaxp2T3i5r2oKFq6M/JTP1AjuuWeuJauNZsde9i9fFqWj4CANVxS
 BLa176wn64Z02L19Wwm0SRgJvzL7wmXJ1LAr8bE7wBZara4MKHySXa+ET1/HPNHodj4Z
 TgTqdWgwI7awtXIRLTZ/c4hVLFabTmimqeOzNDJVR0iTQc0v51CzvCA44M7L3Pw4e2t3
 ncsQ==
X-Gm-Message-State: AOJu0YyWnVcW5D3QXBoOSGzSUDtlmI3SfICaUhzbGG3GoS9xmzVeIsYK
 w12TpXk3XO76JwOlGpSXHwnyIUcuIyYNAi2JBVHgncJoCdWcMfc0G9woUDyzyCp/5a0ERPB17o1
 IJvxYB/bIgqhU3ALF6LkYPnFS9FHOrPccoKVRW/Zf5PKwNfmop3b+84W+YQEeQVz6MQ==
X-Gm-Gg: ATEYQzwWSpL6uFRxXxOddoZng4/o3VQC5AKBfJR/ch6yfyXlrU9M6kYFGSK972fzc9K
 XWRVqxF1E8PmOExUfby76qmlqSBOjEQaZcLEf4v9PZ4BGJtzwORmy41dCxdeYENNy+vHRtxJUSA
 UJ8dkb8JGbxxMtwH+rRAnHxc2OXtV1gU/IXUZTtUHUE/+de+/VXeUWSbMfKQTmNJXx4l7smzWvt
 79UKPq89muCq3F7Cp6MCV3Au0je77NffdlrkMFGKx51w0Mwk8n3T60uxF/l90DVjAOKabf5TOhd
 GG62+P2si4AdrrnVeD8tFAM7Lv1OQXSt/aj5A/BWdq3gTn1Ico1/IiNFfMT4cUvF0UTh3sr9qyV
 8BEPGVyhbuEERLkV0f9vnLlYl1e19Ah8AeW5L0iNj0mrkQYXfHY0O9L8Ei8ar69zqMrvYGw==
X-Received: by 2002:a05:6808:c3ec:b0:45a:5531:aee4 with SMTP id
 5614622812f47-464bef011fcmr8837885b6e.42.1772571964350; 
 Tue, 03 Mar 2026 13:06:04 -0800 (PST)
X-Received: by 2002:a05:6808:c3ec:b0:45a:5531:aee4 with SMTP id
 5614622812f47-464bef011fcmr8837873b6e.42.1772571963892; 
 Tue, 03 Mar 2026 13:06:03 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb3ab494sm9998617b6e.8.2026.03.03.13.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 13:06:03 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, berrange@redhat.com, alex.bennee@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 1/1] tests/docker: Update hexagon cross toolchain to 22.1.0
Date: Tue,  3 Mar 2026 13:05:53 -0800
Message-Id: <20260303210553.2044313-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303210553.2044313-1-brian.cain@oss.qualcomm.com>
References: <20260303210553.2044313-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE3MyBTYWx0ZWRfX+CUAiHCkfSUr
 DMOs1vudPaWJ9AgyJMRp9tlR3XZfLDCcgcfNwYshw4S1BalsyX9kmAzMPuns2vIhy5ROIs17eDx
 VcHW3tIUR56Ew0o+iaejaGyAY2LZ97aCa6Ob8fDUGiTN0xL69dEhIVL0VBBk1lkmnSxJG8h5LoE
 OhvRwUfblawEE2RCZf9QRgrFzxxv7FLEWw9oSbhWdCrhsD+jmukCV8raptXyIHMkhwKZPbvGgSe
 C1zMW1UtjgqcyieWsU9HKs/sutbAPPgrNXp/rSBubBXPJ+mhzLdCutc4y+2UzCYw9KDiaeewvMw
 LA3s39Gtlm95xzqEwDnE+p/k6OSRaZbR0YNUbJT800ZRqOc/gPWXjN8gFk1Y2C20VbzNRGlyYpr
 FqImDSpCH8qYy1Rpri3esZOnaU2tt7uDUoExXaqxPpKnl72RdyxbdeNCx77sKYHYWklJw3Phid5
 cRyS4qEGB4WOe1YrZMQ==
X-Authority-Analysis: v=2.4 cv=UJ3Q3Sfy c=1 sm=1 tr=0 ts=69a74d3d cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=ovJmrJClAAAA:8 a=qC_FGOx9AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=FAJlpLcedYxlmlkzOXMA:9 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
 a=brTEhlvMp4NY0_u118I2:22 a=fsdK_YakeE02zTmptMdW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: etcffknWVfTaKeYrge4QX-oyaNLAcIyC
X-Proofpoint-GUID: etcffknWVfTaKeYrge4QX-oyaNLAcIyC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030173
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
version 22.1.0, replacing the previous 12.Dec.2023 release.

This requires upgrading the base image from Debian 11 to Debian 13
because the new toolchain needs glibc >= 2.34. Additional changes
to accommodate the new base image and toolchain:

- Use DEB822 format for enabling deb-src (Debian 13 sources format)
- Add libc++1, libc++abi1, libunwind-19 runtime deps for the new
  LLVM-based toolchain
- Add zstd for the new .tar.zst archive format
- Replace pip3 install tomli with python3-tomli system package
  (Debian 13 enforces PEP 668)
- Update artifact URL domain to artifacts.codelinaro.org

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 .../dockerfiles/debian-hexagon-cross.docker   | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
index 23152b4918..b4c42661eb 100644
--- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
+++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
@@ -5,10 +5,10 @@
 # needs to be able to build QEMU itself in CI we include its
 # build-deps.
 #
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:13-slim
 
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
+        libunwind-19 \
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


