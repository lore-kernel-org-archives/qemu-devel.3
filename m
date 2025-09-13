Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E46CAC587
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLMT-0000Mv-AA; Sat, 13 Sep 2025 04:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMC-0008QH-2l
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLM7-00056n-NL
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=imKtYE1VIpkUY1c3hyyMnDVKt/4llrsbgdc+ASu2/Cw=;
 b=gv9eBOqnqTvKSo1uMegiee7AH1yJM6kee99s8X7Mizn5WrxPotK8rB+VXh+Z8pK5aYpQV/
 TxVfA63ZIcE7dj0J4vEaoMju8dBkjp2eU6My4kH5w+5Hh53CA7dJ9UtVeYrfo6ym9lVYIl
 xUa4EGmVBx+5zIOOA+tuLuuxdX+OcYI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-5O0qIDhxN8-6Rtn0tuCJoQ-1; Sat, 13 Sep 2025 04:11:31 -0400
X-MC-Unique: 5O0qIDhxN8-6Rtn0tuCJoQ-1
X-Mimecast-MFC-AGG-ID: 5O0qIDhxN8-6Rtn0tuCJoQ_1757751091
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3e067ef24aaso1708201f8f.3
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751090; x=1758355890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=imKtYE1VIpkUY1c3hyyMnDVKt/4llrsbgdc+ASu2/Cw=;
 b=No57q6gffSB/cLstIEOQXLyNF9nEuDeNW57AFZ9G55YqOazu5Bx5Xhwm6BvWMVjEid
 Ivr4sOgOVEDwYu9GyvT/+uvlQNk63qAuTQ8BDevInb6gTx7e/MYUc8LfWjboPlqFX36a
 qJvkUhchP4cVh/9WAZ6QbvjdoEX+hxsE4NcZmo2DeQphpLmebt+WYQCqIBoWKsb6Iy8i
 hyoL2NYvRYwJ2JGD5oIrY8/eTGyetzEzrjkhBzCGomQZS4RlwQcNsyp6UhYD7oDnIPL3
 nY0Z9hxeTKWtlsmz81pFTOkS0JE896GhhL6E4u5lq3I1s+DR4HKfb1cK5rrKBOFGaExm
 3OKA==
X-Gm-Message-State: AOJu0Yz/4xwSPnKTCrdO6eyxD1YYnibnekkorVO7ehHNRWBve3G5C2hb
 09644uAYlkugiNVbS2qCmbbkv0b8hmLM7/0tIM+9AX3aHvmU83ZA3f6SX3PbfQvZrLxMa2KqdXW
 mEtAQtT1G3jAnbUT7poh5oI5TMSRpTtMjddcDUMtWbq0hxhDl3Fi/2pW1VC/PoiofzIYNL851Jb
 gsQE3ZC7pLwtoHwde34kdraonm0derhslghELD15rW
X-Gm-Gg: ASbGncsw8RmO9T+yze9+hI2CiJvli6sPASfNSBLu439Z7nfj84EsOG74VDti+1pf8mO
 8bh1tobm9AEnUC86HE/8p+v5WFuB60hc84/opiYkaCmk20EtWcY2EeFw/fw1k07apa/+o+dLosb
 N3p7eskRrNewBcNxKZAxbrA7F8D+/NxQamlQXranm2ndOKKByluZYcG7E0NHwUiq7K3UE94yvL8
 fw8Nf9LdyUJFiLPlFuoiLCxv51X3GiVE0ewqHtRabNLpc/to1vC28S4+eiAcyYSM3f4Wr1mQ2+1
 oJzsZd7lBHsF7UMP41aDD2dA/7yzkSgJdNlxtc2wCU+ZujQfGuK/jXX0ooUIlbD9SchuAxsD9r3
 QMxXAbOTmKVQwWUUJqWIMQszFoceXhbouGKhCMuEgS1g=
X-Received: by 2002:a5d:5d8a:0:b0:3dc:eb5:51f6 with SMTP id
 ffacd0b85a97d-3e7659d37b9mr5279699f8f.39.1757751089594; 
 Sat, 13 Sep 2025 01:11:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN/ExV7ps9RVLlCoTsbAbcBxfHxxzqZL+DKkvo99JOTzwabW+6rw/TP7a0YWhqRagzQ2wEsA==
X-Received: by 2002:a5d:5d8a:0:b0:3dc:eb5:51f6 with SMTP id
 ffacd0b85a97d-3e7659d37b9mr5279651f8f.39.1757751088661; 
 Sat, 13 Sep 2025 01:11:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e85610cc17sm2114350f8f.54.2025.09.13.01.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:11:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 37/61] rust: split "util" crate
