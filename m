Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4B7CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 17:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZBSm-0008F2-8t; Mon, 15 Jun 2026 13:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZBSk-0008Be-8Z
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:51:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZBSi-0006lA-6F
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:51:05 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFhJYL3139316
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0Go4pMLR/PIlnLsDVhCo0ntJu+fRdDyI/EJdpjzAaQ4=; b=GS4FexWj2rPrK8AL
 s+1rgvnxhafM2D3FPMG76VS73s4q+ethXuk3J/vm9kxrqChgSB61HcMnPMfYL1RQ
 +n9mkf5382S7L1fi3LhBPns0g6/Arki/x9SHMKWICJY/sqzSzJn+7nwKhxMb2Ern
 ruG1aOsMHGCP5PIhVWSsP0jBoKIqtTwEtWwQQM7T8Lsy7fVKYEDiUVuEeEVHLjgz
 37AMxxAh5C05naEHdheUrKy3ahZzjyUmZVrnYnE+ehHMjovfV/PTXARFqXjd7GY2
 uix37CQOFONY0bEmIX8Dm1KAdj8kIObolTpn/Ic3mTj+HlfXv3/mG6jp5hBOBPK1
 o5S/Kg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ete982a00-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:51:02 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304ed777a96so2377183eec.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 10:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781545862; x=1782150662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Go4pMLR/PIlnLsDVhCo0ntJu+fRdDyI/EJdpjzAaQ4=;
 b=eLU23EM3nX4qofij0SLTc7fVnzRyQ65Ur9u6ARkyEsor4VLGiayDI1pVwYsmvhiay7
 r5KP3Pcx8Xf1PLLu7leFo3FuLBqv+t5dZqKa06B9c8FjNGwbJrj1kXxZaFKbbZUI15+k
 9yPex99hbyHbtoRx4dgYVo2AYe63+OBrnfiUa7seCxaCeKMTLMhinHD/PsSOLwBWSTmb
 XnUTJn51wI9lPvM56XK6saADPC6376Ohow4IVXwe1NiigWTcA7JPw8kOixoJ4ZnwL0tK
 dUCXaccNHzsnuq97LQZ+3bp0nfdgcuAeR80oq0R6GA/W3yDBirYiP775lCdgAodciS+L
 phSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781545862; x=1782150662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0Go4pMLR/PIlnLsDVhCo0ntJu+fRdDyI/EJdpjzAaQ4=;
 b=S/14RukhD5hP51JrIxsCGalCYQSZRpaDbUg4uW6rSu8RfPU/OS27PbcrAxzNA5Vx1F
 5fWNRTz/Op822wNrQBxcdPytgmak0owWnP9bDbcb/5Nl6lGOMWJlUTm+KMupZq8e0DaU
 4Id31sinPZUqtsCdeJ+hPrmnC9p0ywyFlY5+bYwac1XzWKLIIeFjTLHc4rImx0E2k+df
 bkeueKv3BzN8SNgXKWEnxMDP6zr/g2UYrnTXmHjpeE8Y6mRvYrmiiatZoKyuXfXOxrpQ
 5IPUIbg6PBjabOp22WVYbIEFGI5qSDEQv3JcSyF1NCVhcEVYXGkKRMr6DOWji+KB2qv2
 66Bg==
X-Gm-Message-State: AOJu0YxA9dt6pRjWoIYHwsHpkHDHeVZL1QpHJvd5ExdjT+GoCk29zxl+
 F1EdsQh7knDdnxPXDoq6BetVNDC7MbeBInQzMe8fE4QE8z3d+NFFIgrq9E9YH4TUsjF2pFsR8+Q
 wa7Qu+SYhOZ4jxIOArI0jYyMBoUqkGLcvsBYH2h7UY0J2WIVtBgWaHRnbOadGfaYoBeLe
