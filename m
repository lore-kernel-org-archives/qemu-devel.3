Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519FEC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 19:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYsCo-0001Xz-64; Fri, 17 Jan 2025 14:40:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYsCY-0001WI-U1
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:40:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYsCX-0002By-7N
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737142816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZfIMapRdAVK5cr8WH2cqZZ26cbMwLQZzS74QVu30oqU=;
 b=Mvu9r7f/GQPBUiOCvXWDC/5kZBuSYOFR2YAotJjtwNLQbLGk8TPv6d2nBdU9SrHdL08x1R
 SLpLjqq8NDSEliYnPZY+ffajd4dbkzcGLPpH9aLTLUx7CMEym8E1zDflOqzmeToZh9H4Bx
 LlyPkICmedGEL6JMY5W0FVscdEonPek=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-sEnvASvLNtqCzVie-0-fxQ-1; Fri, 17 Jan 2025 14:40:15 -0500
X-MC-Unique: sEnvASvLNtqCzVie-0-fxQ-1
X-Mimecast-MFC-AGG-ID: sEnvASvLNtqCzVie-0-fxQ
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa68203d288so195006666b.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 11:40:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737142813; x=1737747613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZfIMapRdAVK5cr8WH2cqZZ26cbMwLQZzS74QVu30oqU=;
 b=NH3rYEHlYyZqlTpQpGjKlb/tDw/lmFmi7VONhC2OqiqKNX7DS8EZ7coH3oaVx5Qi81
 hpUkXQnF82aPoQczL07Rf/jCxkmCoSyQ2z2slsJ7yFrrv6oWtV0zjcvAG+vMJ/VxQkPk
 uwlnY89/CbrnLtznt+jJfoNrhd5wht81zQaa7TZf92Q7oHucf03UPgyoVkuETY7o9es6
 nHRCYOTlUgW4xpaEsUCQ/fdJADrYKBgx1G7fc7ezqr/gZshjtcgZgHZIEpSVst+Ez4hM
 52xR8nuu0oQDE8LPNCCp8k2r7nI/fnFGsZEhdL2QZjQfhOGDhRKsVCLkyCpqfb+KQXVW
 AOvg==
X-Gm-Message-State: AOJu0YxyZwbA+lYXlLI0bMnKcOuBj7xDdMtYZ07AOzSNmhQolBEkfk9P
 tVrVWherVib5nue3m6fFu0g5OSAjES3atihEhnZKDlfWYioogOXHhSpTlT4nfyNQlyx5fjE/WqL
 Hjw1bPIO9S1HxP2mUESVZbTlB0z4n4H/eQmPn5GzniSMSKusA2EIrqAEnaT0KU5KMPNxQb56WGt
 g0s0ZjIf+sEjQzzsY2GM2rCsFgqKWCPcoExshNRBs=
X-Gm-Gg: ASbGnct9EIUzEW4/PymXIdpwFx7fmEzMObRcOBU7EFvAmB15tS9BBlx0Z9uu0wmdGNt
 cR8av+uwuHCQH09exyyiX9MgLfKUnjHFcdrwOcSuTj72GamGzF+OBbg8HjfeVdInS7fIYfBcFwu
 9NS1R281+Ak8mpirTXLRjXKf0szFmpU8PGT6mGZqGGrrjhTWKn6y5lTgXwQxMbQfcGqdQsQMX34
 gb/ZwSF55KQn4RoxIUQ52Dt/NCNVySMPaWYph/GWQ/mNtuCV9uBaNzdLEA0SA==
X-Received: by 2002:a17:907:2d2c:b0:ab2:faed:f180 with SMTP id
 a640c23a62f3a-ab38b18bf29mr409514666b.33.1737142813561; 
 Fri, 17 Jan 2025 11:40:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6cJ0/MWso21JFMAHR/UQKmDuyGQq4mE3BUGlnLZ6Bn+aB2bkitJngAEw5J+sh3QwdPAQFAg==
X-Received: by 2002:a17:907:2d2c:b0:ab2:faed:f180 with SMTP id
 a640c23a62f3a-ab38b18bf29mr409512266b.33.1737142813111; 
 Fri, 17 Jan 2025 11:40:13 -0800 (PST)
Received: from [192.168.10.47] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce1bacsm220439066b.53.2025.01.17.11.40.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 11:40:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 03/10] rust: qom: add object creation functionality
Date: Fri, 17 Jan 2025 20:39:56 +0100
Message-ID: <20250117194003.1173231-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117194003.1173231-1-pbonzini@redhat.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.79,
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

The basic object lifecycle test can now be implemented using safe code!

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 13 ++++++++-----
 rust/qemu-api/src/prelude.rs     |  1 +
 rust/qemu-api/src/qom.rs         | 23 +++++++++++++++++++++--
 rust/qemu-api/tests/tests.rs     | 30 +++++++++++-------------------
 4 files changed, 41 insertions(+), 26 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 27563700665..d8409f3d310 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -690,15 +690,18 @@ pub fn post_load(&self, _version_id: u32) -> Result<(), ()> {
     irq: qemu_irq,
     chr: *mut Chardev,
 ) -> *mut DeviceState {
+    let pl011 = PL011State::new();
     unsafe {
-        let dev: *mut DeviceState = qdev_new(PL011State::TYPE_NAME.as_ptr());
-        let sysbus: *mut SysBusDevice = dev.cast::<SysBusDevice>();
-
+        let dev = pl011.as_mut_ptr::<DeviceState>();
         qdev_prop_set_chr(dev, c_str!("chardev").as_ptr(), chr);
-        sysbus_realize_and_unref(sysbus, addr_of_mut!(error_fatal));
+
+        let sysbus = pl011.as_mut_ptr::<SysBusDevice>();
+        sysbus_realize(sysbus, addr_of_mut!(error_fatal));
         sysbus_mmio_map(sysbus, 0, addr);
         sysbus_connect_irq(sysbus, 0, irq);
-        dev
+
+        // return the pointer, which is kept alive by the QOM tree; drop owned ref
+        pl011.as_mut_ptr()
     }
 }
 
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index 2dc86e19b29..3df6a5c21ec 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -12,6 +12,7 @@
 pub use crate::qom::ObjectCast;
 pub use crate::qom::ObjectCastMut;
 pub use crate::qom::ObjectDeref;
