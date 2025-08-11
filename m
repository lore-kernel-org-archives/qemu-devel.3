Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA7CCA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 16:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulVDt-00048G-EE; Mon, 11 Aug 2025 12:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ulVDp-000481-5e
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 12:18:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ulVDc-00013l-PQ
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 12:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754929070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pGAys4Dmn+cbImX+rn19+0irb6k8+Hu+GVYd9YcbgBo=;
 b=cMWBcsA3EyNPFnIgqnopLkJwOJo2tw5f3+U3SjQ3/yiNuHyf8F8o1xbgi6iL8nRGjfABVe
 0NipNf+zg0qt6fDdD6XqmfIzeMZihtLTKE/0mENYTp3OmfMxpHCvVNEVYe+Qv2i2EcMXnd
 AfcpgHzKwDrfun8r8sVqOWpT6xuKy2A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-1Wfd1imAOyO1GkXN65fQPw-1; Mon, 11 Aug 2025 12:17:49 -0400
X-MC-Unique: 1Wfd1imAOyO1GkXN65fQPw-1
X-Mimecast-MFC-AGG-ID: 1Wfd1imAOyO1GkXN65fQPw_1754929068
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b782c29be3so2413406f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 09:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754929067; x=1755533867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pGAys4Dmn+cbImX+rn19+0irb6k8+Hu+GVYd9YcbgBo=;
 b=LFWt8vLqFXum2kID6ZB3jdhniDLcwRbyLn9z6drDcgFmwtprEJvN/43+OKBC4IXk0a
 29sEWQx7t3joBq3llc3TNnApa3BDwT5fYkt1WwaWtw3uQe8VsZ3dkGXgl2VqfqHyynjW
 EqA3l5HYU4owxolh4aCySbRCuC6qnYZ9a0oclC0p8l3j1cdNBt4/xVxwGszU5mOH5YEm
 EiIshMo1RG9dPhGwYAunRu93s8PYW9B6LthH8AwSFGTH+VapkBTvpZV77v+vGG8XxFAA
 HTfYzsN/aGiXQyCPopTD9Vwr8vGV1Xp6d2wHzRMo/d9sJatC3TMsCgoHKAAK5oe1rohO
 rjlQ==
X-Gm-Message-State: AOJu0YxCubxPriytP4x/J2H6mwvdH9U72aRytKTIGNAvk9kaD9Bs77ld
 xYjVzdRJdaM4bg902LPKII0PCzemfoUMpYJiW+96uOzl8bGHISnyFUNASZ89fILW1VTgKX/LbZC
 GHgdwIgo8JEuWfAY7kT6E+RVR92AeMDFwZ4JhLAEPHOH5Unid+sB52odexuOZEyV/DUoqAILuM7
 J2oADeXEbsbNcV7AAHwDVA9qgtTRwxlt0c3HMQsLot
X-Gm-Gg: ASbGnctuC56LL1M+/xmd7+zi3LAQpFBi2bmkOBrXV4H4Gg+PvYYlGqXlLXQpLFK0Mjh
 lfDUT2yPfnzGRlvWW29qpszI8L70D0zjrAei0B/fvoPsBj/2XIvPCOKPStnaymao95w2mT3vxA6
 /bBw2D6+xBsdUlBY4LhBfLKwYgcRQEs/e7lKwEXbPTZN7R2kqFfepczUv27hFTARY4jLPjd/Rgm
 1XYx+KQ8MKaYvdKJCwcXkDmqNnF6IRihgB6Ue/0Rz+iT+N1cTzmygMs/cCqC9Qb45Me1gfKukga
 So8CA3YeyQ13vVZ9hUStWac2QfRxwS/TuoRvpHznq+DZ
X-Received: by 2002:a05:6000:4022:b0:3b7:948a:1361 with SMTP id
 ffacd0b85a97d-3b910fcc8f1mr281314f8f.6.1754929067072; 
 Mon, 11 Aug 2025 09:17:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTqxmvy/yUFWBZC1F3LtQn/NXixkcyhZgI/m+l5ce+acSIQDsEwQyzrlFJAEvuQ7r5XSpflw==
