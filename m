Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF64C3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKFE-0003s4-A5; Tue, 06 May 2025 11:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKF3-0003on-2J
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:29:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKF0-0001yI-11
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7J88oCyRyqmwlcOmBvYfmuaIGCYbi8fVE3oSHwEmaGM=;
 b=N/p60YYrr7sVqau3/VE+QL43yoBgKXorjJMamxai7ls/z3rQ+U/gBseotgt7sk8gMaq/5I
 W1CaVyd++rfg0aIq8u7OOMNG8FMepqQz21R6B99bDJ2YmSiTi38kNKgXXHHEqaF/YoofTF
 bHbQxp9aSso6rYfghFZ2nA22mk95X68=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-lG-NOw-fOAOx8fz_oloRqg-1; Tue, 06 May 2025 11:29:52 -0400
X-MC-Unique: lG-NOw-fOAOx8fz_oloRqg-1
X-Mimecast-MFC-AGG-ID: lG-NOw-fOAOx8fz_oloRqg_1746545391
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cfda30a3cso28557675e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545390; x=1747150190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7J88oCyRyqmwlcOmBvYfmuaIGCYbi8fVE3oSHwEmaGM=;
 b=IGJDZucAyfiykxKsSH4kiN218paiyKvAHbws7tqLCBLQ6kPFHWLoBVVLsXE2R4D2we
 qGJCLXMt0zuN+vfqib+VfJmcircDF9XUeUU0M0UzwXUlARSii4l5KXOJDrO5+DsiTgXT
 ErI8KFjloz49oYhCBng8Pxfz2fmNqERahYbqQxayIArAK2yLLuMceCUVVzwsB0dfnHHW
 Z5GKm2cJ71xhVDlNSqCqtoDAjSZ2qGfQoR+2ehCbwsePoEl2ciyv1jEikEab1I3m/j+7
 FmEfD8+KQsZWWz1YAB28oq7vZioseE1VuBp71+Xc/2K18JndmdKhRiHAcv1QYhlABiO4
 vOSg==
X-Gm-Message-State: AOJu0YyFYCm3ZWtZhi1fTzpZZd6tMue1T4Y+OLnBW9/ZP7/uT35E3Ef9
 qjTnYahDNB8upKsdw358tH131BUpM2Lv2qlMDnlRA8n0gjUcqsEa1ekzxP4c6tIQlRIsnczdMLG
 t+bogaNMYFz7aLMqyMwLIEhV6c9CAo8EXsiEB1Lc24S8np4WZb46YX/lUB+AJNdUKCDT8jz+26H
 Yi+irTyf5AvlhWLpVgWqbZCQLNSO1QWJZkPWdm
X-Gm-Gg: ASbGnct/kZC50A2AKgQ+q367IBnoITNBvpdPxxvVli697egJCDsNQ2/wSEyFs53IksL
 6eVY5vZzHRYo0KWtRqkWSfdrMNrY9e0afgwOdAgrprw6ShV1gZg9utNSStDozO+J0lHw2mkzHQr
 yFx1AfZ47H4EGtQLfx4xnozgrG27LdMZlc38vsYBpm0PGzm/Oi0y13ymai38kJfWsIJadehCafv
 rap3Rp3yhW8ugbRvYwdK3ep7BS+x8XLEYuq6UEmLIyROnfVUihCIEvvv3EwGilIHypCI0a1bzGo
 Yw+W7EsLKGF+4Tw=
X-Received: by 2002:a05:600c:1914:b0:43d:47e:3205 with SMTP id
 5b1f17b1804b1-441c48bca55mr82922465e9.11.1746545389503; 
 Tue, 06 May 2025 08:29:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxnEBx1F79QVuQoTgvKgeGjQ2NWi0NRFMzsCIPwSyQlO2Sd/7H8F2qnerC8JH49C14RGGFzA==
X-Received: by 2002:a05:600c:1914:b0:43d:47e:3205 with SMTP id
 5b1f17b1804b1-441c48bca55mr82922145e9.11.1746545388923; 
 Tue, 06 May 2025 08:29:48 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0c5esm13807748f8f.1.2025.05.06.08.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:29:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 10/30] rust: replace c_str! with c"" literals
