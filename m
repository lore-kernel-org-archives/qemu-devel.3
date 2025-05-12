Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD96C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEVBs-0000St-P1; Mon, 12 May 2025 11:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEVAE-0005qU-7v
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:34:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEVAC-0006pB-Il
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747064034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9rRJjZJliGh6hgVUcZDujfGoc4FtIeQ+1jIdIdwQh1g=;
 b=TtM+93OsVPehYTjQICtpjvMToNVUExba+2J7GVCjlt2HKFe8aP5n2kwJTxJLsWbFg2jYNy
 sWDkrVgK/KmB7oemb4Vos2DnG1OH9VgQa5AJva6iIeSpjIPhSj/PqbB+KBfMC71zA4F+DX
 39H6SCAioSn2RJOJZH+R+Nh5/vmQusk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-5-MCeVrkOmeMk1_kVXYKHQ-1; Mon, 12 May 2025 11:33:47 -0400
X-MC-Unique: 5-MCeVrkOmeMk1_kVXYKHQ-1
X-Mimecast-MFC-AGG-ID: 5-MCeVrkOmeMk1_kVXYKHQ_1747064025
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d0830c3f7so29145025e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 08:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747064024; x=1747668824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9rRJjZJliGh6hgVUcZDujfGoc4FtIeQ+1jIdIdwQh1g=;
 b=lGQvIGUrdCVF2Bl1b+cDA43sf/xmXLtngiODqBh4quZUyVUqV1SOakCEM1LSX7jvhd
 oje09ZjHEwOgAcQcXjrqL8iBEQqxpXBhSzfb76sZ6LY6Q49+8V6quQSPFlb9/YdkHUI/
 Izblj3xVs2hWvIrBZ7KGhVIDS7iAou5s2olbTIWzRs7PjXf110XpUu6WZVx66bw1qrY6
 +idsZuSSot0c3sCV33f8MLxXxJoKzCCoB15CzQ2bevMjtkQK8ISwOmZBiMY95ctytzF9
 b5bfrXsDN5go/spP94Gi0PosYSOHMMdC+VlD8sHr9lgWG8Yo8rnB3vd+Eptmq50T5KkO
 pjBA==
X-Gm-Message-State: AOJu0Yycx78aHxx3gV9AlkJEkUMMjIpU8CJ/OkzJJARHyutKwfshORme
 l641GPVigjHQaMbcPENwOZoQsgZUlHjQft074HMm8VhxWHpprNcrQMMzUejimfoTMasqmq/R2Xy
 fha0P0wQ+DxUTzLZCf81aTsMD1QcPWsc/QooPaaW3FvA3L6n6qadZLAnty7sUxpYQx+06pM3Fz3
 IEY7+HOp74Ri3gJagPGLVzX94KZgefsK8Z1vnS
X-Gm-Gg: ASbGncttGRKPu9npmg3DRunvrHXPyUE0Vxti/un/jRrz2hidOJft7bkmQ/z32vns6wt
 M69H98nS89lvH4jEPOCRy2IB/Rsx0rqizi9hdc2if8suUIY8txjBm1Rc+pspoTvMvJyEVYSd4s6
 AJ0LP/mwKec+2N+GI2mhhC7dq+M/SEbCs1nBZhl73rEpTA7uCMlVQM5rWL95bffzeHPTy9koiky
 SzbteJlqaMeJMsN/HdDLNMsgDyKH47+pYtBFz0OQIJ4GR5JHv5SQ4iNJuai1OiRBp7bt60aF5O2
 MfKKI79rw19bWrc=
X-Received: by 2002:a05:600c:609b:b0:43e:ee80:c233 with SMTP id
 5b1f17b1804b1-442da58fb92mr99665465e9.32.1747064024497; 
 Mon, 12 May 2025 08:33:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE098WxtRmT/xO07l/nrGw564wWISM+qym3s1c76k8Yg7Kgf8/TRQDrg7uva5CZW0I2tmMKDA==
X-Received: by 2002:a05:600c:609b:b0:43e:ee80:c233 with SMTP id
 5b1f17b1804b1-442da58fb92mr99665185e9.32.1747064024119; 
 Mon, 12 May 2025 08:33:44 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.45.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd34be0csm170700515e9.18.2025.05.12.08.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 08:33:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org
Subject: [PATCH 1/2] rust: pl011: Rename RX FIFO methods
Date: Mon, 12 May 2025 17:33:36 +0200
Message-ID: <20250512153337.153954-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512153337.153954-1-pbonzini@redhat.com>
References: <20250512153337.153954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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

In preparation of having a TX FIFO, rename the RX FIFO methods.
This is the Rust version of commit 40871ca758cf ("hw/char/pl011:
Rename RX FIFO methods").

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 7c563ade9cd..94b31659849 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -329,7 +329,7 @@ fn loopback_tx(&mut self, value: registers::Data) -> bool {
         // hardware flow-control is enabled.
         //
         // For simplicity, the above described is not emulated.
-        self.loopback_enabled() && self.put_fifo(value)
+        self.loopback_enabled() && self.fifo_rx_put(value)
     }
 
     #[must_use]
@@ -439,7 +439,7 @@ pub fn fifo_depth(&self) -> u32 {
     }
 
     #[must_use]
-    pub fn put_fifo(&mut self, value: registers::Data) -> bool {
+    pub fn fifo_rx_put(&mut self, value: registers::Data) -> bool {
         let depth = self.fifo_depth();
         assert!(depth > 0);
         let slot = (self.read_pos + self.read_count) & (depth - 1);
@@ -589,7 +589,7 @@ fn receive(&self, buf: &[u8]) {
         }
         let mut regs = self.regs.borrow_mut();
         let c: u32 = buf[0].into();
-        let update_irq = !regs.loopback_enabled() && regs.put_fifo(c.into());
+        let update_irq = !regs.loopback_enabled() && regs.fifo_rx_put(c.into());
         // Release the BqlRefCell before calling self.update()
         drop(regs);
 
@@ -602,7 +602,7 @@ fn event(&self, event: Event) {
         let mut update_irq = false;
         let mut regs = self.regs.borrow_mut();
         if event == Event::CHR_EVENT_BREAK && !regs.loopback_enabled() {
-            update_irq = regs.put_fifo(registers::Data::BREAK);
+            update_irq = regs.fifo_rx_put(registers::Data::BREAK);
         }
         // Release the BqlRefCell before calling self.update()
         drop(regs);
-- 
2.49.0


