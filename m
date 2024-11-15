Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BACD68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBzNk-0006Ys-Nr; Fri, 15 Nov 2024 11:41:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBzNF-0006Er-7i
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:40:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBzND-0002Jd-Ex
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:40:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731688842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HbWA/NqYdtTCVn8KZ9HlSCULmXdgsjBOnjTg7LOXBL8=;
 b=LMqKWAB+cyXZxy8qpAOqrnXAEjeilqqJ7cvzNohogatgggtU7oLQ4m+jmkWMUaIVHLseF9
 /KslMAAsGdO5+a7mveJ36qq6wULnBnpqshnxzQlFzltP1sPWe8osd6n35tOu1qJpaRKxcm
 5lGL5yYQzlq2s2nQe9/XKtpAaMd8BbA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-WumHOI_KM_mF-tzcfL1nAg-1; Fri, 15 Nov 2024 11:40:40 -0500
X-MC-Unique: WumHOI_KM_mF-tzcfL1nAg-1
X-Mimecast-MFC-AGG-ID: WumHOI_KM_mF-tzcfL1nAg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d531a19a9so531979f8f.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 08:40:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731688838; x=1732293638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HbWA/NqYdtTCVn8KZ9HlSCULmXdgsjBOnjTg7LOXBL8=;
 b=ZdCXMrgDwqyEPZlBCxilu1KDOdTEqa3t9Vv/b14wHNKOiC/4bvnGieHUGF5v12oy7w
 plbeS/z4SqRwSXdB8dp81hnaoWuIgYeVIPpt/93Tm7tf5D0U9WAkFcpJQ34zj1c70DzC
 VOKTgyu6KJR5b07DZ/W17YH/4JOMzU8+5au+BToLOWyrSg7OzxW6U53eGmkWGDCeCtOJ
 0rf3a/5oKOORWPDypU7I+LAImGyHq+J5j8o1FJIuZFSI9Yzd3agdExh+UmTbNyhiSJ0Q
 SYbZG0xJS416Yo8jWSFnLioMU/mLdn2aQ6BEmKQNFNXb3w+CElJZr5omzxRTLgvd3YLv
 9nTw==
X-Gm-Message-State: AOJu0YzLhK/ZOpNNcSUu3weEVkBwX98YtzWs91WP3xv3L8P0fEkZCoLh
 Kz44PZpQ2xla/mpIJSHGTG1MwxitbsZ7NpyqsDmwiqR8lCHUjvL3rpvxRhUaDPi45WOzdZ3G+44
 UoWlkKRi4XRfFy8TSIjThkHqXEARpKJivq9nzNkcDBVSK82qZAkgA3LLM61VrbdMnvayaKtYodB
 gPc3XqdDwE3D3Hh7HTjgu+opFJ0+KVTvl1pwrt6SE=
X-Received: by 2002:a5d:5988:0:b0:37c:cc67:8b1f with SMTP id
 ffacd0b85a97d-38225aaef32mr2844830f8f.48.1731688838395; 
 Fri, 15 Nov 2024 08:40:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOggsLwRV/smU53pSVTKPtU3W4+VGJ3TX8Z5EHHjcW70P0zNZljTV0CQojkcMUM/6/O0moWg==
X-Received: by 2002:a5d:5988:0:b0:37c:cc67:8b1f with SMTP id
 ffacd0b85a97d-38225aaef32mr2844805f8f.48.1731688837987; 
 Fri, 15 Nov 2024 08:40:37 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae3101fsm4751409f8f.92.2024.11.15.08.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 08:40:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, berrange@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org, kwolf@redhat.com
Subject: [PATCH 03/12] rust: build: move rustc_args.py invocation to qemu-api
 crate
Date: Fri, 15 Nov 2024 17:40:16 +0100
Message-ID: <20241115164025.1917618-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115163944.1917393-1-pbonzini@redhat.com>
References: <20241115163944.1917393-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.658,
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

Only qemu-api needs access to the symbols in config-host.h.  Remove
the temptation to use them elsewhere by limiting the --cfg arguments to
the qemu-api crate.

Per-crate invocation of the script will also be needed to add --check-cfg
options for each crate's features (when more complex, build-time
configurable devices are added in the future).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build               | 56 +++++++++++++++++----------------------
 rust/qemu-api/meson.build |  5 +++-
 2 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/meson.build b/meson.build
index 8def5f67bb5..b51add16d2f 100644
--- a/meson.build
+++ b/meson.build
@@ -120,7 +120,30 @@ if have_rust
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
+  add_project_arguments(rustc_lint_args +
+      ['--cfg', 'MESON', '-C', 'default-linker-libraries'],
+      native: false, language: 'rust')
+  add_project_arguments(rustc_lint_args + ['--cfg', 'MESON'],
+      native: true, language: 'rust')
 endif
 
 dtrace = not_found
@@ -3399,37 +3422,8 @@ endif
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
-  add_project_arguments(rustc_args +
-      ['--cfg', 'MESON', '-C', 'default-linker-libraries'],
-      native: false, language: 'rust')
-  add_project_arguments(rustc_args + ['--cfg', 'MESON'],
-      native: true, language: 'rust')
-endif
+config_host_h = configure_file(output: 'config-host.h', configuration: config_host_data)
+genh += config_host_h
 
 hxtool = find_program('scripts/hxtool')
 shaderinclude = find_program('scripts/shaderinclude.py')
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 3be7b7e5ced..5df6b35bf88 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -1,4 +1,7 @@
-_qemu_api_cfg = []
+_qemu_api_cfg = run_command(rustc_args,
+  '--config-headers', config_host_h,
+  capture: true, check: true).stdout().strip().split()
+
 # _qemu_api_cfg += ['--cfg', 'feature="allocator"']
 if rustc.version().version_compare('>=1.77.0')
   _qemu_api_cfg += ['--cfg', 'has_offset_of']
-- 
2.47.0


