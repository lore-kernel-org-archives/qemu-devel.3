Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74005C3ABAD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 10:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAnYf-0001GJ-Ay; Fri, 02 May 2025 06:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAnYb-0001FL-9Q
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAnYX-0000j0-Ud
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746181425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1wYFKFukEgC4q83remIku1UKrxyAwoZsTo9ED8Ho7I0=;
 b=PobhkfR/XJr3FCtlH0roIVwRAr1pNBUiDCWyZMpgy6lagF+F5+++R9dTDXzLXybt2Z7Ijk
 IUB9yZdtlIJGdc0e/dheaI5rRhXj0q199QczjY5hHuhu+64WSaG56OaZHZPl8dsCzmuJP7
 OYhPPFB/IJpvwH72xMQsfHeCZ033/u4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232--tuzoninPTOXzvfRDRp73Q-1; Fri, 02 May 2025 06:23:44 -0400
X-MC-Unique: -tuzoninPTOXzvfRDRp73Q-1
X-Mimecast-MFC-AGG-ID: -tuzoninPTOXzvfRDRp73Q_1746181423
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d00017e9dso8906215e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 03:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746181422; x=1746786222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1wYFKFukEgC4q83remIku1UKrxyAwoZsTo9ED8Ho7I0=;
 b=RqAV9JRXn2lDtaNdh8C94nQID8Si0CeLtTFxU2xVY30sSGn+cktW/UX7IqV96+QYii
 opPgqvj8xL9R2hR82kLhZY49Hp9ijH2p5CZkHDVcrAinqb3nSFAUgu+ypbXRaGND0Ruf
 KXUQ+RIW6jrkaRSgBSQmWDOLSbMGPZQj6mR4QMQgufjkwJxC1aeVal+k2I/PPIgtPLds
 89GJ+Oc20scedGMv7Ng7tr8yuG/n427fwbX9XvWZ9He7/PK5zVOqQz/ZjvW2ViaLHWeu
 d0xCwnADOpXEUChDoQxJHuZEZGGHBoXmWLisYebhCwz7Tzfy6y8149CA9HCeHDcou+Ky
 qn8g==
X-Gm-Message-State: AOJu0Yz8/JBce15xJ/7I1oVA3HSVHFZKxOUfZjy2zofZAtAY7zwBUGJC
 U5WD5uhDKCUTZovmXgcPoZDVWZpmQaAGSY4BRSZYvAkwOJLSHHpC5muzkh072PxWBiVpNfyAtwZ
 zBg8CkMWnIwyzRv6vShhVrfHI2WM0TLvQBJ3RjcnT2+VZNISdqZ6ZetnqWykf4/9DZWGPfS9VPK
 mf1NBpBP9HuM+6lG8bA9DCCM9MSYysyPATmtu4
X-Gm-Gg: ASbGnctvb+n9ZEoaaj7xJhHj+2Vr3oWb/zV+QlRxtQ/jGVazuA8SYFDhOKJkJjwngCf
 hFvO3bdl3hqkIBhiauvWM/Mg0r1ZeAHTSiNF//v681MijU9SwapPiVOXkn+k/xwUfn6Nri/Bhkj
 T0yhObBAr6lyQx5VYyZsCLZKNfql2YbOaIsna99C/XTqrgsk8gZEPmi6nDfh1MhtAQw8NVUGy1S
 F4g73AcYfD4Cj/yNoYXflKPDPy026JGMHp5d0jknmjxar5fjWx5KMijWZq5QI91qiwT0w2/3YK1
 zzNTkioturf8HZw=
X-Received: by 2002:a05:600c:1f94:b0:43d:5ec:b2f4 with SMTP id
 5b1f17b1804b1-441bbeb36afmr22245055e9.10.1746181421446; 
 Fri, 02 May 2025 03:23:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzG6gfgMHL9lJlqgDZyxzQx3ByVYr4LexcBEYEwQxYCUQjgAKWYWeECEcC6CWq6jlHEM/aTg==
