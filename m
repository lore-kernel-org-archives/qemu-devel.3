Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69511D149C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Mll-0001JZ-Ee; Fri, 25 Oct 2024 12:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mlf-0000zf-Nq
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:02:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mlc-0004lD-RZ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729872143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bR3ljwoua+BmkjVrnec06qs6BRRUBdBk6Ij0MIixeNc=;
 b=dSSOgSF1zq+vMLLd0wCAIZH2WwGknqdbeFTYVRbOSV2Twr4t4J9yzZhM4we23gqa3jrgDz
 a3asLCyTZn4AAK73uE+Y7eqi1OgSlbbaKWijW/emDANDf5Cw4weB8ANzb2EX3iOsirZ3EJ
 QdaYHhDNQi8nFKEjgq6krpFZQ0grzH4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-3pET7ECnM9yEWLJnkkZeNQ-1; Fri, 25 Oct 2024 12:02:21 -0400
X-MC-Unique: 3pET7ECnM9yEWLJnkkZeNQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a99cb787d2cso165895366b.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729872139; x=1730476939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bR3ljwoua+BmkjVrnec06qs6BRRUBdBk6Ij0MIixeNc=;
 b=hi0gjEltD6pxDbl688v9zLgZUdazGOH9wVCPMXdNsmn6ENKS6FKuw6H/opFYDwGLZA
 hwEBj56G8f7nPNbAqw22AP87TcaN9oKWGeVhqR/ZVT4HgbLfXiItkxtCly4STmeXwLdV
 UkO7GFEKbTuY55UnG5eFFvQWgeYIYfBtR2OycoGx2azD92/JphGle4U3SG8qyKmrfiJH
 Ql0hgDPZdqEVNKMbdV3P68Emz7bze1mXQtE270ydIaiY6VY60hqVCqErIS2G8MSDabo9
 dtSl2g2TAeZmE/OQegu+bYf+wyD/+MmTbEnlOuozBabWR8PZZdev8Et7NX/Euv0qBXe3
 Ixpw==
X-Gm-Message-State: AOJu0YxWM/RXgo+vEeiPFe7ISAjvJn67t7vhAH0o6O2auMPn51/QxTj2
 NNCSm9IbrgcD5VjnHyaOUMrtl5BiDd9UVJsdHod3KoPrMNXn8bwYVEgxDHei0pbHWetH3uxgUTn
 HrGm71YXiKPqzI1VcdoN+p0l3AFzBV5ZlSZ/kaljIX7OFbDbLHEDIGSt1jp+Q17KVa6Fe3Mqc4A
 Mg/4NCCVO4QyDUKG4ZwJHzIMsdYKveJCyDp9+/yLk=
X-Received: by 2002:a17:907:1ca1:b0:a9a:2afc:e4ed with SMTP id
 a640c23a62f3a-a9abf8a4105mr976874666b.32.1729872139075; 
 Fri, 25 Oct 2024 09:02:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYGrx1hoaoeoy6HB/4SSFDSdFrbU7s91fwNzSiAxIOAoTNpQkdUuucJ/eh8K/GWhgUsVgNrw==
X-Received: by 2002:a17:907:1ca1:b0:a9a:2afc:e4ed with SMTP id
 a640c23a62f3a-a9abf8a4105mr976866466b.32.1729872138349; 
 Fri, 25 Oct 2024 09:02:18 -0700 (PDT)
