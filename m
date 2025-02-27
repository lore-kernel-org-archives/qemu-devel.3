Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BC5C282C5
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 16:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnh1f-000070-JO; Thu, 27 Feb 2025 11:46:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnh1E-0008ML-D2
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:45:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnh1A-0007np-HL
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740674747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5E7+LJSBoOz/G+zWX1NXdeqa/d5B+5NoEKi7sRBRBUw=;
 b=PsaVvUqWEQIuvkMTXyQHM/32WSZOhH5OnngM1vrVtWtnTwQzZ5578ULjWuPnzxOM+eW0cL
 r6bB2/naRWhs8Skm+cgqHcAoJkzpu3tYDnJD+NuPQUEw8ngXsjiZxmCJEp74+GSo9Hv5L9
 eiXWnoE0XdVzJkh1civVN/sjIsRNwnM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-X6T9qUFpPOK7NWbEjCyF_A-1; Thu, 27 Feb 2025 11:45:44 -0500
X-MC-Unique: X6T9qUFpPOK7NWbEjCyF_A-1
X-Mimecast-MFC-AGG-ID: X6T9qUFpPOK7NWbEjCyF_A_1740674743
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-abb93de227dso161010966b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 08:45:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740674742; x=1741279542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5E7+LJSBoOz/G+zWX1NXdeqa/d5B+5NoEKi7sRBRBUw=;
 b=GjucLrMbdcT7X5tRFBuboFIiOZXHDyPeHmjUhionzrvZlkau6YnAqCd7ipPuM9PMgs
 94pK0BfDhuowrAJh61dQ3grfRLduSMYEOket2xUd5WcELqT4ZKvBRfiXk/LfjzACnG4a
 mlFazzUmmBib4Xm9YDEGqhY9PCdDxw+yuJH1iSRlLuMh7H09LG5lfNtszS/kbUT8rcSa
 SMD+8KHddfN/821ormz2h0oo3y3yrKfq7CiuJQz58I2snOEW3Q/GCyW6k7HELRf5Bm1v
 wGuYyskWh4iN+x32L+xZ/KMlFs9yA2Y46TG0ITXQgE/yUjF+cCFP3ja95SY9gYXAq67/
 o9ug==
X-Gm-Message-State: AOJu0YyUqrOrxgwpzKmD3R5k9jfzERkqEhfDyBDB/4S7e574QitACsBm
 FKZOcMhMnMvqme0h4JCxn143DICB0iC9xZL03LMtZJScs5bN5M2NqeEIr53k76kgIgWyfS/osnc
 dlD/X+wTLTHGfTLTEmA29Sej60VT2kDVaQVIMKwprRqHWsgzjUMb/sYKcGiQdG3ebpVNuj2p05F
 OaGVaqSdNjoziwZPZegdO8cchCs7Iq1CXZiOvPIT8=
X-Gm-Gg: ASbGncvxU994rFdmkH9OLT4m+50YHED8u7PhfQjz+GdMx62zP3ggOmFLCW0s/y7CYgr
 9B3sRuiJdWaEKnejwU7TBtegVNrw+QDoJ8SO848mas1rCcJU3YubvUMg2r59Q6IMAURezcCVtRZ
 Msg4th6D4le96WE4JSLTw7a9rwbBVpSdsoYupkwDQtlKmIo18Yr+176wFAvC+d8FJH0xHvS1mOr
 RO4sbqwHPpZKTCsTWbyGo7HRFuDpo7R/61TnJ21n1fc9pnu9Wr+ptPEWJhHEeKraKCHQUp0EW5S
 vJNO13KF5kgW+dyCmg==
X-Received: by 2002:a17:907:7b89:b0:abf:1a67:1ff2 with SMTP id
 a640c23a62f3a-abf25fd9f37mr12747266b.13.1740674741974; 
 Thu, 27 Feb 2025 08:45:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0apzfMHXfdNPZQVyS+XwDNXoZYA63AHcMBdruHD52EYyYsWEGSXQE3mp9VeU/JFY5uSqfRw==
X-Received: by 2002:a17:907:7b89:b0:abf:1a67:1ff2 with SMTP id
 a640c23a62f3a-abf25fd9f37mr12743866b.13.1740674741285; 
 Thu, 27 Feb 2025 08:45:41 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c6ee486sm149558566b.90.2025.02.27.08.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 08:45:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 1/5] rust: chardev: provide basic bindings to character devices
