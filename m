Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F62E77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 12:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKd1H-0003ou-DH; Mon, 09 Dec 2024 07:37:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd15-0003kY-Ao
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:37:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd12-0007Os-Ky
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733747851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMF7KkhAi7BwGkG3WdZkbBzWjurjR2HS0qfiOPgjOHU=;
 b=h8pMut6dg+8ZRrehkM/PM2FXRIqf/0A/kyBZfZ0UQSB4MR6ZzSqRn+yWEsUMAXSCFHeYyS
 qZYv0XKoWcZO6t89aQWaiSNytNdvNAoORasJD4L2rY/NKbkLatXJ8LZw+ra0CkqQ0XwxXl
 FSnj8/f+ICMvu8VaCoulX57Hmdf/ymU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-pQFKVHTeOvCIz2ifL1kGZw-1; Mon, 09 Dec 2024 07:37:30 -0500
X-MC-Unique: pQFKVHTeOvCIz2ifL1kGZw-1
X-Mimecast-MFC-AGG-ID: pQFKVHTeOvCIz2ifL1kGZw
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-386333ea577so759322f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 04:37:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733747848; x=1734352648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wMF7KkhAi7BwGkG3WdZkbBzWjurjR2HS0qfiOPgjOHU=;
 b=LsBlaEVJzVrUENmC9ig12kkk8Ep+C5puydqbttXN3e9WklpGRnCfO6nBK8PraD94ZS
 ptMbqmMsOuOABEsJKO/uSaOm65spsgU3efUDDcz2p/GZDgJ2t2cKM7jQWQkPz1ZBRtcG
 w+kbR2CeHTYZmbwYPsZu9EJFj26dRm2EJnqgk//4tg260sdRr3mI4XpAzU2udR63ke7W
 6CdmfptFCvOzibhmO9g5onT9Pga/Vn9a1C7Eq4zdv1o0DEAuszxZoH4S3B1AxwOsUau4
 YwivwbsAN0n+bslCrnGZb3+v73jjI+kC7XdF3Nq/oG9CwOWdKYlgG7BrbQktrCJYjeFR
 JN0A==
X-Gm-Message-State: AOJu0YzqeZWLjIqrZ7Sm2KJ/QcNxXjkl7ZW+Edu5398kXlcAJ9TM2M5l
 Z2mZD8/9s+PL9gH4175VVB6n9dtHo5SSqXF+pbw+ImJycibklciEOtgQUrPlqWwD+fH53oJVUpv
 O4q8IKApijoC4D3Td/QzPpGzVD+O4dxZfNHiIbiFzZmfiDNSrWAseD/Yef3hdsXgcs1WRsLAHsL
 brGvdV94Bztyvonv9ZehNJl3sm8Madvupp+axD
X-Gm-Gg: ASbGncuqEdEjzEbe/JSHZfGf10H6hsS51BX9kQyTNCdv2xFnBEP6kaTO6c+hFHlRB1v
 jYwC/xidGEUey2K9iHeafi1CUWi7YQB7EjaMTntbcd2nvSdjgYWsYIrVg8ZE7KU3xTLoAZlN6k0
 GNt3ghLj201KK/Y3GPKTKQe6P2WC1B/NedqkNJfm/ulAMBO8+Th6/nSIYLGzAq90V5uOe72p68u
 kZOVQ4fJ/PVhwrD39SnqIbbrJnS0RrV/Y6q7eZPdspUUMEGLafp2A==
X-Received: by 2002:a5d:5f53:0:b0:386:5b2:a9d9 with SMTP id
 ffacd0b85a97d-386453fbd04mr134476f8f.53.1733747847960; 
 Mon, 09 Dec 2024 04:37:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHudZUgpkRU+aSyObe3pCtfO2GlnG4ukBn4FRXPkvB8Xz3AG0t9lU7v4GCtsSs9xEN66yW4yw==
