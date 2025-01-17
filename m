Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567B1C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 09:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYidT-0002c7-A3; Fri, 17 Jan 2025 04:27:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYidR-0002be-Rz
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:27:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYidO-0003S8-0p
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737106041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=538rbrB5J5+iKYFhFGUAKX87kAz6wpkNaI2Nuc/tl2c=;
 b=Alzo2H7PjS+6TbpZhb0uTHaKdftLykdXno0HdKQpu/KHN58ScOkeNbIvz9+NuSrBHCmfZj
 m660AtDga8H+UI3abf3B6U0aoSsKEhYmHuT/uGeE6t3h5oXo4uL7J+ysJA3qLqMNcELGLL
 8GTpNpEv0Ocy8WnK2rpsQJD0afyP1o8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-Syxuow68MSKB7yo_uGLjlg-1; Fri, 17 Jan 2025 04:27:19 -0500
X-MC-Unique: Syxuow68MSKB7yo_uGLjlg-1
X-Mimecast-MFC-AGG-ID: Syxuow68MSKB7yo_uGLjlg
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa634496f58so186393866b.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 01:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737106038; x=1737710838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=538rbrB5J5+iKYFhFGUAKX87kAz6wpkNaI2Nuc/tl2c=;
 b=wg77tZERefBD+bvaEfqjvoMKSMI78bvy2nJOrP/0UcTixcYj88yEbcc5A/FYvX6qx4
 duFjP52QHNSDjuGRT6SEgJz5Eret4lPj5HmsZTMXjzP5Irbw+aT43wwNUZ0qjb2I2/cc
 1wmhY7sl4WVTJevzb5xbhJjoTPTtc8V+AElp8ityNj9mqWFojTqSh+ytj+6BB+Qmsany
 rWvY0qK7Ndymn1BSt/njGkdiyt68wbhYnR68zgDWU56baaUiUum7dvefHo4kIxjrd4ew
 RoHBxLNLd4xOpjwtce/MLgd8nVZSTWeO6pax4XNzDQwWelGLU/Qr5auIKv8adny2XFQV
 lnEQ==
X-Gm-Message-State: AOJu0YyUrWLJ3cigFoOPbkXuhG949ZtEUpSkf296I8h2lXItzmLsPocu
 mJU0ovk481CVZpvGmuTlNXvmbKhBLEyG+rREW+DHD7xHJZ9uUkKdn3MvDblD1Nf/ZMXxXiiU8tN
 pQqFMn6qnbvKh8fPBsSIq5iZyRGJ+xoEFuEiT+5B+qgyJiagZ60rGqtkkuVEaIsiIh7C6zVWC9c
 254bQBhiV3R5OvIRq8vs7DR9I2rrSiUmOYzGoDVfk=
X-Gm-Gg: ASbGncsxoV9ZoDOtMUC7P1X3lMMD27xxrkNrp+RIKqdTNnELgi0nymukc4k1CZBNoV0
 5+6NZh3P1axvTdzrfmBNtyMd2v9kKlhiKxpE7E7zP7+udusaB32GTPHokgKbKNcHk9pk2c2ixKS
 PBnnklL9KeQuL/d33QPgUqFns/dk1JwMnff2iCuvBKshdrvKmEDhkO8VFyf+rwbt+rb3Rrv15gA
 ZZhOjgHwKia4lDjkYCxtch6/T9NcWoqAoTahe/DVvTeroPiT8TpzIQul7HD
X-Received: by 2002:a17:907:7da2:b0:aa6:8a1b:8b84 with SMTP id
 a640c23a62f3a-ab38b5342demr211529066b.57.1737106037641; 
 Fri, 17 Jan 2025 01:27:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVqG+RfH01JbScVMhK0hergPcEkoF02jSu7bcLe4UjTPb/cCZHpm3dL7gwCCHZiJ7iTX4U9Q==
X-Received: by 2002:a17:907:7da2:b0:aa6:8a1b:8b84 with SMTP id
 a640c23a62f3a-ab38b5342demr211526766b.57.1737106037144; 
 Fri, 17 Jan 2025 01:27:17 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384c61388sm138174466b.20.2025.01.17.01.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 01:27:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 08/10] rust: pl011: remove duplicate definitions
Date: Fri, 17 Jan 2025 10:26:55 +0100
Message-ID: <20250117092657.1051233-9-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Unify the "Interrupt" enum and the "INT_*" constants with a struct
that contains the bits.  The "int_level" and "int_enabled" fields
could use a crate such as "bitflags".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 36 ++++++++++++-------------
 rust/hw/char/pl011/src/lib.rs    | 46 +++++++++++---------------------
 2 files changed, 33 insertions(+), 49 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 1d3da59e481..6ecbfb9ac84 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -183,7 +183,7 @@ pub(self) fn read(&mut self, offset: RegisterOffset) -> ControlFlow<u32, u32> {
                     self.flags.set_receive_fifo_empty(true);
                 }
                 if self.read_count + 1 == self.read_trigger {
-                    self.int_level &= !registers::INT_RX;
+                    self.int_level &= !Interrupt::RX.0;
                 }
                 // Update error bits.
                 self.receive_status_error_clear.set_from_data(c);
@@ -232,7 +232,7 @@ pub(self) fn write(
                 }
                 // interrupts always checked
                 let _ = self.loopback_tx(value);
