Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010CDD1CDCF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Br1-0005OD-5H; Tue, 22 Oct 2024 06:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3Bqs-0005Cs-AB
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3Bqp-0004Qm-Cv
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729591854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wXYKPERsSFUrXojLdSDlVUPkke/4VTh6P6Z9bxQslRA=;
 b=elAXQ18ZwuIfvB2TVzP0sig8naWomxGy75rXUnWxzNeuIPZiQP+loeZm2Rdg3s2xoLdrDU
 PM2v5ymFxhkxbGy668yBElFX2cVho0+4KlhBqAtL2OoClP7eXOEClygqT8XmXEYKKMhAqI
 +8riB22x/raC7XWtDb1skgsYxguTjQM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-2A9CNMs7MRCVXTfxV9fs1w-1; Tue, 22 Oct 2024 06:10:53 -0400
X-MC-Unique: 2A9CNMs7MRCVXTfxV9fs1w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-431518e6d8fso38190125e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729591851; x=1730196651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wXYKPERsSFUrXojLdSDlVUPkke/4VTh6P6Z9bxQslRA=;
 b=ISdxMFoP64otk+aSCW0grWyYdISTw57svAHJOR++pWBa1NigT0qnDeVwT2OsMR9J5y
 tTRw15nJMfquJyw19GB50BJSdniDEaJWEbD8EkhEcXZ/ruq0/8Dj1HZ120mq/SoJRZ3r
 3NdxCzf5gUmRWAuNYEj0HO7hKTSWIowvYt/tTAbPzG+zUzo2/bX2hmWK3tIQVKRlniti
 svpVbrSHnmpd2gvEuLCU/bSxcOcWieZluNQ/pUUQwfnh+5mjQblzrC9CQb4gjYhpiMS+
 bX7w/G931V01zlS5ojC2br64KA7/iJhhGKoVck5tul7Pk4ftVBTVXTcNJKX9dhxCY8I6
 6fyQ==
X-Gm-Message-State: AOJu0YwlmnK+k1q4mvVeOXURjWeqhZIsTJlAwtGXuzkaXIdUJtwxfB2x
 SwnbmoB2ZRmX9eY2LsBM8fnMKoD7Pca+x6IW2NBBUNwPAixbfMOlYPDQwo46Q5/WX6g9XXJr/2I
 1jOR3ap0C5l4o3zAAUWTbcKViDUfQbGN5X43sVIFvWCjDlsi+E0gB5/2oO2KFv4ZqPU9MT+gxRE
 4TApTX2XXMoebRhb9sg6z1Uc/jemaIHmW5FsDdk8c=
X-Received: by 2002:a05:600c:4ed2:b0:426:64a2:5362 with SMTP id
 5b1f17b1804b1-4316163b8bbmr111004625e9.8.1729591851217; 
 Tue, 22 Oct 2024 03:10:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENasJYl91Hg+yP66jIknw/gTZ0EeU7r9BvhomsSRp60/DrKVFy7AG/42ZwzSIhw7PyIV6ePQ==
X-Received: by 2002:a05:600c:4ed2:b0:426:64a2:5362 with SMTP id
 5b1f17b1804b1-4316163b8bbmr111004345e9.8.1729591850739; 
 Tue, 22 Oct 2024 03:10:50 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f57fc36sm83998985e9.18.2024.10.22.03.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:10:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org
Subject: [PATCH v2 14/14] dockerfiles: install bindgen from cargo on Ubuntu
 22.04
Date: Tue, 22 Oct 2024 12:09:55 +0200
Message-ID: <20241022100956.196657-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241022100956.196657-1-pbonzini@redhat.com>
References: <20241022100956.196657-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
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
in the container, following the documentation.

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
2.46.2


