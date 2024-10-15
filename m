Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C21D216A2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 13:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0hRP-00027U-NI; Tue, 15 Oct 2024 09:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hRO-00027C-Ms
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hRJ-0001J8-OL
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728998294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=phALTCJWI1ZZcq7L1OJeDibGPB+sOPLHD87meXDFea4=;
 b=iIFRPaV47KZnMxQlk75FZl8K9efjlRreC3IEoxvH9i+o6XvPclD/U7uOFql0bjN1y+fXYE
 8k6oo7Ur/LNYKIv225H3HL32enbau6+gocKUfoamRPE4h7uQy+FFYmOPsfjPk4GbITWfD1
 sxXbLncAPttZ8ZEz0TOsL99OIovVf0g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-qw5qd6aVPCSpdfZ38tuC3w-1; Tue, 15 Oct 2024 09:18:12 -0400
X-MC-Unique: qw5qd6aVPCSpdfZ38tuC3w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4314a22ed8bso1073885e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 06:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728998291; x=1729603091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=phALTCJWI1ZZcq7L1OJeDibGPB+sOPLHD87meXDFea4=;
 b=KN3joz8Y3gsRaSiIuSpK+uB2+azWeJ1wzbZK7Cmj7JQcQh/zD8lDnnU4roEX7iMqdX
 t6MBZjeBNf+LjBq+PX9U8+PhZwybg5sDILpdryfF6A3u0H4fbtELAx35fDoUw5qduQqV
 iKr7pNz+DY2KdpG5qDgsi/a9B5rok7JykR3JnspSUVfbw8v7hAmRZviX4nBppt9EyD/O
 /fHOe0FGo06KHcLcdyjH7RJ3OkxmqAozl0Dm/G6J8uvDaBiyZZCUGTQTbV6xYU6vIT6F
 AGpOiK5tkbyoHE7lN8RIuCUMxm86Njng26qitwB8ycRBdxY6KwL7zPw1nLRFUW+jBRhl
 eHFw==
X-Gm-Message-State: AOJu0Yygy+4x2klEfGrvuIPNu4GAIqcJh2KyQoj8s4SEbO/dh2mXDfBg
 Mqy5YGaMky8SYOp9e1+FiJDf7jYxdjJHhuyGZu0PQ5nAwRjbDlUZO+gdRfyLwQ5uBYfswlLhSmo
 JqbafZX9SzrSn3OgJ/i/ber1U6S6iyejSCJirnIIDS7q+oSZWlM+8veVopHfvzR14WD5XGA7swF
 /ev6BQNyQQJx/93oJr28Itr8cKAeDh3wODlVdTQzo=
X-Received: by 2002:a05:600c:4f88:b0:431:416e:2612 with SMTP id
 5b1f17b1804b1-431416e2919mr18797945e9.32.1728998290736; 
 Tue, 15 Oct 2024 06:18:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyfp6Hy1zQItJ5AqjaWJI7zZoccMsoLfeRXEFBRUhJ6k2+v/4EY2zeywqyyvbjGkXgEZxuAQ==
X-Received: by 2002:a05:600c:4f88:b0:431:416e:2612 with SMTP id
 5b1f17b1804b1-431416e2919mr18797535e9.32.1728998289969; 
 Tue, 15 Oct 2024 06:18:09 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa87c44sm1557662f8f.33.2024.10.15.06.18.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:18:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/16] rust: introduce alternative implementation of offset_of!
Date: Tue, 15 Oct 2024 15:17:28 +0200
Message-ID: <20241015131735.518771-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015131735.518771-1-pbonzini@redhat.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

offset_of! was stabilized in Rust 1.77.0.  Use an alternative implemenation
that was found on the Rust forums, and whose author agreed to license as
MIT for use in QEMU.

The alternative allows only one level of field access, but apart
from this can be used just by replacing core::mem::offset_of! with
qemu_api::offset_of!.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs  |  91 ++++++++++++-------------
 rust/qemu-api/meson.build         |  12 ++--
 rust/qemu-api/src/device_class.rs |   8 +--
 rust/qemu-api/src/lib.rs          |   4 ++
 rust/qemu-api/src/offset_of.rs    | 106 ++++++++++++++++++++++++++++++
 rust/qemu-api/src/tests.rs        |  11 ++--
 6 files changed, 176 insertions(+), 56 deletions(-)
 create mode 100644 rust/qemu-api/src/offset_of.rs

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/devi=
ce.rs
index 55d933ee5e9..f331a13b5f1 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -13,6 +13,7 @@
     bindings::{self, *},
     c_str,
     definitions::ObjectImpl,
+    with_offsets,
 };
