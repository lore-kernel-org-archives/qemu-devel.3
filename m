Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE808C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 09:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYiE0-0001r8-0g; Fri, 17 Jan 2025 04:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYiDs-0001pH-AL
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:01:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYiDq-00082V-Au
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737104457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cvXKMgEe/XNJgIWOzfE8NdJOesl0DV+BIsQqqBzCXzQ=;
 b=JGnQ4OmNe2KT/bAuFXKMfxM01hAfja+RIscWwwPYsS292uWYtqoK9Da4Kp/HH79Q3VxhVA
 U/2io2dppbiGJycoRCkQ0QkykJBsIDDYgZnE49vcHB29BWunNlTg5AXMB2JdEQpq2Cbkbm
 1zSxNNZwyZiCF2xMVJ5/J7Z1ZhOIwBQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-k7XQP0jwNBC-3wNu7Bfecw-1; Fri, 17 Jan 2025 04:00:55 -0500
X-MC-Unique: k7XQP0jwNBC-3wNu7Bfecw-1
X-Mimecast-MFC-AGG-ID: k7XQP0jwNBC-3wNu7Bfecw
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa6a87f324cso207798366b.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 01:00:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737104453; x=1737709253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cvXKMgEe/XNJgIWOzfE8NdJOesl0DV+BIsQqqBzCXzQ=;
 b=t4psl1318frx7dNJlwVlaiXtPYbtRAhPd5vhKrx/FiWq8z9sIVN45YqQjbh0uRHqx/
 oKDuO2Ep/Ns6ce+ksyP9EFUuKw6ROu5GjKK5JpAq2T+9oNDne55QEwKMsuLUL4mYQnTh
 d2kAD0CLyM5CAN2vZhXxQnYROSaWZtK/HVubGZwsc4qERnkMyVTYwcwH4RSPvoqhY5ZH
 oa9D96RImm8zc9NkTpyRRL67asyDdTqOjFfKdRnOVYcF3TAHDlLAnCqNjHfsAmSPP7EU
 V3jwXWbf8CZpMHzSPfWB2y76Wl7ZNs3/kQiwr8KkB4VBFj6MNgRaBTLgWqCOxNLGeUyI
 9G0A==
X-Gm-Message-State: AOJu0YzLN4vHAL4wYYV8sTFxOURup5sJEFUKKiODuA/Ym9DLCVokSXyf
 Fedh2+nYgOMcYOiNEDgr+9yd1QVRHX6FX/lHihR904bYiB/3dvoWQfX48dMBtTJB8jC7xKwgWho
 7gL/+yMiWmuiRYyGcpTvnvBV5LGO6XpbCOzI3UpM5ddR+YCQ52qwJ6DYoEQqumlyhNZKdEBRA9E
 J7QI6hyEe3qEnt2DPerkY1jkGc8GwLBgddn4pEBEU=
X-Gm-Gg: ASbGncvIWlBoKwmQCMseTSMn/sd59L0oNVUQYxxVt6VgJoDNIiCTSaL8vtlgj1Rc40s
 GoWmySDVw1Hygjpegb3GK5VjX7vTk62a6HjQmx9FsgXgyU9K3uALfyxB4DI8EJJlftw1iBJ0c8R
 O8/gI/lukXR3iQLKuZPtXCmo+2NzAhXhnh3iDzHYDg3K5D334J9rpV1reJhXmo3nKeN0t3Pd0a3
 iIk4AWgGMggK6eFgw4a4Dxh1FT3V9m+wKRvr9P6ogxDemBq94VWb2mEVmC0
X-Received: by 2002:a17:907:3f90:b0:aa6:6f92:74b1 with SMTP id
 a640c23a62f3a-ab38b231a83mr181801066b.13.1737104452969; 
 Fri, 17 Jan 2025 01:00:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvqhUySBEw8Q64pnKUaRda8OnfrPnt/UYfBdTwM2ymJyrk5d86ahPNa4PT2etge9Az8gYbtQ==
X-Received: by 2002:a17:907:3f90:b0:aa6:6f92:74b1 with SMTP id
 a640c23a62f3a-ab38b231a83mr181793666b.13.1737104452035; 
 Fri, 17 Jan 2025 01:00:52 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce1f1asm138026466b.58.2025.01.17.01.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 01:00:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com,
	qemu-rust@nongnu.org
Subject: [PATCH 01/10] rust: vmstate: add new type safe implementation
Date: Fri, 17 Jan 2025 10:00:37 +0100
Message-ID: <20250117090046.1045010-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117090046.1045010-1-pbonzini@redhat.com>
References: <20250117090046.1045010-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
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

The existing translation of the C macros for vmstate does not make
any attempt to type-check vmstate declarations against the struct, so
introduce a new system that computes VMStateField based on the actual
struct declaration.

Macros do not have full access to the type system, therefore a full
implementation of this scheme requires a helper trait to analyze the
type and produce a VMStateField from it; a macro "vmstate_of!" accepts
arguments similar to "offset_of!" and tricks the compiler into looking
up the trait for the right type.

The patch introduces not just vmstate_of!, but also the slightly too
clever enabling macro call_func_with_field!.  The particular trick used
here was proposed on the users.rust-lang.org forum, so I take no merit
and all the blame.

