Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B629C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 14:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRYbu-0000xk-UL; Wed, 10 Jul 2024 10:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sRYbp-0000ky-6L
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:47:53 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sRYbl-0001hD-D8
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720622869; x=1752158869;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fD/d8ERF6hOd2bet4lSLB8gCVKV90IUi3IgfNiUuxIQ=;
 b=h+KtKTD+nG+hEKAIQaaNEsZneU+RUqc8UsivO0ynutx2OLes2OF+JL2P
 1nYZDc3I4PvnViiaPTWoD2NjnxpOJNaJMrYNsrX3s/FucT7jlynaMap9y
 r1hJx5G32ShNn455kTMbdLKmxqOTfL9AOihg+Mf8Uah0taY6BfHN8oUJF
 XGrs9d8KMd3tEl4cqbhurqRBzaNQtMbNR5lOiGpcpnIW+t2PC5zPRslUj
 98otPpbGMmN7kc4G17XC70qztpPg/x80AyE77NP6WxGdJxK55sPpnna7X
 +r5lG+o8wN94pAb2Liq1JaxT1TiC0T8RCcrmbb4XekuxDgkDZzcRdY0W7 g==;
X-CSE-ConnectionGUID: CUzAV2ynQzeTsFg/1JRWcg==
X-CSE-MsgGUID: Wg/JSIUmTUWwkRRI7DC+LQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="17768692"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; d="scan'208";a="17768692"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2024 07:47:45 -0700
X-CSE-ConnectionGUID: TgH4nn8HTyOYbu/ilIcFOQ==
X-CSE-MsgGUID: 2PF/y5IEQcKuRd39o+H8+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; d="scan'208";a="53045164"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 10 Jul 2024 07:47:40 -0700
Date: Wed, 10 Jul 2024 23:03:20 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v4 2/7] rust: add bindgen step as a meson dependency
Message-ID: <Zo6iuEfo7o+7SIoY@intel.com>
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <4ce5a7330f594c6c94c8cc3aabceb061095bb855.1720094395.git.manos.pitsidianakis@linaro.org>
 <87msmqsunu.fsf@draig.linaro.org>
 <CAFEAcA9X0564R7V=EsN2qxj51FNNkot3Pfev6mMgUbr35WYFZw@mail.gmail.com>
 <CABgObfbBqHoy4M78NR8EAQ-PV+X86qEK6_ra=tS0_bgqpAt1dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfbBqHoy4M78NR8EAQ-PV+X86qEK6_ra=tS0_bgqpAt1dw@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
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

On Tue, Jul 09, 2024 at 02:28:38PM +0200, Paolo Bonzini wrote:
> 
> Here are the stopping points that I found over the last couple weeks:
> 
> 1.56.0: 2021 edition
> 1.59.0: const CStr::from_bytes_with_nul_unchecked (needed by cstr
> crate, see below)
> 1.64.0: std::ffi::c_char
> 1.65.0: Generic Associated Types
> 1.74.0: Clippy can be configured in Cargo.toml
> 1.77.0: C string literals, offset_of!
> 
> I think 1.59.0 is pretty much the lower bound. Not having offset_of!
> will be a bit painful, but it can be worked around (and pretty much
> has to be, because 1.77.0 is really new).
>

An additional question: does our minimum rust version requirement
indicate that users with this rust version can compile other
dependencies that satisfy QEMU requirements, such as bindgen?

Because I find 1.59.0 can only go to compile bindgen 0.63.0 [1].

[1]: bindgen 0.63.0 MSRV: https://github.com/rust-lang/rust-bindgen/tree/v0.63.0?tab=readme-ov-file#msrv

-Zhao


