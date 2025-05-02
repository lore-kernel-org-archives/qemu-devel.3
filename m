Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A624DC3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 10:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAnYY-0001ES-UB; Fri, 02 May 2025 06:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAnYX-0001Df-85
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:23:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAnYV-0000iA-5x
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746181422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yl8DNVWxw/HVdX6rB7XjjEdD8rzZehVWReue67TF40Y=;
 b=PdcwreAUO1v3CZeut9k+iVvh0rnPVwM/0sksoQZlJLrwZ2xOlfg4SDh/UWlQ5FmVTIwFUh
 ZgeMM/Lb/4N0HYD8JcmQQBYIT1psG9d071tnSYAPdnpcc3wmzDc6EtAR0rGG1b3Ks2FCOk
 uzn64F1VvhcDci3CxLvUrASWrpYOx0s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-wF6_hJruNXqPBWTsZFZ0Yw-1; Fri, 02 May 2025 06:23:40 -0400
X-MC-Unique: wF6_hJruNXqPBWTsZFZ0Yw-1
X-Mimecast-MFC-AGG-ID: wF6_hJruNXqPBWTsZFZ0Yw_1746181419
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d0a037f97so9007315e9.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 03:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746181419; x=1746786219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yl8DNVWxw/HVdX6rB7XjjEdD8rzZehVWReue67TF40Y=;
 b=EGK5yMxhmIvMerihdh690b9uD7+p46XknZ7Qoi0jS2XjorjZjcwVo7Bo6U6FAL4Xt8
 j0TaKA0SnTqTuNFbRYTjDm7XwQPNJOG+4bOoMrP7GdhdCbQ6zhOM+xz2gUY4mhnO4xAW
 byarzpxmEBr51b0SwC42V6q6+a6y2gEmoqtpFd6IAuGSzeB5a1fpbcNum71bgWfHOjO/
 11e84eP7EOjW/MyXxJaAq+BXpefHWxNGF8GBJyptUkO5uegdcfp1LY7cEgoOuwm6LM/d
 qKo8PgHigvSel0b2ScZMiYJJxk9fbrP1jqPz4Yz5vXaIEKmH9dA0lNpv38laG89Jpggg
 zImA==
X-Gm-Message-State: AOJu0Ywpocm+crQe7WBQhrNFgve23zdLUZJhsMM4UeXfImhKHwV0L6cZ
 0vSsc7mU55lzS5eaAEH9GmCMp6BV35XjWxWMv1fYaR2bWwx66f/1UXi94EU0uow/9190nj/BLgv
 pZq5uKkcxjAnNbXWYhDNOB90YL3nw6r/ukEpdJyuRoeKKs/C/qSoRs0908zGxsslOkM4J2fZ1bB
 cXlKL+3/Y0gZm0pF8+jralORAcUiJG/YmoFVWC
X-Gm-Gg: ASbGnctmQt+f3FAneFZTnmTl/VqyW2pqQe7TqrM7U3N05A5KzAGnePT+FMRvCDWwTDm
 rjfVXPguG8gdmqvp2Ti4BcaVMI1irT9u5mwMOcBIitl8LCXcuPn7IMve15I9aq/i0gIbc0Z2OSL
 85pfmEDb+T06yfCTnbAcsRl51neuoNhdvO7H+CGaHAfCKypoofF1eh8juMEli2FcnGa7w7MPESA
 wi76ACf/DyrbJg3lu+jj/L7ovoGYDi/NLuoZuyNL1f/NlM+hV7z37RTtyu4PGtggiOhF+mbtO6p
 MXXKTaKMKIaOk/0=
X-Received: by 2002:a05:600c:1e12:b0:43d:53c:1ad6 with SMTP id
 5b1f17b1804b1-441bbf2bd66mr16522235e9.26.1746181418720; 
 Fri, 02 May 2025 03:23:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO4trlkva0kfy15cK8IlxEl//hJufaDzfW7jYNmpK6cfxH8tX1ZLsUgTAsFrm0sVbOT9PXVA==
X-Received: by 2002:a05:600c:1e12:b0:43d:53c:1ad6 with SMTP id
 5b1f17b1804b1-441bbf2bd66mr16522055e9.26.1746181418320; 
 Fri, 02 May 2025 03:23:38 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89cc50esm40868565e9.8.2025.05.02.03.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 03:23:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 5/9] rust: use MaybeUninit::zeroed() in const context
