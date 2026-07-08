Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0931C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whVRu-0008ES-Sn; Wed, 08 Jul 2026 12:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whVRb-0008D5-4t
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:48:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whVRW-0003pK-9q
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:48:18 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668GLBsX3329678
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 16:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lzFQF1HUV2G1E8HXl9nba8YS04p5FmbwZWCKMbZOfD0=; b=Jp+7ns6XPPnN78W2
 cHYBBejpaIUZKdLN5xovFu5MKT42lQrh+/yHk0qh3CFhZp8963N9JQeQXoSFjRuz
 mJlGIDEGHiblABrYol1/YOp8cYH+YCl8MShFcCOAr+YmsuyNcJuOixdS7Z5FiptC
 NvolXpGWaMdAElssilK9FLOG1lLlcefGoVg7JYWC68bSz2sGPkxzrSZQkXXN1xQc
 qrwQ1QWEff5nYBnz7VsMpdZdgU1Efg4sYIdAbhVYJbMwNlxP4XrJcp7kfScf1hAP
 MBxW9VYDgvI6HqWguQugiJ3G3zXgQp8Zef+WMAi8SshKuz2t8GqMErIP2yPpOM2t
 MGMPqg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9hnv2ggd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 16:48:12 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-380a638fb5bso1056331a91.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 09:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783529292; x=1784134092; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lzFQF1HUV2G1E8HXl9nba8YS04p5FmbwZWCKMbZOfD0=;
 b=JJrvn2uenSWkDZKOzBFln1btyB+q0LJCWGpK2huH5D8rfBp2L7dWYRovWLI8DcHsnt
 4f2HA8Kp1Q/+JVIBZleHQYAYAeQLS33qGgVucLmzjONelt0ht0oAiOTxiiw3jBkbLwdg
 0ELbnXBcyFA7DFov7e8PLIwjOd1ae9Xzcdu97s1hfDPi6/UOAPL80SK8js1BFTRvIobg
 AAF3iEQ/1ZYZP5tEQHHJJEgaHxoGj1Ol5bHG9omBr884ZE4rvkcG16GL/pcJ1sEaiM77
 +fvz5Lo4/h0zOgmgeTv8VCTtbBTcXxHTC+qCbNLL8YrZQzQaPfcnhacwEVXpnhFQd572
 mafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783529292; x=1784134092;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lzFQF1HUV2G1E8HXl9nba8YS04p5FmbwZWCKMbZOfD0=;
 b=gmHeKFFo60xoNGui5HVUGVZg0iMNmrQlFaftYNcKF07lRcUSAdO+ELz/T37Zrdn48B
 Xm622FvGaT0+jkxqLHayy7VwIz9QuKZt4J2hnLtdVkHJBz6Oh8imx49DLP4wWAyl1T/X
 dw232c7YsX1BW+Z9OoraS42uqTXShXAnJAzXFgmiGQqKBiBZS2+vMHQ8NmPie0Ey8Oju
 KvbjE4mw2kVn07+r+edM2jOemZla33egzxWOduzunaY1D/07ntWHFDdJojfi4K177QFJ
 ANWmvHPQ0OApxXgup3yzfojwma60SACnULknjrzxBKDZAuuxW4n1+5rKm3nGLzQYrzLf
 S4Rg==
X-Gm-Message-State: AOJu0Yybanb8xuJcCD1SwrRfmgoVItbrQhOnvTv5LatY+dwirF9iYwJx
 0/pfK+KXLElnKuOlWCN+7pczHt7sd4HDYatLhuq9UqVOKGBRoIInDeZNa3Wqy5eBL3n7LzSgQ1Q
 Ed7sWV9nIi9DzCrkJouy41IfzO0kYyeBrRYNuOuTe7YKkUp9V4U8TAW4HsHGIUA2fOg==
