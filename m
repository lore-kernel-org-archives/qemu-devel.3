Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D4AC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 19:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYsCr-0001cK-57; Fri, 17 Jan 2025 14:40:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYsCp-0001ae-3n
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:40:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYsCg-0002DJ-JQ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:40:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737142825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tB+0wLdGKfYjOO1CK7DKuiSRMJWw6EIiF2Kmen84UhQ=;
 b=Ud+5pwq8/f0pK9z3CJdpY8OtXhpTlnqb10gKE7WQuSyZmaney4YXZgaZzEcJLh54is2eun
 ikTrg/6m2Qou4X+rocviVQMo4/kAs+VcTVCBj32Coq1xHcCWw4H/put9B0pKiJVng0ARSW
 iFEtUiMxK2xlM/dokfzMTDqEjeCgAnM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-OjsqiqEPPWKxEvtnav0Bjg-1; Fri, 17 Jan 2025 14:40:23 -0500
X-MC-Unique: OjsqiqEPPWKxEvtnav0Bjg-1
X-Mimecast-MFC-AGG-ID: OjsqiqEPPWKxEvtnav0Bjg
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5d89a53fc46so3165208a12.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 11:40:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737142821; x=1737747621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tB+0wLdGKfYjOO1CK7DKuiSRMJWw6EIiF2Kmen84UhQ=;
 b=PjvZHXz/DT77Go0nsLDLJO09GR+qg4mG10EP8NQ69ate1A9OZroWPW9MnUg5I8S9Eh
 GtkMiIpfQJekHgq1InEwTwHj8IlAzbKXQD0PapXeCJj1huch5oKPXNIDenhAdYYeFe8E
 ONHjgsfM1YsgNokBYRo60eJ5jRhmPRCoi/fjeXzAXtWrDiSbLdsUxwvDaiF1YCBgLpvL
 XzQQOAbeEGpKe0Y+8BrUuzDLmcbg4tVxDy4BCH9ieqGi8NaczBSmAgW6k8hBxW+KOR8c
 7NGuUnavWXpcVZtPo1OPL1eFkO6xS8Wq3wgjbio1TBbOVOD/agC7RyGAmxQPe/3aJopg
 mDYA==
X-Gm-Message-State: AOJu0Ywo3tYW/PrqRHOiS8yTpXmo7hikbOgh92Hl4rN5BA96puOI2A5u
 OhMh8sIhNvo2MakrmDFJZQCAsh3caWs5N907m43vzSz8n/E38ZX+FRlGo4WJDegCRI7WmrPYl6K
 nlum+jhe4SM2FX3yMRgsxr+Eb7/W9bYYBxlkWHLwlRlovTz/slQcZg3uYguRkGYktycX2K0lu71
 tC1qRrtfqGdFKo+H8LX9KYfFTtIsGZZrX7OsLPKw8=
X-Gm-Gg: ASbGnctPtsAsTxriqlGE6So+Bzfk9uNzEKP2pQVMh+fDkMQXb9DEPQkkvCHCPnBhXUD
 gibR69KFwsZW//rEpUt+M2s/c021RQvmkY9C/C5YpybFuh3tR9l186jz4Nxry8OK0/PzLETxO21
 McJp2WLYGaRgu0xu6opsA+m/GR++lmKnHmfLrfMdymOv0lnSbsTdiOnJh2OF0hM46REGietFUfq
 sypvLWXYl92PRiCGaGhfR9f7ugH0Is7qRpJaNPx/3lVxw2MXVUiVPBwJ5ZJEg==
X-Received: by 2002:a05:6402:2342:b0:5db:67a7:e742 with SMTP id
 4fb4d7f45d1cf-5db7d2f947dmr3591163a12.8.1737142821022; 
 Fri, 17 Jan 2025 11:40:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbHfDaPZvPVis45W8G4jtQRMfhXqK0bY0Sa1dU3kx3iXc5jJ4dYg7FVyd2EaIFIN225cnciQ==
X-Received: by 2002:a05:6402:2342:b0:5db:67a7:e742 with SMTP id
 4fb4d7f45d1cf-5db7d2f947dmr3591134a12.8.1737142820549; 
 Fri, 17 Jan 2025 11:40:20 -0800 (PST)
Received: from [192.168.10.47] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db73642580sm1910393a12.15.2025.01.17.11.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 11:40:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 06/10] rust: qom: allow initializing interface vtables
Date: Fri, 17 Jan 2025 20:39:59 +0100
Message-ID: <20250117194003.1173231-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117194003.1173231-1-pbonzini@redhat.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.79,
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

Unlike regular classes, interface vtables can only be obtained via
object_class_dynamic_cast.  Provide a wrapper that allows accessing
the vtable and pass it to a ClassInitImpl implementation, for example
ClassInitImpl<ResettableClass>.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/prelude.rs |  1 +
 rust/qemu-api/src/qom.rs     | 45 ++++++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index 87e3ce90f26..254edb476dd 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -9,6 +9,7 @@
 
 pub use crate::qdev::DeviceMethods;
 
+pub use crate::qom::InterfaceType;
 pub use crate::qom::IsA;
 pub use crate::qom::Object;
 pub use crate::qom::ObjectCast;
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 6f7db3eabcb..8b2dbb3919c 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -66,8 +66,8 @@
 
 use crate::{
     bindings::{
-        self, object_dynamic_cast, object_get_class, object_get_typename, object_new, object_ref,
-        object_unref, TypeInfo,
+        self, object_class_dynamic_cast, object_dynamic_cast, object_get_class,
+        object_get_typename, object_new, object_ref, object_unref, TypeInfo,
     },
     cell::bql_locked,
 };
@@ -256,6 +256,47 @@ unsafe fn as_object_mut_ptr(&self) -> *mut Object {
     }
 }
 
+/// Trait exposed by all structs corresponding to QOM interfaces.
+/// Unlike `ObjectType`, it is implemented on the class type (which provides
+/// the vtable for the interfaces).
+///
+/// # Safety
+///
+/// `TYPE` must match the contents of the `TypeInfo` as found in the C code;
+/// right now, interfaces can only be declared in C.
+pub unsafe trait InterfaceType: Sized {
+    /// The name of the type, which can be passed to
+    /// `object_class_dynamic_cast()` to obtain the pointer to the vtable
+    /// for this interface.
+    const TYPE_NAME: &'static CStr;
+
+    /// Initialize the vtable for the interface; the generic argument `T` is the
+    /// type being initialized, while the generic argument `U` is the type that
+    /// lists the interface in its `TypeInfo`.
+    ///
+    /// # Panics
+    ///
+    /// Panic if the incoming argument if `T` does not implement the interface.
+    fn interface_init<
+        T: ObjectType + ClassInitImpl<Self> + ClassInitImpl<U::Class>,
+        U: ObjectType,
+    >(
+        klass: &mut U::Class,
+    ) {
+        unsafe {
+            // SAFETY: upcasting to ObjectClass is always valid, and the
+            // return type is either NULL or the argument itself
+            let result: *mut Self = object_class_dynamic_cast(
+                (klass as *mut U::Class).cast(),
+                Self::TYPE_NAME.as_ptr(),
+            )
+            .cast();
+
+            <T as ClassInitImpl<Self>>::class_init(result.as_mut().unwrap())
+        }
+    }
+}
+
 /// This trait provides safe casting operations for QOM objects to raw pointers,
 /// to be used for example for FFI. The trait can be applied to any kind of
 /// reference or smart pointers, and enforces correctness through the [`IsA`]
-- 
2.47.1


