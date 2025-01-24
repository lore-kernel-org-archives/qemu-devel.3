Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD8BC0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGHg-0001qZ-FA; Fri, 24 Jan 2025 04:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGD-0007Yt-DG
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGG6-0003ww-Gw
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qfBGu2d09XoRzvMmTPlk/daGZbhlpGqkbhXjGEOkEVc=;
 b=ZTXY+tMJdaP/23nyNv96gq4bmIRE2FRlI9L52GxK+i1Gk5LivJys1sF587XnbwIrU81kKA
 pV1xtmT64bdUISRk65BYKM6m+G1FBpdMuR1DMWMfHZWL8DoQCew8/kSL5fR34WIhdprqTX
 f8uVHQ3Fz1/TRH+sUpwScX5Ho/xiS4I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-0ntV0aI1OXKhwWsnGVJcyw-1; Fri, 24 Jan 2025 04:45:47 -0500
X-MC-Unique: 0ntV0aI1OXKhwWsnGVJcyw-1
X-Mimecast-MFC-AGG-ID: 0ntV0aI1OXKhwWsnGVJcyw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43628594d34so10310325e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711946; x=1738316746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qfBGu2d09XoRzvMmTPlk/daGZbhlpGqkbhXjGEOkEVc=;
 b=DTj/yGOy2PcKeBRGIPgGMG4nVpv8ajACJuCvydfHfiITZmUvhmiEAzz1LvOIx/4DEM
 AQkvqCQpMiE0nAuyjoFww9y64qK/YpL8UfdZZNPxLPIoQQLqz3otfY8y8sSiKt58yHhK
 5ZFM2zSt8iHJY0cWibcYnFQpK5rUoT2EgLI6zh5X0N7wpPeOTnJTbdidvesM6a04z5de
 78A7EDt9NDpzYI/9pKKO+vKirGy25ZWcomb3jbwSX9oVp52+rWAZ+Kcc67TpIuL4pK/9
 p4bsMgcdVwn6/gIGb/DCqJnXKyvq7JTwqR+mdhIEw9s260SXPNiE3J/RYkz1YfnZjg1a
 MMcA==
X-Gm-Message-State: AOJu0YxhDLEh43EZJZBPcADegmTp0PWqQ5vOVPvNJXUaS6gpTJGTJiGw
 J1uG88gnapN4UJbKnYGOtPTZsIMiZcg2dGefoPFAoFi9D2M6cmwD9fHc7yWzjLjL2p+WT9tcUJ+
 +TAT6vEAQ+1c0k0cLLIY+gH2fGzqHG6xShTccjD5hZfe8Hop36vAt+drAVZUMTAbE3c3tsNPQI0
 Jp/Jy/QQOQvwrDncV7WKBtl/Rl15FmHXO6PVcjxIE=
X-Gm-Gg: ASbGncutw20y2hwQpfx0bBXe6iTjBvMZuWK+dlONdgYicv39KOr7uEYLUpw1Y+jZqgC
 GyRsjOTKVz4tDrEnMf2jyFpcsf241VNRR85/X+IPgk2XHhvteOoeEAxHGzKTiHLFd9KUBdEuSE3
 LdsSJ52vVg79Tx21MD5tEAHxgRA84iSKqkvVZGRUKHwXniHl4g66V0sOfspMa2SmbLgqfYxYKzS
 VZFLy4Yp7Ul15QsMBlQQCQ1CTaE53kGn/ZFCx9rr9hYnvzDihaNdiPu+r+XXsUwDAEcbELGiQ==
X-Received: by 2002:a05:600c:1d14:b0:436:46f9:4fc6 with SMTP id
 5b1f17b1804b1-438913d63cfmr269424625e9.8.1737711946120; 
 Fri, 24 Jan 2025 01:45:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMBiOIJTcrAxD3PfhXn++d3eB+X2m6jKfcqYMhRShtc6/pp+0QMNXb9L/fS+aThRiSoSY9Kw==
X-Received: by 2002:a05:600c:1d14:b0:436:46f9:4fc6 with SMTP id
 5b1f17b1804b1-438913d63cfmr269424355e9.8.1737711945645; 
 Fri, 24 Jan 2025 01:45:45 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4c6fadsm20156545e9.32.2025.01.24.01.45.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/48] rust: vmstate: add public utility macros to implement
 VMState
Date: Fri, 24 Jan 2025 10:44:24 +0100
Message-ID: <20250124094442.13207-31-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 61 ++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index a262c315da1..9ac699b73b7 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -4,13 +4,18 @@
 
 //! Helper macros to declare migration state for device models.
 //!
