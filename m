Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3643C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIVL-00045D-Ip; Mon, 01 Jul 2024 10:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIVK-00044q-19
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIVB-0005L8-I3
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719845972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kFn8a5fReLo+S4SarZhzaU3e4BbwOPj+DmW1DUwZMXo=;
 b=E1vI6ayGcZtcsRjzVouLeXS5LmXgS0hrbWLtblBdeFZedjHq+tDM3owGKGQ6Qp1liRT+/9
 3VpljY2bXvVoFR2l0upGsvZAfHoTSWcf5NgG+8xkyTvpIfvJ0wRtoE1gd9fY5pqJ9hoXPC
 BwUQYKlKiBYglmuaw7CjUjyw8aMgfHk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-pp4OJrtGNNWnSZzbcDuyKg-1; Mon, 01 Jul 2024 10:59:28 -0400
X-MC-Unique: pp4OJrtGNNWnSZzbcDuyKg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-424a775ee7fso22872765e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 07:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719845967; x=1720450767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kFn8a5fReLo+S4SarZhzaU3e4BbwOPj+DmW1DUwZMXo=;
 b=d+pFcr4dAH+WNzK6KihdhZcBzTttX7DScrqh15Q612Dp88osLHv/OV3qapDiCw3mTX
 5VN+ZNyefdZ+ZYiwQ2UZXZn4QyHup2veioBl2mcVLrzdAAgHFzuofNGeHQGWqkFpfyP+
 4sfM9EltNH6jF4wM/0CyedbEHRyoQrMD80Hnfj59p5Jzdh+dXW+nAQa1U9XuCbjDCaNt
 XMr0EcSvrzm72AYoo+6Qofd05b8ARzTCXndlrDzVshgKVmyVtu/cyJ0Nir1ctbR5coxG
 vi6BkoMF+WYSLaWHbwe/nMHS354BWR3T7aGAkQSQhqrUDXYfoLpZzxqIubKHB9d8QxkU
 fQiw==
X-Gm-Message-State: AOJu0YyeJXLO8Qd3Hpca/z3g9EWg4bonW5gJqzmvk105UQa+CNFE97ef
 hHzaMdh4ioO8E1nMjC5QoGdggWRhpjDf+49FYADF5Rvz9IX3+ogPhnscJaGjTu8pa77swIjcLmL
 XWozflv7sJweRvnOXGladxUlQ5KgMVlREbA6Axv6RnRwDN7RiG0LO+YgwGJf+uDzl/zCl9FIb4m
 NNc0SXla3/NYaYUIYT6NJkTxKZRDTITxI310Uy
X-Received: by 2002:a5d:5f8e:0:b0:363:7788:b975 with SMTP id
 ffacd0b85a97d-36775721529mr4047303f8f.52.1719845966872; 
 Mon, 01 Jul 2024 07:59:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy1qi0DnHKrmHTxoOgaGg/kZjQppCGzPd4Wb/whzeKfCyDi6+eAC45fD2XzhbQUkYllkUWZQ==
X-Received: by 2002:a5d:5f8e:0:b0:363:7788:b975 with SMTP id
 ffacd0b85a97d-36775721529mr4047279f8f.52.1719845966483; 
 Mon, 01 Jul 2024 07:59:26 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a1030dfsm10236997f8f.100.2024.07.01.07.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 07:59:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 10/14] rust: add idiomatic bindings to define Device subclasses
Date: Mon,  1 Jul 2024 16:58:42 +0200
Message-ID: <20240701145853.1394967-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701145853.1394967-1-pbonzini@redhat.com>
References: <20240701145853.1394967-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Provide a macro to register a type and automatically define qdev
properties.  Subclasses of DeviceState must define a trait DeviceImpl, to
point the type definition machinery to the implementation of virtual
functions in DeviceState.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu/src/hw/core/device_impl.rs | 140 ++++++++++++++++++++++++++++++++
 qemu/src/hw/core/mod.rs         |   1 +
 qemu/src/lib.rs                 |   5 ++
 qemu/tests/main.rs              |  52 +++++++++++-
 4 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 qemu/src/hw/core/device_impl.rs

