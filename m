Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277ECC0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGIO-0006Xp-LC; Fri, 24 Jan 2025 04:48:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGQ-0007r6-PF
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGO-0003zJ-G6
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=14M6y43j2+I/0HjJ1yw2OhzwD6m5Rm3rJ7c4Et0oVDw=;
 b=Wh0KrcQfYpbGSSB2dPsjKvSVUTd51fQGkdo2lKZZPmCY3J4XrZ1KNTZjdFfg2QOSvAfvZm
 gWnz186AkpShmof/e37XodOBeSF2+6MUuIcPhBFQPyu7xr4HKc99k1Mn15XcPxPo1TgISn
 FJ9nKOYNwh82/k1uIwcBvzj8ImB9+uM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-Yd6b2oNGMiy0FdLMtXXyzg-1; Fri, 24 Jan 2025 04:46:05 -0500
X-MC-Unique: Yd6b2oNGMiy0FdLMtXXyzg-1
X-Mimecast-MFC-AGG-ID: Yd6b2oNGMiy0FdLMtXXyzg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-436219070b4so8838835e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711963; x=1738316763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=14M6y43j2+I/0HjJ1yw2OhzwD6m5Rm3rJ7c4Et0oVDw=;
 b=Au0WVXlXouJa3yfDSzfX1drUTybpi4iVhZMlUAc0tU1WDG6t3wmxwP5buKkSVUlbo2
 8l9bl3mGxZJM3kQ+9QekwelfYnSKYRsHhnGyj0oBgl3LgNuGiuY78Ij3N042Y3uKIznG
 S04wCA2OdkZzPVitbvoPswgAUNbWrRTT41w+jYiiZQboFQVIQystsHnd5D44H/4vvKk2
 +0Q2EcoEUFZol2l+PqCGEDolyFv3sieTe5uY/ZIlheQo3wdkxEUQuSgnWOFP2TwH6DLr
 N9Hw4+pjz+LA6tY4Le74qJNyQxJMreKaOWjNhsK5TmBZgNAxl0ns8MdeVtkkcMrU585L
 vnsg==
X-Gm-Message-State: AOJu0YxA1WHJyryaLLTtqI3m8gi+R9XZ3ehVbfzELkcwsIO+NToVMO4Y
 1hoQ/KSfLP4O1uuf5K+Vx4k4EBd1pgdF2c8hCMuEff1o2bqlXSf5qcxqWaz2Dxazn1a0qqPSrrs
 oR4KL9BrrTRJWcF+k/RctpqCgwQyErpLcrEM4cEz0Hwnz3Au4ipVrR+vnLeaXVAbu7pnrj93Qi3
 r/gyXS9LGmpidEMOT0FD7pUU3Z2+wSD2T886nUOAA=
X-Gm-Gg: ASbGncvWFOq9xDCnO3YabUrJ0bk0IGOTsUM+yTwi5bXLYN/TtlJJjavtGaU0XMvc/zl
 quTvYKlU5jVGxWLCNy91vyhgi7XtyOeXSVWIOWb01CIhJWceFS7ZV4O05TAIHPcPG38vNl/SHzK
 ykWmxKXSg8bah3lLcG3EDE76eZ1UEr3FgRbgKvNwArjg+DhOFRqs8RUDxShZ9NhbYLbikGbQfNx
 P2HVmmEqFxFEVB1/k0PgciC5oJNtFuWJOMep+qJlFhr5lKyh/y1Wkbun2eB8QtAyyY6Xreziw==
X-Received: by 2002:a05:600c:3b94:b0:434:e2ea:fc94 with SMTP id
 5b1f17b1804b1-438913cb620mr316040725e9.11.1737711962645; 
 Fri, 24 Jan 2025 01:46:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3rQQxsZQyvpOIozx0hbjE0/adKr7dmqg8km34oHyV1LLaRGaqvnBlh/SqRHWK3U2nRQeKIg==
X-Received: by 2002:a05:600c:3b94:b0:434:e2ea:fc94 with SMTP id
 5b1f17b1804b1-438913cb620mr316040335e9.11.1737711962087; 
 Fri, 24 Jan 2025 01:46:02 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4856d8sm20627535e9.11.2025.01.24.01.46.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:46:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 39/48] rust: pl011: extract CharBackend receive logic into a
 separate function
Date: Fri, 24 Jan 2025 10:44:33 +0100
Message-ID: <20250124094442.13207-40-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

Prepare for moving all references to the registers and the FIFO into a
separate struct.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 58b54547336..de5110038a5 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -6,7 +6,7 @@
 use std::{
     ffi::CStr,
     ops::ControlFlow,
-    os::raw::{c_int, c_uint, c_void},
+    os::raw::{c_int, c_void},
 };
 
 use qemu_api::{
@@ -488,6 +488,12 @@ pub fn can_receive(&self) -> bool {
         self.read_count < self.fifo_depth()
     }
 
+    pub fn receive(&mut self, ch: u32) {
+        if !self.loopback_enabled() {
+            self.put_fifo(ch)
+        }
+    }
+
     pub fn event(&mut self, event: QEMUChrEvent) {
         if event == QEMUChrEvent::CHR_EVENT_BREAK && !self.loopback_enabled() {
             self.put_fifo(registers::Data::BREAK.into());
@@ -513,7 +519,7 @@ pub fn fifo_depth(&self) -> u32 {
         1
     }
 
-    pub fn put_fifo(&mut self, value: c_uint) {
+    pub fn put_fifo(&mut self, value: u32) {
         let depth = self.fifo_depth();
         assert!(depth > 0);
         let slot = (self.read_pos + self.read_count) & (depth - 1);
@@ -622,12 +628,9 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
 pub unsafe extern "C" fn pl011_receive(opaque: *mut c_void, buf: *const u8, size: c_int) {
     let mut state = NonNull::new(opaque).unwrap().cast::<PL011State>();
     unsafe {
-        if state.as_ref().loopback_enabled() {
-            return;
-        }
         if size > 0 {
             debug_assert!(!buf.is_null());
-            state.as_mut().put_fifo(c_uint::from(buf.read_volatile()))
+            state.as_mut().receive(u32::from(buf.read_volatile()));
         }
     }
 }
-- 
2.48.1


