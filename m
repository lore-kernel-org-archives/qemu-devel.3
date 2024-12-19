Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E23E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOByU-0005jz-W4; Thu, 19 Dec 2024 03:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByT-0005fO-1N
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByQ-0005Du-Or
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4JuCYauHZuFnfd9+PJ8lQTIeKVe3Bn39qjIyqWPL2KU=;
 b=P/WaJtQn21dp25QQZIBlQDX0tl99P5GxL+NO5GZrLYNJF5qfbNq9DFcpbjTHstiRBKGtg0
 dxqGwZyZbkj0rA3fjY5W68pzxGQtg3K4gL25/JS3p9KH53Diwy/mlabbNKfMeFRBpoBt06
 53d77LQr/WOvB4tSJRRE/ULh+X+iGzQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-CcSkPH6mN1CCV8fSMWx3CQ-1; Thu, 19 Dec 2024 03:33:32 -0500
X-MC-Unique: CcSkPH6mN1CCV8fSMWx3CQ-1
X-Mimecast-MFC-AGG-ID: CcSkPH6mN1CCV8fSMWx3CQ
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-386321c8f4bso302867f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:33:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597210; x=1735202010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4JuCYauHZuFnfd9+PJ8lQTIeKVe3Bn39qjIyqWPL2KU=;
 b=jUDK5tptBBn2p/FzWO6XTRPAKtFNaMdA1gdjBY3WbleHwGrOD+PeQsLDpCLFUA4wIn
 iyAz/559MBndIBKhoAb9aa6VRbRFTYr8FSLle8U12c8gSpTrVQOyXNesDLIZqxpUqg6p
 ooPjjQ7HVJ3YAwJzm1bkhGztwAaPeU32iAywayeLWpUWO7bSJdZ6sVwzQC2ZyOgudTrC
 6dqNkxBYhYyEiM1k+L2/nj8NL2MphFEZj/IePJsUo3C38JjlkDIF2yAcNJEm6Doc+tjD
 GTs/QZstTrCqQTx/Z89Pnh+m6jf38Rvl2IXXdn1kMiLVn9QMOCMdsZAOa+nP+j7U2V8/
 w/gw==
X-Gm-Message-State: AOJu0Yxa4G1Z8SZq+ThAwzz/Y905nN1dfoQaanJFaEy+tCwYMdKP5rZX
 BezWEf+Xjc3pH4LvUQ7xU+HZICo99JN2DZWeM/NRG7XTeb3QdwetszYc2l/Ss11sUz3nFUjjnvA
 eHGbX0sgTDcOzPa6DxH7L1hKUa3tyu94HUVyw6IoGinppIcYBfUBfM7nXt34uANBQxBn7ALw90j
 u0ArndOc+dh0Tb5E/I2QvYZhx4BaQi43D7EacF
X-Gm-Gg: ASbGncuiX0WxRVRhRfK7d/Gtb6P7uiGWjKFUrlSCPo/jawCcxcrWVlXVnrP2kOPV3fx
 Mj0skgPrKB6kleiXZ62VKtkIjZeofAd59awRvF+hZTGiG6WbbDV77U6u92dUmVNBVpTwXk5z4My
 1Wgna4XtHac32xPXQP/ot5HDEn5oGEQUkN/YLUmHjJ77WPBGMgAsoJWBug7hHutBj0xgUIuAk2s
 NIhyAsbdbPos6kCnIxZnlCltnE+jXIQga6IDv+3tiMq6AvBR+/hXyUyZ4a2
X-Received: by 2002:a5d:47af:0:b0:385:de8d:c0f5 with SMTP id
 ffacd0b85a97d-388e4d4b5e8mr4911222f8f.16.1734597210486; 
 Thu, 19 Dec 2024 00:33:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCH2Sctnuu7aGZPs2XpMPyb9Nn96mjbdMPHxCk+jTiB/GWlKVrw6q6pgPd9/vjLKx3a16BlQ==
X-Received: by 2002:a5d:47af:0:b0:385:de8d:c0f5 with SMTP id
 ffacd0b85a97d-388e4d4b5e8mr4911193f8f.16.1734597209981; 
 Thu, 19 Dec 2024 00:33:29 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8acafesm970774f8f.98.2024.12.19.00.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:33:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 28/41] rust: re-export C types from qemu-api submodules
Date: Thu, 19 Dec 2024 09:32:15 +0100
Message-ID: <20241219083228.363430-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Long term we do not want device code to use "bindings" at all, so make it
possible to get the relevant types from the other modules of qemu-api.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/qdev.rs    |  7 +++++--
 rust/qemu-api/src/qom.rs     | 12 +++++++-----
 rust/qemu-api/src/sysbus.rs  |  5 +----
 rust/qemu-api/src/vmstate.rs |  9 +++++----
 rust/qemu-api/tests/tests.rs |  9 +++++++--
 5 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index ad4c12d097e..07a502a8371 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -6,10 +6,13 @@
 
 use std::ffi::CStr;
 
