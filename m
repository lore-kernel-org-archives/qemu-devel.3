Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E003C3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIV6-000420-If; Mon, 01 Jul 2024 10:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIV4-00040k-T9
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIV2-0005JE-E0
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719845963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=um1cHYKDVA60dq1DdcbcXL9qPvVb59yG3OyrA7YkkNg=;
 b=CORQGbyLO1WO/FsL6DvBr29lhDt0wJubXL5yTWSjxKIPB8ha/7meeN05uEnnqSyiIF6d6G
 nH4ylm1u1ozb/XfBBqyVZcEzvqAkJPvVgxSQDwnlzimjfF/KYHDiBb1seHl4r9oYzxITyO
 uZ4aITFu5lWd5W6wEWXxckl38QKdesU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-rvlHLLYjO1qQ3_GqQzlrrQ-1; Mon, 01 Jul 2024 10:59:17 -0400
X-MC-Unique: rvlHLLYjO1qQ3_GqQzlrrQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ee4c666856so35551471fa.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 07:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719845955; x=1720450755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=um1cHYKDVA60dq1DdcbcXL9qPvVb59yG3OyrA7YkkNg=;
 b=pk3MdeU/jHk3bQFeXaS3AeOino5ERtqntv/Dy9r8mU/6AHA7lQXbzGbKRL+ZYAfY/v
 WntL2I8T0tiUBl7Pt5Sxm8FzpMZ0RX3nuDVp0d6VOS+Xhy8efVUJtRx89WinsnZ8u17L
 4NMqSXxzJ7Pv/pr2SMc0ExBMnfGRlHquqhyF2YwvqznaXFU5wYNFfcbEmk/KhzYs/DYb
 /+n9/nGydvMcbn/jf4E1EIQA/xA12O5GD7n82USyMK93MABStesznny8AWKqPUcEPwo0
 H/0xw0IBXsw68bXvbPqXC84A85dHTSiaCPrq++XlBFCgyeShdKyiagvmSsddf4ih6cJo
 qI4g==
X-Gm-Message-State: AOJu0YwmVXDMurNAHxd/ShFUKC/Tud20KGyZhqRumAO+vP0KQpoIKybO
 UIZYvJFia0CQtnPpY6hipyFLUUVheMWUF+GVrzc8m3x46PMeeQ0fzFB/yiIRBJ7Sxoa9A0t/U38
 RnpcwsU6gBuK0XX9Vc5tsw/HNh+Ugy9i1ULBFgDnKX47s0+WqPh2xtKKGm+iOc2H/CU+Hqb0vKv
 4/lVUew9BirtV/wsRCKN29gz0ewJH0E1fNc/Jh
X-Received: by 2002:a2e:3018:0:b0:2ec:5f85:61c0 with SMTP id
 38308e7fff4ca-2ee5e707c21mr47302921fa.48.1719845954929; 
 Mon, 01 Jul 2024 07:59:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7LkxnzvJNVXy+mD5cbiiqW3PV7qLAI1xQqINPEE8KtDPkKHNMSCCcvIpZYx6R577FF0DtKQ==
X-Received: by 2002:a2e:3018:0:b0:2ec:5f85:61c0 with SMTP id
 38308e7fff4ca-2ee5e707c21mr47302731fa.48.1719845954359; 
 Mon, 01 Jul 2024 07:59:14 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b061095sm149668235e9.23.2024.07.01.07.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 07:59:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 06/14] rust: define wrappers for basic QOM concepts
Date: Mon,  1 Jul 2024 16:58:38 +0200
Message-ID: <20240701145853.1394967-7-pbonzini@redhat.com>
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

