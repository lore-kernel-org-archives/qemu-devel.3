Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CBBC7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSeoA-0006bH-8Z; Fri, 20 Jun 2025 12:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeo6-0006aG-Fw
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeo4-0000HB-Kp
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750437694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m09gyrXVI69lguFqQqhapy6DhI44HdNH8ReXpoV/H/Y=;
 b=WQwZ/61/zHzjVHubL9Fs8RmrJ7Sb5IMtGknBuHKuREbnSt2psNz1ICuTcO4QTr+8M+PNWt
 wYRfvvcYcYJ6D7xh5cdLuVGkqUpKK4ebJWnw+n7kJ/4bw/TN+Ydi3ghxBdq8qwD9CLMd6e
 xeDoOAvSPvBZ5GLsvsfjwgniFYLhXHI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-qhjya6dHMq-RFeI4ZBak_A-1; Fri, 20 Jun 2025 12:41:32 -0400
X-MC-Unique: qhjya6dHMq-RFeI4ZBak_A-1
X-Mimecast-MFC-AGG-ID: qhjya6dHMq-RFeI4ZBak_A_1750437692
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-60785397a37so1970302a12.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750437691; x=1751042491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m09gyrXVI69lguFqQqhapy6DhI44HdNH8ReXpoV/H/Y=;
 b=wTkWeENavxo+9WH9PsM574yU79JiM7TuM8rdPlWrrw0ZcAXzKty7TyfrHRCcsWVmct
 ZysJisV3JW1bNivQC9qZBLg79c30hDYzqQ7kFPh/AlxzNlPe4kpi9ZcslGGA+JhdrSKb
 mTWIBGWr/O4rwzeW43MoFXArf4bMS7ysxRGDQsW8D4CnZYyJ1993yMk66AYCUzWUYU9d
 BIFblbjSX1GllrbiVVgwdI2BASMBWjl3LtXnOGFtagommjGbRMOb1yyJYraiVnQXbubj
 iMr/RxaDi0ra4mJVtWKfsNcn1FSXrBHzvcAvSY8snwoP5lTZWRHSAGCG/ZyXiRMq41DT
 hvvw==
X-Gm-Message-State: AOJu0YxRcO8HFf5KFmptE3Vdn1a+FRRFWI/96QpHv9WH+GurRHKrEEGh
 IB5a9BSP43ob4NrjGvhQB+crT7zUvuKVjyUenrKNJIkshYBeYZ//EO+yKy1DJaJBQfAhVBEMUra
 xZSo63kviG6WDgzp2CUY9it9NEo8xhPSKVfSUdnXcxtfdJZQa4CioSx2GRCVyTHMTA0+3x5kJaP
 kmfp1rqKklCIW+4K1EvhOSJubTVSfseJtxI22sR+0Z
X-Gm-Gg: ASbGncsGcsM2km2zoi7Ynm096GyskuHFSu+JR8kZTumF1ksk4KQnPYS/IDDcPTKoGqv
 IRHrFUPGxZg5etKdlpSoYorGiqU176tEod8/GMawthLJM/sFTvgCrata511TwASiX+KkmfHSAIR
 arpNkS+dHhQzkI37DVKgBxEK6NuwsBS5CE5OYtMbl7738Ho9QKxvbktWbI3MAs89+QHTzuOvcTo
 Xd/xhD48iv+Fbdp5WrEytkxpNjHtWobB3TIFb1KCptLWb4DxUJMUhhEdNbDmX3zxjGveyLo8LgH
 Smt/mYUUxiYFWKiGeVxDuKf2mg==
X-Received: by 2002:a05:6402:3546:b0:607:19a6:9f1d with SMTP id
 4fb4d7f45d1cf-60a1cd3206dmr3413679a12.14.1750437691226; 
 Fri, 20 Jun 2025 09:41:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR614FVv/R2yCgf5Ei0LXIAbyWz9IHUQeJln+17GXwTuLoGBhTb4d1DESDCiOMg1d5qLISGg==
X-Received: by 2002:a05:6402:3546:b0:607:19a6:9f1d with SMTP id
 4fb4d7f45d1cf-60a1cd3206dmr3413645a12.14.1750437690794; 
 Fri, 20 Jun 2025 09:41:30 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae05408306fsm183794066b.84.2025.06.20.09.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:41:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>
Subject: [PULL 13/24] rust: pl011: Implement logging
Date: Fri, 20 Jun 2025 18:40:41 +0200
Message-ID: <20250620164053.579416-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620164053.579416-1-pbonzini@redhat.com>
References: <20250620164053.579416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

From: Bernhard Beschow <shentey@gmail.com>

Now that there is logging support in Rust for QEMU, use it in the pl011
device.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Link: https://lore.kernel.org/r/20250615112037.11992-3-shentey@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 2d416cd9a3c..92dc295540e 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -8,6 +8,8 @@
     chardev::{CharBackend, Chardev, Event},
     impl_vmstate_forward,
     irq::{IRQState, InterruptSource},
+    log::Log,
+    log_mask_ln,
     memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
     prelude::*,
     qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
@@ -276,8 +278,7 @@ pub(self) fn write(
             DMACR => {
                 self.dmacr = value;
                 if value & 3 > 0 {
-                    // qemu_log_mask(LOG_UNIMP, "pl011: DMA not implemented\n");
-                    eprintln!("pl011: DMA not implemented");
+                    log_mask_ln!(Log::Unimp, "pl011: DMA not implemented");
                 }
             }
         }
@@ -534,7 +535,7 @@ fn read(&self, offset: hwaddr, _size: u32) -> u64 {
                 u64::from(device_id[(offset - 0xfe0) >> 2])
             }
             Err(_) => {
-                // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
+                log_mask_ln!(Log::GuestError, "PL011State::read: Bad offset {offset}");
                 0
             }
             Ok(field) => {
@@ -566,7 +567,10 @@ fn write(&self, offset: hwaddr, value: u64, _size: u32) {
                 .borrow_mut()
                 .write(field, value as u32, &self.char_backend);
         } else {
-            eprintln!("write bad offset {offset} value {value}");
+            log_mask_ln!(
+                Log::GuestError,
+                "PL011State::write: Bad offset {offset} value {value}"
+            );
         }
         if update_irq {
             self.update();
-- 
2.49.0


