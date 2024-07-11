Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72E6C3271E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 04:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRl3w-000527-LI; Thu, 11 Jul 2024 00:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sRl3u-000519-My
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 00:05:42 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sRl3s-0000TT-1D
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 00:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720670740; x=1752206740;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Wsi70F8liq6MA5rM/b7m9HQj9gTWlMscq8b+UVmfI8Y=;
 b=W5zQ76NdKeh1fjg1okLkaNhLMk0pknBvNJ8zBRIfuDRZDfzgEd1JZ9hG
 KWrKnWiul2HA6Cqn9Q1uEGxzYx2++5q1xU4I3bSWpPTEQ7kqrNBAii61u
 ilHmajTocuiGWFxBxWLHmKMeSIi+LHC2jUhui/fStH0Ty6cquusoWzQnC
 Pjw3Y0t4vQUNKlgPqWaziHTYrrG4A2RHZABhS4/zwXxzyagnwUrehU3kL
 aptTYl3PjR12uiL+nJVncZE+OlL4IBP4txQnIJk8tOIva/UBBj4N0ctzL
 7d2i8ZiDGEfbQwlHonJkhhNJCURgEd8DxxCcEqyKy+x/9cRiRfJUAFZFF w==;
X-CSE-ConnectionGUID: 2/hEEdcpQwS0fqOW/m7cbA==
X-CSE-MsgGUID: vNPG5FH9Ti270SFf6HejAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="21901991"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; d="scan'208";a="21901991"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2024 21:05:36 -0700
X-CSE-ConnectionGUID: BtmQrcE5SVGTfm/NNb/l8A==
X-CSE-MsgGUID: bfS+yvsGRjegY+E6l4849A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; d="scan'208";a="48509874"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 10 Jul 2024 21:05:33 -0700
Date: Thu, 11 Jul 2024 12:21:13 +0800
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
Message-ID: <Zo9duWzshTd30EZd@intel.com>
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Manos and all,

On Tue, Jun 11, 2024 at 01:33:32PM +0300, Manos Pitsidianakis wrote:
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

I find it's stiil necessary to strictly limit the width of the lines by
"error_on_line_overflow = true" [1].

Currently rustfmt defaults the width limitation with "max_width = 100",
but it has bugs and doesn't always work. For example, the line of
rust/qemu-api/src/device_class.rs:108 comes to 157 characters and is
ignored by rustfmt, which doesn't even fit in one line of my screen!

Of course I think it's feasible to manually review and fix similar cases,
but it's definitely better to have readily available tool that can help
us rigorously formatted...

[1]: https://github.com/rust-lang/rustfmt/blob/master/Configurations.md#error_on_line_overflow

-Zhao


