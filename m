Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBF0C021A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibey-0000yO-4K; Thu, 13 Feb 2025 11:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibeO-0000pM-89
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibeH-0005QB-AZ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JDXDdyrYu8aqHcWMZRgkJHUGkK2ZXNisxDcxlPZPe2o=;
 b=BAzJLnBhgKGQa/1LuvWU3i8rtscGkgrJEO7QCjTNif0je/0amUOflPV23jQ6XubPro4vL5
 h1/CaoOYxyCMFQltE336sWmWlG3yOnwPcjtXY5N5niLqvpS4jjjXi2lBsp8WJeqJTvuqGJ
 o2WYR7Kt6WMJOuXZgVPq+9uiSoMhDUg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-Ej5S0OsBPlOBgsZQd1dktA-1; Thu, 13 Feb 2025 11:01:06 -0500
X-MC-Unique: Ej5S0OsBPlOBgsZQd1dktA-1
X-Mimecast-MFC-AGG-ID: Ej5S0OsBPlOBgsZQd1dktA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43941ad86d4so8423055e9.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462464; x=1740067264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JDXDdyrYu8aqHcWMZRgkJHUGkK2ZXNisxDcxlPZPe2o=;
 b=N3TxvArPe+fyTyFanreowuZXmAr6ye0zUlCcC95FQqyRNPktGhrqwlAecOaIzf+1Z8
 sQ0cLvjEH2uTdQN0fdeW2BI7tHH1yeFThfAvD5G0MjR01cN70R7PRRNdZKbPGBiOf9Nh
 HYmL/Img45BeUAZZdERvJeMLxulOOWzxsRH1SOcrrSAC1FqHQLo1O168gCn4avAfh39R
 JVyLJh5e3O4H7ji5CEyo0shjNMj744+dtI1ElXetGuj0k+CwfdwKouBcDop28Jb4iy44
 e8vwa7x+0OKnR2on64nryvAYleQNKNUW60HUkHxzpVa2btbVF3MCjSNbFeLXqW4muieU
 WwSQ==
X-Gm-Message-State: AOJu0YxDVv84hfO/0UAeMUBC3T0TRkGcvnUiNZmtLolZkYh3xtulceGO
 AbPtnNJblHv8ZzBNRoEp9yhrKpeNGAnDXcecQXtSRqqAZbw8ZugYnHcAtF58T2NqU7Inlp63DaQ
 2DgpsDynp7kOkOqTnaBc4cxL7CzZvUVpIxduTpv1OgNKTDcb5RnLGv80jl2jwzorUd6/Pxxi4k6
 XlV1taj5uX2qui4bHyaZOB1+eo9feEuoHDyGpTuM0=
X-Gm-Gg: ASbGncsj7t5MaRwAs6Ax4dCRALMh8Ka1aulYFu1DMfnre6FGBwZ2k7kPEMl2zQpDA9t
 zpirpNK/6caKhS7WTpvSOTOZLE0hLxpLjMjvzo5UulRGKlgHbNO2n94Y+TOo/64DMdC1EgxS58q
 +6ZgYi5a+GI0DN9G+onEf+gfkl+oxFemSpzlbCss7fQdkY6oUkCsbHMEBm16lEPiE0WAhNwLnbj
 7XRrhLsLpF7l37oAo+F89UP6gEcPFkSotzp4dZdhqsEVfj36NMp+FKkPNg6BFbbGAJLvqCslExE
 9daw8RQn1dbEyH2hSKJlJj3XKKbRzn8e1NAv8GiD4RFo9w==
X-Received: by 2002:a05:600c:3d86:b0:439:61cd:4fc0 with SMTP id
 5b1f17b1804b1-43961cd5298mr33511495e9.24.1739462462661; 
 Thu, 13 Feb 2025 08:01:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1ICZNqoM/P1kZwMj/1G6bY681Fn1W5wEmVRPxCx1xxpyfCFbfvEla+EjI3eVBVTH+Dh+05w==
