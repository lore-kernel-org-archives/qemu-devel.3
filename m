Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E3D10F996D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXqP-0003cW-2e; Wed, 08 Apr 2026 14:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAXqK-00036s-7A
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:41:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAVtz-0006ns-7w
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:37:17 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638GC6q01072656
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 16:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UQmlyxpZaVV
 P/6TW6V7qRLUtxbYcGCiDyOnIxm58+4w=; b=mKeDk74UkXKfmZ43IbeWeKzAS3I
 b1ir8jxZ2jzOV9UIBrsUCeFxGujpqu30lWEwaDIFSRsLl2Y6CqdX0/r8DyQa5cJo
 KTT2OwhRR87jVzaUncbAYelzLx2Y3n54/xOwh2a/tlkE9WHaSOduzAb3PqPXsPkI
 d2vzKEV5escMmeae0O9vKoSqdaCy6vstcBG+nFLKSwPnAaWq3Q3T9rOrTrovf9RR
 Ofk1V754ovQbOYT8w9n8GE74F3vTlGt746CZEJJLfRhHfrXjw9rMQOBhYWOU9HzF
 ZpGuDK1PK0/XeeisR5brtlUIqA3J7JSAnP4UPZMkSQVfrutL23mAgceQi9Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddtb382b7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 16:37:12 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c741b950511so46695a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775666231; x=1776271031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQmlyxpZaVVP/6TW6V7qRLUtxbYcGCiDyOnIxm58+4w=;
 b=Zq4NeuUTavp8Gjc2wIiVkzBo0TnZNYWnYPoyCZNL+SsPsQrYuXBNCv7lsR2KhiewbO
 Xe9yUrNlqfiZAHS6Yu+TG90OIirl1p5+p8TT86xzvupsNBMQVq+7xmEERI51aoSMamdL
 /8ZiktHc4711I+AQgr7YJ+g6H+YvT4N7jwA5Z1d51A57jHUzla6zhE7GrBoSd6SZqB0w
 CafdhCPEkZOMgSA8xn7QcU7FlhojAkBFXMSFn3xwTstxw+t+5Spr/jonZZ5doUdM16fD
 nWH4auBtjUxyh6HwIK8iamHRCaPbcF4p5O1xts6IeJeeYPvKPvd0+DKj57rd+GjGs+8P
 pA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775666231; x=1776271031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UQmlyxpZaVVP/6TW6V7qRLUtxbYcGCiDyOnIxm58+4w=;
 b=n+i7Rk378U8aCe7RBiygiYYXhB2Ee3SipWJ0BZo80RbLijaQHgmMo7QM1wj8Ijdz13
 St6VHgC4J6zJIb63AZ6geTZcRpT9kT8AThbq/Pz/a/xLUs8JYpeldUMddCMamB6G7lmr
 p1Iv5865JkgDBcAFu4u7NMh1uwPfPrGh9wzW0AUjzU+y7j2tGO8jXGZmYBEQaPv3k5Kk
 R4Z9T+BEeVwoEJ3F99lKQFwIbTVTrOwuE+5F/COzIbCpR7xkBD4XE+Zd6M8NlYt8jyiq
 f2OZId8WHWSEg3GOGPSWILIAeY5mMoq67Bx7ShHdx/sXZSEeerXWC0mrqWP9QnHohSSf
 8CRA==
X-Gm-Message-State: AOJu0YziaFOjoz6OH0o7cy9+/RTzQ7hhB3Z40DicyiEtGuYIFH4T6N6e
 UAmmygeQh7Rze60/lvbpXpM5v5L+Bk2EqrNM41seo5JjhJ34dLJmG6HJKtz+qV5ZSS6qsbAQaCv
 zEkakwl256CJal2LrSD2mlDU7f5HGyMY+15RGuasWNTkN9KsFgbvvk+/llVmf+bfHnygG
