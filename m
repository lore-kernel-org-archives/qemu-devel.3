Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF3EC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 10:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBslC-0005cz-GD; Mon, 05 May 2025 06:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBsl8-0005Ui-Tb
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:09:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBsl7-0007Dq-4t
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746439751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NziHDJPULqGSi476Eq607+qADlO5aBMunawIrs4CgEc=;
 b=jLID0sp2LgwQIMIgYXoh9PU1YwNCuxKNb30NRzR0B4+uc/b2b5l7Jh+Hwt2NNIz4xGNaRj
 pkIUFAWUxp4CbHIsnOmN4lh501VIqFpoQ2koTG9zmnmAq2OztgAtBwmku4ZhhCf9dPdAgj
 ar3ogi6cOYm/3/oKawVT/fyun6g7V+g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-X4m2q-YlP8qBecovAPA2GA-1; Mon, 05 May 2025 06:09:10 -0400
X-MC-Unique: X4m2q-YlP8qBecovAPA2GA-1
X-Mimecast-MFC-AGG-ID: X4m2q-YlP8qBecovAPA2GA_1746439749
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-440a4e2bad7so20339685e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 03:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746439748; x=1747044548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NziHDJPULqGSi476Eq607+qADlO5aBMunawIrs4CgEc=;
 b=qoUznOSZHNUwH+sEnaLJqLgTsG/rPXlOV7SYjU4o/8rlgKWZP6uuEEJrDusEHcPKMk
 ZArBiGfIC84mDUYaTm4EGLr4/kcKaS216btN6bYb62PLYNYFxP7xNwGbJyY8FfeGJYc9
 xM9ocf/gz7Q4dY560tLusZATN88bfQ+PQ4vKN3r9wi4olloINXi8Ru01moRBuaXqxlhR
 VwkFlYU7OBcb9lA2NonUGVMwRpStYk000sAwbva2HIKkHfSGnHYE7Ewxo6UdviQGNR8g
 k8DsCNi6MbvjqGGRYM1pz6aPMw8SsrfzpGK+y6TRqEWqr/SzsDPLOuJn9nLtXL4efp48
 5oCg==
X-Gm-Message-State: AOJu0YzKt1Gb6wNG+aoCVFqKyDKM9HVY0VCKpxVgzVJzvuDRJuf7MFN2
 ltn3o5kv5hCKWwOaPVYYEAERgQRL+mrnOnEN2yZZ+dX6j/KInSAVYLfmaW8dhirDkCr2+GIqjy8
 LQ0Y9hLy0zb6H8ZWucGAZpdW0W7TtZzRiixdxIwO0zmi7w1hOY0orfi7aN5l1R2CfP+IL+zBWmw
 lesOrZ7+q6tgZVOs29eQr9GiMHbcOiTTjyfonm
X-Gm-Gg: ASbGncsS13fu2rUTXrX+5g18bLUo2iI92sOmRCiG0SREAoJMrCWBUlM2blJSwZaVAIi
 WPy3aZSo+1sh37r6gsooMRSDFZNvGrbBFDzKFhN8nLP/QYHqEtnrtl3EWiQerRXGO2RYXf2ybGt
 h8h05TCAuW5GSgkKibE19LVtZDnWttrSatC+e1UOAjHZ8qkvlcDpLSPlsOk/eagFbr5xHOk9c4J
 2Jysmym060OVFWhTkyL0W7xLxO90UQlzzWb264T1067VW7S5KKpRFJAc8o+33nHIaDHYcz0VSei
 uzptuTur9HB32IA=
X-Received: by 2002:a05:6000:3105:b0:39f:bfa:7c90 with SMTP id
 ffacd0b85a97d-3a094038a8fmr11853799f8f.13.1746439748365; 
 Mon, 05 May 2025 03:09:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVCgB0iesXbV330i7mopdTNiGqzKhNVd/XqHbVgAl5Qzo/e0SFEWEcANn+y+gGUEJXt5Ue8w==
