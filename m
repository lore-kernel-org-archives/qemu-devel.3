Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0267C0219B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgLQR-00080r-7T; Fri, 07 Feb 2025 05:17:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLQJ-0007eU-Gf
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:17:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLQH-0004L7-3M
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738923440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3cSSTTdboz+apeIJ4mIzJ7cmm1cZOm2bARcfKVsvDi0=;
 b=fLUusjt1rNC4vhVOmGdC9Fxo17ArH2D4t+dhQwW2WKBCVRivQiBAKC8vDZzdG9xseb2Apu
 nQ6YJUzyYN4hjfxUZD4YpBy4mGuCyEhdhh8tlaPxOeY4Eh3huUJLR733AVFVJ75No6gAIY
 pN+XA19VXPzD1gPj8LaeUUV3phfVqCw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-SX9Hzgg2OZavnhyWPEb8mw-1; Fri, 07 Feb 2025 05:17:19 -0500
X-MC-Unique: SX9Hzgg2OZavnhyWPEb8mw-1
X-Mimecast-MFC-AGG-ID: SX9Hzgg2OZavnhyWPEb8mw
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ab69e4c2563so247128066b.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 02:17:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738923436; x=1739528236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3cSSTTdboz+apeIJ4mIzJ7cmm1cZOm2bARcfKVsvDi0=;
 b=Wpxde/paBuZNkA/IpXgIRGJlFgBqHBSJPtTtv5EuuJMPAyrPZuloVcYzA2OVLGJndM
 ITg4uJHFssFHYitilOd4TrmNq8Y/KeWuIuu4ZlBGS/xoiykkoFezmH74B/tbOZ5Sr2wf
 ck44ghEA0WlziJtdUPCebL+654TkAWb58TK3l9QKlovoEcRs0wceHzk7T3FJPoqVv4hC
 b1aENOKQ1JcDXu/rAur7FSLkGZ2UXsR2aAT0T7R7TfA8QDL8He8b5e9d0bcsWU6q6KnT
 BhFAvIoHMRk12fszbCCrd0e5Fegkx0dD7462dMhOtvpTG5dTpauZtG5FXbmk/bqLWaM9
 cI4g==
X-Gm-Message-State: AOJu0Yz+wIXGKSSLNqrXT6b/hnHH0IdU4mpjHOCUpMutJBxtxAK7zeFh
 W1Voku73zojlJHUm+huPQZGb2SxNWXuJpb4rsdDfwPkrPnN0ybyDUyoiPZGRdrHxSPwHtSgXfK4
 D67bAp2p3zbPn5at5DS0ZMO9qVItNZM/R7kk5dUzd7jgpWidPJSJnHHzAUlJb1jBvxtD+vnU4SA
 +CeDV1MbeZPBuKwRJcV5fjz1hwo/YOEIWhI0za+DM=
X-Gm-Gg: ASbGncvOsX7cUbPy1E9UkF6dseq6auSo7ZcFbVLtZlICuj40a+eraubJ9S4E9sie5x4
 uoA+jCGYFAG+2RkID0NCRlI8tzr6w1sqJ15bUFQYpJ14vfoAHJ6TyE+GxCBmMEIHcyn1qh+igee
 WRkXNxOBtk54Xuw6oCqO+7a2WRE4JjHMVK04nljqIRryYRj2XaazVLZpcuqH17p8peiEs2UfPDC
 3gTmgQ6mO8gAMisq3Zi7z9XNvdZL6+mAS2dlH242eJNC2+dJCYlV5K2CLKAU4KR0YQWyDsygSkJ
 LHWTgA==
X-Received: by 2002:a17:906:9c94:b0:ab6:d6c3:f1e4 with SMTP id
 a640c23a62f3a-ab789c1d1c9mr198405066b.38.1738923435702; 
 Fri, 07 Feb 2025 02:17:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcRIx1tLxmMnWDIZ3rmy67uIFpCRxbXNj7iOv9GsmGkAPUINLJx1k+nK7pFjbd3/hB8Tm8QQ==
X-Received: by 2002:a17:906:9c94:b0:ab6:d6c3:f1e4 with SMTP id
 a640c23a62f3a-ab789c1d1c9mr198400866b.38.1738923434902; 
 Fri, 07 Feb 2025 02:17:14 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab772f843f4sm245053066b.68.2025.02.07.02.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 02:17:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 09/12] rust: bindings for MemoryRegionOps
