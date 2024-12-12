Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3545E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 17:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLmtW-0006qE-T5; Thu, 12 Dec 2024 12:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLmtR-0006mt-4H
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:22:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLmtN-0006nI-54
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734024144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u6V2KCGpKcKJaSNdx7ZIwr1bDMF8vYPd7y6l/A6UdOQ=;
 b=IQDZ4FJqlnDHj5GsG90Jo8QvvlenH2UO07FHXuYJZOYQMFauLMZ7cZtHvxccpSNE75nT42
 FAub+9NMe4K46jflxTtiNESCYEsjDPx14r6WTjW6WoUw0cRvXdsTOdc/mVWUti8GdjuUA5
 ObcV7AbBUFEgN9IpocOMv3Jos2PFKvI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-z7KIu92xOeOmuKlopWI0Lg-1; Thu, 12 Dec 2024 12:22:22 -0500
X-MC-Unique: z7KIu92xOeOmuKlopWI0Lg-1
X-Mimecast-MFC-AGG-ID: z7KIu92xOeOmuKlopWI0Lg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-436228ebc5eso5427375e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 09:22:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734024141; x=1734628941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u6V2KCGpKcKJaSNdx7ZIwr1bDMF8vYPd7y6l/A6UdOQ=;
 b=bPm3jRT8lH43dkvcXwTD5stHoTwkVsu869oCPpdLdN90KGbegwMo5XaU73PMCXlDNL
 KccT0qUnUAF7wBdK6iV7RyVsX9R0wshvDrz2iRpe16rh1oSRz3xVSrBqQMD4yLJJ9ZPX
 ufFuBRi3HyN8nI/O3fBqKEaI7P/J2gI8FbJm4NVdBKOrrrc7HipAV6sNwMTtxibObFMl
 WIrsmuywbw63Aduit3mE29kh6sPymuo63Y0P3zB+NvdauYHdTbVe9UBZGmXkISNvctqk
 52Xk5j9BJe38KhY41P9Vm1y7uk2Zn9JjUPc/QsVinhlY099Qj3TEh0/tnGE0hJBdg8W5
 toVQ==
X-Gm-Message-State: AOJu0YwvjqGGzJN5nd31E2KoD0+0e8ZUeUaLuQjXLwGDmPBmg9evOYik
 cSffLKKJfOxCGDJ8Eu3VN33RG6Y62STmL0PVNJeiC1KsOT7/pg7kruFKNAARqA3bbeupD+flzVU
 7okD/tVW3+mcR164Jxd2fHqgfK9HP5BA+HW1cGLe4zHAtX5DWrDZNMA7fuOl0Y6JFt2xeRXwLGK
 HWT1E5lg8Ov87YUD7JrbTbsiJTxmXfFfIpLCR5
X-Gm-Gg: ASbGncsjjoFs/eN9zVMxJNBDE+qTMmp5CkQJS7i58Z3/Xnk9Sc9jfDOS3Dz1RSYxyHE
 8gYEKIv3dtEylH44Nl7TdZHmzoC4AsOzXGrHx7GfiqtDT80q9RAQRjI0nuuMyqWFqm5R0HUEbJx
 CkCEsVoS/gXmnHf7Q7oRz2iHp4kG83X0HySMFy/PgA93lLK8RdjE2+WP05421ZnIl+HLvudsOmp
 GmI94v71nA0ABW57aBq6AgcNv+YWSVhHCITtG1wiEhW+mkz8KQxfkx1LgHL
X-Received: by 2002:a05:600c:1d1d:b0:434:f335:83b with SMTP id
 5b1f17b1804b1-4361c344549mr61038445e9.5.1734024141033; 
 Thu, 12 Dec 2024 09:22:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5LiWj4pWCKznuzLNsiEJ08jd8fnoongVHTt0lL4NL6k4DsTSN6lkBCvK1s8BBcFEyk6kyTg==
X-Received: by 2002:a05:600c:1d1d:b0:434:f335:83b with SMTP id
 5b1f17b1804b1-4361c344549mr61038215e9.5.1734024140569; 
 Thu, 12 Dec 2024 09:22:20 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436255531fdsm22664625e9.2.2024.12.12.09.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 09:22:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	qemu-rust@nongnu.org
Subject: [PATCH 4/7] rust: pl011: fix break errors and definition of Data
 struct
Date: Thu, 12 Dec 2024 18:22:01 +0100
Message-ID: <20241212172209.533779-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212172209.533779-1-pbonzini@redhat.com>
References: <20241212172209.533779-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

The Data struct is wrong, and does not show how bits 8-15 of DR
are the receive status.  Fix it, and use it to fix break
errors ("c >> 8" in the C code does not translate to
"c.to_be_bytes()[3]").

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 15 ++++++------
 rust/hw/char/pl011/src/lib.rs    | 41 ++++++++++++++++++++++----------
 2 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index eb15e9d5788..e88ea24b00e 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -30,8 +30,6 @@
 /// Fractional Baud Rate Divider, `UARTFBRD`
 const FBRD_MASK: u32 = 0x3f;
 
