Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B593C3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIVP-0004GD-9t; Mon, 01 Jul 2024 10:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIVN-00047L-Kv
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIVH-0005Uz-9G
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719845978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L1+NBzK4iA++gxlMtSNv140MQlgSKu48htjyD75ufEs=;
 b=Se2ibSAeyu2xxxxKMR1oikZg66mpj+dMsc11RAqDwQZTEZFfIihyr7uiDOkG4O1W3ho5mh
 HR1u5hYjTOjVKg4ZZcadGJdO6Uj8PsP4zHe1gzyQu81sPDNcVzRbsEZO6UWKFDhioae1s8
 RdY8YZNKfW3sHvI05I48+ghYj76kfWA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-p9dS2SUYOtWrIOMcy1owPA-1; Mon, 01 Jul 2024 10:59:37 -0400
X-MC-Unique: p9dS2SUYOtWrIOMcy1owPA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4258675a531so4696995e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 07:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719845975; x=1720450775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L1+NBzK4iA++gxlMtSNv140MQlgSKu48htjyD75ufEs=;
 b=Vhuhg3vQ94rrPLrbkRn0xLUTiMRaC7Q5KCozUgTPyWV1aRTqkfw0yPNr0P6JakQmyu
 of6cc2zNKNVErpImfdFr9rOi36PkPaN86VccysUJ22cOHLEbcbpuYfzEitAPQYrLWPqU
 LB/aJDXIocvZTTePG1ICN8n69ffO8igMCcE/g5v5FEajcCd9sJqbbESxUVlLtYVIpzxy
 TkLb+PYYUR+pxkMjScdYQBq0kHVjBexguCcUs1me++T4Xk2//O1Op84fllDKEWmVUQQL
 5DeEPmy5TusYPH63lWPeKOTTi7gNkFwy9DzRK/63SWIYgElSQq3eKhSsMGFkDo0r5OCO
 I8cA==
X-Gm-Message-State: AOJu0YyfG0JwIyHILbXZAjEXGvdkr/CrvEHPJe7+9LzM3By7VW0IsBU8
 IvfBuC24cuxb9+GK/7Me3cU7sYfOsegVZTG82o8orsWK3j5LFJ/+10AAw2fGqaFMfE7Bozo3k1o
 /hUIc/DTkxvMjC17U0zy8YT0IF1+WhJK83mU2PkrlDk+FWCXGo3+dhA74vUxGNXGG2SVPHP12Dw
 cRZrq5i93NaCCS4WpJbd+zKIfHeGGZwFdFyM+2
X-Received: by 2002:a05:6000:136f:b0:367:1da6:e419 with SMTP id
 ffacd0b85a97d-3677571c211mr5077508f8f.46.1719845975210; 
 Mon, 01 Jul 2024 07:59:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOqL7Nm7rykTZQM85jvkNjOHlSRggswDFFctiJZAELgEEO0Z37teVQhYg2YQBb0MCbP0LWLA==
X-Received: by 2002:a05:6000:136f:b0:367:1da6:e419 with SMTP id
 ffacd0b85a97d-3677571c211mr5077485f8f.46.1719845974774; 
 Mon, 01 Jul 2024 07:59:34 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d8ed0sm10291911f8f.28.2024.07.01.07.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 07:59:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 13/14] rust: introduce alternative to offset_of!
Date: Mon,  1 Jul 2024 16:58:45 +0200
Message-ID: <20240701145853.1394967-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701145853.1394967-1-pbonzini@redhat.com>
References: <20240701145853.1394967-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Allow working with Rust versions prior to 1.77.  The code was
taken from Rust's Discourse platform and is used with permission of
the author.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu/Cargo.toml                 |  3 +
 qemu/build.rs                   |  5 ++
 qemu/src/hw/core/device_impl.rs |  4 +-
 qemu/src/lib.rs                 |  4 ++
 qemu/src/qom/object_impl.rs     | 13 +++--
 qemu/src/util/mod.rs            |  1 +
 qemu/src/util/offset_of.rs      | 99 +++++++++++++++++++++++++++++++++
 qemu/tests/main.rs              | 11 +++-
 9 files changed, 137 insertions(+), 10 deletions(-)
 create mode 100644 qemu/build.rs
 create mode 100644 qemu/src/util/offset_of.rs

diff --git a/qemu/Cargo.toml b/qemu/Cargo.toml
index a07a449..93808a5 100644
--- a/qemu/Cargo.toml
+++ b/qemu/Cargo.toml
@@ -12,3 +12,6 @@ cstr = { version = "=0.2.10" }
 
 [dev-dependencies]
 matches = ">=0"
+
+[build-dependencies]
+version_check = { version = "~0.9" }
diff --git a/qemu/build.rs b/qemu/build.rs
new file mode 100644
index 0000000..34f7b49
--- /dev/null
+++ b/qemu/build.rs
@@ -0,0 +1,5 @@
+fn main() {
+    if let Some(true) = version_check::is_min_version("1.77.0") {
+        println!("cargo:rustc-cfg=has_offset_of");
+    }
+}
diff --git a/qemu/src/hw/core/device_impl.rs b/qemu/src/hw/core/device_impl.rs
index 80b0e5e..b1d2f04 100644
--- a/qemu/src/hw/core/device_impl.rs
+++ b/qemu/src/hw/core/device_impl.rs
@@ -111,7 +111,7 @@ macro_rules! qdev_prop {
             $kind,
             $name,
             (<$crate::conf_type!($type) as ConstDefault>::DEFAULT).$field,
-            <$type as $crate::DeviceTypeImpl>::CONF_OFFSET + std::mem::offset_of!($crate::conf_type!($type), $field)
+            <$type as $crate::DeviceTypeImpl>::CONF_OFFSET + $crate::offset_of!($crate::conf_type!($type), $field)
         )
     };
 }
