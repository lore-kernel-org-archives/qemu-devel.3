Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F799C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrlz-0004Ou-Ie; Mon, 05 May 2025 05:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBrku-0003X7-9z
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBrkp-0005jq-C2
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746435889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eJwgErAmU4ckPuc9++qP9v1e1akMhw0OVt15JuOFrhQ=;
 b=Fffrgq5gYfkT9+Q81vCF8q76VPEH5VskSVlQIxyx+QIYklg6YhggTjws8Q9eIb8Gg6wgQ5
 CacUO3nZA7vBUrlZCouNfpAqeb+J7EsCjv3kskCFNY4w/nff0cay9p45p27yDAscBsnCG0
 KoXjiLwvdTczaWZcXqC/QcLyJA1yxbE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-pn3snHaZPeqGX5B6JPcq0A-1; Mon, 05 May 2025 05:04:48 -0400
X-MC-Unique: pn3snHaZPeqGX5B6JPcq0A-1
X-Mimecast-MFC-AGG-ID: pn3snHaZPeqGX5B6JPcq0A_1746435887
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39123912ff0so952582f8f.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746435887; x=1747040687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eJwgErAmU4ckPuc9++qP9v1e1akMhw0OVt15JuOFrhQ=;
 b=nE3EBICn1XEnuOinbH8mit1ZSslj10dmfLyW7qBmKCPL4sGHIcFjO1L2K/saDOX7l0
 M9Fi7Y27p+pGUmYroJGOgJkk2brAY240DZK80g1W1MU32oLbKIm+0vWDxa3ZmtxBJ3B+
 CYA0bXupgKPkFJ29bPH3IDdx8+gIc1bJ+AOP5MGh/00C5df26879Cu48kPOH0qsqVzcR
 I3u4DLSDdqYMDAPH/xi6gIL6W0Zj5wJZiO6CxsAjgvHQUmC9GezFGao4NKqaRDM1ZFzQ
 jJ8CO63hESdJrghfbLoCCXOD03YCionP34bAY/HdHCChn9OB0CtsrByd9nJcjaBi3sS5
 x3RA==
X-Gm-Message-State: AOJu0YxtgJAbQAMc62zOnBPRR9YAc8yWNXNZErA+V/qKP0bPP7okd3sg
 N1Z9768xxk++bWKbaVNdV8tsViCNfNJf0H3IFIV4tu3rEmVfeXGhjCK3+WzQEvMgkKxNInryWpa
 Iax/EPl+s7jkUN59KZ4L0ZLufvzgCGaVOtGwl7DrpPZEOM1lvtvtFNRZnm9fyWd4l3+dzfEvP/g
 uEmBau0hhiS0flZa20TOSJPnPWg4HmMiaiLmkl
X-Gm-Gg: ASbGncsp5HuIXE2QcsziTYlDYbTbaQdwkxSAOvVBW7GIG/UhP5Lxa9BLyTY9/VsLTvp
 p/BOOME4gusfmPyFt7dEL16WYCZzwqQYI8N7SDV0Wrj1pzNi2L5dZXo8Gc7Qy7debX3lAs1A9lu
 mrWKpgthARgFocqof7bLWUZbzeFDmbYRghz4MZS01jjfs7e3D9Zsup6DFoRtBaWFXducoUfIiVM
 G7jCer1/TnbqJmQoayKsyriaENYdW5yHzD68spXORJPmTAqPvEU2RrS8scaFGXBubfkpw5QM4zy
 7LyeZXMTTa5Ys18=
X-Received: by 2002:adf:a1c6:0:b0:3a0:a19f:2f47 with SMTP id
 ffacd0b85a97d-3a0a19f2f70mr2518221f8f.42.1746435886795; 
 Mon, 05 May 2025 02:04:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVsD4q3UAKkWSSg6doa0lAIb5qdD0GX3AiRrVmSOI8zmOfmTtQFX90jdzC+B8Bswws+5dlzQ==
X-Received: by 2002:adf:a1c6:0:b0:3a0:a19f:2f47 with SMTP id
 ffacd0b85a97d-3a0a19f2f70mr2518198f8f.42.1746435886368; 
 Mon, 05 May 2025 02:04:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b16f9dsm9909520f8f.93.2025.05.05.02.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 02:04:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org,
	qemu-rust@nongnu.org
Subject: [PATCH 03/11] rust: use std::ffi instead of std::os::raw
Date: Mon,  5 May 2025 11:04:28 +0200
Message-ID: <20250505090438.24992-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505090438.24992-1-pbonzini@redhat.com>
References: <20250505090438.24992-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is allowed since Rust 1.64.0.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst                    | 2 --
 rust/hw/char/pl011/src/device_class.rs | 2 +-
 rust/hw/timer/hpet/src/hpet.rs         | 3 +--
 rust/qemu-api/src/chardev.rs           | 3 +--
 rust/qemu-api/src/irq.rs               | 6 +++++-
 rust/qemu-api/src/lib.rs               | 2 +-
 rust/qemu-api/src/memory.rs            | 3 +--
 rust/qemu-api/src/qdev.rs              | 3 +--
 rust/qemu-api/src/qom.rs               | 3 +--
 rust/qemu-api/src/timer.rs             | 2 +-
 rust/qemu-api/src/vmstate.rs           | 2 +-
 rust/qemu-api/tests/vmstate_tests.rs   | 7 ++++++-
 12 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 3cc2841d4d1..c7dfba98de1 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -74,8 +74,6 @@ Supported tools
 QEMU supports rustc version 1.63.0 and newer.  Notably, the following features
 are missing:
 
