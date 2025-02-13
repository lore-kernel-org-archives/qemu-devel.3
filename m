Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4EDC021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibes-0000wf-VU; Thu, 13 Feb 2025 11:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibeo-0000u4-CU
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibel-0005Xu-9A
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w/1RoRTf0RRS0LThHHY7f3sZLW21yJAIxZIiCZP4N+g=;
 b=WJw1rHk463BkfuMLxVocAYoMBN/Qs19NhLDh1AZnH8Ydy1TLR1yEMu2rw7eeyDlncjfE8/
 hA7Kg/edPrSe3T9elRSSuzzEStenkkQa8h1JvBCOrnWnrqkWROzZnkigSmKspFgc5ia6zY
 TR8qxHsqM2LzMXX5Rz6yiITIASpPtO4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-2bQRzlyoN6GuTIBHPKwZ6w-1; Thu, 13 Feb 2025 11:01:35 -0500
X-MC-Unique: 2bQRzlyoN6GuTIBHPKwZ6w-1
X-Mimecast-MFC-AGG-ID: 2bQRzlyoN6GuTIBHPKwZ6w_1739462494
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43935bcec74so6051025e9.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:01:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462493; x=1740067293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w/1RoRTf0RRS0LThHHY7f3sZLW21yJAIxZIiCZP4N+g=;
 b=lDzEH7H8d4tHnzB4ZbpjBsvPN/G2aOx0JTHxm+LcH7kqN29K/7ntuKEarWoSFziWut
 M288eQrdQAnfKRBYjqk139eg5gEcL1lqkZ0Hj89hhU0zTmvOh4ICjnnwfhAGNut9XCKu
 +tzifV3gEBFamF+yNiONfTI70dwo+cb4GQ/PiKPAlKneb6eLjjMatWVV3eBHmEsd0amw
 Q/1/MuTuX4ZBiRcefyIifQgM3cdeXVR6xjWPw8tjlZQ2rwvcU+jV7MhFIoVOSnw4afhN
 SHs3ZR65AOIffPZ6TbF1xjb15LQR44HcAFW/4nHEN+bzzdfTg9RtYeQZVkjCZa1FBSdv
 z7Vw==
X-Gm-Message-State: AOJu0Yw3thAYlHL9mwN5OrFy6J6JMEENyXhrHrRx4A/p2zqSZKr26SXV
 kGFjIosA+/uQuwZ7LrSOsATHq2ndPDtvWz3c+fJ/AxM/QAhN4cHjFUYB93xe0hzGSwxZXC/mCp/
 QkwMU+L6LyKmxoyziFSVkiI2jUBmtRz5B35Yu8lW1benXXz6J9FBsNa8gRGmLKNJXu5lkiclrV6
 im8A1libvG+MRZq57K0B4Tc2A3Pd+Gc3m5m8fnWzI=
X-Gm-Gg: ASbGncuxsuAqCRMsCirb5qfEvxXbBQmzfiUfmZETEcx0eqfPwXxBTHezVkZRrOFiW0n
 anJpkkuiveimV6VpdQQQupBQpZ29/X/AvQZeFbEWKlZDKVNFr2/umsmdqrUuW6Pk2PgKsxokFD0
 L4YcUze49zKIrEuhFz3tac8wJ3uyGZw4rSomMzFJ3Q+auP08azfFu/IfolWL+01emOpP858Cc80
 4tUFaINOAbFAsjN67YAcy7fGshqUV1dsoXhUYPdXjR13hLbnxJ3aikV7NrRbXnwXdHWiLOeqdV8
 dQnCp3bYk2AEFlnIoXpSo8Ai7K7JLPbWCwy9X6I+CEWmhA==
X-Received: by 2002:a05:600c:1c82:b0:439:5803:414f with SMTP id
 5b1f17b1804b1-43959925af0mr84072585e9.5.1739462492977; 
 Thu, 13 Feb 2025 08:01:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2EOwQd0ZXPwQhvNrZMUC/5MaOesFDyO0rSKolEYfI3nA9g633cMsov/u/9oYw9nPKETliKQ==
X-Received: by 2002:a05:600c:1c82:b0:439:5803:414f with SMTP id
 5b1f17b1804b1-43959925af0mr84071735e9.5.1739462491899; 
 Thu, 13 Feb 2025 08:01:31 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4344sm2299200f8f.13.2025.02.13.08.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:01:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 13/27] rust: pl011: convert pl011_create to safe Rust
Date: Thu, 13 Feb 2025 17:00:40 +0100
Message-ID: <20250213160054.3937012-14-pbonzini@redhat.com>
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

Not a major change but, as a small but significant step in creating
qdev bindings, show how pl011_create can be written without "unsafe"
calls (apart from converting pointers to references).

