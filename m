Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B8BCCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Em3-0000Kq-Cw; Fri, 10 Oct 2025 11:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7Em2-0000KJ-M5
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:11:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7ElX-00048X-Pn
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760109036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EPkG2xx4KAvF4Noc00ffAe3GOSuomsju0SDpOtx5xNM=;
 b=amSndQekBvvtZzIxIHtPImJUcZUsDhXwmI4sNSdNT42o1kxqmuusWBF4wStb/CWKKZ2GBt
 4i+QukJcYTETdskTAeb5bWNTHRf5qu5XidGGzyErnWwzj81Fd9CuBZOMOkj+0ZYxB79oiC
 njePuVpJp/69597yzwEbuam6jsHM9R4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-wWnrfa5NMhiRRcD_L0xDtw-1; Fri, 10 Oct 2025 11:10:34 -0400
X-MC-Unique: wWnrfa5NMhiRRcD_L0xDtw-1
X-Mimecast-MFC-AGG-ID: wWnrfa5NMhiRRcD_L0xDtw_1760109034
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b3d21b18e8fso198593866b.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760109033; x=1760713833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EPkG2xx4KAvF4Noc00ffAe3GOSuomsju0SDpOtx5xNM=;
 b=La6gAyrr9mXxQE7UFQzOhbt2nFDQtWUyZyZcS2gfYt6AiZbYw7ONGS4sxxm78z2W1j
 rh5cVuWTqIKmX56DpytiewRwMRyvnA8H2ULxc3hoY8z8ryVgpkZsb3Jp0O/+/BpJ6SVK
 5nQkyYFh0Dt001gu7g/mmdTBzaLWcnAhWeZ7o9KFVw9KHPvDn5RRR0YU+R+0ne825RLx
 jDYQoigm/3W5GQ4tDOmM23C0DH3mOSr4BpeLF75hfj+goFoBXgH5G4sFwNgFLdzXp7pW
 zcx1HNsAnbA2hhsNYLzD6lCWhWPQOqYty/PBaaVKchZwSfMBqtVljemhlWlUutaFlxWU
 EMLQ==
X-Gm-Message-State: AOJu0Yy4gJ2J4ZigwpG7SjZvGH5lVWNu8SaL3jOiwwtR2B46D4hFmmuV
 deqsjqMiGEBvxBJnzZ8qFeOVWLn7k2aXNaqlPUqavVlZir030luMqYFbz7aY02Ek/t/GT7vbmL9
 f85QKmFR9NuSkiT7NALR8fA/+g11p0mcCjxYrWacGZniaV2hdLNclHx1ROqhTVYeVyHH/sRfjy0
 a10BG9tVPKztK0VL2Tb22ppYSd67BFn2rde0V2I31H
X-Gm-Gg: ASbGncv2YuBPPCJ1Hd+sGUr3iVNa8uouegEdLwjh6Bszdt/C110A+qk3QryJdX+tuj2
 z4eAJUDF4CCn3W+rkYVl2CFxtvvmhIBajdgitvcaj+u5S8UNAbLuelhs/4G5F63+hI21y6GxdUf
 gowqQrtuE73X/esu1NhhWb+r60la5nIYSMQ1HEjhrCwvsCxLXn8gSjPnot6BwWxcpMMbtjZY5bL
 +9ttP9lJ7pMQBaeQD34RUPK9+uX89Rp2/FkacX4+y2gWZfX6UMa1DFt0JyH8BTV1LX251HJ1OGK
 Jif99TLMMq64na4PK+j+/LKP6B3El7VfSku9pmJ4vG+FLZN/BvvXJVpb4xj/v9mwtifqdp6H9cA
 m8fKTtbGrt6ae5/NubYO0mJp2bsrtolb9+MsAwR6xmA02
X-Received: by 2002:a17:906:4fcd:b0:b50:697e:ba3 with SMTP id
 a640c23a62f3a-b50acc1a958mr1310614666b.63.1760109033068; 
 Fri, 10 Oct 2025 08:10:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDAAstEQn10E5MsdgMsXmttGl8Yg1vLsUH+5bnWAxRACDNkifI2nueZYHnrwsMjlGLgzC8Kw==
