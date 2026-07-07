Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F36C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 21:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whDdK-0002H7-UW; Tue, 07 Jul 2026 17:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whDdH-0002G7-Eb
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 17:47:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whDdE-0003KX-0S
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 17:47:11 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667J5qLr496534
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 21:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=0CpwMOQYz+V
 CqfvBm5xl0keC8nvP3TGW0RHIRo1ry+4=; b=hLuW+l2UB9sbXLzwdYI2lQwg3b6
 eXV3pu+V1ORRtX1ilnStCfPIbtghlNpf5vMZnYRKRH1AIUxuFyDqFPLt/im8kCXW
 X4QxSMrI2u0EyRzNKkE7qc8aL3wuMWfrfaKjmXWXqdkqfr0HSYHEJgHjFeZPKHlb
 c5BJbiSwCeiNJITnlq4CmV1j2/fsayiaklcc++DeVFFvcaMkkewIjMY2Is1fAITC
 ECsgPXzq3Ucn+jluckvwFpGKcjlAk0/GrxNS9zATRKA09fwxBqx9OoFQDQIPTSeh
 DUL6oZrtWJXykutg/s6GIFs9dJDouEKEv19GHk9Z9DrDc6XzKTO140EzXxQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8ye0jwu2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 21:47:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cce02cb769so591295ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 14:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783460824; x=1784065624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0CpwMOQYz+VCqfvBm5xl0keC8nvP3TGW0RHIRo1ry+4=;
 b=M+ZxWOJoFOaJm8c2+OPVt1GEtIgHa1BUfx8yhgwKQbnpc/VVpT73LH0sJgJbO18e1w
 AE9GHbHs7M6lajgiPrXBfaE0TCwgVxGa+iO0qtQ3FQHtYk0APbUNgJSyMyWcfN0xwK/L
 a4yxecbRWi72XRQnm8SBJDH6UB7suI7d8eiilyNSwZLQlL8NwuLHCAfzU31lgfxorF1I
 az4DBAHnI7S/D14DHV7ZTF61Hpc76wLfehXklOR5KYRgejf8PYsJXoi3Z0TtjzHbNWXw
 dBABpD6KmIXC1JqveRFeE12Khf5lpeUKfOLVJaM/6Jru25osorg/ctonHf/qlLgIqF55
 ZzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783460824; x=1784065624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0CpwMOQYz+VCqfvBm5xl0keC8nvP3TGW0RHIRo1ry+4=;
 b=kWSvL3VCZ1Xlcet5WLjknBCGJthJQgv7Qmwh1zvBRJUOvZjonOdlffNgwiw7dcDZqo
 zQXhBz7ejXxB1PTPRBMxbwl6Y48YqIon0Df1OVKwnv7H0oG8U6eSnVVymJ3vjjmXBXrc
 w9Dmmytcv6kT/Zk/0nIrqiA3J62opL1r4ASnsIK4t1VhlaTByov0214+k+XZFjsBUkGl
 ypGYOHx+fXygZU6p0fXCcyW6/rhLx3MgFfsLcs1d4HVgaE5sQ3tC/lgjIMb30yhwAfyt
 ZhQ6Zs3xUyJmuZo9EQnGq0Jv0OdfjBFvh0cfEi9JXanoC/eqGGwTNrKoQ8+sy6R1lrz2
 thww==
X-Gm-Message-State: AOJu0YyGeWqdN1asRKuQ+Qm9piE6JXvfvFPBO4bfvSlEKjc7NNaquKWi
 V0KaFbVtfT0IdYL+oHeRBgNrlKMJj42/PWFgyk/xJo5Hw7d8WZii2QtZt+deeR89SFY3pIxD0hE
 3+Hd7NUyuRhrqe6j8/ltilgndJAXs0j5iXrk8CzmLqo9bC4vefOe/JQdn0iZfn0fWLA==
