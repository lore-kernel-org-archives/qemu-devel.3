Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8568BD1CDCB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3BqY-0004u6-As; Tue, 22 Oct 2024 06:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3BqV-0004tQ-ES
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3BqR-0004Od-D9
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729591830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yBchrBlim6aYT5+mpyUWgR4s/JYFs7BD36LJ5gWznMw=;
 b=dSCVQvNlrzupPWK5p16QOpQhgSo3200hs90D/TbHmY8fd5n/iX2Pigkn1+thNFP3rU+vEn
 jBUF0bYFkPEr14diQhZxd0shU66StwGq0gq8vPQebiYvf0iGu7vhuaujbj1zvSCZCtYDb7
 4HsK5nDpbXuuXs4FBAwlZnwcYfe3x0s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-g-A0iFiVMOue-11gTz6pIA-1; Tue, 22 Oct 2024 06:10:29 -0400
X-MC-Unique: g-A0iFiVMOue-11gTz6pIA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315eaa3189so43705645e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729591827; x=1730196627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yBchrBlim6aYT5+mpyUWgR4s/JYFs7BD36LJ5gWznMw=;
 b=xAKf4TO8C2tZAkq8NTvS1HOqaFGXsOMiHX9ifv2lxtJGpAT9WhMwyot00sGRcea/xc
 /UwHuMUm+Z0DwMrIbOsrMHpXOZt5Kv4fsQyZCB4/i6mlnVUg+kpvL/OQW5HoCtcpTIFo
 ZTv1o83DZ/p6ekrW4zAZDz4VYSQ5aDuxjtW+HSZgCgfLdvuSmkzJY2zNvdPdxxMlalrs
 /iDiRSO6YZlL3ITt/O5QQxfLJdajYDGDJHuUK0lvaFw6VzK9wtcu8uc3xKo4Mr6U9/6H
 7deVGrbjg2ipJ2qulIXvOrw8pZPgbR+fbl/g4hhCv+jLhpNavcF0rnufa/vxeaV5GyPe
 Z1Pg==
X-Gm-Message-State: AOJu0YxvULBZuSHgPb1RAzlAGxlc86RTAXaV6l/aS/sg6W7ORV/m6Toy
 M45BTGSg+Sl0K8gQZj2Ia2Um2VADrqGJ31KsK7NHKaL5eXVM8MbcYdyJ9nHO+A1w+ir5FdVzEwT
 3T1X0YZQFxfaRqbvVgPjR8zlPSY7BqFMAL1jYQRpH+nTRy3M3xhnVN8qOPoBdu+kh20YBl9ENp2
 nKcLQ/e52xBM5LyS68C+SytutFYabXfHRkNZgJegQ=
X-Received: by 2002:a05:600c:5489:b0:431:24c3:dbaa with SMTP id
 5b1f17b1804b1-4316161eeaamr144556885e9.2.1729591827193; 
 Tue, 22 Oct 2024 03:10:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1SfvfTluFev9BgEl9+dkTmUGHtWKuxlCnQ21W7oWMzQzPNPw8Gl95aBTc/lNhhoSNQAoAOw==
X-Received: by 2002:a05:600c:5489:b0:431:24c3:dbaa with SMTP id
 5b1f17b1804b1-4316161eeaamr144556545e9.2.1729591826527; 
 Tue, 22 Oct 2024 03:10:26 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431805a8583sm6287055e9.48.2024.10.22.03.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:10:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org
Subject: [PATCH v2 07/14] rust: introduce alternative implementation of
 offset_of!
Date: Tue, 22 Oct 2024 12:09:48 +0200
Message-ID: <20241022100956.196657-8-pbonzini@redhat.com>
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

From: Junjie Mao <junjie.mao@hotmail.com>

offset_of! was stabilized in Rust 1.77.0.  Use an alternative implemenation
that was found on the Rust forums, and whose author agreed to license as
MIT for use in QEMU.

The alternative allows only one level of field access, but apart
from this can be used just by replacing core::mem::offset_of! with
qemu_api::offset_of!.

