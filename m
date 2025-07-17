Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71453C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 06:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucIN4-0007ca-W9; Thu, 17 Jul 2025 02:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucI5p-0008EY-7U
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 02:27:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucI5l-00086Q-IO
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 02:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752733659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3wc7lAth6GBcBb8U8NN32axGheQwcFepJVyyKJ1eOa8=;
 b=bEDyCB0zpiOyIqFfMOyie/lJv3GSZE/usn8ANPmmyzMTR+8ik0juV89gdIPJniioOMZ5XE
 fUfYDyN4cNg9EcEplkLWoT8myzDBBjw7LZlZsa5qHB9A9676K8el4D0Y91in6a8TAeCbhj
 OYTLR3NK2prba21zMcKQ3kgCY29ZPJ4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-9xtXL2KaMn2Ub1NCN4gI-w-1; Thu, 17 Jul 2025 02:27:37 -0400
X-MC-Unique: 9xtXL2KaMn2Ub1NCN4gI-w-1
X-Mimecast-MFC-AGG-ID: 9xtXL2KaMn2Ub1NCN4gI-w_1752733657
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4eb6fcd88so321615f8f.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 23:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752733656; x=1753338456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3wc7lAth6GBcBb8U8NN32axGheQwcFepJVyyKJ1eOa8=;
 b=SpmABGMZ90PymShJLYS3t7IHOOqGR9QgonHGAoE34SDlxYvfVxzk8CNaPC4/c9ndzq
 TkzAd7LLIbp6S3YWFc2pnXlmECGEtusWLRajXTcQuxibeKUYibeXajG/rxHTdN2WA6KF
 TWRJV5LNcf9Y0hp+6J/R4ALjNPAN94YemOa/8ZoJt090JKnmzLkTK8HK1Lc0J3h1AfTM
 NvYYDqlIWDa4IIFwUZBps+7uMIeWxrMig2CRv2VasanBIqOVFygZxUqKmJ0a++feAeay
 pDskMLFi3yo7vwIUxGNqojleqXitb4pkmR3LsDPlk67sbp3oaHCPj1DoRILsC7q0wFZg
 gFKw==
X-Gm-Message-State: AOJu0YxxlFaItyhpClocc3g71sED7hHXmxUlHtS1reC4k4M7cnBbn9dv
 4c7vLGmqbv4Z9WI0BScP/roP7Sat/MFp9fziEIEDjTjm3ali6i1bYDJpQsmS7vMLpUIaozpPD/e
 cp+meVOb+qk1JYIA4xRo8XbvXaV1GVRehvJ+aSEVIWfCWComuFHR9f3R9PAaA7EHFxc9myGbGd/
 HS/rtiIdP4maf12/qQGJ0PpkKVoe6prwDYoneV58gw
X-Gm-Gg: ASbGncsQZ8f1rWALMhSKnfU28KiV22+HBA5PFOeILw3vUSHOTBMs5TfR7lywxMgbspj
 0/VvA1PKG2Uk3/skuvSVBbqxP+FZ1d+j+hBkLOmd8+B1dMJmn43chzfgHMYtAaFo6eJUaHh40EI
 IjK0lrFiD8zCqBffrCjvgwK0boqBubwWIH6Ewxt6hk940jjALRkLV9K5nX+tFwoubNhzFGtiVyo
 BZyPAju+353p9FmtxhFu4WfiNpyCdqXP19oe1yeMcjrUdy8dg3Fuzti1II3RL5az5l5LRG+lNWt
 NWszdCUvGVHe4Gyh7BZnUN2JoMd314f0NKHon6OhoVE=
X-Received: by 2002:a05:6000:4383:b0:3a5:27ba:479c with SMTP id
 ffacd0b85a97d-3b60e50ff53mr3983682f8f.43.1752733655665; 
 Wed, 16 Jul 2025 23:27:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr0SsmYWr/PIqoKlmDZAkgwq8lCzeqWOpKUZECwhrIPsT/AS+6vxAEdbTsYkEDvNnTcVdSXA==