X-Received: by 2002:a05:600c:3d86:b0:439:61cd:4fc0 with SMTP id
 5b1f17b1804b1-43961cd5298mr33510335e9.24.1739462461482; 
 Thu, 13 Feb 2025 08:01:01 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a04ee48sm53074745e9.3.2025.02.13.08.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:01:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 02/27] rust: qom: add reference counting functionality
Date: Thu, 13 Feb 2025 17:00:29 +0100
Message-ID: <20250213160054.3937012-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213160054.3937012-1-pbonzini@redhat.com>
References: <20250213160054.3937012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Add a smart pointer that allows to add and remove references from
QOM objects.  It's important to note that while all QOM objects have a
reference count, in practice not all of them have their lifetime guarded
by it.  Embedded objects, specifically, are confined to the lifetime of
the owner.

When writing Rust bindings this is important, because embedded objects are
*never* used through the "Owned<>" smart pointer that is introduced here.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/qom.rs     | 166 +++++++++++++++++++++++++++++++++--
 rust/qemu-api/src/vmstate.rs |   6 +-
 rust/qemu-api/tests/tests.rs |  13 ++-
 3 files changed, 178 insertions(+), 7 deletions(-)

diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index f50ee371aac..404446d57fc 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -56,6 +56,7 @@
 use std::{
     ffi::CStr,
     fmt,
+    mem::ManuallyDrop,
     ops::{Deref, DerefMut},
     os::raw::c_void,
     ptr::NonNull,
@@ -63,7 +64,13 @@
 
 pub use bindings::{Object, ObjectClass};
 
-use crate::bindings::{self, object_dynamic_cast, object_get_class, object_get_typename, TypeInfo};
+use crate::{
+    bindings::{
+        self, object_dynamic_cast, object_get_class, object_get_typename, object_ref, object_unref,
+        TypeInfo,
+    },
+    cell::bql_locked,
+};
 
 /// Marker trait: `Self` can be statically upcasted to `P` (i.e. `P` is a direct
 /// or indirect parent of `Self`).
@@ -280,10 +287,10 @@ fn as_ptr<U: ObjectType>(&self) -> *const U
     ///
     /// # Safety
     ///
-    /// This method is unsafe because it overrides const-ness of `&self`.
-    /// Bindings to C APIs will use it a lot, but otherwise it should not
-    /// be necessary.
-    unsafe fn as_mut_ptr<U: ObjectType>(&self) -> *mut U
+    /// This method is safe because only the actual dereference of the pointer
+    /// has to be unsafe.  Bindings to C APIs will use it a lot, but care has
+    /// to be taken because it overrides the const-ness of `&self`.
+    fn as_mut_ptr<U: ObjectType>(&self) -> *mut U
     where
         Self::Target: IsA<U>,
     {
@@ -610,6 +617,148 @@ unsafe impl ObjectType for Object {
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_OBJECT) };
 }
 
