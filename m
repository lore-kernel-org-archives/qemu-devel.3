Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE23D1BDD2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80sA-0005L3-Og; Mon, 04 Nov 2024 12:28:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80s9-0005Is-Kp
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80s7-0000KK-0S
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y7G8bk7MyTkiYNKpQlNw/iAAoDfnCCinR0B/3jOuQkg=;
 b=jRAFYmtA8rNP9UxuKeeQ8Ms5FR2tuRAy+jQK2KEyu+x6cOxoz0CRLGb5O8IHTpuQjRyyh+
 d4xD95o73ThL5B6bToJoobCDzi6w6cmSxDR9EZH3glOrY7ilsmH6F96bItHAeJT4BVgsI8
 d1EwXFWn66663dpH3MXeyHlaHXAlHz4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-cA88tIBVM2CIWzwOyEuW_w-1; Mon, 04 Nov 2024 12:28:06 -0500
X-MC-Unique: cA88tIBVM2CIWzwOyEuW_w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315e8e9b1cso25240365e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:28:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741284; x=1731346084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y7G8bk7MyTkiYNKpQlNw/iAAoDfnCCinR0B/3jOuQkg=;
 b=OCuVKL1Tw6ybtAZxSDedcBqV9KEo/F4SmH7tdtDXHpR5Y0a3UxRdK/hC14I/1mfFF0
 kQGyH3TVVchJfBXqJODUjom9WnSCa56FZCwtJjp3et1Ir3lpBMYcCPs1hH7DRDzEIQWM
 X6Z/jKbREuqlq8XnciHOJJuHhjjmW+P/oorQD49KveZ7zi5ltyahkJIRVS2e2F0Nk1lu
 SP6bH00lVPOzLYWAWpIHEUB/vB4vEwX+Py65dV7RSDydRu+Jw0Zni5NjxxxI6BBbo2nB
 Gu+hwQ8g0OWvNEaFfSFaGIrJ+UiyMzcUrb4o3eEPmL1sWqtXLwA81XmwAUe25o5+ZUay
 LQHQ==
X-Gm-Message-State: AOJu0Yw1Xtlql0+mDTi2FczA84/7AfWp/dbzI+IIUJntaIM6YwtgKYY4
 cduFzQldh4FmxzkMFNdbY3d6VMQLrexZzwzp1b/okxLkknV+EEjTPryM2vqOiAeg7xc83gjM2VT
 rCWqCY8ROIxqvZX64hWVTxU0PRkDCn6hyjmHpW+se4m2mna4jKnH5VK7yo/xp9v3k9/WDH/T/zr
 FLJv3x8Dt3oeuaLRpEysCCY7NIqmfHhZAlcbLprF0=
X-Received: by 2002:a05:600c:45cd:b0:42c:b98d:b993 with SMTP id
 5b1f17b1804b1-4327da72175mr123428885e9.2.1730741283890; 
 Mon, 04 Nov 2024 09:28:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNi0wbQoV6HSZqqYkmrrFKL+OWxEhm0kDbnYYs8RUBtwgGn8HtUDlLQmvSbUUsYDQq9Zu+Ww==
X-Received: by 2002:a05:600c:45cd:b0:42c:b98d:b993 with SMTP id
 5b1f17b1804b1-4327da72175mr123428565e9.2.1730741283375; 
 Mon, 04 Nov 2024 09:28:03 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e595sm13749411f8f.77.2024.11.04.09.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:28:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 18/40] rust: add definitions for vmstate
Date: Mon,  4 Nov 2024 18:26:57 +0100
Message-ID: <20241104172721.180255-19-pbonzini@redhat.com>
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Add a new qemu_api module, `vmstate`. Declare a bunch of Rust
macros declared that are equivalent in spirit to the C macros in
include/migration/vmstate.h.

For example the Rust of equivalent of the C macro:

  VMSTATE_UINT32(field_name, struct_name)

is:

  vmstate_uint32!(field_name, StructName)

This breathtaking development will allow us to reach feature parity between
the Rust and C pl011 implementations.

