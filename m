Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3553AD1BDD2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80sf-00073y-8j; Mon, 04 Nov 2024 12:28:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sd-0006qq-4h
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sZ-0000QO-Ea
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RzUqD1o8XG9OcJ1drSA6m/SQAI0bRYTrCcBia/InCEI=;
 b=VSgGv/U888H3ogIK5aYkvHK9Zyuhq4Cz4DPZtO3qojd03fxheJSEkJZ5vzeOLRF/jtVEPr
 c1OTaeaMaKNFK9aavr/f3LKzkcZaBQzoDBb/KqtpK+3tz3+fXJSp6ezgMVhBPLjRbInMwd
 J0IQg6uGiBHiTfilAnaNaHWwU3RFXDQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-z8CmHG9sOBysFCyYjaWKlQ-1; Mon, 04 Nov 2024 12:28:37 -0500
X-MC-Unique: z8CmHG9sOBysFCyYjaWKlQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43159c07193so38455695e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:28:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741316; x=1731346116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RzUqD1o8XG9OcJ1drSA6m/SQAI0bRYTrCcBia/InCEI=;
 b=FnOjMtQR9nBvj6KZrPWlupczpkqkqla63SIIfniAUg+BYzjK/phOB+9flY8TpmzgvS
 yf/+CETUQS91KOZaOZiQ7/YzIuvHHM6GHDE7/p1+I2vJkADYiSxO+Wkng98C0aFnWjCs
 g1zNKRmUdFlNWbz3F70fqNJTG6snsS7k+aBiWi7HOs/l8gwlOBOKksvaUwGZaSmn8xaa
 4oWOuuwFEiAotFbkCiQHqKIjzmJVKQqIil6kaOAhJDks8xNHsKRAOTbg2IYK6ixcJjHx
 J1S1k7tcoMKClvrQm3EMZ11GeSTfaWfAhTMmNPsJmSnYGD4j0iBB8193kb37QhbS7R5j
 haRQ==
X-Gm-Message-State: AOJu0YyN59jQiZSsd8JA8SC4ML2a2h8iSDYPKjZ6GuCOIbygzru1Od44
 DevtTNcWIlaO7Gdoc5w+2kBOUBD0N2gIwCYHX2LSJ1aqtM7s/0NDsD2I/9z3D100If1ktXIKQgb
 jTJtO3p6C8JSgFCLBN2lvOQGHcohIrZkBgbtl4hYEtSz6Jeuqy1Mrsewc+eZ4ws+pBWsfIotA+g
 AfNY/Kfccen4Xa3otbzFzYF78oe7kkQcjGgPxMxX8=
X-Received: by 2002:a05:600c:4e8a:b0:431:54f3:11ab with SMTP id
 5b1f17b1804b1-43283296051mr139126595e9.33.1730741315413; 
 Mon, 04 Nov 2024 09:28:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDu7f8A0bXAUoqlNkMnVw9bPJK57e55BLdxta9kMLozBSvgQlRTqWF+7GrkMTl9jiQEanJwg==
X-Received: by 2002:a05:600c:4e8a:b0:431:54f3:11ab with SMTP id
 5b1f17b1804b1-43283296051mr139126215e9.33.1730741314773; 
 Mon, 04 Nov 2024 09:28:34 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7c13sm13921096f8f.13.2024.11.04.09.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:28:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 32/40] rust: introduce alternative implementation of offset_of!
