Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AF3C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIUy-0003wD-5a; Mon, 01 Jul 2024 10:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIUw-0003t3-FQ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIUt-0005Ea-Tw
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719845955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZZE6DVkDuQcxnlYAIOtl14LqCPg3/XUa+gT7zaaHeP4=;
 b=gs75Wxy7fnFHMJJlWyGhIUQOnbBC4+t6ZX8k6wTEnlZVLkKvo/fiz+/hAQeF14qm8YdCTo
 wvcbihFGCxGPgTdeGSwHCB26GarE3Yo4QT55kmnSg1SO7Pjo/i5MkVSLyu+0X+cpwyIx/4
 uqC+/j1Rv0Kq9+Xpdx0I7RAYl7XQm70=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-5Z3Vlh5VNW20Q9C7n4Jwvw-1; Mon, 01 Jul 2024 10:59:13 -0400
X-MC-Unique: 5Z3Vlh5VNW20Q9C7n4Jwvw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42490ae735dso29810615e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 07:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719845952; x=1720450752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZZE6DVkDuQcxnlYAIOtl14LqCPg3/XUa+gT7zaaHeP4=;
 b=PNqmJ45qGwe4k6XvIyytHTOXif0Mgj/4WJTeHk9l3gFf7AO4BgyQWgzdL/OFAKxOKi
 F20LNxMfPC2GOJoaKL0VTou/Uah/p4iysMXhoLi3pkcv9MBSD8I0ytBR4RQBGyWohDWA
 qpWBw6F/8tszFi1sPLS3nvh44f8qRAcos2VHS6cWyMSE7k1Xh6kx9FotjrJAucvqjXS0
 d6Te7v5TB106AVzNgrJRsTXSDibu/5g1Exal6zJcmPnYuNUpMZY9HHehiEeFvF3N9QZg
 ZnG9AlrNCf7iDBPseGICCOZl1VwtsUULFOysPpwisGD5rwctAakDCn5gHyXrAj9z6jP2
 ZxNA==
X-Gm-Message-State: AOJu0YxIZZdkRaNlahaoAVCHhIlISAyPJy70s836jIGz8w3ziQINb54D
 EwvpjPQfDAkqRfeNWfaof/Vs0VN49CT1TZFpICOb/Z65Z/3LgTCHoTKARm441zckPbhy2tEBxkR
 5iPJkxPJ5RRPaIgC7ipOgms6RZEqxW1fGOye63YPIo3a4I5hhsbYbGGmEpLUHH9NWaoi1+PKTks
 IbC9T22pvxYqgfoeZ6g/+R6Bgn4MC6sxC+rGCj
X-Received: by 2002:a05:600c:5129:b0:425:63b9:ae2c with SMTP id
 5b1f17b1804b1-4257a02008fmr51352905e9.27.1719845951773; 
 Mon, 01 Jul 2024 07:59:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyfqBCnafqIIFZ+4imKiXRlHo8ocrMrnhO9bcec/S2pttQQ3WOh4sF1xTFfPsNuQ4Dn/Nldw==
X-Received: by 2002:a05:600c:5129:b0:425:63b9:ae2c with SMTP id
 5b1f17b1804b1-4257a02008fmr51352685e9.27.1719845951384; 
 Mon, 01 Jul 2024 07:59:11 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42577a0c286sm76291075e9.0.2024.07.01.07.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 07:59:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 05/14] rust: define wrappers for Error
Date: Mon,  1 Jul 2024 16:58:37 +0200
Message-ID: <20240701145853.1394967-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701145853.1394967-1-pbonzini@redhat.com>
References: <20240701145853.1394967-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The wrappers for Error provide the following functionality:

- a struct that implements std::error::Error and can be filled with
  information similar to what would go into a C Error* (location, message).

- functionality similar to error_prepend() via the "cause()"
  member of std::error::Error.

- converting a Result<> into a value that can be returned to C,
  filling in an Error** (like error_propagate() would do) if the
  Result<> contains an error; useful for callbacks written in Rust

- converting a C Error* into a Result that can be returned to Rust,
  useful for Rust wrappers of C functions

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu/src/lib.rs        |   2 +
 qemu/src/util/error.rs | 241 +++++++++++++++++++++++++++++++++++++++++
 qemu/src/util/mod.rs   |   1 +
 3 files changed, 244 insertions(+)
 create mode 100644 qemu/src/util/error.rs