Date: Fri,  7 Feb 2025 11:16:20 +0100
Message-ID: <20250207101623.2443552-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207101623.2443552-1-pbonzini@redhat.com>
References: <20250207101623.2443552-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 rust/hw/char/pl011/src/device.rs     |  51 +++----
 rust/hw/char/pl011/src/lib.rs        |   1 -
 rust/hw/char/pl011/src/memory_ops.rs |  34 -----
 rust/qemu-api/meson.build            |   1 +
 rust/qemu-api/src/lib.rs             |   1 +
 rust/qemu-api/src/memory.rs          | 191 +++++++++++++++++++++++++++
 rust/qemu-api/src/sysbus.rs          |   7 +-
 rust/qemu-api/src/zeroable.rs        |   1 +
 8 files changed, 226 insertions(+), 61 deletions(-)
 delete mode 100644 rust/hw/char/pl011/src/memory_ops.rs
 create mode 100644 rust/qemu-api/src/memory.rs

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 1d0390b4fbe..5e4e75133c8 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -10,13 +10,14 @@
 
 use qemu_api::{
     bindings::{
-        error_fatal, hwaddr, memory_region_init_io, qdev_prop_set_chr, qemu_chr_fe_accept_input,
-        qemu_chr_fe_ioctl, qemu_chr_fe_set_handlers, qemu_chr_fe_write_all, qemu_irq,
-        sysbus_connect_irq, sysbus_mmio_map, sysbus_realize, CharBackend, Chardev, MemoryRegion,
-        QEMUChrEvent, CHR_IOCTL_SERIAL_SET_BREAK,
+        error_fatal, qdev_prop_set_chr, qemu_chr_fe_accept_input, qemu_chr_fe_ioctl,
+        qemu_chr_fe_set_handlers, qemu_chr_fe_write_all, qemu_irq, sysbus_connect_irq,
+        sysbus_mmio_map, sysbus_realize, CharBackend, Chardev, QEMUChrEvent,
+        CHR_IOCTL_SERIAL_SET_BREAK,
     },
     c_str, impl_vmstate_forward,
     irq::InterruptSource,
+    memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
     prelude::*,
     qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
     qom::{ClassInitImpl, ObjectImpl, Owned, ParentField},
@@ -26,7 +27,6 @@
 
 use crate::{
     device_class,
-    memory_ops::PL011_OPS,
     registers::{self, Interrupt},
     RegisterOffset,
 };
@@ -487,20 +487,24 @@ impl PL011State {
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
 
@@ -525,7 +529,7 @@ fn post_init(&self) {
         }
     }
 
-    pub fn read(&mut self, offset: hwaddr, _size: u32) -> u64 {
+    pub fn read(&self, offset: hwaddr, _size: u32) -> u64 {
         match RegisterOffset::try_from(offset) {
             Err(v) if (0x3f8..0x400).contains(&(v >> 2)) => {
                 let device_id = self.get_class().device_id;
@@ -540,7 +544,7 @@ pub fn read(&mut self, offset: hwaddr, _size: u32) -> u64 {
                 if update_irq {
                     self.update();
                     unsafe {
-                        qemu_chr_fe_accept_input(&mut self.char_backend);
+                        qemu_chr_fe_accept_input(addr_of!(self.char_backend) as *mut _);
                     }
                 }
                 result.into()
@@ -548,7 +552,7 @@ pub fn read(&mut self, offset: hwaddr, _size: u32) -> u64 {
         }
     }
 
-    pub fn write(&mut self, offset: hwaddr, value: u64) {
+    pub fn write(&self, offset: hwaddr, value: u64, _size: u32) {
         let mut update_irq = false;
         if let Ok(field) = RegisterOffset::try_from(offset) {
             // qemu_chr_fe_write_all() calls into the can_receive
@@ -561,14 +565,15 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
                 // XXX this blocks entire thread. Rewrite to use
                 // qemu_chr_fe_write and background I/O callbacks
                 unsafe {
-                    qemu_chr_fe_write_all(&mut self.char_backend, &ch, 1);
+                    qemu_chr_fe_write_all(addr_of!(self.char_backend) as *mut _, &ch, 1);
                 }
             }
 
-            update_irq = self
-                .regs
-                .borrow_mut()
-                .write(field, value as u32, &mut self.char_backend);
+            update_irq = self.regs.borrow_mut().write(
+                field,
+                value as u32,
+                addr_of!(self.char_backend) as *mut _,
+            );
         } else {
             eprintln!("write bad offset {offset} value {value}");
         }
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index e704daf6e3e..88452dc888c 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -27,7 +27,6 @@
 
 mod device;
 mod device_class;
-mod memory_ops;
 
 pub use device::pl011_create;
 
diff --git a/rust/hw/char/pl011/src/memory_ops.rs b/rust/hw/char/pl011/src/memory_ops.rs
deleted file mode 100644
index 432d3263898..00000000000
--- a/rust/hw/char/pl011/src/memory_ops.rs
+++ /dev/null
@@ -1,34 +0,0 @@
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
-    let mut state = NonNull::new(opaque).unwrap().cast::<PL011State>();
-    unsafe { state.as_mut() }.read(addr, size)
-}
-
-unsafe extern "C" fn pl011_write(opaque: *mut c_void, addr: hwaddr, data: u64, _size: c_uint) {
-    let mut state = NonNull::new(opaque).unwrap().cast::<PL011State>();
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
index 7b04947cb6c..75742b50d4e 100644
--- a/rust/qemu-api/src/zeroable.rs
+++ b/rust/qemu-api/src/zeroable.rs
@@ -100,3 +100,4 @@ fn default() -> Self {
 impl_zeroable!(crate::bindings::VMStateDescription);
 impl_zeroable!(crate::bindings::MemoryRegionOps__bindgen_ty_1);
 impl_zeroable!(crate::bindings::MemoryRegionOps__bindgen_ty_2);
+impl_zeroable!(crate::bindings::MemoryRegionOps);
-- 
2.48.1


