Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D03C021B6
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 17:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlWRY-0006oZ-7f; Fri, 21 Feb 2025 12:04:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRT-0006kt-6o
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:04:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRR-0001Q2-Dl
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:03:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740157436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hJleYDBCD4SDSG2l2W+THx3Wzd2iHgM0lXz/mw911rM=;
 b=LGz/vxGIrOTJBAGueVC6IAMID1BV0/RI72jTQz0rswiMPollkrTRpcAL+VL0bWQe9zW6tP
 l+m3/hivGFNPP66K0pQhQ/pZ5dMoRvOBLKPQAiJe4mValwPVkH0RzqYy23OtGlY8xqLQQd
 WEpxSfLZzuCNfdWUeE+ll/AY9Cao3yc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-AHu6RGxDN0ymm-kyRxycTQ-1; Fri, 21 Feb 2025 12:03:55 -0500
X-MC-Unique: AHu6RGxDN0ymm-kyRxycTQ-1
X-Mimecast-MFC-AGG-ID: AHu6RGxDN0ymm-kyRxycTQ_1740157434
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4393b6763a3so10943955e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 09:03:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740157433; x=1740762233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hJleYDBCD4SDSG2l2W+THx3Wzd2iHgM0lXz/mw911rM=;
 b=MEnjo01NJAOPXbVJIrah3Db5ETpwgbfbiDvNqh+VYXpt89IVkgdzqdL1GvKflodrB3
 oihZNX301dcJEijVY6gmzrshrEF9XShFQ/8SXnYkc8iFvrRhVKblmzgypjFLXyr3Exsv
 apfdKDmPFMJh7Zpg8i0E1TctXn/hIp5QyDavC16v3BWrxFQ5ZP1u3x5evoWJwiaxyjdO
 j7yS7VjLpPoGtTR1eNfNYWizprtQvCIZK/awHVwzsnWMOWmY9QvQeObXK36LsoCD5hIB
 ScRdxpYfNDDy+l7BQWKbdST44okoNXgPAugHM7DNFsfLjJnd3ZmtQ0rM6CaNkOMprqKS
 D0uQ==
X-Gm-Message-State: AOJu0Yy6mttQcxO1B7sXICqKQFrWeBI46wS9IbHIMloKwS/y5irlguv1
 pCjDbSsBrK+na1Tk+vyiTqk8civKHFopyZ0OUZ7oLjEyQOc0Myj+Cfuot1rb5XpQ34Lv3wdZDbn
 0/XAe+yrJYiFu462kpQmxCMmgp9T4wqYhQM8f3Gs0zbOY7EVxdXCNhF3iMwMVcahmfs8Y0q4GzV
 TxFbbeQqXK+dEv3/IYEZJitr4ndyxoMeU3PugxjPw=
X-Gm-Gg: ASbGncvUkU42svnkaqgQcX2XPn6r1feUdXASzRSugiViXY7O0fz4R1JORL6Xrig0Qf9
 cICVwHizcifwAxmpPQjfCqxDvM+BSCVMF33JEGlJGZ7mXP2djmJ8fR65zMaH7fN4bof/9EBvIPH
 WBeRieWsPKlnMInx4cWy14bTDcSv2ESJ+MUrqGwJbD6i1w/UBoj+1cbrL3l0qwCIo5zg3k5xlYu
 t2Iq7JXnjzTd/hhAOP2rpURvFPNMFTr6EQpnWzEXkybwDACXRyD8gGYKYV3O+CZ4CX7aCBZSFsG
 W2JVBNUSawIUXaXh1qw=
X-Received: by 2002:a05:600c:4ed1:b0:439:a155:549d with SMTP id
 5b1f17b1804b1-439ae1eacfdmr37742825e9.12.1740157432579; 
 Fri, 21 Feb 2025 09:03:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUJMLtPu1H85AOGMMT+HKTiV5g2ktjFALXblz6rsAXfbi9P1WnTKCL9dEoeEYDJBKe4bW0Uw==