X-Gm-Gg: AfdE7cltQMluiV3vDihg4GLgcEm4P9jQT4R+RQmzmWXr6fuxGk6jPJg03lvlH/ypzEI
 qUFCotdCEXKgltet1NC7w8slJdVqCbdzQitDLn29QfpGSmVJ+3qimqGo0ufhZ+0UfaDDm26uhtU
 kqCz442t7mXk6b4ZSLSSKlelCL+0AsMEYPfKnVkVvq+eUbFMGG4LLuwIyoqcXwWzmPZOCjhIZZ0
 OC5dqfo1K20yoE+8yi+IZ/CA4ReS4jS3arAvDJwtJktkhzPoWWtdwUIH64WRkfvJTqttzo4YGQV
 9UyrW53HK1+lxsWgXUG0DnA3fndd4pa0i8hlK7dizg3NDRi0xedjGwQZLJadnTpBa6tuOGmerpR
 tIdsJGSDA3MNrufeUgB2npscp6wSh7QA488+0++R76lfrwQ1hcdQ4npwklpAjKmrkuqIYv/KroB
 iIFte29Q==
X-Received: by 2002:a17:90a:e70d:b0:37f:9ce1:7360 with SMTP id
 98e67ed59e1d1-38941fb72e4mr3191124a91.33.1783529291794; 
 Wed, 08 Jul 2026 09:48:11 -0700 (PDT)
X-Received: by 2002:a17:90a:e70d:b0:37f:9ce1:7360 with SMTP id
 98e67ed59e1d1-38941fb72e4mr3191090a91.33.1783529291084; 
 Wed, 08 Jul 2026 09:48:11 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f5975sm20603290eec.4.2026.07.08.09.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 09:48:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/4] tests/lcitool/refresh: use raw string literal for trailers
Date: Wed,  8 Jul 2026 09:47:55 -0700
Message-ID: <20260708164758.1168667-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708164758.1168667-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260708164758.1168667-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KNNqylFo c=1 sm=1 tr=0 ts=6a4e7f4c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=kmYkUENqAAAA:8 a=NEAV23lmAAAA:8
 a=ei4SEBeUAAAA:8 a=20KFwNOVAAAA:8 a=n6MYwUk4AAAA:8 a=htwMjFDFCaSGexkR5EAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=p9kz6gysRiz6SGr9lVkz:22 a=8zIOOLb7Ym0NljyPXbuS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE2NSBTYWx0ZWRfXzN6H95u/JneG
 YnsPcyIaYq+DzP+wJp+HfNuqe1fcRc/G1VEH3P6asSLDU6yiYK0/phKznGM//rsA2QDhBJI7cDi
 WNER7+/F0Rf6DuppW/I3yC4chIBFTvs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE2NSBTYWx0ZWRfX1woOfuu5/x3F
 oaLwdg530pBFiimZ1Ce25XdbtIG3x4v/OA/KYRaNLo5jegmvgBoG5Pk8hju9EvrXik7WKUxtN0h
 SaTLwdDbYCDEuf/sXuzE3XG00U77L34/gZOF7UWshZj5gb8HxsmXITZ9KwWCYdoRovanDlBkJsP
 kSjx6m00tPNQb2P0KRznJ60INasRZQlqxNJ3vHS875HlvXxgmJJ1RZiZdBl4NQRiwSxMNxVDar3
 TCViTNLB3Wi+XqPmoeC/pu7y3R7OGeLbPcs58BzpajIewPrGuAvG68o+V9UhrRV93x4LIhO47F7
 bJEluvNxKGwQstzq2Ok5N/Jx729zNJt+SzEHjoy1LzdkX3X0f/menFQSg9BUTOfZVNEZYWZAKrR
 Wjce3BBpTYhL+c+XypUV8E6tkxJ0GdWewDQcao00Xtl/s6nqn3w/HAOF/Pm01N8CR4PD4mcOfKn
 dtWRXG+RppdPppRwevQ==
X-Proofpoint-ORIG-GUID: wtwrHszYUqfl3CntH2xCmTfMUvKri_lM
X-Proofpoint-GUID: wtwrHszYUqfl3CntH2xCmTfMUvKri_lM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_03,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080165
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260707214655.1138626-2-pierrick.bouvier@oss.qualcomm.com
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