Date: Sat, 13 Sep 2025 10:09:18 +0200
Message-ID: <20250913080943.11710-38-pbonzini@redhat.com>
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
Link: https://lore.kernel.org/r/20250827104147.717203-7-marcandre.lureau@redhat.com
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                           |  1 +
 rust/qemu-api/wrapper.h               |  6 ---
 rust/util/wrapper.h                   | 32 ++++++++++++++++
 rust/Cargo.lock                       | 17 +++++++--
 rust/Cargo.toml                       |  5 +--
 rust/hw/char/pl011/Cargo.toml         |  1 +
 rust/hw/char/pl011/meson.build        |  1 +
 rust/hw/char/pl011/src/device.rs      |  7 ++--
 rust/hw/timer/hpet/Cargo.toml         |  1 +
 rust/hw/timer/hpet/meson.build        |  1 +
 rust/hw/timer/hpet/src/device.rs      |  6 +--
 rust/meson.build                      |  1 +
 rust/qemu-api-macros/src/lib.rs       |  2 +-
 rust/qemu-api-macros/src/tests.rs     |  2 +-
 rust/qemu-api/Cargo.toml              |  4 +-
 rust/qemu-api/build.rs                | 50 +-----------------------
 rust/qemu-api/meson.build             | 14 ++-----
 rust/qemu-api/src/bindings.rs         |  1 +
 rust/qemu-api/src/lib.rs              |  6 ---
 rust/qemu-api/src/prelude.rs          |  2 -
 rust/qemu-api/src/qdev.rs             |  4 +-
 rust/qemu-api/src/sysbus.rs           |  2 +-
 rust/qemu-api/src/vmstate.rs          |  2 +-
 rust/qemu-api/tests/tests.rs          |  2 +-
 rust/util/Cargo.toml                  | 23 +++++++++++
 rust/util/build.rs                    | 49 ++++++++++++++++++++++++
 rust/util/meson.build                 | 55 +++++++++++++++++++++++++++
 rust/util/src/bindings.rs             | 25 ++++++++++++
 rust/{qemu-api => util}/src/error.rs  |  5 +--
 rust/util/src/lib.rs                  |  9 +++++
 rust/{qemu-api => util}/src/log.rs    | 12 +++---
 rust/{qemu-api => util}/src/module.rs |  2 +-
 rust/{qemu-api => util}/src/timer.rs  |  0
 33 files changed, 243 insertions(+), 107 deletions(-)
 create mode 100644 rust/util/wrapper.h
 mode change 100644 => 120000 rust/qemu-api/build.rs
 create mode 100644 rust/util/Cargo.toml
 create mode 100644 rust/util/build.rs
 create mode 100644 rust/util/meson.build
 create mode 100644 rust/util/src/bindings.rs
 rename rust/{qemu-api => util}/src/error.rs (98%)
 create mode 100644 rust/util/src/lib.rs
 rename rust/{qemu-api => util}/src/log.rs (93%)
 rename rust/{qemu-api => util}/src/module.rs (97%)
 rename rust/{qemu-api => util}/src/timer.rs (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index cee5a342062..3d7b47873f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3519,6 +3519,7 @@ F: rust/common/
 F: rust/qemu-api
 F: rust/qemu-api-macros
 F: rust/rustfmt.toml
+F: rust/util/
 F: scripts/get-wraps-from-cargo-registry.py
 
 Rust-related patches CC here
diff --git a/rust/qemu-api/wrapper.h b/rust/qemu-api/wrapper.h
index 15a1b19847f..cc7112406b2 100644
--- a/rust/qemu-api/wrapper.h
+++ b/rust/qemu-api/wrapper.h
@@ -48,9 +48,6 @@ typedef enum memory_order {
 #endif /* __CLANG_STDATOMIC_H */
 
 #include "qemu/osdep.h"
-#include "qemu/log.h"
-#include "qemu/log-for-trace.h"
-#include "qemu/module.h"
 #include "qemu-io.h"
 #include "system/system.h"
 #include "hw/sysbus.h"
@@ -61,11 +58,8 @@ typedef enum memory_order {
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/irq.h"
-#include "qapi/error.h"
-#include "qapi/error-internal.h"
 #include "migration/vmstate.h"
 #include "chardev/char-serial.h"
 #include "exec/memattrs.h"
-#include "qemu/timer.h"
 #include "system/address-spaces.h"
 #include "hw/char/pl011.h"
diff --git a/rust/util/wrapper.h b/rust/util/wrapper.h
new file mode 100644
index 00000000000..b9ed68a01d8
--- /dev/null
+++ b/rust/util/wrapper.h
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
+#include "qapi/error.h"
+#include "qapi/error-internal.h"
+#include "qemu/log-for-trace.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 71e8c7ed62a..757c03cbdec 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -73,6 +73,7 @@ dependencies = [
  "common",
  "qemu_api",
  "qemu_api_macros",
+ "util",
 ]
 
 [[package]]
@@ -100,6 +101,7 @@ dependencies = [
  "common",
  "qemu_api",
  "qemu_api_macros",
+ "util",
 ]
 
 [[package]]
@@ -138,11 +140,9 @@ dependencies = [
 name = "qemu_api"
 version = "0.1.0"
 dependencies = [
- "anyhow",
  "common",
- "foreign",
- "libc",
  "qemu_api_macros",
+ "util",
 ]
 
 [[package]]
@@ -180,6 +180,17 @@ version = "1.0.12"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
 
+[[package]]
+name = "util"
+version = "0.1.0"
+dependencies = [
+ "anyhow",
+ "common",
+ "foreign",
+ "libc",
+ "qemu_api_macros",
+]
+
 [[package]]
 name = "version_check"
 version = "0.9.4"
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index c0426d42430..cfdd535e3bd 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -7,6 +7,7 @@ members = [
     "qemu-api",
     "hw/char/pl011",
     "hw/timer/hpet",
+    "util",
 ]
 
 [workspace.package]
@@ -24,9 +25,7 @@ foreign = "~0.3.1"
 libc = "0.2.162"
 
 [workspace.lints.rust]
-unexpected_cfgs = { level = "deny", check-cfg = [
-    'cfg(MESON)',
-] }
+unexpected_cfgs = { level = "deny", check-cfg = ['cfg(MESON)'] }
 
 # Occasionally, we may need to silence warnings and clippy lints that
 # were only introduced in newer Rust compiler versions.  Do not croak
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index 6d15f107dfa..0cf9943fe86 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -17,6 +17,7 @@ bilge = { version = "0.2.0" }
 bilge-impl = { version = "0.2.0" }
 bits = { path = "../../../bits" }
 common = { path = "../../../common" }
+util = { path = "../../../util" }
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
 
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index c4a9f531f7d..8a931a4d03d 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -9,6 +9,7 @@ _libpl011_rs = static_library(
     bits_rs,
     common_rs,
     qemu_api_rs,
+    util_rs,
     qemu_api_macros,
   ],
 )
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index b4aa6c45f87..ab38d57fc41 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -9,8 +9,6 @@
     chardev::{CharBackend, Chardev, Event},
     impl_vmstate_forward, impl_vmstate_struct,
     irq::{IRQState, InterruptSource},
-    log::Log,
-    log_mask_ln,
     memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
     prelude::*,
     qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, ResetType, ResettablePhasesImpl},
@@ -19,6 +17,7 @@
     vmstate::{self, VMStateDescription, VMStateDescriptionBuilder},
     vmstate_fields, vmstate_of, vmstate_subsections, vmstate_unused,
 };
