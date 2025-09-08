Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03E6CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvZSg-0006BS-4M; Mon, 08 Sep 2025 06:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSc-00068f-T1
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:50:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSK-000617-Hr
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757328633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jVfhBtBlOjXzGqnT8KeTSsWVyRaSIgsWAZBRhULMJZ8=;
 b=TVgSHCoBXrB14TB4H6CRPCQ/3Oi7vLlAGtRk2HbRawKhl3DontwhGz+TsIL29tIu7Aj5ug
 jZKaBYt2M3Udf74+Q0eNEjHX8fNiKkiFwXZXM/sFrhjPF9z5Liv74cAl1R/mCIuA26QMlH
 OgenOsEdqbZ2pjLCRYNANOgXvgZqLaE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-U1xS0S9HOwewj2o8F69Xaw-1; Mon, 08 Sep 2025 06:50:31 -0400
X-MC-Unique: U1xS0S9HOwewj2o8F69Xaw-1
X-Mimecast-MFC-AGG-ID: U1xS0S9HOwewj2o8F69Xaw_1757328630
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3dacc10dd30so3153286f8f.0
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757328629; x=1757933429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jVfhBtBlOjXzGqnT8KeTSsWVyRaSIgsWAZBRhULMJZ8=;
 b=dTkcLy3aw/MclZTkcCuy+4qYNorxevMdxWtsOoqi5QWIvsGTmgi5YMDcCoFQ8dT7UV
 Fk75B3w2FuXqgAR0CANvFa8xy648fMgdhvuHqT4ylb3E6Vf905ggbSBTYn0oxo+mrzRc
 R2DBDNY+DxCzRMJAgObTEFnszWEcKzBhYU0unLQiS3RGT+p37rUNJQvExlBT5DfXeOKK
 x+WEWs1I2Ll1uAKLdPFvr6hAdLtvwj9a35dYWnkUNGhC7sAWwxmmESR6rry/yW9Cd5NW
 EladQxrihfRq3tMqHBQZ1m7SposL71+xPmpKwkENkso7ejMzZGk2jH9GfA0/2SYjF6A1
 yQug==
X-Gm-Message-State: AOJu0YzAHbYeRwUEBcKO9sU/yXWGQcJNoB9qwFoVwOpVbXeEry2x+bbl
 q9NlhhzNZZ98Eqe1Aqe53nqIPdPX+bBQy/W+BsVWh0zU/ZLdDWSAra2pfDnjXBioq5A889ohlLv
 vqjTN+iOf3enOVJ5RYAXS3zc4cdJ7n6OtXSt8V5CC1bKJ8VJy06LI4Acfo5st75mCV/74X/gUD3
 eVCT+Sw89N98aksBB8yA+yhBDgIatXpUj/BZ9bN2lX
X-Gm-Gg: ASbGnct1AR388g8zEV0M+YFYAZI04VKf27kI0nilCcSCn7f6FIuPHVkhxJUEpzQg0vZ
 fRiQKKW3sGpmpdvJPj27ai87FnkU+v9hrdugsP0JA4O6h6tHmnhvT+DJV1NiJI30cUwxmV9DToD
 hpODEJDzPHmuAMHwmXu4uByYtdbP8/kvPAKlegQnzLD0lrx33SSNx31N5VND6FguTC6+CwmoCaS
 UR08azz7h6MkYhAFJMSjKhJiLinoBIKva+6PDlxvrdPMz4t1aPo5rXVOK77s0amVWAOv4MnV57d
 2HB1HVsC12QAQSo2p1HKIGiN8t0BL3rMLZ9fVb99lN2eigSXsGygKHZeLHfEKavC60gwRHoljTP
 /9anQ+JfU9oTGq0sPds3pLXkmAhJQ9nqxi4TB2HKaNSE=
X-Received: by 2002:a05:6000:1449:b0:3e3:b6ef:7243 with SMTP id
 ffacd0b85a97d-3e643556a10mr5439473f8f.51.1757328629365; 
 Mon, 08 Sep 2025 03:50:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKYtKVTX0xqubLBgFUa3J3cpAqRWlPUxrrsq24rKr6QAI4aZSIV2Gp+f0Fjrk4rie+lx8DPQ==
X-Received: by 2002:a05:6000:1449:b0:3e3:b6ef:7243 with SMTP id
 ffacd0b85a97d-3e643556a10mr5439444f8f.51.1757328628699; 
 Mon, 08 Sep 2025 03:50:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d9f3c36a78sm25571165f8f.48.2025.09.08.03.50.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:50:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/33] rust: qdev: const_refs_to_static
