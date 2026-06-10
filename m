Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00800CD98CE
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 19:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXOVi-0002vA-DE; Wed, 10 Jun 2026 15:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXOVe-0002tv-CB
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 15:22:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXOVa-0000Ay-Pq
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 15:22:42 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AJJdEX2557838
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 19:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /6DLFc0G95l8pBdW3yxzNC3vA4QxUFcSOA4U1Sxgs/E=; b=HrLv2ZVSi4jCWoww
 9Gx8NPJGPE1efYQvNo7w+s/5zfVZ7fsVWwW1ARxRBF9jMsx1lWQMp6z00rzaemVM
 Gm0UtMAy8j1pl19hwS81yZUs5S04yaCy7x5bDwykx+A+jCNrUuiAZPLLKKy6eSBd
 bzVHB9iuA65DCZJRqOqB3EnSvAUcnnhIfzm+a04AlGIHnbGntNimB9vlAzo2xqFR
 zQYLyLYqmmvttTvTAB4VjLZTP9rd9iQplxZyJhbRD+krkd3G0fGaVt6D/29S1EqA
 69HbR73Yu31EfHnotVY5kMFhkgd6EJBVFtpIzOgVZ/0p/GZQro1WEbEVHwWhrx6v
 LDIZJA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq4w1thqn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 19:22:36 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304f1820babso9093232eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 12:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781119356; x=1781724156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/6DLFc0G95l8pBdW3yxzNC3vA4QxUFcSOA4U1Sxgs/E=;
 b=GatEZ4+6yj1+XatBIbLZ4hszvjHSOf3DlaChWOn7bPYXOzL/ymFaUG+VPq3dSk/HO7
 P1HqRBsT7E3MphjZ1l1mQX65MAlnUd4iqBQaL6BwWZv0cITYVJ535eS0gwAGQ74VGgz5
 lUUPC2Wa5yqv5T5/+BF7Ntd9ypecsHkEHvcPnDljhJrJsqe7L2+NQ2eVlUgv+n9tS3tu
 1KwFVc/iZYqHKr1AOXBk8NfS0hEfJrJAJ8QA1X+gcolFEztnzWOAZrRcSxHKnK2Dx+oZ
 8QcR5mxsQqXKk2D0ve7eQmjBj/UEf1pcrZg8MHbtbIEyNIy640PmsEz/D07nbdRxMp2/
 M6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781119356; x=1781724156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/6DLFc0G95l8pBdW3yxzNC3vA4QxUFcSOA4U1Sxgs/E=;
 b=LmO20fyNBKHH4oaiHZ5S3v2Dc0Dhtt6D5vtMHJYWG3wfuANKkT83Dc5kJtg8qr3rYa
 Dyv6vO3MtJyKGpFHJS1g6unvf9wfF0t4Wq7nOCo2pqZxRWKwmJ6xTUTY+SkYc05Y7wgF
 Z+HU7pfi4XqVfQkA/doj5oxX0WugT520s5YRMEm3aJcBUWQV6AN+g6fYMjgwr85/2kWi
 UWzis5ARSkDMhH25404C2WzpRKXxgMb4UD5yRAN6YJqaBXEZDCm9B44Hr7Xtmsz5agiH
 btxwv6Gu01E66uFEJQuu/S8TWw7LcRnJR7242GaBu3FQWzcQz9DRlQ8gBgWz1TTvTcTz
 URQA==
X-Gm-Message-State: AOJu0YxrcUSvBQTA0fYNgIWX1GcQq8gHYQfgA9Md2fajUknrR8wMAx8/
 6ixo310R81REnyExvGpuhmCCzbPyeq0FRF7BVU4319E5QmLmJ1fdJOjTEjmk7cgg50hz5nnANox
 v2Ab9+Uq0ukgOfItqnWMw5EO2Rz89chWweHPzRLXXMUwWosUXYcG/zRqla/9bq9Wzq25a
X-Gm-Gg: Acq92OEYtchjpDPhBQh4ruRceu/bHJXeo8nhFZodvCwNga5+j6iNzrpNNfNufyE2LJu
 6GcReMP0FALDvjiQMLNbNje9ulHptlaPjmPle6BmjGfdxKZFCN+hqH07ME8pX1DNEPYFJjmfshy
 bXDIrlU3w3KuT762HLQo+mZbBgn/dfbbjcPa6my4ctgZeTYZ/I9tosZ8uwcrhHPdCkie497uvIS
 wN2lNJfykHciAe3lC8lDLmKjmHFTyKqoGuoTtPPq4dBZF9R7UX2jKivMiba/1vWtFPVjzcFGGUs
 Xk3SMr7ZHOrD5uuEh6jGSOd+PZUzwmw0Rl8ash32lYPJd94otll3EBjLCZcFetMaZPoVEgDCjuH
 44vCSZI95fLtqNAYJZbNfYyv0Fkj9+BwgtPeCpcwdlV9mm/Pifl/MJXqjmjCm2o9ZF5ITV3j1yd
 CagO2Ln9dj2HrsDqxJ
X-Received: by 2002:a05:693c:37c8:b0:304:5a9c:644c with SMTP id
 5a478bee46e88-3077b3cf48emr17871037eec.15.1781119356057; 
 Wed, 10 Jun 2026 12:22:36 -0700 (PDT)
X-Received: by 2002:a05:693c:37c8:b0:304:5a9c:644c with SMTP id
 5a478bee46e88-3077b3cf48emr17871009eec.15.1781119355501; 
 Wed, 10 Jun 2026 12:22:35 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df3b234sm34128986eec.23.2026.06.10.12.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 12:22:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 5/5] tests: remove ubuntu2204 container
Date: Wed, 10 Jun 2026 12:22:22 -0700
Message-ID: <20260610192222.2709135-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610192222.2709135-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260610192222.2709135-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vTSTSFj02XZfVF84PEHEWUn9gNYVJesZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE4MyBTYWx0ZWRfXwGLPclJgQP+Z
 T5ODQyQdi3NupfXQXUZTBtinHJMptFMNiCG6yeeNXkGCFHd+i+Vfdv6XsQVzbN0Y1k13D+x7x0P
 hnCwjwyoTs3umquSII4egtjPusBL7nrBlzQQeAEzemdxeiujGnn+hsE9Kd0049C54p0kbYzFiyf
 HEcUeaSmsb3uj3nEeiEIay62C15/vk/g4oZ49oEeD0LinacSti2QEKt4OExK4zd9289herDIRD+
 7KLsrcuDo92JyzfcnfAXYn0kfh6kvLYrrCsDDeZf66nw8AwCwyLaRxbaEHlDfXq1IZw4CofObos
 twfdSXF4K4XeKM8yWk9yw3LQUdmh+xyqvhAhQQTPvidR3jFreJYziSsUqJ++MIvZz29oIMp2ct2
 dKM70s8Vgld/H1iorlnuVEHJM8PFiHD0oouRelN+nSTpeVnsDvi6wdn5zbvcKCJIzmFH8n6vkym
 rn9+CkJijDAJvtiU/4w==
X-Proofpoint-GUID: vTSTSFj02XZfVF84PEHEWUn9gNYVJesZ
X-Authority-Analysis: v=2.4 cv=ZfEt8MVA c=1 sm=1 tr=0 ts=6a29b97c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=danhDmx_AAAA:8 a=S56xvJB5AAAA:8 a=EUspDBNiAAAA:8
 a=hrA9KEnTT8eVkNhlHiQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100183
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


