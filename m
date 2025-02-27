Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA0AC19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tneoD-0006gP-1w; Thu, 27 Feb 2025 09:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnemh-0003t5-CT
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:22:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnemf-00047c-0j
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tXHZ7ahE0SuDjTAp4gMKpg+0aMsCMDD4X5FjTPi4lj4=;
 b=V1VlqHXcsqUEgl4q5+CkWsZKQcR+SFgUIeJEM84JUIreNB9fNFrpYy+VQZb4X79/jOwLap
 0FcqR468zMa+3kD5spH10vFmAIKch8UqV2tlQUJkWcNehQsffyCHwDSIy10GFUg9r2GB14
 HpY8uIwlga9BEo62x+RG5rGQsh64/9A=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-EYidEQP2PiyUowx354ZfDw-1; Thu, 27 Feb 2025 09:22:38 -0500
X-MC-Unique: EYidEQP2PiyUowx354ZfDw-1
X-Mimecast-MFC-AGG-ID: EYidEQP2PiyUowx354ZfDw_1740666156
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-abb7e837a7aso112977566b.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:22:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666155; x=1741270955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tXHZ7ahE0SuDjTAp4gMKpg+0aMsCMDD4X5FjTPi4lj4=;
 b=wEqyZYXL2dZ6D+WLb/yoRKnnhnuTiLolaLssP4fIFPeyqU+qfRPkEtq57dAbGhTg5a
 mFqKgNAWLcJKLAuzCgOdoR7RPngG18jXDdd6bkwwn27UB2HKwkJ4Wxv8H+e8JQc3C3nA
 sn3zjl2H6xMQDQHhlkdzqPDTAS3Hy5CVFAXNNDk8XrZjANvgy+oz1tQyNO1ZWhRNCdJA
 TZqK0W6PG3DXR5OURVwV5d0kygtB+w+7Vs5VvSkZd4VsU9irZlmkYY09Jz4jMlObl5+i
 b/Xe/OnnymJ3st7EXpiwOFeX9ccXWEBMCgcgvfMdPhv3GPIoluDoMSsX9DY+uw3xPRJ9
 OnaA==
X-Gm-Message-State: AOJu0YzLHwbIUph9WVD0IfI+13+yIgBdo8542VAkR4mE4KrBws2EWUTf
 4uCCeGHTd0sCuQ2SRMSQyLUaCSrqj+IkbSsibBB7xm7tpoj6LPo/yr+tjoSSJeX5vuefQ/qtcY/
 IfPGTcR6Ug/pTyGoWhQxDuwVix/uB6dO6JdIqCu1p/GzVFzOyIPkSXt+pj6Cxo+xr6G0HXYGJ5B
 ZPN7yoFnPKL9Z2RSSRTx4S62tugI8SSyu0VeSRdh0=
X-Gm-Gg: ASbGncsryex07mTqkr/5tBPoeTled1qrnO7YnlXQFvr5DRvPuevgBHH1MI1Tg9fVSHn
 P/5F2Oz237aWH0eu/qmz1M8la603/jgNpWGbVW74K3GFm+xfS1coLPe/MkP+fWxQBZcxt5NA5U7
 WZ3UPHcuPJJn70NSVbuXZ69hSL2Ql/QBTki5SJo5q9Xx36OE41fv8dI7mpXna1x3eNCyss3ziuD
 iR69VYAHirZkE9OPeceDsYi90z7HK6dlPFRVS4XBPcWexnB6pSImOego343Vm6vigF9ImJrexaV
 ZjQ7qSbtMuPzX+NQrEAB
X-Received: by 2002:a17:907:96a5:b0:ab7:fbb2:b47c with SMTP id
 a640c23a62f3a-abc09c1a51dmr3073941166b.35.1740666154847; 
 Thu, 27 Feb 2025 06:22:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8W9WmasNs4OKJbm4Y1M3y+D2krJAGkB7w6y4aLrIrrp8CdNeeKERQYmZcCAQRy1rDqxjJqQ==
X-Received: by 2002:a17:907:96a5:b0:ab7:fbb2:b47c with SMTP id
 a640c23a62f3a-abc09c1a51dmr3073937366b.35.1740666154343; 
 Thu, 27 Feb 2025 06:22:34 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c7c07d3sm128139866b.180.2025.02.27.06.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:22:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 06/12] rust: qom: wrap Object with Opaque<>
Date: Thu, 27 Feb 2025 15:22:13 +0100
Message-ID: <20250227142219.812270-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227142219.812270-1-pbonzini@redhat.com>
References: <20250227142219.812270-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
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
index 5488643a2fd..2defbd23516 100644
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
+            let raw_obj = object_new(Self::TYPE_NAME.as_ptr());
+            let obj = Object::from_raw(raw_obj).unsafe_cast::<Self>();
+            Owned::from_raw(obj)
         }
     }
 }
-- 
2.48.1


