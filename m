Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D18AD3940D
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8FaY-0004gF-8U; Thu, 02 Apr 2026 06:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8FaU-0004eZ-W6
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:47:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8FaS-0007mt-77
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:47:46 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6328Rx6h352408
 for <qemu-devel@nongnu.org>; Thu, 2 Apr 2026 10:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UQmlyxpZaVV
 P/6TW6V7qRLUtxbYcGCiDyOnIxm58+4w=; b=K8MeTxwcNLE/aJrSey/79pLnwrc
 qqFo5btqngkq/ujsUTbIO8FHI4kml6jKVwLXH7K3w1NRIc9skRU4MwTsRJKz3sLt
 nH/tVc+D3A8Mw6nzbcANVWirnd2pD+HBThTivy3lDsBV6FAZRbwbiHFLnaFpC6c1
 QzepLD23/0CpURrL53B0Jy+jyi/xUModybSELi0HatkSgpLQrSVECeeVRxjnEQQu
 wAEe2/MQiMmy7rlPJFMETgqFSN7aIfgXnAR933y0UhwwP5clx+2PxgsjBcTRCagj
 YB8oa7qJVt6T0cHaZKpOc9NqZRw2VVLIT9RCO9wCw7Ihu8IWkQG64M6WHBw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9myh8h0c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:47:37 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c8ac8e422dso1240015eec.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 03:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775126857; x=1775731657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQmlyxpZaVVP/6TW6V7qRLUtxbYcGCiDyOnIxm58+4w=;
 b=Xu6c0miNb4698SlkyaXZlaoLwyGt6xaRdPLCsoWDN87fsVOcpljnJ/GljPCrZ0k/Gp
 w6kHpUfIWaNtWw2sVqdrETfaDaCWl46udgTmU8ubbVTP2W+AsoRZ9NpzxeWKfwrDH0t2
 V6h/RUmIiMFf3HSkAca/EZV/hnm8y8TVuNtGVt4lTgr0fKElOveGPus1ZRZv6nO35xkU
 mamgoiPt6zXIRcghN9Pcxffks8HUOEOD8/VNJ4uoiTpHS6ELuegY2qAHyQ7iKLoAlKAG
 u4Dv6AY6LWjEwzE7VC+1sH58kvBS0OuolZnfC+tnGrOcij1ECdeLrNNiZO3WKvZCe3jt
 N0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775126857; x=1775731657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UQmlyxpZaVVP/6TW6V7qRLUtxbYcGCiDyOnIxm58+4w=;
 b=njpb8Z8VG4Q9ons3sKRq8rb8Qc2a6IBM1XGW+7lxxdiQlgTNgpiBQv6kOQDVZqoRgX
 ysnMJkZuu9Tk8FmSQKNggRJ/ntVlTG+3aHh44IasnQ3nDGo9o7n0rCQw3LewJSEygbif
 V9HYHY+afT6LlykcJa8UCWsvWOW43i4UphTW2YqZw2H+O9NN6fCuY+CLEKCUkdou58mh
 B5SCLsUDmRdIfLDzyzkRZ6uPdujr/+3u2crI/Lb1yvOLD5KY81+HaFsY/sxYreMOzmG6
 5QhUgSvMQTx9IorR+V3L0D9qIKShvVEwlou5m9U34YCupZHX8LqaCYtsj0akF6g04lW5
 lM8g==
X-Gm-Message-State: AOJu0YyMzgcmT8jBKqsuVDAM9tJrmqA7+x1IFPjPHYkJNYO6BkOs6+P1
 Vjxyvjf2xNh76dD7tTY4jcd3eeinu/yB6jTIdzOZw9ZHpBF8tr21SQ0hflhAfeOiT3M1bjZw2WS
 vQ/JYtuIwL5ShU25jo+de1aZKqW3uDaadI4nighXuPhxZm7iP0JoId/+9KB0TukWOGw4N