X-Received: by 2002:a5d:5f53:0:b0:386:5b2:a9d9 with SMTP id
 ffacd0b85a97d-386453fbd04mr134437f8f.53.1733747847279; 
 Mon, 09 Dec 2024 04:37:27 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-386348182d4sm7824324f8f.53.2024.12.09.04.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 04:37:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 03/26] rust: cell: add BQL-enforcing RefCell variant
Date: Mon,  9 Dec 2024 13:36:54 +0100
Message-ID: <20241209123717.99077-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209123717.99077-1-pbonzini@redhat.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Similar to the existing BqlCell, introduce a custom interior mutability
primitive that resembles RefCell but accounts for QEMU's threading model.
Borrowing the RefCell requires proving that the BQL is held, and
attempting to access without the BQL is a runtime panic.

Almost all of the code was taken from Rust's standard library, while
removing unstable features and probably-unnecessary functionality that
amounts to 60% of the original code.  A lot of what's left is documentation,
as well as unit tests in the form of doctests.  These are not yet integrated
in "make check" but can be run with "cargo test --doc".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/Cargo.toml  |   3 +-
 rust/qemu-api/meson.build |   3 +
 rust/qemu-api/src/cell.rs | 544 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 539 insertions(+), 11 deletions(-)

diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index 669f288d1cb..4aa22f31986 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -20,8 +20,9 @@ qemu_api_macros = { path = "../qemu-api-macros" }
 version_check = "~0.9"
 
 [features]
-default = []
+default = ["debug_cell"]
 allocator = []