X-Gm-Gg: Acq92OEGO8DCLmmQO1meFNTyJUg7rpyXPLk0hwDmfJf5tPBtlr4BtYGur6H0S2Vf42q
 ExEO9KEF+YJaF21bX+JaupU/XGJPAtuMOdnPFYa8c55QEmygpAOhZSmPO8m3V5TBQN+2Sy4hbSZ
 i5WMdmakf3ilFNlU1aSfj1uP+aZuPntKpUsLKW9p0I1Cqe2kqxpotlLw+oGd4237DC60kbWBwJd
 JFhSosePLRf86mqiBNf6YoROckT/IGDSOzYROa8u6/yBb8lg55NlUn4f7iHwM1iQZuBsYDXoiAz
 d246FyMJ1jNWhao5kplxQiw5ZWnO+R94DGkA0h2s4CJIFJ4kbwtndOj9bF2jkf2X/gt2vM0VCPV
 FM0fUxbh27tGVZ2M5Xklz/Tfr5eMWUsQVnbquxG+VglBdZizvt7gk+iklFwH8Fiy91HwVuf2Wpx
 OjoagYeQ==
X-Received: by 2002:a05:7301:644c:b0:302:b44b:b64a with SMTP id
 5a478bee46e88-30ba32064fcmr345527eec.1.1781545861991; 
 Mon, 15 Jun 2026 10:51:01 -0700 (PDT)
X-Received: by 2002:a05:7301:644c:b0:302:b44b:b64a with SMTP id
 5a478bee46e88-30ba32064fcmr345504eec.1.1781545861349; 
 Mon, 15 Jun 2026 10:51:01 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5cea89sm16816037eec.8.2026.06.15.10.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 10:51:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 2/5] tests: add ubuntu 2404
Date: Mon, 15 Jun 2026 10:50:49 -0700
Message-ID: <20260615175052.2751738-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615175052.2751738-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615175052.2751738-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V5tNF+ni c=1 sm=1 tr=0 ts=6a303b86 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=p0WdMEafAAAA:8 a=danhDmx_AAAA:8
 a=S56xvJB5AAAA:8 a=zoz3a4UqGRdYwpjcZUAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-GUID: _u3Upyu08As7bvOVAY99U2Gb7zt-Jv0u
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4OSBTYWx0ZWRfX3OufC4vxgfqt
 OFqwosi809AKUZY1X/sZm9+tW59L5+lsQ4TIH1PlqZY62hGjMUCdMM5C+4bpa7CCoDUtfR5y1Fr
 BMFoX98DTkoV/+6IiiGm3yfBp+wrZIU=
X-Proofpoint-ORIG-GUID: _u3Upyu08As7bvOVAY99U2Gb7zt-Jv0u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4OSBTYWx0ZWRfX/9YEK22YybxC
 wzeh3jsAXYERe+fgs5vxrtJdePOqsQ1oEuBgFG0N3+sgQmxwMZC57+Lo8hZj3UtGA4anEKpzGFr
 Nq2GqsdzZK0m4qvSZq6nfUVrBhzMgyztr2kaa7x8SE7vCCYZYRgO7m2WebHhZ8RmfyCMZQ8DZaz
 syamXTtHeIhTINOE4p9qpUoxPfHRFlBb1K2EOC/2vG8Am4/XPiRMByB/AVB6/TIzMsAkqnxT+e8
 pHwZikiTW5AdWP/wnXzDpNnLwCt2arwVrl3FWMIig7HHck1F8pw2H70MEKQCrNUBsScYlQ8bvPK
 EkOAi6fevs+MainMVB0jkysIT8ta0/KLv9Nh92JXN9WQCYyXoCiOc03RYbXtqPuIs65HZyuCh7R
 RCVQ2Z0GguUKRCPW2QNxGrQJ4G8PmNC2y+GZ5SZB5xGQ8ql4PubePGpY2kf7H9stupOYW+rUWcq
 hys30pDjFzm1umeQBWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150189
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Link: https://lore.kernel.org/qemu-devel/20260610192222.2709135-3-pierrick.bouvier@oss.qualcomm.com
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


