Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9DBC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnekL-0006yh-8K; Thu, 27 Feb 2025 09:20:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekH-0006vG-NE
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekC-0003gY-41
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6S3+h0KILMZzEFjUXbmLqWGpqxuaheqFJv+xCK/jNY0=;
 b=ZAc5Ma+t7Y5kmVBcFi7AYeOjPkHmMtnv0dISxhjQYMWba7S+QxX2N6gkSjOyP+v24EFShS
 SkmSXfX76+Rx13aL6qC1zYjr8bQTylRM1bUXnlEVRVVjgl3+pViM/vpQA23OpQjWNCwDh7
 snDxyTNRfton/q4njcNPaU09Ap8m1pY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-eTkUseSzMl2VTEQWiQoP0Q-1; Thu, 27 Feb 2025 09:20:05 -0500
X-MC-Unique: eTkUseSzMl2VTEQWiQoP0Q-1
X-Mimecast-MFC-AGG-ID: eTkUseSzMl2VTEQWiQoP0Q_1740666004
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5de5172cc5bso918130a12.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666004; x=1741270804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6S3+h0KILMZzEFjUXbmLqWGpqxuaheqFJv+xCK/jNY0=;
 b=GkTQdWI+uhZNIf6BHBfRrW30fCY5XmvdbdeZvEEpF4I47v3dTV4o34ELZ03TUKSABZ
 oXb50jZI8aOUiH/POFAn+pT7Bz52dd6gj9l8xv+OkAmB7wF+MXTACG8/W5lQWydpqOGE
 XWJdtBSPmYGjHfWLfqd+Iq3e9N9MlXT+0nOZLHq6q4iEwSL88ueBKdEv2qh1y9haAtzo
 5ELIMnx9D0eYjAS7vXDPNfaDCxdULoDFOA0KL59oofCKDn8guMgQGCzDvsE4t5fJNtuC
 V2JNM+uyN9aFSWwKpGh1YwaorAIfOCkOjQhRzChrvYdSuBWkfL3rWlc5zXrdXJfXXx+v
 0o0A==
X-Gm-Message-State: AOJu0YzBWsBqxic4oWUpWOO3agdraa7q3TPsej5me2JNKUffFgxOR3vr
 3moNWxpg67WTVLWkMT2xbuy+/yJ4LonRMSmN3WHIIHt9nmhDDOxXxl8NFzp0FNe3Orw85+Jgrum
 4ofJFlAx3bO8baSoWPC9pH1a3wP5gGuHJNQQPo6l+6W7aOV+YrkK+U1C0yGFz9ywPo9cR2jrAkQ
 7QtumypnUMSI0xQk0JU8yxw1ZoHneBKIM1ec++/vc=
X-Gm-Gg: ASbGncu6vRwUpvfqp8307xIAFQcM8Ik4/BODbOZ4Onbd0iDgP6oVpo6UoGq01iPfm82
 /J71x9xjkhJ1zc6SxYJMYiYvLJwgPExdMIVom5aEYtOizFBysVQDJy3G8rfGNZPWKZV8WdwhJr0
 7w03x/VJbdRpegYZr3h8gmbSEt/TpqIXdrBn8EWfNRQ7+ZyRwqdyuqkG68iBss8ypIeQJghsO9W
 4QRc3u3ytk7NoEi/vGWUwoYce2J4HSyfS/sFoypJxClhRlYwYOh1htkmOQ04PQV/ywKHVZr4jrM
 Sh+K2hDH7BDDcMJ4HxKS
X-Received: by 2002:a05:6402:35d3:b0:5dc:caab:9447 with SMTP id
 4fb4d7f45d1cf-5e4469dd8eemr30508391a12.18.1740666003596; 
 Thu, 27 Feb 2025 06:20:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqZlhQ7KbyYU/7FFHFZRg0Qb5nNfwuQTkzsuGR8q0ELLB/0jkLy8pDqW/yjIx7SX0BSD7zWA==
X-Received: by 2002:a05:6402:35d3:b0:5dc:caab:9447 with SMTP id
 4fb4d7f45d1cf-5e4469dd8eemr30508292a12.18.1740666002966; 
 Thu, 27 Feb 2025 06:20:02 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c75d8ddsm127748866b.154.2025.02.27.06.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 04/34] rust: subprojects: add libc crate
Date: Thu, 27 Feb 2025 15:19:22 +0100
Message-ID: <20250227141952.811410-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This allows access to errno values.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock                               |  7 ++++
 rust/qemu-api/Cargo.toml                      |  1 +
 scripts/archive-source.sh                     |  2 +-
 scripts/make-release                          |  2 +-
 subprojects/.gitignore                        |  1 +
 subprojects/libc-0.2-rs.wrap                  |  7 ++++
 .../packagefiles/libc-0.2-rs/meson.build      | 37 +++++++++++++++++++
 7 files changed, 55 insertions(+), 2 deletions(-)
 create mode 100644 subprojects/libc-0.2-rs.wrap
 create mode 100644 subprojects/packagefiles/libc-0.2-rs/meson.build

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 79e142723b8..2ebf0a11ea4 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -54,6 +54,12 @@ dependencies = [
  "either",
 ]
 
