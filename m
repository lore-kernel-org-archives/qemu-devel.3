Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5591D30011
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1oCb-0008GS-8K; Fri, 18 Oct 2024 10:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCZ-0008GK-JM
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCX-0002c4-Ot
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729262617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F8wsQjPMVjjwkNzJ9IhojZy7e4Mf2LiRo455TrrTrnI=;
 b=idP0dWmRiogSCu2GREtgl00sT8CvGMCOEt9MZ2m8mhfN1sg3jrVGFu1z6FNBFawqSpgFWa
 znXLIIosm8IX+NfCtad8Qct4uXXmcP3M5ZLnqrOJo532u38OiVh0jWw2QFPZ3C3S+BMfaX
 epsHCR8qUBZnNbCqQI5+VSwZCJW3SJs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-0PXKJf3gP0uGlMVxKDj0iQ-1; Fri, 18 Oct 2024 10:43:35 -0400
X-MC-Unique: 0PXKJf3gP0uGlMVxKDj0iQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4314c6ca114so16201745e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729262613; x=1729867413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F8wsQjPMVjjwkNzJ9IhojZy7e4Mf2LiRo455TrrTrnI=;
 b=L46sTPRgOU2L2uqA08rGa3qh6wE7JKNXThiK0+BOIlN7oIiM9P4N1c1dTprW76S7j+
 NiUSRMAtZnYkCMYqMt3Mdv1zvkCc7j/7x7Ltm05fyg5W+Bk+qOlyQcCppI1CiT1LX3lM
 ehzjGSlcEF6Dway5hvSLvXKEFrLPGqkDzhgk7hjIMdw679pPTxtXHX0Pn1j2syK478gp
 bLdKJhkzNwhHeiS/wZ71/Ci1P95v7uZcvMucc/N6rPLXNhLDzSkIVRlfWRSZ68TVJKiF
 9aeha0pGEomt7YjFgljx2gY8IrCOWVjfnokWRZiHA6WtEJkmU8qSGzNkPYzjZVGozfYJ
 Lb6A==
X-Gm-Message-State: AOJu0YxHaHwamTzdtuzF6Qd9qaZs575v4MdWmD5MhfpxCrvgfdSAfIjf
 KOfzVT4Wf7SzSpyH2uSyR+2/QaALKVtVMSguxZDijk0i7jogqiRacsUR5C+pffyAOIsNya/9kiA
 Pt7/Jcpb7wcIovQkm2hbRhfuSvzSZIgPHKdFGz8aVidVCwaM2yF2tO8TRNZSO34eLf7sGSjCOue
 ePjnLSivtoW6aeqcEvl+kimH9i7nHF8x+hW2UqadE=
X-Received: by 2002:a05:600c:5489:b0:431:52b7:a499 with SMTP id
 5b1f17b1804b1-4316164da71mr21554675e9.20.1729262613507; 
 Fri, 18 Oct 2024 07:43:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhMiAaB0ldr+lLd7iVP/vR/2nGp/Lzj18G8C6vG+kacqvRIvPQvUf7/m33/omq2CEfVBEFgQ==
X-Received: by 2002:a05:600c:5489:b0:431:52b7:a499 with SMTP id
 5b1f17b1804b1-4316164da71mr21554465e9.20.1729262613052; 
 Fri, 18 Oct 2024 07:43:33 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ecf04a694sm2142439f8f.33.2024.10.18.07.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:43:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 08/13] rust: build integration test for the qemu_api crate
Date: Fri, 18 Oct 2024 16:43:00 +0200
Message-ID: <20241018144306.954716-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018144306.954716-1-pbonzini@redhat.com>
References: <20241018144306.954716-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                  | 10 ++++-
 rust/qemu-api/meson.build    | 20 +++++++--
 rust/qemu-api/src/tests.rs   | 49 ----------------------
 rust/qemu-api/tests/tests.rs | 78 ++++++++++++++++++++++++++++++++++++
 4 files changed, 104 insertions(+), 53 deletions(-)
 delete mode 100644 rust/qemu-api/src/tests.rs
 create mode 100644 rust/qemu-api/tests/tests.rs

diff --git a/meson.build b/meson.build
index 48f82fd4ba6..e50a7edf6ea 100644
--- a/meson.build
+++ b/meson.build
@@ -3324,7 +3324,15 @@ if have_rust and have_system
     capture : true,
     check: true).stdout().strip().split()
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
index 42ea815fa5a..d24e0c0725e 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -14,11 +14,25 @@ _qemu_api_rs = static_library(
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
+# Rust executable do not support objects, so add an intermediate step.
+rust_qemu_api_objs = static_library(
+    'rust_qemu_api_objs',
+    objects: [libqom.extract_all_objects(recursive: false),
+              libhwcore.extract_all_objects(recursive: false)])
+
+rust.test('rust-qemu-api-integration',
+     static_library(
+         'rust_qemu_api_integration',
+         'tests/tests.rs',
+         override_options: ['rust_std=2021', 'build.rust_std=2021'],
+         link_whole: [rust_qemu_api_objs, libqemuutil]),
+
+     dependencies: [qemu_api, qemu_api_macros],
+     suite: ['unit', 'rust'])
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
index 00000000000..57bab62772d
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
+    bindings::*, declare_properties, define_property,
+    definitions::Class,
+    definitions::ObjectImpl,
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
+            > = Some(dummy_class_init);
+        const CLASS_BASE_INIT: Option<
+            unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi::c_void),
+            > = None;
+    }
+
+    unsafe {
+        module_call_init(module_init_type::MODULE_INIT_QOM);
+        object_unref(object_new(DummyState::TYPE_NAME.as_ptr()) as *mut _);
+    }
+}
-- 
2.46.2


