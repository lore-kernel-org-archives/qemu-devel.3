Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CD1C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 17:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlWRu-0007yu-4U; Fri, 21 Feb 2025 12:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRq-0007kW-2K
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:04:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRn-0001VI-3z
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740157458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2qAjDlzrSY64BqeVItW5GYtRjxGE8Q/k4KYQ6izQmD4=;
 b=E8I2nmR72heNeVFs9yMELoDmmIyXjYVgsHFMJKZ0Zd0rGnd9R7xCU3ZtKn+zue+jt/zT/D
 0HkyKtQwhF1EetEOcv8GFN3nJvBbY4spclKJajLzwPcykFnu2miu0bebpY0Oi5CN+KH/dO
 zbres3/+QthDAhQgHmEPS3/CU3y8VI4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-WwGzz0EAP--jzrpca_zL8g-1; Fri, 21 Feb 2025 12:04:16 -0500
X-MC-Unique: WwGzz0EAP--jzrpca_zL8g-1
X-Mimecast-MFC-AGG-ID: WwGzz0EAP--jzrpca_zL8g_1740157455
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5e08dfe2283so2137128a12.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 09:04:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740157455; x=1740762255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2qAjDlzrSY64BqeVItW5GYtRjxGE8Q/k4KYQ6izQmD4=;
 b=wLcpiycyxEN+W27T8E/rpfJA6ONXnLMKMMPASCmSOofG7p8sqaMnsVVEUlIRrFdWMn
 WAZC46KBFW8swpjGoDeWPUrpYkAju662xFW92dCMQeLg78idtE3Ml2soqCvrWTGjFE+e
 +ugWIc6/b3Xn2qYuGCmwyUWbFC9X7hOgRdo5r7XaxDHHeCQvqNKdqlY2mBnS96d2/19/
 pgsNTV100vVCIfyKx7JbrTpcFUwl+8l8FKIRIgxcQ0LpquIbtdV+nYjZWe0bWZ+ZMw9c
 27ZbxVfxOpw+45158qObX1VVE5maRTlrmA0O1+TSgf0zbh7NNcKpdCLC6SaHc11n5AyD
 UGjA==
X-Gm-Message-State: AOJu0YxkVH1pHs4MdQ4OzkAmAIGo2kXhNYDTICwlUhPilbJJW957JOao
 DLHx474voANZYbQvuKpfdmRLqkLCvhU8BtZ2zz3Rq9ieHfrO4uLytzo14nKUVk1ZP+Gbed2YGti
 AC4/tEoy/18zZ7v7r5Fd+1NvmgDWqDifD/4WI6a+JbgiCeCEYMkd6z1PYhMulN+HF447a9KlHnx
 oo7A/8azdCetWEO5s/Fw0GLOnNumLRzYGkZY90MM4=
X-Gm-Gg: ASbGncuhSUlrdLn3yJlxKn2AuFBeFxjCCPNVgbBmr5ttaDGbn9RhLU0FIUjIb4V5wtu
 6BXRx/qvW+EGSP1jICP0JZR7OZergliZINF6xPOrKD/AL7hTRwFz1blkWAzW1/JVca+AgtpcogS
 dz9k9K+D6SVtGQrTSJkeJ454CkTrDHutDzTiP3aWWaEqADxzRvBT9tXefiuz/rjnw1JGvafxrLe
 cJSu9u5mbRPigHx1Wm+yTBPmqgpp8vK7A6GPDbpNA+QyCXpEynMKHW1Sl7bXvPupn98adq5ZHrG
 rh/Hp9w+KoX1uDUEzt4=
X-Received: by 2002:a05:6402:388c:b0:5e0:7cc4:ec57 with SMTP id
 4fb4d7f45d1cf-5e0b7266ba5mr7393983a12.31.1740157454375; 
 Fri, 21 Feb 2025 09:04:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF33QoOqgmxmc8LVsNCqEn91wuWdiLttrFTLkpybIl0dvb1Oxi7pSLekqxSW/N32BQEskDCgw==
X-Received: by 2002:a05:6402:388c:b0:5e0:7cc4:ec57 with SMTP id
 4fb4d7f45d1cf-5e0b7266ba5mr7393701a12.31.1740157452298; 
 Fri, 21 Feb 2025 09:04:12 -0800 (PST)
Received: from [192.168.10.48] ([151.95.61.185])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e07464bcc7sm6856043a12.33.2025.02.21.09.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:04:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 11/15] rust: qdev: wrap Clock and DeviceState with Opaque<>
Date: Fri, 21 Feb 2025 18:03:38 +0100
Message-ID: <20250221170342.63591-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221170342.63591-1-pbonzini@redhat.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 1a4d1f38762..ed5dce08216 100644
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
+                    dev.0.as_mut_ptr(),
                     cstr.as_ptr(),
                     cb,
-                    dev.cast::<c_void>(),
+                    dev.0.as_void_ptr(),
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
index 24a4dc81e7f..b115d1f8742 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -469,7 +469,7 @@ macro_rules! vmstate_clock {
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


