Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAAAC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnen5-0005ID-Vy; Thu, 27 Feb 2025 09:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnemc-0003qC-KE
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:22:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnemY-00044k-0Q
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DU8RnwXUCUOFmlQq7LelOhzzqajTuinw3yOxvFn4Jv4=;
 b=EhibYWNi/d12bTzwyHSBJfF9ksaLodeM6ENU+gZFhtmTMjy4txbFFJ4Ch2UA6UhltmgT0k
 75At1fMyVF96Ofe6Gq3e4uqZAEg1wXcdN20M4AkcH758bwiUAnlHAiKK1OR0S8O3dPeX7t
 6BnW7TBm2V1Owg3VPkj3C5xJCDMWBMI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-qEoIOJalO4CJ1DBp2bJ3LQ-1; Thu, 27 Feb 2025 09:22:28 -0500
X-MC-Unique: qEoIOJalO4CJ1DBp2bJ3LQ-1
X-Mimecast-MFC-AGG-ID: qEoIOJalO4CJ1DBp2bJ3LQ_1740666147
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5e04de6583bso1482253a12.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:22:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666145; x=1741270945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DU8RnwXUCUOFmlQq7LelOhzzqajTuinw3yOxvFn4Jv4=;
 b=d+Lfmk7w7chkMroCjY3sq1o9+1shjwoj+qRxW/QPIoHyOqQoDsnCFadYd4ocXHwB9U
 gnHmUEWLovch3tSLnkjWUu0f25i0MJJcDIIzORQc2w7pyfXI2Y4xBvFi+5mIraYUXKzI
 /y+2U3QRFRztQoSgMVPrtQDzqRpKyWvr1ASczmhASyB2ypVM92d4P8balN1BOzmktH6n
 IJ3g+VxNZBZFJVE83qyF9jY4Kz/CsLyWSwMWwlUxZ+fADDSEh3zaAXuo2hpKnemMFtNA
 zNE0dM/5JsEMeZgbpTXPc+FD1ZPqhI20lCxMrvbzuMHU7EyAVZz4tEbOh39gJi35m0pi
 bwVg==
X-Gm-Message-State: AOJu0Yz32/JK8eyghBbbQm4f7VzgUKEH9Ztphz51cau2spatxmcJ+FwM
 Afw2aLd/7XOSMLHNOhtpvQX19IPxR+WVf8un8GCz1NLh1sUUNrueOfDy7Cn/iSaToiGRSdcYSF3
 puu8CCddMylbiRfomCT3QedzFjHh1HbDNa552WTDNoltfWj0W9w7ql6WAt0W9LKS0nuAE+Zr/JC
 Rv4AqfzuzfAFUecJavkiN/5PKJM9gNQQX7joMI1Xo=
X-Gm-Gg: ASbGnct3zwxhjYMcCnq6IejMO7w7NHnBIwYUI+KbHBuThdyItO+uKXNKncGbGA0Y2rW
 /WLT0FFvPpVFYvK18BnZ7HXCMNhZU6tIHv8GTqzNaM8YfGyzuolWqDw8SNxlj55feuvwre6nK5T
 /jTvzN99RqvTae0FgkUZ4Yp7sjT9AUQvzcC9ue4+dafG35wZCpqbd1EKeIK/6Vu4DI3B+Ee1IO2
 jEMey2I72IkrU6q6VfkDOsZPUbFo+mCD2ijQDVKZhDWg4+giuHqlkBdt3OwbhF1LJ9tjeYDVTrq
 JOz5O7cnxNjGQKk0m1Uf
X-Received: by 2002:a05:6402:3595:b0:5e0:8c55:536 with SMTP id
 4fb4d7f45d1cf-5e444481531mr13914557a12.4.1740666145476; 
 Thu, 27 Feb 2025 06:22:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQEvRXKFNO8uqehyPrMvfwzyUwe/T2t9ikClNPL5YVhQNUna8NZ1lwhLuT9lhaB++h80+AvQ==
