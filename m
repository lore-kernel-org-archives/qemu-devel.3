Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF09DC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 10:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7eI-0007jX-M1; Thu, 05 Jun 2025 06:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7ds-0007Og-7K
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:16:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7dq-0001Iq-Jx
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749118570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=emYWTK7P65uaB9bRVM5HfCBE6H7lXJtltWgsxH55ExA=;
 b=D2wS6Yp2+d3HnZRxSPaxTcGZaQgAPjhaqFb13X7dS22JyCDCQmJOvm52aXHXsC143Fdedk
 xOVxEQueqTkE5lbzFNs6Nw++9kjYJUH2nz/MnBRyCP+G5WAGDB/7P+1mGkjdPzn+hB3VFB
 cyMEOa9kic8+ForB6zGpJ6we2CfON64=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-DT3_57aQO1yeJYbskapomw-1; Thu, 05 Jun 2025 06:16:08 -0400
X-MC-Unique: DT3_57aQO1yeJYbskapomw-1
X-Mimecast-MFC-AGG-ID: DT3_57aQO1yeJYbskapomw_1749118568
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-441c122fa56so4046765e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 03:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749118567; x=1749723367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=emYWTK7P65uaB9bRVM5HfCBE6H7lXJtltWgsxH55ExA=;
 b=baC16Z/Vz+IDub3P9NASS6LyzpdvGwhD2YvudydLO7kTWXDO94IBAoMEHD6BiCZoXX
 C3Re1uBRvzGolvH8tMTixMyB0eAko7AsTW77XHZc6SOeg21vHnFedsmh827sTxyP5Ju0
 3r2+VGdB1V61fIfSF30mSgUc+ZuHDQRGvx2qqncLLptkFFjd4dN7QYr2qTXlaeSVfGEY
 w7ECbqrz3GuQcdWKzbozI8wGgs603odKwev++sguYnThv+fVwxdBKdzwBWz5li1yPD80
 7Z66BBovIJxkP8lQ1U+S8zd1MinQZp87xXiYDZLFkOr9vAGYHtDVsLvvtdpm+0m4UkCh
 jCxA==
X-Gm-Message-State: AOJu0Yz2fDHFJx3xuTgJHjOr7bU5e8DxhclAd/kmN5Gy06/FVkAEIGLi
 Bj3vyrnita+o0IJ3pSRJPsKIkGomSc8FQGEkofHpUwPUwUGymD2uCQljOTQB8BE/4hvtORcbs61
 yyUVEYZz7SPWcrh92Ih55GSn0bYyYC61IMpSFkdXZjPyYw0xVCu4dVwwZYw4X6EFiyl33wrevSb
 DW6hMkV2uVjxZyEk+zHTFgYMsHAhQBfPHTvKfn3PLP
X-Gm-Gg: ASbGncsecox+/OHcL35226oWEI9V6g9lFefdqN3wE7wuoRWredV4ItqoWx62DhDVBci
 ujZQnlrgbp82ETSJBHAA0vQR6nObNtbc/pOj5pR51TIrDBmFQSF2b/OfKPSl33swEHDDBoXorWd
 184tbin3/u5LiW2QPmPCBdDH089O+Vla3osFIIXSwNHVJLoqdtvPQ9nc0tDdEzyJT0TSoq4xUUI
 p+JnqQPcUHcTukkNJUoXqVYMLxIGpRO8bjhWu2j4AC4CJolpnAFCxfOChACDFAarvIOlD7cmGyR
 J+U/+QAGhl/Dlw==
X-Received: by 2002:a05:600c:4ec6:b0:450:cabd:160 with SMTP id
 5b1f17b1804b1-451f0a64cbfmr60364525e9.3.1749118567288; 
 Thu, 05 Jun 2025 03:16:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaZEfA4lIT9kH4c4bgQ/DT1HAzVu5BowuSZ6Zv381Ug2pverATMZbR13sywaDivJ8GrbJR2g==
X-Received: by 2002:a05:600c:4ec6:b0:450:cabd:160 with SMTP id
 5b1f17b1804b1-451f0a64cbfmr60364145e9.3.1749118566810; 
 Thu, 05 Jun 2025 03:16:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451fb2213c1sm13305155e9.34.2025.06.05.03.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 03:16:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	zhao1.liu@intel.com,
	qemu-rust@nongnu.org
