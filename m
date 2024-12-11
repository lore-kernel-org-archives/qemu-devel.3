Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C82E77185
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPaE-0002zF-1y; Wed, 11 Dec 2024 11:29:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPaA-0002Q9-HG
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:29:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPa7-0000cx-CF
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:29:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BexU3VOLutJEH2IVkrvKdkdz8shoIJg8kVhXm7BVM0w=;
 b=JBs9Poueej7RBP7OBRGyJm0x9NDZF1zX92NHRa36rEw/W/8qu6K6wun+lZPe0GS2O2PFys
 xX6+OSK06285lpXhVUIwrUkYgUbSdErpqz1M0xJNcj7qkjGY6J34x+kqIbHJgeFCLcXF6K
 plOlGXfhQaifb0x6C/h5dPMCLHjM9ls=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-3ddq_VKuPBG60b5X23qJlQ-1; Wed, 11 Dec 2024 11:28:56 -0500
X-MC-Unique: 3ddq_VKuPBG60b5X23qJlQ-1
X-Mimecast-MFC-AGG-ID: 3ddq_VKuPBG60b5X23qJlQ
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-386321c8f4bso2692054f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934534; x=1734539334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BexU3VOLutJEH2IVkrvKdkdz8shoIJg8kVhXm7BVM0w=;
 b=iAtcdjaetdrlPks4vAdcs99v+2uGa1oirNM8aD83EjKYSHIaS/VOSYt1cBgRaSiKcN
 qQZJ7eAWvrsUdql7skKBJwmG9YbkEEhpgommOL7faHOHgbX5fUHiBuMV4jW4dytzCegE
 2hbYVw0dJOCf/oauTUhz0WrdUXPljIT7dxfgqKw4K1Jn7RB4eqwRuwNmlzo4QelE+geq
 6+KnRwFKV6ZVLaKg6KNq3x30F1dyYfEbmYPTxCEyXRv7FEvZPgSu9uA6Ss0DJcSCV0aP
 oJc1/vxm7op14TmjpaGl9aMmfzX1/yWQv67/qb+VQOG9nOBAO+A6dZfyjvJwns4n8COh
 BlKA==
X-Gm-Message-State: AOJu0Yz4TGWLb9gCbh0Wn/OeomtH+HHjsovgEIzteRyRXhCHzE1/KbCF
 oh4cNlU3mC8+wgw27cPX28XSYSTrNg+2GXuTY34WRUevxl/b9ITph71P5fKy0XeRcJGYbgGCUTx
 OLS/LuaeaoaExVm2ifKoukKyu/HrMV5Pqyj9AT6Zsk2zy+MfDD24x51ot+VZ0VdnLuC2I0w9CW9
 Qkpw2fx+XRf+27cO6rCIpxyA5P8JQtQAJRjlX3
X-Gm-Gg: ASbGncshJzjc2d+SMSe7B7u+YnjJEbnonnoaVDwem1diD0v4qWvZgDXtJSztF6qKYfV
 8ZSlM6gUHuMSgKE/+JfihBbGblV0KDej3ktEaA7RfR67Yo/WO8Am+Jm7Jl06WJYG7+eCjnyMZo9
 FA6pa4bedNSYZhobR+ofgCtz24NTcVqGG1Ruq+yuYPR3e50CyGy1n6awS+x+euzdXgSGGqhCEE4
 TIN+ukKoQ9eZ6p12XSQgn7hMXOAM1M4pYADqtouOETiHoI51N7KCbnf
X-Received: by 2002:a5d:6d06:0:b0:386:1cd3:8a07 with SMTP id
 ffacd0b85a97d-3864ce7fd8emr3202734f8f.7.1733934534412; 
 Wed, 11 Dec 2024 08:28:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeXZMoQ7yIBQprH5XCP9M7tt3DtHySdzn1TJsJEvGLe6aC7Oy6go5/SGj5TJzFiljaCxXM8w==
X-Received: by 2002:a5d:6d06:0:b0:386:1cd3:8a07 with SMTP id
 ffacd0b85a97d-3864ce7fd8emr3202714f8f.7.1733934533963; 
 Wed, 11 Dec 2024 08:28:53 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878251dbbfsm1608503f8f.97.2024.12.11.08.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 40/49] rust: add a bit operation module
Date: Wed, 11 Dec 2024 17:27:10 +0100
Message-ID: <20241211162720.320070-41-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

The bindgen supports `static inline` function binding since v0.64.0 as
an experimental feature (`--wrap-static-fns`), and stabilizes it after
v0.70.0.

