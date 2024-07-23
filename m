Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B18C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 06:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW8ut-00031E-8E; Tue, 23 Jul 2024 02:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sW8un-0002z3-CT
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 02:22:25 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sW8ui-0001uB-9Z
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 02:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721715740; x=1753251740;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nxr7+tBuqop0Fy0B97ZVAaydhGMKvdSjcyv2uVlr4Zo=;
 b=hY+gheDkXve5iKRreCmWi+iNXrufEb9XbJtzR9mcK6IsXyDDkpUNkiwR
 HPlXN659CbHfCOh4p+7h+w/en5MIUvvahPl9IdiWe6nRK/rNLndqRATAa
 eLQz9oZfbpypJjaI8v6mwy26DY0g/19j7wmuUTT2GWjj+qcjY4h+tT1mz
 sUXUzWewGxqILeudBNecbPd08k/du0VN2cwjufoaxIysOHeI3ZRWckx9b
 +QtKeXYT6APyq0runeVwS5Z/WKaHcEuNXaytrGBbKlfijx0ndNcLafXMP
 E2sP4V5ZEI+TdA4YRjll8Ri7/0NE/kgRbX6xeyPRZBHNqialcDxXStwd6 g==;
X-CSE-ConnectionGUID: NvWoyEjiRmCiXZK7h8tkBQ==
X-CSE-MsgGUID: CpLElBibS7+m2jCilFZt4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="12661105"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; d="scan'208";a="12661105"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 23:22:16 -0700
X-CSE-ConnectionGUID: JFPvfVizQcmZcKB7UswOQw==
X-CSE-MsgGUID: pJznqixsTTCO4fSl/Nq5hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; d="scan'208";a="56682032"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 22 Jul 2024 23:22:13 -0700
Date: Tue, 23 Jul 2024 14:37:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v5 1/8] build-sys: Add rust feature option
Message-ID: <Zp9PxB4ZyLDgWGtM@intel.com>
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
 <cdba13875d38feb836468a73509d24a88c8332ca.1721648163.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdba13875d38feb836468a73509d24a88c8332ca.1721648163.git.manos.pitsidianakis@linaro.org>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

Hi Manos,

On Mon, Jul 22, 2024 at 02:43:31PM +0300, Manos Pitsidianakis wrote:
> Date: Mon, 22 Jul 2024 14:43:31 +0300
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Subject: [RFC PATCH v5 1/8] build-sys: Add rust feature option
> X-Mailer: git-send-email 2.44.0
> 
> Add rust feature in meson.build, configure, to prepare for adding Rust
> code in the followup commits.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  MAINTAINERS                   |  5 +++++
>  configure                     | 12 ++++++++++++
>  meson.build                   | 17 ++++++++++++++++-
>  Kconfig                       |  1 +
>  Kconfig.host                  |  3 +++
>  meson_options.txt             |  5 +++++
>  rust/Kconfig                  |  0
>  scripts/meson-buildoptions.sh |  3 +++
>  8 files changed, 45 insertions(+), 1 deletion(-)
>  create mode 100644 rust/Kconfig
> 

[snip]

> diff --git a/meson.build b/meson.build
> index a1e51277b0..a3f346ab3c 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -70,6 +70,14 @@ if host_os == 'darwin' and \
>    all_languages += ['objc']
>    objc = meson.get_compiler('objc')
>  endif
> +if get_option('have_rust') and meson.version().version_compare('<1.0.0')
> +  error('Rust support requires Meson version >=1.0.0')
> +endif
> +have_rust = false
> +if not get_option('disable_rust') and add_languages('rust', required: get_option('have_rust'), native: false)
> +  rustc = meson.get_compiler('rust')
> +  have_rust = true
> +endif

Only a nit, "disable_rust" seems redundant, and "have_rust" is enough.

Others LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


