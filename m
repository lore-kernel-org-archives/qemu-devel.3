Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08E6CAC58E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLMu-0001Y5-5e; Sat, 13 Sep 2025 04:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMW-0000UC-9N
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMQ-00059T-LT
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K+HmigdLDFVVTS/7vwTiW6bioj5BvOHUB4Yq/I+1rrI=;
 b=W0k/118Emws9bTcWdZkLEidEsURDbKU5xw9Snrt2MjhtWx8p62Ww9wrQtYAsnyRU5u6FBf
 QTFBBUL5XqHmXjeGUA67NgxchzVXMQQeJIXNc2reWOyzUUvFtmWqZSoT5KOv5V79Hc519V
 sXGokF4vYuBvwhgisYlxt/2H3O1bLGE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-g6dVUqwwO62tNuLD1-OuWQ-1; Sat, 13 Sep 2025 04:11:49 -0400
X-MC-Unique: g6dVUqwwO62tNuLD1-OuWQ-1
X-Mimecast-MFC-AGG-ID: g6dVUqwwO62tNuLD1-OuWQ_1757751108
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3e5190bcba1so1791383f8f.2
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751108; x=1758355908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K+HmigdLDFVVTS/7vwTiW6bioj5BvOHUB4Yq/I+1rrI=;
 b=LP1V4m+5M3wboEbOlrM5RJNtPMxGCqy64SxNXwZTuypNxK1EmCL5iDvYGjinKCmZXO
 PXFzqrWgDDckmIPylk09ltq01TdimWhOsNpQIPZn1FMWwdkNSCKB8ryLbiFPe3vaAh/v
 V8KqdgmrwD9lTvxFjWw/veSjeKO3RWBmmmvPb3HrGtls5oVxTngSD0SeNpedkjj48EW7
 MbPuf4LRgLd4iKfPpP45LPp8CJ6iT/Is3nN06nEeUaxzHDi03sIHlheASCAKQTH/MRz7
 sOJZHEfYU35hkJYxGv1IkwBqxSRCBlp2FzXBNIxB0lmm5s5veOVs79K2paK+fG7xMAa9
 fCvg==
X-Gm-Message-State: AOJu0YyhjG5s4NuMVDqJLfdvibBM/bLTtUzOJd0z+KZjwKaZ8lZkvF4P
 yVzB5GZ82YHcEOLfRnHdA40zwYRjLClPc+BMAfYBJcZ8vFFCKw9sB2ywuQ+NjnckQSznmIo8BgC
 jQLzGjXOuu41MIU8XqxM7TrZiIqsD28ppUG/mvjFy/Qm93fZAGz5qoVCRbmRbx3DxLkG6dEZz/P
 osr7XArbyuPbGroq0GwtkmF5hwciUqW1HOQuxvS7OH
X-Gm-Gg: ASbGncuoL3MaAVf2aD3CZo+AD+kPEMEMy+Vxrpf0DSoLAva/zp3BcP39/nb0IH8vQq8
 9HrcSS0rn+Pv0GzpVQl08X6qccrLIuO+bPt2ERgW8D5aHPvdFTWQbFVNo4c8R6VsfkavkYKIM+J
 ReaVMxL1Q88Nrv7lCFxtq9xHv03KJrbUXlUmTtlrWcLn/y85nCE5uix5ys1vdaxjIhBaKWD/Z39
 BQV8HsKcm/3ticli/1TfKOT+xmifa24b03I7QmpvRZxvEAthJgNgiIrC3m7JK7IsLdrwi37eYXF
 bHLBD+UWneB5Sldo2TaUQYKkC2YT11wgvehWTUH2HxVjjwnA+q9EjyBGr+YZhP9rsFJOibvmx+3
 6NyiZ65ZjJkVfhslRvBfoGCtmZq2FAX45X3AavsAPBa0=
X-Received: by 2002:a5d:5f47:0:b0:3cd:edee:c7f8 with SMTP id
 ffacd0b85a97d-3e7659d3a84mr5197897f8f.29.1757751107352; 
 Sat, 13 Sep 2025 01:11:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuc4CoexhGDyqpgpeRepT8IjNOePta08pTIiZbvWX9iAG01QmGoa1bPJxm9ZfAG0m6p++6ww==
