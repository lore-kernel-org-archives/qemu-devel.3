Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD33AC0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 14:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiaGZ-00008d-Kd; Thu, 13 Feb 2025 09:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiaGX-00007p-Oe
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:32:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiaGU-0007ch-Ee
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:32:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739457149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9HuabNfmcV5bFyT6ApQ3NSr9ADHRppEqYdaF7SVE1ww=;
 b=PzUtzT6naGVW1pwYG98VBVThdKQr43pGrD8qYxbR7IsYF2xsBde9EXoJXvcuTUK/hgBl6+
 0HEPLDW6aOfJJp6w+S9n+2Jo3R4frNvi2WOxssSAcdK9QnrNmVDBlZN97MAGuCTX/606Yy
 at0fY/LaFryIqCTUINd+4FUNsGd8t7E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-JXiXYhr6Pm2Yz0xm0OypDA-1; Thu, 13 Feb 2025 09:32:26 -0500
X-MC-Unique: JXiXYhr6Pm2Yz0xm0OypDA-1
X-Mimecast-MFC-AGG-ID: JXiXYhr6Pm2Yz0xm0OypDA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43941ad86d4so7733645e9.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 06:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739457144; x=1740061944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9HuabNfmcV5bFyT6ApQ3NSr9ADHRppEqYdaF7SVE1ww=;
 b=xSKa/1NtJsR/xSlll1uSiSk5TSKVaCClKgwrpfPZdXcFRD9OMYiiUO+eskw3p0S7ok
 ywYC/kpl8DuooHROmeMFF/BICC7HdaF6A8XE04h2WwTx7vIU6LlqjP546OFjPSsdB/Br
 M+EVb3cMTE4owPmB89Kocev4836Si8JSOtq4pdLh3rtOrTPXs9UujRnZ76mkZEt1Pevp
 1uY691J9UURjqEjY9MWqtx64lJa4wYN+gmmqFvA/aCARk1xKtoMDP8jdlT2NBm76r0Ky
 +/M7yb9QnWCGRA7vGfXUlMAMGX7YRpXn94+Eg7tPH1es8GyBuorHXyXBBxlVXzANFvJF
 wSNA==
X-Gm-Message-State: AOJu0YzHKlx3EkQlY9R1GAzEmziYXLCTLdArSQeS9HZhr5wHyeGEGoJU
 BVXYqJah8jTfmJItw6BrOF5ifao3kSUJwvBe9IcSMg4dfp53NYNZUseRJlwbY4pQ/0voZP6xYyU
 26Cbmk4q5JDMUY/5syiuiGxKWz3n1wpcsBvPJnP6X12nUPsp3zoNcH833eKOCv92EegikC/ojeE
 gNaNE4WWQuHtzQc5rpAF8Omd+XEzx4CNAmWujSJmo=
X-Gm-Gg: ASbGncuqxIsSGgU/mnzFSx1ms82UR/Wm/XAO7RwnbgrB73eNW/4AX7UdKMBq1VErigU
 HopUeIO/Urmp3KfaJJ5xBj/Q4R0HYAljbkEAYbnNEdFugjUiUaQbg5/Gqddx3rgcW3a9Sj6dWJ/
 N09FW/+StnFMil8XWudeYchbtsCaPycSwchvQ1Rio/6/QwzEFZ7Mn/8Fwbhe+5v4GK65uLpN5kL
 pA/rp2ae85/d9bR2qvv6qwxHM2a146+g36w0Es6mq5TUAElosoSN0qtmUWU6a4uh2X0D1nnspVD
 I5hHQVe6sfsAGgEuF7HnJo5lLA6K4l0rFthfqZOv89Q=
X-Received: by 2002:a05:600c:1908:b0:439:5016:3867 with SMTP id
 5b1f17b1804b1-439581be3bdmr72014095e9.23.1739457143869; 
 Thu, 13 Feb 2025 06:32:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+Q32rslomXhJ4sv6SHntRxewjmNgjJhYlDl1akb8WKRyrzdzdtQHr8PMWqxEMXyKsw6or6g==
X-Received: by 2002:a05:600c:1908:b0:439:5016:3867 with SMTP id
 5b1f17b1804b1-439581be3bdmr72013435e9.23.1739457143216; 
 Thu, 13 Feb 2025 06:32:23 -0800 (PST)
