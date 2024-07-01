Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B9FC3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIVF-00044F-1e; Mon, 01 Jul 2024 10:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIVC-00043X-UY
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIV8-0005Ke-Qa
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719845969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DEGKZAsNCxRe4msj+coj0klBr3yJvhJ3TzEiM0nG3fs=;
 b=PqakJVlniZd0wIUqnEaE/9c+WHDnXwKv6P63rnWncWgUvMwhnD6uNfpYwv7MGoq/bb4Ajt
 RHOicJRuehBuG7r3biG4jZcqqaaxQ63lD4P15yIFSI+d3woXqtkmDv/Q0GRt9ItxkAyvIi
 v/x+elHaPIGhKyLVoiGpA1yon4nJijA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-RICNNUntO2qGYW7gBhQLkg-1; Mon, 01 Jul 2024 10:59:26 -0400
X-MC-Unique: RICNNUntO2qGYW7gBhQLkg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4256667ebf9so22789025e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 07:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719845964; x=1720450764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DEGKZAsNCxRe4msj+coj0klBr3yJvhJ3TzEiM0nG3fs=;
 b=gLuFlV8Bn2HZ8aIqIqZlMqyrPTbktgAtZG/LkFnv+8BiiZd9ZB8ZyQTDITAr37WSET
 WdSWlPuJfE3abZM0JZKiRubVmJVnIuBsGh5zAZSpKtajZ5cHYRxq+P1XGVplAADvaj3z
 337BW2t097SQUKF9bUClCMjdFsqLZ+onFi7KP78dy3quZwtXbj57+wvvHLxpb5wInH9k
 gKHzxeI75NjWgt5d1iEeJzM0nB340AWRTibBKBh1V3p+8mwLWLpygDHra4P6ZE9NFd89
 aWpoOxm+YvvSqhN2yHAUey+5DpFxrmAGSKaYWAc2eG3X2Ttg6/A31LcxVFJa5+K75H0f
 TdgQ==
X-Gm-Message-State: AOJu0YxDcLaJolIhSppp99R438pQZGhXdeUbFAC5HXV5+yGeQauV3Ct8
 /nfpGXEoRqYjNtIiFBVFIFrs7r8056qK03+O/ADoL+TysIExlBFB9AGuddIB0xfNi9ol1uh5t8C
 CehJfFaAjw96CxhZRjwXH6DG2eVabgNdX8P7svz6VUH2hwt08ea8lOvAc6j4jpfhVu30rayW6oF
 BPQSYMrawBPZ2xFD/9RhydAMqXZwSpWhfp0Y9i
X-Received: by 2002:a7b:ce15:0:b0:425:5fa2:60a8 with SMTP id
 5b1f17b1804b1-4257a02fc72mr42828075e9.24.1719845963929; 
 Mon, 01 Jul 2024 07:59:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6AimDK+r53PynBwCen4/l1vp8ax4I7+MnkLb+V8YDarFrzgyg/jpKhdbK7n9bEJPpWZWjrw==
X-Received: by 2002:a7b:ce15:0:b0:425:5fa2:60a8 with SMTP id
 5b1f17b1804b1-4257a02fc72mr42827815e9.24.1719845963521; 
 Mon, 01 Jul 2024 07:59:23 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c0f1bsm154656005e9.44.2024.07.01.07.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 07:59:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 09/14] rust: add idiomatic bindings to define Object subclasses
Date: Mon,  1 Jul 2024 16:58:41 +0200
Message-ID: <20240701145853.1394967-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701145853.1394967-1-pbonzini@redhat.com>
References: <20240701145853.1394967-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Provide a macro to register a type and automatically define instance_init
(actually instance_mem_init) and instance_finalize functions.  Subclasses
of Object must define a trait ObjectImpl, to point the type definition
machinery to the implementation of virtual functions in Object.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu/src/lib.rs             |   4 +
 qemu/src/qom/mod.rs         |   1 +
 qemu/src/qom/object_impl.rs | 146 ++++++++++++++++++++++++++++++++++++
 qemu/src/util/mod.rs        |   1 +
 qemu/src/util/zeroed.rs     |  21 ++++++
 qemu/tests/main.rs          |  32 ++++++++
 6 files changed, 205 insertions(+)
 create mode 100644 qemu/src/qom/object_impl.rs
 create mode 100644 qemu/src/util/zeroed.rs
 create mode 100644 qemu/tests/main.rs

diff --git a/qemu/src/lib.rs b/qemu/src/lib.rs
index b0dcce1..81abf9c 100644
--- a/qemu/src/lib.rs
+++ b/qemu/src/lib.rs
@@ -4,6 +4,7 @@
 pub mod bindings;
 pub use bindings::DeviceState;
 pub use bindings::Object;