This provides type-safe object casts, and automatic reference counting.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu/qom-rust.txt      |  82 ++++++++++++
 qemu/src/lib.rs        |   6 +
 qemu/src/qom/mod.rs    |   2 +
 qemu/src/qom/object.rs |  34 +++++
 qemu/src/qom/refs.rs   | 274 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 398 insertions(+)
 create mode 100644 qemu/qom-rust.txt
 create mode 100644 qemu/src/qom/mod.rs
 create mode 100644 qemu/src/qom/object.rs
 create mode 100644 qemu/src/qom/refs.rs

diff --git a/qemu/qom-rust.txt b/qemu/qom-rust.txt
new file mode 100644
index 0000000..1588445
--- /dev/null
+++ b/qemu/qom-rust.txt
@@ -0,0 +1,82 @@
+Rust QOM interoperability design
+--------------------------------
+
+Passing objects around
+----------------------
+
+ObjectRef:
+-> trait for performing casts on objects
+-> upcasts safe at compile time, downcasts safe at runtime
+-> implemented by &T and qom::Owned<T>
+-> casting &T produces &U, casting qom::Owned<T> produces qom::Owned<U>
+
+qom::Owned<T>
+-> T is a struct for a QOM object
+-> cloning qom::Owned calls object_ref, dropping qom::Owned calls object_unref
+
+
+Calling methods
+---------------
+
+- all methods &self (interior mutability)
+  - Rust implementation needs to wrap state with Cell<>, RefCell<> or Mutex<>
+
+one struct per class; one trait per non-final class; one trait per interface
+struct: Object, Device, ...
+- defines constructors
+     example: PL011::new()   (technically defined on ObjectType)
+
+- defines methods of final classes
+
+trait: ObjectMethods, DeviceMethods, UserCreatableMethods, ...
+- defines methods of non-final classes and interfaces
+     example: obj.typename()
+
+- automatically implemented by &T where T is a subclass
+
+
+all methods expect interior mutability
+- structs not Send/Sync by default since they contain C pointers
+  - hence &T and Owned<T> also not thread-safe
+- good: QOM tree (e.g. object_unparent) not thread-safe
+- what if objects _are_ thread-safe?
+  - possibly another trait ObjectSyncMethods?
+
+Bindings for C classes
+----------------------
+
+struct must implement ObjectType
+
+    unsafe impl ObjectType for Object {
+        const TYPE: &'static CStr = c"object";
+    }
+
+struct must implement IsA<T> for all superclasses T
+
+    unsafe impl IsA<Object> for Object {}
+
+
+Defining QOM classes in Rust
+----------------------------
+
+struct must be #[repr(C)]
+
+one traits per class + one more if it has virtual functions
+
+trait #1: ObjectTypeImpl, DeviceTypeImpl, ...
+- metadata
+    type Super: ObjectType;
+- functions:
+    unsafe fn instance_init(obj: *mut Self);
+    ...
+
+trait #2: ObjectImpl, DeviceImpl, ...
+- functions:
+    fn unrealize(&self)
+
+Rust implementation split in configuration (Default + ConstDefault) and
+state (Default)
+
+instance_init implemented automatically via Default/ConstDefault trait
+   maybe: pre_init hook that replaces memset(obj, 0, type->instance_size)?
+instance_finalize implemented automatically via Drop trait
diff --git a/qemu/src/lib.rs b/qemu/src/lib.rs
index 5f926b8..0d91623 100644
--- a/qemu/src/lib.rs
+++ b/qemu/src/lib.rs
@@ -2,6 +2,12 @@
 #![allow(dead_code)]
 
 pub mod bindings;
+pub use bindings::Object;
+
+pub mod qom;
+pub use qom::object::ObjectType;
+pub use qom::refs::ObjectCast;
+pub use qom::refs::Owned;
 
 pub mod util;
 pub use util::error::Error;
