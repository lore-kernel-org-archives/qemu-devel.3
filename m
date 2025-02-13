Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A25C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibfQ-00018w-8o; Thu, 13 Feb 2025 11:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibfN-00017s-Ll
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:02:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibfL-0005fm-5o
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l+aZANu1L4i2e4Tg4LUPUkh6vicaxG7hxdJp4ipBY0E=;
 b=ZteF7lwHkIzFBdxWwMewJRyPc9/y5ZaPVvTXbq9ymHb/Ol/LaWJ5zXIr/H84Kw3HDURDen
 qdIHJmKYCiT0rX/VtHExVt4Ia+yrsgygUnR/ZH1vk7YPiOSvr1VbCpkCTGUkLedfRabg5H
 AKPSIwQHCgbE0g6B1P53iGToyu4xVLM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-I-XlyBCVNxOGVByeqTx04A-1; Thu, 13 Feb 2025 11:02:13 -0500
X-MC-Unique: I-XlyBCVNxOGVByeqTx04A-1
X-Mimecast-MFC-AGG-ID: I-XlyBCVNxOGVByeqTx04A_1739462532
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38de0a98043so614404f8f.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:02:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462531; x=1740067331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l+aZANu1L4i2e4Tg4LUPUkh6vicaxG7hxdJp4ipBY0E=;
 b=Ah9XEoN5DojDq1LhHcUThNLdSg5e3X4u5JWBBS4SA/FTCNEWoa917N9lqyCnURDN0z
 4SCYYRhBK/VC4U3QmY2iD4oJLTXpaycoiOHaQaqyF7IUnRYs6ePe3SXAB9dj8h2uKDrN
 ph3bbEIpKRq3IHAtiSP4/StoAS0xDjsSakkv/zIirgWl6xyNGV5ZJKxEyTDTWYxrhpqy
 LwJ+6UL1qaKqpGcIPzrxrlWvxlbbmXHFWXKzickpmNlzcBoWI+oS91PnEkFeRRzsFut+
 8OUSeqii8PqyY32iBTHMw1nsZdUna6pbDGOmQ8DVMD/+7MwNjZkDzor+mtfLQJ8VAoP4
 nLVw==
X-Gm-Message-State: AOJu0Yye7gRKfz/0G4aNFJn5V50yu7qqCJw++ota9tv1nN78iKJH7FXV
 Q3z1+1gvzO4wYld4mAOnuM6A66kdc1P4TnbP/IdDM7gZJO9+ezlSBUgFZ35xS7jg6co1mR6hkiF
 1FZGNWtz6wlDAf7chY7PyuaPkIRjxHlnsDRlhT8iiNQCBV+5GNPCrun9TV4HJwuqHiELlSa3vE/
 b4WEGCSlBE+ULJZEGagAqalYAJY/gfw2pC/3b70fU=
X-Gm-Gg: ASbGncu9WhIzTrWSKj5fVdiEPdDuM819usQiiQBCZ3hA6aK+RBPeAsxB34qWuFRkMLZ
 7Tp5x/Dv3jgMi1Ti8Rs7AAbofU6gPfIzMFKSKzDcLtICR2ou5ce8CHwZgFr7seUQ6itB2wZc+hA
 bo9OvQQGmMkfYrX1ldz0/jwaJTnHHuUFa2xnwuUYvyFo6mSG30+4Gmh7VJFL3sGYQW5p00rkUQk
 JDzigzo1rcqlrQQnkxtmYVBM2Z6OkWdMhYD1RQUMvw7E8+DvagLh7VlV4FRMp2UNw9liEZuy6Iq
 SlwQdCRh1ogETlGnxMEffccR6ErM32h5/dhNe2C+0MPM2A==
X-Received: by 2002:a5d:52c8:0:b0:38d:e48b:1787 with SMTP id
 ffacd0b85a97d-38dea26c186mr6309492f8f.14.1739462528246; 
 Thu, 13 Feb 2025 08:02:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7exGDLDPu5qiGUy+vjCTWxO1dqlCumxmPQkRMu53nIW1zW59pb3bTc3TBOPwOj+bFx8MGtQ==
X-Received: by 2002:a5d:52c8:0:b0:38d:e48b:1787 with SMTP id
 ffacd0b85a97d-38dea26c186mr6309282f8f.14.1739462525706; 
 Thu, 13 Feb 2025 08:02:05 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25a0fa1esm2208679f8f.100.2025.02.13.08.02.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:02:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/27] rust: qemu_api: add a documentation header for all
 modules
