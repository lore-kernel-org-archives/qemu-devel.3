Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD02CDE00C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcsS4-0000hD-Aa; Thu, 25 Jun 2026 18:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcsS3-0000gw-D8
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:21:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcsS1-0001ML-KF
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:21:39 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PFeMT82737434
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 22:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e725vr2aW7giwWDjY5SN0qVsPJjMTRk2LjBaNB1knyM=; b=lUxKwMJ1gmE3jswr
 PcPmhkEWiv9guzkXBGhqiNZQyoFbW14Heyy5JEeTNI7rr2w4lnAmTXLLtQjX+WKP
 QpsawnOwWC1x/rmK41C7xfnn7Z7AolEBcpfDetsMRGWXnDKXKY8+IqJT5ucciUa+
 tH6rmB2FtagGRadKWE3E01aYUBFKZN5Zy3alN7KDNZPwQGNRkndxgCZj0NQkf5dY
 gWSPs+qa3Xg8WouE5o/y0OdXLNafqG2+i2bEF6sgBm8de2AmbnweC4uB9k6vopT5
 B8FTkBWl7O9ihcN2xVUYNVk66mlJ4O+IYtX1jrUYVliUKqhM+rOjf86HLD4jyZF4
 tP1ZrQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ya8umc2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 22:21:36 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139b62317d0so646215c88.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 15:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782426095; x=1783030895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e725vr2aW7giwWDjY5SN0qVsPJjMTRk2LjBaNB1knyM=;
 b=abRYpCA+w1wz8cZqXHTrlA6UBqSmQa+i5LgEp7W926I0C6V3qhFu37D8ytFLwXTjB/
 P6rx8KHiYzw79IZj+/qQZsu+un6596F2PlxRpuOfywOONzndNL+EgYvn8Ick5LCJKzEC
 YRDTMQOGGPiWCHz95N+3nKYfmMimM4Q2nAEhDGnvuXhFJuiei0Rpm8Yl9uFz7TwtLDg+
 KS3U2E1VRw/+IctJAoYvtJjuMCo2T5BjSQdyDmLTvb/ny3GdrooirsNe0CGsKOBjPKgo
 RqS979eXvus4rkyKBSRnMvvg3emLLhgUhSTtdQBrxY2qX61FUP4lJ/Vg8Eqd9IbvIawn
 CxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782426095; x=1783030895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e725vr2aW7giwWDjY5SN0qVsPJjMTRk2LjBaNB1knyM=;
 b=nKjNoqd7SebHvD6okqyG+5HPPMm/EJQYTwFElhGJm6DF/s9ayLmFFkIpz0dFQKy3mT
 JVnRMIR/nA3j0D2YRE41YyKjoBw9VC/V594B/OQbgOxvhAsQL+PPtQZ/f2rMitv8PUu9
 Pt3LXZL2vEyA0lOdCGCgtzRsHYkvmhWV6WsqV3VQ2oRSSZhINSeFw+gLMcQpxaN0c2D+
 85yyQJ1Gprj+tET49DD/AT1xIfYfnMmJzhFCZ4XZGm3LXL9IyPBE1zZv2ouwYY97Qdjx
 fX99BzoOa5Tk+wMx9Hic83I3tUsoibtj13lzXljRzXtDRq5DGLrEqVByQ3U21OnxFKy0
 Auww==
X-Gm-Message-State: AOJu0YzPpRw3jOBtwcvI2CHNg2toW+HMzm/6CoyfGiNL/H+OozU/YGrx
 JkzP6FxFQORCtQZK/5QB7WlN87fONVi1wKPO6AgY5e8WwNPVwAvDogO5I1OFlGN89KrKT09G6oy
 FGEgQhKqYwzpJWj9pjrdKd2G1n3o9bo1FgIAzTyUGwu5NQEZ3cOCxarv8yEaS1sb0Mg==
