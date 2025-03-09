Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48860C28B2E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 10:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trDyB-0003ob-7U; Sun, 09 Mar 2025 06:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDy8-0003Vq-2l
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:33:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDy5-0004AI-5T
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741516392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EU/CFazaZVh5PdNZNlABB6euybR9YpGeNLleuhzibQc=;
 b=CznxBIihyf1mf2dXrWjBbnyVdmZGixPxL0HdNSB2BWqbEcaQsv8ZAWfMujh+oTgUQ0TFP+
 jKEgmR8hJr3gVDqVwc2bRPgXaJNHDjkwRgNDHq8rFGsBQzMenUnGulk1ClrTe9AzVtKEfA
 g7uUuzUKj7LCAlgP8DDIEyLzc6XDVj8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607--Otb_IiuMZq3vKqC7fG2aA-1; Sun, 09 Mar 2025 06:32:03 -0400
X-MC-Unique: -Otb_IiuMZq3vKqC7fG2aA-1
X-Mimecast-MFC-AGG-ID: -Otb_IiuMZq3vKqC7fG2aA_1741516322
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3912539665cso1912017f8f.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 03:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741516321; x=1742121121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EU/CFazaZVh5PdNZNlABB6euybR9YpGeNLleuhzibQc=;
 b=CUZmM+lpZiXNabM58RJ5rnSoPOPEoe4D6FmhxFHIO8k/pxMGRnyie/0pKRn2y8rR5P
 Ehqp7AHoRzO0bJ1Nt1nyMTfmkaytd5SqbWkcIrYAerfnqLr++Wt/jifGIvhRwEPF0UDV
 mlh9QfRMLYDYkGyVWRnolV0U9QZtWiXAINWvz+ac5OvYvNNuigUXvuBrM0c03MAYaJ/p
 prjXeO57QNFowitjn4inlxlK68UNddbB7UDS+d5bGtz7GnFJU+jYSdAUR71enalDgEnk
 DUWyRC+tOkBnjvvQlIMgE+BoA6JEEZ4eX80q+fj82cSgya5urcEsTLa9tNnMVMVmDwYS
 VL4A==
X-Gm-Message-State: AOJu0YyYkj9Am56blUaWDdWls++fmq6e/TLMPSSX8vj1ecbv2ONt65+j
 bHWaxnF+/U6iME4nr3Fw6vnCsvotOGeN3e6xuI1QZGjEAEvQgs65f4CV8QIEXJmAGfFmvNU40UC
 bM9SNasNtukjAfoiRJ4YWmzQFv0VVyC129rlxaPG/ggOOn5LhjYowJFB81axf/595+YD9MWOqsX
 aADfaZUEkFq/m0iA3oRQvqgfwvwDIHeF0RJqkv9/s=
X-Gm-Gg: ASbGncu9H5O9dScmGZvLi7IsvzhvTaVOZzJqWKh2MnJs/tuZSSki+M4RthKgUw51lGC
 r+g3+KdosZnKhed43RNWnc7AiOkRrL3NYTfZheXl1ASsRHz02GOQBkZo/KXFBYCBG3hXY1ZdXX/
 Pns9faB/53SppQt5MOXA+UWNJMekAUdo+ks8io/U37OgAT7v59Wy64SV211rmOY6oIzVXQrJcEX
 t8KsSHHhpRyi3zFwCxjTDCHd2V7/jABZp3Ix4znMIzhX2qa/R5bg57zvgg62VtTa55kVOWyhRKp
 A4V4TNHACppMa971zjYm5g==
X-Received: by 2002:a5d:648e:0:b0:390:ef45:1a36 with SMTP id
 ffacd0b85a97d-3913af33e09mr3403089f8f.19.1741516321314; 
 Sun, 09 Mar 2025 03:32:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjzQtYdZI9taC7o0Z7eeylZcL7fUFhxPrScN/zFKSMRPEbyFiq5DEF7UyAGssLcSqUkV50PA==
