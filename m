Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA61D3B7E7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 08:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFU6K-0004sH-SA; Mon, 25 Nov 2024 03:05:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFU65-0004o2-81
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:05:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFU63-0007Ie-ET
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732521924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RcrHgMdCsUhvADJrJg4+eYOpXQ+ywXU2jAJ9ArRuW1U=;
 b=QfRM6uT8erBKvnqGAGLA9Objo5tk2G0z/YaAsdZ388HAS5CNaAQUV/ljL7EHMUy/N2kSX2
 P3VBu84N8++JU18ipTk46UxFTYx+GTdaMqXT7ifLf9Cuk8zFrTPidCGTRNgI79vKS4+esm
 Sb/RbEqeZOA41749fv0X+0FyTElqjI0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-GKS4nSnGPOiF2TKw3CBMDA-1; Mon, 25 Nov 2024 03:05:20 -0500
X-MC-Unique: GKS4nSnGPOiF2TKw3CBMDA-1
X-Mimecast-MFC-AGG-ID: GKS4nSnGPOiF2TKw3CBMDA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-434996c1aa7so10212875e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 00:05:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732521918; x=1733126718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RcrHgMdCsUhvADJrJg4+eYOpXQ+ywXU2jAJ9ArRuW1U=;
 b=QJH+PTMYwmAtqDPJC8WjJoEUvoWDNtLLJEBU8wNhU/6qbLizs6Vx+JMrGYyYvUk11X
 jY2IsGIhIuMwBw+uu/4VsTkXqX5LZrGNQoqVnePmdNi2TW42W0bbODtA62Z2NxrVYhds
 ZD63QIiHd6yu8LGiTDy+jM0yWo8jkvL0J9MiD2YfuyJuKCl6ubRPD2LjDVpO7CUHkASG
 hdNjKg6rhD2oTbRvb+n6RTUqRkanpdX2xM6JR3nI6MApb8QOE1XaBOhqBZfKgwamW9hf
 3SIxjEV+B56n3Vd6QR55pxMkIjqn9S7iCc3HSJZyfuLzaEiqw55eTJxIf22PdHd7SgaL
 zIwA==
X-Gm-Message-State: AOJu0YxnB2J/Zu4O6np36mKbYlt16oDK/y5Z3E7e8Mv/b01jYk7Xtg6D
 tOcychECS62GNVKBl9P+HR6pbtJMduts0u5sawqRGRlodvQ/UgmsVvD9X0+9WpYfSeLBnPUdUyx
 lG4m/D9X+u3TueGIl2O0ccKNhndyuStAdkC/XqBgBGCpBsGRhpIN8LVgX2XXIInqqfgECXeazGk
 /J5hxIFkke50pv6kwXNvc6KY1S4idQTT1VUr0U
X-Gm-Gg: ASbGncvQnDPYuc01SXaVGxcuqnn3HSXaoEA74PxYO7SvnudFS9ASVbl81eip6Phf0Z3
 s3dpS/H+Z1U73BfKZpevs/WDSJAU7yxp9K5TfRuzIckFSd1oKs9uctA7VchQEraT6fNAmToJLGe
 vYJmLUZ0TPIrKQA1OebFcKED6fSA7Owz0bxb/2Mlqf/Y+jh/1b3nYUb8razMwJHp0eVAQ36+A+I
 V7CfpuvD0jWZ5uTzuk6nT5nCPoyT5KFK3uOPh9PER5C0uvlBms+NbM=
X-Received: by 2002:a05:6000:1fae:b0:382:5284:995 with SMTP id
 ffacd0b85a97d-38260b576c2mr10791992f8f.16.1732521918567; 
 Mon, 25 Nov 2024 00:05:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnNLgVp+oLPtLekQWmROdWdh6I0G6i2XLiIWkoicaj6IhIScbG1cu1XTw9FxqGrGYHZorxxg==
X-Received: by 2002:a05:6000:1fae:b0:382:5284:995 with SMTP id
 ffacd0b85a97d-38260b576c2mr10791963f8f.16.1732521918149; 
 Mon, 25 Nov 2024 00:05:18 -0800 (PST)
