Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0D7C98321
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 17:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAA7s-00088N-5m; Fri, 25 Sep 2026 13:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA7q-00086h-IY
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA7m-0000dg-A5
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:21 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG0lDq2124499
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6qLh75Vl4QD3YjLjtc4HSOlmDII9YCGHppAOXYIv6jo=; b=NK/h7P01RzWrQcZy
 Oav7Q+6owMEYzCHEhhVk1BtGG++iN+JRgKysEWQlj86b4xqzFLkMT2DPgYI38w6w
 VE/PlEx0W/xbO2yuyhx20djSvDLrjNcYCtLQE9upmHy6UjqhJmyUtMjdAFIpMcXD
 nPn2JjP95ahgl/ZGmPF2eq3KN1/F+0mLj/gcgFoqKDFL7cBJt8U1qM/9s2GidXDa
 0jGUwghXoxLTF3wh/cyXHAJXKYPFnap6H3lCMd7tuu3TEWcXWg8MUpMRz3JwXEQN
 2usDezi2HroRYBvRrWyTmI6XQZQtxZy2VuprQa4eA2Gg2OlrgqpXbelCOmt6dEw7
 oWGNug==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq0ahm1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:14 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so1872429eec.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 10:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790358853; x=1790963653; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6qLh75Vl4QD3YjLjtc4HSOlmDII9YCGHppAOXYIv6jo=;
 b=B1YdcyyLBtirBLESGgDkvaQVSMutSnnHPu0DJChfpXhiRcZXSCyb2mqvg8nmm+GjmV
 gc8l/yiqZn//wvlQTokfFBc96VIiVdYUbXWpjwdWIoQSCOsjXlVMiI/sFjYjzv+gagoO
 zfnnNlwVT9zjvkp81oOAj1t6/C8GYK4pT0lpxpJxtnn7dVbl8ewTAOj8rwgn+62W0BDE
 YAPIC+Cc60A8d/bVuJ2dFnmRfMP70T5KWzqs4JKIOrgCvXSTxTxL1Ht7GyB6V4zs6mWT
 8Nq/DoN6cpWBc7UgNDPpQZvE175lNzPhPwjGmeyXxSRExFhRcclIce3pEysC18Fjo86e
 eBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790358853; x=1790963653;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6qLh75Vl4QD3YjLjtc4HSOlmDII9YCGHppAOXYIv6jo=;
 b=nkz469k82HCK1UmnUrIf7psKlIQ6vcoAh0Usrdde7OW2SOZXHQSK6AjNgeE3GVgqaf
 QWhd+mm7lmMTGf8JyMtIfHTOZzGohkmjlaoEKOnnbSnm6JWlxAUlPGyknWYtojWPJsAm
 Sv6C7o/4WuatE0r3mZd/V7kCYNAC982W7uFOZyRZwF48Qc+X7GmupDRLDw0yQgX1s16K
 MKGl5F4NghGYo8+EpOeDzj1oR16R2ESlApHlzoO6Ff+iIXOD3qoNHKoD/DKvyqjdE9oN
 jW3QxmozsYcaothpxXIJnpp29lz0QB5KLtXWwZK3WJdZE7hH59cdPQGFXkx4k4EDp/6B
 kWAg==
X-Gm-Message-State: AFuF++n0SuL4xm1RrgCHXtrvHKXqI8b3CEyZQj5XQxX+cehl/urnxI4Y
 UsK4OGb/0y/EEXMMTFlm4i/f0TnmR6w5lB6r1VlAGzfMtpyiVwcyRy7y5b5OQIPWZq7W/h90+Zc
 1hWFw0pIIZaX05a2w9j3/0IgtFGiwuTfirBCk9/vY/R8wzlo/GY3hJRthYQ==