X-Received: by 2002:a5d:648e:0:b0:390:ef45:1a36 with SMTP id
 ffacd0b85a97d-3913af33e09mr3403070f8f.19.1741516320711; 
 Sun, 09 Mar 2025 03:32:00 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfb7934sm11680011f8f.12.2025.03.09.03.31.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 03:32:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/25] rust: pl011: switch to safe chardev operation
Date: Sun,  9 Mar 2025 11:31:13 +0100
Message-ID: <20250309103120.1116448-20-pbonzini@redhat.com>
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

Switch bindings::CharBackend with chardev::CharBackend.  This removes
occurrences of "unsafe" due to FFI and switches the wrappers for receive,
can_receive and event callbacks to the common ones implemented by
chardev::CharBackend.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 119 +++++++------------------------
 1 file changed, 25 insertions(+), 94 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 4cdbbf4b73d..4e282bc9e9d 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -2,18 +2,10 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::{
-    ffi::CStr,
-    os::raw::{c_int, c_void},
-    ptr::{addr_of, addr_of_mut, NonNull},
-};
+use std::{ffi::CStr, ptr::addr_of_mut};
 
 use qemu_api::{
-    bindings::{
-        qemu_chr_fe_accept_input, qemu_chr_fe_ioctl, qemu_chr_fe_set_handlers,
-        qemu_chr_fe_write_all, CharBackend, QEMUChrEvent, CHR_IOCTL_SERIAL_SET_BREAK,
-    },
-    chardev::Chardev,
+    chardev::{CharBackend, Chardev, Event},
     impl_vmstate_forward,
     irq::{IRQState, InterruptSource},
     memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
@@ -235,7 +227,7 @@ pub(self) fn write(
         &mut self,
         offset: RegisterOffset,
         value: u32,
-        char_backend: *mut CharBackend,
+        char_backend: &CharBackend,
     ) -> bool {
         // eprintln!("write offset {offset} value {value}");
         use RegisterOffset::*;
@@ -269,17 +261,9 @@ pub(self) fn write(
                     self.reset_tx_fifo();
                 }
                 let update = (self.line_control.send_break() != new_val.send_break()) && {
-                    let mut break_enable: c_int = new_val.send_break().into();
-                    // SAFETY: self.char_backend is a valid CharBackend instance after it's been
-                    // initialized in realize().
-                    unsafe {
-                        qemu_chr_fe_ioctl(
-                            char_backend,
-                            CHR_IOCTL_SERIAL_SET_BREAK as i32,
-                            addr_of_mut!(break_enable).cast::<c_void>(),
-                        );
-                    }
-                    self.loopback_break(break_enable > 0)
+                    let break_enable = new_val.send_break();
+                    let _ = char_backend.send_break(break_enable);
+                    self.loopback_break(break_enable)
                 };
                 self.line_control = new_val;
                 self.set_read_trigger();
@@ -551,9 +535,7 @@ fn read(&self, offset: hwaddr, _size: u32) -> u64 {
                 let (update_irq, result) = self.regs.borrow_mut().read(field);
                 if update_irq {
                     self.update();
-                    unsafe {
-                        qemu_chr_fe_accept_input(addr_of!(self.char_backend) as *mut _);
-                    }
+                    self.char_backend.accept_input();
                 }
                 result.into()
             }
@@ -567,21 +549,16 @@ fn write(&self, offset: hwaddr, value: u64, _size: u32) {
             // callback, so handle writes before entering PL011Registers.
             if field == RegisterOffset::DR {
                 // ??? Check if transmitter is enabled.
-                let ch: u8 = value as u8;
-                // SAFETY: char_backend is a valid CharBackend instance after it's been
-                // initialized in realize().
+                let ch: [u8; 1] = [value as u8];
                 // XXX this blocks entire thread. Rewrite to use
                 // qemu_chr_fe_write and background I/O callbacks
-                unsafe {
-                    qemu_chr_fe_write_all(addr_of!(self.char_backend) as *mut _, &ch, 1);
-                }
+                let _ = self.char_backend.write_all(&ch);
             }
 
-            update_irq = self.regs.borrow_mut().write(
-                field,
-                value as u32,
-                addr_of!(self.char_backend) as *mut _,
-            );
+            update_irq = self
+                .regs
+                .borrow_mut()
+                .write(field, value as u32, &self.char_backend);
         } else {
             eprintln!("write bad offset {offset} value {value}");
         }
@@ -590,15 +567,18 @@ fn write(&self, offset: hwaddr, value: u64, _size: u32) {
         }
     }
 
-    pub fn can_receive(&self) -> bool {
-        // trace_pl011_can_receive(s->lcr, s->read_count, r);
+    fn can_receive(&self) -> u32 {
         let regs = self.regs.borrow();
-        regs.read_count < regs.fifo_depth()
+        // trace_pl011_can_receive(s->lcr, s->read_count, r);
+        u32::from(regs.read_count < regs.fifo_depth())
     }
 
-    pub fn receive(&self, ch: u32) {
+    fn receive(&self, buf: &[u8]) {
+        if buf.is_empty() {
+            return;
+        }
         let mut regs = self.regs.borrow_mut();
-        let update_irq = !regs.loopback_enabled() && regs.put_fifo(ch);
+        let update_irq = !regs.loopback_enabled() && regs.put_fifo(buf[0].into());
         // Release the BqlRefCell before calling self.update()
         drop(regs);
 
@@ -607,10 +587,10 @@ pub fn receive(&self, ch: u32) {
         }
     }
 
-    pub fn event(&self, event: QEMUChrEvent) {
+    fn event(&self, event: Event) {
         let mut update_irq = false;
         let mut regs = self.regs.borrow_mut();
-        if event == QEMUChrEvent::CHR_EVENT_BREAK && !regs.loopback_enabled() {
+        if event == Event::CHR_EVENT_BREAK && !regs.loopback_enabled() {
             update_irq = regs.put_fifo(registers::Data::BREAK.into());
         }
         // Release the BqlRefCell before calling self.update()
@@ -622,20 +602,8 @@ pub fn event(&self, event: QEMUChrEvent) {
     }
 
     fn realize(&self) {
-        // SAFETY: self.char_backend has the correct size and alignment for a
-        // CharBackend object, and its callbacks are of the correct types.
-        unsafe {
-            qemu_chr_fe_set_handlers(
-                addr_of!(self.char_backend) as *mut CharBackend,
-                Some(pl011_can_receive),
-                Some(pl011_receive),
-                Some(pl011_event),
-                None,
-                addr_of!(*self).cast::<c_void>() as *mut c_void,
-                core::ptr::null_mut(),
-                true,
-            );
-        }
+        self.char_backend
+            .enable_handlers(self, Self::can_receive, Self::receive, Self::event);
     }
 
     fn reset_hold(&self, _type: ResetType) {
@@ -666,43 +634,6 @@ pub fn post_load(&self, _version_id: u32) -> Result<(), ()> {
     Interrupt::E.0,
 ];
 
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer, that has
-/// the same size as [`PL011State`]. We also expect the device is
-/// readable/writeable from one thread at any time.
-pub unsafe extern "C" fn pl011_can_receive(opaque: *mut c_void) -> c_int {
-    let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
-    unsafe { state.as_ref().can_receive().into() }
-}
-
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer, that has
-/// the same size as [`PL011State`]. We also expect the device is
-/// readable/writeable from one thread at any time.
-///
-/// The buffer and size arguments must also be valid.
-pub unsafe extern "C" fn pl011_receive(opaque: *mut c_void, buf: *const u8, size: c_int) {
-    let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
-    unsafe {
-        if size > 0 {
-            debug_assert!(!buf.is_null());
-            state.as_ref().receive(u32::from(buf.read_volatile()));
-        }
-    }
-}
-
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer, that has
-/// the same size as [`PL011State`]. We also expect the device is
-/// readable/writeable from one thread at any time.
-pub unsafe extern "C" fn pl011_event(opaque: *mut c_void, event: QEMUChrEvent) {
-    let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
-    unsafe { state.as_ref().event(event) }
-}
-
 /// # Safety
 ///
 /// We expect the FFI user of this function to pass a valid pointer for `chr`
-- 
2.48.1


