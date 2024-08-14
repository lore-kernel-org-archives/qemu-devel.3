Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E7BC52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 00:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se1wH-0004my-Q6; Tue, 13 Aug 2024 20:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1se1wG-0004lS-Gd
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 20:32:32 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1se1w1-0000W4-3n
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 20:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723595537; x=1755131537;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ev9OeDx8uE6NsRQabK3FPE9C8KcR0iSM0s5jwh8vN80=;
 b=I8uSxH1VmMpgyAAJSD2VVdVju+43BijPk1/NIT4JPtJ2QpHD4CtXH25D
 IOpiXXy9WifXwp2gS1ieVnoS80ZWh/+amjPph3x5GFVVAnwyg8kuTiZyJ
 cWFVtQqArhj/c57CbF9PnyJX+MPDKti+Pmqt1c0mnBCeLdcO9yTNp8i1D
 fF2HtayntdFTO9eqbxUe1ZK8pTw0ciiNWhZ55ZjxIUWDpTYDhxspRcmCf
 d+zWOOzpjvFKzAakm/BW7n7GYPq2po7FGZwmNqoqz3Y2C2DO8j25p1gsP
 4WkeUjnJOI8cRyxADlCUYdCgm3aYDi8YikROzp+ercdnd8jhdns3Ws1H2 Q==;
X-CSE-ConnectionGUID: Mn1pGZkcSu+MWhUUUywUOA==
X-CSE-MsgGUID: mDKj3mAkRBCZi7PU24rhTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21346396"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; d="scan'208";a="21346396"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 17:32:15 -0700
X-CSE-ConnectionGUID: 8BI/hIOtR0itKObw5ZQYOQ==
X-CSE-MsgGUID: G6s2W3tORau6Vj3jOlD9mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; d="scan'208";a="58472756"
Received: from junjie-optiplex-7080.sh.intel.com (HELO localhost.localdomain)
 ([10.239.48.46])
 by fmviesa006.fm.intel.com with ESMTP; 13 Aug 2024 17:32:10 -0700
From: Junjie Mao <junjie.mao@intel.com>
To: manos.pitsidianakis@linaro.org,
	pbonzini@redhat.com
Cc: alex.bennee@linaro.org, armbru@redhat.com, berrange@redhat.com,
 gustavo.romero@linaro.org, mads@ynddal.dk, marcandre.lureau@redhat.com,
 peter.maydell@linaro.org, philmd@linaro.org, pierrick.bouvier@linaro.org,
 qemu-devel@nongnu.org, richard.henderson@linaro.org, rowan.hart@intel.com,
 stefanha@redhat.com, thuth@redhat.com, zhao1.liu@intel.com
Subject: [RFC PATCH 1/2] meson: subprojects: Specify Rust edition by
 rust_std=20XX
Date: Wed, 14 Aug 2024 17:08:19 +0800
Message-Id: <20240814090820.1251026-2-junjie.mao@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240814090820.1251026-1-junjie.mao@intel.com>
References: <20240814090820.1251026-1-junjie.mao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=junjie.mao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.125, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Junjie Mao <junjie.mao@intel.com>
---
 subprojects/packagefiles/arbitrary-int-1-rs/meson.build       | 4 +---
 subprojects/packagefiles/bilge-impl-0.2-rs/meson.build        | 2 +-
 subprojects/packagefiles/either-1-rs/meson.build              | 2 +-
 subprojects/packagefiles/itertools-0.11-rs/meson.build        | 2 +-
 subprojects/packagefiles/proc-macro-error-1-rs/meson.build    | 2 +-
 .../packagefiles/proc-macro-error-attr-1-rs/meson.build       | 2 +-
 subprojects/packagefiles/proc-macro2-1-rs/meson.build         | 2 +-
 subprojects/packagefiles/quote-1-rs/meson.build               | 2 +-
 subprojects/packagefiles/syn-2-rs/meson.build                 | 2 +-
 subprojects/packagefiles/unicode-ident-1-rs/meson.build       | 4 +---
 10 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/subprojects/packagefiles/arbitrary-int-1-rs/meson.build b/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
index 9cba82365f..34a189cbae 100644
--- a/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
+++ b/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
@@ -7,10 +7,8 @@ _arbitrary_int_rs = static_library(
   'arbitrary_int',
   files('src/lib.rs'),
   gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
-  rust_args: [
-    '--edition', '2021',
-  ],
   dependencies: [],
 )