X-Received: by 2002:a5d:5f47:0:b0:3cd:edee:c7f8 with SMTP id
 ffacd0b85a97d-3e7659d3a84mr5197857f8f.29.1757751106633; 
 Sat, 13 Sep 2025 01:11:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e037c3cbdsm96140925e9.17.2025.09.13.01.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:11:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 43/61] rust: split "hwcore" crate
Date: Sat, 13 Sep 2025 10:09:24 +0200
Message-ID: <20250913080943.11710-44-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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
Link: https://lore.kernel.org/r/20250827104147.717203-16-marcandre.lureau@redhat.com
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                               |  1 +
 rust/hw/core/wrapper.h                    | 32 +++++++++
 rust/qemu-api/wrapper.h                   |  6 --
 rust/Cargo.lock                           | 17 +++++
 rust/Cargo.toml                           |  1 +
 rust/bindings/src/lib.rs                  | 64 ++++++++++++++++++
 rust/hw/char/pl011/Cargo.toml             |  1 +
 rust/hw/char/pl011/meson.build            |  1 +
 rust/hw/char/pl011/src/device.rs          | 10 ++-
 rust/hw/core/Cargo.toml                   | 26 ++++++++
 rust/hw/core/build.rs                     |  1 +
 rust/hw/core/meson.build                  | 80 +++++++++++++++++++++++
 rust/hw/core/src/bindings.rs              | 41 ++++++++++++
 rust/{qemu-api => hw/core}/src/irq.rs     |  0
 rust/hw/core/src/lib.rs                   | 14 ++++
 rust/{qemu-api => hw/core}/src/qdev.rs    |  2 +-
 rust/{qemu-api => hw/core}/src/sysbus.rs  |  0
 rust/{qemu-api => hw/core}/tests/tests.rs |  7 +-
 rust/hw/timer/hpet/Cargo.toml             |  1 +
 rust/hw/timer/hpet/meson.build            |  1 +
 rust/hw/timer/hpet/src/device.rs          | 26 ++++----
 rust/meson.build                          |  1 +
 rust/qemu-api-macros/src/lib.rs           | 10 +--
 rust/qemu-api-macros/src/tests.rs         | 20 +++---
 rust/qemu-api/Cargo.toml                  |  1 +
 rust/qemu-api/meson.build                 | 17 +----
 rust/qemu-api/src/bindings.rs             | 10 ---
 rust/qemu-api/src/lib.rs                  |  4 --
 rust/qemu-api/src/prelude.rs              |  4 --
 29 files changed, 318 insertions(+), 81 deletions(-)
 create mode 100644 rust/hw/core/wrapper.h
 create mode 100644 rust/bindings/src/lib.rs
 create mode 100644 rust/hw/core/Cargo.toml
 create mode 120000 rust/hw/core/build.rs
 create mode 100644 rust/hw/core/meson.build
 create mode 100644 rust/hw/core/src/bindings.rs
 rename rust/{qemu-api => hw/core}/src/irq.rs (100%)
 create mode 100644 rust/hw/core/src/lib.rs
 rename rust/{qemu-api => hw/core}/src/qdev.rs (99%)
 rename rust/{qemu-api => hw/core}/src/sysbus.rs (100%)
 rename rust/{qemu-api => hw/core}/tests/tests.rs (97%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 432ed513545..92d575b535a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3518,6 +3518,7 @@ S: Maintained
 F: rust/bql/
 F: rust/chardev/
 F: rust/common/
+F: rust/hw/core/
 F: rust/migration/
 F: rust/qemu-api
 F: rust/qemu-api-macros
diff --git a/rust/hw/core/wrapper.h b/rust/hw/core/wrapper.h
new file mode 100644
index 00000000000..3bdbd1249e4
--- /dev/null
+++ b/rust/hw/core/wrapper.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
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
+
+#include "hw/sysbus.h"
+#include "hw/clock.h"
+#include "hw/qdev-clock.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "hw/irq.h"
diff --git a/rust/qemu-api/wrapper.h b/rust/qemu-api/wrapper.h
index 564733b9035..7c9c20b14fe 100644
--- a/rust/qemu-api/wrapper.h
+++ b/rust/qemu-api/wrapper.h
@@ -49,11 +49,5 @@ typedef enum memory_order {
 
 #include "qemu/osdep.h"
 #include "qemu-io.h"
-#include "hw/sysbus.h"
-#include "hw/clock.h"
-#include "hw/qdev-clock.h"
-#include "hw/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
-#include "hw/irq.h"
 #include "exec/memattrs.h"
 #include "hw/char/pl011.h"
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index e6b75f30bef..77118e882b5 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -91,6 +91,7 @@ version = "0.1.0"
 dependencies = [
  "bql",
  "common",
+ "hwcore",
  "migration",
  "qemu_api",
  "qemu_api_macros",
@@ -99,6 +100,20 @@ dependencies = [
  "util",
 ]
 
+[[package]]
+name = "hwcore"
+version = "0.1.0"
+dependencies = [
+ "bql",
+ "chardev",
+ "common",
+ "migration",
+ "qemu_api_macros",
+ "qom",
+ "system",
+ "util",
+]
+
 [[package]]
 name = "itertools"
 version = "0.11.0"
@@ -133,6 +148,7 @@ dependencies = [
  "bql",
  "chardev",
  "common",
+ "hwcore",
  "migration",
  "qemu_api",
  "qemu_api_macros",
@@ -180,6 +196,7 @@ dependencies = [
  "bql",
  "chardev",
  "common",
+ "hwcore",
  "migration",
  "qemu_api_macros",
  "qom",
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 8e210d277a2..8ec07d20651 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -9,6 +9,7 @@ members = [
     "qemu-api",
     "qom",
     "system",
+    "hw/core",
     "hw/char/pl011",
     "hw/timer/hpet",
     "util",
diff --git a/rust/bindings/src/lib.rs b/rust/bindings/src/lib.rs
new file mode 100644
index 00000000000..5bf03b13706
--- /dev/null
+++ b/rust/bindings/src/lib.rs
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#![allow(
+    dead_code,
+    improper_ctypes_definitions,
+    improper_ctypes,
+    non_camel_case_types,
+    non_snake_case,
+    non_upper_case_globals,
+    unsafe_op_in_unsafe_fn,
+    clippy::pedantic,
+    clippy::restriction,
+    clippy::style,
+    clippy::missing_const_for_fn,
+    clippy::ptr_offset_with_cast,
+    clippy::useless_transmute,
+    clippy::missing_safety_doc
+)]
+
+//! `bindgen`-generated declarations.
+
+#[cfg(MESON)]
+include!("bindings.inc.rs");
+
+#[cfg(not(MESON))]
+include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
+
+// SAFETY: these are implemented in C; the bindings need to assert that the
+// BQL is taken, either directly or via `BqlCell` and `BqlRefCell`.
+// When bindings for character devices are introduced, this can be
+// moved to the Opaque<> wrapper in src/chardev.rs.
+unsafe impl Send for CharBackend {}
+unsafe impl Sync for CharBackend {}
+
+// SAFETY: this is a pure data struct
+unsafe impl Send for CoalescedMemoryRange {}
+unsafe impl Sync for CoalescedMemoryRange {}
+
+// SAFETY: these are constants and vtables; the Send and Sync requirements
+// are deferred to the unsafe callbacks that they contain
+unsafe impl Send for MemoryRegionOps {}
+unsafe impl Sync for MemoryRegionOps {}
+
+unsafe impl Send for Property {}
+unsafe impl Sync for Property {}
+
+unsafe impl Send for TypeInfo {}
+unsafe impl Sync for TypeInfo {}
+
+unsafe impl Send for VMStateDescription {}
+unsafe impl Sync for VMStateDescription {}
+
+unsafe impl Send for VMStateField {}
+unsafe impl Sync for VMStateField {}
+
+unsafe impl Send for VMStateInfo {}
+unsafe impl Sync for VMStateInfo {}
+
+// bindgen does not derive Default here
+#[allow(clippy::derivable_impls)]
+impl Default for VMStateFlags {
+    fn default() -> Self {
+        Self(0)
+    }
+}
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index e4b1c3f1eb8..830d88586bb 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -23,6 +23,7 @@ migration = { path = "../../../migration" }
 qom = { path = "../../../qom" }
 chardev = { path = "../../../chardev" }
 system = { path = "../../../system" }
+hwcore = { path = "../../../hw/core" }
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
 
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index fae6e1b9c9d..fac04321133 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -16,6 +16,7 @@ _libpl011_rs = static_library(
     qom_rs,
     chardev_rs,
     system_rs,
+    hwcore_rs,
   ],
 )
 
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index c65db5a5174..a6a17d9f2dc 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -7,16 +7,14 @@
 use bql::BqlRefCell;
 use chardev::{CharBackend, Chardev, Event};
 use common::{static_assert, uninit_field_mut};
+use hwcore::{
+    Clock, ClockEvent, DeviceImpl, DeviceMethods, DeviceState, IRQState, InterruptSource,
+    ResetType, ResettablePhasesImpl, SysBusDevice, SysBusDeviceImpl, SysBusDeviceMethods,
+};
 use migration::{
     self, impl_vmstate_forward, impl_vmstate_struct, vmstate_fields, vmstate_of,
     vmstate_subsections, vmstate_unused, VMStateDescription, VMStateDescriptionBuilder,
 };
-use qemu_api::{
-    irq::{IRQState, InterruptSource},
-    prelude::*,
-    qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, ResetType, ResettablePhasesImpl},
-    sysbus::{SysBusDevice, SysBusDeviceImpl},
-};
 use qom::{prelude::*, ObjectImpl, Owned, ParentField, ParentInit};
 use system::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder};
 use util::{log::Log, log_mask_ln};
diff --git a/rust/hw/core/Cargo.toml b/rust/hw/core/Cargo.toml
new file mode 100644
index 00000000000..0b353802644
--- /dev/null
+++ b/rust/hw/core/Cargo.toml
@@ -0,0 +1,26 @@
+[package]
+name = "hwcore"
+version = "0.1.0"
+description = "Rust bindings for QEMU/hwcore"
+resolver = "2"
+publish = false
+
+authors.workspace = true
+edition.workspace = true
+homepage.workspace = true
+license.workspace = true
+repository.workspace = true
+rust-version.workspace = true
+
+[dependencies]
+common = { path = "../../common" }
+bql = { path = "../../bql" }
+qom = { path = "../../qom" }
+chardev = { path = "../../chardev" }
+migration = { path = "../../migration" }
+system = { path = "../../system" }
+util = { path = "../../util" }
+qemu_api_macros = { path = "../../qemu-api-macros" }
+
+[lints]
+workspace = true
diff --git a/rust/hw/core/build.rs b/rust/hw/core/build.rs
new file mode 120000
index 00000000000..2a79ee31b8c
--- /dev/null
+++ b/rust/hw/core/build.rs
@@ -0,0 +1 @@
+../../util/build.rs
\ No newline at end of file
diff --git a/rust/hw/core/meson.build b/rust/hw/core/meson.build
new file mode 100644
index 00000000000..7dd1ade6f0f
--- /dev/null
+++ b/rust/hw/core/meson.build
@@ -0,0 +1,80 @@
+_hwcore_bindgen_args = []
+c_enums = [
+  'DeviceCategory',
+  'GpioPolarity',
+  'MachineInitPhase',
+  'ResetType',
+]
+foreach enum : c_enums
+  _hwcore_bindgen_args += ['--rustified-enum', enum]
+endforeach
+
+blocked_type = [
+  'Chardev',
+  'Error',
+  'ObjectClass',
+  'MemoryRegion',
+  'VMStateDescription',
+]
+foreach type: blocked_type
+  _hwcore_bindgen_args += ['--blocklist-type', type]
+endforeach
+
+c_bitfields = [
+  'ClockEvent',
+]
+foreach enum : c_bitfields
+  _hwcore_bindgen_args += ['--bitfield-enum', enum]
+endforeach
+
+# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
+#
+# Rust bindings generation with `bindgen` might fail in some cases where the
+# detected `libclang` does not match the expected `clang` version/target. In
+# this case you must pass the path to `clang` and `libclang` to your build
+# command invocation using the environment variables CLANG_PATH and
+# LIBCLANG_PATH
+_hwcore_bindings_inc_rs = rust.bindgen(
+  input: 'wrapper.h',
+  dependencies: common_ss.all_dependencies(),
+  output: 'bindings.inc.rs',
+  include_directories: bindings_incdir,
+  bindgen_version: ['>=0.60.0'],
+  args: bindgen_args_common + _hwcore_bindgen_args,
+)
+
+_hwcore_rs = static_library(
+  'hwcore',
+  structured_sources(
+    [
+      'src/lib.rs',
+      'src/bindings.rs',
+      'src/irq.rs',
+      'src/qdev.rs',
+      'src/sysbus.rs',
+    ],
+    {'.': _hwcore_bindings_inc_rs}
+  ),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  link_with: [_bql_rs, _chardev_rs, _migration_rs, _qom_rs, _system_rs, _util_rs],
+  dependencies: [qemu_api_macros, common_rs],
+)
+
+hwcore_rs = declare_dependency(link_with: [_hwcore_rs],
+  dependencies: [qom_rs, hwcore])
+
+test('rust-hwcore-rs-integration',
+    executable(
+        'rust-hwcore-rs-integration',
+        files('tests/tests.rs'),
+        override_options: ['rust_std=2021', 'build.rust_std=2021'],
+        rust_args: ['--test'],
+        install: false,
+        dependencies: [common_rs, hwcore_rs, bql_rs, migration_rs, qemu_api_macros, util_rs]),
+    args: [
+        '--test', '--test-threads', '1',
+        '--format', 'pretty',
+    ],
+    protocol: 'rust',
+    suite: ['unit', 'rust'])
diff --git a/rust/hw/core/src/bindings.rs b/rust/hw/core/src/bindings.rs
new file mode 100644
index 00000000000..919c02b56ae
--- /dev/null
+++ b/rust/hw/core/src/bindings.rs
@@ -0,0 +1,41 @@
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
+use chardev::bindings::Chardev;
+use common::Zeroable;
+use migration::bindings::VMStateDescription;
+use qom::bindings::ObjectClass;
+use system::bindings::MemoryRegion;
+use util::bindings::Error;
+
+#[cfg(MESON)]
+include!("bindings.inc.rs");
+
+#[cfg(not(MESON))]
+include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
+
+unsafe impl Send for Property {}
+unsafe impl Sync for Property {}
+
+unsafe impl Send for TypeInfo {}
+unsafe impl Sync for TypeInfo {}
+
+unsafe impl Zeroable for Property__bindgen_ty_1 {}
+unsafe impl Zeroable for Property {}
diff --git a/rust/qemu-api/src/irq.rs b/rust/hw/core/src/irq.rs
similarity index 100%
rename from rust/qemu-api/src/irq.rs
rename to rust/hw/core/src/irq.rs
diff --git a/rust/hw/core/src/lib.rs b/rust/hw/core/src/lib.rs
new file mode 100644
index 00000000000..c5588d9bc27
--- /dev/null
+++ b/rust/hw/core/src/lib.rs
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+pub use qom;
+
+pub mod bindings;
+
+mod irq;
+pub use irq::*;
+
+mod qdev;
+pub use qdev::*;
+
+mod sysbus;
+pub use sysbus::*;
diff --git a/rust/qemu-api/src/qdev.rs b/rust/hw/core/src/qdev.rs
similarity index 99%
rename from rust/qemu-api/src/qdev.rs
rename to rust/hw/core/src/qdev.rs
index 7efc796f502..8e9702ce0bb 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -9,13 +9,13 @@
     ptr::NonNull,
 };
 
