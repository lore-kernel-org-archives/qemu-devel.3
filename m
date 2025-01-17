Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900BAC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 09:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYidO-0002ax-O6; Fri, 17 Jan 2025 04:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYidM-0002aI-MN
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:27:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYidH-0003Qx-Ez
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737106034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fXzW1PWCx2t+pwE+gDuweFFhlLiqOMxBQW7g5vUIp6E=;
 b=aOdzHcpauWm4kcaKT4L5bl7J0gDjCfEgjPHPMrtqgVftTm+CGYnndEngzO6AIdJf3f2drT
 au93FmMGeJzFMen2v0IwyO4UkSJvY044duKWsiF7Z/6jpsxNFAaR435iqcFUUvTnvhHb3X
 cmXKMbVWOpT4Jztt1BZgeEgYxokza34=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-_F_pcRQHNl6zM0_qRGPdSw-1; Fri, 17 Jan 2025 04:27:12 -0500
X-MC-Unique: _F_pcRQHNl6zM0_qRGPdSw-1
X-Mimecast-MFC-AGG-ID: _F_pcRQHNl6zM0_qRGPdSw
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa68203d288so146415766b.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 01:27:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737106031; x=1737710831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fXzW1PWCx2t+pwE+gDuweFFhlLiqOMxBQW7g5vUIp6E=;
 b=ge1TK1aLQ1f9qZU2rpHeX3dGYrL6i0vJ/zhNMrt1TG4mBlPjgT5hA+v3MltkQuO00D
 OhfXOtu91T4U59LFFkUpGuckIMBbovWHq6UX0kh6v2e2OJ7tAhFLSPq4xeJCIqJS7fys
 K1Z8f2V7SwYp3Ww0RhRieOgJzKiEhnbM8TJbyq48TKIs2wISEHkO8yz69/trx7Kz2eiU
 k57DN5tnBPgWGhzlD9Xpa0N2/IjEBdDEwIfj4GMbzRxeivVKuak6qjSrGwutCJbCFjII
 KQV7Lu0Fu6/BcMfUglpPl+hJ96l5jqBA7bQTIoCCI6vN49Xp8HTu0mFRct1gbAhx+vMg
 zqoA==
X-Gm-Message-State: AOJu0YyVerm4TPzFPz8Au21rHPfKQKPLX7f8i6zYobqqcFciz3NSdMKY
 O6qGt9KsSA3t6kBxUcgY/c1WIrAHEaWQuXmZBGnUSGz4/anneHxiiZDU1m+/lHcgaoUlLQ7joPN
 diyRoBmmxombR3SU10gjjPCBB3ecYGBIKSeEfPyRJcv+aY8grXlMvju9aeQlcS8172kRwj8fIVK
 4Vs3OX/7nzFCe8R2QkCpm1x4G1DXPi4CyPtSl+6lk=
X-Gm-Gg: ASbGncvYjfghJye4S7j5wrf6fvlPMfU8j+skZ8jGFpocAFvsEZVNy4bOreiLJDjKySb
 LxoqYwNjMKdE++DtvT7+ko9O0lVCRJ3/0e7wANg2yAh2vxHdhocBK1b2pZFZ30w1S5Ec5sYvJUn
 IqnK8bvzx+H2DlYRn1aiZuTpkDZwmedMd/+iVaJcFEb1tyVWiGQoJqprSC0VAySNibTB4SwtwqW
 m3lvgRymODsJ8GcF/DJr/71Dd4PvhxqwtGgBUsPvEeeHi06gN50/fuwAETQ
X-Received: by 2002:a17:907:9710:b0:aa6:a21b:2a9 with SMTP id
 a640c23a62f3a-ab38b3e2ed0mr197954766b.57.1737106030602; 
 Fri, 17 Jan 2025 01:27:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHhRa8RaSJ9NpeAmOvSfs3cxied5hB/iXsr+26UCo3MWxX3lVniKyIWzlY51SautRHczjLZg==
X-Received: by 2002:a17:907:9710:b0:aa6:a21b:2a9 with SMTP id
 a640c23a62f3a-ab38b3e2ed0mr197952366b.57.1737106030038; 
 Fri, 17 Jan 2025 01:27:10 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f2903esm138579566b.109.2025.01.17.01.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 01:27:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 05/10] rust: pl011: pull interrupt updates out of read/write
 ops
Date: Fri, 17 Jan 2025 10:26:52 +0100
Message-ID: <20250117092657.1051233-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117092657.1051233-1-pbonzini@redhat.com>
References: <20250117092657.1051233-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

qemu_irqs are not part of the vmstate, therefore they will remain in
PL011State.  Update them if needed after regs_read()/regs_write().

Apply #[must_use] to functions that return whether the interrupt state
could have changed, so that it's harder to forget the call to update().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 68 ++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 2e8707aef97..67c3e63baa1 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -234,7 +234,6 @@ fn regs_read(&mut self, offset: RegisterOffset) -> ControlFlow<u32, u32> {
                 }
                 // Update error bits.
                 self.receive_status_error_clear.set_from_data(c);
-                self.update();
                 // Must call qemu_chr_fe_accept_input, so return Continue:
                 return ControlFlow::Continue(u32::from(c));
             },
@@ -258,7 +257,7 @@ fn regs_read(&mut self, offset: RegisterOffset) -> ControlFlow<u32, u32> {
         })
     }
 
