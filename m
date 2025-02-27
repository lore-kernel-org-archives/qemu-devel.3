Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0B2C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnene-0006Bk-2t; Thu, 27 Feb 2025 09:23:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tneml-0003ws-10
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:22:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnemj-00048x-BY
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hp60NgzpFm3jMkNxot3ICZaotMUbZm/BSXyoCpaAV7I=;
 b=IRrzjMzAoa0JuMXZF/rYdg4teDGIC+ED70QEnv1ye3TGTz2M6nqVGri65oivnaminfflcE
 tvRVNbKpisBsl64WyO/EWuL0LzjSzudpW4a345iM3m1iuJ749VkraGWt1iHESlxhgn77jg
 3crMOA+ISC5rgDqidvJOeXuMFVoD8u8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-l3-G_ehtNSyYgacQzwog0w-1; Thu, 27 Feb 2025 09:22:43 -0500
X-MC-Unique: l3-G_ehtNSyYgacQzwog0w-1
X-Mimecast-MFC-AGG-ID: l3-G_ehtNSyYgacQzwog0w_1740666162
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-abb61c30566so93711966b.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:22:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666161; x=1741270961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hp60NgzpFm3jMkNxot3ICZaotMUbZm/BSXyoCpaAV7I=;
 b=oj6iMc3/7MDkZpeePrqGEQMNeikJyP6ygzm0ggG90e4cYCuSj8bE12GbnoxmD4Lg8P
 JBFrTOLoftRmLdSGj7ZVl5LusVgaIeELB/xUSwHWtFQvJVxKf6nJBwLcOWVOY5JZugE0
 jE4KnQ+CzXQgrnGiSjVjV6r67gmMU2BdgjDgNG2LoXzts/6DPh202je4o+Oty016OInH
 Om1iqQr73137c7D2+//E96LOiGSwNpQJJKISK3TDa/tMCHYthPFFXH0ciUPgGTDSr+99
 4C/ZcOiEm55aVMokHmHqNBlHK/IIdREg1/6351+/sZoRMJSNDSY9rThjudirr7Y8J0jF
 ED2g==
X-Gm-Message-State: AOJu0Yxcb3YJETAbPOjcXYS3HdGiVQ1UIUokaAbf0ePO8CUj7ZuWN4+Q
 oI3N9hzdUo4eAW7m3TJ8dmCRCc9v4kOc4+S83PuzIFtipbiEA69NDPMKE5KJxlcB2Hs65vfV+IL
 05F2F2ZQrbHb8xL1aYqMEd+uVRbRpDpU9hykOSPEywz/fqWoRlsDnUM+qaJKgTw92LS1mhrC5RP
 0ckMjfIrRJ325BjIN2YVAl1azO19HCnBCuJH0rdy4=
X-Gm-Gg: ASbGncuSehs8Yl+Xx51Lnmx+9iPqKqQh7to6HDi3pw/1EuplmKx5j4uOHm4zJZVnX16
 MiXZCv3drVlO3ZAndTb6cJ55kj9Vjp0EF5D/gHTGtFU0SV1ulTWc3b1IxiTC1iQJSujqC4KTXTl
 YzAC/hK4fSWcrVf8EhLwMed8+si7h/OmUjzYLmb2Y/mrigGSLe55J0P4mJAX5P4Lom2uCySuSdP
 KGC7fHUpPgny3i9eV0qtgLXYP2q60MIgbVDTyI2oRCWZvApPM+XEyUL0PNkm4pfXaU5fQLCDdWS
 QRQ3vKTUIR0oZ9Pd2n0f
X-Received: by 2002:a17:907:c407:b0:abc:4b7:e3d3 with SMTP id
 a640c23a62f3a-abeeedcfecbmr1035991966b.27.1740666160830; 
 Thu, 27 Feb 2025 06:22:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhkDzLZ7Rqvt7edxAJCDIQHcYGsOiEcgzSXzD9gNCicFHn6Ta7APVPqoxssTSBNlFJQ/LaWg==
X-Received: by 2002:a17:907:c407:b0:abc:4b7:e3d3 with SMTP id
 a640c23a62f3a-abeeedcfecbmr1035988666b.27.1740666160328; 
 Thu, 27 Feb 2025 06:22:40 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c1165e7sm130130566b.82.2025.02.27.06.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:22:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 09/12] rust: sysbus: wrap SysBusDevice with Opaque<>
Date: Thu, 27 Feb 2025 15:22:16 +0100
Message-ID: <20250227142219.812270-10-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/bindings.rs |  3 ---
 rust/qemu-api/src/sysbus.rs   | 29 +++++++++++++++++++++--------
 2 files changed, 21 insertions(+), 11 deletions(-)

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
index 0790576d446..e92502a8fe6 100644
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
 
@@ -60,14 +68,16 @@ fn init_mmio(&self, iomem: &MemoryRegion) {
     fn init_irq(&self, irq: &InterruptSource) {
         assert!(bql_locked());
         unsafe {
-            bindings::sysbus_init_irq(self.as_mut_ptr(), irq.as_ptr());
+            bindings::sysbus_init_irq(self.upcast().as_mut_ptr(), irq.as_ptr());
         }
     }
 
     // TODO: do we want a type like GuestAddress here?
     fn mmio_addr(&self, id: u32) -> Option<u64> {
         assert!(bql_locked());
-        let sbd = self.upcast();
+        // SAFETY: the BQL ensures that no one else writes to sbd.mmio[], and
+        // the SysBusDevice must be initialized to get an IsA<SysBusDevice>.
+        let sbd = unsafe { *self.upcast().as_ptr() };
         let id: usize = id.try_into().unwrap();
         if sbd.mmio[id].memory.is_null() {
             None
@@ -81,7 +91,7 @@ fn mmio_map(&self, id: u32, addr: u64) {
         assert!(bql_locked());
         let id: i32 = id.try_into().unwrap();
         unsafe {
-            bindings::sysbus_mmio_map(self.as_mut_ptr(), id, addr);
+            bindings::sysbus_mmio_map(self.upcast().as_mut_ptr(), id, addr);
         }
     }
 
@@ -93,7 +103,7 @@ fn connect_irq(&self, id: u32, irq: &Owned<IRQState>) {
         let id: i32 = id.try_into().unwrap();
         let irq: &IRQState = irq;
         unsafe {
-            bindings::sysbus_connect_irq(self.as_mut_ptr(), id, irq.as_mut_ptr());
+            bindings::sysbus_connect_irq(self.upcast().as_mut_ptr(), id, irq.as_mut_ptr());
         }
     }
 
@@ -101,7 +111,10 @@ fn sysbus_realize(&self) {
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


