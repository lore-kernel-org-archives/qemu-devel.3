Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21189C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 10:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trDx9-0008WC-6G; Sun, 09 Mar 2025 06:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDx1-0008Hb-4h
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:32:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwy-00044K-EK
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741516323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rMJXw2z6gbTxYfWWplVTHw1usKZlq5SZRfFTDJ86AUQ=;
 b=TU2QbAcs5ibjlJ4ENAl8CvSuLLemiICZQCTAhLSxbujeT5Yb9muhGDHO02JY6JYYfM4x2W
 EeJMYXhNlb5WKepDgCHaMecKzJFXokVnpPsHrCOeSqwcf4LPEiwKlwmVeUTXms8jgN/h8c
 tiAmzzPaTFxCY+6pm98EgoHWJAnPKJY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-nCypOI8LOsC5756DQudR8w-1; Sun, 09 Mar 2025 06:32:01 -0400
X-MC-Unique: nCypOI8LOsC5756DQudR8w-1
X-Mimecast-MFC-AGG-ID: nCypOI8LOsC5756DQudR8w_1741516320
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43ced8c2eb7so4303345e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 03:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741516319; x=1742121119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rMJXw2z6gbTxYfWWplVTHw1usKZlq5SZRfFTDJ86AUQ=;
 b=ifshUxyCsqatyW9zHnfG0l7UuGGxLlJM4h4ZOQLdmG9Tsz1G5b7YkXqdtNOT18oTtN
 Bwc3HjejZTL18Hw8q/1Vd5uriYrCSX17hnngY97tO3soTQFavL6XcPxgNv/qXn4UNRMO
 ANbsL6RR6l6LZv6FQtMNU0R/Y65kk+CIUanxuWiMAsJWtYkt5RD7BDvDaU+1m8oRZ9RE
 VBUXzxiD4gR/Sgk62IT2ZCGeQ89HBhf+8ZIUBiVyQyZTuCdxpwmcp+6JZSax5MoV/VTk
 KRCm6ZB+gnOWMWvs/XD+Bvkor9Cm9dWK439VyFobZsusgW+vvul8+vMg6c2dpgW684SF
 s+rw==
X-Gm-Message-State: AOJu0YzQgSnvMJ+mTCgGuAJNer2b99pRCbt6SzX/nUZllrPYT07NMM59
 k94rVfT9buKyNRi0HYpfaj1LyQ5vE3tSbfbeEkjGLrZmgeyQ0X6dnHBaVoT1QTwiVSTL/nR+48U
 FdswBvunTlf8cGAMPIERU3xW6vn1moIr5SYmkRfZ0CNryqS1VBdaHasJoQq1grS1DmLaLqe5g6I
 dOlsYxutzZTrR7CShmVZn4MDSIWUEEFv9fKdsMz+g=
X-Gm-Gg: ASbGncvhngBfYIA42cNJfQ0IxpgdysUD8pn/spmuGab+UPuSBm/Qc5GGWvc9NuonPxO
 mqh4to1sxkqYOMlFfJM88sB9BZsHBqyhUr8sJt63blPhjveTH/GKngIayzK4OiOM3ioJgYCMw/v
 apPrrb1S6SN/fC9lpySb/1DfTwv/2URYagUw4D/hsyiEqpqDfzSR7F3NauT3Y0l22jbpzyOPpAC
 m9qiCD5hWupQSbOe7CZTrp3rw04O6KUJ/iG98Ex0Fx5q9bGspOgZrKhuPmItuSaGz7aoe16EoKY
 AZxUb+GSajeDcjB7TA1cgw==
X-Received: by 2002:a05:600c:450d:b0:439:7c0b:13f6 with SMTP id
 5b1f17b1804b1-43c6872e1ffmr70893405e9.31.1741516319553; 
 Sun, 09 Mar 2025 03:31:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd/tWN761T5J3RV1qC4TQ0PkogVSb9CcwIq3cftaWZkCmWseFfZaAqA5COICW+y/m4dDOI1w==
X-Received: by 2002:a05:600c:450d:b0:439:7c0b:13f6 with SMTP id
 5b1f17b1804b1-43c6872e1ffmr70893175e9.31.1741516319038; 
 Sun, 09 Mar 2025 03:31:59 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4292b06sm140510635e9.14.2025.03.09.03.31.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 03:31:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/25] rust: pl011: clean up visibilities of callbacks
Date: Sun,  9 Mar 2025 11:31:12 +0100
Message-ID: <20250309103120.1116448-19-pbonzini@redhat.com>
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

Do not make callbacks unnecessarily "pub", they are only used
through function pointers.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 01540654cc9..4cdbbf4b73d 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -537,7 +537,7 @@ fn post_init(&self) {
         }
     }
 
-    pub fn read(&self, offset: hwaddr, _size: u32) -> u64 {
+    fn read(&self, offset: hwaddr, _size: u32) -> u64 {
         match RegisterOffset::try_from(offset) {
             Err(v) if (0x3f8..0x400).contains(&(v >> 2)) => {
                 let device_id = self.get_class().device_id;
@@ -560,7 +560,7 @@ pub fn read(&self, offset: hwaddr, _size: u32) -> u64 {
         }
     }
 
-    pub fn write(&self, offset: hwaddr, value: u64, _size: u32) {
+    fn write(&self, offset: hwaddr, value: u64, _size: u32) {
         let mut update_irq = false;
         if let Ok(field) = RegisterOffset::try_from(offset) {
             // qemu_chr_fe_write_all() calls into the can_receive
@@ -621,7 +621,7 @@ pub fn event(&self, event: QEMUChrEvent) {
         }
     }
 
-    pub fn realize(&self) {
+    fn realize(&self) {
         // SAFETY: self.char_backend has the correct size and alignment for a
         // CharBackend object, and its callbacks are of the correct types.
         unsafe {
@@ -638,11 +638,11 @@ pub fn realize(&self) {
         }
     }
 
-    pub fn reset_hold(&self, _type: ResetType) {
+    fn reset_hold(&self, _type: ResetType) {
         self.regs.borrow_mut().reset();
     }
 
-    pub fn update(&self) {
+    fn update(&self) {
         let regs = self.regs.borrow();
         let flags = regs.int_level & regs.int_enabled;
         for (irq, i) in self.interrupts.iter().zip(IRQMASK) {
-- 
2.48.1


