Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469EAC0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGHz-000476-Qb; Fri, 24 Jan 2025 04:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGT-0007rM-71
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGO-0003zM-UU
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oie+UgyG+xo4wp2azixL6WeEjPRPNC/oLryPAGhcuZA=;
 b=FuON5gzawoCkYokvCGEO8nj9htrkxink5ev13xtzkZjbofUL9PpsVuscpJwRnK7zJF4Hdk
 geHhbRic0ZMzONj3YcOYxVsCqgoK3490ieCXHbjBLGw5OHjETeBXZlDl4HiPaTsiUBufki
 hKAuHGHL/nh9htTJweo7kKwZUnKp1fk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-xrsaROcOOp-VKvJlBmBg5w-1; Fri, 24 Jan 2025 04:46:05 -0500
X-MC-Unique: xrsaROcOOp-VKvJlBmBg5w-1
X-Mimecast-MFC-AGG-ID: xrsaROcOOp-VKvJlBmBg5w
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4362b9c15d8so8753975e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711964; x=1738316764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oie+UgyG+xo4wp2azixL6WeEjPRPNC/oLryPAGhcuZA=;
 b=rmOyZcYEuZBXGa1MDGmEoV6Zff2KGHArlzOac4zuzDxj97s4OmqQQbIvc2khdlMuo3
 N6vJ3fFtKL0DrIrV/BwIDZGPn9e7IXPkuu73xIqxiP4f+Y7fHCOOScufEDOWXcn7OD99
 zATBmm3TF3B9pyCq8Consm/d9wbjkWY8N+Xycp8604rvsrwzHOVQyd8fDe8CXgemC06G
 dT2Upm7a0qn9Ji/9y93VGMSkMGEOkd6iClo/LLryj+sLUXKbmPgr5x0EuOJE3tmCjvRj
 TZqpeFZTEwj34I3/x1HgW1ZaPH9gt3tpsaZ6CBoNjSfmr95MGcC/AJvjQL7OrATYgC2A
 htvg==
X-Gm-Message-State: AOJu0YzkVY28ShN8NjJVpwh/+nL6GGF5lXyK6HoLeXM7re+vjlluhZ2y
 rT2RVvrQ+Ci78qDC1cZ2/VbguuExuM3DaArLq6nt3QOvPqW8oNMkq7LPX27QM6GCPX2sjGVq2lh
 bPsUREzaq+e5/6jqSMfmakPJw1CZYr18pUHOnUXj86lwLEZA9Z4tCebHe3NXjOBqOuOf5qgTsrU
 G/XLwdGEbj9FFx7AAl8shHKcm8hJdsNshUaIwFZmM=
X-Gm-Gg: ASbGncsRYaifxKz+6Z0EJb8CIwFdk/lDHDnvCXiLNIkIHg4s+NB3sDDruNyxT48Rxqp
 lsRtVfvYRVOUEAuS+/E9niIy3STfCevssxvh3ulFSWj9rbnMWRsyJvWMCirFkd0W87bl6iicesc
 zeN1KBsK4GgOJM/JZrNliS81rBfPitXEMTvviQW70C7UMSxJ0sT9zj1nSQ/CFw4YDxf2bD9tVnf
 QUNC8xNn9dLWfy4syyFwOcj12PnR/7Mup7oRG80VwPPGVxW3ZS+zJPxSoorrGgfe3NHtzjfqA==
X-Received: by 2002:a05:600c:5486:b0:434:f1e9:afae with SMTP id
 5b1f17b1804b1-438913bfa0fmr242509635e9.1.1737711963919; 
 Fri, 24 Jan 2025 01:46:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUHi8PqY8wgEb9kJyjfU7CyySml8jiZHKdXoA4+DZ7ZbBcNysjR55/L/bjNVmCrfIQSaRfWQ==
X-Received: by 2002:a05:600c:5486:b0:434:f1e9:afae with SMTP id
 5b1f17b1804b1-438913bfa0fmr242509215e9.1.1737711963273; 
 Fri, 24 Jan 2025 01:46:03 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4c75c0sm20280095e9.31.2025.01.24.01.46.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:46:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 40/48] rust: pl011: pull interrupt updates out of read/write ops
Date: Fri, 24 Jan 2025 10:44:34 +0100
Message-ID: <20250124094442.13207-41-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

qemu_irqs are not part of the vmstate, therefore they will remain in
PL011State.  Update them if needed after regs_read()/regs_write().

Apply #[must_use] to functions that return whether the interrupt state
could have changed, so that it's harder to forget the call to update().

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 84 ++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 36 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index de5110038a5..9cac9d352a2 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -242,7 +242,6 @@ fn regs_read(&mut self, offset: RegisterOffset) -> ControlFlow<u32, u32> {
                 }
                 // Update error bits.
                 self.receive_status_error_clear.set_from_data(c);
