Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48E9E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 12:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKd5o-0007rc-Ix; Mon, 09 Dec 2024 07:42:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd20-0004So-8Z
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:38:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1u-0007Zw-G2
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733747904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8FLRIc2gzS7c4NuJ1tEpqw/oXvphOkODjv2WDRCVJI0=;
 b=do4Q4GXetDa9nS07x644wkgAawuWmJzN6wxIdMV4H3GW/2cAslA9+pkh+dISD532LmQlwq
 hmTAZr0QpIsLk3IAWP+QCo10NyaRyw880d33+ZRhFP1duZEEJ54oi9qbrLzbdWHsdkfdf6
 dpw322i//u8OlukLb4C2RIozyuA9igc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-FbbOFKYUOfKobCULKlwHGA-1; Mon, 09 Dec 2024 07:38:22 -0500
X-MC-Unique: FbbOFKYUOfKobCULKlwHGA-1
X-Mimecast-MFC-AGG-ID: FbbOFKYUOfKobCULKlwHGA
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385e1fd40acso2322266f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 04:38:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733747901; x=1734352701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8FLRIc2gzS7c4NuJ1tEpqw/oXvphOkODjv2WDRCVJI0=;
 b=c4ojNBdoD4kbjxkrRZ3hMtxSwKgMVyKOhn/Ew6D9yWUiKFa+aXm0YuatfxUC9XsX9i
 LCw6R9EQKH36xY1fArcIlxJRB9OqRWsfaYxdNgMjSAPsgXVr+lL95pTNrj6zz/e49ANN
 AXst5T+krzuVltPv+eZkFK8pKca9I6k+tMf4t8Rwo7UZQyKim6SOLvZfw2Kqhvo0xyTG
 PFe7Kr8FWAqegCR0ATvncobgTijFdlLwPjG8pqWFc1xZ2VDu5APD/W6xy6Z/QXpfYBhf
 wD+FVHrEfEGBKhupGUcvUch+n8b2mPjVKlVhYYNOyNNUYhLv3Tso5K02cjIGJZwe9Omc
 A4Nw==
X-Gm-Message-State: AOJu0YwmvBiXecgYG/KQOi+n9OUrwPr3biTXCAzVkg34yFEJGDhb811c
 Bakgh/XRvxp2h5r3uIMbq7BAgPTpXKfJZ/26AMTTv9BJozeCn9SWDim25GD/zcJ5P2PikTJmRHa
 jb4T0EvZmScrZNXADz7fnXdInfTCtFXc2Mzr7D3I0UfT7WfcFoUmVQAQXEcBgIWomYofYPi7Zs2
 In/XpRaip234sn8qrNwcFJvweD1FttEbc700tE
X-Gm-Gg: ASbGncskCoobJtfLi27bQZ0oAmac8P20LXggyG7Md6tignn+OfzaEUf4BJSqWVAURLu
 hNyXgN9Abg/j28VbGipJTioUeOg+N8U7kgWO3PpYWKgkoEFouVb1tzvHzENvHxTX4STNy26kwb0
 eK35YuYGHK0kFZslyWkBMWSxpKHvI+WftuWvWifAMmywNmAN551nQwJKQTokDmuvINUIs60WYZM
 97NS+fVnpKkxsiVclN3xIbEgraoKYCWw5qjgf9snKntPt7PCqaM6A==
X-Received: by 2002:a05:6000:1fa5:b0:385:f00a:a45b with SMTP id
 ffacd0b85a97d-386453d7028mr147798f8f.21.1733747901284; 
 Mon, 09 Dec 2024 04:38:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYHxKVPJ2qgAv7OqhotIxo6X4rQdCFyymxlIv8luqWuHEFXSvvl8hVztzNVTYO4jP+aAsfAw==
X-Received: by 2002:a05:6000:1fa5:b0:385:f00a:a45b with SMTP id
 ffacd0b85a97d-386453d7028mr147778f8f.21.1733747900821; 
 Mon, 09 Dec 2024 04:38:20 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861ecf3efasm12925978f8f.17.2024.12.09.04.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 04:38:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 25/26] rust: qemu-api: add a module to wrap functions and
 zero-sized closures
