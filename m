Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73851C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 17:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlWRs-0007sz-ON; Fri, 21 Feb 2025 12:04:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRp-0007jr-IP
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:04:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRn-0001VO-N3
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740157459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kC/cNDLMmEH0ht1LPa/Se/Yyc16GMQBcm6b3VMIbeso=;
 b=Z+ulD5XSI+eNOMzYptlWidcyL+9bYvE8aqvemWjRWFiD9a/yoaxgYli1k/bXVJ/V8e/EDk
 dSE5sZOz4h6Of1Q1kVz2r8d6d+LKRPmWgpAQPqFX2X/KN6e7VvtnTeUo2gNDebiO3g1JoF
 6W00n6lnXeK4zJg9wcsveON9LZCprL8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-UZzRcB0INhKVk8Ab_QCzNg-1; Fri, 21 Feb 2025 12:04:11 -0500
X-MC-Unique: UZzRcB0INhKVk8Ab_QCzNg-1
X-Mimecast-MFC-AGG-ID: UZzRcB0INhKVk8Ab_QCzNg_1740157451
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f36f03312so1130611f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 09:04:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740157450; x=1740762250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kC/cNDLMmEH0ht1LPa/Se/Yyc16GMQBcm6b3VMIbeso=;
 b=LRcEaPxKHWBfnH3yheDXxmcrXfg3ajCH4PivSOxAZzG5xMj9Dlzxxidckqq7uhvudd
 XZw8L3R2vl5vSsjLScyazL4Zmr9UKcx+RsqWK7WERqlZpBxWRM78Bv6uU7pgbq5tizX5
 4DPU/a8eJQKF0UW0TjxpB0fHbnnWPjwT76kOYuWg7b0Lun/zgajqF8T9bda7dUDjxhAz
 r8MQq/JxOZaacZ0b493OcDZyg6RmhjruuOavEOhybBV4+e91v5orb6nYVAqz9Ef4kRJw
 dGVPa8pcucKlufE2wXYwH3NzZnSP/o4hiM1zetW8w4kdh94kmd2+qwphf9iaKosr5m43
 96NQ==
X-Gm-Message-State: AOJu0Yx1j5pEzHRulP1ezxUsJ2LB25cY8zwfcE2P2k4ZgjPRIwmRtKx9
 caKjIEjclISNIJl4ng2jjZzPBkBTkOVY9ksr2JOA5KTQ8LHBin8z9enBuaz9BwHz1LZ6uBxxY/u
 QWKQPbRz2vWWrwDMz2n9WxS3Oon69MkJCKY7paYGxbIawM5ldgaJqDnhKipju67C+a6hP2CSxSQ
 JhUrEVdpyMxnOd8ELyaA9wAqn+ivjeFe5GtxWvca0=
X-Gm-Gg: ASbGncvJi4HYpq/M4ooyCLcjemZz4m3nJLTdB174sCzeAojcad2h3w4w04d8uxdaC32
 h9iAI5w61GAtZsfFNeq/efJMkdMGwKDqX8ddC5JPexsOuD4cvF0g2X8eyvO/ylwrY6jzGj7hBrG
 EstopXOEULX2YgHkds6r63LTij5WlVvipqSfXnRfZ4i0TnJK8evvjExl6/3CFlBrPxd8S6S9Rv2
 wqggGN0GkU4zotxURpEH73hqeYiUV6RZn0qTlElXMW41cRk25JRp3GIemqLGPlaXu85CN6vEux7
 Gf8l/JXzsBvVzIhrLjw=
X-Received: by 2002:a5d:4e87:0:b0:38d:a879:4778 with SMTP id
 ffacd0b85a97d-38f6f0529bbmr3686934f8f.33.1740157450029; 
 Fri, 21 Feb 2025 09:04:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGB0ekFJz+EyjHY94kBqvTTV49d3AiJxMXN0S82AGo5gezpgP14Ud1X2XRcHXYdQ3+tgA1y1A==
X-Received: by 2002:a5d:4e87:0:b0:38d:a879:4778 with SMTP id
 ffacd0b85a97d-38f6f0529bbmr3686832f8f.33.1740157449232; 
 Fri, 21 Feb 2025 09:04:09 -0800 (PST)
