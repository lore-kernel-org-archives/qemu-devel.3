Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D42C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 15:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOefy-0000Us-QP; Mon, 09 Jun 2025 11:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uOefw-0000U8-DE
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:44:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uOefu-0007i9-Dx
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749483877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=epM41E1l12D6pUwXy3YmY7/Hvv8B/vOVwD8gZKKOhHo=;
 b=KyBh4VqrzRlCNwDpJllCcBBOniCgzvISFd8OwiYxXW2VC092PtkeXPOLidAMMPUd1GpnUo
 6LfmT9+nSyRoQEClAOwM03XISLrNq/g8Cuz+UlSN5Jeud5mHBy+6e5dq3VG9hKdcNALbol
 CsuvxKVdi7r35+r8mszAu8Tr4k7sYqI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-KjvZzj-dODSMDKnSnLwfGA-1; Mon, 09 Jun 2025 11:44:36 -0400
X-MC-Unique: KjvZzj-dODSMDKnSnLwfGA-1
X-Mimecast-MFC-AGG-ID: KjvZzj-dODSMDKnSnLwfGA_1749483875
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451deff247cso25086745e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 08:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749483874; x=1750088674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=epM41E1l12D6pUwXy3YmY7/Hvv8B/vOVwD8gZKKOhHo=;
 b=SxeGcFSp1/xsR9d4EIGmVa9jGCaSMdaYuFRCGuSQYLSIIgn5VjnXity+CUoXztE07e
 XWN0zIsED+MQ7geBWd1ikeJST6cvQrxF3Cqqx2iImIeuG82WGWZ6KEM15Vkr42Drl+gg
 jP7g5MRV0x2NaOZowLHtFS4FcE1qi3XIQF4HwcyXT82K8wRq9Rptywc4c4VCSIAqFaLu
 b9rggE+IScp/KWkZa9q20b+ZAiQ2JxojSt5N5j32tIDiZYk3p0DpO+kbislLity0whqe
 uTtKDiZSWt6BQ1cYIBpzJN/GzLTqGoy9y41hADQi/PMoTYiRuDXX6leggTmghi8fUMJf
 ODwg==
X-Gm-Message-State: AOJu0YydIXQDYf4+6fqgA66Q7nvelGLlcWIvhizXx08a/Xq3X5k19UgX
 cfRtqyShX9fg6oXfpoHRCPOgWqqykW7xuAVv+MmTh868DPQpRJygPnGIEu9vxlhtCivolbtj91N
 pFEuTLxh4yqvMy9/JuWYpUvGb4mHBY3zq6/iYadDcgL66JfWRH1o9RdhJYDJquhHROkfEKur0YG
 YJzWY1qcuii/qunsqB4as6tgyWbYTyBTAjlQtmA/hu
X-Gm-Gg: ASbGncuwgJrzk9raUHCpwEICHIRjR2cKlCu14u9ft3NAkqdlPcINrCwBvV+ADPJtr69
 tbZ9/nzeVWfDUsUKoHHlWfuHn952x06RYmmhWlkFdUj5PPxmQxjJtfm1cEWbikn9rw4IL25vpvX
 3s1VOmLoJBr/0NdhJyT6JL9PRB9o8+i5vG1bq/HI8y17cAcHtQmYIvkLUHRyGgQoErmHIZWU9ol
 LGCfRKAJvEopIqYup+4cdIPWDWyAK+/T4gXbUmPmtFwrl3d78RzE2L80QRmML96bHJk57sHq136
 N0t3s144vRecXGY8yRlTmjdW
X-Received: by 2002:a05:6000:2dc7:b0:3a4:ed9a:7016 with SMTP id
 ffacd0b85a97d-3a551427f0emr4291f8f.26.1749483874486; 
 Mon, 09 Jun 2025 08:44:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjGUAEUHvdGNUkTj0micNOMkn375JR2vzYSokk4elbOzTyj8ZmQQscRYA7Y6NVFIefwQPwAQ==
X-Received: by 2002:a05:6000:2dc7:b0:3a4:ed9a:7016 with SMTP id
 ffacd0b85a97d-3a551427f0emr4273f8f.26.1749483873965; 
 Mon, 09 Jun 2025 08:44:33 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45307b9d827sm65817845e9.22.2025.06.09.08.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 08:44:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 4/5] rust: qom: make ParentInit lifetime-invariant
Date: Mon,  9 Jun 2025 17:44:22 +0200
Message-ID: <20250609154423.706056-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609154423.706056-1-pbonzini@redhat.com>
References: <20250609154423.706056-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/qom.rs | 88 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 4 deletions(-)

diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 21c271cd2f9..1481ef20f0c 100644
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
@@ -208,12 +209,91 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> Result<(), fmt::Error> {
 
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
+///     token1
+/// });
+/// // fails to compile:
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


