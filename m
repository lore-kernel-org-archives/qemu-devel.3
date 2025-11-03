Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5832FCCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFrPQ-0008HK-6w; Mon, 03 Nov 2025 05:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vFrPM-0008GT-Vy; Mon, 03 Nov 2025 05:03:29 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vFrPG-0000hS-Eg; Mon, 03 Nov 2025 05:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762164203; x=1793700203;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=4FQmeIYELimW4haBSnFU018/7z6jVn9vbPe5zfgrtJs=;
 b=OOGLkTg0LlG4ugbSXV++/W8LxHB46wv3f5arJd898Ov5/Wuy+8cuWyRG
 ebphqXlCwmihxzTiL+PFAYH+v9PCw/P3F2cnJyOVDMuwvs0olBYpg4BNp
 8HlqaqApw4HFxjSADHDxabn/+vccSzvJFLltXCD84ZI2Wbd5TyHDp5W80
 zaVedOderdvg5kJGf/6UDYrSOwqAjqNPGAArmm511VIpfhFaiXykSZmqa
 oLbqCKbCI4iydgU5JhdMJ4GyKoKsIJYoQc/hOGVYWx2+4cJgPqTpqjl75
 3y1lEzk3ifR0hTNJDCt4fNb3ndX29TUb0UWWvJ/cGsYIjNmX4M/BZrqjx g==;
X-CSE-ConnectionGUID: PBqlt34nTxK9ijEgR2abxw==
X-CSE-MsgGUID: UzGx/3NpSIGXKiPaADfAGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="75586926"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; d="scan'208";a="75586926"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2025 02:03:14 -0800
X-CSE-ConnectionGUID: wKNhXijpRtW3HImVL7IKvw==
X-CSE-MsgGUID: PvUlc5scSqempIhCgFxHqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; d="scan'208";a="186504255"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 03 Nov 2025 02:03:13 -0800
Date: Mon, 3 Nov 2025 18:25:26 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 08/11] rust: qemu-macros: add ToMigrationState derive macro
Message-ID: <aQiDFo0Yv6sIZsH5@intel.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
 <20251001075210.1042479-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001075210.1042479-8-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Paolo,

>  /// # use std::sync::Mutex;
> -/// # use migration::Migratable;
> +/// # use migration::{Migratable, ToMigrationState, VMState, VMStateField};
>  ///
> +/// #[derive(ToMigrationState)]
>  /// pub struct DeviceRegs {
>  ///     status: u32,
>  /// }
> +/// # unsafe impl VMState for DeviceRegsMigration {
> +/// #     const BASE: VMStateField = ::common::Zeroable::ZERO;
> +/// # }

did you miss something like the following?


diff --git a/rust/qemu-macros/src/migration_state.rs b/rust/qemu-macros/src/migration_state.rs
index 5edf0efe687f..2064bb73a6f0 100644
--- a/rust/qemu-macros/src/migration_state.rs
+++ b/rust/qemu-macros/src/migration_state.rs
@@ -236,6 +236,16 @@ pub struct #name {
         }
     }

+    fn generate_vmstate_impl(&self) -> TokenStream {
+        let name = self.migration_state_name();
+
+        quote! {
+            unsafe impl ::migration::VMState for #name {
+                const BASE: ::migration::VMStateField = ::common::Zeroable::ZERO;
+            }
+        }
+    }
+
     fn generate_snapshot_migration_state(&self) -> TokenStream {
         let fields = self
             .fields
@@ -275,12 +285,15 @@ fn generate(&self) -> TokenStream {
         let (impl_generics, ty_generics, where_clause) = generics.split_for_impl();
         let name = self.migration_state_name();
         let migration_state_struct = self.generate_migration_state_struct();
+        let vmstate_impl = self.generate_vmstate_impl();
         let snapshot_impl = self.generate_snapshot_migration_state();
         let restore_impl = self.generate_restore_migrated_state();

         quote! {
             #migration_state_struct

+            #vmstate_impl
+
             impl #impl_generics ToMigrationState for #struct_name #ty_generics #where_clause {
                 type Migrated = #name;