-                self.int_level |= registers::INT_TX;
+                self.int_level |= Interrupt::TX.0;
                 return true;
             }
             RSR => {
@@ -356,19 +356,19 @@ fn loopback_mdmctrl(&mut self) -> bool {
         // Change interrupts based on updated FR
         let mut il = self.int_level;
 
-        il &= !Interrupt::MS;
+        il &= !Interrupt::MS.0;
 
         if self.flags.data_set_ready() {
-            il |= Interrupt::DSR as u32;
+            il |= Interrupt::DSR.0;
         }
         if self.flags.data_carrier_detect() {
-            il |= Interrupt::DCD as u32;
+            il |= Interrupt::DCD.0;
         }
         if self.flags.clear_to_send() {
-            il |= Interrupt::CTS as u32;
+            il |= Interrupt::CTS.0;
         }
         if self.flags.ring_indicator() {
-            il |= Interrupt::RI as u32;
+            il |= Interrupt::RI.0;
         }
         self.int_level = il;
         true
@@ -446,7 +446,7 @@ pub fn put_fifo(&mut self, value: u32) -> bool {
         }
 
         if self.read_count == self.read_trigger {
-            self.int_level |= registers::INT_RX;
+            self.int_level |= Interrupt::RX.0;
             return true;
         }
         false
@@ -622,16 +622,16 @@ pub fn post_load(&self, _version_id: u32) -> Result<(), ()> {
 /// Which bits in the interrupt status matter for each outbound IRQ line ?
 const IRQMASK: [u32; 6] = [
     /* combined IRQ */
-    Interrupt::E
-        | Interrupt::MS
-        | Interrupt::RT as u32
-        | Interrupt::TX as u32
-        | Interrupt::RX as u32,
-    Interrupt::RX as u32,
-    Interrupt::TX as u32,
-    Interrupt::RT as u32,
-    Interrupt::MS,
-    Interrupt::E,
+    Interrupt::E.0
+        | Interrupt::MS.0
+        | Interrupt::RT.0
+        | Interrupt::TX.0
+        | Interrupt::RX.0,
+    Interrupt::RX.0,
+    Interrupt::TX.0,
+    Interrupt::RT.0,
+    Interrupt::MS.0,
+    Interrupt::E.0,
 ];
 
 /// # Safety
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index 2baacba2306..300c732ae1d 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -100,7 +100,6 @@ enum RegisterOffset {
     //Reserved = 0x04C,
 }
 
-#[allow(dead_code)]
 mod registers {
     //! Device registers exposed as typed structs which are backed by arbitrary
     //! integer bitmaps. [`Data`], [`Control`], [`LineControl`], etc.
@@ -521,38 +520,23 @@ fn default() -> Self {
     }
 
     /// Interrupt status bits in UARTRIS, UARTMIS, UARTIMSC
-    pub const INT_OE: u32 = 1 << 10;
-    pub const INT_BE: u32 = 1 << 9;
-    pub const INT_PE: u32 = 1 << 8;
-    pub const INT_FE: u32 = 1 << 7;
-    pub const INT_RT: u32 = 1 << 6;
-    pub const INT_TX: u32 = 1 << 5;
-    pub const INT_RX: u32 = 1 << 4;
-    pub const INT_DSR: u32 = 1 << 3;
-    pub const INT_DCD: u32 = 1 << 2;
-    pub const INT_CTS: u32 = 1 << 1;
-    pub const INT_RI: u32 = 1 << 0;
-    pub const INT_E: u32 = INT_OE | INT_BE | INT_PE | INT_FE;
-    pub const INT_MS: u32 = INT_RI | INT_DSR | INT_DCD | INT_CTS;
-
-    #[repr(u32)]
-    pub enum Interrupt {
-        OE = 1 << 10,
-        BE = 1 << 9,
-        PE = 1 << 8,
-        FE = 1 << 7,
-        RT = 1 << 6,
-        TX = 1 << 5,
-        RX = 1 << 4,
-        DSR = 1 << 3,
-        DCD = 1 << 2,
-        CTS = 1 << 1,
-        RI = 1 << 0,
-    }
+    pub struct Interrupt(pub u32);
 
     impl Interrupt {
-        pub const E: u32 = INT_OE | INT_BE | INT_PE | INT_FE;
-        pub const MS: u32 = INT_RI | INT_DSR | INT_DCD | INT_CTS;
+        pub const OE: Self = Self(1 << 10);
+        pub const BE: Self = Self(1 << 9);
+        pub const PE: Self = Self(1 << 8);
+        pub const FE: Self = Self(1 << 7);
+        pub const RT: Self = Self(1 << 6);
+        pub const TX: Self = Self(1 << 5);
+        pub const RX: Self = Self(1 << 4);
+        pub const DSR: Self = Self(1 << 3);
+        pub const DCD: Self = Self(1 << 2);
+        pub const CTS: Self = Self(1 << 1);
+        pub const RI: Self = Self(1 << 0);
+
+        pub const E: Self = Self(Self::OE.0 | Self::BE.0 | Self::PE.0 | Self::FE.0);
+        pub const MS: Self = Self(Self::RI.0 | Self::DSR.0 | Self::DCD.0 | Self::CTS.0);
     }
 }
 
-- 
2.47.1


