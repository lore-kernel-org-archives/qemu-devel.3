Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6912C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnelV-00008E-VN; Thu, 27 Feb 2025 09:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekt-0007Pr-9d
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekr-0003pE-GP
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L7GGVBmZG7ZF98LfqMdeaCfIRAIPw9igfsvGxUYuvdQ=;
 b=E3MA2cHlJzNyENALgjX+wwBDom++XQbN6TBNlFkkpK/+5JjWAX/wuLSPUOOa9MkeTb95Go
 W1t35g4zfvafDk3dZ+pIPNuNvzoZz0U+kFqo1jI6W0b/+nN6ABzZiJK04h2q9Ntr2n928T
 eaaLkmn5i78A0y9pPCKo2T/qy5e9Cus=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-ugWjiPUGMtuIjEnEo2Ox5A-1; Thu, 27 Feb 2025 09:20:46 -0500
X-MC-Unique: ugWjiPUGMtuIjEnEo2Ox5A-1
X-Mimecast-MFC-AGG-ID: ugWjiPUGMtuIjEnEo2Ox5A_1740666045
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-abbb6fa430fso70450366b.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666044; x=1741270844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L7GGVBmZG7ZF98LfqMdeaCfIRAIPw9igfsvGxUYuvdQ=;
 b=MsxlQOv03XwGJX4b90g/frDgyE5x6JCJcSLYUbE6AO8C9iTGIx/FyorkNBNT2F30hx
 Jhs5nUbcPvDcJpq6aK7eToHg6foRLPbDKYHznfX7mNOPC6Z1D77WN3AA5wFhGLboOX1t
 Q+DIcBzWdT04awMScMt4REg//36BXalGTKZujCfgsvUMcgFrQRh6EkQ9f0aONVppXBVr
 zkoKxgf6+4KeBgrvaC16Eb45Awl5vwN/qJQTT0aXbBFtKyY/BqvaEXYthSmsN+gQmr1x
 WE9laGtABGBh4i506s6AmkC7+w4xmSVne6TWp92cMVOaCGMJLEutVXKal6TqiWVtAT7c
 j3Ng==
X-Gm-Message-State: AOJu0Yz9TKpqiC6ny6mPCKlPh2yIIXv9m1HkRqx4+M9Y9ZUIrpswuFoJ
 tsYr00bXOrK2kprbv2pT0z1EVjnYwu5SPyVeHMjNcU3c3KRwPwiVrkNXSG/UbXR1+hqarSkWnZy
 m1pxu3DoO2UU4F3OR4Qi3rd5/y4tZMQg3BOL5T5KtfUuxwXlqiwhDEoGkeHB7tITK4AT/X7sYA2
 qIxthkWg7D9XJq7vAu9DfNPutFiPcELUlSRXmBQfc=
X-Gm-Gg: ASbGncsH1qKZZdn+4Lppt6GwWqio9UAoz3M84dz4Nnl/nU3K8reL9wnEtyndD/lolvk
 Ap5MCxoOZf9B7ocGn6DcqbWwUEepAucccAdYEhs95/LjYvOhDYSaOLLzC+VSVLvQVLZ6e9PJWck
 5hoVRm4hkrIbqHPprKyeK1izCVHxVaUHsBZZ0+/WobYOKlpzvIsGfZ1mefbDafzA7TLeZXbqmED
 VMQK6SIWIMaSSQzqXY/2YzV5ZiILK90Y2zv3DaQHpkW+Nv09xk5hos3Db22xk0T1FtU2qkkhD/i
 GrwNdo3o7EjEnbgeaCg8
X-Received: by 2002:a05:6402:42c3:b0:5de:dfde:c8b1 with SMTP id
 4fb4d7f45d1cf-5e444853739mr30916757a12.4.1740666044079; 
 Thu, 27 Feb 2025 06:20:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEwHF5s+2czzZF4i+g5uC8ZIvIPzvxMVtRvVmvQf1ifmOd2a2Ary/406iyFDTqANlGIppsrA==
X-Received: by 2002:a05:6402:42c3:b0:5de:dfde:c8b1 with SMTP id
 4fb4d7f45d1cf-5e444853739mr30916682a12.4.1740666043562; 
 Thu, 27 Feb 2025 06:20:43 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c0b9961sm132113566b.10.2025.02.27.06.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 23/34] rust: pl011, qemu_api tests: do not use ClassInitImpl
Date: Thu, 27 Feb 2025 15:19:41 +0100
Message-ID: <20250227141952.811410-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 38 ++++++++++++++++----------------
 rust/qemu-api/tests/tests.rs     | 33 ++++++++++-----------------
 2 files changed, 31 insertions(+), 40 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index ead361b3f52..094049cb9e6 100644
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


