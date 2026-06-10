Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27CFCD98CE
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 19:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXOVe-0002tm-8r; Wed, 10 Jun 2026 15:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXOVb-0002sr-1v
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 15:22:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXOVX-0008VZ-MR
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 15:22:37 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AJLI6L2571584
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 19:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v54rEp8JiOd+5vMBR9rIadwTFv1cogHqanNR92p+5rc=; b=eBffdnK+S10EvInS
 JA4XlYLkdOv1QRwSYYGfqnW9BEMO/P6sIanjLsjjsmM8Xq2Y1XO1YTQjZOkAiHOs
 Af4Rx3+hOue5ywxosYNbtWe+HieecafDYkt5DUYM7Tkra5DjHIQKM77cnJqQmNhj
 3bYVbYOZxO6zH7kWU8upGGq3zWbU5OZO5zqV1xY6GdCnT2Bp7rHNo0Rw75ocBEbX
 P2jbJGtHVIGM1L+gW9VeASNbNrONR52QclFVapUB3l/s9ae71Y6OfK4XYCnsLt6I
 4gc5OFD1UPdcpFq8L4lbplVaFkzus55ZPohkx61H0YLVd2cDkEMeSP3Hcu0/xr7D
 I899/A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq2sek7m1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 19:22:34 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304e7fc90b1so7305591eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 12:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781119353; x=1781724153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v54rEp8JiOd+5vMBR9rIadwTFv1cogHqanNR92p+5rc=;
 b=Th6g/+SEf2+5MtkdSplL2iXAZgl7N1IdX70TOYiOTd0z7UEjWmI7kwFSJABnEcjJ6+
 cdicK3y7G7sFvKvoZcnFw92NE9xw2FhYvI27jprHn6RZ+hAog9IlM+WjfERjOwxrzjpv
 GuXDasTAlNcGhpc9b05CFeGepY/hvgsVVPPagNUKi1ivNz88LjHHBZFprgSRN0Zwta3z
 TD73LnNK+cH7N9rm1BtXolny7E2kkevxrYNfyj4ZtKAolDvM0kCscwolXN2zLPw1p35o
 EXBMlRGBbVDpRcHSYEW43xwpSbnim88OWTi9HxBa3TvKh1wdJZAHbY1yLjpSHF8Tp8Jc
 yGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781119353; x=1781724153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v54rEp8JiOd+5vMBR9rIadwTFv1cogHqanNR92p+5rc=;
 b=hsTaqfVgAEyovRKqHZDx5Ss0bW74D1qG6f1wtcqG0h1MO45qn6mUAtOHnJDaQKtotB
 FX7ZV/alrjbpKV563fA2OIyFR9Ghze0LzGQKrFh4AclHf/wG3NUcPX+K9TRg2SYNa10C
 iV6xupCjZ7Qss27s1TrLhlNHX5Zd5Nh0B3O3zZSTdAGwHaT1ssMYJrwtgu373SdLPb/O
 SplKv8Mv/b556j9CYyimLjb2Xn6EwtZYVfJzxW06sIL+pCPxdYQC9tyDLfvc7ZkouYNa
 HKuXmokcZ86RPBR6EzJ6tbfY0Fejh6flzCUfDwV0K63iYU8B9hHtfUNEoIv1f7GgSHxc
 TRUA==
X-Gm-Message-State: AOJu0YxPOJ89tvoaaNfF4qOzj2sAeRBsAnQTKtqChijFszf1Greybi80
 HtYtYorhvhE85fZUWjMe8vJJqpPCWNVEq6YFLxmVAASuWUoXLVWZQXxJDmNFoG/aTYDZudD85ot
 jrq0Ug3121ECDHUtQBL8nmUXK2PZWcK9WEn4qSisAViIvwRBkRoGoFoKU4ozPagYsLzVn
X-Gm-Gg: Acq92OEadEgtYVXn1Sk9C1gPv8FGpcqptlVK+BNw6kx9nH4O6R8o+g1NtOVGizGrqiW
 FlSxr9FXyUZFr//UqzyrVMmWF2zmAn4zWcIdYI1Ahaetb7X7FSyARj39IYipz721a+fW/NzS5Ml
 Om+X0LGkEa4ikiET4iDtbVkly/TdkUaIpZR3oFvNt9SMa4z3WD9y4T0kBZU//S6nFsAxOgTQnWD
 w++0yanreHl1/wjF65/gLOhbxSWGXnTaXUJmD3lA1wu8FvUy5FoREKi9yZO2UXghLTjgfMl091w
 7qTH31Cs1ZU31LCZqg/0hZZorDY25k+dpd6IAOWpMDkk5XK9A4lRlrbt1W8a6RKMJiY5nQ9h9sD
 BYtyBWX3p3mhBWimhh3wCaeAUBTItCRzB2Ge6mXRCN5DuVnD8wCBvcuzsgMBbBHk0y/ozUnC+u0
 TWv7cBSsB9bf1bywVO
