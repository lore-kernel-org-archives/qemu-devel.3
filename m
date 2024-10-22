Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC931D1CDCB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Bqb-0004vA-Cl; Tue, 22 Oct 2024 06:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3BqZ-0004uS-0T
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3BqT-0004Oj-Ti
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729591832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p2uLljYjUly9gfbALpWloSBtc6UsfQdEzE6UaHjO4cY=;
 b=PuMblHEsDrB9zrnXHutJYtRygWmrjGMh9hgVyIpsjT5U/9CSThapiQOplaSjB9bLEFI/Sg
 DntNyHtpUdFvRgMzCnxlOOs1B8lvNm0I4zbRnuyjy9PGF8bJNkHMvbWF9yi2Ym66wpDJey
 eGAI+9Rf7WQ+ZaUEwyxLLmWrJxYKPpY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-g0cZToZgMdytz_4yEQpcYw-1; Tue, 22 Oct 2024 06:10:25 -0400
X-MC-Unique: g0cZToZgMdytz_4yEQpcYw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315eaa3189so43705075e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729591822; x=1730196622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p2uLljYjUly9gfbALpWloSBtc6UsfQdEzE6UaHjO4cY=;
 b=aSHHihYZfYjAxeA8Af46SeCzB99phFxoVnaJVNyjQPnjYiQxqLXm5QuKkpFYf3JFYc
 1f7K6dEoGMLSdINPJkvvgCC7DSWz+rok9KofHabt/k7a1TFAUjfTss03woy4oUAX9usO
 C+tAfUqfoRYQhXHP1EhN1lq2owgADcXAuRrdia3/UA3Lv+0FhGo0S64Q+MntUga/QLR5
 Tk7PSsBjlc7cMOoQz4eIL72b0a1frhWg+6RWavsvN1sIPTjnyeSZZmDR2NpMbcC29c2c
 mlZzbgStSraeMn6XqH1snX1oCjmIBgoK/R/QJhWYFMdzjE7L2+TgyYG1tz2EdF9Wd1lc
 x8CA==
X-Gm-Message-State: AOJu0YxTd56YCaU1yzxURFsMeRgFD3hgij/08hxRUBL0qkw9XBfbtaWW
 BfKHWxHKLq4bkt8U1gQUJuyCaB2dlbAckv6gQ8GCxS6F/kFAbrXbL999O2049DvMNwnlUfRyQgh
 qhAyKcmYLgaFRCSsb8eilB4HbufRT3KvtfKgHpnuf3LmuE0tnP+eCbEHEiKKN+LtNYM0elgpC49
 pK1q5dsxyOFdtbcdmAtSseN94SfsYU/0qIiKFG2fE=
X-Received: by 2002:a05:600c:5118:b0:431:604d:b22 with SMTP id
 5b1f17b1804b1-4316163bcbdmr176850915e9.16.1729591822178; 
 Tue, 22 Oct 2024 03:10:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHoS9DC1RJMddRt0hU6ZtpdoDQDkvBCdOP19Ectrf7z2F8rSu2CbtI7oaked69XcOYrgiygw==
X-Received: by 2002:a05:600c:5118:b0:431:604d:b22 with SMTP id
 5b1f17b1804b1-4316163bcbdmr176850465e9.16.1729591821609; 
 Tue, 22 Oct 2024 03:10:21 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f5711b3sm83295015e9.9.2024.10.22.03.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:10:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org
Subject: [PATCH v2 06/14] rust: synchronize dependencies between subprojects
 and Cargo.lock
Date: Tue, 22 Oct 2024 12:09:47 +0200
Message-ID: <20241022100956.196657-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241022100956.196657-1-pbonzini@redhat.com>
References: <20241022100956.196657-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The next commit will introduce a new build dependency for rust/qemu-api,
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
 rust/hw/char/pl011/Cargo.lock   |  5 +++-
 rust/qemu-api-macros/Cargo.lock | 11 ++++----
 rust/qemu-api/Cargo.lock        | 49 ++++++++++++++++++++++++++++++++-
 rust/qemu-api/Cargo.toml        |  1 +
 4 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/rust/hw/char/pl011/Cargo.lock b/rust/hw/char/pl011/Cargo.lock
index b58cebb186e..82028ddf793 100644
--- a/rust/hw/char/pl011/Cargo.lock
+++ b/rust/hw/char/pl011/Cargo.lock
@@ -1,6 +1,6 @@
 # This file is automatically @generated by Cargo.
 # It is not intended for manual editing.
-version =3D 3
+version =3D 4
=20
 [[package]]
 name =3D "arbitrary-int"
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
index fdc0fce116c..779b0ac6a25 100644
--- a/rust/qemu-api-macros/Cargo.lock
+++ b/rust/qemu-api-macros/Cargo.lock
@@ -1,12 +1,12 @@
 # This file is automatically @generated by Cargo.
 # It is not intended for manual editing.
-version =3D 3
+version =3D 4
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
index e9c51a243a8..468293feedd 100644
--- a/rust/qemu-api/Cargo.lock
+++ b/rust/qemu-api/Cargo.lock
@@ -1,7 +1,54 @@
 # This file is automatically @generated by Cargo.
 # It is not intended for manual editing.
-version =3D 3
+version =3D 4
+
+[[package]]
+name =3D "proc-macro2"
+version =3D "1.0.84"
+source =3D "registry+https://github.com/rust-lang/crates.io-index"
+checksum =3D "ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc12024a=
49d6"
+dependencies =3D [
+ "unicode-ident",
+]
=20
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
2.46.2


