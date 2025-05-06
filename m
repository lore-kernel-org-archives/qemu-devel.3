Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F1EC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKEy-0003kx-MF; Tue, 06 May 2025 11:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKEw-0003k8-GB
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKEs-0001xJ-5w
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IFPDsTbrLdiIRzvVoUS5dgOJNed7LD9BnNHYJEOGkc0=;
 b=cNC9qSJrK4dEJTEHscJqkELCj160Wqbr+ijk9q4dS5G7VD+yoDKQ3SC/Lh4PY3kZXsyJDV
 xu3wXL5IjsyR8xTShl4IUImD1Xiejv0pFMnUADXBI1+6NfStiUKniaFzTInpiJX/D8MA6B
 S+RBTgwSdJsuAelAFu/m+t8eBzeBI0w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-g-oPmYl0NdmcUvRGEhzrOg-1; Tue, 06 May 2025 11:29:44 -0400
X-MC-Unique: g-oPmYl0NdmcUvRGEhzrOg-1
X-Mimecast-MFC-AGG-ID: g-oPmYl0NdmcUvRGEhzrOg_1746545383
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3912b54611dso2827985f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545382; x=1747150182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IFPDsTbrLdiIRzvVoUS5dgOJNed7LD9BnNHYJEOGkc0=;
 b=pI0RFiuvfRqGZ9jf4k9mfldKGLT+68OcCXmGIRr86YTBleuIErP5x/piumI+IBWioH
 biJPkQbiUT6fI3JMPIxnbZQ7Y0AF8vOK5R/fI8TnAui0BkSZHfTG9gbdRvtrU4CUqZOE
 7Q5jl09/tzECfLmy2jVxM7lVDI5bkFUMQ5pr0Fi6SRkq8bu0KLO12LVUqwSYhImg8x7q
 emhjtqK1z8gesgapHx7p575ZHaehqlGbT++wNvj7xCTwTP8lA8B3keva4sAu9jYn4Dzc
 jF4xJnHPkCcb/hvCNg9afvulxuhiiTnK8oS0SLw0dV2flr+fvXzdzSTXrhwEFgEhuSFA
 3Clg==
X-Gm-Message-State: AOJu0YxenqwPAlczgs5+7tMke0IDqTYiHzVxTOeJdIXfxJF2drl8+DOi
 fT++jRrneVJzcXH60qXMD6Ol6YwjV9wzSWXyRYaHmxVarQF+MYDpT86PJ8c2j2Jfif0a146U7NE
 0imSI2cS8HEcrLhJFaf+ukWuEwftgfMNCWkUN24vsZTe7YM9NTluWL0g3nCkDG/s/Zeo7TWZGh2
 OVsCNAWlnnrDGEbcPVIFEVE5AC2idnBrKY2dP9
X-Gm-Gg: ASbGncv9aLRjdUSyx0feBWTTwVhoX+rhg5NLW+r1udlzdFJ7f37XLOp1oexTI6nloWn
 dfuaE7Yo0mPpE8WJBALW0i11v9FMkVIJ3ZDnlpCWwKz+yYQF7k1i0iuTwxFSJMaARL3j2Puj5Xo
 eBMEn8y7pXPqdW+t2fnSz2ZOElnG7y2vgOvy8+1WSgmFSRGIQyQ1uyufaZQLhQMuSy1nq71MmII
 X9k5BbBj7Qr77S4vXUAatnd6Zi2f6pfjrNssNgh0jRrRrCJs/y1+vY3Xd+iXRHSD4Av0lPC/MXa
 eXmo+Gh81JIZ8do=
X-Received: by 2002:a05:6000:2289:b0:38b:d7d2:12f6 with SMTP id
 ffacd0b85a97d-3a09fd7a1acmr8371205f8f.2.1746545381724; 
 Tue, 06 May 2025 08:29:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjqvytadpK5OojR0XVaSBwGeiUa9K8nLozV1/5qEroIq5HB2uHaL1hgDR0e5sMKHqJpJ+j0A==
X-Received: by 2002:a05:6000:2289:b0:38b:d7d2:12f6 with SMTP id
 ffacd0b85a97d-3a09fd7a1acmr8371181f8f.2.1746545381224; 
 Tue, 06 May 2025 08:29:41 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae7b45sm13806377f8f.46.2025.05.06.08.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:29:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 06/30] rust: use MaybeUninit::zeroed() in const context
Date: Tue,  6 May 2025 17:29:01 +0200
Message-ID: <20250506152927.222671-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
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
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst              |   4 --
 rust/hw/timer/hpet/src/fw_cfg.rs |   6 +-
 rust/qemu-api/src/zeroable.rs    | 106 +++++--------------------------
 3 files changed, 20 insertions(+), 96 deletions(-)

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
index a3415a2ebcc..d8239d08563 100644
--- a/rust/qemu-api/src/zeroable.rs
+++ b/rust/qemu-api/src/zeroable.rs
@@ -4,89 +4,17 @@
 
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
+/// type.  In particular, raw pointers can be zero, but references and
+/// `NonNull<T>` cannot.
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
+    /// Return a value of Self whose memory representation consists of all
+    /// zeroes, with the possible exclusion of padding bytes.
+    const ZERO: Self = unsafe { ::core::mem::MaybeUninit::<Self>::zeroed().assume_init() };
 }
 
 // bindgen does not derive Default here
@@ -97,13 +25,13 @@ fn default() -> Self {
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


