Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339EEC36017
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 01:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzPzR-0007Jw-MT; Mon, 31 Mar 2025 21:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saman@enumclass.cc>)
 id 1tzPzE-0007Io-Tf
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 21:00:18 -0400
Received: from out-13.smtp.spacemail.com ([63.250.43.96])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <saman@enumclass.cc>)
 id 1tzPz9-0003wx-4C
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 21:00:15 -0400
Received: from prod-lbout-phx.jellyfish.systems (unknown [198.177.122.3])
 by smtp.spacemail.com (Postfix) with ESMTPA id 4ZRV5x0QfvzC88G8
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:00:05 +0000 (UTC)
Received: from mailcore-5877cc4bb4-t27p4
 (ec2-54-185-60-75.us-west-2.compute.amazonaws.com [54.185.60.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.spacemail.com (Postfix) with ESMTPSA id 4ZRV5w47zYz6tkJ
 for <qemu-devel@nongnu.org>; Tue,  1 Apr 2025 01:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=enumclass.cc;
 s=spacemail; t=1743469204;
 bh=7FvAVPywJNW91D1DduDmWhVdHlvIpBCdnfZpA9HmhQU=;
 h=From:Date:Subject:To:References:In-Reply-To:From;
 b=TuhK1LLvRYwN+VKi0OxkYtASAT3ir53FfGwhI9L7H0Mn9DcnHybc9smHgNkUMKbNm
 klPO9qNOgloVz6J2iHr+yOgoGWFYLNmofDuRadQzI2JU0P3IhjKuifm7dVv01TVzip
 W1L/kXBf7kYANmJY6ci9JFJY4frCt8obTwUioWDf8HXriF59esBlILRkK5RgvtqdPm
 LirXQR+ljYM6Z9OWp8UcONFC1PaLuhkJem1HH7LQFYOVplpXssaj2vpDN47lxYu1aX
 YMjDN6L8A2MuWE9tsgrgOGJ3vB2ttQMIZ571xvVkdOQ84Xlo8pKTj30m/3eKQmu4l4
 CO4MqrtJbKBXw==
From: Saman Dehghan <saman@enumclass.cc>
Date: Tue, 01 Apr 2025 01:00:03 +0000
Subject: Re: [PATCH] Rust: Add tracing and logging support for Rust code
Message-Id: <8RFIA02ESPU4.MUW9SSD6NTTM3@mailcore-5877cc4bb4-t27p4>
To: qemu-devel@nongnu.org
References: <20250401002633.738345-1-saman@enumclass.cc>
In-Reply-To: <20250401002633.738345-1-saman@enumclass.cc>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="=-li5TH4lZWUqTEuErLWqkdg=="
Received-SPF: pass client-ip=63.250.43.96; envelope-from=saman@enumclass.cc;
 helo=out-13.smtp.spacemail.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--=-li5TH4lZWUqTEuErLWqkdg==
Content-Type: text/plain; charset=utf-8

I saw that `Bernhard Beschow` is working on the same thing. So, please feel free to close my pull request. Thank you :)






---
Saman Dehghan



Replying to qemu-devel@nongnu.org on March 31, 2025, 7:26 PM


From: saman@enumclass.cc

To: qemu-devel@nongnu.org

CC: stefanha@redhat.com, qemu-rust@nongnu.org, mads@ynddal.dk, manos.pitsidianakis@linaro.org, saman@enumclass.cc

Date: March 31, 2025, 7:26 PM

Subject: [PATCH] Rust: Add tracing and logging support for Rust code


      
      
   
   
This change introduces initial support for tracing and logging in Rust-based
QEMU code. As an example, tracing and logging have been implemented in the
pl011 device, which is written in Rust.

- Updated `rust/wrapper.h` to include the `qemu/log.h` and `hw/char/trace.h` header.
- Added log.rs to wrap `qemu_log_mask` and `qemu_log_mask_and_addr`
- Modified `tracetool` scripts to move C function implementation from
  header to .c
- Added log and trace in rust version of PL011 device

Future enhancements could include generating idiomatic Rust APIs for tracing
using the tracetool scripts

Signed-off-by: saman <saman@enumclass.cc>
---
 include/qemu/log-for-trace.h        |  5 +--
 rust/hw/char/pl011/src/device.rs    | 34 +++++++++++++++---
 rust/hw/char/pl011/src/registers.rs | 20 +++++++++++
 rust/qemu-api/meson.build           |  1 +
 rust/qemu-api/src/lib.rs            |  1 +
 rust/qemu-api/src/log.rs            | 54 +++++++++++++++++++++++++++++
 rust/wrapper.h                      |  2 ++
 scripts/tracetool/format/c.py       | 16 +++++++++
 scripts/tracetool/format/h.py       | 11 ++----
 util/log.c                          |  5 +++
 10 files changed, 131 insertions(+), 18 deletions(-)
 create mode 100644 rust/qemu-api/src/log.rs

diff --git a/include/qemu/log-for-trace.h b/include/qemu/log-for-trace.h
index d47c9cd446..ad5cd0dd24 100644
--- a/include/qemu/log-for-trace.h
+++ b/include/qemu/log-for-trace.h
@@ -24,10 +24,7 @@ extern int qemu_loglevel;
 #define LOG_TRACE          (1 << 15)
 
 /* Returns true if a bit is set in the current loglevel mask */
-static inline bool qemu_loglevel_mask(int mask)
-{
-    return (qemu_loglevel & mask) != 0;
-}
+bool qemu_loglevel_mask(int mask);
 
 /* main logging function */
 void G_GNUC_PRINTF(1, 2) qemu_log(const char *fmt, ...);
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index bf88e0b00a..42385a7bf6 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -2,15 +2,21 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::{ffi::CStr, mem::size_of, ptr::addr_of_mut};
+use std::{
+    ffi::{CStr, CString},
+    mem::size_of,
+    ptr::addr_of_mut,
+};
 
 use qemu_api::{
     chardev::{CharBackend, Chardev, Event},
     impl_vmstate_forward,
     irq::{IRQState, InterruptSource},
+    log::Mask,
     memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
     prelude::*,
     qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
+    qemu_log_mask,
     qom::{ObjectImpl, Owned, ParentField},
     static_assert,
     sysbus::{SysBusDevice, SysBusDeviceImpl},
@@ -298,7 +304,7 @@ pub(self) fn write(
             DMACR => {
                 self.dmacr = value;
                 if value & 3 > 0 {
-                    // qemu_log_mask(LOG_UNIMP, "pl011: DMA not implemented\n");
+                    qemu_log_mask!(Mask::log_unimp, "pl011: DMA not implemented\n");
                     eprintln!("pl011: DMA not implemented");
                 }
             }
@@ -535,11 +541,21 @@ fn read(&self, offset: hwaddr, _size: u32) -> u64 {
                 u64::from(device_id[(offset - 0xfe0) >> 2])
             }
             Err(_) => {
-                // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
+                qemu_log_mask!(
+                    Mask::log_guest_error,
+                    "pl011_read: Bad offset 0x%x\n",
+                    offset as i32
+                );
                 0
             }
             Ok(field) => {
+                let regname = field.as_str();
                 let (update_irq, result) = self.regs.borrow_mut().read(field);
+                let c_string = CString::new(regname).expect("CString::new failed");
+                let name_ptr = c_string.as_ptr();
+                unsafe {
+                    qemu_api::bindings::trace_pl011_read(offset as u32, result, name_ptr);
+                }
                 if update_irq {
                     self.update();
                     self.char_backend.accept_input();
@@ -576,8 +592,16 @@ fn write(&self, offset: hwaddr, value: u64, _size: u32) {
 
     fn can_receive(&self) -> u32 {
         let regs = self.regs.borrow();
-        // trace_pl011_can_receive(s->lcr, s->read_count, r);
-        u32::from(regs.read_count < regs.fifo_depth())
+        let fifo_available = u32::from(regs.read_count < regs.fifo_depth());
+        unsafe {
+            qemu_api::bindings::trace_pl011_can_receive(
+                u32::from(regs.line_control),
+                regs.read_count,
+                regs.fifo_depth().try_into().unwrap(),
+                fifo_available,
+            );
+        }
+        fifo_available
     }
 
     fn receive(&self, buf: &[u8]) {
diff --git a/rust/hw/char/pl011/src/registers.rs b/rust/hw/char/pl011/src/registers.rs
index cd92fa2c30..11c085030d 100644
--- a/rust/hw/char/pl011/src/registers.rs
+++ b/rust/hw/char/pl011/src/registers.rs
@@ -72,6 +72,26 @@ pub enum RegisterOffset {
     //Reserved = 0x04C,
 }
 
+impl RegisterOffset {
+    pub fn as_str(&self) -> &'static str {
+        match self {
+            RegisterOffset::DR => "DR",
+            RegisterOffset::RSR => "RSR",
+            RegisterOffset::FR => "FR",
+            RegisterOffset::FBRD => "FBRD",
+            RegisterOffset::ILPR => "ILPR",
+            RegisterOffset::IBRD => "IBRD",
+            RegisterOffset::LCR_H => "LCR_H",
+            RegisterOffset::CR => "CR",
+            RegisterOffset::FLS => "FLS",
+            RegisterOffset::IMSC => "IMSC",
+            RegisterOffset::RIS => "RIS",
+            RegisterOffset::MIS => "MIS",
+            RegisterOffset::ICR => "ICR",
+            RegisterOffset::DMACR => "DMACR",
+        }
+    }
+}
 /// Receive Status Register / Data Register common error bits
 ///
 /// The `UARTRSR` register is updated only when a read occurs
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 858685ddd4..f8eddf7887 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -34,6 +34,7 @@ _qemu_api_rs = static_library(
       'src/qom.rs',
       'src/sysbus.rs',
       'src/timer.rs',
+      'src/log.rs',
       'src/vmstate.rs',
       'src/zeroable.rs',
     ],
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 05f38b51d3..b54989a243 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -21,6 +21,7 @@
 pub mod chardev;
 pub mod errno;
 pub mod irq;
+pub mod log;
 pub mod memory;
 pub mod module;
 pub mod offset_of;
diff --git a/rust/qemu-api/src/log.rs b/rust/qemu-api/src/log.rs
new file mode 100644
index 0000000000..07e8bceb34
--- /dev/null
+++ b/rust/qemu-api/src/log.rs
@@ -0,0 +1,54 @@
+#[allow(non_camel_case_types)]
+#[repr(u32)]
+pub enum Mask {
+    cpu_log_tb_out_asm = crate::bindings::CPU_LOG_TB_OUT_ASM,
+    cpu_log_tb_in_asm = crate::bindings::CPU_LOG_TB_IN_ASM,
+    cpu_log_tb_op = crate::bindings::CPU_LOG_TB_OP,
+    cpu_log_tb_op_opt = crate::bindings::CPU_LOG_TB_OP_OPT,
+    cpu_log_int = crate::bindings::CPU_LOG_INT,
+    cpu_log_exec = crate::bindings::CPU_LOG_EXEC,
+    cpu_log_pcall = crate::bindings::CPU_LOG_PCALL,
+    cpu_log_tb_cpu = crate::bindings::CPU_LOG_TB_CPU,
+    cpu_log_reset = crate::bindings::CPU_LOG_RESET,
+    log_unimp = crate::bindings::LOG_UNIMP,
+    log_guest_error = crate::bindings::LOG_GUEST_ERROR,
+    cpu_log_mmu = crate::bindings::CPU_LOG_MMU,
+    cpu_log_tb_nochain = crate::bindings::CPU_LOG_TB_NOCHAIN,
+    cpu_log_page = crate::bindings::CPU_LOG_PAGE,
+    cpu_log_tb_op_ind = crate::bindings::CPU_LOG_TB_OP_IND,
+    cpu_log_tb_fpu = crate::bindings::CPU_LOG_TB_FPU,
+    cpu_log_plugin = crate::bindings::CPU_LOG_PLUGIN,
+    log_strace = crate::bindings::LOG_STRACE,
+    log_per_thread = crate::bindings::LOG_PER_THREAD,
+    cpu_log_tb_vpu = crate::bindings::CPU_LOG_TB_VPU,
+    log_tb_op_plugin = crate::bindings::LOG_TB_OP_PLUGIN,
+    log_invalid_mem = crate::bindings::LOG_INVALID_MEM,
+}
+
+#[macro_export]
+macro_rules! qemu_log_mask {
+    ($mask:expr, $fmt:expr $(, $arg:expr)*) => {{
+        let mask: Mask = $mask;
+        unsafe {
+            if $crate::bindings::qemu_loglevel_mask(mask as std::os::raw::c_int) {
+                let format_str = std::ffi::CString::new($fmt).expect("CString::new failed");
+                $crate::bindings::qemu_log(format_str.as_ptr() $(, $arg)*);
+            }
+        }
+    }};
+}
+
+#[macro_export]
+macro_rules! qemu_log_mask_and_addr {
+    ($mask:expr, $addr:expr, $fmt:expr $(, $arg:expr)*) => {{
+        let mask: Mask = $mask;
+        let addr: $crate::bindings::hwaddr = $addr;
+        unsafe {
+            if $crate::bindings::qemu_loglevel_mask(mask as std::os::raw::c_int) &&
+                $crate::bindings::qemu_log_in_addr_range(addr) {
+                let format_str = std::ffi::CString::new($fmt).expect("CString::new failed");
+                $crate::bindings::qemu_log(format_str.as_ptr() $(, $arg)*);
+            }
+        }
+    }};
+}
diff --git a/rust/wrapper.h b/rust/wrapper.h
index d4fec54657..cd2f311d71 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -64,5 +64,7 @@ typedef enum memory_order {
 #include "chardev/char-serial.h"
 #include "exec/memattrs.h"
 #include "qemu/timer.h"
+#include "qemu/log.h"
 #include "exec/address-spaces.h"
 #include "hw/char/pl011.h"
+#include "hw/char/trace.h"
diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
index 69edf0d588..f2d383f89c 100644
--- a/scripts/tracetool/format/c.py
+++ b/scripts/tracetool/format/c.py
@@ -43,6 +43,22 @@ def generate(events, backend, group):
             sstate = "TRACE_%s_ENABLED" % e.name.upper(),
             dstate = e.api(e.QEMU_DSTATE))
 
+        cond = "true"
+
+        out('',
+            'void %(api)s(%(args)s)',
+            '{',
+            '    if (%(cond)s) {',
+            '        %(api_nocheck)s(%(names)s);',
+            '    }',
+            '}',
+            api=e.api(),
+            api_nocheck=e.api(e.QEMU_TRACE_NOCHECK),
+            args=e.args,
+            names=", ".join(e.args.names()),
+            cond=cond
+            )
+
     out('TraceEvent *%(group)s_trace_events[] = {',
         group = group.lower())
 
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index ea126b07ea..16b360ae49 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -74,17 +74,10 @@ def generate(events, backend, group):
         cond = "true"
 
         out('',
-            'static inline void %(api)s(%(args)s)',
-            '{',
-            '    if (%(cond)s) {',
-            '        %(api_nocheck)s(%(names)s);',
-            '    }',
-            '}',
+            'void %(api)s(%(args)s);',
             api=e.api(),
-            api_nocheck=e.api(e.QEMU_TRACE_NOCHECK),
             args=e.args,
-            names=", ".join(e.args.names()),
-            cond=cond)
+            )
 
     backend.generate_end(events, group)
 
diff --git a/util/log.c b/util/log.c
index b87d399e4c..51f659be0a 100644
--- a/util/log.c
+++ b/util/log.c
@@ -143,6 +143,11 @@ void qemu_log_unlock(FILE *logfile)
     }
 }
 
+bool qemu_loglevel_mask(int mask)
+{
+    return (qemu_loglevel & mask) != 0;
+}
+
 void qemu_log(const char *fmt, ...)
 {
     FILE *f = qemu_log_trylock();
-- 
2.43.0
--=-li5TH4lZWUqTEuErLWqkdg==
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable


 <html >
   <head>
      <meta charset=3D"utf-8">
      <style>
body,
.spm-email {
    font: 400 1rem / 1.5 "GB Proxima Nova", -apple-system, BlinkMacSystemFo=
nt, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", =
"Segoe UI Emoji", "Segoe UI Symbol";
    overflow-y: hidden;
    color: var(--sds-color-text-neutral-primary, #2b2b2d);
    text-rendering: geometricprecision;
    -webkit-font-smoothing: antialiased;
}

pre {
    word-break: initial;
    white-space: pre-wrap;
}

blockquote,
.spm-email blockquote {
    margin: 16px 0 0;
    padding: 16px 0 0;
    color: var(--sds-color-text-neutral-primary, #2b2b2d);
    border-top: 1px solid var(--sds-color-border-neutral-subtle, #6f6e6f);
}

.spm-quoted-email--title,
.spm-email .spm-quoted-email--title {
    width: auto;
    display: inline-block;
    margin-bottom: 16px;
    color: var(--sds-color-text-neutral-secondary, #575860);
    font-size: .875rem;
    line-height: 1.25rem;
}

.spm-email .spm-signature-block {
    margin-top: 24px;
}

.spm-signature-block p {
    margin: 0;
}

.spm-embedded-image:not([width], [style*=3D"width"]) {
  max-inline-size: 100%;
  min-inline-size: 38px;
}

.spm-email hr,
hr {
    border: 0;
    height: 1px;
    background-color: var(--sds-color-border-inverted-minimal);
}
   =20
#spmEmailContainer {
    width: 100%;=20
    padding-bottom: 18px;
}</style>
   </head>
   <body class=3D"spm-email"><div style=3D"font-family: Arial, Helvetica, s=
ans-serif; font-size: 12pt;">I saw that `Bernhard Beschow` is working on th=
e same thing. So, please feel free to close my pull request. Thank you :)<b=
r></div><div class=3D"spm-empty-space"><br></div><div class=3D"spm-signatur=
e-block" style=3D"margin-top: 0px;" signatureid=3D"45460"><p>---<br>Saman D=
ehghan<br></p></div><blockquote type=3D"cite" class=3D"spm-quote-block" sty=
le=3D"margin: 0px;"><p class=3D"spm-quoted-email--title">Replying to qemu-d=
evel@nongnu.org on March 31, 2025, 7:26 PM</p><div><div>From: saman@enumcla=
ss.cc</div><div>To: qemu-devel@nongnu.org</div><div>CC: stefanha@redhat.com=
, qemu-rust@nongnu.org, mads@ynddal.dk, manos.pitsidianakis@linaro.org, sam=
an@enumclass.cc</div><div>Date: March 31, 2025, 7:26 PM</div><div>Subject: =
[PATCH] Rust: Add tracing and logging support for Rust code</div></div>
     =20
     =20
  =20
   <div id=3D"spmEmailContainer">This change introduces initial support for=
 tracing and logging in Rust-based<br>QEMU code. As an example, tracing and=
 logging have been implemented in the<br>pl011 device, which is written in =
Rust.<br><br>- Updated `rust/wrapper.h` to include the `qemu/log.h` and `hw=
/char/trace.h` header.<br>- Added log.rs to wrap `qemu_log_mask` and `qemu_=
log_mask_and_addr`<br>- Modified `tracetool` scripts to move C function imp=
lementation from<br>  header to .c<br>- Added log and trace in rust version=
 of PL011 device<br><br>Future enhancements could include generating idioma=
tic Rust APIs for tracing<br>using the tracetool scripts<br><br>Signed-off-=
by: saman &lt;saman@enumclass.cc&gt;<br>---<br> include/qemu/log-for-trace.=
h        |  5 +--<br> rust/hw/char/pl011/src/device.rs    | 34 ++++++++++++=
+++---<br> rust/hw/char/pl011/src/registers.rs | 20 +++++++++++<br> rust/qe=
mu-api/meson.build           |  1 +<br> rust/qemu-api/src/lib.rs           =
 |  1 +<br> rust/qemu-api/src/log.rs            | 54 ++++++++++++++++++++++=
+++++++<br> rust/wrapper.h                      |  2 ++<br> scripts/traceto=
ol/format/c.py       | 16 +++++++++<br> scripts/tracetool/format/h.py      =
 | 11 ++----<br> util/log.c                          |  5 +++<br> 10 files =
changed, 131 insertions(+), 18 deletions(-)<br> create mode 100644 rust/qem=
u-api/src/log.rs<br><br>diff --git a/include/qemu/log-for-trace.h b/include=
/qemu/log-for-trace.h<br>index d47c9cd446..ad5cd0dd24 100644<br>--- a/inclu=
de/qemu/log-for-trace.h<br>+++ b/include/qemu/log-for-trace.h<br>@@ -24,10 =
+24,7 @@ extern int qemu_loglevel;<br> #define LOG_TRACE          (1 &lt;&l=
t; 15)<br> <br> /* Returns true if a bit is set in the current loglevel mas=
k */<br>-static inline bool qemu_loglevel_mask(int mask)<br>-{<br>-    retu=
rn (qemu_loglevel &amp; mask) !=3D 0;<br>-}<br>+bool qemu_loglevel_mask(int=
 mask);<br> <br> /* main logging function */<br> void G_GNUC_PRINTF(1, 2) q=
emu_log(const char *fmt, ...);<br>diff --git a/rust/hw/char/pl011/src/devic=
e.rs b/rust/hw/char/pl011/src/device.rs<br>index bf88e0b00a..42385a7bf6 100=
644<br>--- a/rust/hw/char/pl011/src/device.rs<br>+++ b/rust/hw/char/pl011/s=
rc/device.rs<br>@@ -2,15 +2,21 @@<br> // Author(s): Manos Pitsidianakis &lt=
;manos.pitsidianakis@linaro.org&gt;<br> // SPDX-License-Identifier: GPL-2.0=
-or-later<br> <br>-use std::{ffi::CStr, mem::size_of, ptr::addr_of_mut};<br=
>+use std::{<br>+    ffi::{CStr, CString},<br>+    mem::size_of,<br>+    pt=
r::addr_of_mut,<br>+};<br> <br> use qemu_api::{<br>     chardev::{CharBacke=
nd, Chardev, Event},<br>     impl_vmstate_forward,<br>     irq::{IRQState, =
InterruptSource},<br>+    log::Mask,<br>     memory::{hwaddr, MemoryRegion,=
 MemoryRegionOps, MemoryRegionOpsBuilder},<br>     prelude::*,<br>     qdev=
::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, Resetta=
blePhasesImpl},<br>+    qemu_log_mask,<br>     qom::{ObjectImpl, Owned, Par=
entField},<br>     static_assert,<br>     sysbus::{SysBusDevice, SysBusDevi=
ceImpl},<br>@@ -298,7 +304,7 @@ pub(self) fn write(<br>             DMACR =3D=
&gt; {<br>                 self.dmacr =3D value;<br>                 if val=
ue &amp; 3 &gt; 0 {<br>-                    // qemu_log_mask(LOG_UNIMP, "pl=
011: DMA not implemented\n");<br>+                    qemu_log_mask!(Mask::=
log_unimp, "pl011: DMA not implemented\n");<br>                     eprintl=
n!("pl011: DMA not implemented");<br>                 }<br>             }<b=
r>@@ -535,11 +541,21 @@ fn read(&amp;self, offset: hwaddr, _size: u32) -&gt=
; u64 {<br>                 u64::from(device_id[(offset - 0xfe0) &gt;&gt; 2=
])<br>             }<br>             Err(_) =3D&gt; {<br>-                /=
/ qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offs=
et);<br>+                qemu_log_mask!(<br>+                    Mask::log_=
guest_error,<br>+                    "pl011_read: Bad offset 0x%x\n",<br>+ =
                   offset as i32<br>+                );<br>                =
 0<br>             }<br>             Ok(field) =3D&gt; {<br>+              =
  let regname =3D field.as_str();<br>                 let (update_irq, resu=
lt) =3D self.regs.borrow_mut().read(field);<br>+                let c_strin=
g =3D CString::new(regname).expect("CString::new failed");<br>+            =
    let name_ptr =3D c_string.as_ptr();<br>+                unsafe {<br>+  =
                  qemu_api::bindings::trace_pl011_read(offset as u32, resul=
t, name_ptr);<br>+                }<br>                 if update_irq {<br>=
                     self.update();<br>                     self.char_backe=
nd.accept_input();<br>@@ -576,8 +592,16 @@ fn write(&amp;self, offset: hwad=
dr, value: u64, _size: u32) {<br> <br>     fn can_receive(&amp;self) -&gt; =
u32 {<br>         let regs =3D self.regs.borrow();<br>-        // trace_pl0=
11_can_receive(s-&gt;lcr, s-&gt;read_count, r);<br>-        u32::from(regs.=
read_count &lt; regs.fifo_depth())<br>+        let fifo_available =3D u32::=
from(regs.read_count &lt; regs.fifo_depth());<br>+        unsafe {<br>+    =
        qemu_api::bindings::trace_pl011_can_receive(<br>+                u3=
2::from(regs.line_control),<br>+                regs.read_count,<br>+      =
          regs.fifo_depth().try_into().unwrap(),<br>+                fifo_a=
vailable,<br>+            );<br>+        }<br>+        fifo_available<br>  =
   }<br> <br>     fn receive(&amp;self, buf: &amp;[u8]) {<br>diff --git a/r=
ust/hw/char/pl011/src/registers.rs b/rust/hw/char/pl011/src/registers.rs<br=
>index cd92fa2c30..11c085030d 100644<br>--- a/rust/hw/char/pl011/src/regist=
ers.rs<br>+++ b/rust/hw/char/pl011/src/registers.rs<br>@@ -72,6 +72,26 @@ p=
ub enum RegisterOffset {<br>     //Reserved =3D 0x04C,<br> }<br> <br>+impl =
RegisterOffset {<br>+    pub fn as_str(&amp;self) -&gt; &amp;'static str {<=
br>+        match self {<br>+            RegisterOffset::DR =3D&gt; "DR",<b=
r>+            RegisterOffset::RSR =3D&gt; "RSR",<br>+            RegisterO=
ffset::FR =3D&gt; "FR",<br>+            RegisterOffset::FBRD =3D&gt; "FBRD"=
,<br>+            RegisterOffset::ILPR =3D&gt; "ILPR",<br>+            Regi=
sterOffset::IBRD =3D&gt; "IBRD",<br>+            RegisterOffset::LCR_H =3D&=
gt; "LCR_H",<br>+            RegisterOffset::CR =3D&gt; "CR",<br>+         =
   RegisterOffset::FLS =3D&gt; "FLS",<br>+            RegisterOffset::IMSC =
=3D&gt; "IMSC",<br>+            RegisterOffset::RIS =3D&gt; "RIS",<br>+    =
        RegisterOffset::MIS =3D&gt; "MIS",<br>+            RegisterOffset::=
ICR =3D&gt; "ICR",<br>+            RegisterOffset::DMACR =3D&gt; "DMACR",<b=
r>+        }<br>+    }<br>+}<br> /// Receive Status Register / Data Registe=
r common error bits<br> ///<br> /// The `UARTRSR` register is updated only =
when a read occurs<br>diff --git a/rust/qemu-api/meson.build b/rust/qemu-ap=
i/meson.build<br>index 858685ddd4..f8eddf7887 100644<br>--- a/rust/qemu-api=
/meson.build<br>+++ b/rust/qemu-api/meson.build<br>@@ -34,6 +34,7 @@ _qemu_=
api_rs =3D static_library(<br>       'src/qom.rs',<br>       'src/sysbus.rs=
',<br>       'src/timer.rs',<br>+      'src/log.rs',<br>       'src/vmstate=
.rs',<br>       'src/zeroable.rs',<br>     ],<br>diff --git a/rust/qemu-api=
/src/lib.rs b/rust/qemu-api/src/lib.rs<br>index 05f38b51d3..b54989a243 1006=
44<br>--- a/rust/qemu-api/src/lib.rs<br>+++ b/rust/qemu-api/src/lib.rs<br>@=
@ -21,6 +21,7 @@<br> pub mod chardev;<br> pub mod errno;<br> pub mod irq;<b=
r>+pub mod log;<br> pub mod memory;<br> pub mod module;<br> pub mod offset_=
of;<br>diff --git a/rust/qemu-api/src/log.rs b/rust/qemu-api/src/log.rs<br>=
new file mode 100644<br>index 0000000000..07e8bceb34<br>--- /dev/null<br>++=
+ b/rust/qemu-api/src/log.rs<br>@@ -0,0 +1,54 @@<br>+#[allow(non_camel_case=
_types)]<br>+#[repr(u32)]<br>+pub enum Mask {<br>+    cpu_log_tb_out_asm =3D=
 crate::bindings::CPU_LOG_TB_OUT_ASM,<br>+    cpu_log_tb_in_asm =3D crate::=
bindings::CPU_LOG_TB_IN_ASM,<br>+    cpu_log_tb_op =3D crate::bindings::CPU=
_LOG_TB_OP,<br>+    cpu_log_tb_op_opt =3D crate::bindings::CPU_LOG_TB_OP_OP=
T,<br>+    cpu_log_int =3D crate::bindings::CPU_LOG_INT,<br>+    cpu_log_ex=
ec =3D crate::bindings::CPU_LOG_EXEC,<br>+    cpu_log_pcall =3D crate::bind=
ings::CPU_LOG_PCALL,<br>+    cpu_log_tb_cpu =3D crate::bindings::CPU_LOG_TB=
_CPU,<br>+    cpu_log_reset =3D crate::bindings::CPU_LOG_RESET,<br>+    log=
_unimp =3D crate::bindings::LOG_UNIMP,<br>+    log_guest_error =3D crate::b=
indings::LOG_GUEST_ERROR,<br>+    cpu_log_mmu =3D crate::bindings::CPU_LOG_=
MMU,<br>+    cpu_log_tb_nochain =3D crate::bindings::CPU_LOG_TB_NOCHAIN,<br=
>+    cpu_log_page =3D crate::bindings::CPU_LOG_PAGE,<br>+    cpu_log_tb_op=
_ind =3D crate::bindings::CPU_LOG_TB_OP_IND,<br>+    cpu_log_tb_fpu =3D cra=
te::bindings::CPU_LOG_TB_FPU,<br>+    cpu_log_plugin =3D crate::bindings::C=
PU_LOG_PLUGIN,<br>+    log_strace =3D crate::bindings::LOG_STRACE,<br>+    =
log_per_thread =3D crate::bindings::LOG_PER_THREAD,<br>+    cpu_log_tb_vpu =
=3D crate::bindings::CPU_LOG_TB_VPU,<br>+    log_tb_op_plugin =3D crate::bi=
ndings::LOG_TB_OP_PLUGIN,<br>+    log_invalid_mem =3D crate::bindings::LOG_=
INVALID_MEM,<br>+}<br>+<br>+#[macro_export]<br>+macro_rules! qemu_log_mask =
{<br>+    ($mask:expr, $fmt:expr $(, $arg:expr)*) =3D&gt; {{<br>+        le=
t mask: Mask =3D $mask;<br>+        unsafe {<br>+            if $crate::bin=
dings::qemu_loglevel_mask(mask as std::os::raw::c_int) {<br>+              =
  let format_str =3D std::ffi::CString::new($fmt).expect("CString::new fail=
ed");<br>+                $crate::bindings::qemu_log(format_str.as_ptr() $(=
, $arg)*);<br>+            }<br>+        }<br>+    }};<br>+}<br>+<br>+#[mac=
ro_export]<br>+macro_rules! qemu_log_mask_and_addr {<br>+    ($mask:expr, $=
addr:expr, $fmt:expr $(, $arg:expr)*) =3D&gt; {{<br>+        let mask: Mask=
 =3D $mask;<br>+        let addr: $crate::bindings::hwaddr =3D $addr;<br>+ =
       unsafe {<br>+            if $crate::bindings::qemu_loglevel_mask(mas=
k as std::os::raw::c_int) &amp;&amp;<br>+                $crate::bindings::=
qemu_log_in_addr_range(addr) {<br>+                let format_str =3D std::=
ffi::CString::new($fmt).expect("CString::new failed");<br>+                =
$crate::bindings::qemu_log(format_str.as_ptr() $(, $arg)*);<br>+           =
 }<br>+        }<br>+    }};<br>+}<br>diff --git a/rust/wrapper.h b/rust/wr=
apper.h<br>index d4fec54657..cd2f311d71 100644<br>--- a/rust/wrapper.h<br>+=
++ b/rust/wrapper.h<br>@@ -64,5 +64,7 @@ typedef enum memory_order {<br> #i=
nclude "chardev/char-serial.h"<br> #include "exec/memattrs.h"<br> #include =
"qemu/timer.h"<br>+#include "qemu/log.h"<br> #include "exec/address-spaces.=
h"<br> #include "hw/char/pl011.h"<br>+#include "hw/char/trace.h"<br>diff --=
git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py<br>inde=
x 69edf0d588..f2d383f89c 100644<br>--- a/scripts/tracetool/format/c.py<br>+=
++ b/scripts/tracetool/format/c.py<br>@@ -43,6 +43,22 @@ def generate(event=
s, backend, group):<br>             sstate =3D "TRACE_%s_ENABLED" % e.name.=
upper(),<br>             dstate =3D e.api(e.QEMU_DSTATE))<br> <br>+        =
cond =3D "true"<br>+<br>+        out('',<br>+            'void %(api)s(%(ar=
gs)s)',<br>+            '{',<br>+            '    if (%(cond)s) {',<br>+   =
         '        %(api_nocheck)s(%(names)s);',<br>+            '    }',<br=
>+            '}',<br>+            api=3De.api(),<br>+            api_noche=
ck=3De.api(e.QEMU_TRACE_NOCHECK),<br>+            args=3De.args,<br>+      =
      names=3D", ".join(e.args.names()),<br>+            cond=3Dcond<br>+  =
          )<br>+<br>     out('TraceEvent *%(group)s_trace_events[] =3D {',<=
br>         group =3D group.lower())<br> <br>diff --git a/scripts/tracetool=
/format/h.py b/scripts/tracetool/format/h.py<br>index ea126b07ea..16b360ae4=
9 100644<br>--- a/scripts/tracetool/format/h.py<br>+++ b/scripts/tracetool/=
format/h.py<br>@@ -74,17 +74,10 @@ def generate(events, backend, group):<br=
>         cond =3D "true"<br> <br>         out('',<br>-            'static =
inline void %(api)s(%(args)s)',<br>-            '{',<br>-            '    i=
f (%(cond)s) {',<br>-            '        %(api_nocheck)s(%(names)s);',<br>=
-            '    }',<br>-            '}',<br>+            'void %(api)s(%(=
args)s);',<br>             api=3De.api(),<br>-            api_nocheck=3De.a=
pi(e.QEMU_TRACE_NOCHECK),<br>             args=3De.args,<br>-            na=
mes=3D", ".join(e.args.names()),<br>-            cond=3Dcond)<br>+         =
   )<br> <br>     backend.generate_end(events, group)<br> <br>diff --git a/=
util/log.c b/util/log.c<br>index b87d399e4c..51f659be0a 100644<br>--- a/uti=
l/log.c<br>+++ b/util/log.c<br>@@ -143,6 +143,11 @@ void qemu_log_unlock(FI=
LE *logfile)<br>     }<br> }<br> <br>+bool qemu_loglevel_mask(int mask)<br>=
+{<br>+    return (qemu_loglevel &amp; mask) !=3D 0;<br>+}<br>+<br> void qe=
mu_log(const char *fmt, ...)<br> {<br>     FILE *f =3D qemu_log_trylock();<=
br>-- <br>2.43.0<br><br></div>
</blockquote></body>
</html>=

--=-li5TH4lZWUqTEuErLWqkdg==--