+/// A reference-counted pointer to a QOM object.
+///
+/// `Owned<T>` wraps `T` with automatic reference counting.  It increases the
+/// reference count when created via [`Owned::from`] or cloned, and decreases
+/// it when dropped.  This ensures that the reference count remains elevated
+/// as long as any `Owned<T>` references to it exist.
+///
+/// `Owned<T>` can be used for two reasons:
+/// * because the lifetime of the QOM object is unknown and someone else could
+///   take a reference (similar to `Arc<T>`, for example): in this case, the
+///   object can escape and outlive the Rust struct that contains the `Owned<T>`
+///   field;
+///
+/// * to ensure that the object stays alive until after `Drop::drop` is called
+///   on the Rust struct: in this case, the object will always die together with
+///   the Rust struct that contains the `Owned<T>` field.
+///
+/// Child properties are an example of the second case: in C, an object that
+/// is created with `object_initialize_child` will die *before*
+/// `instance_finalize` is called, whereas Rust expects the struct to have valid
+/// contents when `Drop::drop` is called.  Therefore Rust structs that have
+/// child properties need to keep a reference to the child object.  Right now
+/// this can be done with `Owned<T>`; in the future one might have a separate
+/// `Child<'parent, T>` smart pointer that keeps a reference to a `T`, like
+/// `Owned`, but does not allow cloning.
+///
+/// Note that dropping an `Owned<T>` requires the big QEMU lock to be taken.
+#[repr(transparent)]
+#[derive(PartialEq, Eq, Hash, PartialOrd, Ord)]
+pub struct Owned<T: ObjectType>(NonNull<T>);
+
+// The following rationale for safety is taken from Linux's kernel::sync::Arc.
+
+// SAFETY: It is safe to send `Owned<T>` to another thread when the underlying
+// `T` is `Sync` because it effectively means sharing `&T` (which is safe
+// because `T` is `Sync`); additionally, it needs `T` to be `Send` because any
+// thread that has an `Owned<T>` may ultimately access `T` using a
+// mutable reference when the reference count reaches zero and `T` is dropped.
+unsafe impl<T: ObjectType + Send + Sync> Send for Owned<T> {}
+
+// SAFETY: It is safe to send `&Owned<T>` to another thread when the underlying
+// `T` is `Sync` because it effectively means sharing `&T` (which is safe
+// because `T` is `Sync`); additionally, it needs `T` to be `Send` because any
+// thread that has a `&Owned<T>` may clone it and get an `Owned<T>` on that
+// thread, so the thread may ultimately access `T` using a mutable reference
+// when the reference count reaches zero and `T` is dropped.
+unsafe impl<T: ObjectType + Sync + Send> Sync for Owned<T> {}
+
+impl<T: ObjectType> Owned<T> {
+    /// Convert a raw C pointer into an owned reference to the QOM
+    /// object it points to.  The object's reference count will be
+    /// decreased when the `Owned` is dropped.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `ptr` is NULL.
+    ///
+    /// # Safety
+    ///
+    /// The caller must indeed own a reference to the QOM object.
+    /// The object must not be embedded in another unless the outer
+    /// object is guaranteed to have a longer lifetime.
+    ///
+    /// A raw pointer obtained via [`Owned::into_raw()`] can always be passed
+    /// back to `from_raw()` (assuming the original `Owned` was valid!),
+    /// since the owned reference remains there between the calls to
+    /// `into_raw()` and `from_raw()`.
+    pub unsafe fn from_raw(ptr: *const T) -> Self {
+        // SAFETY NOTE: while NonNull requires a mutable pointer, only
+        // Deref is implemented so the pointer passed to from_raw
+        // remains const
+        Owned(NonNull::new(ptr as *mut T).unwrap())
+    }
+
+    /// Obtain a raw C pointer from a reference.  `src` is consumed
+    /// and the reference is leaked.
+    #[allow(clippy::missing_const_for_fn)]
+    pub fn into_raw(src: Owned<T>) -> *mut T {
+        let src = ManuallyDrop::new(src);
+        src.0.as_ptr()
+    }
+
+    /// Increase the reference count of a QOM object and return
+    /// a new owned reference to it.
+    ///
+    /// # Safety
+    ///
+    /// The object must not be embedded in another, unless the outer
+    /// object is guaranteed to have a longer lifetime.
+    pub unsafe fn from(obj: &T) -> Self {
+        unsafe {
+            object_ref(obj.as_object_mut_ptr().cast::<c_void>());
+
+            // SAFETY NOTE: while NonNull requires a mutable pointer, only
+            // Deref is implemented so the reference passed to from_raw
+            // remains shared
+            Owned(NonNull::new_unchecked(obj.as_mut_ptr()))
+        }
+    }
+}
+
+impl<T: ObjectType> Clone for Owned<T> {
+    fn clone(&self) -> Self {
+        // SAFETY: creation method is unsafe; whoever calls it has
+        // responsibility that the pointer is valid, and remains valid
+        // throughout the lifetime of the `Owned<T>` and its clones.
+        unsafe { Owned::from(self.deref()) }
+    }
+}
+
+impl<T: ObjectType> Deref for Owned<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: creation method is unsafe; whoever calls it has
+        // responsibility that the pointer is valid, and remains valid
+        // throughout the lifetime of the `Owned<T>` and its clones.
+        // With that guarantee, reference counting ensures that
+        // the object remains alive.
+        unsafe { &*self.0.as_ptr() }
+    }
+}
+impl<T: ObjectType> ObjectDeref for Owned<T> {}
+
+impl<T: ObjectType> Drop for Owned<T> {
+    fn drop(&mut self) {
+        assert!(bql_locked());
+        // SAFETY: creation method is unsafe, and whoever calls it has
+        // responsibility that the pointer is valid, and remains valid
+        // throughout the lifetime of the `Owned<T>` and its clones.
+        unsafe {
+            object_unref(self.as_object_mut_ptr().cast::<c_void>());
+        }
+    }
+}
+
+impl<T: IsA<Object>> fmt::Debug for Owned<T> {
+    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
+        self.deref().debug_fmt(f)
+    }
+}
+
 /// Trait for methods exposed by the Object class.  The methods can be
 /// called on all objects that have the trait `IsA<Object>`.
 ///