Date: Mon,  4 Nov 2024 18:27:11 +0100
Message-ID: <20241104172721.180255-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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
 rust/qemu-api-macros/src/lib.rs               |  75 +++++++-
 rust/qemu-api/Cargo.toml                      |   6 +-
 rust/qemu-api/build.rs                        |   9 +
 rust/qemu-api/meson.build                     |  12 +-
 rust/qemu-api/src/device_class.rs             |   8 +-
 rust/qemu-api/src/lib.rs                      |   4 +
 rust/qemu-api/src/offset_of.rs                | 161 ++++++++++++++++++
 rust/qemu-api/src/vmstate.rs                  |  10 +-
 rust/qemu-api/tests/tests.rs                  |   1 +
 subprojects/packagefiles/syn-2-rs/meson.build |   1 +
 13 files changed, 274 insertions(+), 18 deletions(-)
 create mode 100644 rust/qemu-api/src/offset_of.rs

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 9f43b33e8b8..c0c6069247a 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -93,6 +93,7 @@ name = "qemu_api"
 version = "0.1.0"
 dependencies = [
  "qemu_api_macros",
+ "version_check",
 ]
 
 [[package]]
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 2d225d544de..bca727e37f0 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -55,7 +55,7 @@ impl DeviceId {
 }
 
 #[repr(C)]