@@ -126,7 +126,7 @@ macro_rules! qdev_define_type {
             @extends $super $(,$supers)*, $crate::Object);
 
         unsafe impl $crate::DeviceTypeImpl for $struct {
-            const CONF_OFFSET: usize = std::mem::offset_of!($struct, conf);
+            const CONF_OFFSET: usize = $crate::offset_of!($struct, conf);
 
             fn properties() -> *const $crate::Property {
                 static mut PROPERTIES: &'static [$crate::Property] = &[$($props),+];
diff --git a/qemu/src/lib.rs b/qemu/src/lib.rs
index 3f0491c..2d43a25 100644
--- a/qemu/src/lib.rs
+++ b/qemu/src/lib.rs
@@ -31,3 +31,7 @@ pub use util::foreign::IntoNative;
 pub use util::foreign::OwnedPointer;
 pub use util::zeroed::Zeroed;
 pub type Result<T> = std::result::Result<T, Error>;
+
+// with_offsets is exported directly from util::offset_of
+#[cfg(has_offset_of)]
+pub use std::mem::offset_of;
diff --git a/qemu/src/qom/object_impl.rs b/qemu/src/qom/object_impl.rs
index 61546b6..b1768b9 100644
--- a/qemu/src/qom/object_impl.rs
+++ b/qemu/src/qom/object_impl.rs
@@ -95,11 +95,14 @@ unsafe fn rust_type_register<T: TypeImpl + ObjectImpl>() {
 #[macro_export]
 macro_rules! qom_define_type {
     ($name:expr, $struct:ident, $conf_ty:ty, $state_ty:ty; @extends $super:ty $(,$supers:ty)*) => {
-        struct $struct {
-            // self.base dropped by call to superclass instance_finalize
-            base: std::mem::ManuallyDrop<$super>,
-            conf: $conf_ty,
-            state: $state_ty,
+        $crate::with_offsets! {
+            #[repr(C)]
+            struct $struct {
+                // self.base dropped by call to superclass instance_finalize
+                base: std::mem::ManuallyDrop<$super>,
+                conf: $conf_ty,
+                state: $state_ty,
+            }
         }
 
         // Define IsA markers for the struct itself and all the superclasses
diff --git a/qemu/src/util/mod.rs b/qemu/src/util/mod.rs
index 9c081b6..e4df7c9 100644
--- a/qemu/src/util/mod.rs
+++ b/qemu/src/util/mod.rs
@@ -1,3 +1,4 @@
 pub mod error;
 pub mod foreign;
+pub mod offset_of;
 pub mod zeroed;
diff --git a/qemu/src/util/offset_of.rs b/qemu/src/util/offset_of.rs
new file mode 100644
index 0000000..4ce5188
--- /dev/null
+++ b/qemu/src/util/offset_of.rs
@@ -0,0 +1,99 @@
+#[cfg(not(has_offset_of))]
+#[macro_export]
+macro_rules! offset_of {
+    ($Container:ty, $field:ident) => {
+        <$Container>::offset_to.$field
+    };
+}
+
+/// A wrapper for struct declarations, that allows using `offset_of!` in
+/// versions of Rust prior to 1.77
+#[macro_export]
+macro_rules! with_offsets {
+    // source: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=10a22a9b8393abd7b541d8fc844bc0df
+    // used under MIT license with permission of Yandros aka Daniel Henry-Mantilla
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
+    ) => (
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
+        const _: () = {
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
+                const offset_to: StructOffsets = StructOffsets {
+                    $(
+                        $field_name: Helper::$field_name,
+                    )*
+                };
+            }
+            const END_OF_PREV_FIELD: usize = 0;
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
+    ) => ();
+
+    (
+        @names [$field_name:ident $($other_names:tt)*]
+        @tys [$field_ty:ty , $($other_tys:tt)*]
+    ) => (
+        impl Helper {
+            const $field_name: usize = {
+                let align =
+                    std::mem::align_of::<$field_ty>()
+                ;
+                let trail =
+                    END_OF_PREV_FIELD % align
+                ;
+                0   + END_OF_PREV_FIELD
+                    + (align - trail)
+                        * [1, 0][(trail == 0) as usize]
+            };
+        }
+        const _: () = {
+            const END_OF_PREV_FIELD: usize =
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
diff --git a/qemu/tests/main.rs b/qemu/tests/main.rs
index 601e92b..854c626 100644
--- a/qemu/tests/main.rs
+++ b/qemu/tests/main.rs
@@ -14,11 +14,16 @@ use qemu::DeviceState;
 
 use qemu::Result;
 
+use qemu::with_offsets;
+
 use std::cell::RefCell;
 
-#[derive(Default, ConstDefault)]
-struct TestConf {
-    foo: bool,
+with_offsets! {
+    #[repr(C)]
+    #[derive(Default, ConstDefault)]
+    struct TestConf {
+        foo: bool,
+    }
 }
 
 #[derive(Default)]
-- 
2.45.2


