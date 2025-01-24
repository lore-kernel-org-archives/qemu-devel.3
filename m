Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F55AC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGI1-0004FZ-N7; Fri, 24 Jan 2025 04:47:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGM-0007oY-LW
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGK-0003yq-R9
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JUZvvlaNtJrFbkkw9/p5GgCt5QVuzk/+d4qUzLuDLw4=;
 b=UzHJkwwELn4OGZc55oV39Nh4EmK7aT0dosPrqNSHYcLz/5+Zuz3hubaRmHtfEFXhLGyV3H
 XuS/LGlcm9YzrNPgIt5ABs9gJnBnyernjBlRnWW/2op3r+wkWdfRrK604yxd++aRHlTU1A
 0XgRm9avu/cuRmyT51M55dBRaH4+bOc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-_8Y9NHMiO4aNOYACdnAS1w-1; Fri, 24 Jan 2025 04:46:02 -0500
X-MC-Unique: _8Y9NHMiO4aNOYACdnAS1w-1
X-Mimecast-MFC-AGG-ID: _8Y9NHMiO4aNOYACdnAS1w
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43623bf2a83so15109445e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:46:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711960; x=1738316760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JUZvvlaNtJrFbkkw9/p5GgCt5QVuzk/+d4qUzLuDLw4=;
 b=oJSNNgRQ07x9/2UjWrFIVF+cNoCXz7RIlplkv7HBvoinmFwVbR0AluJ/vvFUnSWLzF
 iBuaVg7Mi+VNdudmMxgni4K53jUia/rw2Pedm5kXzYUZ5DoCrKjzSgBbo75huw9+fSmb
 oloBWeBHHarOOAOLjTs3uchnf6jhfjRbM27GrfBwaDsZpEzQrO+rnX4KchuwTr0HoM/l
 MtqwcD/nUA/oirvGt3fNnE5l7Hj/X63uz8IMfSNkzBtGFBtVjmZQDfMQznmeNDNZZibM
 3K+ypMLo8HJHM8g8vVpjliPbzpl5Q4gsPpk2hp36EiF//HJQGe9wErw/zbdWpn/jJnmI
 RyKg==
X-Gm-Message-State: AOJu0YwM5WpO2S+lVsLUAJePIeS6B9utRhBWSwblyLMgbMuKmYkbaOQe
 pwuZmefevP3C+xvhdjolVUDPn/Cln6xqVyCNnHLkP5M5VBu/oedQrVOfMVYwa1IdUULAaKmhY14
 AMagUqR2QHXHClUCWOgYte2ck7TYY6obu2DsXNURLlDZULfIgi5Dp7CXKjfeH5v1BcwkY8GexzO
 O41EXdAu2JJ3XvanKpVaTNNrDCmnVd4ykhf1Mfm9Y=
X-Gm-Gg: ASbGncsMKcOBLZG4KO75TmEUxriQNVLhAPI0mANjOJD6IyGP2pW376KzfA+YpdBuI7A
 If+uNzCblxUGjevhnT3ApAV5b8XGRkqYFmOB7o4U/Fw4tZ3G02sE/Gzi6rQoNbhB0AhzDy1Pa3Z
 MpHDK/waJQ4TOIGgl1gstMyQZSMcLdxH48/HLIaXzNJvrZu2o+29goqkZhH2pvTNYm5kQQPUirH
 /rtTzzga+1PFblZqSnFMfrBL/nfI2Lm/F9IcN0RGoKc0o2SJGIm0bZoMGWqnpRco1et5FEajQ==
X-Received: by 2002:a05:600c:3149:b0:434:e9ee:c2d with SMTP id
 5b1f17b1804b1-4389144eee4mr237345025e9.26.1737711960531; 
 Fri, 24 Jan 2025 01:46:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZnPxOwuDAnNeXdA6db/f2nQUiOSJpjQN0GrFdk1loiEVEI5x4VUgQRg5UVkn2XGIQFiisRQ==
X-Received: by 2002:a05:600c:3149:b0:434:e9ee:c2d with SMTP id
 5b1f17b1804b1-4389144eee4mr237344715e9.26.1737711960051; 
 Fri, 24 Jan 2025 01:46:00 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd48ae56sm20569435e9.21.2025.01.24.01.45.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 38/48] rust: pl011: extract conversion to RegisterOffset
Date: Fri, 24 Jan 2025 10:44:32 +0100
Message-ID: <20250124094442.13207-39-pbonzini@redhat.com>
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

As an added bonus, this also makes the new function return u32 instead
of u64, thus factoring some casts into a single place.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 113 +++++++++++++++++--------------
 1 file changed, 64 insertions(+), 49 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index c8496eeb1b6..58b54547336 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -5,6 +5,7 @@
 use core::ptr::{addr_of, addr_of_mut, NonNull};
 use std::{
     ffi::CStr,
+    ops::ControlFlow,
     os::raw::{c_int, c_uint, c_void},
 };
 
@@ -222,19 +223,11 @@ fn post_init(&self) {
         }
     }
 