Date: Thu, 27 Feb 2025 17:45:30 +0100
Message-ID: <20250227164538.814576-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227164538.814576-1-pbonzini@redhat.com>
References: <20250227164538.814576-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

Most of the character device API is pretty simple, with "0 or -errno"
or "number of bytes or -errno" as the convention for return codes.
Add safe wrappers for the API to the CharBackend bindgen-generated
struct.

The API is not complete, but it covers the parts that are used
by the PL011 device, plus qemu_chr_fe_write which is needed to
implement the standard library Write trait.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/meson.build     |  17 ++-
 rust/qemu-api/src/chardev.rs  | 237 +++++++++++++++++++++++++++++++++-
 rust/qemu-api/src/zeroable.rs |   1 +
 3 files changed, 250 insertions(+), 5 deletions(-)

diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 6e52c4bad74..a3f226ccc2a 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -54,7 +54,19 @@ qemu_api = declare_dependency(link_with: _qemu_api_rs)
 rust_qemu_api_objs = static_library(
     'rust_qemu_api_objs',
     objects: [libqom.extract_all_objects(recursive: false),
-              libhwcore.extract_all_objects(recursive: false)])
+              libhwcore.extract_all_objects(recursive: false),
+              libchardev.extract_all_objects(recursive: false),
+              libcrypto.extract_all_objects(recursive: false),
+              libauthz.extract_all_objects(recursive: false),
+              libio.extract_all_objects(recursive: false)])
+rust_qemu_api_deps = declare_dependency(
+    dependencies: [
+      qom_ss.dependencies(),
+      chardev_ss.dependencies(),
+      crypto_ss.dependencies(),
+      authz_ss.dependencies(),
+      io_ss.dependencies()],
+    link_whole: [rust_qemu_api_objs, libqemuutil])
 
 test('rust-qemu-api-integration',
     executable(
@@ -63,8 +75,7 @@ test('rust-qemu-api-integration',
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
         rust_args: ['--test'],
         install: false,
-        dependencies: [qemu_api, qemu_api_macros],
-        link_whole: [rust_qemu_api_objs, libqemuutil]),
+        dependencies: [qemu_api, qemu_api_macros, rust_qemu_api_deps]),
     args: [
         '--test', '--test-threads', '1',
         '--format', 'pretty',
diff --git a/rust/qemu-api/src/chardev.rs b/rust/qemu-api/src/chardev.rs
index a35b9217e90..3281844fd4e 100644
--- a/rust/qemu-api/src/chardev.rs
+++ b/rust/qemu-api/src/chardev.rs
@@ -3,10 +3,23 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 //! Bindings for character devices
+//!
+//! Character devices in QEMU can run under the big QEMU lock or in a separate
+//! `GMainContext`. Here we only support the former, because the bindings
+//! enforce that the BQL is taken whenever the functions in [`CharBackend`] are
+//! called.
 
-use std::ffi::CStr;
+use std::{
+    ffi::CStr,
+    fmt::{self, Debug},
+    io::{self, ErrorKind, Write},
+    marker::PhantomPinned,
+    os::raw::{c_int, c_void},
+    ptr::addr_of_mut,
+    slice,
+};
 
-use crate::{bindings, cell::Opaque, prelude::*};
+use crate::{bindings, callbacks::FnCall, cell::{BqlRefMut, Opaque}, prelude::*};
 
 /// A safe wrapper around [`bindings::Chardev`].
 #[repr(transparent)]
@@ -14,6 +27,226 @@
 pub struct Chardev(Opaque<bindings::Chardev>);
 
 pub type ChardevClass = bindings::ChardevClass;
+pub type Event = bindings::QEMUChrEvent;
+
+/// A safe wrapper around [`bindings::CharBackend`], denoting the character
+/// back-end that is used for example by a device.  Compared to the
+/// underlying C struct it adds BQL protection, and is marked as pinned
+/// because the QOM object ([`bindings::Chardev`]) contains a pointer to
+/// the `CharBackend`.
+pub struct CharBackend {
+    inner: BqlRefCell<bindings::CharBackend>,
+    _pin: PhantomPinned,
+}
+
+impl Write for BqlRefMut<'_, bindings::CharBackend> {
+    fn flush(&mut self) -> io::Result<()> {
+        Ok(())
+    }
+
+    fn write(&mut self, buf: &[u8]) -> io::Result<usize> {
+        let chr: &mut bindings::CharBackend = self;
+
+        let len = buf.len().try_into().unwrap();
+        let r = unsafe { bindings::qemu_chr_fe_write(addr_of_mut!(*chr), buf.as_ptr(), len) };
+        errno::into_io_result(r).map(|cnt| cnt as usize)
+    }
+
+    fn write_all(&mut self, buf: &[u8]) -> io::Result<()> {
+        let chr: &mut bindings::CharBackend = self;
+
+        let len = buf.len().try_into().unwrap();
+        let r = unsafe { bindings::qemu_chr_fe_write_all(addr_of_mut!(*chr), buf.as_ptr(), len) };
+        errno::into_io_result(r).and_then(|cnt| {
+            if cnt as usize == buf.len() {
+                Ok(())
+            } else {
+                Err(ErrorKind::WriteZero.into())
+            }
+        })
+    }
+}
+
+impl Debug for CharBackend {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        // SAFETY: accessed just to print the values
+        let chr = self.inner.as_ptr();
+        Debug::fmt(unsafe { &*chr }, f)
+    }
+}
+
+// FIXME: use something like PinnedDrop from the pinned_init crate
+impl Drop for CharBackend {
+    fn drop(&mut self) {
+        self.disable_handlers();
+    }
+}
+
+impl CharBackend {
+    /// Enable the front-end's character device handlers, if there is an
+    /// associated `Chardev`.
+    pub fn enable_handlers<
+        'chardev,
+        'owner: 'chardev,
+        T,
+        CanReceiveFn: for<'a> FnCall<(&'a T,), u32>,
+        ReceiveFn: for<'a, 'b> FnCall<(&'a T, &'b [u8])>,
+        EventFn: for<'a> FnCall<(&'a T, Event)>,
+    >(
+        // When "self" is dropped, the handlers are automatically disabled.
+        // However, this is not necessarily true if the owner is dropped.
+        // So require the owner to outlive the character device.
+        &'chardev self,
+        owner: &'owner T,
+        _can_receive: CanReceiveFn,
+        _receive: ReceiveFn,
+        _event: EventFn,
+    ) {
+        unsafe extern "C" fn rust_can_receive_cb<T, F: for<'a> FnCall<(&'a T,), u32>>(
+            opaque: *mut c_void,
+        ) -> c_int {
+            // SAFETY: the values are safe according to the contract of
+            // enable_handlers() and qemu_chr_fe_set_handlers()
+            let owner: &T = unsafe { &*(opaque.cast::<T>()) };
+            let r = F::call((owner,));
+            r.try_into().unwrap()
+        }
+
+        unsafe extern "C" fn rust_receive_cb<T, F: for<'a, 'b> FnCall<(&'a T, &'b [u8])>>(
+            opaque: *mut c_void,
+            buf: *const u8,
+            size: c_int,
+        ) {
+            // SAFETY: the values are safe according to the contract of
+            // enable_handlers() and qemu_chr_fe_set_handlers()
+            let owner: &T = unsafe { &*(opaque.cast::<T>()) };
+            let buf = unsafe { slice::from_raw_parts(buf, size.try_into().unwrap()) };
+            F::call((owner, buf))
+        }
+
+        unsafe extern "C" fn rust_event_cb<T, F: for<'a> FnCall<(&'a T, Event)>>(
+            opaque: *mut c_void,
+            event: Event,
+        ) {
+            // SAFETY: the values are safe according to the contract of
+            // enable_handlers() and qemu_chr_fe_set_handlers()
+            let owner: &T = unsafe { &*(opaque.cast::<T>()) };
+            F::call((owner, event))
+        }
+
+        let _: () = CanReceiveFn::ASSERT_IS_SOME;
+        let receive_cb: Option<unsafe extern "C" fn(*mut c_void, *const u8, c_int)> =
+            if ReceiveFn::is_some() {
+                Some(rust_receive_cb::<T, ReceiveFn>)
+            } else {
+                None
+            };
+        let event_cb: Option<unsafe extern "C" fn(*mut c_void, Event)> = if EventFn::is_some() {
+            Some(rust_event_cb::<T, EventFn>)
+        } else {
+            None
+        };
+
+        let mut chr = self.inner.borrow_mut();
+        // SAFETY: the borrow promises that the BQL is taken
+        unsafe {
+            bindings::qemu_chr_fe_set_handlers(
+                addr_of_mut!(*chr),
+                Some(rust_can_receive_cb::<T, CanReceiveFn>),
+                receive_cb,
+                event_cb,
+                None,
+                (owner as *const T as *mut T).cast::<c_void>(),
+                core::ptr::null_mut(),
+                true,
+            );
+        }
+    }
+
+    /// Disable the front-end's character device handlers.
+    pub fn disable_handlers(&self) {
+        let mut chr = self.inner.borrow_mut();
+        // SAFETY: the borrow promises that the BQL is taken
+        unsafe {
+            bindings::qemu_chr_fe_set_handlers(
+                addr_of_mut!(*chr),
+                None,
+                None,
+                None,
+                None,
+                core::ptr::null_mut(),
+                core::ptr::null_mut(),
+                true,
+            );
+        }
+    }
+
+    /// Notify that the frontend is ready to receive data.
+    pub fn accept_input(&self) {
+        let mut chr = self.inner.borrow_mut();
+        // SAFETY: the borrow promises that the BQL is taken
+        unsafe { bindings::qemu_chr_fe_accept_input(addr_of_mut!(*chr)) }
+    }
+
+    /// Temporarily borrow the character device, allowing it to be used
+    /// as an implementor of `Write`.  Note that it is not valid to drop
+    /// the big QEMU lock while the character device is borrowed, as
+    /// that might cause C code to write to the character device.
+    pub fn borrow_mut(&self) -> impl Write + '_ {
+        self.inner.borrow_mut()
+    }
+
+    /// Send a continuous stream of zero bits on the line if `enabled` is
+    /// true, or a short stream if `enabled` is false.
+    pub fn send_break(&self, long: bool) -> io::Result<()> {
+        let mut chr = self.inner.borrow_mut();
+        let mut duration: c_int = long.into();
+        // SAFETY: the borrow promises that the BQL is taken
+        let r = unsafe {
+            bindings::qemu_chr_fe_ioctl(
+                addr_of_mut!(*chr),
+                bindings::CHR_IOCTL_SERIAL_SET_BREAK as i32,
+                addr_of_mut!(duration).cast::<c_void>(),
+            )
+        };
+
+        errno::into_io_result(r).map(|_| ())
+    }
+
+    /// Write data to a character backend from the front end.  This function
+    /// will send data from the front end to the back end.  Unlike
+    /// `write`, this function will block if the back end cannot
+    /// consume all of the data attempted to be written.
+    ///
+    /// Returns the number of bytes consumed (0 if no associated Chardev) or an
+    /// error.
+    pub fn write(&self, buf: &[u8]) -> io::Result<usize> {
+        let len = buf.len().try_into().unwrap();
+        // SAFETY: qemu_chr_fe_write is thread-safe
+        let r = unsafe { bindings::qemu_chr_fe_write(self.inner.as_ptr(), buf.as_ptr(), len) };
+        errno::into_io_result(r).map(|cnt| cnt as usize)
+    }
+
+    /// Write data to a character backend from the front end.  This function
+    /// will send data from the front end to the back end.  Unlike
+    /// `write`, this function will block if the back end cannot
+    /// consume all of the data attempted to be written.
+    ///
+    /// Returns the number of bytes consumed (0 if no associated Chardev) or an
+    /// error.
+    pub fn write_all(&self, buf: &[u8]) -> io::Result<()> {
+        let len = buf.len().try_into().unwrap();
+        // SAFETY: qemu_chr_fe_write_all is thread-safe
+        let r = unsafe { bindings::qemu_chr_fe_write_all(self.inner.as_ptr(), buf.as_ptr(), len) };
+        errno::into_io_result(r).and_then(|cnt| {
+            if cnt as usize == buf.len() {
+                Ok(())
+            } else {
+                Err(ErrorKind::WriteZero.into())
+            }
+        })
+    }
+}
 
 unsafe impl ObjectType for Chardev {
     type Class = ChardevClass;
diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
index 47b6977828d..a3415a2ebcc 100644
--- a/rust/qemu-api/src/zeroable.rs
+++ b/rust/qemu-api/src/zeroable.rs
@@ -106,3 +106,4 @@ fn default() -> Self {
 impl_zeroable!(crate::bindings::MemoryRegionOps__bindgen_ty_2);
 impl_zeroable!(crate::bindings::MemoryRegionOps);
 impl_zeroable!(crate::bindings::MemTxAttrs);
+impl_zeroable!(crate::bindings::CharBackend);
-- 
2.48.1