X-Gm-Gg: AfdE7cnTENftIxntpvstXfwbw20+nLfmPiTlm7x08rMjRLTkEsU6bZIPkzXIyCznuKq
 +5Xf9PQBSdTaWtkxnN1synD5BXnKAXVDN5HhmzO36IexkRk6wBe4xTbmtEArcT2q66tt5kENjR1
 AWJBxZl5Q3ZTkT/+xGCdrLKmKRBGCvUgnr3+yVcHvK1QxLabp3bQnV/qLxYQOSsFWTqPJMcS5mJ
 1Z+Vsah3IU0Th7nIiBQt06yHBjF80HlBR1eZjTKFjnWsGdfrJddPuhRBt6e1lKHY2PRVWNKt7EB
 +ls6Ef6ZWRxKEOCZrY8uHHpnRhQcr5gXrV0D/PZfD0Vho/Ahkq6rvRhVicwdTX8DuuqUUks7EtG
 a+71h4jYFrlQNXQfZTgoRIIqBr2pbznkCTemIijOtKvS6uAI9BzrrObhlAR5DfIguxGfBo4+pdJ
 lzMA+YDw==
X-Received: by 2002:a05:7022:f512:b0:139:beb9:fccc with SMTP id
 a92af1059eb24-139dbb49550mr2488892c88.26.1782426095539; 
 Thu, 25 Jun 2026 15:21:35 -0700 (PDT)
X-Received: by 2002:a05:7022:f512:b0:139:beb9:fccc with SMTP id
 a92af1059eb24-139dbb49550mr2488882c88.26.1782426094999; 
 Thu, 25 Jun 2026 15:21:34 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f318e7sm11538477c88.3.2026.06.25.15.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:21:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 5/6] gitlab: pull before_script logic into
 .base_meson_job_template
Date: Thu, 25 Jun 2026 15:21:10 -0700
Message-ID: <20260625222111.1761-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625222111.1761-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260625222111.1761-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE5MyBTYWx0ZWRfX/KG5RouXf3hy
 k1fos5czBR+BVwfKvJtiN2dDrflNhsryTQ1IJYN9cRjb2qQqumnaj90BOI6/cIXLT++Oo7syJlb
 DtMru1n/Za0SZd2pOXutI32huUNpY2c=
X-Proofpoint-GUID: OwP4Xu7QVsmUWhoS1q4UEBRLqqOPU31M
X-Proofpoint-ORIG-GUID: OwP4Xu7QVsmUWhoS1q4UEBRLqqOPU31M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE5MyBTYWx0ZWRfX2rQxqS+CJ7Ij
 rRZun4yPiRIcoroFcMmqe/zS+VrFGwQZiaytsgjMW4GlBBZtQ2G7M9CHPVbYBD+hlGYpjZv4T2O
 Jn91mEzxxSqDbnjVR5WFYny/+V/4ukZ0IGLeWvkNLy9q8dz0Sw6Bof8JGC8eRDK/r6qh+8KdIOk
 e9f/UG3+12kTI5uHRzxQexm6iY3hiE7aqEVONVj6xTi2FFnXBLBv7cJ/n4GmZJFGL11aYxj1FJi
 Ow5t8sW1iavIErNJGTTTzBl1EZx2Sx9BpVEwmtTgPxgsxDBIuXiVVDn9RRfYXfk5dRdnJrTADTi
 pUo5lGEaBk+PEttm+50x70/SD7igUsZtEWuvEfNqyIrkVOl073dfoUCucz9tCKOFKAlgm8EqlYw
 uuCeqxjFtKGknd0eOYtMB0f+fChqrshFizwcfq80kMkHb8NK8crh4xZCaY3oofxgEWfhgtEtdmi
 jJdJ5xmqV6C2IQiz64w==
X-Authority-Analysis: v=2.4 cv=Z+Xc2nRA c=1 sm=1 tr=0 ts=6a3da9f0 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=OotkPD_eqh6jdMuQoDsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250193
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

From: Daniel P. Berrangé <berrange@redhat.com>

