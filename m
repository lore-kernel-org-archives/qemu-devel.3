Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD2DC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 17:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJxj2-0005ix-5k; Tue, 27 May 2025 13:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJxj0-0005i1-0F
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:04:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJxix-0006hv-Rc
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748365462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P6BB7ST9HP5gqI17reXXLVec4z+t3iB9vyB2FO/CtT0=;
 b=FptTtA1d/mfNG7fWFjkNEhU03ga4+ALdavBd87z+XX9969rZDQTmlrl74LBUiUrIU0rJ7G
 X+L2whSWwDw2ZavHxxSgFquy+wQPmv6sTR10WRamAwi1HinlXWe9sYy56q2zkrA1ahLgeZ
 jead0q2zBP4jQMPW1SUApKZIyf5gMyw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-HszxVJTNOTeDSoefTFpboQ-1; Tue, 27 May 2025 13:04:21 -0400
X-MC-Unique: HszxVJTNOTeDSoefTFpboQ-1
X-Mimecast-MFC-AGG-ID: HszxVJTNOTeDSoefTFpboQ_1748365460
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-60211a1705dso3027287a12.2
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 10:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748365460; x=1748970260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P6BB7ST9HP5gqI17reXXLVec4z+t3iB9vyB2FO/CtT0=;
 b=F64aBTqeHa4lgiIfOOMeuUDOkS/i/56OLOtQVEj+wIaDtEP9EYWr+Aq49sLTgyJvqv
 Q2QRT30/HT8e5VMe4ixfYMdVdvV/la/JWqlN0TUfe2/C1+6UaLB4l8U696lod4Rd/w2d
 TCfuOLdVcHkb8/HcnYl7TNeWz/l0RtfhLy1QK3sffichwDtgDbGnaJoPnHeisIRfTO2E
 Sia7cdyPaz6IV1K1xfD5e2v3zVo+xyjiTX88PzL81MQJRI+5EMfcZ406wdSqtIeaD7XI
 V1qpq9945ZoGdj6N0vdbRgdTYz5cyiWFU8C+Vi+4SiMCKcOFqZxJI/f3yNa1zuSOdKUH
 T2JQ==
X-Gm-Message-State: AOJu0YwkW+5kZBDGCDJqzo/dmhvVul3nKu2Jx9OJdKMKCdNmoNwcL3U/
 Qs9ACEfkf+4v/4/VqnZ2ddCCSEvOXHdT+oNcDXbXnfVu1TyC6l1Z4y53R37WQ7RemRRA16+MTC9
 Oqn91xW/j02xfWPtTUog+DkQlg6Lv13m+SQ1oLCGT5N9c7AEfWa6PqMUDeN2tmYKzPyle8T5PaA
 iIZkIgkclF33TYEaufXOqSkRwh0tHLTN5VZkM6HpRi
X-Gm-Gg: ASbGncums4zGbHqJQqPxcOKIp3jWib0cghEgjOb9ShoMKO4O95O49Rg7CIldwleUX0e
 1ilCFfByk6H+ZFWomy4i8Y5J7Hs4GRd6cbk2YPQa1oBVdogW6L6o1yzWTur9ke6mM45m5Lm/lQ5
 Lf4FJY17mlZazfTyyboTwUahycROGjjw4YL9el49pjPvw5Zw2qLwRdc2e8DHZhRDP+YQILT0Bh0
 OE52poLvtpMVyaAjdyJwmkzvlglp+TCZzgnVqoirRG71qNB9symq5aJoPdyUgBFv29MhCdZNk27
 zVLUZaPsgr5jng==
X-Received: by 2002:a05:6402:2354:b0:601:8481:3268 with SMTP id
 4fb4d7f45d1cf-602da2ff018mr12008990a12.25.1748365459626; 
 Tue, 27 May 2025 10:04:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH78Hl6IYFrs5GnznkMwRL8X4s61IWZCk1B6DoLZVPiV6jiEuIZ0pwQaCHPyaxafUmu0i2cNw==
X-Received: by 2002:a05:6402:2354:b0:601:8481:3268 with SMTP id
 4fb4d7f45d1cf-602da2ff018mr12008924a12.25.1748365458908; 
 Tue, 27 May 2025 10:04:18 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6035a134d4bsm5154717a12.20.2025.05.27.10.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 10:04:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 6/6] rust: use native Meson support for clippy and rustdoc
Date: Tue, 27 May 2025 19:04:04 +0200
Message-ID: <20250527170404.1580482-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527170404.1580482-1-pbonzini@redhat.com>
References: <20250527170404.1580482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 rust/clippy.toml => clippy.toml |  0
 rust/Cargo.toml                 |  1 -
 rust/meson.build                | 12 ------------
 scripts/rust/rustc_args.py      |  5 +----
 6 files changed, 9 insertions(+), 21 deletions(-)
 rename rust/clippy.toml => clippy.toml (100%)

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
index eebd74b1fce..6f6d743a7d8 100644
--- a/meson.build
+++ b/meson.build
@@ -4376,7 +4376,7 @@ foreach target : target_dirs
                               build_by_default: true,
                               build_always_stale: true)
       rlib = static_library('rust_' + target.underscorify(),
-                            rlib_rs,
+                            structured_sources([], {'.': rlib_rs}),
                             dependencies: target_rust.dependencies(),
                             override_options: ['rust_std=2021', 'build.rust_std=2021'],
                             rust_abi: 'c')
diff --git a/rust/clippy.toml b/clippy.toml
similarity index 100%
rename from rust/clippy.toml
rename to clippy.toml
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


