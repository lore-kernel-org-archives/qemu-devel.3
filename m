Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18075C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSenv-0006XV-Dd; Fri, 20 Jun 2025 12:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSens-0006X0-1u
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSenq-0000Fk-8m
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750437681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P0ToVja12+bxntDkM4pyBWaD2U29e/LsVsIKe4q19RE=;
 b=TLwcbRKwPLCxW5XzClk8SD2EniBPmlnZN76esUnQ/dQQRvoW/Wi0tQXZEAMZ7mHkd84baH
 Pkuf0g4y9v/uNg9ZWHBYsTbXFOehD2Ofho5FSTxuXfs065pIi0BFmvEXS3i8Xll14/LIzp
 XWPiFJB7mHX7Us4/bNlgq5l+Z0/O+6E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-FcvnPXdGOOGAuNXNCHySiw-1; Fri, 20 Jun 2025 12:41:20 -0400
X-MC-Unique: FcvnPXdGOOGAuNXNCHySiw-1
X-Mimecast-MFC-AGG-ID: FcvnPXdGOOGAuNXNCHySiw_1750437679
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ad89a3bcc62so152222066b.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750437678; x=1751042478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P0ToVja12+bxntDkM4pyBWaD2U29e/LsVsIKe4q19RE=;
 b=BibAXEYiKdY691R+7ysMNrO7B/onuaZTxHy7TY5HjC5js5KKyEQ/ppBRyBR1siRw2A
 sGmSrWBFX79M/0pVFpFGFEMgOjCpFuwfoftzSZaD2RJ/MjeGHjRvig7zhNT309FR/UWY
 VAnqrrXEAZV0y/W5z4G2QpUM6l7VVRQTaoKMPe1zCbVZGZQbBNC9X8CW75V/9Hz01zvo
 8kOLZm1lHffWlXLcUNs8tre7CoxneW6Glo1TyGE3pvfELEcDYpfdirY9FICLKnjewco4
 DPA7tUZbqizlAYMd1SPqGU1TctjVzsYUiPJN5kxKHXKJEnp46DoWeeY7BkqbA7YqxwYq
 ulAA==
X-Gm-Message-State: AOJu0Yx/907Qaxakyz+P/SVkcHN0iWFAFsiVmbp9QER+46CmhByatHYK
 IiVamvfCX8XdzymGhEWS2Bcb3OVPptYbmKkzO0F7DYSHMfbRy1BhoynEtpb0hqithCs7c+U+sax
 Cthm7QOyDFjms9scbJrufp/PGTATwMrG5H+JaD21aw3p5qZc6FxZ9aWGv8PlKcbn4XUYSOdk6sz
 R2hEBTngTcTINMG9yyiMpvkxvEhTjHlrp/98AWrU1r
X-Gm-Gg: ASbGncvSZjyTim+4afLgT3akYaoefs8KxrGQtkiHuLZw0FOdYSBqcHyQoiCVJFPXBDY
 O2GT649NzVNtv92TgZ0zVI+I+6VRm2dzi4QVUr3lU0t9Wtj04NY2EkqewFXw952Vylxv0Q7H085
 gilbBaOnNvquyUal5NtE2eJJZD9BVfDd2mW4PifdENA6WenXsImEZxu5ogXYYSpbQkHEuPbxeeA
 WiD2rSmg0+jbCa9nTdfswGy1pLVgFGrs8EECrnZBexxaPUQtfU+MjM4ZtNdVqjMsWPJExBs5dlJ
 EtuWA6+tp+WzTKDv5aSmidyTmA==
X-Received: by 2002:a17:907:1b29:b0:ad8:9257:573d with SMTP id
 a640c23a62f3a-ae057a0826bmr325331966b.24.1750437677760; 
 Fri, 20 Jun 2025 09:41:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv+cX4lo9hxNHLN1cuQI0Zi/KLvmxBBXi8M9d4HlRrjFgbQzjm+HjNmik3eZjbeofkiwtadA==
X-Received: by 2002:a17:907:1b29:b0:ad8:9257:573d with SMTP id
 a640c23a62f3a-ae057a0826bmr325329366b.24.1750437677218; 
 Fri, 20 Jun 2025 09:41:17 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae053edc0e9sm188735466b.54.2025.06.20.09.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:41:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 08/24] rust: qom: make ParentInit lifetime-invariant
Date: Fri, 20 Jun 2025 18:40:36 +0200
Message-ID: <20250620164053.579416-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620164053.579416-1-pbonzini@redhat.com>
References: <20250620164053.579416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is the trick that allows the parent-field initializer to be used
only for the object that it's meant to be initialized.  This way,
the owner of a MemoryRegion must be the object that embeds it.