X-Received: by 2002:a05:600c:1f94:b0:43d:5ec:b2f4 with SMTP id
 5b1f17b1804b1-441bbeb36afmr22244595e9.10.1746181420775; 
 Fri, 02 May 2025 03:23:40 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae3403sm1730617f8f.28.2025.05.02.03.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 03:23:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 6/9] rust: remove offset_of replacement
Date: Fri,  2 May 2025 12:23:19 +0200
Message-ID: <20250502102323.104815-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502102323.104815-1-pbonzini@redhat.com>
References: <20250502102323.104815-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

---
 docs/devel/rust.rst                  |   6 -
 rust/Cargo.toml                      |   2 +-
 rust/hw/char/pl011/src/device.rs     |   4 +-
 rust/hw/timer/hpet/src/hpet.rs       |   4 +-
 rust/qemu-api-macros/src/lib.rs      |  29 +----
 rust/qemu-api/Cargo.toml             |   3 -
 rust/qemu-api/build.rs               |   7 --
 rust/qemu-api/meson.build            |   4 -
 rust/qemu-api/src/lib.rs             |   4 -
 rust/qemu-api/src/offset_of.rs       | 168 ---------------------------
 rust/qemu-api/src/qdev.rs            |   6 +-
 rust/qemu-api/src/vmstate.rs         |  10 +-
 rust/qemu-api/tests/tests.rs         |   2 -
 rust/qemu-api/tests/vmstate_tests.rs |   5 +-
 14 files changed, 16 insertions(+), 238 deletions(-)
 delete mode 100644 rust/qemu-api/src/offset_of.rs

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 13a002cfe69..8dad90fdf98 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -86,12 +86,6 @@ are missing:
 * ``c"" literals`` (stable in 1.77.0).  QEMU provides a ``c_str!()`` macro
   to define ``CStr`` constants easily
 
-* ``offset_of!`` (stable in 1.77.0).  QEMU uses ``offset_of!()`` heavily; it
-  provides a replacement in the ``qemu_api`` crate, but it does not support
-  lifetime parameters and therefore ``&'a Something`` fields in the struct
-  may have to be replaced by ``NonNull<Something>``.  *Nested* ``offset_of!``
-  was only stabilized in Rust 1.82.0, but it is not used.
-
 * inline const expression (stable in 1.79.0), currently worked around with
   associated constants in the ``FnCall`` trait.
 
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index ab1185a8143..ea2a85a1d07 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -10,7 +10,7 @@ members = [
 [workspace.lints.rust]
 unexpected_cfgs = { level = "deny", check-cfg = [
     'cfg(MESON)', 'cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)',
-    'cfg(has_offset_of)'] }
+] }
 
 # Occasionally, we may need to silence warnings and clippy lints that
 # were only introduced in newer Rust compiler versions.  Do not croak
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index bb2a0f207a5..7c563ade9cd 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -74,7 +74,7 @@ fn index(&self, idx: u32) -> &Self::Output {
 }
 
 #[repr(C)]
