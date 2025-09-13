Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AA3CAC58E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLN6-0001t0-Iw; Sat, 13 Sep 2025 04:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMb-0000ky-9P
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMX-0005Ap-3f
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bT0gqJJClXbo7glAkR0Ah6HPDYTr2ivQc8sNu5n8pRc=;
 b=e32BksuNvoS7B2O2HWy3zXMU2VvivgXXmAaTx65bvs9dsk2WYJwk4P/hQJIxSO9PtKINs+
 f+gvocjSN/Iu2ssV2HRfk1F5YrtxiyRb6DE0rWLZvhIg9iUfyg+CzqStdg8IEDUtXLm1lb
 4jMBrx9tr2TWf9C76PP5KBbgo7kyR9w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-_tiSCjXsMgOe0KZv94U29Q-1; Sat, 13 Sep 2025 04:11:56 -0400
X-MC-Unique: _tiSCjXsMgOe0KZv94U29Q-1
X-Mimecast-MFC-AGG-ID: _tiSCjXsMgOe0KZv94U29Q_1757751115
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3e751508f3aso1972289f8f.0
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751114; x=1758355914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bT0gqJJClXbo7glAkR0Ah6HPDYTr2ivQc8sNu5n8pRc=;
 b=LERnlblg2U58Bu/IQIWXKLaDuAcGB6yVqZKQpvACdowtWzi6YAHFJ9/pncDfukv/zw
 C6FH/Ela4PRaj0+Q3E71FbJdtfBQnPHrP0nsOl97R1qeeCUs+WxQKItTDCUk2kZooHh5
 olaUt5ME56jMJCrnpL6yJ0eBjuXZpqhTDMVd0Jy00x4vgbZYQolAjcxTUlDu44azHtFU
 BIYz7fey4WVpZGEQHPL2sw3WhOOe9y4eTEPQVob436cVx2IGVkfqVL2pBkNC4/FhQ3Bv
 +vFqzTQItR8x+mqGHk6ZVv4oZ4KEGCO5v6+4LrNRWlxrdXQMzIqPraYVXcRmsWYFha6I
 xmLw==
X-Gm-Message-State: AOJu0YxDtj9Gpm4COfDKtev3HUyS0oNIKr91iuDJ7dfIPirpgqg8f2uF
 ooL6rxb/7gTEnA86wavcx+EfHS+wkpE++9gtMSwXeQJOBq2Rb/ZSFXdKhe+LvxSovHZ7shOOrAq
 wTp/FzndY/0Jbu4Jj10VIRunVYm9Ncl7KVHJCoLDCNb+A+q1MRuh0Wbfn9GRacTQClDTvGXrgdB
 JSlPuhZrfL+C4m45CNXbwhQ7qlhglDofyLBHwFfjDH
X-Gm-Gg: ASbGncuaixveJzcj4rKoh/Iyma6EqRDsf4r8DPy6wYUxKUR+lmhkfTE2zuSBDuQ62wF
 jp4Tnfk+2X5xC4VZcbAHJHwy84WO0roNi3ArzyzEe6Lkk78LiCl8+jZgyAlkAgCmh5GkA34OAUL
 E1nPXizzDWcD/wIBq1/ogZtls+fHiHeYv5oFHkZgf0VQnKRsK5ocpTL727pcWQnDWpwoizTFAcp
 jE7/Jpg+EtZo1rkng0zFjit0JbguMOlEzWantcxDHXFhqdc11u2l/yhdnxZ/223VUPeu1i6Jn+/
 43RX1+zAcoXI1eEe3F15qJ8n/NpWjYQ788FFS8QeLKpJRb37986re99E4rDd9V0t+RW+EWreg/I
 9D9o/kbzcO2Y/IgxA6UxpcNV1RQFhibEz4OIGyCyOl9o=
X-Received: by 2002:a5d:588a:0:b0:3e9:12ea:fab8 with SMTP id
 ffacd0b85a97d-3e912eafc58mr227307f8f.43.1757751114237; 
 Sat, 13 Sep 2025 01:11:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjAp9/6Yi9NAWa5lLhh3HDLPNALsnxvx8vFKzxwoOEmf8iMdAgLKeQBGyfs37CQ9aAu/L5jw==
X-Received: by 2002:a5d:588a:0:b0:3e9:12ea:fab8 with SMTP id
 ffacd0b85a97d-3e912eafc58mr227278f8f.43.1757751113632; 
 Sat, 13 Sep 2025 01:11:53 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e8892afc04sm1591367f8f.13.2025.09.13.01.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:11:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 46/61] rust/pl011: drop dependency on qemu_api
Date: Sat, 13 Sep 2025 10:09:27 +0200
Message-ID: <20250913080943.11710-47-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20250827104147.717203-19-marcandre.lureau@redhat.com
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/wrapper.h       | 51 ++++++++++++++++++++++++++++++
 rust/Cargo.lock                    |  1 -
 rust/hw/char/pl011/Cargo.toml      |  1 -
 rust/hw/char/pl011/build.rs        |  1 +
 rust/hw/char/pl011/meson.build     | 27 ++++++++++++++--
 rust/hw/char/pl011/src/bindings.rs | 27 ++++++++++++++++
 rust/hw/char/pl011/src/device.rs   |  2 +-
 rust/hw/char/pl011/src/lib.rs      |  1 +
 8 files changed, 106 insertions(+), 5 deletions(-)
 create mode 100644 rust/hw/char/pl011/wrapper.h
 create mode 120000 rust/hw/char/pl011/build.rs
 create mode 100644 rust/hw/char/pl011/src/bindings.rs

