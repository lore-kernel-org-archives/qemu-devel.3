Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD98BCD6E77
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 21:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVFz9-0006tP-Jr; Thu, 04 Jun 2026 17:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wVFz6-0006sK-5Q
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 17:52:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wVFyy-0006jH-G4
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 17:52:10 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654HI9x9944656
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 21:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UfSys8tl/sT
 oUCQhziPapOsI9PNLbBW4EAri1zKwNdA=; b=X1sQqIseZgMsaMQSc59aqDAnx+4
 CbrowjYmLyItwQc7bO6Yb7U5jGSxKSQCVTzznzQ5KX6sXvyz6b/VD4Dte6NznEL+
 M6QQRh8XNMn+V2gmzOmA9tllVb6NcxhFW3iwB1N6bKkKa30+43R09Jd/jGnXzlHX
 nntQpL45iC9Hp9mro3lA0ZlUUxDi5Mna6Mx/kDl6RJPnLcA5S0WmV7H9GU454OIX
 d8uMDfIHQPUFKjOPkgeN0WJv1ln1jkFlRi+IHQr4zTRLxKyXBj/1qHvPTOtHTkUd
 0xlI7KsJgTQP57d+hof0bM+nAuB/VT9G8O2mV0+F9jPPrFBhvI+vKSt1xzg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek8d52u3m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 21:52:07 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304dd917645so1119496eec.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 14:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780609926; x=1781214726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UfSys8tl/sToUCQhziPapOsI9PNLbBW4EAri1zKwNdA=;
 b=iejJN6NDVyObU/3C/j4sR1lKfQ9euBUKbCx0ZsyIFqKUtI0M2owPgKHbeczu20h5dz
 HEwmQq9ElROR+qDkRNkNYkjprL3TrEpbL+mdln7SMZTmUvWkdV54e/xibaAs8e/jzsVp
 h2VOlMXx73j2FsvLL1nq4qCSYMnGaQOeXT5Wr2rwEDz5Q0KnqjZAS8Og1D/1VEVIIrBh
 J5UITnzIqjVBNdSuc1sZnyzPKVxYLlbQBapcBXiycirW5gZf4d0pKRB4QoZl/HSvSYgj
 t01evfDZXGi1P2jUEyf1B4H8iuBZvLbInd5nIOnwEz4iVO3QJOf6sbvEAQRQlcR8lovg
 ypcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780609926; x=1781214726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UfSys8tl/sToUCQhziPapOsI9PNLbBW4EAri1zKwNdA=;
 b=WXMHdFFQshUV0+lwsx2WGD3un0PcxWIvzqFCZwZotWcoVMVFbOVHQikQrqzqtjaYaK
 3LcBRTOJwrcMWB7Z1IAGyPS3IQ3OZo/xG4iGzou5qfWU7vOaktvxCHHT7LCDWcAOb7RJ
 rVru+7wEa67KXZgTdHEDOYgZZKKjGVwzKCFoON10Q4B/Q0msGZ3a+pkQtjW38XWdt4Tf
 WFSCeG/0HVFzlPdfPGl8u57u009isRyQpPqNTj71Yywytcoy7rK0PXnubDnZfU6KRmVD
 z3LpLf6LJWbUFR2lyZ3XM3XcCbE3XrS4tXrNbTJkRYeNmL8krm8xvvCZnURCn2KSwkSs
 vpkA==
X-Gm-Message-State: AOJu0YyDN3JGx8gHdxIpcohyUU9g4Vpiew7KjKjRgPSloR9N6FpqdgZD
 hPlA7gMv35y1hF+u5t7Xg4A7v8eMkXZdOFLcUfCfWNPwFzZ/ucKhs0SVh2ysvjalN/dM0Tkcosb
 SdQoVa3QTMzQlaobbygVqXnnvNOmzP6ipFO9OmYhovvkxIgfkuH5B7mvo55akcfxX2UzG
X-Gm-Gg: Acq92OFXRFUOhmYH9yMME798L94UgqpAwFQh1MsJWow1/yPBqzHF/c7BsjybTdW98Bo
 OzycTa3Xq0Lc+UTBMlg5nskWx0C7YnbTOvE/VsKGrijCbLNjeGZ7unwrWtCxqgHPU7+fLY1DrT8
 mdA6WHaz7W/Ul7+7gJEHwj4VdVkOLlmbfEOmTLn+g4QBGdj0AAcC2Sl2AecYyeEg+sB40gq6yO8
 SwJaDmNLIHnl3c1wnxjXfMbE7mdTJXByB00JoEOyhNcqrXSmuIjwSrfNM2JrXAo39Pq0+dh+oj/
 bfQzpps9k4QvDUdE6g7rUFP0ZGSkmI3/exSa3f4nsVqYUatkf4e2toliIJ/bMpvIB1hOMHTWQqR
 rOT1It4D7JftS3igqufeT9r9RtXsavmh1YOPBp33YZaPDOptxZXB+NaJtNFsMK3RfS5oqZrvUxQ
 Ft0qQGbyNGutxKTn9f
X-Received: by 2002:a05:7300:8ca0:b0:2ea:b85c:153d with SMTP id
 5a478bee46e88-3077b285d5bmr325179eec.27.1780609926332; 
 Thu, 04 Jun 2026 14:52:06 -0700 (PDT)