-pub use bindings::{ClockEvent, DeviceClass, Property, ResetType};
 use chardev::Chardev;
 use common::{callbacks::FnCall, Opaque};
 use migration::{impl_vmstate_c_struct, VMStateDescription};
 use qom::{prelude::*, ObjectClass, ObjectImpl, Owned, ParentInit};
 use util::{Error, Result};
 
+pub use crate::bindings::{ClockEvent, DeviceClass, Property, ResetType};
 use crate::{
     bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out, ResettableClass},
     irq::InterruptSource,
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/hw/core/src/sysbus.rs
similarity index 100%
rename from rust/qemu-api/src/sysbus.rs
rename to rust/hw/core/src/sysbus.rs
diff --git a/rust/qemu-api/tests/tests.rs b/rust/hw/core/tests/tests.rs
similarity index 97%
rename from rust/qemu-api/tests/tests.rs
rename to rust/hw/core/tests/tests.rs
index f2e5eb9f4f4..21ee301fa68 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/hw/core/tests/tests.rs
@@ -5,16 +5,11 @@
 use std::{ffi::CStr, ptr::addr_of};
 
 use bql::BqlCell;
+use hwcore::{DeviceImpl, DeviceState, ResettablePhasesImpl, SysBusDevice};
 use migration::{VMStateDescription, VMStateDescriptionBuilder};