Date: Mon,  8 Sep 2025 12:49:41 +0200
Message-ID: <20250908105005.2119297-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908105005.2119297-1-pbonzini@redhat.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Now that const_refs_static can be assumed, convert the members of
the DeviceImpl trait from functions to constants.  This lets the
compiler know that they have a 'static lifetime, and removes the
need for the weird "Box::leak()".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs  |  4 +--
 rust/hw/timer/hpet/src/device.rs  |  9 ++-----
 rust/qemu-api-macros/src/lib.rs   |  8 +++---
 rust/qemu-api-macros/src/tests.rs | 44 ++++++++++++++-----------------
 rust/qemu-api/src/qdev.rs         | 19 +++++--------
 rust/qemu-api/tests/tests.rs      |  4 +--
 6 files changed, 33 insertions(+), 55 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 87a17716fed..8411db8d00c 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -172,9 +172,7 @@ impl ObjectImpl for PL011State {
 }
 
 impl DeviceImpl for PL011State {
-    fn vmsd() -> Option<VMStateDescription<Self>> {
-        Some(VMSTATE_PL011)
-    }
+    const VMSTATE: Option<VMStateDescription<Self>> = Some(VMSTATE_PL011);
     const REALIZE: Option<fn(&Self) -> qemu_api::Result<()>> = Some(Self::realize);
 }
 
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index eb5bd042b1c..dd5326a40d4 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -1008,16 +1008,11 @@ impl ObjectImpl for HPETState {
 // SAFETY: HPET_PROPERTIES is a valid Property array constructed with the
 // qemu_api::declare_properties macro.
 unsafe impl qemu_api::qdev::DevicePropertiesImpl for HPETState {
-    fn properties() -> &'static [Property] {
-        &HPET_PROPERTIES
-    }
+    const PROPERTIES: &'static [Property] = &HPET_PROPERTIES;
 }
 
 impl DeviceImpl for HPETState {
-    fn vmsd() -> Option<VMStateDescription<Self>> {
-        Some(VMSTATE_HPET)
-    }
-
+    const VMSTATE: Option<VMStateDescription<Self>> = Some(VMSTATE_HPET);
     const REALIZE: Option<fn(&Self) -> qemu_api::Result<()>> = Some(Self::realize);
 }
 
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 97b2c214b62..a65a7ce2fe9 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -289,11 +289,9 @@ macro_rules! str_to_c_str {
 
     Ok(quote_spanned! {input.span() =>
         unsafe impl ::qemu_api::qdev::DevicePropertiesImpl for #name {
-            fn properties() -> &'static [::qemu_api::bindings::Property] {
-                static PROPERTIES: &[::qemu_api::bindings::Property] = &[#(#properties_expanded),*];
-
-                PROPERTIES
-            }
+            const PROPERTIES: &'static [::qemu_api::bindings::Property] = &[
+                #(#properties_expanded),*
+            ];
         }
     })
 }
diff --git a/rust/qemu-api-macros/src/tests.rs b/rust/qemu-api-macros/src/tests.rs
index aafffcdce91..0e5a5728908 100644
--- a/rust/qemu-api-macros/src/tests.rs
+++ b/rust/qemu-api-macros/src/tests.rs
@@ -101,18 +101,16 @@ pub struct DummyState {
         },
         quote! {
             unsafe impl ::qemu_api::qdev::DevicePropertiesImpl for DummyState {
-                fn properties() -> &'static [::qemu_api::bindings::Property] {
-                    static PROPERTIES: &[::qemu_api::bindings::Property] =
-                        &[::qemu_api::bindings::Property {
-                            name: ::std::ffi::CStr::as_ptr(c"migrate_clock"),
-                            info: <bool as ::qemu_api::qdev::QDevProp>::VALUE,
-                            offset: ::core::mem::offset_of!(DummyState, migrate_clock) as isize,
-                            set_default: true,
-                            defval: ::qemu_api::bindings::Property__bindgen_ty_1 { u: true as u64 },
-                            ..::qemu_api::zeroable::Zeroable::ZERO
-                        }];
-                    PROPERTIES
-                }
+                const PROPERTIES: &'static [::qemu_api::bindings::Property] = &[
+                    ::qemu_api::bindings::Property {
+                        name: ::std::ffi::CStr::as_ptr(c"migrate_clock"),
+                        info: <bool as ::qemu_api::qdev::QDevProp>::VALUE,
+                        offset: ::core::mem::offset_of!(DummyState, migrate_clock) as isize,
+                        set_default: true,
+                        defval: ::qemu_api::bindings::Property__bindgen_ty_1 { u: true as u64 },
+                        ..::qemu_api::zeroable::Zeroable::ZERO
+                    }
+                ];
             }
         }
     );