diff --git a/qemu/src/lib.rs b/qemu/src/lib.rs
index c48edcf..5f926b8 100644
--- a/qemu/src/lib.rs
+++ b/qemu/src/lib.rs
@@ -4,7 +4,9 @@
 pub mod bindings;
 
 pub mod util;
+pub use util::error::Error;
 pub use util::foreign::CloneToForeign;
 pub use util::foreign::FromForeign;
 pub use util::foreign::IntoNative;
 pub use util::foreign::OwnedPointer;
+pub type Result<T> = std::result::Result<T, Error>;
diff --git a/qemu/src/util/error.rs b/qemu/src/util/error.rs
new file mode 100644
index 0000000..e7e6f2e
--- /dev/null
+++ b/qemu/src/util/error.rs
@@ -0,0 +1,241 @@
+//! Error class for QEMU Rust code
+//!
+//! @author Paolo Bonzini
+
+use crate::bindings;
+use crate::bindings::error_free;
+use crate::bindings::error_get_pretty;
+use crate::bindings::error_setg_internal;
+
+use std::ffi::CStr;
+use std::fmt::{self, Display};
+use std::ptr;
+
+use crate::util::foreign::{CloneToForeign, FromForeign, OwnedPointer};
+
+#[derive(Debug, Default)]
+pub struct Error {
+    msg: Option<String>,
+    /// Appends the print string of the error to the msg if not None
+    cause: Option<Box<dyn std::error::Error>>,
+    location: Option<(String, u32)>,
+}
+
+impl std::error::Error for Error {
+    fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {
+        self.cause.as_deref()
+    }
+
+    #[allow(deprecated)]
+    fn description(&self) -> &str {
+        self.msg
+            .as_deref()
+            .or_else(|| self.cause.as_deref().map(std::error::Error::description))
+            .unwrap_or("error")
+    }
+}
+
+impl Display for Error {
+    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
+        let mut prefix = "";
+        if let Some((ref file, line)) = self.location {
+            write!(f, "{}:{}", file, line)?;
+            prefix = ": ";
+        }
+        if let Some(ref msg) = self.msg {
+            write!(f, "{}{}", prefix, msg)?;
+            prefix = ": ";
+        }
+        if let Some(ref cause) = self.cause {
+            write!(f, "{}{}", prefix, cause)?;
+        } else if prefix.is_empty() {
+            f.write_str("unknown error")?;
+        }
+        Ok(())
+    }
+}
+
+impl From<&str> for Error {
+    fn from(msg: &str) -> Self {
+        Error {
+            msg: Some(String::from(msg)),
+            cause: None,
+            location: None,
+        }
+    }
+}
+
+impl From<std::io::Error> for Error {
+    fn from(error: std::io::Error) -> Self {
+        Error {
+            msg: None,
+            cause: Some(Box::new(error)),
+            location: None,
+        }
+    }
+}
+
+impl Error {
+    /// Create a new error, prepending `msg` to the
+    /// description of `cause`
+    pub fn with_error<E: std::error::Error + 'static>(msg: &str, cause: E) -> Self {
+        Error {
+            msg: Some(String::from(msg)),
+            cause: Some(Box::new(cause)),
+            location: None,
+        }
+    }
+
+    /// Create a new error, prepending `file:line: msg` to the
+    /// description of `cause`
+    pub fn with_error_file_line<E: std::error::Error + 'static>(
+        msg: &str,
+        cause: E,
+        file: &str,
+        line: u32,
+    ) -> Self {
+        Error {
+            msg: Some(String::from(msg)),
+            cause: Some(Box::new(cause)),
+            location: Some((String::from(file), line)),
+        }
+    }
+
+    /// Create a new error with format `file:line: msg`
+    pub fn with_file_line(msg: &str, file: &str, line: u32) -> Self {
+        Error {
+            msg: Some(String::from(msg)),
+            cause: None,
+            location: Some((String::from(file), line)),
+        }
+    }
+
+    /// Consume a result, returning false if it is an error and
+    /// true if it is successful.  The error is propagated into
+    /// `errp` like the C API `error_propagate` would do.
+    ///
+    /// # Safety
+    ///
+    /// `errp` must be valid; typically it is received from C code
+    pub unsafe fn bool_or_propagate<T>(
+        result: Result<(), Self>,
+        errp: *mut *mut bindings::Error,
+    ) -> bool {
+        Self::ok_or_propagate(result, errp).is_some()
+    }
+
+    /// Consume a result, returning a `NULL` pointer if it is an
+    /// error and a C representation of the contents if it is
+    /// successful.  The error is propagated into `errp` like
+    /// the C API `error_propagate` would do.
+    ///
+    /// # Safety
+    ///
+    /// `errp` must be valid; typically it is received from C code
+    pub unsafe fn ptr_or_propagate<T: CloneToForeign>(
+        result: Result<T, Self>,
+        errp: *mut *mut bindings::Error,
+    ) -> *mut T::Foreign {
+        Self::ok_or_propagate(result, errp).map_or(ptr::null_mut(), |ref x| {
+            CloneToForeign::clone_to_foreign_ptr(x)
+        })
+    }
+
+    /// Consume a result and return `self.ok()`, but also propagate a
+    /// possible error into `errp`, like the C API `error_propagate`
+    /// would do.
+    ///
+    /// # Safety
+    ///
+    /// `errp` must be valid; typically it is received from C code
+    pub unsafe fn ok_or_propagate<T>(
+        result: Result<T, Self>,
+        errp: *mut *mut bindings::Error,
+    ) -> Option<T> {
+        match result {
+            Ok(ok) => Some(ok),
+            Err(err) => {
+                err.propagate(errp);
+                None
+            }
+        }
+    }
+
+    /// Equivalent of the C function `error_propagate`.  Fill `*errp`
+    /// with the information container in `self` if `errp` is not NULL;
+    /// then consume it.
+    ///
+    /// # Safety
+    ///
+    /// `errp` must be valid; typically it is received from C code
+    pub unsafe fn propagate(self, errp: *mut *mut bindings::Error) {
+        if errp.is_null() {
+            return;
+        }
+        errp.write(self.clone_to_foreign_ptr());
+    }
+
+    /// Convert a C `Error*` into a Rust `Result`, using `Ok(Default::default())`
+    /// if `c_error` is NULL.
+    ///
+    /// # Safety
+    ///
+    /// `c_error` must be valid; typically it has been filled by a C
+    /// function.
+    pub unsafe fn err_or_default<T: Default>(c_error: *mut bindings::Error) -> Result<T, Self> {
+        Self::err_or_else(c_error, Default::default)
+    }
+
+    /// Convert a C `Error*` into a Rust `Result`, calling `f()` to
+    /// obtain an `Ok` value if `c_error` is NULL.
+    ///
+    /// # Safety
+    ///
+    /// `c_error` must be valid; typically it has been filled by a C
+    /// function.
+    pub unsafe fn err_or_else<T, F: FnOnce() -> T>(
+        c_error: *mut bindings::Error,
+        f: F,
+    ) -> Result<T, Self> {
+        match Option::<Self>::from_foreign(c_error) {
+            None => Ok(f()),
+            Some(err) => Err(err),
+        }
+    }
+}
+
+impl CloneToForeign for Error {
+    type Foreign = bindings::Error;
+
+    fn clone_to_foreign(&self) -> OwnedPointer<Self> {
+        let mut x: *mut bindings::Error = ptr::null_mut();
+        unsafe {
+            error_setg_internal(
+                &mut x,
+                ptr::null_mut(), // FIXME
+                0,
+                ptr::null_mut(), // FIXME
+                c"%s".as_ptr(),
+                format!("{}", self),
+            );
+            OwnedPointer::new(x)
+        }
+    }
+
+    unsafe fn free_foreign(p: *mut bindings::Error) {
+        unsafe {
+            error_free(p);
+        }
+    }
+}
+
+impl FromForeign for Error {
+    unsafe fn cloned_from_foreign(c_error: *const bindings::Error) -> Self {
+        let c_str = unsafe { CStr::from_ptr(error_get_pretty(c_error)) };
+        Error {
+            msg: Some(c_str.to_string_lossy().into_owned()),
+            cause: None,
+            location: None,
+        }
+    }
+}
diff --git a/qemu/src/util/mod.rs b/qemu/src/util/mod.rs
index be00d0c..e6078ac 100644
--- a/qemu/src/util/mod.rs
+++ b/qemu/src/util/mod.rs
@@ -1 +1,2 @@
+pub mod error;
 pub mod foreign;
-- 
2.45.2