-const DATA_BREAK: u32 = 1 << 10;
-
 /// QEMU sourced constant.
 pub const PL011_FIFO_DEPTH: usize = 16_usize;
 
@@ -68,7 +66,7 @@ pub struct PL011State {
     pub dmacr: u32,
     pub int_enabled: u32,
     pub int_level: u32,
-    pub read_fifo: [u32; PL011_FIFO_DEPTH],
+    pub read_fifo: [registers::Data; PL011_FIFO_DEPTH],
     pub ilpr: u32,
     pub ibrd: u32,
     pub fbrd: u32,
@@ -215,10 +213,11 @@ pub fn read(&mut self, offset: hwaddr, _size: c_uint) -> std::ops::ControlFlow<u
                     self.int_level &= !registers::INT_RX;
                 }
                 // Update error bits.
-                self.receive_status_error_clear = c.to_be_bytes()[3].into();
+                self.receive_status_error_clear.set_from_data(c);
                 self.update();
                 // Must call qemu_chr_fe_accept_input, so return Continue:
-                return std::ops::ControlFlow::Continue(c.into());
+                let c = u32::from(c);
+                return std::ops::ControlFlow::Continue(u64::from(c));
             }
             Ok(RSR) => u8::from(self.receive_status_error_clear).into(),
             Ok(FR) => u16::from(self.flags).into(),
@@ -411,7 +410,7 @@ fn loopback_mdmctrl(&mut self) {
 
     fn loopback_break(&mut self, enable: bool) {
         if enable {
-            self.loopback_tx(DATA_BREAK);
+            self.loopback_tx(registers::Data::BREAK.into());
         }
     }
 
@@ -475,7 +474,7 @@ pub fn can_receive(&self) -> bool {
 
     pub fn event(&mut self, event: QEMUChrEvent) {
         if event == bindings::QEMUChrEvent::CHR_EVENT_BREAK && !self.loopback_enabled() {
-            self.put_fifo(DATA_BREAK);
+            self.put_fifo(registers::Data::BREAK.into());
         }
     }
 
@@ -502,7 +501,7 @@ pub fn put_fifo(&mut self, value: c_uint) {
         let depth = self.fifo_depth();
         assert!(depth > 0);
         let slot = (self.read_pos + self.read_count) & (depth - 1);
-        self.read_fifo[slot] = value;
+        self.read_fifo[slot] = registers::Data::from(value);
         self.read_count += 1;
         self.flags.set_receive_fifo_empty(false);
         if self.read_count == depth {
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index e3eacb0e6b9..463ae60543b 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -139,6 +139,21 @@ pub mod registers {
     //! unused thus treated as zero when read or written.
     use bilge::prelude::*;
 
+    /// Receive Status Register / Data Register common error bits
+    ///
+    /// The `UARTRSR` register is updated only when a read occurs
+    /// from the `UARTDR` register with the same status information
+    /// that can also be obtained by reading the `UARTDR` register
+    #[bitsize(8)]
+    #[derive(Clone, Copy, Default, DebugBits, FromBits)]
+    pub struct Errors {
+        pub framing_error: bool,
+        pub parity_error: bool,
+        pub break_error: bool,
+        pub overrun_error: bool,
+        _reserved_unpredictable: u4,
+    }
+
     // TODO: FIFO Mode has different semantics
     /// Data Register, `UARTDR`
     ///
@@ -181,16 +196,18 @@ pub mod registers {
     ///
     /// # Source
     /// ARM DDI 0183G 3.3.1 Data Register, UARTDR
-    #[bitsize(16)]
-    #[derive(Clone, Copy, DebugBits, FromBits)]
+    #[bitsize(32)]
+    #[derive(Clone, Copy, Default, DebugBits, FromBits)]
     #[doc(alias = "UARTDR")]
     pub struct Data {
-        _reserved: u4,
         pub data: u8,
-        pub framing_error: bool,
-        pub parity_error: bool,
-        pub break_error: bool,
-        pub overrun_error: bool,
+        pub errors: Errors,
+        _reserved: u16,
+    }
+
+    impl Data {
+        // bilge is not very const-friendly, unfortunately
+        pub const BREAK: Self = Self { value: 1 << 10 };
     }
 
     // TODO: FIFO Mode has different semantics
@@ -220,14 +237,14 @@ pub struct Data {
     #[bitsize(8)]
     #[derive(Clone, Copy, DebugBits, FromBits)]
     pub struct ReceiveStatusErrorClear {
-        pub framing_error: bool,
-        pub parity_error: bool,
-        pub break_error: bool,
-        pub overrun_error: bool,
-        _reserved_unpredictable: u4,
+        pub errors: Errors,
     }
 
     impl ReceiveStatusErrorClear {
+        pub fn set_from_data(&mut self, data: Data) {
+            self.set_errors(data.errors());
+        }
+
         pub fn reset(&mut self) {
             // All the bits are cleared to 0 on reset.
             *self = Self::default();
-- 
2.47.1


