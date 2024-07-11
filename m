Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0911C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 08:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRoxV-0004aJ-3i; Thu, 11 Jul 2024 04:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sRoxS-0004Rm-BY
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:15:18 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sRoxP-0007aK-TZ
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720685716; x=1752221716;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=7Uj42hfMqHudd60vhmHxt5bqTYUxqnqPrgTxblkBNoI=;
 b=ZTa3FVYpHTinFFLiGhorvyoLen3TdIgTNYCGfga3pD/kDhKR5eOaPYOk
 uRxxpojcf3Iv51tr+8RYG6ES831eCctkYEPNkNhIu+yoxBGu7gfAyoz97
 LTGURe8rAKJjn/502XUotcA5XyaJ0sdBDuGanejHPI/58ay5DYvYJpohV
 ydiieQBRwNRAtO6wifg48Oqm4vCm8ELXEowZ8G/Uf5IKPNR4h8mcSgSXw
 L0Xm/0ES5s7pVagYmrzsSpX0vUEP4lbhbA7VBRpZVm6CIfQiVH4HMGL5g
 haSdjnQ+AkxFUQmt6wDhjqZ5vwa+FmmcVqxx0fzejQ0K9oBsb34/3KO18 w==;
X-CSE-ConnectionGUID: MGJSNzZNRb2aN1HldFIAcw==
X-CSE-MsgGUID: h2SuhlAzR7OBVvW1ePwJ5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="43469396"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; d="scan'208";a="43469396"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2024 01:15:11 -0700
X-CSE-ConnectionGUID: ZXtUn92IR3WOut6cQXIikQ==
X-CSE-MsgGUID: Dz+7quAgQwGn+VvzT44KYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; d="scan'208";a="52866781"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 11 Jul 2024 01:15:07 -0700
Date: Thu, 11 Jul 2024 16:30:46 +0800
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
Message-ID: <Zo+YNnP+QEdL/Dik@intel.com>
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <4ce5a7330f594c6c94c8cc3aabceb061095bb855.1720094395.git.manos.pitsidianakis@linaro.org>
 <87msmqsunu.fsf@draig.linaro.org>
 <CAFEAcA9X0564R7V=EsN2qxj51FNNkot3Pfev6mMgUbr35WYFZw@mail.gmail.com>
 <CABgObfbBqHoy4M78NR8EAQ-PV+X86qEK6_ra=tS0_bgqpAt1dw@mail.gmail.com>
 <Zo6iuEfo7o+7SIoY@intel.com>
 <CABgObfZGLd5Uj9CV-8v=QdGFjN53ZUKhqXjobzpk7tJjYYZj1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfZGLd5Uj9CV-8v=QdGFjN53ZUKhqXjobzpk7tJjYYZj1A@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
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

On Wed, Jul 10, 2024 at 04:50:10PM +0200, Paolo Bonzini wrote:
> Date: Wed, 10 Jul 2024 16:50:10 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [RFC PATCH v4 2/7] rust: add bindgen step as a meson dependency
> 
> On Wed, Jul 10, 2024 at 4:48 PM Zhao Liu <zhao1.liu@intel.com> wrote:
> >
> > On Tue, Jul 09, 2024 at 02:28:38PM +0200, Paolo Bonzini wrote:
> > >
> > > Here are the stopping points that I found over the last couple weeks:
> > >
> > > 1.56.0: 2021 edition
> > > 1.59.0: const CStr::from_bytes_with_nul_unchecked (needed by cstr
> > > crate, see below)
> > > 1.64.0: std::ffi::c_char
> > > 1.65.0: Generic Associated Types
> > > 1.74.0: Clippy can be configured in Cargo.toml
> > > 1.77.0: C string literals, offset_of!
> > >
> > > I think 1.59.0 is pretty much the lower bound. Not having offset_of!
> > > will be a bit painful, but it can be worked around (and pretty much
> > > has to be, because 1.77.0 is really new).
> > >
> >
> > An additional question: does our minimum rust version requirement
> > indicate that users with this rust version can compile other
> > dependencies that satisfy QEMU requirements, such as bindgen?
> 
> Yes (though in the case of bindgen, like cargo and rustc, we'll use it
> from the distro; Debian bookworm has 0.60.1 so that's what we'll have
> to stick with).
>

I just did some build tests to hopefully help Manos clarify the gap.

With 1.59.0 rust and 0.60.1 bindgen, I found the big problem is this
version can't support current external crates ("bilge" and
"arbitrary-int").

The lowest possible version of bilge is 0.1.1 (because 0.1.0 contains the
removed unstable feature), but v0.1.1 bilge depends on arbitrary-int
(lowest bound is 1.2.4), which is not supported by v1.59.0 rust. So for
this case either we have to keep raising the minimum rust version, or we
have to reconsider the external crates.

And with 1.63.0, the main problem is core_ffi_c is unstable (once_cell
doesn't matter since it's unneeded). Roughly speaking, it seems that if
we didn't have to use the c type as parameters, this problem could
possibly be worked around.

So maybe 1.63.0 is the proper minimum version and this is aligned with
Debian bullseye.