Subject: [PATCH 08/14] rust: qdev: support returning errors from realize
Date: Thu,  5 Jun 2025 12:15:37 +0200
Message-ID: <20250605101544.368953-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605101544.368953-1-pbonzini@redhat.com>
References: <20250605101544.368953-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs |  5 +++--
 rust/hw/timer/hpet/src/device.rs |  5 +++--
 rust/qemu-api/src/qdev.rs        | 10 ++++++----
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 0501fa5be9c..be8387f6f2d 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -175,7 +175,7 @@ fn properties() -> &'static [Property] {
     fn vmsd() -> Option<&'static VMStateDescription> {
         Some(&device_class::VMSTATE_PL011)
     }
-    const REALIZE: Option<fn(&Self)> = Some(Self::realize);
+    const REALIZE: Option<fn(&Self) -> qemu_api::Result<()>> = Some(Self::realize);
 }
 
 impl ResettablePhasesImpl for PL011State {
@@ -619,9 +619,10 @@ fn event(&self, event: Event) {
         }
     }
 
-    fn realize(&self) {
+    fn realize(&self) -> qemu_api::Result<()> {
         self.char_backend
             .enable_handlers(self, Self::can_receive, Self::receive, Self::event);
+        Ok(())
     }
 
     fn reset_hold(&self, _type: ResetType) {
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index e3ba62b2875..68c82b09b60 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -724,7 +724,7 @@ fn post_init(&self) {
         }
     }
 
-    fn realize(&self) {
+    fn realize(&self) -> qemu_api::Result<()> {
         if self.int_route_cap == 0 {
             // TODO: Add error binding: warn_report()
             println!("Hpet's hpet-intcap property not initialized");
@@ -751,6 +751,7 @@ fn realize(&self) {
 
         self.init_gpio_in(2, HPETState::handle_legacy_irq);
         self.init_gpio_out(from_ref(&self.pit_enabled));
+        Ok(())
     }
 
     fn reset_hold(&self, _type: ResetType) {
@@ -1042,7 +1043,7 @@ fn vmsd() -> Option<&'static VMStateDescription> {
         Some(&VMSTATE_HPET)
     }
 
-    const REALIZE: Option<fn(&Self)> = Some(Self::realize);
+    const REALIZE: Option<fn(&Self) -> qemu_api::Result<()>> = Some(Self::realize);
 }
 
 impl ResettablePhasesImpl for HPETState {
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 1279d7a58d5..81052097071 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -12,10 +12,11 @@
 pub use bindings::{ClockEvent, DeviceClass, Property, ResetType};
 
 use crate::{
-    bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out, Error, ResettableClass},
+    bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out, ResettableClass},
     callbacks::FnCall,
     cell::{bql_locked, Opaque},
     chardev::Chardev,
+    error::{Error, Result},
     irq::InterruptSource,
     prelude::*,
     qom::{ObjectClass, ObjectImpl, Owned},
@@ -108,7 +109,7 @@ pub trait DeviceImpl: ObjectImpl + ResettablePhasesImpl + IsA<DeviceState> {
     ///
     /// If not `None`, the parent class's `realize` method is overridden
     /// with the function pointed to by `REALIZE`.
-    const REALIZE: Option<fn(&Self)> = None;
+    const REALIZE: Option<fn(&Self) -> Result<()>> = None;
 
     /// An array providing the properties that the user can set on the
     /// device.  Not a `const` because referencing statics in constants
@@ -134,10 +135,11 @@ fn vmsd() -> Option<&'static VMStateDescription> {
 /// readable/writeable from one thread at any time.
 unsafe extern "C" fn rust_realize_fn<T: DeviceImpl>(
     dev: *mut bindings::DeviceState,
-    _errp: *mut *mut Error,
+    errp: *mut *mut bindings::Error,
 ) {
     let state = NonNull::new(dev).unwrap().cast::<T>();
-    T::REALIZE.unwrap()(unsafe { state.as_ref() });
+    let result = T::REALIZE.unwrap()(unsafe { state.as_ref() });
+    unsafe { Error::ok_or_propagate(result, errp); }
 }
 
 unsafe impl InterfaceType for ResettableClass {
-- 
2.49.0