-    pub fn read(&mut self, offset: hwaddr, _size: c_uint) -> std::ops::ControlFlow<u64, u64> {
+    fn regs_read(&mut self, offset: RegisterOffset) -> ControlFlow<u32, u32> {
         use RegisterOffset::*;
 
-        let value = match RegisterOffset::try_from(offset) {
-            Err(v) if (0x3f8..0x400).contains(&(v >> 2)) => {
-                let device_id = self.get_class().device_id;
-                u32::from(device_id[(offset - 0xfe0) >> 2])
-            }
-            Err(_) => {
-                // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
-                0
-            }
-            Ok(DR) => {
+        ControlFlow::Break(match offset {
+            DR => {
                 self.flags.set_receive_fifo_full(false);
                 let c = self.read_fifo[self.read_pos];
                 if self.read_count > 0 {
@@ -251,39 +244,33 @@ pub fn read(&mut self, offset: hwaddr, _size: c_uint) -> std::ops::ControlFlow<u
                 self.receive_status_error_clear.set_from_data(c);
                 self.update();
                 // Must call qemu_chr_fe_accept_input, so return Continue:
-                let c = u32::from(c);
-                return std::ops::ControlFlow::Continue(u64::from(c));
+                return ControlFlow::Continue(u32::from(c));
             }
-            Ok(RSR) => u32::from(self.receive_status_error_clear),
-            Ok(FR) => u32::from(self.flags),
-            Ok(FBRD) => self.fbrd,
-            Ok(ILPR) => self.ilpr,
-            Ok(IBRD) => self.ibrd,
-            Ok(LCR_H) => u32::from(self.line_control),
-            Ok(CR) => u32::from(self.control),
-            Ok(FLS) => self.ifl,
-            Ok(IMSC) => self.int_enabled,
-            Ok(RIS) => self.int_level,
-            Ok(MIS) => self.int_level & self.int_enabled,
-            Ok(ICR) => {
+            RSR => u32::from(self.receive_status_error_clear),
+            FR => u32::from(self.flags),
+            FBRD => self.fbrd,
+            ILPR => self.ilpr,
+            IBRD => self.ibrd,
+            LCR_H => u32::from(self.line_control),
+            CR => u32::from(self.control),
+            FLS => self.ifl,
+            IMSC => self.int_enabled,
+            RIS => self.int_level,
+            MIS => self.int_level & self.int_enabled,
+            ICR => {
                 // "The UARTICR Register is the interrupt clear register and is write-only"
                 // Source: ARM DDI 0183G 3.3.13 Interrupt Clear Register, UARTICR
                 0
             }
-            Ok(DMACR) => self.dmacr,
-        };
-        std::ops::ControlFlow::Break(value.into())
+            DMACR => self.dmacr,
+        })
     }
 
-    pub fn write(&mut self, offset: hwaddr, value: u64) {
+    fn regs_write(&mut self, offset: RegisterOffset, value: u32) {
         // eprintln!("write offset {offset} value {value}");
         use RegisterOffset::*;
-        let value: u32 = value as u32;
-        match RegisterOffset::try_from(offset) {
-            Err(_bad_offset) => {
-                eprintln!("write bad offset {offset} value {value}");
-            }
-            Ok(DR) => {
+        match offset {
+            DR => {
                 // ??? Check if transmitter is enabled.
                 let ch: u8 = value as u8;
                 // XXX this blocks entire thread. Rewrite to use
@@ -298,22 +285,22 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
                 self.int_level |= registers::INT_TX;
                 self.update();
             }
-            Ok(RSR) => {
-                self.receive_status_error_clear.reset();
+            RSR => {
+                self.receive_status_error_clear = 0.into();
             }
-            Ok(FR) => {
+            FR => {
                 // flag writes are ignored
             }
-            Ok(ILPR) => {
+            ILPR => {
                 self.ilpr = value;
             }
-            Ok(IBRD) => {
+            IBRD => {
                 self.ibrd = value;
             }
-            Ok(FBRD) => {
+            FBRD => {
                 self.fbrd = value;
             }
-            Ok(LCR_H) => {
+            LCR_H => {
                 let new_val: registers::LineControl = value.into();
                 // Reset the FIFO state on FIFO enable or disable
                 if self.line_control.fifos_enabled() != new_val.fifos_enabled() {
@@ -336,26 +323,26 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
                 self.line_control = new_val;
                 self.set_read_trigger();
             }
-            Ok(CR) => {
+            CR => {
                 // ??? Need to implement the enable bit.
                 self.control = value.into();
                 self.loopback_mdmctrl();
             }
-            Ok(FLS) => {
+            FLS => {
                 self.ifl = value;
                 self.set_read_trigger();
             }
-            Ok(IMSC) => {
+            IMSC => {
                 self.int_enabled = value;
                 self.update();
             }
-            Ok(RIS) => {}
-            Ok(MIS) => {}
-            Ok(ICR) => {
+            RIS => {}
+            MIS => {}
+            ICR => {
                 self.int_level &= !value;
                 self.update();
             }
-            Ok(DMACR) => {
+            DMACR => {
                 self.dmacr = value;
                 if value & 3 > 0 {
                     // qemu_log_mask(LOG_UNIMP, "pl011: DMA not implemented\n");
@@ -570,6 +557,34 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
 
         Ok(())
     }
+
+    pub fn read(&mut self, offset: hwaddr, _size: u32) -> ControlFlow<u64, u64> {
+        match RegisterOffset::try_from(offset) {
+            Err(v) if (0x3f8..0x400).contains(&(v >> 2)) => {
+                let device_id = self.get_class().device_id;
+                ControlFlow::Break(u64::from(device_id[(offset - 0xfe0) >> 2]))
+            }
+            Err(_) => {
+                // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
+                ControlFlow::Break(0)
+            }
+            Ok(field) => {
+                let result = self.regs_read(field);
+                match result {
+                    ControlFlow::Break(value) => ControlFlow::Break(value.into()),
+                    ControlFlow::Continue(value) => ControlFlow::Continue(value.into()),
+                }
+            }
+        }
+    }
+
+    pub fn write(&mut self, offset: hwaddr, value: u64) {
+        if let Ok(field) = RegisterOffset::try_from(offset) {
+            self.regs_write(field, value as u32);
+        } else {
+            eprintln!("write bad offset {offset} value {value}");
+        }
+    }
 }
 
 /// Which bits in the interrupt status matter for each outbound IRQ line ?
-- 
2.48.1


