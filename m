Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98072CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 17:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZBSq-0008Gm-8N; Mon, 15 Jun 2026 13:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZBSm-0008Fk-Tv
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:51:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZBSk-0006mg-I3
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:51:08 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFhfGB783280
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eVQk100+1WRqU0mHBJGNJNpqEEjtfPZtTxC0PquLP2k=; b=M9FIBlNIgtCHTp3z
 bW9/rFjDISck2g9p7AvyHbPJjb/tH/bVrfaUhqdz0L8EIf2g3donh5K8k8w8Zt79
 nU8SDnOsqm4wkgxmHQufiPt3jqB/poTtRSYDDWEC93fZU/LwP/EFDR5lyB1knWYc
 e/Z0ftIcVqH8YGYh4UA0qybnlUMK58YS+aUbeOEsdCJOzgDL1Fmltg3WAfxlsyxt
 fSAf7pOQbF9B4FIhrumECaRhbNedXRr/jBoeC4x1x9Xp7EcIV5WFmPZBuiX2qqqf
 /DteU2DvJCCPajYJxFs+Lj1TlEOpS6lRgb47iqFTnc1odt1LXdY8cHXoDtfhEIRe
 oJw2Lw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etevx23ac-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:51:05 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304b8d0ee63so5830624eec.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 10:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781545865; x=1782150665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eVQk100+1WRqU0mHBJGNJNpqEEjtfPZtTxC0PquLP2k=;
 b=OxZtm/VYCiylWsnN+6lUnTl9Jcp/CBGHrhRMIgpC6zHf0rTu01ynqQ/pQuIgif+ivg
 5B68+Ys4JFuqiMSIourWRK8EpTayOdTdP0K3A9wyFmazxmz5aPQ+DtYfLNIOkQ8FM2Co
 EXqS5sV3xgYp7NH2qDROwEqojF4tlu+3qyQlPKd0klbNl4/kA9oaLEjaPBoVXsq7efGq
 /qPDP0ycb909HMm9y/ycix7NRuWu0KUn8NiYCEvTdcLaqQmXA1xZJau3lc5k6+vpR0Ik
 fsB3gqpeo4hLQeAQ6dIDiGD1R8Fpk6k/vtviiYHukDlinZYV2CXfcTb1aHa0k6wcUgz3
 UXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781545865; x=1782150665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eVQk100+1WRqU0mHBJGNJNpqEEjtfPZtTxC0PquLP2k=;
 b=nM9QR9yCuTsCWOVyjR3huSzwYautl8kcY+rLIosPrae3vpf2mbWVcz/TnPCKXJ/F+v
 KSYEC+PkyDGEQmJ5hVPat9qPf9OyIdc17BD6QUDMk0bsxv6luO1e1W0UvcRreLTLsnMt
 Oi1AXs6j7aaDA7io4zTI4Z6HvfnB31JeuL+CwXpKb3xUM7CNKTdivJLkM7C8w6K73rXY
 gh9cZO0qwFO5/OEADuis2/GWPG9ve3Hfp6fuY/ox9pCBHIcpYcCVNGwWGHKUrXks8XlX
 8/DjhNnokq9ktctW1lebVn7j4xTxWvn86wvZxF76lWBxxwbK/0LcuhkrVuTGz49JfS7k
 ABGg==
X-Gm-Message-State: AOJu0YxgC6uzqMd7XtphYQJOtvPQPHHsfZ+IW6wle0ThRXLQlf1xS2iI
 A5+vwK5VryFVc8duv0uDEyFRUoUNGL1Yqd8Q8BxNHBnnpe9WZGNmOlx7FfhmKSAGGJnx9gr6J8n
 8ixPwJeJxWCeK674bAC5FS65q2q0yqyFdk7yPCPjReGmWWWeI25cCrcrqsZBn+TR6ZV7f
