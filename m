Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6DAC3ABAD
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 07:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uB7mF-000831-0W; Sat, 03 May 2025 03:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7mB-00082c-PO
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7m9-0006c3-5M
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746259146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u7aiabvalma8/ssAKdGg3gUinofOerC+pA/wzQHL28g=;
 b=i5IxafJ48RZPpqiSsQ9uCjl8GYH17BrWh3ta+2lQIoFXBJCHJyhrpvumdSXLRI+s5QlCU4
 XF7O4ZkQqOrkOLldfb9Ur7cqrg8JvXX6Yc3uTyqH0NzQ7hYIy/Lxh062L71Qct9l3MCLhE
 EhyzFOZXSz2Ic6dGliwaKGGs0bR/sYk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-otg2MYVZOk-XBuu9a7xl0A-1; Sat, 03 May 2025 03:59:05 -0400
X-MC-Unique: otg2MYVZOk-XBuu9a7xl0A-1
X-Mimecast-MFC-AGG-ID: otg2MYVZOk-XBuu9a7xl0A_1746259144
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39126c3469fso779849f8f.3
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 00:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746259142; x=1746863942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u7aiabvalma8/ssAKdGg3gUinofOerC+pA/wzQHL28g=;
 b=Q4RCYnGSegvOE/R+Bfwh/zu7p48dyyY+A3rLU2EtVEIGvggBMyVXLah1Ny5U8zKYAy
 8jLNG/93hLu7kzbibWSVTUKceNnuLh5dKOE3jhvqPpY5+rJI40P1fZ9Vd/Gn1Vno1zYB
 lxYmgkbfoaLzbIdomkMysXmgGJPacvlK2AEteMdEhRxNd68QOVYq+pm6jEt6XXkg5UXS
 s2F9SvqWOUZh0iyjUkj2h/oLxYVl5w2oE5XviZM7Xkamx60Q8LAqCRJZ+rlTw11dFiT4
 O5GNwxkBXUUKu3ERCfFfSMPX4AULpi/IEp4NWL8RYe6fqfQUld2n6z/tePxefrIcFGIu
 cflw==
X-Gm-Message-State: AOJu0YysekUHuZIGMkZ69YE1GafeGrJvBlPfNBz6qkdVIkDNs9gHv3lc
 4g+dnqLBNLOw1Z4ynsq3lN0EeGQ9LxloN4rJnD+siGcRWo5jE1cvtH0Y7VGysZdLT4smS2CtW+I
 kGN3mq2Cte+eSeHA1K1RXr30OpeUDKx42urnQHsgnagxGDiT3iF5f1mApVAcoQRljIIbdcO952Y
 TdINjOaWNXE+zbujwg1sU6N8Qjg/kWkLY7JkRc
X-Gm-Gg: ASbGncvOLojQIeOf6AMBjwFH4CjBzMtzhonwMKdvA1sHf4Os9Rw9ZR+EE44c5kMP10d
 ZuHQBtNNG8CZnn4Tx3HfCj6vEAro8h/bhL0cwl8bnffJbZcuo6oQjcIp2oAJQcp1+9Ioa2OG14H
 u5sSZ5+ySqUdpmx85R59Es4zjtui7T9dusLXiUJbL12eDlIGnzPXsvlYU4PCw/3WQ61/YioNMHf
 sUMeIGcW+38dOA1OHM9eZ3b1F/Vo747fWh38ZopxeS461BjDyCQ/JslrQgm4/euU96RieR3ZlBr
 JYKDK2nADgxQBJc=
X-Received: by 2002:a05:6000:240b:b0:3a0:8020:c5c5 with SMTP id
 ffacd0b85a97d-3a099aef8e6mr4176870f8f.58.1746259142470; 
 Sat, 03 May 2025 00:59:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDMeYvmICphnYKVr5xX1J98nvgeO4cjNuU9mY++NKd/jXoM4l4DBIdfwJy0qQAKfNIOFBzUQ==
X-Received: by 2002:a05:6000:240b:b0:3a0:8020:c5c5 with SMTP id
 ffacd0b85a97d-3a099aef8e6mr4176853f8f.58.1746259142008; 
 Sat, 03 May 2025 00:59:02 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae3ccdsm4211887f8f.38.2025.05.03.00.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 00:59:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 01/13] rust/vmstate: Add support for field_exists checks
Date: Sat,  3 May 2025 09:58:46 +0200
Message-ID: <20250503075858.277375-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503075858.277375-1-pbonzini@redhat.com>
References: <20250503075858.277375-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Unfortunately, at present it's not possible to have a const
"with_exist_check" method to append test_fn after vmstate_struct (due
to error on "constant functions cannot evaluate destructors" for `F`).

Before the vmstate builder, the only way to support "test_fn" is to
extend vmstate_struct macro to add the such new optional member (and
fortunately, Rust can still parse the current expansion!).

Abstract the previous callback implementation of vmstate_validate into
a separate macro, and moves it before vmstate_struct for vmstate_struct
to call.

