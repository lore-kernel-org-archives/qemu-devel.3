Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760ECE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK2j-0000QT-8e; Fri, 10 Jan 2025 13:47:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK1v-0000C0-K5
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:46:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK1o-00015R-V9
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Y7AVIgYdOQkLjAuEs4LCi+iFSpj9VAgo8xznKQsbL4=;
 b=WdArafX6GiUxBMfsWX2I74c0+uL5qa9Bj21OsQQgiGL0BX6JVjUF0CiRXqPBy+eV424R/f
 ExIiqyQYG+BQQcmtAMB7bZDtXBHdtTgcBEu5BuE0Vay8aEvlF0cTg5QGlHCwQmORgw/3n/
 o0EjlKIhH7QjEZFzd/KmSHJvWh8FD5A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-SAEOOldKMU2uJxEkpbutnA-1; Fri, 10 Jan 2025 13:46:34 -0500
X-MC-Unique: SAEOOldKMU2uJxEkpbutnA-1
X-Mimecast-MFC-AGG-ID: SAEOOldKMU2uJxEkpbutnA
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5d40c0c728aso1909503a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:46:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534792; x=1737139592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Y7AVIgYdOQkLjAuEs4LCi+iFSpj9VAgo8xznKQsbL4=;
 b=RnRp4tNF5v+uVbPLe8CnxdOR4Nia0ib+WPn/5KDfVgMnsp/EIA99ovVMuAVj54nM+p
 F0FKWfgtTsF1QoilCCabDUmqMZ+hpDcOIgOdxFhsNrDRmjmKZQEDFQ4NWkWFQp2QDWj1
 ACPTAP2pgoXbdBRqlret2auhrjy/rag9Asjy5IcwoDdN8fCpFd9KYkEQaPOhnLs/HY6C
 EIYYi0CUl7VBR87W6tCNrKa1YqPoVXyb6vgskf+/ateG69F4+TBMKAtwNDedIfNCLpPh
 o361AjFbGrz+kAY5T0cFGBOVcmN3RPJxk4m+G+s5e0Gq6oBRp3+ajZ8OrXkJQUNm8B1g
 XLdw==
X-Gm-Message-State: AOJu0YxERnytULLOXIUmJvP4lIfVwzE0L/En0zdCm+kZuSAlKGLhU4Zg
 8G6z+gQLPrkoNrj8MzB9wfdqy+B9Z09G+4gu8QS/3MZ/FI1J5kXc6ZyPEHhq+0a0itw3SJG4qau
 ywC0vHq/2bJ/fLuTZfnpKOpDBbzZDV9ErvScS4g8Wj+kQve2/a2Oqvd25O+PLtXvRSlx8tPPd9C
 belqlniy2kjpkiz9VrFSJw73drNsVMU9lVMAxmxic=
X-Gm-Gg: ASbGncsRkmbNcoyx/r4T9qwou/WCgT0Bfvp1NNJMBfjOQmPguULeIi0TW1PI9NDu1GX
 ydGcb4+KG1anYsFlrBTHzs3Th0o8ptKe7AmNO8maa9gZ14lzFBDv+XzI3YYor/VITvD/kjPjaia
 e50QSDN4NSMb36/ZzcM60g5vJHv8r/P6l+LDHn01P75KO+ha0B2B0g5d1AKDEtdcKohxc1KmQGL
 2ApO4f14qayPFRC3kDLPPIrQ2Fpq+5xaFjDkicHuRCA4LjVD41UOahX390=
X-Received: by 2002:a50:858c:0:b0:5d9:857e:b259 with SMTP id
 4fb4d7f45d1cf-5d9857eb31cmr14539987a12.31.1736534792228; 
 Fri, 10 Jan 2025 10:46:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8VRoiJfpZr0lg1yBx64xa8aIqBuoVsf5dw2dNq6dFmoBLLLE+69EJNK2jsn3Md+08LeNebA==
X-Received: by 2002:a50:858c:0:b0:5d9:857e:b259 with SMTP id
 4fb4d7f45d1cf-5d9857eb31cmr14539956a12.31.1736534791809; 
 Fri, 10 Jan 2025 10:46:31 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c9565517sm193586366b.130.2025.01.10.10.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:46:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 04/38] rust: add a utility module for compile-time type checks