@@ -641,6 +790,13 @@ fn get_class(&self) -> &'static <Self::Target as ObjectType>::Class {
 
         klass
     }
+
+    /// Convenience function for implementing the Debug trait
+    fn debug_fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
+        f.debug_tuple(&self.typename())
+            .field(&(self as *const Self))
+            .finish()
+    }
 }
 
 impl<R: ObjectDeref> ObjectMethods for R where R::Target: IsA<Object> {}
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 6ac432cf52f..11d21b8791c 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -29,6 +29,8 @@
 pub use crate::bindings::{VMStateDescription, VMStateField};
 use crate::{
     bindings::{self, VMStateFlags},
+    prelude::*,
+    qom::Owned,
     zeroable::Zeroable,
 };
 
@@ -191,7 +193,8 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateFlags
 /// * a transparent wrapper for any of the above (`Cell`, `UnsafeCell`,
 ///   [`BqlCell`](crate::cell::BqlCell), [`BqlRefCell`](crate::cell::BqlRefCell)
 /// * a raw pointer to any of the above
-/// * a `NonNull` pointer or a `Box` for any of the above
+/// * a `NonNull` pointer, a `Box` or an [`Owned`](crate::qom::Owned) for any of
+///   the above
 /// * an array of any of the above
 ///
 /// In order to support other types, the trait `VMState` must be implemented
@@ -398,6 +401,7 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
 // Unlike C pointers, Box is always non-null therefore there is no need
 // to specify VMS_ALLOC.
 impl_vmstate_pointer!(Box<T> where T: VMState);
+impl_vmstate_pointer!(Owned<T> where T: VMState + ObjectType);
 
 // Arrays using the underlying type's VMState plus
 // VMS_ARRAY/VMS_ARRAY_OF_POINTER
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 5c3e75ed3d5..5f6096a572e 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -15,7 +15,7 @@
     declare_properties, define_property,
     prelude::*,
     qdev::{DeviceClass, DeviceImpl, DeviceState, Property},
-    qom::{ClassInitImpl, ObjectImpl, ParentField},
+    qom::{ClassInitImpl, ObjectImpl, Owned, ParentField},
     vmstate::VMStateDescription,
     zeroable::Zeroable,
 };
@@ -138,6 +138,17 @@ fn test_object_new() {
     }
 }
 
+#[test]
+#[allow(clippy::redundant_clone)]
+/// Create, clone and then drop an instance.
+fn test_clone() {
+    init_qom();
+    let p: *mut DummyState = unsafe { object_new(DummyState::TYPE_NAME.as_ptr()).cast() };
+    let p = unsafe { Owned::from_raw(p) };
+    assert_eq!(p.clone().typename(), "dummy");
+    drop(p);
+}
+
 #[test]
 /// Try invoking a method on an object.
 fn test_typename() {
-- 
2.48.1


