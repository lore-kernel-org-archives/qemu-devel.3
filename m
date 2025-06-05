Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58768C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 10:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7eB-0007VK-Ph; Thu, 05 Jun 2025 06:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7df-0007K4-DH
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7db-0001Dm-Ln
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:15:59 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-mho3YaI9MOahkfcbtABaGA-1; Thu, 05 Jun 2025 06:15:51 -0400
X-MC-Unique: mho3YaI9MOahkfcbtABaGA-1
X-Mimecast-MFC-AGG-ID: mho3YaI9MOahkfcbtABaGA_1749118550
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43e9b0fd00cso4206585e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 03:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749118549; x=1749723349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f/yO9eEjhawAZj65JQFxPuRWg2iLDF9BJAX6Rlp50h8=;
 b=iH3aRD/PfBGmvsP/awgIeDTh7x+XE5MGdjaqaRy4ieRQ9ni0ZCw1ZIF7BEZSaffG0c
 ww/yYn/oWKrKHtITQfzr/69y3bEWV05RGvE8PAdK0l36JQ6jgCM+aikK/kNfoWddVZAO
 A0AXU57KAdfkayXOrrQcxOZhQU7SAJtTSdUzJra5wUYcn25IcQxAX9VJtM8Xpr6tivmS
 jQC6oNS2YawM6fPVuK3nvI0dI4OBAyy4RzGBs/6fvUxLtDkpZWv0C5RmUHPtOEBx9q+C
 Pd7TFW8LMYFvzfuz1j77ZJBwCHTX4BMz+pYCl2e//lkNNlINmODQM0MQQHDDoPxgROlt
 9ZVg==
X-Gm-Message-State: AOJu0Yz8ytzO5Nzl0V/T6S78diz6AtrlJi3G9Qkcc+sgP3cKJO9pNlQi
 3yfmK9EhoMZeLpCFpVUfOFl4+LgtAJV8nvYFQXZatQFwdWI2uXD2BKrq5Ql6lza6XRJTX3PCDjS
 x7VCIKd757JoQ5DJtSGXRRigMtk+euiuITB6q1bq3U3KyorzMX8J5Iyi6zlPBgx7w4By7DyBxLN
 x+wlDbY+rgmdj3cL8XWtEeloepkSLDmhM95oyZG7aY
X-Gm-Gg: ASbGnctKBREs+ydSXTLkbksn6G0+MIyY1yz4+cExN5rm+Prn6gtFpPUH6N4vAbAI2Q/
 Av5WUBhc97IqQytgY44FbYTMK1y8Qcu61S6NgLkgt4rb4I2ZsRBmgMAiXrw8DpjJ89oVtGNWLzK
 +UJU94TgXuP1TsI5B6xHfhEMqDromAXwlQfs9VmlbfcscO24qqjiy737s9GdwHwFd3SjlbjnmGo
 xJM3s/bBqg3TriIb1c/aoiX+jWpilD2uyJJrg4OYZFRS8c5Jmap3BJQo/JIDVMBOTQXTgyDwxcg
 q0IA9lZRjufBXA==
X-Received: by 2002:a05:600c:1c92:b0:441:d228:3a07 with SMTP id
 5b1f17b1804b1-451f88bead1mr29144885e9.13.1749118549250; 
 Thu, 05 Jun 2025 03:15:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEsdXK4rZSelkjyTujofrcxEbYO92HN5R3iXK9tE9qPwXNi8myDozictQvkYTMZ7Y93GJlIQ==
X-Received: by 2002:a05:600c:1c92:b0:441:d228:3a07 with SMTP id
 5b1f17b1804b1-451f88bead1mr29144455e9.13.1749118548756; 
 Thu, 05 Jun 2025 03:15:48 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451fb208ad0sm13536905e9.24.2025.06.05.03.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 03:15:46 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	zhao1.liu@intel.com,
	qemu-rust@nongnu.org
Subject: [PATCH 01/14] subprojects: add the anyhow crate
Date: Thu,  5 Jun 2025 12:15:30 +0200
Message-ID: <20250605101544.368953-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605101544.368953-1-pbonzini@redhat.com>
References: <20250605101544.368953-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Paolo Bonzini <pbonzini@redhat.com>
From:  Paolo Bonzini via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is a standard replacement for Box<dyn Error> which is more efficient (it only
occcupies one word) and provides a backtrace of the error.  This could be plumbed
into &error_abort in the future.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/meson.build                              |  2 ++
 rust/qemu-api/meson.build                     |  2 +-
 scripts/archive-source.sh                     |  2 +-
 scripts/make-release                          |  2 +-
 subprojects/.gitignore                        |  1 +
 subprojects/anyhow-1-rs.wrap                  |  7 ++++
 .../packagefiles/anyhow-1.0-rs/meson.build    | 33 +++++++++++++++++++
 7 files changed, 46 insertions(+), 3 deletions(-)
 create mode 100644 subprojects/anyhow-1-rs.wrap
 create mode 100644 subprojects/packagefiles/anyhow-1.0-rs/meson.build