This also provides a starting point for creating Error** bindings.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 37 ++++++++++++++++----------------
 rust/qemu-api/src/sysbus.rs      | 34 ++++++++++++++++++++++++++---
 2 files changed, 49 insertions(+), 22 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 4e959073711..fe73771021e 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -10,14 +10,12 @@
 
 use qemu_api::{
     bindings::{
-        error_fatal, qdev_prop_set_chr, qemu_chr_fe_accept_input, qemu_chr_fe_ioctl,
-        qemu_chr_fe_set_handlers, qemu_chr_fe_write_all, qemu_irq, sysbus_connect_irq,
-        sysbus_mmio_map, sysbus_realize, CharBackend, QEMUChrEvent,
-        CHR_IOCTL_SERIAL_SET_BREAK,
+        qemu_chr_fe_accept_input, qemu_chr_fe_ioctl, qemu_chr_fe_set_handlers,
+        qemu_chr_fe_write_all, CharBackend, QEMUChrEvent, CHR_IOCTL_SERIAL_SET_BREAK,
     },
     chardev::Chardev,
-    c_str, impl_vmstate_forward,
-    irq::InterruptSource,
+    impl_vmstate_forward,
+    irq::{IRQState, InterruptSource},
     memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
     prelude::*,
     qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
@@ -698,26 +696,27 @@ pub fn post_load(&self, _version_id: u32) -> Result<(), ()> {
 
 /// # Safety
 ///
-/// We expect the FFI user of this function to pass a valid pointer for `chr`.
+/// We expect the FFI user of this function to pass a valid pointer for `chr`
+/// and `irq`.
 #[no_mangle]
 pub unsafe extern "C" fn pl011_create(
     addr: u64,
-    irq: qemu_irq,
+    irq: *mut IRQState,
     chr: *mut Chardev,
 ) -> *mut DeviceState {
-    let pl011 = PL011State::new();
-    unsafe {
-        let dev = pl011.as_mut_ptr::<DeviceState>();
-        qdev_prop_set_chr(dev, c_str!("chardev").as_ptr(), chr);
+    // SAFETY: The callers promise that they have owned references.
+    // They do not gift them to pl011_create, so use `Owned::from`.
+    let irq = unsafe { Owned::<IRQState>::from(&*irq) };
+    let chr = unsafe { Owned::<Chardev>::from(&*chr) };
 
-        let sysbus = pl011.as_mut_ptr::<SysBusDevice>();
-        sysbus_realize(sysbus, addr_of_mut!(error_fatal));
-        sysbus_mmio_map(sysbus, 0, addr);
-        sysbus_connect_irq(sysbus, 0, irq);
+    let dev = PL011State::new();
+    dev.prop_set_chr("chardev", &chr);
+    dev.sysbus_realize();
+    dev.mmio_map(0, addr);
+    dev.connect_irq(0, &irq);
 
-        // return the pointer, which is kept alive by the QOM tree; drop owned ref
-        pl011.as_mut_ptr()
-    }
+    // The pointer is kept alive by the QOM tree; drop the owned ref
+    dev.as_mut_ptr()
 }
 
 #[repr(C)]
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index c27dbf79e43..1f66a5f1e09 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -2,18 +2,18 @@
 // Author(s): Paolo Bonzini <pbonzini@redhat.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::ffi::CStr;
+use std::{ffi::CStr, ptr::addr_of_mut};
 
 pub use bindings::{SysBusDevice, SysBusDeviceClass};
 
 use crate::{
     bindings,
     cell::bql_locked,
-    irq::InterruptSource,
+    irq::{IRQState, InterruptSource},
     memory::MemoryRegion,
     prelude::*,
     qdev::{DeviceClass, DeviceState},
-    qom::ClassInitImpl,
+    qom::{ClassInitImpl, Owned},
 };
 
 unsafe impl ObjectType for SysBusDevice {
@@ -60,6 +60,34 @@ fn init_irq(&self, irq: &InterruptSource) {
             bindings::sysbus_init_irq(self.as_mut_ptr(), irq.as_ptr());
         }
     }
+
+    // TODO: do we want a type like GuestAddress here?
+    fn mmio_map(&self, id: u32, addr: u64) {
+        assert!(bql_locked());
+        let id: i32 = id.try_into().unwrap();
+        unsafe {
+            bindings::sysbus_mmio_map(self.as_mut_ptr(), id, addr);
+        }
+    }
+
+    // Owned<> is used here because sysbus_connect_irq (via
+    // object_property_set_link) adds a reference to the IRQState,
+    // which can prolong its life
+    fn connect_irq(&self, id: u32, irq: &Owned<IRQState>) {
+        assert!(bql_locked());
+        let id: i32 = id.try_into().unwrap();
+        unsafe {
+            bindings::sysbus_connect_irq(self.as_mut_ptr(), id, irq.as_mut_ptr());
+        }
+    }
+
+    fn sysbus_realize(&self) {
+        // TODO: return an Error
+        assert!(bql_locked());
+        unsafe {
+            bindings::sysbus_realize(self.as_mut_ptr(), addr_of_mut!(bindings::error_fatal));
+        }
+    }
 }
 
 impl<R: ObjectDeref> SysBusDeviceMethods for R where R::Target: IsA<SysBusDevice> {}
-- 
2.48.1