X-Received: by 2002:a05:600c:4ed1:b0:439:a155:549d with SMTP id
 5b1f17b1804b1-439ae1eacfdmr37742105e9.12.1740157431971; 
 Fri, 21 Feb 2025 09:03:51 -0800 (PST)
Received: from [192.168.10.48] ([151.95.61.185])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b030b347sm23028795e9.26.2025.02.21.09.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:03:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 04/15] rust: pl011, qemu_api tests: do not use ClassInitImpl
Date: Fri, 21 Feb 2025 18:03:31 +0100
Message-ID: <20250221170342.63591-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221170342.63591-1-pbonzini@redhat.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Outside the qemu_api crate, orphan rules make the usage of ClassInitImpl
unwieldy.  Now that it is optional, do not use it.

For PL011Class, this makes it easier to provide a PL011Impl trait similar
to the ones in the qemu_api crate.  The device id consts are moved there.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 38 ++++++++++++++++----------------
 rust/qemu-api/tests/tests.rs     | 33 ++++++++++-----------------
 2 files changed, 31 insertions(+), 40 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index a6da9db0bb0..fc1c8ec8d6a 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -50,11 +50,6 @@ fn index(&self, idx: hwaddr) -> &Self::Output {
     }
 }
 
-impl DeviceId {
-    const ARM: Self = Self(&[0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1]);
-    const LUMINARY: Self = Self(&[0x11, 0x00, 0x18, 0x01, 0x0d, 0xf0, 0x05, 0xb1]);
-}
-
 // FIFOs use 32-bit indices instead of usize, for compatibility with
 // the migration stream produced by the C version of this device.
 #[repr(transparent)]
@@ -143,16 +138,24 @@ pub struct PL011Class {
     device_id: DeviceId,
 }
 
+trait PL011Impl: SysBusDeviceImpl + IsA<PL011State> {
+    const DEVICE_ID: DeviceId;
+}
+
+impl PL011Class {
+    fn class_init<T: PL011Impl>(&mut self) {
+        self.device_id = T::DEVICE_ID;
+        <T as ClassInitImpl<SysBusDeviceClass>>::class_init(&mut self.parent_class);
+    }
+}
+
 unsafe impl ObjectType for PL011State {
     type Class = PL011Class;
     const TYPE_NAME: &'static CStr = crate::TYPE_PL011;
 }
 
