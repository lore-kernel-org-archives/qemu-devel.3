Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED048D30011
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1oCM-0008Df-1e; Fri, 18 Oct 2024 10:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCK-0008DE-0I
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCI-0002b3-Cc
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729262601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jd0gmtcBQzLINXkp+X79ep9Gkfj1tGWs8hU6aYifJxw=;
 b=UsrJJMY91BkRYNXsvSpW7nS4Bm1UI1kOhTarILnYch9aGpYccbQDC1D1JHp8CgjyophBnV
 KemZKY7WEMwHiaUqETkABijSh+SIVww2lOorHtjKhnsUL7SZcgJC446KHeF64Q3Gg7NZSO
 EMZqe/yV4yLGQ36ZP39YMtt7yF3RrxA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-AUkuFRABOoKB4c2dYzv9-A-1; Fri, 18 Oct 2024 10:43:20 -0400
X-MC-Unique: AUkuFRABOoKB4c2dYzv9-A-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315af466d9so12917725e9.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729262599; x=1729867399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jd0gmtcBQzLINXkp+X79ep9Gkfj1tGWs8hU6aYifJxw=;
 b=JGxEuMiHvWIajTp+WeFwsnBxtQgMr1gAOfMOHWHGf6EJrinQRbpZorxjDjFgHmxhrx
 /43L52honhRoPtGx3tjh9TcJUP4VdGvdutF4cdka7vHQNmb7yIs2Vf/W3bXODUExTWV9
 /tw7+fmh4bnproXNbKPiyctwis+5oTwrIQBYrtCCzEM2mUZjvJ2eP2bFNmvMfXQbflop
 NqcqhrdJjB3mKACZuiAr4kmDWPumE5YjopPN8PXqvk4I301Z0oVsEa3GMVGxbIQdzBDo
 jBpbfx4SFSSPgmDgmB067FH7Jv1oUEtensVZj52BOvAfTY81dYOqVhnW5LDEpDo+kRyV
 hWnw==
X-Gm-Message-State: AOJu0YygJhck0i+GdB8yOIlg3eY59EbeoVil0tt0PHv4lPbWe9dAPGA+
 UbtHtg4nah2XVm+4fRs1e8pl2eybfbjEi8ktNgoI3NV4UHcoRpMkPsVJXj0fsaOWCdNXOty7VZo
 KcimlNKTTypIA2TKKuwBSOlV1yqmGBzm2/pSMLAB6JN3+DoTbWnZ0izjYDAp4KS3uSKNM6b09sX
 YkWAzbqXbjyHMrRcVjAgvuKY8Hk3aZzztTiJAwPjk=
X-Received: by 2002:a05:600c:354e:b0:42b:a7c7:5667 with SMTP id
 5b1f17b1804b1-431616a3a15mr20835685e9.25.1729262598556; 
 Fri, 18 Oct 2024 07:43:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBlwSkyu6zYc2SdwTjWIXH0OuA20A1PK/mET2YotKr6f9GSxkvXqsT905efB/NKciY/uQCoA==
X-Received: by 2002:a05:600c:354e:b0:42b:a7c7:5667 with SMTP id
 5b1f17b1804b1-431616a3a15mr20835435e9.25.1729262598034; 
 Fri, 18 Oct 2024 07:43:18 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43160e0a887sm25991095e9.23.2024.10.18.07.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:43:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 03/13] meson: pass rustc_args when building all crates
Date: Fri, 18 Oct 2024 16:42:55 +0200
Message-ID: <20241018144306.954716-4-pbonzini@redhat.com>
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

rustc_args is needed to smooth the difference in warnings between the various
versions of rustc.  Always include those arguments.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                       | 18 +++++++++++-------
 rust/qemu-api/meson.build         |  2 +-
 rust/qemu-api/src/device_class.rs | 10 ++++++----
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/meson.build b/meson.build
index f85bc22fbdd..44f3bf34931 100644
--- a/meson.build
+++ b/meson.build
@@ -3317,6 +3317,17 @@ endif
 
 genh += configure_file(output: 'config-host.h', configuration: config_host_data)
 
+if have_rust and have_system
+  rustc_args = run_command(
+    find_program('scripts/rust/rustc_args.py'),
+    '--config-headers', meson.project_build_root() / 'config-host.h',
+    capture : true,
+    check: true).stdout().strip().split()
+  rustc_args += ['-D', 'unsafe_op_in_unsafe_fn']
+  add_project_arguments(rustc_args, native: false, language: 'rust')
+  add_project_arguments(rustc_args, native: true, language: 'rust')
+endif
+
 hxtool = find_program('scripts/hxtool')
 shaderinclude = find_program('scripts/shaderinclude.py')
 qapi_gen = find_program('scripts/qapi-gen.py')
@@ -3909,12 +3920,6 @@ common_all = static_library('common',
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
@@ -4087,7 +4092,6 @@ foreach target : target_dirs
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


