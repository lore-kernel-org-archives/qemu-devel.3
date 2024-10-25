Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DD6D149C0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Mnt-00043w-3a; Fri, 25 Oct 2024 12:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4MnZ-0003p2-0h
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:04:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4MnV-0004vu-QS
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729872260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lF4rdAhy19DxRdx2p8FMvfbjzQhye5OhOp5HNVlQP1w=;
 b=KekOjGP/BADpWaDXD0RZQd3W1hfjc+7HKHX8fmzqdXYcubfduksfcUAoefybMzZ97s6QT4
 PHe8DM78ig2QxfYFCOl3Hb6lKqJWaPCxkdBk/SKhmIaOgmreUs1FuhCxImvhPxevf2tzMa
 yiT8w+F/8OeQ6g/bnP5PBQNnXsLwRMM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-AumjB-COPB21fnArr_yBKQ-1; Fri, 25 Oct 2024 12:04:19 -0400
X-MC-Unique: AumjB-COPB21fnArr_yBKQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5cbb0b2c6e8so684114a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729872256; x=1730477056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lF4rdAhy19DxRdx2p8FMvfbjzQhye5OhOp5HNVlQP1w=;
 b=Otm0sUnzPGBFUoh5ejsQk1FMN6w3vjJmTUWZAXh+hQD/gSRqNT+K1+IyCqZ4N6Qwgd
 qr5+Wt9WceVNGADJjRc+8PFdyZ7LwarCBf+CVBNEmAf4EU6PA65XKqxCco8qfnZZ3q0Q
 QzvMda3cT0Elp7202DnIYKcCfYHg/V9hfALfEnPbAVMeuxqlGQGg1agHDeJZ47KAGGJp
 PNoP7HPjcn/uVnMM5QvY3Gjy+alRzs+16DVKPwqxlD4jbcxIxmMD4mxx+cL0L01fLNxw
 fzq21GFSPQgMxe59xexFjBG4y5VKeHCOIggWsYEjIeadNpHdMW+CpVJ9jRmuNrBxxdWM
 AjcQ==
X-Gm-Message-State: AOJu0YxIGQMRm77JpVnfMMKcS/seiZ+L08S2PbTrWskraQBRfgYTd2Uk
 A+Dxq6a8UDSsoUGJCQWgKeiwVqqoLaZa+U9LWdxJcok8EXJaL8WgnsmR/JjAkLr0OOr0pLzf3WE
 eaWTDSLueFzr9asy8CQ9TpRv3PmOoUh5WGfrktNxn5JtDJXznIdR6cq/Ick8oHzsfcCMvvI59dW
 ETUCdtinDvXQE65PfPUc/u9Rq8z5ZIz5dD0ZxOB0U=
X-Received: by 2002:a05:6402:13d3:b0:5ca:e5b:bbdb with SMTP id
 4fb4d7f45d1cf-5cb8acb7b16mr7338545a12.18.1729872256013; 
 Fri, 25 Oct 2024 09:04:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXy8L7yHeeXU1+w6XKn+whHOxFUNpZvJl/XFf2YkNAfAUz7/57mtu9FzHvuOujom4wD7U/xg==
X-Received: by 2002:a05:6402:13d3:b0:5ca:e5b:bbdb with SMTP id
 4fb4d7f45d1cf-5cb8acb7b16mr7338506a12.18.1729872255524; 
 Fri, 25 Oct 2024 09:04:15 -0700 (PDT)
Received: from [192.168.10.47] ([151.81.112.43])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb6348ec6sm758523a12.87.2024.10.25.09.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:04:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: [PATCH 16/23] rust: do not use MaybeUninit::zeroed()
Date: Fri, 25 Oct 2024 18:02:01 +0200
Message-ID: <20241025160209.194307-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025160209.194307-1-pbonzini@redhat.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

MaybeUninit::zeroed() is handy but is not available as a "const" function
until Rust 1.75.0.

Remove the default implementation of Zeroable::ZERO, and write by hand
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
2.47.0


