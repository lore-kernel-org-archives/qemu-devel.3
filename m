Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD194C71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 13:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ446-0000JO-3o; Fri, 13 Jun 2025 09:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uQ43i-00009c-7v
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 09:03:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uQ43f-0000Yb-NB
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 09:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749819779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m5umpPvvgjn/tpYWRO7zkHG7cUrCidjwdnI8p2wrau8=;
 b=MD842qGvjgYEUYeMzvHocZrumdzPQ2ZXPoIw6FMxNf6j/k1yQHtc/t3T6RInx7QNmJtEsP
 0dWf7OaNpFKcloS8zbTzIdvgyG50+AqukVYMdUdOajtgXY0eA91vdEwcZx4rT3nzm5zCiN
 ziecl7XqdEzVPnG0dV3CwDOQo0H8hrg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-9CaGw-DMPG-ZWpjDnVzVkw-1; Fri, 13 Jun 2025 09:02:55 -0400
X-MC-Unique: 9CaGw-DMPG-ZWpjDnVzVkw-1
X-Mimecast-MFC-AGG-ID: 9CaGw-DMPG-ZWpjDnVzVkw_1749819774
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a3696a0d3aso900611f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 06:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749819774; x=1750424574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m5umpPvvgjn/tpYWRO7zkHG7cUrCidjwdnI8p2wrau8=;
 b=Jr0VFQpUQQjX0wT1vPLWdzYcVLSfdRc5bjznRdndoXXpprMMulaoP3v/o2XuyIkYs0
 ZBwqGWYcUYu/wTEbkIsakttrJ1eEAYeqinvT/P13v+InITrEntHrZPM/T3xg9UF6bpxp
 84KDP2pt+gN7ZGOpmxebLUqu81Auea2uDo0ZWvzI0XWdISeySsJ7zBsu2xjLJENzMlpi
 RJT/J/OtYyc2bG+xCaB4FEZTK5VZ4yO6mI3jQgf4gG9FNH+oeCITYmNB7UAhBWPKMW7V
 VxmtZny75f9Qs021OW0FI9t09bG4ZxNQzK9wVSq5xWfLMlfa/i+u8AvtbRgXGWvhXZdR
 0UFg==
X-Gm-Message-State: AOJu0YwdktZsTpdDjPD95NN/e0ZQ9xCEV2qJmtW1Dc0KuWtqZSGY18kc
 0ksFNQDdWA3UhiQ7G+PoS3nKtDikM3u9d4PAQ2oA6zgJA8Ydts/kJcjReopSaDp0PBeqTd3+xBL
 AX75SgWT2wD1zXQRUXncnrIWifiO0NhLo2t6VAB6yBBSCRZ422JkoNOYs4rdhZmbnnJCvp5nh++
 EGJ7nCHXB4FGROu238NQmrwTqzVNppHM1azGswuaWD
X-Gm-Gg: ASbGncth3qB7o2bIR31XLdzc1LJHx0tko3mFrtE4WGEXwn7HeO+dbETl3zUaYzeSRkr
 6fvpOA1+zaf5zKbBxBEF8B+Mz4Mq7z1m3O5+iB1/UuqixT2WNlm7CyFJfbAOXEfuC5YccOIcR5v
 AauSMTDbPt/TDHAWrSZaF2kJ6+kK0idmEyN78r+D5k4CQPtWWVXD19aTVzlMqRFTX1htGmVUfKa
 qU31VT4GKhtPFM++5TuIrYfKeYfvpl32SyL3mrEosgc466a1Oli4QSbSIVqa3VJD0zDCo/cjf9F
 NzXosfFyVtPpN0u2vB1YATHK
X-Received: by 2002:a05:6000:2289:b0:3a5:2182:bce2 with SMTP id
 ffacd0b85a97d-3a568670d35mr3093299f8f.17.1749819773708; 
 Fri, 13 Jun 2025 06:02:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7dPESzSJnMQK9ul1O+mcXOPsRqx6aLMWAt7BLIxvMa/wM99XZ8vHkYYbz9ON6yclE7voXKw==
