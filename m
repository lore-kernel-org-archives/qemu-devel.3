Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E65C0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGIw-0007rz-0d; Fri, 24 Jan 2025 04:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGV-0007rW-EI
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGT-000409-Qy
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QamUuDsh3u1zhv5UP9v4AP13NvSKrprRowPTkNfQPV0=;
 b=VlhFFw7m1uVm/fya4VVj60NamK94Ubt0J1RAPnfypbnDKnNNFNg7y0oscraMShUMb12F7Y
 ZPiuR3v5/QjvNPSQgl7+wPCV6U/OiG1q3uTWqaQcFTlsY3dToGZ6bdt16rLY3mluKrutbK
 iHSIpFVzZXXHHDu0z6jg8/1ztyOF0SY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-6s9kZ87_OneDVFzvECI24A-1; Fri, 24 Jan 2025 04:46:11 -0500
X-MC-Unique: 6s9kZ87_OneDVFzvECI24A-1
X-Mimecast-MFC-AGG-ID: 6s9kZ87_OneDVFzvECI24A
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385e3cbf308so742567f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:46:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711969; x=1738316769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QamUuDsh3u1zhv5UP9v4AP13NvSKrprRowPTkNfQPV0=;
 b=wVgaAMUXgg+En/GP5CvbepSuy6Y+QXkcvLjaUeVDQFgenq3ryjfYZaxzn2WxC42uaK
 +FON4h2pr4gLt5lu+DgEaJ6TUVhmS+0TK5JP/NbnDWV5TTSrVRnGZDZD4TE7iabSHAcL
 2jJ8AwPKHsuQBUuvwUaZ9Ooy1Fp4+ru/q0BJuHuGyIBMiMeavCF7tgrVVi4q49uEdpnq
 3KKAoHbwXMcEtAlE00WQOKNep6r4wgCU9yhJ9sMw3mUs09XWeftrs8ig0/DfFDSeTGLI
 Q8PBZ8OdfAwzh+WN/wDP9hjhSso0H8f024eL32b3zU4EkY098wCkdeBHSNa6U7NjmkdI
 rC6g==
X-Gm-Message-State: AOJu0YwGCHCYJjZRh5BPPCiaQIqXcaXdkXRbQ8uhGoYJGNCKGNwVuXGn
 7sIOfh6+GBdyMB0MvJ7WnpZGj5BLfKn9v31/lrEz/+sBnR9LJCk4Pttq74xP5lxH9AGAps1jPcL
 wrjl01NkP9i2D8hC1LYMUMpq5dxOEMJ3hPv3mmwj/IRczhk94/K5PcSBushP1VrppXUE7WavJAX
 d5GLjiPCG5+kd3CJFWZiB9+qlxJN22gov7RJyLIN8=
X-Gm-Gg: ASbGnctTReR2o3+BDPvL76d5cZ8kmDasGg+bcxlAU1oNPul1sRLXdOPwpFovK0mcs9n
 2wnLorjjwfuTGIoGv+KCXGBsLcY/qHCV94OD9WNMojkq9IQL2XYdcHFRt2Dzo3RQnDiapTjZOvI
 l+KDXqLYVip+vDUUJ6X5mJ5U6DLrhk+gULLaynf82OYMgwvpm/skfIrgvP+eaA1AOFK+iRPZ4vX
 WHJb15Y67Xs8b2XWmSbTugOB1gTXrcgB50jYLZUjE8KCQEuGDMz+s/irT8FuygoYyJ/K7Ynlw==
X-Received: by 2002:a5d:6481:0:b0:38c:246f:b0b3 with SMTP id
 ffacd0b85a97d-38c246fb2bcmr6845003f8f.51.1737711969545; 
 Fri, 24 Jan 2025 01:46:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlslvanWOXciNRbMHt3LyBstsOQVcKdcoxXMR33PJ8oXh4eTK0zDAuRCx9LMuAbPsCnCR5nw==
X-Received: by 2002:a5d:6481:0:b0:38c:246f:b0b3 with SMTP id
 ffacd0b85a97d-38c246fb2bcmr6844949f8f.51.1737711969017; 
 Fri, 24 Jan 2025 01:46:09 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188928sm2151701f8f.45.2025.01.24.01.46.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:46:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 44/48] rust: pl011: pull device-specific code out of
 MemoryRegionOps callbacks
Date: Fri, 24 Jan 2025 10:44:38 +0100
Message-ID: <20250124094442.13207-45-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