-#[derive(Debug, Default, qemu_api_macros::offsets)]
+#[derive(Debug, Default)]
 pub struct PL011Registers {
     #[doc(alias = "fr")]
     pub flags: registers::Flags,
@@ -98,7 +98,7 @@ pub struct PL011Registers {
 }
 
 #[repr(C)]
-#[derive(qemu_api_macros::Object, qemu_api_macros::offsets)]
+#[derive(qemu_api_macros::Object)]
 /// PL011 Device Model in QEMU
 pub struct PL011State {
     pub parent_obj: ParentField<SysBusDevice>,
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index d4364f2f2f7..72609c31f44 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -183,7 +183,7 @@ fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
 
 /// HPET Timer Abstraction
 #[repr(C)]
-#[derive(Debug, qemu_api_macros::offsets)]
+#[derive(Debug)]
 pub struct HPETTimer {
     /// timer N index within the timer block (`HPETState`)
     #[doc(alias = "tn")]
@@ -523,7 +523,7 @@ fn write(&mut self, reg: TimerRegister, value: u64, shift: u32, len: u32) {
 
 /// HPET Event Timer Block Abstraction
 #[repr(C)]
-#[derive(qemu_api_macros::Object, qemu_api_macros::offsets)]
+#[derive(qemu_api_macros::Object)]
 pub struct HPETState {
     parent_obj: ParentField<SysBusDevice>,
     iomem: MemoryRegion,
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 1448f3025a4..108f434ed44 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -6,7 +6,7 @@
 use quote::quote;
 use syn::{
     parse_macro_input, parse_quote, punctuated::Punctuated, spanned::Spanned, token::Comma, Data,
-    DeriveInput, Field, Fields, FieldsUnnamed, Ident, Meta, Path, Token, Type, Variant, Visibility,
+    DeriveInput, Field, Fields, FieldsUnnamed, Ident, Meta, Path, Token, Variant,
 };
 
 mod utils;
@@ -157,33 +157,6 @@ pub fn derive_opaque(input: TokenStream) -> TokenStream {
     TokenStream::from(expanded)
 }
 
-#[rustfmt::skip::macros(quote)]
-fn derive_offsets_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, MacroError> {
-    is_c_repr(&input, "#[derive(offsets)]")?;
-
-    let name = &input.ident;
-    let fields = get_fields(&input, "#[derive(offsets)]")?;
-    let field_names: Vec<&Ident> = fields.iter().map(|f| f.ident.as_ref().unwrap()).collect();
-    let field_types: Vec<&Type> = fields.iter().map(|f| &f.ty).collect();
-    let field_vis: Vec<&Visibility> = fields.iter().map(|f| &f.vis).collect();
-
-    Ok(quote! {
-	::qemu_api::with_offsets! {
-	    struct #name {
-		#(#field_vis #field_names: #field_types,)*
-	    }
-	}
-    })
-}
-
-#[proc_macro_derive(offsets)]
-pub fn derive_offsets(input: TokenStream) -> TokenStream {
-    let input = parse_macro_input!(input as DeriveInput);
-    let expanded = derive_offsets_or_error(input).unwrap_or_else(Into::into);
-
-    TokenStream::from(expanded)
-}
-
 #[allow(non_snake_case)]
 fn get_repr_uN(input: &DeriveInput, msg: &str) -> Result<Path, MacroError> {
     let repr = input.attrs.iter().find(|attr| attr.path().is_ident("repr"));
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index 57747bc9341..c5b7b2464e9 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -18,9 +18,6 @@ rust-version = "1.63.0"
 qemu_api_macros = { path = "../qemu-api-macros" }
 libc = "0.2.162"
 
-[build-dependencies]
-version_check = "~0.9"
-
 [features]
 default = ["debug_cell"]
 allocator = []
diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
index 471e6c633df..470be2a4d54 100644
--- a/rust/qemu-api/build.rs
+++ b/rust/qemu-api/build.rs
@@ -8,8 +8,6 @@
 use std::os::windows::fs::symlink_file;
 use std::{env, fs::remove_file, io::Result, path::Path};
 
-use version_check as rustc;
-
 fn main() -> Result<()> {
     // Placing bindings.inc.rs in the source directory is supported
     // but not documented or encouraged.
@@ -38,11 +36,6 @@ fn main() -> Result<()> {
     }
     symlink_file(file, dest_path)?;
 
-    // Check for available rustc features
-    if rustc::is_min_version("1.77.0").unwrap_or(false) {
-        println!("cargo:rustc-cfg=has_offset_of");
-    }
-
     println!("cargo:rerun-if-changed=build.rs");
     Ok(())
 }
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 858685ddd4a..95e65643ae1 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -5,9 +5,6 @@ _qemu_api_cfg = run_command(rustc_args,
 libc_dep = dependency('libc-0.2-rs')
 
 # _qemu_api_cfg += ['--cfg', 'feature="allocator"']
-if rustc.version().version_compare('>=1.77.0')
-  _qemu_api_cfg += ['--cfg', 'has_offset_of']
-endif
 if get_option('debug_mutex')
   _qemu_api_cfg += ['--cfg', 'feature="debug_cell"']
 endif
@@ -28,7 +25,6 @@ _qemu_api_rs = static_library(
       'src/irq.rs',
       'src/memory.rs',
       'src/module.rs',
-      'src/offset_of.rs',
       'src/prelude.rs',
       'src/qdev.rs',
       'src/qom.rs',
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index c3641e893b7..90c19636660 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -23,7 +23,6 @@
 pub mod irq;
 pub mod memory;
 pub mod module;
-pub mod offset_of;
 pub mod qdev;
 pub mod qom;
 pub mod sysbus;
@@ -165,6 +164,3 @@ unsafe fn dealloc(&self, ptr: *mut u8, layout: Layout) {
         }
     }
 }
-
-#[cfg(has_offset_of)]
-pub use core::mem::offset_of;
diff --git a/rust/qemu-api/src/offset_of.rs b/rust/qemu-api/src/offset_of.rs
deleted file mode 100644
index 373229bbde9..00000000000
--- a/rust/qemu-api/src/offset_of.rs
+++ /dev/null
@@ -1,168 +0,0 @@
-// SPDX-License-Identifier: MIT
-
-#![doc(hidden)]
-//! This module provides macros that emulate the functionality of
-//! `core::mem::offset_of` on older versions of Rust.
-//!
-//! Documentation is hidden because it only exposes macros, which
-//! are exported directly from `qemu_api`.
-
-/// This macro provides the same functionality as `core::mem::offset_of`,
-/// except that only one level of field access is supported.  The declaration
-/// of the struct must be wrapped with `with_offsets! { }`.
-///
-/// It is needed because `offset_of!` was only stabilized in Rust 1.77.
-#[cfg(not(has_offset_of))]
-#[macro_export]
-macro_rules! offset_of {
-    ($Container:ty, $field:ident) => {
-        <$Container>::OFFSET_TO__.$field
-    };
-}
-
-/// A wrapper for struct declarations, that allows using `offset_of!` in
-/// versions of Rust prior to 1.77
-#[macro_export]
-macro_rules! with_offsets {
-    // This method to generate field offset constants comes from:
-    //
-    //     https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=10a22a9b8393abd7b541d8fc844bc0df
-    //
-    // used under MIT license with permission of Yandros aka Daniel Henry-Mantilla
-    (
-        $(#[$struct_meta:meta])*
-        $struct_vis:vis
-        struct $StructName:ident {
-            $(
-                $(#[$field_meta:meta])*
-                $field_vis:vis
-                $field_name:ident : $field_ty:ty
-            ),*
-            $(,)?
-        }
-    ) => (
-        #[cfg(not(has_offset_of))]
-        const _: () = {
-            struct StructOffsetsHelper<T>(std::marker::PhantomData<T>);
-            const END_OF_PREV_FIELD: usize = 0;
-
-            // populate StructOffsetsHelper<T> with associated consts,
-            // one for each field
-            $crate::with_offsets! {
-                @struct $StructName
-                @names [ $($field_name)* ]
-                @tys [ $($field_ty ,)*]
-            }
-
-            // now turn StructOffsetsHelper<T>'s consts into a single struct,
-            // applying field visibility.  This provides better error messages
-            // than if offset_of! used StructOffsetsHelper::<T> directly.
-            pub
-            struct StructOffsets {
-                $(
-                    $field_vis
-                    $field_name: usize,
-                )*
-            }
-            impl $StructName {
-                pub
-                const OFFSET_TO__: StructOffsets = StructOffsets {
-                    $(
-                        $field_name: StructOffsetsHelper::<$StructName>::$field_name,
-                    )*
-                };
-            }
-        };
-    );
-
-    (
-        @struct $StructName:ident
-        @names []
-        @tys []
-    ) => ();
-
-    (
-        @struct $StructName:ident
-        @names [$field_name:ident $($other_names:tt)*]
-        @tys [$field_ty:ty , $($other_tys:tt)*]
-    ) => (
-        #[allow(non_local_definitions)]
-        #[allow(clippy::modulo_one)]
-        impl StructOffsetsHelper<$StructName> {
-            #[allow(nonstandard_style)]
-            const $field_name: usize = {
-                const ALIGN: usize = std::mem::align_of::<$field_ty>();
-                const TRAIL: usize = END_OF_PREV_FIELD % ALIGN;
-                END_OF_PREV_FIELD + (if TRAIL == 0 { 0usize } else { ALIGN - TRAIL })
-            };
-        }
-        const _: () = {
-            const END_OF_PREV_FIELD: usize =
-                StructOffsetsHelper::<$StructName>::$field_name +
-                std::mem::size_of::<$field_ty>()
-            ;
-            $crate::with_offsets! {
-                @struct $StructName
-                @names [$($other_names)*]
-                @tys [$($other_tys)*]
-            }
-        };
-    );
-}
-
-#[cfg(test)]
-mod tests {
-    use crate::offset_of;
-
-    #[repr(C)]
-    struct Foo {
-        a: u16,
-        b: u32,
-        c: u64,
-        d: u16,
-    }
-
-    #[repr(C)]
-    struct Bar {
-        pub a: u16,
-        pub b: u64,
-        c: Foo,
-        d: u64,
-    }
-
-    crate::with_offsets! {
-        #[repr(C)]
-        struct Bar {
-            pub a: u16,
-            pub b: u64,
-            c: Foo,
-            d: u64,
-        }
-    }
-
-    #[repr(C)]
-    pub struct Baz {
-        b: u32,
-        a: u8,
-    }
-    crate::with_offsets! {
-        #[repr(C)]
-        pub struct Baz {
-            b: u32,
-            a: u8,
-        }
-    }
-
-    #[test]
-    fn test_offset_of() {
-        const OFFSET_TO_C: usize = offset_of!(Bar, c);
-
-        assert_eq!(offset_of!(Bar, a), 0);
-        assert_eq!(offset_of!(Bar, b), 8);
-        assert_eq!(OFFSET_TO_C, 16);
-        assert_eq!(offset_of!(Bar, d), 40);
-
-        assert_eq!(offset_of!(Baz, b), 0);
-        assert_eq!(offset_of!(Baz, a), 4);
-    }
-}
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 17c7fecabeb..1279d7a58d5 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -190,7 +190,7 @@ macro_rules! define_property {
             // use associated function syntax for type checking
             name: ::std::ffi::CStr::as_ptr($name),
             info: $prop,
-            offset: $crate::offset_of!($state, $field) as isize,
+            offset: ::std::mem::offset_of!($state, $field) as isize,
             bitnr: $bitnr,
             set_default: true,
             defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval as u64 },
@@ -202,7 +202,7 @@ macro_rules! define_property {
             // use associated function syntax for type checking
             name: ::std::ffi::CStr::as_ptr($name),
             info: $prop,
-            offset: $crate::offset_of!($state, $field) as isize,
+            offset: ::std::mem::offset_of!($state, $field) as isize,
             set_default: true,
             defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval as u64 },
             ..$crate::zeroable::Zeroable::ZERO
@@ -213,7 +213,7 @@ macro_rules! define_property {
             // use associated function syntax for type checking
             name: ::std::ffi::CStr::as_ptr($name),
             info: $prop,
-            offset: $crate::offset_of!($state, $field) as isize,
+            offset: ::std::mem::offset_of!($state, $field) as isize,
             set_default: false,
             ..$crate::zeroable::Zeroable::ZERO
         }
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 78c7f17db13..9a6e6b734b9 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -205,8 +205,8 @@ macro_rules! vmstate_of {
             name: ::core::concat!(::core::stringify!($field_name), "\0")
                 .as_bytes()
                 .as_ptr() as *const ::std::os::raw::c_char,
-            offset: $crate::offset_of!($struct_name, $field_name),
-            $(num_offset: $crate::offset_of!($struct_name, $num),)?
+            offset: ::std::mem::offset_of!($struct_name, $field_name),
+            $(num_offset: ::std::mem::offset_of!($struct_name, $num),)?
             // The calls to `call_func_with_field!` are the magic that
             // computes most of the VMStateField from the type of the field.
             info: $crate::info_enum_to_ref!($crate::call_func_with_field!(
@@ -482,10 +482,10 @@ macro_rules! vmstate_struct {
             name: ::core::concat!(::core::stringify!($field_name), "\0")
                 .as_bytes()
                 .as_ptr() as *const ::std::os::raw::c_char,
-            $(num_offset: $crate::offset_of!($struct_name, $num),)?
+            $(num_offset: ::std::mem::offset_of!($struct_name, $num),)?
             offset: {
                 $crate::assert_field_type!($struct_name, $field_name, $type $(, num = $num)?);
-                $crate::offset_of!($struct_name, $field_name)
+                ::std::mem::offset_of!($struct_name, $field_name)
             },
             size: ::core::mem::size_of::<$type>(),
             flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
@@ -517,7 +517,7 @@ macro_rules! vmstate_clock {
                     $field_name,
                     $crate::qom::Owned<$crate::qdev::Clock> $(, num = $num)?
                 );
-                $crate::offset_of!($struct_name, $field_name)
+                ::std::mem::offset_of!($struct_name, $field_name)
             },
             size: ::core::mem::size_of::<*const $crate::qdev::Clock>(),
             flags: $crate::bindings::VMStateFlags(
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 99a7aab6fed..d045808c3a8 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -26,7 +26,6 @@
     ..Zeroable::ZERO
 };
 
-#[derive(qemu_api_macros::offsets)]
 #[repr(C)]
 #[derive(qemu_api_macros::Object)]
 pub struct DummyState {
@@ -79,7 +78,6 @@ fn vmsd() -> Option<&'static VMStateDescription> {
     }
 }
 
-#[derive(qemu_api_macros::offsets)]
 #[repr(C)]
 #[derive(qemu_api_macros::Object)]
 pub struct DummyChildState {
diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index 9a56ffd2385..cc3527a9b6a 100644
--- a/rust/qemu-api/tests/vmstate_tests.rs
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -33,7 +33,7 @@
 //     - VMSTATE_VARRAY_UINT16_UNSAFE
 //     - VMSTATE_VARRAY_MULTIPLY
 #[repr(C)]
-#[derive(Default, qemu_api_macros::offsets)]
+#[derive(Default)]
 struct FooA {
     arr: [u8; FOO_ARRAY_MAX],
     num: u16,
@@ -154,7 +154,7 @@ fn test_vmstate_varray_multiply() {
 //     - VMSTATE_ARRAY
 //     - VMSTATE_STRUCT_VARRAY_UINT8 with BqlCell wrapper & test_fn
 #[repr(C)]
-#[derive(Default, qemu_api_macros::offsets)]
+#[derive(Default)]
 struct FooB {
     arr_a: [FooA; FOO_ARRAY_MAX],
     num_a: u8,
@@ -329,7 +329,6 @@ fn test_vmstate_struct_varray_uint8_wrapper() {
 impl_vmstate_forward!(FooCWrapper);
 
 #[repr(C)]
-#[derive(qemu_api_macros::offsets)]
 struct FooC {
     ptr: *const i32,
     ptr_a: NonNull<FooA>,
-- 
2.49.0


