Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF10AF8A15F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDL44-00056K-MW; Thu, 16 Apr 2026 07:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL40-00055Y-5x
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL3x-00039Z-Ow
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:15 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G7UFgq3733587
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UQmlyxpZaVV
 P/6TW6V7qRLUtxbYcGCiDyOnIxm58+4w=; b=MteY/FgsqJFRz0fOgVAcde+nPwS
 RuQGUmBRu2EQxqI5AHx39Xxy7VsFOTy2sKeuv7x+dglo82Un7JaPlGr8DcUbis8s
 SYe64331+HdzcNGZsgq0JGwQ1qRP1eMrGfnskZ+zbUUEZHaipo+/1BMNv+IZ3xuU
 iwKrn4xqXLnwsqoQRhHyl8yTPhJLt1ETRPILvYm81DEHtat8EY4S48MTcc/64EvF
 cKjT3d9L65COm089RtNq8fat0cTltQM7GUPndGwygQ0/E/+S/RzujiW/e2h+ZdFb
 rQkYpr93UmEu/S1FXZJKh2kQYiwzziUEyZajhZ01/+HJczXYAtrV+bDZing==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djcqwktw1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:10 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2d93379001eso15669389eec.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 04:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776339550; x=1776944350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQmlyxpZaVVP/6TW6V7qRLUtxbYcGCiDyOnIxm58+4w=;
 b=SJAEetmuY6N1Gn68c5ALC9ObId5aBNFqDOSWZtH/1RluF5waARPPt808U2Wj3s5vXL
 nJDD/uOYWXldK8/jU0NUJHPzFsIGz4m2QTbTaDLyx/gLOt+Oqq66p7jj1GIh3v4mtZuy
 MwD1WLD/LQEg86k+D3UNtpAg5cjBvBQMcb3ENiKhIZ1gIT5mSoqVHiNTijocWMukgLQa
 u6BJyjRH6/g40yhP/17VLEIC89SDZmY6RcqsNgiaztgKzx0EmvMy7XhoNexoKhyfr1gY
 WEZMGT9rEbeZjTps5keJlDrxJenlVekkn2uXTJPOVXVyv3vYw8KX/w4hpfn6o/+ejalg
 M0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776339550; x=1776944350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UQmlyxpZaVVP/6TW6V7qRLUtxbYcGCiDyOnIxm58+4w=;
 b=G957/WM5Ot7LGWrnMdLyL2+srNLHlJoH1xHKn4imgEvksp9dmHsM4tZ/R7uZMnARO4
 66rch3j/gXp7T2QV6aj9RSRlAbcTTKc3Hzo/zjxF+GVJcKV4zuXwM65rpgPqKSG7ZvwI
 6JbLmuAnOoEb/h4DhD7BMb2aaGzzp5ZLmhoO4UXuaqwRYHVaaKT3ppzGbsv5dJ413zrJ
 +tBxA0m+s/oBucK/z6Np8o4foT/Q2GfHqlJNgb1eSt0dStgVyOlyUmtVj69y8u233A7p
 fdn/q/jCS7oLH2+CMhxSYm9nGbIasPO9xJyDW4zGvNyP84ZXo2BvUhBjBe99KcM0kQlx
 PqGg==
X-Gm-Message-State: AOJu0Yz4keKoRNjoQpbCp9ttUYnPF8iWR+qPxv48oYED991NdDHTZ5Ql
 YuVz63gJYsIRgtKIWdh3FPNQKUd7oFAfZ73vR1+8JqaiY8AP8A5HujZHDUTKAV0JM1av9l6ZGXq
 n98bLpdY3qGor29zmD/PxftRfDCA8nEp0RPicnYSTf6pQshoNPvFY7ndiRRQ2RojyOoZi
X-Gm-Gg: AeBDievbqLKwIZLoRceZHDDLVwYRakQZzIrKJMirWO802/SGtUU4mxD5ilMV042tMSz
 DDG28O7VY+pCMgwc9x9dvJPl/+h3ArJ2pw9zBN61R9aEgM7ByVRxXJDTg4eyktG5+VYMoecHhuA
 dhfViyRWcGFSyQB5xcsy/aHe7CXAb+KpdivG1yYTCGRvYLihDYX5ktK2mGRraLq/71FAUW6wxDL
 wC6pqxo0Cft3OLX5XIpZLZlAJ6YITZ1b/I9rMV0fVnCVuYKYuDPsrce/nKIANG2aETtEUgD6i91
 Z6ehzByDbQ25z5kpTnfl6oWExWcOJgKSXncl4yUrjM5ds3bVqxTp4XBDnIePN83kWapOVxdQjBc
 1GzjZzayAaYSQ5p2vT/SWSc6/mcFU2u6+4rtN/kBZ1CdbGS4VqD4QgDubiMHHqQEDoN3Af8fdfe
 czNS8ZlY8/Jp9OYXEA8Nk=
X-Received: by 2002:a05:7300:cd93:b0:2dd:405f:89b3 with SMTP id
 5a478bee46e88-2dd405f9033mr6231423eec.0.1776339549962; 
 Thu, 16 Apr 2026 04:39:09 -0700 (PDT)
X-Received: by 2002:a05:7300:cd93:b0:2dd:405f:89b3 with SMTP id
 5a478bee46e88-2dd405f9033mr6231403eec.0.1776339549417; 
 Thu, 16 Apr 2026 04:39:09 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c10a65asm6845391eec.6.2026.04.16.04.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 04:39:09 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v5 01/16] tests/docker: Update hexagon cross toolchain to
 22.1.0
Date: Thu, 16 Apr 2026 04:38:50 -0700
Message-Id: <e94d57178d464c517425391f2698efcd125f56c9.1776339451.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HXkjJtRd4pttBoMni-GgRxZ8CdTGCcru
X-Proofpoint-GUID: HXkjJtRd4pttBoMni-GgRxZ8CdTGCcru
X-Authority-Analysis: v=2.4 cv=XOIAjwhE c=1 sm=1 tr=0 ts=69e0ca5e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=ovJmrJClAAAA:8
 a=qC_FGOx9AAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=q7X4_axEi9qJq2Gpr8MA:9
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=brTEhlvMp4NY0_u118I2:22 a=fsdK_YakeE02zTmptMdW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDExMCBTYWx0ZWRfX+CYpjh39JB//
 eJgKtMQpLzE7xtpQyMsTx5NoJintWs/8LmVUf7LwbBYJ82DT77lECWwy0ZApHUtEL9zd8DttHWY
 D6KjRyJ4PXmbMA1jaNktQYmrByTDSX3hkKcnMLTdZjkZXZzFBxtzTemOuWX+SKyUzUATABR1BtX
 YrV0KQo0/KU00JdTMwEG3MN5ZJvwjTPFXwoLjm910Tu6GOMsHePatLNqVPlnLJGc15PAKztNoNB
 NDn3ErMDe60i30TJ+x22vz+hFdhIlQaFb+Y22hOLxqvsSGq8EDsD+qeAXBHMuDN84AOVfMEgMZ2
 TeGRh1355ppZMB0IJ6ttFYUGoFs/45A9FLAcb22wX1RlbZ3VVQN+FSnt/TqeC2QNSikKa4uFi7d
 /5vDqCCjkxi7OcNGSwTQHtk3x0eJpLzqDSRgeOg7QkUo2hX5+ewPXSdvQcdtZT5CIynBOyYOc8h
 zZBRYrStt6JF+aJkCgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160110
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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


