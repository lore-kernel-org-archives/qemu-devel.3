Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E410D1039A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Mnk-0003qy-Sw; Fri, 25 Oct 2024 12:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4MnN-0003j3-L7
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:04:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4MnH-0004uJ-36
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729872246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+5UXLeSNTKZFIyyJrO31yi9+dqN57JHc1LDcaUTPJDk=;
 b=XO+lvWruqHDP0mv60nMaPinigPhdPza1W8e7VVnllKzosWS1mJyqKrZgWY33310tYtZXft
 E/67z5yAOoBlzI0sR3wRUnnxrgFu218yakdt4mLZ5fvwsMIqNrh2GC1Ht1Xc0x+WTDxVie
 mHopBpg439T1Kfh56crNCn5X5ykw/f4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-Gi9L_qHiNxW3dXjd9m55Ew-1; Fri, 25 Oct 2024 12:04:05 -0400
X-MC-Unique: Gi9L_qHiNxW3dXjd9m55Ew-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a99fc3e2285so146469766b.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729872241; x=1730477041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+5UXLeSNTKZFIyyJrO31yi9+dqN57JHc1LDcaUTPJDk=;
 b=XSeQ6gj/9V1juuQ3IFmO/PQedqqwfbjr3mh4t3ak0QgarEFxMl2pr9twIdkqr2UxHn
 BgRVb9YM3RmU2sfv9kZ1i6oLc1Ck8jw75PIqZeE6Dl1r+qYPRR9aeUXC5dJz8wfuNPgd
 Jgx5VYNgcBjwJWhmJ+4aRsxFMtaq5ivVNONWRMLDwgBc4I5dK9vw4W8lYYFYvNmOfxmL
 iyNx6dNNA8Bps8upBatuSR9gtEajY49mWojyF6Gnbyh2Oxs50jZSBw8uWpCB9qLNV50G
 9UYOlux98nHbooBUOi/fm2vllCENVK/bkt/vao0HNUIICArdnUbvYyREaJOUdPivxGtb
 Bo7w==
X-Gm-Message-State: AOJu0YzUgd0kNuJ4MrOvTbVavN+HveB1SlDyvbvM/hqJQ0rirKjRG4o4
 jWZL1Q5c2gkGn743OasVkjMUdIfWoo5gJA2CV4pngMKAzqd6fwZh22AiQ2mM8x/qDuZnEp0gK65
 qnj3K2LA6fgM591UR07DlRyZYQeJFP++2DHbMElMImn52Hezi4Dy7AvKCfzH2ckS/5XL/+CJPrv
 6PPfZXT5SQIydp/Q2BqOhWYO4ZqXw48qmxwydYJwY=
X-Received: by 2002:a17:907:7b97:b0:a9a:14fc:9868 with SMTP id
 a640c23a62f3a-a9abf845c7emr1011199166b.4.1729872240582; 
 Fri, 25 Oct 2024 09:04:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYbCkXHSHn0pW3MitwYigUbxut1i9SGXK1VPt/u1JezpzIrvN6KNAV2yh56q907VieuHuq0Q==
X-Received: by 2002:a17:907:7b97:b0:a9a:14fc:9868 with SMTP id
 a640c23a62f3a-a9abf845c7emr1011194966b.4.1729872239882; 
 Fri, 25 Oct 2024 09:03:59 -0700 (PDT)
