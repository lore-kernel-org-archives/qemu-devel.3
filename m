Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7073BC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whVS0-0008Fm-2c; Wed, 08 Jul 2026 12:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whVRd-0008DW-PL
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:48:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whVRa-0003pj-9b
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:48:20 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668GLKrX3330146
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 16:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZEH07oKvATR0Gj53iAhWfmPw3n82glBS//APLxKMbwM=; b=EdNGiwKcMTv7sca2
 a/bhGKSkzvYAn8EZTv8OrlnsGfSeXcHxrHPUS6zwyMYPnEX1qRsSIgJB6F+tp/DV
 5WlpEHO+Hf5faeXnhMh70u6vgBJs1D7KP7W+SmACTEDDA5ibAMyTcHb30W4XQKep
 rDd1bHQ2qW3HYy+TIbP7hAuchXDbau4x2WSK8D/n6PMSvUd/ASE7LVsd6U63nTKi
 wEmLAMcp6rOR4CJxkCE1DrqowNE1t5TjOn3PU3aSR45lgrdtf6nHx1dPih8omuR7
 Oss6cvHUfbfcFfxMeGSNR32/V+49zs5l6E7nOpqldEU24uQqwok9SuXMbO95qCfY
 MB+K7Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9hnv2ggp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 16:48:15 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-385d2703b64so41400a91.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 09:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783529295; x=1784134095; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZEH07oKvATR0Gj53iAhWfmPw3n82glBS//APLxKMbwM=;
 b=Dw7sHNPBG43IK2pCGmaHQ7nUgkZ0f9cJFujwSLJvJh0fHzNAbCh+VRHgS1rgj7oT3o
 kOW2P2HIKXHLB7yIwqz6OlK/6UW8235msBxezlEVtthpbmXATV54S43Jq4dw80mulMcH
 O3SKtbYbYZN9vBhoJCH6k/cQqEyNUdGUFM5P8K1W9VozAhW44dozuVdYvRSXTrOXtLGT
 RSXyCiXrG9FIlpHZu8D11lICBFD2CCWdOJggln5w7mni3fHzBtGWBTdGX+IjJfVEz9eb
 P93BYgd444v/Njc+aiDqttaUZPHo7yJzCjHRrJYZxQ4M4hc5PAWuLO2ZLoRMqtVYf1Od
 /6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783529295; x=1784134095;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZEH07oKvATR0Gj53iAhWfmPw3n82glBS//APLxKMbwM=;
 b=CpdMBuxH2y/VUvyJpKB+fhWBiESyE/fi2d8SNXRVG7AzP3fsnimBViBBXorZOnWuWE
 f/WdAlDedx84RYCVXSbUO18sMwIFi6DUFU7T/tdyPkISocQ6klbhjofUnJrG7jjGbQGV
 eXdup+eHV9Qoue/5oUoel9279XjmEUZo0p3MgpuoVJ3SW64VofB+WistPMZI7lvrx+FL
 T0FvtU87T2MgXUHhQbudj4VXCpNcaPlTtuPE0uwnU+Q6iWiLA4M5M0ovoDTIZZsf5o++
 cyd5WNBo9SiKv+C6VBFXqyzOmnFin7g4BEvFcCVmlc/j6ctj6m8Ycw0cGmvWhuP6Cqtl
 Wp2A==
X-Gm-Message-State: AOJu0YxjjwWVjCJhhTMsCYIhPhuzxhYItBstYr3L7ZpvMwaE7s1bxOQD
 bjPSfPiikNxp403D2QLOYNrzHakWhSDk9TWDyy8n31+MMsmlPP7D7D2y7kIQlgoeEZRzNDQAnAK
 D5efZ2wGPSg4ScqPYGjwpElXQe0ivbGv3e2NsJ9njejVZJWs6m3aQe+mxpLqcCEHEIQ==
X-Gm-Gg: AfdE7ckbv5aVrUktfTeiMomMgZCa4McUWdlulXTZZmpXg8yL6LqXGD3MyQWNX60MVct
 Cxr9yelJ8I79YSDc+DD9oDqfJ/kFjYBXlcN23tPIB14z5/9enlgil6L5IAolxXyeA3XJPA69jHs
 swc4YE0vYiBqaal1eSavmYXPRJdeQCs+1Tuy34pS/VprHU1btRDRdPnvMZ/xCwxiiY8bx8a7rIi
 IdE0ZZtreXMBva21UIpIUTpRbDvl1uAhrNHmPSaKX36xE8aq0fqOdh7N94Db6Z6XquPOOvYY9ik
 fcqpmwCB9yl+x3g2dIc32VMi9k/1wYR0Hiwzdh2qeMLzu7LFd7s+X0aA4kpMItflXxTgWsLVK8e
 q43QXCVQCa1NO1m5gYaiat6qzCTP9XZy8WggBj65uunsYnOPa3z0+Z9/m/9E80wu5MR2vwR6X3a
 11yW56Lg==
