Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425CFCAC5B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LoR-0004dO-Oo; Wed, 24 Sep 2025 05:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LoP-0004cr-Px
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LoE-0004ll-CC
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4J9lM6M2NH6+IBy5oZZhi7qe3sJv/LOLw1XFzXMwbNc=;
 b=gHBgRBh4KQAcTf62FtLQvUhjnm4vpRGl/vfYFiTGlvxDb9GGmQ2wemp9zFhWi5ruEjsTep
 q4esAbuNL6jxu5KOOIYmbIw/0AkIXgaIzkltkU0u0A52tBXoTUqc2y4HFc0bfe0vte5A+l
 1h5da82AQFoLfCJnObCCEKr3xzs9jpI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-3rvgeYAFMqKSbzowkChNEw-1; Wed, 24 Sep 2025 05:29:07 -0400
X-MC-Unique: 3rvgeYAFMqKSbzowkChNEw-1
X-Mimecast-MFC-AGG-ID: 3rvgeYAFMqKSbzowkChNEw_1758706146
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-631dbb59345so5553742a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706145; x=1759310945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4J9lM6M2NH6+IBy5oZZhi7qe3sJv/LOLw1XFzXMwbNc=;
 b=j06J7g2+jPETuN4ZGYHPSgJuf7RL7wdbLK7Y6I0cU5wQd2qAnhyDfY3maSmWYRvCJ5
 /TbW1CycaGGWPYSn+82AKVLca/CLJAwIxsbH2y+9GtgWK8vM2NEBnddZ6/hm2WtMj/r2
 +j9rl1+jNNJcHXeeqZKXPspXf7Ad5B+mkvcySd65QWNDI/IZtkrtMC2xMcdjyFB/Evxr
 RxKxMxiroGTZ1x3+GQrB17PpDjOyRPGHQLP4AfYlAigCHwXU1TePiwdmP4UgAJRCe0/Q
 Zr7IWSilkncB4qVKgUGJFDt8HCu+03MqNKjB7Is9BL+ghqch5UZRGqFgMSdaMO78KwvG
 /Zlg==
X-Gm-Message-State: AOJu0Ywh0t5Bu5ysofj5Jt/EHckk9VNUb3w+0lEK97MWDg5RSqv8uroi
 edRYNSNzqBVG+wMSCLP2jpmSN7Qj1/duxSTCwwy+k8pdE7svE+CJ5ykbvYQyFAt7sw/jhrFKCZS
 Sfu/6jTEBQOocD0rRtohTYjXiko+9PkoLHEkKNitNowfzV0/mUeq7WqfyJ6NhPVFgPVQZjkkHLE
 B73uxlkmNBxt7AWuAlnIxJlVrD3LfXfbwew2NNYPSp
X-Gm-Gg: ASbGnctrlzeIsMxXzs+8LfO7mlS77Gvyo3tUm618loWqM689Dp5tyOeRD4iX7+wJFck
 NadvCCOj258+jmM5d4eEJEvMEP6dqUKS0inhPu7JefT7KMoQwGngiuMtVynNV6RfCAiBzGmPhyR
 lE6zcRVLjWk190AgtqI+mX3BSV2Gywd6Qdd84SeX4OF0JVaHInW48fBYW4PyEwM2GHwssfXQUCA
 j1UszfXFWhUBgalcOF0Klv/yGA98VCctLsFjihxnHMS8UzACaPxz/lmTyKWD97dZMHsf2GGX7Rd
 EqZOHp4fqJqfCSXLe+ONV0l4ta8/9RzL/0ITTHlZNLYv9MQGXO7P5wkiTSzfMRuXr4Ilf8wOH/4
 qWJrSeDlHhSIQZvkWB9ZS0QaOKyeFWeo4kMgW1+J8IGfZ0A==
X-Received: by 2002:a05:6402:505a:b0:62f:65f5:a8cd with SMTP id
 4fb4d7f45d1cf-63467679abamr4666552a12.7.1758706145313; 
 Wed, 24 Sep 2025 02:29:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvcC8bkXEj/h60ZkLfx+nh+e6fwJ3ON1CaVmstnBdpVSz8tjJ6xPKUf2NaNIaJWQdAihqaqg==
X-Received: by 2002:a05:6402:505a:b0:62f:65f5:a8cd with SMTP id
 4fb4d7f45d1cf-63467679abamr4666530a12.7.1758706144716; 
 Wed, 24 Sep 2025 02:29:04 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6347788dc8bsm1688110a12.9.2025.09.24.02.29.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:29:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/29] subprojects: add attrs crate
Date: Wed, 24 Sep 2025 11:28:25 +0200
Message-ID: <20250924092850.42047-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The attrs crate is a simple combinator-based for Rust attributes.  It
will be used instead of a handwritten parser.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/meson.build                              |  2 ++
 rust/qemu-macros/Cargo.toml                   |  1 +
 rust/qemu-macros/meson.build                  |  1 +
 scripts/archive-source.sh                     |  2 +-
 scripts/make-release                          |  2 +-
 subprojects/.gitignore                        |  1 +
 subprojects/attrs-0.2-rs.wrap                 |  7 ++++
 .../packagefiles/attrs-0.2-rs/meson.build     | 33 +++++++++++++++++++
 8 files changed, 47 insertions(+), 2 deletions(-)
 create mode 100644 subprojects/attrs-0.2-rs.wrap
 create mode 100644 subprojects/packagefiles/attrs-0.2-rs/meson.build

