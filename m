Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3767CC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 19:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYsCp-0001bA-D1; Fri, 17 Jan 2025 14:40:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYsCe-0001Y7-4b
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:40:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYsCc-0002Cj-58
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737142821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fRcbdCPUwOzkxRo3DppX4d9hILrOyDu40de8lR3wnkQ=;
 b=WQy6Qi4laX6We1/hBQv1geBzpM7h/IK1Fluk1GGfvzIM4bR0wY4UBRvOggoXhYF1Zcn3wV
 4xTbpofWifSSVY86++JYsD8VK6NQJGSk7Tb+TzR2Rbmo97q4MX4s6S3A5Z7dwzRU4pSOze
 wX76L849x+9cCWGkTOipT1d0XPMjmgI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-AxvMnqo2NICMID8YQqmdTw-1; Fri, 17 Jan 2025 14:40:20 -0500
X-MC-Unique: AxvMnqo2NICMID8YQqmdTw-1
X-Mimecast-MFC-AGG-ID: AxvMnqo2NICMID8YQqmdTw
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5d89a53fc46so3165137a12.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 11:40:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737142817; x=1737747617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fRcbdCPUwOzkxRo3DppX4d9hILrOyDu40de8lR3wnkQ=;
 b=YPx9Oh/gZpyup/pYewF8hojm1uZtaBve1EIajbZn0R+CXl3F5AGsXS9zbQV38vZ4F4
 50ULwtXyOOQZ/cDzzGh2V5x/UQtU6hLbEr8WJu1J170Tm4hDdNXF2KK81mT9HARGmpa8
 9I8uaAzn9tE8sDzyE7xSiGh8Gxsc/HTNlJ6fHezzpUjgfoHEUGLwZXytq0SX0waO5WP3
 uMKV6rP8C9PD+ytkW3cs4Hcu3tEkdxLCMRLizVXzB5xpZd7K4UyQBK6yESV3HB3n62+A
 2xXaGMNsvRx4pX3bIzzP+dXZmADm3z9iLA14/5d3eDb4UbGkiuZkl9d7pUNXuClv7Mo5
 o4+w==
X-Gm-Message-State: AOJu0YzSepsvUFmH3aMQSTy5FkUCeNnkeiAAuQX5Su2B/j3hJZ5DlBX6
 hU28PGfGatMNWhiuypuSMdcc1q1OnZSof68lNKqg8bH1iYWn+Rq5CzeG5iiANUqYIv3Gp0SZknw
 KmuoA2SyVF4EBPTZGxiBLhW9KhhQ6CBzoyUOz+n0CDB2+1FftR4i1XeVKisipcvr4m9f58CAzmL
 zk2mfnarKw/xxHBDZVCXXPYdYe3l/EM+ORlEI9QjI=
X-Gm-Gg: ASbGncu0VxIxSJT3aJTmTzZ9VJM4O6O3TKpv4BAPoWmvio9tCin2PYMHr9aZekhGUCq
 dgx3ERGVNyz4vft62gp5AV/bhNtGis7l0TTPTRr6CGED+DN2MhHqU0oKcI9WaolKRd/0A0555Fi
 6cdeo9TZVVCjYuUin84w2epywH4JTqtHYICnPVc+KfCxJt9GuUeIV2qZjc1wMofngOhiDZBZMyq
 YRxP7slCSL9bCmHbJisok8Qx/7ZnhXqIR8U+nVXNaa+VvtSsWg1kXqogZ1bsA==
X-Received: by 2002:a17:907:3f11:b0:ab2:aea7:510f with SMTP id
 a640c23a62f3a-ab38b320310mr425608866b.30.1737142817151; 
 Fri, 17 Jan 2025 11:40:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6byZGf3zER2luuH6R2ebrcD5twTbc6HkYOOuFRATHSL5vwYA0+GcMdkji3gsjKP+xQTIxRg==
X-Received: by 2002:a17:907:3f11:b0:ab2:aea7:510f with SMTP id
 a640c23a62f3a-ab38b320310mr425602266b.30.1737142815320; 
 Fri, 17 Jan 2025 11:40:15 -0800 (PST)
Received: from [192.168.10.47] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384fce6ddsm216656066b.180.2025.01.17.11.40.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 11:40:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 04/10] rust: callbacks: allow passing optional callbacks as ()
Date: Fri, 17 Jan 2025 20:39:57 +0100
Message-ID: <20250117194003.1173231-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117194003.1173231-1-pbonzini@redhat.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In some cases, callbacks are optional.  Using "Some(function)" and "None"
does not work well, because when someone writes "None" the compiler does
not know what to use for "F" in "Option<F>".

Therefore, adopt () to mean a "null" callback.  It is possible to enforce
that a callback is valid by adding a "let _: () = F::ASSERT_IS_SOME" before
the invocation of F::call.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/callbacks.rs | 97 ++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/rust/qemu-api/src/callbacks.rs b/rust/qemu-api/src/callbacks.rs
index 314f9dce962..a59878bfb74 100644
--- a/rust/qemu-api/src/callbacks.rs
+++ b/rust/qemu-api/src/callbacks.rs
@@ -79,6 +79,31 @@
 /// call_it(&move |_| String::from(x), "hello workd");
 /// ```
 ///
