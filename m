Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BE9C021A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibf0-0000zP-Fs; Thu, 13 Feb 2025 11:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibeP-0000pZ-Td
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibeJ-0005Qg-An
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XCiret68kVy9ikx7EXAg8zqFJuISRQAId/mthV/wRgU=;
 b=XgcurFbPdmzgJ0/5iSsekPbNAzSsl652rMlmauCTkuseVsn/2i5ULz4eeqwZHJUvvHiiJK
 Yjbb8U5migkLUnhrsUjLWfurcVAh0g+fCB5TMByxcbMziR/qjuMfgwbFOJJ8kB2IPGXPCN
 4423LekppT7/RG8/aKY3tdxvoSP7v3M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-WnNe7Cg7M9iqwkBoBwqgPw-1; Thu, 13 Feb 2025 11:01:08 -0500
X-MC-Unique: WnNe7Cg7M9iqwkBoBwqgPw-1
X-Mimecast-MFC-AGG-ID: WnNe7Cg7M9iqwkBoBwqgPw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4394040fea1so6230615e9.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:01:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462467; x=1740067267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XCiret68kVy9ikx7EXAg8zqFJuISRQAId/mthV/wRgU=;
 b=GQiPBkFTOMKXQlLMcmJheVW75Y46Ec6ESKjmGv4f/9mKrdpYqEpcc+F/mEIjOKKkKk
 khyIkjsD5MORIRMaNUvuiCkkxoovDTbIkLyuRR6E9V97ejUa5FWLC6dNfdpm53bxPCwg
 M0KHHBDmkSk/Kcgzm7DAeceX0yEB1OovLPTvYswcW8s74IGX/Qy2a2dxPHuSKycqfzMO
 VjRGbjLGrRFoxSG7CniRe+sD7kNUyeNaGByhfa5aJhGzeHY8oK4iBTnn8Q0iI/UOOGhS
 NlDA3sC3Y11aa/J6MIvCczn+cPLlTu5O5M/Qw7/D1i6PSJWdaEXMbwd99U7vR5I6UXrh
 HhAw==
X-Gm-Message-State: AOJu0YzDF/q5JyndmA1V7APyfo0XfNLoS6odbPRVTzl/U2vGiwu1sxHR
 oQKoy3JRPm9v3JLIZjC4XEwBdvx1fsQ6a3WcZIq1NcnNiL/ZLl3H7+bu6cbrIGzxNr03e/bAaR2
 3QgL34leLt/ERjYsz21drDlNBaXRZzE6QtLU3bhNYiNpRsq77no9QLzuPVeCrsR74kPv/Cwy1V9
 TedV4ib/J5+GMrBltWiiDSHJpVHkjHbGdZewf9RqA=
X-Gm-Gg: ASbGncsaGwyXKp+OdIM4F+QG2McRg3+SBLHe5gCmocRHD6PtpdvMd4NadwZK3J0Ackb
 gC43/xwumo9davQDBI5wX3hlG4RvcA5eDn7jRmx92hkJ6tXgLYbDwe8/gtzwy6FwNMLY3WitvBl
 9jXf1xBV5cV7OdyY/V6+7aV5e7sspJjjSQAAsmnkqhTeSDueJ2c5kJcIC5eS7/oXelYpTzMmfDe
 HexWKAWZQ543nuMmUQSta00Phv6fGfzdxoT/B5N741DpRwWYQjR4EsipgDtLVkZp1rHXhr/aP5K
 5VR5Js4kyEKfxR8pBKzq//VvskSb/HHi14hk4kmys/G0Zg==
X-Received: by 2002:a05:600c:6a15:b0:439:5cf6:ec3 with SMTP id
 5b1f17b1804b1-43960bca41fmr36849645e9.4.1739462466989; 
 Thu, 13 Feb 2025 08:01:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGG3n03WFGaiuZw0EnXX+R1paGlqFU+k8lMKVxHFMd2DuUvGuhBZ/lD9G6tiTSkOKQg1UbtZA==
X-Received: by 2002:a05:600c:6a15:b0:439:5cf6:ec3 with SMTP id
 5b1f17b1804b1-43960bca41fmr36848945e9.4.1739462466314; 
 Thu, 13 Feb 2025 08:01:06 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1b824dsm52248675e9.34.2025.02.13.08.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:01:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 04/27] rust: callbacks: allow passing optional callbacks as ()
Date: Thu, 13 Feb 2025 17:00:31 +0100
Message-ID: <20250213160054.3937012-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213160054.3937012-1-pbonzini@redhat.com>
References: <20250213160054.3937012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

In some cases, callbacks are optional.  Using "Some(function)" and "None"
does not work well, because when someone writes "None" the compiler does
not know what to use for "F" in "Option<F>".

Therefore, adopt () to mean a "null" callback.  It is possible to enforce
that a callback is valid by adding a "let _: () = F::ASSERT_IS_SOME" before
the invocation of F::call.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/callbacks.rs | 97 ++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/rust/qemu-api/src/callbacks.rs b/rust/qemu-api/src/callbacks.rs
index 314f9dce962..9642a16eb89 100644
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
+    /// at compile time.
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
+    /// Note that this can be more simply `const { assert!(F::IS_SOME) }` in
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
2.48.1


