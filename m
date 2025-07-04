Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6B7C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 12:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXfKw-0001UG-EF; Fri, 04 Jul 2025 08:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXfKr-0001LO-Qd; Fri, 04 Jul 2025 08:16:10 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXfKn-00023E-78; Fri, 04 Jul 2025 08:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751631365; x=1783167365;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=AmvNkrWV5AgLDrAVsZEayza3h/QwIDrqw0vEUeEm/go=;
 b=Oq0jXZWJsv65beBu/aDCNiD/EbLHsJOfgei3bUaUmrIu7jzgP0zkYjVF
 nIqgmK2IwNe6gZG2qYcmDhLvim/3e3PZh9BSbRPxIBPAppdP15G20elrJ
 Xp+y4/mTEt0rnSo1a09E9zBYn5oLT8bRoDDHZQGDZMW3cdxlDc+QTXKMp
 PmNbx7oSs3XfOhAQWM55ZrBadYcZgXTReA6edDQVBrVN+2i6VOBciI4x+
 8LKMiQMvH0Ehu2TKVDfmJKZOfn7SnehFfLbtP+UCbihVMlBaeD+ftKORW
 wPJoc1qEDYatOB1lLvJ8M2h3T5tJcmAPs1zmG1ZFhV3W25Tk6Qj9t0P9m Q==;
X-CSE-ConnectionGUID: Gi4xiH9LRbmZFn/LkUFpog==
X-CSE-MsgGUID: zhI+RBCRRqajiGbnHV6RvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64566829"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="64566829"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 05:16:02 -0700
X-CSE-ConnectionGUID: u9NnPIhUR1mrd7ATmrSSDA==
X-CSE-MsgGUID: 6k+/y6DhTs+Da2FCzqRFlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="160305232"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 04 Jul 2025 05:15:59 -0700
Date: Fri, 4 Jul 2025 20:37:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] rust/qemu-api-macros: add unit tests
Message-ID: <aGfLBaW0p528ggCP@intel.com>
References: <20250704-rust_add_derive_macro_unit_tests-v1-0-ebd47fa7f78f@linaro.org>
 <20250704-rust_add_derive_macro_unit_tests-v1-2-ebd47fa7f78f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704-rust_add_derive_macro_unit_tests-v1-2-ebd47fa7f78f@linaro.org>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218,
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

On Fri, Jul 04, 2025 at 01:26:58PM +0300, Manos Pitsidianakis wrote:
> Date: Fri, 04 Jul 2025 13:26:58 +0300
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Subject: [PATCH 2/2] rust/qemu-api-macros: add unit tests
> X-Mailer: b4 0.14.2
> 
> Add unit tests to check Derive macro output for expected error messages,
> or for expected correct codegen output.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  rust/qemu-api-macros/meson.build  |   3 +
>  rust/qemu-api-macros/src/lib.rs   |   3 +
>  rust/qemu-api-macros/src/tests.rs | 135 ++++++++++++++++++++++++++++++++++++++
>  rust/qemu-api-macros/src/utils.rs |   1 +
>  4 files changed, 142 insertions(+)
> 
> diff --git a/rust/qemu-api-macros/meson.build b/rust/qemu-api-macros/meson.build
> index 8610ce1c8440c4b6e38a8462d4975bf76d72fb05..2152bcb99b30e4bdcc1c5b887b7903a37f6181c3 100644
> --- a/rust/qemu-api-macros/meson.build
> +++ b/rust/qemu-api-macros/meson.build
> @@ -17,3 +17,6 @@ _qemu_api_macros_rs = rust.proc_macro(
>  qemu_api_macros = declare_dependency(
>    link_with: _qemu_api_macros_rs,
>  )
> +
> +rust.test('rust-qemu-api-macros-tests', _qemu_api_macros_rs,
> +          suite: ['unit', 'rust'])
> diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
> index 4b30bea9eafc7924bf593113c3f42c5b1010c4b9..6c6e9b683f047f79cb377e6d30e23490f66bd711 100644
> --- a/rust/qemu-api-macros/src/lib.rs
> +++ b/rust/qemu-api-macros/src/lib.rs
> @@ -15,6 +15,9 @@
>  mod bits;
>  use bits::BitsConstInternal;
>  
> +#[cfg(test)]
> +mod tests;
> +
>  fn get_fields<'a>(
>      input: &'a DeriveInput,
>      msg: &str,
> diff --git a/rust/qemu-api-macros/src/tests.rs b/rust/qemu-api-macros/src/tests.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..dfca7d4838f141783472a4e728312aebeb9b5a8b
> --- /dev/null
> +++ b/rust/qemu-api-macros/src/tests.rs
> @@ -0,0 +1,135 @@
> +// Copyright 2025, Linaro Limited
> +// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +use super::*;
> +use quote::quote;
> +
> +macro_rules! derive_compile_fail {
> +    ($derive_fn:ident, $input:expr, $error_msg:expr) => {{
> +        let input: proc_macro2::TokenStream = $input;
> +        let error_msg: &str = $error_msg;
> +        let derive_fn: fn(input: syn::DeriveInput) -> Result<proc_macro2::TokenStream, MacroError> =
> +            $derive_fn;
> +
> +        let input: syn::DeriveInput = syn::parse2(input).unwrap();
> +        let result = derive_fn(input);
> +        let MacroError::Message(err, _) = result.unwrap_err() else {
> +            panic!()
> +        };
> +        assert_eq!(err, error_msg);
> +    }};
> +}
> +
> +macro_rules! derive_compile {
> +    ($derive_fn:ident, $input:expr, $($expected:tt)*) => {{
> +        let input: proc_macro2::TokenStream = $input;
> +        let expected: proc_macro2::TokenStream = $($expected)*;
> +        let derive_fn: fn(input: syn::DeriveInput) -> Result<proc_macro2::TokenStream, MacroError> =
> +            $derive_fn;
> +
> +        let input: syn::DeriveInput = syn::parse2(input).unwrap();
> +        let result = derive_fn(input).unwrap();
> +        assert_eq!(result.to_string(), expected.to_string());
> +    }};
> +}

Good examples to test macros. LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



