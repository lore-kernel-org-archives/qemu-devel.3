Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D45D149C1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Mn9-0003AM-P5; Fri, 25 Oct 2024 12:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mn7-00034n-9Z
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mn3-0004tO-Rs
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729872233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tgWG4QrvBYKougesQ0BiWi02RU29Y/LaKzz9PJv7isg=;
 b=gbeqpIV137bsPlLR5eq3l6s9e36dPWXKj28JaDWI4v9fYVL/6bN3v15b1x4KP9q6roZgmc
 NM31hw9SkI7aAjIAAVxKTJ8iAJGXenH1Yi7Ojl06bOqTTNd2EpRra7HUFV+LqlFEYKm4/N
 gkpe8kUOEQGehBhgdDxIwejyjylp+as=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-xeA84wW0NZSd-cq8vIT8mw-1; Fri, 25 Oct 2024 12:03:52 -0400
X-MC-Unique: xeA84wW0NZSd-cq8vIT8mw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5c94862c3adso1546771a12.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729872227; x=1730477027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tgWG4QrvBYKougesQ0BiWi02RU29Y/LaKzz9PJv7isg=;
 b=Jz0ex6wPvIKVDTxVnDJ7Pn8Ri0dMdifBl5fOGSM9wy+IfaGxsJ6enTv0O8NSmFWYsX
 gRU9kL3Jr5i9oRvqMXdUgiB9YrwCPnqHVijGLJW7lC2C9CGTjK7fDske5aHefziA2Doh
 Y48tJ7WG7q5kIFilmuzoEOFoUeIu7xjyX4zAZTWn0hyE8YegURmhRB8AQn9Shvgi2B/i
 DYoWgbFrqtUQDa3lRwaMyg6yjK3BHr5+wNez0eP0UuxyLUHL7J4lfCycXeTTsUyvlckc
 tYU2kMY5GlN/e5SGBkkvIFWB6XGXQmXUhjcpLBxiSOgsA0xY2E5RAM4Tdx0HSf+47yCD
 fduw==
X-Gm-Message-State: AOJu0YxNo8RHkrYgbLK4LgvufWrNhPYnEF2PvSs7BxVlstwQRcB1qs9f
 +UuvmZHbXcR2R0ucxl6FZqgMqjrC+k1O4cmQMG4bPTeR9/b6g/nqDw5Ct0P25eBWGJqIyrw76PJ
 kDaxdYgQuoB1Nq9B/x3XfW8sGyXEs7RQPUWdCMK+/iDlxV6nIzU0aQQ5ofunaRIPZsnu+7ONfa0
 jRfSX9/iBvwHDqMKDlpVcpWr6AHlwYZ/QC37Xmg3Q=
X-Received: by 2002:a05:6402:c4b:b0:5c9:57bd:e9d with SMTP id
 4fb4d7f45d1cf-5cb8acfa774mr8984833a12.19.1729872227250; 
 Fri, 25 Oct 2024 09:03:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo+IpPCgXFxnI+vBxFyzloxpIcZza3hwhd1qSntwAhAWRmUDA/ncpT9h+QhOtdjHZDMF6+3Q==
X-Received: by 2002:a05:6402:c4b:b0:5c9:57bd:e9d with SMTP id
 4fb4d7f45d1cf-5cb8acfa774mr8984785a12.19.1729872226726; 
 Fri, 25 Oct 2024 09:03:46 -0700 (PDT)
Received: from [192.168.10.47] ([151.81.112.43])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb62c22d1sm757768a12.45.2024.10.25.09.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:03:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: [PATCH 13/23] rust: synchronize dependencies between subprojects and
 Cargo.lock
Date: Fri, 25 Oct 2024 18:01:58 +0200
Message-ID: <20241025160209.194307-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025160209.194307-1-pbonzini@redhat.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

The next commit will introduce a new build.rs dependency for rust/qemu-api,
version_check.  Before adding it, ensure that all dependencies are
synchronized between the Meson- and cargo-based build systems.

Note that it's not clear whether in the long term we'll use Cargo for
anything; it seems that the three main uses (clippy, rustfmt, rustdoc)
can all be invoked manually---either via glue code in QEMU, or by
extending Meson to gain the relevant functionality.  However, for
the time being we're stuck with Cargo so it should at least look at
the same code as the rest of the build system.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/Cargo.lock   |  3 +++
 rust/qemu-api-macros/Cargo.lock |  9 ++++---
 rust/qemu-api/Cargo.lock        | 47 +++++++++++++++++++++++++++++++++
 rust/qemu-api/Cargo.toml        |  1 +
 4 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/rust/hw/char/pl011/Cargo.lock b/rust/hw/char/pl011/Cargo.lock