read() can now return a simple u64.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs     | 23 +++++++++++++----------
 rust/hw/char/pl011/src/memory_ops.rs | 18 ++----------------
 2 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index eab3cf96f4c..9a0ba87aa5b 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -12,9 +12,10 @@
 use qemu_api::{
     bindings::{
         error_fatal, hwaddr, memory_region_init_io, qdev_init_clock_in, qdev_new,
-        qdev_prop_set_chr, qemu_chr_fe_ioctl, qemu_chr_fe_set_handlers, qemu_chr_fe_write_all,
-        qemu_irq, sysbus_connect_irq, sysbus_mmio_map, sysbus_realize_and_unref, CharBackend,
-        Chardev, Clock, ClockEvent, MemoryRegion, QEMUChrEvent, CHR_IOCTL_SERIAL_SET_BREAK,
+        qdev_prop_set_chr, qemu_chr_fe_accept_input, qemu_chr_fe_ioctl, qemu_chr_fe_set_handlers,
+        qemu_chr_fe_write_all, qemu_irq, sysbus_connect_irq, sysbus_mmio_map,
+        sysbus_realize_and_unref, CharBackend, Chardev, Clock, ClockEvent, MemoryRegion,
+        QEMUChrEvent, CHR_IOCTL_SERIAL_SET_BREAK,
     },
     c_str, impl_vmstate_forward,
     irq::InterruptSource,
@@ -538,30 +539,32 @@ fn post_init(&self) {
         }
     }
 
-    #[allow(clippy::needless_pass_by_ref_mut)]
-    pub fn read(&mut self, offset: hwaddr, _size: u32) -> ControlFlow<u64, u64> {
+    pub fn read(&mut self, offset: hwaddr, _size: u32) -> u64 {
         let mut update_irq = false;
         let result = match RegisterOffset::try_from(offset) {
             Err(v) if (0x3f8..0x400).contains(&(v >> 2)) => {
                 let device_id = self.get_class().device_id;
-                ControlFlow::Break(u64::from(device_id[(offset - 0xfe0) >> 2]))
+                u32::from(device_id[(offset - 0xfe0) >> 2])
             }
             Err(_) => {
                 // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
-                ControlFlow::Break(0)
+                0
             }
             Ok(field) => match self.regs.borrow_mut().read(field) {
-                ControlFlow::Break(value) => ControlFlow::Break(value.into()),
+                ControlFlow::Break(value) => value,
                 ControlFlow::Continue(value) => {
                     update_irq = true;
-                    ControlFlow::Continue(value.into())
+                    value
                 }
             },
         };
         if update_irq {
             self.update();
+            unsafe {
+                qemu_chr_fe_accept_input(&mut self.char_backend);
+            }
         }
-        result
+        result.into()
     }
 
     pub fn write(&mut self, offset: hwaddr, value: u64) {
diff --git a/rust/hw/char/pl011/src/memory_ops.rs b/rust/hw/char/pl011/src/memory_ops.rs
index a286003d136..432d3263898 100644
--- a/rust/hw/char/pl011/src/memory_ops.rs
+++ b/rust/hw/char/pl011/src/memory_ops.rs
@@ -24,25 +24,11 @@
 };
 
 unsafe extern "C" fn pl011_read(opaque: *mut c_void, addr: hwaddr, size: c_uint) -> u64 {
-    assert!(!opaque.is_null());
     let mut state = NonNull::new(opaque).unwrap().cast::<PL011State>();
-    let val = unsafe { state.as_mut().read(addr, size) };
-    match val {
-        std::ops::ControlFlow::Break(val) => val,
-        std::ops::ControlFlow::Continue(val) => {
-            // SAFETY: self.char_backend is a valid CharBackend instance after it's been
-            // initialized in realize().
-            let cb_ptr = unsafe { core::ptr::addr_of_mut!(state.as_mut().char_backend) };
-            unsafe {
-                qemu_chr_fe_accept_input(cb_ptr);
-            }
-
-            val
-        }
-    }
+    unsafe { state.as_mut() }.read(addr, size)
 }
 
 unsafe extern "C" fn pl011_write(opaque: *mut c_void, addr: hwaddr, data: u64, _size: c_uint) {
     let mut state = NonNull::new(opaque).unwrap().cast::<PL011State>();
-    unsafe { state.as_mut().write(addr, data) }
+    unsafe { state.as_mut() }.write(addr, data);
 }
-- 
2.48.1