X-Received: by 2002:a05:6000:4383:b0:3a5:27ba:479c with SMTP id
 ffacd0b85a97d-3b60e50ff53mr3983652f8f.43.1752733655076; 
 Wed, 16 Jul 2025 23:27:35 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc22a8sm20228574f8f.34.2025.07.16.23.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 23:27:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	manos.pitsidianakis@linaro.org
Subject: [PATCH 2/4] subprojects: add attrs crate
Date: Thu, 17 Jul 2025 08:27:25 +0200
Message-ID: <20250717062727.305466-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717062727.305466-1-pbonzini@redhat.com>
References: <20250717062727.305466-1-pbonzini@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The attrs crate is a simple combinator-based parser for Rust attributes.
It will be used instead of a handwritten parser.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock                               | 11 +++++++
 rust/meson.build                              |  2 ++
 rust/qemu-api-macros/Cargo.toml               |  1 +
 rust/qemu-api-macros/meson.build              |  1 +
 scripts/archive-source.sh                     |  2 +-
 scripts/make-release                          |  2 +-
 subprojects/.gitignore                        |  1 +
 subprojects/attrs-0.2-rs.wrap                 |  7 ++++
 .../packagefiles/attrs-0.2-rs/meson.build     | 32 +++++++++++++++++++
 9 files changed, 57 insertions(+), 2 deletions(-)
 create mode 100644 subprojects/attrs-0.2-rs.wrap
 create mode 100644 subprojects/packagefiles/attrs-0.2-rs/meson.build

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 4baf6ba663c..570ba5b82d3 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -14,6 +14,16 @@ version = "1.2.7"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "c84fc003e338a6f69fbd4f7fe9f92b535ff13e9af8997f3b14b6ddff8b1df46d"
 
+[[package]]
+name = "attrs"
+version = "0.2.9"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "2a207d40f43de65285f3de0509bb6cb16bc46098864fce957122bbacce327e5f"
+dependencies = [
+ "proc-macro2",
+ "syn",
+]
+
 [[package]]
 name = "bilge"
 version = "0.2.0"
@@ -139,6 +149,7 @@ dependencies = [
 name = "qemu_api_macros"
 version = "0.1.0"
 dependencies = [
+ "attrs",
  "proc-macro2",
  "quote",
  "syn",
diff --git a/rust/meson.build b/rust/meson.build
index 331f11b7e72..21df23c1f9e 100644
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
 
 qemuutil_rs = qemuutil.partial_dependency(link_args: true, links: true)
 
diff --git a/rust/qemu-api-macros/Cargo.toml b/rust/qemu-api-macros/Cargo.toml
index 0cd40c8e168..99f7a425fcc 100644
--- a/rust/qemu-api-macros/Cargo.toml
+++ b/rust/qemu-api-macros/Cargo.toml
@@ -16,6 +16,7 @@ rust-version.workspace = true
 proc-macro = true
 
 [dependencies]
+attrs = "0.2.9"
 proc-macro2 = "1"
 quote = "1"
 syn = { version = "2", features = ["extra-traits"] }
diff --git a/rust/qemu-api-macros/meson.build b/rust/qemu-api-macros/meson.build
index 2152bcb99b3..12d02b20c20 100644
--- a/rust/qemu-api-macros/meson.build
+++ b/rust/qemu-api-macros/meson.build
@@ -8,6 +8,7 @@ _qemu_api_macros_rs = rust.proc_macro(
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
index 4509a9fabf5..00a91fb95f4 100755
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
index 9d579f72d12..1ffd9513671 100644
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
index 00000000000..fc6f269dcbf
--- /dev/null
+++ b/subprojects/packagefiles/attrs-0.2-rs/meson.build
@@ -0,0 +1,32 @@
+project('attrs-0.2-rs', 'rust',
+  meson_version: '>=1.5.0',
+  version: '0.2.9',
+  license: 'MIT OR Apache-2.0',
+  default_options: [])
+
+subproject('attrs-0.2-rs', required: true)
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
2.50.1


