Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D9EC3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIUx-0003up-PT; Mon, 01 Jul 2024 10:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIUv-0003p3-3E
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIUs-0005Ah-0X
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719845952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4FB4lTjJ2jdkYkhNKjtSbR2CEvqDwGBPr2HOuzmXi+Q=;
 b=Cu4ubbs9phv437Vxcn/SDP9+iXVsa+mAKkB61RJSNR7pvkGSY7ZbzGH3wR9gteGo5tv5y4
 Sonc0cu2C4y78Yh90nqblul6yDJOkvwOSWjtW3mB4iJYf49qw0al4C+WdCM8VsbyDmfZ8m
 97YHv0uLg1xmBMnfZ1r9+7NlDzdYyEQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-WgpDa7wbNZ61bhssyeVNAg-1; Mon, 01 Jul 2024 10:59:11 -0400
X-MC-Unique: WgpDa7wbNZ61bhssyeVNAg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-363edcf12a3so2052780f8f.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 07:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719845949; x=1720450749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4FB4lTjJ2jdkYkhNKjtSbR2CEvqDwGBPr2HOuzmXi+Q=;
 b=OVoPFI6z4C+XrJ1LQm4dAMMz6CqDZub87m426OphPmBJV3eH9L8F1CIWTT2CoxvYLZ
 k6MckvvBDWlbaDZkrpnuWw+9X9m8X24l7Wp9hZo6BvEJ1Vr4f/OViVUMk0kD+/H++F7j
 qwVQwAh2e79cZLdxV+NNbQQUVr1lN3nFN/oNl0e6nfnw69+lZ7EW9Vvtqzx7+6SWsLSI
 mG9OTvaR3ZVngVPG+UUx+rjAP+1VkgJtxskYzsBmp0KdmKoABz+KqGF9P11liZ+I+Jd9
 COKSYrzZtETovDfYyXwopT+NkY+Hru1zcHhEe1rFqZ4TIEkdot12J+CcvwjWjHyR+Bym
 Skow==
X-Gm-Message-State: AOJu0YyEZMcnLulSfBoMkimj2YuqbxL/NgkdYRXPuAt1fbMGnenKKFmY
 LighrUIADIQpRn9RBKxTf9TtqC84g7WNKmbRAkCC8FEqX66RNs0SbqJissYsvVfCQFPMhEN6It/
 AWKB7WYraR42eVLLDyFqWVoqdBQ/RmBnXiGMM2f63vRyoViYxb+0OyhKDvXBUN17mHG+VF+B6Rr
 S9Vp9GOucQTmpDTNl3s2MfcoJHUu4LK38PdevI
X-Received: by 2002:a05:6000:1447:b0:367:4dbb:ed4e with SMTP id
 ffacd0b85a97d-3677561da1bmr4170415f8f.0.1719845949201; 
 Mon, 01 Jul 2024 07:59:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEma+4/l+Pn62ItPvedLeZpIOdZx7y2TYZTPNuebsrDVIm7QiIfX7fwQ3nyIkvoKCnsvAYgew==
X-Received: by 2002:a05:6000:1447:b0:367:4dbb:ed4e with SMTP id
 ffacd0b85a97d-3677561da1bmr4170391f8f.0.1719845948723; 
 Mon, 01 Jul 2024 07:59:08 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fba5asm10250857f8f.71.2024.07.01.07.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 07:59:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 04/14] rust: add tests for util::foreign
Date: Mon,  1 Jul 2024 16:58:36 +0200
Message-ID: <20240701145853.1394967-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701145853.1394967-1-pbonzini@redhat.com>
References: <20240701145853.1394967-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Provide sample implementations in util::foreign for strings and
elementary integer types, and use them to test the code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu/Cargo.toml          |   4 +
 qemu/src/util/foreign.rs | 456 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 474 insertions(+)

diff --git a/qemu/Cargo.toml b/qemu/Cargo.toml
index 18d0fa4..1100725 100644
--- a/qemu/Cargo.toml
+++ b/qemu/Cargo.toml
@@ -5,3 +5,7 @@ edition = "2021"
 
 [dependencies]
 const-default = { version = "~1", features = ["derive"] }
