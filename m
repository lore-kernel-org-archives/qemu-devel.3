Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192FDD30016
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1oCp-0008RE-PQ; Fri, 18 Oct 2024 10:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCo-0008Pl-Bo
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCm-0002cq-HD
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729262630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=emK1BbhOeZN8ln9uEXMUETGvQfGIAyHdSO+Caj5JSUY=;
 b=VzxXptx0AME2MDa6lD6BGgLKV+JR68MIADGH3g5sMetZyu6nWN4zbp7WI0ewyjQ9cXUQ03
 01KfjTj23v8eXwExtuGP7+kgvv6SDXHjOQdyoxhCfhYazd1uRCpiKBJp+SEw/5JMs3njaH
 sRHcvz3PJhEATVgw5TUErc6o3rALsBM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-Q41-OngaMRuwIi_ugl6-AQ-1; Fri, 18 Oct 2024 10:43:49 -0400
X-MC-Unique: Q41-OngaMRuwIi_ugl6-AQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d4af408dcso1212220f8f.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729262627; x=1729867427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=emK1BbhOeZN8ln9uEXMUETGvQfGIAyHdSO+Caj5JSUY=;
 b=FstKgFs5RglPXs49mJyF1T1rjo8LhVGVWgYhoksHUY/FmXcmqqNanP3OOpTNQLWF7N
 r/PMg+ySku9xu3kcHK69bqRJYQHVN8IWtxruUYT4GgkaWKZ9F0Pm2p48ADs8hN+q0c4D
 VZ4iqGDDytM5g8elJHaDQY4KW0YeTtLYFI/LAgAorrLC887mOj5BdEHMwjpEi6zBAIYR
 nTDD2OdqaoqBXUuIx/8w7pa4Fu7AOeQtzgC16qeIZnYDpSh5nSr/CPzJFfPkoNsg1j/9
 jwvIH88iKzegO8E/Ouh1TpUFTCpPuc4nSRUe6Ez6BpTlbF0swBCzr+G9+43Zws5ZFQcW
 8A8Q==
X-Gm-Message-State: AOJu0Ywp5qzTRq3IwEtWplfU3FvORBBxaJJep4DXGLAVDLwau9VunJH9
 Y8kqnQ4sbleJFJVCV8p5uigPzzb7jA3dcHk8FwvEA/fh9qFvXIXL7JldnKMk6emRchCtUTwMT2G
 iymORaT8uTuoJCb25kQHEsHURxUgVAmQArXk6moc34lJcOw5ft6jetjZNIt+n+R0a7E55qRuE1j
 Xq1mnJxkOVzDd7ZBDluHvhnwpp059feeuXpvbw9x4=
X-Received: by 2002:adf:e38f:0:b0:37c:ce58:5a1a with SMTP id
 ffacd0b85a97d-37eb48942f4mr1981611f8f.54.1729262627233; 
 Fri, 18 Oct 2024 07:43:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHch1i06pVAPnRkPkyas0oKandPSHmPSRHHeGgmz15lUrNXqa+PTJNkp74byPNyhiiSAqbEg==
X-Received: by 2002:adf:e38f:0:b0:37c:ce58:5a1a with SMTP id
 ffacd0b85a97d-37eb48942f4mr1981588f8f.54.1729262626708; 
 Fri, 18 Oct 2024 07:43:46 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ecf0861d2sm2105397f8f.56.2024.10.18.07.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:43:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 12/13] rust: provide safe wrapper for MaybeUninit::zeroed()
Date: Fri, 18 Oct 2024 16:43:04 +0200
Message-ID: <20241018144306.954716-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018144306.954716-1-pbonzini@redhat.com>
References: <20241018144306.954716-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

MaybeUninit::zeroed() is handy, but it introduces unsafe (and has a
pretty heavy syntax in general).  Introduce a trait that provides the
same functionality while staying within safe Rust.

In addition, MaybeUninit::zeroed() is not available as a "const"
function until Rust 1.75.0, so this also prepares for having handwritten
implementations of the trait until we can assume that version.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device_class.rs |  8 ++++++--
 rust/hw/char/pl011/src/memory_ops.rs   | 11 +++++++----
 rust/qemu-api/meson.build              |  1 +
 rust/qemu-api/src/device_class.rs      |  8 ++++----
 rust/qemu-api/src/lib.rs               |  1 +
 rust/qemu-api/src/zeroable.rs          | 23 +++++++++++++++++++++++
 6 files changed, 42 insertions(+), 10 deletions(-)
 create mode 100644 rust/qemu-api/src/zeroable.rs

diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index 2ad80451e87..78fa1cdd5b6 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -4,7 +4,11 @@
 
 use core::ptr::NonNull;
 
