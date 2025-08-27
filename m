Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5DECA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 10:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urDdk-0007R8-Bq; Wed, 27 Aug 2025 06:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1urDdd-000767-2O
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:44:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1urDdQ-0003EF-DX
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756291446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pM8yeV/MxY3D2cjRCLlzbY4ZKh7wPZ0kCWOUFzGRB7U=;
 b=Teia3U41sS7CSOIjpnwegbaHPQj0XUxQCIF/aLxHEJRcSMF2e/DYuBajqK2OKXAfsPRZ2K
 idg+XqRVnKatXyCpi2RcHlQiOpbwtqULJpRYHsS+wN+sLYV7XLmsHvVYEmRm8RzMpw6TDQ
 OC/HK6BegX76j03tfbPw7lR30TfegZ4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-YVR0rGYqMhyAOKARmIkQ1g-1; Wed,
 27 Aug 2025 06:44:03 -0400
X-MC-Unique: YVR0rGYqMhyAOKARmIkQ1g-1
X-Mimecast-MFC-AGG-ID: YVR0rGYqMhyAOKARmIkQ1g_1756291442
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4B1F1956088; Wed, 27 Aug 2025 10:43:59 +0000 (UTC)
Received: from localhost (unknown [10.45.242.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 79E8619560AB; Wed, 27 Aug 2025 10:43:56 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 16/22] rust: rename qemu_api_macros -> qemu_macros
Date: Wed, 27 Aug 2025 14:41:38 +0400
Message-ID: <20250827104147.717203-17-marcandre.lureau@redhat.com>
In-Reply-To: <20250827104147.717203-1-marcandre.lureau@redhat.com>
References: <20250827104147.717203-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Since "qemu_api" is no longer the unique crate to provide APIs.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 MAINTAINERS                                   |  2 +-
 rust/Cargo.lock                               | 22 +++++++++----------
 rust/Cargo.toml                               |  2 +-
 rust/bits/Cargo.toml                          |  2 +-
 rust/bits/meson.build                         |  2 +-
 rust/bits/src/lib.rs                          |  4 ++--
 rust/chardev/Cargo.toml                       |  2 +-
 rust/chardev/meson.build                      |  4 ++--
 rust/chardev/src/chardev.rs                   |  2 +-
 rust/common/src/opaque.rs                     |  4 ++--
 rust/hw/char/pl011/Cargo.toml                 |  2 +-
 rust/hw/char/pl011/meson.build                |  4 ++--
 rust/hw/char/pl011/src/device.rs              |  4 ++--
 rust/hw/char/pl011/src/registers.rs           |  2 +-
 rust/hw/core/Cargo.toml                       |  2 +-
 rust/hw/core/meson.build                      |  4 ++--
 rust/hw/core/src/irq.rs                       |  2 +-
 rust/hw/core/src/qdev.rs                      |  4 ++--
 rust/hw/core/src/sysbus.rs                    |  2 +-
 rust/hw/core/tests/tests.rs                   |  4 ++--
 rust/hw/timer/hpet/Cargo.toml                 |  2 +-
 rust/hw/timer/hpet/meson.build                |  4 ++--
 rust/hw/timer/hpet/src/device.rs              |  6 ++---
 rust/meson.build                              |  2 +-
 rust/migration/Cargo.toml                     |  2 +-
 rust/qemu-api/Cargo.toml                      |  2 +-
 rust/qemu-api/meson.build                     |  4 ++--
 .../Cargo.toml                                |  2 +-
 .../meson.build                               | 10 ++++-----
 .../src/bits.rs                               |  0
 .../src/lib.rs                                |  0
 .../src/tests.rs                              |  0
 rust/qom/Cargo.toml                           |  2 +-
 rust/qom/meson.build                          |  4 ++--
 rust/qom/src/qom.rs                           |  4 ++--
 rust/system/Cargo.toml                        |  2 +-
 rust/system/meson.build                       |  4 ++--
 rust/system/src/memory.rs                     |  2 +-
 rust/util/Cargo.toml                          |  2 +-
 rust/util/meson.build                         |  2 +-
 rust/util/src/timer.rs                        |  4 ++--
 41 files changed, 68 insertions(+), 68 deletions(-)
 rename rust/{qemu-api-macros => qemu-macros}/Cargo.toml (94%)
 rename rust/{qemu-api-macros => qemu-macros}/meson.build (63%)
 rename rust/{qemu-api-macros => qemu-macros}/src/bits.rs (100%)
 rename rust/{qemu-api-macros => qemu-macros}/src/lib.rs (100%)
 rename rust/{qemu-api-macros => qemu-macros}/src/tests.rs (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3f40a80240..62790c7b5d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3516,7 +3516,7 @@ F: rust/common/
 F: rust/hw/core/
 F: rust/migration/
 F: rust/qemu-api
-F: rust/qemu-api-macros
+F: rust/qemu-macros/
 F: rust/qom/
 F: rust/rustfmt.toml
 F: rust/system/
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index d454692c91..91f137d75c 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -41,7 +41,7 @@ dependencies = [
 name = "bits"
 version = "0.1.0"
 dependencies = [
- "qemu_api_macros",
+ "qemu_macros",
 ]
 
 [[package]]
@@ -58,7 +58,7 @@ dependencies = [
  "bql",
  "common",
  "migration",
- "qemu_api_macros",
+ "qemu_macros",
  "qom",
  "util",
 ]
@@ -94,7 +94,7 @@ dependencies = [
  "hwcore",
  "migration",
  "qemu_api",
- "qemu_api_macros",
+ "qemu_macros",
  "qom",
  "system",
  "util",
@@ -108,7 +108,7 @@ dependencies = [
  "chardev",
  "common",
  "migration",
- "qemu_api_macros",
+ "qemu_macros",
  "qom",
  "system",
  "util",
@@ -134,7 +134,7 @@ name = "migration"
 version = "0.1.0"
 dependencies = [
  "common",
- "qemu_api_macros",
+ "qemu_macros",
  "util",
 ]
 
@@ -151,7 +151,7 @@ dependencies = [
  "hwcore",
  "migration",
  "qemu_api",
- "qemu_api_macros",
+ "qemu_macros",
  "qom",
  "system",
  "util",
@@ -201,14 +201,14 @@ dependencies = [
  "hwcore",
  "libc",
  "migration",
- "qemu_api_macros",
+ "qemu_macros",
  "qom",
  "system",
  "util",
 ]
 
 [[package]]
-name = "qemu_api_macros"
+name = "qemu_macros"
 version = "0.1.0"
 dependencies = [
  "proc-macro2",
@@ -223,7 +223,7 @@ dependencies = [
  "bql",
  "common",
  "migration",
- "qemu_api_macros",
+ "qemu_macros",
  "util",
 ]
 
@@ -252,7 +252,7 @@ name = "system"
 version = "0.1.0"
 dependencies = [
  "common",
- "qemu_api_macros",
+ "qemu_macros",
  "qom",
  "util",
 ]
@@ -271,7 +271,7 @@ dependencies = [
  "common",
  "foreign",
  "libc",
- "qemu_api_macros",
+ "qemu_macros",
 ]
 
 [[package]]
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 11280ad524..4a97510676 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -5,7 +5,7 @@ members = [
     "bql",
     "common",
     "migration",
-    "qemu-api-macros",
+    "qemu-macros",
     "qemu-api",
     "qom",
     "system",
diff --git a/rust/bits/Cargo.toml b/rust/bits/Cargo.toml
index 1ff38a4117..7fce972b27 100644
--- a/rust/bits/Cargo.toml
+++ b/rust/bits/Cargo.toml
@@ -13,7 +13,7 @@ repository.workspace = true
 rust-version.workspace = true
 
 [dependencies]
-qemu_api_macros = { path = "../qemu-api-macros" }
+qemu_macros = { path = "../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/bits/meson.build b/rust/bits/meson.build
index 2a41e138c5..359ca86f15 100644
--- a/rust/bits/meson.build
+++ b/rust/bits/meson.build
@@ -3,7 +3,7 @@ _bits_rs = static_library(
   'src/lib.rs',
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
-  dependencies: [qemu_api_macros],
+  dependencies: [qemu_macros],
 )
 
 bits_rs = declare_dependency(link_with: _bits_rs)
diff --git a/rust/bits/src/lib.rs b/rust/bits/src/lib.rs
index d485d6bd11..4e091aebbd 100644
--- a/rust/bits/src/lib.rs
+++ b/rust/bits/src/lib.rs
@@ -380,11 +380,11 @@ fn from(x: $type) -> Self {
     };
 
     { $type:ty: $expr:expr } => {
-        ::qemu_api_macros::bits_const_internal! { $type @ ($expr) }
+        ::qemu_macros::bits_const_internal! { $type @ ($expr) }
     };
 
     { $type:ty as $int_type:ty: $expr:expr } => {
-        (::qemu_api_macros::bits_const_internal! { $type @ ($expr) }.into_bits()) as $int_type
+        (::qemu_macros::bits_const_internal! { $type @ ($expr) }.into_bits()) as $int_type
     };
 }
 
diff --git a/rust/chardev/Cargo.toml b/rust/chardev/Cargo.toml
index 7df9c677fc..c139177307 100644
--- a/rust/chardev/Cargo.toml
+++ b/rust/chardev/Cargo.toml
@@ -18,7 +18,7 @@ bql = { path = "../bql" }
 migration = { path = "../migration" }
 qom = { path = "../qom" }
 util = { path = "../util" }
-qemu_api_macros = { path = "../qemu-api-macros" }
+qemu_macros = { path = "../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/chardev/meson.build b/rust/chardev/meson.build
index 918e0a5224..487f36e27d 100644
--- a/rust/chardev/meson.build
+++ b/rust/chardev/meson.build
@@ -39,10 +39,10 @@ _chardev_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _chardev_cfg,
-  dependencies: [qemuutil_rs, common_rs, bql_rs, migration_rs, qemu_api_macros, qom_rs, util_rs, chardev],
+  dependencies: [qemuutil_rs, common_rs, bql_rs, migration_rs, qemu_macros, qom_rs, util_rs, chardev],
 )
 
-chardev_rs = declare_dependency(link_with: [_chardev_rs], dependencies: [qemu_api_macros, chardev])
+chardev_rs = declare_dependency(link_with: [_chardev_rs], dependencies: [qemu_macros, chardev])
 
 # Doctests are essentially integration tests, so they need the same dependencies.
 # Note that running them requires the object files for C code, so place them
diff --git a/rust/chardev/src/chardev.rs b/rust/chardev/src/chardev.rs
index fcf3778ffb..0e0a8f5556 100644
--- a/rust/chardev/src/chardev.rs
+++ b/rust/chardev/src/chardev.rs
@@ -26,7 +26,7 @@
 
 /// A safe wrapper around [`bindings::Chardev`].
 #[repr(transparent)]
-#[derive(qemu_api_macros::Wrapper)]
+#[derive(qemu_macros::Wrapper)]
 pub struct Chardev(Opaque<bindings::Chardev>);
 
 pub type ChardevClass = bindings::ChardevClass;
diff --git a/rust/common/src/opaque.rs b/rust/common/src/opaque.rs
index e076964634..06f6b8cd29 100644
--- a/rust/common/src/opaque.rs
+++ b/rust/common/src/opaque.rs
@@ -194,7 +194,7 @@ pub unsafe fn new() -> Self {
 
 /// Annotates [`Self`] as a transparent wrapper for another type.
 ///
-/// Usually defined via the [`qemu_api_macros::Wrapper`] derive macro.
+/// Usually defined via the [`qemu_macros::Wrapper`] derive macro.
 ///
 /// # Examples
 ///
@@ -230,7 +230,7 @@ pub unsafe fn new() -> Self {
 ///
 /// They are not defined here to allow them to be `const`.
 ///
-/// [`qemu_api_macros::Wrapper`]: ../../qemu_api_macros/derive.Wrapper.html
+/// [`qemu_macros::Wrapper`]: ../../qemu_macros/derive.Wrapper.html
 pub unsafe trait Wrapper {
     type Wrapped;
 }
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index 830d88586b..9e451fc0aa 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -25,7 +25,7 @@ chardev = { path = "../../../chardev" }
 system = { path = "../../../system" }
 hwcore = { path = "../../../hw/core" }
 qemu_api = { path = "../../../qemu-api" }
-qemu_api_macros = { path = "../../../qemu-api-macros" }
+qemu_macros = { path = "../../../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 83030476de..7d90f2aad6 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -12,7 +12,7 @@ _libpl011_rs = static_library(
     migration_rs,
     bql_rs,
     qemu_api,
-    qemu_api_macros,
+    qemu_macros,
     qom_rs,
     chardev_rs,
     system_rs,
@@ -24,6 +24,6 @@ rust_devices_ss.add(when: 'CONFIG_X_PL011_RUST', if_true: [declare_dependency(
   link_whole: [_libpl011_rs],
   # Putting proc macro crates in `dependencies` is necessary for Meson to find
   # them when compiling the root per-target static rust lib.
-  dependencies: [bilge_impl_rs, qemu_api_macros],
+  dependencies: [bilge_impl_rs, qemu_macros],
   variables: {'crate': 'pl011'},
 )])
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index ffc805d4f6..b7c1cb68a2 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -103,7 +103,7 @@ pub struct PL011Registers {
 }
 
 #[repr(C)]
-#[derive(qemu_api_macros::Object)]
+#[derive(qemu_macros::Object)]
 /// PL011 Device Model in QEMU
 pub struct PL011State {
     pub parent_obj: ParentField<SysBusDevice>,
@@ -688,7 +688,7 @@ pub fn post_load(&self, _version_id: u32) -> Result<(), ()> {
 }
 
 #[repr(C)]
-#[derive(qemu_api_macros::Object)]
+#[derive(qemu_macros::Object)]
 /// PL011 Luminary device model.
 pub struct PL011Luminary {
     parent_obj: ParentField<PL011State>,
diff --git a/rust/hw/char/pl011/src/registers.rs b/rust/hw/char/pl011/src/registers.rs
index 2bfbd81095..a1c41347ed 100644
--- a/rust/hw/char/pl011/src/registers.rs
+++ b/rust/hw/char/pl011/src/registers.rs
@@ -16,7 +16,7 @@
 #[doc(alias = "offset")]
 #[allow(non_camel_case_types)]
 #[repr(u64)]
-#[derive(Debug, Eq, PartialEq, qemu_api_macros::TryInto)]
+#[derive(Debug, Eq, PartialEq, qemu_macros::TryInto)]
 pub enum RegisterOffset {
     /// Data Register
     ///
diff --git a/rust/hw/core/Cargo.toml b/rust/hw/core/Cargo.toml
index 0b35380264..0eb9ffee26 100644
--- a/rust/hw/core/Cargo.toml
+++ b/rust/hw/core/Cargo.toml
@@ -20,7 +20,7 @@ chardev = { path = "../../chardev" }
 migration = { path = "../../migration" }
 system = { path = "../../system" }
 util = { path = "../../util" }
-qemu_api_macros = { path = "../../qemu-api-macros" }
+qemu_macros = { path = "../../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/hw/core/meson.build b/rust/hw/core/meson.build
index d390f2d665..692c4b8e0f 100644
--- a/rust/hw/core/meson.build
+++ b/rust/hw/core/meson.build
@@ -62,7 +62,7 @@ _hwcore_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _hwcore_cfg,
-  dependencies: [qemu_api_macros, common_rs, bql_rs, chardev_rs, migration_rs, qemuutil_rs, qom_rs, system_rs, util_rs,
+  dependencies: [qemu_macros, common_rs, bql_rs, chardev_rs, migration_rs, qemuutil_rs, qom_rs, system_rs, util_rs,
                  qom, hwcore, chardev, migration],
 )
 
@@ -85,7 +85,7 @@ test('rust-hwcore-rs-integration',
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
         rust_args: ['--test'],
         install: false,
-        dependencies: [common_rs, hwcore_rs, bql_rs, migration_rs, qemu_api_macros, util_rs]),
+        dependencies: [common_rs, hwcore_rs, bql_rs, migration_rs, qemu_macros, util_rs]),
     args: [
         '--test', '--test-threads', '1',
         '--format', 'pretty',
diff --git a/rust/hw/core/src/irq.rs b/rust/hw/core/src/irq.rs
index fead2bbe8e..d8d964cad2 100644
--- a/rust/hw/core/src/irq.rs
+++ b/rust/hw/core/src/irq.rs
@@ -18,7 +18,7 @@
 
 /// An opaque wrapper around [`bindings::IRQState`].
 #[repr(transparent)]
-#[derive(Debug, qemu_api_macros::Wrapper)]
+#[derive(Debug, qemu_macros::Wrapper)]
 pub struct IRQState(Opaque<bindings::IRQState>);
 
 /// Interrupt sources are used by devices to pass changes to a value (typically
diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index 359eee7ec9..69d8a7f4c1 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -23,7 +23,7 @@
 
 /// A safe wrapper around [`bindings::Clock`].
 #[repr(transparent)]
-#[derive(Debug, qemu_api_macros::Wrapper)]
+#[derive(Debug, qemu_macros::Wrapper)]
 pub struct Clock(Opaque<bindings::Clock>);
 
 unsafe impl Send for Clock {}
@@ -31,7 +31,7 @@ unsafe impl Sync for Clock {}
 
 /// A safe wrapper around [`bindings::DeviceState`].
 #[repr(transparent)]
-#[derive(Debug, qemu_api_macros::Wrapper)]
+#[derive(Debug, qemu_macros::Wrapper)]
 pub struct DeviceState(Opaque<bindings::DeviceState>);
 
 unsafe impl Send for DeviceState {}
diff --git a/rust/hw/core/src/sysbus.rs b/rust/hw/core/src/sysbus.rs
index 81014f9ebf..020d650b50 100644
--- a/rust/hw/core/src/sysbus.rs
+++ b/rust/hw/core/src/sysbus.rs
@@ -19,7 +19,7 @@
 
 /// A safe wrapper around [`bindings::SysBusDevice`].
 #[repr(transparent)]
-#[derive(Debug, qemu_api_macros::Wrapper)]
+#[derive(Debug, qemu_macros::Wrapper)]
 pub struct SysBusDevice(Opaque<bindings::SysBusDevice>);
 
 unsafe impl Send for SysBusDevice {}
diff --git a/rust/hw/core/tests/tests.rs b/rust/hw/core/tests/tests.rs
index 421b35d98d..dff2daae35 100644
--- a/rust/hw/core/tests/tests.rs
+++ b/rust/hw/core/tests/tests.rs
@@ -22,7 +22,7 @@
 };
 
 #[repr(C)]
-#[derive(qemu_api_macros::Object)]
+#[derive(qemu_macros::Object)]
 pub struct DummyState {
     parent: ParentField<DeviceState>,
     migrate_clock: bool,
@@ -74,7 +74,7 @@ fn vmsd() -> Option<&'static VMStateDescription> {
 }
 
 #[repr(C)]
-#[derive(qemu_api_macros::Object)]
+#[derive(qemu_macros::Object)]
 pub struct DummyChildState {
     parent: ParentField<DummyState>,
 }
diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
index e28d66f645..68e8187bb8 100644
--- a/rust/hw/timer/hpet/Cargo.toml
+++ b/rust/hw/timer/hpet/Cargo.toml
@@ -18,7 +18,7 @@ bql = { path = "../../../bql" }
 qom = { path = "../../../qom" }
 system = { path = "../../../system" }
 qemu_api = { path = "../../../qemu-api" }
-qemu_api_macros = { path = "../../../qemu-api-macros" }
+qemu_macros = { path = "../../../qemu-macros" }
 hwcore = { path = "../../../hw/core" }
 
 [lints]
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index d65306c169..b2eee01faf 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -9,7 +9,7 @@ _libhpet_rs = static_library(
     migration_rs,
     bql_rs,
     qemu_api,
-    qemu_api_macros,
+    qemu_macros,
     qom_rs,
     system_rs,
     hwcore_rs,
@@ -20,6 +20,6 @@ rust_devices_ss.add(when: 'CONFIG_X_HPET_RUST', if_true: [declare_dependency(
   link_whole: [_libhpet_rs],
   # Putting proc macro crates in `dependencies` is necessary for Meson to find
   # them when compiling the root per-target static rust lib.
-  dependencies: [qemu_api_macros],
+  dependencies: [qemu_macros],
   variables: {'crate': 'hpet'},
 )])
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index b8e6b1fe31..0ada7fcfde 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -97,7 +97,7 @@
 /// Timer N Interrupt Routing Capability (bits 32:63)
 const HPET_TN_CFG_INT_ROUTE_CAP_SHIFT: usize = 32;
 
-#[derive(qemu_api_macros::TryInto)]
+#[derive(qemu_macros::TryInto)]
 #[repr(u64)]
 #[allow(non_camel_case_types)]
 /// Timer registers, masked by 0x18
@@ -110,7 +110,7 @@ enum TimerRegister {
     ROUTE = 16,
 }
 
-#[derive(qemu_api_macros::TryInto)]
+#[derive(qemu_macros::TryInto)]
 #[repr(u64)]
 #[allow(non_camel_case_types)]
 /// Global registers
@@ -516,7 +516,7 @@ fn write(&mut self, reg: TimerRegister, value: u64, shift: u32, len: u32) {
 
 /// HPET Event Timer Block Abstraction
 #[repr(C)]
-#[derive(qemu_api_macros::Object)]
+#[derive(qemu_macros::Object)]
 pub struct HPETState {
     parent_obj: ParentField<SysBusDevice>,
     iomem: MemoryRegion,
diff --git a/rust/meson.build b/rust/meson.build
index 041b0a473e..9f6a0b161d 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -23,7 +23,7 @@ qemuutil_rs = qemuutil.partial_dependency(link_args: true, links: true)
 genrs = []
 
 subdir('common')
-subdir('qemu-api-macros')
+subdir('qemu-macros')
 subdir('bits')
 subdir('util')
 subdir('migration')
diff --git a/rust/migration/Cargo.toml b/rust/migration/Cargo.toml
index 98e6df2109..66af81e0a3 100644
--- a/rust/migration/Cargo.toml
+++ b/rust/migration/Cargo.toml
@@ -15,7 +15,7 @@ rust-version.workspace = true
 [dependencies]
 common = { path = "../common" }
 util = { path = "../util" }
-qemu_api_macros = { path = "../qemu-api-macros" }
+qemu_macros = { path = "../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index f8b80e5771..c77f6af174 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -20,7 +20,7 @@ hwcore = { path = "../hw/core" }
 migration = { path = "../migration" }
 util = { path = "../util" }
 bql = { path = "../bql" }
-qemu_api_macros = { path = "../qemu-api-macros" }
+qemu_macros = { path = "../qemu-macros" }
 qom = { path = "../qom" }
 system = { path = "../system" }
 anyhow = "~1.0"
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index a4c90b2bf7..02318950ff 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -52,7 +52,7 @@ _qemu_api_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
-  dependencies: [anyhow_rs, common_rs, chardev_rs, foreign_rs, libc_rs, qemu_api_macros, qemuutil_rs, util_rs, migration_rs, bql_rs, qom_rs, system_rs, hwcore_rs,
+  dependencies: [anyhow_rs, common_rs, chardev_rs, foreign_rs, libc_rs, qemu_macros, qemuutil_rs, util_rs, migration_rs, bql_rs, qom_rs, system_rs, hwcore_rs,
                  qom, hwcore, chardev, migration],
 )
 
@@ -60,7 +60,7 @@ rust.test('rust-qemu-api-tests', _qemu_api_rs,
           suite: ['unit', 'rust'])
 
 qemu_api = declare_dependency(link_with: [_qemu_api_rs],
-  dependencies: [qemu_api_macros, qom, hwcore, chardev, migration])
+  dependencies: [qemu_macros, qom, hwcore, chardev, migration])
 
 # Doctests are essentially integration tests, so they need the same dependencies.
 # Note that running them requires the object files for C code, so place them
diff --git a/rust/qemu-api-macros/Cargo.toml b/rust/qemu-macros/Cargo.toml
similarity index 94%
rename from rust/qemu-api-macros/Cargo.toml
rename to rust/qemu-macros/Cargo.toml
index 0cd40c8e16..3b6f1d337f 100644
--- a/rust/qemu-api-macros/Cargo.toml
+++ b/rust/qemu-macros/Cargo.toml
@@ -1,5 +1,5 @@
 [package]
-name = "qemu_api_macros"
+name = "qemu_macros"
 version = "0.1.0"
 authors = ["Manos Pitsidianakis <manos.pitsidianakis@linaro.org>"]
 description = "Rust bindings for QEMU - Utility macros"
diff --git a/rust/qemu-api-macros/meson.build b/rust/qemu-macros/meson.build
similarity index 63%
rename from rust/qemu-api-macros/meson.build
rename to rust/qemu-macros/meson.build
index 2152bcb99b..d0b2992e20 100644
--- a/rust/qemu-api-macros/meson.build
+++ b/rust/qemu-macros/meson.build
@@ -1,5 +1,5 @@
-_qemu_api_macros_rs = rust.proc_macro(
-  'qemu_api_macros',
+_qemu_macros_rs = rust.proc_macro(
+  'qemu_macros',
   files('src/lib.rs'),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_args: [
@@ -14,9 +14,9 @@ _qemu_api_macros_rs = rust.proc_macro(
   ],
 )
 
-qemu_api_macros = declare_dependency(
-  link_with: _qemu_api_macros_rs,
+qemu_macros = declare_dependency(
+  link_with: _qemu_macros_rs,
 )
 
-rust.test('rust-qemu-api-macros-tests', _qemu_api_macros_rs,
+rust.test('rust-qemu-macros-tests', _qemu_macros_rs,
           suite: ['unit', 'rust'])
diff --git a/rust/qemu-api-macros/src/bits.rs b/rust/qemu-macros/src/bits.rs
similarity index 100%
rename from rust/qemu-api-macros/src/bits.rs
rename to rust/qemu-macros/src/bits.rs
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
similarity index 100%
rename from rust/qemu-api-macros/src/lib.rs
rename to rust/qemu-macros/src/lib.rs
diff --git a/rust/qemu-api-macros/src/tests.rs b/rust/qemu-macros/src/tests.rs
similarity index 100%
rename from rust/qemu-api-macros/src/tests.rs
rename to rust/qemu-macros/src/tests.rs
diff --git a/rust/qom/Cargo.toml b/rust/qom/Cargo.toml
index 46bbf7c7fe..060ad2ec34 100644
--- a/rust/qom/Cargo.toml
+++ b/rust/qom/Cargo.toml
@@ -16,7 +16,7 @@ rust-version.workspace = true
 common = { path = "../common" }
 bql = { path = "../bql" }
 migration = { path = "../migration" }
-qemu_api_macros = { path = "../qemu-api-macros" }
+qemu_macros = { path = "../qemu-macros" }
 util = { path = "../util" }
 
 [lints]
diff --git a/rust/qom/meson.build b/rust/qom/meson.build
index 8492868634..d0b2615c52 100644
--- a/rust/qom/meson.build
+++ b/rust/qom/meson.build
@@ -32,10 +32,10 @@ _qom_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qom_cfg,
-  dependencies: [qemuutil_rs, bql_rs, common_rs, migration_rs, qemu_api_macros, qom],
+  dependencies: [qemuutil_rs, bql_rs, common_rs, migration_rs, qemu_macros, qom],
 )
 
-qom_rs = declare_dependency(link_with: [_qom_rs], dependencies: [qemu_api_macros, qom])
+qom_rs = declare_dependency(link_with: [_qom_rs], dependencies: [qemu_macros, qom])
 
 # Doctests are essentially integration tests, so they need the same dependencies.
 # Note that running them requires the object files for C code, so place them
diff --git a/rust/qom/src/qom.rs b/rust/qom/src/qom.rs
index a632ec43f2..880bef6c47 100644
--- a/rust/qom/src/qom.rs
+++ b/rust/qom/src/qom.rs
@@ -112,7 +112,7 @@
 
 /// A safe wrapper around [`bindings::Object`].
 #[repr(transparent)]
-#[derive(Debug, qemu_api_macros::Wrapper)]
+#[derive(Debug, qemu_macros::Wrapper)]
 pub struct Object(Opaque<bindings::Object>);
 
 unsafe impl Send for Object {}
@@ -173,7 +173,7 @@ fn as_ref(&self) -> &$parent {
 ///
 /// ```ignore
 /// #[repr(C)]
-/// #[derive(qemu_api_macros::Object)]
+/// #[derive(qemu_macros::Object)]
 /// pub struct MyDevice {
 ///     parent: ParentField<DeviceState>,
 ///     ...
diff --git a/rust/system/Cargo.toml b/rust/system/Cargo.toml
index 6803895e08..d8338c8348 100644
--- a/rust/system/Cargo.toml
+++ b/rust/system/Cargo.toml
@@ -16,7 +16,7 @@ rust-version.workspace = true
 common = { path = "../common" }
 qom = { path = "../qom" }
 util = { path = "../util" }
-qemu_api_macros = { path = "../qemu-api-macros" }
+qemu_macros = { path = "../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/system/meson.build b/rust/system/meson.build
index cbd3eb4717..710462376d 100644
--- a/rust/system/meson.build
+++ b/rust/system/meson.build
@@ -39,12 +39,12 @@ _system_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _system_cfg,
-  dependencies: [qemuutil_rs, common_rs, bql_rs, migration_rs, qemu_api_macros, qom_rs, util_rs,
+  dependencies: [qemuutil_rs, common_rs, bql_rs, migration_rs, qemu_macros, qom_rs, util_rs,
                 hwcore],
 )
 
 system_rs = declare_dependency(link_with: [_system_rs],
-  dependencies: [qemu_api_macros, hwcore])
+  dependencies: [qemu_macros, hwcore])
 
 # Doctests are essentially integration tests, so they need the same dependencies.
 # Note that running them requires the object files for C code, so place them
diff --git a/rust/system/src/memory.rs b/rust/system/src/memory.rs
index 29568ed767..7312f809f5 100644
--- a/rust/system/src/memory.rs
+++ b/rust/system/src/memory.rs
@@ -129,7 +129,7 @@ fn default() -> Self {
 
 /// A safe wrapper around [`bindings::MemoryRegion`].
 #[repr(transparent)]
-#[derive(qemu_api_macros::Wrapper)]
+#[derive(qemu_macros::Wrapper)]
 pub struct MemoryRegion(Opaque<bindings::MemoryRegion>);
 
 unsafe impl Send for MemoryRegion {}
diff --git a/rust/util/Cargo.toml b/rust/util/Cargo.toml
index aa10f03384..c5d1adb8fe 100644
--- a/rust/util/Cargo.toml
+++ b/rust/util/Cargo.toml
@@ -17,7 +17,7 @@ anyhow = "~1.0"
 libc = "0.2.162"
 foreign = "~0.3.1"
 common = { path = "../common" }
-qemu_api_macros = { path = "../qemu-api-macros" }
+qemu_macros = { path = "../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/util/meson.build b/rust/util/meson.build
index 8f3ebf5415..a7a5bd8d99 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -44,7 +44,7 @@ _util_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _util_cfg,
-  dependencies: [anyhow_rs, libc_rs, foreign_rs, qemuutil_rs, common_rs, qemu_api_macros],
+  dependencies: [anyhow_rs, libc_rs, foreign_rs, qemuutil_rs, common_rs, qemu_macros],
 )
 
 util_rs = declare_dependency(link_with: [_util_rs], dependencies: [qemuutil_rs, qom])
diff --git a/rust/util/src/timer.rs b/rust/util/src/timer.rs
index 441072a949..42096cef0d 100644
--- a/rust/util/src/timer.rs
+++ b/rust/util/src/timer.rs
@@ -15,14 +15,14 @@
 
 /// A safe wrapper around [`bindings::QEMUTimer`].
 #[repr(transparent)]
-#[derive(Debug, qemu_api_macros::Wrapper)]
+#[derive(Debug, qemu_macros::Wrapper)]
 pub struct Timer(Opaque<bindings::QEMUTimer>);
 
 unsafe impl Send for Timer {}
 unsafe impl Sync for Timer {}
 
 #[repr(transparent)]
-#[derive(qemu_api_macros::Wrapper)]
+#[derive(qemu_macros::Wrapper)]
 pub struct TimerListGroup(Opaque<bindings::QEMUTimerListGroup>);
 
 unsafe impl Send for TimerListGroup {}
-- 
2.50.1


