Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84862D3B7EC
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 08:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFU6T-0004uY-L7; Mon, 25 Nov 2024 03:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFU6L-0004sf-U6
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:05:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFU6F-0007Lj-D7
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:05:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732521934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z1jI5qwsUNqYvHHAVfyTEysqObilmnJhAcwQxA2HPEU=;
 b=XUjL0rWFnNektdlPHWYwRsOuEK4cKvwhtDDahb0SR0WY6j+ElA/aQJB/nCNQeiXlGNwoAX
 kDkl6CtQRZD2D9P1fU+Ysnwz8QZhdnET+PzOBiUou7hXyktvK1xzwEmCo1zM3l1fXbdD2c
 IH7Zqcs3i2PIwrJtp5/Gpsy3oqItOuI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-YCDJR5fONqySVcSeX_iXCA-1; Mon, 25 Nov 2024 03:05:33 -0500
X-MC-Unique: YCDJR5fONqySVcSeX_iXCA-1
X-Mimecast-MFC-AGG-ID: YCDJR5fONqySVcSeX_iXCA
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43499388faaso9785695e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 00:05:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732521931; x=1733126731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z1jI5qwsUNqYvHHAVfyTEysqObilmnJhAcwQxA2HPEU=;
 b=t5XvWTnfOCUt+xy1pUmkB56nLFbprJIQvs5xQcYTF8LXSlffzXyeUuTLV+f4gpMP37
 pL1SPIfJmJbVNGWzxZDC13Cl6aecOc1pB0HmwwLAQIbsXWGTmVFzr/fjxi83cfL6uDCa
 b8yUZQsHe7OKM15Pymgdr9XTYsOTpR7MIaDhFgeobq2Tk9Xi7oTdGlWyTkpNzaJ/QnyY
 ZOTioel/XrVZFWV8OPLQ/Z7y/nRxYX3LN4pZOCkDRSAbJEc/4zlNxm10DqHDxGWANObn
 LOy9Pfld0spoHjhsKs2/4DcNX3dWvm0+AFbi6Ac4Kgz4h6JIZBo8zWCAXTjI9V3KdZun
 WA5w==
X-Gm-Message-State: AOJu0YzS35jU/rJWps0NsGVJ+qA/RrVMXuTp8iqvP8wo1TBW6qOZqHVG
 oTPpDlupPKRojl2tlv3pQUqagtgZpjJDhs7izTwWwXO87IItBFJJQrJYWQSUdQtIzyPnR2sorwR
 beCz5HXsno8P4zGnohJNwocVKwxomO6pJGG73wAQY+kQ/qAq+pAdiwPLA229ZaSpsoFa/ZjS474
 ARhzvbL/mpIxPiFcl7irreIIsM6dRzwZ+lVJoI
X-Gm-Gg: ASbGncuvhGsuquAjuHfuVZMfyBssyrPvOG/6V9hNn6MVUvek0mLoqt0fpzq/U5Mr++M
 7BGZuTv+3VJhP4oAawYLxfw+aT13qk1dMeeHt8VMBpkpahikosKB/e6DLvlPN7fZZZkHLemn4Of
 UFIYQZlQpfXwBbVyUyFeXHzreEmOVRCUV+lhTq1Xl3PpMxJAMKYoXvHok2K8930UkldH9SH9WAv
 wtMNiNt1ANcnUCl9vE/nfbuWcqXCJ61PwvqcaeN+UHO+0q/B83mGDI=
X-Received: by 2002:a05:600c:3b08:b0:426:5e91:3920 with SMTP id
 5b1f17b1804b1-433ce4e9d8emr96978415e9.29.1732521931135; 
 Mon, 25 Nov 2024 00:05:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUCAmD2lWimxDZqMtrhgQNdPh6ETlm00iNBGKIMmjBARDD9AzUJXk0guOTS38HePIIzum8+w==
X-Received: by 2002:a05:600c:3b08:b0:426:5e91:3920 with SMTP id
 5b1f17b1804b1-433ce4e9d8emr96978165e9.29.1732521930697; 
 Mon, 25 Nov 2024 00:05:30 -0800 (PST)
Received: from [192.168.10.47] ([151.49.236.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4349cc29406sm53524305e9.0.2024.11.25.00.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 00:05:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 8/8] rust: qom: move bridge for TypeInfo functions out of pl011
Date: Mon, 25 Nov 2024 09:05:07 +0100
Message-ID: <20241125080507.115450-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125080507.115450-1-pbonzini@redhat.com>
References: <20241125080507.115450-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

Allow the ObjectImpl trait to expose Rust functions that avoid raw
pointers (though INSTANCE_INIT for example is still unsafe).
ObjectImpl::TYPE_INFO adds thunks around the functions in
ObjectImpl.

While at it, document `TypeInfo`.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 40 +++++++---------------
 rust/qemu-api/src/definitions.rs | 57 +++++++++++++++++++++++++++++---
 2 files changed, 65 insertions(+), 32 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index aeccce5186c..08f7faf00d3 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -110,7 +110,7 @@ impl ObjectImpl for PL011State {
     type Class = PL011Class;
     const TYPE_NAME: &'static CStr = crate::TYPE_PL011;
     const PARENT_TYPE_NAME: Option<&'static CStr> = Some(TYPE_SYS_BUS_DEVICE);
-    const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = Some(pl011_init);
+    const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
 }
 
 #[repr(C)]
@@ -615,19 +615,6 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
     }
 }
 
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer, that has
-/// the same size as [`PL011State`]. We also expect the device is
-/// readable/writeable from one thread at any time.
-pub unsafe extern "C" fn pl011_init(obj: *mut Object) {
-    unsafe {
-        debug_assert!(!obj.is_null());
-        let mut state = NonNull::new_unchecked(obj.cast::<PL011State>());
-        state.as_mut().init();
-    }
-}
-
 #[repr(C)]
 #[derive(Debug, qemu_api_macros::Object)]
 /// PL011 Luminary device model.
