Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34840CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 12:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kr9-0001UD-RP; Thu, 25 Sep 2025 08:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v1kr7-0001SA-7E; Thu, 25 Sep 2025 08:13:49 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v1kqz-0006SU-WD; Thu, 25 Sep 2025 08:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758802422; x=1790338422;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Ubh6m6wIzLggVY741nUZywV85JxITpX7s/YsPR6IepE=;
 b=e7v1Q1a4HxlLmYO/f40y0BdLCqmrJhikpcCeW5DFYQJ09GgM3LpSvDrP
 QQ2lhonu4JCNL6Puelfdgdr16NXKh9ztzJhrVK/lEwQi8mkaG2F8YVn88
 WytozAEhgQFMWn4PHdHsDepPZBaF1ywQkNKHBbQcLugDxaYTjT4om2ZXC
 d4QIO2ubq00S7bWNMU12mXOmlYPG9zHmIHp9y0yNOWQuVgeMRPhsg7gQM
 4n6PqFm/Gq1u0fPlqfRdHqFAupsUBinAR7A2a55Y+pM5MoeLt3IRyUmKq
 G6LTCsfVueCAn2tY0idJ1xCaCRnDg5kDNQkuXdAAQPQylFYDU9bNj1AgZ A==;
X-CSE-ConnectionGUID: +9Rjdp7gQfSqMaUwGK22gA==
X-CSE-MsgGUID: IvP7PXOJT4aHZjnqUUoM+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="48682615"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="48682615"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 05:13:26 -0700
X-CSE-ConnectionGUID: E4YpkzUHS92ldqPczjCdyA==
X-CSE-MsgGUID: XHovghKYTnSA/lBuZ+N+gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="182468265"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 25 Sep 2025 05:13:24 -0700
Date: Thu, 25 Sep 2025 20:35:22 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, manos.pitsidianakis@linaro.org
Subject: Re: [PATCH 5/7] rust: qemu-macros: add ToMigrationState derive macro
Message-ID: <aNU3Cgll0vETC2Az@intel.com>
References: <20250920142958.181910-1-pbonzini@redhat.com>
 <20250920142958.181910-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920142958.181910-6-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Sat, Sep 20, 2025 at 04:29:56PM +0200, Paolo Bonzini wrote:
> Date: Sat, 20 Sep 2025 16:29:56 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 5/7] rust: qemu-macros: add ToMigrationState derive macro
> X-Mailer: git-send-email 2.51.0
> 
> Add a macro that recursively builds the "migrated" version
> of a struct.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/migration/meson.build              |   2 +-
>  rust/migration/src/lib.rs               |   2 +
>  rust/migration/src/migratable.rs        |  12 +-
>  rust/qemu-macros/src/lib.rs             |  88 +++++++
>  rust/qemu-macros/src/migration_state.rs | 296 ++++++++++++++++++++++++
>  rust/qemu-macros/src/tests.rs           | 112 ++++++++-
>  6 files changed, 507 insertions(+), 5 deletions(-)
>  create mode 100644 rust/qemu-macros/src/migration_state.rs

...

