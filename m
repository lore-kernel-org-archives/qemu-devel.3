Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2826D1CDCB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Bqk-00055e-8H; Tue, 22 Oct 2024 06:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3Bqh-00053E-28
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3Bqf-0004Pl-0Y
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729591844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=biLPxyuTmYjTQwz6O/sjJWtUJX+CBzOfsRAa2TZ+E2U=;
 b=Rbk4qHFsRDolWbEeF5kirzGT5VZIe484WSWZYTO/9stZbF8B0taCGT+syesrWrdVT5I0k9
 9a1VwC1CF19L9GB9MuPa8Di0bRbnchpJi7L+hixXIMHnqm35eAT/Lui4jvOfXr1LW4Q/jW
 lKgp9qlqmMJnGC7rlhHCHEgpf8cexzU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-zgRU7B9SNaC5VoTaDkKawA-1; Tue, 22 Oct 2024 06:10:42 -0400
X-MC-Unique: zgRU7B9SNaC5VoTaDkKawA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-539ed93e08aso4018331e87.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729591840; x=1730196640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=biLPxyuTmYjTQwz6O/sjJWtUJX+CBzOfsRAa2TZ+E2U=;
 b=ke5+UTcSW3H66cfdLX7H3ja1yW3HCBbtoF6RfoHVw9MJYM1DAGkqhEUgtea2h6ZGWX
 tcT4xIO3WEuPElMDaE3j0LYGryu/sVWZcpK7Ol8KTuYryCDwK0La0bXDFMD4mM4P0Tjn
 ifYDICXesbJ3O6DpSqjUvQKvhmSITEPqnoJSWSIpRyCOybucGiXjBb1NCaFiOQsuq9TU
 kT0Al5NFM0q8AN0c3W+d9lfmjwTKncNzdFUmsqEgklJvtL0/UVQOOL+Kclw0UGyvmolS
 gsbxxTWsFzwyIXv87G1BZzkQWEo7ITNYMo4OCIKlO03eJfHLmGV+Oz3+T28hw1fktRas
 uROg==
X-Gm-Message-State: AOJu0YxKdAPtz7Xj6o0dDfandLTl5U4pzkwY0m/e63HVKoCjFspmZ4xY
 Y8ZfPIvIu9u8NiZEMdNsCACDUUlDfJvigZIzZnfS5T2LAcvsPSRmkQwb1THgmRpqnXux88Tt/BW
 EijOhDDMT5HRWUO/Zsz+rZG9+j3sYckdlycLdRo9d04Ob04CbggwQ1IZee0TZZWcAvig3MMUhXy
 AWyt4end9EyJX/NuBcTfQD08W75/77tWh8PDL11jg=
X-Received: by 2002:a05:6512:2207:b0:539:f699:4954 with SMTP id
 2adb3069b0e04-53b12c42f7emr1743110e87.58.1729591840250; 
 Tue, 22 Oct 2024 03:10:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrpdzMEtP8GCRmiUdFQ5jGMhUMEzMd9aQF/jUXNzE+TGciLXFKA5p3pvKX+bCR0aSoJfrHPQ==
X-Received: by 2002:a05:6512:2207:b0:539:f699:4954 with SMTP id
 2adb3069b0e04-53b12c42f7emr1743077e87.58.1729591839635; 
 Tue, 22 Oct 2024 03:10:39 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f5cc563sm83567805e9.44.2024.10.22.03.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:10:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org
Subject: [PATCH v2 11/14] rust: do not use --generate-cstr
Date: Tue, 22 Oct 2024 12:09:52 +0200
Message-ID: <20241022100956.196657-12-pbonzini@redhat.com>
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

--generate-cstr is a good idea and generally the right thing to do,
but it is not available in Debian 12 and Ubuntu 22.04.  Work around
the absence.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                       |  4 +++-
 rust/hw/char/pl011/src/device.rs  |  1 +
 rust/qemu-api/src/device_class.rs | 10 ++++++++++
 rust/qemu-api/tests/tests.rs      |  4 ++--
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 9c57d7e5c6d..a083e3434b3 100644
--- a/meson.build
+++ b/meson.build
@@ -3941,13 +3941,15 @@ common_all =3D static_library('common',
                             dependencies: common_ss.all_dependencies())
=20
 if have_rust
+  # We would like to use --generate-cstr, but it is only available
+  # starting with bindgen 0.66.0.  The oldest supported versions
+  # are in Ubuntu 22.04 (0.59.1) and Debian 12 (0.60.1).
   bindgen_args =3D [
     '--disable-header-comment',
     '--raw-line', '// @generated',
     '--ctypes-prefix', 'std::os::raw',
     '--formatter', 'rustfmt',
     '--generate-block',
-    '--generate-cstr',
     '--impl-debug',
     '--merge-extern-blocks',
     '--no-doc-comments',
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/devi=
ce.rs
index c26d21e079d..1bcb6a0fba8 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -13,6 +13,7 @@
     bindings::{self, *},
     c_str,
     definitions::ObjectImpl,
+    device_class::TYPE_SYS_BUS_DEVICE,
 };
=20
 use crate::{
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_c=
lass.rs
index ce3d5f50507..995267dd715 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -2,6 +2,10 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
=20
+use std::ffi::CStr;
+
+use crate::bindings;
+
 #[macro_export]
 macro_rules! device_class_init {
     ($func:ident, props =3D> $props:ident, realize_fn =3D> $realize_fn:exp=
r, legacy_reset_fn =3D> $legacy_reset_fn:expr, vmsd =3D> $vmsd:ident$(,)*) =
=3D> {
@@ -83,3 +87,9 @@ macro_rules! vm_state_description {
         };
     }
 }
+
+// workaround until we can use --generate-cstr in bindgen.
+pub const TYPE_DEVICE: &CStr =3D
+    unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_DEVICE) };
+pub const TYPE_SYS_BUS_DEVICE: &CStr =3D
+    unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_SYS_BUS_DE=
VICE) };
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 96e413b75ee..f932acd5c10 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -8,7 +8,7 @@
     bindings::*,
     c_str, declare_properties, define_property,
     definitions::{Class, ObjectImpl},
-    device_class_init, vm_state_description,
+    device_class, device_class_init, vm_state_description,
 };
=20
 #[test]
@@ -56,7 +56,7 @@ impl ObjectImpl for DummyState {
         type Class =3D DummyClass;
         const TYPE_INFO: qemu_api::bindings::TypeInfo =3D qemu_api::type_i=
nfo! { Self };
         const TYPE_NAME: &'static CStr =3D c_str!("dummy");
-        const PARENT_TYPE_NAME: Option<&'static CStr> =3D Some(TYPE_DEVICE=
);
+        const PARENT_TYPE_NAME: Option<&'static CStr> =3D Some(device_clas=
s::TYPE_DEVICE);
         const ABSTRACT: bool =3D false;
         const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)=
> =3D None;
         const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Ob=
ject)> =3D None;
--=20
2.46.2