Date: Fri,  2 May 2025 12:23:18 +0200
Message-ID: <20250502102323.104815-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502102323.104815-1-pbonzini@redhat.com>
References: <20250502102323.104815-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst              |   4 --
 rust/hw/timer/hpet/src/fw_cfg.rs |   6 +-
 rust/qemu-api/src/zeroable.rs    | 104 +++++--------------------------
 3 files changed, 18 insertions(+), 96 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 8167ff49aa9..13a002cfe69 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -83,10 +83,6 @@ are missing:
 * "Return position ``impl Trait`` in Traits" (1.75.0, blocker for including
   the pinned-init create).
 
-* ``MaybeUninit::zeroed()`` as a ``const`` function (1.75.0).  QEMU's
-  ``Zeroable`` trait can be implemented without ``MaybeUninit::zeroed()``,
-  so this would be just a cleanup.
-
 * ``c"" literals`` (stable in 1.77.0).  QEMU provides a ``c_str!()`` macro
   to define ``CStr`` constants easily
 
diff --git a/rust/hw/timer/hpet/src/fw_cfg.rs b/rust/hw/timer/hpet/src/fw_cfg.rs
index bef03727ea3..aa08d283519 100644
--- a/rust/hw/timer/hpet/src/fw_cfg.rs
+++ b/rust/hw/timer/hpet/src/fw_cfg.rs
@@ -4,7 +4,7 @@
 
 use std::ptr::addr_of_mut;
 
-use qemu_api::{cell::bql_locked, impl_zeroable, zeroable::Zeroable};
+use qemu_api::{cell::bql_locked, zeroable::Zeroable};
 
 /// Each `HPETState` represents a Event Timer Block. The v1 spec supports
 /// up to 8 blocks. QEMU only uses 1 block (in PC machine).
@@ -18,7 +18,7 @@ pub struct HPETFwEntry {
     pub min_tick: u16,
     pub page_prot: u8,
 }
-impl_zeroable!(HPETFwEntry);
+unsafe impl Zeroable for HPETFwEntry {}
 
 #[repr(C, packed)]
 #[derive(Copy, Clone, Default)]
@@ -26,7 +26,7 @@ pub struct HPETFwConfig {
     pub count: u8,
     pub hpet: [HPETFwEntry; HPET_MAX_NUM_EVENT_TIMER_BLOCK],
 }
-impl_zeroable!(HPETFwConfig);
+unsafe impl Zeroable for HPETFwConfig {}
 
 #[allow(non_upper_case_globals)]
 #[no_mangle]
diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
index a3415a2ebcc..57d802db69b 100644
--- a/rust/qemu-api/src/zeroable.rs
+++ b/rust/qemu-api/src/zeroable.rs
@@ -4,89 +4,15 @@
 
 /// Encapsulates the requirement that
 /// `MaybeUninit::<Self>::zeroed().assume_init()` does not cause undefined
-/// behavior.  This trait in principle could be implemented as just:
-///
-/// ```
-/// pub unsafe trait Zeroable: Default {
-///     const ZERO: Self = unsafe { ::core::mem::MaybeUninit::<Self>::zeroed().assume_init() };
-/// }
-/// ```
-///
-/// The need for a manual implementation is only because `zeroed()` cannot
-/// be used as a `const fn` prior to Rust 1.75.0. Once we can assume a new
-/// enough version of the compiler, we could provide a `#[derive(Zeroable)]`
-/// macro to check at compile-time that all struct fields are Zeroable, and
-/// use the above blanket implementation of the `ZERO` constant.
+/// behavior.
 ///
 /// # Safety
 ///
