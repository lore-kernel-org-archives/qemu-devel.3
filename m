Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794B3C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 10:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7eK-0007x5-CK; Thu, 05 Jun 2025 06:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7dq-0007O7-Ie
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:16:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7dn-0001Ho-ST
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749118566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qb5VF/W0HxUj2zBAoVC6z6KQvpOIXPHyBu3lEBptkvw=;
 b=cuO0DrjCFEypLTUERyzAYw7l+eq8Y0OU/93f8rLv+/JyRtB8E9dnYL/wrKph/UwPw+jlWH
 tSFbo/fXqVVZf4dwBIX//7/wN4C7S+2YsbeGPJDdj45RuKnDrdfwXkeVO7FvqegsyT13Da
 dJ3K+9zsKINRtr7oV3ctBpOgehd2grQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-MxPgDz7sOCqGFAaUPW9v1g-1; Thu, 05 Jun 2025 06:16:05 -0400
X-MC-Unique: MxPgDz7sOCqGFAaUPW9v1g-1
X-Mimecast-MFC-AGG-ID: MxPgDz7sOCqGFAaUPW9v1g_1749118564
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f85f31d9so462661f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 03:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749118562; x=1749723362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qb5VF/W0HxUj2zBAoVC6z6KQvpOIXPHyBu3lEBptkvw=;
 b=Eizl/qiTiSHn/Z+hGO2IZuW8pckRvI53jEaFf3/MyVtxcd4yFn6hxJw5qCQJ/4ibcI
 FlNXeZRb+gW11o9QHLWZnyL54s2S13M3BNxpaLwiYOqVimFcaENN/nFli21rmB4V43nO
 T2OXLi+xhVmc0yUG1RcXQCxQd3YXWy8WWRt+M7btA8Zucz4AJy5bD7kfgU9aYNroIA9U
 S/bXeNe1CIJmR0rE11AxTR5wSF2EoAhkaKD+YsXpkrQyANuinklu0vLynLOR80eFgH0t
 s9YLcEMOdEZaAtMLgep6iSOMGr4FApqc3JltkMX2ggoxMG3Q+6k1fTl1QE5vufjx6AED
 gd8g==
X-Gm-Message-State: AOJu0Yz8WgNaNsdnuAKiQo0t9Xm0Y+IOd1RfWYdgiY0HgbXUXl1uhLwP
 L3ZzzmuaIX1DLqWXFVXz2161KB1JuhMPW3xUGaEPd8VuSxZddvS9VaMW46YnY2MsQZJ4+NdtkD8
 wi4XZxhxrzuCQQYQOsyStWSUdDSFYFy4vwnt3xrg5w6L6LwQn02alCgyqsh3Dx3+dZEMdnIfGTw
 8uJm7+865+ySD5lQwFPzq1dnI7W2uIMDAMYgT9pwiF
X-Gm-Gg: ASbGncttTgsPPYMbkdO90VD4im9EpzfkizpqBbE8NikIA48bXibB3AR7BWjka1Hp7iA
 1zfuyfywZC+O3qWC1ArzXGa/1sRKbtQRQZRdzgHCwhUSJc8c5Qd/gIctJRXru2YUPE69g+Y3IEX
 EN7obeqBPzjk78Fwmzrw4p8uTts3mAozpD+kUyeO5ZbuqDYVhQzNhv04GqR/1aqkNzInUvqYI/W
 wC/dHGRSZLoC7L0ezB43Uz28U1rGRcsSBJ/FDb8IeXmJVdtkAc0rl6uaJ7SUoPwjqC0wpCe40rL
 5WAXHUBuEheXAw==
X-Received: by 2002:a05:6000:25ca:b0:3a4:d452:fff with SMTP id
 ffacd0b85a97d-3a51d91fad0mr5072638f8f.17.1749118562226; 
 Thu, 05 Jun 2025 03:16:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEUYJm+vcV7cv15rTdASS4p7UCsbVMCL6Gs87bkPsbrAc9hxnyReOsEkejdwFPWqGNF+5vKw==
