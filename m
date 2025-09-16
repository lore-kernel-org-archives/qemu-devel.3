Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCCFCAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 08:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyR9B-0006tQ-KE; Tue, 16 Sep 2025 04:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uyR97-0006gn-Ki; Tue, 16 Sep 2025 04:34:41 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uyR91-000603-Uv; Tue, 16 Sep 2025 04:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758011676; x=1789547676;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VO7sI8EkKjiuIxmrP/H7OvNMu6oE7ELux2ybMT1pdIE=;
 b=RxZjw3nR/SrdA6FOpORankBlxmtxA4kjwJldj73z6992bur4z9pFy94D
 LjhrZE2PeuOdTUqwtJ9GQGTERSMx5Q41T8eWCP90fsOF41z3MXi6RRpz6
 6rACCKSaWXVKt/Qwm4k4gEmWlut05KuBOt44H52d/ky+eT9/i9Arcyus9
 eDqdzrp5poCZQA9dhFIWEI302dxuS2uSLjWZWLJRztvA7Py74A+AW1SlK
 muSXjAE/zziTxt4gbKEf1w7GkfB+xSDttq2UTU9kmattSdxJSrYG74jwi
 pRlJT/tnmo5om0XhZw0C/ulZtUs110tD0TPFvfR9JxvCGYWVRjOib24t+ w==;
X-CSE-ConnectionGUID: uW9GqoXtQbm/VoxKE8JaJg==
X-CSE-MsgGUID: w9wKpmMZSmKtwdMXhowwhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="77725179"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; d="scan'208";a="77725179"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 01:34:22 -0700
X-CSE-ConnectionGUID: GlwNrBC1T/qr+Tr/Pahf+A==
X-CSE-MsgGUID: 5JSql50AQzOflj35Hn3NGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; d="scan'208";a="174691082"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 16 Sep 2025 01:34:20 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 07/12] rust/qdev: Rename PropertyInfo field from VALUE to
 BASE_INFO
Date: Tue, 16 Sep 2025 16:55:52 +0800
Message-Id: <20250916085557.2008344-8-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916085557.2008344-1-zhao1.liu@intel.com>
References: <20250916085557.2008344-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Bit property info will added next. To distinguish different info fields,
rename `VALUE` to `BASE_INFO`, then it can better reflect that it
represents the basic property info.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/core/src/qdev.rs    | 12 ++++++------
 rust/qemu-macros/src/lib.rs |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index 2735e2b2c109..d887046d8de1 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -109,13 +109,13 @@ pub trait ResettablePhasesImpl {
 ///
 /// # Safety
 ///
-/// This trait is marked as `unsafe` because `VALUE` must be a valid raw
+/// This trait is marked as `unsafe` because `BASE_INFO` must be a valid raw
 /// reference to a [`bindings::PropertyInfo`].
 ///
 /// Note we could not use a regular reference:
 ///
 /// ```text
-/// const VALUE: &bindings::PropertyInfo = ...
+/// const BASE_INFO: &bindings::PropertyInfo = ...
 /// ```
 ///
 /// because this results in the following compiler error:
@@ -131,22 +131,22 @@ pub trait ResettablePhasesImpl {
 /// It is the implementer's responsibility to provide a valid
 /// [`bindings::PropertyInfo`] pointer for the trait implementation to be safe.
 pub unsafe trait QDevProp {
-    const VALUE: *const bindings::PropertyInfo;
+    const BASE_INFO: *const bindings::PropertyInfo;
 }
 
 /// Use [`bindings::qdev_prop_bool`] for `bool`.
 unsafe impl QDevProp for bool {
-    const VALUE: *const bindings::PropertyInfo = addr_of!(bindings::qdev_prop_bool);
+    const BASE_INFO: *const bindings::PropertyInfo = addr_of!(bindings::qdev_prop_bool);
 }
 
 /// Use [`bindings::qdev_prop_uint64`] for `u64`.
 unsafe impl QDevProp for u64 {
-    const VALUE: *const bindings::PropertyInfo = addr_of!(bindings::qdev_prop_uint64);
+    const BASE_INFO: *const bindings::PropertyInfo = addr_of!(bindings::qdev_prop_uint64);
 }
 
 /// Use [`bindings::qdev_prop_chr`] for [`chardev::CharBackend`].
 unsafe impl QDevProp for chardev::CharBackend {
-    const VALUE: *const bindings::PropertyInfo = addr_of!(bindings::qdev_prop_chr);
+    const BASE_INFO: *const bindings::PropertyInfo = addr_of!(bindings::qdev_prop_chr);
 }
 
 /// Trait to define device properties.
diff --git a/rust/qemu-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
index ed4064d6e110..b43ca31bae30 100644
--- a/rust/qemu-macros/src/lib.rs
+++ b/rust/qemu-macros/src/lib.rs
@@ -272,7 +272,7 @@ macro_rules! str_to_c_str {
             },
         )?;
         let field_ty = field.ty.clone();
-        let qdev_prop = quote! { <#field_ty as ::hwcore::QDevProp>::VALUE };
+        let qdev_prop = quote! { <#field_ty as ::hwcore::QDevProp>::BASE_INFO };
         let set_default = defval.is_some();
         let defval = defval.unwrap_or(syn::Expr::Verbatim(quote! { 0 }));
         properties_expanded.push(quote! {
-- 
2.34.1