The actual implementation of offset_of! is done in a declarative macro,
but for simplicity and to avoid introducing an extra level of indentation,
the trigger is a procedural macro #[derive(offsets)].

Signed-off-by: Junjie Mao <junjie.mao@hotmail.com>
Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/Cargo.lock                 |   1 +
 rust/hw/char/pl011/src/device.rs              |   2 +-
 rust/qemu-api-macros/Cargo.toml               |   5 +-
 rust/qemu-api-macros/src/lib.rs               |  29 +++-
 rust/qemu-api/Cargo.lock                      |   7 +
 rust/qemu-api/Cargo.toml                      |   6 +-
 rust/qemu-api/build.rs                        |   8 +
 rust/qemu-api/meson.build                     |  12 +-
 rust/qemu-api/src/device_class.rs             |   8 +-
 rust/qemu-api/src/lib.rs                      |   4 +
 rust/qemu-api/src/offset_of.rs                | 161 ++++++++++++++++++
 rust/qemu-api/tests/tests.rs                  |   1 +
 subprojects/packagefiles/syn-2-rs/meson.build |   1 +
 13 files changed, 232 insertions(+), 13 deletions(-)
 create mode 100644 rust/qemu-api/src/offset_of.rs

diff --git a/rust/hw/char/pl011/Cargo.lock b/rust/hw/char/pl011/Cargo.lock
index 82028ddf793..087658ca72b 100644
--- a/rust/hw/char/pl011/Cargo.lock
+++ b/rust/hw/char/pl011/Cargo.lock
@@ -93,6 +93,7 @@ name =3D "qemu_api"
 version =3D "0.1.0"
 dependencies =3D [
  "qemu_api_macros",
+ "version_check",
 ]
=20
 [[package]]
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/devi=
ce.rs
index 5ffe1911376..c26d21e079d 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -29,7 +29,7 @@
 pub const PL011_FIFO_DEPTH: usize =3D 16_usize;
=20
 #[repr(C)]
