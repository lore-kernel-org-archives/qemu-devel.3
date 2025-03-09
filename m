Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2AEC28B2E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 10:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trDx6-0008Ok-RV; Sun, 09 Mar 2025 06:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwx-0008AU-5z
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:32:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwu-00043p-LB
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741516320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X6mhZ60j81W24GLpu0Kz4HHiix+PtR6lsoSKDnwJfGI=;
 b=MMkrTM/5HHiJ+a87rpt4UN92DsaKq9Uj6Oa8ChLqUrkFHPijA1bQOwJpsE0LobY4x5+tWM
 VQbKvGtAlIeDB1pCbIId1H3g8ZGGBFsVThLmcJD9eXZS/CYxx7oOzzvnuGcb/P1c8TWMv0
 gBh2j1jw3fiB7A52S8dHORwMAauZq5k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-FqHsJ4UyO6uxHSszynNXaQ-1; Sun, 09 Mar 2025 06:31:58 -0400
X-MC-Unique: FqHsJ4UyO6uxHSszynNXaQ-1
X-Mimecast-MFC-AGG-ID: FqHsJ4UyO6uxHSszynNXaQ_1741516317
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39131851046so869609f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 03:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741516316; x=1742121116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X6mhZ60j81W24GLpu0Kz4HHiix+PtR6lsoSKDnwJfGI=;
 b=ZqRVIPuyK4XU7nOfgrmws/8nx7me6RHFwGZamlqtItCFQh76kwv81m8+scY9dUGnim
 twsAFexFg/H0rXi8AlYcVTFsxISuAM/1yN7RT0oF/e3Vf5nmlFLZoZxi8SyKINv4zTX5
 refUSKpKEkyLPGNit/O79ZXf8MEWfh4c8gVctixBIPAOITb93aKhiwY3OoQcUFPAQOqQ
 rIvDskwRvTq0rdPfs2fKjcpvDmPXxYr45eQAVX6pmoQcvw8bzXOCg9qFUHGIBajnBIdS
 5Y5wiWwKARMJRyvTM1QbXaTJikEIlESwFNJ4351uR9V53Qk7I7Vl7go12oTQUfMZTPT4
 b/tA==
X-Gm-Message-State: AOJu0YyirmjObcXT7SIyJIHPoBAOleps2xzXa3a6qPUXLun9Xdeo4eV5
 YFWbxwq4PPds+uWIkJu3TYx6YW9TBowf5xuIGKhsAs9Sg3IE6PN8D/4RLCfx7doyaHYjNW4bOHQ
 Yo4C4e0PDdSzFfZOQRidkE8REq2DTusqi7KE9COL+Ue05Bsqzp5DO+WJVoJMy+RxxejYPoBnM/5
 1AXOvxCmmYhyNhu2ZkdUEXwDo9/RjHXXE5lf1TN1w=
X-Gm-Gg: ASbGnctm9N7xTJ0dJ/UdUzyMlCVO4YubbJzpPXLhKfoRZyA6mfFqN90e0609SVhC6VD
 O10HEgyEd04y6MQWDMm1nusCO2BqxGr/r4Btg0/Vb/k7aA4pYNmBA+AnsR+AnOgoHsxPtvje/+X
 SYRfZjdgLvTc2g6wt5JpWJ1VFzeXIkPxeMi1PMX6RqEj+6CWX81ojSoMyZG0FXu9POHBGhOt7s5
 u7E8IgTO5EI3UzqwLn0eOcXF8EDjnjmT1W4ywv81ogIY13MRmz+8kwTF/2XgvTGwKgGXN6bHVs4
 udKmh1sbFm5qZY4K9EJXaw==
X-Received: by 2002:adf:8b97:0:b0:391:42f2:5c7b with SMTP id
 ffacd0b85a97d-39142f25d2emr1203125f8f.16.1741516316148; 
 Sun, 09 Mar 2025 03:31:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh85U/SxwTSwKIMrw3PXpjjcNN7o8n2e2VcD9C/kRZaBcMNt3wcPnoFYD97FHkSIc4XlS/Rg==
X-Received: by 2002:adf:8b97:0:b0:391:42f2:5c7b with SMTP id
 ffacd0b85a97d-39142f25d2emr1203102f8f.16.1741516315587; 
 Sun, 09 Mar 2025 03:31:55 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfdb9sm11401560f8f.27.2025.03.09.03.31.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 03:31:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/25] rust: chardev: provide basic bindings to character
 devices
Date: Sun,  9 Mar 2025 11:31:10 +0100
Message-ID: <20250309103120.1116448-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309103120.1116448-1-pbonzini@redhat.com>
References: <20250309103120.1116448-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 rust/qemu-api/src/chardev.rs  | 242 +++++++++++++++++++++++++++++++++-
 rust/qemu-api/src/zeroable.rs |   1 +
 3 files changed, 255 insertions(+), 5 deletions(-)

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
index a35b9217e90..11e6c45afaf 100644
--- a/rust/qemu-api/src/chardev.rs
+++ b/rust/qemu-api/src/chardev.rs
@@ -3,10 +3,28 @@
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
+use crate::{
+    bindings,
+    callbacks::FnCall,
+    cell::{BqlRefMut, Opaque},
+    prelude::*,
+};
 
 /// A safe wrapper around [`bindings::Chardev`].
 #[repr(transparent)]
@@ -14,6 +32,226 @@
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


