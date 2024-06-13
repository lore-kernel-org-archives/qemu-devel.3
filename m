Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D44C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 08:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHfcF-0006cK-1L; Thu, 13 Jun 2024 04:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sHfcE-0006cA-4k
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:15:26 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sHfcA-0001L0-F2
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718266522; x=1749802522;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7IKR19ayympX7WKeS0vHrb/DbWgWoboRrJ4p5h/0qkU=;
 b=C3QBfBpYczU8INIJGqUxF4KA3MiQd3jHCSvNEkKd5Ym3ocOU9VbsG9wI
 gweg9lBOao0xY/j0DkRRVsOopSDntZ2NlxSVSWofPbhAwUTGXZifFkpu1
 o3Ey+tq/mIfzX8P4RXzDtHgCb7LLa/eF8sgV+rK8UnIhrW8D2phUw/wne
 A0hK/IQJ4fFCezUWeFuiTSiI33Cg4qaowlDJ3L4tMyPqrFteWoYE9k6ci
 amPNCKUIW48DxMj7ujqP1lVbfTSTkF9g+qd8FIFT3+o95Ac2ZmAVxl33R
 WmtaR++lgDBzLHf6kpfTSjjNoWqLVsW4VnaVk+KOA30YnrxzR9Jo0UYJ0 w==;
X-CSE-ConnectionGUID: NqHIHiaBQGObs5+V/Qwssw==
X-CSE-MsgGUID: Uf+h6cpIRI2UbqRt3k9vJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="15197641"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="15197641"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2024 01:15:19 -0700
X-CSE-ConnectionGUID: v9xmRuCGQKutqsLYM8+9Dw==
X-CSE-MsgGUID: /AGM21LtQQ64cnof1exuRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="70851494"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 13 Jun 2024 01:15:15 -0700
Date: Thu, 13 Jun 2024 16:30:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
Message-ID: <ZmquNSnnVSdOe0Z3@intel.com>
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jun 11, 2024 at 01:33:32PM +0300, Manos Pitsidianakis wrote:
> Date: Tue, 11 Jun 2024 13:33:32 +0300
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Subject: [RFC PATCH v2 3/5] rust: add PL011 device model
> X-Mailer: git-send-email 2.44.0
> 
> This commit adds a re-implementation of hw/char/pl011.c in Rust.
> 
> It uses generated Rust bindings (produced by `ninja
> aarch64-softmmu-generated.rs`) to
> register itself as a QOM type/class.
> 
> How to build:
> 
> 1. Make sure rust, cargo and bindgen (cargo install bindgen-cli) are
>    installed
> 2. Configure a QEMU build with:
>    --enable-system --target-list=aarch64-softmmu --enable-with-rust
> 3. Launching a VM with qemu-system-aarch64 should use the Rust version
>    of the pl011 device (unless it is not set up so in hw/arm/virt.c; the
>    type of the UART device is hardcoded).
> 
>    To confirm, inspect `info qom-tree` in the monitor and look for an
>    `x-pl011-rust` device.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---

Hi Manos,

Thanks for your example!

> diff --git a/rust/pl011/Cargo.toml b/rust/pl011/Cargo.toml
> new file mode 100644
> index 0000000000..db74f2b59f
> --- /dev/null
> +++ b/rust/pl011/Cargo.toml
> @@ -0,0 +1,66 @@

...

> +[lints]
> +[lints.rustdoc]
> +broken_intra_doc_links = "deny"
> +redundant_explicit_links = "deny"
> +[lints.clippy]
> +# lint groups
> +correctness = { level = "deny", priority = -1 }
> +suspicious = { level = "deny", priority = -1 }
> +complexity = { level = "deny", priority = -1 }
> +perf = { level = "deny", priority = -1 }
> +cargo = { level = "deny", priority = -1 }
> +nursery = { level = "deny", priority = -1 }
> +style = { level = "deny", priority = -1 }
> +# restriction group
> +dbg_macro = "deny"
> +rc_buffer = "deny"
> +as_underscore = "deny"
> +assertions_on_result_states = "deny"
> +# pedantic group
> +doc_markdown = "deny"
> +expect_fun_call = "deny"
> +borrow_as_ptr = "deny"
> +case_sensitive_file_extension_comparisons = "deny"
> +cast_lossless = "deny"
> +cast_ptr_alignment = "allow"
> +large_futures = "deny"
> +waker_clone_wake = "deny"
> +unused_enumerate_index = "deny"
> +unnecessary_fallible_conversions = "deny"
> +struct_field_names = "deny"
> +manual_hash_one = "deny"
> +into_iter_without_iter = "deny"
> +option_if_let_else = "deny"
> +missing_const_for_fn = "deny"
> +significant_drop_tightening = "deny"
> +multiple_crate_versions = "deny"
> +significant_drop_in_scrutinee = "deny"
> +cognitive_complexity = "deny"
> +missing_safety_doc = "allow"

...

> diff --git a/rust/pl011/rustfmt.toml b/rust/pl011/rustfmt.toml
> new file mode 120000
> index 0000000000..39f97b043b
> --- /dev/null
> +++ b/rust/pl011/rustfmt.toml
> @@ -0,0 +1 @@
> +../rustfmt.toml

...

> diff --git a/rust/rustfmt.toml b/rust/rustfmt.toml
> new file mode 100644
> index 0000000000..ebecb99fe0
> --- /dev/null
> +++ b/rust/rustfmt.toml
> @@ -0,0 +1,7 @@
> +edition = "2021"
> +format_generated_files = false
> +format_code_in_doc_comments = true
> +format_strings = true
> +imports_granularity = "Crate"
> +group_imports = "StdExternalCrate"
> +wrap_comments = true
> 

About the Rust style, inspired from the discussion on my previous
simpletrace-rust [1], it looks like people prefer the default rust style
and use the default check without custom configurations.

More style requirements are also an open, especially for unstable ones,
and it would be better to split this part into a separate patch, so that
the discussion about style doesn't overshadow the focus on your example.

[1]: https://lore.kernel.org/qemu-devel/ZlnBGwk29Ds9FjUA@redhat.com/

Regards,
Zhao