Received: from [192.168.10.47] ([151.49.236.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbee00fsm9615650f8f.96.2024.11.25.00.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 00:05:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 3/8] rust: qom: convert type_info! macro to an associated const
Date: Mon, 25 Nov 2024 09:05:02 +0100
Message-ID: <20241125080507.115450-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125080507.115450-1-pbonzini@redhat.com>
References: <20241125080507.115450-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

type_info! is only used in the definition of ObjectImpl::TYPE_INFO, and
in fact in all of them.  Pull type_info!'s definition into the ObjectImpl
trait, thus simplifying the external interface of qemu_api::definitions.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs |  6 ++--
 rust/qemu-api/src/definitions.rs | 50 ++++++++++++++------------------
 rust/qemu-api/tests/tests.rs     |  1 -
 3 files changed, 24 insertions(+), 33 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 763605d4776..f050a332170 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -106,7 +106,6 @@ pub struct PL011State {
 
 impl ObjectImpl for PL011State {
     type Class = PL011Class;
-    const TYPE_INFO: qemu_api::bindings::TypeInfo = qemu_api::type_info! { Self };
     const TYPE_NAME: &'static CStr = crate::TYPE_PL011;
     const PARENT_TYPE_NAME: Option<&'static CStr> = Some(TYPE_SYS_BUS_DEVICE);
     const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = Some(pl011_init);
@@ -149,7 +148,7 @@ unsafe fn init(&mut self) {
                 addr_of_mut!(*self).cast::<Object>(),
                 &PL011_OPS,
                 addr_of_mut!(*self).cast::<c_void>(),
-                Self::TYPE_INFO.name,
+                Self::TYPE_NAME.as_ptr(),
                 0x1000,
             );
             sysbus_init_mmio(sbd, addr_of_mut!(self.iomem));
@@ -598,7 +597,7 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
     chr: *mut Chardev,
 ) -> *mut DeviceState {
     unsafe {
-        let dev: *mut DeviceState = qdev_new(PL011State::TYPE_INFO.name);
+        let dev: *mut DeviceState = qdev_new(PL011State::TYPE_NAME.as_ptr());
         let sysbus: *mut SysBusDevice = dev.cast::<SysBusDevice>();
 
         qdev_prop_set_chr(dev, c_str!("chardev").as_ptr(), chr);
@@ -660,7 +659,6 @@ impl qemu_api::definitions::ClassInitImpl for PL011LuminaryClass {
 
 impl ObjectImpl for PL011Luminary {
     type Class = PL011LuminaryClass;
-    const TYPE_INFO: qemu_api::bindings::TypeInfo = qemu_api::type_info! { Self };
     const TYPE_NAME: &'static CStr = crate::TYPE_PL011_LUMINARY;
     const PARENT_TYPE_NAME: Option<&'static CStr> = Some(crate::TYPE_PL011);
     const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = Some(pl011_luminary_init);
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
index 3291f4242ce..6ecfaf51b09 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -9,15 +9,34 @@
 use crate::bindings::{Object, ObjectClass, TypeInfo};
 
 /// Trait a type must implement to be registered with QEMU.
-pub trait ObjectImpl {
-    type Class;
-    const TYPE_INFO: TypeInfo;
+pub trait ObjectImpl: Sized {
+    type Class: ClassInitImpl;
     const TYPE_NAME: &'static CStr;
     const PARENT_TYPE_NAME: Option<&'static CStr>;
     const ABSTRACT: bool = false;
     const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
     const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
     const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
+
+    const TYPE_INFO: TypeInfo = TypeInfo {
+        name: Self::TYPE_NAME.as_ptr(),
+        parent: if let Some(pname) = Self::PARENT_TYPE_NAME {
+            pname.as_ptr()
+        } else {
+            core::ptr::null_mut()
+        },
+        instance_size: core::mem::size_of::<Self>(),
+        instance_align: core::mem::align_of::<Self>(),
+        instance_init: Self::INSTANCE_INIT,
+        instance_post_init: Self::INSTANCE_POST_INIT,
+        instance_finalize: Self::INSTANCE_FINALIZE,
+        abstract_: Self::ABSTRACT,
+        class_size: core::mem::size_of::<Self::Class>(),
+        class_init: <Self::Class as ClassInitImpl>::CLASS_INIT,
+        class_base_init: <Self::Class as ClassInitImpl>::CLASS_BASE_INIT,
+        class_data: core::ptr::null_mut(),
+        interfaces: core::ptr::null_mut(),
+    };
 }
 
 /// Trait used to fill in a class struct.
@@ -83,28 +102,3 @@ extern "C" fn ctor_fn() {
         }
     };
 }
-
-#[macro_export]
-macro_rules! type_info {
-    ($t:ty) => {
-        $crate::bindings::TypeInfo {
-            name: <$t as $crate::definitions::ObjectImpl>::TYPE_NAME.as_ptr(),
-            parent: if let Some(pname) = <$t as $crate::definitions::ObjectImpl>::PARENT_TYPE_NAME {
-                pname.as_ptr()
-            } else {
-                ::core::ptr::null_mut()
-            },
-            instance_size: ::core::mem::size_of::<$t>(),
-            instance_align: ::core::mem::align_of::<$t>(),
-            instance_init: <$t as $crate::definitions::ObjectImpl>::INSTANCE_INIT,
-            instance_post_init: <$t as $crate::definitions::ObjectImpl>::INSTANCE_POST_INIT,
-            instance_finalize: <$t as $crate::definitions::ObjectImpl>::INSTANCE_FINALIZE,
-            abstract_: <$t as $crate::definitions::ObjectImpl>::ABSTRACT,
-            class_size:  ::core::mem::size_of::<<$t as $crate::definitions::ObjectImpl>::Class>(),
-            class_init: <<$t as $crate::definitions::ObjectImpl>::Class as $crate::definitions::ClassInitImpl>::CLASS_INIT,
-            class_base_init: <<$t as $crate::definitions::ObjectImpl>::Class as $crate::definitions::ClassInitImpl>::CLASS_BASE_INIT,
-            class_data: ::core::ptr::null_mut(),
-            interfaces: ::core::ptr::null_mut(),
-        };
-    }
-}
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 704c63c846f..7f9df348b00 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -55,7 +55,6 @@ pub struct DummyClass {
 
     impl ObjectImpl for DummyState {
         type Class = DummyClass;
-        const TYPE_INFO: qemu_api::bindings::TypeInfo = qemu_api::type_info! { Self };
         const TYPE_NAME: &'static CStr = c_str!("dummy");
         const PARENT_TYPE_NAME: Option<&'static CStr> = Some(device_class::TYPE_DEVICE);
     }
-- 
2.47.0