+pub use crate::qom::ObjectClassMethods;
 pub use crate::qom::ObjectMethods;
 pub use crate::qom::ObjectType;
 
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index c404f8a1aa7..6f7db3eabcb 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -66,8 +66,8 @@
 
 use crate::{
     bindings::{
-        self, object_dynamic_cast, object_get_class, object_get_typename, object_ref, object_unref,
-        TypeInfo,
+        self, object_dynamic_cast, object_get_class, object_get_typename, object_new, object_ref,
+        object_unref, TypeInfo,
     },
     cell::bql_locked,
 };
@@ -717,6 +717,24 @@ fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
     }
 }
 
+/// Trait for class methods exposed by the Object class.  The methods can be
+/// called on all objects that have the trait `IsA<Object>`.
+///
+/// The trait should only be used through the blanket implementation,
+/// which guarantees safety via `IsA`
+pub trait ObjectClassMethods: IsA<Object> {
+    /// Return a new reference counted instance of this class
+    fn new() -> Owned<Self> {
+        assert!(bql_locked());
+        // SAFETY: the object created by object_new is allocated on
+        // the heap and has a reference count of 1
+        unsafe {
+            let obj = &*object_new(Self::TYPE_NAME.as_ptr());
+            Owned::from_raw(obj.unsafe_cast::<Self>())
+        }
+    }
+}
+
 /// Trait for methods exposed by the Object class.  The methods can be
 /// called on all objects that have the trait `IsA<Object>`.
 ///
@@ -757,4 +775,5 @@ fn debug_fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
     }
 }
 
+impl<T> ObjectClassMethods for T where T: IsA<Object> {}
 impl<R: ObjectDeref> ObjectMethods for R where R::Target: IsA<Object> {}
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 5c3e75ed3d5..1944e65c8f3 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -3,8 +3,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use std::{
-    ffi::CStr,
-    os::raw::c_void,
+    ffi::{c_void, CStr},
     ptr::{addr_of, addr_of_mut},
 };
 
@@ -132,22 +131,16 @@ fn init_qom() {
 /// Create and immediately drop an instance.
 fn test_object_new() {
     init_qom();
-    unsafe {
-        object_unref(object_new(DummyState::TYPE_NAME.as_ptr()).cast());
-        object_unref(object_new(DummyChildState::TYPE_NAME.as_ptr()).cast());
-    }
+    drop(DummyState::new());
+    drop(DummyChildState::new());
 }
 
 #[test]
 /// Try invoking a method on an object.
 fn test_typename() {
     init_qom();
-    let p: *mut DummyState = unsafe { object_new(DummyState::TYPE_NAME.as_ptr()).cast() };
-    let p_ref: &DummyState = unsafe { &*p };
-    assert_eq!(p_ref.typename(), "dummy");
-    unsafe {
-        object_unref(p_ref.as_object_mut_ptr().cast::<c_void>());
-    }
+    let p = DummyState::new();
+    assert_eq!(p.typename(), "dummy");
 }
 
 // a note on all "cast" tests: usually, especially for downcasts the desired
@@ -162,24 +155,23 @@ fn test_typename() {
 /// Test casts on shared references.
 fn test_cast() {
     init_qom();
-    let p: *mut DummyState = unsafe { object_new(DummyState::TYPE_NAME.as_ptr()).cast() };
+    let p = DummyState::new();
+    let p_ptr: *mut DummyState = unsafe { p.as_mut_ptr() };
+    let p_ref: &mut DummyState = unsafe { &mut *p_ptr };
 
-    let p_ref: &DummyState = unsafe { &*p };
     let obj_ref: &Object = p_ref.upcast();
-    assert_eq!(addr_of!(*obj_ref), p.cast());
+    assert_eq!(addr_of!(*obj_ref), p_ptr.cast());
 
     let sbd_ref: Option<&SysBusDevice> = obj_ref.dynamic_cast();
     assert!(sbd_ref.is_none());
 
     let dev_ref: Option<&DeviceState> = obj_ref.downcast();
-    assert_eq!(addr_of!(*dev_ref.unwrap()), p.cast());
+    assert_eq!(addr_of!(*dev_ref.unwrap()), p_ptr.cast());
 
     // SAFETY: the cast is wrong, but the value is only used for comparison
     unsafe {
         let sbd_ref: &SysBusDevice = obj_ref.unsafe_cast();
-        assert_eq!(addr_of!(*sbd_ref), p.cast());
-
-        object_unref(p_ref.as_object_mut_ptr().cast::<c_void>());
+        assert_eq!(addr_of!(*sbd_ref), p_ptr.cast());
     }
 }
 
-- 
2.47.1


