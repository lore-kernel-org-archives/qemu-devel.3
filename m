Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB40C3ABB9
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 10:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBsl3-0005S9-64; Mon, 05 May 2025 06:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBsl2-0005Rk-33
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:09:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBskz-0007CD-9J
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746439744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o4eJEJ6LUK5A+acUKlwgi0vs0hdZWNs63Wrhl4hER54=;
 b=HkvEsQNCoMIXIDSAYG4ZgW7HDl7Q3qwvUNyf0JFCoL0uU7ov68f0Lc3jwUUlYPNNBEyw3g
 1XIpc+yCysng5ODHWPaokTvcc0XuENMeBuaEzodqz0E9Pl3r4xfiYOuAQNL8qWNQPZGmn6
 MYsuHi09HIAXHHt2X1OFdrjVWA94s6c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-sAB00WwaMly3wmtzPHqUug-1; Mon, 05 May 2025 06:09:03 -0400
X-MC-Unique: sAB00WwaMly3wmtzPHqUug-1
X-Mimecast-MFC-AGG-ID: sAB00WwaMly3wmtzPHqUug_1746439742
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43f251dc364so23994905e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 03:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746439741; x=1747044541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o4eJEJ6LUK5A+acUKlwgi0vs0hdZWNs63Wrhl4hER54=;
 b=pm/jFFQUxYydp5uUb20eG0pXk5Jctquu/L4NkfIN6RmmxwIgll79Qz5Ye9NTFOFb6z
 oriDsdroCyPU0IcuyiBGTxYrOt95HnlpZqpAkF74X6iqu1FBaklAlF+JWZQoLFaJG8Pe
 6sGRy6Ege+XRjhxC5r714Kj7CBBIJByz5H4nysIEKRRmJAjyfmSrd0gbwsEo8wIC6J42
 /4Habhk816FVDEi8MVx6UuPQXx2cMlngidtfK+vEMgWUXtAT93X24siDjVTiUHVCaTwv
 /qzy3dgKUccX6dNlBMNDMUnLGr2MqSdZhnItjkSboy95SKrU+MP0O/xwwuwWTFE/LqzI
 sgmA==
X-Gm-Message-State: AOJu0YwTjXcJDmwqxqQBpXcHzLJRzzz7XMIL2EVS/qP6/pZXxw8K6mkS
 fW8D8CWG2hdG5gHyqa4r6+3l4X7U41fR8f0ZxMHsFfeZUNVaQHEHX+OeEz6utYiPhPpQYEAMC+f
 q78B9qCCwT7LtiyjlJgBkfcA4FHvLNZ0LLgyTw65e4CkMoK8OPv8mOxRNx4TMzdEsvAnpls/oW5
 I/gHoTijWj4OalYzcWiLxIA1p0Hxofn0ZnJQ4t
X-Gm-Gg: ASbGnct3LDJFxefWMBaG0K7UpiLvX6zVT4ypDVkEY+J1Cxt0oDlmpj7wOswPeYLbr1o
 +won4ZnJMWOkPo7xdyB5PXb8yCIzS6fM6RQQl1iYqoDyEYgJ8EpLg7F3xicy9s0SLKF9wjeiJB8
 oJ7XIeXTgUJWWfC2TIrxV3crqiPP54Ey3WFj67bEB3m5tvZr86tnwMB6sqyFjYAEpaBRwAoz5RY
 NrKkKNOyht0FrEGBoYe4kBH7INYNMcnFcsgykNkc/KkOntuNtO6Yn2GxfFAzp6WVNwVE2UJmRll
 DgremB1BqotwVcU=
X-Received: by 2002:a05:600c:3d8e:b0:43e:a7c9:8d2b with SMTP id
 5b1f17b1804b1-441c4919de9mr53226045e9.24.1746439740870; 
 Mon, 05 May 2025 03:09:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNr2lFzAub5aEOX7AAocy2B9+yhvcltYQ3gJYxA/xfXsF1K8RluuFCzthU2kAVLvsSoDlJTQ==
X-Received: by 2002:a05:600c:3d8e:b0:43e:a7c9:8d2b with SMTP id
 5b1f17b1804b1-441c4919de9mr53225865e9.24.1746439740404; 
 Mon, 05 May 2025 03:09:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2b20b36sm175419965e9.25.2025.05.05.03.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 03:08:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 2/5] rust: use inline const expressions
Date: Mon,  5 May 2025 12:08:51 +0200
Message-ID: <20250505100854.73936-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505100854.73936-1-pbonzini@redhat.com>
References: <20250505100854.73936-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

They were stabilized in Rust 1.79.0.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst            |  9 +++------
 rust/qemu-api/src/callbacks.rs | 27 +--------------------------
 rust/qemu-api/src/chardev.rs   |  2 +-
 rust/qemu-api/src/qdev.rs      |  2 +-
 rust/qemu-api/src/timer.rs     |  2 +-
 rust/qemu-api/src/vmstate.rs   |  2 +-
 6 files changed, 8 insertions(+), 36 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 139c298d462..cc52adcfdbe 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -75,9 +75,6 @@ QEMU supports rustc version 1.83.0 and newer.  The following features
 from relatively new versions of Rust are not used for historical reasons;
 patches are welcome:
 
