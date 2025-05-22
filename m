Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDD2C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 10:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI3bi-0005jK-La; Thu, 22 May 2025 06:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uI3bf-0005iY-Os; Thu, 22 May 2025 06:56:59 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uI3bc-0001Wi-Bk; Thu, 22 May 2025 06:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747911416; x=1779447416;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=t8sr7c7hiIP7wZ66gzMBP9SBHFOuVLDvQZo4Bab0+QQ=;
 b=MaZyTFpSn9/vkdY/FtEDSav8XQCF1mtfKrc8TSy+iXCjRDf0CmtQssWY
 XRRav+oO+fuQHqKo2UjuAah6gFqwF+97jGmewtHta1HWXtQTZHWmnR2gk
 /wzbhH/Ck//3BXUL9afqYjbxbQAntcwXQeDyuVpH1VAVyzRk83EqzEpex
 WE2dm5wUdMA/e7VaJ/cuzxuuiEq6qufOOrbJG9LpOeCTnuJGS5YEE3wuY
 1shMChs4AtlI1nbhSynN0cm+mA8XWWBNC96Gau6zz6zBJZq/9NagMaZT3
 hcz9xL72KMRon65FI0Vv59UYk0TQoHLXlGT2a3s5uAgaiPmP3cPvWNb4m g==;
X-CSE-ConnectionGUID: fUL4EdGcQUqF8WTpHsdvCQ==
X-CSE-MsgGUID: rp+K4JsQQQuU43NPT5MEbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="75326304"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; d="scan'208";a="75326304"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2025 03:56:51 -0700
X-CSE-ConnectionGUID: pdwsIGsGSHSKqv9Ok/t8lQ==
X-CSE-MsgGUID: BdQhrkHcQiqcNhHMtNWh2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; d="scan'208";a="145691366"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 22 May 2025 03:56:49 -0700
Date: Thu, 22 May 2025 19:17:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH WIP RFC] rust: add qdev DeviceProperties derive macro
Message-ID: <aC8H5LOQSac7mdaE@intel.com>
References: <20250522-rust-qdev-properties-v1-1-5b18b218bad1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522-rust-qdev-properties-v1-1-5b18b218bad1@linaro.org>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
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

On Thu, May 22, 2025 at 11:12:30AM +0300, Manos Pitsidianakis wrote:
> Date: Thu, 22 May 2025 11:12:30 +0300
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Subject: [PATCH WIP RFC] rust: add qdev DeviceProperties derive macro
> X-Mailer: b4 0.14.2
> 
> Add derive macro for declaring qdev properties directly above the field
> definitions. To do this, we split DeviceImpl::properties method on a
> separate trait so we can implement only that part in the derive macro
> expansion (we cannot partially implement the DeviceImpl trait).
> 
> Adding a `property` attribute above the field declaration will generate
> a `qemu_api::bindings::Property` array member in the device's property
> list.
> 
> As a proof of concept, I added a typed alias for booleans,
> `bool_property` that allows you to skip specifying qdev_prop_bool.
> 
> This is unnecessary though, because once we have the
> const_refs_to_static feature we can introduce a QdevProp trait that
> returns a reference to a type's qdev_prop_* global variable. We cannot
> do this now because for our minimum Rust version we cannot refer to
> statics from const values.
> 
> It'd look like this:
> 
>   pub trait QDevProp {
>     const VALUE: &'static bindings::PropertyInfo;
>   }
> 
>   impl QDevProp for bool {
>     const VALUE: &'static bindings::PropertyInfo = unsafe {
>       &bindings::qdev_prop_bool };
>   }
> 
>   impl QDevProp for u64 {
>     const VALUE: &'static bindings::PropertyInfo = unsafe {
>       &bindings::qdev_prop_uint64 };
>   }
> 
>   // etc.. for all basic types

Good idea! We can have something like current impl_vmstate_scalar.

> So, this patch is not for merging yet, I will wait until we upgrade the
> Rust version and re-spin it with a proper trait-based implementation (and
> also split it into individual steps/patches).

I think this can be aligned with Paolo's optimization for vmstate [*]

[*]: https://lore.kernel.org/qemu-devel/20250505100854.73936-5-pbonzini@redhat.com/

> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  rust/hw/char/pl011/src/device.rs       |  13 +--
>  rust/hw/char/pl011/src/device_class.rs |  26 +-----
>  rust/hw/timer/hpet/src/hpet.rs         |   4 +-
>  rust/qemu-api-macros/src/lib.rs        | 157 ++++++++++++++++++++++++++++++++-
>  rust/qemu-api/src/qdev.rs              |  22 +++--
>  rust/qemu-api/tests/tests.rs           |   9 +-
>  6 files changed, 187 insertions(+), 44 deletions(-)

...