diff --git a/rust/meson.build b/rust/meson.build
index c7bd6aba45f..b3ac3a71970 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -13,10 +13,12 @@ libc_rs = dependency('libc-0.2-rs')
 subproject('proc-macro2-1-rs', required: true)
 subproject('quote-1-rs', required: true)
 subproject('syn-2-rs', required: true)
+subproject('attrs-0.2-rs', required: true)
 
 quote_rs_native = dependency('quote-1-rs', native: true)
 syn_rs_native = dependency('syn-2-rs', native: true)
 proc_macro2_rs_native = dependency('proc-macro2-1-rs', native: true)
+attrs_rs_native = dependency('attrs-0.2-rs', native: true)
 
 genrs = []
 
diff --git a/rust/qemu-macros/Cargo.toml b/rust/qemu-macros/Cargo.toml
index 3b6f1d337f8..c25b6c0b0da 100644
--- a/rust/qemu-macros/Cargo.toml
+++ b/rust/qemu-macros/Cargo.toml
@@ -16,6 +16,7 @@ rust-version.workspace = true
 proc-macro = true
 
 [dependencies]
+attrs = "0.2.9"
 proc-macro2 = "1"
 quote = "1"
 syn = { version = "2", features = ["extra-traits"] }
diff --git a/rust/qemu-macros/meson.build b/rust/qemu-macros/meson.build
index d0b2992e204..0f27e0df925 100644
--- a/rust/qemu-macros/meson.build
+++ b/rust/qemu-macros/meson.build
@@ -8,6 +8,7 @@ _qemu_macros_rs = rust.proc_macro(
     '--cfg', 'feature="proc-macro"',
   ],
   dependencies: [
+    attrs_rs_native,
     proc_macro2_rs_native,
     quote_rs_native,
     syn_rs_native,
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 035828c532e..476a996a70d 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -27,7 +27,7 @@ sub_file="${sub_tdir}/submodule.tar"
 # in their checkout, because the build environment is completely
 # different to the host OS.
 subprojects="keycodemapdb libvfio-user berkeley-softfloat-3
-  berkeley-testfloat-3 anyhow-1-rs arbitrary-int-1-rs bilge-0.2-rs
+  berkeley-testfloat-3 anyhow-1-rs arbitrary-int-1-rs attrs-0.2-rs bilge-0.2-rs
   bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs
   libc-0.2-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
diff --git a/scripts/make-release b/scripts/make-release
index 87f563ef5f7..bc1b43caa25 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -40,7 +40,7 @@ fi
 
 # Only include wraps that are invoked with subproject()
 SUBPROJECTS="libvfio-user keycodemapdb berkeley-softfloat-3
-  berkeley-testfloat-3 anyhow-1-rs arbitrary-int-1-rs bilge-0.2-rs
+  berkeley-testfloat-3 anyhow-1-rs arbitrary-int-1-rs attrs-0.2-rs bilge-0.2-rs
   bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs
   libc-0.2-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index f4281934ce1..983c4c1549e 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -8,6 +8,7 @@
 /slirp
 /anyhow-1.0.98
 /arbitrary-int-1.2.7
+/attrs-0.2.9
 /bilge-0.2.0
 /bilge-impl-0.2.0
 /either-1.12.0
diff --git a/subprojects/attrs-0.2-rs.wrap b/subprojects/attrs-0.2-rs.wrap
new file mode 100644
index 00000000000..cd43c91d63e
--- /dev/null
+++ b/subprojects/attrs-0.2-rs.wrap
@@ -0,0 +1,7 @@
+[wrap-file]
+directory = attrs-0.2.9
+source_url = https://crates.io/api/v1/crates/attrs/0.2.9/download
+source_filename = attrs-0.2.9.tar.gz
+source_hash = 2a207d40f43de65285f3de0509bb6cb16bc46098864fce957122bbacce327e5f
+#method = cargo
+patch_directory = attrs-0.2-rs
diff --git a/subprojects/packagefiles/attrs-0.2-rs/meson.build b/subprojects/packagefiles/attrs-0.2-rs/meson.build
new file mode 100644
index 00000000000..ee575476cb2
--- /dev/null
+++ b/subprojects/packagefiles/attrs-0.2-rs/meson.build
@@ -0,0 +1,33 @@
+project('attrs-0.2-rs', 'rust',
+  meson_version: '>=1.5.0',
+  version: '0.2.9',
+  license: 'MIT OR Apache-2.0',
+  default_options: [])
+
+subproject('proc-macro2-1-rs', required: true)
+subproject('syn-2-rs', required: true)
+
+proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
+syn_dep = dependency('syn-2-rs', native: true)
+
+_attrs_rs = static_library(
+  'attrs',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  rust_args: [
+    '--cap-lints', 'allow',
+  ],
+  dependencies: [
+    proc_macro2_dep,
+    syn_dep,
+  ],
+  native: true,
+)
+
+attrs_dep = declare_dependency(
+  link_with: _attrs_rs,
+)
+
+meson.override_dependency('attrs-0.2-rs', attrs_dep, native: true)
-- 
2.51.0


