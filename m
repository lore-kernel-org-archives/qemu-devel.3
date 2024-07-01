Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBA4C3065B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIUz-0003xR-31; Mon, 01 Jul 2024 10:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIUx-0003um-6n
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIUs-0005Ap-1G
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719845953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOb7lPpCZJz3JV8h1vR7Nm7ptbAZTCJyioTDRRfbz+U=;
 b=SG7YenCXIv9adhCTuAOznvomUhQFrV0nafvSnN+cDK8bOh3s6e9TXf3NjmmHxljDFHwnzR
 tBOXAv0s2kAZglxaBRYfFdoIYMafmrXwRAhm1O5ughcA7V/tSbyZgAMW/6Se8uk2VW5pCJ
 sWPxISPQQHJLgwxy8zDioo4YvDF1fdA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-kJmnEonkN86oPV_C0k4w2g-1; Mon, 01 Jul 2024 10:59:08 -0400
X-MC-Unique: kJmnEonkN86oPV_C0k4w2g-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4255f94080bso22338945e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 07:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719845946; x=1720450746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dOb7lPpCZJz3JV8h1vR7Nm7ptbAZTCJyioTDRRfbz+U=;
 b=A+O1uWXIzTMs6sp9yq8espKfcHn+Z77JQQd7BBpLti8akCjJiAZKQNvXa72Mb6kMIc
 Q/G3FI34UtwP/bTKpDo+opCB2p7LPCzJyBo1VhXmI9zUU+YJ9SobIqJVp6dv4R/dbkp4
 86Oyu17f44zySD0WqySgSCrRYTT/04mQeM2LInVGAEkXaMEOjtrZ4oOu7V99cTpUZ29C
 GKZbLsBAIMaX3yS9tJBptOHoITMesPvOmqzUh5VCWuzsqp1hj0S70+Zja8pIlCzcoDne
 KWWWGGXQsaGZWarzvqYC7Zaknfy181loisTSEWDh5CF4ZDdAUUag81hM/CncVkiHFMUC
 Pwmw==
X-Gm-Message-State: AOJu0YzNmJ4Y9uY0ZsmS43s8aTDT5PjSAlBK+m72Dc5bBErLFb9DjnPY
 eHx+Gxx0Hn5ukURtQLGkJE5hDCG7Ria9C0BzIyvWUj/PvqQOtZi/deQlRiGJK/uIY4WIbtpyHZw
 u2aor6N2WL84bliGHzLeQROXJs24okhw6MOjs/+ok5b7vQovsnjxXgXcfisY9K/2mzhtxuBlanC
 DsPkTMx0wTxS9JKTih9bS4AN/PUuvhotmPMHVU
X-Received: by 2002:a05:600c:3b09:b0:424:7bcf:2486 with SMTP id
 5b1f17b1804b1-4257a00aadamr34948445e9.4.1719845946398; 
 Mon, 01 Jul 2024 07:59:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxYzDZk7aajFO2Hj5/wZoBbox9nvdOZOlzMaYILjTLvsNdMm0i2/Axrh27hLn+vIFESdNz9g==
X-Received: by 2002:a05:600c:3b09:b0:424:7bcf:2486 with SMTP id
 5b1f17b1804b1-4257a00aadamr34948265e9.4.1719845945943; 
 Mon, 01 Jul 2024 07:59:05 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3cf90sm156221475e9.5.2024.07.01.07.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 07:59:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 03/14] rust: define traits and pointer wrappers to convert
 from/to C representations
Date: Mon,  1 Jul 2024 16:58:35 +0200
Message-ID: <20240701145853.1394967-4-pbonzini@redhat.com>
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

The qemu::util::foreign module provides:

- A trait for structs that can be converted to a C ("foreign") representation
  (CloneToForeign)

