Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA628D1BDD2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80rq-000584-PA; Mon, 04 Nov 2024 12:27:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80rm-00055h-FD
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:27:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80rh-0000AN-SD
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5qAG6ukCd1KkybKSvqNo8XTeuhbkZsfnPzCuHeVYnsk=;
 b=A4py+fU9Nuce7VzJrYwSzmULeDG1tvuL+Vtm92nJaSHYTag5JU5bLmdGIyL0nlB+Bbuwcs
 S3ztZxHGPm+SwQ8TEjVPZhRcBm1szK3N3ae9SQ6bvKx9uIHNA7eNiuYGY2WMq8uFFBNo7i
 Cjps+cnBcIgwhdKBKVr4T/7HvL9IeV0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-9yHG4_xxP9q-HKr8swn2AA-1; Mon, 04 Nov 2024 12:27:40 -0500
X-MC-Unique: 9yHG4_xxP9q-HKr8swn2AA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d4a211177so2261463f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:27:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741259; x=1731346059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5qAG6ukCd1KkybKSvqNo8XTeuhbkZsfnPzCuHeVYnsk=;
 b=RSP/ZmXvHvz+jB9cMRsiBP0KUynqjZ6m1QYXNd7WXP/TUTv6u/r3HJ+iSyAa3i588v
 K9XLZ40z1piwL0SxxNYDiRhuIqWX1iFGVBSCKvUFzzFwcuHsY0uFjkOjb1NV/sdGnHV9
 2/5oeUAUw+k7wKW8cqyQdadylgFDPThqIVAwjdIE7XRxJeVW2/Hfyie4oKGVopTFGnIJ
 l+09LEZqgiBwWYYuf6K4l85GcDCz3d5ExPXd3czwNtTcJeK32d3vsmeuSSsfZ68CQADh
 rXA1M3HYJl/7PFQ6F3fM4Yod0UIdJ+Q4te5h1p7cCjTCbeBAw7Q7Wtnr6FDnzdhZFWN4
 HOgQ==
X-Gm-Message-State: AOJu0YybIQ1jFwMvhz6Pm69mDpGqNlG11+vdQGoGIFs2fqqlaqJy7Emo
 v6iToj3x7KZe9N9cIDxjtVnZZWAjR1ep1izGOnBThg4ky/miE+j64zq8/841SzL+K8vhV8ZK4NG
 bwIXQ09stthrMHayV6WdS1Pu1hGg0W05X/AeN0KrUYJDMSlPzK0asb7l2uWwFPzz5XQCOH6ZwmV
 9+G6Z9hXGyu7MO4g9bPqtk2C6bYfRwSOgTaH+ZDyI=
X-Received: by 2002:a05:6000:1fac:b0:381:bdeb:1799 with SMTP id
 ffacd0b85a97d-381bdeb17fbmr15377240f8f.16.1730741258949; 
 Mon, 04 Nov 2024 09:27:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7NZXabIEkdsFFPILyejhCm5PfJJQL1aLm17DaQ0eefZ4AIfNUkM6m6H99PeqSZSfAd7xJCg==
X-Received: by 2002:a05:6000:1fac:b0:381:bdeb:1799 with SMTP id
 ffacd0b85a97d-381bdeb17fbmr15377208f8f.16.1730741257893; 
 Mon, 04 Nov 2024 09:27:37 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e734csm13734062f8f.60.2024.11.04.09.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:27:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 07/40] meson: pass rustc_args when building all crates
Date: Mon,  4 Nov 2024 18:26:46 +0100
Message-ID: <20241104172721.180255-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

rustc_args is needed to smooth the difference in warnings between the various
versions of rustc.  Always include those arguments.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                       | 20 +++++++++++++-------
 rust/qemu-api/meson.build         |  2 +-
 rust/qemu-api/src/device_class.rs | 10 ++++++----
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/meson.build b/meson.build
index 29a8df6d5f2..7d06d2fe74e 100644
--- a/meson.build
+++ b/meson.build
@@ -3331,6 +3331,19 @@ endif
 
 genh += configure_file(output: 'config-host.h', configuration: config_host_data)
 
+if have_rust and have_system
+  rustc_args = run_command(
+    find_program('scripts/rust/rustc_args.py'),
+    '--config-headers', meson.project_build_root() / 'config-host.h',
+    capture : true,
+    check: true).stdout().strip().split()
+
+  # Prohibit code that is forbidden in Rust 2024
+  rustc_args += ['-D', 'unsafe_op_in_unsafe_fn']
+  add_project_arguments(rustc_args, native: false, language: 'rust')
+  add_project_arguments(rustc_args, native: true, language: 'rust')
+endif
+
 hxtool = find_program('scripts/hxtool')
 shaderinclude = find_program('scripts/shaderinclude.py')
 qapi_gen = find_program('scripts/qapi-gen.py')
@@ -3923,12 +3936,6 @@ common_all = static_library('common',
                             dependencies: common_ss.all_dependencies())
 
 if have_rust and have_system
-  rustc_args = run_command(
-    find_program('scripts/rust/rustc_args.py'),
-    '--config-headers', meson.project_build_root() / 'config-host.h',
-    capture : true,
-    check: true).stdout().strip().split()
-  rustc_args += ['-D', 'unsafe_op_in_unsafe_fn']
   bindgen_args = [
     '--disable-header-comment',
     '--raw-line', '// @generated',
@@ -4101,7 +4108,6 @@ foreach target : target_dirs
                             rlib_rs,
                             dependencies: target_rust.dependencies(),
                             override_options: ['rust_std=2021', 'build.rust_std=2021'],
-                            rust_args: rustc_args,
                             rust_abi: 'c')
       arch_deps += declare_dependency(link_whole: [rlib])
     endif
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index c72d34b607d..42ea815fa5a 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -10,7 +10,7 @@ _qemu_api_rs = static_library(
   ),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
-  rust_args: rustc_args + [
+  rust_args: [
     '--cfg', 'MESON',
     # '--cfg', 'feature="allocator"',
   ],
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index 1ea95beb78d..b6b68cf9ce2 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -16,10 +16,12 @@ macro_rules! device_class_init {
         ) {
             let mut dc =
                 ::core::ptr::NonNull::new(klass.cast::<$crate::bindings::DeviceClass>()).unwrap();
-            dc.as_mut().realize = $realize_fn;
-            dc.as_mut().vmsd = &$vmsd;
-            $crate::bindings::device_class_set_legacy_reset(dc.as_mut(), $legacy_reset_fn);
-            $crate::bindings::device_class_set_props(dc.as_mut(), $props.as_mut_ptr());
+            unsafe {
+                dc.as_mut().realize = $realize_fn;
+                dc.as_mut().vmsd = &$vmsd;
+                $crate::bindings::device_class_set_legacy_reset(dc.as_mut(), $legacy_reset_fn);
+                $crate::bindings::device_class_set_props(dc.as_mut(), $props.as_mut_ptr());
+            }
         }
     };
 }
-- 
2.47.0


