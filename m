Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CC6D1BDD3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80sg-0007Br-4A; Mon, 04 Nov 2024 12:28:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sd-0006w0-LI
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sb-0000Qf-OT
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eq5qbzLPKG4WD2CsQZHh3f809/48MMF72sDvSN7iEVo=;
 b=JaYdjpfH9poUalcBJg4/Acr+SiPaSbbMnxqWLbVvd9W8T5WQO061cczV20+yqfXz8tLUJA
 Ic9QUQ7eq2APaLy5WQZVw1zTuj6uLWA41JzG6+/6ZHuLXhFxAtMGJtLHwzZA8wwfNBwnnK
 DlNSlFzcZ3FVcPDir6nrXyMN6yi44W8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-ln8lSviuMhiTKz45rdcugg-1; Mon, 04 Nov 2024 12:28:39 -0500
X-MC-Unique: ln8lSviuMhiTKz45rdcugg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2fb55e102b6so27509781fa.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741317; x=1731346117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eq5qbzLPKG4WD2CsQZHh3f809/48MMF72sDvSN7iEVo=;
 b=lohfIF5NJrr1X+JLf5N6f0Kgkh6FcfnfC8+YxZ/SutdXEpwguabk3pkKcRkOLgYLHl
 HFYmPfKEQ1+oCBWGmk+9NODOuxZEJUtviae9/Gr0fvla0LYIQK4YiE3sAzVevY5hiVt1
 f1JRKWvLhdgowkmbtnEEUiisyIJJ87t/5dgOto+ib0MchAZo/VGkOABuQCw+Byipt0Tv
 2tjWfdHXmpCZcGW7ZAYPgUZadrw3S8OZrTFKPYWEIHcJoX4YH1KiNAU1bHJNjCPTu4FP
 8zlY/9ldZRuXMrMReJYJAtk0Bow/H2MwLo0wCGaveHaCYqAGwjDu4+8MtiFHWCSGhc/d
 9jcA==
X-Gm-Message-State: AOJu0YzXp4oVdCgM1q9j9jQFpuBmE0PYSTKpcBHBHsQcBH1AUYcCJshD
 sNKtUgenOu0zZvyQmF4YC0iTd4p/PoCeSqtgBwMGltJNE+9W36qx5xXyoAJoVVKccEuDRdsJQux
 J8Nazv97MwBdqhqBAfAXT/xPiOiFojTZX8lhNfVQWEPvgAgKlQ73g94x+tGj/CAz7guhNPu1Y//
 Ik5WD2bAu0JRkRVg1jXX4KcjX9wh/CaR7HQH3TC+s=
X-Received: by 2002:a05:651c:1508:b0:2fa:ddb5:77f9 with SMTP id
 38308e7fff4ca-2fedb7ec448mr66869711fa.40.1730741316623; 
 Mon, 04 Nov 2024 09:28:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHENFgBbFtPZcrXOhpsL/Kt0hDBbVz4KNDOgXigmEFmYVxLZcBKOeqwjS2FVGp7keKsNSehqQ==
X-Received: by 2002:a05:651c:1508:b0:2fa:ddb5:77f9 with SMTP id
 38308e7fff4ca-2fedb7ec448mr66869441fa.40.1730741316076; 
 Mon, 04 Nov 2024 09:28:36 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd917fa7sm187323265e9.18.2024.11.04.09.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:28:35 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 33/40] rust: do not use MaybeUninit::zeroed()
Date: Mon,  4 Nov 2024 18:27:12 +0100
Message-ID: <20241104172721.180255-34-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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
 
+use std::ptr;
+
 /// Encapsulates the requirement that
-/// `MaybeUninit::<Self>::zeroed().assume_init()` does not cause
-/// undefined behavior.
+/// `MaybeUninit::<Self>::zeroed().assume_init()` does not cause undefined
+/// behavior.  This trait in principle could be implemented as just:
+///
+/// ```
+///     const ZERO: Self = unsafe {
+///         ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init()
+///     },
+/// ```
+///
+/// The need for a manual implementation is only because `zeroed()` cannot
+/// be used as a `const fn` prior to Rust 1.75.0. Once we can assume a new
+/// enough version of the compiler, we could provide a `#[derive(Zeroable)]`
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
+/// any assumption on the safety of `zeroed()`.  However, other users of the
+/// trait could use it that way.  Do not add this trait to a type unless
+/// all-zeroes is a valid value for the type.  In particular, remember that
+/// raw pointers can be zero, but references and `NonNull<T>` cannot
 pub unsafe trait Zeroable: Default {
-    /// SAFETY: If the trait was added to a type, then by definition
-    /// this is safe.
-    const ZERO: Self = unsafe { ::core::mem::MaybeUninit::<Self>::zeroed().assume_init() };
+    const ZERO: Self;
 }
 
-unsafe impl Zeroable for crate::bindings::Property__bindgen_ty_1 {}
-unsafe impl Zeroable for crate::bindings::Property {}
-unsafe impl Zeroable for crate::bindings::VMStateDescription {}
-unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_1 {}
-unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_2 {}
+unsafe impl Zeroable for crate::bindings::Property__bindgen_ty_1 {
+    const ZERO: Self = Self { i: 0 };
+}
+
+unsafe impl Zeroable for crate::bindings::Property {
+    const ZERO: Self = Self {
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
+    const ZERO: Self = Self {
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
+    const ZERO: Self = Self {
+        min_access_size: 0,
+        max_access_size: 0,
+        unaligned: false,
+        accepts: None,
+    };
+}
+
+unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_2 {
+    const ZERO: Self = Self {
+        min_access_size: 0,
+        max_access_size: 0,
+        unaligned: false,
+    };
+}
-- 
2.47.0


