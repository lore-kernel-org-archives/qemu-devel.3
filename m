Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3056C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 18:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9SA2-00015u-BZ; Wed, 23 Sep 2026 14:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9SA0-00014o-5u
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 14:57:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9S9w-0003Xa-Rd
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 14:57:39 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGTZOY595325
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 18:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=uXXPBxmn2OB
 tCg8ydFoKAjzXL6oyf0orojICmgs0j1c=; b=iLb/OedD0TYNz10JvGVZyVuD/Du
 8SoJiZhtEGsviqx//F30EIXkZvf226ZxzkrL+Kz0f2toDbW63HooZ68RPXs9vwyM
 O0RShqqz7U/72RiKtv9jzdfkJggVQhC+U7vH1xJda6xWKrttytkYrwSaeXQycd9I
 zuYQLj99sKYNw6PBRA0RIC6wJCSCKriDm920KJuJMFIBjW+FJNjYemkRASa5MHEE
 Wb1XDsxoBg+noua1fji8dNAVjtY7BVCHcOpgkPOt2+fU55Njk36eC0gFD49kcEyK
 1O+QLaiS1QQkh24JriJmLEM8AnZyYpgf1/KyB/GRu7TahxhIIWEaLlCnReA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjxshhu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 18:57:35 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3284bbaa89dso492658eec.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 11:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790189854; x=1790794654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uXXPBxmn2OBtCg8ydFoKAjzXL6oyf0orojICmgs0j1c=;
 b=aXrAB8rO4XFDLnWvXJxfumPrhQo+pbjEhcbIGbg8ssgoMvdDvXkHhEu9qzvnxepMc8
 Iul9ss88vei2/k42jkvmC2aQduPQKB79BkQDYHel5jQsF0p1Hsd4DM1b5STj23KXLYUH
 Mzi808HI3KCIh6UCem8kxkWntze9DYTOks523hK/SrrP3IVFnf2ohAeHtl95UDa7JiYD
 aAb+h36DTXFy33inMzNP/gASCOtHBUBp8Jl5xPhfXHH5WZGot3qOez3kO3VOGO/7NIso
 XGqD4Cr+kImZH48zjz9AQuczhgMikhxGTjzMwYWf2K3ZySfrNZwmn0kbwNAXV0DfdeDB
 oxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790189854; x=1790794654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uXXPBxmn2OBtCg8ydFoKAjzXL6oyf0orojICmgs0j1c=;
 b=vyqZTYKg/Xn4S/8b98InIlpT/Q4dJAMvVunIIwBE2NVBKkPfEnn53MF36rWyDKhBeC
 YxhAQfjJYy7He+plWh1Ps8hA0PSOqLBy9GXXlzC/q1SbZSyhPwdsf67gi+d3PwCbLoNc
 hEs4G0H/yuButoDptlbZc/8sMaiU9b6VkoIxw9nNTKv0dSEoeuRQAhejlMqHKgA82v2T
 837WPeg4HPNOT/CnBnc0S3dfo+4kLlNysr1foMEgISl3RDu9rob69lqWC1qp5wJDcJWx
 JR5IjdjP/1q8LetfI/nm0RVzRKG0bXfyMH9SsqHYQbSGq5ogV+7aappt/U6JFb61tVBq
 aF4w==
X-Gm-Message-State: AFuF++k36mRXcK6dICCBZDjKD0CbAk8/tgJu/jx1tg3IChIXkUCpM4gJ
 c0ZQdFc0qC1S/tV4zaQARqw6Ok3lIrwjalZZ0/8xa8XE/ofsNVSUOAB5VPp8Pwo8xqBKe8h2YTx
 75bIcFtT4835hup9cZUobqRe4B/1wwKRbC8SRCNltnAw4/gltL93yU8NUZ5vgTngGdQ==
X-Gm-Gg: AYBFou3v7HDI5Ugf9nlOwZ+UzejaE/NIl4RPXsTAibUaZXfNWmfDCqr+0Dob1fmTuY6
 eVr7GfVJy5ctvPvCKZw5z8hc4kqetxOaz7tgpBSyfOzR36qUnkhYHRXlIK+GdhV/sEyUPDWErxb
 eQOxihZWcCkYvKcWGwlh+EPo5Xa0NRmyijz3wVfxe3k8tVRw/3xU/IpTu96aVm3sClvHr4WnIgp
 x+Gvv4YlZBRBw5kdvtoQ7/8FxUb+Y9oMKqLzG1ToE+7hVY74XQIBcdaBBa+IadDxFXeqiNxqW7n
 i1vvM1i3qsWKY7k5Ae7LhPg4GmB/F8RnVubZk75olJlNZF8QS93XVDWGQ1NKBGKeYUtXr5nHJ0b
 SaFwrw65cTkT4WJinEo5kxlADnE1R2k1mKW14SzZNkReinOj5W/T2M0NonGcE1ynh249d
