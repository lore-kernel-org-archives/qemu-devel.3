Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4620BCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 14:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGHsN-0002d0-I1; Tue, 04 Nov 2025 09:19:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vGHsJ-0002cq-CF; Tue, 04 Nov 2025 09:19:07 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vGHsG-0005cc-6W; Tue, 04 Nov 2025 09:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762265944; x=1793801944;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=AyKFq/mMVkaAjBzp3vp/hCzikcEuR0zvdiNVm1FGg7s=;
 b=Z8huc7rn6372L58HDNROw9fov5Xpjc77YoFs9ptsWTUND+TbO+L8a+/B
 oy/UvzPUKw2d096MIVm660iECp3Sachk+md0vIihoP7/jABXqzkaeOZs0
 gYtGaFYPnUAgqtRwT88qVACzIA8dShfWN/obrldXhqT8dUEpR4DEKaasF
 z+vXj6g4XxJkGOqXQ7a3lpDo53U9ECZ2J/dflB3ne7oBGK6bY+78xNUt4
 20FwjUIgVC11hqwcLj4TbWi6UY6h0eoK2EdL5gFqHDUst9DPdq8eUmFXq
 Jb04ZI8AW0ykKp/CpBYdZuSHIFxEha84qbJX2HAbhHeuZQdY74zrAUN7l g==;
X-CSE-ConnectionGUID: DQcUlhoKQZqlbtN37ZEmuQ==
X-CSE-MsgGUID: yY3lFxEmRIy3JDy6UVMzPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="86988964"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="86988964"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 06:18:59 -0800
X-CSE-ConnectionGUID: b55FLiJqRsKTmvN7FyXroA==
X-CSE-MsgGUID: rabUJhE5Q7yB7UJxHHMVSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="186846571"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 04 Nov 2025 06:18:57 -0800
Date: Tue, 4 Nov 2025 22:41:11 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 08/11] rust: qemu-macros: add ToMigrationState derive macro
Message-ID: <aQoQh4tU+kR0tKwM@intel.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
 <20251001075210.1042479-8-pbonzini@redhat.com>
 <aQiDFo0Yv6sIZsH5@intel.com> <aQjPApAmM2Hma3Rm@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQjPApAmM2Hma3Rm@intel.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
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

> It seems the generated migration_state_struct needs a complete VMSD:
> collect all its fields and build a VMSD.
> 
> And then apply impl_vmstate_struct! to this  migration_state_struct.
> 
> If we zero the BASE, then `vmstate_of!(Self, migration_state)` seems
> can't migrate its fields.

I think the following generated vmstate implementation should be what we
need:

diff --git a/rust/qemu-macros/src/migration_state.rs b/rust/qemu-macros/src/migration_state.rs
index 5edf0efe687f..cb047638e3da 100644
--- a/rust/qemu-macros/src/migration_state.rs
+++ b/rust/qemu-macros/src/migration_state.rs
@@ -1,6 +1,6 @@
 use std::borrow::Cow;

-use proc_macro2::TokenStream;
+use proc_macro2::{Literal, TokenStream};
 use quote::{format_ident, quote, ToTokens};
 use syn::{spanned::Spanned, DeriveInput, Error, Field, Ident, Result, Type};

@@ -236,6 +236,43 @@ pub struct #name {
         }
     }

+    fn generate_vmstate_impl(&self) -> TokenStream {
+        let name = self.migration_state_name();
+        let name_str = name.to_string();
+        // Most of the time, const variables use uppercase snake case style,
+        // while VMStateDescription.name uses lowercase snake case. But we're
+        // not strictly following the usual snake case conventions here because
+        // what we have is good enough for the generated code right now.
+        //
+        // QEMU struct names are typically in camel case, but there are exceptions
+        // - like non-standard camel case such as HPETState. So converting from
+        // camel to snake case would need an extra helper.
+        let vmsd_name = format_ident!("VMSTATE_{}", name_str);
+        // C-string literal "c" can't be used in quote! directly.
+        let vmsd_c_name = Literal::c_string(&std::ffi::CString::new(name_str).unwrap());
+
+        let vmstate_fields = self.fields.iter().map(|field| {
+            let field_name = &field.name;
+            quote! {
+                vmstate_of!(#name, #field_name),
+            }
+        });
+
+        quote! {
+            const #vmsd_name: VMStateDescription<#name> =
+                VMStateDescriptionBuilder::<#name>::new()
+                    .name(#vmsd_c_name)
+                    .version_id(0)
+                    .minimum_version_id(0)
+                    .fields(vmstate_fields! {
+                        #(#vmstate_fields)*
+                    })
+                    .build();
+
+            impl_vmstate_struct!(#name, #vmsd_name);
+        }
+    }
+
     fn generate_snapshot_migration_state(&self) -> TokenStream {
         let fields = self
             .fields
@@ -275,12 +312,15 @@ fn generate(&self) -> TokenStream {
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

diff --git a/rust/qemu-macros/src/tests.rs b/rust/qemu-macros/src/tests.rs
index 65691412ff57..d70ebf23c273 100644
--- a/rust/qemu-macros/src/tests.rs
+++ b/rust/qemu-macros/src/tests.rs
@@ -408,6 +408,20 @@ pub struct CustomMigration {
                 pub nested_field: <NestedStruct as ToMigrationState>::Migrated,
                 pub simple_field: <u32 as ToMigrationState>::Migrated,
             }
+            const VMSTATE_CustomMigration: VMStateDescription <CustomMigration> =
+                VMStateDescriptionBuilder::<CustomMigration>::new()
+                    .name(c"CustomMigration")
+                    .version_id(0)
+                    .minimum_version_id(0)
+                    .fields(vmstate_fields! {
+                        vmstate_of!(CustomMigration, shared_data),
+                        vmstate_of!(CustomMigration, converted_field),
+                        vmstate_of!(CustomMigration, fallible_field),
+                        vmstate_of!(CustomMigration, nested_field),
+                        vmstate_of!(CustomMigration, simple_field),
+                    })
+                    .build();
+            impl_vmstate_struct!(CustomMigration, VMSTATE_CustomMigration);
             impl ToMigrationState for MyStruct {
                 type Migrated = CustomMigration;
                 fn snapshot_migration_state(



