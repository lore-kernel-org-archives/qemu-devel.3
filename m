Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1874ED149C0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Mor-000554-Hw; Fri, 25 Oct 2024 12:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mo9-0004v1-KK
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:05:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mo7-000500-TS
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729872299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k/4Em/H4v7wbvnwMZF2nZE5DI93vJeI1Nc1yPo99svY=;
 b=S3aZaqZZDW5VTntI1JumtHYef9qyIiJz1v/GaYFM30h8HHnmpyDOfunGhaIlBxMYIEDSOO
 dfgwCgFwMzwo9pvcDPojrSLMtkTYDe9l6KGJZ2Bu99ef1O+fAoc+/sJgQ/Kw7zO6Sol/I5
 UrfevjEoRZSJKlzn2N+aBOCyeTnZvqY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-X3187xKrMkm1mM9tb16fCA-1; Fri, 25 Oct 2024 12:04:58 -0400
X-MC-Unique: X3187xKrMkm1mM9tb16fCA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2fb3f99c9a7so15338891fa.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729872296; x=1730477096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/4Em/H4v7wbvnwMZF2nZE5DI93vJeI1Nc1yPo99svY=;
 b=gftxbpExwi68kCOjoXQ5J9CzliqRBHYFvSkqMi+3FeHCAOQeBcNlajc3OuTpEAM+W/
 j08i7D7ksNz3ouNhwX02FR68A9ccCCe4UM0DK2bYYi3Ez1UcMkFWwUkngTWQtI4qCrJ/
 VVKMKI9RCI0KcfkDBGs3HQwUgzmZk6+S/JMZDkk/ZW6PIwR9vcrC6lNJz/EPASiEzUKg
 ZiTkJlPnxjHpOh+IfsO7/fYWBnmRHexcgH89gKUx4Fam1g6hJKIy/exez9DiD+aaEJc9
 zQKDgKxi6Z/6PACLeM1Cc4UyjUcuVQiq8DHHhRVqnrMdQxacGJMJy31FUqxo09OIHq39
 coCw==
X-Gm-Message-State: AOJu0YxE8ep+pK8nhY4JJ/swS1y3HnNZ2luVRkJJP32HK17TPs2YlfK/
 bQmBdQn2ph2lvtjyv6mnBfsFwSjAWsXjJKIZFpXIqn5mu57GJ0YSMxY+LB0Z0ua7xKNXWE4sK3d
 sJc3JRTB8UpWhS/b3DkfbJme4SdS9HkFqHbQsQffDcoWKUY8b4dTT0CSIwoPyRKEunENi/KDXJB
 i6785qlpV1/3RuwplWCSa9TnvAfJCZMdw9F7uorwA=
X-Received: by 2002:a05:651c:2115:b0:2fa:dadf:aad5 with SMTP id
 38308e7fff4ca-2fca825aeb0mr40652461fa.28.1729872295382; 
 Fri, 25 Oct 2024 09:04:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB/trpaCte10LSF5OMXbss25QEhcpOwLdzH0N5OYTyrCXiT7hYtb14vZIlJ8iKsEuMzTYaWw==
X-Received: by 2002:a05:651c:2115:b0:2fa:dadf:aad5 with SMTP id
 38308e7fff4ca-2fca825aeb0mr40651921fa.28.1729872294727; 
 Fri, 25 Oct 2024 09:04:54 -0700 (PDT)
Received: from [192.168.10.47] ([151.81.112.43])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb6258683sm757360a12.20.2024.10.25.09.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:04:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: [PATCH 22/23] dockerfiles: install bindgen from cargo on Ubuntu 22.04
Date: Fri, 25 Oct 2024 18:02:07 +0200
Message-ID: <20241025160209.194307-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025160209.194307-1-pbonzini@redhat.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Because Ubuntu 22.04 has a very old version of bindgen, that
does not have the important option --allowlist-file, it will
not be able to use --enable-rust out of the box.  Instead,
install the latest version of bindgen-cli via "cargo install"
in the container, following QEMU's own documentation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/dockerfiles/ubuntu2204.docker |  5 +++++
 tests/lcitool/mappings.yml                 |  4 ++++
 tests/lcitool/refresh                      | 11 ++++++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dock=
erfiles/ubuntu2204.docker
index ce3aa39d4f3..245ac879622 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -149,6 +149,11 @@ ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
 ENV NINJA "/usr/bin/ninja"
 ENV PYTHON "/usr/bin/python3"
+ENV CARGO_HOME=3D/usr/local/cargo
+ENV PATH=3D$CARGO_HOME/bin:$PATH
+RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+  apt install -y --no-install-recommends cargo
+RUN cargo install bindgen-cli
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index 9c5ac87c1c2..c90b23a00f1 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -1,4 +1,8 @@
 mappings:
+  # Too old on Ubuntu 22.04; we install it from cargo instead
+  bindgen:
+    Ubuntu2204:
+
   flake8:
     OpenSUSELeap15:
=20
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 0f16f4d525c..a46cbbdca41 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -137,6 +137,14 @@ fedora_rustup_nightly_extras =3D [
     'RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-cli=
\n',
 ]
=20
+ubuntu2204_bindgen_extras =3D [
+    "ENV CARGO_HOME=3D/usr/local/cargo\n",
+    'ENV PATH=3D$CARGO_HOME/bin:$PATH\n',
+    "RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \\\n",
+    "  apt install -y --no-install-recommends cargo\n",
+    'RUN cargo install bindgen-cli\n',
+]
+
 def cross_build(prefix, targets):
     conf =3D "ENV QEMU_CONFIGURE_OPTS --cross-prefix=3D%s\n" % (prefix)
     targets =3D "ENV DEF_TARGET_LIST %s\n" % (targets)
@@ -157,7 +165,8 @@ try:
                         trailer=3D"".join(debian12_extras))
     generate_dockerfile("fedora", "fedora-40")
     generate_dockerfile("opensuse-leap", "opensuse-leap-15")
-    generate_dockerfile("ubuntu2204", "ubuntu-2204")
+    generate_dockerfile("ubuntu2204", "ubuntu-2204",
+                        trailer=3D"".join(ubuntu2204_bindgen_extras))
=20
     #
     # Non-fatal Rust-enabled build
--=20
2.47.0


