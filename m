Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4CBC021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibey-0000yw-Tt; Thu, 13 Feb 2025 11:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibeQ-0000pc-0D
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibeO-0005Rc-12
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p4TsCALrwmKkF6xOTgGrMRoSliyIjrnUML60NrYfbfc=;
 b=T7Rwr3GKve12IgiJtWvVgHTRvTnba2hDqMOKKbYHRyxNAPFsttDHV+8/rNTcR+f79aZmOj
 DOOc4qLPeM/Z+QH4gzzV9ew7AEXhRkNEIpr8879MJn4CZArmU3HE9SoYh6rVKV3MrOljhf
 P4YEFboRCWJmsdXsepo6QoHk2byT/4g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-MOvkylzPMtunqmV7OtXFjQ-1; Thu, 13 Feb 2025 11:01:13 -0500
X-MC-Unique: MOvkylzPMtunqmV7OtXFjQ-1
X-Mimecast-MFC-AGG-ID: MOvkylzPMtunqmV7OtXFjQ_1739462472
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ab7e9f7381cso119694566b.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:01:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462472; x=1740067272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p4TsCALrwmKkF6xOTgGrMRoSliyIjrnUML60NrYfbfc=;
 b=m3ri6TBm6fTullz74GPqaEm1YGtrkIbswlgJ/kW8NDVMy/kqMS7cxvRs4B9+YhvtJu
 geWysC0oqmZ7xT/oAeclTML7hdZ/gNwiK9JN06HCgpnlq7paVfmt8Ks9O/JLu3C2gHlB
 tETAT0mfH5zFV5d1AIxalQnsyB15OC7PcxmAlnczkeI2vwRwxjR8ZR1Ues4HUdjrC5Qr
 rVjMymlxWamDkFTaTMllPZQlucIHW6txDDCxXaXFbVO3PU/CHd+z+TVv/7mtk9PwxInC
 gWfH8lgj+5V1lqGuxOBjna0RyMvZBw485tc4jw6rywGbc1uHAwGO46oXzE8jDyVd3lqp
 Y+pQ==
X-Gm-Message-State: AOJu0Yzm4fDtjOhQ6kezwyr1UA/oc+OXS1A2w2DJ3Go7dePZlFpc7Iea
 bRoIAU0NlReI/4SQR2+43ZwyJCwRdh7dPAntN1oQv/UAvm5kAJhXecDD5sAZaR/4GTES+94VmOG
 kfHkr3i5Ks1l06UiN+28BzMmD0qUZFlTaj07kWEX1wnX+UOzZ0h2oyC20rjKNb9Qfl3CcMR+7MT
 zET13U2TeIM3RqTHrSM5LM57lq/bbZHdEaEDm2DiU=
X-Gm-Gg: ASbGncuYDLGtmI5pdl+w7GjvI/gXKqUDYHWOk3/O9PmSGvloKyWMJY2CTQRP9DkOPjn
 R+PQfnkluDMqjvdQFsKOiVFUyPR92kPn0wkyfMWA0/E99+cav8fTKFxPxSlsVwfKygvxsCRGpXw
 srjbH20vkQGcbAoe/DmZCokgl43mackLvyUHNSiuAYxDvQ5d88vZBBMt5fURWhmH4ijBIEjdPFW
 OZWLO2DPYh8kqtKyCq9rVVdhuaCeCRgUpFWQQKw/4Updy/QmLJdN4YXWK9Hi/V5zabMtqrm8yqH
 i0xWtoJrJlBMFQA5QFjONU1K9p0SPVvm433XPDycQfINfg==
X-Received: by 2002:a17:907:2d0c:b0:ab7:f2da:8125 with SMTP id
 a640c23a62f3a-aba4ebca817mr435292066b.27.1739462469966; 
 Thu, 13 Feb 2025 08:01:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHugt1Thz3R1hT0Ofwk6m+PP3dolqfTTzoxNHJK/Vt8RDldRhVy1m6VXZ9RwtuoNSQhjZi93g==