>  #[repr(C)]
> -#[derive(qemu_api_macros::Object)]
> +#[derive(qemu_api_macros::Object, qemu_api_macros::DeviceProperties)]
>  /// PL011 Device Model in QEMU
>  pub struct PL011State {
>      pub parent_obj: ParentField<SysBusDevice>,
>      pub iomem: MemoryRegion,
>      #[doc(alias = "chr")]
> +    #[property(name = c"chardev", qdev_prop = qemu_api::bindings::qdev_prop_chr)]

This macro pattern looks good!

As you mentioned above, with QDevProp, this could be nicer so that user
wouldn't have to bind type and PropertyInfo manually.

>      pub char_backend: CharBackend,
>      pub regs: BqlRefCell<PL011Registers>,
>      /// QEMU interrupts
> @@ -122,6 +126,7 @@ pub struct PL011State {
>      #[doc(alias = "clk")]
>      pub clock: Owned<Clock>,
>      #[doc(alias = "migrate_clk")]
> +    #[bool_property(name = c"migrate-clk", default = true)]
>      pub migrate_clock: bool,
>  }
>  
> @@ -169,9 +174,6 @@ impl ObjectImpl for PL011State {
>  }
>  
>  impl DeviceImpl for PL011State {
> -    fn properties() -> &'static [Property] {
> -        &device_class::PL011_PROPERTIES
> -    }
>      fn vmsd() -> Option<&'static VMStateDescription> {
>          Some(&device_class::VMSTATE_PL011)
>      }
> @@ -703,6 +705,7 @@ impl PL011Impl for PL011Luminary {
>      const DEVICE_ID: DeviceId = DeviceId(&[0x11, 0x00, 0x18, 0x01, 0x0d, 0xf0, 0x05, 0xb1]);
>  }
>  
> +impl DevicePropertiesImpl for PL011Luminary {}
>  impl DeviceImpl for PL011Luminary {}
>  impl ResettablePhasesImpl for PL011Luminary {}
>  impl SysBusDeviceImpl for PL011Luminary {}

...

> diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
> index 1279d7a58d50e1bf6c8d2e6f00d7229bbb19e003..2fd8b2750ffabcaa1065558d38a700e35fbc9136 100644
> --- a/rust/qemu-api/src/qdev.rs
> +++ b/rust/qemu-api/src/qdev.rs
> @@ -100,8 +100,19 @@ pub trait ResettablePhasesImpl {
>      T::EXIT.unwrap()(unsafe { state.as_ref() }, typ);
>  }
>  
> +pub trait DevicePropertiesImpl {
> +    /// An array providing the properties that the user can set on the
> +    /// device.  Not a `const` because referencing statics in constants
> +    /// is unstable until Rust 1.83.0.
> +    fn properties() -> &'static [Property] {
> +        &[]
> +    }
> +}
> +
>  /// Trait providing the contents of [`DeviceClass`].
> -pub trait DeviceImpl: ObjectImpl + ResettablePhasesImpl + IsA<DeviceState> {
> +pub trait DeviceImpl:
> +    ObjectImpl + ResettablePhasesImpl + DevicePropertiesImpl + IsA<DeviceState>
> +{

DeviceImpl has a new bound: DevicePropertiesImpl, which means that
devices that don't need properties also need to implement the empty
DevicePropertiesImpl.

We now have ResettablePhasesImpl that needs to do this, but I'm not sure
if we should continue to add more examples?

>      /// _Realization_ is the second stage of device creation. It contains
>      /// all operations that depend on device properties and can fail (note:
>      /// this is not yet supported for Rust devices).
> @@ -110,13 +121,6 @@ pub trait DeviceImpl: ObjectImpl + ResettablePhasesImpl + IsA<DeviceState> {
>      /// with the function pointed to by `REALIZE`.
>      const REALIZE: Option<fn(&Self)> = None;
>  
> -    /// An array providing the properties that the user can set on the
> -    /// device.  Not a `const` because referencing statics in constants
> -    /// is unstable until Rust 1.83.0.
> -    fn properties() -> &'static [Property] {
> -        &[]
> -    }
> -

This default empty Property array looks more convenient than this:

impl DevicePropertiesImpl for DummyChildState {}

However, if there's no way to avoid adding DevicePropertiesImpl, the
cost of an empty trait could be acceptable relative to the benefit of
this more friendly macro, I think!

Thanks,
Zhao

>      /// A `VMStateDescription` providing the migration format for the device
>      /// Not a `const` because referencing statics in constants is unstable
>      /// until Rust 1.83.0.
> @@ -171,7 +175,7 @@ pub fn class_init<T: DeviceImpl>(&mut self) {
>          if let Some(vmsd) = <T as DeviceImpl>::vmsd() {
>              self.vmsd = vmsd;
>          }
> -        let prop = <T as DeviceImpl>::properties();
> +        let prop = <T as DevicePropertiesImpl>::properties();
>          if !prop.is_empty() {
>              unsafe {
>                  bindings::device_class_set_props_n(self, prop.as_ptr(), prop.len());

