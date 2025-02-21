Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A29C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 17:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlWRX-0006oE-MJ; Fri, 21 Feb 2025 12:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRQ-0006jv-2r
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:03:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRO-0001Ou-3T
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740157433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G+2kng6sRFTLtB08RcVigadgRIcXeqRixX2Ql4tgm1M=;
 b=duScw2tfRxTenP3W39F5ESuuQheffkAJkXaaykU229dW2ASOG8e7OOrj8sAhuzUqdgKEf8
 ppDS/fsEfyN2T+xvVxdZxUfiNxWNIiIGdJtV9PKqNNyek5H4nxvWdutfsdPSWYQB19azNV
 02oSlHtSlYOi0soBTiA4hG7Huj2xBO8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-JvrsMP7RN5y4omD8q4L7Hw-1; Fri, 21 Feb 2025 12:03:51 -0500
X-MC-Unique: JvrsMP7RN5y4omD8q4L7Hw-1
X-Mimecast-MFC-AGG-ID: JvrsMP7RN5y4omD8q4L7Hw_1740157430
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-438da39bb69so16012445e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 09:03:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740157430; x=1740762230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G+2kng6sRFTLtB08RcVigadgRIcXeqRixX2Ql4tgm1M=;
 b=aB2ja7hDyVXn4r22dN5771a9owsn9jL9kbWP3LwSPVi/sNbutxDwSMVq3XXyCRyU/3
 agRzLHRmu+RBuhf61KsYLfGaaZkASOJGBzW5ZrLJvAEiCNt9Ka8Kex1BvuOqcGnRSElU
 CDuqv6SU1bMZdtWTzPz4QLd5hyVYbelBnj94X3uO8iuEleUCNZNn44WnUsbH0B9qQNsX
 q5CJpnjK3bOI8JFJnQ38pVnRSnDqNGcxpDdBeScgn/BBWLlL6dkQ4vJhhH0s0jBtDFKh
 idb7+4hCbyAq5E5c/16bq4hK1pXQtdiC3ZSUjaJe7QP9NbCQ3sPchcCv72e6DidrxO25
 nxtw==
X-Gm-Message-State: AOJu0YwU5xqf3cmV76L9ZoEFFFBoUKAsjqmgmhptdnVwREvGqaEoggwD
 ZcXKGU6OIoSS8rvPJImF8dhpJq3zHX8b9llplo94OxG48PbgiPskmNNGiBW/o2FyWCltikI1HjF
 iGzKtQs/CJmpfHCeFzlijLVZlcNpdyKYm7wMLJBHfdY0eR1vLsh1BjomqKvDVTzQaT+D6mhdk2D
 Teg84t8IKx+HYi7zT9u1YxbvCm0/lATEbEyCiO9Rk=
X-Gm-Gg: ASbGncvDN76YgO4MLjSccnFgSRJqj5SMmTRApNmMp9nsSV8fyBdocupka8bFEbbmKQ5
 +h+qNaQU675Xbriea1JhDBF4O4JyyD6Pn6XrpiMh7LZmquTAAV/dTWY7zoRaGP1c+9jMUWNI+XW
 3jdP7H3Nleje1MCwtn0S8eNeeIoyglshGgj5ejLZsvrg3s+gBX5c88DsUN9GxwDQDvtVfwMzkgb
 YCAsFP1rl9xmTgPTaEEqppY2EMyosM3w95e4dv0CbOmU5DwtKS1lFeTxiTOsBBc68H/qBNVDjmF
 WQykLBqvSRoP8SgOZpo=
X-Received: by 2002:a05:600c:468a:b0:439:87d2:b0fd with SMTP id
 5b1f17b1804b1-439ae1e8dc2mr37053335e9.12.1740157429603; 
 Fri, 21 Feb 2025 09:03:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGq4r8d+X1Ah+8VVeXGPFojGkr0Y/GIJbu2hBMO1Z/gUvvNGqrM95nyK7Hib7qyi4XybK+Evw==
X-Received: by 2002:a05:600c:468a:b0:439:87d2:b0fd with SMTP id
 5b1f17b1804b1-439ae1e8dc2mr37051615e9.12.1740157428223; 
 Fri, 21 Feb 2025 09:03:48 -0800 (PST)
Received: from [192.168.10.48] ([151.95.61.185])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce404sm23182125e9.7.2025.02.21.09.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:03:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 03/15] rust: qom: add ObjectImpl::CLASS_INIT
Date: Fri, 21 Feb 2025 18:03:30 +0100
Message-ID: <20250221170342.63591-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221170342.63591-1-pbonzini@redhat.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
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

As shown in the PL011 device, the orphan rules required a manual
implementation of ClassInitImpl for anything not in the qemu_api crate;
this gets in the way of moving system emulation-specific code (including
DeviceClass, which as a blanket ClassInitImpl<DeviceClass> implementation)
into its own crate.

Make ClassInitImpl optional, at the cost of having to specify the CLASS_INIT
member by hand in every implementation of ObjectImpl.  The next commits will
get rid of it, replacing all the "impl<T> ClassInitImpl<Class> for T" blocks
with a generic class_init<T> method on Class.

