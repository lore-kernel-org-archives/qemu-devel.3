Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4232C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGHW-0001Ak-S1; Fri, 24 Jan 2025 04:47:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGD-0007ZH-Og
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGG7-0003x6-9e
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ER3J/G2n/x1etciyFe+iGi4cTA2mYslp7tdM9gzwjf0=;
 b=NHZ9B5RxEg6XflIjr9cTODioqC89eBwJwKORi8mG8tnodQSRYw6uxGdx0H9RQXFaOGkHv1
 /XyJwc3cAavCgoSE5f1Knq+schXvsKCSRBOJcVUrdOikXA4Ue431ojY307Y/rPKHqlC7cN
 SJbq0ZBMoFQ/AWySpTMELVYQ+W6qsZk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-eiuTbOL-MkibkINRJM4ilQ-1; Fri, 24 Jan 2025 04:45:45 -0500
X-MC-Unique: eiuTbOL-MkibkINRJM4ilQ-1
X-Mimecast-MFC-AGG-ID: eiuTbOL-MkibkINRJM4ilQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-436219070b4so8837505e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711943; x=1738316743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ER3J/G2n/x1etciyFe+iGi4cTA2mYslp7tdM9gzwjf0=;
 b=ucxTDxx4xj0hA3thZFYgB0kEup37c2A+NUCgkRSjWgQTER2M5MSa4ZQqMbulHP9qkC
 9CICx/6RzEdaRTWhGRxVWpuzqWsaNWTQJwfhrXElEbgtlPhWSaHrIgeY6+8ypH4cAP4S
 yX6fsCSvAopK424hBrW8j/QmfQbsnV/n6WDTBdPNGtrTCQp4PrEKwy58yorRNNgGaHQ+
 TJMAvE0oKtkMCz9H9SWUh02pueS6Ujc3kz78Zt0RCHjvAgUNeja6I9nkeTKhyBltucKz
 UzTCfEYPMSvDMw8WAik/uKac/LhmfbwqbHB6PWlhE9pWhKjFzHgZuAxDeC70STuGTxyD
 gr0Q==
X-Gm-Message-State: AOJu0YxCG9N8QJT+km9fi1YG1JTAOy8Fb7a2tq6sAW+JegE3h8REOJvB
 Pbvd2+Dy8FVQfpNTP6ixgZgp6yBxYiP2tXvygtCkc4ZleaER6qiNtGwZ4kfC3XYATjZ3VC+z/mc
 dK7dU6JtUkQHwvnQ3j+Fm/qFQvs41eacVWIppvw3y0bNEj7BE/3YhovJd4YnCnXFVs8M3z7gTWe
 sdWRg4p6cwnLthyM7yvAHLXz0AzzHklcS3qc9s4oc=
X-Gm-Gg: ASbGncsAli2JsRry+9AHdMPr8Yqjlb3nAOfJiAjphGYPqju3KyyTuXbNcZSJrfJTMFH
 TlJPMewIhfZfI38eYHUs3E0MGvH79CWidXq3rSYEGRUsT+5mgblg2YE/NG95sioSWfkfJ1XrFe4
 UKY9DGC4OBbwejdDjFNlTNKHi69mHQshujURQjtSDGKacPo2IWl4PwZjE9JAhJVsxYJul/NMcQY
 5IwC147ds86MJraAzR3Dn6By+lMFFqgKJiB6/T4B3NufNJ8xICY9exuaALzHNMCHDcIShvm3w==
X-Received: by 2002:a05:600c:1c93:b0:431:5863:4240 with SMTP id
 5b1f17b1804b1-43891429c77mr245338575e9.24.1737711943379; 
 Fri, 24 Jan 2025 01:45:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8KhK1T73h7P9Wlshy05YecWHsNCQOIsEAZN6pbI8qVVau+yAgRle1VJCR9b7nn7euu8VQ3g==
X-Received: by 2002:a05:600c:1c93:b0:431:5863:4240 with SMTP id
 5b1f17b1804b1-43891429c77mr245338195e9.24.1737711942791; 
 Fri, 24 Jan 2025 01:45:42 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4857cesm20392295e9.13.2025.01.24.01.45.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:41 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/48] rust: vmstate: implement VMState for scalar types
Date: Fri, 24 Jan 2025 10:44:23 +0100
Message-ID: <20250124094442.13207-30-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

Scalar types are those that have their own VMStateInfo.  This poses
a problem in that references to VMStateInfo can only be included in
associated consts starting with Rust 1.83.0, when the const_refs_static
was stabilized.  Removing the requirement is done by placing a limited
list of VMStateInfos in an enum, and going from enum to &VMStateInfo
only when building the VMStateField.

