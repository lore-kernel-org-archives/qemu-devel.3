Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939DEC021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 17:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlWRg-00078Y-VP; Fri, 21 Feb 2025 12:04:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRe-0006xN-0L
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:04:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRb-0001Rq-0H
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740157446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IDuooerhK1to1+S4hiPVrqtGgOqxZ0Q0ElNK+Nffz5Y=;
 b=J4FpUMnEPVv7tL3uH6C9rutlpdTk3pleKgtbtkWK30amdbcc2ZO7I5UBt5teBqQIK+4ubs
 7FWdNTzp+VNR/WU+SetxFr0QNoNphB1qLSdQC3V96e+gkNhX1ABZwDi9To7RewiKrmgyvD
 rRzxkYZGUhWbSyXTFbWjlJ9yJkUhatI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-eYbs7Ut6P_yhmtPGDVGM-w-1; Fri, 21 Feb 2025 12:04:04 -0500
X-MC-Unique: eYbs7Ut6P_yhmtPGDVGM-w-1
X-Mimecast-MFC-AGG-ID: eYbs7Ut6P_yhmtPGDVGM-w_1740157443
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f37b4a72fso1741619f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 09:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740157442; x=1740762242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IDuooerhK1to1+S4hiPVrqtGgOqxZ0Q0ElNK+Nffz5Y=;
 b=Osw/cwjd5RVJABmwzdjHTgCuQayFDmkwH0jqLCX1BOMH2+CUUQxaqLdJBCy/31DqW4
 sW0TeYjHQQ0tpNXov8try0dNEN/QYW/y/dy8ro0cDuhuF48i3F0NZAF2nqVYZDWcABOz
 B9SCdApshBr9bqXEyUcm+Wjxxiz0m9jRrYVnYxTt+iauOUBUPmR4ISA37VaQZf1mYC1I
 vLiPB/Lx8c9/9OYo2ZFJtAw3OTEbogoEJ/uGuuxmBnvP+aiUHjyI1WswDdaS4tjFZnYw
 3dtT/3ZHcK2UZwm1arovuxrzLixBF1X4mMMmxVaRjDYQnrOjzBlY9tLNBAHstuAIwQ0y
 tQhg==
X-Gm-Message-State: AOJu0YxM5i6X2ce56nkPhm0GLhLx4P3f0W6uHgBRBbcchTlfP+AAvgP5
 mCYG83SFQlkJe9ebp0JWJvIWG0/u8JYxdy0W6W87aHsEjutKavBsEA7cgqne3otAI37Kiiflt5a
 uAG5Eait0z4O9PiQ13Ir9HuNEafcxQoXTicXGH1135nhppYpkf/V8MvlpcMPl5XmkY8uRIlTF+Q
 MINmm4Uc9EAetlAkXe47C32IixvvLlm5fj+KwAFA8=
X-Gm-Gg: ASbGncsmZGDBv+EDBguOnrATdOp2A8nvGvpG80/A5v9+28AoLweeFNpj75r0nDTcOJ1
 0zqD+l52RI/knNY9IhjItDFRJL6LKUuvu9zF+FKSx1+EnmM/+5ZtQbjrKvmb9QmqB3Aq4JG2i9w
 jaskjB+eifMVDbaGjxBkUGT0bkME9bHQr7ppKElfOUVALCbYeN3jTMEn/QfHGBNJ2zIM9xOFBqp
 MZmoQ7oLV64uNExTjoP9uWxVcpuWo70JvqMbsdJ+mMu//5G5NomZLVx2+nxRn8j/FrYgUsjfL6F
 PXxAWsglBeordxAJj7Y=
X-Received: by 2002:a05:6000:1ac7:b0:38d:ae1e:2f3c with SMTP id
 ffacd0b85a97d-38f6f51db2cmr3652613f8f.25.1740157439997; 
 Fri, 21 Feb 2025 09:03:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjpFHc9uvNj7Nbzsa/WYamQ7zWK2mxWvP3dv2m49lIeaql26yFVY109MkBPpNu0D31mt2JuA==
X-Received: by 2002:a05:6000:1ac7:b0:38d:ae1e:2f3c with SMTP id
 ffacd0b85a97d-38f6f51db2cmr3652419f8f.25.1740157437844; 
 Fri, 21 Feb 2025 09:03:57 -0800 (PST)