X-Gm-Gg: AfdE7ckrJ/Nf5P5s6MFhAkZHGM4GP4IoTB5PuX8Rrmib4Wp1oLZaIStX4lVHQvYfXd2
 BfqcHmHD3Mh3zeM7VySA53gyllV1XL9kN/+fkCjgYkIi0fioXNvklXoohk0fRwv2WCByJSbH65y
 iVli/3Dff5PWT3I2gJeXRDRmngjJyd3sFoLnRQqOyoRX/94KHUGP2QLYKpTzjD33+hsQhKg+whE
 xxd2PujHDMZqlxYRoU4QJWao8oy6dkckquOQBvwjy2efebF1AwSKXZfR7ZTifGrWBmBg7DNDvPa
 WDJIKboJltNYTfzJc4c97JG4+8f3sY81b8MCQGDEfqyF1nGqnN6XCDejKkgG4lNrl+RfevIWOyU
 M3twJjaQJ2Sx+C+cF/RR92n+eDjZIWhrtkZZQtVJeCUfiRFb+9q2XTkh09PNRVJSJMA9pic7V
X-Received: by 2002:a17:902:ec85:b0:2c6:a012:6241 with SMTP id
 d9443c01a7336-2ccbe3f7d69mr69741665ad.6.1783460823527; 
 Tue, 07 Jul 2026 14:47:03 -0700 (PDT)
X-Received: by 2002:a17:902:ec85:b0:2c6:a012:6241 with SMTP id
 d9443c01a7336-2ccbe3f7d69mr69741415ad.6.1783460822980; 
 Tue, 07 Jul 2026 14:47:02 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdcbe2sm18368045ad.9.2026.07.07.14.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 14:47:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 berrange@redhat.com, mjt@tls.msk.ru
Subject: [PATCH 1/4] tests/lcitool/refresh: use raw string literal for trailers
Date: Tue,  7 Jul 2026 14:46:52 -0700
Message-ID: <20260707214655.1138626-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707214655.1138626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260707214655.1138626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CZqs2TtuQlUdsAXVDY2fNz-TpGgxY_Bd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDIxMyBTYWx0ZWRfX3WkU4D0qAYtA
 0BYWquOFtnhy1wEkNf5VV8Qs7VaocsG2KCtK5gjAYOiEfeKkyDWLhHJMogxP2DMzfYUOF3TkRk0
 RxC3E/i4IYe9WmkNpGrw0ui+jM8Hl9A=
X-Authority-Analysis: v=2.4 cv=SZfHsPRu c=1 sm=1 tr=0 ts=6a4d73d8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=kmYkUENqAAAA:8
 a=NEAV23lmAAAA:8 a=ei4SEBeUAAAA:8 a=EUspDBNiAAAA:8 a=n6MYwUk4AAAA:8
 a=htwMjFDFCaSGexkR5EAA:9 a=1OuFwYUASf3TG4hYMiVC:22 a=p9kz6gysRiz6SGr9lVkz:22
 a=8zIOOLb7Ym0NljyPXbuS:22
X-Proofpoint-GUID: CZqs2TtuQlUdsAXVDY2fNz-TpGgxY_Bd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDIxMyBTYWx0ZWRfX/HGRTFgg6ASc
 /3/i1jwa9fS1dYs8oPw0lcaqSuvlfVLLduB2661z6XvJvmnmDiB+fq/ReaK6j2yXw3ir0UAL1Eb
 h4G7uNPohsww1XDxgKr/P4P+QOhwFJffaV50GJDEmsvbEWnDa6BWL43Cwtl0FAnaQ6VzuoHXdrz
 6eSNxuQTv9W/qIe/Uk91DAIjLuHaQF3Rl6Bt5OvdkpmYItUjR2hu3IDMYOO56GSrTLi4rvBjMLg
 ASFRN81bJvyPQa0PF3uKWIpzyrL0IKvWsIGbfGs1/BEJctaCOSxf5mLEnB01NPoYAxIID+KGTyA
 4A8S635T+E8+QdBNNV6/7PJKiseTC0EXDSvp9m/H38XfI0CzZJ5Ke8JxzzUNcKtSKEWSuSEaaOC
 p/qzWt0gVFHMc+P5tV6fCwZGP3ZOOsEgl3538rsJeXHP1jmft3oE19EvdDDqaNm/KlDK27JfKX4
 ys7a1+3T3EnJzfq2KeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_05,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070213
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

Using a list of string is not convenient, as users need to escape it
manually and handle end of lines. By using a raw string literal,
what you see is what you get.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/lcitool/refresh | 209 +++++++++++++++++++++---------------------
 1 file changed, 105 insertions(+), 104 deletions(-)

diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index e0da0d2de1d..1fdd37440c9 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -72,6 +72,7 @@ def generate_dockerfile(host, target, project="qemu", cross=None, trailer=None,
     cmd.extend([target, project])
 
     if trailer is not None:
+        trailer = trailer.strip() + "\n"
         trailer += "\n".join(add_user_mapping)
     else:
         trailer = "\n".join(add_user_mapping)
@@ -100,113 +101,113 @@ def generate_yaml(os, target, arch, trailer=None):
     generate(filename, cmd, trailer)
 
 
-alpine_extras = [
-    "# https://gitlab.alpinelinux.org/alpine/aports/-/issues/17463\n",
-    "RUN apk add clang19-libclang\n",
-]
+alpine_extras = r"""
+# https://gitlab.alpinelinux.org/alpine/aports/-/issues/17463
+RUN apk add clang19-libclang
+"""
 
 # Netmap still needs to be manually built as it is yet to be packaged
 # into a distro. We also add cscope and gtags which are used in the CI
 # test
-debian13_extras = [
-    "# netmap/cscope/global\n",
-    "RUN DEBIAN_FRONTEND=noninteractive eatmydata \\\n",
-    "  apt install -y --no-install-recommends \\\n",
-    "  cscope\\\n",
-    "  global\\\n",
-    "  linux-headers-generic\n",
-    "RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/netmap\n",
-    "RUN cd /usr/src/netmap && git checkout v11.3\n",
-    "RUN cd /usr/src/netmap/LINUX && \\\n",
-    "  ./configure --no-drivers --no-apps \\\n",
-    "  --kernel-dir=$(ls -d /usr/src/linux-headers-*-$(dpkg --print-architecture)) \\\n",
-    "  && make install\n",
-    "ENV QEMU_CONFIGURE_OPTS=--enable-netmap\n"
-]
+debian13_extras = r"""
+# netmap/cscope/global
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+  apt install -y --no-install-recommends \
+  cscope\
+  global\
+  linux-headers-generic
+RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/netmap
+RUN cd /usr/src/netmap && git checkout v11.3
+RUN cd /usr/src/netmap/LINUX && \
+  ./configure --no-drivers --no-apps \
+  --kernel-dir=$(ls -d /usr/src/linux-headers-*-$(dpkg --print-architecture)) \
+  && make install
+ENV QEMU_CONFIGURE_OPTS=--enable-netmap
+"""
 
 # Based on the hub.docker.com/library/rust Dockerfiles
-fedora_rustup_nightly_extras = [
-    "RUN dnf install -y wget\n",
-    "ENV RUSTUP_HOME=/usr/local/rustup CARGO_HOME=/usr/local/cargo\n",
-    "ENV RUSTC=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustc\n",
-    "ENV RUSTDOC=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustdoc\n",
-    "ENV CARGO=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/cargo\n",
-    "RUN set -eux && \\\n",
-    "  rustArch='x86_64-unknown-linux-gnu' && \\\n",
-    "  rustupSha256='6aeece6993e902708983b209d04c0d1dbb14ebb405ddb87def578d41f920f56d' && \\\n",
-    '  url="https://static.rust-lang.org/rustup/archive/1.27.1/${rustArch}/rustup-init" && \\\n',
-    '  wget "$url" && \\\n',
-    '  echo "${rustupSha256} *rustup-init" | sha256sum -c - && \\\n',
-    "  chmod +x rustup-init && \\\n",
-    "  ./rustup-init -y --no-modify-path --profile default --default-toolchain nightly --default-host ${rustArch} && \\\n",
-    "  chmod -R a+w $RUSTUP_HOME $CARGO_HOME && \\\n",
-    "  /usr/local/cargo/bin/rustup --version && \\\n",
-    "  /usr/local/cargo/bin/rustup run nightly cargo --version && \\\n",
-    "  /usr/local/cargo/bin/rustup run nightly rustc --version && \\\n",
-    '  test "$CARGO" = "$(/usr/local/cargo/bin/rustup +nightly which cargo)" && \\\n',
-    '  test "$RUSTDOC" = "$(/usr/local/cargo/bin/rustup +nightly which rustdoc)" && \\\n',
-    '  test "$RUSTC" = "$(/usr/local/cargo/bin/rustup +nightly which rustc)"\n',
-    'ENV PATH=$CARGO_HOME/bin:$PATH\n',
-    'RUN /usr/local/cargo/bin/rustup run nightly cargo install --locked bindgen-cli\n',
-    'RUN $CARGO --list\n',
-]
+fedora_rustup_nightly_extras = r"""
+RUN dnf install -y wget
+ENV RUSTUP_HOME=/usr/local/rustup CARGO_HOME=/usr/local/cargo
+ENV RUSTC=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustc
+ENV RUSTDOC=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustdoc
+ENV CARGO=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/cargo
+RUN set -eux && \
+  rustArch='x86_64-unknown-linux-gnu' && \
+  rustupSha256='6aeece6993e902708983b209d04c0d1dbb14ebb405ddb87def578d41f920f56d' && \
+  url="https://static.rust-lang.org/rustup/archive/1.27.1/${rustArch}/rustup-init" && \
+  wget "$url" && \
+  echo "${rustupSha256} *rustup-init" | sha256sum -c - && \
+  chmod +x rustup-init && \
+  ./rustup-init -y --no-modify-path --profile default --default-toolchain nightly --default-host ${rustArch} && \
+  chmod -R a+w $RUSTUP_HOME $CARGO_HOME && \
+  /usr/local/cargo/bin/rustup --version && \
+  /usr/local/cargo/bin/rustup run nightly cargo --version && \
+  /usr/local/cargo/bin/rustup run nightly rustc --version && \
+  test "$CARGO" = "$(/usr/local/cargo/bin/rustup +nightly which cargo)" && \
+  test "$RUSTDOC" = "$(/usr/local/cargo/bin/rustup +nightly which rustdoc)" && \
+  test "$RUSTC" = "$(/usr/local/cargo/bin/rustup +nightly which rustc)"
+ENV PATH=$CARGO_HOME/bin:$PATH
+RUN /usr/local/cargo/bin/rustup run nightly cargo install --locked bindgen-cli
+RUN $CARGO --list
+"""
 
-ubuntu2404_rust_extras = [
-    "ENV RUSTC=/usr/bin/rustc-1.83\n",
-    "ENV RUSTDOC=/usr/bin/rustdoc-1.83\n",
-    "ENV CARGO_HOME=/usr/local/cargo\n",
-    'ENV PATH=$CARGO_HOME/bin:$PATH\n',
-    "RUN DEBIAN_FRONTEND=noninteractive eatmydata \\\n",
-    "  apt install -y --no-install-recommends cargo\n",
-    'RUN cargo install --locked bindgen-cli\n',
-]
+ubuntu2404_rust_extras = r"""
+ENV RUSTC=/usr/bin/rustc-1.83
+ENV RUSTDOC=/usr/bin/rustdoc-1.83
+ENV CARGO_HOME=/usr/local/cargo
+ENV PATH=$CARGO_HOME/bin:$PATH
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+  apt install -y --no-install-recommends cargo
+RUN cargo install --locked bindgen-cli
+"""
 
-debian_all_test_cross_compilers = [
-    "# extras for cross and alternate toolchains\n",
-    "RUN DEBIAN_FRONTEND=noninteractive eatmydata \\\n",
-    "  apt install -y --no-install-recommends \\\n",
-    "  clang\\\n",
-    "  dpkg-dev\\\n",
-    "  gdb-multiarch\\\n",
-    "  libclang-rt-dev\n",
-    "ENV AVAILABLE_COMPILERS=\"\\\n",
-    "  gcc-aarch64-linux-gnu \\\n",
-    "  libc6-dev-arm64-cross \\\n",
-    "  gcc-arm-linux-gnueabihf \\\n",
-    "  libc6-dev-armhf-cross \\\n",
-    "  gcc-alpha-linux-gnu \\\n"
-    "  libc6.1-dev-alpha-cross \\\n"
-    "  gcc-mips-linux-gnu \\\n",
-    "  libc6-dev-mips-cross \\\n",
-    "  gcc-mips64-linux-gnuabi64 \\\n",
-    "  libc6-dev-mips64-cross \\\n",
-    "  gcc-mips64el-linux-gnuabi64 \\\n",
-    "  libc6-dev-mips64el-cross \\\n",
-    "  gcc-mipsel-linux-gnu \\\n",
-    "  libc6-dev-mipsel-cross \\\n",
-    "  gcc-powerpc64le-linux-gnu \\\n",
-    "  libc6-dev-ppc64el-cross \\\n",
-    "  gcc-riscv64-linux-gnu \\\n",
-    "  libc6-dev-riscv64-cross \\\n",
-    "  gcc-s390x-linux-gnu \\\n",
-    "  libc6-dev-s390x-cross\\\n",
-    "  gcc-sh4-linux-gnu \\\n",
-    "  libc6-dev-sh4-cross \\\n",
-    "  \"\n",
-    "RUN if dpkg-architecture -e amd64; then \\\n",
-    "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross\"; \\\n",
-    "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross\"; \\\n",
-    "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-powerpc-linux-gnu libc6-dev-powerpc-cross\"; \\\n",
-    "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross\"; \\\n",
-    "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross\"; \\\n",
-    "fi && \\\n",
-    "DEBIAN_FRONTEND=noninteractive eatmydata \\\n",
-    "apt install -y --no-install-recommends \\\n",
-    "${AVAILABLE_COMPILERS} && \\\n",
-    "dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt\n",
-    "ENV QEMU_CONFIGURE_OPTS=--disable-docs\n",
-    "ENV DEF_TARGET_LIST=aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user\n",
-]
+debian_all_test_cross_compilers = r"""
+# extras for cross and alternate toolchains
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+  apt install -y --no-install-recommends \
+  clang\
+  dpkg-dev\
+  gdb-multiarch\
+  libclang-rt-dev
+ENV AVAILABLE_COMPILERS="\
+  gcc-aarch64-linux-gnu \
+  libc6-dev-arm64-cross \
+  gcc-arm-linux-gnueabihf \
+  libc6-dev-armhf-cross \
+  gcc-alpha-linux-gnu \
+  libc6.1-dev-alpha-cross \
+  gcc-mips-linux-gnu \
+  libc6-dev-mips-cross \
+  gcc-mips64-linux-gnuabi64 \
+  libc6-dev-mips64-cross \
+  gcc-mips64el-linux-gnuabi64 \
+  libc6-dev-mips64el-cross \
+  gcc-mipsel-linux-gnu \
+  libc6-dev-mipsel-cross \
+  gcc-powerpc64le-linux-gnu \
+  libc6-dev-ppc64el-cross \
+  gcc-riscv64-linux-gnu \
+  libc6-dev-riscv64-cross \
+  gcc-s390x-linux-gnu \
+  libc6-dev-s390x-cross\
+  gcc-sh4-linux-gnu \
+  libc6-dev-sh4-cross \
+  "
+RUN if dpkg-architecture -e amd64; then \
+  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross"; \
+  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross"; \
+  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc-linux-gnu libc6-dev-powerpc-cross"; \
+  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; \
+  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; \
+fi && \
+DEBIAN_FRONTEND=noninteractive eatmydata \
+apt install -y --no-install-recommends \
+${AVAILABLE_COMPILERS} && \
+dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt
+ENV QEMU_CONFIGURE_OPTS=--disable-docs
+ENV DEF_TARGET_LIST=aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
+"""
 
 def cross_build(prefix, targets):
     conf = "ENV QEMU_CONFIGURE_OPTS=--cross-prefix=%s\n" % (prefix)
@@ -223,20 +224,20 @@ try:
     # Standard native builds
     #
     generate_dockerfile("alpine", "alpine-323",
-                        trailer="".join(alpine_extras))
+                        trailer=alpine_extras)
     generate_dockerfile("centos9", "centos-stream-9")
     generate_dockerfile("debian", "debian-13",
-                        trailer="".join(debian13_extras))
+                        trailer=debian13_extras)
     generate_dockerfile("fedora", "fedora-43")
     generate_dockerfile("opensuse-leap", "opensuse-leap-16")
     generate_dockerfile("ubuntu2404", "ubuntu-2404",
-                        trailer="".join(ubuntu2404_rust_extras))
+                        trailer=ubuntu2404_rust_extras)
 
     #
     # Non-fatal Rust-enabled build
     #
     generate_dockerfile("fedora-rust-nightly", "fedora-43",
-                        trailer="".join(fedora_rustup_nightly_extras))
+                        trailer=fedora_rustup_nightly_extras)
 
     #
     # Cross compiling builds
@@ -293,7 +294,7 @@ try:
     generate_dockerfile("debian-all-test-cross", "debian-13",
                         project="qemu-minimal",
                         enable_rust=False,
-                        trailer="".join(debian_all_test_cross_compilers))
+                        trailer=debian_all_test_cross_compilers)
 
     #
     # GitLab packages lists
-- 
2.47.3