More information is in the comments; it's best explained with a simplified
example.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/qom.rs | 89 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 85 insertions(+), 4 deletions(-)

diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index ef966e570ca..04d102591dc 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -95,6 +95,7 @@
 use std::{
     ffi::{c_void, CStr},
     fmt,
+    marker::PhantomData,
     mem::{ManuallyDrop, MaybeUninit},
     ops::{Deref, DerefMut},
     ptr::NonNull,
@@ -208,12 +209,92 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> Result<(), fmt::Error> {
 
 /// This struct knows that the superclasses of the object have already been
 /// initialized.
-pub struct ParentInit<'a, T>(&'a mut MaybeUninit<T>);
+///
+/// The declaration of `ParentInit` is.. *"a kind of magic"*.  It uses a
+/// technique that is found in several crates, the main ones probably being
+/// `ghost-cell` (in fact it was introduced by the [`GhostCell` paper](https://plv.mpi-sws.org/rustbelt/ghostcell/))
+/// and `generativity`.
+///
+/// The `PhantomData` makes the `ParentInit` type *invariant* with respect to
+/// the lifetime argument `'init`.  This, together with the `for<'...>` in
+/// `[ParentInit::with]`, block any attempt of the compiler to be creative when
+/// operating on types of type `ParentInit` and to extend their lifetimes.  In
+/// particular, it ensures that the `ParentInit` cannot be made to outlive the
+/// `rust_instance_init()` function that creates it, and therefore that the
+/// `&'init T` reference is valid.
+///
+/// This implementation of the same concept, without the QOM baggage, can help
+/// understanding the effect:
+///
+/// ```
+/// use std::marker::PhantomData;
+///
+/// #[derive(PartialEq, Eq)]
+/// pub struct Jail<'closure, T: Copy>(&'closure T, PhantomData<fn(&'closure ()) -> &'closure ()>);
+///
+/// impl<'closure, T: Copy> Jail<'closure, T> {
+///     fn get(&self) -> T {
+///         *self.0
+///     }
+///
+///     #[inline]
+///     fn with<U>(v: T, f: impl for<'id> FnOnce(Jail<'id, T>) -> U) -> U {
+///         let parent_init = Jail(&v, PhantomData);
+///         f(parent_init)
+///     }
+/// }
+/// ```
+///
+/// It's impossible to escape the `Jail`; `token1` cannot be moved out of the
+/// closure:
+///
+/// ```ignore
+/// let x = 42;
+/// let escape = Jail::with(&x, |token1| {
+///     println!("{}", token1.get());
+///     // fails to compile...
+///     token1
+/// });
+/// // ... so you cannot do this:
+/// println!("{}", escape.get());
+/// ```
+///
+/// Likewise, in the QOM case the `ParentInit` cannot be moved out of
+/// `instance_init()`. Without this trick it would be possible to stash a
+/// `ParentInit` and use it later to access uninitialized memory.
+///
+/// Here is another example, showing how separately-created "identities" stay
+/// isolated:
+///
+/// ```ignore
+/// impl<'closure, T: Copy> Clone for Jail<'closure, T> {
+///     fn clone(&self) -> Jail<'closure, T> {
+///         Jail(self.0, PhantomData)
+///     }
+/// }
+///
+/// fn main() {
+///     Jail::with(42, |token1| {
+///         // this works and returns true: the clone has the same "identity"
+///         println!("{}", token1 == token1.clone());
+///         Jail::with(42, |token2| {
+///             // here the outer token remains accessible...
+///             println!("{}", token1.get());
+///             // ... but the two are separate: this fails to compile:
+///             println!("{}", token1 == token2);
+///         });
+///     });
+/// }
+/// ```
+pub struct ParentInit<'init, T>(
+    &'init mut MaybeUninit<T>,
+    PhantomData<fn(&'init ()) -> &'init ()>,
+);
 
-impl<'a, T> ParentInit<'a, T> {
+impl<'init, T> ParentInit<'init, T> {
     #[inline]
-    pub fn with(obj: &'a mut MaybeUninit<T>, f: impl FnOnce(ParentInit<'a, T>)) {
-        let parent_init = ParentInit(obj);
+    pub fn with(obj: &'init mut MaybeUninit<T>, f: impl for<'id> FnOnce(ParentInit<'id, T>)) {
+        let parent_init = ParentInit(obj, PhantomData);
         f(parent_init)
     }
 }
-- 
2.49.0