X-Received: by 2002:a17:907:2d0c:b0:ab7:f2da:8125 with SMTP id
 a640c23a62f3a-aba4ebca817mr435204566b.27.1739462463300; 
 Thu, 13 Feb 2025 08:01:03 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4396180f199sm21157805e9.15.2025.02.13.08.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:01:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 03/27] rust: qom: add object creation functionality
Date: Thu, 13 Feb 2025 17:00:30 +0100
Message-ID: <20250213160054.3937012-4-pbonzini@redhat.com>
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

The basic object lifecycle test can now be implemented using safe code!

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 23 ++++++++++++---------
 rust/qemu-api/src/prelude.rs     |  1 +
 rust/qemu-api/src/qom.rs         | 23 +++++++++++++++++++--
 rust/qemu-api/tests/tests.rs     | 35 ++++++++++++--------------------
 4 files changed, 48 insertions(+), 34 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 8050ede9c85..f5db114b0c7 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -10,11 +10,11 @@
 
 use qemu_api::{
     bindings::{
-        error_fatal, hwaddr, memory_region_init_io, qdev_init_clock_in, qdev_new,
-        qdev_prop_set_chr, qemu_chr_fe_accept_input, qemu_chr_fe_ioctl, qemu_chr_fe_set_handlers,
-        qemu_chr_fe_write_all, qemu_irq, sysbus_connect_irq, sysbus_mmio_map,
-        sysbus_realize_and_unref, CharBackend, Chardev, Clock, ClockEvent, MemoryRegion,
-        QEMUChrEvent, CHR_IOCTL_SERIAL_SET_BREAK,
+        error_fatal, hwaddr, memory_region_init_io, qdev_init_clock_in, qdev_prop_set_chr,
+        qemu_chr_fe_accept_input, qemu_chr_fe_ioctl, qemu_chr_fe_set_handlers,
+        qemu_chr_fe_write_all, qemu_irq, sysbus_connect_irq, sysbus_mmio_map, sysbus_realize,
+        CharBackend, Chardev, Clock, ClockEvent, MemoryRegion, QEMUChrEvent,
+        CHR_IOCTL_SERIAL_SET_BREAK,
     },
     c_str, impl_vmstate_forward,
     irq::InterruptSource,
@@ -705,15 +705,18 @@ pub fn post_load(&self, _version_id: u32) -> Result<(), ()> {
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
index 404446d57fc..3e63cb30ca6 100644
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
@@ -759,6 +759,24 @@ fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
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
@@ -799,4 +817,5 @@ fn debug_fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
     }
 }
 
+impl<T> ObjectClassMethods for T where T: IsA<Object> {}
 impl<R: ObjectDeref> ObjectMethods for R where R::Target: IsA<Object> {}
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 5f6096a572e..10748fba197 100644
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
 
@@ -15,7 +14,7 @@
     declare_properties, define_property,
     prelude::*,
     qdev::{DeviceClass, DeviceImpl, DeviceState, Property},
-    qom::{ClassInitImpl, ObjectImpl, Owned, ParentField},
+    qom::{ClassInitImpl, ObjectImpl, ParentField},
     vmstate::VMStateDescription,
     zeroable::Zeroable,
 };
@@ -132,10 +131,8 @@ fn init_qom() {
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
@@ -143,8 +140,7 @@ fn test_object_new() {
 /// Create, clone and then drop an instance.
 fn test_clone() {
     init_qom();
-    let p: *mut DummyState = unsafe { object_new(DummyState::TYPE_NAME.as_ptr()).cast() };
-    let p = unsafe { Owned::from_raw(p) };
+    let p = DummyState::new();
     assert_eq!(p.clone().typename(), "dummy");
     drop(p);
 }
@@ -153,12 +149,8 @@ fn test_clone() {
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
@@ -173,24 +165,23 @@ fn test_typename() {
 /// Test casts on shared references.
 fn test_cast() {
     init_qom();
-    let p: *mut DummyState = unsafe { object_new(DummyState::TYPE_NAME.as_ptr()).cast() };
+    let p = DummyState::new();
+    let p_ptr: *mut DummyState = p.as_mut_ptr();
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
2.48.1