Date: Thu, 13 Feb 2025 17:00:51 +0100
Message-ID: <20250213160054.3937012-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213160054.3937012-1-pbonzini@redhat.com>
References: <20250213160054.3937012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/assertions.rs | 4 ++++
 rust/qemu-api/src/bindings.rs   | 2 ++
 rust/qemu-api/src/c_str.rs      | 8 ++++++++
 rust/qemu-api/src/offset_of.rs  | 7 +++++++
 rust/qemu-api/src/prelude.rs    | 2 ++
 rust/qemu-api/src/sysbus.rs     | 2 ++
 rust/qemu-api/src/zeroable.rs   | 2 ++
 7 files changed, 27 insertions(+)

diff --git a/rust/qemu-api/src/assertions.rs b/rust/qemu-api/src/assertions.rs
index 6e420469806..fa1a18de6fe 100644
--- a/rust/qemu-api/src/assertions.rs
+++ b/rust/qemu-api/src/assertions.rs
@@ -2,9 +2,13 @@
 // Author(s): Paolo Bonzini <pbonzini@redhat.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#![doc(hidden)]
 //! This module provides macros to check the equality of types and
 //! the type of `struct` fields.  This can be useful to ensure that
 //! types match the expectations of C code.
+//!
+//! Documentation is hidden because it only exposes macros, which
+//! are exported directly from `qemu_api`.
 
 // Based on https://stackoverflow.com/questions/64251852/x/70978292#70978292
 // (stackoverflow answers are released under MIT license).
diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index b71220113ef..d2868639ff6 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -15,6 +15,8 @@
     clippy::missing_safety_doc
 )]
 
+//! `bindgen`-generated declarations.
+
 #[cfg(MESON)]
 include!("bindings.inc.rs");
 
diff --git a/rust/qemu-api/src/c_str.rs b/rust/qemu-api/src/c_str.rs
index 4cd96da0b45..3fa61b59c76 100644
--- a/rust/qemu-api/src/c_str.rs
+++ b/rust/qemu-api/src/c_str.rs
@@ -2,6 +2,14 @@
 // Author(s): Paolo Bonzini <pbonzini@redhat.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#![doc(hidden)]
+//! This module provides a macro to define a constant of type
+//! [`CStr`](std::ffi::CStr), for compatibility with versions of
+//! Rust that lack `c""` literals.
+//!
+//! Documentation is hidden because it only exposes macros, which
+//! are exported directly from `qemu_api`.
+
 #[macro_export]
 /// Given a string constant _without_ embedded or trailing NULs, return
 /// a `CStr`.
diff --git a/rust/qemu-api/src/offset_of.rs b/rust/qemu-api/src/offset_of.rs
index 075e98f986b..373229bbde9 100644
--- a/rust/qemu-api/src/offset_of.rs
+++ b/rust/qemu-api/src/offset_of.rs
@@ -1,5 +1,12 @@
 // SPDX-License-Identifier: MIT
 
+#![doc(hidden)]
+//! This module provides macros that emulate the functionality of
+//! `core::mem::offset_of` on older versions of Rust.
+//!
+//! Documentation is hidden because it only exposes macros, which
+//! are exported directly from `qemu_api`.
+
 /// This macro provides the same functionality as `core::mem::offset_of`,
 /// except that only one level of field access is supported.  The declaration
 /// of the struct must be wrapped with `with_offsets! { }`.
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index 254edb476dd..fbf0ee23e0b 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -2,6 +2,8 @@
 // Author(s): Paolo Bonzini <pbonzini@redhat.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+//! Commonly used traits and types for QEMU.
+
 pub use crate::bitops::IntegerExt;
 
 pub use crate::cell::BqlCell;
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index 1f66a5f1e09..fa36e12178f 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -2,6 +2,8 @@
 // Author(s): Paolo Bonzini <pbonzini@redhat.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+//! Bindings to access `sysbus` functionality from Rust.
+
 use std::{ffi::CStr, ptr::addr_of_mut};
 
 pub use bindings::{SysBusDevice, SysBusDeviceClass};
diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
index cd424e6ea05..a2356cb2f24 100644
--- a/rust/qemu-api/src/zeroable.rs
+++ b/rust/qemu-api/src/zeroable.rs
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+//! Defines a trait for structs that can be safely initialized with zero bytes.
+
 /// Encapsulates the requirement that
 /// `MaybeUninit::<Self>::zeroed().assume_init()` does not cause undefined
 /// behavior.  This trait in principle could be implemented as just:
-- 
2.48.1