+pub use bindings::TypeInfo;
 
 pub mod hw;
 pub use hw::core::device::DeviceMethods;
@@ -12,6 +13,8 @@ pub mod qom;
 pub use qom::object::ObjectClassMethods;
 pub use qom::object::ObjectMethods;
 pub use qom::object::ObjectType;
+pub use qom::object_impl::ObjectImpl;
+pub use qom::object_impl::TypeImpl;
 pub use qom::refs::ObjectCast;
 pub use qom::refs::Owned;
 
@@ -21,4 +24,5 @@ pub use util::foreign::CloneToForeign;
 pub use util::foreign::FromForeign;
 pub use util::foreign::IntoNative;
 pub use util::foreign::OwnedPointer;
+pub use util::zeroed::Zeroed;
 pub type Result<T> = std::result::Result<T, Error>;
diff --git a/qemu/src/qom/mod.rs b/qemu/src/qom/mod.rs
index 95489c5..3f8ee6e 100644
--- a/qemu/src/qom/mod.rs
+++ b/qemu/src/qom/mod.rs
@@ -1,2 +1,3 @@
 pub mod object;
+pub mod object_impl;
 pub mod refs;
diff --git a/qemu/src/qom/object_impl.rs b/qemu/src/qom/object_impl.rs
new file mode 100644
index 0000000..61546b6
--- /dev/null
+++ b/qemu/src/qom/object_impl.rs
@@ -0,0 +1,146 @@
+//! Macros and traits to implement subclasses of Object in Rust
+//!
+//! @author Paolo Bonzini
+
+#![allow(clippy::missing_safety_doc)]
+
+use const_default::ConstDefault;
+
+use std::ffi::c_void;
+use std::mem;
+use std::mem::MaybeUninit;
+use std::ptr::drop_in_place;
+
+use crate::qom::object::ObjectType;
+
+use crate::qom::refs::ObjectCast;
+
+use crate::bindings::type_register;
+use crate::bindings::Object;
+use crate::bindings::ObjectClass;
+use crate::bindings::TypeInfo;
+
+use crate::util::zeroed::Zeroed;
+
+/// Information on which superclass methods are overridden
+/// by a Rust-implemented subclass of Object.
+pub trait ObjectImpl: ObjectType {
+    /// If not `None`, a function that implements the `unparent` member
+    /// of the QOM `ObjectClass`.
+    const UNPARENT: Option<fn(obj: &Self)> = None;
+}
+
+impl ObjectClass {
+    /// Initialize an `ObjectClass` from an `ObjectImpl`.
+    pub fn class_init<T: ObjectImpl>(&mut self) {
+        unsafe extern "C" fn rust_unparent<T: ObjectImpl>(obj: *mut Object) {
+            let f = T::UNPARENT.unwrap();
+            f((&*obj).unsafe_cast::<T>())
+        }
+        self.unparent = T::UNPARENT.map(|_| rust_unparent::<T> as _);
+    }
+}
+
+impl Object {
+    pub unsafe extern "C" fn rust_class_init<T: ObjectImpl>(
+        klass: *mut c_void,
+        _data: *mut c_void,
+    ) {
+        let oc: &mut ObjectClass = &mut *(klass.cast());
+        oc.class_init::<T>();
+    }
+}
+
+/// Internal information on a Rust-implemented subclass of Object.
+/// Only public because it is used by macros.
+pub unsafe trait TypeImpl: ObjectType + ObjectImpl {
+    type Super: ObjectType;
+    type Conf: ConstDefault;
+    type State: Default;
+
+    const CLASS_INIT: unsafe extern "C" fn(klass: *mut c_void, data: *mut c_void);
+
+    fn uninit_conf(obj: &mut MaybeUninit<Self>) -> &mut MaybeUninit<Self::Conf>;
+    fn uninit_state(obj: &mut MaybeUninit<Self>) -> &mut MaybeUninit<Self::State>;
+}
+
+unsafe fn rust_type_register<T: TypeImpl + ObjectImpl>() {
+    unsafe extern "C" fn rust_instance_mem_init<T: TypeImpl>(obj: *mut c_void) {
+        let obj: &mut std::mem::MaybeUninit<T> = &mut *(obj.cast());
+
+        T::uninit_conf(obj).write(ConstDefault::DEFAULT);
+        T::uninit_state(obj).write(Default::default());
+    }
+
+    unsafe extern "C" fn rust_instance_finalize<T: TypeImpl>(obj: *mut c_void) {
+        let obj: *mut T = obj.cast();
+        drop_in_place(obj);
+    }
+
+    let ti = TypeInfo {
+        name: T::TYPE.as_ptr(),
+        parent: T::Super::TYPE.as_ptr(),
+        instance_size: mem::size_of::<T>(),
+        instance_mem_init: Some(rust_instance_mem_init::<T>),
+        instance_finalize: Some(rust_instance_finalize::<T>),
+        class_init: Some(T::CLASS_INIT),
+
+        // SAFETY: TypeInfo is defined in C and all fields are okay to be zeroed
+        ..Zeroed::zeroed()
+    };
+
+    type_register(&ti)
+}
+
+#[macro_export]
+macro_rules! qom_define_type {
+    ($name:expr, $struct:ident, $conf_ty:ty, $state_ty:ty; @extends $super:ty $(,$supers:ty)*) => {
+        struct $struct {
+            // self.base dropped by call to superclass instance_finalize
+            base: std::mem::ManuallyDrop<$super>,
+            conf: $conf_ty,
+            state: $state_ty,
+        }
+
+        // Define IsA markers for the struct itself and all the superclasses
+        $crate::qom_isa!($struct, $super $(,$supers)*);
+
+        unsafe impl $crate::qom::object::ObjectType for $struct {
+            const TYPE: &'static std::ffi::CStr = $name;
+        }
+
+        unsafe impl $crate::qom::object_impl::TypeImpl for $struct {
+            type Super = $super;
+            type Conf = $conf_ty;
+            type State = $state_ty;
+
+            const CLASS_INIT: unsafe extern "C" fn(klass: *mut std::ffi::c_void, data: *mut std::ffi::c_void)
+                = <$super>::rust_class_init::<Self>;
+
+            fn uninit_conf(obj: &mut std::mem::MaybeUninit::<Self>) -> &mut std::mem::MaybeUninit<$conf_ty> {
+                use std::ptr::addr_of_mut;
+
+                // Projecting the incoming reference to a single field is safe,
+                // because the return value is also MaybeUnit
+                unsafe { &mut *(addr_of_mut!((*obj.as_mut_ptr()).conf).cast()) }
+            }
+
+            fn uninit_state(obj: &mut std::mem::MaybeUninit::<Self>) -> &mut std::mem::MaybeUninit<$state_ty> {
+                use std::ptr::addr_of_mut;
+
+                // Projecting the incoming reference to a single field is safe,
+                // because the return value is also MaybeUnit
+                unsafe { &mut *(addr_of_mut!((*obj.as_mut_ptr()).state).cast()) }
+            }
+        }
+
+        // TODO: call rust_type_register
+    };
+}
+
+#[macro_export]
+macro_rules! conf_type {
+    ($type:ty) => {
+        <$type as $crate::qom::object_impl::TypeImpl>::Conf
+    };
+}
diff --git a/qemu/src/util/mod.rs b/qemu/src/util/mod.rs
index e6078ac..9c081b6 100644
--- a/qemu/src/util/mod.rs
+++ b/qemu/src/util/mod.rs
@@ -1,2 +1,3 @@
 pub mod error;
 pub mod foreign;