=20
 use crate::{
@@ -28,50 +29,52 @@
 /// QEMU sourced constant.
 pub const PL011_FIFO_DEPTH: usize =3D 16_usize;
=20
-#[repr(C)]
-#[derive(Debug, qemu_api_macros::Object)]
-/// PL011 Device Model in QEMU
-pub struct PL011State {
-    pub parent_obj: SysBusDevice,
-    pub iomem: MemoryRegion,
-    #[doc(alias =3D "fr")]
-    pub flags: registers::Flags,
-    #[doc(alias =3D "lcr")]
-    pub line_control: registers::LineControl,
-    #[doc(alias =3D "rsr")]
-    pub receive_status_error_clear: registers::ReceiveStatusErrorClear,
-    #[doc(alias =3D "cr")]
-    pub control: registers::Control,
-    pub dmacr: u32,
-    pub int_enabled: u32,
-    pub int_level: u32,
-    pub read_fifo: [u32; PL011_FIFO_DEPTH],
-    pub ilpr: u32,
-    pub ibrd: u32,
-    pub fbrd: u32,
-    pub ifl: u32,
-    pub read_pos: usize,
-    pub read_count: usize,
-    pub read_trigger: usize,
-    #[doc(alias =3D "chr")]
-    pub char_backend: CharBackend,
-    /// QEMU interrupts
-    ///
-    /// ```text
-    ///  * sysbus MMIO region 0: device registers
-    ///  * sysbus IRQ 0: `UARTINTR` (combined interrupt line)
-    ///  * sysbus IRQ 1: `UARTRXINTR` (receive FIFO interrupt line)
-    ///  * sysbus IRQ 2: `UARTTXINTR` (transmit FIFO interrupt line)
-    ///  * sysbus IRQ 3: `UARTRTINTR` (receive timeout interrupt line)
-    ///  * sysbus IRQ 4: `UARTMSINTR` (momem status interrupt line)
-    ///  * sysbus IRQ 5: `UARTEINTR` (error interrupt line)
-    /// ```
-    #[doc(alias =3D "irq")]
-    pub interrupts: [qemu_irq; 6usize],
-    #[doc(alias =3D "clk")]
-    pub clock: NonNull<Clock>,
-    #[doc(alias =3D "migrate_clk")]
-    pub migrate_clock: bool,
+with_offsets! {
+    #[repr(C)]
+    #[derive(Debug, qemu_api_macros::Object)]
+    /// PL011 Device Model in QEMU
+    pub struct PL011State {
+        pub parent_obj: SysBusDevice,
+        pub iomem: MemoryRegion,
+        #[doc(alias =3D "fr")]
+        pub flags: registers::Flags,
+        #[doc(alias =3D "lcr")]
+        pub line_control: registers::LineControl,
+        #[doc(alias =3D "rsr")]
+        pub receive_status_error_clear: registers::ReceiveStatusErrorClear,
+        #[doc(alias =3D "cr")]
+        pub control: registers::Control,
+        pub dmacr: u32,
+        pub int_enabled: u32,
+        pub int_level: u32,
+        pub read_fifo: [u32; PL011_FIFO_DEPTH],
+        pub ilpr: u32,
+        pub ibrd: u32,
+        pub fbrd: u32,
+        pub ifl: u32,
+        pub read_pos: usize,
+        pub read_count: usize,
+        pub read_trigger: usize,
+        #[doc(alias =3D "chr")]
+        pub char_backend: CharBackend,
+        /// QEMU interrupts
+        ///
+        /// ```text
+        ///  * sysbus MMIO region 0: device registers
+        ///  * sysbus IRQ 0: `UARTINTR` (combined interrupt line)
+        ///  * sysbus IRQ 1: `UARTRXINTR` (receive FIFO interrupt line)
+        ///  * sysbus IRQ 2: `UARTTXINTR` (transmit FIFO interrupt line)
+        ///  * sysbus IRQ 3: `UARTRTINTR` (receive timeout interrupt line)
+        ///  * sysbus IRQ 4: `UARTMSINTR` (momem status interrupt line)
+        ///  * sysbus IRQ 5: `UARTEINTR` (error interrupt line)
+        /// ```
+        #[doc(alias =3D "irq")]
+        pub interrupts: [qemu_irq; 6usize],
+        #[doc(alias =3D "clk")]
+        pub clock: NonNull<Clock>,
+        #[doc(alias =3D "migrate_clk")]
+        pub migrate_clock: bool,
+    }
 }
=20
 impl ObjectImpl for PL011State {
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index b55931c6490..57f813fc8f9 100644
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
       'src/tests.rs',
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
   dependencies: [
     qemu_api_macros,
   ],
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_c=
lass.rs
index 871063d4a92..d4fa544df39 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -26,7 +26,7 @@ macro_rules! device_class_init {
=20
 #[macro_export]
 macro_rules! define_property {
-    ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr, default =
=3D $defval:expr$(,)*) =3D> {
+    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:expr, default =
=3D $defval:expr$(,)*) =3D> {
         $crate::bindings::Property {
             name: {
                 #[used]
@@ -34,7 +34,7 @@ macro_rules! define_property {
                 _TEMP.as_ptr()
             },
             info: $prop,
-            offset: ::core::mem::offset_of!($state, $field)
+            offset: $crate::offset_of!($state, $field)
                 .try_into()
                 .expect("Could not fit offset value to type"),
             bitnr: 0,
@@ -47,7 +47,7 @@ macro_rules! define_property {
             link_type: ::core::ptr::null(),
         }
     };
-    ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr$(,)*) =3D>=
 {
+    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:expr$(,)*) =3D=
> {
         $crate::bindings::Property {
             name: {
                 #[used]
@@ -55,7 +55,7 @@ macro_rules! define_property {
                 _TEMP.as_ptr()
             },
             info: $prop,
-            offset: ::core::mem::offset_of!($state, $field)
+            offset: $crate::offset_of!($state, $field)
                 .try_into()
                 .expect("Could not fit offset value to type"),
             bitnr: 0,
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 9b2483fbfa3..082f1addb10 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -30,6 +30,7 @@ unsafe impl Sync for bindings::VMStateDescription {}
 pub mod c_str;
 pub mod definitions;
 pub mod device_class;
+pub mod offset_of;
=20
 #[cfg(test)]
 mod tests;
@@ -167,3 +168,6 @@ unsafe fn dealloc(&self, ptr: *mut u8, layout: Layout) {
         }
     }
 }
+
+#[cfg(has_offset_of)]
+pub use std::mem::offset_of;
diff --git a/rust/qemu-api/src/offset_of.rs b/rust/qemu-api/src/offset_of.rs
new file mode 100644
index 00000000000..4e1de373674
--- /dev/null
+++ b/rust/qemu-api/src/offset_of.rs
@@ -0,0 +1,106 @@
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
+        <$Container>::offset_to.$field
+    };
+}
+
+/// A wrapper for struct declarations, that allows using `offset_of!` in
+/// versions of Rust prior to 1.77
+#[macro_export]
+macro_rules! with_offsets {
+    // source: https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&e=
dition=3D2018&gist=3D10a22a9b8393abd7b541d8fc844bc0df
+    // used under MIT license with permission of Yandros aka Daniel Henry-=
Mantilla
+    (
+        #[repr(C)]
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
+        #[repr(C)]
+        $(#[$struct_meta])*
+        $struct_vis
+        struct $StructName {
+            $(
+                $(#[$field_meta])*
+                $field_vis
+                $field_name : $field_ty ,
+            )*
+        }
+
+        #[cfg(not(has_offset_of))]
+        #[allow(nonstandard_style)]
+        const _: () =3D {
+            pub
+            struct StructOffsets {
+                $(
+                    $field_vis
+                    $field_name: usize,
+                )*
+            }
+            struct Helper;
+            impl $StructName {
+                pub
+                const offset_to: StructOffsets =3D StructOffsets {
+                    $(
+                        $field_name: Helper::$field_name,
+                    )*
+                };
+            }
+            const END_OF_PREV_FIELD: usize =3D 0;
+            $crate::with_offsets! {
+                @names [ $($field_name)* ]
+                @tys [ $($field_ty ,)*]
+            }
+        };
+    );
+
+    (
+        @names []
+        @tys []
+    ) =3D> ();
+
+    (
+        @names [$field_name:ident $($other_names:tt)*]
+        @tys [$field_ty:ty , $($other_tys:tt)*]
+    ) =3D> (
+        impl Helper {
+            const $field_name: usize =3D {
+                let align =3D
+                    std::mem::align_of::<$field_ty>()
+                ;
+                let trail =3D
+                    END_OF_PREV_FIELD % align
+                ;
+                0   + END_OF_PREV_FIELD
+                    + (align - trail)
+                        * [1, 0][(trail =3D=3D 0) as usize]
+            };
+        }
+        const _: () =3D {
+            const END_OF_PREV_FIELD: usize =3D
+                Helper::$field_name +
+                std::mem::size_of::<$field_ty>()
+            ;
+            $crate::with_offsets! {
+                @names [$($other_names)*]
+                @tys [$($other_tys)*]
+            }
+        };
+    );
+}
diff --git a/rust/qemu-api/src/tests.rs b/rust/qemu-api/src/tests.rs
index d34b8d24187..b582f27baa1 100644
--- a/rust/qemu-api/src/tests.rs
+++ b/rust/qemu-api/src/tests.rs
@@ -4,6 +4,7 @@
=20
 use crate::{
     bindings::*, c_str, declare_properties, define_property, device_class_=
init, vm_state_description,
+    with_offsets,
 };
=20
 #[test]
@@ -15,10 +16,12 @@ fn test_device_decl_macros() {
         unmigratable: true,
     }
=20
-    #[repr(C)]
-    pub struct DummyState {
-        pub char_backend: CharBackend,
-        pub migrate_clock: bool,
+    with_offsets! {
+        #[repr(C)]
+        pub struct DummyState {
+            pub char_backend: CharBackend,
+            pub migrate_clock: bool,
+        }
     }
=20
     declare_properties! {
--=20
2.46.2


