Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8152C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 19:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYsCu-0001fr-FK; Fri, 17 Jan 2025 14:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYsCs-0001dM-Cz
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:40:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYsCo-0002EC-Oe
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737142833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bkTyh20ofHIoBA2u9V9N3EE8+dgrUhUhrAuzIR0U41E=;
 b=fdqdSF69/ZPK65nFt4MS6kXrc9JCJwHoKnnDUYDJJMK/ywFeicZWx437YfwUjfTWuQR21z
 CKG2YLGaUZcWnoFUesrgDr1tGicwQC9Y9kA2+dy9f9Mu7zCD6gfTg6hzIFhEL0m8XZU8/I
 Erxtzmbs8XX9vB6c9rCNy5kGTeY07hc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-9lxWprf-MKaU97StrL8t8A-1; Fri, 17 Jan 2025 14:40:32 -0500
X-MC-Unique: 9lxWprf-MKaU97StrL8t8A-1
X-Mimecast-MFC-AGG-ID: 9lxWprf-MKaU97StrL8t8A
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5d0b5036394so3418031a12.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 11:40:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737142830; x=1737747630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bkTyh20ofHIoBA2u9V9N3EE8+dgrUhUhrAuzIR0U41E=;
 b=sSyLpiWD7JjubT74E+mZ/DA/C5wOLqhHnH9J9s8FnfsSr12hFx0LFq4lPlMmxjqUFN
 5419qGLkcM9l3jB5u7DNDv+xtKiwlmXjmoqqkz/ADKv5o1tUSiYcIQhbsfjEC0/tnmeU
 1DTrjb0if//g+OuYKyB38Lm2LLhyQmsGkNCmMlEJOTnDfTLwaX7swMOAcilHwHK3qedW
 s3MCS4eylV3KDqiFk5jItoIS9bEiJ52LeY4yhIXqpM2scB1nryaIQ941ynZi0H82RuDH
 QKlTdN8C6bw9/WnOfFZvSfFXpNrz2jVEj0KzgPV9zonaNwcucdsHb+Y66FCYdRnQTFLm
 YH3A==
X-Gm-Message-State: AOJu0YxD766+CtxAaAZtFZFDJjBiaIXfsYGi0Mef6Vf/0QzljbV0fraR
 FJhzAnOQLGIaf5+CeYoHzRgQusK+oudw0gvTlJGek52U6B0oHqywnqjiSm3yM0w0Wfy7v9fvVck
 Z75FiCnjZ4p2wyZnvq7sQFVEskXT8tyJcgAf2k/jmW+e61NcaTtmT972DVkqMVR192rvkOqbpXf
 u7EQIGKTrwAeVlGxyCLt5FB0Hsgl0U87Hy7NgUzgA=
X-Gm-Gg: ASbGncvjG/C8ZvU0xLbMVnDBbNP7pe9EpuQEfdPCXv295s3yq0+8t2fiBJTa8Iut71h
 VTPMg+rS4vTY1ej+KA6GyOpghmhaHkZIj2HlW7rQ2v3fgp3e6wU0wz7ogCXIwPrLBGQshbtQU9H
 eFk5gomPhkwe894YivJWiWLumPvNnLHsBcFphJ+SVffSLpA74z4eEY5VB+yRolHSKCv9sJergNm
 2e7sBGMzIQ4L5lFoXXJ+KPYIEAOyy02m8+mpsCm8DX6rajo1y0cb3CGVn1oIQ==
X-Received: by 2002:a05:6402:34ca:b0:5d9:82bc:ad06 with SMTP id
 4fb4d7f45d1cf-5db7d2d9b24mr3890788a12.3.1737142830322; 
 Fri, 17 Jan 2025 11:40:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8v/v1+hpk7RH2ofAQecmmr9x1RCkbbmIftXAxpm+Y5fIks36690JZ34lNPYgohLmLKTOo8Q==
X-Received: by 2002:a05:6402:34ca:b0:5d9:82bc:ad06 with SMTP id
 4fb4d7f45d1cf-5db7d2d9b24mr3890775a12.3.1737142829811; 
 Fri, 17 Jan 2025 11:40:29 -0800 (PST)
