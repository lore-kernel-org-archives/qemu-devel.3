Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C23AD15DBB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2vOy-0006cb-B4; Mon, 21 Oct 2024 12:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vNv-0005uZ-9B
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:36:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vNt-0006I8-8A
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729528555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9GT7AM3dNIUTb0glH6Ier4DyJgqZCZmSaW5xm7t2d5c=;
 b=e/LmQLHxgYPKHwr4mxu3wK62XtOzicj0p8jgJQmfBK0hNkSzcZPyibrUDi31cHnIWhAuEi
 A41eLc7eavctUFVcSEVUkzcGmZia+X+NdSjnxbTe9+aePgd4gRAH6EpUyt1cnsbK9741BW
 AWHq9cjH0vOI/HpfncvJP6ficfFHrhs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-7VwXp7kkMZ6K6ACdEL_CNA-1; Mon, 21 Oct 2024 12:35:53 -0400
X-MC-Unique: 7VwXp7kkMZ6K6ACdEL_CNA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-431518ae047so27500045e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 09:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729528551; x=1730133351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9GT7AM3dNIUTb0glH6Ier4DyJgqZCZmSaW5xm7t2d5c=;
 b=tZN48FZSnoq6f2G8CBP3WD3+XCmkftHsuxccsEmYOpWIRwdSsFZ3mJlwjkBm1wteZV
 cIyp9CHjNHI8/GgxZTxT+2X5E9AB9XKHW9sfX0KrC0P6+DOSdyORAyCM1OW2N8EqOqHu
 XKfzc1IdaHPqD0iJuyXkCB3BQ9wsTzppM+xDSx/gcypEmAaHbkTvHlFP89JCSjex9vZ5
 Xl2wF2IG/LDXIo79kP5zAwGhXxV4vrYmbem5yxEczk2u7C1lvWm23Naip/OaOL+wNDbg
 2niu3GCCHaoSKIe0XOoBxlt05qsRxve790yDhPruUgdAjZp399dTe4rK9Iy9brM2113/
 R/9A==
X-Gm-Message-State: AOJu0YzHIVYmsQJVt37Co4pwsa2UL7qeEZUZ7EOmltR2zcpzkUJJ21xG
 vACNprNDRi7akhO+Bu9U9u1d6usrOKC2Y8f3yEO7/erxHcvnginEqp9Xe9g3MnaqGHGDkzMHJfR
 H/Ixewa2BAa5iPvRsqlJ1ZPZ1Edfc1vmObgKLPIIBjiO9XUGQuiRxhDEM0gJ/hN6cs5WwQuprGT
 T7fRSFh9q+C2ZaKgRmEbiTRqWKtCRfCVUbi9HbyWM=
X-Received: by 2002:a05:600c:3590:b0:431:4a82:97f2 with SMTP id
 5b1f17b1804b1-4317bd7f68fmr1645255e9.6.1729528551309; 
 Mon, 21 Oct 2024 09:35:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4SLc6xQ1Gv58wzV1GBsiZAYLjnpBGJee1+5HmHNgVb8o94h9FPGT5N+Xcvf56CjVwUR1QHQ==
X-Received: by 2002:a05:600c:3590:b0:431:4a82:97f2 with SMTP id
 5b1f17b1804b1-4317bd7f68fmr1645095e9.6.1729528550856; 
 Mon, 21 Oct 2024 09:35:50 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f5c2c8esm62956805e9.36.2024.10.21.09.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 09:35:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH v2 03/13] meson: pass rustc_args when building all crates
Date: Mon, 21 Oct 2024 18:35:28 +0200
Message-ID: <20241021163538.136941-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241021163538.136941-1-pbonzini@redhat.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                       | 20 +++++++++++++-------
 rust/qemu-api/meson.build         |  2 +-
 rust/qemu-api/src/device_class.rs | 10 ++++++----
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/meson.build b/meson.build
index f85bc22fbdd..63c07a5b660 100644
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
2.46.2


