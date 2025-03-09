Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDB7C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 10:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trDxE-0000GY-Dz; Sun, 09 Mar 2025 06:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDx3-0008Km-Hx
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:32:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDx1-00044x-V9
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741516327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wbOO8hVPA/iWAR/aAhdUbZRw20JyRLfj8f5+lfhW6z4=;
 b=f56xFQ/q5fRRJ5xKwH10x7sJzVgqR7d66isShiuPnevRosR6+0c/h4xqoMDV4ufrQpDElV
 0fByPyWKgTZyentDyLvCLdt4VDLoB+A12UqZaesIMAKXS9G/imfW5+V8WADy/nnngHxZkG
 7gcXcxfHvtJmZW0bTc+SZk/SexSRctE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-ZD91VZRqMv2_raEFtfK2tw-1; Sun, 09 Mar 2025 06:32:05 -0400
X-MC-Unique: ZD91VZRqMv2_raEFtfK2tw-1
X-Mimecast-MFC-AGG-ID: ZD91VZRqMv2_raEFtfK2tw_1741516324
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4388eee7073so19653695e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 03:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741516324; x=1742121124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wbOO8hVPA/iWAR/aAhdUbZRw20JyRLfj8f5+lfhW6z4=;
 b=AGK0qh0Xa8a/nmnbvXGSTu3C1pWHZYuDnZBPFt+xeD8r2nb8ntmp5/ra3FeCQAjIvd
 +JiBf32hLIxpXDDNv1iGV3KU7dJ2a2KEDHS0pFniJPxUCKmHE1ZUY8yxYX7t3bH0EHnJ
 mFb0aRyCFZt1IRydYeh2NUipAFYhaaRuGNc81/mvnxEX9Hpb7WNp2pD7orxIMZgOG0Bs
 8EDXX11V/W+aag+hkXjM9GJnAL1+HeCLcB5gVNiDdb9EOgDjhuPxtQV5WkCQoafpE8+k
 9JdjAGwO7pit2jUJEQFEvl88a1cwxsueTTFwtiwtvq+BEmdfM/XTaXPNvPGvBQJytCoD
 vy2Q==
X-Gm-Message-State: AOJu0YxCyvam0bHiLvp9R9hyWYC/Wc0+RggL7KAr4iWwi+g17lsxMhcx
 PpUxBIxIl50PVNSS1u6yCWJp/+KKhp3u67hi4BZlmo8AcTqZFkEgxRRe4mFZAU2q1WHNSdvlBNX
 EH7Qxnd2xBEce+MBRRchPz6XpQszzYX9ZorlXzYc8tkPc3CMdAGcKv2QdiKXBrGN4FYxfeXvWsC
 66pLiXFwkXglEX6naAk5LW6+/mutWqrKLQdY0UMGg=
X-Gm-Gg: ASbGncuq2fAZaGd3StVRBKW5ZH5lH++VNwLtPpvd2EIvBIIiyRAIndK/jVQUhsS38zn
 Dghy0VGhCtpc8NUIDVGh5R2a2CYrpD3aN32yUo0wB5sy0W2Q40WsAD6Zst2DQ4AOg+2G8Qhy8rj
 /cud9x8APHpy45+Y5NQkSTF27f9lqVXR/X1RiTfzpTtXmqj2C/q/eFYhzKjYWgosIEhlYedXTG6
 5G+V5NrU1zg5XlefBE6qdA7iEi0k4cf4v7pTosp5ueuYNWHW0u7/0Sgub46UuKbLuT3uty6WM03
 gM/KFTvLbyCaATHPBL9zzA==
X-Received: by 2002:a05:600c:754:b0:43b:bfa7:c7d with SMTP id
 5b1f17b1804b1-43ce4aa8771mr35085235e9.2.1741516323984; 
 Sun, 09 Mar 2025 03:32:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4U1sgQ7Yw11hS4ilbfOvsS17ZMTC35iONV4y2gUHL6UcXuIB0x3ffoCM4oxaREM4OhAelVA==
X-Received: by 2002:a05:600c:754:b0:43b:bfa7:c7d with SMTP id
 5b1f17b1804b1-43ce4aa8771mr35085035e9.2.1741516323467; 
 Sun, 09 Mar 2025 03:32:03 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8b0461sm114516235e9.4.2025.03.09.03.32.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 03:32:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/25] rust: pl011: pass around registers::Data
Date: Sun,  9 Mar 2025 11:31:14 +0100
Message-ID: <20250309103120.1116448-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309103120.1116448-1-pbonzini@redhat.com>
References: <20250309103120.1116448-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
index 4e282bc9e9d..af93ae8bebe 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -234,7 +234,7 @@ pub(self) fn write(
         match offset {
             DR => {
                 // interrupts always checked
-                let _ = self.loopback_tx(value);
+                let _ = self.loopback_tx(value.into());
                 self.int_level |= Interrupt::TX.0;
                 return true;
             }
@@ -301,7 +301,7 @@ pub(self) fn write(
 
     #[inline]
     #[must_use]
-    fn loopback_tx(&mut self, value: u32) -> bool {
+    fn loopback_tx(&mut self, value: registers::Data) -> bool {
         // Caveat:
         //
         // In real hardware, TX loopback happens at the serial-bit level
@@ -370,7 +370,7 @@ fn loopback_mdmctrl(&mut self) -> bool {
     }
 
     fn loopback_break(&mut self, enable: bool) -> bool {
-        enable && self.loopback_tx(registers::Data::BREAK.into())
+        enable && self.loopback_tx(registers::Data::BREAK)
     }
 
     fn set_read_trigger(&mut self) {
@@ -429,11 +429,11 @@ pub fn fifo_depth(&self) -> u32 {
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
@@ -578,7 +578,8 @@ fn receive(&self, buf: &[u8]) {
             return;
         }
         let mut regs = self.regs.borrow_mut();
-        let update_irq = !regs.loopback_enabled() && regs.put_fifo(buf[0].into());
+        let c: u32 = buf[0].into();
+        let update_irq = !regs.loopback_enabled() && regs.put_fifo(c.into());
         // Release the BqlRefCell before calling self.update()
         drop(regs);
 
@@ -591,7 +592,7 @@ fn event(&self, event: Event) {
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