X-Received: by 2002:a05:6a20:244a:b0:3b4:7459:85a0 with SMTP id
 adf61e73a8af0-3c09b2184cdmr9697833637.18.1783529295313; 
 Wed, 08 Jul 2026 09:48:15 -0700 (PDT)
X-Received: by 2002:a05:6a20:244a:b0:3b4:7459:85a0 with SMTP id
 adf61e73a8af0-3c09b2184cdmr9697793637.18.1783529294731; 
 Wed, 08 Jul 2026 09:48:14 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f5975sm20603290eec.4.2026.07.08.09.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 09:48:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 4/4] tests/docker/dockerfiles/debian-all-test-cross.docker: add
 missing apt update
Date: Wed,  8 Jul 2026 09:47:58 -0700
Message-ID: <20260708164758.1168667-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708164758.1168667-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260708164758.1168667-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KNNqylFo c=1 sm=1 tr=0 ts=6a4e7f4f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=n6MYwUk4AAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=fbayYWIdwhgohUsoNHwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE2NSBTYWx0ZWRfX6l12ptNSlzV6
 zcD9EQVmt2faHDkRqYUyok0UCMOo7/0ukg8/ILGaAwgXU/ggDR2STsborEc2SDuNldSnidRhRaI
 xXnmgdFAz19/oE5jHNAGePYcQFizm/c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE2NSBTYWx0ZWRfX/zXuI2TW/QYb
 CVISxxcgESUG6gs3SsosQJDHSrwxv7TEzuuqBtjxk9A0AqA51dV1Y1k0KUWz9UumqOzbSBeCeow
 FyDlXVkHidUnPbOLZju86cU+tyJilA1q3kxWXBd7Agk+WuZV2PCf8wUQO3ECDDaXHyOzA/RECXr
 ycqUh0ZpRvoaeUpIc6AzPw9aphv+mFWUEO/mgrgGOsXdB16PVQx42xqw72qwHSPRSBxfqMIcGOi
 NGkWJaIsBmRkKaIPm2shjQpdYbDSxSKdbGdsQza6I35JSggPHbJlhduKJnL5NwvMH9vjv2E4svh
 oJz70IuKJVHiPKDS2JbIYExolS6ZPNV/eXM/wCn/Y/zIUZ0GWA3gY0/uCV+Ufqxi98/V1MhhfyV
 6AUEqSQSROu1tVdiOiVXVJ9+qRlBOH0Xcd2ARDh9ain9SrcY9INnS34mKFdkIdD74+xjhKQalzK
 lbE2oJtNY49sjBy2sdA==
X-Proofpoint-ORIG-GUID: zG6pePHxV_IQbP8DMAchF9tmfhnR6QdA
X-Proofpoint-GUID: zG6pePHxV_IQbP8DMAchF9tmfhnR6QdA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_03,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080165
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

RUN statements should always use apt update && apt install together:
https://docs.docker.com/build/building/best-practices/#apt-get

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260707214655.1138626-5-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/debian-all-test-cross.docker | 4 +++-
 tests/lcitool/refresh                                 | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index a10ffc73500..2dc580552e3 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -55,7 +55,8 @@ ENV MAKE="/usr/bin/make"
 ENV NINJA="/usr/bin/ninja"
 ENV PYTHON="/usr/bin/python3"
 # extras for cross and alternate toolchains
-RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+RUN apt update && \
+  DEBIAN_FRONTEND=noninteractive eatmydata \
   apt install -y --no-install-recommends \
   clang\
   dpkg-dev\
@@ -92,6 +93,7 @@ RUN if dpkg-architecture -e amd64; then \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; \
 fi && \
+apt update && \
 DEBIAN_FRONTEND=noninteractive eatmydata \
 apt install -y --no-install-recommends \
 ${AVAILABLE_COMPILERS} && \
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 8def84d946e..6bc611b0e6c 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -166,7 +166,8 @@ RUN cargo install --locked bindgen-cli
 
 debian_all_test_cross_compilers = r"""
 # extras for cross and alternate toolchains
-RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+RUN apt update && \
+  DEBIAN_FRONTEND=noninteractive eatmydata \
   apt install -y --no-install-recommends \
   clang\
   dpkg-dev\
@@ -203,6 +204,7 @@ RUN if dpkg-architecture -e amd64; then \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; \
 fi && \
+apt update && \
 DEBIAN_FRONTEND=noninteractive eatmydata \
 apt install -y --no-install-recommends \
 ${AVAILABLE_COMPILERS} && \
-- 
2.47.3


