Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92487C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 09:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYiEF-0001wk-8I; Fri, 17 Jan 2025 04:01:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYiEA-0001uM-JT
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:01:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYiE8-00084n-BU
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737104471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EthFAxtcH1LlnwWWbd3845lmR+MXoAUnpKNrFECKNWo=;
 b=gA63xjTlXq2gfnT9Lv2u+JGuupX6+UA3tFi8j/Uk4PGEV4so39C/Y9Oj+r5dT8qMnHq9zD
 SMYkEunKsS5q09Ot2SYTzl5Cppo/rYhqjVu9zMixTwbsRR6SjOFIfWupIvIXN8hQ0k/he7
 WDf/g/ClRvVKwDIhipyl1/6Bp9sB+8M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-nuoTdXq2Nca4KxLCrrsEJA-1; Fri, 17 Jan 2025 04:01:09 -0500
X-MC-Unique: nuoTdXq2Nca4KxLCrrsEJA-1
X-Mimecast-MFC-AGG-ID: nuoTdXq2Nca4KxLCrrsEJA
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa67f18cb95so183429266b.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 01:01:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737104467; x=1737709267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EthFAxtcH1LlnwWWbd3845lmR+MXoAUnpKNrFECKNWo=;
 b=F6QDnAzEq1+6L3GJImUKtOZsq9x3f6M6gckQxqQP/fcgxfBfdwFDL+WwwI+JPwlU0B
 g6rFJZLaZsD5LNNAzkwF5ZXKgX+W75x/GyuFpQpxkIksKjX6qqBTLlgLhXc/PaGt5LOS
 CPFqzY0N5XYjKzzNjZ/7VTBi2tQPN9+zIkkSCZtTSlh8Ofz0A7Aul48YdmCSvGBZEGxw
 TV/wgFhdko6m83iWA9aGIrCx2mNBPPBuJ4HGVQSFSkrvnwATOPCsdhoaCc48xev/t7sZ
 BTtmx/beVwF7oDOXBpwgiyc1Z6hDSggBJWPw77B4eBAeOtA1ZG8p43ljsnKG/1CsiAnK
 tBVA==
X-Gm-Message-State: AOJu0YyBt/HVFPT/6eqD1UPxiafy6/V3HBo1py6ydMrU2Urp3wOmYwMo
 czIOzTawQJ79i9XmLzRThVd4qPNXITx4gcuwnchcYg1E2VcL6oLx8MTHS8mMRR3+uOry41qErRi
 77DMda48vvCrl7P8xUi6kkxE6BjSxNWLCwNLzf70CIpMEm1aYM5OXvLqYt8P+a56epbXnAvsSYx
 mT+6Cldvf5XiBKiMekHZ8c0ui6z8T+2S7oi+gmGWY=
X-Gm-Gg: ASbGncvr/DspVENR/T/gVSy3qv+88JxWp0CH229YDR6HNQCXXQHSDkzIWvBprzWKvG0
 yh5BvytpkmI27I56zWZ84kweovBmNLPZqxkh19rw1M/tmoVj1jfDzkmiFZK8VuGqGZjdxDVAv6D
 gOFwqJwcLPS2T3L+ry0BQhaWi/RuYzKVbYKNyeHQe7L0FukwW4SlHLhzFxfDV2W29knvqeSadfz
 ghyuNsYH3ZHGHq213z6KXtFoR7sblroYCOoCb3vJA9F5A1zsgJYiQpLy8Fc
X-Received: by 2002:a17:907:6d09:b0:aa6:8935:ae71 with SMTP id
 a640c23a62f3a-ab38b0b7f21mr158639866b.12.1737104466879; 
 Fri, 17 Jan 2025 01:01:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHl/IKBTGZxcZgEsrNvJ9xZiD9KHQ8ZGesgLhiG9rSCCkYdsh+PBqgBcViTMwpptnt2vvXy/g==
X-Received: by 2002:a17:907:6d09:b0:aa6:8935:ae71 with SMTP id
 a640c23a62f3a-ab38b0b7f21mr158636166b.12.1737104466250; 
 Fri, 17 Jan 2025 01:01:06 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384c5c486sm138716166b.12.2025.01.17.01.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 01:01:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com,
	qemu-rust@nongnu.org
Subject: [PATCH 06/10] rust: vmstate: add public utility macros to implement
 VMState
Date: Fri, 17 Jan 2025 10:00:42 +0100
Message-ID: <20250117090046.1045010-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117090046.1045010-1-pbonzini@redhat.com>
References: <20250117090046.1045010-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
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
index b0a2ce105cc..8f32c72a0fd 100644
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
@@ -188,7 +195,9 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateField
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
2.47.1