But the oldest version of bindgen supported by QEMU is v0.60.1, so
there's no way to generate the binding for deposit64() which is `static
inline` (in include/qemu/bitops.h).

Instead, implement it by hand in Rust and make it available for all
unsigned types through an IntegerExt trait. Since it only involves bit
operations, the Rust version of the code is almost identical to the
original C version, but it applies to more types than just u64.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Co-authored-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/meson.build    |   1 +
 rust/qemu-api/src/bitops.rs  | 119 +++++++++++++++++++++++++++++++++++
 rust/qemu-api/src/lib.rs     |   1 +
 rust/qemu-api/src/prelude.rs |   2 +
 4 files changed, 123 insertions(+)
 create mode 100644 rust/qemu-api/src/bitops.rs

diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index b927eb58c8e..adcee661150 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -16,6 +16,7 @@ _qemu_api_rs = static_library(
     [
       'src/lib.rs',
       'src/bindings.rs',
+      'src/bitops.rs',
       'src/cell.rs',
       'src/c_str.rs',
       'src/definitions.rs',
diff --git a/rust/qemu-api/src/bitops.rs b/rust/qemu-api/src/bitops.rs
new file mode 100644
index 00000000000..023ec1a9983
--- /dev/null
+++ b/rust/qemu-api/src/bitops.rs
@@ -0,0 +1,119 @@
+// Copyright (C) 2024 Intel Corporation.
+// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! This module provides bit operation extensions to integer types.
+//! It is usually included via the `qemu_api` prelude.
+
+use std::ops::{
+    Add, AddAssign, BitAnd, BitAndAssign, BitOr, BitOrAssign, BitXor, BitXorAssign, Div, DivAssign,
+    Mul, MulAssign, Not, Rem, RemAssign, Shl, ShlAssign, Shr, ShrAssign,
+};
+
+/// Trait for extensions to integer types
+pub trait IntegerExt:
+    Add<Self, Output = Self> + AddAssign<Self> +
+    BitAnd<Self, Output = Self> + BitAndAssign<Self> +
+    BitOr<Self, Output = Self> + BitOrAssign<Self> +
+    BitXor<Self, Output = Self> + BitXorAssign<Self> +
+    Copy +
+    Div<Self, Output = Self> + DivAssign<Self> +
+    Eq +
+    Mul<Self, Output = Self> + MulAssign<Self> +
+    Not<Output = Self> + Ord + PartialOrd +
+    Rem<Self, Output = Self> + RemAssign<Self> +
+    Shl<Self, Output = Self> + ShlAssign<Self> +
+    Shl<u32, Output = Self> + ShlAssign<u32> + // add more as needed
+    Shr<Self, Output = Self> + ShrAssign<Self> +
+    Shr<u32, Output = Self> + ShrAssign<u32> // add more as needed
+{
+    const BITS: u32;
+    const MAX: Self;
+    const MIN: Self;
+    const ONE: Self;
+    const ZERO: Self;
+
+    #[inline]
+    #[must_use]
+    fn bit(start: u32) -> Self
+    {
+        debug_assert!(start < Self::BITS);
+
+        Self::ONE << start
+    }
+
+    #[inline]
+    #[must_use]
+    fn mask(start: u32, length: u32) -> Self
+    {
+        /* FIXME: Implement a more elegant check with error handling support? */
+        debug_assert!(start < Self::BITS && length > 0 && length <= Self::BITS - start);
+
+        (Self::MAX >> (Self::BITS - length)) << start
+    }
+
+    #[inline]
+    #[must_use]
+    fn deposit<U: IntegerExt>(self, start: u32, length: u32,
+                          fieldval: U) -> Self
+        where Self: From<U>
+    {
+        debug_assert!(length <= U::BITS);
+
+        let mask = Self::mask(start, length);
+        (self & !mask) | ((Self::from(fieldval) << start) & mask)
+    }
+
+    #[inline]
+    #[must_use]
+    fn extract(self, start: u32, length: u32) -> Self
+    {
+        let mask = Self::mask(start, length);
+        (self & mask) >> start
+    }
+}
+
+macro_rules! impl_num_ext {
+    ($type:ty) => {
+        impl IntegerExt for $type {
+            const BITS: u32 = <$type>::BITS;
+            const MAX: Self = <$type>::MAX;
+            const MIN: Self = <$type>::MIN;
+            const ONE: Self = 1;
+            const ZERO: Self = 0;
+        }
+    };
+}
+
+impl_num_ext!(u8);
+impl_num_ext!(u16);
+impl_num_ext!(u32);
+impl_num_ext!(u64);
+
+#[cfg(test)]
+mod tests {
+    use super::*;
+
+    #[test]
+    fn test_deposit() {
+        assert_eq!(15u32.deposit(8, 8, 1u32), 256 + 15);
+        assert_eq!(15u32.deposit(8, 1, 255u8), 256 + 15);
+    }
+
+    #[test]
+    fn test_extract() {
+        assert_eq!(15u32.extract(2, 4), 3);
+    }
+
+    #[test]
+    fn test_bit() {
+        assert_eq!(u8::bit(7), 128);
+        assert_eq!(u32::bit(16), 0x10000);
+    }
+
+    #[test]
+    fn test_mask() {
+        assert_eq!(u8::mask(7, 1), 128);
+        assert_eq!(u32::mask(8, 8), 0xff00);
+    }
+}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 0efbef47441..9e007e16354 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -12,6 +12,7 @@
 #[rustfmt::skip]
 pub mod prelude;
 
+pub mod bitops;
 pub mod c_str;
 pub mod cell;
 pub mod definitions;
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index dfaddbd062a..a39e228babf 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -2,5 +2,7 @@
 // Author(s): Paolo Bonzini <pbonzini@redhat.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+pub use crate::bitops::IntegerExt;
+
 pub use crate::cell::BqlCell;
 pub use crate::cell::BqlRefCell;
-- 
2.47.1