Date: Fri, 10 Jan 2025 19:45:45 +0100
Message-ID: <20250110184620.408302-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
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

It is relatively common in the low-level qemu_api code to assert that
a field of a struct has a specific type; for example, it can be used
to ensure that the fields match what the qemu_api and C code expects
for safety.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/meson.build       |  1 +
 rust/qemu-api/src/assertions.rs | 90 +++++++++++++++++++++++++++++++++
 rust/qemu-api/src/lib.rs        |  1 +
 3 files changed, 92 insertions(+)
 create mode 100644 rust/qemu-api/src/assertions.rs

diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 9425ba7100c..60944a657de 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -15,6 +15,7 @@ _qemu_api_rs = static_library(
   structured_sources(
     [
       'src/lib.rs',
+      'src/assertions.rs',
       'src/bindings.rs',
       'src/bitops.rs',
       'src/callbacks.rs',
diff --git a/rust/qemu-api/src/assertions.rs b/rust/qemu-api/src/assertions.rs
new file mode 100644
index 00000000000..6e420469806
--- /dev/null
+++ b/rust/qemu-api/src/assertions.rs
@@ -0,0 +1,90 @@
+// Copyright 2024, Red Hat Inc.
+// Author(s): Paolo Bonzini <pbonzini@redhat.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! This module provides macros to check the equality of types and
+//! the type of `struct` fields.  This can be useful to ensure that
+//! types match the expectations of C code.
+
+// Based on https://stackoverflow.com/questions/64251852/x/70978292#70978292
+// (stackoverflow answers are released under MIT license).
+
+#[doc(hidden)]
+pub trait EqType {
+    type Itself;
+}
+
+impl<T> EqType for T {
+    type Itself = T;
+}
+
+/// Assert that two types are the same.
+///
+/// # Examples
+///
+/// ```
+/// # use qemu_api::assert_same_type;
+/// # use std::ops::Deref;
+/// assert_same_type!(u32, u32);
+/// assert_same_type!(<Box<u32> as Deref>::Target, u32);
+/// ```
+///
+/// Different types will cause a compile failure
+///
+/// ```compile_fail
+/// # use qemu_api::assert_same_type;
+/// assert_same_type!(&Box<u32>, &u32);
+/// ```
+#[macro_export]
+macro_rules! assert_same_type {
+    ($t1:ty, $t2:ty) => {
+        const _: () = {
+            #[allow(unused)]
+            fn assert_same_type(v: $t1) {
+                fn types_must_be_equal<T, U>(_: T)
+                where
+                    T: $crate::assertions::EqType<Itself = U>,
+                {
+                }
+                types_must_be_equal::<_, $t2>(v);
+            }
+        };
+    };
+}
+
+/// Assert that a field of a struct has the given type.
+///
+/// # Examples
+///
+/// ```
+/// # use qemu_api::assert_field_type;
+/// pub struct A {
+///     field1: u32,
+/// }
+///
+/// assert_field_type!(A, field1, u32);
+/// ```
+///
+/// Different types will cause a compile failure
+///
+/// ```compile_fail
+/// # use qemu_api::assert_field_type;
+/// # pub struct A { field1: u32 }
+/// assert_field_type!(A, field1, i32);
+/// ```
+#[macro_export]
+macro_rules! assert_field_type {
+    ($t:ty, $i:tt, $ti:ty) => {
+        const _: () = {
+            #[allow(unused)]
+            fn assert_field_type(v: $t) {
+                fn types_must_be_equal<T, U>(_: T)
+                where
+                    T: $crate::assertions::EqType<Itself = U>,
+                {
+                }
+                types_must_be_equal::<_, $ti>(v.$i);
+            }
+        };
+    };
+}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 4b43e02c0f9..83c6a987c05 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -12,6 +12,7 @@
 #[rustfmt::skip]
 pub mod prelude;
 
+pub mod assertions;
 pub mod bitops;
 pub mod c_str;
 pub mod callbacks;
-- 
2.47.1