Received: from [192.168.10.48] ([151.95.61.185])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4314sm23666248f8f.9.2025.02.21.09.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:03:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 06/15] rust: cell: add wrapper for FFI types
Date: Fri, 21 Feb 2025 18:03:33 +0100
Message-ID: <20250221170342.63591-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221170342.63591-1-pbonzini@redhat.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
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

Inspired by the same-named type in Linux.  This type provides the compiler
with a correct view of what goes on with FFI types.  In addition, it
separates the glue code from the bindgen-generated code, allowing
traits such as Send, Sync or Zeroable to be specified independently
for C and Rust structs.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst       |  34 +++++--
 rust/qemu-api/src/cell.rs | 191 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 210 insertions(+), 15 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index e3f9e16aacb..9a621648e72 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -295,15 +295,33 @@ of ``&mut self``; access to internal fields must use *interior mutability*
 to go from a shared reference to a ``&mut``.
 
 Whenever C code provides you with an opaque ``void *``, avoid converting it
-to a Rust mutable reference, and use a shared reference instead.  Rust code
-will then have to use QEMU's ``BqlRefCell`` and ``BqlCell`` type, which
-enforce that locking rules for the "Big QEMU Lock" are respected.  These cell
-types are also known to the ``vmstate`` crate, which is able to "look inside"
-them when building an in-memory representation of a ``struct``'s layout.
-Note that the same is not true of a ``RefCell`` or ``Mutex``.
+to a Rust mutable reference, and use a shared reference instead.  The
+``qemu_api::cell`` module provides wrappers that can be used to tell the
+Rust compiler about interior mutability, and optionally to enforce locking
+rules for the "Big QEMU Lock".  In the future, similar cell types might
+also be provided for ``AioContext``-based locking as well.
 
-In the future, similar cell types might also be provided for ``AioContext``-based
-locking as well.
+In particular, device code will usually rely on the ``BqlRefCell`` and
+``BqlCell`` type to ensure that data is accessed correctly under the
+"Big QEMU Lock".  These cell types are also known to the ``vmstate``
+crate, which is able to "look inside" them when building an in-memory
+representation of a ``struct``'s layout.  Note that the same is not true
+of a ``RefCell`` or ``Mutex``.
+
+Bindings code instead will usually use the ``Opaque`` type, which hides
+the contents of the underlying struct and can be easily converted to
+a raw pointer, for use in calls to C functions.  It can be used for
+example as follows::
+
+    #[repr(transparent)]
+    #[derive(Debug)]
+    pub struct Object(Opaque<bindings::Object>);
+
+The bindings will then manually check for the big QEMU lock with
+assertions, which allows the wrapper to be declared thread-safe::
+
+    unsafe impl Send for Object {}
+    unsafe impl Sync for Object {}
 
 Writing bindings to C code
 ''''''''''''''''''''''''''
diff --git a/rust/qemu-api/src/cell.rs b/rust/qemu-api/src/cell.rs
index eae4e2ce786..84b9eb07467 100644
--- a/rust/qemu-api/src/cell.rs
+++ b/rust/qemu-api/src/cell.rs
@@ -27,7 +27,7 @@
 // IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 // DEALINGS IN THE SOFTWARE.
 
-//! BQL-protected mutable containers.
+//! QEMU-specific mutable containers
 //!
 //! Rust memory safety is based on this rule: Given an object `T`, it is only
 //! possible to have one of the following:
@@ -43,8 +43,10 @@
 //! usually have their pointer shared with the "outside world very early in
 //! their lifetime", for example when they create their
 //! [`MemoryRegion`s](crate::bindings::MemoryRegion).  Therefore, individual
-//! parts of a  device must be made mutable in a controlled manner through the
-//! use of cell types.
+//! parts of a  device must be made mutable in a controlled manner; this module
+//! provides the tools to do so.
+//!
+//! ## Cell types
 //!
 //! [`BqlCell<T>`] and [`BqlRefCell<T>`] allow doing this via the Big QEMU Lock.
 //! While they are essentially the same single-threaded primitives that are
@@ -71,7 +73,7 @@
 //! QEMU device implementations is usually incorrect and can lead to
 //! thread-safety issues.
 //!
