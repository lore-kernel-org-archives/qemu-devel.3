Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91904C28B2E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 10:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trDwr-00085q-8a; Sun, 09 Mar 2025 06:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwp-00085P-9B
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwn-00042o-JM
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741516312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hp60NgzpFm3jMkNxot3ICZaotMUbZm/BSXyoCpaAV7I=;
 b=Pa47r29bOM3jK34OxvDj8dXR8bojhtZo6bRy+8a3nHknCg1jep0zi+Vm3ys99b3MClQanb
 UIiAsO/3mkKNLjcZ1BDd7UeB+PyJdIgiu1V9zzVzGkeiq9pw6BH1RKRQcz2tgOXfdvJbEb
 QLnVPDDH9PpUECsW+fDJpc2HpDr1R88=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-IumTV9SnNla_oK7-K6eE7w-1; Sun, 09 Mar 2025 06:31:50 -0400
X-MC-Unique: IumTV9SnNla_oK7-K6eE7w-1
X-Mimecast-MFC-AGG-ID: IumTV9SnNla_oK7-K6eE7w_1741516309
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39142ce2151so136462f8f.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 03:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741516308; x=1742121108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hp60NgzpFm3jMkNxot3ICZaotMUbZm/BSXyoCpaAV7I=;
 b=hz1MTepqXqNKjRnl/GUIzafzp/4AQbuimBnR8MjDmHSavNWIA5XQcHsUUzHtGoJSI6
 VTCLShkWL0aYh2giMPULbjlMK2Me+Wl5dQrg2ZUMdzohRaTA4jqIa1uZ9NKnxKW6+CEs
 0KcEoK2+8dgBcb6H5mAUPZ7JhwsqRazu+lriWAi7sb+8KBDiWKs0FdthlX6ZdpAAPbmT
 rEM2RoA1ILTN/qxymvyYrfMC8SsMGuZlaboWj2Z57mJvo8BywWtB5Uk5lzcmVXlGax/S
 Qrf/Su7Xx8qCMDFvGi8dji4sKk1+XeP8KaNoR7YH4afuHmjXx/m2LC83nFmZ/M361vft
 PQqg==
X-Gm-Message-State: AOJu0Yz2ZB6G+4ftK4130wXMkG1CKLfNuvIPYO2LnP66DlrlMHaOxo6/
 als6U46NlUugSdp2OeZ467YAQ7M2DTtX31bBrtNCiIK6pdNplbVomkOz6HdUmNTh7uyL8p+NtcP
 OA+UthCDdFT8pEIgs0/oblnQz4d34UO2M0S6OpYpM4Szn0dvL/36GsVSTfhN8xDzuNb/XNdRy0s
 8bOK1em8ysFnUQ/ifo/9cfYBxCTB7zmvtCH2s/wLw=
X-Gm-Gg: ASbGnctwBsekvyFB5a99TbWrzqwhEds6OtIC+LYazuDBqtpeQ99yVyUMHsLKsIH0P9X
 nsyJqibkQEIj0XApTQ59p177YqgKTq4nxzhftjfBl6mlU2hV6J4zKVGCIeoPZcltdyoqNDb1naH
 Ks8gxaXJOv0X4J9IlL4CdE7Q+hTpV6/0Omqp4jGrHfm5BoKyEa9Tpyagpu7m0JdXAPrvm54G/wx
 8OS/qe4cR9R1i0c/oQrYzl5pwYgTUkXm11Z0JDV5f6rhYATT8miKjs0tObcR+GqXzBnCH3TNckv
 dqMBIwOb8L2WkKxtSC1t+g==
X-Received: by 2002:a5d:47cc:0:b0:391:23de:b1b4 with SMTP id
 ffacd0b85a97d-39132db0648mr6275542f8f.45.1741516308602; 
 Sun, 09 Mar 2025 03:31:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUGvbKAW3FccWIUTK2Y3T66VPkgXr2R6M+osFDEOctQI2KE0VCwH2WHNCtzOXg98YsFaVZsg==
X-Received: by 2002:a5d:47cc:0:b0:391:23de:b1b4 with SMTP id
 ffacd0b85a97d-39132db0648mr6275527f8f.45.1741516308147; 
 Sun, 09 Mar 2025 03:31:48 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2f10sm11558920f8f.65.2025.03.09.03.31.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 03:31:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/25] rust: sysbus: wrap SysBusDevice with Opaque<>
Date: Sun,  9 Mar 2025 11:31:06 +0100
Message-ID: <20250309103120.1116448-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309103120.1116448-1-pbonzini@redhat.com>
References: <20250309103120.1116448-1-pbonzini@redhat.com>
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


