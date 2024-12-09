Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE4DE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 12:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKd1S-0003y4-AG; Mon, 09 Dec 2024 07:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1M-0003rz-KM
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:37:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1D-0007Pp-Ck
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733747858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sBwsf4s6VXMmXVQEquo962VkkBl6Oft5lKCFdPBoVSc=;
 b=Y+dA60GGJoaqKlm87aH4hmlEZTbty/4GCQU+pz4sguZxYlpOrmkl4HdUP2DgFmH8NfwgZG
 nA2Ve7QAOhJO/rQxShqDsjzueFDPJVBMaj8r+3NdKZCpoislJDz1hH5vWH5THvEyXYwXW1
 qiV1lrPHXCO+0yDXwvHDlfcu4hR7Un8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-TO0LMUN5PJWaVwfaPIm0Ow-1; Mon, 09 Dec 2024 07:37:37 -0500
X-MC-Unique: TO0LMUN5PJWaVwfaPIm0Ow-1
X-Mimecast-MFC-AGG-ID: TO0LMUN5PJWaVwfaPIm0Ow
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-386321c8f4bso1237657f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 04:37:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733747855; x=1734352655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sBwsf4s6VXMmXVQEquo962VkkBl6Oft5lKCFdPBoVSc=;
 b=r2IBs/jcPMBHR33gca/WJtrEbu8PyZSA0zMZX+ydZAqyb2lsoJj6lowwDeI/BBmhZq
 BTDkdAOqfXUGlZwsXrhMrO3e8VdtnzgPzcyJolIUJNAUJ3r1SkataKXMdWZYmNpv2A4B
 xVqWDKnJrX6Y/a6QAkDJVU2584DFJc6IPYST9E0rktUcdbjyyUk+btYARIOKEPiaP7SF
 qJYo8eVqE+19+E70aBnxV+/r2Yo68VzG3l83aNn7Eex6SHJJfn1FrhTqaEzrrNDpInXm
 EhfBHoPseCVGqkgguPcTPJdlVehxx2+o9cUqknohWzo/tPptvan47vnpiRqBn7QtqC86
 BueA==
X-Gm-Message-State: AOJu0YxeiUxfIeZnJZXuONmL15EcjcEtLEbP9VbUiHe8iSSL5ys+nNr2
 jciy3SahrMey6qSldJ5bBapQvY9qojPdgw3WdOHw0iHSKFoduuikXPmv8mQobQ+AusQLcHmBMrP
 fYMC3G+9QSLP8NSqOXZZte5oFXXdh54qXn0ZO0n5kX9fkGSqja8s7Q7dllJmHTA6Nr+aLQiqezt
 VrFrJlJEqt0Sea5s6jjJzXGypBg6JqihCtdtrJ
X-Gm-Gg: ASbGnctJHVLpC/lJisz6NwCxlS4idGDqrNuIaJ4Y95WNOf/s82fy6wGT9UsE4VPW+BU
 Q/gIAUVQrs3K8zaWBug3RUXevRY67qNulX5NGmq8qARrEVqnxzH4sz7yaQHs87KRg/wFipRNFtr
 Bi6EJ3R40zEp+K5hveyg6ZBqnZUyGPRlrMD9ONrnuB7MVjphiDrypeh2149VxjBI633V4q14vLn
 zWWn70jL1XBTaZGbdCCnKZV7m9rwy3jkuSNbe8x9eWuBgfFw4196Q==
X-Received: by 2002:a05:6000:178e:b0:386:8ff:d20b with SMTP id
 ffacd0b85a97d-386453def96mr159959f8f.27.1733747854844; 
 Mon, 09 Dec 2024 04:37:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjporSdgQ1wAOgDZrCeoKxDdS9DTZ2gGKSzKXGXlzKxxnAGAbEQwy9CfjSOYBE62A3bTbiDg==
X-Received: by 2002:a05:6000:178e:b0:386:8ff:d20b with SMTP id
 ffacd0b85a97d-386453def96mr159929f8f.27.1733747854348; 
 Mon, 09 Dec 2024 04:37:34 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-386221a62f2sm12984210f8f.105.2024.12.09.04.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 04:37:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 06/26] rust: add a bit operation module
Date: Mon,  9 Dec 2024 13:36:57 +0100
Message-ID: <20241209123717.99077-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209123717.99077-1-pbonzini@redhat.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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
Co-authored-by: Paolo Bonzini <pbonzini@redhat.com>
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
index 00000000000..5acd6642d1a
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
+        assert!(start <= Self::BITS);
+
+        Self::ONE << start
+    }
+
+    #[inline]
+    #[must_use]
+    fn mask(start: u32, length: u32) -> Self
+    {
+        /* FIXME: Implement a more elegant check with error handling support? */
+        assert!(length > 0 && length <= Self::BITS - start);
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