Received: from [192.168.10.47] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db73642379sm1951266a12.8.2025.01.17.11.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 11:40:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 10/10] rust: bindings for MemoryRegionOps
Date: Fri, 17 Jan 2025 20:40:03 +0100
Message-ID: <20250117194003.1173231-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117194003.1173231-1-pbonzini@redhat.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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
 rust/hw/char/pl011/src/device.rs     |  43 +++---
 rust/hw/char/pl011/src/lib.rs        |   1 -
 rust/hw/char/pl011/src/memory_ops.rs |  36 -----
 rust/qemu-api/meson.build            |   1 +
 rust/qemu-api/src/lib.rs             |   1 +
 rust/qemu-api/src/memory.rs          | 191 +++++++++++++++++++++++++++
 rust/qemu-api/src/sysbus.rs          |   7 +-
 rust/qemu-api/src/zeroable.rs        |  12 ++
 8 files changed, 234 insertions(+), 58 deletions(-)
 delete mode 100644 rust/hw/char/pl011/src/memory_ops.rs
 create mode 100644 rust/qemu-api/src/memory.rs

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 259efacb046..294394c6e82 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -2,7 +2,7 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use core::ptr::{addr_of_mut, NonNull};
+use core::ptr::{addr_of, addr_of_mut, NonNull};
 use std::{
     ffi::CStr,
     os::raw::{c_int, c_void},
@@ -12,14 +12,14 @@
     bindings::{self, *},
     c_str, impl_vmstate_forward,
     irq::InterruptSource,
+    memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
     prelude::*,
-    qdev::{Clock, ClockEvent, DeviceImpl, ResettablePhasesImpl, ResetType},
+    qdev::{Clock, ClockEvent, DeviceImpl, ResetType, ResettablePhasesImpl},
     qom::{ClassInitImpl, ObjectImpl, Owned, ParentField},
 };
 
 use crate::{
     device_class,
-    memory_ops::PL011_OPS,
     registers::{self, Interrupt},
     RegisterOffset,
 };