Right now the definition is always the same, but do not provide a default
as that will not be true once ClassInitImpl goes away.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs |  3 +++
 rust/hw/timer/hpet/src/hpet.rs   |  3 ++-
 rust/qemu-api/src/qom.rs         | 14 +++++++++++---
 rust/qemu-api/tests/tests.rs     |  3 +++
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 7063b60c0cc..a6da9db0bb0 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -160,6 +160,7 @@ impl ObjectImpl for PL011State {
 
     const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
     const INSTANCE_POST_INIT: Option<fn(&Self)> = Some(Self::post_init);
+    const CLASS_INIT: fn(&mut Self::Class) = <Self as ClassInitImpl<Self::Class>>::class_init;
 }
 
 impl DeviceImpl for PL011State {
@@ -744,6 +745,8 @@ unsafe impl ObjectType for PL011Luminary {
 
 impl ObjectImpl for PL011Luminary {
     type ParentType = PL011State;
+
+    const CLASS_INIT: fn(&mut Self::Class) = <Self as ClassInitImpl<Self::Class>>::class_init;
 }
 
 impl DeviceImpl for PL011Luminary {}
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index b4ffccf815f..e01b4b67064 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -21,7 +21,7 @@
     },
     prelude::*,
     qdev::{DeviceImpl, DeviceMethods, DeviceState, Property, ResetType, ResettablePhasesImpl},
-    qom::{ObjectImpl, ObjectType, ParentField},
+    qom::{ClassInitImpl, ObjectImpl, ObjectType, ParentField},
     qom_isa,
     sysbus::{SysBusDevice, SysBusDeviceImpl},
     timer::{Timer, CLOCK_VIRTUAL},
@@ -836,6 +836,7 @@ impl ObjectImpl for HPETState {
 
     const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
     const INSTANCE_POST_INIT: Option<fn(&Self)> = Some(Self::post_init);
+    const CLASS_INIT: fn(&mut Self::Class) = <Self as ClassInitImpl<Self::Class>>::class_init;
 }
 
 // TODO: Make these properties user-configurable!
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 10ce359becb..d821ac25acc 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -180,7 +180,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> Result<(), fmt::Error> {
     T::INSTANCE_POST_INIT.unwrap()(unsafe { state.as_ref() });
 }
 
-unsafe extern "C" fn rust_class_init<T: ObjectType + ClassInitImpl<T::Class>>(
+unsafe extern "C" fn rust_class_init<T: ObjectType + ObjectImpl>(
     klass: *mut ObjectClass,
     _data: *mut c_void,
 ) {
@@ -190,7 +190,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> Result<(), fmt::Error> {
     // SAFETY: klass is a T::Class, since rust_class_init<T>
     // is called from QOM core as the class_init function
     // for class T
-    T::class_init(unsafe { klass.as_mut() })
+    <T as ObjectImpl>::CLASS_INIT(unsafe { klass.as_mut() })
 }
 
 unsafe extern "C" fn drop_object<T: ObjectImpl>(obj: *mut Object) {
@@ -499,7 +499,7 @@ impl<T: ObjectType> ObjectDeref for &mut T {}
 impl<T: ObjectType> ObjectCastMut for &mut T {}
 
 /// Trait a type must implement to be registered with QEMU.
-pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> + IsA<Object> {
+pub trait ObjectImpl: ObjectType + IsA<Object> {
     /// The parent of the type.  This should match the first field of the
     /// struct that implements `ObjectImpl`, minus the `ParentField<_>` wrapper.
     type ParentType: ObjectType;
@@ -552,6 +552,14 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> + IsA<Object> {
 
     // methods on ObjectClass
     const UNPARENT: Option<fn(&Self)> = None;
+
+    /// Store into the argument the virtual method implementations
+    /// for `Self`.  On entry, the virtual method pointers are set to
+    /// the default values coming from the parent classes; the function
+    /// can change them to override virtual methods of a parent class.
+    ///
+    /// Usually defined as `<Self as ClassInitImpl<Self::Class>::class_init`.
+    const CLASS_INIT: fn(&mut Self::Class);
 }
 
 /// Internal trait used to automatically fill in a class struct.
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 03569e4a44c..9546e9d7963 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -60,6 +60,7 @@ unsafe impl ObjectType for DummyState {
 impl ObjectImpl for DummyState {
     type ParentType = DeviceState;
     const ABSTRACT: bool = false;
+    const CLASS_INIT: fn(&mut DummyClass) = <Self as ClassInitImpl<DummyClass>>::class_init;
 }
 
 impl ResettablePhasesImpl for DummyState {}
@@ -102,6 +103,8 @@ unsafe impl ObjectType for DummyChildState {
 impl ObjectImpl for DummyChildState {
     type ParentType = DummyState;
     const ABSTRACT: bool = false;
+    const CLASS_INIT: fn(&mut DummyChildClass) =
+        <Self as ClassInitImpl<DummyChildClass>>::class_init;
 }
 
 impl ResettablePhasesImpl for DummyChildState {}
-- 
2.48.1


