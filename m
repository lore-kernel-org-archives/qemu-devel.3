Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5063CC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIV6-00041c-9U; Mon, 01 Jul 2024 10:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIV4-00040Y-Q1
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIV3-0005JP-1E
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719845964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2fDHzvolcHSyEF2PMhkfCLwQi+naT9yNZR1yGvTHNhQ=;
 b=GmYTnDEwpZ4yqh6izq9MWGXXu0qbOsqDXKTQmN4B3MOJgWa7kflGxdm6g5INpOP5SaZpgi
 v/y1B0HmHSBSE6h035YY/JBMwbD6M6Yr1oPAt17eY5ADCxfgmPtCpG6+/34nu0N1OWJyek
 Cn0l7CRQHBnv4L4dDyO4lvdu61lqa2g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-vrFeTYTVM_uV3EiCgik-9A-1; Mon, 01 Jul 2024 10:59:23 -0400
X-MC-Unique: vrFeTYTVM_uV3EiCgik-9A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-424a5a5f024so20968345e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 07:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719845961; x=1720450761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2fDHzvolcHSyEF2PMhkfCLwQi+naT9yNZR1yGvTHNhQ=;
 b=B8JM2sMw0t+1qCjcjP9JJfPCbLQ9KJZdz5jj7puIixENp/Sbb1vr+gq3qJm9hfaEhp
 mU3a63EdrDSQJMXSHyRvmlA+HEaqw5Mhe0wuwtw3EhZSGgT2gxZ8mARotXkfeuUnOsPv
 uo8YY+WMzQlo5TDpzgQffcU5d4juhebq1p7f8id8CIrqm08wmUivfMraHV2v3MD8x/hu
 ek6ExQWTQz6EnuDJrlSb20GJUtgUWQzGC4hjQrq2hA58wcQde/WgjI6LOa4195cIOpVK
 alTVD6B4MTBcbD8jhUT3IQiSG6KyZmmLcDj7ChZiNvkXELVNZjAP/0FTXwOpICUmOMEY
 5F4A==
X-Gm-Message-State: AOJu0Ywb5GsV26yNn4zQPeIz7IH0LTXT7Nzd23+wAFJZ186fuOJP7JGF
 OwpgikdFVYd8qm2RGDl8JXu7oFXB6bJ11PAz3N2dNSbEIEtknqMl0fany7rCqRYsNYqOpA24Swa
 Di86T4gdcxgWelZJvlvGqB2etHyFMN+ETksV6IjbtJKYm9jRP9oVUDsuwTeMHLsXEm3Uu+l2rLU
 /cQqNOpfWwlFPCWi1tNYUIX1XFNb/GyLb5MY4Z
X-Received: by 2002:a05:600c:4213:b0:424:8fe1:41f9 with SMTP id
 5b1f17b1804b1-4257a02b772mr40209665e9.11.1719845961095; 
 Mon, 01 Jul 2024 07:59:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3E0S5vdT8n7O2aIMFqSXbXsqL/8LiVmGLXQLHirZr3Ks/sXxuBRDzCKbPLFLyHa0ERNzeQg==
X-Received: by 2002:a05:600c:4213:b0:424:8fe1:41f9 with SMTP id
 5b1f17b1804b1-4257a02b772mr40209425e9.11.1719845960731; 
 Mon, 01 Jul 2024 07:59:20 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d9385sm10201466f8f.39.2024.07.01.07.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 07:59:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 08/14] rust: define wrappers for methods of the QOM Device
 class
Date: Mon,  1 Jul 2024 16:58:40 +0200
Message-ID: <20240701145853.1394967-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701145853.1394967-1-pbonzini@redhat.com>
References: <20240701145853.1394967-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Provide a trait that can be used to invoke methods of the QOM Device
class.  The trait extends Deref and has a blanket implementation for any
type that dereferences to IsA<DeviceState>.  This way, it can be used on any
struct that dereferences to Object or a subclass.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu/src/hw/core/device.rs | 56 ++++++++++++++++++++++++++++++++++++++
 qemu/src/hw/core/mod.rs    |  1 +
 qemu/src/hw/mod.rs         |  1 +
 qemu/src/lib.rs            |  4 +++
 4 files changed, 62 insertions(+)
 create mode 100644 qemu/src/hw/core/device.rs
 create mode 100644 qemu/src/hw/core/mod.rs
 create mode 100644 qemu/src/hw/mod.rs

diff --git a/qemu/src/hw/core/device.rs b/qemu/src/hw/core/device.rs
new file mode 100644
index 0000000..294251e
--- /dev/null
+++ b/qemu/src/hw/core/device.rs
@@ -0,0 +1,56 @@
+//! Bindings for the QOM Device class
+//!
+//! @author Paolo Bonzini
+
+use crate::qom::object::ObjectType;
+
+use crate::qom::refs::IsA;
+use crate::qom::refs::ObjectCast;
+
+use crate::bindings;
+use crate::bindings::device_cold_reset;
+use crate::bindings::device_realize;
+use crate::bindings::DeviceState;
+use crate::bindings::Object;
+
+use crate::qom_isa;
+
+use crate::Result;
+
+use std::ffi::CStr;
+use std::ops::Deref;
+use std::ptr::null_mut;
+
+unsafe impl ObjectType for DeviceState {
+    const TYPE: &'static CStr = c"device";
+}
+
+qom_isa!(DeviceState, Object);
+
+/// Trait for methods exposed by the Object class.  The methods can be
+/// called on all objects that have the trait `IsA<Object>`.
+///
+/// The trait should only be used through the blanket implementation,
+/// which guarantees safety via `IsA`
+pub trait DeviceMethods: Deref
+where
+    Self::Target: IsA<DeviceState>,
+{
+    fn realize(&self) -> Result<()> {
+        let device = self.upcast::<DeviceState>();
+        let mut err: *mut bindings::Error = null_mut();
+        // SAFETY: safety of this is the requirement for implementing IsA
+        unsafe {
+            device_realize(device.as_mut_ptr(), &mut err);
+            crate::Error::err_or_default(err)
+        }
+    }
+
+    fn cold_reset(&self) {
+        let device = self.upcast::<DeviceState>();
+        // SAFETY: safety of this is the requirement for implementing IsA
+        unsafe { device_cold_reset(device.as_mut_ptr()) }
+    }
+}
+
+impl<R: Deref> DeviceMethods for R where R::Target: IsA<DeviceState> {}
diff --git a/qemu/src/hw/core/mod.rs b/qemu/src/hw/core/mod.rs
new file mode 100644
index 0000000..5458924
--- /dev/null
+++ b/qemu/src/hw/core/mod.rs
@@ -0,0 +1 @@
+pub mod device;
diff --git a/qemu/src/hw/mod.rs b/qemu/src/hw/mod.rs
new file mode 100644
index 0000000..5a7ca06
--- /dev/null
+++ b/qemu/src/hw/mod.rs
@@ -0,0 +1 @@
+pub mod core;
diff --git a/qemu/src/lib.rs b/qemu/src/lib.rs
index a6e7b17..b0dcce1 100644
--- a/qemu/src/lib.rs
+++ b/qemu/src/lib.rs
@@ -2,8 +2,12 @@
 #![allow(dead_code)]
 
 pub mod bindings;
+pub use bindings::DeviceState;
 pub use bindings::Object;
 
+pub mod hw;
+pub use hw::core::device::DeviceMethods;
+
 pub mod qom;
 pub use qom::object::ObjectClassMethods;
 pub use qom::object::ObjectMethods;
-- 
2.45.2