diff --git a/qemu/src/hw/core/device_impl.rs b/qemu/src/hw/core/device_impl.rs
new file mode 100644
index 0000000..80b0e5e
--- /dev/null
+++ b/qemu/src/hw/core/device_impl.rs
@@ -0,0 +1,140 @@
+//! Macros and traits to implement subclasses of Device in Rust
+//!
+//! @author Paolo Bonzini
+
+#![allow(clippy::missing_safety_doc)]
+
+use std::ffi::c_void;
+
+use crate::bindings;
+use crate::bindings::DeviceClass;
+use crate::bindings::DeviceState;
+use crate::bindings::Property;
+
+use crate::qom::object_impl::ObjectImpl;
+use crate::qom::object_impl::TypeImpl;
+
+use crate::qom::refs::ObjectCast;
+
+use crate::util::error::Error;
+
+/// Information on which superclass methods are overridden
+/// by a Rust-implemented subclass of Device.
+pub trait DeviceImpl: ObjectImpl + DeviceTypeImpl {
+    /// If not `None`, a function that implements the `realize` member
+    /// of the QOM `DeviceClass`.
+    const REALIZE: Option<fn(obj: &Self) -> crate::Result<()>> = None;
+
+    /// If not `None`, a function that implements the `unrealize` member
+    /// of the QOM `DeviceClass`.
+    const UNREALIZE: Option<fn(obj: &Self)> = None;
+
+    /// If not `None`, a function that implements the `cold_reset` member
+    /// of the QOM `DeviceClass`.
+    const COLD_RESET: Option<fn(obj: &Self)> = None;
+}
+
+impl DeviceClass {
+    pub fn class_init<T: DeviceImpl>(&mut self) {
+        unsafe extern "C" fn rust_cold_reset<T: DeviceImpl>(obj: *mut DeviceState) {
+            let f = T::COLD_RESET.unwrap();
+            f((&*obj).unsafe_cast::<T>())
+        }
+        self.cold_reset = T::COLD_RESET.map(|_| rust_cold_reset::<T> as _);
+
+        unsafe extern "C" fn rust_realize<T: DeviceImpl>(
+            obj: *mut DeviceState,
+            errp: *mut *mut bindings::Error,
+        ) {
+            let f = T::REALIZE.unwrap();
+            let result = f((&*obj).unsafe_cast::<T>());
+            Error::ok_or_propagate(result, errp);
+        }
+        self.realize = T::REALIZE.map(|_| rust_realize::<T> as _);
+
+        unsafe extern "C" fn rust_unrealize<T: DeviceImpl>(obj: *mut DeviceState) {
+            let f = T::UNREALIZE.unwrap();
+            f((&*obj).unsafe_cast::<T>())
+        }
+        self.unrealize = T::UNREALIZE.map(|_| rust_unrealize::<T> as _);
+
+        self.properties = <T as DeviceTypeImpl>::properties();
+
+        // Now initialize the ObjectClass from the ObjectImpl.
+        self.oc.class_init::<T>();
+    }
+}
+
+impl DeviceState {
+    pub unsafe extern "C" fn rust_class_init<T: DeviceImpl>(
+        klass: *mut c_void,
+        _data: *mut c_void,
+    ) {
+        let dc: &mut DeviceClass = &mut *(klass.cast());
+        dc.class_init::<T>();
+    }
+}
+
+/// Internal information on a Rust-implemented subclass of Device.
+/// Only public because it is used by macros.
+pub unsafe trait DeviceTypeImpl: TypeImpl {
+    const CONF_OFFSET: usize;
+
+    // This needs to be here, and not in DeviceImpl, because properties
+    // reference statics (for globals defined in C, e.g. qdev_prop_bool)
+    // which is unstable (see https://github.com/rust-lang/rust/issues/119618,
+    // feature const_refs_to_static)
+    fn properties() -> *const Property;
+}
+
+pub struct QdevPropBool;
+impl QdevPropBool {
+    pub const fn convert(value: &bool) -> u64 {
+        *value as u64
+    }
+}
+
+#[macro_export]
+macro_rules! qdev_prop {
+    (@internal bool, $name:expr, $default:expr, $offset:expr) => {
+        $crate::Property {
+            name: $name.as_ptr(),
+            offset: $offset,
+            default: $crate::hw::core::device_impl::QdevPropBool::convert(&($default)),
+            info: unsafe { &$crate::bindings::qdev_prop_bool },
+        }
+    };
+
+    // Replace field with typechecking expression and offset
+    ($kind:tt, $name:expr, $type:ty, $default:expr, $field:ident) => {
+        qdev_prop!(@internal
+            $kind,
+            $name,
+            (<$crate::conf_type!($type) as ConstDefault>::DEFAULT).$field,
+            <$type as $crate::DeviceTypeImpl>::CONF_OFFSET + std::mem::offset_of!($crate::conf_type!($type), $field)
+        )
+    };
+}
+
+#[macro_export]
+macro_rules! qdev_define_type {
+    ($name:expr, $struct:ident, $conf_ty:ty, $state_ty:ty;
+     @extends $super:ty $(,$supers:ty)*;
+     @properties [$($props: expr),+]) => {
+        $crate::qom_define_type!(
+            $name, $struct, $conf_ty, $state_ty;
+            @extends $super $(,$supers)*, $crate::Object);
+
+        unsafe impl $crate::DeviceTypeImpl for $struct {
+            const CONF_OFFSET: usize = std::mem::offset_of!($struct, conf);
+
+            fn properties() -> *const $crate::Property {
+                static mut PROPERTIES: &'static [$crate::Property] = &[$($props),+];
+
+                // SAFETY: The only reference is created here; mut is needed to refer to
+                // &qdev_prop_xxx.
+                unsafe { PROPERTIES.as_ptr() }
+            }
+        }
+    }
+}
diff --git a/qemu/src/hw/core/mod.rs b/qemu/src/hw/core/mod.rs
index 5458924..6cd9197 100644
--- a/qemu/src/hw/core/mod.rs
+++ b/qemu/src/hw/core/mod.rs
@@ -1 +1,2 @@
 pub mod device;