+pub mod zeroed;
diff --git a/qemu/src/util/zeroed.rs b/qemu/src/util/zeroed.rs
new file mode 100644
index 0000000..e656834
--- /dev/null
+++ b/qemu/src/util/zeroed.rs
@@ -0,0 +1,21 @@
+#![allow(clippy::undocumented_unsafe_blocks)]
+
+use std::mem::MaybeUninit;
+
+/// Trait providing an easy way to obtain an all-zero
+/// value for a struct
+///
+/// # Safety
+///
+/// Only add this to a type if `MaybeUninit::zeroed().assume_init()`
+/// is valid for that type.
+pub unsafe trait Zeroed: Sized {
+    fn zeroed() -> Self {
+        // SAFETY: If this weren't safe, just do not add the
+        // trait to a type.
+        unsafe { MaybeUninit::zeroed().assume_init() }
+    }
+}
+
+// Put here all the impls that you need for the bindgen-provided types.
+unsafe impl Zeroed for crate::bindings::TypeInfo {}
diff --git a/qemu/tests/main.rs b/qemu/tests/main.rs
new file mode 100644
index 0000000..a7cbeed
--- /dev/null
+++ b/qemu/tests/main.rs
@@ -0,0 +1,32 @@
+use const_default::ConstDefault;
+
+use qemu::qom_define_type;
+use qemu::Object;
+use qemu::ObjectClassMethods;
+use qemu::ObjectImpl;
+
+#[derive(Default, ConstDefault)]
+struct TestConf {
+    #[allow(dead_code)]
+    foo: bool,
+}
+
+#[derive(Default)]
+struct TestState {
+    #[allow(dead_code)]
+    bar: i32,
+}
+
+qom_define_type!(
+    c"test-object",
+    TestObject,
+    TestConf,
+    ();
+    @extends Object
+);
+
+impl ObjectImpl for TestObject {}
+
+fn main() {
+    drop(TestObject::new());
+}
-- 
2.45.2


