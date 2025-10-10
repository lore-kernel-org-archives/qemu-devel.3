Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38B7CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Elb-0008Qs-JU; Fri, 10 Oct 2025 11:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7ElX-0008PQ-Uh
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:10:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7ElE-00044B-Tg
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760109021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EVTFiamtz2g0JhSEELeH53XdwlrM4EAcjsX38InL3bs=;
 b=d3k36ZZQpvFH+QhrsQpQt317X9J44HNd01tK1SB6XfZVGiFqOP3YCXTQq/2xInjlErsYHm
 LnXe9DktVavrihxW3b8mS5hjBEoKKGvSrjObmVABrlzDYkGpyZLKwx1S+IRpJiFeXwjn4G
 cAo3FRxmlABwLuQkSpo5gGMKvFseJOM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-xBwoiKjtPF-Ez20Yhb0rYw-1; Fri, 10 Oct 2025 11:10:20 -0400
X-MC-Unique: xBwoiKjtPF-Ez20Yhb0rYw-1
X-Mimecast-MFC-AGG-ID: xBwoiKjtPF-Ez20Yhb0rYw_1760109019
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-639ffd6a3fbso2914707a12.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760109018; x=1760713818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EVTFiamtz2g0JhSEELeH53XdwlrM4EAcjsX38InL3bs=;
 b=FNIx3puGTvfc07gOsJhrOTKvoXpHUb4GyYtMNx4nY7IDAgz1rOQReIWtXRQZPCtF0R
 Nu6mizeTizX0kYmPwoZqTQ296wXFhHcGhCo2Pr4xmy05OlZANC/6xl+VuJV/0K+hjzK8
 a91RXEaDj/XpI44+jpMwTYsu0sOGvRZ+wxDTMSpwQQLZr3/DVCsamkvJmSVH4yr6qelX
 c/uUwO5SR/++Kp0N0UMkyrg8WpKTturRBG+NaIdxn2d4VcYrpLn73xUvBogYnfoK22j2
 cxAawOUoR0wRHMykjD7HEg8e68bnnOObinzuGi2taAJYdChuGcA8ZPtdJO8W2KZdYmNe
 kqnA==
X-Gm-Message-State: AOJu0YzH/fX+jHmmBXcxUMXp0uQ0Tqv2mxdo7c57SGqr3NyzPL1sw9Xr
 I1imkWhZ4p9aRCwbKv9osHb6JEjVmov4CaICFkXycCBTpX+tRdxYvbYePLb4SmTn/Xj6b1UI/tG
 pKPSIAzO/6VqmtkTSrb2aaQDIblGE8reseZ6o2YGLdb9dU4u5RKE/sISe1Af4kThwV1HaaLvjqP
 XLiG4+/6fjmYJbXzntWTipoaf2ETeuJB2G3MiXzSFt
X-Gm-Gg: ASbGncvamJ4yiQSQkaZ6jt1KgfPqaDWZ9LSh8Zi9AdsOhSGizI32VutX0i4uhxPUvsU
 hY9jwQTntR48AHBF792pR/PE7px2KM5p5a4eqSoMhYM04J27rUwbmOtc112Q379Umkez+5iHik/
 fK4CB8JfWzalOPcIHwv3HzcOvn2kCkboPYMLvx30/1tUrBuoR98PP3L/YgyUz9Vz20DI5YRhWtx
 RzUh+z+FpDTOk7g0fgfgDnEKwiHvdPRkxCbf03LjGfM0LJOc2BO3lIJm/duk8aio5GvVeZHOp1k
 4hsPSJd3eyd9si01nkp6cKbNII7axhrhYMXXU9Q0LQCs3djZunywF4DcwxcIdA/Gukb0+fAxDAu
 5DVbLXAq+TJWxE0Li/T2clZGYqhKmnKzhb4r2XDpw8g2I
X-Received: by 2002:a05:6402:4312:b0:637:f374:eeda with SMTP id
 4fb4d7f45d1cf-639d5c31e8amr11194083a12.20.1760109018458; 
 Fri, 10 Oct 2025 08:10:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBFLnVpPt/Ln/uvtHT2tQWvrWAdARD8vHorn1C7WvZ3OQXdduMcqlRT0aVQfDyO9PIJ3gPpg==
X-Received: by 2002:a05:6402:4312:b0:637:f374:eeda with SMTP id
 4fb4d7f45d1cf-639d5c31e8amr11194045a12.20.1760109017922; 
 Fri, 10 Oct 2025 08:10:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.231.162])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a5c134062sm2529652a12.36.2025.10.10.08.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 08:10:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	marcandre.lureau@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH 04/19] rust/qobject: add basic bindings