X-Gm-Gg: Acq92OF+a3QkjrfEw5tgavp5vBwKoM9fHZJ085y/KgWdiqDkSKejF5GrdxrpkQTH27Q
 f40ro1xmyWYg2rmkSbvff8LOisJz+YWcR21onaziZzwN2K+BF4IFQJ/omOhNtBTIK4PkSIdqKQr
 7fp+O5ZKClnmwXtJNUXCaPRwhhIVltLjdRsZl650NGUjTUJBQoRnv7mHK3+W0pV4ZmmcdE8A3bR
 aLgK4XOsdxpAq/3LxMFKUFppCYE2z+YmC6hUA3z5chCsKizflwBcMIrOwJgMVSyalTtxgurQCVm
 tRDpWZzKdoNdv8Ed9xihIWyy7D1Nh3AxfcL1UgVcy1ZOfDDgWnEh2vSm9Z6VMyT1Y5y7nRuhNo3
 8UMtu64j6lPXqJpw2DjEwDrkIxuGSUE9i/ct9h2U9xheXy1Yf/gtU+vqUlj2ueLyrJCc7juETqS
 g8JMhA3w==
X-Received: by 2002:a05:7300:b913:b0:304:b14:ec53 with SMTP id
 5a478bee46e88-3093e39f75emr5888648eec.27.1781545864448; 
 Mon, 15 Jun 2026 10:51:04 -0700 (PDT)
X-Received: by 2002:a05:7300:b913:b0:304:b14:ec53 with SMTP id
 5a478bee46e88-3093e39f75emr5888612eec.27.1781545863886; 
 Mon, 15 Jun 2026 10:51:03 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5cea89sm16816037eec.8.2026.06.15.10.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 10:51:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 5/5] tests: remove ubuntu2204 container
Date: Mon, 15 Jun 2026 10:50:52 -0700
Message-ID: <20260615175052.2751738-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615175052.2751738-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615175052.2751738-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _rNcLrfOf8xcfO-0Wpk6lTIyjLuCtdRD
X-Proofpoint-GUID: _rNcLrfOf8xcfO-0Wpk6lTIyjLuCtdRD
X-Authority-Analysis: v=2.4 cv=f8t4wuyM c=1 sm=1 tr=0 ts=6a303b89 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=p0WdMEafAAAA:8 a=danhDmx_AAAA:8
 a=S56xvJB5AAAA:8 a=hrA9KEnTT8eVkNhlHiQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4OSBTYWx0ZWRfX5XALOb5Z4EN+
 nued1RY5wh5SWN4HAsCbf3q3uJREkzCVU2z+GY1lIuP+fQQo1jFNAXdhkIflokSegqPVSoomG1y
 E/21H92UpmTzLJEvfq4A8BeRtWrWdDE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4OSBTYWx0ZWRfX793H7yyUtJCO
 xPa1+xWb9WFhz2lJnikoQsKQz/ARSZbQjjKEESAc8zihHje0uj8sjJACjW+BqtgvbO35EjlEJsE
 JzX8XOyi4gy+qsu4jawkBQqjFxsMwiB/P+onleDVW7nTtcPAU9ghYiUxgY8s7QtvWjohuEr9vtE
 540esmnWs/BH3cmE9r0nFpAlWGCTt+LB8RYotPeTnbwKj+QmlJx1goVsWxXmR1LSfF2VOAinkVh
 BcLlg6IdYFVZL38cOsgTWR7EuUB0P28ga3KRhBIdkDQrJJbDhjBQsKBYWy4VA8rDxtUV45oT36v
 UnzrdoxY8RU6sjB6HbVuWl90cEMUT0zdLXb/RevRmNJNhDDff6QazdiCXfLgPDAv1hT7pqX9ECs
 PHIVuoG14ncDiDuy3PKYCmN0Bs96lv511kzbFapTdkJk5eMPsbn+/+RQzNyptvKrWXlOJMqngQU
 wI9eaAFyQz3hbf9nwqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150189
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
Link: https://lore.kernel.org/qemu-devel/20260610192222.2709135-6-pierrick.bouvier@oss.qualcomm.com
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


