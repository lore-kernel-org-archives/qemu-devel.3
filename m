Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D4EC41513
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIUm-0003M7-Nv; Mon, 01 Jul 2024 10:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIUl-0003Ki-3J
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIUj-00052e-8O
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719845943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RHpEuKlw8QJPXOpD78MMN+7/lIJQeedbl+21kFAu6RE=;
 b=V3/8weawR4JSvZ2ANh/dLkipo1X3Qg8pxIXyR0vPBt9KQ1ZUjFizv6PsU1wTiG+vgppCZs
 qE3dP9Mu+U3RCYrefNlNK3xXnZgK21fgmp46phi9FVnmlxgsL75Pj/ghKe22AfiWnbHodP
 nDCAJ1KmASi3KK3GHbKx0YPHnVlrwOU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-sWmV8dvEPlWZrndKNfmUyQ-1; Mon, 01 Jul 2024 10:59:02 -0400
X-MC-Unique: sWmV8dvEPlWZrndKNfmUyQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4258675a6easo5779695e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 07:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719845941; x=1720450741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RHpEuKlw8QJPXOpD78MMN+7/lIJQeedbl+21kFAu6RE=;
 b=Rx5hcVpbkSMm0IHNs+OKZ9te6y552X9zhSQkS3iosStxkcp/spr6V5+09HIWwl2g/U
 ZA5DPDtGv4n8UMBxhM/Gdu8OFNFJiaJyUpAmcH2wzbozqeJF4/1OO0THDjsSLLqoJzOq
 IseyEljVQS6ESljWVm4ef3Q8JbSIdkyWyiCoOPsC9e2nlPkXb4tJqoKj5aj2SVMutN/t
 eQu+I+VOX80spLhGz44iHPWCpZW0iPZSH1YaXshH/a7oBVwtZ7LHN0Eu9vJ/TYg1RFoT
 11pgrDkpTfYsfU6zrEyM7bWgSojxcAYaN6UmI4Xa8lsfqjSHdl1dzcwYdZia0xIeCk4/
 NoEQ==
X-Gm-Message-State: AOJu0YytxnSHI81xcs2J89P5PAT/SoK4hZs9PnL4zkKmO2BMzmh2+rM3
 3du/Kfw89m843HOVsbuLG1HjJNJbJ4dCSrERan2tf/n0z6BzFE4VKvmg4IbkD1FtPEq/ByNl7IL
 dt/kMap2gOLX3ccwyYd2xs/Q1QtYzqt4h/6C7XE8cYERgVQpMRgFaioCzsVVDRv72AW/Gaw/g54
 8EmyRw0qdQx1y5ehQ0e0vddFGogsK9QAh79bJ3
X-Received: by 2002:a05:6000:2a7:b0:366:e9f9:99c1 with SMTP id
 ffacd0b85a97d-36775724482mr3998914f8f.53.1719845940936; 
 Mon, 01 Jul 2024 07:59:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpHuqT08prYZNxP+XKtb0LrSfZbWdvY+x4yOUMzPNbG+HRAJihzeEYXDUjNvYEPueTbtXkYA==
X-Received: by 2002:a05:6000:2a7:b0:366:e9f9:99c1 with SMTP id
 ffacd0b85a97d-36775724482mr3998888f8f.53.1719845940525; 
 Mon, 01 Jul 2024 07:59:00 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e169dsm10218914f8f.65.2024.07.01.07.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 07:58:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 01/14] add skeleton
Date: Mon,  1 Jul 2024 16:58:33 +0200
Message-ID: <20240701145853.1394967-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701145853.1394967-1-pbonzini@redhat.com>
References: <20240701145853.1394967-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

qemu/ is where target-independent code goes.  This code should
not use constructors and will be brought in as needed.