Date: Fri, 10 Oct 2025 17:09:49 +0200
Message-ID: <20251010151006.791038-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010151006.791038-1-pbonzini@redhat.com>
References: <20251010151006.791038-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is only a basic API, intended to be used by the serde traits.

Co-authored-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/util/wrapper.h          |   7 +
 rust/util/meson.build        |   6 +-
 rust/util/src/lib.rs         |   2 +
 rust/util/src/qobject/mod.rs | 317 +++++++++++++++++++++++++++++++++++
 4 files changed, 330 insertions(+), 2 deletions(-)
 create mode 100644 rust/util/src/qobject/mod.rs

diff --git a/rust/util/wrapper.h b/rust/util/wrapper.h
index b9ed68a01d8..0907dd59142 100644
--- a/rust/util/wrapper.h
+++ b/rust/util/wrapper.h
@@ -30,3 +30,10 @@ typedef enum memory_order {
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
+#include "qobject/qnull.h"
+#include "qobject/qbool.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
+#include "qobject/qobject.h"
+#include "qobject/qlist.h"
+#include "qobject/qdict.h"
diff --git a/rust/util/meson.build b/rust/util/meson.build
index 8ad344dccbd..ce468ea5227 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -36,8 +36,10 @@ _util_rs = static_library(
       'src/module.rs',
       'src/timer.rs',
     ],
-    {'.': _util_bindings_inc_rs}
-  ),
+    {'.': _util_bindings_inc_rs,
+    'qobject': [
+      'src/qobject/mod.rs',
+    ]}),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs, qom, qemuutil],
diff --git a/rust/util/src/lib.rs b/rust/util/src/lib.rs
index 16c89b95174..fe0128103c8 100644
--- a/rust/util/src/lib.rs
+++ b/rust/util/src/lib.rs
@@ -4,6 +4,8 @@
 pub mod error;
 pub mod log;
 pub mod module;
+#[macro_use]
+pub mod qobject;
 pub mod timer;
 
 pub use error::{Error, Result};