X-Received: by 2002:a05:6402:3595:b0:5e0:8c55:536 with SMTP id
 4fb4d7f45d1cf-5e444481531mr13914532a12.4.1740666145018; 
 Thu, 27 Feb 2025 06:22:25 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3fb58f7sm1145654a12.57.2025.02.27.06.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:22:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 02/12] rust: qemu_api_macros: add Wrapper derive macro
Date: Thu, 27 Feb 2025 15:22:09 +0100
Message-ID: <20250227142219.812270-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227142219.812270-1-pbonzini@redhat.com>
References: <20250227142219.812270-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add a derive macro that makes it easy to peel off all the layers of
specialness (UnsafeCell, MaybeUninit, etc.) and just get a pointer
to the wrapped type; and likewise add them back starting from a
*mut.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst             |  8 +--
 rust/qemu-api-macros/src/lib.rs | 86 ++++++++++++++++++++++++++++++++-
 rust/qemu-api/meson.build       |  7 +--
 rust/qemu-api/src/cell.rs       | 31 ++++++++++++
 4 files changed, 123 insertions(+), 9 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 784c3e40bdc..64e04bc5c41 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -315,11 +315,13 @@ a raw pointer, for use in calls to C functions.  It can be used for
 example as follows::
 
     #[repr(transparent)]
-    #[derive(Debug)]
+    #[derive(Debug, qemu_api_macros::Wrapper)]
     pub struct Object(Opaque<bindings::Object>);
 
-The bindings will then manually check for the big QEMU lock with
-assertions, which allows the wrapper to be declared thread-safe::
+where the special ``derive`` macro provides useful methods such as
+``from_raw``, ``as_ptr`` and ``as_mut_ptr``.  The bindings will then
+manually check for the big QEMU lock with assertions, which allows
+the wrapper to be declared thread-safe::
 
     unsafe impl Send for Object {}
     unsafe impl Sync for Object {}
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 7ec218202f4..3df9c48035d 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -6,7 +6,7 @@
 use quote::quote;
 use syn::{
     parse_macro_input, parse_quote, punctuated::Punctuated, spanned::Spanned, token::Comma, Data,
-    DeriveInput, Field, Fields, Ident, Meta, Path, Token, Type, Variant, Visibility,
+    DeriveInput, Field, Fields, FieldsUnnamed, Ident, Meta, Path, Token, Type, Variant, Visibility,
 };
 
 mod utils;
@@ -33,6 +33,35 @@ fn get_fields<'a>(
     }
 }
 