Date: Tue,  6 May 2025 17:29:05 +0200
Message-ID: <20250506152927.222671-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst                    |  6 +--
 rust/hw/char/pl011/src/device_class.rs | 11 +++--
 rust/hw/char/pl011/src/lib.rs          |  6 +--
 rust/hw/timer/hpet/src/hpet.rs         | 19 ++++----
 rust/hw/timer/hpet/src/lib.rs          |  4 +-
 rust/qemu-api/meson.build              |  1 -
 rust/qemu-api/src/c_str.rs             | 61 --------------------------
 rust/qemu-api/src/cell.rs              |  4 +-
 rust/qemu-api/src/lib.rs               |  1 -
 rust/qemu-api/src/vmstate.rs           |  2 +-
 rust/qemu-api/tests/tests.rs           |  9 ++--
 rust/qemu-api/tests/vmstate_tests.rs   | 15 +++----
 12 files changed, 32 insertions(+), 107 deletions(-)
 delete mode 100644 rust/qemu-api/src/c_str.rs

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 5cfafc532cc..557cee72f39 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -81,9 +81,6 @@ are missing:
 * "Return position ``impl Trait`` in Traits" (1.75.0, blocker for including
   the pinned-init create).
 
-* ``c"" literals`` (stable in 1.77.0).  QEMU provides a ``c_str!()`` macro
-  to define ``CStr`` constants easily
-
 * inline const expression (stable in 1.79.0), currently worked around with
   associated constants in the ``FnCall`` trait.
 
@@ -166,7 +163,6 @@ module           status
 ``bitops``       complete
 ``callbacks``    complete
 ``cell``         stable
-``c_str``        complete
 ``errno``        complete
 ``irq``          complete
 ``memory``       stable
@@ -423,7 +419,7 @@ Adding dependencies
 Generally, the set of dependent crates is kept small.  Think twice before
 adding a new external crate, especially if it comes with a large set of
 dependencies itself.  Sometimes QEMU only needs a small subset of the