-                self.update();
                 // Must call qemu_chr_fe_accept_input, so return Continue:
                 return ControlFlow::Continue(u32::from(c));
             }
@@ -266,7 +265,7 @@ fn regs_read(&mut self, offset: RegisterOffset) -> ControlFlow<u32, u32> {
         })
     }
 
-    fn regs_write(&mut self, offset: RegisterOffset, value: u32) {
+    fn regs_write(&mut self, offset: RegisterOffset, value: u32) -> bool {
         // eprintln!("write offset {offset} value {value}");
         use RegisterOffset::*;
         match offset {
@@ -281,9 +280,10 @@ fn regs_write(&mut self, offset: RegisterOffset, value: u32) {
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
@@ -307,7 +307,7 @@ fn regs_write(&mut self, offset: RegisterOffset, value: u32) {
                     self.reset_rx_fifo();
                     self.reset_tx_fifo();
                 }
-                if self.line_control.send_break() ^ new_val.send_break() {
+                let update = (self.line_control.send_break() != new_val.send_break()) && {
                     let mut break_enable: c_int = new_val.send_break().into();
                     // SAFETY: self.char_backend is a valid CharBackend instance after it's been
                     // initialized in realize().
@@ -318,15 +318,16 @@ fn regs_write(&mut self, offset: RegisterOffset, value: u32) {
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
@@ -334,13 +335,13 @@ fn regs_write(&mut self, offset: RegisterOffset, value: u32) {
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
@@ -350,14 +351,12 @@ fn regs_write(&mut self, offset: RegisterOffset, value: u32) {
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
@@ -375,12 +374,13 @@ fn loopback_tx(&mut self, value: u32) {
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
@@ -421,13 +421,11 @@ fn loopback_mdmctrl(&mut self) {
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
@@ -489,14 +487,17 @@ pub fn can_receive(&self) -> bool {
     }
 
     pub fn receive(&mut self, ch: u32) {
-        if !self.loopback_enabled() {
-            self.put_fifo(ch)
+        if !self.loopback_enabled() && self.put_fifo(ch) {
+            self.update();
         }
     }
 
     pub fn event(&mut self, event: QEMUChrEvent) {
         if event == QEMUChrEvent::CHR_EVENT_BREAK && !self.loopback_enabled() {
-            self.put_fifo(registers::Data::BREAK.into());
+            let update = self.put_fifo(registers::Data::BREAK.into());
+            if update {
+                self.update();
+            }
         }
     }
 
@@ -519,7 +520,8 @@ pub fn fifo_depth(&self) -> u32 {
         1
     }
 
-    pub fn put_fifo(&mut self, value: u32) {
+    #[must_use]
+    pub fn put_fifo(&mut self, value: u32) -> bool {
         let depth = self.fifo_depth();
         assert!(depth > 0);
         let slot = (self.read_pos + self.read_count) & (depth - 1);
@@ -532,8 +534,9 @@ pub fn put_fifo(&mut self, value: u32) {
 
         if self.read_count == self.read_trigger {
             self.int_level |= registers::INT_RX;
-            self.update();
+            return true;
         }
+        false
     }
 
     pub fn update(&self) {
@@ -565,7 +568,8 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
     }
 
     pub fn read(&mut self, offset: hwaddr, _size: u32) -> ControlFlow<u64, u64> {
-        match RegisterOffset::try_from(offset) {
+        let mut update_irq = false;
+        let result = match RegisterOffset::try_from(offset) {
             Err(v) if (0x3f8..0x400).contains(&(v >> 2)) => {
                 let device_id = self.get_class().device_id;
                 ControlFlow::Break(u64::from(device_id[(offset - 0xfe0) >> 2]))
@@ -574,22 +578,30 @@ pub fn read(&mut self, offset: hwaddr, _size: u32) -> ControlFlow<u64, u64> {
                 // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
                 ControlFlow::Break(0)
             }
-            Ok(field) => {
-                let result = self.regs_read(field);
-                match result {
-                    ControlFlow::Break(value) => ControlFlow::Break(value.into()),
-                    ControlFlow::Continue(value) => ControlFlow::Continue(value.into()),
+            Ok(field) => match self.regs_read(field) {
+                ControlFlow::Break(value) => ControlFlow::Break(value.into()),
+                ControlFlow::Continue(value) => {
+                    update_irq = true;
+                    ControlFlow::Continue(value.into())
                 }
-            }
+            },
+        };
+        if update_irq {
+            self.update();
         }
+        result
     }
 
     pub fn write(&mut self, offset: hwaddr, value: u64) {
+        let mut update_irq = false;
         if let Ok(field) = RegisterOffset::try_from(offset) {
-            self.regs_write(field, value as u32);
+            update_irq = self.regs_write(field, value as u32);
         } else {
             eprintln!("write bad offset {offset} value {value}");
         }
+        if update_irq {
+            self.update();
+        }
     }
 }
 
-- 
2.48.1