+libc = "^0"
+
+[dev-dependencies]
+matches = ">=0"
diff --git a/qemu/src/util/foreign.rs b/qemu/src/util/foreign.rs
index a591925..0b8b708 100644
--- a/qemu/src/util/foreign.rs
+++ b/qemu/src/util/foreign.rs
@@ -5,6 +5,7 @@
 /// Similar to glib-rs but a bit simpler and possibly more
 /// idiomatic.
 use std::borrow::Cow;
+use std::ffi::{c_char, c_void, CStr, CString};
 use std::fmt;
 use std::fmt::Debug;
 use std::mem;
@@ -22,6 +23,14 @@ pub trait CloneToForeign {
     /// # Safety
     ///
     /// `p` must be `NULL` or point to valid data.
+    ///
+    /// ```
+    /// # use qemu::CloneToForeign;
+    /// let foreign = "Hello, world!".clone_to_foreign();
+    /// unsafe {
+    ///     String::free_foreign(foreign.into_inner());
+    /// }
+    /// ```
     unsafe fn free_foreign(p: *mut Self::Foreign);
 
     /// Convert a native Rust object to a foreign C struct, copying
@@ -119,6 +128,17 @@ pub trait IntoNative<T> {
     ///
     /// `p` must point to valid data, or can be `NULL` if Self is an
     /// `Option` type.  It becomes invalid after the function returns.
+    ///
+    /// ```
+    /// # use qemu::{CloneToForeign, IntoNative};
+    /// let s = "Hello, world!".to_string();
+    /// let foreign = s.clone_to_foreign();
+    /// let native: String = unsafe {
+    ///     foreign.into_native()
+    ///     // foreign is not leaked
+    /// };
+    /// assert_eq!(s, native);
+    /// ```
     unsafe fn into_native(self) -> T;
 }
 
@@ -141,6 +161,15 @@ pub trait FromForeign: CloneToForeign + Sized {
     ///
     /// `p` must point to valid data, or can be `NULL` is `Self` is an
     /// `Option` type.
+    ///
+    /// ```
+    /// # use qemu::FromForeign;
+    /// let p = c"Hello, world!".as_ptr();
+    /// let s = unsafe {
+    ///     String::cloned_from_foreign(p as *const std::ffi::c_char)
+    /// };
+    /// assert_eq!(s, "Hello, world!");
+    /// ```
     unsafe fn cloned_from_foreign(p: *const Self::Foreign) -> Self;
 
     /// Convert a C datum to a native Rust object, taking ownership of
@@ -152,6 +181,16 @@ pub trait FromForeign: CloneToForeign + Sized {
     ///
     /// `p` must point to valid data, or can be `NULL` is `Self` is an
     /// `Option` type.  `p` becomes invalid after the function returns.
+    ///
+    /// ```
+    /// # use qemu::{CloneToForeign, FromForeign};
+    /// let s = "Hello, world!";
+    /// let foreign = s.clone_to_foreign();
+    /// unsafe {
+    ///     assert_eq!(String::from_foreign(foreign.into_inner()), s);
+    /// }
+    /// // foreign is not leaked
+    /// ```
     unsafe fn from_foreign(p: *mut Self::Foreign) -> Self {
         let result = Self::cloned_from_foreign(p);
         Self::free_foreign(p);
@@ -176,6 +215,12 @@ impl<T: CloneToForeign + ?Sized> OwnedPointer<T> {
 
     /// Safely create an `OwnedPointer` from one that has the same
     /// freeing function.
+    /// ```
+    /// # use qemu::{CloneToForeign, OwnedPointer};
+    /// let s = "Hello, world!";
+    /// let foreign_str = s.clone_to_foreign();
+    /// let foreign_string = OwnedPointer::<String>::from(foreign_str);
+    /// # assert_eq!(foreign_string.into_native(), s);
     pub fn from<U>(x: OwnedPointer<U>) -> Self
     where
         U: CloneToForeign<Foreign = <T as CloneToForeign>::Foreign> + ?Sized,
@@ -189,6 +234,12 @@ impl<T: CloneToForeign + ?Sized> OwnedPointer<T> {
 
     /// Safely convert an `OwnedPointer` into one that has the same
     /// freeing function.
+    /// ```
+    /// # use qemu::{CloneToForeign, OwnedPointer};
+    /// let s = "Hello, world!";
+    /// let foreign_str = s.clone_to_foreign();
+    /// let foreign_string: OwnedPointer<String> = foreign_str.into();
+    /// # assert_eq!(foreign_string.into_native(), s);
     pub fn into<U>(self) -> OwnedPointer<U>
     where
         U: CloneToForeign<Foreign = <T as CloneToForeign>::Foreign>,
@@ -198,6 +249,16 @@ impl<T: CloneToForeign + ?Sized> OwnedPointer<T> {
 
     /// Return the pointer that is stored in the `OwnedPointer`.  The
     /// pointer is valid for as long as the `OwnedPointer` itself.
+    ///
+    /// ```
+    /// # use qemu::CloneToForeign;
+    /// let s = "Hello, world!";
+    /// let foreign = s.clone_to_foreign();
+    /// let p = foreign.as_ptr();
+    /// let len = unsafe { libc::strlen(p) };
+    /// drop(foreign);
+    /// # assert_eq!(len, 13);
+    /// ```
     pub fn as_ptr(&self) -> *const <T as CloneToForeign>::Foreign {
         self.ptr
     }
@@ -208,6 +269,15 @@ impl<T: CloneToForeign + ?Sized> OwnedPointer<T> {
 
     /// Return the pointer that is stored in the `OwnedPointer`,
     /// consuming the `OwnedPointer` but not freeing the pointer.
+    ///
+    /// ```
+    /// # use qemu::CloneToForeign;
+    /// let s = "Hello, world!";
+    /// let p = s.clone_to_foreign().into_inner();
+    /// let len = unsafe { libc::strlen(p) };
+    /// // p needs to be freed manually
+    /// # assert_eq!(len, 13);
+    /// ```
     pub fn into_inner(mut self) -> *mut <T as CloneToForeign>::Foreign {
         let result = mem::replace(&mut self.ptr, ptr::null_mut());
         mem::forget(self);
@@ -218,6 +288,17 @@ impl<T: CloneToForeign + ?Sized> OwnedPointer<T> {
 impl<T: FromForeign + ?Sized> OwnedPointer<T> {
     /// Convert a C datum to a native Rust object, taking ownership of
     /// the pointer or Rust object (same as `from_glib_full` in `glib-rs`)
+    ///
+    /// ```
+    /// # use qemu::{CloneToForeign, IntoNative};
+    /// let s = "Hello, world!".to_string();
+    /// let foreign = s.clone_to_foreign();
+    /// let native: String = unsafe {
+    ///     foreign.into_native()
+    ///     // foreign is not leaked
+    /// };
+    /// assert_eq!(s, native);
+    /// ```
     pub fn into_native(self) -> T {
         // SAFETY: the pointer was passed to the unsafe constructor OwnedPointer::new
         unsafe { T::from_foreign(self.into_inner()) }
@@ -245,3 +326,378 @@ impl<T: CloneToForeign + ?Sized> Drop for OwnedPointer<T> {
         unsafe { T::free_foreign(p) }
     }
 }
+
+impl CloneToForeign for str {
+    type Foreign = c_char;
+
+    unsafe fn free_foreign(ptr: *mut c_char) {
+        libc::free(ptr as *mut c_void);
+    }
+
+    fn clone_to_foreign(&self) -> OwnedPointer<Self> {
+        // SAFETY: self.as_ptr() is guaranteed to point to self.len() bytes;
+        // the destination is freshly allocated
+        unsafe {
+            let p = libc::malloc(self.len() + 1) as *mut c_char;
+            ptr::copy_nonoverlapping(self.as_ptr() as *const c_char, p, self.len());
+            *p.add(self.len()) = 0;
+            OwnedPointer::new(p)
+        }
+    }
+}
+
+impl CloneToForeign for CStr {
+    type Foreign = c_char;
+
+    unsafe fn free_foreign(ptr: *mut c_char) {
+        libc::free(ptr as *mut c_void);
+    }
+
+    fn clone_to_foreign(&self) -> OwnedPointer<Self> {
+        // SAFETY: self.as_ptr() is guaranteed to point to self.len() bytes;
+        // the destination is freshly allocated
+        unsafe {
+            let slice = self.to_bytes_with_nul();
+            let p = libc::malloc(slice.len()) as *mut c_char;
+            ptr::copy_nonoverlapping(self.as_ptr() as *const c_char, p, slice.len());
+            OwnedPointer::new(p)
+        }
+    }
+}
+
+impl CloneToForeign for String {
+    type Foreign = c_char;
+
+    unsafe fn free_foreign(ptr: *mut c_char) {
+        libc::free(ptr as *mut c_void);
+    }
+
+    fn clone_to_foreign(&self) -> OwnedPointer<Self> {
+        self.as_str().clone_to_foreign().into()
+    }
+}
+
+impl FromForeign for String {
+    unsafe fn cloned_from_foreign(p: *const c_char) -> Self {
+        let cstr = CStr::from_ptr(p);
+        String::from_utf8_lossy(cstr.to_bytes()).into_owned()
+    }
+}
+
+impl CloneToForeign for CString {
+    type Foreign = c_char;
+
+    unsafe fn free_foreign(ptr: *mut c_char) {
+        libc::free(ptr as *mut c_void);
+    }
+
+    fn clone_to_foreign(&self) -> OwnedPointer<Self> {
+        self.as_c_str().clone_to_foreign().into()
+    }
+}
+
+impl FromForeign for CString {
+    unsafe fn cloned_from_foreign(p: *const c_char) -> Self {
+        CStr::from_ptr(p).to_owned()
+    }
+}
+
+impl FromForeign for Cow<'_, str>
+{
+    unsafe fn cloned_from_foreign(p: *const c_char) -> Self {
+        let cstr = CStr::from_ptr(p);
+        cstr.to_string_lossy()
+    }
+}
+
+macro_rules! foreign_copy_type {
+    ($rust_type:ty, $foreign_type:ty) => {
+        impl CloneToForeign for $rust_type {
+            type Foreign = $foreign_type;
+
+            unsafe fn free_foreign(ptr: *mut Self::Foreign) {
+                libc::free(ptr as *mut c_void);
+            }
+
+            fn clone_to_foreign(&self) -> OwnedPointer<Self> {
+                // Safety: we are copying into a freshly-allocated block
+                unsafe {
+                    let p = libc::malloc(mem::size_of::<Self>()) as *mut Self::Foreign;
+                    *p = *self as Self::Foreign;
+                    OwnedPointer::new(p)
+                }
+            }
+        }
+
+        impl FromForeign for $rust_type {
+            unsafe fn cloned_from_foreign(p: *const Self::Foreign) -> Self {
+                *p
+            }
+        }
+
+        impl CloneToForeign for [$rust_type] {
+            type Foreign = $foreign_type;
+
+            unsafe fn free_foreign(ptr: *mut Self::Foreign) {
+                libc::free(ptr as *mut c_void);
+            }
+
+            fn clone_to_foreign(&self) -> OwnedPointer<Self> {
+                // SAFETY: self.as_ptr() is guaranteed to point to the same number of bytes
+                // as the freshly allocated destination
+                unsafe {
+                    let size = mem::size_of::<Self::Foreign>();
+                    let p = libc::malloc(self.len() * size) as *mut Self::Foreign;
+                    ptr::copy_nonoverlapping(self.as_ptr() as *const Self::Foreign, p, self.len());
+                    OwnedPointer::new(p)
+                }
+            }
+        }
+    };
+}
+foreign_copy_type!(i8, i8);
+foreign_copy_type!(u8, u8);
+foreign_copy_type!(i16, i16);
+foreign_copy_type!(u16, u16);
+foreign_copy_type!(i32, i32);
+foreign_copy_type!(u32, u32);
+foreign_copy_type!(i64, i64);
+foreign_copy_type!(u64, u64);
+foreign_copy_type!(isize, libc::ptrdiff_t);
+foreign_copy_type!(usize, libc::size_t);
+foreign_copy_type!(f32, f32);
+foreign_copy_type!(f64, f64);
+
+#[cfg(test)]
+mod tests {
+    #![allow(clippy::shadow_unrelated)]
+
+    use super::*;
+    use matches::assert_matches;
+    use std::ffi::c_void;
+
+    #[test]
+    fn test_foreign_int_convert() {
+        let i = 123i8;
+        let p = i.clone_to_foreign();
+        unsafe {
+            assert_eq!(i, *p.as_ptr());
+            assert_eq!(i, i8::cloned_from_foreign(p.as_ptr()));
+        }
+        assert_eq!(i, p.into_native());
+
+        let p = i.clone_to_foreign();
+        unsafe {
+            assert_eq!(i, i8::from_foreign(p.into_inner()));
+        }
+    }
+
+    #[test]
+    fn test_cloned_from_foreign_string_cow() {
+        let s = "Hello, world!".to_string();
+        let cstr = c"Hello, world!";
+        let cloned = unsafe { Cow::cloned_from_foreign(cstr.as_ptr()) };
+        assert_eq!(s, cloned);
+    }
+
+    #[test]
+    fn test_cloned_from_foreign_string() {
+        let s = "Hello, world!".to_string();
+        let cstr = c"Hello, world!";
+        let cloned = unsafe { String::cloned_from_foreign(cstr.as_ptr()) };
+        assert_eq!(s, cloned);
+    }
+
+    #[test]
+    fn test_cloned_from_foreign_cstring() {
+        let s = CString::new("Hello, world!").unwrap();
+        let cloned = s.clone_to_foreign();
+        let copy = unsafe { CString::cloned_from_foreign(cloned.as_ptr()) };
+        assert_ne!(copy.as_ptr(), cloned.as_ptr());
+        assert_ne!(copy.as_ptr(), s.as_ptr());
+        assert_eq!(copy, s);
+    }
+
+    #[test]
+    fn test_from_foreign_string() {
+        let s = "Hello, world!".to_string();
+        let cloned = s.clone_to_foreign_ptr();
+        let copy = unsafe { String::from_foreign(cloned) };
+        assert_eq!(s, copy);
+    }
+
+    #[test]
+    fn test_owned_pointer_default() {
+        let s: String = Default::default();
+        let foreign: OwnedPointer<String> = Default::default();
+        let native = foreign.into_native();
+        assert_eq!(s, native);
+    }
+
+    #[test]
+    fn test_owned_pointer_into() {
+        let s = "Hello, world!".to_string();
+        let cloned: OwnedPointer<String> = s.clone_to_foreign().into();
+        let copy = cloned.into_native();
+        assert_eq!(s, copy);
+    }
+
+    #[test]
+    fn test_owned_pointer_into_native() {
+        let s = "Hello, world!".to_string();
+        let cloned = s.clone_to_foreign();
+        let copy = cloned.into_native();
+        assert_eq!(s, copy);
+    }
+
+    #[test]
+    fn test_ptr_into_native() {
+        let s = "Hello, world!".to_string();
+        let cloned = s.clone_to_foreign_ptr();
+        let copy: String = unsafe { cloned.into_native() };
+        assert_eq!(s, copy);
+
+        // This is why type bounds are needed... they aren't for
+        // OwnedPointer::into_native
+        let cloned = s.clone_to_foreign_ptr();
+        let copy: c_char = unsafe { cloned.into_native() };
+        assert_eq!(s.as_bytes()[0], copy as u8);
+    }
+
+    #[test]
+    fn test_clone_to_foreign_str() {
+        let s = "Hello, world!";
+        let p = c"Hello, world!".as_ptr();
+        let cloned = s.clone_to_foreign();
+        unsafe {
+            let len = libc::strlen(cloned.as_ptr());
+            assert_eq!(len, s.len());
+            assert_eq!(
+                libc::memcmp(
+                    cloned.as_ptr() as *const c_void,
+                    p as *const c_void,
+                    len + 1
+                ),
+                0
+            );
+        }
+    }
+
+    #[test]
+    fn test_clone_to_foreign_cstr() {
+        let s: &CStr = c"Hello, world!";
+        let cloned = s.clone_to_foreign();
+        unsafe {
+            let len = libc::strlen(cloned.as_ptr());
+            assert_eq!(len, s.count_bytes());
+            assert_eq!(
+                libc::memcmp(
+                    cloned.as_ptr() as *const c_void,
+                    s.as_ptr() as *const c_void,
+                    len + 1
+                ),
+                0
+            );
+        }
+    }
+
+    #[test]
+    fn test_clone_to_foreign_string_cow() {
+        let p = c"Hello, world!".as_ptr();
+        for s in vec![
+            Into::<Cow<str>>::into("Hello, world!"),
+            Into::<Cow<str>>::into("Hello, world!".to_string())] {
+            let cloned = s.clone_to_foreign();
+            unsafe {
+                let len = libc::strlen(cloned.as_ptr());
+                assert_eq!(len, s.len());
+                assert_eq!(
+                    libc::memcmp(
+                        cloned.as_ptr() as *const c_void,
+                        p as *const c_void,
+                        len + 1
+                    ),
+                    0
+                );
+            }
+        }
+    }
+
+    #[test]
+    fn test_clone_to_foreign_bytes() {
+        let s = b"Hello, world!\0";
+        let cloned = s.clone_to_foreign();
+        unsafe {
+            let len = libc::strlen(cloned.as_ptr() as *const c_char);
+            assert_eq!(len, s.len() - 1);
+            assert_eq!(
+                libc::memcmp(
+                    cloned.as_ptr() as *const c_void,
+                    s.as_ptr() as *const c_void,
+                    len + 1
+                ),
+                0
+            );
+        }
+    }
+
+    #[test]
+    fn test_clone_to_foreign_cstring() {
+        let s = CString::new("Hello, world!").unwrap();
+        let cloned = s.clone_to_foreign();
+        unsafe {
+            assert_ne!(s.as_ptr(), cloned.as_ptr());
+            assert_eq!(
+                libc::strcmp(
+                    cloned.as_ptr() as *const c_char,
+                    s.as_ptr() as *const c_char,
+                ),
+                0
+            );
+        }
+    }
+
+    #[test]
+    fn test_clone_to_foreign_string() {
+        let s = "Hello, world!".to_string();
+        let cstr = c"Hello, world!";
+        let cloned = s.clone_to_foreign();
+        unsafe {
+            let len = libc::strlen(cloned.as_ptr());
+            assert_eq!(len, s.len());
+            assert_eq!(
+                libc::memcmp(
+                    cloned.as_ptr() as *const c_void,
+                    cstr.as_ptr() as *const c_void,
+                    len + 1
+                ),
+                0
+            );
+        }
+    }
+
+    #[test]
+    fn test_option() {
+        // An Option can be used to produce or convert NULL pointers
+        let s = Some("Hello, world!".to_string());
+        let cstr = c"Hello, world!";
+        unsafe {
+            assert_eq!(Option::<String>::cloned_from_foreign(cstr.as_ptr()), s);
+            assert_matches!(Option::<String>::cloned_from_foreign(ptr::null()), None);
+            assert_matches!(Option::<String>::from_foreign(ptr::null_mut()), None);
+        }
+    }
+
+    #[test]
+    fn test_box() {
+        // A box can be produced if the inner type has the capability.
+        let s = Box::new("Hello, world!".to_string());
+        let cstr = c"Hello, world!";
+        let cloned = unsafe { Box::<String>::cloned_from_foreign(cstr.as_ptr()) };
+        assert_eq!(s, cloned);
+
+        let s = Some(Box::new("Hello, world!".to_string()));
+        let cloned = unsafe { Option::<Box<String>>::cloned_from_foreign(cstr.as_ptr()) };
+        assert_eq!(s, cloned);
+    }
+}
-- 
2.45.2