-//! ## `BqlCell<T>`
+//! ### `BqlCell<T>`
 //!
 //! [`BqlCell<T>`] implements interior mutability by moving values in and out of
 //! the cell. That is, an `&mut T` to the inner value can never be obtained as
@@ -91,7 +93,7 @@
 //!    - [`set`](BqlCell::set): this method replaces the interior value,
 //!      dropping the replaced value.
 //!
-//! ## `BqlRefCell<T>`
+//! ### `BqlRefCell<T>`
 //!
 //! [`BqlRefCell<T>`] uses Rust's lifetimes to implement "dynamic borrowing", a
 //! process whereby one can claim temporary, exclusive, mutable access to the
@@ -111,13 +113,82 @@
 //! Multiple immutable borrows are allowed via [`borrow`](BqlRefCell::borrow),
 //! or a single mutable borrow via [`borrow_mut`](BqlRefCell::borrow_mut).  The
 //! thread will panic if these rules are violated or if the BQL is not held.
+//!
+//! ## Opaque wrappers
+//!
+//! The cell types from the previous section are useful at the boundaries
+//! of code that requires interior mutability.  When writing glue code that
+//! interacts directly with C structs, however, it is useful to operate
+//! at a lower level.
+//!
+//! C functions often violate Rust's fundamental assumptions about memory
+//! safety by modifying memory even if it is shared.  Furthermore, C structs
+//! often start their life uninitialized and may be populated lazily.
+//!
+//! For this reason, this module provides the [`Opaque<T>`] type to opt out
+//! of Rust's usual guarantees about the wrapped type. Access to the wrapped
+//! value is always through raw pointers, obtained via methods like
+//! [`as_mut_ptr()`](Opaque::as_mut_ptr) and [`as_ptr()`](Opaque::as_ptr). These
+//! pointers can then be passed to C functions or dereferenced; both actions
+//! require `unsafe` blocks, making it clear where safety guarantees must be
+//! manually verified. For example
+//!
+//! ```ignore
+//! let state = Opaque::<MyStruct>::uninit();
+//! unsafe {
+//!     qemu_struct_init(state.as_mut_ptr());
+//! }
+//! ```
+//!
+//! [`Opaque<T>`] will usually be wrapped one level further, so that
+//! bridge methods can be added to the wrapper:
+//!
+//! ```ignore
+//! pub struct MyStruct(Opaque<bindings::MyStruct>);
+//!
+//! impl MyStruct {
+//!     fn new() -> Pin<Box<MyStruct>> {
+//!         let result = Box::pin(Opaque::uninit());
+//!         unsafe { qemu_struct_init(result.as_mut_ptr()) };
+//!         result
+//!     }
+//! }
+//! ```
+//!
+//! This pattern of wrapping bindgen-generated types in [`Opaque<T>`] provides
+//! several advantages:
+//!
+//! * The choice of traits to be implemented is not limited by the
+//!   bindgen-generated code.  For example, [`Drop`] can be added without
+//!   disabling [`Copy`] on the underlying bindgen type
+//!
+//! * [`Send`] and [`Sync`] implementations can be controlled by the wrapper
+//!   type rather than being automatically derived from the C struct's layout
+//!
+//! * Methods can be implemented in a separate crate from the bindgen-generated
+//!   bindings
+//!
+//! * [`Debug`](std::fmt::Debug) and [`Display`](std::fmt::Display)
+//!   implementations can be customized to be more readable than the raw C
+//!   struct representation
+//!
+//! The [`Opaque<T>`] type does not include BQL validation; it is possible to
+//! assert in the code that the right lock is taken, to use it together
+//! with a custom lock guard type, or to let C code take the lock, as
+//! appropriate.  It is also possible to use it with non-thread-safe
+//! types, since by default (unlike [`BqlCell`] and [`BqlRefCell`]
+//! it is neither `Sync` nor `Send`.
+//!
+//! While [`Opaque<T>`] is necessary for C interop, it should be used sparingly
+//! and only at FFI boundaries. For QEMU-specific types that need interior
+//! mutability, prefer [`BqlCell`] or [`BqlRefCell`].
 
 use std::{
     cell::{Cell, UnsafeCell},
     cmp::Ordering,
     fmt,
-    marker::PhantomData,
-    mem,
+    marker::{PhantomData, PhantomPinned},
+    mem::{self, MaybeUninit},
     ops::{Deref, DerefMut},
     ptr::NonNull,
 };
