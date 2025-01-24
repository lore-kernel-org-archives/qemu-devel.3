Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C95C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGI1-0004CQ-Ld; Fri, 24 Jan 2025 04:47:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGg-0007zR-KE
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGd-00041C-Uo
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ESHgSiSE1123xBuo1J97jzh2hkYZ9bH4zzgarY8aj/g=;
 b=J0vp8NswnYE6y24YDk5e5tObur0uyv12oQxmKZ2mAduZVtonBO6QIUeSReeTnHnQ6o7qNA
 Mtc/1W1G9MsY9ZqdRCW5ohc2THQxN+ahwLhUHN4A2xu+clV4kwFA7QZJEi+dCol7me3XcL
 B+0ZMd2/q+ezUBCoKZgncnwucAHLXmI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-lNUoovw2PC66eTwTR1i3EQ-1; Fri, 24 Jan 2025 04:46:20 -0500
X-MC-Unique: lNUoovw2PC66eTwTR1i3EQ-1
X-Mimecast-MFC-AGG-ID: lNUoovw2PC66eTwTR1i3EQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4362153dcd6so9086415e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:46:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711978; x=1738316778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ESHgSiSE1123xBuo1J97jzh2hkYZ9bH4zzgarY8aj/g=;
 b=VQLAfnkZcYKOLS2dTvi2wjNi/T5S3V4OGN8pYfcA4zIgnN3BAoHCKWA9vFF0LzcCex
 elWmW7xpFiex15XoHtN8MKUAyrLZbkmPynE46jbtJ1/HczjnYkE5nuX6dd2sLE8w0AcX
 u2SzcCTMCZq57FxSX6LUoVHZCb6476Wrr9VpF2QNXzuU/CXx7b/Sm1IymC3mUWWskeWI
 8VdV8KDd7PvdDLuWVNzxAHYI54xNCZs6AGOVp0GKF7rRDFrR9dtA7ZANb8BeRpqHam5n
 vRlsaQr7cwqaMhGMLzAiuZEDITXyMYBm0MP7PGhBH+hTt5JLeOO9oKIvqppshw+Ba5b3
 F5YQ==
X-Gm-Message-State: AOJu0YxEhm+2kpJNcl+t35rhO1wpjDvuUBv98xii/Gf/ixFE8HP49cL8
 ZPpD4eeEZk5YVE4ldsB7mmtO6/N0JjA8qzSAgaoOHcDPmEKQ2HGwLIRZpYYmNsYpGfc+2SdIzhv
 Ox3yCzeP8Bxv6xvzfoa+7HDxfaqGOYhV1AZ3njZbGEgD8LytM4BE6GA2SC0Z5jrvR3NvUSH0MnB
 HQJeiSffktdzOIeI5/kDpwnWjCurxTzn4oZ0fTVb0=
X-Gm-Gg: ASbGncubiWmxOLHWyHb2Il769zzzvJCpfYD91WPg8/SY76rn54HXXS3COqM48uuj3AQ
 cqVkVTs/IlOY7Gn2ejL8MEYUc95eyR3eFbJkzKm62gspKN9WC2dPWLRjFIauZsBW+SRv0JylGZx
 jO4jE+Ouj4q7pCUTWQLrDNq6MvWsxwuenfTCztVeo+UfYUC2u5luZE6M0qhbTNXYSMK3tezztFO
 PK6n/TVDHxoPHHXv+QbfLfAYQCFlCUXHEIt+Z4jxZ3uyL5+VB06qQG1zFgAqbIIGKdIAzO6Dw==
X-Received: by 2002:a05:600c:4fd6:b0:434:feb1:adcf with SMTP id
 5b1f17b1804b1-43891436690mr223595735e9.25.1737711978175; 
 Fri, 24 Jan 2025 01:46:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQw0q78asJ8ydf09X5+4Zdt/evkPrjtWQgWQSAs/cTYcwd1Vk+lgSSYu44GFjnIyo4jbXmQw==
X-Received: by 2002:a05:600c:4fd6:b0:434:feb1:adcf with SMTP id
 5b1f17b1804b1-43891436690mr223595575e9.25.1737711977857; 
 Fri, 24 Jan 2025 01:46:17 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4d2c0esm20278115e9.33.2025.01.24.01.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:46:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 48/48] rust: qemu-api: add sub-subclass to the integration tests
Date: Fri, 24 Jan 2025 10:44:42 +0100
Message-ID: <20250124094442.13207-49-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
2.48.1