qemu-hw/ is where the target-dependent code goes, which is going
to be built depending on Kconfig symbols.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitignore               |   2 +
 Cargo.toml               |   3 +
 qemu-hw/Cargo.toml       |   6 ++
 qemu-hw/src/lib.rs       |   0
 qemu-hw/src/main.rs      |   3 +
 qemu/Cargo.toml          |   7 ++
 qemu/src/bindings/mod.rs |  88 +++++++++++++++++++++++++
 qemu/src/lib.rs          |   4 ++
 9 files changed, 249 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 Cargo.toml
 create mode 100644 qemu-hw/Cargo.toml
 create mode 100644 qemu-hw/src/lib.rs
 create mode 100644 qemu-hw/src/main.rs
 create mode 100644 qemu/Cargo.toml
 create mode 100644 qemu/src/bindings/mod.rs
 create mode 100644 qemu/src/lib.rs

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..3fbfc34
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1,2 @@
+/target
+/.git-old
diff --git a/Cargo.toml b/Cargo.toml
new file mode 100644
index 0000000..f66a80e
--- /dev/null
+++ b/Cargo.toml
@@ -0,0 +1,3 @@
+[workspace]
+members = ["qemu"]
+resolver = "2"
diff --git a/qemu-hw/Cargo.toml b/qemu-hw/Cargo.toml
new file mode 100644
index 0000000..9bd6930
--- /dev/null
+++ b/qemu-hw/Cargo.toml
@@ -0,0 +1,6 @@
+[package]
+name = "qemu-hw"
+version = "0.1.0"
+edition = "2021"
+
+[dependencies]
diff --git a/qemu-hw/src/lib.rs b/qemu-hw/src/lib.rs
new file mode 100644
index 0000000..e69de29
diff --git a/qemu-hw/src/main.rs b/qemu-hw/src/main.rs
new file mode 100644
index 0000000..e7a11a9
--- /dev/null
+++ b/qemu-hw/src/main.rs
@@ -0,0 +1,3 @@
+fn main() {
+    println!("Hello, world!");
+}
diff --git a/qemu/Cargo.toml b/qemu/Cargo.toml
new file mode 100644
index 0000000..18d0fa4
--- /dev/null
+++ b/qemu/Cargo.toml
@@ -0,0 +1,7 @@
+[package]
+name = "qemu"
+version = "0.1.0"
+edition = "2021"
+
+[dependencies]
+const-default = { version = "~1", features = ["derive"] }
diff --git a/qemu/src/bindings/mod.rs b/qemu/src/bindings/mod.rs
new file mode 100644
index 0000000..a49447b
--- /dev/null
+++ b/qemu/src/bindings/mod.rs
@@ -0,0 +1,88 @@
+use std::ffi::{c_char, c_void};
+
+#[repr(C)]
+pub struct Object {
+    pub klass: *mut c_void,
+    pub free: extern "C" fn(c: *mut c_void),
+    pub properties: *mut c_void,
+    pub r#ref: u32,
+    pub parent: *mut Object,
+}
+
+#[repr(C)]
+pub struct ObjectClass {
+    pub unparent: Option<unsafe extern "C" fn(*mut Object)>,
+}
+
+#[repr(C)]
+pub struct DeviceState {
+    pub base: Object,
+}
+
+#[repr(C)]
+#[allow(non_camel_case_types)]
+pub struct PropertyInfo {
+    pub name: *const c_char,
+    pub description: *const c_char,
+    // ...
+}
+#[repr(C)]
+pub struct Property {
+    pub name: *const c_char,
+    pub offset: usize,
+    pub default: u64,
+    pub info: *const PropertyInfo,
+}
+
+pub struct DeviceClass {
+    pub oc: ObjectClass,
+
+    pub realize: Option<unsafe extern "C" fn(*mut DeviceState, *mut *mut Error)>,
+    pub unrealize: Option<unsafe extern "C" fn(*mut DeviceState)>,
+    pub cold_reset: Option<unsafe extern "C" fn(*mut DeviceState)>,
+    pub properties: *const Property,
+}
+
+#[repr(C)]
+pub struct TypeInfo {
+    pub name: *const c_char,
+    pub parent: *const c_char,
+    pub instance_mem_init: Option<unsafe extern "C" fn(*mut c_void)>,
+    pub instance_init: Option<unsafe extern "C" fn(*mut c_void)>,
+    pub instance_finalize: Option<unsafe extern "C" fn(*mut c_void)>,
+    pub class_init: Option<unsafe extern "C" fn(*mut c_void, *mut c_void)>,
+    pub instance_size: usize,
+}
+
+#[repr(C)]
+pub struct Error {
+    _unused: c_char,
+}
+
+extern "C" {
+    pub fn error_setg_internal(
+        errp: *mut *mut Error,
+        src: *mut c_char,
+        line: u32,
+        func: *mut c_char,
+        fmt: *const c_char,
+        ...
+    );
+    pub fn error_get_pretty(errp: *const Error) -> *mut c_char;
+    pub fn error_free(errp: *mut Error);
+
+    pub fn object_dynamic_cast(obj: *mut Object, typ: *const c_char) -> *mut c_void;
+    pub fn object_property_add_child(obj: *mut Object, typ: *const c_char,
+        child: *mut Object);
+    pub fn object_get_typename(obj: *const Object) -> *const c_char;
+    pub fn object_ref(obj: *mut Object);
+    pub fn object_new(typ: *const c_char) -> *const Object;
+    pub fn object_unref(obj: *mut Object);
+    pub fn object_unparent(obj: *mut Object);
+
+    pub fn device_cold_reset(obj: *mut DeviceState);
+    pub fn device_realize(obj: *mut DeviceState, err: *mut *mut Error) -> bool;
+    pub fn type_register(obj: *const TypeInfo);
+
+    pub static qdev_prop_bool: PropertyInfo;
+}
diff --git a/qemu/src/lib.rs b/qemu/src/lib.rs
new file mode 100644
index 0000000..fce21d7
--- /dev/null
+++ b/qemu/src/lib.rs
@@ -0,0 +1,4 @@
+#![allow(unused_macros)]
+#![allow(dead_code)]
+
+pub mod bindings;
-- 
2.45.2