-    fn regs_write(&mut self, offset: RegisterOffset, value: u32) {
+    fn regs_write(&mut self, offset: RegisterOffset, value: u32) -> bool {
         // eprintln!("write offset {offset} value {value}");
         use RegisterOffset::*;
         match offset {
@@ -273,9 +272,10 @@ fn regs_write(&mut self, offset: RegisterOffset, value: u32) {
                 unsafe {
                     qemu_chr_fe_write_all(addr_of_mut!(self.char_backend), &ch, 1);
                 }
-                self.loopback_tx(value);
+                // interrupts always checked
+                let _ = self.loopback_tx(value);
                 self.int_level |= registers::INT_TX;
-                self.update();
+                return true;
             }
             RSR => {
                 self.receive_status_error_clear = 0.into();
@@ -299,7 +299,7 @@ fn regs_write(&mut self, offset: RegisterOffset, value: u32) {
                     self.reset_rx_fifo();
                     self.reset_tx_fifo();
                 }
-                if self.line_control.send_break() ^ new_val.send_break() {
+                let update = (self.line_control.send_break() != new_val.send_break()) && {
                     let mut break_enable: c_int = new_val.send_break().into();
                     // SAFETY: self.char_backend is a valid CharBackend instance after it's been
                     // initialized in realize().
@@ -310,15 +310,16 @@ fn regs_write(&mut self, offset: RegisterOffset, value: u32) {
                             addr_of_mut!(break_enable).cast::<c_void>(),
                         );
                     }
-                    self.loopback_break(break_enable > 0);
-                }
+                    self.loopback_break(break_enable > 0)
+                };
                 self.line_control = new_val;
                 self.set_read_trigger();
+                return update;
             }
             CR => {
                 // ??? Need to implement the enable bit.
                 self.control = value.into();
-                self.loopback_mdmctrl();
+                return self.loopback_mdmctrl();
             }
             FLS => {
                 self.ifl = value;
@@ -326,13 +327,13 @@ fn regs_write(&mut self, offset: RegisterOffset, value: u32) {
             }
             IMSC => {
                 self.int_enabled = value;
-                self.update();
+                return true;
             }
             RIS => {}
             MIS => {}
             ICR => {
                 self.int_level &= !value;
-                self.update();
+                return true;
             }
             DMACR => {
                 self.dmacr = value;
@@ -342,14 +343,12 @@ fn regs_write(&mut self, offset: RegisterOffset, value: u32) {
                 }
             }
         }
+        false
     }
 
     #[inline]
-    fn loopback_tx(&mut self, value: u32) {
-        if !self.loopback_enabled() {
-            return;
-        }
-
+    #[must_use]
+    fn loopback_tx(&mut self, value: u32) -> bool {
         // Caveat:
         //
         // In real hardware, TX loopback happens at the serial-bit level
@@ -367,12 +366,13 @@ fn loopback_tx(&mut self, value: u32) {
         // hardware flow-control is enabled.
         //
         // For simplicity, the above described is not emulated.
-        self.put_fifo(value);
+        self.loopback_enabled() && self.put_fifo(value)
     }
 
-    fn loopback_mdmctrl(&mut self) {
+    #[must_use]
+    fn loopback_mdmctrl(&mut self) -> bool {
         if !self.loopback_enabled() {
-            return;
+            return false;
         }
 
         /*
@@ -413,13 +413,11 @@ fn loopback_mdmctrl(&mut self) {
             il |= Interrupt::RI as u32;
         }
         self.int_level = il;
-        self.update();
+        true
     }
 
-    fn loopback_break(&mut self, enable: bool) {
-        if enable {
-            self.loopback_tx(registers::Data::BREAK.into());
-        }
+    fn loopback_break(&mut self, enable: bool) -> bool {
+        enable && self.loopback_tx(registers::Data::BREAK.into())
     }
 
     fn set_read_trigger(&mut self) {
@@ -481,14 +479,17 @@ pub fn can_receive(&self) -> bool {
     }
 
     pub fn receive(&mut self, ch: u32) {
-        if !self.loopback_enabled() {
-            self.put_fifo(ch)
+        if !self.loopback_enabled() && self.put_fifo(ch) {
+            self.update();
         }
     }
 
     pub fn event(&mut self, event: QEMUChrEvent) {
         if event == bindings::QEMUChrEvent::CHR_EVENT_BREAK && !self.loopback_enabled() {
-            self.put_fifo(registers::Data::BREAK.into());
+            let update = self.put_fifo(registers::Data::BREAK.into());
+            if update {
+                self.update();
+            }
         }
     }
 
@@ -511,7 +512,8 @@ pub fn fifo_depth(&self) -> u32 {
         1
     }
 
-    pub fn put_fifo(&mut self, value: u32) {
+    #[must_use]
+    pub fn put_fifo(&mut self, value: u32) -> bool {
         let depth = self.fifo_depth();
         assert!(depth > 0);
         let slot = (self.read_pos + self.read_count) & (depth - 1);
@@ -524,8 +526,9 @@ pub fn put_fifo(&mut self, value: u32) {
 
         if self.read_count == self.read_trigger {
             self.int_level |= registers::INT_RX;
-            self.update();
+            return true;
         }
+        false
     }
 
     pub fn update(&self) {
@@ -568,14 +571,19 @@ pub fn read(&mut self, offset: hwaddr, _size: u32) -> ControlFlow<u64, u64> {
             }
             Ok(field) => match self.regs_read(field) {
                 ControlFlow::Break(value) => ControlFlow::Break(value.into()),
-                ControlFlow::Continue(value) => ControlFlow::Continue(value.into()),
+                ControlFlow::Continue(value) => {
+                    self.update();
+                    ControlFlow::Continue(value.into())
+                },
             }
         }
     }
 
     pub fn write(&mut self, offset: hwaddr, value: u64) {
         if let Ok(field) = RegisterOffset::try_from(offset) {
-           self.regs_write(field, value as u32);
+            if self.regs_write(field, value as u32) {
+                self.update();
+            }
         } else {
             eprintln!("write bad offset {offset} value {value}");
         }
-- 
2.47.1