-functionality; see for example QEMU's ``assertions`` or ``c_str`` modules.
+functionality; see for example QEMU's ``assertions`` module.
 
 On top of this recommendation, adding external crates to QEMU is a
 slightly complicated process, mostly due to the need to teach Meson how
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index cd2dc33c207..d328d846323 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -9,7 +9,6 @@
 
 use qemu_api::{
     bindings::{qdev_prop_bool, qdev_prop_chr},
-    c_str,
     prelude::*,
     vmstate::VMStateDescription,
     vmstate_clock, vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections, vmstate_unused,
@@ -25,7 +24,7 @@ extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
 
 /// Migration subsection for [`PL011State`] clock.
 static VMSTATE_PL011_CLOCK: VMStateDescription = VMStateDescription {
-    name: c_str!("pl011/clock").as_ptr(),
+    name: c"pl011/clock".as_ptr(),
     version_id: 1,
     minimum_version_id: 1,
     needed: Some(pl011_clock_needed),
@@ -46,7 +45,7 @@ extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
 }
 
 static VMSTATE_PL011_REGS: VMStateDescription = VMStateDescription {
-    name: c_str!("pl011/regs").as_ptr(),
+    name: c"pl011/regs".as_ptr(),
     version_id: 2,
     minimum_version_id: 2,
     fields: vmstate_fields! {
@@ -70,7 +69,7 @@ extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
 };
 
 pub static VMSTATE_PL011: VMStateDescription = VMStateDescription {
-    name: c_str!("pl011").as_ptr(),
+    name: c"pl011".as_ptr(),
     version_id: 2,
     minimum_version_id: 2,
     post_load: Some(pl011_post_load),
@@ -87,14 +86,14 @@ extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
 qemu_api::declare_properties! {
     PL011_PROPERTIES,
     qemu_api::define_property!(
-        c_str!("chardev"),
+        c"chardev",
         PL011State,
         char_backend,
         unsafe { &qdev_prop_chr },
         CharBackend
     ),
     qemu_api::define_property!(
-        c_str!("migrate-clk"),
+        c"migrate-clk",
         PL011State,
         migrate_clock,
         unsafe { &qdev_prop_bool },
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index dbae76991c9..5c4fbc9d148 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -12,13 +12,11 @@
 //! See [`PL011State`](crate::device::PL011State) for the device model type and
 //! the [`registers`] module for register types.
 
-use qemu_api::c_str;
-
 mod device;
 mod device_class;
 mod registers;
 
 pub use device::pl011_create;
 
-pub const TYPE_PL011: &::std::ffi::CStr = c_str!("pl011");
-pub const TYPE_PL011_LUMINARY: &::std::ffi::CStr = c_str!("pl011_luminary");
+pub const TYPE_PL011: &::std::ffi::CStr = c"pl011";
+pub const TYPE_PL011_LUMINARY: &::std::ffi::CStr = c"pl011_luminary";
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index 719343a20c5..779681d6509 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -14,7 +14,6 @@
         address_space_memory, address_space_stl_le, qdev_prop_bit, qdev_prop_bool,
         qdev_prop_uint32, qdev_prop_uint8,
     },
-    c_str,
     cell::{BqlCell, BqlRefCell},
     irq::InterruptSource,
     memory::{
@@ -908,7 +907,7 @@ impl ObjectImpl for HPETState {
 qemu_api::declare_properties! {
     HPET_PROPERTIES,
     qemu_api::define_property!(
-        c_str!("timers"),
+        c"timers",
         HPETState,
         num_timers,
         unsafe { &qdev_prop_uint8 },
@@ -916,7 +915,7 @@ impl ObjectImpl for HPETState {
         default = HPET_MIN_TIMERS
     ),
     qemu_api::define_property!(
-        c_str!("msi"),
+        c"msi",
         HPETState,
         flags,
         unsafe { &qdev_prop_bit },
@@ -925,7 +924,7 @@ impl ObjectImpl for HPETState {
         default = false,
     ),
     qemu_api::define_property!(
-        c_str!("hpet-intcap"),
+        c"hpet-intcap",
         HPETState,
         int_route_cap,
         unsafe { &qdev_prop_uint32 },
@@ -933,7 +932,7 @@ impl ObjectImpl for HPETState {
         default = 0
     ),
     qemu_api::define_property!(
-        c_str!("hpet-offset-saved"),
+        c"hpet-offset-saved",
         HPETState,
         hpet_offset_saved,
         unsafe { &qdev_prop_bool },
@@ -974,7 +973,7 @@ impl ObjectImpl for HPETState {
 }
 
 static VMSTATE_HPET_RTC_IRQ_LEVEL: VMStateDescription = VMStateDescription {
-    name: c_str!("hpet/rtc_irq_level").as_ptr(),
+    name: c"hpet/rtc_irq_level".as_ptr(),
     version_id: 1,
     minimum_version_id: 1,
     needed: Some(hpet_rtc_irq_level_needed),
@@ -985,7 +984,7 @@ impl ObjectImpl for HPETState {
 };
 
 static VMSTATE_HPET_OFFSET: VMStateDescription = VMStateDescription {
-    name: c_str!("hpet/offset").as_ptr(),
+    name: c"hpet/offset".as_ptr(),
     version_id: 1,
     minimum_version_id: 1,
     needed: Some(hpet_offset_needed),
@@ -996,7 +995,7 @@ impl ObjectImpl for HPETState {
 };
 
 static VMSTATE_HPET_TIMER: VMStateDescription = VMStateDescription {
-    name: c_str!("hpet_timer").as_ptr(),
+    name: c"hpet_timer".as_ptr(),
     version_id: 1,
     minimum_version_id: 1,
     fields: vmstate_fields! {
@@ -1011,10 +1010,10 @@ impl ObjectImpl for HPETState {
     ..Zeroable::ZERO
 };
 
-const VALIDATE_TIMERS_NAME: &CStr = c_str!("num_timers must match");
+const VALIDATE_TIMERS_NAME: &CStr = c"num_timers must match";
 
 static VMSTATE_HPET: VMStateDescription = VMStateDescription {
-    name: c_str!("hpet").as_ptr(),
+    name: c"hpet".as_ptr(),
     version_id: 2,
     minimum_version_id: 1,
     pre_save: Some(hpet_pre_save),
diff --git a/rust/hw/timer/hpet/src/lib.rs b/rust/hw/timer/hpet/src/lib.rs
index 5e7c961c289..1954584a87e 100644
--- a/rust/hw/timer/hpet/src/lib.rs
+++ b/rust/hw/timer/hpet/src/lib.rs
@@ -7,9 +7,7 @@
 //! This library implements a device model for the IA-PC HPET (High
 //! Precision Event Timers) device in QEMU.
 
-use qemu_api::c_str;
-
 pub mod fw_cfg;
 pub mod hpet;
 
-pub const TYPE_HPET: &::std::ffi::CStr = c_str!("hpet");
+pub const TYPE_HPET: &::std::ffi::CStr = c"hpet";
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 95e65643ae1..1696df705bf 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -20,7 +20,6 @@ _qemu_api_rs = static_library(
       'src/callbacks.rs',
       'src/cell.rs',
       'src/chardev.rs',
-      'src/c_str.rs',
       'src/errno.rs',
       'src/irq.rs',
       'src/memory.rs',
diff --git a/rust/qemu-api/src/c_str.rs b/rust/qemu-api/src/c_str.rs
deleted file mode 100644
index 3fa61b59c76..00000000000
--- a/rust/qemu-api/src/c_str.rs
+++ /dev/null
@@ -1,61 +0,0 @@
-// Copyright 2024 Red Hat, Inc.
-// Author(s): Paolo Bonzini <pbonzini@redhat.com>
-// SPDX-License-Identifier: GPL-2.0-or-later
-
-#![doc(hidden)]
-//! This module provides a macro to define a constant of type
-//! [`CStr`](std::ffi::CStr), for compatibility with versions of
-//! Rust that lack `c""` literals.
-//!
-//! Documentation is hidden because it only exposes macros, which
-//! are exported directly from `qemu_api`.
-
-#[macro_export]
-/// Given a string constant _without_ embedded or trailing NULs, return
-/// a `CStr`.
-///
-/// Needed for compatibility with Rust <1.77.
-macro_rules! c_str {
-    ($str:expr) => {{
-        const STRING: &str = concat!($str, "\0");
-        const BYTES: &[u8] = STRING.as_bytes();
-
-        // "for" is not allowed in const context... oh well,
-        // everybody loves some lisp.  This could be turned into
-        // a procedural macro if this is a problem; alternatively
-        // Rust 1.72 makes CStr::from_bytes_with_nul a const function.
-        const fn f(b: &[u8], i: usize) {
-            if i == b.len() - 1 {
-            } else if b[i] == 0 {
-                panic!("c_str argument contains NUL")
-            } else {
-                f(b, i + 1)
-            }
-        }
-        f(BYTES, 0);
-
-        // SAFETY: absence of NULs apart from the final byte was checked above
-        unsafe { std::ffi::CStr::from_bytes_with_nul_unchecked(BYTES) }
-    }};
-}
-
-#[cfg(test)]
-mod tests {
-    use std::ffi::CStr;
-
-    use crate::c_str;
-
-    #[test]
-    fn test_cstr_macro() {
-        let good = c_str!("🦀");
-        let good_bytes = b"\xf0\x9f\xa6\x80\0";
-        assert_eq!(good.to_bytes_with_nul(), good_bytes);
-    }
-
-    #[test]
-    fn test_cstr_macro_const() {
-        const GOOD: &CStr = c_str!("🦀");
-        const GOOD_BYTES: &[u8] = b"\xf0\x9f\xa6\x80\0";
-        assert_eq!(GOOD.to_bytes_with_nul(), GOOD_BYTES);
-    }
-}
diff --git a/rust/qemu-api/src/cell.rs b/rust/qemu-api/src/cell.rs
index 1cb9fdcd53f..05ce09f6cb6 100644
--- a/rust/qemu-api/src/cell.rs
+++ b/rust/qemu-api/src/cell.rs
@@ -77,13 +77,13 @@
 //!
 //! ```
 //! # use qemu_api::prelude::*;
-//! # use qemu_api::{c_str, cell::BqlRefCell, irq::InterruptSource, irq::IRQState};
+//! # use qemu_api::{cell::BqlRefCell, irq::InterruptSource, irq::IRQState};
 //! # use qemu_api::{sysbus::SysBusDevice, qom::Owned, qom::ParentField};
 //! # const N_GPIOS: usize = 8;
 //! # struct PL061Registers { /* ... */ }
 //! # unsafe impl ObjectType for PL061State {
 //! #     type Class = <SysBusDevice as ObjectType>::Class;
-//! #     const TYPE_NAME: &'static std::ffi::CStr = c_str!("pl061");
+//! #     const TYPE_NAME: &'static std::ffi::CStr = c"pl061";
 //! # }
 //! struct PL061State {
 //!     parent_obj: ParentField<SysBusDevice>,
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 90c19636660..234a94e3c29 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -15,7 +15,6 @@
 
 pub mod assertions;
 pub mod bitops;
-pub mod c_str;
 pub mod callbacks;
 pub mod cell;
 pub mod chardev;
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 205f35a21fd..9c8b2398e9d 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -427,7 +427,7 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
 macro_rules! vmstate_unused {
     ($size:expr) => {{
         $crate::bindings::VMStateField {
-            name: $crate::c_str!("unused").as_ptr(),
+            name: c"unused".as_ptr(),
             size: $size,
             info: unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_info_unused_buffer) },
             flags: $crate::bindings::VMStateFlags::VMS_BUFFER,
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index d045808c3a8..a658a49fcfd 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -6,7 +6,6 @@
 
 use qemu_api::{
     bindings::{module_call_init, module_init_type, qdev_prop_bool},
-    c_str,
     cell::{self, BqlCell},
     declare_properties, define_property,
     prelude::*,
@@ -21,7 +20,7 @@
 
 // Test that macros can compile.
 pub static VMSTATE: VMStateDescription = VMStateDescription {
-    name: c_str!("name").as_ptr(),
+    name: c"name".as_ptr(),
     unmigratable: true,
     ..Zeroable::ZERO
 };
@@ -48,7 +47,7 @@ pub fn class_init<T: DeviceImpl>(self: &mut DummyClass) {
 declare_properties! {
     DUMMY_PROPERTIES,
         define_property!(
-            c_str!("migrate-clk"),
+            c"migrate-clk",
             DummyState,
             migrate_clock,
             unsafe { &qdev_prop_bool },
@@ -58,7 +57,7 @@ pub fn class_init<T: DeviceImpl>(self: &mut DummyClass) {
 
 unsafe impl ObjectType for DummyState {
     type Class = DummyClass;
-    const TYPE_NAME: &'static CStr = c_str!("dummy");
+    const TYPE_NAME: &'static CStr = c"dummy";
 }
 
 impl ObjectImpl for DummyState {
@@ -92,7 +91,7 @@ pub struct DummyChildClass {
 
 unsafe impl ObjectType for DummyChildState {
     type Class = DummyChildClass;
-    const TYPE_NAME: &'static CStr = c_str!("dummy_child");
+    const TYPE_NAME: &'static CStr = c"dummy_child";
 }
 
 impl ObjectImpl for DummyChildState {
diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index cc3527a9b6a..ad0fc5cd5dd 100644
--- a/rust/qemu-api/tests/vmstate_tests.rs
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -14,7 +14,6 @@
         vmstate_info_bool, vmstate_info_int32, vmstate_info_int64, vmstate_info_int8,
         vmstate_info_uint64, vmstate_info_uint8, vmstate_info_unused_buffer, VMStateFlags,
     },
-    c_str,
     cell::{BqlCell, Opaque},
     impl_vmstate_forward,
     vmstate::{VMStateDescription, VMStateField},
@@ -43,7 +42,7 @@ struct FooA {
 }
 
 static VMSTATE_FOOA: VMStateDescription = VMStateDescription {
-    name: c_str!("foo_a").as_ptr(),
+    name: c"foo_a".as_ptr(),
     version_id: 1,
     minimum_version_id: 1,
     fields: vmstate_fields! {
@@ -173,7 +172,7 @@ fn validate_foob(_state: &FooB, _version_id: u8) -> bool {
 }
 
 static VMSTATE_FOOB: VMStateDescription = VMStateDescription {
-    name: c_str!("foo_b").as_ptr(),
+    name: c"foo_b".as_ptr(),
     version_id: 2,
     minimum_version_id: 1,
     fields: vmstate_fields! {
@@ -337,7 +336,7 @@ struct FooC {
 }
 
 static VMSTATE_FOOC: VMStateDescription = VMStateDescription {
-    name: c_str!("foo_c").as_ptr(),
+    name: c"foo_c".as_ptr(),
     version_id: 3,
     minimum_version_id: 1,
     fields: vmstate_fields! {
@@ -452,13 +451,13 @@ fn validate_food_2(_state: &FooD, _version_id: u8) -> bool {
 }
 
 static VMSTATE_FOOD: VMStateDescription = VMStateDescription {
-    name: c_str!("foo_d").as_ptr(),
+    name: c"foo_d".as_ptr(),
     version_id: 3,
     minimum_version_id: 1,
     fields: vmstate_fields! {
-        vmstate_validate!(FooD, c_str!("foo_d_0"), FooD::validate_food_0),
-        vmstate_validate!(FooD, c_str!("foo_d_1"), FooD::validate_food_1),
-        vmstate_validate!(FooD, c_str!("foo_d_2"), validate_food_2),
+        vmstate_validate!(FooD, c"foo_d_0", FooD::validate_food_0),
+        vmstate_validate!(FooD, c"foo_d_1", FooD::validate_food_1),
+        vmstate_validate!(FooD, c"foo_d_2", validate_food_2),
     },
     ..Zeroable::ZERO
 };
-- 
2.49.0


