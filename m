Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EA5D216A2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 13:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0hRJ-000270-5j; Tue, 15 Oct 2024 09:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hRH-00026G-2f
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hRE-0001I6-Ss
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728998290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mSJy+BswT8rFNNdI2QF0Qc2703bnkbHCgHm0DMWaW6Y=;
 b=WMruTlJ6MzFLSSuUJBe4q0AsQSSY3mKtbodMl/j97Pu8NwPHXaTr8UXTAQw3VYZnuKcSDE
 ZkdaP7+RuoYWFZJtbKR9LAHI4fWEUWDBi+ytQSzXSADm5j1bTyrITGUgccryrUEsux5vUU
 Ws42PLcJBR8C5PGp61Nobs4yz0S+7c8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-WOJBC0pvMUiVA9zhEoIukw-1; Tue, 15 Oct 2024 09:18:09 -0400
X-MC-Unique: WOJBC0pvMUiVA9zhEoIukw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-539e75025f9so1885914e87.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 06:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728998287; x=1729603087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mSJy+BswT8rFNNdI2QF0Qc2703bnkbHCgHm0DMWaW6Y=;
 b=mAWHGXTsz9x3WGp+6P9aU7wBzzOiVNhuW6vAWx9eJ/kLEvjb/8qJ3XD9Vkyd5JZ9B6
 ZXO00qfQgrXPO/5eTC/akzFBfWf9myQ60Y8oWqZZtnWLDhrlK9fRvyGHGR0s65Ds9SHo
 nM2bh8WtfbO+aTHKbb5Bvi5ZL+Sm3k6wjQ4xgoDS2o5TX3W2JRFiMvJOjvwWk5ltyM0I
 peu2OCXgfY7VTeI7kmqoTn+/ml3PYucDnyQYLx4H0VsHl+F9A55vOxtVa1nAQBMbMMSA
 nZ4tJuzG72qJ1+KY0jLVMTfi2JuiKIzwA6xln5bAC1hc8L+aG7jOkKdwvBCLxNpmjcBm
 NOaA==
X-Gm-Message-State: AOJu0Yw5Ka07J4wX8Y0v4NahqVMi6aGSk1HwcwMYqBvJnVWj0x6FOXEs
 wktXetucTx4No7faZ3HICA2jN4FMgz9D73L6HlGRN1Wqx1wvPXV+wYLWP5ORRKIkwUXZ3FYCAzk
 Hd9CdkfXCOrnF7YwK6er9FX4CexVs3tyR9NlKW5ntEo3qkyzW4ngER1iCWXKypJXJmO1ZXuEitJ
 O8BiZ/bPWC0cmGRj9bHkItsLMpyLuTvLQKWOT3NN4=
X-Received: by 2002:a05:6512:39cb:b0:536:554a:24c2 with SMTP id
 2adb3069b0e04-53a03f18ddamr217623e87.13.1728998286752; 
 Tue, 15 Oct 2024 06:18:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW8IpPiS0mrUwgvOXGSwYEkPzEJgqtWQdAERWMRai+qN+ZR357sT9utkGh3RWjxxXJuR79NA==
X-Received: by 2002:a05:6512:39cb:b0:536:554a:24c2 with SMTP id
 2adb3069b0e04-53a03f18ddamr217596e87.13.1728998286018; 
 Tue, 15 Oct 2024 06:18:06 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f6b31b9sm17840825e9.29.2024.10.15.06.18.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:18:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/16] rust: introduce a c_str macro
Date: Tue, 15 Oct 2024 15:17:27 +0200
Message-ID: <20241015131735.518771-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015131735.518771-1-pbonzini@redhat.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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

This allows CStr constants to be defined easily on Rust 1.63.0, while
checking that there are no embedded NULs.  c"" literals were only
stabilized in Rust 1.77.0.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs       |  3 +-
 rust/hw/char/pl011/src/device_class.rs | 10 +++--
 rust/hw/char/pl011/src/lib.rs          |  4 +-
 rust/qemu-api/meson.build              |  1 +
 rust/qemu-api/src/c_str.rs             | 52 ++++++++++++++++++++++++++
 rust/qemu-api/src/lib.rs               |  1 +
 rust/qemu-api/src/tests.rs             |  8 ++--
 7 files changed, 70 insertions(+), 9 deletions(-)
 create mode 100644 rust/qemu-api/src/c_str.rs

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/devi=
ce.rs
index cd4c01c2336..55d933ee5e9 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -11,6 +11,7 @@
=20
 use qemu_api::{
     bindings::{self, *},
+    c_str,
     definitions::ObjectImpl,
 };
=20
@@ -99,7 +100,7 @@ impl qemu_api::definitions::Class for PL011Class {
 }
=20
 #[used]
