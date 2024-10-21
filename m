Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC66D15DBA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2vOz-0006oT-M0; Mon, 21 Oct 2024 12:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vOC-00065s-2G
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:36:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vO6-0006Ji-Si
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729528569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q404IxZFk+NIfcxl+Tcr9XRM6bnBKtIpSop9l9a12Xk=;
 b=ictC8xMQGsEzxlhMG1jC3ioeGnlkUHdZXNr2x4/PpjPnxjdYxUORHKsUNkS7QDdsbCLJYY
 p9RtfwRBNpBni/6solWaxcQA7oCEPHeluKm5QU9peEmJS3nJF401oJnJDKh5ACuQg1l47I
 hjgOjWEG57rPsVxuRoppnjHDpG/xNZM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-xAyz1ud0OsWaj2LXtjagRw-1; Mon, 21 Oct 2024 12:36:08 -0400
X-MC-Unique: xAyz1ud0OsWaj2LXtjagRw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315f48bd70so28269635e9.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 09:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729528566; x=1730133366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q404IxZFk+NIfcxl+Tcr9XRM6bnBKtIpSop9l9a12Xk=;
 b=lcVgPOvrthamK7UnWGUQ4pn/A2TawrX4PpzUAspijK6wfrOISysleLY1jI27W5Os8p
 z70flVfJsTAAZXx789KhnZAj6sXxg0hRghGFoDnsqHwtpiFHydhgMa5RYqdJZhzBsQbV
 1/5lmYq4xpBm+ELusc+i1Q0gb8JKTIYqWBm5XFMPzbmSVi7ty/5FyZSziaWlt9sMz/3U
 gt1Jlhoaa+5OCERhTE63eHwI6DRta34rCjQ7j/Y0C1ZuziN57VMvlYdkNjba4FY72aVO
 Qsa9Iex19sTgceURlh9LQz7vP0fDu5QpJ7Sjp3CQMZprx0FfsD34s+sCEyAq6AdMT67v
 O8Zg==
X-Gm-Message-State: AOJu0YyavooiB/pSlnHLAIfQwtuY+LLrqHsyePz5cz5I087gwYzdZdFV
 J0lU3UWelfNMBpGPTyffCiKxAnPqBb+alaPJPLu+SCHCqDcHLHaLjJ4LbUZa22KEg14VzleNB2C
 yGs9uo6vn4edzIWwJJcZS6+pibDAM2+4CqSDHQRiTnuN0NIesm6wSFisMx6aMJ26WDTl28Lbl5I
 Sgjkc1CJEOvlHIhIu8do6KYBSns4EDrIdxX1uh1rw=
X-Received: by 2002:a05:600c:19d2:b0:431:3c67:fb86 with SMTP id
 5b1f17b1804b1-431616a404dmr88541325e9.33.1729528566373; 
 Mon, 21 Oct 2024 09:36:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHecvCZ1N1dVcHdMc7UcS3N7JC2ht0pL/nBidv/7JzOv05qnQEXa6OPB3xkVzspDNQhi6fJOQ==
X-Received: by 2002:a05:600c:19d2:b0:431:3c67:fb86 with SMTP id
 5b1f17b1804b1-431616a404dmr88541095e9.33.1729528565907; 
 Mon, 21 Oct 2024 09:36:05 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f57102asm62047065e9.1.2024.10.21.09.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 09:36:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 07/13] rust: build integration test for the qemu_api crate
Date: Mon, 21 Oct 2024 18:35:32 +0200
Message-ID: <20241021163538.136941-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241021163538.136941-1-pbonzini@redhat.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
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

Adjust the integration test to compile with a subset of QEMU object
files, and make it actually create an object of the class it defines.

Follow the Rust filesystem conventions, where tests go in tests/ if
they use the library in the same way any other code would.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                  | 10 ++++-
 rust/qemu-api/meson.build    | 26 ++++++++++--
 rust/qemu-api/src/lib.rs     |  3 --
 rust/qemu-api/src/tests.rs   | 49 ----------------------
 rust/qemu-api/tests/tests.rs | 78 ++++++++++++++++++++++++++++++++++++
 5 files changed, 110 insertions(+), 56 deletions(-)
 delete mode 100644 rust/qemu-api/src/tests.rs
 create mode 100644 rust/qemu-api/tests/tests.rs

diff --git a/meson.build b/meson.build
index 6739165908e..3c71d129494 100644
--- a/meson.build
+++ b/meson.build
@@ -3326,7 +3326,15 @@ if have_rust and have_system
 
   # Prohibit code that is forbidden in Rust 2024
   rustc_args += ['-D', 'unsafe_op_in_unsafe_fn']
-  add_project_arguments(rustc_args, native: false, language: 'rust')
+
+  # Apart from procedural macros, our Rust executables will often link
+  # with C code, so include all the libraries that C code needs.  This
+  # is safe; https://github.com/rust-lang/rust/pull/54675 says that
+  # passing -nodefaultlibs to the linker "was more ideological to
+  # start with than anything".
+  add_project_arguments(rustc_args + ['-C', 'default-linker-libraries'],
+      native: false, language: 'rust')
+
   add_project_arguments(rustc_args, native: true, language: 'rust')
 endif
 
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 42ea815fa5a..1fc36078027 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -14,11 +14,31 @@ _qemu_api_rs = static_library(
     '--cfg', 'MESON',
     # '--cfg', 'feature="allocator"',
   ],