Received: from [192.168.10.47] ([151.81.112.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b1f0679bdsm84671866b.91.2024.10.25.09.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:02:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: [PATCH 01/23] rust: add definitions for vmstate
Date: Fri, 25 Oct 2024 18:01:46 +0200
Message-ID: <20241025160209.194307-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025160209.194307-1-pbonzini@redhat.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

Extracted from a patch by Manos Pitsidianakis.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/meson.build         |   1 +
 rust/qemu-api/src/device_class.rs |  21 --
 rust/qemu-api/src/lib.rs          |   3 +
 rust/qemu-api/src/vmstate.rs      | 358 ++++++++++++++++++++++++++++++
 rust/qemu-api/tests/tests.rs      |  11 +-
 5 files changed, 368 insertions(+), 26 deletions(-)
 create mode 100644 rust/qemu-api/src/vmstate.rs

diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 1b0fd406378..3b849f7c413 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -5,6 +5,7 @@ _qemu_api_rs =3D static_library(
       'src/lib.rs',
       'src/definitions.rs',
       'src/device_class.rs',
+      'src/vmstate.rs',
       'src/zeroable.rs',
     ],
     {'.' : bindings_rs},
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_c=
lass.rs
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
-    ) =3D> {
-        #[used]
-        $(#[$outer])*
-        pub static $name: $crate::bindings::VMStateDescription =3D $crate:=
:bindings::VMStateDescription {
-            $(name: {
-                #[used]
-                static VMSTATE_NAME: &::core::ffi::CStr =3D $vname;
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
=20
 pub mod definitions;
 pub mod device_class;
+pub mod vmstate;
 pub mod zeroable;
=20
 use std::alloc::{GlobalAlloc, Layout};
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
new file mode 100644
index 00000000000..3aa6ed2a781
--- /dev/null
+++ b/rust/qemu-api/src/vmstate.rs
@@ -0,0 +1,358 @@
+// Copyright 2024, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! Helper macros to declare migration state for device models.
+//!
+//! Some macros are direct equivalents to the C macros declared in
+//! `include/migration/vmstate.h` while [`vmstate_subsections`] and
+//! [`vmstate_fields`] are meant to be used when declaring a device model =
state
+//! struct.
+
+#[doc(alias =3D "VMSTATE_UNUSED_BUFFER")]
+#[macro_export]
+macro_rules! vmstate_unused_buffer {
+    ($field_exists_fn:expr, $version_id:expr, $size:expr) =3D> {{
+        $crate::bindings::VMStateField {
+            name: c"unused".as_ptr(),
+            err_hint: ::core::ptr::null(),
+            offset: 0,
+            size: $size,
+            start: 0,
+            num: 0,
+            num_offset: 0,
+            size_offset: 0,
+            info: unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate=
_info_unused_buffer) },
+            flags: VMStateFlags::VMS_BUFFER,
+            vmsd: ::core::ptr::null(),
+            version_id: $version_id,
+            struct_version_id: 0,
+            field_exists: $field_exists_fn,
+        }
+    }};
+}
+
+#[doc(alias =3D "VMSTATE_UNUSED_V")]
+#[macro_export]
+macro_rules! vmstate_unused_v {
+    ($version_id:expr, $size:expr) =3D> {{
+        $crate::vmstate_unused_buffer!(None, $version_id, $size)
+    }};
+}
+
+#[doc(alias =3D "VMSTATE_UNUSED")]
+#[macro_export]
+macro_rules! vmstate_unused {
+    ($size:expr) =3D> {{
+        $crate::vmstate_unused_v!(0, $size)
+    }};
+}
+
+#[doc(alias =3D "VMSTATE_SINGLE_TEST")]
+#[macro_export]
+macro_rules! vmstate_single_test {
+    ($field_name:ident, $struct_name:ty, $field_exists_fn:expr, $version_i=
d:expr, $info:block, $size:expr) =3D> {{
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
+            info: $info,
+            flags: VMStateFlags::VMS_SINGLE,
+            vmsd: ::core::ptr::null(),
+            version_id: $version_id,
+            struct_version_id: 0,
+            field_exists: $field_exists_fn,
+        }
+    }};
+}
+
+#[doc(alias =3D "VMSTATE_SINGLE")]
+#[macro_export]
+macro_rules! vmstate_single {
+    ($field_name:ident, $struct_name:ty, $version_id:expr, $info:block, $s=
ize:expr) =3D> {{
+        $crate::vmstate_single_test!($field_name, $struct_name, None, $ver=
sion_id, $info, $size)
+    }};
+}
+
+#[doc(alias =3D "VMSTATE_UINT32_V")]
+#[macro_export]
+macro_rules! vmstate_uint32_v {
+    ($field_name:ident, $struct_name:ty, $version_id:expr) =3D> {{
+        $crate::vmstate_single!(
+            $field_name,
+            $struct_name,
+            $version_id,
+            { unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_inf=
o_uint32) } },
+            ::core::mem::size_of::<u32>()
+        )
+    }};
+}
+
+#[doc(alias =3D "VMSTATE_UINT32")]
+#[macro_export]
+macro_rules! vmstate_uint32 {
+    ($field_name:ident, $struct_name:ty) =3D> {{
+        $crate::vmstate_uint32_v!($field_name, $struct_name, 0)
+    }};
+}
+
+#[doc(alias =3D "VMSTATE_INT32_V")]
+#[macro_export]
+macro_rules! vmstate_int32_v {
+    ($field_name:ident, $struct_name:ty, $version_id:expr) =3D> {{
+        $crate::vmstate_single!(
+            $field_name,
+            $struct_name,
+            $version_id,
+            { unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_inf=
o_int32) } },
+            ::core::mem::size_of::<i32>()
+        )
+    }};
+}
+
+#[doc(alias =3D "VMSTATE_INT32")]
+#[macro_export]
+macro_rules! vmstate_int32 {
+    ($field_name:ident, $struct_name:ty) =3D> {{
+        $crate::vmstate_int32_v!($field_name, $struct_name, 0)
+    }};
+}
+
+#[doc(alias =3D "VMSTATE_ARRAY")]
+#[macro_export]
+macro_rules! vmstate_array {
+    ($field_name:ident, $struct_name:ty, $length:expr, $version_id:expr, $=
info:block, $size:expr) =3D> {{
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
+            info: $info,
+            flags: VMStateFlags::VMS_ARRAY,
+            vmsd: ::core::ptr::null(),
+            version_id: $version_id,
+            struct_version_id: 0,
+            field_exists: None,
+        }
+    }};
+}
+
+#[doc(alias =3D "VMSTATE_UINT32_ARRAY_V")]
+#[macro_export]
+macro_rules! vmstate_uint32_array_v {
+    ($field_name:ident, $struct_name:ty, $length:expr, $version_id:expr) =
=3D> {{
+        $crate::vmstate_array!(
+            $field_name,
+            $struct_name,
+            $length,
+            $version_id,
+            { unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_inf=
o_uint32) } },
+            ::core::mem::size_of::<u32>()
+        )
+    }};
+}
+
+#[doc(alias =3D "VMSTATE_UINT32_ARRAY")]
+#[macro_export]
+macro_rules! vmstate_uint32_array {
+    ($field_name:ident, $struct_name:ty, $length:expr) =3D> {{
+        $crate::vmstate_uint32_array_v!($field_name, $struct_name, $length=
, 0)
+    }};
+}
+
+#[doc(alias =3D "VMSTATE_STRUCT_POINTER_V")]
+#[macro_export]
+macro_rules! vmstate_struct_pointer_v {
+    ($field_name:ident, $struct_name:ty, $version_id:expr, $vmsd:expr, $ty=
pe:ty) =3D> {{
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
+            flags: VMStateFlags(VMStateFlags::VMS_STRUCT.0 | VMStateFlags:=
:VMS_POINTER.0),
+            vmsd: $vmsd,
+            version_id: $version_id,
+            struct_version_id: 0,
+            field_exists: None,
+        }
+    }};
+}
+
+#[doc(alias =3D "VMSTATE_ARRAY_OF_POINTER")]
+#[macro_export]
+macro_rules! vmstate_array_of_pointer {
+    ($field_name:ident, $struct_name:ty, $num:expr, $version_id:expr, $inf=
o:expr, $type:ty) =3D> {{
+        $crate::bindings::VMStateField {
+            name: ::core::concat!(::core::stringify!($field_name), 0)
+                .as_bytes()
+                .as_ptr() as *const ::core::ffi::c_char,
+            version_id: $version_id,
+            num: $num as _,
+            info: $info,
+            size: ::core::mem::size_of::<*const $type>(),
+            flags: VMStateFlags(VMStateFlags::VMS_ARRAY.0 | VMStateFlags::=
VMS_ARRAY_OF_POINTER.0),
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
+#[doc(alias =3D "VMSTATE_ARRAY_OF_POINTER_TO_STRUCT")]
+#[macro_export]
+macro_rules! vmstate_array_of_pointer_to_struct {
+    ($field_name:ident, $struct_name:ty, $num:expr, $version_id:expr, $vms=
d:expr, $type:ty) =3D> {{
+        $crate::bindings::VMStateField {
+            name: ::core::concat!(::core::stringify!($field_name), 0)
+                .as_bytes()
+                .as_ptr() as *const ::core::ffi::c_char,
+            version_id: $version_id,
+            num: $num as _,
+            vmsd: $vmsd,
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
+#[doc(alias =3D "VMSTATE_CLOCK_V")]
+#[macro_export]
+macro_rules! vmstate_clock_v {
+    ($field_name:ident, $struct_name:ty, $version_id:expr) =3D> {{
+        $crate::vmstate_struct_pointer_v!(
+            $field_name,
+            $struct_name,
+            $version_id,
+            { unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_clo=
ck) } },
+            $crate::bindings::Clock
+        )
+    }};
+}
+
+#[doc(alias =3D "VMSTATE_CLOCK")]
+#[macro_export]
+macro_rules! vmstate_clock {
+    ($field_name:ident, $struct_name:ty) =3D> {{
+        $crate::vmstate_clock_v!($field_name, $struct_name, 0)
+    }};
+}
+
+#[doc(alias =3D "VMSTATE_ARRAY_CLOCK_V")]
+#[macro_export]
+macro_rules! vmstate_array_clock_v {
+    ($field_name:ident, $struct_name:ty, $num:expr, $version_id:expr) =3D>=
 {{
+        $crate::vmstate_array_of_pointer_to_struct!(
+            $field_name,
+            $struct_name,
+            $num,
+            $version_id,
+            { unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_clo=
ck) } },
+            $crate::bindings::Clock
+        )
+    }};
+}
+
+#[doc(alias =3D "VMSTATE_ARRAY_CLOCK")]
+#[macro_export]
+macro_rules! vmstate_array_clock {
+    ($field_name:ident, $struct_name:ty, $num:expr) =3D> {{
+        $crate::vmstate_array_clock_v!($field_name, $struct_name, $name, 0)
+    }};
+}
+
+/// Helper macro to declare a list of
+/// ([`VMStateField`](`crate::bindings::VMStateField`)) into a static and =
return
+/// a pointer to the array of values it created.
+#[macro_export]
+macro_rules! vmstate_fields {
+    ($($field:expr),*$(,)*) =3D> {{
+        static _FIELDS: &[$crate::bindings::VMStateField] =3D &[
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
+/// This is necessary to be able to declare subsection descriptions as sta=
tics,
+/// because the only way to implement `Sync` for a foreign type (and `*con=
st`
+/// pointers are foreign types in Rust) is to create a wrapper struct and
+/// `unsafe impl Sync` for it.
+///
+/// This struct is used in the [`vmstate_subsections`] macro implementatio=
n.
+#[repr(transparent)]
+pub struct VMStateSubsectionsWrapper(pub &'static [*const crate::bindings:=
:VMStateDescription]);
+
+unsafe impl Sync for VMStateSubsectionsWrapper {}
+
+/// Helper macro to declare a list of subsections
+/// ([`VMStateDescription`](`crate::bindings::VMStateDescription`)) into a
+/// static and return a pointer to the array of pointers it created.
+#[macro_export]
+macro_rules! vmstate_subsections {
+    ($($subsection:expr),*$(,)*) =3D> {{
+        static _SUBSECTIONS: $crate::vmstate::VMStateSubsectionsWrapper =
=3D $crate::vmstate::VMStateSubsectionsWrapper(&[
+            $({
+                static _SUBSECTION: $crate::bindings::VMStateDescription =
=3D $subsection;
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
=20
 #[test]
 fn test_device_decl_macros() {
     // Test that macros can compile.
-    vm_state_description! {
-        VMSTATE,
-        name: c"name",
+    pub static VMSTATE: VMStateDescription =3D VMStateDescription {
+        name: c"name".as_ptr(),
         unmigratable: true,
-    }
+        ..Zeroable::ZERO
+    };
=20
     #[repr(C)]
     #[derive(qemu_api_macros::Object)]
--=20
2.47.0


