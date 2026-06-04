Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38CECD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 21:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVFz7-0006tF-Kf; Thu, 04 Jun 2026 17:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wVFz6-0006sJ-4m
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 17:52:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wVFyz-0006jh-AW
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 17:52:11 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654JnpB53111402
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 21:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3ZonSs13WlR
 UmFeR56D7sjhHu3JSlNQhEdOHPFKNos8=; b=m6yDzMNnJTfVvric91otBCf2/a2
 ZlZVn2NP/daO0tc6JcfG5EWlSNRQWCWgDEvvCRsBvIvFYvWVDQ7YMn58lgdBt4ZI
 TvAMwRrDLYIYAUACHmtKvgrw5ECzqdQWJWCvooP44PwFSL5nWmHscG+mWfpkpgZa
 ZmoN9clcdyQuKoNx3m/6odzhZIyjeiyi9KIKnnnbqaaeG6jpUlaYFoPHG8svDOJu
 jJJVjfYNITkRItOtvxboiGmAlYrFG/KHFXKBUUes/b59k3KFkXeUvCytjrmJc6p8
 Ex6wsPA0xCwQ38YtH0ZRD4ZzDaIgVG7iw8+bHijh5bBl48M/nPcEjcrXngw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekfv70dtc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 21:52:07 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304d8613efbso1126164eec.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 14:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780609927; x=1781214727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ZonSs13WlRUmFeR56D7sjhHu3JSlNQhEdOHPFKNos8=;
 b=he5pibpyV7X4SxVBZJP7Yq5MBTtKJjmQ7jixiYcN6iLX8eFRebSzH45+1nTuBP0xvd
 GZspBzgn2diTksgs37x20hivFGtbhot9AzLlbntDUiQ0aDtlhRPN/rSeKmhD7UOi+dxt
 6erCbtLXmDmu6pRPZsoB7HT94eQMitmovhwGWhtzYwRsCj/b3CScn0qpk+Eg5LOdylR0
 L8oc3h63xXIWgGFPN3i5wMX/8/8JoGRjC0lXBWdQx9GKfPwbQg0nwUg09X5misbp9ouz
 n7tEebswhwd9Rj4V88uzzmfykh/ljdJJtxhcJmLlh9yVgNMeJWL/G1tRsI+K7vn+D5zx
 mjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780609927; x=1781214727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3ZonSs13WlRUmFeR56D7sjhHu3JSlNQhEdOHPFKNos8=;
 b=gpAdTFy0ZHvXHgo7N73evqdiYBCnctIwWMju4wLZ2HTlhbfDZNUkh9+CEdkqSgyag+
 ElsTAgqbFgKuUSn0QtvXGC8u5sFjiHbt95pjNhyS8SFnjYQcFKzlEW2IscESEN/sdbYT
 xyQg3PR4e/exsXE3j8C871GTGALSt+kYvFeQ7vlFT+D1b9kXjXvSCmMQpLtGBobRQJ5U
 awSHnlzkYwYJ55bddUUk2Hlmg5DfTZAy3fRzcpLUuqAOARlFyLR+KtoyCWGnxdxBSMtQ
 nmrotvxj+PqEcQMEf1pnrTbLeMkcMRXyR+JLG3/FvFTCqoQJYSP/XEDZFOl29L+fYefH
 n/zA==
X-Gm-Message-State: AOJu0YySgAeAaABGg1tre0gj78yeXrjlSOCDmflxjn+cswWbXKId4AYr
 YhrUmZzOYhcpmuI62qhWDhy4KJb4oh6E1DFMnqCJPupQ7CFW5lFAYFDlsO27j1tr315kjSZOK4r
 1e/nNMXlCnylvbI+U6wCEduTENFeiaBD+ZptyNcep/qkI/vlX7wut6rp+XSoJEeqGPCPQ
X-Gm-Gg: Acq92OEy5xuoWJSxv/+k3rNttJcMBQTjTS/kFutVaEFu/zhP0xvnlnpTs/BQ/UhZ4Q0
 KL/thYQiZjAlUqDqVHCOQYFTWGkHQBWq3s9i+SyU8T6oAJ9VyizfpUI4rhMNOA4k7/HxDWehYfV
 EJalrJepqH0YUrexWYRvxgZ5/mHHa4SOGcV8TIt8egXXhHiDm+KLmjBZlHdI7+cRdflFiE4t7jN
 2aaAXgqI27wwntWDBuPP4HqkcWHvGgZuMHwb2VBLFoRQX4rG2YMvmaATgP2vscNXwIR7eKtE9zB
 qfmALQmZpwPNwCZACJcoXoS3Lg8J9CIoKCujRJBmY5/UaZcI40Jfq7kPHUY+Piy4OJTZPpw9e3p
 AjPexfSAk/GjC/VdGVmQ0F4AGRqdlpoFybKPewyl5snLNRZ3l5virn6Mq9K5gDOl66wXD8WZPHW
 aQpxteVE7k26yOx9Kf
