Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C91D1BDD2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80ry-0005Cg-3X; Mon, 04 Nov 2024 12:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80rv-0005BO-Im
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:27:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80rq-0000FP-5e
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=15gJocChv51sOFhNt0S0HtN1Adkbm8Pf6dpwy6uwFWE=;
 b=FB2sBxSZGxbz4Frbq/rOZoDjTU9mAu1awLIPCpnEYAzw383OFspKrH0nNsWBkmVUwdun5C
 a+GNDx6c+/6Dte0TUpO1QklnqyY80bDf7VkF7+14gc+UcPwlI+2415Rg1Eopu5ZeGWR6SO
 /X0/q8Ks34MWBD5nfeazReybPeUnlIA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-la0HymNlNgajKtrHGSUNfA-1; Mon, 04 Nov 2024 12:27:51 -0500
X-MC-Unique: la0HymNlNgajKtrHGSUNfA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d563a1af4so2141142f8f.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:27:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741270; x=1731346070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=15gJocChv51sOFhNt0S0HtN1Adkbm8Pf6dpwy6uwFWE=;
 b=gLZIHElhgsR5HelwQuw5OVo2LmY31ExW0nrmqX5yuE9CKmbFAq05fYvmCw1PSR/PPd
 bOWBzn7ibn9i+qcsqx/CmPaRHMrXPpRvnHQWmj6PS8DL60e8lIl+IOeTXJQniEhhym9y
 OPfdccX9ol2E9N2c5wMUv4fhBr9zOKpt8i4xA/EubtR7d0Y4DdcP+0okrWG2E7Vo3yWp
 sD9asXXlui/oTL9sVX3KZ1vuTmXSJcl6lGzlXxfuDV8jhfQyTy+3ZFI81qdqVZjJcbNM
 l+tk6uqNl5HOs8/r+BWQISi0UHNEYTuKUTQcGDfubUlYPxs0uJaZCqa1aPnPEgL957wi
 Fvzw==
X-Gm-Message-State: AOJu0YxM7hU+uclRZ7EgoGfU5EkP62YxalnuMj00W4esbAOwuFcyZh/a
 32q3XbzK3crFN7Or53/M5I7YwHMr8Ifd2GXdYxr4h9NPFIKdS4JbJBeN5HPznxIXaTyUEgl7+B0
 2avwiT8n5SPYqCojIEWHpoUtGRMta7xrTRnEoA8wDDwC4MdTX+uzFMtbq1LCeQFC6g8M6l4a8rq
 ZQUFqEx2xqQTcjAtEudgx172/mpKl1ZzBDF+p1Xu8=
X-Received: by 2002:a05:6000:1569:b0:37d:3985:8871 with SMTP id
 ffacd0b85a97d-381c7aa4867mr11416891f8f.39.1730741269785; 
 Mon, 04 Nov 2024 09:27:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFK4zkkwxfeHDhJ11Uh0NLykYPjtHtoeqROzyPy0xCnWH6wDBP8UJ1R8aL/rX5uMd5eUnXweg==
X-Received: by 2002:a05:6000:1569:b0:37d:3985:8871 with SMTP id
 ffacd0b85a97d-381c7aa4867mr11416865f8f.39.1730741269338; 
 Mon, 04 Nov 2024 09:27:49 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116c13asm13663253f8f.109.2024.11.04.09.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:27:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 12/40] rust: build integration test for the qemu_api crate
Date: Mon,  4 Nov 2024 18:26:51 +0100
Message-ID: <20241104172721.180255-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

Adjust the integration test to compile with a subset of QEMU object
files, and make it actually create an object of the class it defines.

Follow the Rust filesystem conventions, where tests go in tests/ if
they use the library in the same way any other code would.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
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
index 34328f7394c..d360120b233 100644
--- a/meson.build
+++ b/meson.build
@@ -3340,7 +3340,15 @@ if have_rust and have_system
 
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
2.47.0