+[[package]]
+name = "libc"
+version = "0.2.162"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "18d287de67fe55fd7e1581fe933d965a5a9477b38e949cfa9f8574ef01506398"
+
 [[package]]
 name = "pl011"
 version = "0.1.0"
@@ -100,6 +106,7 @@ dependencies = [
 name = "qemu_api"
 version = "0.1.0"
 dependencies = [
+ "libc",
  "qemu_api_macros",
  "version_check",
 ]
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index a51dd142852..57747bc9341 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -16,6 +16,7 @@ rust-version = "1.63.0"
 
 [dependencies]
 qemu_api_macros = { path = "../qemu-api-macros" }
+libc = "0.2.162"
 
 [build-dependencies]
 version_check = "~0.9"
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 30677c3ec90..e461c1531ed 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -28,7 +28,7 @@ sub_file="${sub_tdir}/submodule.tar"
 # different to the host OS.
 subprojects="keycodemapdb libvfio-user berkeley-softfloat-3
   berkeley-testfloat-3 arbitrary-int-1-rs bilge-0.2-rs
-  bilge-impl-0.2-rs either-1-rs itertools-0.11-rs proc-macro2-1-rs
+  bilge-impl-0.2-rs either-1-rs itertools-0.11-rs libc-0.2-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
   syn-2-rs unicode-ident-1-rs"
 sub_deinit=""
diff --git a/scripts/make-release b/scripts/make-release
index 1b89b3423a8..8c3594a1a47 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -41,7 +41,7 @@ fi
 # Only include wraps that are invoked with subproject()
 SUBPROJECTS="libvfio-user keycodemapdb berkeley-softfloat-3
   berkeley-testfloat-3 arbitrary-int-1-rs bilge-0.2-rs
-  bilge-impl-0.2-rs either-1-rs itertools-0.11-rs proc-macro2-1-rs
+  bilge-impl-0.2-rs either-1-rs itertools-0.11-rs libc-0.2-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
   syn-2-rs unicode-ident-1-rs"
 
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index 50f173f90db..d12d34618cc 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -11,6 +11,7 @@
 /bilge-impl-0.2.0
 /either-1.12.0
 /itertools-0.11.0
+/libc-0.2.162
 /proc-macro-error-1.0.4
 /proc-macro-error-attr-1.0.4
 /proc-macro2-1.0.84
diff --git a/subprojects/libc-0.2-rs.wrap b/subprojects/libc-0.2-rs.wrap
new file mode 100644
index 00000000000..bbe08f87883
--- /dev/null
+++ b/subprojects/libc-0.2-rs.wrap
@@ -0,0 +1,7 @@
+[wrap-file]
+directory = libc-0.2.162
+source_url = https://crates.io/api/v1/crates/libc/0.2.162/download
+source_filename = libc-0.2.162.tar.gz
+source_hash = 18d287de67fe55fd7e1581fe933d965a5a9477b38e949cfa9f8574ef01506398
+#method = cargo
+patch_directory = libc-0.2-rs
diff --git a/subprojects/packagefiles/libc-0.2-rs/meson.build b/subprojects/packagefiles/libc-0.2-rs/meson.build
new file mode 100644
index 00000000000..ac4f80dba98
--- /dev/null
+++ b/subprojects/packagefiles/libc-0.2-rs/meson.build
@@ -0,0 +1,37 @@
+project('libc-0.2-rs', 'rust',
+  meson_version: '>=1.5.0',
+  version: '0.2.162',
+  license: 'MIT OR Apache-2.0',
+  default_options: [])
+
+_libc_rs = static_library(
+  'libc',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2015', 'build.rust_std=2015'],
+  rust_abi: 'rust',
+  rust_args: [
+    '--cap-lints', 'allow',
+    '--cfg', 'freebsd11',
+    '--cfg', 'libc_priv_mod_use',
+    '--cfg', 'libc_union',
+    '--cfg', 'libc_const_size_of',
+    '--cfg', 'libc_align',
+    '--cfg', 'libc_int128',
+    '--cfg', 'libc_core_cvoid',
+    '--cfg', 'libc_packedN',
+    '--cfg', 'libc_cfg_target_vendor',
+    '--cfg', 'libc_non_exhaustive',
+    '--cfg', 'libc_long_array',
+    '--cfg', 'libc_ptr_addr_of',
+    '--cfg', 'libc_underscore_const_names',
+    '--cfg', 'libc_const_extern_fn',
+  ],
+  dependencies: [],
+)
+
+libc_dep = declare_dependency(
+  link_with: _libc_rs,
+)
+
+meson.override_dependency('libc-0.2-rs', libc_dep)
-- 
2.48.1