+/// `()` can be used to indicate "no function":
+///
+/// ```
+/// # use qemu_api::callbacks::FnCall;
+/// fn optional<F: for<'a> FnCall<(&'a str,), String>>(_f: &F, s: &str) -> Option<String> {
+///     if F::IS_SOME {
+///         Some(F::call((s,)))
+///     } else {
+///         None
+///     }
+/// }
+///
+/// assert!(optional(&(), "hello world").is_none());
+/// ```
+///
+/// Invoking `F::call` will then be a run-time error.
+///
+/// ```should_panic
+/// # use qemu_api::callbacks::FnCall;
+/// # fn call_it<F: for<'a> FnCall<(&'a str,), String>>(_f: &F, s: &str) -> String {
+/// #     F::call((s,))
+/// # }
+/// let s: String = call_it(&(), "hello world"); // panics
+/// ```
+///
 /// # Safety
 ///
 /// Because `Self` is a zero-sized type, all instances of the type are
@@ -93,10 +118,70 @@ pub unsafe trait FnCall<Args, R = ()>: 'static + Sync + Sized {
     /// Rust 1.79.0+.
     const ASSERT_ZERO_SIZED: () = { assert!(mem::size_of::<Self>() == 0) };
 
+    /// Referring to this constant asserts that the `Self` type is an actual
+    /// function type, which can be used to catch incorrect use of `()`
+    /// at  compile time.
+    ///
+    /// # Examples
+    ///
+    /// ```compile_fail
+    /// # use qemu_api::callbacks::FnCall;
+    /// fn call_it<F: for<'a> FnCall<(&'a str,), String>>(_f: &F, s: &str) -> String {
+    ///     let _: () = F::ASSERT_IS_SOME;
+    ///     F::call((s,))
+    /// }
+    ///
+    /// let s: String = call_it((), "hello world"); // does not compile
+    /// ```
+    ///
+    /// Note that this use more simply `const { assert!(F::IS_SOME) }` in
+    /// Rust 1.79.0 or newer.
+    const ASSERT_IS_SOME: () = { assert!(Self::IS_SOME) };
+
+    /// `true` if `Self` is an actual function type and not `()`.
+    ///
+    /// # Examples
+    ///
+    /// You can use `IS_SOME` to catch this at compile time:
+    ///
+    /// ```compile_fail
+    /// # use qemu_api::callbacks::FnCall;
+    /// fn call_it<F: for<'a> FnCall<(&'a str,), String>>(_f: &F, s: &str) -> String {
+    ///     const { assert!(F::IS_SOME) }
+    ///     F::call((s,))
+    /// }
+    ///
+    /// let s: String = call_it((), "hello world"); // does not compile
+    /// ```
+    const IS_SOME: bool;
+
+    /// `false` if `Self` is an actual function type, `true` if it is `()`.
+    fn is_none() -> bool {
+        !Self::IS_SOME
+    }
+
+    /// `true` if `Self` is an actual function type, `false` if it is `()`.
+    fn is_some() -> bool {
+        Self::IS_SOME
+    }
+
     /// Call the function with the arguments in args.
     fn call(a: Args) -> R;
 }
 
+/// `()` acts as a "null" callback.  Using `()` and `function` is nicer
+/// than `None` and `Some(function)`, because the compiler is unable to
+/// infer the type of just `None`.  Therefore, the trait itself acts as the
+/// option type, with functions [`FnCall::is_some`] and [`FnCall::is_none`].
+unsafe impl<Args, R> FnCall<Args, R> for () {
+    const IS_SOME: bool = false;
+
+    /// Call the function with the arguments in args.
+    fn call(_a: Args) -> R {
+        panic!("callback not specified")
+    }
+}
+
 macro_rules! impl_call {
     ($($args:ident,)* ) => (
         // SAFETY: because each function is treated as a separate type,
@@ -106,6 +191,8 @@ unsafe impl<F, $($args,)* R> FnCall<($($args,)*), R> for F
         where
             F: 'static + Sync + Sized + Fn($($args, )*) -> R,
         {
+            const IS_SOME: bool = true;
+
             #[inline(always)]
             fn call(a: ($($args,)*)) -> R {
                 let _: () = Self::ASSERT_ZERO_SIZED;
@@ -141,4 +228,14 @@ fn do_test_call<'a, F: FnCall<(&'a str,), String>>(_f: &F) -> String {
     fn test_call() {
         assert_eq!(do_test_call(&str::to_owned), "hello world")
     }
+
+    // The `_f` parameter is unused but it helps the compiler infer `F`.
+    fn do_test_is_some<'a, F: FnCall<(&'a str,), String>>(_f: &F) {
+        assert!(F::is_some());
+    }
+
+    #[test]
+    fn test_is_some() {
+        do_test_is_some(&str::to_owned);
+    }
 }
-- 
2.47.1