+pub use bindings::{DeviceClass, DeviceState, Property};
+
 use crate::{
-    bindings::{self, DeviceClass, DeviceState, Error, ObjectClass, Property, VMStateDescription},
+    bindings::{self, Error},
     prelude::*,
-    qom::ClassInitImpl,
+    qom::{ClassInitImpl, ObjectClass},
+    vmstate::VMStateDescription,
 };
 
 /// Trait providing the contents of [`DeviceClass`].
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 2222d1a5ab9..a663647ffe5 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -33,7 +33,9 @@
 
 use std::{ffi::CStr, os::raw::c_void};
 
-use crate::bindings::{self, Object, ObjectClass, TypeInfo};
+pub use bindings::{Object, ObjectClass};
+
+use crate::bindings::{self, TypeInfo};
 
 unsafe extern "C" fn rust_instance_init<T: ObjectImpl>(obj: *mut Object) {
     // SAFETY: obj is an instance of T, since rust_instance_init<T>
@@ -164,9 +166,9 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
 ///
 /// Each struct will implement this trait with `T` equal to each
 /// superclass.  For example, a device should implement at least
-/// `ClassInitImpl<`[`DeviceClass`](crate::bindings::DeviceClass)`>` and
-/// `ClassInitImpl<`[`ObjectClass`](crate::bindings::ObjectClass)`>`.
-/// Such implementations are made in one of two ways.
+/// `ClassInitImpl<`[`DeviceClass`](crate::qdev::DeviceClass)`>` and
+/// `ClassInitImpl<`[`ObjectClass`]`>`.  Such implementations are made
+/// in one of two ways.
 ///
 /// For most superclasses, `ClassInitImpl` is provided by the `qemu-api`
 /// crate itself.  The Rust implementation of methods will come from a
@@ -221,7 +223,7 @@ pub trait ClassInitImpl<T> {
     ///
     /// The virtual method implementations usually come from another
     /// trait, for example [`DeviceImpl`](crate::qdev::DeviceImpl)
-    /// when `T` is [`DeviceClass`](crate::bindings::DeviceClass).
+    /// when `T` is [`DeviceClass`](crate::qdev::DeviceClass).
     ///
     /// On entry, `klass`'s parent class is initialized, while the other fields
     /// are all zero; it is therefore assumed that all fields in `T` can be
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index fa69cadd7c1..9abc687a261 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -7,10 +7,7 @@
 pub use bindings::{SysBusDevice, SysBusDeviceClass};
 
 use crate::{
-    bindings::{self, DeviceClass},
-    cell::bql_locked,
-    irq::InterruptSource,
-    prelude::*,
+    bindings, cell::bql_locked, irq::InterruptSource, prelude::*, qdev::DeviceClass,
     qom::ClassInitImpl,
 };
 
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index bedcf1e8f39..25c68b703ea 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -10,6 +10,8 @@
 //! [`vmstate_fields`](crate::vmstate_fields) are meant to be used when
 //! declaring a device model state struct.
 
+pub use crate::bindings::VMStateDescription;
+
 #[doc(alias = "VMSTATE_UNUSED_BUFFER")]
 #[macro_export]
 macro_rules! vmstate_unused_buffer {
@@ -328,7 +330,7 @@ macro_rules! vmstate_fields {
 }
 
 /// A transparent wrapper type for the `subsections` field of
-/// [`VMStateDescription`](crate::bindings::VMStateDescription).
+/// [`VMStateDescription`].
 ///
 /// This is necessary to be able to declare subsection descriptions as statics,
 /// because the only way to implement `Sync` for a foreign type (and `*const`
@@ -342,9 +344,8 @@ macro_rules! vmstate_fields {
 
 unsafe impl Sync for VMStateSubsectionsWrapper {}
 
-/// Helper macro to declare a list of subsections
-/// ([`VMStateDescription`](`crate::bindings::VMStateDescription`)) into a
-/// static and return a pointer to the array of pointers it created.
+/// Helper macro to declare a list of subsections ([`VMStateDescription`])
+/// into a static and return a pointer to the array of pointers it created.
 #[macro_export]
 macro_rules! vmstate_subsections {
     ($($subsection:expr),*$(,)*) => {{
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 78f7da474b2..68557fb85c7 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -5,8 +5,13 @@
 use std::ffi::CStr;
 
 use qemu_api::{
-    bindings::*, c_str, declare_properties, define_property, prelude::*, qdev::DeviceImpl,
-    qom::ObjectImpl, zeroable::Zeroable,
+    bindings::*,
+    c_str, declare_properties, define_property,
+    prelude::*,
+    qdev::{DeviceImpl, DeviceState, Property},
+    qom::ObjectImpl,
+    vmstate::VMStateDescription,
+    zeroable::Zeroable,
 };
 
 #[test]
-- 
2.47.1