X-Received: by 2002:a05:6000:25ca:b0:3a4:d452:fff with SMTP id
 ffacd0b85a97d-3a51d91fad0mr5072605f8f.17.1749118561571; 
 Thu, 05 Jun 2025 03:16:01 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe740bbsm24182845f8f.54.2025.06.05.03.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 03:16:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	zhao1.liu@intel.com,
	qemu-rust@nongnu.org
Subject: [PATCH 06/14] rust: qemu-api: add bindings to Error
Date: Thu,  5 Jun 2025 12:15:35 +0200
Message-ID: <20250605101544.368953-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605101544.368953-1-pbonzini@redhat.com>
References: <20250605101544.368953-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=unavailable autolearn_force=no
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

Provide an implementation of std::error::Error that bridges the Rust
anyhow::Error and std::panic::Location types with QEMU's Error*.

It also has several utility methods, analogous to error_propagate(),
that convert a Result into a return value + Error** pair.  One important
difference is that these propagation methods *panic* if *errp is NULL,
unlike error_propagate() which eats subsequent errors[1].  The reason
for this is that in C you have an error_set*() call at the site where
the error is created, and calls to error_propagate() are relatively rare.

In Rust instead, even though these functions do "propagate" a
qemu_api::Error into a C Error**, there is no error_setg() anywhere that
could check for non-NULL errp and call abort().  error_propagate()'s
behavior of ignoring subsequent errors is generally considered weird,
and there would be a bigger risk of triggering it from Rust code.

[1] This is actually a violation of the preconditions of error_propagate(),
    so it should not happen.  But you never know...

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst        |   5 +
 rust/Cargo.lock            |  17 ++
 rust/Cargo.toml            |   1 +
 rust/qemu-api/Cargo.toml   |   2 +
 rust/qemu-api/meson.build  |   1 +
 rust/qemu-api/src/error.rs | 312 +++++++++++++++++++++++++++++++++++++
 rust/qemu-api/src/lib.rs   |   3 +
 7 files changed, 341 insertions(+)
 create mode 100644 rust/qemu-api/src/error.rs

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 34d9c7945b7..98803d5e8dd 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -96,6 +96,11 @@ are missing:
   architecture (VMState).  Right now, VMState lacks type safety because
   it is hard to place the ``VMStateField`` definitions in traits.
 
+* NUL-terminated file names with ``#[track_caller]`` are scheduled for
+  inclusion as `#![feature(location_file_nul)]`, but it will be a while
+  before QEMU can use them.  For now, there is special code in
+  ``util/error.c`` to support non-NUL-terminated file names.
+
 * associated const equality would be nice to have for some users of
   ``callbacks::FnCall``, but is still experimental.  ``ASSERT_IS_SOME``
   replaces it.
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index bccfe855a70..b785c718f31 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -2,6 +2,12 @@
 # It is not intended for manual editing.
 version = 3
 
+[[package]]
+name = "anyhow"
+version = "1.0.98"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "e16d2d3311acee920a9eb8d33b8cbc1787ce4a264e85f964c2404b969bdcd487"
+
 [[package]]
 name = "arbitrary-int"
 version = "1.2.7"
@@ -44,6 +50,15 @@ version = "1.12.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "3dca9240753cf90908d7e4aac30f630662b02aebaa1b58a3cadabdb23385b58b"
 
+[[package]]
+name = "foreign"
+version = "0.3.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "17ca1b5be8c9d320daf386f1809c7acc0cb09accbae795c2001953fa50585846"
+dependencies = [
+ "libc",
+]
+
 [[package]]
 name = "hpet"
 version = "0.1.0"
