Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EA0C19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 16:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnh1i-0000Cl-GX; Thu, 27 Feb 2025 11:46:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnh1I-0008Pg-Bb
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:45:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnh1B-0007o2-E8
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740674747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rMJXw2z6gbTxYfWWplVTHw1usKZlq5SZRfFTDJ86AUQ=;
 b=gTKTQe5YLIcar26n4YhaVVHmeBqcuQXfZ3p+fPBtoVbIR1MPNpk6Czq525IGEBLVR4ffo2
 uzr5Eu4yUwW3W2cZCMhrD0uESK+GskB0EK1nrtOOr5vajTIPSeiLbYBXQVCfgG6zucTdKk
 3WceXcksj2R1mYs2v2EVSCquQSBC598=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-GR-CoyDgOIa0s90iZqmhyQ-1; Thu, 27 Feb 2025 11:45:46 -0500
X-MC-Unique: GR-CoyDgOIa0s90iZqmhyQ-1
X-Mimecast-MFC-AGG-ID: GR-CoyDgOIa0s90iZqmhyQ_1740674745
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-abecbdb4272so135700266b.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 08:45:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740674744; x=1741279544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rMJXw2z6gbTxYfWWplVTHw1usKZlq5SZRfFTDJ86AUQ=;
 b=vXUfi4SfcKJa0NMlToOXyKme5Ub3jjeGHDM6y5fJOGA5DngR0NY0h+Z3HT7qY1lA+E
 5irzHwJ7MaEaSmBH82P7yjD/dlBFwMSMNId/Fn9uFTqtiMNJRhue3j6wyy+Dn4sLoXau
 5SfSlDUyO7+qAHbciPOTrQLhQHyHwQeAVXojjXeWbvU0Ck4sUIpc++mp2PXKiSs/ZPVb
 52VsNmzGFI559uE9W9/gUTyLWVpoWsGjj+zj9IwzkC1+9Dps+oXMNdv2dtqDyHgE+hc2
 kalB+iPGZAAlKw8/HTiJV/7DNsdlS80LWYRmC+y/PUmVE9Lm3OW9+NfRdA2lFYI0U4rv
 Sn1Q==
X-Gm-Message-State: AOJu0Yzep2Ury73YistNW/nChjtDIRE7sTugo5cJMIPPKZ3RwrRUGgod
 pR2h4EGPdljklCL6rBlHuGlkM+T6rRFGcAAddhD6h2bj7dZPAxlxFxdNWevoq9jXVZA1ijI+M7M
 OFaEawjT0v2K+/gtsqThLgt8+gHgytfmUkXbcn+N2f5hsJrb2YUGA3ko2rJIiP9egtrd8wVy3i4
 Va5+JvszmrpCGqmIcBKAQe4osf7EykwMl89AUxr+I=
X-Gm-Gg: ASbGncvLsFH1NPPSKyP7Tj36KFHzsQyiEVprYUQaq4PQg64NwLYdZgHcb4hzgb7UXiQ
 fgTykAyT96P1ZLnMzZnMimH+BTDBIxg8ajj9bfbKEvIErHGALWxyhuGSpGTEudt8J/JaFlDWDvh
 MlprkzJ3MLIlOtZLRtgJGb3p+r5VQBsUjgqFp4k+o9wDU5eYHBZU85eqGxqmVBjxWtF/BDUkf4f
 jvvwkCdrxn/DzwDPFvAl7c0CCgFyLb9yj+/pFesU6heQxV9/Wj+oiTOMQHaa67YX/5HTabpCBYm
 BSf0K6+t2hegoua84Q==
X-Received: by 2002:a17:906:dc8d:b0:ab6:d575:3c4c with SMTP id
 a640c23a62f3a-abf25fbb503mr14697066b.17.1740674744394; 
 Thu, 27 Feb 2025 08:45:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0HQpKmBJxKb6ttFfE87pBaF4i8de8emI/ci2S56wYBnBM/4Yyp4zUzV0TrZvvPcpYqt/kYw==
X-Received: by 2002:a17:906:dc8d:b0:ab6:d575:3c4c with SMTP id
 a640c23a62f3a-abf25fbb503mr14693666b.17.1740674743960; 
 Thu, 27 Feb 2025 08:45:43 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf21ae000dsm34397566b.126.2025.02.27.08.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 08:45:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 3/5] rust: pl011: clean up visibilities of callbacks
Date: Thu, 27 Feb 2025 17:45:32 +0100
Message-ID: <20250227164538.814576-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227164538.814576-1-pbonzini@redhat.com>
References: <20250227164538.814576-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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