X-Received: by 2002:a05:701b:2318:b0:143:2973:c08b with SMTP id
 a92af1059eb24-14503fde9eemr67755c88.28.1790189854032; 
 Wed, 23 Sep 2026 11:57:34 -0700 (PDT)
X-Received: by 2002:a05:701b:2318:b0:143:2973:c08b with SMTP id
 a92af1059eb24-14503fde9eemr67731c88.28.1790189853326; 
 Wed, 23 Sep 2026 11:57:33 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f9820ca5sm8154931c88.3.2026.09.23.11.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 11:57:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, philmd@oss.qualcomm.com, 
 berrange@redhat.com, alex.bennee@linaro.org,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH v2 2/6] tests/lcitool/refresh: generate dockerfiles using
 --host-arch x86_64
Date: Wed, 23 Sep 2026 11:57:21 -0700
Message-ID: <20260923185725.863311-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923185725.863311-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260923185725.863311-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lFrxE98QfIjVXNTGbw50x4_Bdu0sWr83
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3NSBTYWx0ZWRfX2PhlkZUY2E/e
 Zrl9a31A818zAqnn+TLumfkPAJN7hkwlvE7jgvpDtVqh6dYRhgCVdAOs4XPfZxRo4NSDf/YC9DB
 yUIQCk9Yz7Kk4GSM2lrTePWhkPbFVcAR3ntP5VFcejfmhzh9NrskjrVSOyzrQmZPxnaQri+QY7C
 rjXKWfQHI2YVtBqftahEDfkVbvMHwyx4asKs/4BGH8aVA9O+AsZIm3olY/MtsRE/XdOOOk0xR0k
 7YQ2juqf3YAn6fM3A6JdMoeqU5kzYv4mjcVcs3RZmcyO+i+nBZYO+ArixDu2o0VPLxvoJvXgDDC
 Ox8/iLsyEguJ10naKYPHsTq85ksSOZ9wA1lN1gMG0MBJAKkcGyx3+3mtGjz2wpcMyFFgO90cIlf
 lz5vGZg8iF3HRSYSwVhdBW9HQ2dsu0R/ls6XpPMYWxec9zI/rJPgNcccutVyQ+Gr+skJdjq/2Hw
 QL4lseq55Mxk0bfJlkQ==
X-Proofpoint-GUID: lFrxE98QfIjVXNTGbw50x4_Bdu0sWr83
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ab4211f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=E9XLolqhLJxn-exp_28A:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3NSBTYWx0ZWRfX96ojV0ry2QOd
 Qr9d3HE1qPkecj2PrfcDwqxFBxa9VvTGnmt2iVNQ0cbiNaarEnI/MlYuSNMkjQW3dUyHIVCD8Hq
 dy1yaxRgZgLgjX2EKmvXbiJ0glLckW4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230075
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

To ensure refresh output is consistent on any host architecture, we need
to specify which host arch it's supposed to target.
Indeed, by default, package list will depend on host architecture, which
means that output will depend on which machine runs refresh command.
For example, on aarch64 host, refresh removes libpmem-dev package since
it's not available.

Also, update lcitool submodule: It now uses arch specific images by
default. Thus we update all images at the same time.
https://gitlab.com/libvirt/libvirt-ci/-/commit/f34cd57eb892259c26600187bc35cc4152f932cf

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/alpine.docker                | 2 +-
 tests/docker/dockerfiles/centos9.docker               | 2 +-
 tests/docker/dockerfiles/debian-all-test-cross.docker | 4 ++--
 tests/docker/dockerfiles/debian-amd64-cross.docker    | 4 ++--
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 4 ++--
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 4 ++--
 tests/docker/dockerfiles/debian-i686-cross.docker     | 4 ++--
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 4 ++--
 tests/docker/dockerfiles/debian-riscv64-cross.docker  | 4 ++--
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 4 ++--
 tests/docker/dockerfiles/debian.docker                | 4 ++--
 tests/docker/dockerfiles/fedora-rust-nightly.docker   | 2 +-
 tests/docker/dockerfiles/fedora-win64-cross.docker    | 2 +-
 tests/docker/dockerfiles/fedora.docker                | 2 +-
 tests/docker/dockerfiles/opensuse-leap.docker         | 2 +-
 tests/docker/dockerfiles/ubuntu2404.docker            | 2 +-
 tests/lcitool/libvirt-ci                              | 2 +-
 tests/lcitool/refresh                                 | 2 +-
 18 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index 7c342e801c5..f1a5923e709 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -1,6 +1,6 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all alpine-323 qemu
