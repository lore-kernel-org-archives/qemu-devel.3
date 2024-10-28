Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6FCD3398E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Qle-0001Jg-R4; Mon, 28 Oct 2024 10:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Ql5-0000Li-VH
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Ql3-0003lZ-0E
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730125806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e6dzvxdvUD9f5+tb1x3QNv8ncs9HO3QkAP+Z/lD+THw=;
 b=V9cEGu/+puA5xQw5XPAsvZHjo9no2V4RPpyfesgKU44QgNyor/5tc6xlBvx4Fr6jSzHdX9
 M8lomFVRBlxi8Yt+R26N+DWy1NhgTmd2NslR7c6fzBhlRN+6SUkXhkp1k64iYSZHfNTw5L
 i8B3wrjEBiXUqomYFdwCRFW9+Ra5fTQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-UJzBYOW9OAOI0_KcbeYAaA-1; Mon, 28 Oct 2024 10:30:04 -0400
X-MC-Unique: UJzBYOW9OAOI0_KcbeYAaA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d4854fa0eso2144823f8f.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730125802; x=1730730602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e6dzvxdvUD9f5+tb1x3QNv8ncs9HO3QkAP+Z/lD+THw=;
 b=cCqTIj+Gd6rDTcYrRQCD75jqa7HD7NVSOrMeIvNxTtUDtUYZCokXtmRBYCFQPcP7x3
 rWIxxzwFsuQZXBkK7gdS4JBAfvtXKqQLKvABDt9raytBVduyh+EAwXVsxBCiW1/zkqHV
 2PrMMqd5P68lOQPfi14QOj0Zb2O455bwjg/CCNop/Cj/7/T+vQzOLLwiRWAkxFeZcEhB
 6XxCMqKNnVRTAO7SwjCpErcJ5gWFjbqBz/f79Scb6hOur3HlVqN5lxxYYys6pWUBCYdA
 s+urB10Dqjlefc5iYjJI4VkNoRyfGrCCcNtb6j911I2ca0eY8Ci6FErvaB0SrCBE95FI
 FnFg==
X-Gm-Message-State: AOJu0Yy4/21rDk72HAsUYBiuCMaKy7m4Kk3XGREcYxVAiqlybOjKnGqe
 d7Yn3KMIIYbnjs9TgrDJOtPYqsJr/d3H+8tbwOoc7uc/lBd01KT1sWaiP7cDxKc8bTZYlvVgPrf
 GBL2fkeCKUN22aMvWJX+3l9c4hdwOiXDY7uVDvwsDeVFhGqpty+vvDfEpMp83rJZL2u4OvDTtPR
 UxL1A/ASiISdFhFyx1NWLgPG5RSBn+jHzd4/K8FSg=
X-Received: by 2002:adf:efca:0:b0:37d:4b07:606b with SMTP id
 ffacd0b85a97d-380611e0fd1mr5978566f8f.36.1730125802535; 
 Mon, 28 Oct 2024 07:30:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAqN3JyuLnWU5F1AhVZqWvpubhQ9PAAzD3KGBL1xyVJHHmz/6bFxKX4UhfHMPN2Zq8w6+6GA==
X-Received: by 2002:adf:efca:0:b0:37d:4b07:606b with SMTP id
 ffacd0b85a97d-380611e0fd1mr5978541f8f.36.1730125802053; 
 Mon, 28 Oct 2024 07:30:02 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b712cbsm9675079f8f.77.2024.10.28.07.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 07:29:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Junjie Mao <junjie.mao@hotmail.com>,
	Kevin Wolf <kwolf@redhat.com>
Subject: [PULL 11/24] meson: pass rustc_args when building all crates
Date: Mon, 28 Oct 2024 15:29:18 +0100
Message-ID: <20241028142932.363687-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028142932.363687-1-pbonzini@redhat.com>
References: <20241028142932.363687-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
index 0f1de0db2d9..0b8c3495eab 100644
--- a/meson.build
+++ b/meson.build
@@ -3317,6 +3317,19 @@ endif
 
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
@@ -3909,12 +3922,6 @@ common_all = static_library('common',
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
@@ -4087,7 +4094,6 @@ foreach target : target_dirs
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


