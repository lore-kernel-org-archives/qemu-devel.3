Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35CFCD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 17:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZBSo-0008GO-RY; Mon, 15 Jun 2026 13:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZBSl-0008Dl-2M
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:51:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZBSj-0006mD-43
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:51:06 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFhaEA992107
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pVyB55S918FF4lGz+LhcHZ0OJQ0hGymSlHSisf7FugY=; b=PVegWBU86XHyFmJO
 FICsLJl/n2CCTk6VbZW8rqJjZ1lvB0gvmEWiswMYHPZT/BYcTEsFyJ9SYcceqURw
 x6VmrpyYiPspDpXWS1dWxrbj1dbSQvbGcNBPd8fZWUvAj9dA7tiUo4WVdlPWPlmn
 IBys02PnjdBkgHNbZRcZG9hXeCyciSHBv+OPNQkSpdBnz6/Zg5Hzn4cED8T7YBci
 1JraHzf1g8S1VGYP5VQkOmYrTzRCiUlOomLTeGuOXv+1fw3gHWngUjVM0Jg+TaGu
 RPteAq29HV/AxS8fD0Ig1g3TkJtKQuL8Hfr90AA4b7FtqAMTgwQl0FWV57G/vreu
 efkuFg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etgvhhn35-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:51:04 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-307fe856724so2312956eec.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 10:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781545863; x=1782150663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pVyB55S918FF4lGz+LhcHZ0OJQ0hGymSlHSisf7FugY=;
 b=EKN+vKyANL/4augS0jrhoIJ2VLRkxJzfcDJedIWaqtBOwAWX2lCO+MikjDraCoCxJz
 pXIBRurtlC0JVWxtoc0laNmpnCL39KYibywM+UCSS3QQm5ozfi4QE8vqXh4NgSB/8rM7
 6j4g73tD5kTpR9fKn5E+nBCz51dkaWGmLRhYshJLwHmKMS2aLOHBCbxG+xs9gvI6ET9R
 CSbJKDsfuxjMg85WaW2AXv6HNX3HaaA8a3RQTeYc5vH3ZnyiCrCfNnvJsZQCV5kymAbI
 i+hoL5qw1IJeIPiNKMmG0VzpQbHArwXSghr9yDFixrftWt+zXQGJtMMcZkuu63BmTzfQ
 I/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781545863; x=1782150663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pVyB55S918FF4lGz+LhcHZ0OJQ0hGymSlHSisf7FugY=;
 b=Q1dMds6QbhR+Y+USyM5t7RYAVM2T4aS9QtwQcqysgtRwpHAdP2yS/3DmBDLzpRI+A3
 EubfWB2usLyOmei+7wUKp2mGagANz54okFbQYSMaNTnP5AIHsSVSPgHvFQWQ05mHVlH6
 tiIHfIQuNBuyPk+zVTi88HuEncgqchWUgRwSxmd2bfUHxF9KNk+G5z+QEf2DigFgmZkP
 s4sW0CFpcPH6ODXbkFk01Li93DAgMEMRYXn64DwWed6nCe3w5ykQO/xQcg2YKDRAE/ZB
 sBH1/QBHyvaI/gHOqACbKNNfrCJSDQDwpytLMjrW/Q7SxutLS+NB2J3O746Zgjq1dWS3
 B/Sg==
X-Gm-Message-State: AOJu0Yw4F4wjV67utXUlspv/Ba++m7rCmpSzqMYjC2LtbPA74Gsz9HqF
 UfpikSVQCGgtmRdEH/2R9mmgADSomSiumpSgUocJTuav3j+KgWM+A9Pgr5k93txvCHU3Ryfe4L/
 isKsZ0J5+KMnRt9k/mr3CzZy0JcqV3+hZG7HXx9znvYD5Kmoxs/dWke04J4EvkLEtSrUX