-* ``core::ffi`` (1.64.0).  Use ``std::os::raw`` and ``std::ffi`` instead.
-
 * ``cast_mut()``/``cast_const()`` (1.65.0).  Use ``as`` instead.
 
 * "let ... else" (1.65.0).  Use ``if let`` instead.  This is currently patched
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index b4d4a7eb432..cd2dc33c207 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -3,7 +3,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use std::{
-    os::raw::{c_int, c_void},
+    ffi::{c_int, c_void},
     ptr::NonNull,
 };
 
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index 12de2ba59a1..d4364f2f2f7 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -3,8 +3,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use std::{
-    ffi::CStr,
-    os::raw::{c_int, c_void},
+    ffi::{c_int, c_void, CStr},
     pin::Pin,
     ptr::{addr_of_mut, null_mut, NonNull},
     slice::from_ref,
diff --git a/rust/qemu-api/src/chardev.rs b/rust/qemu-api/src/chardev.rs
index 11e6c45afaf..146a4852da3 100644
--- a/rust/qemu-api/src/chardev.rs
+++ b/rust/qemu-api/src/chardev.rs
@@ -10,11 +10,10 @@
 //! called.
 
 use std::{
-    ffi::CStr,
+    ffi::{c_int, c_void, CStr},
     fmt::{self, Debug},
     io::{self, ErrorKind, Write},
     marker::PhantomPinned,
-    os::raw::{c_int, c_void},
     ptr::addr_of_mut,
     slice,
 };
diff --git a/rust/qemu-api/src/irq.rs b/rust/qemu-api/src/irq.rs
index 1222d4fde30..1526e6f63a1 100644
--- a/rust/qemu-api/src/irq.rs
+++ b/rust/qemu-api/src/irq.rs
@@ -4,7 +4,11 @@
 
 //! Bindings for interrupt sources
 
-use std::{ffi::CStr, marker::PhantomData, os::raw::c_int, ptr};
+use std::{
+    ffi::{c_int, CStr},
+    marker::PhantomData,
+    ptr,
+};
 
 use crate::{
     bindings::{self, qemu_set_irq},
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 05f38b51d30..c3641e893b7 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -33,7 +33,7 @@
 
 use std::{
     alloc::{GlobalAlloc, Layout},
-    os::raw::c_void,
+    ffi::c_void,
 };
 
 #[cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)]
diff --git a/rust/qemu-api/src/memory.rs b/rust/qemu-api/src/memory.rs
index fdb1ea11fcf..9ef2694bd62 100644
--- a/rust/qemu-api/src/memory.rs
+++ b/rust/qemu-api/src/memory.rs
@@ -5,9 +5,8 @@
 //! Bindings for `MemoryRegion`, `MemoryRegionOps` and `MemTxAttrs`
 
 use std::{
-    ffi::{CStr, CString},
+    ffi::{c_uint, c_void, CStr, CString},
     marker::PhantomData,
-    os::raw::{c_uint, c_void},
 };
 
 pub use bindings::{hwaddr, MemTxAttrs};
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 18b4a9ba687..17c7fecabeb 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -5,8 +5,7 @@
 //! Bindings to create devices and access device functionality from Rust.
 
 use std::{
-    ffi::{CStr, CString},
-    os::raw::{c_int, c_void},
+    ffi::{c_int, c_void, CStr, CString},
     ptr::NonNull,
 };
 
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index f1b4022157b..6929e4d33ae 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -93,11 +93,10 @@
 //! without incurring into violations of orphan rules for traits.
 
 use std::{
-    ffi::CStr,
+    ffi::{c_void, CStr},
     fmt,
     mem::ManuallyDrop,
     ops::{Deref, DerefMut},
-    os::raw::c_void,
     ptr::NonNull,
 };
 
diff --git a/rust/qemu-api/src/timer.rs b/rust/qemu-api/src/timer.rs
index e769f8bc910..d697fd742bc 100644
--- a/rust/qemu-api/src/timer.rs
+++ b/rust/qemu-api/src/timer.rs
@@ -3,7 +3,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use std::{
-    os::raw::{c_int, c_void},
+    ffi::{c_int, c_void},
     pin::Pin,
 };
 
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 9ae97c389c1..c0f29f74188 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -25,7 +25,7 @@
 //!   functionality that is missing from `vmstate_of!`.
 
 use core::{marker::PhantomData, mem, ptr::NonNull};
-use std::os::raw::{c_int, c_void};
+use std::ffi::{c_int, c_void};
 
 pub use crate::bindings::{VMStateDescription, VMStateField};
 use crate::{
diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index f7a93117e1a..9a56ffd2385 100644
--- a/rust/qemu-api/tests/vmstate_tests.rs
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -2,7 +2,12 @@
 // Author(s): Zhao Liu <zhai1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::{ffi::CStr, mem::size_of, os::raw::c_void, ptr::NonNull, slice};
+use std::{
+    ffi::{c_void, CStr},
+    mem::size_of,
+    ptr::NonNull,
+    slice,
+};
 
 use qemu_api::{
     bindings::{
-- 
2.49.0