-#[derive(Debug, qemu_api_macros::Object)]
+#[derive(Debug, qemu_api_macros::Object, qemu_api_macros::offsets)]
 /// PL011 Device Model in QEMU
 pub struct PL011State {
     pub parent_obj: SysBusDevice,
diff --git a/rust/qemu-api-macros/Cargo.toml b/rust/qemu-api-macros/Cargo.t=
oml
index 144cc3650fa..47fec2e4637 100644
--- a/rust/qemu-api-macros/Cargo.toml
+++ b/rust/qemu-api-macros/Cargo.toml
@@ -19,7 +19,10 @@ proc-macro =3D true
 [dependencies]
 proc-macro2 =3D "1"
 quote =3D "1"
-syn =3D "2"
+
+[dependencies.syn]
+version =3D "2"
+features=3D ["extra-traits"]
=20
 # Do not include in any global workspace
 [workspace]
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib=
.rs
index a4bc5d01ee8..472264159d6 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -3,8 +3,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
=20
 use proc_macro::TokenStream;
-use quote::quote;
-use syn::{parse_macro_input, DeriveInput};
+use quote::{quote, quote_spanned};
+use syn::{parse_macro_input, parse_quote, spanned::Spanned, Attribute, Der=
iveInput};
=20
 #[proc_macro_derive(Object)]
 pub fn derive_object(input: TokenStream) -> TokenStream {
@@ -21,3 +21,28 @@ pub fn derive_object(input: TokenStream) -> TokenStream {
=20
     TokenStream::from(expanded)
 }
+
+#[proc_macro_derive(offsets)]
+pub fn derive_offsets(input: TokenStream) -> TokenStream {
+    let input =3D parse_macro_input!(input as DeriveInput);
+    let repr_c: Attribute =3D parse_quote! { #[repr(C)] };
+
+    // All the work for expanding this macro is done in "with_offsets!",
+    // a macro in the qemu_api crate which re-parses the struct declaratio=
n;
+    // this derive macro is just a convenience.
+    //
+    // The with_offsets! macro expands to nothing if the compiler is new e=
nough
+    // to have a stable offset_of.
+    let expanded =3D if !input.attrs.iter().any(|x| *x =3D=3D repr_c) {
+        quote_spanned! {
+            input.span() =3D>
+            compile_error!("expected #[repr(C)] together with #[derive(off=
sets)]");
+        }
+    } else {
+        quote! {
+            ::qemu_api::with_offsets! { #input }
+        }
+    };
+
+    TokenStream::from(expanded)
+}
diff --git a/rust/qemu-api/Cargo.lock b/rust/qemu-api/Cargo.lock
index 468293feedd..371c6167918 100644
--- a/rust/qemu-api/Cargo.lock
+++ b/rust/qemu-api/Cargo.lock
@@ -16,6 +16,7 @@ name =3D "qemu_api"
 version =3D "0.1.0"
 dependencies =3D [
  "qemu_api_macros",
+ "version_check",
 ]
=20
 [[package]]
@@ -52,3 +53,9 @@ name =3D "unicode-ident"
 version =3D "1.0.12"
 source =3D "registry+https://github.com/rust-lang/crates.io-index"
 checksum =3D "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0f=
ee4b"
+
+[[package]]
+name =3D "version_check"
+version =3D "0.9.4"
+source =3D "registry+https://github.com/rust-lang/crates.io-index"
+checksum =3D "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e=
483f"
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index db594c64083..9c3a99522a9 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -16,6 +16,9 @@ categories =3D []
 [dependencies]
 qemu_api_macros =3D { path =3D "../qemu-api-macros" }
=20
+[build-dependencies]
+version_check =3D "~0.9"
+
 [features]
 default =3D []
 allocator =3D []
@@ -24,4 +27,5 @@ allocator =3D []
 [workspace]
=20
 [lints.rust]
-unexpected_cfgs =3D { level =3D "warn", check-cfg =3D ['cfg(MESON)', 'cfg(=
HAVE_GLIB_WITH_ALIGNED_ALLOC)'] }
+unexpected_cfgs =3D { level =3D "warn", check-cfg =3D ['cfg(MESON)', 'cfg(=
HAVE_GLIB_WITH_ALIGNED_ALLOC)',
+                                                 'cfg(has_offset_of)'] }
diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
index 419b154c2d2..0a68c3712f1 100644
--- a/rust/qemu-api/build.rs
+++ b/rust/qemu-api/build.rs
@@ -3,6 +3,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
=20
 use std::path::Path;
+use version_check as rustc;
=20
 fn main() {
     if !Path::new("src/bindings.rs").exists() {
@@ -11,4 +12,11 @@ fn main() {
              (`ninja bindings.rs`) and copy them to src/bindings.rs, or bu=
ild through meson."
         );
     }
+
+    // Check for available rustc features
+    if rustc::is_min_version("1.77.0").unwrap_or(false) {
+        println!("cargo:rustc-cfg=3Dhas_offset_of");
+    }
+
+    println!("cargo:rerun-if-changed=3Dbuild.rs");
 }
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 2b3dea59fb6..4ac33acced3 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -1,3 +1,9 @@
+_qemu_api_cfg =3D ['--cfg', 'MESON']
+# _qemu_api_cfg +=3D ['--cfg', 'feature=3D"allocator"']
+if rustc.version().version_compare('>=3D1.77.0')
+  _qemu_api_cfg +=3D ['--cfg', 'has_offset_of']
+endif
+
 _qemu_api_rs =3D static_library(
   'qemu_api',
   structured_sources(
@@ -6,16 +12,14 @@ _qemu_api_rs =3D static_library(
       'src/c_str.rs',
       'src/definitions.rs',
       'src/device_class.rs',
+      'src/offset_of.rs',
       'src/zeroable.rs',
     ],
     {'.' : bindings_rs},
   ),
   override_options: ['rust_std=3D2021', 'build.rust_std=3D2021'],
   rust_abi: 'rust',
-  rust_args: [
-    '--cfg', 'MESON',
-    # '--cfg', 'feature=3D"allocator"',
-  ],
+  rust_args: _qemu_api_cfg,
 )
=20
 rust.test('rust-qemu-api-tests', _qemu_api_rs,
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_c=
lass.rs
index 5c305d945d3..ce3d5f50507 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -23,23 +23,23 @@ macro_rules! device_class_init {
=20
 #[macro_export]
 macro_rules! define_property {
-    ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr, default =
=3D $defval:expr$(,)*) =3D> {
+    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:expr, default =
=3D $defval:expr$(,)*) =3D> {
         $crate::bindings::Property {
             // use associated function syntax for type checking
             name: ::std::ffi::CStr::as_ptr($name),
             info: $prop,
-            offset: ::core::mem::offset_of!($state, $field) as isize,
+            offset: $crate::offset_of!($state, $field) as isize,
             set_default: true,
             defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval.=
into() },
             ..$crate::zeroable::Zeroable::ZERO
         }
     };
-    ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr$(,)*) =3D>=
 {
+    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:expr$(,)*) =3D=
> {
         $crate::bindings::Property {
             // use associated function syntax for type checking
             name: ::std::ffi::CStr::as_ptr($name),
             info: $prop,
-            offset: ::core::mem::offset_of!($state, $field) as isize,
+            offset: $crate::offset_of!($state, $field) as isize,
             set_default: false,
             ..$crate::zeroable::Zeroable::ZERO
         }
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 9c3be4f6489..92f1785d891 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -30,6 +30,7 @@ unsafe impl Sync for bindings::VMStateDescription {}
 pub mod c_str;
 pub mod definitions;
 pub mod device_class;
+pub mod offset_of;
 pub mod zeroable;
=20
 use std::{
@@ -166,3 +167,6 @@ unsafe fn dealloc(&self, ptr: *mut u8, layout: Layout) {
         }
     }
 }
+
+#[cfg(has_offset_of)]
+pub use std::mem::offset_of;
diff --git a/rust/qemu-api/src/offset_of.rs b/rust/qemu-api/src/offset_of.rs
new file mode 100644
index 00000000000..87db8607592
--- /dev/null
+++ b/rust/qemu-api/src/offset_of.rs
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: MIT
+
+/// This macro provides the same functionality as `core::mem::offset_of`,
+/// except that only one level of field access is supported.  The declarat=
ion
+/// of the struct must be wrapped with `with_offsets! { }`.
+///
+/// It is needed because `offset_of!` was only stabilized in Rust 1.77.
+#[cfg(not(has_offset_of))]
+#[macro_export]
+macro_rules! offset_of {
+    ($Container:ty, $field:ident) =3D> {
+        <$Container>::OFFSET_TO__.$field
+    };
+}
+
+/// A wrapper for struct declarations, that allows using `offset_of!` in
+/// versions of Rust prior to 1.77
+#[macro_export]
+macro_rules! with_offsets {
+    // This method to generate field offset constants comes from:
+    //
+    //     https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&editi=
on=3D2018&gist=3D10a22a9b8393abd7b541d8fc844bc0df
+    //
+    // used under MIT license with permission of Yandros aka Daniel Henry-=
Mantilla
+    (
+        $(#[$struct_meta:meta])*
+        $struct_vis:vis
+        struct $StructName:ident {
+            $(
+                $(#[$field_meta:meta])*
+                $field_vis:vis
+                $field_name:ident : $field_ty:ty
+            ),*
+            $(,)?
+        }
+    ) =3D> (
+        #[cfg(not(has_offset_of))]
+        const _: () =3D {
+            struct StructOffsetsHelper<T>(std::marker::PhantomData<T>);
+            const END_OF_PREV_FIELD: usize =3D 0;
+
+            // populate StructOffsetsHelper<T> with associated consts,
+            // one for each field
+            $crate::with_offsets! {
+                @struct $StructName
+                @names [ $($field_name)* ]
+                @tys [ $($field_ty ,)*]
+            }
+
+            // now turn StructOffsetsHelper<T>'s consts into a single stru=
ct,
+            // applying field visibility.  This provides better error mess=
ages
+            // than if offset_of! used StructOffsetsHelper::<T> directly.
+            pub
+            struct StructOffsets {
+                $(
+                    $field_vis
+                    $field_name: usize,
+                )*
+            }
+            impl $StructName {
+                pub
+                const OFFSET_TO__: StructOffsets =3D StructOffsets {
+                    $(
+                        $field_name: StructOffsetsHelper::<$StructName>::$=
field_name,
+                    )*
+                };
+            }
+        };
+    );
+
+    (
+        @struct $StructName:ident
+        @names []
+        @tys []
+    ) =3D> ();
+
+    (
+        @struct $StructName:ident
+        @names [$field_name:ident $($other_names:tt)*]
+        @tys [$field_ty:ty , $($other_tys:tt)*]
+    ) =3D> (
+        #[allow(non_local_definitions)]
+        #[allow(clippy::modulo_one)]
+        impl StructOffsetsHelper<$StructName> {
+            #[allow(nonstandard_style)]
+            const $field_name: usize =3D {
+                const ALIGN: usize =3D std::mem::align_of::<$field_ty>();
+                const TRAIL: usize =3D END_OF_PREV_FIELD % ALIGN;
+                END_OF_PREV_FIELD + (if TRAIL =3D=3D 0 { 0usize } else { A=
LIGN - TRAIL })
+            };
+        }
+        const _: () =3D {
+            const END_OF_PREV_FIELD: usize =3D
+                StructOffsetsHelper::<$StructName>::$field_name +
+                std::mem::size_of::<$field_ty>()
+            ;
+            $crate::with_offsets! {
+                @struct $StructName
+                @names [$($other_names)*]
+                @tys [$($other_tys)*]
+            }
+        };
+    );
+}
+
+#[cfg(test)]
+mod tests {
+    use crate::offset_of;
+
+    #[repr(C)]
+    struct Foo {
+        a: u16,
+        b: u32,
+        c: u64,
+        d: u16,
+    }
+
+    #[repr(C)]
+    struct Bar {
+        pub a: u16,
+        pub b: u64,
+        c: Foo,
+        d: u64,
+    }
+
+    crate::with_offsets! {
+        #[repr(C)]
+        struct Bar {
+            pub a: u16,
+            pub b: u64,
+            c: Foo,
+            d: u64,
+        }
+    }
+
+    #[repr(C)]
+    pub struct Baz {
+        b: u32,
+        a: u8,
+    }
+    crate::with_offsets! {
+        #[repr(C)]
+        pub struct Baz {
+            b: u32,
+            a: u8,
+        }
+    }
+
+    #[test]
+    fn test_offset_of() {
+        const OFFSET_TO_C: usize =3D offset_of!(Bar, c);
+
+        assert_eq!(offset_of!(Bar, a), 0);
+        assert_eq!(offset_of!(Bar, b), 8);
+        assert_eq!(OFFSET_TO_C, 16);
+        assert_eq!(offset_of!(Bar, d), 40);
+
+        assert_eq!(offset_of!(Baz, b), 0);
+        assert_eq!(offset_of!(Baz, a), 4);
+    }
+}
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 605bc99ed4c..96e413b75ee 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -20,6 +20,7 @@ fn test_device_decl_macros() {
         unmigratable: true,
     }
=20
+    #[derive(qemu_api_macros::offsets)]
     #[repr(C)]
     #[derive(qemu_api_macros::Object)]
     pub struct DummyState {
diff --git a/subprojects/packagefiles/syn-2-rs/meson.build b/subprojects/pa=
ckagefiles/syn-2-rs/meson.build
index a53335f3092..9f56ce1c24d 100644
--- a/subprojects/packagefiles/syn-2-rs/meson.build
+++ b/subprojects/packagefiles/syn-2-rs/meson.build
@@ -24,6 +24,7 @@ _syn_rs =3D static_library(
     '--cfg', 'feature=3D"printing"',
     '--cfg', 'feature=3D"clone-impls"',
     '--cfg', 'feature=3D"proc-macro"',
+    '--cfg', 'feature=3D"extra-traits"',
   ],
   dependencies: [
     quote_dep,
--=20
2.46.2