Received: from [192.168.126.123] (93-40-58-165.ip37.fastwebnet.it.
 [93.40.58.165]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439618a9421sm19199865e9.34.2025.02.13.06.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 06:32:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	kwolf@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH 2/2] rust: add module to convert between -errno and io::Error
Date: Thu, 13 Feb 2025 15:32:16 +0100
Message-ID: <20250213143216.3910163-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213143216.3910163-1-pbonzini@redhat.com>
References: <20250213143216.3910163-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It is a common convention in QEMU to return a positive value in case of
success, and a negated errno value in case of error.  Unfortunately,
using errno portably in Rust is a bit complicated; on Unix the errno
values are supported natively by io::Error, but on Windows they are not;
so, use the libc crate.

This is a set of utility functions that are used by both chardev and
block layer bindings.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/meson.build       |   4 +
 rust/qemu-api/src/assertions.rs |  28 +++
 rust/qemu-api/src/errno.rs      | 342 ++++++++++++++++++++++++++++++++
 rust/qemu-api/src/lib.rs        |   1 +
 rust/qemu-api/src/prelude.rs    |   2 +
 5 files changed, 377 insertions(+)
 create mode 100644 rust/qemu-api/src/errno.rs

diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 2e9c1078b9b..bcf1cf780f3 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -2,6 +2,8 @@ _qemu_api_cfg = run_command(rustc_args,
   '--config-headers', config_host_h, '--features', files('Cargo.toml'),
   capture: true, check: true).stdout().strip().splitlines()
 
+libc_dep = dependency('libc-0.2-rs')
+
 # _qemu_api_cfg += ['--cfg', 'feature="allocator"']
 if rustc.version().version_compare('>=1.77.0')
   _qemu_api_cfg += ['--cfg', 'has_offset_of']
@@ -22,6 +24,7 @@ _qemu_api_rs = static_library(
       'src/cell.rs',
       'src/chardev.rs',
       'src/c_str.rs',
+      'src/errno.rs',
       'src/irq.rs',
       'src/memory.rs',
       'src/module.rs',
@@ -39,6 +42,7 @@ _qemu_api_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
+  dependencies: libc_dep,
 )
 
 rust.test('rust-qemu-api-tests', _qemu_api_rs,
diff --git a/rust/qemu-api/src/assertions.rs b/rust/qemu-api/src/assertions.rs
index fa1a18de6fe..104dec39774 100644
--- a/rust/qemu-api/src/assertions.rs
+++ b/rust/qemu-api/src/assertions.rs
@@ -92,3 +92,31 @@ fn types_must_be_equal<T, U>(_: T)
         };
     };
 }
