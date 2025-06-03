Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C92C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 21:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMZSB-0004up-K8; Tue, 03 Jun 2025 17:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZS7-0004tW-3a
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:45:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZS5-000668-6V
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748987144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bcxJnoz+2En8eWeqkNixpoq4dwRy92+S/WPoZpmcK18=;
 b=CIeV/Q41HCREBMK/NcILLefp+OXwuz1wIYhn4+AUsmOcrGSvRpZSuo0ukobPuc5djCejON
 ve++5xdp49sfaJbVvbW4opAA7lm9e0uNMh2FrRWCgMtrRWDWzEEkLcKC4Orww088Hc/Tx6
 7NH6GvCaIjM9PnSRT57U/OjIXqgU3oI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-ybfj8PJPOYC1pN9R12BSqA-1; Tue, 03 Jun 2025 17:45:43 -0400
X-MC-Unique: ybfj8PJPOYC1pN9R12BSqA-1
X-Mimecast-MFC-AGG-ID: ybfj8PJPOYC1pN9R12BSqA_1748987142
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450cb8ff0c6so29478555e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 14:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748987141; x=1749591941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bcxJnoz+2En8eWeqkNixpoq4dwRy92+S/WPoZpmcK18=;
 b=bmJMq+s/4ePCntZ/lTsJ9NJTMU7H8RHTeCTv25AUIyHSS4HgDIJdcM/XepqeAihvMO
 hKMDdsMyP0kJ/oq7fkuluMJeNxcAOWK0/7dMx5DjeTS2fyhxCJ6U1EpGAbk0l4yhnpnn
 cjSnNWB4hr+ya731vmsWStxLRmytbzOXoYeeHyOCCiuZZ58VdTw2tWk83UuXRul3lx0d
 24qW3MRSXtmauvvfLZHp2e56hdZpout12rtE13OVNDhCC4MIFzECNJkz54avW7uZLOnJ
 6aixjqXCb0X7c6Z6hRVGXEKOmTxZxWDe18lCiBPQaVkMISNc/tnfciLzVVen06fZTed0
 J9/Q==
X-Gm-Message-State: AOJu0YyetZIVdTleb+4xRX2n6x47IiDwI2BNs6tayu90Jbw08znS6Ipn
 UkLt3hUFGfBHQMmCldVmR3MtGTEDQaDvGE4VaIBdXWn0jRxU8aFhu7ydb02sQBii1Nl1mm2xo/C
 eVdvuiLod6FNx4G026qT4SQI30Qlw8iuQx/gmbc3+MpnWtE/ce4+VWtARa+HhaVDW5EaK2jifmL
 ceKL915Schg4xlrPT1FV7Ht0cx1wCueW6w1eVbFYtM
X-Gm-Gg: ASbGncvsd0L524v7cftsWMIpzd2d0jzTrxAjFFsNaWk4igDavmPntCkhJeX7R/3/mKP
 mouMxgrD2go7qMOwreeIQyC457z4KQNWNhJP/WIQztyZqmUMsrLk1e7589A+WXdLdpeKVNs7bzn
 zwJMA3943fFnICXNkf20/KIftNEvQGn6NSprkdiNmb5Og++xjdI4YdxzkyeRYxEJJXISaH39Aa2
 N2j49tBIO+HkHxzHqKIZu+ETGsy1q9sXvdBWvASpjTleuEyAIJH7WQAOiRbMCB//0A6FQibStIj
 WbR7/tnwyho6qg==
X-Received: by 2002:a05:600c:818e:b0:440:6a5f:c308 with SMTP id
 5b1f17b1804b1-451f0a772b1mr2395725e9.13.1748987141309; 
 Tue, 03 Jun 2025 14:45:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPLZPeEJGi1iyEv0ujDosGAydvOhi/wRAW8s+TegKbU3ev18PgHGBKZOxMljbNz8kReRnErw==
X-Received: by 2002:a05:600c:818e:b0:440:6a5f:c308 with SMTP id
 5b1f17b1804b1-451f0a772b1mr2395575e9.13.1748987140520; 
 Tue, 03 Jun 2025 14:45:40 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73eebsm19260493f8f.44.2025.06.03.14.45.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 14:45:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/16] rust: use native Meson support for clippy and rustdoc
Date: Tue,  3 Jun 2025 23:45:14 +0200
Message-ID: <20250603214523.131185-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603214523.131185-1-pbonzini@redhat.com>
References: <20250603214523.131185-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

Meson has support for invoking clippy and rustdoc on all crates (1.7.0 for
clippy, 1.8.0 for rustdoc).  Use it instead of the homegrown version; this
requires disabling the multiple_crate_versions lint (the only one that was
enabled from the "cargo" group)---which was not particularly useful anyway
because all dependencies are converted by hand into Meson subprojects.