X-Gm-Gg: AYBFou072twUu1fY8l2O/B4RFDIUtZIsJsv9Nw5BGmQfjiVDH4WXvsu3mw7rPnFT5Yh
 eW6cWgUCjTqjTGPpHnUw8kYzwijfBXZ6lRKLjELlU1M7IbEYDA9JYijUedQRJoIxpJsuDKVZg+z
 fe8tx2elqkNvup4DkBlR8yTNwgpcMTNnK3XELOfYhBwiLK/Jpee0lI/QkA7MTypirD4V3pUcyig
 e4uWXxdqIjUUtdyWvmi7ST3v6fdvz9n1WvFSFahGp2CSmd55Ddc6xDwT1kxBp5K+QrQAUlhzzyE
 9pZQwItE06a+5ZmxKn0TIufC/XhxRbS3UM5hyT7IbExpil30Z89pRSXOydtFub431EE9aWtk/GR
 4z2AYZzjYBzbT3gC64mpZXB8=
X-Received: by 2002:a05:7301:db81:b0:32e:e250:85ef with SMTP id
 5a478bee46e88-3426fcc9969mr708400eec.1.1790358853207; 
 Fri, 25 Sep 2026 10:54:13 -0700 (PDT)
X-Received: by 2002:a05:7301:db81:b0:32e:e250:85ef with SMTP id
 5a478bee46e88-3426fcc9969mr708371eec.1.1790358852419; 
 Fri, 25 Sep 2026 10:54:12 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144172de6sm11055128eec.9.2026.09.25.10.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 10:54:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 05/13] tests/lcitool/refresh: generate dockerfiles using
 --host-arch x86_64
Date: Fri, 25 Sep 2026 10:53:52 -0700
Message-ID: <20260925175400.1897574-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfX6pWYGf6/rDd0
 yxElH9dLsCDJBbtXD4M9XHW76msQrXscOSUfBmyYcLkO5Y3lJ2gBJt2wQEtNne4oPaE2zoBktmH
 xeB6sHIgT7sYk52xzKtxm/EcPKcXC2o=
X-Proofpoint-GUID: LpH2yzD2LKKEiT0fvGzDCcj8EPTs7J0j
X-Proofpoint-ORIG-GUID: LpH2yzD2LKKEiT0fvGzDCcj8EPTs7J0j
X-Authority-Analysis: v=2.4 cv=LNPz05W9 c=1 sm=1 tr=0 ts=6ab6b546 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=E9XLolqhLJxn-exp_28A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfXyZ9hn3boRTf1
 AtHqBREplJizlynTTi4AffnRHZfRQtQcEYrr0ITvx0Ymc0auvLpN/MsybEKkp0j+DI+CtL2hQMl
 9htw0aH2TmFAVqq74MJeKftS/Zh1+enU9fwffJPkKtUwl/rj4+t+/hEkh6nllgMSK9P8pShvsYM
 vpo+enuxXs+QTKp53AwDPUdRyyHnPE/TwPtDIvYUPl2fg+lWYdO9djDlA3Rc7c0/XHx/fo5Mtp3
 X5fIKwzbRIoPcqpTJCyoeSyufYZbdcVTu5w2hN7mKvAv/jgLa+uyF8UmQ8wpLLvW0TFLgkp/23w
 iPmXhkuJzhpv6NjBZ89ManPIDIx0T7Ev/haQv47IKoNbkgNTPGSnPT+lxTuWiro1BkK/p9yKu14
 vGB4ywBd+2IcqkhfCddf/wxLVBPLAHFMwm1hEzhvIVxj70IVgD47dZbpTyM3iVawK1Z2Eooy+j5
 J/TVLCVDYCXVe3lr4YQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250071
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

To ensure refresh output is consistent on any host architecture, we need
to specify which host arch it's supposed to target.
Indeed, by default, package list will depend on host architecture, which
means that output will depend on which machine runs refresh command.
For example, on aarch64 host, refresh removes libpmem-dev package since
it's not available.

Also, update lcitool submodule: It now uses arch specific images by
default. Thus we update all images at the same time.
https://gitlab.com/libvirt/libvirt-ci/-/commit/f34cd57eb892259c26600187bc35cc4152f932cf

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260923185725.863311-3-pierrick.bouvier@oss.qualcomm.com
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