-use qemu_api::{
-    qdev::{DeviceImpl, DeviceState, ResettablePhasesImpl},
-    sysbus::SysBusDevice,
-};
 use qom::{prelude::*, ObjectImpl, ParentField};
 use util::bindings::{module_call_init, module_init_type};
 
-mod vmstate_tests;
-
 // Test that macros can compile.
 pub const VMSTATE: VMStateDescription<DummyState> = VMStateDescriptionBuilder::<DummyState>::new()
     .name(c"name")
diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
index a95b1271c64..e28d66f6457 100644
--- a/rust/hw/timer/hpet/Cargo.toml
+++ b/rust/hw/timer/hpet/Cargo.toml
@@ -19,6 +19,7 @@ qom = { path = "../../../qom" }
 system = { path = "../../../system" }
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
+hwcore = { path = "../../../hw/core" }
 
 [lints]
 workspace = true
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index c4ffe020f6b..e6f99b67785 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -12,6 +12,7 @@ _libhpet_rs = static_library(
     qemu_api_macros,
     qom_rs,
     system_rs,
+    hwcore_rs,
   ],
 )
 
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 841c2ba3375..3031539744f 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -12,17 +12,15 @@
 
 use bql::{BqlCell, BqlRefCell};
 use common::{bitops::IntegerExt, uninit_field_mut};