+fn get_unnamed_field<'a>(input: &'a DeriveInput, msg: &str) -> Result<&'a Field, MacroError> {
+    if let Data::Struct(s) = &input.data {
+        let unnamed = match &s.fields {
+            Fields::Unnamed(FieldsUnnamed {
+                unnamed: ref fields,
+                ..
+            }) => fields,
+            _ => {
+                return Err(MacroError::Message(
+                    format!("Tuple struct required for {}", msg),
+                    s.fields.span(),
+                ))
+            }
+        };
+        if unnamed.len() != 1 {
+            return Err(MacroError::Message(
+                format!("A single field is required for {}", msg),
+                s.fields.span(),
+            ));
+        }
+        Ok(&unnamed[0])
+    } else {
+        Err(MacroError::Message(
+            format!("Struct required for {}", msg),
+            input.ident.span(),
+        ))
+    }
+}
+
 fn is_c_repr(input: &DeriveInput, msg: &str) -> Result<(), MacroError> {
     let expected = parse_quote! { #[repr(C)] };
 
@@ -46,6 +75,19 @@ fn is_c_repr(input: &DeriveInput, msg: &str) -> Result<(), MacroError> {
     }
 }
 
+fn is_transparent_repr(input: &DeriveInput, msg: &str) -> Result<(), MacroError> {
+    let expected = parse_quote! { #[repr(transparent)] };
+
+    if input.attrs.iter().any(|attr| attr == &expected) {
+        Ok(())
+    } else {
+        Err(MacroError::Message(
+            format!("#[repr(transparent)] required for {}", msg),
+            input.ident.span(),
+        ))
+    }
+}
+
 fn derive_object_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, MacroError> {
     is_c_repr(&input, "#[derive(Object)]")?;
 
@@ -72,6 +114,48 @@ pub fn derive_object(input: TokenStream) -> TokenStream {
     TokenStream::from(expanded)
 }
 
+fn derive_opaque_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, MacroError> {
+    is_transparent_repr(&input, "#[derive(Wrapper)]")?;
+
+    let name = &input.ident;
+    let field = &get_unnamed_field(&input, "#[derive(Wrapper)]")?;
+    let typ = &field.ty;
+
+    // TODO: how to add "::qemu_api"?  For now, this is only used in the
+    // qemu_api crate so it's not a problem.
+    Ok(quote! {
+        unsafe impl crate::cell::Wrapper for #name {
+            type Wrapped = <#typ as crate::cell::Wrapper>::Wrapped;
+        }
+        impl #name {
+            pub unsafe fn from_raw<'a>(ptr: *mut <Self as crate::cell::Wrapper>::Wrapped) -> &'a Self {
+                let ptr = ::std::ptr::NonNull::new(ptr).unwrap().cast::<Self>();
+                unsafe { ptr.as_ref() }
+            }
+
+            pub const fn as_mut_ptr(&self) -> *mut <Self as crate::cell::Wrapper>::Wrapped {
+                self.0.as_mut_ptr()
+            }
+
+            pub const fn as_ptr(&self) -> *const <Self as crate::cell::Wrapper>::Wrapped {
+                self.0.as_ptr()
+            }
+
+            pub const fn as_void_ptr(&self) -> *mut ::core::ffi::c_void {
+                self.0.as_void_ptr()
+            }
+        }
+    })
+}
+
+#[proc_macro_derive(Wrapper)]
+pub fn derive_opaque(input: TokenStream) -> TokenStream {
+    let input = parse_macro_input!(input as DeriveInput);
+    let expanded = derive_opaque_or_error(input).unwrap_or_else(Into::into);
+
+    TokenStream::from(expanded)
+}
+
 #[rustfmt::skip::macros(quote)]
 fn derive_offsets_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, MacroError> {
     is_c_repr(&input, "#[derive(offsets)]")?;
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index bcf1cf780f3..6e52c4bad74 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -42,16 +42,13 @@ _qemu_api_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
-  dependencies: libc_dep,
+  dependencies: [libc_dep, qemu_api_macros],
 )
 
 rust.test('rust-qemu-api-tests', _qemu_api_rs,
           suite: ['unit', 'rust'])
 
-qemu_api = declare_dependency(
-  link_with: _qemu_api_rs,
-  dependencies: qemu_api_macros,
-)
+qemu_api = declare_dependency(link_with: _qemu_api_rs)
 
 # Rust executables do not support objects, so add an intermediate step.
 rust_qemu_api_objs = static_library(
diff --git a/rust/qemu-api/src/cell.rs b/rust/qemu-api/src/cell.rs
index 7c00109d0e9..24efb3a2f2a 100644
--- a/rust/qemu-api/src/cell.rs
+++ b/rust/qemu-api/src/cell.rs
@@ -1023,3 +1023,34 @@ pub unsafe fn new() -> Self {
         }
     }
 }
+
+/// Annotates [`Self`] as a transparent wrapper for another type.
+///
+/// Usually defined via the [`qemu_api_macros::Wrapper`] derive macro.
+///
+/// # Examples
+///
+/// ```
+/// # use std::mem::ManuallyDrop;
+/// # use qemu_api::cell::Wrapper;
+/// #[repr(transparent)]
+/// pub struct Example {
+///     inner: ManuallyDrop<String>,
+/// }
+///
+/// unsafe impl Wrapper for Example {
+///     type Wrapped = String;
+/// }
+/// ```
+///
+/// # Safety
+///
+/// `Self` must be a `#[repr(transparent)]` wrapper for the `Wrapped` type,
+/// whether directly or indirectly.
+pub unsafe trait Wrapper {
+    type Wrapped;
+}
+
+unsafe impl<T> Wrapper for Opaque<T> {
+    type Wrapped = T;
+}
-- 
2.48.1