+debug_cell = []
 
 [lints]
 workspace = true
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index edc21e1a3f8..cacb112c5c3 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -6,6 +6,9 @@ _qemu_api_cfg = run_command(rustc_args,
 if rustc.version().version_compare('>=1.77.0')
   _qemu_api_cfg += ['--cfg', 'has_offset_of']
 endif
+if get_option('debug_mutex')
+  _qemu_api_cfg += ['--feature', 'debug_cell']
+endif
 
 _qemu_api_rs = static_library(
   'qemu_api',
diff --git a/rust/qemu-api/src/cell.rs b/rust/qemu-api/src/cell.rs
index 2e4ea8d590d..28349de291a 100644
--- a/rust/qemu-api/src/cell.rs
+++ b/rust/qemu-api/src/cell.rs
@@ -46,20 +46,30 @@
 //! parts of a  device must be made mutable in a controlled manner through the
 //! use of cell types.
 //!
-//! This module provides a way to do so via the Big QEMU Lock.  While
-//! [`BqlCell<T>`] is essentially the same single-threaded primitive that is
-//! available in `std::cell`, the BQL allows it to be used from a multi-threaded
-//! context and to share references across threads, while maintaining Rust's
-//! safety guarantees.  For this reason, unlike its `std::cell` counterpart,
-//! `BqlCell` implements the `Sync` trait.
+//! [`BqlCell<T>`] and [`BqlRefCell<T>`] allow doing this via the Big QEMU Lock.
+//! While they are essentially the same single-threaded primitives that are
+//! available in `std::cell`, the BQL allows them to be used from a
+//! multi-threaded context and to share references across threads, while
+//! maintaining Rust's safety guarantees.  For this reason, unlike
+//! their `std::cell` counterparts, `BqlCell` and `BqlRefCell` implement the
+//! `Sync` trait.
 //!
 //! BQL checks are performed in debug builds but can be optimized away in
 //! release builds, providing runtime safety during development with no overhead
 //! in production.
 //!
-//! Warning: While `BqlCell` is similar to its `std::cell` counterpart, the two
-//! are not interchangeable. Using `std::cell` types in QEMU device
-//! implementations is usually incorrect and can lead to thread-safety issues.
+//! The two provide different ways of handling interior mutability.
+//! `BqlRefCell` is best suited for data that is primarily accessed by the
+//! device's own methods, where multiple reads and writes can be grouped within
+//! a single borrow and a mutable reference can be passed around.  Instead,
+//! [`BqlCell`] is a better choice when sharing small pieces of data with
+//! external code (especially C code), because it provides simple get/set
+//! operations that can be used one at a time.
+//!
+//! Warning: While `BqlCell` and `BqlRefCell` are similar to their `std::cell`
+//! counterparts, they are not interchangeable. Using `std::cell` types in
+//! QEMU device implementations is usually incorrect and can lead to
+//! thread-safety issues.
 //!
 //! ## `BqlCell<T>`
 //!
@@ -80,8 +90,37 @@
 //!      returns the replaced value.
 //!    - [`set`](BqlCell::set): this method replaces the interior value,
 //!      dropping the replaced value.
+//!
+//! ## `BqlRefCell<T>`
+//!
+//! [`BqlRefCell<T>`] uses Rust's lifetimes to implement "dynamic borrowing", a
+//! process whereby one can claim temporary, exclusive, mutable access to the
+//! inner value:
+//!
+//! ```ignore
+//! fn clear_interrupts(&self, val: u32) {
+//!     // A mutable borrow gives read-write access to the registers
+//!     let mut regs = self.registers.borrow_mut();
+//!     let old = regs.interrupt_status();
+//!     regs.update_interrupt_status(old & !val);
+//! }
+//! ```
+//!
+//! Borrows for `BqlRefCell<T>`s are tracked at _runtime_, unlike Rust's native
+//! reference types which are entirely tracked statically, at compile time.
+//! Multiple immutable borrows are allowed via [`borrow`](BqlRefCell::borrow),
+//! or a single mutable borrow via [`borrow_mut`](BqlRefCell::borrow_mut).  The
+//! thread will panic if these rules are violated or if the BQL is not held.
 
-use std::{cell::UnsafeCell, cmp::Ordering, fmt, mem};
+use std::{
+    cell::{Cell, UnsafeCell},
+    cmp::Ordering,
+    fmt,
+    marker::PhantomData,
+    mem,
+    ops::{Deref, DerefMut},
+    ptr::NonNull,
+};
 
 use crate::bindings;
 
@@ -93,6 +132,15 @@ pub fn bql_locked() -> bool {
     !cfg!(MESON) || unsafe { bindings::bql_locked() }
 }
 
+fn bql_block_unlock(increase: bool) {
+    if cfg!(MESON) {
+        // SAFETY: this only adjusts a counter
+        unsafe {
+            bindings::bql_block_unlock(increase);
+        }
+    }
+}
+
 /// A mutable memory location that is protected by the Big QEMU Lock.
 ///
 /// # Memory layout
@@ -296,3 +344,479 @@ pub fn take(&self) -> T {
         self.replace(Default::default())
     }
 }
+
+/// A mutable memory location with dynamically checked borrow rules,
+/// protected by the Big QEMU Lock.
+///
+/// See the [module-level documentation](self) for more.
+///
+/// # Memory layout
+///
+/// `BqlRefCell<T>` starts with the same in-memory representation as its
+/// inner type `T`.
+#[repr(C)]
+pub struct BqlRefCell<T> {
+    // It is important that this is the first field (which is not the case
+    // for std::cell::BqlRefCell), so that we can use offset_of! on it.
+    // UnsafeCell and repr(C) both prevent usage of niches.
+    value: UnsafeCell<T>,
+    borrow: Cell<BorrowFlag>,
+    // Stores the location of the earliest currently active borrow.
+    // This gets updated whenever we go from having zero borrows
+    // to having a single borrow. When a borrow occurs, this gets included
+    // in the panic message
+    #[cfg(feature = "debug_cell")]
+    borrowed_at: Cell<Option<&'static std::panic::Location<'static>>>,
+}
+
+// Positive values represent the number of `BqlRef` active. Negative values
+// represent the number of `BqlRefMut` active. Right now QEMU's implementation
+// does not allow to create `BqlRefMut`s that refer to distinct, nonoverlapping
+// components of a `BqlRefCell` (e.g., different ranges of a slice).
+//
+// `BqlRef` and `BqlRefMut` are both two words in size, and so there will likely
+// never be enough `BqlRef`s or `BqlRefMut`s in existence to overflow half of
+// the `usize` range. Thus, a `BorrowFlag` will probably never overflow or
+// underflow. However, this is not a guarantee, as a pathological program could
+// repeatedly create and then mem::forget `BqlRef`s or `BqlRefMut`s. Thus, all
+// code must explicitly check for overflow and underflow in order to avoid
+// unsafety, or at least behave correctly in the event that overflow or
+// underflow happens (e.g., see BorrowRef::new).
+type BorrowFlag = isize;
+const UNUSED: BorrowFlag = 0;
+
+#[inline(always)]
+const fn is_writing(x: BorrowFlag) -> bool {
+    x < UNUSED
+}
+
+#[inline(always)]
+const fn is_reading(x: BorrowFlag) -> bool {
+    x > UNUSED
+}
+
+impl<T> BqlRefCell<T> {
+    /// Creates a new `BqlRefCell` containing `value`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use qemu_api::cell::BqlRefCell;
+    ///
+    /// let c = BqlRefCell::new(5);
+    /// ```
+    #[inline]
+    pub const fn new(value: T) -> BqlRefCell<T> {
+        BqlRefCell {
+            value: UnsafeCell::new(value),
+            borrow: Cell::new(UNUSED),
+            #[cfg(feature = "debug_cell")]
+            borrowed_at: Cell::new(None),
+        }
+    }
+}
+
+// This ensures the panicking code is outlined from `borrow_mut` for
+// `BqlRefCell`.
+#[inline(never)]
+#[cold]
+#[cfg(feature = "debug_cell")]
+fn panic_already_borrowed(source: &Cell<Option<&'static std::panic::Location<'static>>>) -> ! {
+    // If a borrow occurred, then we must already have an outstanding borrow,
+    // so `borrowed_at` will be `Some`
+    panic!("already borrowed at {:?}", source.take().unwrap())
+}
+
+#[inline(never)]
+#[cold]
+#[cfg(not(feature = "debug_cell"))]
+fn panic_already_borrowed() -> ! {
+    panic!("already borrowed")
+}
+
+impl<T> BqlRefCell<T> {
+    #[inline]
+    #[allow(clippy::unused_self)]
+    fn panic_already_borrowed(&self) -> ! {
+        #[cfg(feature = "debug_cell")]
+        {
+            panic_already_borrowed(&self.borrowed_at)
+        }
+        #[cfg(not(feature = "debug_cell"))]
+        {
+            panic_already_borrowed()
+        }
+    }
+
+    /// Immutably borrows the wrapped value.
+    ///
+    /// The borrow lasts until the returned `BqlRef` exits scope. Multiple
+    /// immutable borrows can be taken out at the same time.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the value is currently mutably borrowed.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use qemu_api::cell::BqlRefCell;
+    ///
+    /// let c = BqlRefCell::new(5);
+    ///
+    /// let borrowed_five = c.borrow();
+    /// let borrowed_five2 = c.borrow();
+    /// ```
+    ///
+    /// An example of panic:
+    ///
+    /// ```should_panic
+    /// use qemu_api::cell::BqlRefCell;
+    ///
+    /// let c = BqlRefCell::new(5);
+    ///
+    /// let m = c.borrow_mut();
+    /// let b = c.borrow(); // this causes a panic
+    /// ```
+    #[inline]
+    #[track_caller]
+    pub fn borrow(&self) -> BqlRef<'_, T> {
+        if let Some(b) = BorrowRef::new(&self.borrow) {
+            // `borrowed_at` is always the *first* active borrow
+            if b.borrow.get() == 1 {
+                #[cfg(feature = "debug_cell")]
+                self.borrowed_at.set(Some(std::panic::Location::caller()));
+            }
+
+            bql_block_unlock(true);
+
+            // SAFETY: `BorrowRef` ensures that there is only immutable access
+            // to the value while borrowed.
+            let value = unsafe { NonNull::new_unchecked(self.value.get()) };
+            BqlRef { value, borrow: b }
+        } else {
+            self.panic_already_borrowed()
+        }
+    }
+
+    /// Mutably borrows the wrapped value.
+    ///
+    /// The borrow lasts until the returned `BqlRefMut` or all `BqlRefMut`s
+    /// derived from it exit scope. The value cannot be borrowed while this
+    /// borrow is active.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the value is currently borrowed.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use qemu_api::cell::BqlRefCell;
+    ///
+    /// let c = BqlRefCell::new("hello".to_owned());
+    ///
+    /// *c.borrow_mut() = "bonjour".to_owned();
+    ///
+    /// assert_eq!(&*c.borrow(), "bonjour");
+    /// ```
+    ///
+    /// An example of panic:
+    ///
+    /// ```should_panic
+    /// use qemu_api::cell::BqlRefCell;
+    ///
+    /// let c = BqlRefCell::new(5);
+    /// let m = c.borrow();
+    ///
+    /// let b = c.borrow_mut(); // this causes a panic
+    /// ```
+    #[inline]
+    #[track_caller]
+    pub fn borrow_mut(&self) -> BqlRefMut<'_, T> {
+        if let Some(b) = BorrowRefMut::new(&self.borrow) {
+            #[cfg(feature = "debug_cell")]
+            {
+                self.borrowed_at.set(Some(std::panic::Location::caller()));
+            }
+
+            // SAFETY: this only adjusts a counter
+            bql_block_unlock(true);
+
+            // SAFETY: `BorrowRefMut` guarantees unique access.
+            let value = unsafe { NonNull::new_unchecked(self.value.get()) };
+            BqlRefMut {
+                value,
+                _borrow: b,
+                marker: PhantomData,
+            }
+        } else {
+            self.panic_already_borrowed()
+        }
+    }
+
+    /// Returns a raw pointer to the underlying data in this cell.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use qemu_api::cell::BqlRefCell;
+    ///
+    /// let c = BqlRefCell::new(5);
+    ///
+    /// let ptr = c.as_ptr();
+    /// ```
+    #[inline]
+    pub const fn as_ptr(&self) -> *mut T {
+        self.value.get()
+    }
+}
+
+// SAFETY: Same as for std::sync::Mutex.  In the end this is a Mutex that is
+// stored out-of-line.  Even though BqlRefCell includes Cells, they are
+// themselves protected by the Big QEMU Lock.  Furtheremore, the Big QEMU
+// Lock cannot be released while any borrows is active.
+unsafe impl<T> Send for BqlRefCell<T> where T: Send {}
+unsafe impl<T> Sync for BqlRefCell<T> {}
+
+impl<T: Clone> Clone for BqlRefCell<T> {
+    /// # Panics
+    ///
+    /// Panics if the value is currently mutably borrowed.
+    #[inline]
+    #[track_caller]
+    fn clone(&self) -> BqlRefCell<T> {
+        BqlRefCell::new(self.borrow().clone())
+    }
+
+    /// # Panics
+    ///
+    /// Panics if `source` is currently mutably borrowed.
+    #[inline]
+    #[track_caller]
+    fn clone_from(&mut self, source: &Self) {
+        self.value.get_mut().clone_from(&source.borrow())
+    }
+}
+
+impl<T: Default> Default for BqlRefCell<T> {
+    /// Creates a `BqlRefCell<T>`, with the `Default` value for T.
+    #[inline]
+    fn default() -> BqlRefCell<T> {
+        BqlRefCell::new(Default::default())
+    }
+}
+
+impl<T: PartialEq> PartialEq for BqlRefCell<T> {
+    /// # Panics
+    ///
+    /// Panics if the value in either `BqlRefCell` is currently mutably
+    /// borrowed.
+    #[inline]
+    fn eq(&self, other: &BqlRefCell<T>) -> bool {
+        *self.borrow() == *other.borrow()
+    }
+}
+
+impl<T: Eq> Eq for BqlRefCell<T> {}
+
+impl<T: PartialOrd> PartialOrd for BqlRefCell<T> {
+    /// # Panics
+    ///
+    /// Panics if the value in either `BqlRefCell` is currently mutably
+    /// borrowed.
+    #[inline]
+    fn partial_cmp(&self, other: &BqlRefCell<T>) -> Option<Ordering> {
+        self.borrow().partial_cmp(&*other.borrow())
+    }
+}
+
+impl<T: Ord> Ord for BqlRefCell<T> {
+    /// # Panics
+    ///
+    /// Panics if the value in either `BqlRefCell` is currently mutably
+    /// borrowed.
+    #[inline]
+    fn cmp(&self, other: &BqlRefCell<T>) -> Ordering {
+        self.borrow().cmp(&*other.borrow())
+    }
+}
+
+impl<T> From<T> for BqlRefCell<T> {
+    /// Creates a new `BqlRefCell<T>` containing the given value.
+    fn from(t: T) -> BqlRefCell<T> {
+        BqlRefCell::new(t)
+    }
+}
+
+struct BorrowRef<'b> {
+    borrow: &'b Cell<BorrowFlag>,
+}
+
+impl<'b> BorrowRef<'b> {
+    #[inline]
+    fn new(borrow: &'b Cell<BorrowFlag>) -> Option<BorrowRef<'b>> {
+        let b = borrow.get().wrapping_add(1);
+        if !is_reading(b) {
+            // Incrementing borrow can result in a non-reading value (<= 0) in these cases:
+            // 1. It was < 0, i.e. there are writing borrows, so we can't allow a read
+            //    borrow due to Rust's reference aliasing rules
+            // 2. It was isize::MAX (the max amount of reading borrows) and it overflowed
+            //    into isize::MIN (the max amount of writing borrows) so we can't allow an
+            //    additional read borrow because isize can't represent so many read borrows
+            //    (this can only happen if you mem::forget more than a small constant amount
+            //    of `BqlRef`s, which is not good practice)
+            None
+        } else {
+            // Incrementing borrow can result in a reading value (> 0) in these cases:
+            // 1. It was = 0, i.e. it wasn't borrowed, and we are taking the first read
+            //    borrow
+            // 2. It was > 0 and < isize::MAX, i.e. there were read borrows, and isize is
+            //    large enough to represent having one more read borrow
+            borrow.set(b);
+            Some(BorrowRef { borrow })
+        }
+    }
+}
+
+impl Drop for BorrowRef<'_> {
+    #[inline]
+    fn drop(&mut self) {
+        let borrow = self.borrow.get();
+        debug_assert!(is_reading(borrow));
+        self.borrow.set(borrow - 1);
+        bql_block_unlock(false)
+    }
+}
+
+impl Clone for BorrowRef<'_> {
+    #[inline]
+    fn clone(&self) -> Self {
+        BorrowRef::new(self.borrow).unwrap()
+    }
+}
+
+/// Wraps a borrowed reference to a value in a `BqlRefCell` box.
+/// A wrapper type for an immutably borrowed value from a `BqlRefCell<T>`.
+///
+/// See the [module-level documentation](self) for more.
+pub struct BqlRef<'b, T: 'b> {
+    // NB: we use a pointer instead of `&'b T` to avoid `noalias` violations, because a
+    // `BqlRef` argument doesn't hold immutability for its whole scope, only until it drops.
+    // `NonNull` is also covariant over `T`, just like we would have with `&T`.
+    value: NonNull<T>,
+    borrow: BorrowRef<'b>,
+}
+
+impl<T> Deref for BqlRef<'_, T> {
+    type Target = T;
+
+    #[inline]
+    fn deref(&self) -> &T {
+        // SAFETY: the value is accessible as long as we hold our borrow.
+        unsafe { self.value.as_ref() }
+    }
+}
+
+impl<'b, T> BqlRef<'b, T> {
+    /// Copies a `BqlRef`.
+    ///
+    /// The `BqlRefCell` is already immutably borrowed, so this cannot fail.
+    ///
+    /// This is an associated function that needs to be used as
+    /// `BqlRef::clone(...)`. A `Clone` implementation or a method would
+    /// interfere with the widespread use of `r.borrow().clone()` to clone
+    /// the contents of a `BqlRefCell`.
+    #[must_use]
+    #[inline]
+    #[allow(clippy::should_implement_trait)]
+    pub fn clone(orig: &BqlRef<'b, T>) -> BqlRef<'b, T> {
+        BqlRef {
+            value: orig.value,
+            borrow: orig.borrow.clone(),
+        }
+    }
+}
+
+impl<T: fmt::Debug> fmt::Debug for BqlRef<'_, T> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        (**self).fmt(f)
+    }
+}
+
+impl<T: fmt::Display> fmt::Display for BqlRef<'_, T> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        (**self).fmt(f)
+    }
+}
+
+struct BorrowRefMut<'b> {
+    borrow: &'b Cell<BorrowFlag>,
+}
+
+impl<'b> BorrowRefMut<'b> {
+    #[inline]
+    fn new(borrow: &'b Cell<BorrowFlag>) -> Option<BorrowRefMut<'b>> {
+        // There must currently be no existing references when borrow_mut() is
+        // called, so we explicitly only allow going from UNUSED to UNUSED - 1.
+        match borrow.get() {
+            UNUSED => {
+                borrow.set(UNUSED - 1);
+                Some(BorrowRefMut { borrow })
+            }
+            _ => None,
+        }
+    }
+}
+
+impl Drop for BorrowRefMut<'_> {
+    #[inline]
+    fn drop(&mut self) {
+        let borrow = self.borrow.get();
+        debug_assert!(is_writing(borrow));
+        self.borrow.set(borrow + 1);
+        bql_block_unlock(false)
+    }
+}
+
+/// A wrapper type for a mutably borrowed value from a `BqlRefCell<T>`.
+///
+/// See the [module-level documentation](self) for more.
+pub struct BqlRefMut<'b, T: 'b> {
+    // NB: we use a pointer instead of `&'b mut T` to avoid `noalias` violations, because a
+    // `BqlRefMut` argument doesn't hold exclusivity for its whole scope, only until it drops.
+    value: NonNull<T>,
+    _borrow: BorrowRefMut<'b>,
+    // `NonNull` is covariant over `T`, so we need to reintroduce invariance.
+    marker: PhantomData<&'b mut T>,
+}
+
+impl<T> Deref for BqlRefMut<'_, T> {
+    type Target = T;
+
+    #[inline]
+    fn deref(&self) -> &T {
+        // SAFETY: the value is accessible as long as we hold our borrow.
+        unsafe { self.value.as_ref() }
+    }
+}
+
+impl<T> DerefMut for BqlRefMut<'_, T> {
+    #[inline]
+    fn deref_mut(&mut self) -> &mut T {
+        // SAFETY: the value is accessible as long as we hold our borrow.
+        unsafe { self.value.as_mut() }
+    }
+}
+
+impl<T: fmt::Debug> fmt::Debug for BqlRefMut<'_, T> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        (**self).fmt(f)
+    }
+}
+
+impl<T: fmt::Display> fmt::Display for BqlRefMut<'_, T> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        (**self).fmt(f)
+    }
+}
-- 
2.47.1