X-Received: by 2002:a05:6000:4022:b0:3b7:948a:1361 with SMTP id
 ffacd0b85a97d-3b910fcc8f1mr281286f8f.6.1754929066578; 
 Mon, 11 Aug 2025 09:17:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.234.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458b4f9e952sm400768945e9.9.2025.08.11.09.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 09:17:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	manos.pitsidianakis@linaro.org
Subject: [PATCH 2/2] meson: let Meson handle mixed-language linking of Rust
 and C objects
Date: Mon, 11 Aug 2025 18:17:37 +0200
Message-ID: <20250811161737.220835-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811161737.220835-1-pbonzini@redhat.com>
References: <20250811161737.220835-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Meson 1.9.0 can pass C objects into rustc so that the final link pass can
add the Rust libstd.  Use that to eliminate the staticlib and allow
dynamic linking with libstd (also introduced by Meson 1.9.0, but not
for staticlib crates due to lack of support in rustc).

The main() function is still provided by C, which is possible by
declaring the main source file of the Rust executable (which is
created by scripts/rust/rust_root_crate.sh) as #![no_main].

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                     | 19 ++++++++-----------
 scripts/rust/rust_root_crate.sh |  1 +
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/meson.build b/meson.build
index e53cd5b4138..0a921272f57 100644
--- a/meson.build
+++ b/meson.build
@@ -4377,25 +4377,22 @@ foreach target : target_dirs
   arch_srcs += target_specific.sources()
   arch_deps += target_specific.dependencies()
 
+  main_rs = []
+  crates = []
   if have_rust and target_type == 'system'
     target_rust = rust_devices_ss.apply(config_target, strict: false)
-    crates = []
+    arch_deps += target_rust.dependencies()
     foreach dep : target_rust.dependencies()
       crates += dep.get_variable('crate')
     endforeach
     if crates.length() > 0
-      rlib_rs = custom_target('rust_' + target.underscorify() + '.rs',
+      main_rs = custom_target('rust_' + target.underscorify() + '.rs',
                               output: 'rust_' + target.underscorify() + '.rs',
                               command: [rust_root_crate, crates],
                               capture: true,
                               build_by_default: true,
                               build_always_stale: true)
-      rlib = static_library('rust_' + target.underscorify(),
-                            structured_sources([], {'.': rlib_rs}),
-                            dependencies: target_rust.dependencies(),
-                            override_options: ['rust_std=2021', 'build.rust_std=2021'],
-                            rust_abi: 'c')
-      arch_deps += declare_dependency(link_whole: [rlib])
+      main_rs = structured_sources(main_rs)
     endif
   endif
 
@@ -4419,14 +4416,14 @@ foreach target : target_dirs
     execs = [{
       'name': 'qemu-system-' + target_name,
       'win_subsystem': 'console',
-      'sources': files('system/main.c'),
+      'sources': [main_rs, files('system/main.c')],
       'dependencies': [sdl]
     }]
     if host_os == 'windows' and (sdl.found() or gtk.found())
       execs += [{
         'name': 'qemu-system-' + target_name + 'w',
         'win_subsystem': 'windows',
-        'sources': files('system/main.c'),
+        'sources': [main_rs, files('system/main.c')],
         'dependencies': [sdl]
       }]
     endif
@@ -4435,7 +4432,7 @@ foreach target : target_dirs
       execs += [{
         'name': 'qemu-fuzz-' + target_name,
         'win_subsystem': 'console',
-        'sources': specific_fuzz.sources(),
+        'sources': [main_rs, specific_fuzz.sources()],
         'dependencies': specific_fuzz.dependencies(),
       }]
     endif
diff --git a/scripts/rust/rust_root_crate.sh b/scripts/rust/rust_root_crate.sh
index 975bddf7f1a..1ee88114ad9 100755
--- a/scripts/rust/rust_root_crate.sh
+++ b/scripts/rust/rust_root_crate.sh
@@ -6,6 +6,7 @@ cat <<EOF
 // @generated
 // This file is autogenerated by scripts/rust_root_crate.sh
 
+#![no_main]
 EOF
 
 for crate in $*; do
-- 
2.50.1