X-Gm-Gg: AeBDiev/3b+eQIjH2RMXVTSG6HLDmQagJNzepTyeIiAsjYyTlZcilUeY9BoQa1s+vtn
 //04foi1mKwN/6jFmg2WInUkalTNQ8Hyl/0Hh2mPHVVy4Emj3YHhuhsISdG6rdOwkuE85Apk+s6
 +MgMV4PP3o+Y/XqeINy1SV3oeDMqOe4fjD2AmpyTjtJpC/S4RPJoAd2ovm0e6QeK0T0QUYh7v5U
 HJTNVX/W68BcieoHJxaPSvUTXl4J5p14wYPLxr4DtZ3h9r6rt6lFBrgE5BHO2k0KybKlcr0po6e
 FHLfSndT1+e5B+Zye5LXBZe9Qzb7e0KWTFZDbFKwdYaLrn4LNn/KxMuEcmQeN2t7X6YU0Y0SN1o
 5eHJW7uxg/0eW0xKOTi2fsM96fnuJxLYBLWZ/tqfntLmJRMx1lZX6q4xyAZH8xYdkRaqCLeD+aS
 PzChs/KJp+
X-Received: by 2002:a05:7022:4396:b0:12a:6a64:81ef with SMTP id
 a92af1059eb24-12c28b962ffmr97534c88.9.1775666231116; 
 Wed, 08 Apr 2026 09:37:11 -0700 (PDT)
X-Received: by 2002:a05:7022:4396:b0:12a:6a64:81ef with SMTP id
 a92af1059eb24-12c28b962ffmr97501c88.9.1775666230366; 
 Wed, 08 Apr 2026 09:37:10 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c1ff43d04sm4082006c88.4.2026.04.08.09.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:37:10 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 01/16] tests/docker: Update hexagon cross toolchain to
 22.1.0
Date: Wed,  8 Apr 2026 09:36:52 -0700
Message-Id: <a04c3c5feb96ad9252818ef8bb1492406fe85ff7.1775665981.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE1NCBTYWx0ZWRfX/vIpkQtewCEB
 7mjhQhlZviBCsVgTwc+Ts9W++d4+XisZE7UncRLrhr9bNuXb1RTkCRgNeUdwrAunWEcSttI1Z7M
 BP9Wm2PHObjf7G03tcm4Dx3Z9L/X0ouJjse4K6ecLXWWI89LC5ThQMrywnUos3OjZr9BYh43JH6
 7GdpgrQJc+O3iySSluFtm4AL0IK0AFa7hJvzofY+i6tN6jTrUw6Uj/en76c3qSTT1+cfNbTMd6y
 LnG0BBpIfKx7qZcf34pgcF+VReXUw/3OL5g2dMUafl/xxFqNm8GRDqy8KB1/bk7pr0TD8bBaPQi
 0HkzaXv/EmxaepTqugpLO44X8EYWkpBZ392JOjgEzvSORPWOYheUM9VO0/0qyfQ7ZEb5cGaw90H
 zpKEsmefdPSr9Laxrp35anNJR8Oiu0gzBcuxJOW3uON/cR+eKl2vI/qPsVx6bi0Nef4wX0UbcRS
 Q8zzeR83XNfx4lrz/oQ==
X-Authority-Analysis: v=2.4 cv=eKIjSnp1 c=1 sm=1 tr=0 ts=69d68438 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=ovJmrJClAAAA:8
 a=qC_FGOx9AAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=q7X4_axEi9qJq2Gpr8MA:9
 a=bFCP_H2QrGi7Okbo017w:22 a=brTEhlvMp4NY0_u118I2:22 a=fsdK_YakeE02zTmptMdW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: SLu8gPdUn_psBthHpW2eapc9cYVR_uw1
X-Proofpoint-ORIG-GUID: SLu8gPdUn_psBthHpW2eapc9cYVR_uw1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080154
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Brian Cain <brian.cain@oss.qualcomm.com>

Update the hexagon cross-compiler Docker container to use toolchain
version 22.1.0, replacing the previous 12.Dec.2023 release.

Changes to accommodate the new toolchain:

- Add libc++1, libc++abi1, libunwind-19 runtime deps for the new
  LLVM-based toolchain
- Add zstd for the new .tar.zst archive format
- Update artifact URL domain to artifacts.codelinaro.org

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 tests/docker/dockerfiles/debian-hexagon-cross.docker | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
index 91d4b71ac9..636d0ca8a0 100644
--- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
+++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
@@ -19,7 +19,11 @@ RUN apt-get update && \
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
@@ -40,12 +44,12 @@ RUN apt-get update && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
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
2.37.2