> diff --git a/rust/migration/src/migratable.rs b/rust/migration/src/migratable.rs
> index d09eeb35f11..fa25317eea8 100644
> --- a/rust/migration/src/migratable.rs
> +++ b/rust/migration/src/migratable.rs
> @@ -79,6 +79,10 @@
>  /// # dev2.restore_migrated_state_mut(*mig, 1).unwrap();
>  /// # assert_eq!(dev2, dev);
>  /// ```
> +///
> +/// More commonly, the trait is derived through the
> +/// [`derive(ToMigrationState)`](qemu_macros::ToMigrationState) procedural
> +/// macro.
>  pub trait ToMigrationState {
>      /// The type used to represent the migrated state.
>      type Migrated: Default + VMState;
> @@ -305,13 +309,17 @@ fn restore_migrated_state(
>  /// It manages the lifecycle of migration state and provides automatic
>  /// conversion between runtime and migration representations.
>  ///
> -/// ```ignore
> +/// ```
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

Outdated comment? Looks like the DeviceRegsMigration definition is
missing.

>  /// pub struct SomeDevice {
>  ///     // ...

...

> +/// Derive macro for generating migration state structures and trait
> +/// implementations.
> +///
> +/// This macro generates a migration state struct and implements the
> +/// `ToMigrationState` trait for the annotated struct, enabling state
> +/// serialization and restoration.  Note that defining a `VMStateDescription`
> +/// for the migration state struct is left to the user.
> +///
> +/// # Container attributes
> +///
> +/// The following attributes can be applied to the struct:
> +///
> +/// - `#[migration_state(rename = CustomName)]` - Customizes the name of the
> +///   generated migration struct. By default, the generated struct is named
> +///   `{OriginalName}Migration`.
> +///
> +/// # Field attributes
> +///
> +/// The following attributes can be applied to individual fields:
> +///
> +/// - `#[migration_state(omit)]` - Excludes the field from the migration state
> +///   entirely.
> +///
> +/// - `#[migration_state(into(Type))]` - Converts the field using `.into()`
> +///   during both serialization and restoration.
> +///
> +/// - `#[migration_state(try_into(Type))]` - Converts the field using
> +///   `.try_into()` during both serialization and restoration. Returns
> +///   `InvalidError` on conversion failure.

Good idea. These conversion modes are very useful, and inspiring.

It may be not necessary for #[property] to integrate into()/try_into()
mode, but the below conversion is ugly:

#[property(rename = "msi", bit = HPET_FLAG_MSI_SUPPORT_SHIFT as u8, default = false)]

conversion should happen within the macro parsing process. But unfortunately,
try_into() is not const, maybe I could do this for bit property:

diff --git a/rust/qemu-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
index c459f9bcb42f..e67df57c3712 100644
--- a/rust/qemu-macros/src/lib.rs
+++ b/rust/qemu-macros/src/lib.rs
@@ -275,7 +275,10 @@ macro_rules! str_to_c_str {
                 name: ::std::ffi::CStr::as_ptr(#prop_name),
                 info: #qdev_prop,
                 offset: ::core::mem::offset_of!(#name, #field_name) as isize,
-                bitnr: #bitnr,
+                bitnr: {
+                    const _: () = assert!(#bitnr <= u8::MAX as _, "bit exceeds u8 range");
+                    #bitnr as u8
+                },
                 set_default: #set_default,
                 defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: #defval as u64 },
                 ..::common::Zeroable::ZERO

> +/// - `#[migration_state(clone)]` - Clones the field value.

How about emphasizing the use case?

"Clones the field value, especially for the types don't implement `Copy`."

> +/// Fields without any attributes use `ToMigrationState` recursively; note that
> +/// this is a simple copy for types that implement `Copy`.
> +///
> +/// # Attribute compatibility
> +///
> +/// - `omit` cannot be used with any other attributes
> +/// - only one of `into(Type)`, `try_into(Type)` can be used, but they can be
> +///   coupled with `clone`.
> +///

...

The implementation of the entire macro is great.

> +#[test]
> +fn test_derive_to_migration_state() {

...

> +        quote! {
> +            #[derive(Default)]
> +            pub struct CustomMigration {
> +                pub shared_data: String,
> +                pub converted_field: Cow<'static, str>,
> +                pub fallible_field: i8,
> +                pub nested_field: <NestedStruct as ToMigrationState>::Migrated,
> +                pub simple_field: <u32 as ToMigrationState>::Migrated,
> +            }

In the production code, CustomMigration still needs to implement VMState
trait, so that String & Cow<'static, str> also need to implement VMState
trait. This seems like the thing that we are currently missing.

For test, it's enough to show how the macro works.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