X-Received: by 2002:a05:7300:8ca0:b0:2ea:b85c:153d with SMTP id
 5a478bee46e88-3077b285d5bmr325163eec.27.1780609925889; 
 Thu, 04 Jun 2026 14:52:05 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df64eb9sm5270115eec.25.2026.06.04.14.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 14:52:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/5] ci: update to ubuntu2404
Date: Thu,  4 Jun 2026 14:51:46 -0700
Message-ID: <20260604215148.3769627-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604215148.3769627-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260604215148.3769627-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NW7v7YxWOlJGChxVL-ZplI_KVUntvsmt
X-Authority-Analysis: v=2.4 cv=IZG3n2qa c=1 sm=1 tr=0 ts=6a21f387 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=jLLu7jlssiS7FhGicJIA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDIxNCBTYWx0ZWRfX9qSJCXspOKWx
 Sxm+IauT9hRiklIqHwDrNFqsJhSSKupgjFlcImrTeQn2giD8k5FdfUB23fBbwsVln7Tc5QHysvr
 +iLTdZmVPtSEIYNjrAAHeCEP689tXn3dwBnU7DGjLNfxWDr03Q7HxGUXJWGd2XSCul5fx0pYoxH
 Sc8I6ZPUhlzNP34JR4knXpQf4blXCdOO5xN6R6DPNiwMvJsTnC8Wuuf3CNWhzqd4o9EQAyvy8CR
 MQUCUq6Ef8ED7PptEdJXXRsPydEitSz/1EqsutuOHE5E8VW6Vv8lO0yR2jKevpm/aAEkw401qTH
 eKeG9FnRU0+qowfdxCOTYySV2Nsev8dnJT4dTPUHx8d+FNmBMsjPSrpJF95Si5HXd6WKuxOOe3J
 Oa/ESrJOnO7hQZGrfCMokc2quFEXKqMcmPvPFBNa7ToPUnatQeDsAonS5pQutZqlxhVBM5ZryZG
 AtG0AxdASNGamgaPWyg==
X-Proofpoint-GUID: NW7v7YxWOlJGChxVL-ZplI_KVUntvsmt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606040214
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 .gitlab-ci.d/buildtest.yml  | 16 ++++++++--------
 .gitlab-ci.d/containers.yml |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index d0543490309..e2553e7326f 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -36,9 +36,9 @@ build-system-ubuntu:
     - .native_build_job_template
     - .native_build_artifact_template
   needs:
-    - job: amd64-ubuntu2204-container
+    - job: amd64-ubuntu2404-container
   variables:
-    IMAGE: ubuntu2204
+    IMAGE: ubuntu2404
     CONFIGURE_ARGS: --enable-docs --enable-rust
     TARGETS: alpha-softmmu microblaze-softmmu mips64el-softmmu
     MAKE_CHECK_ARGS: check-build
@@ -49,7 +49,7 @@ check-system-ubuntu:
     - job: build-system-ubuntu
       artifacts: true
   variables:
-    IMAGE: ubuntu2204
+    IMAGE: ubuntu2404
     MAKE_CHECK_ARGS: check
 
 functional-system-ubuntu:
@@ -58,7 +58,7 @@ functional-system-ubuntu:
     - job: build-system-ubuntu
       artifacts: true
   variables:
-    IMAGE: ubuntu2204
+    IMAGE: ubuntu2404
     MAKE_CHECK_ARGS: check-functional
 
 build-system-debian:
@@ -577,9 +577,9 @@ functional-cfi-x86_64:
 tsan-build:
   extends: .native_build_job_template
   needs:
-    - job: amd64-ubuntu2204-container
+    - job: amd64-ubuntu2404-container
   variables:
-    IMAGE: ubuntu2204
+    IMAGE: ubuntu2404
     CONFIGURE_ARGS: --enable-tsan --cc=clang --cxx=clang++
           --enable-trace-backends=ust --disable-slirp
     TARGETS: x86_64-softmmu ppc64-softmmu riscv64-softmmu x86_64-linux-user
@@ -591,10 +591,10 @@ tsan-build:
 gcov:
   extends: .native_build_job_template
   needs:
-    - job: amd64-ubuntu2204-container
+    - job: amd64-ubuntu2404-container
   timeout: 80m
   variables:
-    IMAGE: ubuntu2204
+    IMAGE: ubuntu2404
     CONFIGURE_ARGS: --enable-gcov
     TARGETS: aarch64-softmmu ppc64-softmmu s390x-softmmu x86_64-softmmu
     MAKE_CHECK_ARGS: check-unit check-softfloat
diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index 515e7382f26..87c20094d22 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -13,10 +13,10 @@ amd64-debian-container:
   variables:
     NAME: debian
 
-amd64-ubuntu2204-container:
+amd64-ubuntu2404-container:
   extends: .container_job_template
   variables:
-    NAME: ubuntu2204
+    NAME: ubuntu2404
 
 amd64-opensuse-leap-container:
   extends: .container_job_template
@@ -58,7 +58,7 @@ weekly-container-builds:
     # containers
     - amd64-alpine-container
     - amd64-debian-container
-    - amd64-ubuntu2204-container
+    - amd64-ubuntu2404-container
     - amd64-opensuse-leap-container
     - python-container
     - amd64-fedora-rust-nightly-container
-- 
2.43.0