-* inline const expression (stable in 1.79.0), currently worked around with
-  associated constants in the ``FnCall`` trait.
-
 * associated constants are still explicitly marked ``'static`` (`changed in
   1.81.0`__)
 
@@ -88,9 +85,9 @@ patches are welcome:
   architecture (VMState).  Right now, VMState lacks type safety because
   it is hard to place the ``VMStateField`` definitions in traits.
 
-* associated const equality would be nice to have for some users of
-  ``callbacks::FnCall``, but is still experimental.  ``ASSERT_IS_SOME``
-  replaces it.
+Associated const equality would be nice to have for some users of
+``callbacks::FnCall``, but is still experimental.  Const assertions
+are used instead.
 
 __ https://github.com/rust-lang/rust/pull/125258
 
diff --git a/rust/qemu-api/src/callbacks.rs b/rust/qemu-api/src/callbacks.rs
index 9642a16eb89..dbe2305f509 100644
--- a/rust/qemu-api/src/callbacks.rs
+++ b/rust/qemu-api/src/callbacks.rs
@@ -113,31 +113,6 @@
 /// This is always true for zero-capture closures and function pointers, as long
 /// as the code is able to name the function in the first place.
 pub unsafe trait FnCall<Args, R = ()>: 'static + Sync + Sized {
-    /// Referring to this internal constant asserts that the `Self` type is
-    /// zero-sized.  Can be replaced by an inline const expression in
-    /// Rust 1.79.0+.
-    const ASSERT_ZERO_SIZED: () = { assert!(mem::size_of::<Self>() == 0) };
-
-    /// Referring to this constant asserts that the `Self` type is an actual
-    /// function type, which can be used to catch incorrect use of `()`
-    /// at compile time.
-    ///
-    /// # Examples
-    ///
-    /// ```compile_fail
-    /// # use qemu_api::callbacks::FnCall;
-    /// fn call_it<F: for<'a> FnCall<(&'a str,), String>>(_f: &F, s: &str) -> String {
-    ///     let _: () = F::ASSERT_IS_SOME;
-    ///     F::call((s,))
-    /// }
-    ///
-    /// let s: String = call_it((), "hello world"); // does not compile
-    /// ```
-    ///
-    /// Note that this can be more simply `const { assert!(F::IS_SOME) }` in
-    /// Rust 1.79.0 or newer.
-    const ASSERT_IS_SOME: () = { assert!(Self::IS_SOME) };
-
     /// `true` if `Self` is an actual function type and not `()`.
     ///
     /// # Examples
@@ -195,7 +170,7 @@ unsafe impl<F, $($args,)* R> FnCall<($($args,)*), R> for F
 
             #[inline(always)]
             fn call(a: ($($args,)*)) -> R {
-                let _: () = Self::ASSERT_ZERO_SIZED;
+                const { assert!(mem::size_of::<Self>() == 0) };
 
                 // SAFETY: the safety of this method is the condition for implementing
                 // `FnCall`.  As to the `NonNull` idiom to create a zero-sized type,
diff --git a/rust/qemu-api/src/chardev.rs b/rust/qemu-api/src/chardev.rs
index 6e0590d758e..cb27be52569 100644
--- a/rust/qemu-api/src/chardev.rs
+++ b/rust/qemu-api/src/chardev.rs
@@ -138,7 +138,7 @@ pub fn enable_handlers<
             F::call((owner, event))
         }
 
-        let _: () = CanReceiveFn::ASSERT_IS_SOME;
+        const { assert!(CanReceiveFn::IS_SOME) };
         let receive_cb: Option<unsafe extern "C" fn(*mut c_void, *const u8, c_int)> =
             if ReceiveFn::is_some() {
                 Some(rust_receive_cb::<T, ReceiveFn>)
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 1279d7a58d5..6c93805a742 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -358,7 +358,7 @@ fn do_init_gpio_in(
             }
         }
 
-        let _: () = F::ASSERT_IS_SOME;
+        const { assert!(F::IS_SOME) };
         unsafe extern "C" fn rust_irq_handler<T, F: for<'a> FnCall<(&'a T, u32, u32)>>(
             opaque: *mut c_void,
             line: c_int,
diff --git a/rust/qemu-api/src/timer.rs b/rust/qemu-api/src/timer.rs
index 868bd88575f..66d39df37d8 100644
--- a/rust/qemu-api/src/timer.rs
+++ b/rust/qemu-api/src/timer.rs
@@ -56,7 +56,7 @@ pub fn init_full<'timer, 'opaque: 'timer, T, F>(
     ) where
         F: for<'a> FnCall<(&'a T,)>,
     {
-        let _: () = F::ASSERT_IS_SOME;
+        const { assert!(F::IS_SOME) };
 
         /// timer expiration callback
         unsafe extern "C" fn rust_timer_handler<T, F: for<'a> FnCall<(&'a T,)>>(
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 9c8b2398e9d..c564bd70308 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -457,7 +457,7 @@ macro_rules! vmstate_exist_fn {
         const fn test_cb_builder__<T, F: for<'a> $crate::callbacks::FnCall<(&'a T, u8), bool>>(
             _phantom: ::core::marker::PhantomData<F>,
         ) -> $crate::vmstate::VMSFieldExistCb {
-            let _: () = F::ASSERT_IS_SOME;
+            const { assert!(F::IS_SOME) };
             $crate::vmstate::rust_vms_test_field_exists::<T, F>
         }
 
-- 
2.49.0


