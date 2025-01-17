Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81214C02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 19:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYsCY-0001WD-JY; Fri, 17 Jan 2025 14:40:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYsCW-0001Un-ST
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:40:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYsCV-0002BS-A6
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:40:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737142814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vaboZ+TQyEKNVXlrPQA7ag9T+Mayf0OWrnAczy+Hp9Q=;
 b=d3Vmz48bnYP+Qw1+uHf3DQRcrcv9z22eIb4YuNGxtt5NyRQBAb56fYv6BVu3qFmwRoM0AK
 yLAjbXaBRbcuFdEbGrFJaPpYv33sVGqxu6aBHIstSxXZxesRTLs/wFaZShGDyvA/3LkuCx
 VJM3+NRbzp0hn9JvKxAEi5JUYJecaTU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-GozuQNAlMNil04DBgb2Rrw-1; Fri, 17 Jan 2025 14:40:13 -0500
X-MC-Unique: GozuQNAlMNil04DBgb2Rrw-1
X-Mimecast-MFC-AGG-ID: GozuQNAlMNil04DBgb2Rrw
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5d40c0c728aso2307609a12.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 11:40:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737142810; x=1737747610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vaboZ+TQyEKNVXlrPQA7ag9T+Mayf0OWrnAczy+Hp9Q=;
 b=mEZ/tuClcEZ9NUKCqzKGMJiOdl2owGMeeqvDpHUXMbChUIcDpX7vt+LlTYx0uwZ8n2
 3etDK1sNBxAsbjVLF5cRY9aHQ4NT0BAgLwcVykmwQiADASSbiJw8jmRb4AmtniMOrSOy
 FmPRNgp0zpFvF5BJKxzGRjTSdn+hxyNk4DHs4b5oSKKGNXEcj+t3rXvJhw+rLRCzCmy1
 I9QsDpaJGgFsSDzdg6WRV8EVCIIwqhGIO/bjzZZQO6UaU3n1ZVWamPd17uBK4zHAWGcm
 Y6UcjGZfKY5M0qXWcx5SMpDTJu/zWHOXsTU/WU+gD9ukgaQN70Y3oEG3D3Nj82tUob3S
 mG9w==
X-Gm-Message-State: AOJu0Yx8SNpNwDLtEFUxdC85JoHFULeX+ofCY3syh13T7sVtw77QDH8t
 nYC2JQy5oGOIdL2LfDGj6YwNJRAd///8Zr21DBTuc2IjrXMH3oeYvVFV2TMj+/jNW9pqnwHM7fp
 bBxMt0p50wgcPVFyfqhRuFsqS+oLCj22p0RDGsmCX8gPV0nZu1EeVEkbzGj8d6DnNsi8joo8wOv
 iBIQDfwy/to3n4aKlOr0DtuPSjJ+9dYoffdcs12A0=
X-Gm-Gg: ASbGnctViUnbf7f88otu7UgzzDjqGPKzcdFhcjsiJXHQfPYo3FGDdzhvUt8+9zeLITa
 KiipTTcJyZCaS0Ty7XrLzKxXioDFUfVDRa3ZyXXYWvoxLcu+PGnSSELrkRqjkhiOK1Be6csPCrU
 Li/1ZggqapFaMtYsNo5SPQC6t1wN8W+WvQZJOVXuRTwAZ3tHLJJLiQOpHzalpchkrFFiHuemsRF
 7fsculqwv7h32LvGqKSQJNPz2Gu4ZvL9+Qrk/Py7xUdyrEsZ+6ZRkr6solH4g==
X-Received: by 2002:a05:6402:524b:b0:5d0:9054:b119 with SMTP id
 4fb4d7f45d1cf-5db7db07787mr8615037a12.21.1737142810512; 
 Fri, 17 Jan 2025 11:40:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDQN3/+dlRteAovEglF5VL6vxcKS7afffhvsgRaXODoQ26l5oelB3KyewP+DUvzPrRvfyxEA==