X-Gm-Gg: Acq92OFn3KQOnDwd3Fy1LaLqPhOVn8A8U0yTx1I1+/8PFKrJ1pq+m75m+cuZoHu6fQd
 yw8gsHYgqAXyNztfdiKCyx9SATuTAc8th1joVkug4634JHRcWjVoZLhPF2mV/2Ys3xa3TuF0IjA
 lx3KfnBnuSCVcttSE50DjevgO9RYJm6VeHWF3k2Lhf+KmcV1pCBTYln4GtUPHB78faATkBpc1RC
 Q6bIYCytd4uxt5Ggit+1VGOU4Qbz8bPaOprIMChnPg0x4TuCTnOpWrQgpfZwST59ICV/EMfXrc2
 QoBHJPJ/SxXlJd6gF5L9w1bA56Kp/mmyGuqxO1IZGwARjaynZVfsMMUaC/3VEqNQoaMixLqjR2K
 wCNkUBDi7OQl0PtdjkTBcdTQhENku8flJr2QaPLQ7UdUl6jBLdJc1r+fN48cjmYy+n0uelSJp0S
 /w7z/e5Q==
X-Received: by 2002:a05:7300:d10:b0:2ed:e12:3773 with SMTP id
 5a478bee46e88-30ba5fb4473mr136297eec.35.1781545863368; 
 Mon, 15 Jun 2026 10:51:03 -0700 (PDT)
X-Received: by 2002:a05:7300:d10:b0:2ed:e12:3773 with SMTP id
 5a478bee46e88-30ba5fb4473mr136271eec.35.1781545862860; 
 Mon, 15 Jun 2026 10:51:02 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5cea89sm16816037eec.8.2026.06.15.10.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 10:51:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 4/5] ci: update to ubuntu2404
Date: Mon, 15 Jun 2026 10:50:51 -0700
Message-ID: <20260615175052.2751738-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615175052.2751738-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615175052.2751738-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4OSBTYWx0ZWRfX/KPDfGA76QMT
 1xjl+ZUyWbOz1c/oQEDsxkqmfFLqt50xaGv59dpRkPCEkqWLLEizUcTIVsHdj313XAUigJsMzJg
 jacer3Z1oNF6BfQ2wXCzLoX4yz6PX/0=
X-Authority-Analysis: v=2.4 cv=Zqnd7d7G c=1 sm=1 tr=0 ts=6a303b88 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=S56xvJB5AAAA:8 a=1Zc7Yv2amc--asnSjtAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-GUID: UN5bYGYMKZg1ynvPsTfua1yLnSBHst5h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4OSBTYWx0ZWRfX4UMjr9XIbVr4
 qn68QUk+0rM3ADZy8t/F5gWZNW1aoCkoQlWfYwRbc2NtLvBN/V0FDxkWPHXJYyte832aH/0f/pG
 zzn8GtLc08sSpE9o0GqLYwqI4KLpKJ9eQfeAGjRNQFvtTjEw6UfGhxMnmflXpn5v3s1VEQh6Nis
 vDdY0uDNq0JoYcU5zyB16l7TmWl5yeQQhm0if3OiPqoEfW2x0Bx46DnnJOXmpo21JVQNQ/n8eGC
 mEpfjZuJfPMntwJuEX4aVKbt8jYzgfxrw/g6oN6HstuaYZwk+Mc1Skn/1wAoHP6NTko1OLwHt6l
 2SOXSKGuqXbid+3Of2rWh/wjRtJUpqLRlAQZ+E9AZYoxpbcV127N8KvnN7fEySjZTzD6SKZsbzJ
 6M+xHgiLcd7CWsn4vmtOLM/xzIw3xsnPGVyks78uKQYpzEMuLgOW629/9lR4L4xm8dPRdwBTt+3
 t77jElXOBftCPbmeXUQ==
X-Proofpoint-ORIG-GUID: UN5bYGYMKZg1ynvPsTfua1yLnSBHst5h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150189
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Link: https://lore.kernel.org/qemu-devel/20260610192222.2709135-5-pierrick.bouvier@oss.qualcomm.com
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