-use qemu_api::{bindings::*, definitions::ObjectImpl};
+use qemu_api::{
+    bindings::*,
+    definitions::ObjectImpl,
+    zeroable::Zeroable,
+};
 
 use crate::device::PL011State;
 
@@ -12,7 +16,7 @@
 pub static VMSTATE_PL011: VMStateDescription = VMStateDescription {
     name: PL011State::TYPE_INFO.name,
     unmigratable: true,
-    ..unsafe { ::core::mem::MaybeUninit::<VMStateDescription>::zeroed().assume_init() }
+    ..Zeroable::ZERO
 };
 
 qemu_api::declare_properties! {
diff --git a/rust/hw/char/pl011/src/memory_ops.rs b/rust/hw/char/pl011/src/memory_ops.rs
index 5a5320e66c3..24ac9c870c1 100644
--- a/rust/hw/char/pl011/src/memory_ops.rs
+++ b/rust/hw/char/pl011/src/memory_ops.rs
@@ -2,9 +2,12 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use core::{mem::MaybeUninit, ptr::NonNull};
+use core::ptr::NonNull;
 
-use qemu_api::bindings::*;
+use qemu_api::{
+    bindings::*,
+    zeroable::Zeroable
+};
 
 use crate::device::PL011State;
 
@@ -14,11 +17,11 @@
     read_with_attrs: None,
     write_with_attrs: None,
     endianness: device_endian::DEVICE_NATIVE_ENDIAN,
-    valid: unsafe { MaybeUninit::<MemoryRegionOps__bindgen_ty_1>::zeroed().assume_init() },
+    valid: Zeroable::ZERO,
     impl_: MemoryRegionOps__bindgen_ty_2 {
         min_access_size: 4,
         max_access_size: 4,
-        ..unsafe { MaybeUninit::<MemoryRegionOps__bindgen_ty_2>::zeroed().assume_init() }
+        ..Zeroable::ZERO
     },
 };
 
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index d24e0c0725e..5fa4a08e76b 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -5,6 +5,7 @@ _qemu_api_rs = static_library(
       'src/lib.rs',
       'src/definitions.rs',
       'src/device_class.rs',
+      'src/zeroable.rs',
     ],
     {'.' : bindings_rs},
   ),
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index d885f2fcf19..ed2d7ce1a54 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -31,7 +31,7 @@ macro_rules! define_property {
             offset: ::core::mem::offset_of!($state, $field) as isize,
             set_default: true,
             defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval.into() },
-            ..unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() }
+            ..$crate::zeroable::Zeroable::ZERO
         }
     };
     ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr$(,)*) => {
@@ -41,7 +41,7 @@ macro_rules! define_property {
             info: $prop,
             offset: ::core::mem::offset_of!($state, $field) as isize,
             set_default: false,
-            ..unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() }
+            ..$crate::zeroable::Zeroable::ZERO
         }
     };
 }
@@ -58,7 +58,7 @@ macro_rules! declare_properties {
             len
         }] = [
             $($prop),*,
-            unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() },
+            $crate::zeroable::Zeroable::ZERO,
         ];
     };
 }
@@ -79,7 +79,7 @@ macro_rules! vm_state_description {
                 $vname.as_ptr()
             },)*
             unmigratable: true,
-            ..unsafe { ::core::mem::MaybeUninit::<$crate::bindings::VMStateDescription>::zeroed().assume_init() }
+            ..$crate::zeroable::Zeroable::ZERO
         };
     }
 }
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index e72fb4b4bb1..91b9459235b 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -29,6 +29,7 @@ unsafe impl Sync for bindings::VMStateDescription {}
 
 pub mod definitions;
 pub mod device_class;
+pub mod zeroable;
 
 #[cfg(test)]
 mod tests;
diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
new file mode 100644
index 00000000000..927c634b48f
--- /dev/null
+++ b/rust/qemu-api/src/zeroable.rs
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/// Encapsulates the requirement that
+/// `MaybeUninit::<Self>::zeroed().assume_init()` does not cause
+/// undefined behavior.
+///
+/// SAFETY: do not add this trait to a type unless all-zeroes is
+/// a valid value for the type.  In particular, remember that raw
+/// pointers can be zero, but references and `NonNull<T>` cannot
+/// unless wrapped with `Option<>`.
+pub unsafe trait Zeroable: Default {
+    /// SAFETY: If the trait was added to a type, then by definition
+    /// this is safe.
+    const ZERO: Self = unsafe {
+        ::core::mem::MaybeUninit::<Self>::zeroed().assume_init()
+    };
+}
+
+unsafe impl Zeroable for crate::bindings::Property__bindgen_ty_1 {}
+unsafe impl Zeroable for crate::bindings::Property {}
+unsafe impl Zeroable for crate::bindings::VMStateDescription {}
+unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_1 {}
+unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_2 {}
-- 
2.46.2


