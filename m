Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FCCD1CDD0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Bqa-0004uo-8d; Tue, 22 Oct 2024 06:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3BqW-0004tX-II
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3BqU-0004Oo-1t
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729591833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=03JiRCmWWZh2jJskiShZoJxz/aHC3ZzZOgP/wBs0hjc=;
 b=Nlrbu5pC3o1CQQDM1AxBB3wvtQq+3+z2DHy79F95PusgjSb0v1oVIm4toEp+eVile8yNGh
 REEBjwnLk4JMucsBt9NwSaYIoYlX3+B+EXaN/9RHKPsjYSTPNACljnB9a4LE/n5W8Ap26W
 IdAhpkUF5tpuuim3OUNqhND/3Bi+/oM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-7AElOKDfPgqeNM6EwSfBVg-1; Tue, 22 Oct 2024 06:10:32 -0400
X-MC-Unique: 7AElOKDfPgqeNM6EwSfBVg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315dd8fe7fso45269605e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729591830; x=1730196630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=03JiRCmWWZh2jJskiShZoJxz/aHC3ZzZOgP/wBs0hjc=;
 b=OMq8sbhg8tIYclb4jYBZqdTJq0wBxPnRFq4e5JY8eIzO/tQeP3EQ7Wi4SC2otjiufx
 pmjwxcLRvstPRqdZY7OwSc8dijolNp/FzTfEoDYyVEnX1i9Niz40VkUC9H9K/CwXmAA3
 Al26X6fVe3ozdooF+CgzsvT1CqT+3qvVEpz2jGrdtJY6u+vnCHrdtqLwt2RnA7RStjux
 HrVRg2zmuHkHvtco2qflsdZMisZVtdVAWHrs7DLE/5ZBmxShteMrW2sYCHfPgoWihpUf
 ZGekIgxHZEnzAbteQhFHeXlp6KFIIgabdevXINqG4dgyItZIhOVFBupiKJDZK1Spna/R
 MuoQ==
X-Gm-Message-State: AOJu0Yydu1E2ZUD749mqxd/NdLHiF8Z2y8ZST+nZk7kNAakRtYkXjH6z
 hpC0R/L2V2sPMQXpsVJ89zCrQjnpdkrYwRHK6KwVKld66e2m27EIdigPXC9LlQcBPJC/pPyB5Y9
 ou/J3D40sjUaD2FfM1AwDJrg7sHG/jWYomAzmCCodseSkergPxa8TDM4dc8SZMBQXmZWyFGP0Rx
 z12Veg8D0xy2yCJlejeHNtnXsx85X2U8eIc3kU2hM=
X-Received: by 2002:a05:600c:6747:b0:431:5ba1:a520 with SMTP id
 5b1f17b1804b1-4316161ef0bmr156590505e9.3.1729591830088; 
 Tue, 22 Oct 2024 03:10:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeXIzdAkgD/irfpaEYUIV1U1m1yqe+mtDkoib8cYmNAUb4ZS087N2QLxFwDJ4XbqUxXSPPVg==
X-Received: by 2002:a05:600c:6747:b0:431:5ba1:a520 with SMTP id
 5b1f17b1804b1-4316161ef0bmr156590225e9.3.1729591829637; 
 Tue, 22 Oct 2024 03:10:29 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f5cc183sm83173315e9.40.2024.10.22.03.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:10:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org
Subject: [PATCH v2 08/14] rust: do not use MaybeUninit::zeroed()
Date: Tue, 22 Oct 2024 12:09:49 +0200
Message-ID: <20241022100956.196657-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241022100956.196657-1-pbonzini@redhat.com>
References: <20241022100956.196657-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

MaybeUninit::zeroed() is handy is not available as a "const" function until
Rust 1.75.0.

Remove the default implemntation of Zeroable::ZERO, and write by hand
the definitions for those types that need it.  It may be possible to
add automatic implementation of the trait, via a procedural macro and/or
a trick similar to offset_of!, but do it the easy way for now.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/zeroable.rs | 91 +++++++++++++++++++++++++++++------
 1 file changed, 77 insertions(+), 14 deletions(-)

diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
index 45ec95c9f70..13cdb2ccba5 100644
--- a/rust/qemu-api/src/zeroable.rs
+++ b/rust/qemu-api/src/zeroable.rs
@@ -1,23 +1,86 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
=20
+use std::ptr;
+
 /// Encapsulates the requirement that
-/// `MaybeUninit::<Self>::zeroed().assume_init()` does not cause
-/// undefined behavior.
+/// `MaybeUninit::<Self>::zeroed().assume_init()` does not cause undefined
+/// behavior.  This trait in principle could be implemented as just:
+///
+/// ```
+///     const ZERO: Self =3D unsafe {
+///         ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed=
().assume_init()
+///     },
+/// ```
+///
+/// The need for a manual implementation is only because `zeroed()` cannot
+/// be used as a `const fn` prior to Rust 1.75.0. Once we can assume a new
+/// enough version of the compiler, we could provide a `#[derive(Zeroable)=
]`
+/// macro to check at compile-time that all struct fields are Zeroable, and
+/// use the above blanket implementation of the `ZERO` constant.
 ///
 /// # Safety
 ///
-/// Do not add this trait to a type unless all-zeroes is
-/// a valid value for the type.  In particular, remember that raw
-/// pointers can be zero, but references and `NonNull<T>` cannot
-/// unless wrapped with `Option<>`.
+/// Because the implementation of `ZERO` is manual, it does not make
+/// any assumption on the safety of `zeroed()`.  However, other users of t=
he
+/// trait could use it that way.  Do not add this trait to a type unless
+/// all-zeroes is a valid value for the type.  In particular, remember that
+/// raw pointers can be zero, but references and `NonNull<T>` cannot
 pub unsafe trait Zeroable: Default {
-    /// SAFETY: If the trait was added to a type, then by definition
-    /// this is safe.
-    const ZERO: Self =3D unsafe { ::core::mem::MaybeUninit::<Self>::zeroed=
().assume_init() };
+    const ZERO: Self;
 }
=20
-unsafe impl Zeroable for crate::bindings::Property__bindgen_ty_1 {}
-unsafe impl Zeroable for crate::bindings::Property {}
-unsafe impl Zeroable for crate::bindings::VMStateDescription {}
-unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_1 {}
-unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_2 {}
+unsafe impl Zeroable for crate::bindings::Property__bindgen_ty_1 {
+    const ZERO: Self =3D Self { i: 0 };
+}
+
+unsafe impl Zeroable for crate::bindings::Property {
+    const ZERO: Self =3D Self {
+        name: ptr::null(),
+        info: ptr::null(),
+        offset: 0,
+        bitnr: 0,
+        bitmask: 0,
+        set_default: false,
+        defval: Zeroable::ZERO,
+        arrayoffset: 0,
+        arrayinfo: ptr::null(),
+        arrayfieldsize: 0,
+        link_type: ptr::null(),
+    };
+}
+
+unsafe impl Zeroable for crate::bindings::VMStateDescription {
+    const ZERO: Self =3D Self {
+        name: ptr::null(),
+        unmigratable: false,
+        early_setup: false,
+        version_id: 0,
+        minimum_version_id: 0,
+        priority: crate::bindings::MigrationPriority::MIG_PRI_DEFAULT,
+        pre_load: None,
+        post_load: None,
+        pre_save: None,
+        post_save: None,
+        needed: None,
+        dev_unplug_pending: None,
+        fields: ptr::null(),
+        subsections: ptr::null(),
+    };
+}
+
+unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_1 {
+    const ZERO: Self =3D Self {
+        min_access_size: 0,
+        max_access_size: 0,
+        unaligned: false,
+        accepts: None,
+    };
+}
+
+unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_2 {
+    const ZERO: Self =3D Self {
+        min_access_size: 0,
+        max_access_size: 0,
+        unaligned: false,
+    };
+}
--=20
2.46.2