Received: from [192.168.10.47] ([151.81.112.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b3a08477bsm84055966b.201.2024.10.25.09.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:03:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: [PATCH 15/23] rust: introduce alternative implementation of offset_of!
Date: Fri, 25 Oct 2024 18:02:00 +0200
Message-ID: <20241025160209.194307-16-pbonzini@redhat.com>
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

The procedural macro is perhaps a bit overengineered, but it helps
introducing some idioms that will be useful in the future as well.

Signed-off-by: Junjie Mao <junjie.mao@hotmail.com>
Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock                               |   1 +
 rust/hw/char/pl011/src/device.rs              |   2 +-
 rust/qemu-api-macros/Cargo.toml               |   2 +-
 rust/qemu-api-macros/src/lib.rs               |  81 ++++++++-
 rust/qemu-api/Cargo.toml                      |   6 +-
 rust/qemu-api/build.rs                        |   9 +
 rust/qemu-api/meson.build                     |  12 +-
 rust/qemu-api/src/device_class.rs             |   8 +-
 rust/qemu-api/src/lib.rs                      |   4 +
 rust/qemu-api/src/offset_of.rs                | 161 ++++++++++++++++++
 rust/qemu-api/src/vmstate.rs                  |  10 +-
 rust/qemu-api/tests/tests.rs                  |   1 +
 subprojects/packagefiles/syn-2-rs/meson.build |   1 +
 13 files changed, 280 insertions(+), 18 deletions(-)
 create mode 100644 rust/qemu-api/src/offset_of.rs

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 9f43b33e8b8..c0c6069247a 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
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
index 2d225d544de..bca727e37f0 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -55,7 +55,7 @@ impl DeviceId {
 }
=20
 #[repr(C)]
-#[derive(Debug, qemu_api_macros::Object)]
+#[derive(Debug, qemu_api_macros::Object, qemu_api_macros::offsets)]
 /// PL011 Device Model in QEMU
 pub struct PL011State {
     pub parent_obj: SysBusDevice,
diff --git a/rust/qemu-api-macros/Cargo.toml b/rust/qemu-api-macros/Cargo.t=
oml
index f8d6d03609f..a8f7377106b 100644
--- a/rust/qemu-api-macros/Cargo.toml
+++ b/rust/qemu-api-macros/Cargo.toml
@@ -19,4 +19,4 @@ proc-macro =3D true
 [dependencies]
 proc-macro2 =3D "1"
 quote =3D "1"
-syn =3D "2"
+syn =3D { version =3D "2", features =3D ["extra-traits"] }
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib=
.rs
index a4bc5d01ee8..c2ea22101e4 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -3,8 +3,34 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
=20
 use proc_macro::TokenStream;
-use quote::quote;
-use syn::{parse_macro_input, DeriveInput};
+use proc_macro2::Span;
+use quote::{quote, quote_spanned};
+use syn::{
+    parse_macro_input, parse_quote, punctuated::Punctuated, token::Comma, =
Data, DeriveInput, Field,
+    Fields, Ident, Type, Visibility,
+};
+
+struct CompileError(String, Span);
+
+impl From<CompileError> for proc_macro2::TokenStream {
+    fn from(err: CompileError) -> Self {
+        let CompileError(msg, span) =3D err;
+        quote_spanned! { span =3D> compile_error!(#msg); }
+    }
+}
+
+fn is_c_repr(input: &DeriveInput, msg: &str) -> Result<(), CompileError> {
+    let expected =3D parse_quote! { #[repr(C)] };
+
+    if input.attrs.iter().any(|attr| attr =3D=3D &expected) {
+        Ok(())
+    } else {
+        Err(CompileError(
+            format!("#[repr(C)] required for {}", msg),
+            input.ident.span(),
+        ))
+    }
+}
=20
 #[proc_macro_derive(Object)]
 pub fn derive_object(input: TokenStream) -> TokenStream {
@@ -21,3 +53,48 @@ pub fn derive_object(input: TokenStream) -> TokenStream {
=20
     TokenStream::from(expanded)
 }
+
+fn get_fields(input: &DeriveInput) -> Result<&Punctuated<Field, Comma>, Co=
mpileError> {
+    if let Data::Struct(s) =3D &input.data {
+        if let Fields::Named(fs) =3D &s.fields {
+            Ok(&fs.named)
+        } else {
+            Err(CompileError(
+                "Cannot generate offsets for unnamed fields.".to_string(),
+                input.ident.span(),
+            ))
+        }
+    } else {
+        Err(CompileError(
+            "Cannot generate offsets for union or enum.".to_string(),
+            input.ident.span(),
+        ))
+    }
+}
+
+#[rustfmt::skip::macros(quote)]
+fn derive_offsets_or_error(input: DeriveInput) -> Result<proc_macro2::Toke=
nStream, CompileError> {
+    is_c_repr(&input, "#[derive(offsets)]")?;
+
+    let name =3D &input.ident;
+    let fields =3D get_fields(&input)?;
+    let field_names: Vec<&Ident> =3D fields.iter().map(|f| f.ident.as_ref(=
).unwrap()).collect();
+    let field_types: Vec<&Type> =3D fields.iter().map(|f| &f.ty).collect();
+    let field_vis: Vec<&Visibility> =3D fields.iter().map(|f| &f.vis).coll=
ect();
+
+    Ok(quote! {
+	::qemu_api::with_offsets! {
+	    struct #name {
+		#(#field_vis #field_names: #field_types,)*
+	    }
+	}
+    })
+}
+
+#[proc_macro_derive(offsets)]
+pub fn derive_offsets(input: TokenStream) -> TokenStream {
+    let input =3D parse_macro_input!(input as DeriveInput);
+    let expanded =3D derive_offsets_or_error(input).unwrap_or_else(Into::i=
nto);
+
+    TokenStream::from(expanded)
+}
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index e092f61e8f3..cc716d75d46 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -16,9 +16,13 @@ categories =3D []
 [dependencies]
 qemu_api_macros =3D { path =3D "../qemu-api-macros" }
=20
+[build-dependencies]
+version_check =3D "~0.9"
+
 [features]
 default =3D []
 allocator =3D []
=20
 [lints.rust]
-unexpected_cfgs =3D { level =3D "warn", check-cfg =3D ['cfg(MESON)', 'cfg(=
HAVE_GLIB_WITH_ALIGNED_ALLOC)'] }
+unexpected_cfgs =3D { level =3D "warn", check-cfg =3D ['cfg(MESON)', 'cfg(=
HAVE_GLIB_WITH_ALIGNED_ALLOC)',
+                                                 'cfg(has_offset_of)'] }
diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
index 419b154c2d2..20f8f718b90 100644
--- a/rust/qemu-api/build.rs
+++ b/rust/qemu-api/build.rs
@@ -4,6 +4,8 @@
=20
 use std::path::Path;
=20
+use version_check as rustc;
+
 fn main() {
     if !Path::new("src/bindings.rs").exists() {
         panic!(
@@ -11,4 +13,11 @@ fn main() {
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
index c950b008d59..6f637af7b1b 100644
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
@@ -6,6 +12,7 @@ _qemu_api_rs =3D static_library(
       'src/c_str.rs',
       'src/definitions.rs',
       'src/device_class.rs',
+      'src/offset_of.rs',
       'src/vmstate.rs',
       'src/zeroable.rs',
     ],
@@ -13,10 +20,7 @@ _qemu_api_rs =3D static_library(
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
index cb4573ca6ef..56608c7f7fc 100644
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
             defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval =
as u64 },
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
index e6bd953e10b..aa8d16ec94b 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -32,6 +32,7 @@ unsafe impl Sync for bindings::VMStateInfo {}
 pub mod c_str;
 pub mod definitions;
 pub mod device_class;
+pub mod offset_of;
 pub mod vmstate;
 pub mod zeroable;
=20
@@ -169,3 +170,6 @@ unsafe fn dealloc(&self, ptr: *mut u8, layout: Layout) {
         }
     }
 }
+
+#[cfg(has_offset_of)]
+pub use core::mem::offset_of;
diff --git a/rust/qemu-api/src/offset_of.rs b/rust/qemu-api/src/offset_of.rs
new file mode 100644
index 00000000000..075e98f986b
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
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 0aaaef1c7c8..b452d01ae3e 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -57,7 +57,7 @@ macro_rules! vmstate_single_test {
                 .as_bytes()
                 .as_ptr() as *const ::std::os::raw::c_char,
             err_hint: ::core::ptr::null(),
-            offset: ::core::mem::offset_of!($struct_name, $field_name),
+            offset: $crate::offset_of!($struct_name, $field_name),
             size: $size,
             start: 0,
             num: 0,
@@ -134,7 +134,7 @@ macro_rules! vmstate_array {
                 .as_bytes()
                 .as_ptr() as *const ::std::os::raw::c_char,
             err_hint: ::core::ptr::null(),
-            offset: ::core::mem::offset_of!($struct_name, $field_name),
+            offset: $crate::offset_of!($struct_name, $field_name),
             size: $size,
             start: 0,
             num: $length as _,
@@ -182,7 +182,7 @@ macro_rules! vmstate_struct_pointer_v {
                 .as_bytes()
                 .as_ptr() as *const ::std::os::raw::c_char,
             err_hint: ::core::ptr::null(),
-            offset: ::core::mem::offset_of!($struct_name, $field_name),
+            offset: $crate::offset_of!($struct_name, $field_name),
             size: ::core::mem::size_of::<*const $type>(),
             start: 0,
             num: 0,
@@ -211,7 +211,7 @@ macro_rules! vmstate_array_of_pointer {
             info: $info,
             size: ::core::mem::size_of::<*const $type>(),
             flags: VMStateFlags(VMStateFlags::VMS_ARRAY.0 | VMStateFlags::=
VMS_ARRAY_OF_POINTER.0),
-            offset: ::core::mem::offset_of!($struct_name, $field_name),
+            offset: $crate::offset_of!($struct_name, $field_name),
             err_hint: ::core::ptr::null(),
             start: 0,
             num_offset: 0,
@@ -240,7 +240,7 @@ macro_rules! vmstate_array_of_pointer_to_struct {
                     | VMStateFlags::VMS_STRUCT.0
                     | VMStateFlags::VMS_ARRAY_OF_POINTER.0,
             ),
-            offset: ::core::mem::offset_of!($struct_name, $field_name),
+            offset: $crate::offset_of!($struct_name, $field_name),
             err_hint: ::core::ptr::null(),
             start: 0,
             num_offset: 0,
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 381ac84657b..7442f695646 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -21,6 +21,7 @@ fn test_device_decl_macros() {
         ..Zeroable::ZERO
     };
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
2.47.0