X-Gm-Gg: ATEYQzxPCWxm6cpOvwY3OuO17xtMLiIqFUX6gRUxhN3d+FAGzdVmFdjGXY9Ls3qbeMU
 xx76lWhjZ+M8vuy/IozWJzQdTrbwBpjSSJ0YVNWm2B7Gm5M19XIiKWbDPpSwYLFSWVpyMJKrtRZ
 A5vv2dKEPXYi/0gk+hZ5Vufd5aioP9LzWEJiMSWt/pmaEdtkuO85EnTTUapzM/yUhpF7UvoWyyR
 AOj5dwVihQBvVQGu860qTtn9of9fx8xbMNi9RdHkfgr9EBXhQE2I7trlal3WqoSVVomBQmBA3S0
 RKQMd8DGzKCVIy/w9yfvDNiFbkHIZmnTeD+OQ3pZEV5tvZJFK4FbxYGSF/YbFt+o5Tjm0maOdCl
 j8nSeAfBle/nn1o0tZXLMSbunpnUwEtaJuK4GqOovrLuJQU+Jg+kHu97qu6wll7+kBy/j1sn0vL
 ryxkmmrNzY
X-Received: by 2002:a05:7300:5707:b0:2c6:7f49:a871 with SMTP id
 5a478bee46e88-2c9326aa17bmr4127113eec.20.1775126857178; 
 Thu, 02 Apr 2026 03:47:37 -0700 (PDT)
X-Received: by 2002:a05:7300:5707:b0:2c6:7f49:a871 with SMTP id
 5a478bee46e88-2c9326aa17bmr4127083eec.20.1775126856510; 
 Thu, 02 Apr 2026 03:47:36 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7d00f5easm2004783eec.29.2026.04.02.03.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 03:47:36 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 01/16] tests/docker: Update hexagon cross toolchain to
 22.1.0
Date: Thu,  2 Apr 2026 03:47:18 -0700
Message-Id: <e17bf5c09e434979a491b27bd2fad23fffd2b9cd.1775122853.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RQS08OrLZ6fGRlyZLV0GxyRYzE1nCI1Q
X-Proofpoint-ORIG-GUID: RQS08OrLZ6fGRlyZLV0GxyRYzE1nCI1Q
X-Authority-Analysis: v=2.4 cv=JII2csKb c=1 sm=1 tr=0 ts=69ce4949 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=ovJmrJClAAAA:8
 a=qC_FGOx9AAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=q7X4_axEi9qJq2Gpr8MA:9
 a=scEy_gLbYbu1JhEsrz4S:22 a=brTEhlvMp4NY0_u118I2:22 a=fsdK_YakeE02zTmptMdW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5NyBTYWx0ZWRfX31p2Ny88mZr4
 71+X9aOn4a9G2TPRXNM0EDuZtVZ4vi1EitZod8L7UOEUOuvi9IltmkiYdds7uNUatogwTiW1zfo
 36hrggzsTogqhcNj1ajgky6flMd3UL8I/RQm0VvOGGwRMEHUqIJCVpnACgrLCo7NJy7rHpXVmuG
 jeDyuhuf2SU1SRXloOF5sKnddthqC6ZZUA9lR1A3nOWY7dQ90/b9MMIoB7sPZcl/Y6vXkF7Wv5K
 6iCBy+lf9Bi3g8u9r4MiC6SD9uXkiVxxyC9x7rHplBeltn8aF43tcWsDW6wmUCfk+yn/xCR+mRO
 0eS4mOFy3oaI9eu7sBFtRhgUUUgrfKIxwZBLxxJpCvVim7BH00QeY8MSey6BOqewON2GDND4KLo
 KjqXCblFkWtTJkTjTsH2XgBKOxHbY6p2dPZlprF4kKyQN3/FkFjeXMNKNHieJMZ67nzywkZxWxD
 dc/I11/6KaN9Hda7vBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020097
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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