-/// Because the implementation of `ZERO` is manual, it does not make
-/// any assumption on the safety of `zeroed()`.  However, other users of the
-/// trait could use it that way.  Do not add this trait to a type unless
-/// all-zeroes is a valid value for the type.  In particular, remember that
-/// raw pointers can be zero, but references and `NonNull<T>` cannot
+/// Do not add this trait to a type unless all-zeroes is a valid value for the
+/// type.  In particular, raw pointers can be zero, but references and `NonNull<T>`
+/// cannot.
 pub unsafe trait Zeroable: Default {
-    const ZERO: Self;
-}
-
-/// A macro that acts similarly to [`core::mem::zeroed()`], only is const
-///
-/// ## Safety
-///
-/// Similar to `core::mem::zeroed()`, except this zeroes padding bits. Zeroed
-/// padding usually isn't relevant to safety, but might be if a C union is used.
-///
-/// Just like for `core::mem::zeroed()`, an all zero byte pattern might not
-/// be a valid value for a type, as is the case for references `&T` and `&mut
-/// T`. Reference types trigger a (denied by default) lint and cause immediate
-/// undefined behavior if the lint is ignored
-///
-/// ```rust compile_fail
-/// use const_zero::const_zero;
-/// // error: any use of this value will cause an error
-/// // note: `#[deny(const_err)]` on by default
-/// const STR: &str = unsafe{const_zero!(&'static str)};
-/// ```
-///
-/// `const_zero` does not work on unsized types:
-///
-/// ```rust compile_fail
-/// use const_zero::const_zero;
-/// // error[E0277]: the size for values of type `[u8]` cannot be known at compilation time
-/// const BYTES: [u8] = unsafe{const_zero!([u8])};
-/// ```
-/// ## Differences with `core::mem::zeroed`
-///
-/// `const_zero` zeroes padding bits, while `core::mem::zeroed` doesn't
-#[macro_export]
-macro_rules! const_zero {
-    // This macro to produce a type-generic zero constant is taken from the
-    // const_zero crate (v0.1.1):
-    //
-    //     https://docs.rs/const-zero/latest/src/const_zero/lib.rs.html
-    //
-    // and used under MIT license
-    ($type_:ty) => {{
-        const TYPE_SIZE: ::core::primitive::usize = ::core::mem::size_of::<$type_>();
-        union TypeAsBytes {
-            bytes: [::core::primitive::u8; TYPE_SIZE],
-            inner: ::core::mem::ManuallyDrop<$type_>,
-        }
-        const ZERO_BYTES: TypeAsBytes = TypeAsBytes {
-            bytes: [0; TYPE_SIZE],
-        };
-        ::core::mem::ManuallyDrop::<$type_>::into_inner(ZERO_BYTES.inner)
-    }};
-}
-
-/// A wrapper to implement the `Zeroable` trait through the `const_zero` macro.
-#[macro_export]
-macro_rules! impl_zeroable {
-    ($type:ty) => {
-        unsafe impl $crate::zeroable::Zeroable for $type {
-            const ZERO: Self = unsafe { $crate::const_zero!($type) };
-        }
-    };
+    const ZERO: Self = unsafe { ::core::mem::MaybeUninit::<Self>::zeroed().assume_init() };
 }
 
 // bindgen does not derive Default here
@@ -97,13 +23,13 @@ fn default() -> Self {
     }
 }
 
-impl_zeroable!(crate::bindings::Property__bindgen_ty_1);
-impl_zeroable!(crate::bindings::Property);
-impl_zeroable!(crate::bindings::VMStateFlags);
-impl_zeroable!(crate::bindings::VMStateField);
-impl_zeroable!(crate::bindings::VMStateDescription);
-impl_zeroable!(crate::bindings::MemoryRegionOps__bindgen_ty_1);
-impl_zeroable!(crate::bindings::MemoryRegionOps__bindgen_ty_2);
-impl_zeroable!(crate::bindings::MemoryRegionOps);
-impl_zeroable!(crate::bindings::MemTxAttrs);
-impl_zeroable!(crate::bindings::CharBackend);
+unsafe impl Zeroable for crate::bindings::Property__bindgen_ty_1 {}
+unsafe impl Zeroable for crate::bindings::Property {}
+unsafe impl Zeroable for crate::bindings::VMStateFlags {}
+unsafe impl Zeroable for crate::bindings::VMStateField {}
+unsafe impl Zeroable for crate::bindings::VMStateDescription {}
+unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_1 {}
+unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_2 {}
+unsafe impl Zeroable for crate::bindings::MemoryRegionOps {}
+unsafe impl Zeroable for crate::bindings::MemTxAttrs {}
+unsafe impl Zeroable for crate::bindings::CharBackend {}
-- 
2.49.0