diff --git a/rust/util/src/qobject/mod.rs b/rust/util/src/qobject/mod.rs
new file mode 100644
index 00000000000..9c6f168d6e1
--- /dev/null
+++ b/rust/util/src/qobject/mod.rs
@@ -0,0 +1,317 @@
+//! `QObject` bindings
+//!
+//! This module implements bindings for QEMU's `QObject` data structure.
+//! The bindings integrate with `serde`, which take the role of visitors
+//! in Rust code.
+
+#![deny(clippy::unwrap_used)]
+
+use std::{
+    cell::UnsafeCell,
+    ffi::{c_char, CString},
+    mem::ManuallyDrop,
+    ptr::{addr_of, addr_of_mut},
+    sync::atomic::{AtomicUsize, Ordering},
+};
+
+use common::assert_field_type;
+
+use crate::bindings;
+
+/// A wrapper for a C `QObject`.
+///
+/// Because `QObject` is not thread-safe, the safety of these bindings
+/// right now hinges on treating them as immutable.  It is part of the
+/// contract with the `QObject` constructors that the Rust struct is
+/// only built after the contents are stable.
+///
+/// Only a bare bones API is public; production and consumption of `QObject`
+/// generally goes through `serde`.
+pub struct QObject(&'static UnsafeCell<bindings::QObject>);
+
+// SAFETY: the QObject API are not thread-safe other than reference counting;
+// but the Rust struct is only created once the contents are stable, and
+// therefore it obeys the aliased XOR mutable invariant.
+unsafe impl Send for QObject {}
+unsafe impl Sync for QObject {}
+
+// Since a QObject can be a floating-point value, and potentially a NaN,
+// do not implement Eq
+impl PartialEq for QObject {
+    fn eq(&self, other: &Self) -> bool {
+        unsafe { bindings::qobject_is_equal(self.0.get(), other.0.get()) }
+    }
+}
+
+impl QObject {
+    /// Construct a [`QObject`] from a C `QObjectBase` pointer.
+    /// The caller cedes its reference to the returned struct.
+    ///
+    /// # Safety
+    ///
+    /// The `QObjectBase` must not be changed from C code while
+    /// the Rust `QObject` lives
+    const unsafe fn from_base(p: *const bindings::QObjectBase_) -> Self {
+        QObject(unsafe { &*p.cast() })
+    }
+
+    /// Construct a [`QObject`] from a C `QObject` pointer.
+    /// The caller cedes its reference to the returned struct.
+    ///
+    /// # Safety
+    ///
+    /// The `QObject` must not be changed from C code while
+    /// the Rust `QObject` lives
+    pub const unsafe fn from_raw(p: *const bindings::QObject) -> Self {
+        QObject(unsafe { &*p.cast() })
+    }
+
+    /// Obtain a raw C pointer from a reference. `self` is consumed
+    /// and the C `QObject` pointer is leaked.
+    pub fn into_raw(self) -> *mut bindings::QObject {
+        let src = ManuallyDrop::new(self);
+        src.0.get()
+    }
+
+    /// Construct a [`QObject`] from a C `QObject` pointer.
+    /// The caller *does not* cede its reference to the returned struct.
+    ///
+    /// # Safety
+    ///
+    /// The `QObjectBase` must not be changed from C code while
+    /// the Rust `QObject` lives
+    unsafe fn cloned_from_base(p: *const bindings::QObjectBase_) -> Self {
+        let orig = unsafe { ManuallyDrop::new(QObject::from_base(p)) };
+        (*orig).clone()
+    }
+
+    /// Construct a [`QObject`] from a C `QObject` pointer.
+    /// The caller *does not* cede its reference to the returned struct.
+    ///
+    /// # Safety
+    ///
+    /// The `QObject` must not be changed from C code while
+    /// the Rust `QObject` lives
+    pub unsafe fn cloned_from_raw(p: *const bindings::QObject) -> Self {
+        let orig = unsafe { ManuallyDrop::new(QObject::from_raw(p)) };
+        (*orig).clone()
+    }
+
+    fn refcnt(&self) -> &AtomicUsize {
+        assert_field_type!(bindings::QObjectBase_, refcnt, usize);
+        let qobj = self.0.get();
+        unsafe { AtomicUsize::from_ptr(addr_of_mut!((*qobj).base.refcnt)) }
+    }
+}
+
+impl From<()> for QObject {
+    fn from(_null: ()) -> Self {
+        unsafe { QObject::cloned_from_base(addr_of!(bindings::qnull_.base)) }
+    }
+}
+
+impl<T> From<Option<T>> for QObject
+where
+    QObject: From<T>,
+{
+    fn from(o: Option<T>) -> Self {
+        o.map_or_else(|| ().into(), Into::into)
+    }
+}
+
+impl From<bool> for QObject {
+    fn from(b: bool) -> Self {
+        let qobj = unsafe { &*bindings::qbool_from_bool(b) };
+        unsafe { QObject::from_base(addr_of!(qobj.base)) }
+    }
+}
+
+macro_rules! from_int {
+    ($t:ty) => {
+        impl From<$t> for QObject {
+            fn from(n: $t) -> Self {
+                let qobj = unsafe { &*bindings::qnum_from_int(n.into()) };
+                unsafe { QObject::from_base(addr_of!(qobj.base)) }
+            }
+        }
+    };
+}
+
+from_int!(i8);
+from_int!(i16);
+from_int!(i32);
+from_int!(i64);
+
+macro_rules! from_uint {
+    ($t:ty) => {
+        impl From<$t> for QObject {
+            fn from(n: $t) -> Self {
+                let qobj = unsafe { &*bindings::qnum_from_uint(n.into()) };
+                unsafe { QObject::from_base(addr_of!(qobj.base)) }
+            }
+        }
+    };
+}
+
+from_uint!(u8);
+from_uint!(u16);
+from_uint!(u32);
+from_uint!(u64);
+
+macro_rules! from_double {
+    ($t:ty) => {
+        impl From<$t> for QObject {
+            fn from(n: $t) -> Self {
+                let qobj = unsafe { &*bindings::qnum_from_double(n.into()) };
+                unsafe { QObject::from_base(addr_of!(qobj.base)) }
+            }
+        }
+    };
+}
+
+from_double!(f32);
+from_double!(f64);
+
+impl From<CString> for QObject {
+    fn from(s: CString) -> Self {
+        let qobj = unsafe { &*bindings::qstring_from_str(s.as_ptr()) };
+        unsafe { QObject::from_base(addr_of!(qobj.base)) }
+    }
+}
+
+impl<A> FromIterator<A> for QObject
+where
+    Self: From<A>,
+{
+    fn from_iter<I: IntoIterator<Item = A>>(it: I) -> Self {
+        let qlist = unsafe { &mut *bindings::qlist_new() };
+        for elem in it {
+            let elem: QObject = elem.into();
+            let elem = elem.into_raw();
+            unsafe {
+                bindings::qlist_append_obj(qlist, elem);
+            }
+        }
+        unsafe { QObject::from_base(addr_of!(qlist.base)) }
+    }
+}
+
+impl<A> FromIterator<(CString, A)> for QObject
+where
+    Self: From<A>,
+{
+    fn from_iter<I: IntoIterator<Item = (CString, A)>>(it: I) -> Self {
+        let qdict = unsafe { &mut *bindings::qdict_new() };
+        for (key, val) in it {
+            let val: QObject = val.into();
+            let val = val.into_raw();
+            unsafe {
+                bindings::qdict_put_obj(qdict, key.as_ptr().cast::<c_char>(), val);
+            }
+        }
+        unsafe { QObject::from_base(addr_of!(qdict.base)) }
+    }
+}
+
+impl Clone for QObject {
+    fn clone(&self) -> Self {
+        self.refcnt().fetch_add(1, Ordering::Acquire);
+        QObject(self.0)
+    }
+}
+
+impl Drop for QObject {
+    fn drop(&mut self) {
+        if self.refcnt().fetch_sub(1, Ordering::Release) == 1 {
+            unsafe {
+                bindings::qobject_destroy(self.0.get());
+            }
+        }
+    }
+}
+
+#[allow(unused)]
+macro_rules! match_qobject {
+    (@internal ($qobj:expr) =>
+        $(() => $unit:expr,)?
+        $(bool($boolvar:tt) => $bool:expr,)?
+        $(i64($i64var:tt) => $i64:expr,)?
+        $(u64($u64var:tt) => $u64:expr,)?
+        $(f64($f64var:tt) => $f64:expr,)?
+        $(CStr($cstrvar:tt) => $cstr:expr,)?
+        $(QList($qlistvar:tt) => $qlist:expr,)?
+        $(QDict($qdictvar:tt) => $qdict:expr,)?
+        $(_ => $other:expr,)?
+    ) => {
+        loop {
+            let qobj_ = $qobj.0.get();
+            match unsafe { &* qobj_ }.base.type_ {
+                $($crate::bindings::QTYPE_QNULL => break $unit,)?
+                $($crate::bindings::QTYPE_QBOOL => break {
+                    let qbool__: *mut $crate::bindings::QBool = qobj_.cast();
+                    let $boolvar = unsafe { (&*qbool__).value };
+                    $bool
+                },)?
+                $crate::bindings::QTYPE_QNUM => {
+                    let qnum__: *mut $crate::bindings::QNum = qobj_.cast();
+                    let qnum__ = unsafe { &*qnum__ };
+                    match qnum__.kind {
+                        $crate::bindings::QNUM_I64 |
+                        $crate::bindings::QNUM_U64 |
+                        $crate::bindings::QNUM_DOUBLE => {}
+                        _ => {
+                            panic!("unreachable");
+                        }
+                    }
+
+                    match qnum__.kind {
+                        $($crate::bindings::QNUM_I64 => break {
+                            let $i64var = unsafe { qnum__.u.i64_ };
+                            $i64
+                        },)?
+                        $($crate::bindings::QNUM_U64 => break {
+                            let $u64var = unsafe { qnum__.u.u64_ };
+                            $u64
+                        },)?
+                        $($crate::bindings::QNUM_DOUBLE => break {
+                            let $f64var = unsafe { qnum__.u.dbl };
+                            $f64
+                        },)?
+                        _ => {}
+                    }
+                },
+                $($crate::bindings::QTYPE_QSTRING => break {
+                    let qstring__: *mut $crate::bindings::QString = qobj_.cast();
+                    let $cstrvar = unsafe { ::core::ffi::CStr::from_ptr((&*qstring__).string) };
+                    $cstr
+                },)?
+                $($crate::bindings::QTYPE_QLIST => break {
+                    let qlist__: *mut $crate::bindings::QList = qobj_.cast();
+                    let $qlistvar = unsafe { &*qlist__ };
+                    $qlist
+                },)?
+                $($crate::bindings::QTYPE_QDICT => break {
+                    let qdict__: *mut $crate::bindings::QDict = qobj_.cast();
+                    let $qdictvar = unsafe { &*qdict__ };
+                    $qdict
+                },)?
+                _ => ()
+            };
+            $(break $other;)?
+            #[allow(unreachable_code)]
+            {
+                panic!("unreachable");
+            }
+        }
+    };
+
+    // first cleanup the syntax a bit, checking that there's at least
+    // one pattern and always adding a trailing comma
+    (($qobj:expr) =>
+        $($type:tt$(($val:tt))? => $code:expr ),+ $(,)?) => {
+            match_qobject!(@internal ($qobj) =>
+                $($type $(($val))? => $code,)+)
+    };
+}
+#[allow(unused_imports)]
+use match_qobject;
-- 
2.51.0