diff --git a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
index e0c51c7375..80243c7024 100644
--- a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
+++ b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
@@ -22,8 +22,8 @@ rust = import('rust')
 _bilge_impl_rs = rust.proc_macro(
   'bilge_impl',
   files('src/lib.rs'),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_args: [
-    '--edition', '2021',
     '--cfg', 'use_fallback',
     '--cfg', 'feature="syn-error"',
     '--cfg', 'feature="proc-macro"',
diff --git a/subprojects/packagefiles/either-1-rs/meson.build b/subprojects/packagefiles/either-1-rs/meson.build
index 07240b8708..a5842eb3a6 100644
--- a/subprojects/packagefiles/either-1-rs/meson.build
+++ b/subprojects/packagefiles/either-1-rs/meson.build
@@ -7,9 +7,9 @@ _either_rs = static_library(
   'either',
   files('src/lib.rs'),
   gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2018', 'build.rust_std=2018'],
   rust_abi: 'rust',
   rust_args: [
-    '--edition', '2018',
     '--cfg', 'feature="use_std"',
     '--cfg', 'feature="use_alloc"',
   ],
diff --git a/subprojects/packagefiles/itertools-0.11-rs/meson.build b/subprojects/packagefiles/itertools-0.11-rs/meson.build
index da731ca032..13d2d27019 100644
--- a/subprojects/packagefiles/itertools-0.11-rs/meson.build
+++ b/subprojects/packagefiles/itertools-0.11-rs/meson.build
@@ -11,9 +11,9 @@ _itertools_rs = static_library(
   'itertools',
   files('src/lib.rs'),
   gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2018', 'build.rust_std=2018'],
   rust_abi: 'rust',
   rust_args: [
-    '--edition', '2018',
     '--cfg', 'feature="use_std"',
     '--cfg', 'feature="use_alloc"',
   ],
diff --git a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
index 20f2e99a87..38ea7b89d3 100644
--- a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
@@ -16,9 +16,9 @@ syn_dep = dependency('syn-2-rs', native: true)
 _proc_macro_error_rs = static_library(
   'proc_macro_error',
   files('src/lib.rs'),
+  override_options: ['rust_std=2018', 'build.rust_std=2018'],
   rust_abi: 'rust',
   rust_args: [
-    '--edition', '2018',
     '--cfg', 'use_fallback',
     '--cfg', 'feature="syn-error"',
     '--cfg', 'feature="proc-macro"',
diff --git a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
index 1aafd41795..d900c54cfd 100644
--- a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
@@ -13,8 +13,8 @@ rust = import('rust')
 _proc_macro_error_attr_rs = rust.proc_macro(
   'proc_macro_error_attr',
   files('src/lib.rs'),
+  override_options: ['rust_std=2018', 'build.rust_std=2018'],
   rust_args: [
-    '--edition', '2018',
     '--cfg', 'use_fallback',
     '--cfg', 'feature="syn-error"',
     '--cfg', 'feature="proc-macro"'
diff --git a/subprojects/packagefiles/proc-macro2-1-rs/meson.build b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
index 6796d75295..8e601b50cc 100644
--- a/subprojects/packagefiles/proc-macro2-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
@@ -11,9 +11,9 @@ _proc_macro2_rs = static_library(
   'proc_macro2',
   files('src/lib.rs'),
   gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: [
-    '--edition', '2021',
     '--cfg', 'feature="proc-macro"',
     '--cfg', 'no_literal_byte_character',
     '--cfg', 'no_literal_c_string',
diff --git a/subprojects/packagefiles/quote-1-rs/meson.build b/subprojects/packagefiles/quote-1-rs/meson.build
index a9c2fb9b61..d36609bd3c 100644
--- a/subprojects/packagefiles/quote-1-rs/meson.build
+++ b/subprojects/packagefiles/quote-1-rs/meson.build
@@ -11,9 +11,9 @@ _quote_rs = static_library(
   'quote',
   files('src/lib.rs'),
   gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: [
-    '--edition', '2021',
     '--cfg', 'feature="proc-macro"',
   ],
   dependencies: [
diff --git a/subprojects/packagefiles/syn-2-rs/meson.build b/subprojects/packagefiles/syn-2-rs/meson.build
index b4666473fb..a53335f309 100644
--- a/subprojects/packagefiles/syn-2-rs/meson.build
+++ b/subprojects/packagefiles/syn-2-rs/meson.build
@@ -15,9 +15,9 @@ _syn_rs = static_library(
   'syn',
   files('src/lib.rs'),
   gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: [
-    '--edition', '2021',
     '--cfg', 'feature="full"',
     '--cfg', 'feature="derive"',
     '--cfg', 'feature="parsing"',
diff --git a/subprojects/packagefiles/unicode-ident-1-rs/meson.build b/subprojects/packagefiles/unicode-ident-1-rs/meson.build
index 77c581f40a..54f2376854 100644
--- a/subprojects/packagefiles/unicode-ident-1-rs/meson.build
+++ b/subprojects/packagefiles/unicode-ident-1-rs/meson.build
@@ -7,10 +7,8 @@ _unicode_ident_rs = static_library(
   'unicode_ident',
   files('src/lib.rs'),
   gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
-  rust_args: [
-    '--edition', '2021',
-  ],
   dependencies: [],
   native: true,
 )
--
2.30.2

