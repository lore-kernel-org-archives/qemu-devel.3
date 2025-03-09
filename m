Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D42C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 10:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trDwn-00084m-6L; Sun, 09 Mar 2025 06:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwk-00083v-M3
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwi-000424-T5
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741516308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SqsGJNftWM1nTyRVPF20AlSEyETSkxx30EnRjrvmmVk=;
 b=a2fy4vuLgAeosAVhHbMnHUExe8zRdBenzINgJEewVw9z70Y3+Z1Y7NgjERbg21AOTvut7D
 wANpXPRIUIRT9uqH+4MuQlMXLk5a86oKGmgHlR2P7U9blGlm+nqpCE/N1aeKrq1JFGzNEY
 O/IpChDHOzaf1sT0EYPFCmv9pQvtr+M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-tSD7srqgPGWEQ60yu0FWFg-1; Sun, 09 Mar 2025 06:31:47 -0400
X-MC-Unique: tSD7srqgPGWEQ60yu0FWFg-1
X-Mimecast-MFC-AGG-ID: tSD7srqgPGWEQ60yu0FWFg_1741516306
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43bd8fd03a2so14698095e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 03:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741516305; x=1742121105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SqsGJNftWM1nTyRVPF20AlSEyETSkxx30EnRjrvmmVk=;
 b=L4v5XeF1jrQKnzydpacHJOCQ5RRt1HZGVnQrQTzoAymUIw4elFRGR4mV+1vfbjj8X1
 azXBkQl727UG67XkRygFyj3ecRtuJnltatN0yaRuyxmMHFTyvXBnMFGf0CZrUUfAQxRu
 vqYDyO7+kQay2acQxC2BuCjTJrH6lEGyD/WTniSOFPRExQ/HJrWa6KF8p2ZFSRgtoeN0
 oG3i6mupzpLuuzLXT4pj3cWsIQL9Idynlf9XQ66NDrwliOY7obFwkG6CC7Xupt3O99J3
 25sfnugimMnlQPi/mcboIOdm0zFWjlw4HqKXQ0spbYniMT2SikyOczeDaX9qns76ghKe
 gGRA==
X-Gm-Message-State: AOJu0YwuNgAsVHM7PZqpk/MP7fffMIxLpRK+0y7W2XotzqIuaKEqZyrv
 XES+535VS3F8JYEBF43ARnpq/9IcU0wefuz3mbZR7yyc+be+UU+2jH/vMkcCtcnqavhlZThI5Ro
 Gt56+ecfOP9IozGGjfHozjzP0yPyvlTLE9j9kGKVx5ypBw4A/Hmm1Y0xcHR7plweVnGlr46Kx5x
 c8cipiZHaC4o1hNFPzCsJoyRasP7msdgQ7FzS+z0U=
X-Gm-Gg: ASbGncsJQ2x2wUJ0tbWJgmV2GE1ewdJmme1qGfIV9chzrKL73xLqqDstfwGHORWyPHl
 zQaYST2+I8YPxAsrJwcs1qGEWMPpxjyydCoeC9MHEmAhJpcukMK2ZIK24McA7EzIRUieTxmLnfs
 n6b858cmdvWYvm22JDTbiM92DYzcEfL2h4sbSawZi4t1vKft6dwGrusbAFPaICmrrbb664g0dHm
 P7+4kSIpS02PTX4llASleC0UfPiUgWaVlbFL10o1bPUVFfwzXqiVvIIbwLdGHkZ3V4iorLgquNQ
 rh4Oy/nE7QpE+XEw7RozvA==
X-Received: by 2002:a05:6000:402a:b0:38f:23f4:2d7a with SMTP id
 ffacd0b85a97d-39132dc51admr6999166f8f.40.1741516304913; 
 Sun, 09 Mar 2025 03:31:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWqMHHrs3+v9xNSfsdPe2fT+UdNsRv2a2d2TEsa8aRq4RBxexPzD7OXhMaZobte132CpXg1Q==