X-Received: by 2002:a17:906:4fcd:b0:b50:697e:ba3 with SMTP id
 a640c23a62f3a-b50acc1a958mr1310611066b.63.1760109032539; 
 Fri, 10 Oct 2025 08:10:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.231.162])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d9526885sm253031366b.84.2025.10.10.08.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 08:10:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	marcandre.lureau@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH 10/19] rust/util: replace Error::err_or_unit/err_or_else with
 Error::with_errp
Date: Fri, 10 Oct 2025 17:09:55 +0200
Message-ID: <20251010151006.791038-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010151006.791038-1-pbonzini@redhat.com>
References: <20251010151006.791038-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Introduce a simpler function that hides the creation of the Error**.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/util/src/error.rs | 52 ++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/rust/util/src/error.rs b/rust/util/src/error.rs
index bdbf2634170..5a0dd7786b5 100644
--- a/rust/util/src/error.rs
+++ b/rust/util/src/error.rs
@@ -14,8 +14,7 @@
 //!   [`ptr_or_propagate`](crate::Error::ptr_or_propagate) can be used to build
 //!   a C return value while also propagating an error condition
 //!
-//! * [`err_or_else`](crate::Error::err_or_else) and
-//!   [`err_or_unit`](crate::Error::err_or_unit) can be used to build a `Result`
+//! * [`with_errp`](crate::Error::with_errp) can be used to build a `Result`
 //!
 //! This module is most commonly used at the boundary between C and Rust code;
 //! other code will usually access it through the
@@ -208,35 +207,21 @@ pub unsafe fn propagate(self, errp: *mut *mut bindings::Error) {
         }
     }
 
-    /// Convert a C `Error*` into a Rust `Result`, using
-    /// `Ok(())` if `c_error` is NULL.  Free the `Error*`.
+    /// Pass a C `Error*` to the closure, and convert the result
+    /// (either the return value of the closure, or the error)
+    /// into a Rust `Result`.
     ///
     /// # Safety
     ///
-    /// `c_error` must be `NULL` or valid; typically it was initialized
-    /// with `ptr::null_mut()` and passed by reference to a C function.
-    pub unsafe fn err_or_unit(c_error: *mut bindings::Error) -> Result<()> {
-        // SAFETY: caller guarantees c_error is valid
-        unsafe { Self::err_or_else(c_error, || ()) }
-    }
+    /// One exit from `f`, `c_error` must be unchanged or point to a
+    /// valid C [`struct Error`](bindings::Error).
+    pub unsafe fn with_errp<T, F: FnOnce(&mut *mut bindings::Error) -> T>(f: F) -> Result<T> {
+        let mut c_error: *mut bindings::Error = ptr::null_mut();
 
-    /// Convert a C `Error*` into a Rust `Result`, calling `f()` to
-    /// obtain an `Ok` value if `c_error` is NULL.  Free the `Error*`.
-    ///
-    /// # Safety
-    ///
-    /// `c_error` must be `NULL` or point to a valid C [`struct
-    /// Error`](bindings::Error); typically it was initialized with
-    /// `ptr::null_mut()` and passed by reference to a C function.
-    pub unsafe fn err_or_else<T, F: FnOnce() -> T>(
-        c_error: *mut bindings::Error,
-        f: F,
-    ) -> Result<T> {
-        // SAFETY: caller guarantees c_error is valid
-        let err = unsafe { Option::<Self>::from_foreign(c_error) };
-        match err {
-            None => Ok(f()),
-            Some(err) => Err(err),
+        // SAFETY: guaranteed by the postcondition of `f`
+        match (f(&mut c_error), unsafe { c_error.into_native() }) {
+            (result, None) => Ok(result),
+            (_, Some(err)) => Err(err),
         }
     }
 }
@@ -421,13 +406,16 @@ fn test_ptr_or_propagate() {
     }
 
     #[test]
-    fn test_err_or_unit() {
+    fn test_with_errp() {
         unsafe {
-            let result = Error::err_or_unit(ptr::null_mut());
-            assert_match!(result, Ok(()));
+            let result = Error::with_errp(|_errp| true);
+            assert_match!(result, Ok(true));
 
-            let err = error_for_test(c"msg");
-            let err = Error::err_or_unit(err.into_inner()).unwrap_err();
+            let err = Error::with_errp(|errp| {
+                *errp = error_for_test(c"msg").into_inner();
+                false
+            })
+            .unwrap_err();
             assert_eq!(&*format!("{err}"), "msg");
         }
     }
-- 
2.51.0


