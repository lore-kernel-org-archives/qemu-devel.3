Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF63C35FF9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 14:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuBqI-00053x-NA; Mon, 17 Mar 2025 10:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuBpk-0004uf-69; Mon, 17 Mar 2025 10:52:54 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuBpc-00061r-TM; Mon, 17 Mar 2025 10:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742223165; x=1773759165;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VJljKNmjPdcPw2FYw9qRNJPbq/zXEvkClaRKs0KyTKs=;
 b=GxyNWaWURLRITaU+a7Je6ty8a3/MouWCg5kZAhdTExZIYp5PDysHgH27
 YO6kU++1pyQjaE76N41ZQRIQ783u9/1jYKpLVxdDXMKLye7BHZT3r/b++
 yYn8J/pVlN71rwcFeQ3brRTUubcwih+cZZ6xy38srRCTp2Z89xWCGfTAt
 cG3XIoEsXBG6ofOuxxqSNSsTrLayKgpx+CnPMJWL7aUZBGVNJ409PZmuV
 Mu6tDCmTj16xyoVY+WYflUSJ0q7KJi4nEkfk4c2ElhybTLcjAicM7c9qG
 eBUAIe60xz3QvFkl7ttWkZFxL9nfx+6IYgzPAKx++2sOZToHPK7DMHM5G w==;
X-CSE-ConnectionGUID: lEZI2fZoQW2gEQogiVSJ/Q==
X-CSE-MsgGUID: EhCXD2UJQcGiC4Zr61Q/Eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54694593"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; d="scan'208";a="54694593"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2025 07:52:31 -0700
X-CSE-ConnectionGUID: dt74G+7CQzqd2f396YJjdQ==
X-CSE-MsgGUID: p4VLoG94Rs2X0h895iR0iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; d="scan'208";a="126988499"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 17 Mar 2025 07:52:30 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 03/17] rust/vmstate: Add a prefix separator ",
 " for the array field in vmstate macros
Date: Mon, 17 Mar 2025 23:12:22 +0800
Message-Id: <20250317151236.536673-4-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317151236.536673-1-zhao1.liu@intel.com>
References: <20250317151236.536673-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The fields are separated by ",", so it's necessary to add ", " in array
field to avoid matching failure.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/vmstate.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 9533b1250fa5..94efbd8bb735 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -202,7 +202,7 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateFlags
 /// and [`impl_vmstate_forward!`](crate::impl_vmstate_forward) help with this.
 #[macro_export]
 macro_rules! vmstate_of {
-    ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])? $(,)?) => {
+    ($struct_name:ty, $field_name:ident $(, [0 .. $num:ident $(* $factor:expr)?])? $(,)?) => {
         $crate::bindings::VMStateField {
             name: ::core::concat!(::core::stringify!($field_name), "\0")
                 .as_bytes()
@@ -435,7 +435,7 @@ macro_rules! vmstate_unused {
 #[doc(alias = "VMSTATE_STRUCT")]
 #[macro_export]
 macro_rules! vmstate_struct {
-    ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])?, $vmsd:expr, $type:ty $(,)?) => {
+    ($struct_name:ty, $field_name:ident $(, [0 .. $num:ident $(* $factor:expr)?])?, $vmsd:expr, $type:ty $(,)?) => {
         $crate::bindings::VMStateField {
             name: ::core::concat!(::core::stringify!($field_name), "\0")
                 .as_bytes()
-- 
2.34.1