-pub static CLK_NAME: &CStr =3D c"clk";
+pub static CLK_NAME: &CStr =3D c_str!("clk");
=20
 impl PL011State {
     /// Initializes a pre-allocated, unitialized instance of `PL011State`.
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/sr=
c/device_class.rs
index b7ab31af02d..a3d1b1e929a 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -4,7 +4,11 @@
=20
 use core::ptr::NonNull;
=20
-use qemu_api::{bindings::*, definitions::ObjectImpl};
+use qemu_api::{
+    bindings::*,
+    c_str,
+    definitions::ObjectImpl
+};
=20
 use crate::device::PL011State;
=20
@@ -18,14 +22,14 @@
 qemu_api::declare_properties! {
     PL011_PROPERTIES,
     qemu_api::define_property!(
-        c"chardev",
+        c_str!("chardev"),
         PL011State,
         char_backend,
         unsafe { &qdev_prop_chr },
         CharBackend
     ),
     qemu_api::define_property!(
-        c"migrate-clk",
+        c_str!("migrate-clk"),
         PL011State,
         migrate_clock,
         unsafe { &qdev_prop_bool },
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index 2b157868b0f..0a598e5629d 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -41,11 +41,13 @@
 extern crate bilge_impl;
 extern crate qemu_api;
=20
+use qemu_api::c_str;
+
 pub mod device;
 pub mod device_class;
 pub mod memory_ops;
=20
-pub const TYPE_PL011: &::std::ffi::CStr =3D c"pl011";
+pub const TYPE_PL011: &::std::ffi::CStr =3D c_str!("pl011");
=20
 /// Offset of each register from the base memory address of the device.
 ///
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 436e2f1e836..b55931c6490 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -3,6 +3,7 @@ _qemu_api_rs =3D static_library(
   structured_sources(
     [
       'src/lib.rs',
+      'src/c_str.rs',
       'src/definitions.rs',
       'src/device_class.rs',
       'src/tests.rs',
diff --git a/rust/qemu-api/src/c_str.rs b/rust/qemu-api/src/c_str.rs
new file mode 100644
index 00000000000..0286dade306
--- /dev/null
+++ b/rust/qemu-api/src/c_str.rs
@@ -0,0 +1,52 @@
+// Copyright 2024 Red Hat, Inc.
+// Author(s): Paolo Bonzini <pbonzini@redhat.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#[macro_export]
+/// Given a string constant _without_ embedded or trailing NULs, return
+/// a CStr.
+///
+/// Needed for compatibility with Rust <1.77.
+macro_rules! c_str {
+    ($str:expr) =3D> {{
+        const STRING: &str =3D concat!($str, "\0");
+        const BYTES: &[u8] =3D STRING.as_bytes();
+
+        // "for" is not allowed in const context... oh well,
+        // everybody loves some lisp.  This could be turned into
+        // a procedural macro if this is a problem; alternatively
+        // Rust 1.72 makes CStr::from_bytes_with_nul a const function.
+        const fn f(b: &[u8], i: usize) {
+            if i =3D=3D BYTES.len() - 1 {}
+            else if BYTES[i] =3D=3D 0 {
+                panic!("c_str argument contains NUL")
+            } else {
+                f(b, i + 1)
+            }
+        }
+        f(BYTES, 0);
+
+        // SAFETY: absence of NULs apart from the final byte was checked a=
bove
+        unsafe { std::ffi::CStr::from_bytes_with_nul_unchecked(BYTES) }
+    }};
+}
+
+#[cfg(test)]
+mod tests {
+    use std::ffi::CStr;
+    use crate::c_str;
+
+    #[test]
+    fn test_cstr_macro() {
+        let good =3D c_str!("=F0=9F=A6=80");
+        let good_bytes =3D b"\xf0\x9f\xa6\x80\0";
+        assert_eq!(good.to_bytes_with_nul(), good_bytes);
+    }
+
+    #[test]
+    fn test_cstr_macro_const() {
+        const GOOD: &CStr =3D c_str!("=F0=9F=A6=80");
+        const GOOD_BYTES: &[u8] =3D b"\xf0\x9f\xa6\x80\0";
+        assert_eq!(GOOD.to_bytes_with_nul(), GOOD_BYTES);
+    }
+}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index c2f60ac4727..9b2483fbfa3 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -27,6 +27,7 @@ unsafe impl Sync for bindings::Property {}
 unsafe impl Sync for bindings::TypeInfo {}
 unsafe impl Sync for bindings::VMStateDescription {}
=20
+pub mod c_str;
 pub mod definitions;
 pub mod device_class;
=20
diff --git a/rust/qemu-api/src/tests.rs b/rust/qemu-api/src/tests.rs
index f0cd4d5d716..d34b8d24187 100644
--- a/rust/qemu-api/src/tests.rs
+++ b/rust/qemu-api/src/tests.rs
@@ -3,7 +3,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
=20
 use crate::{
-    bindings::*, declare_properties, define_property, device_class_init, v=
m_state_description,
+    bindings::*, c_str, declare_properties, define_property, device_class_=
init, vm_state_description,
 };
=20
 #[test]
@@ -11,7 +11,7 @@ fn test_device_decl_macros() {
     // Test that macros can compile.
     vm_state_description! {
         VMSTATE,
-        name: c"name",
+        name: c_str!("name"),
         unmigratable: true,
     }
=20
@@ -24,14 +24,14 @@ pub struct DummyState {
     declare_properties! {
         DUMMY_PROPERTIES,
             define_property!(
-                c"chardev",
+                c_str!("chardev"),
                 DummyState,
                 char_backend,
                 unsafe { &qdev_prop_chr },
                 CharBackend
             ),
             define_property!(
-                c"migrate-clk",
+                c_str!("migrate-clk"),
                 DummyState,
                 migrate_clock,
                 unsafe { &qdev_prop_bool },
--=20
2.46.2