This ensures that all jobs have the $JOBS env set and capture the
packages.txt content (where available) in their logs, and all use
the job section headers.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260624124657.2725376-6-berrange@redhat.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 .gitlab-ci.d/base.yml                |  9 +++++++++
 .gitlab-ci.d/buildtest-template.yml  | 24 ++----------------------
 .gitlab-ci.d/crossbuild-template.yml | 12 ------------
 3 files changed, 11 insertions(+), 34 deletions(-)

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index 366e654bcb9..fa0ca940481 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -148,6 +148,15 @@ variables:
       - build/meson-logs
     reports:
       junit: build/meson-logs/*.junit.xml
+  before_script:
+    - source scripts/ci/gitlab-ci-section
+    - section_start setup "Pre-script setup"
+    - JOBS=$(expr $(nproc) + 1)
+    # Prevent logs (if any) from prior build job artifacts
+    # from being duplicated in the new job artifacts
+    - rm -f build/meson-logs/*
+    - test -f /packages.txt && cat /packages.txt
+    - section_end setup
 
 .base_meson_ccache_job_template:
   extends: .base_meson_job_template
diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 8dfd17a0b5e..11d7a756678 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -3,12 +3,6 @@
   extends: .base_meson_ccache_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
-  before_script:
-    - source scripts/ci/gitlab-ci-section
-    - section_start setup "Pre-script setup"
-    - JOBS=$(expr $(nproc) + 1)
-    - cat /packages.txt
-    - section_end setup
   script:
     - !reference [.base_meson_ccache_job_template, script]
     - du -sh .git
@@ -74,11 +68,6 @@
 
 .native_test_job_template:
   extends: .common_test_job_template
-  before_script:
-    # Prevent logs from the build job that run earlier
-    # from being duplicated in the test job artifacts
-    - rm -f build/meson-logs/*
-
 
 .functional_test_job_template:
   extends: .common_test_job_template
@@ -96,27 +85,18 @@
       - build/tests/functional/*/*/*.log
     reports:
       junit: build/meson-logs/*.junit.xml
-  before_script:
-    - export QEMU_TEST_ALLOW_UNTRUSTED_CODE=1
-    - export QEMU_TEST_CACHE_DIR=${CI_PROJECT_DIR}/functional-cache
-    # Prevent logs from the build job that run earlier
-    # from being duplicated in the test job artifacts
-    - rm -f build/meson-logs/*
   after_script:
     - cd build
     - du -chs ${CI_PROJECT_DIR}/*-cache
   variables:
     QEMU_JOB_FUNCTIONAL: 1
+    QEMU_TEST_ALLOW_UNTRUSTED_CODE: 1
+    QEMU_TEST_CACHE_DIR: ${CI_PROJECT_DIR}/functional-cache
 
 .wasm_build_job_template:
   extends: .base_meson_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
-  before_script:
-    - source scripts/ci/gitlab-ci-section
-    - section_start setup "Pre-script setup"
-    - JOBS=$(expr $(nproc) + 1)
-    - section_end setup
   script:
     - du -sh .git
     - mkdir build
diff --git a/.gitlab-ci.d/crossbuild-template.yml b/.gitlab-ci.d/crossbuild-template.yml
index aadae26844b..94423814a75 100644
--- a/.gitlab-ci.d/crossbuild-template.yml
+++ b/.gitlab-ci.d/crossbuild-template.yml
@@ -3,12 +3,6 @@
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   timeout: 80m
-  before_script:
-    - source scripts/ci/gitlab-ci-section
-    - section_start setup "Pre-script setup"
-    - JOBS=$(expr $(nproc) + 1)
-    - cat /packages.txt
-    - section_end setup
   script:
     - !reference [.base_meson_ccache_job_template, script]
     - mkdir build
@@ -48,9 +42,6 @@
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   timeout: 60m
-  before_script:
-    - source scripts/ci/gitlab-ci-section
-    - JOBS=$(expr $(nproc) + 1)
   script:
     - !reference [.base_meson_ccache_job_template, script]
     - mkdir build
@@ -73,9 +64,6 @@
   extends: .base_meson_ccache_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
-  before_script:
-    - source scripts/ci/gitlab-ci-section
-    - JOBS=$(expr $(nproc) + 1)
   script:
     - !reference [.base_meson_ccache_job_template, script]
     - mkdir build
-- 
2.47.3