+pub mod device_impl;
diff --git a/qemu/src/lib.rs b/qemu/src/lib.rs
index 81abf9c..3f0491c 100644
--- a/qemu/src/lib.rs
+++ b/qemu/src/lib.rs
@@ -2,12 +2,17 @@
 #![allow(dead_code)]
 
 pub mod bindings;
+pub use bindings::DeviceClass;
 pub use bindings::DeviceState;
 pub use bindings::Object;
+pub use bindings::Property;
+pub use bindings::PropertyInfo;
 pub use bindings::TypeInfo;
 
 pub mod hw;
 pub use hw::core::device::DeviceMethods;
+pub use hw::core::device_impl::DeviceImpl;
+pub use hw::core::device_impl::DeviceTypeImpl;
 
 pub mod qom;
 pub use qom::object::ObjectClassMethods;
diff --git a/qemu/tests/main.rs b/qemu/tests/main.rs
index a7cbeed..e499c14 100644
--- a/qemu/tests/main.rs
+++ b/qemu/tests/main.rs
@@ -5,9 +5,18 @@ use qemu::Object;
 use qemu::ObjectClassMethods;
 use qemu::ObjectImpl;
 
+use qemu::qdev_define_type;
+use qemu::qdev_prop;
+use qemu::DeviceImpl;
+use qemu::DeviceMethods;
+use qemu::DeviceState;
+
+use qemu::Result;
+
+use std::cell::RefCell;
+
 #[derive(Default, ConstDefault)]
 struct TestConf {
-    #[allow(dead_code)]
     foo: bool,
 }
 
@@ -27,6 +36,47 @@ qom_define_type!(
 
 impl ObjectImpl for TestObject {}
 
+qdev_define_type!(
+    c"test-device",
+    TestDevice,
+    TestConf,
+    RefCell<TestState>;
+    @extends DeviceState;
+    @properties [qdev_prop!(bool, c"foo", TestDevice, true, foo)]
+);
+
+impl TestDevice {
+    #[allow(clippy::unused_self)]
+    fn unparent(&self) {
+        println!("unparent");
+    }
+
+    #[allow(clippy::unused_self)]
+    fn realize(&self) -> Result<()> {
+        println!("realize");
+        Ok(())
+    }
+
+    #[allow(clippy::unused_self)]
+    fn unrealize(&self) {
+        println!("unrealize");
+    }
+}
+
+impl ObjectImpl for TestDevice {
+    const UNPARENT: Option<fn(&TestDevice)> = Some(TestDevice::unparent);
+}
+
+impl DeviceImpl for TestDevice {
+    const REALIZE: Option<fn(&TestDevice) -> Result<()>> = Some(TestDevice::realize);
+    const UNREALIZE: Option<fn(&TestDevice)> = Some(TestDevice::unrealize);
+}
+
 fn main() {
     drop(TestObject::new());
+
+    let d = TestDevice::new();
+    d.realize().unwrap();
+    d.cold_reset();
+    d.unparent();
 }
-- 
2.45.2


