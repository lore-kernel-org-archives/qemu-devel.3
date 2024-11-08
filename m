Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA0CD64072
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 18:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9TJ2-0001pI-55; Fri, 08 Nov 2024 13:02:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9TIw-0001o5-7F
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 13:01:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9TIu-0001v4-G1
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 13:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731088911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eX7uUTJtFkCsP2+rTSsbiyuX9JxoUOb2ob7tcl3vQYY=;
 b=LxFgeZFrGDlfyKMGivTcd+X5OOratG+RcehuJDuWrrHrrOchlI8YAOwVSiA8Ci+4QV+CzR
 93GgImHw/BZzub18J+RWiSM2c/jkGoKF+nO82SVXfFM7GOKycUgpBEpzwrcudJ9a/3q6jC
 zu2SH6Ll+hDiu+eoyofNUvRCPxLGrps=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-espbQXhHPrKlaL6u3Bwkzg-1; Fri, 08 Nov 2024 13:01:50 -0500
X-MC-Unique: espbQXhHPrKlaL6u3Bwkzg-1
X-Mimecast-MFC-AGG-ID: espbQXhHPrKlaL6u3Bwkzg
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315afcae6cso14195875e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 10:01:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731088908; x=1731693708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eX7uUTJtFkCsP2+rTSsbiyuX9JxoUOb2ob7tcl3vQYY=;
 b=DidVcYlzsjC/VGR2/jlMwrE7Y1KUywiHYysIEhN4thZ0Z7ieQMH3oYpieAAM8WD4kq
 T2gWk6Qx8jiKtiWjG4G3HE/NzynOojQ61IL4dVLhCW2aFo0xYFqSjYNVBbaeIcUSI1zz
 QX3hKWkNBY84vhcQvJTqVBmYHcN0i08fCoNwOS5uWPy96bjkccM35XsDrqTeVnXY6cGg
 UZhUXBuZtdE9KludSBqsK8wGxczMeFRICJZrPl5aN3AEyj80CunQqj+Ep9O9qODhcbGC
 lxKiaZ3qurdvzLINU+dbUWiPhcI1FLvnRcsuDg9wSnwlL/1kPQ34DoyLzOTkhtIWqzzu
 62jg==
X-Gm-Message-State: AOJu0YzGoHygYoL+hlJpxN0g7OBBxii89+hmX/zj5+ZL1jhKwMhSAA6i
 FXO6bYaQfT1mSGijLodFoZuCUIvsU+rrVm+dutaA5vLBhRylXfNa6YZDX045gmpq/T0YsKQog6b
 LJi8PDXpL+RtLFCyBJONApBg3fcV/a9uC3kkUTGR6NvyMzlaEOFNIMTIf5gKrstuaFg3+rBmJYy
 bpEO1as/tJRNJEEHi5pXg7cXlJxuf47u5U/XIV0tw=
X-Received: by 2002:a05:600c:35c9:b0:431:4e33:98b6 with SMTP id
 5b1f17b1804b1-432b744eb43mr33058135e9.5.1731088908385; 
 Fri, 08 Nov 2024 10:01:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFwtqVHHAOdjFWs6lX6Rk2Gc37fRg1QVcCrWVI39JEvaYjJc0xice8UqHMPWJbQl6S1+99xw==
X-Received: by 2002:a05:600c:35c9:b0:431:4e33:98b6 with SMTP id
 5b1f17b1804b1-432b744eb43mr33057545e9.5.1731088907740; 
 Fri, 08 Nov 2024 10:01:47 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa70a23fsm121326055e9.33.2024.11.08.10.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 10:01:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, kwolf@redhat.com, junjie.mao@hotmail.com,
 zhao1.liu@intel.com, qemu-rust@nondevel.org
Subject: [RFC PATCH 02/11] rust: build: move rustc_args.py invocation to
 individual crates