+use util::{log::Log, log_mask_ln};
 
 use crate::registers::{self, Interrupt, RegisterOffset};
 
@@ -172,7 +171,7 @@ impl ObjectImpl for PL011State {
 
 impl DeviceImpl for PL011State {
     const VMSTATE: Option<VMStateDescription<Self>> = Some(VMSTATE_PL011);
-    const REALIZE: Option<fn(&Self) -> qemu_api::Result<()>> = Some(Self::realize);
+    const REALIZE: Option<fn(&Self) -> util::Result<()>> = Some(Self::realize);
 }
 
 impl ResettablePhasesImpl for PL011State {
@@ -623,7 +622,7 @@ fn event(&self, event: Event) {
         }
     }
 
-    fn realize(&self) -> qemu_api::Result<()> {
+    fn realize(&self) -> util::Result<()> {
         self.char_backend
             .enable_handlers(self, Self::can_receive, Self::receive, Self::event);
         Ok(())
diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
index ba7354f07e0..dd9a5ed3d43 100644
--- a/rust/hw/timer/hpet/Cargo.toml
+++ b/rust/hw/timer/hpet/Cargo.toml
@@ -12,6 +12,7 @@ rust-version.workspace = true
 
 [dependencies]
 common = { path = "../../../common" }
+util = { path = "../../../util" }
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
 
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index c91d330439a..ca09660bf47 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -6,6 +6,7 @@ _libhpet_rs = static_library(
   dependencies: [
     common_rs,
     qemu_api_rs,
+    util_rs,
     qemu_api_macros,
   ],
 )
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 72375d31550..2be180fdedd 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -27,10 +27,10 @@
     qom::{ObjectImpl, ObjectType, ParentField, ParentInit},
     qom_isa,
     sysbus::{SysBusDevice, SysBusDeviceImpl},
-    timer::{Timer, CLOCK_VIRTUAL, NANOSECONDS_PER_SECOND},
     vmstate::{self, VMStateDescription, VMStateDescriptionBuilder},
     vmstate_fields, vmstate_of, vmstate_subsections, vmstate_validate,
 };
+use util::timer::{Timer, CLOCK_VIRTUAL, NANOSECONDS_PER_SECOND};
 
 use crate::fw_cfg::HPETFwConfig;
 
@@ -728,7 +728,7 @@ fn post_init(&self) {
         }
     }
 
-    fn realize(&self) -> qemu_api::Result<()> {
+    fn realize(&self) -> util::Result<()> {
         if self.num_timers < HPET_MIN_TIMERS || self.num_timers > HPET_MAX_TIMERS {
             Err(format!(
                 "hpet.num_timers must be between {HPET_MIN_TIMERS} and {HPET_MAX_TIMERS}"
@@ -1013,7 +1013,7 @@ unsafe impl qemu_api::qdev::DevicePropertiesImpl for HPETState {
 
 impl DeviceImpl for HPETState {
     const VMSTATE: Option<VMStateDescription<Self>> = Some(VMSTATE_HPET);
-    const REALIZE: Option<fn(&Self) -> qemu_api::Result<()>> = Some(Self::realize);
+    const REALIZE: Option<fn(&Self) -> util::Result<()>> = Some(Self::realize);
 }
 
 impl ResettablePhasesImpl for HPETState {
diff --git a/rust/meson.build b/rust/meson.build
index 402f8d66007..a9d715e6e94 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -25,6 +25,7 @@ genrs = []
 subdir('common')
 subdir('qemu-api-macros')
 subdir('bits')
+subdir('util')
 subdir('qemu-api')
 
 subdir('hw')
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 49003a47801..67650a9a269 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -100,7 +100,7 @@ fn derive_object_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream
         ::common::assert_field_type!(#name, #parent,
             ::qemu_api::qom::ParentField<<#name as ::qemu_api::qom::ObjectImpl>::ParentType>);
 
-        ::qemu_api::module_init! {
+        ::util::module_init! {
             MODULE_INIT_QOM => unsafe {
                 ::qemu_api::bindings::type_register_static(&<#name as ::qemu_api::qom::ObjectImpl>::TYPE_INFO);
             }
diff --git a/rust/qemu-api-macros/src/tests.rs b/rust/qemu-api-macros/src/tests.rs
index ef2806368d2..8e71ac6e677 100644
--- a/rust/qemu-api-macros/src/tests.rs
+++ b/rust/qemu-api-macros/src/tests.rs
@@ -170,7 +170,7 @@ struct Foo {
                 _unused,
                 ::qemu_api::qom::ParentField<<Foo as ::qemu_api::qom::ObjectImpl>::ParentType>
             );
-            ::qemu_api::module_init! {
+            ::util::module_init! {
                 MODULE_INIT_QOM => unsafe {
                     ::qemu_api::bindings::type_register_static(&<Foo as ::qemu_api::qom::ObjectImpl>::TYPE_INFO);
                 }
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index 2e0e2044912..fbfb894421d 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -15,10 +15,8 @@ rust-version.workspace = true
 
 [dependencies]
 common = { path = "../common" }
+util = { path = "../util" }
 qemu_api_macros = { path = "../qemu-api-macros" }
-anyhow = { workspace = true }
-foreign = { workspace = true }
-libc = { workspace = true }
 
 [features]
 default = ["debug_cell"]
diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
deleted file mode 100644
index 5654d1d5624..00000000000
--- a/rust/qemu-api/build.rs
+++ /dev/null
@@ -1,49 +0,0 @@
-// Copyright 2024, Linaro Limited
-// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
-// SPDX-License-Identifier: GPL-2.0-or-later
-
-#[cfg(unix)]
-use std::os::unix::fs::symlink as symlink_file;
-#[cfg(windows)]
-use std::os::windows::fs::symlink_file;
-use std::{env, fs::remove_file, io::Result, path::Path};
-
-fn main() -> Result<()> {
-    let manifest_dir = env!("CARGO_MANIFEST_DIR");
-    let file = if let Ok(root) = env::var("MESON_BUILD_ROOT") {
-        let sub = get_rust_subdir(manifest_dir).unwrap();
-        format!("{root}/{sub}/bindings.inc.rs")
-    } else {
-        // Placing bindings.inc.rs in the source directory is supported
-        // but not documented or encouraged.
-        format!("{manifest_dir}/src/bindings.inc.rs")
-    };
-
-    let file = Path::new(&file);
-    if !Path::new(&file).exists() {
-        panic!(concat!(
-            "\n",
-            "    No generated C bindings found! Maybe you wanted one of\n",
-            "    `make clippy`, `make rustfmt`, `make rustdoc`?\n",
-            "\n",
-            "    For other uses of `cargo`, start a subshell with\n",
-            "    `pyvenv/bin/meson devenv`, or point MESON_BUILD_ROOT to\n",
-            "    the top of the build tree."
-        ));
-    }
-
-    let out_dir = env::var("OUT_DIR").unwrap();
-    let dest_path = format!("{out_dir}/bindings.inc.rs");
-    let dest_path = Path::new(&dest_path);
-    if dest_path.symlink_metadata().is_ok() {
-        remove_file(dest_path)?;
-    }
-    symlink_file(file, dest_path)?;
-
-    println!("cargo:rerun-if-changed=build.rs");
-    Ok(())
-}
-
-fn get_rust_subdir(path: &str) -> Option<&str> {
-    path.find("/rust").map(|index| &path[index + 1..])
-}
diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
new file mode 120000
index 00000000000..71a3167885c
--- /dev/null
+++ b/rust/qemu-api/build.rs
@@ -0,0 +1 @@
+../util/build.rs
\ No newline at end of file
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 64af3caef58..7734f656a26 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -14,10 +14,8 @@ c_enums = [
   'MigrationPolicy',
   'MigrationPriority',
   'QEMUChrEvent',
-  'QEMUClockType',
   'ResetType',
   'device_endian',
-  'module_init_type',
 ]
 _qemu_api_bindgen_args = []
 foreach enum : c_enums
@@ -31,6 +29,7 @@ foreach enum : c_bitfields
   _qemu_api_bindgen_args += ['--bitfield-enum', enum]
 endforeach
 
+_qemu_api_bindgen_args += ['--blocklist-type', 'Error']
 # TODO: Remove this comment when the clang/libclang mismatch issue is solved.
 #
 # Rust bindings generation with `bindgen` might fail in some cases where the
@@ -55,16 +54,12 @@ _qemu_api_rs = static_library(
       'src/bindings.rs',
       'src/cell.rs',
       'src/chardev.rs',
-      'src/error.rs',
       'src/irq.rs',
-      'src/log.rs',
       'src/memory.rs',
-      'src/module.rs',
       'src/prelude.rs',
       'src/qdev.rs',
       'src/qom.rs',
       'src/sysbus.rs',
-      'src/timer.rs',
       'src/vmstate.rs',
     ],
     {'.' : _qemu_api_bindings_inc_rs},
@@ -72,13 +67,10 @@ _qemu_api_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
-  dependencies: [anyhow_rs, common_rs, foreign_rs, libc_rs, qemu_api_macros, qemuutil_rs,
+  dependencies: [anyhow_rs, common_rs, foreign_rs, libc_rs, qemu_api_macros, util_rs,
                  qom, hwcore, chardev, migration],
 )
 
-rust.test('rust-qemu-api-tests', _qemu_api_rs,
-          suite: ['unit', 'rust'])
-
 qemu_api_rs = declare_dependency(link_with: [_qemu_api_rs],
   dependencies: [qemu_api_macros, qom, hwcore, chardev, migration])
 
@@ -98,7 +90,7 @@ test('rust-qemu-api-integration',
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
         rust_args: ['--test'],
         install: false,
-        dependencies: [common_rs, qemu_api_rs]),
+        dependencies: [common_rs, util_rs, qemu_api_rs]),
     args: [
         '--test', '--test-threads', '1',
         '--format', 'pretty',
diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index 3acdd903b52..aedf42b652c 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -21,6 +21,7 @@
 //! `bindgen`-generated declarations.
 
 use common::Zeroable;
+use util::bindings::Error;
 
 #[cfg(MESON)]
 include!("bindings.inc.rs");
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 6232e39e711..54b252fb2c5 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -15,19 +15,13 @@
 
 pub mod cell;
 pub mod chardev;
-pub mod error;
 pub mod irq;
-pub mod log;
 pub mod memory;
-pub mod module;
 pub mod qdev;
 pub mod qom;
 pub mod sysbus;
-pub mod timer;
 pub mod vmstate;
 
 // Allow proc-macros to refer to `::qemu_api` inside the `qemu_api` crate (this
 // crate).
 extern crate self as qemu_api;
-
-pub use error::{Error, Result};
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index dcfe71497f0..3d771481e40 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -7,8 +7,6 @@
 pub use crate::cell::BqlCell;
 pub use crate::cell::BqlRefCell;
 
-pub use crate::log_mask_ln;
-
 pub use crate::qdev::DeviceMethods;
 
 pub use crate::qom::InterfaceType;
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 8be125fae47..d87479ce13b 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -11,12 +11,12 @@
 
 pub use bindings::{ClockEvent, DeviceClass, Property, ResetType};
 use common::{callbacks::FnCall, Opaque};
+use util::{Error, Result};
 
 use crate::{
     bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out, ResettableClass},
     cell::bql_locked,
     chardev::Chardev,
-    error::{Error, Result},
     impl_vmstate_c_struct,
     irq::InterruptSource,
     prelude::*,
@@ -183,7 +183,7 @@ pub trait DeviceImpl:
 /// readable/writeable from one thread at any time.
 unsafe extern "C" fn rust_realize_fn<T: DeviceImpl>(
     dev: *mut bindings::DeviceState,
-    errp: *mut *mut bindings::Error,
+    errp: *mut *mut util::bindings::Error,
 ) {
     let state = NonNull::new(dev).unwrap().cast::<T>();
     let result = T::REALIZE.unwrap()(unsafe { state.as_ref() });
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index 4a5b4cbbf67..2dbfc31dbda 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -114,7 +114,7 @@ fn sysbus_realize(&self) {
         unsafe {
             bindings::sysbus_realize(
                 self.upcast().as_mut_ptr(),
-                addr_of_mut!(bindings::error_fatal),
+                addr_of_mut!(util::bindings::error_fatal),
             );
         }
     }
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 06aac3a73f4..37e47cc4c6f 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -315,7 +315,7 @@ unsafe impl VMState for $type {
 impl_vmstate_scalar!(vmstate_info_uint16, u16, VMS_VARRAY_UINT16);
 impl_vmstate_scalar!(vmstate_info_uint32, u32, VMS_VARRAY_UINT32);
 impl_vmstate_scalar!(vmstate_info_uint64, u64);
-impl_vmstate_scalar!(vmstate_info_timer, crate::timer::Timer);
+impl_vmstate_scalar!(vmstate_info_timer, util::timer::Timer);
 
 #[macro_export]
 macro_rules! impl_vmstate_c_struct {
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 13495687419..70ef4a80d57 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -5,7 +5,6 @@
 use std::{ffi::CStr, ptr::addr_of};
 
 use qemu_api::{
-    bindings::{module_call_init, module_init_type},
     cell::{self, BqlCell},
     prelude::*,
     qdev::{DeviceImpl, DeviceState, ResettablePhasesImpl},
@@ -13,6 +12,7 @@
     sysbus::SysBusDevice,
     vmstate::{VMStateDescription, VMStateDescriptionBuilder},
 };
+use util::bindings::{module_call_init, module_init_type};
 
 mod vmstate_tests;
 
diff --git a/rust/util/Cargo.toml b/rust/util/Cargo.toml
new file mode 100644
index 00000000000..637df61060a
--- /dev/null
+++ b/rust/util/Cargo.toml
@@ -0,0 +1,23 @@
+[package]
+name = "util"
+version = "0.1.0"
+description = "Rust bindings for QEMU/util"
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
+anyhow = { workspace = true }
+foreign = { workspace = true }
+libc = { workspace = true }
+common = { path = "../common" }
+qemu_api_macros = { path = "../qemu-api-macros" }
+
+[lints]
+workspace = true
diff --git a/rust/util/build.rs b/rust/util/build.rs
new file mode 100644
index 00000000000..5654d1d5624
--- /dev/null
+++ b/rust/util/build.rs
@@ -0,0 +1,49 @@
+// Copyright 2024, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#[cfg(unix)]
+use std::os::unix::fs::symlink as symlink_file;
+#[cfg(windows)]
+use std::os::windows::fs::symlink_file;
+use std::{env, fs::remove_file, io::Result, path::Path};
+
+fn main() -> Result<()> {
+    let manifest_dir = env!("CARGO_MANIFEST_DIR");
+    let file = if let Ok(root) = env::var("MESON_BUILD_ROOT") {
+        let sub = get_rust_subdir(manifest_dir).unwrap();
+        format!("{root}/{sub}/bindings.inc.rs")
+    } else {
+        // Placing bindings.inc.rs in the source directory is supported
+        // but not documented or encouraged.
+        format!("{manifest_dir}/src/bindings.inc.rs")
+    };
+
+    let file = Path::new(&file);
+    if !Path::new(&file).exists() {
+        panic!(concat!(
+            "\n",
+            "    No generated C bindings found! Maybe you wanted one of\n",
+            "    `make clippy`, `make rustfmt`, `make rustdoc`?\n",
+            "\n",
+            "    For other uses of `cargo`, start a subshell with\n",
+            "    `pyvenv/bin/meson devenv`, or point MESON_BUILD_ROOT to\n",
+            "    the top of the build tree."
+        ));
+    }
+
+    let out_dir = env::var("OUT_DIR").unwrap();
+    let dest_path = format!("{out_dir}/bindings.inc.rs");
+    let dest_path = Path::new(&dest_path);
+    if dest_path.symlink_metadata().is_ok() {
+        remove_file(dest_path)?;
+    }
+    symlink_file(file, dest_path)?;
+
+    println!("cargo:rerun-if-changed=build.rs");
+    Ok(())
+}
+
+fn get_rust_subdir(path: &str) -> Option<&str> {
+    path.find("/rust").map(|index| &path[index + 1..])
+}
diff --git a/rust/util/meson.build b/rust/util/meson.build
new file mode 100644
index 00000000000..56e929349b8
--- /dev/null
+++ b/rust/util/meson.build
@@ -0,0 +1,55 @@
+_util_bindgen_args = []
+c_enums = [
+  'module_init_type',
+  'QEMUClockType',
+]
+foreach enum : c_enums
+  _util_bindgen_args += ['--rustified-enum', enum]
+endforeach
+
+#
+# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
+#
+# Rust bindings generation with `bindgen` might fail in some cases where the
+# detected `libclang` does not match the expected `clang` version/target. In
+# this case you must pass the path to `clang` and `libclang` to your build
+# command invocation using the environment variables CLANG_PATH and
+# LIBCLANG_PATH
+_util_bindings_inc_rs = rust.bindgen(
+  input: 'wrapper.h',
+  dependencies: common_ss.all_dependencies(),
+  output: 'bindings.inc.rs',
+  include_directories: bindings_incdir,
+  bindgen_version: ['>=0.60.0'],
+  args: bindgen_args_common + _util_bindgen_args,
+)
+
+_util_rs = static_library(
+  'util',
+  structured_sources(
+    [
+      'src/lib.rs',
+      'src/bindings.rs',
+      'src/error.rs',
+      'src/log.rs',
+      'src/module.rs',
+      'src/timer.rs',
+    ],
+    {'.': _util_bindings_inc_rs}
+  ),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  dependencies: [anyhow_rs, libc_rs, foreign_rs, common_rs, qemu_api_macros, qom, qemuutil],
+)
+
+util_rs = declare_dependency(link_with: [_util_rs], dependencies: [qemuutil, qom])
+
+# Doctests are essentially integration tests, so they need the same dependencies.
+# Note that running them requires the object files for C code, so place them
+# in a separate suite that is run by the "build" CI jobs rather than "check".
+rust.doctest('rust-util-rs-doctests',
+     _util_rs,
+     protocol: 'rust',
+     dependencies: util_rs,
+     suite: ['doc', 'rust']
+)
diff --git a/rust/util/src/bindings.rs b/rust/util/src/bindings.rs
new file mode 100644
index 00000000000..9ffff12cded
--- /dev/null
+++ b/rust/util/src/bindings.rs
@@ -0,0 +1,25 @@
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
+#[cfg(MESON)]
+include!("bindings.inc.rs");
+
+#[cfg(not(MESON))]
+include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
diff --git a/rust/qemu-api/src/error.rs b/rust/util/src/error.rs
similarity index 98%
rename from rust/qemu-api/src/error.rs
rename to rust/util/src/error.rs
index 8bac3cbec81..bfa5a8685bc 100644
--- a/rust/qemu-api/src/error.rs
+++ b/rust/util/src/error.rs
@@ -19,7 +19,7 @@
 //!
 //! This module is most commonly used at the boundary between C and Rust code;
 //! other code will usually access it through the
-//! [`qemu_api::Result`](crate::Result) type alias, and will use the
+//! [`utils::Result`](crate::Result) type alias, and will use the
 //! [`std::error::Error`] interface to let C errors participate in Rust's error
 //! handling functionality.
 //!
@@ -30,7 +30,7 @@
 //! type up to C code, or from a combination of the two.
 //!
 //! The third case, corresponding to [`Error::with_error`], is the only one that
-//! requires mentioning [`qemu_api::Error`](crate::Error) explicitly.  Similar
+//! requires mentioning [`utils::Error`](crate::Error) explicitly.  Similar
 //! to how QEMU's C code handles errno values, the string and the
 //! `anyhow::Error` object will be concatenated with `:` as the separator.
 
@@ -320,7 +320,6 @@ mod tests {
     use foreign::OwnedPointer;
 
     use super::*;
-    use crate::bindings;
 
     #[track_caller]
     fn error_for_test(msg: &CStr) -> OwnedPointer<Error> {
diff --git a/rust/util/src/lib.rs b/rust/util/src/lib.rs
new file mode 100644
index 00000000000..16c89b95174
--- /dev/null
+++ b/rust/util/src/lib.rs
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+pub mod bindings;
+pub mod error;
+pub mod log;
+pub mod module;
+pub mod timer;
+
+pub use error::{Error, Result};
diff --git a/rust/qemu-api/src/log.rs b/rust/util/src/log.rs
similarity index 93%
rename from rust/qemu-api/src/log.rs
rename to rust/util/src/log.rs
index d07f6272dc1..af9a3e91234 100644
--- a/rust/qemu-api/src/log.rs
+++ b/rust/util/src/log.rs
@@ -49,7 +49,7 @@ impl LogGuard {
     /// # Examples
     ///
     /// ```
-    /// # use qemu_api::log::LogGuard;
+    /// # use util::log::LogGuard;
     /// # use std::io::Write;
     /// if let Some(mut log) = LogGuard::new() {
     ///     writeln!(log, "test");
@@ -116,7 +116,7 @@ fn drop(&mut self) {
 /// # Example
 ///
 /// ```
-/// use qemu_api::{log::Log, log_mask_ln};
+/// use util::{log::Log, log_mask_ln};
 ///
 /// let error_address = 0xbad;
 /// log_mask_ln!(Log::GuestError, "Address 0x{error_address:x} out of range");
@@ -126,7 +126,7 @@ fn drop(&mut self) {
 /// trailing `,`:
 ///
 /// ```
-/// use qemu_api::{log::Log, log_mask_ln};
+/// use util::{log::Log, log_mask_ln};
 ///
 /// let error_address = 0xbad;
 /// log_mask_ln!(
@@ -139,12 +139,12 @@ fn drop(&mut self) {
 macro_rules! log_mask_ln {
     ($mask:expr, $fmt:tt $($args:tt)*) => {{
         // Type assertion to enforce type `Log` for $mask
-        let _: Log = $mask;
+        let _: $crate::log::Log = $mask;
 
         if unsafe {
-            (::qemu_api::bindings::qemu_loglevel & ($mask as std::os::raw::c_int)) != 0
+            ($crate::bindings::qemu_loglevel & ($mask as std::os::raw::c_int)) != 0
         } {
-            _ = ::qemu_api::log::LogGuard::log_fmt(
+            _ = $crate::log::LogGuard::log_fmt(
                 format_args!("{}\n", format_args!($fmt $($args)*)));
         }
     }};
diff --git a/rust/qemu-api/src/module.rs b/rust/util/src/module.rs
similarity index 97%
rename from rust/qemu-api/src/module.rs
rename to rust/util/src/module.rs
index fa5cea3598f..06c45fc142b 100644
--- a/rust/qemu-api/src/module.rs
+++ b/rust/util/src/module.rs
@@ -36,7 +36,7 @@ extern "C" fn ctor_fn() {
 
     // shortcut because it's quite common that $body needs unsafe {}
     ($type:ident => unsafe $body:block) => {
-        $crate::module_init! {
+        ::util::module_init! {
             $type => { unsafe { $body } }
         }
     };
diff --git a/rust/qemu-api/src/timer.rs b/rust/util/src/timer.rs
similarity index 100%
rename from rust/qemu-api/src/timer.rs
rename to rust/util/src/timer.rs
-- 
2.51.0