Introduce the trait and some functions to access it; the actual
implementation comes later.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/prelude.rs |   2 +
 rust/qemu-api/src/vmstate.rs | 113 +++++++++++++++++++++++++++++++++--
 2 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index 4ea70b9c823..2dc86e19b29 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -18,3 +18,5 @@
 pub use crate::qom_isa;
 
 pub use crate::sysbus::SysBusDeviceMethods;
+
+pub use crate::vmstate::VMState;
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 63c897abcdf..b839a7d6b7f 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -4,13 +4,114 @@
 
 //! Helper macros to declare migration state for device models.
 //!
-//! Some macros are direct equivalents to the C macros declared in
-//! `include/migration/vmstate.h` while
-//! [`vmstate_subsections`](crate::vmstate_subsections) and
-//! [`vmstate_fields`](crate::vmstate_fields) are meant to be used when
-//! declaring a device model state struct.
+//! This module includes three families of macros:
+//!
+//! * [`vmstate_unused!`](crate::vmstate_unused) and
+//!   [`vmstate_of!`](crate::vmstate_of), which are used to express the
+//!   migration format for a struct.  This is based on the [`VMState`] trait,
+//!   which is defined by all migrateable types.
+//!
+//! * helper macros to declare a device model state struct, in particular
+//!   [`vmstate_subsections`](crate::vmstate_subsections) and
+//!   [`vmstate_fields`](crate::vmstate_fields).
+//!
+//! * direct equivalents to the C macros declared in
+//!   `include/migration/vmstate.h`. These are not type-safe and should not be
+//!   used if the equivalent functionality is available with `vmstate_of!`.
 
-pub use crate::bindings::VMStateDescription;
+use core::marker::PhantomData;
+
+pub use crate::bindings::{VMStateDescription, VMStateField};
+
+/// This macro is used to call a function with a generic argument bound
+/// to the type of a field.  The function must take a
+/// [`PhantomData`]`<T>` argument; `T` is the type of
+/// field `$field` in the `$typ` type.
+///
+/// # Examples
+///
+/// ```
+/// # use qemu_api::call_func_with_field;
+/// # use core::marker::PhantomData;
+/// const fn size_of_field<T>(_: PhantomData<T>) -> usize {
+///     std::mem::size_of::<T>()
+/// }
+///
+/// struct Foo {
+///     x: u16,
+/// };
+/// // calls size_of_field::<u16>()
+/// assert_eq!(call_func_with_field!(size_of_field, Foo, x), 2);
+/// ```
+#[macro_export]
+macro_rules! call_func_with_field {
+    // Based on the answer by user steffahn (Frank Steffahn) at
+    // https://users.rust-lang.org/t/inferring-type-of-field/122857
+    // and used under MIT license
+    ($func:expr, $typ:ty, $($field:tt).+) => {
+        $func(loop {
+            #![allow(unreachable_code)]
+            const fn phantom__<T>(_: &T) -> ::core::marker::PhantomData<T> { ::core::marker::PhantomData }
+            // Unreachable code is exempt from checks on uninitialized values.
+            // Use that trick to infer the type of this PhantomData.
+            break ::core::marker::PhantomData;
+            break phantom__(&{ let value__: $typ; value__.$($field).+ });
+        })
+    };
+}
+
+/// A trait for types that can be included in a device's migration stream.  It
+/// provides the base contents of a `VMStateField` (minus the name and offset).
+///
+/// # Safety
+///
+/// The contents of this trait go straight into structs that are parsed by C
+/// code and used to introspect into other structs.  Be careful.
+pub unsafe trait VMState {
+    /// The base contents of a `VMStateField` (minus the name and offset) for
+    /// the type that is implementing the trait.
+    const BASE: VMStateField;
+}
+
+/// Internal utility function to retrieve a type's `VMStateField`;
+/// used by [`vmstate_of!`](crate::vmstate_of).
+pub const fn vmstate_base<T: VMState>(_: PhantomData<T>) -> VMStateField {
+    T::BASE
+}
+
+/// Return the `VMStateField` for a field of a struct.  The field must be
+/// visible in the current scope.
+///
+/// In order to support other types, the trait `VMState` must be implemented
+/// for them.
+#[macro_export]
+macro_rules! vmstate_of {
+    ($struct_name:ty, $field_name:ident $(,)?) => {
+        $crate::bindings::VMStateField {
+            name: ::core::concat!(::core::stringify!($field_name), "\0")
+                .as_bytes()
+                .as_ptr() as *const ::std::os::raw::c_char,
+            offset: $crate::offset_of!($struct_name, $field_name),
+            // Compute most of the VMStateField from the type of the field.
+            ..$crate::call_func_with_field!(
+                $crate::vmstate::vmstate_base,
+                $struct_name,
+                $field_name
+            )
+        }
+    };
+}
+
+// Add a couple builder-style methods to VMStateField, allowing
+// easy derivation of VMStateField constants from other types.
+impl VMStateField {
+    #[must_use]
+    pub const fn with_version_id(mut self, version_id: i32) -> Self {
+        assert!(version_id >= 0);
+        self.version_id = version_id;
+        self
+    }
+}
 
 #[doc(alias = "VMSTATE_UNUSED_BUFFER")]
 #[macro_export]
-- 
2.47.1