X-Received: by 2002:a05:6000:2289:b0:3a5:2182:bce2 with SMTP id
 ffacd0b85a97d-3a568670d35mr3093142f8f.17.1749819772004; 
 Fri, 13 Jun 2025 06:02:52 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b087f8sm2338302f8f.53.2025.06.13.06.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:02:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	tanishdesai37@gmail.com
Subject: [PATCH 1/2] rust: prepare variable definitions for multiple bindgen
 invocations
Date: Fri, 13 Jun 2025 15:02:48 +0200
Message-ID: <20250613130249.1225545-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613130249.1225545-1-pbonzini@redhat.com>
References: <20250613130249.1225545-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When splitting the QEMU Rust bindings into multiple crates, the
bindgen-generated structs also have to be split so that it's
possible to add "impl" blocks (e.g. for Sync/Send or Default,
or even for utility methods in cases such as VMStateFlags).

Tweak various variable definitions in meson.build, to avoid naming
conflicts once there will be multiple bindgen invocations.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build               | 21 ++++++++++++---------
 rust/meson.build          |  2 +-
 rust/qemu-api/meson.build |  2 +-
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/meson.build b/meson.build
index ed60be2a2d0..d9838319dae 100644
--- a/meson.build
+++ b/meson.build
@@ -4200,10 +4200,11 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
 endforeach
 
 if have_rust
+  bindings_incdir = include_directories('.', 'include')
   # We would like to use --generate-cstr, but it is only available
   # starting with bindgen 0.66.0.  The oldest supported versions
   # is 0.60.x (Debian 12 has 0.60.1) which introduces --allowlist-file.
-  bindgen_args = [
+  bindgen_args_common = [
     '--disable-header-comment',
     '--raw-line', '// @generated',
     '--ctypes-prefix', 'std::os::raw',
@@ -4219,20 +4220,22 @@ if have_rust
     ]
   if not rustfmt.found()
     if bindgen.version().version_compare('<0.65.0')
-      bindgen_args += ['--no-rustfmt-bindings']
+      bindgen_args_common += ['--no-rustfmt-bindings']
     else
-      bindgen_args += ['--formatter', 'none']
+      bindgen_args_common += ['--formatter', 'none']
     endif
   endif
   if bindgen.version().version_compare('>=0.66.0')
-    bindgen_args += ['--rust-target', '1.59']
+    bindgen_args_common += ['--rust-target', '1.59']
   endif
   if bindgen.version().version_compare('<0.61.0')
     # default in 0.61+
-    bindgen_args += ['--size_t-is-usize']
+    bindgen_args_common += ['--size_t-is-usize']
   else
-    bindgen_args += ['--merge-extern-blocks']
+    bindgen_args_common += ['--merge-extern-blocks']
   endif
+
+  bindgen_args = []
   c_enums = [
     'DeviceCategory',
     'GpioPolarity',
@@ -4264,13 +4267,13 @@ if have_rust
   # this case you must pass the path to `clang` and `libclang` to your build
   # command invocation using the environment variables CLANG_PATH and
   # LIBCLANG_PATH
-  bindings_rs = rust.bindgen(
+  _qemu_api_bindings_inc_rs = rust.bindgen(
     input: 'rust/wrapper.h',
     dependencies: common_ss.all_dependencies(),
     output: 'bindings.inc.rs',
-    include_directories: include_directories('.', 'include'),
+    include_directories: bindings_incdir,
     bindgen_version: ['>=0.60.0'],
-    args: bindgen_args,
+    args: bindgen_args_common + bindgen_args,
     )
   subdir('rust')
 endif
diff --git a/rust/meson.build b/rust/meson.build
index 99ae7956cd0..e9f0879e296 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -33,5 +33,5 @@ if cargo.found()
     command: [config_host['MESON'], 'devenv',
               '--workdir', '@CURRENT_SOURCE_DIR@',
               cargo, 'fmt'],
-    depends: bindings_rs)
+    depends: _qemu_api_bindings_inc_rs)
 endif
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 33653b4a28e..64c04dfd74b 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -32,7 +32,7 @@ _qemu_api_rs = static_library(
       'src/vmstate.rs',
       'src/zeroable.rs',
     ],
-    {'.' : bindings_rs},
+    {'.' : _qemu_api_bindings_inc_rs},
   ),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
-- 
2.49.0