X-Received: by 2002:a05:6000:402a:b0:38f:23f4:2d7a with SMTP id
 ffacd0b85a97d-39132dc51admr6999147f8f.40.1741516304407; 
 Sun, 09 Mar 2025 03:31:44 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01d81csm11650657f8f.58.2025.03.09.03.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 03:31:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 10/25] rust: qdev: wrap Clock and DeviceState with Opaque<>
Date: Sun,  9 Mar 2025 11:31:04 +0100
Message-ID: <20250309103120.1116448-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309103120.1116448-1-pbonzini@redhat.com>
References: <20250309103120.1116448-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/bindings.rs |  6 ----
 rust/qemu-api/src/qdev.rs     | 68 ++++++++++++++++++++++++-----------
 rust/qemu-api/src/vmstate.rs  |  2 +-
 3 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index be6dd68c09c..6e70a75a0e6 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -34,12 +34,6 @@ unsafe impl Sync for CharBackend {}
 unsafe impl Send for Chardev {}
 unsafe impl Sync for Chardev {}
 
-unsafe impl Send for Clock {}
-unsafe impl Sync for Clock {}
-
-unsafe impl Send for DeviceState {}
-unsafe impl Sync for DeviceState {}
-
 unsafe impl Send for MemoryRegion {}
 unsafe impl Sync for MemoryRegion {}
 
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 1a4d1f38762..1c4a67b5728 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -10,12 +10,12 @@
     ptr::NonNull,
 };
 
-pub use bindings::{Clock, ClockEvent, DeviceClass, DeviceState, Property, ResetType};
+pub use bindings::{ClockEvent, DeviceClass, Property, ResetType};
 
 use crate::{
     bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out, Error, ResettableClass},
     callbacks::FnCall,
-    cell::bql_locked,
+    cell::{bql_locked, Opaque},
     chardev::Chardev,
     irq::InterruptSource,
     prelude::*,
@@ -23,6 +23,22 @@
     vmstate::VMStateDescription,
 };
 