@@ -114,6 +129,8 @@ dependencies = [
 name = "qemu_api"
 version = "0.1.0"
 dependencies = [
+ "anyhow",
+ "foreign",
  "libc",
  "qemu_api_macros",
 ]
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index fd4c2fbf84b..0868e1b4268 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -67,6 +67,7 @@ missing_safety_doc = "deny"
 mut_mut = "deny"
 needless_bitwise_bool = "deny"
 needless_pass_by_ref_mut = "deny"
+needless_update = "deny"
 no_effect_underscore_binding = "deny"
 option_option = "deny"
 or_fun_call = "deny"
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index c96cf50e7a1..db7000dee44 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -15,7 +15,9 @@ rust-version.workspace = true
 
 [dependencies]
 qemu_api_macros = { path = "../qemu-api-macros" }
+anyhow = "~1.0"
 libc = "0.2.162"
+foreign = "~0.3.1"
 
 [features]
 default = ["debug_cell"]
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 2f0f3b2aae1..cac8595a148 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -19,6 +19,7 @@ _qemu_api_rs = static_library(
       'src/cell.rs',
       'src/chardev.rs',
       'src/errno.rs',
+      'src/error.rs',
       'src/irq.rs',
       'src/memory.rs',
       'src/module.rs',
diff --git a/rust/qemu-api/src/error.rs b/rust/qemu-api/src/error.rs
new file mode 100644
index 00000000000..80157f6ea1b
--- /dev/null
+++ b/rust/qemu-api/src/error.rs
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! Error propagation for QEMU Rust code
+//!
+//! This module contains [`Error`], the bridge between Rust errors and
+//! [`Result`](std::result::Result)s and QEMU's C [`Error`](bindings::Error)
+//! struct.
+//!
+//! For FFI code, [`Error`] provides functions to simplify conversion between
+//! the Rust ([`Result<>`](std::result::Result)) and C (`Error**`) conventions:
+//!
+//! * [`ok_or_propagate`](crate::Error::ok_or_propagate),
+//!   [`bool_or_propagate`](crate::Error::bool_or_propagate),
+//!   [`ptr_or_propagate`](crate::Error::ptr_or_propagate) can be used to build
+//!   a C return value while also propagating an error condition
+//!
+//! * [`err_or_else`](crate::Error::err_or_else) and
+//!   [`err_or_unit`](crate::Error::err_or_unit) can be used to build a `Result`
+//!
+//! This module is most commonly used at the boundary between C and Rust code;
+//! other code will usually access it through the
+//! [`qemu_api::Result`](crate::Result) type alias, and will use the
+//! [`std::error::Error`] interface to let C errors participate in Rust's error
+//! handling functionality.
+//!
+//! Rust code can also create use this module to create an error object that
+//! will be passed up to C code, though in most cases this will be done
+//! transparently through the `?` operator.  Errors can be constructed from a
+//! simple error string, from an [`anyhow::Error`] to pass any other Rust error
+//! type up to C code, or from a combination of the two.
+//!
+//! The third case, corresponding to [`Error::with_error`], is the only one that
+//! requires mentioning [`qemu_api::Error`](crate::Error) explicitly.  Similar
+//! to how QEMU's C code handles errno values, the string and the
+//! `anyhow::Error` object will be concatenated with `:` as the separator.
+
+use std::{
+    borrow::Cow,
+    ffi::{c_char, c_int, c_void, CStr},
+    fmt::{self, Display},
+    panic, ptr,
+};
+
+use foreign::{prelude::*, OwnedPointer};
+
+use crate::bindings;
+
+pub type Result<T> = std::result::Result<T, Error>;
+
+#[derive(Debug)]
+pub struct Error {
+    msg: Option<Cow<'static, str>>,
+    /// Appends the print string of the error to the msg if not None
+    cause: Option<anyhow::Error>,
+    file: &'static str,
+    line: u32,
+}
+
+impl std::error::Error for Error {
+    fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {
+        self.cause.as_ref().map(AsRef::as_ref)
+    }
+
+    #[allow(deprecated)]
+    fn description(&self) -> &str {
+        self.msg
+            .as_deref()
+            .or_else(|| self.cause.as_deref().map(std::error::Error::description))
+            .expect("no message nor cause?")
+    }
+}
+
+impl Display for Error {
+    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
+        let mut prefix = "";
+        if let Some(ref msg) = self.msg {
+            write!(f, "{msg}")?;
+            prefix = ": ";
+        }
+        if let Some(ref cause) = self.cause {
+            write!(f, "{prefix}{cause}")?;
+        } else if prefix.is_empty() {
+            panic!("no message nor cause?");
+        }
+        Ok(())
+    }
+}
+
+impl From<String> for Error {
+    #[track_caller]
+    fn from(msg: String) -> Self {
+        let location = panic::Location::caller();
+        Error {
+            msg: Some(Cow::Owned(msg)),
+            cause: None,
+            file: location.file(),
+            line: location.line(),
+        }
+    }
+}
+
+impl From<&'static str> for Error {
+    #[track_caller]
+    fn from(msg: &'static str) -> Self {
+        let location = panic::Location::caller();
+        Error {
+            msg: Some(Cow::Borrowed(msg)),
+            cause: None,
+            file: location.file(),
+            line: location.line(),
+        }
+    }
+}
+
+impl From<anyhow::Error> for Error {
+    #[track_caller]
+    fn from(error: anyhow::Error) -> Self {
+        let location = panic::Location::caller();
+        Error {
+            msg: None,
+            cause: Some(error),
+            file: location.file(),
+            line: location.line(),
+        }
+    }
+}
+
+impl Error {
+    /// Create a new error, prepending `msg` to the
+    /// description of `cause`
+    #[track_caller]
+    pub fn with_error(msg: impl Into<Cow<'static, str>>, cause: impl Into<anyhow::Error>) -> Self {
+        let location = panic::Location::caller();
+        Error {
+            msg: Some(msg.into()),
+            cause: Some(cause.into()),
+            file: location.file(),
+            line: location.line(),
+        }
+    }
+
+    /// Consume a result, returning `false` if it is an error and
+    /// `true` if it is successful.  The error is propagated into
+    /// `errp` like the C API `error_propagate` would do.
+    ///
+    /// # Safety
+    ///
+    /// `errp` must be a valid argument to `error_propagate`;
+    /// typically it is received from C code and need not be
+    /// checked further at the Rust↔C boundary.
+    pub unsafe fn bool_or_propagate(result: Result<()>, errp: *mut *mut bindings::Error) -> bool {
+        // SAFETY: caller guarantees errp is valid
+        unsafe { Self::ok_or_propagate(result, errp) }.is_some()
+    }
+
+    /// Consume a result, returning a `NULL` pointer if it is an error and
+    /// a C representation of the contents if it is successful.  This is
+    /// similar to the C API `error_propagate`, but it panics if `*errp`
+    /// is not `NULL`.
+    ///
+    /// # Safety
+    ///
+    /// `errp` must be a valid argument to `error_propagate`;
+    /// typically it is received from C code and need not be
+    /// checked further at the Rust↔C boundary.
+    ///
+    /// See [`propagate`](Error::propagate) for more information.
+    #[must_use]
+    pub unsafe fn ptr_or_propagate<T: CloneToForeign>(
+        result: Result<T>,
+        errp: *mut *mut bindings::Error,
+    ) -> *mut T::Foreign {
+        // SAFETY: caller guarantees errp is valid
+        unsafe { Self::ok_or_propagate(result, errp) }.clone_to_foreign_ptr()
+    }
+
+    /// Consume a result in the same way as `self.ok()`, but also propagate
+    /// a possible error into `errp`.  This is similar to the C API
+    /// `error_propagate`, but it panics if `*errp` is not `NULL`.
+    ///
+    /// # Safety
+    ///
+    /// `errp` must be a valid argument to `error_propagate`;
+    /// typically it is received from C code and need not be
+    /// checked further at the Rust↔C boundary.
+    ///
+    /// See [`propagate`](Error::propagate) for more information.
+    pub unsafe fn ok_or_propagate<T>(
+        result: Result<T>,
+        errp: *mut *mut bindings::Error,
+    ) -> Option<T> {
+        result.map_err(|err| unsafe { err.propagate(errp) }).ok()
+    }
+
+    /// Equivalent of the C function `error_propagate`.  Fill `*errp`
+    /// with the information container in `self` if `errp` is not NULL;
+    /// then consume it.
+    ///
+    /// This is similar to the C API `error_propagate`, but it panics if
+    /// `*errp` is not `NULL`.
+    ///
+    /// # Safety
+    ///
+    /// `errp` must be a valid argument to `error_propagate`; it can be
+    /// `NULL` or it can point to any of:
+    /// * `error_abort`
+    /// * `error_fatal`
+    /// * a local variable of (C) type `Error *`
+    ///
+    /// Typically `errp` is received from C code and need not be
+    /// checked further at the Rust↔C boundary.
+    pub unsafe fn propagate(self, errp: *mut *mut bindings::Error) {
+        if errp.is_null() {
+            return;
+        }
+
+        // SAFETY: caller guarantees that errp and *errp are valid
+        unsafe {
+            assert_eq!(*errp, ptr::null_mut());
+            bindings::error_propagate(errp, self.clone_to_foreign_ptr());
+        }
+    }
+
+    /// Convert a C `Error*` into a Rust `Result`, using
+    /// `Ok(())` if `c_error` is NULL.  Free the `Error*`.
+    ///
+    /// # Safety
+    ///
+    /// `c_error` must be `NULL` or valid; typically it was initialized
+    /// with `ptr::null_mut()` and passed by reference to a C function.
+    pub unsafe fn err_or_unit(c_error: *mut bindings::Error) -> Result<()> {
+        // SAFETY: caller guarantees c_error is valid
+        unsafe { Self::err_or_else(c_error, || ()) }
+    }
+
+    /// Convert a C `Error*` into a Rust `Result`, calling `f()` to
+    /// obtain an `Ok` value if `c_error` is NULL.  Free the `Error*`.
+    ///
+    /// # Safety
+    ///
+    /// `c_error` must be `NULL` or point to a valid C [`struct
+    /// Error`](bindings::Error); typically it was initialized with
+    /// `ptr::null_mut()` and passed by reference to a C function.
+    pub unsafe fn err_or_else<T, F: FnOnce() -> T>(
+        c_error: *mut bindings::Error,
+        f: F,
+    ) -> Result<T> {
+        // SAFETY: caller guarantees c_error is valid
+        let err = unsafe { Option::<Self>::from_foreign(c_error) };
+        match err {
+            None => Ok(f()),
+            Some(err) => Err(err),
+        }
+    }
+}
+
+impl FreeForeign for Error {
+    type Foreign = bindings::Error;
+
+    unsafe fn free_foreign(p: *mut bindings::Error) {
+        // SAFETY: caller guarantees p is valid
+        unsafe {
+            bindings::error_free(p);
+        }
+    }
+}
+
+impl CloneToForeign for Error {
+    fn clone_to_foreign(&self) -> OwnedPointer<Self> {
+        // SAFETY: all arguments are controlled by this function
+        unsafe {
+            let err: *mut c_void = libc::malloc(std::mem::size_of::<bindings::Error>());
+            let err: &mut bindings::Error = &mut *err.cast();
+            *err = bindings::Error {
+                msg: format!("{self}").clone_to_foreign_ptr(),
+                err_class: bindings::ERROR_CLASS_GENERIC_ERROR,
+                src_len: self.file.len() as c_int,
+                src: self.file.as_ptr().cast::<c_char>(),
+                line: self.line as c_int,
+                func: ptr::null_mut(),
+                hint: ptr::null_mut(),
+            };
+            OwnedPointer::new(err)
+        }
+    }
+}
+
+impl FromForeign for Error {
+    unsafe fn cloned_from_foreign(c_error: *const bindings::Error) -> Self {
+        // SAFETY: caller guarantees c_error is valid
+        unsafe {
+            let error = &*c_error;
+            let file = if error.src_len < 0 {
+                // NUL-terminated
+                CStr::from_ptr(error.src).to_str()
+            } else {
+                // Can become str::from_utf8 with Rust 1.87.0
+                std::str::from_utf8(std::slice::from_raw_parts(
+                    &*error.src.cast::<u8>(),
+                    error.src_len as usize,
+                ))
+            };
+
+            Error {
+                msg: FromForeign::cloned_from_foreign(error.msg),
+                cause: None,
+                file: file.unwrap(),
+                line: error.line as u32,
+            }
+        }
+    }
+}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 234a94e3c29..93902fc94bc 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -19,6 +19,7 @@
 pub mod cell;
 pub mod chardev;
 pub mod errno;
+pub mod error;
 pub mod irq;
 pub mod memory;
 pub mod module;
@@ -34,6 +35,8 @@
     ffi::c_void,
 };
 
+pub use error::{Error, Result};
+
 #[cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)]
 extern "C" {
     fn g_aligned_alloc0(
-- 
2.49.0


