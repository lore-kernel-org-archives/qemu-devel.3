Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA62D33990
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5QmU-0002Gi-KY; Mon, 28 Oct 2024 10:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5QlM-0000XZ-5k
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5QlK-000408-D6
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730125829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XJKy0xe3JNrrE6/anLJ268ol41o+r1HxLKUij6otdYI=;
 b=GnZyjAS9ipX8smRZGhJrQV9TlEtp8T6EVJYXN3wQQlwDat0MOG8pVMz/75op8r5JXxktKu
 45q8MSnM1bU5yyeqSxQtZR/seQVa3a2Er4oLuWT1I8XJ5/WuQfu/s6CR8WtC2jc8tpcKPY
 EU/Kw8FKWenR2FZwnLeDdTuV5MYgw+w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-XcZ5ynCcMqyrQ7nEkHeC0Q-1; Mon, 28 Oct 2024 10:30:27 -0400
X-MC-Unique: XcZ5ynCcMqyrQ7nEkHeC0Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315b7b0c16so34092985e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730125825; x=1730730625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XJKy0xe3JNrrE6/anLJ268ol41o+r1HxLKUij6otdYI=;
 b=jPCh/oYMnV898h35TTJXhIhWhJVzTqKW9V6vy+Dy2OuLpwPqeBHXr45jmNaGqMZtHY
 mzyiEG2D+LdlOSyVHdP2brw7Ja9uvEegTocp433CG+1Mp7/OmYLtTobnImTS5vLDCCJ6
 e53ttABNi+h84vgpIj0B3mb2VGkDSo8F+Kv1kIgzdCjh7CHuiQR78C63F9KfFT0uXZHO
 18R1mXSII+6OPsiUOHkoAmorcx8yjmIRhuLf5oxBCIoLtu9X/1Mhs64lqLcrOxSpK9tS
 kDAdqHx2wbg5dC3Nckm2S4OID4kPOArI5T7rFUzqjlwW5ERjdm9Pyw1i0/MMq49z+oR2
 d1HA==
X-Gm-Message-State: AOJu0Yz6j2Td8Apo7v+3EOxSmxUc3NADNVJOnnDUGOSsfyraRaCPBMoz
 9oQ5aXb17TRg1M6m4HK1oVujaRF5GmlX4uryPcIXvF1f70OfhsyWe98+2EJoCc0qUmsUxklu+Gt
 g8xeXu7ZgKip23GCen8i9vWuc7WhWisC0KZJBy+DGAF+16be9CZZKm1E0+Id/EIfOcQpBO0Qz0+
 JYxN8NLGQZajR0W3r52uGOcnl3AKenMrRqBd8H2ss=
X-Received: by 2002:a5d:6083:0:b0:37d:2db5:b50c with SMTP id
 ffacd0b85a97d-380610f2d67mr5781986f8f.8.1730125825118; 
 Mon, 28 Oct 2024 07:30:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUMQHjAQ4M8oWrH9dhGlFvLnjrMZXkc/P+keMaFqWJ43H01mGt8Tjr6W3INtGTE0QHscvEeA==
X-Received: by 2002:a5d:6083:0:b0:37d:2db5:b50c with SMTP id
 ffacd0b85a97d-380610f2d67mr5781962f8f.8.1730125824647; 
 Mon, 28 Oct 2024 07:30:24 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058bb4461sm9562929f8f.113.2024.10.28.07.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 07:30:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Junjie Mao <junjie.mao@hotmail.com>,
	Kevin Wolf <kwolf@redhat.com>
Subject: [PULL 20/24] rust: provide safe wrapper for MaybeUninit::zeroed()
Date: Mon, 28 Oct 2024 15:29:27 +0100
Message-ID: <20241028142932.363687-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028142932.363687-1-pbonzini@redhat.com>
References: <20241028142932.363687-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device_class.rs |  4 ++--
 rust/hw/char/pl011/src/memory_ops.rs   |  8 ++++----
 rust/qemu-api/meson.build              |  1 +
 rust/qemu-api/src/device_class.rs      |  8 ++++----
 rust/qemu-api/src/lib.rs               |  1 +
 rust/qemu-api/src/zeroable.rs          | 23 +++++++++++++++++++++++
 6 files changed, 35 insertions(+), 10 deletions(-)
 create mode 100644 rust/qemu-api/src/zeroable.rs

diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index 2ad80451e87..08c846aa482 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -4,7 +4,7 @@
 
 use core::ptr::NonNull;
 
-use qemu_api::{bindings::*, definitions::ObjectImpl};
+use qemu_api::{bindings::*, definitions::ObjectImpl, zeroable::Zeroable};
 
 use crate::device::PL011State;
 
@@ -12,7 +12,7 @@
 pub static VMSTATE_PL011: VMStateDescription = VMStateDescription {
     name: PL011State::TYPE_INFO.name,
     unmigratable: true,
-    ..unsafe { ::core::mem::MaybeUninit::<VMStateDescription>::zeroed().assume_init() }
+    ..Zeroable::ZERO
 };
 
 qemu_api::declare_properties! {
diff --git a/rust/hw/char/pl011/src/memory_ops.rs b/rust/hw/char/pl011/src/memory_ops.rs
index 5a5320e66c3..fc69922fbf3 100644
--- a/rust/hw/char/pl011/src/memory_ops.rs
+++ b/rust/hw/char/pl011/src/memory_ops.rs
@@ -2,9 +2,9 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use core::{mem::MaybeUninit, ptr::NonNull};
+use core::ptr::NonNull;
 
-use qemu_api::bindings::*;
+use qemu_api::{bindings::*, zeroable::Zeroable};
 
 use crate::device::PL011State;
 
@@ -14,11 +14,11 @@
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
index 1fc36078027..1b0fd406378 100644
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
index 4b14cb3ffd6..aa6088d9d3d 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -31,7 +31,7 @@ macro_rules! define_property {
             offset: ::core::mem::offset_of!($state, $field) as isize,
             set_default: true,
             defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval as u64 },
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
index 6bc68076aae..e94a15bb823 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -29,6 +29,7 @@ unsafe impl Sync for bindings::VMStateDescription {}
 
 pub mod definitions;
 pub mod device_class;
+pub mod zeroable;
 
 use std::alloc::{GlobalAlloc, Layout};
 
diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
new file mode 100644
index 00000000000..45ec95c9f70
--- /dev/null
+++ b/rust/qemu-api/src/zeroable.rs
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/// Encapsulates the requirement that
+/// `MaybeUninit::<Self>::zeroed().assume_init()` does not cause
+/// undefined behavior.
+///
+/// # Safety
+///
+/// Do not add this trait to a type unless all-zeroes is
+/// a valid value for the type.  In particular, remember that raw
+/// pointers can be zero, but references and `NonNull<T>` cannot
+/// unless wrapped with `Option<>`.
+pub unsafe trait Zeroable: Default {
+    /// SAFETY: If the trait was added to a type, then by definition
+    /// this is safe.
+    const ZERO: Self = unsafe { ::core::mem::MaybeUninit::<Self>::zeroed().assume_init() };
+}
+
+unsafe impl Zeroable for crate::bindings::Property__bindgen_ty_1 {}
+unsafe impl Zeroable for crate::bindings::Property {}
+unsafe impl Zeroable for crate::bindings::VMStateDescription {}
+unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_1 {}
+unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_2 {}
-- 
2.47.0


