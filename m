Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1155FCAC5A8
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 15:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzzkq-00080w-2n; Sat, 20 Sep 2025 11:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uzzkk-0007yO-FR; Sat, 20 Sep 2025 11:43:58 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uzzkf-0001zC-Ly; Sat, 20 Sep 2025 11:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758383034; x=1789919034;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FE/A26CM7lN9wxf4s24xxF3DOe3NwCfkq0cfOOFg6wU=;
 b=TatoO260RYfy+GOZJM5sL50z8IdvFxMVWxbJL3A6DkmDl2m1A/ZG3a+M
 St5lG4YI2dr7js7jF7Ia08rywO/RzdAu44Jg1bffMKWDWjHB2PAuvZV8N
 LZ8Ib9qvjjHeyx9qtPflzC/mcg/FFa+xIr2D7jv4BmWATwvgerhfC5K0y
 o2hKqIQPKz0FC+oCwdYd8EFqU2G1zPotLBaTcEyNdjNXWYROXvg89TxdX
 OsvabZFamqrETzhDeeuI6Hy1yhJcP9fXfB8mZQbaN8z5pI7QjUkW7Rutu
 Q8lPdvnu5OPV4hyMEKroZ3eBD2thIE7m3P4HT31w6ByuN7Hyb0Lnc/UqL A==;
X-CSE-ConnectionGUID: rZhrKqiVQRyHGW+qevF3/Q==
X-CSE-MsgGUID: 7WROMVWtRDKh0vAbASwZ9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11559"; a="70955535"
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; d="scan'208";a="70955535"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2025 08:43:49 -0700
X-CSE-ConnectionGUID: XxLnda1HTYCpFDrH9JhOow==
X-CSE-MsgGUID: m2tE3PAQQH2ZB7yFOCkhdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; d="scan'208";a="181349462"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 20 Sep 2025 08:43:47 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 06/12] rust/qdev: Refine the documentation for QDevProp
 trait
Date: Sun, 21 Sep 2025 00:05:14 +0800
Message-Id: <20250920160520.3699591-7-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250920160520.3699591-1-zhao1.liu@intel.com>
References: <20250920160520.3699591-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Refine the documentation to clarify:
 * `unsfae` requires that `VALUE` must be valid.
 * using `*const` instead of `&` because the latter will cause compiler
   error.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/core/src/qdev.rs | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index d8113238e513..89c21e7c6b50 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -109,9 +109,16 @@ pub trait ResettablePhasesImpl {
 ///
 /// # Safety
 ///
-/// This trait is marked as `unsafe` because currently having a `const` refer to
-/// an `extern static` as a reference instead of a raw pointer results in this
-/// compiler error:
+/// This trait is marked as `unsafe` because `VALUE` must be a valid raw
+/// reference to a [`bindings::PropertyInfo`].
+///
+/// Note we could not use a regular reference:
+///
+/// ```text
+/// const VALUE: &bindings::PropertyInfo = ...
+/// ```
+///
+/// because this results in the following compiler error:
 ///
 /// ```text
 /// constructing invalid value: encountered reference to `extern` static in `const`
@@ -119,7 +126,7 @@ pub trait ResettablePhasesImpl {
 ///
 /// This is because the compiler generally might dereference a normal reference
 /// during const evaluation, but not in this case (if it did, it'd need to
-/// dereference the raw pointer so this would fail to compile).
+/// dereference the raw pointer so using a `*const` would also fail to compile).
 ///
 /// It is the implementer's responsibility to provide a valid
 /// [`bindings::PropertyInfo`] pointer for the trait implementation to be safe.
-- 
2.34.1


