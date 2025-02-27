Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294A6C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnemy-0004th-4B; Thu, 27 Feb 2025 09:23:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnemc-0003q1-IV
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:22:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnemV-00044X-9k
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:22:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6iIZDcF/PvBVJf1MmHUhmduGZrGIMJ+/spGBp0GIEiY=;
 b=UmCubofNsa4YUcIbnnA1KGo6aXG3NWzw+SeQb2/OHFmt4ycGZP0271cR3vEzB0YOGbrc/U
 S8v6J5SplJDCPLNBMWlSqjU1N9d4RHHb2mbIXLFibRvFXcv3uwtGBJqBm2lJbS2YXnm40h
 4tZ+7qvtwVMksR9+Mot5FctGrd5mwh0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-mLX19pR3Pby_Ian8HE4iWw-1; Thu, 27 Feb 2025 09:22:26 -0500
X-MC-Unique: mLX19pR3Pby_Ian8HE4iWw-1
X-Mimecast-MFC-AGG-ID: mLX19pR3Pby_Ian8HE4iWw_1740666146
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5d9fb24f87bso1245188a12.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:22:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666145; x=1741270945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6iIZDcF/PvBVJf1MmHUhmduGZrGIMJ+/spGBp0GIEiY=;
 b=oA87XuUZ7h//yYY1kVwdQsYvdRHZ0WJOysMcyTLJbnAbKhP6vY0gAHi2yPD+jdMCiy
 mUAbmHKuMu6HpjAHnCYKRy+m6BQ13wkTkiJY6hjrJukKj2d7vOzpjbGKZeo5T5VvdqBU
 kaEQUPqjygYM1xQsfO175BVEhBA1yvc4gFBv5Rd9xrN+/XFgTf/ct8ntKvK76QBGzsZV
 7YNNEveOCq5Ko6jAKNWr1bedz3j9a8tAg3fCjiMaErs79AcEZbMaE37HVUZGJiszDo6d
 KCvGDSgZKtY6vq307VfdR/n+yU/tg7hy3WmvWd7uH/AOdrv8SjYWZjvAXQe+nhMaX0+V
 jfiA==
X-Gm-Message-State: AOJu0Yy+Yy3PUiMUfJdcr6UKJWt5rK0z8tfN8uuveMwwasEmmRk08Luo
 fHHK79C4C0YZuzWztSi5IyKZSUhB6N2LStTuYMZYB9IdxCcuHvPl1j09neG+ddegA64qvktNAqd
 U7DRcPmYjVyFucUU0BCZJ/mv4AcSvkHZir6+b6l9oDFo5Hn4t8oduezMv8/q7Ri+rkLNdU2qL/3
 m6QH3ZRWheP+keyOnMnyPP9ADV2Sj5cmcEMiUTb+0=
X-Gm-Gg: ASbGncvEL+R8mt5D1MTMxoRDF5lvQEzx4EwqxqSxa1vR2jjvxjVVrvA+osZNKqB57aa
 ldwyigO/ie1QplZRV+nRzxIcA1dvYgEC1LaTh43N237mwEeALHPcnwdSPI0k5s14QHr1cZvhwsL
 1Hv0p2p65xVNHyvyyxmgaGQjH2aIjSAN82Bx/SJiuBJEbuxLlogneLQVqpCheL2Uw1xBWWyGLD5
 fLLSriwQ2rR5acdUsR1I9Y0Un0grBvMeXmm7OKWnAQ631cWwerbKpkDLf0rkn9tIi9JDhJTQ0RE
 dAlUSs4PlRDBLgq7fbvU
X-Received: by 2002:a17:906:3291:b0:ab7:eeae:b23e with SMTP id
 a640c23a62f3a-abeeef74ademr928125166b.47.1740666144356; 
 Thu, 27 Feb 2025 06:22:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHklFqPVR+3DXJIrGGBuALrOKv7zqbe8KGnQ7eyzk1n4cSghHR9ghnEfklanU7UGHy5Z24EVg==
X-Received: by 2002:a17:906:3291:b0:ab7:eeae:b23e with SMTP id
 a640c23a62f3a-abeeef74ademr928121866b.47.1740666143755; 
 Thu, 27 Feb 2025 06:22:23 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c0ba3dbsm129921666b.22.2025.02.27.06.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:22:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 01/12] rust: cell: add wrapper for FFI types
Date: Thu, 27 Feb 2025 15:22:08 +0100
Message-ID: <20250227142219.812270-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227142219.812270-1-pbonzini@redhat.com>
References: <20250227142219.812270-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

Inspired by the same-named type in Linux.  This type provides the compiler
with a correct view of what goes on with FFI types.  In addition, it
separates the glue code from the bindgen-generated code, allowing
traits such as Send, Sync or Zeroable to be specified independently
for C and Rust structs.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst       |  34 +++++--
 rust/qemu-api/src/cell.rs | 197 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 216 insertions(+), 15 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 5d8aa3a45bc..784c3e40bdc 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -296,15 +296,33 @@ of ``&mut self``; access to internal fields must use *interior mutability*
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
index eae4e2ce786..7c00109d0e9 100644
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
+//! unsafe {
+//!     let state = Opaque::<MyStruct>::uninit();
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
+//!         let result = Box::pin(unsafe { Opaque::uninit() });
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
@@ -840,3 +911,115 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
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
+    /// in another `unsafe` block, for example when passing it to a C function,
+    /// but the functions containing the dereference are usually safe.  The
+    /// value returned from `uninit()` must be initialized and pinned before
+    /// calling them.
+    #[allow(clippy::missing_const_for_fn)]
+    pub unsafe fn uninit() -> Self {
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
+    /// in another `unsafe` block, for example when passing it to a C function,
+    /// but the functions containing the dereference are usually safe.  The
+    /// value returned from `uninit()` must be pinned (and possibly initialized)
+    /// before calling them.
+    #[allow(clippy::missing_const_for_fn)]
+    pub unsafe fn zeroed() -> Self {
+        Self {
+            value: UnsafeCell::new(MaybeUninit::zeroed()),
+            _pin: PhantomPinned,
+        }
+    }
+
+    /// Returns a raw mutable pointer to the opaque data.
+    pub const fn as_mut_ptr(&self) -> *mut T {
+        UnsafeCell::get(&self.value).cast()
+    }
+
+    /// Returns a raw pointer to the opaque data.
+    pub const fn as_ptr(&self) -> *const T {
+        self.as_mut_ptr() as *const _
+    }
+
+    /// Returns a raw pointer to the opaque data that can be passed to a
+    /// C function as `void *`.
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
+impl<T: Default> Opaque<T> {
+    /// Creates a new opaque object with default contents.
+    ///
+    /// # Safety
+    ///
+    /// Ultimately the pointer to the returned value will be dereferenced
+    /// in another `unsafe` block, for example when passing it to a C function,
+    /// but the functions containing the dereference are usually safe.  The
+    /// value returned from `uninit()` must be pinned before calling them.
+    pub unsafe fn new() -> Self {
+        Self {
+            value: UnsafeCell::new(MaybeUninit::new(T::default())),
+            _pin: PhantomPinned,
+        }
+    }
+}
-- 
2.48.1