Date: Fri,  8 Nov 2024 19:01:30 +0100
Message-ID: <20241108180139.117112-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108180139.117112-1-pbonzini@redhat.com>
References: <20241108180139.117112-1-pbonzini@redhat.com>
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

Only qemu-api needs access to the symbols in config-host.h.  Remove
the temptation to use them by limiting the --cfg arguments to the
qemu-api crate.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build               | 54 +++++++++++++++++----------------------
 rust/qemu-api/meson.build |  4 +++
 2 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/meson.build b/meson.build
index a7342c6edbd..7a9a523467b 100644
--- a/meson.build
+++ b/meson.build
@@ -120,7 +120,29 @@ if have_rust
 endif
 
 if have_rust
+  rustc_args = find_program('scripts/rust/rustc_args.py')
   rustfmt = find_program('rustfmt', required: false)
+
+  # Prohibit code that is forbidden in Rust 2024
+  rustc_lint_args = ['-D', 'unsafe_op_in_unsafe_fn']
+
+  # Occasionally, we may need to silence warnings and clippy lints that
+  # were only introduced in newer Rust compiler versions.  Do not croak
+  # in that case; a CI job with rust_strict_lints == true ensures that
+  # we do not have misspelled allow() attributes.
+  if not get_option('strict_rust_lints')
+    rustc_lint_args += ['-A', 'unknown_lints']
+  endif
+
+  # Apart from procedural macros, our Rust executables will often link
+  # with C code, so include all the libraries that C code needs.  This
+  # is safe; https://github.com/rust-lang/rust/pull/54675 says that
+  # passing -nodefaultlibs to the linker "was more ideological to
+  # start with than anything".
+  add_project_arguments(rustc_lint_args + ['-C', 'default-linker-libraries'],
+      native: false, language: 'rust')
+
+  add_project_arguments(rustc_lint_args, native: true, language: 'rust')
 endif
 
 dtrace = not_found
@@ -3399,36 +3421,8 @@ endif
 # Generated sources #
 #####################
 
-genh += configure_file(output: 'config-host.h', configuration: config_host_data)
-
-if have_rust
-  rustc_args = run_command(
-    find_program('scripts/rust/rustc_args.py'),
-    '--config-headers', meson.project_build_root() / 'config-host.h',
-    capture : true,
-    check: true).stdout().strip().split()
-
-  # Prohibit code that is forbidden in Rust 2024
-  rustc_args += ['-D', 'unsafe_op_in_unsafe_fn']
-
-  # Occasionally, we may need to silence warnings and clippy lints that
-  # were only introduced in newer Rust compiler versions.  Do not croak
-  # in that case; a CI job with rust_strict_lints == true ensures that
-  # we do not have misspelled allow() attributes.
-  if not get_option('strict_rust_lints')
-    rustc_args += ['-A', 'unknown_lints']
-  endif
-
-  # Apart from procedural macros, our Rust executables will often link
-  # with C code, so include all the libraries that C code needs.  This
-  # is safe; https://github.com/rust-lang/rust/pull/54675 says that
-  # passing -nodefaultlibs to the linker "was more ideological to
-  # start with than anything".
-  add_project_arguments(rustc_args + ['-C', 'default-linker-libraries'],
-      native: false, language: 'rust')
-
-  add_project_arguments(rustc_args, native: true, language: 'rust')
-endif
+config_host_h = configure_file(output: 'config-host.h', configuration: config_host_data)
+genh += config_host_h
 
 hxtool = find_program('scripts/hxtool')
 shaderinclude = find_program('scripts/shaderinclude.py')
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index e3870e901e3..f84f85b88c6 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -4,6 +4,10 @@ if rustc.version().version_compare('>=1.77.0')
   _qemu_api_cfg += ['--cfg', 'has_offset_of']
 endif
 
+_qemu_api_cfg += run_command(rustc_args,
+  '--config-headers', config_host_h,
+  capture: true, check: true).stdout().strip().split()
+
 _qemu_api_rs = static_library(
   'qemu_api',
   structured_sources(
-- 
2.47.0