diff --git a/rust/meson.build b/rust/meson.build
index b1b3315be97..f752a064649 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -1,7 +1,9 @@
+subproject('anyhow-1-rs', required: true)
 subproject('bilge-0.2-rs', required: true)
 subproject('bilge-impl-0.2-rs', required: true)
 subproject('libc-0.2-rs', required: true)
 
+anyhow_rs = dependency('anyhow-1-rs')
 bilge_rs = dependency('bilge-0.2-rs')
 bilge_impl_rs = dependency('bilge-impl-0.2-rs')
 libc_rs = dependency('libc-0.2-rs')
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index b532281e8c0..da70720e4c1 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -35,7 +35,7 @@ _qemu_api_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
-  dependencies: [libc_rs, qemu_api_macros, qemuutil_rs,
+  dependencies: [anyhow_rs, libc_rs, qemu_api_macros, qemuutil_rs,
                  qom, hwcore, chardev, migration],
 )
 
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index e461c1531ed..816062fee94 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -27,7 +27,7 @@ sub_file="${sub_tdir}/submodule.tar"
 # in their checkout, because the build environment is completely
 # different to the host OS.
 subprojects="keycodemapdb libvfio-user berkeley-softfloat-3
-  berkeley-testfloat-3 arbitrary-int-1-rs bilge-0.2-rs
+  berkeley-testfloat-3 anyhow-1-rs arbitrary-int-1-rs bilge-0.2-rs
   bilge-impl-0.2-rs either-1-rs itertools-0.11-rs libc-0.2-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
   syn-2-rs unicode-ident-1-rs"
diff --git a/scripts/make-release b/scripts/make-release
index 8c3594a1a47..ea65bdcc0cf 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -40,7 +40,7 @@ fi
 
 # Only include wraps that are invoked with subproject()
 SUBPROJECTS="libvfio-user keycodemapdb berkeley-softfloat-3
-  berkeley-testfloat-3 arbitrary-int-1-rs bilge-0.2-rs
+  berkeley-testfloat-3 anyhow-1-rs arbitrary-int-1-rs bilge-0.2-rs
   bilge-impl-0.2-rs either-1-rs itertools-0.11-rs libc-0.2-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
   syn-2-rs unicode-ident-1-rs"
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index d12d34618cc..b9ae507b85a 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -6,6 +6,7 @@
 /keycodemapdb
 /libvfio-user
 /slirp
+/anyhow-1.0.98
 /arbitrary-int-1.2.7
 /bilge-0.2.0
 /bilge-impl-0.2.0
diff --git a/subprojects/anyhow-1-rs.wrap b/subprojects/anyhow-1-rs.wrap
new file mode 100644
index 00000000000..a69a3645b49
--- /dev/null
+++ b/subprojects/anyhow-1-rs.wrap
@@ -0,0 +1,7 @@
+[wrap-file]
+directory = anyhow-1.0.98
+source_url = https://crates.io/api/v1/crates/anyhow/1.0.98/download
+source_filename = anyhow-1.0.98.tar.gz
+source_hash = e16d2d3311acee920a9eb8d33b8cbc1787ce4a264e85f964c2404b969bdcd487
+#method = cargo
+patch_directory = anyhow-1-rs
diff --git a/subprojects/packagefiles/anyhow-1.0-rs/meson.build b/subprojects/packagefiles/anyhow-1.0-rs/meson.build
new file mode 100644
index 00000000000..348bab98b9f
--- /dev/null
+++ b/subprojects/packagefiles/anyhow-1.0-rs/meson.build
@@ -0,0 +1,33 @@
+project('anyhow-1-rs', 'rust',
+  meson_version: '>=1.5.0',
+  version: '1.0.98',
+  license: 'MIT OR Apache-2.0',
+  default_options: [])
+
+rustc = meson.get_compiler('rust')
+
+rust_args = ['--cap-lints', 'allow']
+rust_args += ['--cfg', 'feature="std"']
+if rustc.version().version_compare('<1.65.0')
+  error('rustc version ' + rustc.version() + ' is unsupported. Please upgrade to at least 1.65.0')
+endif
+rust_args += [ '--cfg', 'std_backtrace' ] # >= 1.65.0
+if rustc.version().version_compare('<1.81.0')
+  rust_args += [ '--cfg', 'anyhow_no_core_error' ]
+endif
+
+_anyhow_rs = static_library(
+  'anyhow',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2018', 'build.rust_std=2018'],
+  rust_abi: 'rust',
+  rust_args: rust_args,
+  dependencies: [],
+)
+
+anyhow_dep = declare_dependency(
+  link_with: _anyhow_rs,
+)
+
+meson.override_dependency('anyhow-1-rs', anyhow_dep)
-- 
2.49.0