+#  $ lcitool dockerfile --layers all --host-arch x86_64 alpine-323 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
index 8bfce395f9d..4201352533f 100644
--- a/tests/docker/dockerfiles/centos9.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -1,6 +1,6 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all centos-stream-9 qemu
+#  $ lcitool dockerfile --layers all --host-arch x86_64 centos-stream-9 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index c0ab05a5ff3..45edba38e92 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all debian-13 qemu-minimal
+#  $ lcitool dockerfile --layers all --host-arch x86_64 debian-13 qemu-minimal
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:13-slim
+FROM docker.io/amd64/debian:13-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 975b9f346e6..227cc773751 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch x86_64 debian-13 qemu
+#  $ lcitool dockerfile --layers all --host-arch x86_64 --cross-arch x86_64 debian-13 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:13-slim
+FROM docker.io/amd64/debian:13-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 3efce404827..f0c23718fa4 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch aarch64 debian-13 qemu
+#  $ lcitool dockerfile --layers all --host-arch x86_64 --cross-arch aarch64 debian-13 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:13-slim
+FROM docker.io/amd64/debian:13-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 91e8587b5d4..ff240096d85 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch armv7l debian-13 qemu
+#  $ lcitool dockerfile --layers all --host-arch x86_64 --cross-arch armv7l debian-13 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:13-slim
+FROM docker.io/amd64/debian:13-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index a60b72e05b9..276df72651a 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch i686 debian-13 qemu
+#  $ lcitool dockerfile --layers all --host-arch x86_64 --cross-arch i686 debian-13 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:13-slim
+FROM docker.io/amd64/debian:13-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index a7599b4f618..54b9564abb3 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch ppc64le debian-13 qemu
+#  $ lcitool dockerfile --layers all --host-arch x86_64 --cross-arch ppc64le debian-13 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:13-slim
+FROM docker.io/amd64/debian:13-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index 52661d4d9e4..d807825b83d 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch riscv64 debian-13 qemu
+#  $ lcitool dockerfile --layers all --host-arch x86_64 --cross-arch riscv64 debian-13 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:13-slim
+FROM docker.io/amd64/debian:13-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 0a04777b363..1a6b688425d 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch s390x debian-13 qemu
+#  $ lcitool dockerfile --layers all --host-arch x86_64 --cross-arch s390x debian-13 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:13-slim
+FROM docker.io/amd64/debian:13-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 77869f71546..ce591feec21 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all debian-13 qemu
+#  $ lcitool dockerfile --layers all --host-arch x86_64 debian-13 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:13-slim
+FROM docker.io/amd64/debian:13-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index 0f7b4c13388..144325ae1e7 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -1,6 +1,6 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all fedora-43 qemu
+#  $ lcitool dockerfile --layers all --host-arch x86_64 fedora-43 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index 3ed3e15df33..9b366c7c73f 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -1,6 +1,6 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch mingw64 fedora-43 qemu,qemu-win-installer
+#  $ lcitool dockerfile --layers all --host-arch x86_64 --cross-arch mingw64 fedora-43 qemu,qemu-win-installer
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 8fa8bea1abf..8f7e9efc899 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,6 +1,6 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all fedora-43 qemu
+#  $ lcitool dockerfile --layers all --host-arch x86_64 fedora-43 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index 3a3d6f73c89..1b306d4b648 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -1,6 +1,6 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all opensuse-leap-16 qemu
+#  $ lcitool dockerfile --layers all --host-arch x86_64 opensuse-leap-16 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
diff --git a/tests/docker/dockerfiles/ubuntu2404.docker b/tests/docker/dockerfiles/ubuntu2404.docker
index bb8f4e4e53f..cafbc382408 100644
--- a/tests/docker/dockerfiles/ubuntu2404.docker
+++ b/tests/docker/dockerfiles/ubuntu2404.docker
@@ -1,6 +1,6 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all ubuntu-2404 qemu
+#  $ lcitool dockerfile --layers all --host-arch x86_64 ubuntu-2404 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index 76b5dd5b5c8..f34cd57eb89 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit 76b5dd5b5c84511e2e799c2b3d6a2a9b9f6a081d
+Subproject commit f34cd57eb892259c26600187bc35cc4152f932cf
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 9a71af0e41d..002ab11270f 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -66,7 +66,7 @@ add_user_mapping = [
 def generate_dockerfile(host, target, project="qemu", cross=None, trailer=None,
                         enable_rust=True):
     filename = Path(src_dir, "tests", "docker", "dockerfiles", host + ".docker")
-    cmd = lcitool_cmd + ["dockerfile"]
+    cmd = lcitool_cmd + ["dockerfile", "--host-arch", "x86_64"]
     if cross is not None:
         cmd.extend(["--cross", cross])
     cmd.extend([target, project])
-- 
2.47.3