The same thing cannot be done with VMS_STRUCT because the set of
VMStateDescriptions extends to structs defined by the devices.
Therefore, structs and cells cannot yet use vmstate_of!.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 128 ++++++++++++++++++++++++++++++++++-
 1 file changed, 126 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 7652930affc..a262c315da1 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -22,7 +22,10 @@
 use core::{marker::PhantomData, mem, ptr::NonNull};
 
 pub use crate::bindings::{VMStateDescription, VMStateField};
-use crate::bindings::VMStateFlags;
+use crate::{
+    bindings::{self, VMStateFlags},
+    zeroable::Zeroable,
+};
 
 /// This macro is used to call a function with a generic argument bound
 /// to the type of a field.  The function must take a
@@ -61,6 +64,70 @@ const fn phantom__<T>(_: &T) -> ::core::marker::PhantomData<T> { ::core::marker:
     };
 }
 
+/// Workaround for lack of `const_refs_static`: references to global variables
+/// can be included in a `static`, but not in a `const`; unfortunately, this
+/// is exactly what would go in the `VMStateField`'s `info` member.
+///
+/// This enum contains the contents of the `VMStateField`'s `info` member,
+/// but as an `enum` instead of a pointer.
+#[allow(non_camel_case_types)]
+pub enum VMStateFieldType {
+    null,
+    vmstate_info_bool,
+    vmstate_info_int8,
+    vmstate_info_int16,
+    vmstate_info_int32,
+    vmstate_info_int64,
+    vmstate_info_uint8,
+    vmstate_info_uint16,
+    vmstate_info_uint32,
+    vmstate_info_uint64,
+    vmstate_info_timer,
+}
+
+/// Workaround for lack of `const_refs_static`.  Converts a `VMStateFieldType`
+/// to a `*const VMStateInfo`, for inclusion in a `VMStateField`.
+#[macro_export]
+macro_rules! info_enum_to_ref {
+    ($e:expr) => {
+        unsafe {
+            match $e {
+                $crate::vmstate::VMStateFieldType::null => ::core::ptr::null(),
+                $crate::vmstate::VMStateFieldType::vmstate_info_bool => {
+                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_bool)
+                }
+                $crate::vmstate::VMStateFieldType::vmstate_info_int8 => {
+                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_int8)
+                }
+                $crate::vmstate::VMStateFieldType::vmstate_info_int16 => {
+                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_int16)
+                }
+                $crate::vmstate::VMStateFieldType::vmstate_info_int32 => {
+                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_int32)
+                }
+                $crate::vmstate::VMStateFieldType::vmstate_info_int64 => {
+                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_int64)
+                }
+                $crate::vmstate::VMStateFieldType::vmstate_info_uint8 => {
+                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_uint8)
+                }
+                $crate::vmstate::VMStateFieldType::vmstate_info_uint16 => {
+                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_uint16)
+                }
+                $crate::vmstate::VMStateFieldType::vmstate_info_uint32 => {
+                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_uint32)
+                }
+                $crate::vmstate::VMStateFieldType::vmstate_info_uint64 => {
+                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_uint64)
+                }
+                $crate::vmstate::VMStateFieldType::vmstate_info_timer => {
+                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_timer)
+                }
+            }
+        }
+    };
+}
+
 /// A trait for types that can be included in a device's migration stream.  It
 /// provides the base contents of a `VMStateField` (minus the name and offset).
 ///