-  dependencies: [
-    qemu_api_macros,
-  ],
 )
 
 qemu_api = declare_dependency(
   link_with: _qemu_api_rs,
+  dependencies: qemu_api_macros,
 )
+
+# Rust executables do not support objects, so add an intermediate step.
+rust_qemu_api_objs = static_library(
+    'rust_qemu_api_objs',
+    objects: [libqom.extract_all_objects(recursive: false),
+              libhwcore.extract_all_objects(recursive: false)])
+
+test('rust-qemu-api-integration',
+    executable(
+        'rust-qemu-api-integration',
+        'tests/tests.rs',
+        override_options: ['rust_std=2021', 'build.rust_std=2021'],
+        rust_args: ['--test'],
+        install: false,
+        dependencies: [qemu_api, qemu_api_macros],
+        link_whole: [rust_qemu_api_objs, libqemuutil]),
+    args: [
+        '--test',
+        '--format', 'pretty',
+    ],
+    protocol: 'rust',
+    suite: ['unit', 'rust'])
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index e72fb4b4bb1..6bc68076aae 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -30,9 +30,6 @@ unsafe impl Sync for bindings::VMStateDescription {}
 pub mod definitions;
 pub mod device_class;
 
-#[cfg(test)]
-mod tests;
-
 use std::alloc::{GlobalAlloc, Layout};
 
 #[cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)]
diff --git a/rust/qemu-api/src/tests.rs b/rust/qemu-api/src/tests.rs
deleted file mode 100644
index df54edbd4e2..00000000000
--- a/rust/qemu-api/src/tests.rs
+++ /dev/null
@@ -1,49 +0,0 @@
-// Copyright 2024, Linaro Limited
-// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
-// SPDX-License-Identifier: GPL-2.0-or-later
-
-use crate::{
-    bindings::*, declare_properties, define_property, device_class_init, vm_state_description,
-};
-
-#[test]
-fn test_device_decl_macros() {
-    // Test that macros can compile.
-    vm_state_description! {
-        VMSTATE,
-        name: c"name",
-        unmigratable: true,
-    }
-
-    #[repr(C)]
-    pub struct DummyState {
-        pub char_backend: CharBackend,
-        pub migrate_clock: bool,
-    }
-
-    declare_properties! {
-        DUMMY_PROPERTIES,
-            define_property!(
-                c"chardev",
-                DummyState,
-                char_backend,
-                unsafe { &qdev_prop_chr },
-                CharBackend
-            ),
-            define_property!(
-                c"migrate-clk",
-                DummyState,
-                migrate_clock,
-                unsafe { &qdev_prop_bool },
-                bool
-            ),
-    }
-
-    device_class_init! {
-        dummy_class_init,
-        props => DUMMY_PROPERTIES,
-        realize_fn => None,
-        reset_fn => None,
-        vmsd => VMSTATE,
-    }
-}
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
new file mode 100644
index 00000000000..aa1e0568c69
--- /dev/null
+++ b/rust/qemu-api/tests/tests.rs
@@ -0,0 +1,78 @@
+// Copyright 2024, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use core::ffi::CStr;
+
+use qemu_api::{
+    bindings::*,
+    declare_properties, define_property,
+    definitions::{Class, ObjectImpl},
+    device_class_init, vm_state_description,
+};
+
+#[test]
+fn test_device_decl_macros() {
+    // Test that macros can compile.
+    vm_state_description! {
+        VMSTATE,
+        name: c"name",
+        unmigratable: true,
+    }
+
+    #[repr(C)]
+    #[derive(qemu_api_macros::Object)]
+    pub struct DummyState {
+        pub _parent: DeviceState,
+        pub migrate_clock: bool,
+    }
+
+    #[repr(C)]
+    pub struct DummyClass {
+        pub _parent: DeviceClass,
+    }
+
+    declare_properties! {
+        DUMMY_PROPERTIES,
+            define_property!(
+                c"migrate-clk",
+                DummyState,
+                migrate_clock,
+                unsafe { &qdev_prop_bool },
+                bool
+            ),
+    }
+
+    device_class_init! {
+        dummy_class_init,
+        props => DUMMY_PROPERTIES,
+        realize_fn => None,
+        legacy_reset_fn => None,
+        vmsd => VMSTATE,
+    }
+
+    impl ObjectImpl for DummyState {
+        type Class = DummyClass;
+        const TYPE_INFO: qemu_api::bindings::TypeInfo = qemu_api::type_info! { Self };
+        const TYPE_NAME: &'static CStr = c"dummy";
+        const PARENT_TYPE_NAME: Option<&'static CStr> = Some(TYPE_DEVICE);
+        const ABSTRACT: bool = false;
+        const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
+        const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
+        const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
+    }
+
+    impl Class for DummyClass {
+        const CLASS_INIT: Option<
+            unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi::c_void),
+        > = Some(dummy_class_init);
+        const CLASS_BASE_INIT: Option<
+            unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi::c_void),
+        > = None;
+    }
+
+    unsafe {
+        module_call_init(module_init_type::MODULE_INIT_QOM);
+        object_unref(object_new(DummyState::TYPE_NAME.as_ptr()) as *mut _);
+    }
+}
-- 
2.46.2