Received: from [192.168.10.48] ([151.95.61.185])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b44b2sm23583955f8f.20.2025.02.21.09.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:04:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 10/15] rust: qom: wrap Object with Opaque<>
Date: Fri, 21 Feb 2025 18:03:37 +0100
Message-ID: <20250221170342.63591-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221170342.63591-1-pbonzini@redhat.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/bindings.rs |  3 ---
 rust/qemu-api/src/memory.rs   |  2 +-
 rust/qemu-api/src/qdev.rs     |  6 +++---
 rust/qemu-api/src/qom.rs      | 35 ++++++++++++++++++++++-------------
 4 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index d2868639ff6..be6dd68c09c 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -46,9 +46,6 @@ unsafe impl Sync for MemoryRegion {}
 unsafe impl Send for ObjectClass {}
 unsafe impl Sync for ObjectClass {}
 
-unsafe impl Send for Object {}
-unsafe impl Sync for Object {}
-
 unsafe impl Send for SysBusDevice {}
 unsafe impl Sync for SysBusDevice {}
 
diff --git a/rust/qemu-api/src/memory.rs b/rust/qemu-api/src/memory.rs
index 682951ab44e..713c494ca2e 100644
--- a/rust/qemu-api/src/memory.rs
+++ b/rust/qemu-api/src/memory.rs
@@ -157,7 +157,7 @@ unsafe fn do_init_io(
             let cstr = CString::new(name).unwrap();
             memory_region_init_io(
                 slot,
-                owner.cast::<Object>(),
+                owner.cast::<bindings::Object>(),
                 ops,
                 owner.cast::<c_void>(),
                 cstr.as_ptr(),
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index c136457090c..1a4d1f38762 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -52,7 +52,7 @@ pub trait ResettablePhasesImpl {
 /// can be downcasted to type `T`. We also expect the device is
 /// readable/writeable from one thread at any time.
 unsafe extern "C" fn rust_resettable_enter_fn<T: ResettablePhasesImpl>(
-    obj: *mut Object,
+    obj: *mut bindings::Object,
     typ: ResetType,
 ) {
     let state = NonNull::new(obj).unwrap().cast::<T>();
@@ -65,7 +65,7 @@ pub trait ResettablePhasesImpl {
 /// can be downcasted to type `T`. We also expect the device is
 /// readable/writeable from one thread at any time.
 unsafe extern "C" fn rust_resettable_hold_fn<T: ResettablePhasesImpl>(
-    obj: *mut Object,
+    obj: *mut bindings::Object,
     typ: ResetType,
 ) {
     let state = NonNull::new(obj).unwrap().cast::<T>();
@@ -78,7 +78,7 @@ pub trait ResettablePhasesImpl {
 /// can be downcasted to type `T`. We also expect the device is
 /// readable/writeable from one thread at any time.
 unsafe extern "C" fn rust_resettable_exit_fn<T: ResettablePhasesImpl>(
-    obj: *mut Object,
+    obj: *mut bindings::Object,
     typ: ResetType,
 ) {
     let state = NonNull::new(obj).unwrap().cast::<T>();
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 5488643a2fd..0bca36336ba 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -101,16 +101,24 @@
     ptr::NonNull,
 };
 
-pub use bindings::{Object, ObjectClass};
+pub use bindings::ObjectClass;
 
 use crate::{
     bindings::{
         self, object_class_dynamic_cast, object_dynamic_cast, object_get_class,
         object_get_typename, object_new, object_ref, object_unref, TypeInfo,
     },
-    cell::bql_locked,
+    cell::{bql_locked, Opaque},
 };
 
+/// A safe wrapper around [`bindings::Object`].
+#[repr(transparent)]
+#[derive(Debug, qemu_api_macros::Wrapper)]
+pub struct Object(Opaque<bindings::Object>);
+
+unsafe impl Send for Object {}
+unsafe impl Sync for Object {}
+
 /// Marker trait: `Self` can be statically upcasted to `P` (i.e. `P` is a direct
 /// or indirect parent of `Self`).
 ///
@@ -199,7 +207,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> Result<(), fmt::Error> {
     }
 }
 
-unsafe extern "C" fn rust_instance_init<T: ObjectImpl>(obj: *mut Object) {
+unsafe extern "C" fn rust_instance_init<T: ObjectImpl>(obj: *mut bindings::Object) {
     let mut state = NonNull::new(obj).unwrap().cast::<T>();
     // SAFETY: obj is an instance of T, since rust_instance_init<T>
     // is called from QOM core as the instance_init function
@@ -209,7 +217,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> Result<(), fmt::Error> {
     }
 }
 
-unsafe extern "C" fn rust_instance_post_init<T: ObjectImpl>(obj: *mut Object) {
+unsafe extern "C" fn rust_instance_post_init<T: ObjectImpl>(obj: *mut bindings::Object) {
     let state = NonNull::new(obj).unwrap().cast::<T>();
     // SAFETY: obj is an instance of T, since rust_instance_post_init<T>
     // is called from QOM core as the instance_post_init function
@@ -230,7 +238,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> Result<(), fmt::Error> {
     <T as ObjectImpl>::CLASS_INIT(unsafe { klass.as_mut() })
 }
 
-unsafe extern "C" fn drop_object<T: ObjectImpl>(obj: *mut Object) {
+unsafe extern "C" fn drop_object<T: ObjectImpl>(obj: *mut bindings::Object) {
     // SAFETY: obj is an instance of T, since drop_object<T> is called
     // from the QOM core function object_deinit() as the instance_finalize
     // function for class T.  Note that while object_deinit() will drop the
@@ -280,14 +288,14 @@ pub unsafe trait ObjectType: Sized {
     /// Return the receiver as an Object.  This is always safe, even
     /// if this type represents an interface.
     fn as_object(&self) -> &Object {
-        unsafe { &*self.as_object_ptr() }
+        unsafe { &*self.as_ptr().cast() }
     }
 
     /// Return the receiver as a const raw pointer to Object.
     /// This is preferrable to `as_object_mut_ptr()` if a C
     /// function only needs a `const Object *`.
-    fn as_object_ptr(&self) -> *const Object {
-        self.as_ptr().cast()
+    fn as_object_ptr(&self) -> *const bindings::Object {
+        self.as_object().as_ptr()
     }
 
     /// Return the receiver as a mutable raw pointer to Object.
@@ -297,8 +305,8 @@ fn as_object_ptr(&self) -> *const Object {
     /// This cast is always safe, but because the result is mutable
     /// and the incoming reference is not, this should only be used
     /// for calls to C functions, and only if needed.
-    unsafe fn as_object_mut_ptr(&self) -> *mut Object {
-        self.as_object_ptr() as *mut _
+    unsafe fn as_object_mut_ptr(&self) -> *mut bindings::Object {
+        self.as_object().as_mut_ptr()
     }
 }
 
@@ -621,7 +629,7 @@ pub trait ObjectImpl: ObjectType + IsA<Object> {
 /// We expect the FFI user of this function to pass a valid pointer that
 /// can be downcasted to type `T`. We also expect the device is
 /// readable/writeable from one thread at any time.
-unsafe extern "C" fn rust_unparent_fn<T: ObjectImpl>(dev: *mut Object) {
+unsafe extern "C" fn rust_unparent_fn<T: ObjectImpl>(dev: *mut bindings::Object) {
     let state = NonNull::new(dev).unwrap().cast::<T>();
     T::UNPARENT.unwrap()(unsafe { state.as_ref() });
 }
@@ -796,8 +804,9 @@ fn new() -> Owned<Self> {
         // SAFETY: the object created by object_new is allocated on
         // the heap and has a reference count of 1
         unsafe {
-            let obj = &*object_new(Self::TYPE_NAME.as_ptr());
-            Owned::from_raw(obj.unsafe_cast::<Self>())
+            let obj = object_new(Self::TYPE_NAME.as_ptr());
+            let obj = Object::from_raw(obj).unsafe_cast::<Self>();
+            Owned::from_raw(obj)
         }
     }
 }
-- 
2.48.1