+
+/// Assert that an expression matches a pattern.  This can also be
+/// useful to compare enums that do not implement `Eq`.
+///
+/// # Examples
+///
+/// ```
+/// # use qemu_api::assert_match;
+/// // JoinHandle does not implement `Eq`, therefore the result
+/// // does not either.
+/// let result: Result<std::thread::JoinHandle<()>, u32> = Err(42);
+/// assert_match!(result, Err(42));
+/// ```
+#[macro_export]
+macro_rules! assert_match {
+    ($a:expr, $b:pat) => {
+        assert!(
+            match $a {
+                $b => true,
+                _ => false,
+            },
+            "{} = {:?} does not match {}",
+            stringify!($a),
+            $a,
+            stringify!($b)
+        );
+    };
+}
diff --git a/rust/qemu-api/src/errno.rs b/rust/qemu-api/src/errno.rs
new file mode 100644
index 00000000000..4ef7161a94a
--- /dev/null
+++ b/rust/qemu-api/src/errno.rs
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! Utility functions to convert `errno` to and from
+//! [`io::Error`]/[`io::Result`]
+//!
+//! QEMU C functions often have a "positive success/negative `errno`" calling
+//! convention.  This module provides functions to portably convert an integer
+//! into an [`io::Result`] and back.
+
+use std::{convert::TryFrom, io, io::ErrorKind};
+
+/// An `errno` value that can be converted into an [`io::Error`]
+pub struct Errno(pub u16);
+
+// On Unix, from_raw_os_error takes an errno value and OS errors
+// are printed using strerror.  On Windows however it takes a
+// GetLastError() value; therefore we need to convert errno values
+// into io::Error by hand.  This is the same mapping that the
+// standard library uses to retrieve the kind of OS errors
+// (`std::sys::pal::unix::decode_error_kind`).
+impl From<Errno> for ErrorKind {
+    fn from(value: Errno) -> ErrorKind {
+        let Errno(errno) = value;
+        match i32::from(errno) {
+            libc::EPERM | libc::EACCES => ErrorKind::PermissionDenied,
+            libc::ENOENT => ErrorKind::NotFound,
+            libc::EINTR => ErrorKind::Interrupted,
+            x if x == libc::EAGAIN || x == libc::EWOULDBLOCK => ErrorKind::WouldBlock,
+            libc::ENOMEM => ErrorKind::OutOfMemory,
+            libc::EEXIST => ErrorKind::AlreadyExists,
+            libc::EINVAL => ErrorKind::InvalidInput,
+            libc::EPIPE => ErrorKind::BrokenPipe,
+            libc::EADDRINUSE => ErrorKind::AddrInUse,
+            libc::EADDRNOTAVAIL => ErrorKind::AddrNotAvailable,
+            libc::ECONNABORTED => ErrorKind::ConnectionAborted,
+            libc::ECONNREFUSED => ErrorKind::ConnectionRefused,
+            libc::ECONNRESET => ErrorKind::ConnectionReset,
+            libc::ENOTCONN => ErrorKind::NotConnected,
+            libc::ENOTSUP => ErrorKind::Unsupported,
+            libc::ETIMEDOUT => ErrorKind::TimedOut,
+            _ => ErrorKind::Other,
+        }
+    }
+}
+
+// This is used on Windows for all io::Errors, but also on Unix if the
+// io::Error does not have a raw OS error.  This is the reversed
+// mapping of the above.
+impl From<io::ErrorKind> for Errno {
+    fn from(value: io::ErrorKind) -> Errno {
+        let errno = match value {
+            // can be both EPERM or EACCES :( pick one
+            ErrorKind::PermissionDenied => libc::EPERM,
+            ErrorKind::NotFound => libc::ENOENT,
+            ErrorKind::Interrupted => libc::EINTR,
+            ErrorKind::WouldBlock => libc::EAGAIN,
+            ErrorKind::OutOfMemory => libc::ENOMEM,
+            ErrorKind::AlreadyExists => libc::EEXIST,
+            ErrorKind::InvalidInput => libc::EINVAL,
+            ErrorKind::BrokenPipe => libc::EPIPE,
+            ErrorKind::AddrInUse => libc::EADDRINUSE,
+            ErrorKind::AddrNotAvailable => libc::EADDRNOTAVAIL,
+            ErrorKind::ConnectionAborted => libc::ECONNABORTED,
+            ErrorKind::ConnectionRefused => libc::ECONNREFUSED,
+            ErrorKind::ConnectionReset => libc::ECONNRESET,
+            ErrorKind::NotConnected => libc::ENOTCONN,
+            ErrorKind::Unsupported => libc::ENOTSUP,
+            ErrorKind::TimedOut => libc::ETIMEDOUT,
+            _ => libc::EIO,
+        };
+        Errno(errno as u16)
+    }
+}
+
+impl From<Errno> for io::Error {
+    #[cfg(unix)]
+    fn from(value: Errno) -> io::Error {
+        let Errno(errno) = value;
+        io::Error::from_raw_os_error(errno.into())
+    }
+
+    #[cfg(windows)]
+    fn from(value: Errno) -> io::Error {
+        let error_kind: ErrorKind = value.into();
+        error_kind.into()
+    }
+}
+
+impl From<io::Error> for Errno {
+    fn from(value: io::Error) -> Errno {
+        if cfg!(unix) {
+            if let Some(errno) = value.raw_os_error() {
+                return Errno(u16::try_from(errno).unwrap());
+            }
+        }
+        value.kind().into()
+    }
+}
+
+/// Internal traits; used to enable [`into_io_result`] and [`into_neg_errno`]
+/// for the "right" set of types.
+mod traits {
+    use super::Errno;
+
+    /// A signed type that can be converted into an [`io::Result`]
+    pub trait GetErrno {
+        /// Unsigned variant of `Self`, used as the type for the `Ok` case.
+        type Out;
+
+        /// Return `Ok(self)` if positive, `Err(Errno(-self))` if negative
+        fn into_errno_result(self) -> Result<Self::Out, Errno>;
+    }
+
+    /// A type that can be taken out of an [`io::Result`] and converted
+    /// into "positive success/negative `errno`" convention.
+    pub trait MergeErrno {
+        /// Signed variant of `Self`, used as the return type of
+        /// [`into_neg_errno`].
+        type Out: From<u16> + std::ops::Neg<Output = Self::Out>;
+
+        /// Return `self`, asserting that it is in range
+        fn map_ok(self) -> Self::Out;
+    }
+
+    macro_rules! get_errno {
+        ($t:ty, $out:ty) => {
+            impl GetErrno for $t {
+                type Out = $out;
+                fn into_errno_result(self) -> Result<Self::Out, Errno> {
+                    match self {
+                        0.. => Ok(self as $out),
+                        -65535..=-1 => Err(Errno(-self as u16)),
+                        _ => panic!("{self} is not a negative errno"),
+                    }
+                }
+            }
+        };
+    }
+
+    get_errno!(i32, u32);
+    get_errno!(i64, u64);
+    get_errno!(isize, usize);
+
+    macro_rules! merge_errno {
+        ($t:ty, $out:ty) => {
+            impl MergeErrno for $t {
+                type Out = $out;
+                fn map_ok(self) -> Self::Out {
+                    self.try_into().unwrap()
+                }
+            }
+        };
+    }
+
+    merge_errno!(u8, i32);
+    merge_errno!(u16, i32);
+    merge_errno!(u32, i32);
+    merge_errno!(u64, i64);
+
+    impl MergeErrno for () {
+        type Out = i32;
+        fn map_ok(self) -> i32 {
+            0
+        }
+    }
+}
+
+use traits::{GetErrno, MergeErrno};
+
+/// Convert an integer value into a [`io::Result`].
+///
+/// Positive values are turned into an `Ok` result; negative values
+/// are interpreted as negated `errno` and turned into an `Err`.
+///
+/// ```
+/// # use qemu_api::errno::into_io_result;
+/// # use std::io::ErrorKind;
+/// let ok = into_io_result(1i32).unwrap();
+/// assert_eq!(ok, 1u32);
+///
+/// let err = into_io_result(-1i32).unwrap_err(); // -EPERM
+/// assert_eq!(err.kind(), ErrorKind::PermissionDenied);
+/// ```
+///
+/// # Panics
+///
+/// Since the result is an unsigned integer, negative values must
+/// be close to 0; values that are too far away are considered
+/// likely overflows and will panic:
+///
+/// ```should_panic
+/// # use qemu_api::errno::into_io_result;
+/// # #[allow(dead_code)]
+/// let err = into_io_result(-0x1234_5678i32); // panic
+/// ```
+pub fn into_io_result<T: GetErrno>(value: T) -> io::Result<T::Out> {
+    value.into_errno_result().map_err(Into::into)
+}
+
+/// Convert a [`Result`] into an integer value, using negative `errno`
+/// values to report errors.
+///
+/// ```
+/// # use qemu_api::errno::into_neg_errno;
+/// # use std::io::{self, ErrorKind};
+/// let ok: io::Result<()> = Ok(());
+/// assert_eq!(into_neg_errno(ok), 0);
+///
+/// let err: io::Result<()> = Err(ErrorKind::InvalidInput.into());
+/// assert_eq!(into_neg_errno(err), -22); // -EINVAL
+/// ```
+///
+/// Since this module also provides the ability to convert [`io::Error`]
+/// to an `errno` value, [`io::Result`] is the most commonly used type
+/// for the argument of this function:
+///
+/// # Panics
+///
+/// Since the result is a signed integer, integer `Ok` values must remain
+/// positive:
+///
+/// ```should_panic
+/// # use qemu_api::errno::into_neg_errno;
+/// # use std::io;
+/// let err: io::Result<u32> = Ok(0x8899_AABB);
+/// into_neg_errno(err) // panic
+/// # ;
+/// ```
+pub fn into_neg_errno<T: MergeErrno, E: Into<Errno>>(value: Result<T, E>) -> T::Out {
+    match value {
+        Ok(x) => x.map_ok(),
+        Err(err) => -T::Out::from(err.into().0),
+    }
+}
+
+#[cfg(test)]
+mod tests {
+    use std::io::ErrorKind;
+
+    use super::*;
+    use crate::assert_match;
+
+    #[test]
+    pub fn test_from_u8() {
+        let ok: io::Result<_> = Ok(42u8);
+        assert_eq!(into_neg_errno(ok), 42);
+
+        let err: io::Result<u8> = Err(io::ErrorKind::PermissionDenied.into());
+        assert_eq!(into_neg_errno(err), -1);
+
+        if cfg!(unix) {
+            let os_err: io::Result<u8> = Err(io::Error::from_raw_os_error(10));
+            assert_eq!(into_neg_errno(os_err), -10);
+        }
+    }
+
+    #[test]
+    pub fn test_from_u16() {
+        let ok: io::Result<_> = Ok(1234u16);
+        assert_eq!(into_neg_errno(ok), 1234);
+
+        let err: io::Result<u16> = Err(io::ErrorKind::PermissionDenied.into());
+        assert_eq!(into_neg_errno(err), -1);
+
+        if cfg!(unix) {
+            let os_err: io::Result<u16> = Err(io::Error::from_raw_os_error(10));
+            assert_eq!(into_neg_errno(os_err), -10);
+        }
+    }
+
+    #[test]
+    pub fn test_i32() {
+        assert_match!(into_io_result(1234i32), Ok(1234));
+
+        let err = into_io_result(-1i32).unwrap_err();
+        #[cfg(unix)]
+        assert_match!(err.raw_os_error(), Some(1));
+        assert_match!(err.kind(), ErrorKind::PermissionDenied);
+    }
+
+    #[test]
+    pub fn test_from_u32() {
+        let ok: io::Result<_> = Ok(1234u32);
+        assert_eq!(into_neg_errno(ok), 1234);
+
+        let err: io::Result<u32> = Err(io::ErrorKind::PermissionDenied.into());
+        assert_eq!(into_neg_errno(err), -1);
+
+        if cfg!(unix) {
+            let os_err: io::Result<u32> = Err(io::Error::from_raw_os_error(10));
+            assert_eq!(into_neg_errno(os_err), -10);
+        }
+    }
+
+    #[test]
+    pub fn test_i64() {
+        assert_match!(into_io_result(1234i64), Ok(1234));
+
+        let err = into_io_result(-22i64).unwrap_err();
+        #[cfg(unix)]
+        assert_match!(err.raw_os_error(), Some(22));
+        assert_match!(err.kind(), ErrorKind::InvalidInput);
+    }
+
+    #[test]
+    pub fn test_from_u64() {
+        let ok: io::Result<_> = Ok(1234u64);
+        assert_eq!(into_neg_errno(ok), 1234);
+
+        let err: io::Result<u64> = Err(io::ErrorKind::InvalidInput.into());
+        assert_eq!(into_neg_errno(err), -22);
+
+        if cfg!(unix) {
+            let os_err: io::Result<u64> = Err(io::Error::from_raw_os_error(6));
+            assert_eq!(into_neg_errno(os_err), -6);
+        }
+    }
+
+    #[test]
+    pub fn test_isize() {
+        assert_match!(into_io_result(1234isize), Ok(1234));
+
+        let err = into_io_result(-4isize).unwrap_err();
+        #[cfg(unix)]
+        assert_match!(err.raw_os_error(), Some(4));
+        assert_match!(err.kind(), ErrorKind::Interrupted);
+    }
+
+    #[test]
+    pub fn test_from_unit() {
+        let ok: io::Result<_> = Ok(());
+        assert_eq!(into_neg_errno(ok), 0);
+
+        let err: io::Result<()> = Err(io::ErrorKind::OutOfMemory.into());
+        assert_eq!(into_neg_errno(err), -12);
+
+        if cfg!(unix) {
+            let os_err: io::Result<()> = Err(io::Error::from_raw_os_error(2));
+            assert_eq!(into_neg_errno(os_err), -2);
+        }
+    }
+}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index ed1a8f9a2b4..05f38b51d30 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -19,6 +19,7 @@
 pub mod callbacks;
 pub mod cell;
 pub mod chardev;
+pub mod errno;
 pub mod irq;
 pub mod memory;
 pub mod module;
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index fbf0ee23e0b..634acf37a85 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -9,6 +9,8 @@
 pub use crate::cell::BqlCell;
 pub use crate::cell::BqlRefCell;
 
+pub use crate::errno;
+
 pub use crate::qdev::DeviceMethods;
 
 pub use crate::qom::InterfaceType;
-- 
2.48.1