X-Received: by 2002:a05:7300:fd09:b0:2f5:3fb3:4a76 with SMTP id
 5a478bee46e88-3077b38e294mr282504eec.10.1780609927238; 
 Thu, 04 Jun 2026 14:52:07 -0700 (PDT)
X-Received: by 2002:a05:7300:fd09:b0:2f5:3fb3:4a76 with SMTP id
 5a478bee46e88-3077b38e294mr282491eec.10.1780609926606; 
 Thu, 04 Jun 2026 14:52:06 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df64eb9sm5270115eec.25.2026.06.04.14.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 14:52:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/5] tests: remove ubuntu2204 container
Date: Thu,  4 Jun 2026 14:51:47 -0700
Message-ID: <20260604215148.3769627-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604215148.3769627-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260604215148.3769627-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2Gz5-ZJK3pEQKhX_3vEmLPCJggNwKZHG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDIxNCBTYWx0ZWRfXxT0yN/FLS4mw
 xA2hjYg3k6UGiGb19GN5lYMrpNcPRFODlYTMLoa+aZPDsx3bJUGIp8oSvutFGt18PEqGpOoLVsg
 QjVLvQSW+PXZIY7X+6ZwIyJceCRiMK4udcsTh7BHr1lL963yDMDpKacmDsr3xI6Kd193FVEMGHj
 Ulk8kihcQbUUfyovRFEaY0PPdx43b0xbwY8a7uyXdLwwSVKHZMx6mOWnC0ypXdUlN2a0GSU7ADx
 o5YAvwHgWihkdaCjW08T7WBjk9tgaM0votcP6YF1RsGu6FErZHlEjRU2IJ/oAvmRALeV/6p5jP8
 sK6dDwDBwuKcUq/CSpEBjXDzZ5oSO2PEjq3xX9zyita1Z+f5gcW8rJ51XSF5tB24uMeMzMRjlga
 4CEYVSMStw8vNjLZ4xlcL7KdCxl6uhmwId7JbwdCa8mENvyYteTWvu/pjVg+vAKgPzzLxGAW3dj
 sJ9jYcqzEvIsGkfK/JQ==
X-Authority-Analysis: v=2.4 cv=JNULdcKb c=1 sm=1 tr=0 ts=6a21f387 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=p0WdMEafAAAA:8
 a=danhDmx_AAAA:8 a=EUspDBNiAAAA:8 a=hrA9KEnTT8eVkNhlHiQA:9
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 2Gz5-ZJK3pEQKhX_3vEmLPCJggNwKZHG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040214
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
 tests/docker/dockerfiles/ubuntu2204.docker | 168 ---------------------
 tests/lcitool/refresh                      |   4 -
 2 files changed, 172 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/ubuntu2204.docker

diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
deleted file mode 100644
index 4617bbe1f65..00000000000
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ /dev/null
@@ -1,168 +0,0 @@
-# THIS FILE WAS AUTO-GENERATED
-#
-#  $ lcitool dockerfile --layers all ubuntu-2204 qemu
-#
-# https://gitlab.com/libvirt/libvirt-ci
-
-FROM docker.io/library/ubuntu:22.04
-
-RUN export DEBIAN_FRONTEND=noninteractive && \
-    apt-get update && \
-    apt-get install -y eatmydata && \
-    eatmydata apt-get dist-upgrade -y && \
-    eatmydata apt-get install --no-install-recommends -y \
-                      bash \
-                      bc \
-                      bison \
-                      bsdextrautils \
-                      bzip2 \
-                      ca-certificates \
-                      ccache \
-                      clang \
-                      coreutils \
-                      dbus \
-                      debianutils \
-                      diffutils \
-                      exuberant-ctags \
-                      findutils \
-                      flex \
-                      gcc \
-                      gcovr \
-                      gettext \
-                      git \
-                      hostname \
-                      libaio-dev \
-                      libasan6 \
-                      libasound2-dev \
-                      libattr1-dev \
-                      libbpf-dev \
-                      libbrlapi-dev \
-                      libbz2-dev \
-                      libc6-dev \
-                      libcacard-dev \
-                      libcap-ng-dev \
-                      libcapstone-dev \
-                      libcbor-dev \
-                      libclang-dev \
-                      libcmocka-dev \
-                      libcurl4-gnutls-dev \
-                      libdaxctl-dev \
-                      libdrm-dev \
-                      libepoxy-dev \
-                      libfdt-dev \
-                      libffi-dev \
-                      libfuse3-dev \
-                      libgbm-dev \
-                      libgcrypt20-dev \
-                      libglib2.0-dev \
-                      libgnutls28-dev \
-                      libgtk-3-dev \
-                      libgtk-vnc-2.0-dev \
-                      libibverbs-dev \
-                      libiscsi-dev \
-                      libjemalloc-dev \
-                      libjpeg-turbo8-dev \
-                      libjson-c-dev \
-                      liblttng-ust-dev \
-                      liblzo2-dev \
-                      libncursesw5-dev \
-                      libnfs-dev \
-                      libnuma-dev \
-                      libpam0g-dev \
-                      libpcre2-dev \
-                      libpipewire-0.3-dev \
-                      libpixman-1-dev \
-                      libpmem-dev \
-                      libpng-dev \
-                      libpulse-dev \
-                      librbd-dev \
-                      librdmacm-dev \
-                      libsasl2-dev \
-                      libsdl2-dev \
-                      libsdl2-image-dev \
-                      libseccomp-dev \
-                      libselinux1-dev \
-                      libslirp-dev \
-                      libsnappy-dev \
-                      libsndio-dev \
-                      libspice-protocol-dev \
-                      libspice-server-dev \
-                      libssh-dev \
-                      libstd-rust-dev \
-                      libsystemd-dev \
-                      libtasn1-6-dev \
-                      libubsan1 \
-                      libudev-dev \
-                      liburing-dev \
-                      libusb-1.0-0-dev \
-                      libusbredirhost-dev \
-                      libvdeplug-dev \
-                      libvirglrenderer-dev \
-                      libvte-2.91-dev \
-                      libxen-dev \
-                      libzstd-dev \
-                      llvm \
-                      locales \
-                      make \
-                      mtools \
-                      multipath-tools \
-                      nettle-dev \
-                      ninja-build \
-                      openssh-client \
-                      pkgconf \
-                      python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
-                      python3-pip \
-                      python3-setuptools \
-                      python3-sphinx \
-                      python3-sphinx-rtd-theme \
-                      python3-tomli \
-                      python3-venv \
-                      python3-wheel \
-                      python3-yaml \
-                      rpm2cpio \
-                      rustc-1.83 \
-                      sed \
-                      socat \
-                      sparse \
-                      swtpm \
-                      systemtap-sdt-dev \
-                      tar \
-                      tesseract-ocr \
-                      tesseract-ocr-eng \
-                      vulkan-tools \
-                      xorriso \
-                      zlib1g-dev \
-                      zstd && \
-    eatmydata apt-get autoremove -y && \
-    eatmydata apt-get autoclean -y && \
-    sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
-    dpkg-reconfigure locales && \
-    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED && \
-    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
-    mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
-
-RUN /usr/bin/pip3 install meson==1.8.1
-
-ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
-ENV LANG="en_US.UTF-8"
-ENV MAKE="/usr/bin/make"
-ENV NINJA="/usr/bin/ninja"
-ENV PYTHON="/usr/bin/python3"
-ENV RUSTC=/usr/bin/rustc-1.83
-ENV RUSTDOC=/usr/bin/rustdoc-1.83
-ENV CARGO_HOME=/usr/local/cargo
-ENV PATH=$CARGO_HOME/bin:$PATH
-RUN DEBIAN_FRONTEND=noninteractive eatmydata \
-  apt install -y --no-install-recommends cargo
-RUN cargo install --locked bindgen-cli
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 26abc695735..e0da0d2de1d 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -231,10 +231,6 @@ try:
     generate_dockerfile("opensuse-leap", "opensuse-leap-16")
     generate_dockerfile("ubuntu2404", "ubuntu-2404",
                         trailer="".join(ubuntu2404_rust_extras))
-    generate_dockerfile("ubuntu2204", "ubuntu-2204",
-                        trailer="".join(ubuntu2404_rust_extras),
-                        # https://bugs.launchpad.net/ubuntu/+source/rustc-1.83/+bug/2120318
-                        enable_rust=False)
 
     #
     # Non-fatal Rust-enabled build
-- 
2.43.0