rustfmt is still not supported.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst             | 10 +++++++---
 meson.build                     |  2 +-
 rust/clippy.toml => clippy.toml |  2 +-
 rust/Cargo.toml                 |  1 -
 rust/meson.build                | 12 ------------
 scripts/rust/rustc_args.py      |  5 +----
 6 files changed, 10 insertions(+), 22 deletions(-)
 rename rust/clippy.toml => clippy.toml (55%)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index f66f2bef60b..34d9c7945b7 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -37,12 +37,16 @@ output directory (typically ``rust/target/``).  A vanilla invocation
 of Cargo will complain that it cannot find the generated sources,
 which can be fixed in different ways:
 
-* by using special shorthand targets in the QEMU build directory::
+* by using Makefile targets, provided by Meson, that run ``clippy`` or
+  ``rustdoc``:
 
     make clippy
-    make rustfmt
     make rustdoc
 
+A target for ``rustfmt`` is also declared in ``rust/meson.build``:
+
+    make rustfmt
+
 * by invoking ``cargo`` through the Meson `development environment`__
   feature::
 
@@ -50,7 +54,7 @@ which can be fixed in different ways:
     pyvenv/bin/meson devenv -w ../rust cargo fmt
 
   If you are going to use ``cargo`` repeatedly, ``pyvenv/bin/meson devenv``
-  will enter a shell where commands like ``cargo clippy`` just work.
+  will enter a shell where commands like ``cargo fmt`` just work.
 
 __ https://mesonbuild.com/Commands.html#devenv
 
diff --git a/meson.build b/meson.build
index e85b358d637..651bd4f7275 100644
--- a/meson.build
+++ b/meson.build
@@ -4404,7 +4404,7 @@ foreach target : target_dirs
                               build_by_default: true,
                               build_always_stale: true)
       rlib = static_library('rust_' + target.underscorify(),
-                            rlib_rs,
+                            structured_sources([], {'.': rlib_rs}),
                             dependencies: target_rust.dependencies(),
                             override_options: ['rust_std=2021', 'build.rust_std=2021'],
                             rust_abi: 'c')
diff --git a/rust/clippy.toml b/clippy.toml
similarity index 55%
rename from rust/clippy.toml
rename to clippy.toml
index 58a62c0e632..90161729838 100644
--- a/rust/clippy.toml
+++ b/clippy.toml
@@ -1,3 +1,3 @@
-doc-valid-idents = ["PrimeCell", ".."]
+doc-valid-idents = ["IrDA", "PrimeCell", ".."]
 allow-mixed-uninlined-format-args = false
 msrv = "1.77.0"
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index d9faeecb10b..a00b8ad0bcd 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -63,7 +63,6 @@ ignored_unit_patterns = "deny"
 implicit_clone = "deny"
 macro_use_imports = "deny"
 missing_safety_doc = "deny"
-multiple_crate_versions = "deny"
 mut_mut = "deny"
 needless_bitwise_bool = "deny"
 needless_pass_by_ref_mut = "deny"
diff --git a/rust/meson.build b/rust/meson.build
index 801f4374dfa..afce62f4772 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -24,21 +24,9 @@ subdir('hw')
 cargo = find_program('cargo', required: false)
 
 if cargo.found()
-  run_target('clippy',
-    command: [config_host['MESON'], 'devenv',
-              '--workdir', '@CURRENT_SOURCE_DIR@',
-              cargo, 'clippy', '--tests'],
-    depends: bindings_rs)
-
   run_target('rustfmt',
     command: [config_host['MESON'], 'devenv',
               '--workdir', '@CURRENT_SOURCE_DIR@',
               cargo, 'fmt'],
     depends: bindings_rs)
-
-  run_target('rustdoc',
-    command: [config_host['MESON'], 'devenv',
-              '--workdir', '@CURRENT_SOURCE_DIR@',
-              cargo, 'doc', '--no-deps', '--document-private-items'],
-    depends: bindings_rs)
 endif
diff --git a/scripts/rust/rustc_args.py b/scripts/rust/rustc_args.py
index 2633157df2a..63b0748e0d3 100644
--- a/scripts/rust/rustc_args.py
+++ b/scripts/rust/rustc_args.py
@@ -104,10 +104,7 @@ def generate_lint_flags(cargo_toml: CargoTOML, strict_lints: bool) -> Iterable[s
             else:
                 raise Exception(f"invalid level {level} for {prefix}{lint}")
 
-            # This may change if QEMU ever invokes clippy-driver or rustdoc by
-            # hand.  For now, check the syntax but do not add non-rustc lints to
-            # the command line.
-            if k == "rust" and not (strict_lints and lint in STRICT_LINTS):
+            if not (strict_lints and lint in STRICT_LINTS):
                 lint_list.append(LintFlag(flags=[flag, prefix + lint], priority=priority))
 
     if strict_lints:
-- 
2.49.0