X-Received: by 2002:a05:6402:524b:b0:5d0:9054:b119 with SMTP id
 4fb4d7f45d1cf-5db7db07787mr8614735a12.21.1737142807492; 
 Fri, 17 Jan 2025 11:40:07 -0800 (PST)
Received: from [192.168.10.47] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db73642247sm1949804a12.2.2025.01.17.11.40.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 11:40:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 01/10] rust: qemu-api: add sub-subclass to the integration
 tests
Date: Fri, 17 Jan 2025 20:39:54 +0100
Message-ID: <20250117194003.1173231-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117194003.1173231-1-pbonzini@redhat.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

From: Zhao Liu <zhao1.liu@intel.com>

missing signed-off-by from zhao
---
 rust/qemu-api/tests/tests.rs | 56 ++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 526c3f4f8ea..5c3e75ed3d5 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -14,8 +14,8 @@
     cell::{self, BqlCell},
     declare_properties, define_property,
     prelude::*,
-    qdev::{DeviceImpl, DeviceState, Property},
-    qom::{ObjectImpl, ParentField},
+    qdev::{DeviceClass, DeviceImpl, DeviceState, Property},
+    qom::{ClassInitImpl, ObjectImpl, ParentField},
     vmstate::VMStateDescription,
     zeroable::Zeroable,
 };
@@ -37,6 +37,10 @@ pub struct DummyState {
 
 qom_isa!(DummyState: Object, DeviceState);
 
+pub struct DummyClass {
+    parent_class: <DeviceState as ObjectType>::Class,
+}
+
 declare_properties! {
     DUMMY_PROPERTIES,
         define_property!(
@@ -49,7 +53,7 @@ pub struct DummyState {
 }
 
 unsafe impl ObjectType for DummyState {
-    type Class = <DeviceState as ObjectType>::Class;
+    type Class = DummyClass;
     const TYPE_NAME: &'static CStr = c_str!("dummy");
 }
 
@@ -67,6 +71,51 @@ fn vmsd() -> Option<&'static VMStateDescription> {
     }
 }
 
+// `impl<T> ClassInitImpl<DummyClass> for T` doesn't work since it violates
+// orphan rule.
+impl ClassInitImpl<DummyClass> for DummyState {
+    fn class_init(klass: &mut DummyClass) {
+        <Self as ClassInitImpl<DeviceClass>>::class_init(&mut klass.parent_class);
+    }
+}
+
+#[derive(qemu_api_macros::offsets)]
+#[repr(C)]
+#[derive(qemu_api_macros::Object)]
+pub struct DummyChildState {
+    parent: ParentField<DummyState>,
+}
+
+qom_isa!(DummyChildState: Object, DeviceState, DummyState);
+
+pub struct DummyChildClass {
+    parent_class: <DummyState as ObjectType>::Class,
+}
+
+unsafe impl ObjectType for DummyChildState {
+    type Class = DummyChildClass;
+    const TYPE_NAME: &'static CStr = c_str!("dummy_child");
+}
+
+impl ObjectImpl for DummyChildState {
+    type ParentType = DummyState;
+    const ABSTRACT: bool = false;
+}
+
+impl DeviceImpl for DummyChildState {}
+
+impl ClassInitImpl<DummyClass> for DummyChildState {
+    fn class_init(klass: &mut DummyClass) {
+        <Self as ClassInitImpl<DeviceClass>>::class_init(&mut klass.parent_class);
+    }
+}
+
+impl ClassInitImpl<DummyChildClass> for DummyChildState {
+    fn class_init(klass: &mut DummyChildClass) {
+        <Self as ClassInitImpl<DummyClass>>::class_init(&mut klass.parent_class);
+    }
+}
+
 fn init_qom() {
     static ONCE: BqlCell<bool> = BqlCell::new(false);
 
@@ -85,6 +134,7 @@ fn test_object_new() {
     init_qom();
     unsafe {
         object_unref(object_new(DummyState::TYPE_NAME.as_ptr()).cast());
+        object_unref(object_new(DummyChildState::TYPE_NAME.as_ptr()).cast());
     }
 }
 
-- 
2.47.1