@@ -69,6 +136,12 @@ const fn phantom__<T>(_: &T) -> ::core::marker::PhantomData<T> { ::core::marker:
 /// The contents of this trait go straight into structs that are parsed by C
 /// code and used to introspect into other structs.  Be careful.
 pub unsafe trait VMState {
+    /// The `info` member of a `VMStateField` is a pointer and as such cannot
+    /// yet be included in the [`BASE`](VMState::BASE) associated constant;
+    /// this is only allowed by Rust 1.83.0 and newer.  For now, include the
+    /// member as an enum which is stored in a separate constant.
+    const SCALAR_TYPE: VMStateFieldType = VMStateFieldType::null;
+
     /// The base contents of a `VMStateField` (minus the name and offset) for
     /// the type that is implementing the trait.
     const BASE: VMStateField;
@@ -83,6 +156,12 @@ pub unsafe trait VMState {
     };
 }
 
+/// Internal utility function to retrieve a type's `VMStateFieldType`;
+/// used by [`vmstate_of!`](crate::vmstate_of).
+pub const fn vmstate_scalar_type<T: VMState>(_: PhantomData<T>) -> VMStateFieldType {
+    T::SCALAR_TYPE
+}
+
 /// Internal utility function to retrieve a type's `VMStateField`;
 /// used by [`vmstate_of!`](crate::vmstate_of).
 pub const fn vmstate_base<T: VMState>(_: PhantomData<T>) -> VMStateField {
@@ -99,6 +178,15 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateFlags
 /// Return the `VMStateField` for a field of a struct.  The field must be
 /// visible in the current scope.
 ///
+/// Only a limited set of types is supported out of the box:
+/// * scalar types (integer and `bool`)
+/// * the C struct `QEMUTimer`
+/// * a transparent wrapper for any of the above (`Cell`, `UnsafeCell`,
+///   [`BqlCell`](crate::cell::BqlCell), [`BqlRefCell`](crate::cell::BqlRefCell)
+/// * a raw pointer to any of the above
+/// * a `NonNull` pointer or a `Box` for any of the above
+/// * an array of any of the above
+///
 /// In order to support other types, the trait `VMState` must be implemented
 /// for them.
 #[macro_export]
@@ -109,8 +197,14 @@ macro_rules! vmstate_of {
                 .as_bytes()
                 .as_ptr() as *const ::std::os::raw::c_char,
             offset: $crate::offset_of!($struct_name, $field_name),
-            // Compute most of the VMStateField from the type of the field.
             $(.num_offset: $crate::offset_of!($struct_name, $num),)?
+            // The calls to `call_func_with_field!` are the magic that
+            // computes most of the VMStateField from the type of the field.
+            info: $crate::info_enum_to_ref!($crate::call_func_with_field!(
+                $crate::vmstate::vmstate_scalar_type,
+                $struct_name,
+                $field_name
+            )),
             ..$crate::call_func_with_field!(
                 $crate::vmstate::vmstate_base,
                 $struct_name,
@@ -187,6 +281,7 @@ pub const fn with_varray_multiply(mut self, num: u32) -> VMStateField {
 macro_rules! impl_vmstate_transparent {
     ($type:ty where $base:tt: VMState $($where:tt)*) => {
         unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
+            const SCALAR_TYPE: VMStateFieldType = <$base as VMState>::SCALAR_TYPE;
             const BASE: VMStateField = VMStateField {
                 size: mem::size_of::<$type>(),
                 ..<$base as VMState>::BASE
@@ -201,6 +296,33 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
 impl_vmstate_transparent!(crate::cell::BqlCell<T> where T: VMState);
 impl_vmstate_transparent!(crate::cell::BqlRefCell<T> where T: VMState);
 
+// Scalar types using predefined VMStateInfos
+
+macro_rules! impl_vmstate_scalar {
+    ($info:ident, $type:ty$(, $varray_flag:ident)?) => {
+        unsafe impl VMState for $type {
+            const SCALAR_TYPE: VMStateFieldType = VMStateFieldType::$info;
+            const BASE: VMStateField = VMStateField {
+                size: mem::size_of::<$type>(),
+                flags: VMStateFlags::VMS_SINGLE,
+                ..Zeroable::ZERO
+            };
+            $(const VARRAY_FLAG: VMStateFlags = VMStateFlags::$varray_flag;)?
+        }
+    };
+}
+
+impl_vmstate_scalar!(vmstate_info_bool, bool);
+impl_vmstate_scalar!(vmstate_info_int8, i8);
+impl_vmstate_scalar!(vmstate_info_int16, i16);
+impl_vmstate_scalar!(vmstate_info_int32, i32);
+impl_vmstate_scalar!(vmstate_info_int64, i64);
+impl_vmstate_scalar!(vmstate_info_uint8, u8, VMS_VARRAY_UINT8);
+impl_vmstate_scalar!(vmstate_info_uint16, u16, VMS_VARRAY_UINT16);
+impl_vmstate_scalar!(vmstate_info_uint32, u32, VMS_VARRAY_UINT32);
+impl_vmstate_scalar!(vmstate_info_uint64, u64);
+impl_vmstate_scalar!(vmstate_info_timer, bindings::QEMUTimer);
+
 // Pointer types using the underlying type's VMState plus VMS_POINTER
 // Note that references are not supported, though references to cells
 // could be allowed.
@@ -208,6 +330,7 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
 macro_rules! impl_vmstate_pointer {
     ($type:ty where $base:tt: VMState $($where:tt)*) => {
         unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
+            const SCALAR_TYPE: VMStateFieldType = <T as VMState>::SCALAR_TYPE;
             const BASE: VMStateField = <$base as VMState>::BASE.with_pointer_flag();
         }
     };
@@ -225,6 +348,7 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
 // VMS_ARRAY/VMS_ARRAY_OF_POINTER
 
 unsafe impl<T: VMState, const N: usize> VMState for [T; N] {
+    const SCALAR_TYPE: VMStateFieldType = <T as VMState>::SCALAR_TYPE;
     const BASE: VMStateField = <T as VMState>::BASE.with_array_flag(N);
 }
 
-- 
2.48.1


