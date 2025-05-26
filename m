Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A107C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 14:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJYlw-0003JJ-Aw; Mon, 26 May 2025 10:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJYld-00031S-Fk
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:25:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJYlV-0007ro-S9
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748269519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yEirfICDV2iUFGeoHG7Gn3nAmnYWGEW5yhNDMIdDw0M=;
 b=NqDNFGdP4uza9OHLwY5/v//khZbQCSM4vLvxhaaPIrc8ZNchJFFB78N6yepedJi4++LoXF
 B2qNrXNtO+lquBL6egFnIxU6QFdL7ixhqjk1peSJOOFD5AL76RrmOi44WYB1f/TuVJtTug
 jZ5Ou97esqSUk6pFxbjRQYU84SZg4SQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-kF41sNprMaq6w1CtByvRrQ-1; Mon, 26 May 2025 10:25:17 -0400
X-MC-Unique: kF41sNprMaq6w1CtByvRrQ-1
X-Mimecast-MFC-AGG-ID: kF41sNprMaq6w1CtByvRrQ_1748269517
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf5196c25so13574175e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 07:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748269515; x=1748874315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yEirfICDV2iUFGeoHG7Gn3nAmnYWGEW5yhNDMIdDw0M=;
 b=t7BvKnmYNjaAjLiQJGlUjlseJpzXPzFnS7fk9FM0utEk/Jp71+WvmCCYq+Do4Hsgag
 kcuzWL+sO2+4dQ03CotTyNh1WGiIX2n7RP8orDONbJtXkPZ9CCxJ+Kic3r09J224xENA
 3pufE8j0TQGptdCLTkVkr9s1BqDmi3PErJkd3tTW88/TxuRrSi1W0MfwIysRR4NqZDjW
 PVhA2JL6+cZES8kX5L7zjVf3rvs09qLhYCLmYZz1job/sayP/PerOlLY2ac6/BOzFkhy
 CAVf0y4B+EdPL3qHabPFgeeuD73ppikdQht7245Al4cy0wnEyXGS7DDvCwFSUEVOQs+W
 oMCg==
X-Gm-Message-State: AOJu0YyJdtFaaca+J1Bo2QOS0InhaskCgSz8prqq4/NpS3SU/PPtNee2
 wTytoz2rzFlvmvasDDr7Ov0SFV+e1nF4s0WRNSeOoaRU8xhcOc8iT/JOJPa1EkUkqJhSiYoeEvn
 nrJvGwyodefhhG11a6ivlz1xBXXixUVjPMXMVZWNvdBkIwc9HC6fK6eT0K7w2slSK0hUGf36jSl
 WRjRmpBzvcrKTWEUFI/GaZtFd07kxrjFeUGkrShVBH
X-Gm-Gg: ASbGncuftbDdd6p+uDmEh7lSiYNdFVwnBlm1K6+HXfPLUL7xioN0IwFmPXjBpRMb8Xx
 6FF+TbIaIyUK54VCXJ1HebZ91a2JJyI1/WBud65FB8r51MwtZCgL6mg30NFSMDeiyBA9yFqYfIX
 nzh4I6T3DxeWsG5OpV9gwjGHnb2ibJyxoKqdr12J0w3Pp23KOB2i6vtQuk2ZyKwTsgTmEjgcxQt
 PuxAYQk1SZ99+Hz32zTaJBPynj0M+GEQGyr2llchSqY+l7V/ITQF5ka+zyNDueGUivzv1LC0UQ6
 LL5A8eli/bK76w==
X-Received: by 2002:a05:600c:1da6:b0:44a:4874:bdde with SMTP id
 5b1f17b1804b1-44c8ed8f474mr89520835e9.0.1748269514848; 
 Mon, 26 May 2025 07:25:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvFQhU736uPEHz30h8XKYQwp60N+KklBTccvOgW4W5S3cXm93i6WcOt9PK66MdDozUqztwEQ==
X-Received: by 2002:a05:600c:1da6:b0:44a:4874:bdde with SMTP id
 5b1f17b1804b1-44c8ed8f474mr89520605e9.0.1748269514409; 
 Mon, 26 May 2025 07:25:14 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f18251basm235241585e9.4.2025.05.26.07.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 07:25:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH 08/12] rust: qdev: support returning errors from realize
Date: Mon, 26 May 2025 16:24:51 +0200
Message-ID: <20250526142455.1061519-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526142254.1061009-1-pbonzini@redhat.com>
References: <20250526142254.1061009-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs |  5 +++--
 rust/hw/timer/hpet/src/hpet.rs   |  5 +++--
 rust/qemu-api/src/qdev.rs        | 10 ++++++----
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index bde3be65c5b..95fe9a34cd2 100644
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
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index 779681d6509..55eef669a9d 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
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


