Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C1AC19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 16:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnh1g-00009O-Fh; Thu, 27 Feb 2025 11:46:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnh1T-0008Sv-D9
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:46:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnh1J-0007qV-Nu
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740674753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jqB9iJokqmluSAsMEShYfyYzEVhrNHlSWPdg3LihApk=;
 b=WKzlhcoNlZUHRoRi1AKyu/6vA8n7akXKUG1l3a7BXdyurFwUPDCYva4amgPC3W5qAYEg4I
 Jckbj3fSsD8UyWHponfvJkmXK2RAU3yS0GwenIQYwow5WiscjgNNb7EQU0gq7FPXyeHLpn
 o5MrJUvU1XPyCWMnLJ7P6LutimXpj+w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-sJMHVgzbP-qCKuUZEhoafw-1; Thu, 27 Feb 2025 11:45:51 -0500
X-MC-Unique: sJMHVgzbP-qCKuUZEhoafw-1
X-Mimecast-MFC-AGG-ID: sJMHVgzbP-qCKuUZEhoafw_1740674750
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-abb8e0944bfso128219766b.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 08:45:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740674749; x=1741279549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jqB9iJokqmluSAsMEShYfyYzEVhrNHlSWPdg3LihApk=;
 b=jSe0l05+bAv8mwS2EzEcCcDI+8LShZQ03hzhKzbgiyR8lbj8myiL/X5WkDhg8aSRKP
 OcOF/SVoUC4Yi8DqQLSVkNQXfHlVIZN4vs89Z1YRL32npHHRKYzG6b9b8+THDDPtvkMj
 k2J66c4xcbIheflcZL2uvB3y8wO1gtWHasYMCceiyVWIYgPwGZE22tvvo0by/FCHnIPr
 Sqr6F+HfR455M4+TOlbTks3nRPTCy5eP6CUnI1CQTyvel5IGYt0tz48CH+/kh7DjxMyZ
 738aUjl+IjADK7r9TEXmzM7kO+fNEOCPR0mJw94MmMGgB1fV5V0hg9eoSS2SwdjSoZ20
 U3IQ==
X-Gm-Message-State: AOJu0YwzM5ApoIEMatrXofVS5Kvd7sSNTx6l7gnF++BKxpA4ZAHOQyUx
 HPOpR86axQfxwLsY10EVSwc7kFx1+xFX8zzFZOtzy38QCrbZHKNZED0CatlUWZ0VmPSkvuF8ABK
 cPvgSNcmoRiDTiRAxDg31oNwKH/BynZDZF9UMKcLZKhPh37duEJtvAteEmcqaAea/kiKmWRbRSQ
 CUd0Vrhxi2gB/0vg36cxCd+c62T5lrv0H7PJ2ouWU=
X-Gm-Gg: ASbGncvfRyeQcx7uV7bZWFqSXkCNc1cyVl6nFKk9HZ6lI4T/eGuU3enwPEdleeIxHbw
 VsseVsDfVxKpZIKRKuOvlHCO/Gnz1Rf/0NtdwctEfiZuSCbhu2uninNyauGG+7bSLw/T4FiI23A
 7JctxTY4JZuYYxbYG+LjPVOUk+xT55MtkQOxh2WrMo7ftlvcmdzaMj+2STtIgcbcu4pSYDSDWRe
 gikvrlFPpvyf7dhmm3gQmmmHoT0fHw6/bT+DpTDSkATyVIgO0yhx56NmQUD/PXH8d3OSYvTgxO1
 l5uxJUg/qxIFZVNQQg==
X-Received: by 2002:a17:906:da88:b0:abe:fed3:9eb8 with SMTP id
 a640c23a62f3a-abf2687fe85mr10584466b.41.1740674749088; 
 Thu, 27 Feb 2025 08:45:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiUSLoz/5h/sVOIyTG4cZUIUWywZC+7Ocvaw54WV8v2wYGoZqmW6mmP7rrKNmMD+kPyYuPCQ==
X-Received: by 2002:a17:906:da88:b0:abe:fed3:9eb8 with SMTP id
 a640c23a62f3a-abf2687fe85mr10580166b.41.1740674748602; 
 Thu, 27 Feb 2025 08:45:48 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c6ed7f1sm147260666b.120.2025.02.27.08.45.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 08:45:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 5/5] rust: pl011: pass around registers::Data
Date: Thu, 27 Feb 2025 17:45:34 +0100
Message-ID: <20250227164538.814576-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227164538.814576-1-pbonzini@redhat.com>
References: <20250227164538.814576-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

The values stored in the Fifo are instances of the bitfield-struct
registers::Data.  Convert as soon as possible the value written
into DR, and always refer to the bitfield struct; it's generally
cleaner other than PL011State::receive having to do a double
conversion u8=>u32=>registers::Data.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 2283bae71eb..a679f6295f5 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -237,7 +237,7 @@ pub(self) fn write(
         match offset {
             DR => {
                 // interrupts always checked
-                let _ = self.loopback_tx(value);
+                let _ = self.loopback_tx(value.into());
                 self.int_level |= Interrupt::TX.0;
                 return true;
             }
@@ -304,7 +304,7 @@ pub(self) fn write(
 
     #[inline]
     #[must_use]
-    fn loopback_tx(&mut self, value: u32) -> bool {
+    fn loopback_tx(&mut self, value: registers::Data) -> bool {
         // Caveat:
         //
         // In real hardware, TX loopback happens at the serial-bit level
@@ -373,7 +373,7 @@ fn loopback_mdmctrl(&mut self) -> bool {
     }
 
     fn loopback_break(&mut self, enable: bool) -> bool {
-        enable && self.loopback_tx(registers::Data::BREAK.into())
+        enable && self.loopback_tx(registers::Data::BREAK)
     }
 
     fn set_read_trigger(&mut self) {
@@ -432,11 +432,11 @@ pub fn fifo_depth(&self) -> u32 {
     }
 
     #[must_use]
-    pub fn put_fifo(&mut self, value: u32) -> bool {
+    pub fn put_fifo(&mut self, value: registers::Data) -> bool {
         let depth = self.fifo_depth();
         assert!(depth > 0);
         let slot = (self.read_pos + self.read_count) & (depth - 1);
-        self.read_fifo[slot] = registers::Data::from(value);
+        self.read_fifo[slot] = value;
         self.read_count += 1;
         self.flags.set_receive_fifo_empty(false);
         if self.read_count == depth {
@@ -581,7 +581,8 @@ fn receive(&self, buf: &[u8]) {
             return;
         }
         let mut regs = self.regs.borrow_mut();
-        let update_irq = !regs.loopback_enabled() && regs.put_fifo(buf[0].into());
+        let c: u32 = buf[0].into();
+        let update_irq = !regs.loopback_enabled() && regs.put_fifo(c.into());
         // Release the BqlRefCell before calling self.update()
         drop(regs);
 
@@ -594,7 +595,7 @@ fn event(&self, event: Event) {
         let mut update_irq = false;
         let mut regs = self.regs.borrow_mut();
         if event == Event::CHR_EVENT_BREAK && !regs.loopback_enabled() {
-            update_irq = regs.put_fifo(registers::Data::BREAK.into());
+            update_irq = regs.put_fifo(registers::Data::BREAK);
         }
         // Release the BqlRefCell before calling self.update()
         drop(regs);
-- 
2.48.1