+use hwcore::{
+    bindings::{qdev_prop_bit, qdev_prop_bool, qdev_prop_uint32, qdev_prop_usize},
+    declare_properties, define_property, DeviceImpl, DeviceMethods, DeviceState, InterruptSource,
+    Property, ResetType, ResettablePhasesImpl, SysBusDevice, SysBusDeviceImpl, SysBusDeviceMethods,
+};
 use migration::{
     self, impl_vmstate_struct, vmstate_fields, vmstate_of, vmstate_subsections, vmstate_validate,
     VMStateDescription, VMStateDescriptionBuilder,
 };
-use qemu_api::{
-    bindings::{qdev_prop_bit, qdev_prop_bool, qdev_prop_uint32, qdev_prop_usize},
-    irq::InterruptSource,
-    prelude::*,
-    qdev::{DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
-    sysbus::{SysBusDevice, SysBusDeviceImpl},
-};
 use qom::{prelude::*, ObjectImpl, ParentField, ParentInit};
 use system::{
     bindings::{address_space_memory, address_space_stl_le, hwaddr},
@@ -904,9 +902,9 @@ impl ObjectImpl for HPETState {
 }
 
 // TODO: Make these properties user-configurable!
-qemu_api::declare_properties! {
+declare_properties! {
     HPET_PROPERTIES,
-    qemu_api::define_property!(
+    define_property!(
         c"timers",
         HPETState,
         num_timers,
@@ -914,7 +912,7 @@ impl ObjectImpl for HPETState {
         u8,
         default = HPET_MIN_TIMERS
     ),
-    qemu_api::define_property!(
+    define_property!(
         c"msi",
         HPETState,
         flags,
@@ -923,7 +921,7 @@ impl ObjectImpl for HPETState {
         bit = HPET_FLAG_MSI_SUPPORT_SHIFT as u8,
         default = false,
     ),
-    qemu_api::define_property!(
+    define_property!(
         c"hpet-intcap",
         HPETState,
         int_route_cap,
@@ -931,7 +929,7 @@ impl ObjectImpl for HPETState {
         u32,
         default = 0
     ),
-    qemu_api::define_property!(
+    define_property!(
         c"hpet-offset-saved",
         HPETState,
         hpet_offset_saved,
@@ -1004,8 +1002,8 @@ impl ObjectImpl for HPETState {
         .build();
 
 // SAFETY: HPET_PROPERTIES is a valid Property array constructed with the
-// qemu_api::declare_properties macro.
-unsafe impl qemu_api::qdev::DevicePropertiesImpl for HPETState {
+// hwcore::declare_properties macro.
+unsafe impl hwcore::DevicePropertiesImpl for HPETState {
     const PROPERTIES: &'static [Property] = &HPET_PROPERTIES;
 }
 
diff --git a/rust/meson.build b/rust/meson.build
index d8b71f55061..041b0a473e5 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -31,6 +31,7 @@ subdir('bql')
 subdir('qom')
 subdir('system')
 subdir('chardev')
+subdir('hw/core')
 subdir('qemu-api')
 
 subdir('hw')
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index e643e57ebdf..830b4326985 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -272,24 +272,24 @@ macro_rules! str_to_c_str {
             },
         )?;
         let field_ty = field.ty.clone();
-        let qdev_prop = quote! { <#field_ty as ::qemu_api::qdev::QDevProp>::VALUE };
+        let qdev_prop = quote! { <#field_ty as ::hwcore::QDevProp>::VALUE };
         let set_default = defval.is_some();
         let defval = defval.unwrap_or(syn::Expr::Verbatim(quote! { 0 }));
         properties_expanded.push(quote! {
-            ::qemu_api::bindings::Property {
+            ::hwcore::bindings::Property {
                 name: ::std::ffi::CStr::as_ptr(#prop_name),
                 info: #qdev_prop ,
                 offset: ::core::mem::offset_of!(#name, #field_name) as isize,
                 set_default: #set_default,
-                defval: ::qemu_api::bindings::Property__bindgen_ty_1 { u: #defval as u64 },
+                defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: #defval as u64 },
                 ..::common::Zeroable::ZERO
             }
         });
     }
 
     Ok(quote_spanned! {input.span() =>
-        unsafe impl ::qemu_api::qdev::DevicePropertiesImpl for #name {
-            const PROPERTIES: &'static [::qemu_api::bindings::Property] = &[
+        unsafe impl ::hwcore::DevicePropertiesImpl for #name {
+            const PROPERTIES: &'static [::hwcore::bindings::Property] = &[
                 #(#properties_expanded),*
             ];
         }
diff --git a/rust/qemu-api-macros/src/tests.rs b/rust/qemu-api-macros/src/tests.rs
index 76e6c57479e..9ab7eab7f37 100644
--- a/rust/qemu-api-macros/src/tests.rs
+++ b/rust/qemu-api-macros/src/tests.rs
@@ -100,14 +100,14 @@ pub struct DummyState {
             }
         },
         quote! {
-            unsafe impl ::qemu_api::qdev::DevicePropertiesImpl for DummyState {
-                const PROPERTIES: &'static [::qemu_api::bindings::Property] = &[
-                    ::qemu_api::bindings::Property {
+            unsafe impl ::hwcore::DevicePropertiesImpl for DummyState {
+                const PROPERTIES: &'static [::hwcore::bindings::Property] = &[
+                    ::hwcore::bindings::Property {
                         name: ::std::ffi::CStr::as_ptr(c"migrate_clock"),
-                        info: <bool as ::qemu_api::qdev::QDevProp>::VALUE,
+                        info: <bool as ::hwcore::QDevProp>::VALUE,
                         offset: ::core::mem::offset_of!(DummyState, migrate_clock) as isize,
                         set_default: true,
-                        defval: ::qemu_api::bindings::Property__bindgen_ty_1 { u: true as u64 },
+                        defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: true as u64 },
                         ..::common::Zeroable::ZERO
                     }
                 ];
@@ -127,14 +127,14 @@ pub struct DummyState {
             }
         },
         quote! {
-            unsafe impl ::qemu_api::qdev::DevicePropertiesImpl for DummyState {
-                const PROPERTIES: &'static [::qemu_api::bindings::Property] = &[
-                    ::qemu_api::bindings::Property {
+            unsafe impl ::hwcore::DevicePropertiesImpl for DummyState {
+                const PROPERTIES: &'static [::hwcore::bindings::Property] = &[
+                    ::hwcore::bindings::Property {
                         name: ::std::ffi::CStr::as_ptr(c"migrate-clk"),
-                        info: <bool as ::qemu_api::qdev::QDevProp>::VALUE,
+                        info: <bool as ::hwcore::QDevProp>::VALUE,
                         offset: ::core::mem::offset_of!(DummyState, migrate_clock) as isize,
                         set_default: true,
-                        defval: ::qemu_api::bindings::Property__bindgen_ty_1 { u: true as u64 },
+                        defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: true as u64 },
                         ..::common::Zeroable::ZERO
                     }
                 ];
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index 2884c1d460b..9e7afc7e3ad 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -16,6 +16,7 @@ rust-version.workspace = true
 [dependencies]
 common = { path = "../common" }
 chardev = { path = "../chardev" }
+hwcore = { path = "../hw/core" }
 migration = { path = "../migration" }
 util = { path = "../util" }
 bql = { path = "../bql" }
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 92e2581a64e..2dc638782ca 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -3,22 +3,12 @@ _qemu_api_cfg = run_command(rustc_args,
   capture: true, check: true).stdout().strip().splitlines()
 
 c_enums = [
-  'DeviceCategory',
-  'GpioPolarity',
-  'MachineInitPhase',
   'MemoryDeviceInfoKind',
-  'ResetType',
 ]
 _qemu_api_bindgen_args = []
 foreach enum : c_enums
   _qemu_api_bindgen_args += ['--rustified-enum', enum]
 endforeach
-c_bitfields = [
-  'ClockEvent',
-]
-foreach enum : c_bitfields
-  _qemu_api_bindgen_args += ['--bitfield-enum', enum]
-endforeach
 
 blocked_type = [
   'Chardev',
@@ -55,17 +45,14 @@ _qemu_api_rs = static_library(
     [
       'src/lib.rs',
       'src/bindings.rs',
-      'src/irq.rs',
       'src/prelude.rs',
-      'src/qdev.rs',
-      'src/sysbus.rs',
     ],
     {'.' : _qemu_api_bindings_inc_rs},
   ),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
-  dependencies: [anyhow_rs, bql_rs, chardev_rs, common_rs, foreign_rs, libc_rs, migration_rs, qemu_api_macros,
+  dependencies: [anyhow_rs, bql_rs, chardev_rs, common_rs, foreign_rs, hwcore_rs, libc_rs, migration_rs, qemu_api_macros,
                  qom_rs, system_rs, util_rs, hwcore],
 )
 
@@ -75,7 +62,7 @@ qemu_api_rs = declare_dependency(link_with: [_qemu_api_rs],
 test('rust-qemu-api-integration',
     executable(
         'rust-qemu-api-integration',
-        files('tests/tests.rs', 'tests/vmstate_tests.rs'),
+        files('tests/vmstate_tests.rs'),
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
         rust_args: ['--test'],
         install: false,
diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index 63b805c76e4..9c863e9b5b4 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -21,7 +21,6 @@
 //! `bindgen`-generated declarations.
 
 use chardev::bindings::Chardev;
-use common::Zeroable;
 use migration::bindings::VMStateDescription;
 use qom::bindings::ObjectClass;
 use system::bindings::{device_endian, MemTxAttrs, MemoryRegion};
@@ -32,12 +31,3 @@
 
 #[cfg(not(MESON))]
 include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
-
-unsafe impl Send for Property {}
-unsafe impl Sync for Property {}
-
-unsafe impl Send for TypeInfo {}
-unsafe impl Sync for TypeInfo {}
-
-unsafe impl Zeroable for crate::bindings::Property__bindgen_ty_1 {}
-unsafe impl Zeroable for crate::bindings::Property {}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 8d574404789..21b886035f3 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -13,10 +13,6 @@
 #[rustfmt::skip]
 pub mod prelude;
 
-pub mod irq;
-pub mod qdev;
-pub mod sysbus;
-
 // Allow proc-macros to refer to `::qemu_api` inside the `qemu_api` crate (this
 // crate).
 extern crate self as qemu_api;
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index 9e9d1c82474..8db56f9f817 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -3,7 +3,3 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 //! Commonly used traits and types for QEMU.
-
-pub use crate::qdev::DeviceMethods;
-
-pub use crate::sysbus::SysBusDeviceMethods;
-- 
2.51.0