index b58cebb186e..9f43b33e8b8 100644
--- a/rust/hw/char/pl011/Cargo.lock
+++ b/rust/hw/char/pl011/Cargo.lock
@@ -91,6 +91,9 @@ dependencies =3D [
 [[package]]
 name =3D "qemu_api"
 version =3D "0.1.0"
+dependencies =3D [
+ "qemu_api_macros",
+]
=20
 [[package]]
 name =3D "qemu_api_macros"
diff --git a/rust/qemu-api-macros/Cargo.lock b/rust/qemu-api-macros/Cargo.l=
ock
index fdc0fce116c..f989e25829f 100644
--- a/rust/qemu-api-macros/Cargo.lock
+++ b/rust/qemu-api-macros/Cargo.lock
@@ -4,9 +4,9 @@ version =3D 3
=20
 [[package]]
 name =3D "proc-macro2"
-version =3D "1.0.86"
+version =3D "1.0.84"
 source =3D "registry+https://github.com/rust-lang/crates.io-index"
-checksum =3D "5e719e8df665df0d1c8fbfd238015744736151d4445ec0836b8e628aae10=
3b77"
+checksum =3D "ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc12024a=
49d6"
 dependencies =3D [
  "unicode-ident",
 ]
@@ -18,6 +18,7 @@ dependencies =3D [
  "proc-macro2",
  "quote",
  "syn",
+ "unicode-ident",
 ]
=20
 [[package]]
@@ -31,9 +32,9 @@ dependencies =3D [
=20
 [[package]]
 name =3D "syn"
-version =3D "2.0.72"
+version =3D "2.0.66"
 source =3D "registry+https://github.com/rust-lang/crates.io-index"
-checksum =3D "dc4b9b9bf2add8093d3f2c0204471e951b2285580335de42f9d2534f3ae7=
a8af"
+checksum =3D "c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cd=
cff5"
 dependencies =3D [
  "proc-macro2",
  "quote",
diff --git a/rust/qemu-api/Cargo.lock b/rust/qemu-api/Cargo.lock
index e9c51a243a8..e407911cdd1 100644
--- a/rust/qemu-api/Cargo.lock
+++ b/rust/qemu-api/Cargo.lock
@@ -2,6 +2,53 @@
 # It is not intended for manual editing.
 version =3D 3
=20
+[[package]]
+name =3D "proc-macro2"
+version =3D "1.0.84"
+source =3D "registry+https://github.com/rust-lang/crates.io-index"
+checksum =3D "ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc12024a=
49d6"
+dependencies =3D [
+ "unicode-ident",
+]
+
 [[package]]
 name =3D "qemu_api"
 version =3D "0.1.0"
+dependencies =3D [
+ "qemu_api_macros",
+]
+
+[[package]]
+name =3D "qemu_api_macros"
+version =3D "0.1.0"
+dependencies =3D [
+ "proc-macro2",
+ "quote",
+ "syn",
+]
+
+[[package]]
+name =3D "quote"
+version =3D "1.0.36"
+source =3D "registry+https://github.com/rust-lang/crates.io-index"
+checksum =3D "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208ac=
aca7"
+dependencies =3D [
+ "proc-macro2",
+]
+
+[[package]]
+name =3D "syn"
+version =3D "2.0.66"
+source =3D "registry+https://github.com/rust-lang/crates.io-index"
+checksum =3D "c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cd=
cff5"
+dependencies =3D [
+ "proc-macro2",
+ "quote",
+ "unicode-ident",
+]
+
+[[package]]
+name =3D "unicode-ident"
+version =3D "1.0.12"
+source =3D "registry+https://github.com/rust-lang/crates.io-index"
+checksum =3D "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0f=
ee4b"
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index 3677def3fe2..db594c64083 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -14,6 +14,7 @@ keywords =3D []
 categories =3D []
=20
 [dependencies]
+qemu_api_macros =3D { path =3D "../qemu-api-macros" }
=20
 [features]
 default =3D []
--=20
2.47.0