X-Received: by 2002:a05:7300:3721:b0:2f2:6dde:df54 with SMTP id
 5a478bee46e88-3077b371232mr17863353eec.33.1781119352883; 
 Wed, 10 Jun 2026 12:22:32 -0700 (PDT)
X-Received: by 2002:a05:7300:3721:b0:2f2:6dde:df54 with SMTP id
 5a478bee46e88-3077b371232mr17863327eec.33.1781119352287; 
 Wed, 10 Jun 2026 12:22:32 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df3b234sm34128986eec.23.2026.06.10.12.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 12:22:31 -0700 (PDT)
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
Subject: [PATCH v2 2/5] tests: add ubuntu 2404
Date: Wed, 10 Jun 2026 12:22:19 -0700
Message-ID: <20260610192222.2709135-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610192222.2709135-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260610192222.2709135-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VR9rbU8dM7ct1lFKpeiHJECbG_wVp_Gs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE4MyBTYWx0ZWRfXwfOqh/0vfCH+
 ey4Xo482rI8sFKQ/m4edGViiADxxKhKURTFfJsecanigxoc9fqGpXfLab1SpQ1rXKAV7El33Mkn
 FHA6/X7tiPl2ukRjj7VpV0o1JiFosuFGfAhRxKnm9328dSmTB4F7jGdHw9aRidYZe5y/6osHCQC
 qNVsB1B1l9x0QrmQS7qZokYbD75MNTr8YWs77jzL3i8BGnMT7eYwRG+ESQeURE94tdhVJn1LiLx
 N+oNcFI5prKdIoaFzCXIaOzgV7PJTuU17c/2ZsZ+dDDUdku5yd+npERq9SosCG/GR+bgNx4m4q0
 jpgX4gL2ucxXwz8lsoAL8U50BDlW8H6HaQsZ+eaccMNWDYLYBHlxsQg9dh+yu7JXfOMyJ7n2ewt
 czwFx8gTRPH2mcEEfpKm5jJ5Q2iceBQt4KP0zRLNZNKlM2givAobGKSO+7EEJH+mTUFyEhn/etg
 QjJhLN77ilJuU7pm6tQ==
X-Proofpoint-ORIG-GUID: VR9rbU8dM7ct1lFKpeiHJECbG_wVp_Gs
X-Authority-Analysis: v=2.4 cv=Md1cfZ/f c=1 sm=1 tr=0 ts=6a29b97a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=danhDmx_AAAA:8 a=S56xvJB5AAAA:8 a=EUspDBNiAAAA:8
 a=zoz3a4UqGRdYwpjcZUAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100183
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/ubuntu2404.docker | 172 +++++++++++++++++++++
 tests/lcitool/refresh                      |   6 +-
 2 files changed, 176 insertions(+), 2 deletions(-)
 create mode 100644 tests/docker/dockerfiles/ubuntu2404.docker

