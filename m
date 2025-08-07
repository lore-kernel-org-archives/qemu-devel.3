Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083FEC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzRG-0007yl-Hv; Thu, 07 Aug 2025 08:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzR0-0007fo-6v; Thu, 07 Aug 2025 08:09:28 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzQv-00056D-Oq; Thu, 07 Aug 2025 08:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568562; x=1786104562;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OxhjwyLszdE/5nDOkyohSk0dJTIgi8pKdSOahOmdvyc=;
 b=a4Efb3I4064+xf7IAaD3gfzKuiNScwTVy3cM3f0Mb0wrdXjcJHEtCIdh
 aVKSnR6SMD2bwVraeuYBT6Jquikrh64DEMwwKxOTs52gYP3YceNJswajV
 ZwO5S4O08kz3dxapNdrRybWa7NRA1stavb82DkxWeojutjGWmmopfExei
 0xQj/qMHmWdtHnUul3+r2IQtEwmnX3r9FmXYExHBpRbEsk22RpOR3RmF4
 r6+9Gjw/xKy94VmkQK9OXEd8K2QLOh4/TnffnZh++IeZU9rVstN+/OH0E
 ZbrJ4qxhJWpVLPxDVFLVe5Ab/PMDlEWcbz6jtHPpKLUqcByrP3YmaTZVX g==;
X-CSE-ConnectionGUID: lJ/lYhdnQp6iexVxMOqRVQ==
X-CSE-MsgGUID: l7ZZhBzXTI6X+UIgnlZ60Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036739"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036739"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:09:20 -0700
X-CSE-ConnectionGUID: r5EH3NTmQH6ZgB52sBuJEg==
X-CSE-MsgGUID: VNoGryIpTNiQe4Pc3JpXUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701077"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:09:18 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 06/26] subprojects: Add winapi-x86_64-pc-windows-gnu crate
Date: Thu,  7 Aug 2025 20:30:07 +0800
Message-Id: <20250807123027.2910950-7-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807123027.2910950-1-zhao1.liu@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 scripts/archive-source.sh                     |  2 +-
 scripts/make-release                          |  2 +-
 subprojects/.gitignore                        |  1 +
 .../meson.build                               | 20 +++++++++++++++++++
 .../winapi-x86_64-pc-windows-gnu-0.4-rs.wrap  | 10 ++++++++++
 5 files changed, 33 insertions(+), 2 deletions(-)
 create mode 100644 subprojects/packagefiles/winapi-x86_64-pc-windows-gnu-0.4-rs/meson.build
 create mode 100644 subprojects/winapi-x86_64-pc-windows-gnu-0.4-rs.wrap

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 2dff5d3d89fe..4caf6078f1ac 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -32,7 +32,7 @@ subprojects="keycodemapdb libvfio-user berkeley-softfloat-3
   libc-0.2-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
   syn-2-rs thiserror-1-rs thiserror-impl-1-rs unicode-ident-1-rs
-  winapi-i686-pc-windows-gnu-0.4-rs"
+  winapi-i686-pc-windows-gnu-0.4-rs winapi-x86_64-pc-windows-gnu-0.4-rs"
 sub_deinit=""
 
 function cleanup() {
diff --git a/scripts/make-release b/scripts/make-release
index f7a1481f856a..eb8b2446ad3a 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -45,7 +45,7 @@ SUBPROJECTS="libvfio-user keycodemapdb berkeley-softfloat-3
   libc-0.2-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
   syn-2-rs thiserror-1-rs thiserror-impl-1-rs unicode-ident-1-rs
-  winapi-i686-pc-windows-gnu-0.4-rs"
+  winapi-i686-pc-windows-gnu-0.4-rs winapi-x86_64-pc-windows-gnu-0.4-rs"
 
 src="$1"
 version="$2"
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index 838409353fca..ed51f2012e2c 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -23,3 +23,4 @@
 /thiserror-impl-1.0.65
 /unicode-ident-1.0.12
 /winapi-i686-pc-windows-gnu-0.4.0
+/winapi-x86_64-pc-windows-gnu-0.4.0
diff --git a/subprojects/packagefiles/winapi-x86_64-pc-windows-gnu-0.4-rs/meson.build b/subprojects/packagefiles/winapi-x86_64-pc-windows-gnu-0.4-rs/meson.build
new file mode 100644
index 000000000000..6b06e1d2810e
--- /dev/null
+++ b/subprojects/packagefiles/winapi-x86_64-pc-windows-gnu-0.4-rs/meson.build
@@ -0,0 +1,20 @@
+project('winapi-x86_64-pc-windows-gnu-0.4-rs', 'rust',
+ meson_version: '>=1.5.0',
+ version: '0.4.0',
+ license: 'MIT OR Apache-2.0',
+ default_options: [])
+
+lib = static_library(
+  'winapi-x86_64-pc-windows-gnu',
+  'src/lib.rs',
+  override_options : ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi : 'rust',
+  rust_args: ['--cap-lints', 'allow'],
+  dependencies: [thiserror_rs],
+)
+
+dep = declare_dependency(
+  link_with : [lib],
+)
+
+meson.override_dependency('winapi-x86_64-pc-windows-gnu-0.4-rs', dep)
diff --git a/subprojects/winapi-x86_64-pc-windows-gnu-0.4-rs.wrap b/subprojects/winapi-x86_64-pc-windows-gnu-0.4-rs.wrap
new file mode 100644
index 000000000000..d75a096980a1
--- /dev/null
+++ b/subprojects/winapi-x86_64-pc-windows-gnu-0.4-rs.wrap
@@ -0,0 +1,10 @@
+[wrap-file]
+directory = winapi-x86_64-pc-windows-gnu-0.4.0
+source_url = https://crates.io/api/v1/crates/winapi-x86_64-pc-windows-gnu/0.4.0/download
+source_filename = winapi-x86_64-pc-windows-gnu-0.4.0.tar.gz
+source_hash = 712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f
+#method = cargo
+patch_directory = winapi-x86_64-pc-windows-gnu-0.4-rs
+
+# bump this version number on every change to meson.build or the patches:
+# v2
-- 
2.34.1