- A trait for structs that can be built from a C ("foreign") representation
  (FromForeign), and the utility IntoNative that can be used with less typing
  (similar to the standard library's From and Into pair)

- Automatic implementations of the above traits for Option<>, supporting NULL
  pointers

- A wrapper for a pointer that automatically frees the contained data.  If
  a struct XYZ implements CloneToForeign, you can build an OwnedPointer<XYZ>
  and it will free the contents automatically unless you retrieve it with
  owned_ptr.into_inner()

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu/src/lib.rs          |   6 +
 qemu/src/util/foreign.rs | 247 +++++++++++++++++++++++++++++++++++++++
 qemu/src/util/mod.rs     |   1 +
 3 files changed, 254 insertions(+)
 create mode 100644 qemu/src/util/foreign.rs
 create mode 100644 qemu/src/util/mod.rs

diff --git a/qemu/src/lib.rs b/qemu/src/lib.rs
index fce21d7..c48edcf 100644
--- a/qemu/src/lib.rs
+++ b/qemu/src/lib.rs
@@ -2,3 +2,9 @@
 #![allow(dead_code)]
 
 pub mod bindings;
+
+pub mod util;
+pub use util::foreign::CloneToForeign;
+pub use util::foreign::FromForeign;
+pub use util::foreign::IntoNative;
+pub use util::foreign::OwnedPointer;
diff --git a/qemu/src/util/foreign.rs b/qemu/src/util/foreign.rs
new file mode 100644
index 0000000..a591925
--- /dev/null
+++ b/qemu/src/util/foreign.rs
@@ -0,0 +1,247 @@
+// TODO: change to use .cast() etc.
+#![allow(clippy::ptr_as_ptr)]
+
+/// Traits to map between C structs and native Rust types.
+/// Similar to glib-rs but a bit simpler and possibly more
+/// idiomatic.
+use std::borrow::Cow;
+use std::fmt;
+use std::fmt::Debug;
+use std::mem;
+use std::ptr;
+
+/// A type for which there is a canonical representation as a C datum.
+pub trait CloneToForeign {
+    /// The representation of `Self` as a C datum.  Typically a
+    /// `struct`, though there are exceptions for example `c_char`
+    /// for strings, since C strings are of `char *` type).
+    type Foreign;
+
+    /// Free the C datum pointed to by `p`.
+    ///
+    /// # Safety
+    ///
+    /// `p` must be `NULL` or point to valid data.
+    unsafe fn free_foreign(p: *mut Self::Foreign);
+
+    /// Convert a native Rust object to a foreign C struct, copying
+    /// everything pointed to by `self` (same as `to_glib_full` in `glib-rs`)
+    fn clone_to_foreign(&self) -> OwnedPointer<Self>;
+
+    /// Convert a native Rust object to a foreign C pointer, copying
+    /// everything pointed to by `self`.  The returned pointer must
+    /// be freed with the `free_foreign` associated function.
+    fn clone_to_foreign_ptr(&self) -> *mut Self::Foreign {
+        self.clone_to_foreign().into_inner()
+    }
+}
+
+impl<T> CloneToForeign for Option<T>
+where
+    T: CloneToForeign,
+{
+    type Foreign = <T as CloneToForeign>::Foreign;
+
+    unsafe fn free_foreign(x: *mut Self::Foreign) {
+        T::free_foreign(x)
+    }
+
+    fn clone_to_foreign(&self) -> OwnedPointer<Self> {
+        // Same as the underlying implementation, but also convert `None`
+        // to a `NULL` pointer.
+        self.as_ref()
+            .map(CloneToForeign::clone_to_foreign)
+            .map(OwnedPointer::into)
+            .unwrap_or_default()
+    }
+}
+
+impl<T> FromForeign for Option<T>
+where
+    T: FromForeign,
+{
+    unsafe fn cloned_from_foreign(p: *const Self::Foreign) -> Self {
+        // Same as the underlying implementation, but also accept a `NULL` pointer.
+        if p.is_null() {
+            None
+        } else {
+            Some(T::cloned_from_foreign(p))
+        }
+    }
+}
+
+impl<T> CloneToForeign for Box<T>
+where
+    T: CloneToForeign,
+{
+    type Foreign = <T as CloneToForeign>::Foreign;
+
+    unsafe fn free_foreign(x: *mut Self::Foreign) {
+        T::free_foreign(x)
+    }
+
+    fn clone_to_foreign(&self) -> OwnedPointer<Self> {
+        self.as_ref().clone_to_foreign().into()
+    }
+}
+
+impl<T> FromForeign for Box<T>
+where
+    T: FromForeign,
+{
+    unsafe fn cloned_from_foreign(p: *const Self::Foreign) -> Self {
+        Box::new(T::cloned_from_foreign(p))
+    }
+}
+
+impl<'a, B> CloneToForeign for Cow<'a, B>
+    where B: 'a + ToOwned + ?Sized + CloneToForeign,
+{
+    type Foreign = B::Foreign;
+
+    unsafe fn free_foreign(ptr: *mut B::Foreign) {
+        B::free_foreign(ptr);
+    }
+
+    fn clone_to_foreign(&self) -> OwnedPointer<Self> {
+        self.as_ref().clone_to_foreign().into()
+    }
+}
+
+/// Convert a C datum into a native Rust object, taking ownership of
+/// the C datum.  You should not need to implement this trait
+/// as long as Rust types implement `FromForeign`.
+pub trait IntoNative<T> {
+    /// Convert a C datum to a native Rust object, taking ownership of
+    /// the pointer or Rust object (same as `from_glib_full` in `glib-rs`)
+    ///
+    /// # Safety
+    ///
+    /// `p` must point to valid data, or can be `NULL` if Self is an
+    /// `Option` type.  It becomes invalid after the function returns.
+    unsafe fn into_native(self) -> T;
+}
+
+impl<T, U> IntoNative<U> for *mut T
+where
+    U: FromForeign<Foreign = T>,
+{
+    unsafe fn into_native(self) -> U {
+        U::from_foreign(self)
+    }
+}
+
+/// A type which can be constructed from a canonical representation as a
+/// C datum.
+pub trait FromForeign: CloneToForeign + Sized {
+    /// Convert a C datum to a native Rust object, copying everything
+    /// pointed to by `p` (same as `from_glib_none` in `glib-rs`)
+    ///
+    /// # Safety
+    ///
+    /// `p` must point to valid data, or can be `NULL` is `Self` is an
+    /// `Option` type.
+    unsafe fn cloned_from_foreign(p: *const Self::Foreign) -> Self;
+
+    /// Convert a C datum to a native Rust object, taking ownership of
+    /// the pointer or Rust object (same as `from_glib_full` in `glib-rs`)
+    ///
+    /// The default implementation calls `cloned_from_foreign` and frees `p`.
+    ///
+    /// # Safety
+    ///
+    /// `p` must point to valid data, or can be `NULL` is `Self` is an
+    /// `Option` type.  `p` becomes invalid after the function returns.
+    unsafe fn from_foreign(p: *mut Self::Foreign) -> Self {
+        let result = Self::cloned_from_foreign(p);
+        Self::free_foreign(p);
+        result
+    }
+}
+
+pub struct OwnedPointer<T: CloneToForeign + ?Sized> {
+    ptr: *mut <T as CloneToForeign>::Foreign,
+}
+
+impl<T: CloneToForeign + ?Sized> OwnedPointer<T> {
+    /// Return a new `OwnedPointer` that wraps the pointer `ptr`.
+    ///
+    /// # Safety
+    ///
+    /// The pointer must be valid and live until the returned `OwnedPointer`
+    /// is dropped.
+    pub unsafe fn new(ptr: *mut <T as CloneToForeign>::Foreign) -> Self {
+        OwnedPointer { ptr }
+    }
+
+    /// Safely create an `OwnedPointer` from one that has the same
+    /// freeing function.
+    pub fn from<U>(x: OwnedPointer<U>) -> Self
+    where
+        U: CloneToForeign<Foreign = <T as CloneToForeign>::Foreign> + ?Sized,
+    {
+        unsafe {
+            // SAFETY: the pointer type and free function are the same,
+            // only the type changes
+            OwnedPointer::new(x.into_inner())
+        }
+    }
+
+    /// Safely convert an `OwnedPointer` into one that has the same
+    /// freeing function.
+    pub fn into<U>(self) -> OwnedPointer<U>
+    where
+        U: CloneToForeign<Foreign = <T as CloneToForeign>::Foreign>,
+    {
+        OwnedPointer::from(self)
+    }
+
+    /// Return the pointer that is stored in the `OwnedPointer`.  The
+    /// pointer is valid for as long as the `OwnedPointer` itself.
+    pub fn as_ptr(&self) -> *const <T as CloneToForeign>::Foreign {
+        self.ptr
+    }
+
+    pub fn as_mut_ptr(&self) -> *mut <T as CloneToForeign>::Foreign {
+        self.ptr
+    }
+
+    /// Return the pointer that is stored in the `OwnedPointer`,
+    /// consuming the `OwnedPointer` but not freeing the pointer.
+    pub fn into_inner(mut self) -> *mut <T as CloneToForeign>::Foreign {
+        let result = mem::replace(&mut self.ptr, ptr::null_mut());
+        mem::forget(self);
+        result
+    }
+}
+
+impl<T: FromForeign + ?Sized> OwnedPointer<T> {
+    /// Convert a C datum to a native Rust object, taking ownership of
+    /// the pointer or Rust object (same as `from_glib_full` in `glib-rs`)
+    pub fn into_native(self) -> T {
+        // SAFETY: the pointer was passed to the unsafe constructor OwnedPointer::new
+        unsafe { T::from_foreign(self.into_inner()) }
+    }
+}
+
+impl<T: CloneToForeign + ?Sized> Debug for OwnedPointer<T> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        let name = std::any::type_name::<T>();
+        let name = format!("OwnedPointer<{}>", name);
+        f.debug_tuple(&name).field(&self.as_ptr()).finish()
+    }
+}
+
+impl<T: CloneToForeign + Default + ?Sized> Default for OwnedPointer<T> {
+    fn default() -> Self {
+        <T as Default>::default().clone_to_foreign()
+    }
+}
+
+impl<T: CloneToForeign + ?Sized> Drop for OwnedPointer<T> {
+    fn drop(&mut self) {
+        let p = mem::replace(&mut self.ptr, ptr::null_mut());
+        // SAFETY: the pointer was passed to the unsafe constructor OwnedPointer::new
+        unsafe { T::free_foreign(p) }
+    }
+}
diff --git a/qemu/src/util/mod.rs b/qemu/src/util/mod.rs
new file mode 100644
index 0000000..be00d0c
--- /dev/null
+++ b/qemu/src/util/mod.rs
@@ -0,0 +1 @@
+pub mod foreign;
-- 
2.45.2