diff --git a/qemu/src/qom/mod.rs b/qemu/src/qom/mod.rs
new file mode 100644
index 0000000..95489c5
--- /dev/null
+++ b/qemu/src/qom/mod.rs
@@ -0,0 +1,2 @@
+pub mod object;
+pub mod refs;
diff --git a/qemu/src/qom/object.rs b/qemu/src/qom/object.rs
new file mode 100644
index 0000000..bd6b957
--- /dev/null
+++ b/qemu/src/qom/object.rs
@@ -0,0 +1,34 @@
+//! Bindings for the QOM Object class
+//!
+//! @author Paolo Bonzini
+
+use std::ffi::CStr;
+
+use crate::bindings::Object;
+
+use crate::qom_isa;
+
+/// Trait exposed by all structs corresponding to QOM objects.
+/// Defines "class methods" for the class.  Usually these can be
+/// implemented on the class itself; here, using a trait allows
+/// each class to define `TYPE`, and it also lets `new()` return the
+/// right type.
+///
+/// # Safety
+///
+/// - the first field of the struct must be of `Object` type,
+///   or derived from it
+///
+/// - `TYPE` must match the type name used in the `TypeInfo` (no matter
+///   if it is defined in C or Rust).
+///
+/// - the struct must be `#[repr(C)]`
+pub unsafe trait ObjectType: Sized {
+    const TYPE: &'static CStr;
+}
+
+unsafe impl ObjectType for Object {
+    const TYPE: &'static CStr = c"object";
+}
+
+qom_isa!(Object);
diff --git a/qemu/src/qom/refs.rs b/qemu/src/qom/refs.rs
new file mode 100644
index 0000000..a319bde
--- /dev/null
+++ b/qemu/src/qom/refs.rs
@@ -0,0 +1,274 @@
+//! Casting and reference counting traits for QOM objects
+//!
+//! @author Paolo Bonzini
+
+use crate::bindings::object_dynamic_cast;
+use crate::bindings::Object;
+use crate::bindings::{object_ref, object_unref};
+
+use crate::qom::object::ObjectType;
+
+use std::borrow::Borrow;
+use std::mem::ManuallyDrop;
+use std::ops::Deref;
+use std::ptr::NonNull;
+
+/// Marker trait: `Self` can be statically upcasted to `P` (i.e. `P` is a direct
+/// or indirect parent of `Self`).
+///
+/// # Safety
+///
+/// The struct `Self` must begin, directly or indirectly, with a field of type
+/// `P`.  This ensures that invalid casts, which rely on `IsA<>` for static
+/// checking, are rejected at compile time.
+pub unsafe trait IsA<P: ObjectType>: ObjectType {}
+
+// SAFETY: it is always safe to cast to your own type
+unsafe impl<T: ObjectType> IsA<T> for T {}
+
+#[macro_export]
+macro_rules! qom_isa {
+    ($struct:ty $(,$parent:ty)* ) => {
+        $(
+            impl AsRef<$parent> for $struct {
+                fn as_ref(&self) -> &$parent {
+                    use $crate::ObjectCast;
+                    self.upcast::<$parent>()
+                }
+            }
+
+            // SAFETY: it is the caller responsibility to have $parent as the
+            // first field
+            unsafe impl $crate::qom::refs::IsA<$parent> for $struct {}
+        )*
+    };
+}
+
+/// Trait for a reference to a QOM object.  Allows conversion to/from
+/// C objects in generic code.
+pub trait ObjectCast: Copy + Deref
+where
+    Self::Target: ObjectType,
+{
+    /// Convert this (possibly smart) reference to a basic Rust reference.
+    fn as_ref(&self) -> &Self::Target {
+        self.deref()
+    }
+
+    /// Convert to a const Rust pointer, to be used for example for FFI.
+    fn as_ptr(&self) -> *const Self::Target {
+        self.as_ref()
+    }
+
+    /// Convert to a mutable Rust pointer, to be used for example for FFI.
+    /// Used to implement interior mutability for objects.
+    ///
+    /// # Safety
+    ///
+    /// This method is unsafe because it overrides const-ness of `&self`.
+    /// Bindings to C APIs will use it a lot, but otherwise it should not
+    /// be necessary.
+    unsafe fn as_mut_ptr(&self) -> *mut Self::Target {
+        #[allow(clippy::as_ptr_cast_mut)]
+        {
+            self.as_ptr().cast_mut()
+        }
+    }
+
+    /// Perform a cast to a superclass
+    fn upcast<'a, U: ObjectType>(self) -> &'a U
+    where
+        Self::Target: IsA<U>,
+        Self: 'a,
+    {
+        // SAFETY: soundness is declared via IsA<U>, which is an unsafe trait
+        unsafe { self.unsafe_cast::<U>() }
+    }
+
+    /// Perform a cast to a subclass.  Checks at compile time that the
+    /// cast can succeed, but the final verification will happen at
+    /// runtime only.
+    fn downcast<'a, U: IsA<Self::Target>>(self) -> Option<&'a U>
+    where
+        Self: 'a,
+    {
+        self.dynamic_cast::<U>()
+    }
+
+    /// Perform a cast between QOM types.  The check that U is indeed
+    /// the dynamic type of `self` happens at runtime.
+    fn dynamic_cast<'a, U: ObjectType>(self) -> Option<&'a U>
+    where
+        Self: 'a,
+    {
+        unsafe {
+            // SAFETY: upcasting to Object is always valid, and the
+            // return type is either NULL or the argument itself
+            let result: *const U =
+                object_dynamic_cast(self.unsafe_cast::<Object>().as_mut_ptr(), U::TYPE.as_ptr())
+                    .cast();
+
+            result.as_ref()
+        }
+    }
+
+    /// Unconditional cast to an arbitrary QOM type.
+    ///
+    /// # Safety
+    ///
+    /// What safety? You need to know yourself that the cast is correct; only use
+    /// when performance is paramount.  It is still better than a raw pointer
+    /// `cast()`, which does not even check that you remain in the realm of
+    /// QOM `ObjectType`s.
+    ///
+    /// `unsafe_cast::<Object>()` can also be used, and is always safe, if all
+    /// you have is an `ObjectType` (as opposed to an `IsA<Object>`).
+    unsafe fn unsafe_cast<'a, U: ObjectType>(self) -> &'a U
+    where
+        Self: 'a,
+    {
+        &*(self.as_ptr().cast::<U>())
+    }
+}
+
+impl<T: ObjectType> ObjectCast for &T {}
+
+/// An owned reference to a QOM object.
+///
+/// Like [`std::sync::Arc`], references are added with [`Clone::clone`] and removed
+/// by dropping the `Owned`.
+#[derive(PartialEq, Eq, Hash, PartialOrd, Ord)]
+pub struct Owned<T: ObjectType>(NonNull<T>);
+
+// QOM knows how to handle reference counting across threads, but sending
+// the Owned to another thread requires the implementation itself to be
+// thread-safe (aka Sync).  But I'm not entirely sure that this is enough
+// (see for example ARef in rust/kernel/types.rs, which is very similar
+// to this type).
+//
+//unsafe impl<T: Sync + ObjectType> Send for Owned<T> {}
+//unsafe impl<T: ObjectType> Sync for Owned<T> {}
+
+impl<T: ObjectType> Owned<T> {
+    /// Obtain a reference from a raw C pointer
+    ///
+    /// # Safety
+    ///
+    /// Typically this function will only be used by low level bindings
+    /// to C APIs.
+    pub unsafe fn from_raw(ptr: *const T) -> Self {
+        // SAFETY NOTE: while NonNull requires a mutable pointer,
+        // only Deref is implemented so the pointer passed to from_raw
+        // remains const
+        Owned(NonNull::new_unchecked(ptr.cast_mut()))
+    }
+
+    /// Obtain a raw C pointer from a reference.  `src` is consumed
+    /// and the reference is leaked.
+    pub fn into_raw(src: Owned<T>) -> *const T {
+        let src = ManuallyDrop::new(src);
+        src.0.as_ptr()
+    }
+
+
+    /// Increase the reference count of a QOM object and return
+    ///
+    /// # Safety
+    ///
+    /// Unsafe because the object could be embedded in another.  To
+    /// obtain an `Owned` safely, use `ObjectType::new()`.
+    pub unsafe fn from(obj: &T) -> Self {
+        object_ref(obj.unsafe_cast::<Object>().as_mut_ptr());
+
+        // SAFETY NOTE: while NonNull requires a mutable pointer,
+        // only Deref is implemented so the pointer passed to from_raw
+        // remains const
+        Owned(NonNull::new_unchecked(obj.as_mut_ptr()))
+    }
+
+    /// Perform a cast to a superclass
+    pub fn upcast<U: ObjectType>(src: Owned<T>) -> Owned<U>
+    where
+        T: IsA<U>,
+    {
+        // SAFETY: soundness is declared via IsA<U>, which is an unsafe trait
+        unsafe { Owned::unsafe_cast::<U>(src) }
+    }
+
+    /// Perform a cast to a subclass.  Checks at compile time that the
+    /// cast can succeed, but the final verification will happen at
+    /// runtime only.
+    pub fn downcast<U: IsA<T>>(src: Owned<T>) -> Result<Owned<U>, Owned<T>> {
+        Owned::dynamic_cast::<U>(src)
+    }
+
+    /// Perform a cast between QOM types.  The check that U is indeed
+    /// the dynamic type of `self` happens at runtime.
+    pub fn dynamic_cast<U: ObjectType>(src: Owned<T>) -> Result<Owned<U>, Owned<T>> {
+        // override automatic drop to skip the unref/ref
+        let src = ManuallyDrop::new(src);
+        match src.dynamic_cast::<U>() {
+            // get the ownership back from the ManuallyDrop<>
+            None => Err(ManuallyDrop::into_inner(src)),
+
+            // SAFETY: the ref is moved (thanks to ManuallyDrop) from
+            // self to casted_ref
+            Some(casted_ref) => Ok(unsafe { Owned::<U>::from_raw(casted_ref) }),
+        }
+    }
+
+    /// Unconditional cast to an arbitrary QOM type.
+    ///
+    /// # Safety
+    ///
+    /// What safety? You need to know yourself that the cast is correct.  Only use
+    /// when performance is paramount
+    pub unsafe fn unsafe_cast<U: ObjectType>(src: Owned<T>) -> Owned<U> {
+        // override automatic drop to skip the unref/ref
+        let src = ManuallyDrop::new(src);
+        let casted_ref = src.unsafe_cast::<U>();
+        Owned::<U>::from_raw(casted_ref)
+    }
+}
+
+impl<T: ObjectType> AsRef<T> for Owned<T> {
+    fn as_ref(&self) -> &T {
+        self.deref()
+    }
+}
+
+impl<T: ObjectType> Borrow<T> for Owned<T> {
+    fn borrow(&self) -> &T {
+        self.deref()
+    }
+}
+
+impl<T: ObjectType> Clone for Owned<T> {
+    fn clone(&self) -> Self {
+        // SAFETY: creation method is unsafe, and whoever calls it
+        // has responsibility that the pointer is valid
+        unsafe { Owned::from(self.deref()) }
+    }
+}
+
+impl<T: ObjectType> Deref for Owned<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: creation method is unsafe, and whoever calls it
+        // has responsibility that the pointer has a static lifetime.
+        // Once that is guaranteed, reference counting ensures that
+        // the object remains alive.
+        unsafe { &*self.0.as_ptr() }
+    }
+}
+
+impl<T: ObjectType> Drop for Owned<T> {
+    fn drop(&mut self) {
+        // SAFETY: creation method is unsafe, and whoever calls it
+        // has responsibility that the pointer is valid
+        unsafe {
+            object_unref(self.unsafe_cast::<Object>().as_mut_ptr());
+        }
+    }
+}
-- 
2.45.2