diff --git a/rust/hw/char/pl011/wrapper.h b/rust/hw/char/pl011/wrapper.h
new file mode 100644
index 00000000000..87a5a589c8e
--- /dev/null
+++ b/rust/hw/char/pl011/wrapper.h
@@ -0,0 +1,51 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2024 Linaro Ltd.
+ *
+ * Authors: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+
+/*
+ * This header file is meant to be used as input to the `bindgen` application
+ * in order to generate C FFI compatible Rust bindings.
+ */
+
+#ifndef __CLANG_STDATOMIC_H
+#define __CLANG_STDATOMIC_H
+/*
+ * Fix potential missing stdatomic.h error in case bindgen does not insert the
+ * correct libclang header paths on its own. We do not use stdatomic.h symbols
+ * in QEMU code, so it's fine to declare dummy types instead.
+ */
+typedef enum memory_order {
+  memory_order_relaxed,
+  memory_order_consume,
+  memory_order_acquire,
+  memory_order_release,
+  memory_order_acq_rel,
+  memory_order_seq_cst,
+} memory_order;
+#endif /* __CLANG_STDATOMIC_H */
+
+#include "qemu/osdep.h"
+#include "hw/char/pl011.h"
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index c407029afed..2018d13fbf5 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -149,7 +149,6 @@ dependencies = [
  "common",
  "hwcore",
  "migration",
- "qemu_api",
  "qemu_macros",
  "qom",
  "system",
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index 9e451fc0aa8..285d25c2178 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -24,7 +24,6 @@ qom = { path = "../../../qom" }
 chardev = { path = "../../../chardev" }
 system = { path = "../../../system" }
 hwcore = { path = "../../../hw/core" }
-qemu_api = { path = "../../../qemu-api" }
 qemu_macros = { path = "../../../qemu-macros" }
 
 [lints]
diff --git a/rust/hw/char/pl011/build.rs b/rust/hw/char/pl011/build.rs
new file mode 120000
index 00000000000..5f5060db356
--- /dev/null
+++ b/rust/hw/char/pl011/build.rs
@@ -0,0 +1 @@
+../../../util/build.rs
\ No newline at end of file
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index bad6a839c39..a14993f6921 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -1,6 +1,30 @@
+# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
+#
+# Rust bindings generation with `bindgen` might fail in some cases where the
+# detected `libclang` does not match the expected `clang` version/target. In
+# this case you must pass the path to `clang` and `libclang` to your build
+# command invocation using the environment variables CLANG_PATH and
+# LIBCLANG_PATH
+_libpl011_bindings_inc_rs = rust.bindgen(
+  input: 'wrapper.h',
+  dependencies: common_ss.all_dependencies(),
+  output: 'bindings.inc.rs',
+  include_directories: bindings_incdir,
+  bindgen_version: ['>=0.60.0'],
+  args: bindgen_args_common,
+)
+
 _libpl011_rs = static_library(
   'pl011',
-  files('src/lib.rs'),
+  structured_sources(
+    [
+      'src/lib.rs',
+      'src/bindings.rs',
+      'src/device.rs',
+      'src/registers.rs',
+    ],
+    {'.' : _libpl011_bindings_inc_rs},
+  ),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   dependencies: [
@@ -8,7 +32,6 @@ _libpl011_rs = static_library(
     bilge_impl_rs,
     bits_rs,
     common_rs,
-    qemu_api_rs,
     util_rs,
     migration_rs,
     bql_rs,
diff --git a/rust/hw/char/pl011/src/bindings.rs b/rust/hw/char/pl011/src/bindings.rs
new file mode 100644
index 00000000000..bd5ea840cb2
--- /dev/null
+++ b/rust/hw/char/pl011/src/bindings.rs
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#![allow(
+    dead_code,
+    improper_ctypes_definitions,
+    improper_ctypes,
+    non_camel_case_types,
+    non_snake_case,
+    non_upper_case_globals,
+    unnecessary_transmutes,
+    unsafe_op_in_unsafe_fn,
+    clippy::pedantic,
+    clippy::restriction,
+    clippy::style,
+    clippy::missing_const_for_fn,
+    clippy::ptr_offset_with_cast,
+    clippy::useless_transmute,
+    clippy::missing_safety_doc,
+    clippy::too_many_arguments
+)]
+
+//! `bindgen`-generated declarations.
+
+#[cfg(MESON)]
+include!("bindings.inc.rs");
+
+#[cfg(not(MESON))]
+include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 3010b6d9839..85626a969d4 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -130,7 +130,7 @@ pub struct PL011State {
 // structs, so the size of the Rust version must not be any larger
 // than the size of the C one. If this assert triggers you need to
 // expand the padding_for_rust[] array in the C PL011State struct.
-static_assert!(size_of::<PL011State>() <= size_of::<qemu_api::bindings::PL011State>());
+static_assert!(size_of::<PL011State>() <= size_of::<crate::bindings::PL011State>());
 
 qom_isa!(PL011State : SysBusDevice, DeviceState, Object);
 
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index 2b70d2ff560..0c19b708c0a 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -12,6 +12,7 @@
 //! See [`PL011State`](crate::device::PL011State) for the device model type and
 //! the [`registers`] module for register types.
 
+mod bindings;
 mod device;
 mod registers;
 
-- 
2.51.0