Extracted from a patch by Manos Pitsidianakis
(https://lore.kernel.org/qemu-devel/20241024-rust-round-2-v1-4-051e7a25b978@linaro.org/).

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/meson.build         |   1 +
 rust/qemu-api/src/device_class.rs |  21 --
 rust/qemu-api/src/lib.rs          |   3 +
 rust/qemu-api/src/vmstate.rs      | 360 ++++++++++++++++++++++++++++++
 rust/qemu-api/tests/tests.rs      |  11 +-
 5 files changed, 370 insertions(+), 26 deletions(-)
 create mode 100644 rust/qemu-api/src/vmstate.rs

diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 1b0fd406378..3b849f7c413 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -5,6 +5,7 @@ _qemu_api_rs = static_library(
       'src/lib.rs',
       'src/definitions.rs',
       'src/device_class.rs',
+      'src/vmstate.rs',
       'src/zeroable.rs',
     ],
     {'.' : bindings_rs},
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index aa6088d9d3d..3d40256f60f 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -62,24 +62,3 @@ macro_rules! declare_properties {
         ];
     };
 }
-
-#[macro_export]
-macro_rules! vm_state_description {
-    ($(#[$outer:meta])*
-     $name:ident,
-     $(name: $vname:expr,)*
-     $(unmigratable: $um_val:expr,)*
-    ) => {
-        #[used]
-        $(#[$outer])*
-        pub static $name: $crate::bindings::VMStateDescription = $crate::bindings::VMStateDescription {
-            $(name: {
-                #[used]
-                static VMSTATE_NAME: &::core::ffi::CStr = $vname;
-                $vname.as_ptr()
-            },)*
-            unmigratable: true,
-            ..$crate::zeroable::Zeroable::ZERO
-        };
-    }
-}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index e94a15bb823..10ab3d7e639 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -26,9 +26,12 @@ unsafe impl Send for bindings::Property {}
 unsafe impl Sync for bindings::Property {}
 unsafe impl Sync for bindings::TypeInfo {}
 unsafe impl Sync for bindings::VMStateDescription {}
+unsafe impl Sync for bindings::VMStateField {}
+unsafe impl Sync for bindings::VMStateInfo {}
 
 pub mod definitions;
 pub mod device_class;
+pub mod vmstate;
 pub mod zeroable;
 
 use std::alloc::{GlobalAlloc, Layout};
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
new file mode 100644
index 00000000000..0c1197277f9
--- /dev/null
+++ b/rust/qemu-api/src/vmstate.rs
@@ -0,0 +1,360 @@
+// Copyright 2024, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! Helper macros to declare migration state for device models.
+//!
+//! Some macros are direct equivalents to the C macros declared in
+//! `include/migration/vmstate.h` while
+//! [`vmstate_subsections`](crate::vmstate_subsections) and
+//! [`vmstate_fields`](crate::vmstate_fields) are meant to be used when
+//! declaring a device model state struct.
+
+#[doc(alias = "VMSTATE_UNUSED_BUFFER")]
+#[macro_export]
+macro_rules! vmstate_unused_buffer {
+    ($field_exists_fn:expr, $version_id:expr, $size:expr) => {{
+        $crate::bindings::VMStateField {
+            name: c"unused".as_ptr(),
+            err_hint: ::core::ptr::null(),
+            offset: 0,
+            size: $size,
+            start: 0,
+            num: 0,
+            num_offset: 0,
+            size_offset: 0,
+            info: unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_info_unused_buffer) },
+            flags: VMStateFlags::VMS_BUFFER,
+            vmsd: ::core::ptr::null(),
+            version_id: $version_id,
+            struct_version_id: 0,
+            field_exists: $field_exists_fn,
+        }
+    }};
+}
+
+#[doc(alias = "VMSTATE_UNUSED_V")]
+#[macro_export]
+macro_rules! vmstate_unused_v {
+    ($version_id:expr, $size:expr) => {{
+        $crate::vmstate_unused_buffer!(None, $version_id, $size)
+    }};
+}
+
+#[doc(alias = "VMSTATE_UNUSED")]
+#[macro_export]
+macro_rules! vmstate_unused {
+    ($size:expr) => {{
+        $crate::vmstate_unused_v!(0, $size)
+    }};
+}
+
+#[doc(alias = "VMSTATE_SINGLE_TEST")]
+#[macro_export]
+macro_rules! vmstate_single_test {
+    ($field_name:ident, $struct_name:ty, $field_exists_fn:expr, $version_id:expr, $info:expr, $size:expr) => {{
+        $crate::bindings::VMStateField {
+            name: ::core::concat!(::core::stringify!($field_name), 0)
+                .as_bytes()
+                .as_ptr() as *const ::core::ffi::c_char,
+            err_hint: ::core::ptr::null(),
+            offset: ::core::mem::offset_of!($struct_name, $field_name),
+            size: $size,
+            start: 0,
+            num: 0,
+            num_offset: 0,
+            size_offset: 0,
+            info: unsafe { $info },
+            flags: VMStateFlags::VMS_SINGLE,
+            vmsd: ::core::ptr::null(),
+            version_id: $version_id,
+            struct_version_id: 0,
+            field_exists: $field_exists_fn,
+        }
+    }};
+}
+
+#[doc(alias = "VMSTATE_SINGLE")]
+#[macro_export]
+macro_rules! vmstate_single {
+    ($field_name:ident, $struct_name:ty, $version_id:expr, $info:expr, $size:expr) => {{
+        $crate::vmstate_single_test!($field_name, $struct_name, None, $version_id, $info, $size)
+    }};
+}
+
+#[doc(alias = "VMSTATE_UINT32_V")]
+#[macro_export]
+macro_rules! vmstate_uint32_v {
+    ($field_name:ident, $struct_name:ty, $version_id:expr) => {{
+        $crate::vmstate_single!(
+            $field_name,
+            $struct_name,
+            $version_id,
+            ::core::ptr::addr_of!($crate::bindings::vmstate_info_uint32),
+            ::core::mem::size_of::<u32>()
+        )
+    }};
+}
+
+#[doc(alias = "VMSTATE_UINT32")]
+#[macro_export]
+macro_rules! vmstate_uint32 {
+    ($field_name:ident, $struct_name:ty) => {{
+        $crate::vmstate_uint32_v!($field_name, $struct_name, 0)
+    }};
+}
+
+#[doc(alias = "VMSTATE_INT32_V")]
+#[macro_export]
+macro_rules! vmstate_int32_v {
+    ($field_name:ident, $struct_name:ty, $version_id:expr) => {{
+        $crate::vmstate_single!(
+            $field_name,
+            $struct_name,
+            $version_id,
+            ::core::ptr::addr_of!($crate::bindings::vmstate_info_int32),
+            ::core::mem::size_of::<i32>()
+        )
+    }};
+}
+
+#[doc(alias = "VMSTATE_INT32")]
+#[macro_export]
+macro_rules! vmstate_int32 {
+    ($field_name:ident, $struct_name:ty) => {{
+        $crate::vmstate_int32_v!($field_name, $struct_name, 0)
+    }};
+}
+
+#[doc(alias = "VMSTATE_ARRAY")]
+#[macro_export]
+macro_rules! vmstate_array {
+    ($field_name:ident, $struct_name:ty, $length:expr, $version_id:expr, $info:expr, $size:expr) => {{
+        $crate::bindings::VMStateField {
+            name: ::core::concat!(::core::stringify!($field_name), 0)
+                .as_bytes()
+                .as_ptr() as *const ::core::ffi::c_char,
+            err_hint: ::core::ptr::null(),
+            offset: ::core::mem::offset_of!($struct_name, $field_name),
+            size: $size,
+            start: 0,
+            num: $length as _,
+            num_offset: 0,
+            size_offset: 0,
+            info: unsafe { $info },
+            flags: VMStateFlags::VMS_ARRAY,
+            vmsd: ::core::ptr::null(),
+            version_id: $version_id,
+            struct_version_id: 0,
+            field_exists: None,
+        }
+    }};
+}
+
+#[doc(alias = "VMSTATE_UINT32_ARRAY_V")]
+#[macro_export]
+macro_rules! vmstate_uint32_array_v {
+    ($field_name:ident, $struct_name:ty, $length:expr, $version_id:expr) => {{
+        $crate::vmstate_array!(
+            $field_name,
+            $struct_name,
+            $length,
+            $version_id,
+            ::core::ptr::addr_of!($crate::bindings::vmstate_info_uint32),
+            ::core::mem::size_of::<u32>()
+        )
+    }};
+}
+
+#[doc(alias = "VMSTATE_UINT32_ARRAY")]
+#[macro_export]
+macro_rules! vmstate_uint32_array {
+    ($field_name:ident, $struct_name:ty, $length:expr) => {{
+        $crate::vmstate_uint32_array_v!($field_name, $struct_name, $length, 0)
+    }};
+}
+
+#[doc(alias = "VMSTATE_STRUCT_POINTER_V")]
+#[macro_export]
+macro_rules! vmstate_struct_pointer_v {
+    ($field_name:ident, $struct_name:ty, $version_id:expr, $vmsd:expr, $type:ty) => {{
+        $crate::bindings::VMStateField {
+            name: ::core::concat!(::core::stringify!($field_name), 0)
+                .as_bytes()
+                .as_ptr() as *const ::core::ffi::c_char,
+            err_hint: ::core::ptr::null(),
+            offset: ::core::mem::offset_of!($struct_name, $field_name),
+            size: ::core::mem::size_of::<*const $type>(),
+            start: 0,
+            num: 0,
+            num_offset: 0,
+            size_offset: 0,
+            info: ::core::ptr::null(),
+            flags: VMStateFlags(VMStateFlags::VMS_STRUCT.0 | VMStateFlags::VMS_POINTER.0),
+            vmsd: unsafe { $vmsd },
+            version_id: $version_id,
+            struct_version_id: 0,
+            field_exists: None,
+        }
+    }};
+}
+
+#[doc(alias = "VMSTATE_ARRAY_OF_POINTER")]
+#[macro_export]
+macro_rules! vmstate_array_of_pointer {
+    ($field_name:ident, $struct_name:ty, $num:expr, $version_id:expr, $info:expr, $type:ty) => {{
+        $crate::bindings::VMStateField {
+            name: ::core::concat!(::core::stringify!($field_name), 0)
+                .as_bytes()
+                .as_ptr() as *const ::core::ffi::c_char,
+            version_id: $version_id,
+            num: $num as _,
+            info: unsafe { $info },
+            size: ::core::mem::size_of::<*const $type>(),
+            flags: VMStateFlags(VMStateFlags::VMS_ARRAY.0 | VMStateFlags::VMS_ARRAY_OF_POINTER.0),
+            offset: ::core::mem::offset_of!($struct_name, $field_name),
+            err_hint: ::core::ptr::null(),
+            start: 0,
+            num_offset: 0,
+            size_offset: 0,
+            vmsd: ::core::ptr::null(),
+            struct_version_id: 0,
+            field_exists: None,
+        }
+    }};
+}
+
+#[doc(alias = "VMSTATE_ARRAY_OF_POINTER_TO_STRUCT")]
+#[macro_export]
+macro_rules! vmstate_array_of_pointer_to_struct {
+    ($field_name:ident, $struct_name:ty, $num:expr, $version_id:expr, $vmsd:expr, $type:ty) => {{
+        $crate::bindings::VMStateField {
+            name: ::core::concat!(::core::stringify!($field_name), 0)
+                .as_bytes()
+                .as_ptr() as *const ::core::ffi::c_char,
+            version_id: $version_id,
+            num: $num as _,
+            vmsd: unsafe { $vmsd },
+            size: ::core::mem::size_of::<*const $type>(),
+            flags: VMStateFlags(
+                VMStateFlags::VMS_ARRAY.0
+                    | VMStateFlags::VMS_STRUCT.0
+                    | VMStateFlags::VMS_ARRAY_OF_POINTER.0,
+            ),
+            offset: ::core::mem::offset_of!($struct_name, $field_name),
+            err_hint: ::core::ptr::null(),
+            start: 0,
+            num_offset: 0,
+            size_offset: 0,
+            vmsd: ::core::ptr::null(),
+            struct_version_id: 0,
+            field_exists: None,
+        }
+    }};
+}
+
+#[doc(alias = "VMSTATE_CLOCK_V")]
+#[macro_export]
+macro_rules! vmstate_clock_v {
+    ($field_name:ident, $struct_name:ty, $version_id:expr) => {{
+        $crate::vmstate_struct_pointer_v!(
+            $field_name,
+            $struct_name,
+            $version_id,
+            ::core::ptr::addr_of!($crate::bindings::vmstate_clock),
+            $crate::bindings::Clock
+        )
+    }};
+}
+
+#[doc(alias = "VMSTATE_CLOCK")]
+#[macro_export]
+macro_rules! vmstate_clock {
+    ($field_name:ident, $struct_name:ty) => {{
+        $crate::vmstate_clock_v!($field_name, $struct_name, 0)
+    }};
+}
+
+#[doc(alias = "VMSTATE_ARRAY_CLOCK_V")]
+#[macro_export]
+macro_rules! vmstate_array_clock_v {
+    ($field_name:ident, $struct_name:ty, $num:expr, $version_id:expr) => {{
+        $crate::vmstate_array_of_pointer_to_struct!(
+            $field_name,
+            $struct_name,
+            $num,
+            $version_id,
+            ::core::ptr::addr_of!($crate::bindings::vmstate_clock),
+            $crate::bindings::Clock
+        )
+    }};
+}
+
+#[doc(alias = "VMSTATE_ARRAY_CLOCK")]
+#[macro_export]
+macro_rules! vmstate_array_clock {
+    ($field_name:ident, $struct_name:ty, $num:expr) => {{
+        $crate::vmstate_array_clock_v!($field_name, $struct_name, $name, 0)
+    }};
+}
+
+/// Helper macro to declare a list of
+/// ([`VMStateField`](`crate::bindings::VMStateField`)) into a static and return
+/// a pointer to the array of values it created.
+#[macro_export]
+macro_rules! vmstate_fields {
+    ($($field:expr),*$(,)*) => {{
+        static _FIELDS: &[$crate::bindings::VMStateField] = &[
+            $($field),*,
+            $crate::bindings::VMStateField {
+                name: ::core::ptr::null(),
+                err_hint: ::core::ptr::null(),
+                offset: 0,
+                size: 0,
+                start: 0,
+                num: 0,
+                num_offset: 0,
+                size_offset: 0,
+                info: ::core::ptr::null(),
+                flags: VMStateFlags::VMS_END,
+                vmsd: ::core::ptr::null(),
+                version_id: 0,
+                struct_version_id: 0,
+                field_exists: None,
+            }
+        ];
+        _FIELDS.as_ptr()
+    }}
+}
+
+/// A transparent wrapper type for the `subsections` field of
+/// [`VMStateDescription`](crate::bindings::VMStateDescription).
+///
+/// This is necessary to be able to declare subsection descriptions as statics,
+/// because the only way to implement `Sync` for a foreign type (and `*const`
+/// pointers are foreign types in Rust) is to create a wrapper struct and
+/// `unsafe impl Sync` for it.
+///
+/// This struct is used in the
+/// [`vm_state_subsections`](crate::vmstate_subsections) macro implementation.
+#[repr(transparent)]
+pub struct VMStateSubsectionsWrapper(pub &'static [*const crate::bindings::VMStateDescription]);
+
+unsafe impl Sync for VMStateSubsectionsWrapper {}
+
+/// Helper macro to declare a list of subsections
+/// ([`VMStateDescription`](`crate::bindings::VMStateDescription`)) into a
+/// static and return a pointer to the array of pointers it created.
+#[macro_export]
+macro_rules! vmstate_subsections {
+    ($($subsection:expr),*$(,)*) => {{
+        static _SUBSECTIONS: $crate::vmstate::VMStateSubsectionsWrapper = $crate::vmstate::VMStateSubsectionsWrapper(&[
+            $({
+                static _SUBSECTION: $crate::bindings::VMStateDescription = $subsection;
+                ::core::ptr::addr_of!(_SUBSECTION)
+            }),*,
+            ::core::ptr::null()
+        ]);
+        _SUBSECTIONS.0.as_ptr()
+    }}
+}
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index aa1e0568c69..37c4dd44f81 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -8,17 +8,18 @@
     bindings::*,
     declare_properties, define_property,
     definitions::{Class, ObjectImpl},
-    device_class_init, vm_state_description,
+    device_class_init,
+    zeroable::Zeroable,
 };
 
 #[test]
 fn test_device_decl_macros() {
     // Test that macros can compile.
-    vm_state_description! {
-        VMSTATE,
-        name: c"name",
+    pub static VMSTATE: VMStateDescription = VMStateDescription {
+        name: c"name".as_ptr(),
         unmigratable: true,
-    }
+        ..Zeroable::ZERO
+    };
 
     #[repr(C)]
     #[derive(qemu_api_macros::Object)]
-- 
2.47.0