@@ -490,20 +490,24 @@ impl PL011State {
     /// location/instance. All its fields are expected to hold unitialized
     /// values with the sole exception of `parent_obj`.
     unsafe fn init(&mut self) {
+        static PL011_OPS: MemoryRegionOps<PL011State> = MemoryRegionOpsBuilder::<PL011State>::new()
+            .read(&PL011State::read)
+            .write(&PL011State::write)
+            .native_endian()
+            .impl_sizes(4, 4)
+            .build();
+
         // SAFETY:
         //
         // self and self.iomem are guaranteed to be valid at this point since callers
         // must make sure the `self` reference is valid.
-        unsafe {
-            memory_region_init_io(
-                addr_of_mut!(self.iomem),
-                addr_of_mut!(*self).cast::<Object>(),
-                &PL011_OPS,
-                addr_of_mut!(*self).cast::<c_void>(),
-                Self::TYPE_NAME.as_ptr(),
-                0x1000,
-            );
-        }
+        MemoryRegion::init_io(
+            unsafe { &mut *addr_of_mut!(self.iomem) },
+            addr_of_mut!(*self),
+            &PL011_OPS,
+            "pl011",
+            0x1000,
+        );
 
         self.regs = Default::default();
 
@@ -528,8 +532,7 @@ fn post_init(&self) {
         }
     }
 
-    #[allow(clippy::needless_pass_by_ref_mut)]
-    pub fn read(&mut self, offset: hwaddr, _size: u32) -> u64 {
+    pub fn read(&self, offset: hwaddr, _size: u32) -> u64 {
         let (update_irq, result) = match RegisterOffset::try_from(offset) {
             Err(v) if (0x3f8..0x400).contains(&(v >> 2)) => {
                 let device_id = self.get_class().device_id;
@@ -544,16 +547,20 @@ pub fn read(&mut self, offset: hwaddr, _size: u32) -> u64 {
         if update_irq {
             self.update();
             unsafe {
-                qemu_chr_fe_accept_input(&mut self.char_backend);
+                qemu_chr_fe_accept_input(addr_of!(self.char_backend) as *mut _);
             }
         }
         result.into()
     }
 
-    pub fn write(&mut self, offset: hwaddr, value: u64) {
+    pub fn write(&self, offset: hwaddr, value: u64, _size: u32) {
         let mut update_irq = false;
         if let Ok(field) = RegisterOffset::try_from(offset) {
-            update_irq = self.regs.borrow_mut().write(field, value as u32, &mut self.char_backend);
+            update_irq = self.regs.borrow_mut().write(
+                field,
+                value as u32,
+                addr_of!(self.char_backend) as *mut _,
+            );
         } else {
             eprintln!("write bad offset {offset} value {value}");
         }
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index 300c732ae1d..5622e974cbc 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -29,7 +29,6 @@
 
 mod device;
 mod device_class;
-mod memory_ops;
 
 pub use device::pl011_create;
 
diff --git a/rust/hw/char/pl011/src/memory_ops.rs b/rust/hw/char/pl011/src/memory_ops.rs
deleted file mode 100644
index 95b4df794e4..00000000000
--- a/rust/hw/char/pl011/src/memory_ops.rs
+++ /dev/null
@@ -1,36 +0,0 @@
-// Copyright 2024, Linaro Limited
-// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
-// SPDX-License-Identifier: GPL-2.0-or-later
-
-use core::ptr::NonNull;
-use std::os::raw::{c_uint, c_void};
-
-use qemu_api::{bindings::*, zeroable::Zeroable};
-
-use crate::device::PL011State;
-
-pub static PL011_OPS: MemoryRegionOps = MemoryRegionOps {
-    read: Some(pl011_read),
-    write: Some(pl011_write),
-    read_with_attrs: None,
-    write_with_attrs: None,
-    endianness: device_endian::DEVICE_NATIVE_ENDIAN,
-    valid: Zeroable::ZERO,
-    impl_: MemoryRegionOps__bindgen_ty_2 {
-        min_access_size: 4,
-        max_access_size: 4,
-        ..Zeroable::ZERO
-    },
-};
-
-unsafe extern "C" fn pl011_read(opaque: *mut c_void, addr: hwaddr, size: c_uint) -> u64 {
-    assert!(!opaque.is_null());
-    let mut state = unsafe { NonNull::new_unchecked(opaque.cast::<PL011State>()) };
-    unsafe { state.as_mut() }.read(addr, size)
-}
-
-unsafe extern "C" fn pl011_write(opaque: *mut c_void, addr: hwaddr, data: u64, _size: c_uint) {
-    assert!(!opaque.is_null());
-    let mut state = unsafe { NonNull::new_unchecked(opaque.cast::<PL011State>()) };
-    unsafe { state.as_mut() }.write(addr, data);
-}
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 60944a657de..80eafc7f6bd 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -22,6 +22,7 @@ _qemu_api_rs = static_library(
       'src/cell.rs',
       'src/c_str.rs',
       'src/irq.rs',
+      'src/memory.rs',
       'src/module.rs',
       'src/offset_of.rs',
       'src/prelude.rs',
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 83c6a987c05..8cc095b13f6 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -18,6 +18,7 @@
 pub mod callbacks;
 pub mod cell;
 pub mod irq;
+pub mod memory;
 pub mod module;
 pub mod offset_of;
 pub mod qdev;
diff --git a/rust/qemu-api/src/memory.rs b/rust/qemu-api/src/memory.rs
new file mode 100644
index 00000000000..963d689c27d
--- /dev/null
+++ b/rust/qemu-api/src/memory.rs
@@ -0,0 +1,191 @@
+// Copyright 2024 Red Hat, Inc.
+// Author(s): Paolo Bonzini <pbonzini@redhat.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! Bindings for `MemoryRegion` and `MemoryRegionOps`
+
+use std::{
+    ffi::{CStr, CString},
+    marker::{PhantomData, PhantomPinned},
+    os::raw::{c_uint, c_void},
+    ptr::addr_of,
+};
+
+pub use bindings::hwaddr;
+
+use crate::{
+    bindings::{self, device_endian, memory_region_init_io},
+    callbacks::FnCall,
+    prelude::*,
+    zeroable::Zeroable,
+};
+
+pub struct MemoryRegionOps<T>(
+    bindings::MemoryRegionOps,
+    // Note: quite often you'll see PhantomData<fn(&T)> mentioned when discussing
+    // covariance and contravariance; you don't need any of those to understand
+    // this usage of PhantomData.  Quite simply, MemoryRegionOps<T> *logically*
+    // holds callbacks that take an argument of type &T, except the type is erased
+    // before the callback is stored in the bindings::MemoryRegionOps field.
+    // The argument of PhantomData is a function pointer in order to represent
+    // that relationship; while that will also provide desirable and safe variance
+    // for T, variance is not the point but just a consequence.
+    PhantomData<fn(&T)>,
+);
+
+// SAFETY: When a *const T is passed to the callbacks, the call itself
+// is done in a thread-safe manner.  The invocation is okay as long as
+// T itself is `Sync`.
+unsafe impl<T: Sync> Sync for MemoryRegionOps<T> {}
+
+#[derive(Clone)]
+pub struct MemoryRegionOpsBuilder<T>(bindings::MemoryRegionOps, PhantomData<fn(&T)>);
+
+unsafe extern "C" fn memory_region_ops_read_cb<T, F: for<'a> FnCall<(&'a T, hwaddr, u32), u64>>(
+    opaque: *mut c_void,
+    addr: hwaddr,
+    size: c_uint,
+) -> u64 {
+    F::call((unsafe { &*(opaque.cast::<T>()) }, addr, size))
+}
+
+unsafe extern "C" fn memory_region_ops_write_cb<T, F: for<'a> FnCall<(&'a T, hwaddr, u64, u32)>>(
+    opaque: *mut c_void,
+    addr: hwaddr,
+    data: u64,
+    size: c_uint,
+) {
+    F::call((unsafe { &*(opaque.cast::<T>()) }, addr, data, size))
+}
+
+impl<T> MemoryRegionOpsBuilder<T> {
+    #[must_use]
+    pub const fn read<F: for<'a> FnCall<(&'a T, hwaddr, u32), u64>>(mut self, _f: &F) -> Self {
+        self.0.read = Some(memory_region_ops_read_cb::<T, F>);
+        self
+    }
+
+    #[must_use]
+    pub const fn write<F: for<'a> FnCall<(&'a T, hwaddr, u64, u32)>>(mut self, _f: &F) -> Self {
+        self.0.write = Some(memory_region_ops_write_cb::<T, F>);
+        self
+    }
+
+    #[must_use]
+    pub const fn big_endian(mut self) -> Self {
+        self.0.endianness = device_endian::DEVICE_BIG_ENDIAN;
+        self
+    }
+
+    #[must_use]
+    pub const fn little_endian(mut self) -> Self {
+        self.0.endianness = device_endian::DEVICE_LITTLE_ENDIAN;
+        self
+    }
+
+    #[must_use]
+    pub const fn native_endian(mut self) -> Self {
+        self.0.endianness = device_endian::DEVICE_NATIVE_ENDIAN;
+        self
+    }
+
+    #[must_use]
+    pub const fn valid_sizes(mut self, min: u32, max: u32) -> Self {
+        self.0.valid.min_access_size = min;
+        self.0.valid.max_access_size = max;
+        self
+    }
+
+    #[must_use]
+    pub const fn valid_unaligned(mut self) -> Self {
+        self.0.valid.unaligned = true;
+        self
+    }
+
+    #[must_use]
+    pub const fn impl_sizes(mut self, min: u32, max: u32) -> Self {
+        self.0.impl_.min_access_size = min;
+        self.0.impl_.max_access_size = max;
+        self
+    }
+
+    #[must_use]
+    pub const fn impl_unaligned(mut self) -> Self {
+        self.0.impl_.unaligned = true;
+        self
+    }
+
+    #[must_use]
+    pub const fn build(self) -> MemoryRegionOps<T> {
+        MemoryRegionOps::<T>(self.0, PhantomData)
+    }
+
+    #[must_use]
+    pub const fn new() -> Self {
+        Self(bindings::MemoryRegionOps::ZERO, PhantomData)
+    }
+}
+
+impl<T> Default for MemoryRegionOpsBuilder<T> {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+/// A safe wrapper around [`bindings::MemoryRegion`].  Compared to the
+/// underlying C struct it is marked as pinned because the QOM tree
+/// contains a pointer to it.
+pub struct MemoryRegion {
+    inner: bindings::MemoryRegion,
+    _pin: PhantomPinned,
+}
+
+impl MemoryRegion {
+    // inline to ensure that it is not included in tests, which only
+    // link to hwcore and qom.  FIXME: inlining is actually the opposite
+    // of what we want, since this is the type-erased version of the
+    // init_io function below.  Look into splitting the qemu_api crate.
+    #[inline(always)]
+    unsafe fn do_init_io(
+        slot: *mut bindings::MemoryRegion,
+        owner: *mut Object,
+        ops: &'static bindings::MemoryRegionOps,
+        name: &'static str,
+        size: u64,
+    ) {
+        unsafe {
+            let cstr = CString::new(name).unwrap();
+            memory_region_init_io(
+                slot,
+                owner.cast::<Object>(),
+                ops,
+                owner.cast::<c_void>(),
+                cstr.as_ptr(),
+                size,
+            );
+        }
+    }
+
+    pub fn init_io<T: IsA<Object>>(
+        &mut self,
+        owner: *mut T,
+        ops: &'static MemoryRegionOps<T>,
+        name: &'static str,
+        size: u64,
+    ) {
+        unsafe {
+            Self::do_init_io(&mut self.inner, owner.cast::<Object>(), &ops.0, name, size);
+        }
+    }
+
+    pub(crate) const fn as_mut_ptr(&self) -> *mut bindings::MemoryRegion {
+        addr_of!(self.inner) as *mut _
+    }
+}
+
+unsafe impl ObjectType for MemoryRegion {
+    type Class = bindings::MemoryRegionClass;
+    const TYPE_NAME: &'static CStr =
+        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_MEMORY_REGION) };
+}
+qom_isa!(MemoryRegion: Object);
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index e6762b5c145..c27dbf79e43 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -2,7 +2,7 @@
 // Author(s): Paolo Bonzini <pbonzini@redhat.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::{ffi::CStr, ptr::addr_of};
+use std::ffi::CStr;
 
 pub use bindings::{SysBusDevice, SysBusDeviceClass};
 
@@ -10,6 +10,7 @@
     bindings,
     cell::bql_locked,
     irq::InterruptSource,
+    memory::MemoryRegion,
     prelude::*,
     qdev::{DeviceClass, DeviceState},
     qom::ClassInitImpl,
@@ -42,10 +43,10 @@ pub trait SysBusDeviceMethods: ObjectDeref
     /// important, since whoever creates the sysbus device will refer to the
     /// region with a number that corresponds to the order of calls to
     /// `init_mmio`.
-    fn init_mmio(&self, iomem: &bindings::MemoryRegion) {
+    fn init_mmio(&self, iomem: &MemoryRegion) {
         assert!(bql_locked());
         unsafe {
-            bindings::sysbus_init_mmio(self.as_mut_ptr(), addr_of!(*iomem) as *mut _);
+            bindings::sysbus_init_mmio(self.as_mut_ptr(), iomem.as_mut_ptr());
         }
     }
 
diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
index 57cac96de06..0208381ee38 100644
--- a/rust/qemu-api/src/zeroable.rs
+++ b/rust/qemu-api/src/zeroable.rs
@@ -99,6 +99,18 @@ unsafe impl Zeroable for crate::bindings::VMStateDescription {
     };
 }
 
+unsafe impl Zeroable for crate::bindings::MemoryRegionOps {
+    const ZERO: Self = Self {
+        read: None,
+        write: None,
+        read_with_attrs: None,
+        write_with_attrs: None,
+        endianness: crate::bindings::device_endian::DEVICE_NATIVE_ENDIAN,
+        valid: Zeroable::ZERO,
+        impl_: Zeroable::ZERO,
+    };
+}
+
 unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_1 {
     const ZERO: Self = Self {
         min_access_size: 0,
-- 
2.47.1