+/// A safe wrapper around [`bindings::Clock`].
+#[repr(transparent)]
+#[derive(Debug, qemu_api_macros::Wrapper)]
+pub struct Clock(Opaque<bindings::Clock>);
+
+unsafe impl Send for Clock {}
+unsafe impl Sync for Clock {}
+
+/// A safe wrapper around [`bindings::DeviceState`].
+#[repr(transparent)]
+#[derive(Debug, qemu_api_macros::Wrapper)]
+pub struct DeviceState(Opaque<bindings::DeviceState>);
+
+unsafe impl Send for DeviceState {}
+unsafe impl Sync for DeviceState {}
+
 /// Trait providing the contents of the `ResettablePhases` struct,
 /// which is part of the QOM `Resettable` interface.
 pub trait ResettablePhasesImpl {
@@ -117,7 +133,10 @@ fn vmsd() -> Option<&'static VMStateDescription> {
 /// We expect the FFI user of this function to pass a valid pointer that
 /// can be downcasted to type `T`. We also expect the device is
 /// readable/writeable from one thread at any time.
-unsafe extern "C" fn rust_realize_fn<T: DeviceImpl>(dev: *mut DeviceState, _errp: *mut *mut Error) {
+unsafe extern "C" fn rust_realize_fn<T: DeviceImpl>(
+    dev: *mut bindings::DeviceState,
+    _errp: *mut *mut Error,
+) {
     let state = NonNull::new(dev).unwrap().cast::<T>();
     T::REALIZE.unwrap()(unsafe { state.as_ref() });
 }
@@ -251,7 +270,7 @@ fn init_clock_in<F: for<'a> FnCall<(&'a Self::Target, ClockEvent)>>(
         events: ClockEvent,
     ) -> Owned<Clock> {
         fn do_init_clock_in(
-            dev: *mut DeviceState,
+            dev: &DeviceState,
             name: &str,
             cb: Option<unsafe extern "C" fn(*mut c_void, ClockEvent)>,
             events: ClockEvent,
@@ -265,14 +284,15 @@ fn do_init_clock_in(
             unsafe {
                 let cstr = CString::new(name).unwrap();
                 let clk = bindings::qdev_init_clock_in(
-                    dev,
+                    dev.as_mut_ptr(),
                     cstr.as_ptr(),
                     cb,
-                    dev.cast::<c_void>(),
+                    dev.as_void_ptr(),
                     events.0,
                 );
 
-                Owned::from(&*clk)
+                let clk: &Clock = Clock::from_raw(clk);
+                Owned::from(clk)
             }
         }
 
@@ -289,7 +309,7 @@ fn do_init_clock_in(
             None
         };
 
-        do_init_clock_in(self.as_mut_ptr(), name, cb, events)
+        do_init_clock_in(self.upcast(), name, cb, events)
     }
 
     /// Add an output clock named `name`.
@@ -304,9 +324,10 @@ fn do_init_clock_in(
     fn init_clock_out(&self, name: &str) -> Owned<Clock> {
         unsafe {
             let cstr = CString::new(name).unwrap();
-            let clk = bindings::qdev_init_clock_out(self.as_mut_ptr(), cstr.as_ptr());
+            let clk = bindings::qdev_init_clock_out(self.upcast().as_mut_ptr(), cstr.as_ptr());
 
-            Owned::from(&*clk)
+            let clk: &Clock = Clock::from_raw(clk);
+            Owned::from(clk)
         }
     }
 
@@ -314,7 +335,11 @@ fn prop_set_chr(&self, propname: &str, chr: &Owned<Chardev>) {
         assert!(bql_locked());
         let c_propname = CString::new(propname).unwrap();
         unsafe {
-            bindings::qdev_prop_set_chr(self.as_mut_ptr(), c_propname.as_ptr(), chr.as_mut_ptr());
+            bindings::qdev_prop_set_chr(
+                self.upcast().as_mut_ptr(),
+                c_propname.as_ptr(),
+                chr.as_mut_ptr(),
+            );
         }
     }
 
@@ -323,8 +348,17 @@ fn init_gpio_in<F: for<'a> FnCall<(&'a Self::Target, u32, u32)>>(
         num_lines: u32,
         _cb: F,
     ) {
-        let _: () = F::ASSERT_IS_SOME;
+        fn do_init_gpio_in(
+            dev: &DeviceState,
+            num_lines: u32,
+            gpio_in_cb: unsafe extern "C" fn(*mut c_void, c_int, c_int),
+        ) {
+            unsafe {
+                qdev_init_gpio_in(dev.as_mut_ptr(), Some(gpio_in_cb), num_lines as c_int);
+            }
+        }
 
+        let _: () = F::ASSERT_IS_SOME;
         unsafe extern "C" fn rust_irq_handler<T, F: for<'a> FnCall<(&'a T, u32, u32)>>(
             opaque: *mut c_void,
             line: c_int,
@@ -337,19 +371,13 @@ fn init_gpio_in<F: for<'a> FnCall<(&'a Self::Target, u32, u32)>>(
         let gpio_in_cb: unsafe extern "C" fn(*mut c_void, c_int, c_int) =
             rust_irq_handler::<Self::Target, F>;
 
-        unsafe {
-            qdev_init_gpio_in(
-                self.as_mut_ptr::<DeviceState>(),
-                Some(gpio_in_cb),
-                num_lines as c_int,
-            );
-        }
+        do_init_gpio_in(self.upcast(), num_lines, gpio_in_cb);
     }
 
     fn init_gpio_out(&self, pins: &[InterruptSource]) {
         unsafe {
             qdev_init_gpio_out(
-                self.as_mut_ptr::<DeviceState>(),
+                self.upcast().as_mut_ptr(),
                 InterruptSource::slice_as_ptr(pins),
                 pins.len() as c_int,
             );
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 1e7ba531e2a..f0510ae769d 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -470,7 +470,7 @@ macro_rules! vmstate_clock {
                 $crate::assert_field_type!(
                     $struct_name,
                     $field_name,
-                    $crate::qom::Owned<$crate::bindings::Clock>
+                    $crate::qom::Owned<$crate::qdev::Clock>
                 );
                 $crate::offset_of!($struct_name, $field_name)
             },
-- 
2.48.1