@@ -840,3 +911,109 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         (**self).fmt(f)
     }
 }
+
+/// Stores an opaque value that is shared with C code.
+///
+/// Often, C structs can changed when calling a C function even if they are
+/// behind a shared Rust reference, or they can be initialized lazily and have
+/// invalid bit patterns (e.g. `3` for a [`bool`]).  This goes against Rust's
+/// strict aliasing rules, which normally prevent mutation through shared
+/// references.
+///
+/// Wrapping the struct with `Opaque<T>` ensures that the Rust compiler does not
+/// assume the usual constraints that Rust structs require, and allows using
+/// shared references on the Rust side.
+///
+/// `Opaque<T>` is `#[repr(transparent)]`, so that it matches the memory layout
+/// of `T`.
+#[repr(transparent)]
+pub struct Opaque<T> {
+    value: UnsafeCell<MaybeUninit<T>>,
+    // PhantomPinned also allows multiple references to the `Opaque<T>`, i.e.
+    // one `&mut Opaque<T>` can coexist with a `&mut T` or any number of `&T`;
+    // see https://docs.rs/pinned-aliasable/latest/pinned_aliasable/.
+    _pin: PhantomPinned,
+}
+
+impl<T> Opaque<T> {
+    /// Creates a new shared reference from a C pointer
+    ///
+    /// # Safety
+    ///
+    /// The pointer must be valid, though it need not point to a valid value.
+    pub unsafe fn from_raw<'a>(ptr: *mut T) -> &'a Self {
+        let ptr = NonNull::new(ptr).unwrap().cast::<Self>();
+        // SAFETY: Self is a transparent wrapper over T
+        unsafe { ptr.as_ref() }
+    }
+
+    /// Creates a new opaque object with uninitialized contents.
+    ///
+    /// # Safety
+    ///
+    /// Ultimately the pointer to the returned value will be dereferenced
+    /// in another unsafe block, for example when passing it to a C function.
+    /// However, this function is unsafe to "force" documenting who is going
+    /// to initialize and pin the value.
+    pub const unsafe fn uninit() -> Self {
+        Self {
+            value: UnsafeCell::new(MaybeUninit::uninit()),
+            _pin: PhantomPinned,
+        }
+    }
+
+    /// Creates a new opaque object with zeroed contents.
+    ///
+    /// # Safety
+    ///
+    /// Ultimately the pointer to the returned value will be dereferenced
+    /// in another unsafe block, for example when passing it to a C function.
+    /// However, this function is unsafe to "force" documenting whether a
+    /// zero value is safe.
+    pub const unsafe fn zeroed() -> Self {
+        Self {
+            value: UnsafeCell::new(MaybeUninit::uninit()),
+            _pin: PhantomPinned,
+        }
+    }
+
+    /// Returns a raw pointer to the opaque data.
+    pub const fn as_mut_ptr(&self) -> *mut T {
+        UnsafeCell::get(&self.value).cast()
+    }
+
+    /// Returns a raw pointer to the opaque data.
+    pub const fn as_ptr(&self) -> *const T {
+        self.as_mut_ptr() as *const _
+    }
+
+    /// Returns a raw pointer to the opaque data.
+    pub const fn as_void_ptr(&self) -> *mut std::ffi::c_void {
+        UnsafeCell::get(&self.value).cast()
+    }
+}
+
+impl<T> fmt::Debug for Opaque<T> {
+    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
+        let mut name: String = "Opaque<".to_string();
+        name += std::any::type_name::<T>();
+        name += ">";
+        f.debug_tuple(&name).field(&self.as_ptr()).finish()
+    }
+}
+
+impl<T: Default> Default for Opaque<T> {
+    fn default() -> Self {
+        Self {
+            value: UnsafeCell::new(MaybeUninit::new(T::default())),
+            _pin: PhantomPinned,
+        }
+    }
+}
+
+impl<T: Default> Opaque<T> {
+    /// Creates a new opaque object with default contents.
+    pub fn new() -> Self {
+        Self::default()
+    }
+}
-- 
2.48.1


