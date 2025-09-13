Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80A0CAC587
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLM2-0007sz-4t; Sat, 13 Sep 2025 04:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLu-000706-TD
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLr-00055D-84
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=abpJhzSiEvSBxp/thG7p1BXuYoKn4R+kKTAYQkjtF8A=;
 b=PINNXHn+/rB7hwW34KIuhiX1tPWVyBhAoGom89t4MY9U/fU3Vy2zrvjHVj66mH0vQKvXsS
 nVb5CcialQ6IzJggQE8RJeyzYmmtt+GxgdXy4gMqqJ/VoqYLQ2sBBeozlD85hZ22waOh1a
 4mED539w/ROqNOj8q9oOYSmyabgD3pE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-zENST5IwNj2oyDolaFvohA-1; Sat, 13 Sep 2025 04:11:08 -0400
X-MC-Unique: zENST5IwNj2oyDolaFvohA-1
X-Mimecast-MFC-AGG-ID: zENST5IwNj2oyDolaFvohA_1757751067
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3e3f8616125so2193037f8f.1
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751066; x=1758355866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=abpJhzSiEvSBxp/thG7p1BXuYoKn4R+kKTAYQkjtF8A=;
 b=A+Z/IWuzuARPerKqsyYQvl1rvgbuhuGTItJdkcAuk4oQt5TFD3dJAN8bPaPTs3axJD
 LzlRnQaYiaS7Dywnv/ykGUjTfc+sNgp0hZoaEN6QEmr+QZBiPh+1na+jgbxUmmVp+0CM
 CGAqQRVNNhRqbEo8Aq4SYzLVffDwtg5EZGrrIbMpu0UkmRzYJs8W0wjX3xiJroB8zUE3
 hQ5Sg5tc2x3akwjISNbSxmYLTeLQgvldkaNOGXB6CsgxuzltUUTNWpW0rVaSbnG+UV1f
 J/TR2iF6e2B8svugQiyMVF+3XF2UkEI5tZOX976t5wqIZvCcliZfpD/e7BzS+k1m3Asz
 WOEw==
X-Gm-Message-State: AOJu0YwzTw+XFPLqP0Jh8v4fyR8t0U1e9q8PGinNAKHOZNlXeeWnKb7q
 Sfd7z1ShIcj/D8aBaD6SwEhG1WNaA2FRdXCncbgBenPqw22gQG7zikLMOmG67pOSB0eki3VDkGG
 D2S0/F0ruqfQwh4KiI3aUfGt8thMrKKTM6DQYiiKvSPPT75sHNtyBG7ZXsv+i3HaWRM6oK1yGif
 w9z9rhJW4AxtqjRDT7D5WpDFpr07jaIil5/vmQtTGW
X-Gm-Gg: ASbGncufHW6dwiy8tveKzLjEhKanUhqHg51oe4ZW3sPoxcpUhL9dBmXE9yC0zR40Gdd
 ZAClLp1VobHqGVCUfn+imtyW2KvbH1sdIDKT632JTFiqHmVdezRMrPXDAqOehLk/LsBTBhd/vHc
 1doOWZQpf3hc4dnSq46Ulo+TPpeQCzFjsab7dIqdGwpa6XfEimTkKfgDvFv52xWXaQwrcudUeF8
 EESYsCP0uOSdxOsQ+XmkvUK/gLsLF8jVrDTtWQ05PaTeUz09NiAztNZPDk1QR6dQmuO9w7bDqjq
 AIiSoxdJnyS3ayhfXPph+rbFqbemX2kAbFKpiMPebrLmLd7lA7PA1iE/hO04rhdyx/vbBpUJMow
 GK8SvvgHwxw2TvgVQnqp6D9rzgMLMLAlGYeJIIc6+RSQ=
X-Received: by 2002:a05:6000:288c:b0:3e2:a7b2:d2f with SMTP id
 ffacd0b85a97d-3e75e15ccdcmr7255966f8f.26.1757751066286; 
 Sat, 13 Sep 2025 01:11:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTKl8gXeE2ppbLrHMs1PLfhXZlLD1z/CDRjcKRXRbMp5SBTQm8+R6n+tIJOlo80DTttiD5yg==
X-Received: by 2002:a05:6000:288c:b0:3e2:a7b2:d2f with SMTP id
 ffacd0b85a97d-3e75e15ccdcmr7255942f8f.26.1757751065742; 
 Sat, 13 Sep 2025 01:11:05 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e04cf2870sm46739375e9.1.2025.09.13.01.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:11:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 28/61] rust: qdev: const_refs_to_static
Date: Sat, 13 Sep 2025 10:09:09 +0200
Message-ID: <20250913080943.11710-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250908105005.2119297-10-pbonzini@redhat.com
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