@@ -130,18 +128,16 @@ pub struct DummyState {
         },
         quote! {
             unsafe impl ::qemu_api::qdev::DevicePropertiesImpl for DummyState {
-                fn properties() -> &'static [::qemu_api::bindings::Property] {
-                    static PROPERTIES: &[::qemu_api::bindings::Property] =
-                        &[::qemu_api::bindings::Property {
-                            name: ::std::ffi::CStr::as_ptr(c"migrate-clk"),
-                            info: <bool as ::qemu_api::qdev::QDevProp>::VALUE,
-                            offset: ::core::mem::offset_of!(DummyState, migrate_clock) as isize,
-                            set_default: true,
-                            defval: ::qemu_api::bindings::Property__bindgen_ty_1 { u: true as u64 },
-                            ..::qemu_api::zeroable::Zeroable::ZERO
-                        }];
-                    PROPERTIES
-                }
+                const PROPERTIES: &'static [::qemu_api::bindings::Property] = &[
+                    ::qemu_api::bindings::Property {
+                        name: ::std::ffi::CStr::as_ptr(c"migrate-clk"),
+                        info: <bool as ::qemu_api::qdev::QDevProp>::VALUE,
+                        offset: ::core::mem::offset_of!(DummyState, migrate_clock) as isize,
+                        set_default: true,
+                        defval: ::qemu_api::bindings::Property__bindgen_ty_1 { u: true as u64 },
+                        ..::qemu_api::zeroable::Zeroable::ZERO
+                    }
+                ];
             }
         }
     );
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 4dda8c81131..436142d8aef 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -151,11 +151,8 @@ unsafe impl QDevProp for crate::chardev::CharBackend {
 /// Caller is responsible for the validity of properties array.
 pub unsafe trait DevicePropertiesImpl {
     /// An array providing the properties that the user can set on the
-    /// device.  Not a `const` because referencing statics in constants
-    /// is unstable until Rust 1.83.0.
-    fn properties() -> &'static [Property] {
-        &[]
-    }
+    /// device.
+    const PROPERTIES: &'static [Property] = &[];
 }
 
 /// Trait providing the contents of [`DeviceClass`].
@@ -173,9 +170,7 @@ pub trait DeviceImpl:
     /// A `VMStateDescription` providing the migration format for the device
     /// Not a `const` because referencing statics in constants is unstable
     /// until Rust 1.83.0.
-    fn vmsd() -> Option<VMStateDescription<Self>> {
-        None
-    }
+    const VMSTATE: Option<VMStateDescription<Self>> = None;
 }
 
 /// # Safety
@@ -224,12 +219,10 @@ pub fn class_init<T: DeviceImpl>(&mut self) {
         if <T as DeviceImpl>::REALIZE.is_some() {
             self.realize = Some(rust_realize_fn::<T>);
         }
-        if let Some(vmsd) = <T as DeviceImpl>::vmsd() {
-            // Give a 'static lifetime to the return value of vmsd().
-            // Temporary until vmsd() can be changed into a const.
-            self.vmsd = Box::leak(Box::new(vmsd.get()));
+        if let Some(ref vmsd) = <T as DeviceImpl>::VMSTATE {
+            self.vmsd = vmsd.as_ref();
         }
-        let prop = <T as DevicePropertiesImpl>::properties();
+        let prop = <T as DevicePropertiesImpl>::PROPERTIES;
         if !prop.is_empty() {
             unsafe {
                 bindings::device_class_set_props_n(self, prop.as_ptr(), prop.len());
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 4d4e4653f38..13495687419 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -56,9 +56,7 @@ impl ObjectImpl for DummyState {
 impl ResettablePhasesImpl for DummyState {}
 
 impl DeviceImpl for DummyState {
-    fn vmsd() -> Option<VMStateDescription<Self>> {
-        Some(VMSTATE)
-    }
+    const VMSTATE: Option<VMStateDescription<Self>> = Some(VMSTATE);
 }
 
 #[repr(C)]
-- 
2.51.0