X-Received: by 2002:a05:6000:3105:b0:39f:bfa:7c90 with SMTP id
 ffacd0b85a97d-3a094038a8fmr11853771f8f.13.1746439747977; 
 Mon, 05 May 2025 03:09:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b0fe9dsm9932263f8f.71.2025.05.05.03.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 03:09:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 5/5] rust: qdev: const_refs_to_static
Date: Mon,  5 May 2025 12:08:54 +0200
Message-ID: <20250505100854.73936-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505100854.73936-1-pbonzini@redhat.com>
References: <20250505100854.73936-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Now that const_refs_to_static can be assumed, convert the members of
the DeviceImpl trait from functions to constants.  This lets the
compiler know that they have a 'static lifetime, and removes the
need for the weird "Box::leak()".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs |  8 ++------
 rust/hw/timer/hpet/src/hpet.rs   | 10 ++--------
 rust/qemu-api/src/qdev.rs        | 16 +++++-----------
 rust/qemu-api/tests/tests.rs     |  8 ++------
 4 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 38373f54e7c..34aa2bbabec 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -169,12 +169,8 @@ impl ObjectImpl for PL011State {
 }
 
 impl DeviceImpl for PL011State {
-    fn properties() -> &'static [Property] {
-        &device_class::PL011_PROPERTIES
-    }
-    fn vmsd() -> Option<VMStateDescription<Self>> {
-        Some(device_class::VMSTATE_PL011)
-    }
+    const PROPERTIES: &'static [Property] = &device_class::PL011_PROPERTIES;
+    const VMSTATE: Option<VMStateDescription<Self>> = Some(device_class::VMSTATE_PL011);
     const REALIZE: Option<fn(&Self)> = Some(Self::realize);
 }
 
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index be3b9afa316..48970a6f9c5 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -1009,14 +1009,8 @@ impl ObjectImpl for HPETState {
         .build();
 
 impl DeviceImpl for HPETState {
-    fn properties() -> &'static [Property] {
-        &HPET_PROPERTIES
-    }
-
-    fn vmsd() -> Option<VMStateDescription<Self>> {
-        Some(VMSTATE_HPET)
-    }
-
+    const PROPERTIES: &'static [Property] = &HPET_PROPERTIES;
+    const VMSTATE: Option<VMStateDescription<Self>> = Some(VMSTATE_HPET);
     const REALIZE: Option<fn(&Self)> = Some(Self::realize);
 }
 
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 09555bbd0e7..9b2bfabdad2 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -113,16 +113,12 @@ pub trait DeviceImpl: ObjectImpl + ResettablePhasesImpl + IsA<DeviceState> {
     /// An array providing the properties that the user can set on the
     /// device.  Not a `const` because referencing statics in constants
     /// is unstable until Rust 1.83.0.
-    fn properties() -> &'static [Property] {
-        &[]
-    }
+    const PROPERTIES: &'static [Property] = &[];
 
     /// A `VMStateDescription` providing the migration format for the device
     /// Not a `const` because referencing statics in constants is unstable
     /// until Rust 1.83.0.
-    fn vmsd() -> Option<VMStateDescription<Self>> {
-        None
-    }
+    const VMSTATE: Option<VMStateDescription<Self>> = None;
 }
 
 /// # Safety
@@ -168,12 +164,10 @@ pub fn class_init<T: DeviceImpl>(&mut self) {
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
-        let prop = <T as DeviceImpl>::properties();
+        let prop = <T as DeviceImpl>::PROPERTIES;
         if !prop.is_empty() {
             unsafe {
                 bindings::device_class_set_props_n(self, prop.as_ptr(), prop.len());
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 3264641d128..db0fd3de99b 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -67,12 +67,8 @@ impl ObjectImpl for DummyState {
 impl ResettablePhasesImpl for DummyState {}
 
 impl DeviceImpl for DummyState {
-    fn properties() -> &'static [Property] {
-        &DUMMY_PROPERTIES
-    }
-    fn vmsd() -> Option<VMStateDescription<Self>> {
-        Some(VMSTATE)
-    }
+    const PROPERTIES: &'static [Property] = &DUMMY_PROPERTIES;
+    const VMSTATE: Option<VMStateDescription<Self>> = Some(VMSTATE);
 }
 
 #[repr(C)]
-- 
2.49.0