Note that there's no need to add any extra flag for a new test_fn added
in the VMStateField.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250414144943.1112885-2-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 70 +++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 1b2b12eadd6..8c4a5bee3c1 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -200,13 +200,14 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateFlags
 /// and [`impl_vmstate_forward!`](crate::impl_vmstate_forward) help with this.
 #[macro_export]
 macro_rules! vmstate_of {
-    ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])? $(,)?) => {
+    ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])? $(, $test_fn:expr)? $(,)?) => {
         $crate::bindings::VMStateField {
             name: ::core::concat!(::core::stringify!($field_name), "\0")
                 .as_bytes()
                 .as_ptr() as *const ::std::os::raw::c_char,
             offset: $crate::offset_of!($struct_name, $field_name),
             $(num_offset: $crate::offset_of!($struct_name, $num),)?
+            $(field_exists: $crate::vmstate_exist_fn!($struct_name, $test_fn),)?
             // The calls to `call_func_with_field!` are the magic that
             // computes most of the VMStateField from the type of the field.
             info: $crate::info_enum_to_ref!($crate::call_func_with_field!(
@@ -435,6 +436,38 @@ macro_rules! vmstate_unused {
     }};
 }
 
+pub extern "C" fn rust_vms_test_field_exists<T, F: for<'a> FnCall<(&'a T, u8), bool>>(
+    opaque: *mut c_void,
+    version_id: c_int,
+) -> bool {
+    // SAFETY: the opaque was passed as a reference to `T`.
+    let owner: &T = unsafe { &*(opaque.cast::<T>()) };
+    let version: u8 = version_id.try_into().unwrap();
+    F::call((owner, version))
+}
+
+pub type VMSFieldExistCb = unsafe extern "C" fn(
+    opaque: *mut std::os::raw::c_void,
+    version_id: std::os::raw::c_int,
+) -> bool;
+
+#[macro_export]
+macro_rules! vmstate_exist_fn {
+    ($struct_name:ty, $test_fn:expr) => {{
+        const fn test_cb_builder__<T, F: for<'a> $crate::callbacks::FnCall<(&'a T, u8), bool>>(
+            _phantom: ::core::marker::PhantomData<F>,
+        ) -> $crate::vmstate::VMSFieldExistCb {
+            let _: () = F::ASSERT_IS_SOME;
+            $crate::vmstate::rust_vms_test_field_exists::<T, F>
+        }
+
+        const fn phantom__<T>(_: &T) -> ::core::marker::PhantomData<T> {
+            ::core::marker::PhantomData
+        }
+        Some(test_cb_builder__::<$struct_name, _>(phantom__(&$test_fn)))
+    }};
+}
+
 // FIXME: including the `vmsd` field in a `const` is not possible without
 // the const_refs_static feature (stabilized in Rust 1.83.0).  Without it,
 // it is not possible to use VMS_STRUCT in a transparent manner using
@@ -445,7 +478,7 @@ macro_rules! vmstate_unused {
 #[doc(alias = "VMSTATE_STRUCT")]
 #[macro_export]
 macro_rules! vmstate_struct {
-    ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])?, $vmsd:expr, $type:ty $(,)?) => {
+    ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])?, $vmsd:expr, $type:ty $(, $test_fn:expr)? $(,)?) => {
         $crate::bindings::VMStateField {
             name: ::core::concat!(::core::stringify!($field_name), "\0")
                 .as_bytes()
@@ -458,6 +491,7 @@ macro_rules! vmstate_struct {
             size: ::core::mem::size_of::<$type>(),
             flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
             vmsd: $vmsd,
+            $(field_exists: $crate::vmstate_exist_fn!($struct_name, $test_fn),)?
             ..$crate::zeroable::Zeroable::ZERO
          } $(.with_varray_flag_unchecked(
                   $crate::call_func_with_field!(
@@ -514,43 +548,13 @@ macro_rules! vmstate_fields {
     }}
 }
 
-pub extern "C" fn rust_vms_test_field_exists<T, F: for<'a> FnCall<(&'a T, u8), bool>>(
-    opaque: *mut c_void,
-    version_id: c_int,
-) -> bool {
-    let owner: &T = unsafe { &*(opaque.cast::<T>()) };
-    let version: u8 = version_id.try_into().unwrap();
-    // SAFETY: the opaque was passed as a reference to `T`.
-    F::call((owner, version))
-}
-
-pub type VMSFieldExistCb = unsafe extern "C" fn(
-    opaque: *mut std::os::raw::c_void,
-    version_id: std::os::raw::c_int,
-) -> bool;
-
 #[doc(alias = "VMSTATE_VALIDATE")]
 #[macro_export]
 macro_rules! vmstate_validate {
     ($struct_name:ty, $test_name:expr, $test_fn:expr $(,)?) => {
         $crate::bindings::VMStateField {
             name: ::std::ffi::CStr::as_ptr($test_name),
-            field_exists: {
-                const fn test_cb_builder__<
-                    T,
-                    F: for<'a> $crate::callbacks::FnCall<(&'a T, u8), bool>,
-                >(
-                    _phantom: ::core::marker::PhantomData<F>,
-                ) -> $crate::vmstate::VMSFieldExistCb {
-                    let _: () = F::ASSERT_IS_SOME;
-                    $crate::vmstate::rust_vms_test_field_exists::<T, F>
-                }
-
-                const fn phantom__<T>(_: &T) -> ::core::marker::PhantomData<T> {
-                    ::core::marker::PhantomData
-                }
-                Some(test_cb_builder__::<$struct_name, _>(phantom__(&$test_fn)))
-            },
+            field_exists: $crate::vmstate_exist_fn!($struct_name, $test_fn),
             flags: $crate::bindings::VMStateFlags(
                 $crate::bindings::VMStateFlags::VMS_MUST_EXIST.0
                     | $crate::bindings::VMStateFlags::VMS_ARRAY.0,
-- 
2.49.0