-#[derive(Debug, qemu_api_macros::Object)]
+#[derive(Debug, qemu_api_macros::Object, qemu_api_macros::offsets)]
 /// PL011 Device Model in QEMU
 pub struct PL011State {
     pub parent_obj: SysBusDevice,
diff --git a/rust/qemu-api-macros/Cargo.toml b/rust/qemu-api-macros/Cargo.toml
index f8d6d03609f..a8f7377106b 100644
--- a/rust/qemu-api-macros/Cargo.toml
+++ b/rust/qemu-api-macros/Cargo.toml
@@ -19,4 +19,4 @@ proc-macro = true
 [dependencies]
 proc-macro2 = "1"
 quote = "1"
-syn = "2"
+syn = { version = "2", features = ["extra-traits"] }
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index a4bc5d01ee8..cf99ac04b8f 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -3,8 +3,34 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use proc_macro::TokenStream;
-use quote::quote;
-use syn::{parse_macro_input, DeriveInput};
+use proc_macro2::Span;
+use quote::{quote, quote_spanned};
+use syn::{
+    parse_macro_input, parse_quote, punctuated::Punctuated, token::Comma, Data, DeriveInput, Field,
+    Fields, Ident, Type, Visibility,
+};
+
+struct CompileError(String, Span);
+
+impl From<CompileError> for proc_macro2::TokenStream {
+    fn from(err: CompileError) -> Self {
+        let CompileError(msg, span) = err;
+        quote_spanned! { span => compile_error!(#msg); }
+    }
+}
+
+fn is_c_repr(input: &DeriveInput, msg: &str) -> Result<(), CompileError> {
+    let expected = parse_quote! { #[repr(C)] };
+
+    if input.attrs.iter().any(|attr| attr == &expected) {
+        Ok(())
+    } else {
+        Err(CompileError(
+            format!("#[repr(C)] required for {}", msg),
+            input.ident.span(),
+        ))
+    }
+}
 
 #[proc_macro_derive(Object)]
 pub fn derive_object(input: TokenStream) -> TokenStream {
@@ -21,3 +47,48 @@ pub fn derive_object(input: TokenStream) -> TokenStream {
 
     TokenStream::from(expanded)
 }
+
+fn get_fields(input: &DeriveInput) -> Result<&Punctuated<Field, Comma>, CompileError> {
+    if let Data::Struct(s) = &input.data {
+        if let Fields::Named(fs) = &s.fields {
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
+fn derive_offsets_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, CompileError> {
+    is_c_repr(&input, "#[derive(offsets)]")?;
+
+    let name = &input.ident;
+    let fields = get_fields(&input)?;
+    let field_names: Vec<&Ident> = fields.iter().map(|f| f.ident.as_ref().unwrap()).collect();
+    let field_types: Vec<&Type> = fields.iter().map(|f| &f.ty).collect();
+    let field_vis: Vec<&Visibility> = fields.iter().map(|f| &f.vis).collect();
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
+    let input = parse_macro_input!(input as DeriveInput);
+    let expanded = derive_offsets_or_error(input).unwrap_or_else(Into::into);
+
+    TokenStream::from(expanded)
+}
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index e092f61e8f3..cc716d75d46 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -16,9 +16,13 @@ categories = []
 [dependencies]
 qemu_api_macros = { path = "../qemu-api-macros" }
 
+[build-dependencies]
+version_check = "~0.9"
+
 [features]
 default = []
 allocator = []
 
 [lints.rust]
-unexpected_cfgs = { level = "warn", check-cfg = ['cfg(MESON)', 'cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)'] }
+unexpected_cfgs = { level = "warn", check-cfg = ['cfg(MESON)', 'cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)',
+                                                 'cfg(has_offset_of)'] }
diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
index 419b154c2d2..20f8f718b90 100644
--- a/rust/qemu-api/build.rs
+++ b/rust/qemu-api/build.rs
@@ -4,6 +4,8 @@
 
 use std::path::Path;
 
+use version_check as rustc;
+
 fn main() {
     if !Path::new("src/bindings.rs").exists() {
         panic!(
@@ -11,4 +13,11 @@ fn main() {
              (`ninja bindings.rs`) and copy them to src/bindings.rs, or build through meson."
         );
     }
+
+    // Check for available rustc features
+    if rustc::is_min_version("1.77.0").unwrap_or(false) {
+        println!("cargo:rustc-cfg=has_offset_of");
+    }
+
+    println!("cargo:rerun-if-changed=build.rs");
 }
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index c950b008d59..6f637af7b1b 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -1,3 +1,9 @@
+_qemu_api_cfg = ['--cfg', 'MESON']
+# _qemu_api_cfg += ['--cfg', 'feature="allocator"']
+if rustc.version().version_compare('>=1.77.0')
+  _qemu_api_cfg += ['--cfg', 'has_offset_of']
+endif
+
 _qemu_api_rs = static_library(
   'qemu_api',
   structured_sources(
@@ -6,6 +12,7 @@ _qemu_api_rs = static_library(
       'src/c_str.rs',
       'src/definitions.rs',
       'src/device_class.rs',
+      'src/offset_of.rs',
       'src/vmstate.rs',
       'src/zeroable.rs',
     ],
@@ -13,10 +20,7 @@ _qemu_api_rs = static_library(
   ),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
-  rust_args: [
-    '--cfg', 'MESON',
-    # '--cfg', 'feature="allocator"',
-  ],
+  rust_args: _qemu_api_cfg,
 )
 
 rust.test('rust-qemu-api-tests', _qemu_api_rs,
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index cb4573ca6ef..56608c7f7fc 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -23,23 +23,23 @@ macro_rules! device_class_init {
 
 #[macro_export]
 macro_rules! define_property {
-    ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr, default = $defval:expr$(,)*) => {
+    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:expr, default = $defval:expr$(,)*) => {
         $crate::bindings::Property {
             // use associated function syntax for type checking
             name: ::std::ffi::CStr::as_ptr($name),
             info: $prop,
-            offset: ::core::mem::offset_of!($state, $field) as isize,
+            offset: $crate::offset_of!($state, $field) as isize,
             set_default: true,
             defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval as u64 },
             ..$crate::zeroable::Zeroable::ZERO
         }
     };
-    ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr$(,)*) => {
+    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:expr$(,)*) => {
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
+/// except that only one level of field access is supported.  The declaration
+/// of the struct must be wrapped with `with_offsets! { }`.
+///
+/// It is needed because `offset_of!` was only stabilized in Rust 1.77.
+#[cfg(not(has_offset_of))]
+#[macro_export]
+macro_rules! offset_of {
+    ($Container:ty, $field:ident) => {
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
+    //     https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=10a22a9b8393abd7b541d8fc844bc0df
+    //
+    // used under MIT license with permission of Yandros aka Daniel Henry-Mantilla
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
+    ) => (
+        #[cfg(not(has_offset_of))]
+        const _: () = {
+            struct StructOffsetsHelper<T>(std::marker::PhantomData<T>);
+            const END_OF_PREV_FIELD: usize = 0;
+
+            // populate StructOffsetsHelper<T> with associated consts,
+            // one for each field
+            $crate::with_offsets! {
+                @struct $StructName
+                @names [ $($field_name)* ]
+                @tys [ $($field_ty ,)*]
+            }
+
+            // now turn StructOffsetsHelper<T>'s consts into a single struct,
+            // applying field visibility.  This provides better error messages
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
+                const OFFSET_TO__: StructOffsets = StructOffsets {
+                    $(
+                        $field_name: StructOffsetsHelper::<$StructName>::$field_name,
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
+    ) => ();
+
+    (
+        @struct $StructName:ident
+        @names [$field_name:ident $($other_names:tt)*]
+        @tys [$field_ty:ty , $($other_tys:tt)*]
+    ) => (
+        #[allow(non_local_definitions)]
+        #[allow(clippy::modulo_one)]
+        impl StructOffsetsHelper<$StructName> {
+            #[allow(nonstandard_style)]
+            const $field_name: usize = {
+                const ALIGN: usize = std::mem::align_of::<$field_ty>();
+                const TRAIL: usize = END_OF_PREV_FIELD % ALIGN;
+                END_OF_PREV_FIELD + (if TRAIL == 0 { 0usize } else { ALIGN - TRAIL })
+            };
+        }
+        const _: () = {
+            const END_OF_PREV_FIELD: usize =
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
+        const OFFSET_TO_C: usize = offset_of!(Bar, c);
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
index 9c252ce18ef..bedcf1e8f39 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -58,7 +58,7 @@ macro_rules! vmstate_single_test {
                 .as_bytes()
                 .as_ptr() as *const ::std::os::raw::c_char,
             err_hint: ::core::ptr::null(),
-            offset: ::core::mem::offset_of!($struct_name, $field_name),
+            offset: $crate::offset_of!($struct_name, $field_name),
             size: $size,
             start: 0,
             num: 0,
@@ -135,7 +135,7 @@ macro_rules! vmstate_array {
                 .as_bytes()
                 .as_ptr() as *const ::std::os::raw::c_char,
             err_hint: ::core::ptr::null(),
-            offset: ::core::mem::offset_of!($struct_name, $field_name),
+            offset: $crate::offset_of!($struct_name, $field_name),
             size: $size,
             start: 0,
             num: $length as _,
@@ -183,7 +183,7 @@ macro_rules! vmstate_struct_pointer_v {
                 .as_bytes()
                 .as_ptr() as *const ::std::os::raw::c_char,
             err_hint: ::core::ptr::null(),
-            offset: ::core::mem::offset_of!($struct_name, $field_name),
+            offset: $crate::offset_of!($struct_name, $field_name),
             size: ::core::mem::size_of::<*const $type>(),
             start: 0,
             num: 0,
@@ -212,7 +212,7 @@ macro_rules! vmstate_array_of_pointer {
             info: unsafe { $info },
             size: ::core::mem::size_of::<*const $type>(),
             flags: VMStateFlags(VMStateFlags::VMS_ARRAY.0 | VMStateFlags::VMS_ARRAY_OF_POINTER.0),
-            offset: ::core::mem::offset_of!($struct_name, $field_name),
+            offset: $crate::offset_of!($struct_name, $field_name),
             err_hint: ::core::ptr::null(),
             start: 0,
             num_offset: 0,
@@ -241,7 +241,7 @@ macro_rules! vmstate_array_of_pointer_to_struct {
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
 
+    #[derive(qemu_api_macros::offsets)]
     #[repr(C)]
     #[derive(qemu_api_macros::Object)]
     pub struct DummyState {
diff --git a/subprojects/packagefiles/syn-2-rs/meson.build b/subprojects/packagefiles/syn-2-rs/meson.build
index a53335f3092..9f56ce1c24d 100644
--- a/subprojects/packagefiles/syn-2-rs/meson.build
+++ b/subprojects/packagefiles/syn-2-rs/meson.build
@@ -24,6 +24,7 @@ _syn_rs = static_library(
     '--cfg', 'feature="printing"',
     '--cfg', 'feature="clone-impls"',
     '--cfg', 'feature="proc-macro"',
+    '--cfg', 'feature="extra-traits"',
   ],
   dependencies: [
     quote_dep,
-- 
2.47.0