-//! This module includes three families of macros:
+//! This module includes four families of macros:
 //!
 //! * [`vmstate_unused!`](crate::vmstate_unused) and
 //!   [`vmstate_of!`](crate::vmstate_of), which are used to express the
 //!   migration format for a struct.  This is based on the [`VMState`] trait,
 //!   which is defined by all migrateable types.
 //!
+//! * [`impl_vmstate_forward`](crate::impl_vmstate_forward) and
+//!   [`impl_vmstate_bitsized`](crate::impl_vmstate_bitsized), which help with
+//!   the definition of the [`VMState`] trait (respectively for transparent
+//!   structs and for `bilge`-defined types)
+//!
 //! * helper macros to declare a device model state struct, in particular
 //!   [`vmstate_subsections`](crate::vmstate_subsections) and
 //!   [`vmstate_fields`](crate::vmstate_fields).
@@ -134,7 +139,9 @@ macro_rules! info_enum_to_ref {
 /// # Safety
 ///
 /// The contents of this trait go straight into structs that are parsed by C
-/// code and used to introspect into other structs.  Be careful.
+/// code and used to introspect into other structs.  Generally, you don't need
+/// to implement it except via macros that do it for you, such as
+/// `impl_vmstate_bitsized!`.
 pub unsafe trait VMState {
     /// The `info` member of a `VMStateField` is a pointer and as such cannot
     /// yet be included in the [`BASE`](VMState::BASE) associated constant;
@@ -188,7 +195,9 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateFlags
 /// * an array of any of the above
 ///
 /// In order to support other types, the trait `VMState` must be implemented
-/// for them.
+/// for them.  The macros
+/// [`impl_vmstate_bitsized!`](crate::impl_vmstate_bitsized)
+/// and [`impl_vmstate_forward!`](crate::impl_vmstate_forward) help with this.
 #[macro_export]
 macro_rules! vmstate_of {
     ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])? $(,)?) => {
@@ -276,6 +285,32 @@ pub const fn with_varray_multiply(mut self, num: u32) -> VMStateField {
     }
 }
 
+/// This macro can be used (by just passing it a type) to forward the `VMState`
+/// trait to the first field of a tuple.  This is a workaround for lack of
+/// support of nested [`offset_of`](core::mem::offset_of) until Rust 1.82.0.
+///
+/// # Examples
+///
+/// ```
+/// # use qemu_api::vmstate::impl_vmstate_forward;
+/// pub struct Fifo([u8; 16]);
+/// impl_vmstate_forward!(Fifo);
+/// ```
+#[macro_export]
+macro_rules! impl_vmstate_forward {
+    // This is similar to impl_vmstate_transparent below, but it
+    // uses the same trick as vmstate_of! to obtain the type of
+    // the first field of the tuple
+    ($tuple:ty) => {
+        unsafe impl $crate::vmstate::VMState for $tuple {
+            const SCALAR_TYPE: $crate::vmstate::VMStateFieldType =
+                $crate::call_func_with_field!($crate::vmstate::vmstate_scalar_type, $tuple, 0);
+            const BASE: $crate::bindings::VMStateField =
+                $crate::call_func_with_field!($crate::vmstate::vmstate_base, $tuple, 0);
+        }
+    };
+}
+
 // Transparent wrappers: just use the internal type
 
 macro_rules! impl_vmstate_transparent {
@@ -296,6 +331,26 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
 impl_vmstate_transparent!(crate::cell::BqlCell<T> where T: VMState);
 impl_vmstate_transparent!(crate::cell::BqlRefCell<T> where T: VMState);
 
+#[macro_export]
+macro_rules! impl_vmstate_bitsized {
+    ($type:ty) => {
+        unsafe impl $crate::vmstate::VMState for $type {
+            const SCALAR_TYPE: $crate::vmstate::VMStateFieldType =
+                                        <<<$type as ::bilge::prelude::Bitsized>::ArbitraryInt
+                                          as ::bilge::prelude::Number>::UnderlyingType
+                                         as $crate::vmstate::VMState>::SCALAR_TYPE;
+            const BASE: $crate::bindings::VMStateField =
+                                        <<<$type as ::bilge::prelude::Bitsized>::ArbitraryInt
+                                          as ::bilge::prelude::Number>::UnderlyingType
+                                         as $crate::vmstate::VMState>::BASE;
+            const VARRAY_FLAG: $crate::bindings::VMStateFlags =
+                                        <<<$type as ::bilge::prelude::Bitsized>::ArbitraryInt
+                                          as ::bilge::prelude::Number>::UnderlyingType
+                                         as $crate::vmstate::VMState>::VARRAY_FLAG;
+        }
+    };
+}
+
 // Scalar types using predefined VMStateInfos
 
 macro_rules! impl_vmstate_scalar {
-- 
2.48.1


