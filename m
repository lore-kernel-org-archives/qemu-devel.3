Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F639C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWIE-0002ai-U5; Fri, 06 Jun 2025 08:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWI9-0002YR-1H
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWI5-0005sw-IN
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z2NuiPAVz5qwYZ3DwOgzCzQjZAP4Szd5YKA/6O60EH4=;
 b=fzWjxQl9Y79ie/F+3tbhHO0Oi9U1l8be8jSe77L9N4STJDefGPwnXHtGX6Xciz2iFQuYxV
 6nUtltMLYWQJiNu4DlAMK7UFjbtFoQOEx/kMovY7MytfF5paibeazaZKOaITYic0t6SS3Q
 VIw94UZ02CDmrm8LBhDvPSUAhfd7dkI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-xraoYt4xOT6HDOb4oR3B9Q-1; Fri, 06 Jun 2025 08:35:18 -0400
X-MC-Unique: xraoYt4xOT6HDOb4oR3B9Q-1
X-Mimecast-MFC-AGG-ID: xraoYt4xOT6HDOb4oR3B9Q_1749213318
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f85f31d9so1134369f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213317; x=1749818117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z2NuiPAVz5qwYZ3DwOgzCzQjZAP4Szd5YKA/6O60EH4=;
 b=tOVcY+Yj2i6Ww8UM9AyWZPQzzfpBlVtPl/Sl9QCTJBwY4LoNqxTVIERSJUpIdhIaHB
 bAxkSdErpLLoSk+7jmCnR6upYw++zSDnxt4+AK3fO7pLbHuOWyMadJ98VrmRu0XECjXg
 00MAsOKz2biLoD467Ea1kH9UZtqolVoYveyfa9YDe8ekNsuHF+1gMQURlNmaxn6c3x1i
 ZgSX/WyPguFSzz0B0CRjZuSYj+RcACg3mBZJtS4wVcWZu3b3RBq6t//wUAcSJWVz62Hk
 UdZSXOntm5b6nrxsYiLKWglR6WQMWMa1f4sNq4g2LTLettGdkPi+08BjdF/U9b5yR1ih
 j6uA==
X-Gm-Message-State: AOJu0YyMivwZuuORik97TH9ig47lZZf1RMDk5Fmwy9kjlzyqH0Zl3mea
 /2SFHOX3rhCCwU+j1KUuHfr55GtTwqwDcsSkMKBQbTgOHMhYu3nzwhSdVl/EO4emxc7faF0ETR9
 xErUD+F3zzeeo71xEkHhvgCrsR4e8LkygHWfpLFIv1jM/rbmMxZzf6cJW1m/NikyBVixBXiqsDk
 W7dgqRwwbf4DedTYqyyqKHENPAEdqnn1aFewbgDm8E
X-Gm-Gg: ASbGncv9AbctZMOxfxobX/9DplBxON24iCsycY+6WvnP2SNleptokIr0xoJsaOqaLAT
 mRu2GVaTr+4u438Ce3t8Gj6RtoyMJXjNRb+hwZ3wt13goUMmhy128AM8xrNKBb043OivwpHOaFj
 EdvQbPQydp6yl9E12m3ArKoHUTHC6tNFoQxAV6kUkrDgk+wNDrvRMeHSbFvqDlt11OJVBexRr8a
 GsNd0TNzywJQXDPgX/cLVu58wdDO0AQoNTqdvA46cEXW+qkj6B3EqJMo3I8xeBLWf9n2zVdtgOK
 HwalNiLCQnOGanu6w0nx8WUE
X-Received: by 2002:a05:6000:248a:b0:3a4:dfc2:b9e1 with SMTP id
 ffacd0b85a97d-3a531784b7emr2502235f8f.2.1749213316791; 
 Fri, 06 Jun 2025 05:35:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbUxNCm7kt5V/g9fsxwA2v8bawKKzfy+M+Cgovisivn6p9PfAsxAj4k5JosX3pODJfq77ofg==
X-Received: by 2002:a05:6000:248a:b0:3a4:dfc2:b9e1 with SMTP id
 ffacd0b85a97d-3a531784b7emr2502213f8f.2.1749213316263; 
 Fri, 06 Jun 2025 05:35:16 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244d15asm1813791f8f.66.2025.06.06.05.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:35:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 08/31] rust: qdev: support returning errors from realize
Date: Fri,  6 Jun 2025 14:34:22 +0200
Message-ID: <20250606123447.538131-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs |  5 +++--
 rust/hw/timer/hpet/src/device.rs |  5 +++--
 rust/qemu-api/src/qdev.rs        | 12 ++++++++----
 3 files changed, 14 insertions(+), 8 deletions(-)

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
index 1279d7a58d5..0610959f467 100644
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
@@ -134,10 +135,13 @@ fn vmsd() -> Option<&'static VMStateDescription> {
 /// readable/writeable from one thread at any time.
 unsafe extern "C" fn rust_realize_fn<T: DeviceImpl>(
     dev: *mut bindings::DeviceState,
-    _errp: *mut *mut Error,
+    errp: *mut *mut bindings::Error,
 ) {
     let state = NonNull::new(dev).unwrap().cast::<T>();
-    T::REALIZE.unwrap()(unsafe { state.as_ref() });
+    let result = T::REALIZE.unwrap()(unsafe { state.as_ref() });
+    unsafe {
+        Error::ok_or_propagate(result, errp);
+    }
 }
 
 unsafe impl InterfaceType for ResettableClass {
-- 
2.49.0