Date: Mon,  9 Dec 2024 13:37:16 +0100
Message-ID: <20241209123717.99077-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209123717.99077-1-pbonzini@redhat.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

One recurring issue when writing Rust bindings is how to convert a Rust
function ("fn" or "impl Fn") to a C function, and how to pass around
"self" to a C function that only takes a void*.

An easy solution would be to store on the heap a pair consisting of
a pointer to the Rust function and the pointer to "self", but it is
possible to do better.  If an "Fn" has zero size (that is, if it is a
zero-capture closures or a function pointer---which in turn includes all
methods), it is possible to build a generic Rust function that calls it
even if you only have the type; you don't need either the pointer to the
function itself (because the address of the code is part of the type)
or any closure data (because it has size zero).

Introduce a wrapper that provides the functionality of calling the
function given only its type.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/meson.build      |   1 +
 rust/qemu-api/src/callbacks.rs | 141 +++++++++++++++++++++++++++++++++
 rust/qemu-api/src/lib.rs       |   1 +
 3 files changed, 143 insertions(+)
 create mode 100644 rust/qemu-api/src/callbacks.rs

diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 7ff408ad68e..8c82c5e96c2 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -17,6 +17,7 @@ _qemu_api_rs = static_library(
       'src/lib.rs',
       'src/bindings.rs',
       'src/bitops.rs',
+      'src/callbacks.rs',
       'src/cell.rs',
       'src/c_str.rs',
       'src/irq.rs',
diff --git a/rust/qemu-api/src/callbacks.rs b/rust/qemu-api/src/callbacks.rs
new file mode 100644
index 00000000000..6401d807198
--- /dev/null
+++ b/rust/qemu-api/src/callbacks.rs
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: MIT
+
+//! Utility functions to deal with callbacks from C to Rust.
+
+use std::{mem, ptr::NonNull};
+
+/// Trait for functions (types implementing [`Fn`]) that can be used as
+/// callbacks. These include both zero-capture closures and function pointers.
+///
+/// In Rust, calling a function through the `Fn` trait normally requires a
+/// `self` parameter, even though for zero-sized functions (including function
+/// pointers) the type itself contains all necessary information to call the
+/// function. This trait provides a `call` function that doesn't require `self`,
+/// allowing zero-sized functions to be called using only their type.
+///
+/// This enables zero-sized functions to be passed entirely through generic
+/// parameters and resolved at compile-time. A typical use is a function
+/// receiving an unused parameter of generic type `F` and calling it via
+/// `F::call` or passing it to another function via `func::<F>`.
+///
+/// QEMU uses this trick to create wrappers to C callbacks.  The wrappers
+/// are needed to convert an opaque `*mut c_void` into a Rust reference,
+/// but they only have a single opaque that they can use.  The `FnCall`
+/// trait makes it possible to use that opaque for `self` or any other
+/// reference:
+///
+/// ```ignore
+/// // The compiler creates a new `rust_bh_cb` wrapper for each function
+/// // passed to `qemu_bh_schedule_oneshot` below.
+/// unsafe extern "C" fn rust_bh_cb<T, F: for<'a> FnCall<(&'a T,)>>(
+///     opaque: *mut c_void,
+/// ) {
+///     // SAFETY: the opaque was passed as a reference to `T`.
+///     F::call((unsafe { &*(opaque.cast::<T>()) }, ))
+/// }
+///
+/// // The `_f` parameter is unused but it helps the compiler build the appropriate `F`.
+/// // Using a reference allows usage in const context.
+/// fn qemu_bh_schedule_oneshot<T, F: for<'a> FnCall<(&'a T,)>>(_f: &F, opaque: &T) {
+///     let cb: unsafe extern "C" fn(*mut c_void) = rust_bh_cb::<T, F>;
+///     unsafe {
+///         bindings::qemu_bh_schedule_oneshot(cb, opaque as *const T as *const c_void as *mut c_void)
+///     }
+/// }
+/// ```
+///
+/// Each wrapper is a separate instance of `rust_bh_cb` and is therefore
+/// compiled to a separate function ("monomorphization").  If you wanted
+/// to pass `self` as the opaque value, the generic parameters would be
+/// `rust_bh_cb::<Self, F>`.
+///
+/// `Args` is a tuple type whose types are the arguments of the function,
+/// while `R` is the returned type.
+///
+/// # Examples
+///
+/// ```
+/// # use qemu_api::callbacks::FnCall;
+/// fn call_it<F: for<'a> FnCall<(&'a str,), String>>(_f: &F, s: &str) -> String {
+///     F::call((s,))
+/// }
+///
+/// let s: String = call_it(&str::to_owned, "hello world");
+/// assert_eq!(s, "hello world");
+/// ```
+///
+/// Note that the compiler will produce a different version of `call_it` for
+/// each function that is passed to it.  Therefore the argument is not really
+/// used, except to decide what is `F` and what `F::call` does.
+///
+/// Attempting to pass a non-zero-sized closure causes a compile-time failure:
+///
+/// ```compile_fail
+/// # use qemu_api::callbacks::FnCall;
+/// # fn call_it<'a, F: FnCall<(&'a str,), String>>(_f: &F, s: &'a str) -> String {
+/// #     F::call((s,))
+/// # }
+/// let x: &'static str = "goodbye world";
+/// call_it(&move |_| String::from(x), "hello workd");
+/// ```
+///
+/// # Safety
+///
+/// Because `Self` is a zero-sized type, all instances of the type are
+/// equivalent. However, in addition to this, `Self` must have no invariants
+/// that could be violated by creating a reference to it.
+///
+/// This is always true for zero-capture closures and function pointers, as long
+/// as the code is able to name the function in the first place.
+pub unsafe trait FnCall<Args, R = ()>: 'static + Sync + Sized {
+    /// Referring to this internal constant asserts that the `Self` type is
+    /// zero-sized.  Can be replaced by an inline const expression in
+    /// Rust 1.79.0+.
+    const ASSERT_ZERO_SIZED: () = { assert!(mem::size_of::<Self>() == 0) };
+
+    /// Call the function with the arguments in args.
+    fn call(a: Args) -> R;
+}
+
+macro_rules! impl_call {
+    ($($args:ident,)* ) => (
+        // SAFETY: because each function is treated as a separate type,
+        // accessing `FnCall` is only possible in code that would be
+        // allowed to call the function.
+        unsafe impl<F, $($args,)* R> FnCall<($($args,)*), R> for F
+        where
+            F: 'static + Sync + Sized + Fn($($args, )*) -> R,
+        {
+            #[inline(always)]
+            fn call(a: ($($args,)*)) -> R {
+                let _: () = Self::ASSERT_ZERO_SIZED;
+
+                // SAFETY: the safety of this method is the condition for implementing
+                // `FnCall`.  As to the `NonNull` idiom to create a zero-sized type,
+                // see https://github.com/rust-lang/libs-team/issues/292.
+                let f: &'static F = unsafe { &*NonNull::<Self>::dangling().as_ptr() };
+                let ($($args,)*) = a;
+                f($($args,)*)
+            }
+        }
+    )
+}
+
+impl_call!(_1, _2, _3, _4, _5,);
+impl_call!(_1, _2, _3, _4,);
+impl_call!(_1, _2, _3,);
+impl_call!(_1, _2,);
+impl_call!(_1,);
+impl_call!();
+
+#[cfg(test)]
+mod tests {
+    use super::*;
+
+    // The `_f` parameter is unused but it helps the compiler infer `F`.
+    fn do_test_call<'a, F: FnCall<(&'a str,), String>>(_f: &F) -> String {
+        F::call(("hello world",))
+    }
+
+    #[test]
+    fn test_call() {
+        assert_eq!(do_test_call(&str::to_owned), "hello world")
+    }
+}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 124bece0449..4b43e02c0f9 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -14,6 +14,7 @@
 
 pub mod bitops;
 pub mod c_str;
+pub mod callbacks;
 pub mod cell;
 pub mod irq;
 pub mod module;
-- 
2.47.1


