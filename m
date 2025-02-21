Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3410DC021B6
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 17:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlWRx-0008D6-8A; Fri, 21 Feb 2025 12:04:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRr-0007ml-4r
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:04:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRp-0001Vr-30
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:04:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740157460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wrxstZfwC92BCL08iYO3tMXByMssL0Rad+3hL3bRI4k=;
 b=XKAldwQb/0l/S6I+LX9a86GkDjihruQLqrVM43wFz/W0MEeox8PdRGiyizStmu3Ydhl/NR
 mmYDMVIav6TA2FE4I5dpswGPAaZ4Fvyk3tVlKtFppZik3nUtVgvPWmkAPdKqKaJgdU1xEQ
 Cpqk5qqsBq3NvdfLWUxwf1oY72aooCo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-vmo46GzqO_mRVpvHyEddow-1; Fri, 21 Feb 2025 12:04:18 -0500
X-MC-Unique: vmo46GzqO_mRVpvHyEddow-1
X-Mimecast-MFC-AGG-ID: vmo46GzqO_mRVpvHyEddow_1740157458
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5da03762497so2320560a12.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 09:04:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740157456; x=1740762256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wrxstZfwC92BCL08iYO3tMXByMssL0Rad+3hL3bRI4k=;
 b=kNDJ32XcE6EQ8OXGsydDlK7pMAORdVo+zJrhWQnKzKbAkDxfS5xZ7e/FQFn+3hXrbB
 S+C+XLWSKQK9kk+yh1szNRub/whoLXEY0SFfQocdLYSced0+WfKQWXkRF1VDVEaNuQ4u
 +FymBlDgCEkzppiCc62MnyN5bzE3wX8C2RrrXQ86ejMcIOQO77ibJKgi48WOxmnLsgPK
 hrjVcdzmO1qlMQVx0FMzMDOAJWVXPu79ElhhfUiJumRRaSU+rMJxQ7r8QYi91ae8amYP
 HHrTaATXB/Xhje2H90Fr0q9hkxsLLNKeUwMXEXog+JXWqYLVjEHmE/v3GTXr0buFsi2H
 UfJQ==
X-Gm-Message-State: AOJu0YwIgWcZEaPsQjQ4gQ/X/0h4KKUTLL7a1FQ3sdcyBN8Bed8YRhVU
 6ARPNWahNULIy+fxfAVCqzXW4+ScCn6o8gPPfKg6P6pmqdG28ptfoc0IrnwPiiIa0GvfzfUzobO
 Debwk2skKkrbAjBwy8yxk24GtjZH45JS2E6rKIP5fz9yn05X1ZBoj21s8PuWY6CDL4wdAK0i/i8
 juYd7N5NKzfa+6zaCqnEgta6GZ8JM8vVo7jXqcKUI=
X-Gm-Gg: ASbGncuneDe5Hb9lg/T33RLap7qp/bGscHixcN4A7GhpjMtZS1lSpLM1m4A2I8as6b9
 hJaa5w/da08k4AWPxEtyfAra/KJ4jCjl72+uvgj6ZVyNQiRdcKUNu1JFOVmETF4WikOSK+wFYOR
 72qmf7BZb1+XMkpOnIEgkLTdVHpDSyWbGrb1ORFceCTfcpJDXoy0sv9z9tDW7M20Hivx4F6uVJi
 UaFu16I9WiKr/kAaAiJbirPn4+fnGKYODtytBbQhYmEvk8zlkUyLyfuHGrbdomyt338alfqwO9/
 Rb+pq0UQn8bzCq3lVN0=
X-Received: by 2002:a05:6402:1ecf:b0:5e0:8a3f:ef65 with SMTP id
 4fb4d7f45d1cf-5e0b62f9bbdmr4044712a12.7.1740157456163; 
 Fri, 21 Feb 2025 09:04:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExONKfMjCtfDcseZA+TksGC0DWhptB5rhNYjv195XCgFnxhHIkfqbSWPIwA2s61byRocY23g==
X-Received: by 2002:a05:6402:1ecf:b0:5e0:8a3f:ef65 with SMTP id
 4fb4d7f45d1cf-5e0b62f9bbdmr4044457a12.7.1740157454033; 
 Fri, 21 Feb 2025 09:04:14 -0800 (PST)