@@ -640,19 +627,16 @@ pub struct PL011LuminaryClass {
     _inner: [u8; 0],
 }
 
-/// Initializes a pre-allocated, unitialized instance of `PL011Luminary`.
-///
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer, that has
-/// the same size as [`PL011Luminary`]. We also expect the device is
-/// readable/writeable from one thread at any time.
-pub unsafe extern "C" fn pl011_luminary_init(obj: *mut Object) {
-    unsafe {
-        debug_assert!(!obj.is_null());
-        let mut state = NonNull::new_unchecked(obj.cast::<PL011Luminary>());
-        let state = state.as_mut();
-        state.parent_obj.device_id = DeviceId::Luminary;
+impl PL011Luminary {
+    /// Initializes a pre-allocated, unitialized instance of `PL011Luminary`.
+    ///
+    /// # Safety
+    ///
+    /// We expect the FFI user of this function to pass a valid pointer, that
+    /// has the same size as [`PL011Luminary`]. We also expect the device is
+    /// readable/writeable from one thread at any time.
+    unsafe fn init(&mut self) {
+        self.parent_obj.device_id = DeviceId::Luminary;
     }
 }
 
@@ -660,7 +644,7 @@ impl ObjectImpl for PL011Luminary {
     type Class = PL011LuminaryClass;
     const TYPE_NAME: &'static CStr = crate::TYPE_PL011_LUMINARY;
     const PARENT_TYPE_NAME: Option<&'static CStr> = Some(crate::TYPE_PL011);
-    const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = Some(pl011_luminary_init);
+    const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
 }
 
 impl DeviceImpl for PL011Luminary {}
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
index d64a581a5cc..b20c53f6ce6 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -8,6 +8,20 @@
 
 use crate::bindings::{Object, ObjectClass, TypeInfo};
 
+unsafe extern "C" fn rust_instance_init<T: ObjectImpl>(obj: *mut Object) {
+    // SAFETY: obj is an instance of T, since drop_object<T>
+    // is called from QOM core as the instance_finalize function
+    // for class T
+    unsafe { T::INSTANCE_INIT.unwrap()(&mut *obj.cast::<T>()) }
+}
+
+unsafe extern "C" fn rust_instance_post_init<T: ObjectImpl>(obj: *mut Object) {
+    // SAFETY: obj is an instance of T, since drop_object<T>
+    // is called from QOM core as the instance_finalize function
+    // for class T
+    T::INSTANCE_POST_INIT.unwrap()(unsafe { &mut *obj.cast::<T>() })
+}
+
 unsafe extern "C" fn drop_object<T: ObjectImpl>(obj: *mut Object) {
     // SAFETY: obj is an instance of T, since drop_object<T>
     // is called from QOM core as the instance_finalize function
@@ -16,13 +30,42 @@
 }
 
 /// Trait a type must implement to be registered with QEMU.
+///
+/// # Safety
+///
+/// - the struct must be `#[repr(C)]`
+///
+/// - `Class` and `TYPE` must match the data in the `TypeInfo` (this is
+///   automatic if the class is defined via `ObjectImpl`).
+///
+/// - the first field of the struct must be of the instance struct corresponding
+///   to the superclass declared as `PARENT_TYPE_NAME`
 pub trait ObjectImpl: ClassInitImpl + Sized {
+    /// The QOM class object corresponding to this struct.  Not used yet.
     type Class;
+
+    /// The name of the type, which can be passed to `object_new()` to
+    /// generate an instance of this type.
     const TYPE_NAME: &'static CStr;
+
+    /// The parent of the type.  This should match the first field of
+    /// the struct that implements `ObjectImpl`:
     const PARENT_TYPE_NAME: Option<&'static CStr>;
+
+    /// Whether the object can be instantiated
     const ABSTRACT: bool = false;
-    const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
-    const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
+
+    /// Function that is called to initialize an object.  The parent class will
+    /// have already been initialized so the type is only responsible for
+    /// initializing its own members.
+    ///
+    /// FIXME: The argument is not really a valid reference. `&mut
+    /// MaybeUninit<Self>` would be a better description.
+    const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = None;
+
+    /// Function that is called to finish initialization of an object, once
+    /// `INSTANCE_INIT` functions have been called.
+    const INSTANCE_POST_INIT: Option<fn(&mut Self)> = None;
 
     const TYPE_INFO: TypeInfo = TypeInfo {
         name: Self::TYPE_NAME.as_ptr(),
@@ -33,8 +76,14 @@ pub trait ObjectImpl: ClassInitImpl + Sized {
         },
         instance_size: core::mem::size_of::<Self>(),
         instance_align: core::mem::align_of::<Self>(),
-        instance_init: Self::INSTANCE_INIT,
-        instance_post_init: Self::INSTANCE_POST_INIT,
+        instance_init: match Self::INSTANCE_INIT {
+            None => None,
+            Some(_) => Some(rust_instance_init::<Self>),
+        },
+        instance_post_init: match Self::INSTANCE_POST_INIT {
+            None => None,
+            Some(_) => Some(rust_instance_post_init::<Self>),
+        },
         instance_finalize: Some(drop_object::<Self>),
         abstract_: Self::ABSTRACT,
         class_size: core::mem::size_of::<Self::Class>(),
-- 
2.47.0