diff --git a/tests/docker/dockerfiles/ubuntu2404.docker b/tests/docker/dockerfiles/ubuntu2404.docker
new file mode 100644
index 00000000000..26bc2dd94f4
--- /dev/null
+++ b/tests/docker/dockerfiles/ubuntu2404.docker
@@ -0,0 +1,172 @@
+# THIS FILE WAS AUTO-GENERATED
+#
+#  $ lcitool dockerfile --layers all ubuntu-2404 qemu
+#
+# https://gitlab.com/libvirt/libvirt-ci
+
+FROM docker.io/library/ubuntu:24.04
+
+RUN export DEBIAN_FRONTEND=noninteractive && \
+    apt-get update && \
+    apt-get install -y eatmydata && \
+    eatmydata apt-get dist-upgrade -y && \
+    eatmydata apt-get install --no-install-recommends -y \
+                      bash \
+                      bc \
+                      bindgen \
+                      bison \
+                      bsdextrautils \
+                      bzip2 \
+                      ca-certificates \
+                      ccache \
+                      clang \
+                      coreutils \
+                      dbus \
+                      debianutils \
+                      diffutils \
+                      exuberant-ctags \
+                      findutils \
+                      flex \
+                      gcc \
+                      gcovr \
+                      gettext \
+                      git \
+                      hostname \
+                      libaio-dev \
+                      libasan8 \
+                      libasound2-dev \
+                      libattr1-dev \
+                      libbpf-dev \
+                      libbrlapi-dev \
+                      libbz2-dev \
+                      libc6-dev \
+                      libcacard-dev \
+                      libcap-ng-dev \
+                      libcapstone-dev \
+                      libcbor-dev \
+                      libclang-rt-dev \
+                      libcmocka-dev \
+                      libcurl4-gnutls-dev \
+                      libdaxctl-dev \
+                      libdrm-dev \
+                      libepoxy-dev \
+                      libfdt-dev \
+                      libffi-dev \
+                      libfuse3-dev \
+                      libgbm-dev \
+                      libgcrypt20-dev \
+                      libglib2.0-dev \
+                      libgnutls28-dev \
+                      libgtk-3-dev \
+                      libgtk-vnc-2.0-dev \
+                      libibverbs-dev \
+                      libiscsi-dev \
+                      libjemalloc-dev \
+                      libjpeg-turbo8-dev \
+                      libjson-c-dev \
+                      liblttng-ust-dev \
+                      liblzo2-dev \
+                      libncursesw5-dev \
+                      libnfs-dev \
+                      libnuma-dev \
+                      libpam0g-dev \
+                      libpcre2-dev \
+                      libpipewire-0.3-dev \
+                      libpixman-1-dev \
+                      libpmem-dev \
+                      libpng-dev \
+                      libpulse-dev \
+                      librbd-dev \
+                      librdmacm-dev \
+                      libsasl2-dev \
+                      libsdl2-dev \
+                      libsdl2-image-dev \
+                      libseccomp-dev \
+                      libselinux1-dev \
+                      libslirp-dev \
+                      libsnappy-dev \
+                      libsndio-dev \
+                      libspice-protocol-dev \
+                      libspice-server-dev \
+                      libssh-dev \
+                      libstd-rust-dev \
+                      libsystemd-dev \
+                      libtasn1-6-dev \
+                      libubsan1 \
+                      libudev-dev \
+                      liburing-dev \
+                      libusb-1.0-0-dev \
+                      libusbredirhost-dev \
+                      libvdeplug-dev \
+                      libvirglrenderer-dev \
+                      libvte-2.91-dev \
+                      libxdp-dev \
+                      libxen-dev \
+                      libzstd-dev \
+                      llvm \
+                      locales \
+                      make \
+                      mtools \
+                      multipath-tools \
+                      nettle-dev \
+                      ninja-build \
+                      openssh-client \
+                      pkgconf \
+                      python3 \
+                      python3-numpy \
+                      python3-opencv \
+                      python3-pillow \
+                      python3-pip \
+                      python3-setuptools \
+                      python3-sphinx \
+                      python3-sphinx-rtd-theme \
+                      python3-tomli \
+                      python3-venv \
+                      python3-wheel \
+                      python3-yaml \
+                      rpm2cpio \
+                      rustc-1.83 \
+                      sed \
+                      socat \
+                      sparse \
+                      swtpm \
+                      systemtap-sdt-dev \
+                      tar \
+                      tesseract-ocr \
+                      tesseract-ocr-eng \
+                      vulkan-tools \
+                      xorriso \
+                      zlib1g-dev \
+                      zstd && \
+    eatmydata apt-get autoremove -y && \
+    eatmydata apt-get autoclean -y && \
+    sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
+    dpkg-reconfigure locales && \
+    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED && \
+    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
+    mkdir -p /usr/libexec/ccache-wrappers && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
+
+RUN /usr/bin/pip3 install meson==1.8.1
+
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
+ENV RUSTC=/usr/bin/rustc-1.83
+ENV RUSTDOC=/usr/bin/rustdoc-1.83
+ENV CARGO_HOME=/usr/local/cargo
+ENV PATH=$CARGO_HOME/bin:$PATH
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+  apt install -y --no-install-recommends cargo
+RUN cargo install --locked bindgen-cli
+# As a final step configure the user (if env is defined)
+ARG USER
+ARG UID
+RUN if [ "${USER}" ]; then \
+  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST=1
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index fa545cf1f4f..26abc695735 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -151,7 +151,7 @@ fedora_rustup_nightly_extras = [
     'RUN $CARGO --list\n',
 ]
 
-ubuntu2204_rust_extras = [
+ubuntu2404_rust_extras = [
     "ENV RUSTC=/usr/bin/rustc-1.83\n",
     "ENV RUSTDOC=/usr/bin/rustdoc-1.83\n",
     "ENV CARGO_HOME=/usr/local/cargo\n",
@@ -229,8 +229,10 @@ try:
                         trailer="".join(debian13_extras))
     generate_dockerfile("fedora", "fedora-43")
     generate_dockerfile("opensuse-leap", "opensuse-leap-16")
+    generate_dockerfile("ubuntu2404", "ubuntu-2404",
+                        trailer="".join(ubuntu2404_rust_extras))
     generate_dockerfile("ubuntu2204", "ubuntu-2204",
-                        trailer="".join(ubuntu2204_rust_extras),
+                        trailer="".join(ubuntu2404_rust_extras),
                         # https://bugs.launchpad.net/ubuntu/+source/rustc-1.83/+bug/2120318
                         enable_rust=False)
 
-- 
2.43.0