-impl ClassInitImpl<PL011Class> for PL011State {
-    fn class_init(klass: &mut PL011Class) {
-        klass.device_id = DeviceId::ARM;
-        <Self as ClassInitImpl<SysBusDeviceClass>>::class_init(&mut klass.parent_class);
-    }
+impl PL011Impl for PL011State {
+    const DEVICE_ID: DeviceId = DeviceId(&[0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1]);
 }
 
 impl ObjectImpl for PL011State {
@@ -160,7 +163,7 @@ impl ObjectImpl for PL011State {
 
     const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
     const INSTANCE_POST_INIT: Option<fn(&Self)> = Some(Self::post_init);
-    const CLASS_INIT: fn(&mut Self::Class) = <Self as ClassInitImpl<Self::Class>>::class_init;
+    const CLASS_INIT: fn(&mut Self::Class) = Self::Class::class_init::<Self>;
 }
 
 impl DeviceImpl for PL011State {
@@ -729,13 +732,6 @@ pub struct PL011Luminary {
     parent_obj: ParentField<PL011State>,
 }
 
-impl ClassInitImpl<PL011Class> for PL011Luminary {
-    fn class_init(klass: &mut PL011Class) {
-        klass.device_id = DeviceId::LUMINARY;
-        <Self as ClassInitImpl<SysBusDeviceClass>>::class_init(&mut klass.parent_class);
-    }
-}
-
 qom_isa!(PL011Luminary : PL011State, SysBusDevice, DeviceState, Object);
 
 unsafe impl ObjectType for PL011Luminary {
@@ -746,7 +742,11 @@ unsafe impl ObjectType for PL011Luminary {
 impl ObjectImpl for PL011Luminary {
     type ParentType = PL011State;
 
-    const CLASS_INIT: fn(&mut Self::Class) = <Self as ClassInitImpl<Self::Class>>::class_init;
+    const CLASS_INIT: fn(&mut Self::Class) = Self::Class::class_init::<Self>;
+}
+
+impl PL011Impl for PL011Luminary {
+    const DEVICE_ID: DeviceId = DeviceId(&[0x11, 0x00, 0x18, 0x01, 0x0d, 0xf0, 0x05, 0xb1]);
 }
 
 impl DeviceImpl for PL011Luminary {}
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 9546e9d7963..93c5637bbc3 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -13,7 +13,7 @@
     cell::{self, BqlCell},
     declare_properties, define_property,
     prelude::*,
-    qdev::{DeviceClass, DeviceImpl, DeviceState, Property, ResettablePhasesImpl},
+    qdev::{DeviceImpl, DeviceState, Property, ResettablePhasesImpl},
     qom::{ClassInitImpl, ObjectImpl, ParentField},
     sysbus::SysBusDevice,
     vmstate::VMStateDescription,
@@ -41,6 +41,12 @@ pub struct DummyClass {
     parent_class: <DeviceState as ObjectType>::Class,
 }
 
+impl DummyClass {
+    pub fn class_init<T: DeviceImpl>(self: &mut DummyClass) {
+        <T as ClassInitImpl<DeviceClass>>::class_init(&mut self.parent_class);
+    }
+}
+
 declare_properties! {
     DUMMY_PROPERTIES,
         define_property!(
@@ -60,7 +66,7 @@ unsafe impl ObjectType for DummyState {
 impl ObjectImpl for DummyState {
     type ParentType = DeviceState;
     const ABSTRACT: bool = false;
-    const CLASS_INIT: fn(&mut DummyClass) = <Self as ClassInitImpl<DummyClass>>::class_init;
+    const CLASS_INIT: fn(&mut DummyClass) = DummyClass::class_init::<Self>;
 }
 
 impl ResettablePhasesImpl for DummyState {}
@@ -74,14 +80,6 @@ fn vmsd() -> Option<&'static VMStateDescription> {
     }
 }
 
-// `impl<T> ClassInitImpl<DummyClass> for T` doesn't work since it violates
-// orphan rule.
-impl ClassInitImpl<DummyClass> for DummyState {
-    fn class_init(klass: &mut DummyClass) {
-        <Self as ClassInitImpl<DeviceClass>>::class_init(&mut klass.parent_class);
-    }
-}
-
 #[derive(qemu_api_macros::offsets)]
 #[repr(C)]
 #[derive(qemu_api_macros::Object)]
@@ -103,22 +101,15 @@ unsafe impl ObjectType for DummyChildState {
 impl ObjectImpl for DummyChildState {
     type ParentType = DummyState;
     const ABSTRACT: bool = false;
-    const CLASS_INIT: fn(&mut DummyChildClass) =
-        <Self as ClassInitImpl<DummyChildClass>>::class_init;
+    const CLASS_INIT: fn(&mut DummyChildClass) = DummyChildClass::class_init::<Self>;
 }
 
 impl ResettablePhasesImpl for DummyChildState {}
 impl DeviceImpl for DummyChildState {}
 
-impl ClassInitImpl<DummyClass> for DummyChildState {
-    fn class_init(klass: &mut DummyClass) {
-        <Self as ClassInitImpl<DeviceClass>>::class_init(&mut klass.parent_class);
-    }
-}
-
-impl ClassInitImpl<DummyChildClass> for DummyChildState {
-    fn class_init(klass: &mut DummyChildClass) {
-        <Self as ClassInitImpl<DummyClass>>::class_init(&mut klass.parent_class);
+impl DummyChildClass {
+    pub fn class_init<T: DeviceImpl>(self: &mut DummyChildClass) {
+        self.parent_class.class_init::<T>();
     }
 }
 
-- 
2.48.1