Received: from [192.168.10.48] ([151.95.61.185])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e09072247esm4486329a12.51.2025.02.21.09.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:04:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 12/15] rust: sysbus: wrap SysBusDevice with Opaque<>
Date: Fri, 21 Feb 2025 18:03:39 +0100
Message-ID: <20250221170342.63591-13-pbonzini@redhat.com>
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
 rust/hw/timer/hpet/src/hpet.rs |  2 +-
 rust/qemu-api/src/bindings.rs  |  3 ---
 rust/qemu-api/src/sysbus.rs    | 25 ++++++++++++++++++-------
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index be27eb0eff4..19e63465cff 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -741,7 +741,7 @@ fn reset_hold(&self, _type: ResetType) {
         HPETFwConfig::update_hpet_cfg(
             self.hpet_id.get(),
             self.capability.get() as u32,
-            sbd.mmio[0].addr,
+            unsafe { *sbd.as_ptr() }.mmio[0].addr,
         );
 
         // to document that the RTC lowers its output on reset as well
diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index 6e70a75a0e6..b791ca6d87f 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -40,9 +40,6 @@ unsafe impl Sync for MemoryRegion {}
 unsafe impl Send for ObjectClass {}
 unsafe impl Sync for ObjectClass {}
 
-unsafe impl Send for SysBusDevice {}
-unsafe impl Sync for SysBusDevice {}
-
 // SAFETY: this is a pure data struct
 unsafe impl Send for CoalescedMemoryRange {}
 unsafe impl Sync for CoalescedMemoryRange {}
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index 48803a655f9..78909fb9931 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -6,11 +6,11 @@
 
 use std::{ffi::CStr, ptr::addr_of_mut};
 
-pub use bindings::{SysBusDevice, SysBusDeviceClass};
+pub use bindings::SysBusDeviceClass;
 
 use crate::{
     bindings,
-    cell::bql_locked,
+    cell::{bql_locked, Opaque},
     irq::{IRQState, InterruptSource},
     memory::MemoryRegion,
     prelude::*,
@@ -18,6 +18,14 @@
     qom::Owned,
 };
 
+/// A safe wrapper around [`bindings::SysBusDevice`].
+#[repr(transparent)]
+#[derive(Debug, qemu_api_macros::Wrapper)]
+pub struct SysBusDevice(Opaque<bindings::SysBusDevice>);
+
+unsafe impl Send for SysBusDevice {}
+unsafe impl Sync for SysBusDevice {}
+
 unsafe impl ObjectType for SysBusDevice {
     type Class = SysBusDeviceClass;
     const TYPE_NAME: &'static CStr =
@@ -49,7 +57,7 @@ pub trait SysBusDeviceMethods: ObjectDeref
     fn init_mmio(&self, iomem: &MemoryRegion) {
         assert!(bql_locked());
         unsafe {
-            bindings::sysbus_init_mmio(self.as_mut_ptr(), iomem.as_mut_ptr());
+            bindings::sysbus_init_mmio(self.upcast().as_mut_ptr(), iomem.as_mut_ptr());
         }
     }
 
@@ -60,7 +68,7 @@ fn init_mmio(&self, iomem: &MemoryRegion) {
     fn init_irq(&self, irq: &InterruptSource) {
         assert!(bql_locked());
         unsafe {
-            bindings::sysbus_init_irq(self.as_mut_ptr(), irq.as_ptr());
+            bindings::sysbus_init_irq(self.upcast().as_mut_ptr(), irq.as_ptr());
         }
     }
 
@@ -69,7 +77,7 @@ fn mmio_map(&self, id: u32, addr: u64) {
         assert!(bql_locked());
         let id: i32 = id.try_into().unwrap();
         unsafe {
-            bindings::sysbus_mmio_map(self.as_mut_ptr(), id, addr);
+            bindings::sysbus_mmio_map(self.upcast().as_mut_ptr(), id, addr);
         }
     }
 
@@ -81,7 +89,7 @@ fn connect_irq(&self, id: u32, irq: &Owned<IRQState>) {
         let id: i32 = id.try_into().unwrap();
         let irq: &IRQState = irq;
         unsafe {
-            bindings::sysbus_connect_irq(self.as_mut_ptr(), id, irq.as_mut_ptr());
+            bindings::sysbus_connect_irq(self.upcast().as_mut_ptr(), id, irq.as_mut_ptr());
         }
     }
 
@@ -89,7 +97,10 @@ fn sysbus_realize(&self) {
         // TODO: return an Error
         assert!(bql_locked());
         unsafe {
-            bindings::sysbus_realize(self.as_mut_ptr(), addr_of_mut!(bindings::error_fatal));
+            bindings::sysbus_realize(
+                self.upcast().as_mut_ptr(),
+                addr_of_mut!(bindings::error_fatal),
+            );
         }
     }
 }
-- 
2.48.1


