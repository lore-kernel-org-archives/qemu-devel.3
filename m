Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8033DC27C5E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2JT-0003y1-UZ; Tue, 11 Jun 2024 10:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sH2JQ-0003xA-DK
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:17:25 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sH2JN-0004Kj-UR
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718115442; x=1749651442;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jqDDKMRFFi6HkBd6s3niITdbCbZfM15NbjMG5/evPQc=;
 b=V8jXnVd6dMXdzzAE1aru514JP0t4VTlup7tf6nLt9zx/dC3XV/0cHHTQ
 DhKcaXTutqW/GaXeI/zz9ydosgGMv/ix7qOPt/yM2LxZ/seQHh9QXi6cb
 VkH03MJkmf8GS1Z7QVG90ycq7foifzdog6qiHvVFZHWQgVhmNMzaOJjDV
 U3dgDX+RpkDBtiSZyy9rwfjUPg2mMuUW2IKwRP5rbPOsqe993dOEBQ+U1
 HsofkKD7yLAVyrjh8ATZtyZPpmwTV8nVPGijqUyEeFX5q1ixSH96w5AiA
 TKeUHQXr7Ni8h8yMCSoOcdcPHPGivauqQddtxuWhA7hZCRStSLA3oW1NX g==;
X-CSE-ConnectionGUID: boe/NNcOScCBgNeGQUH87A==
X-CSE-MsgGUID: M9GbmfVWSw687IPqECdUtg==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="18610017"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; d="scan'208";a="18610017"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2024 07:17:19 -0700
X-CSE-ConnectionGUID: yV+QtZNsRPCgZkXWmXhC6A==
X-CSE-MsgGUID: EcRAVimzQVu+MxHq7Kt+IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; d="scan'208";a="39535649"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 11 Jun 2024 07:17:16 -0700
Date: Tue, 11 Jun 2024 22:32:44 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?=  <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9?= e <alex.bennee@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
Message-ID: <ZmhgDBbsdHn35otx@intel.com>
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <ZmgJVGMx81aHjg5f@redhat.com> <ZmgcrSYHwA0Z8Asq@intel.com>
 <ewwqb.egyl58j8s5u@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ewwqb.egyl58j8s5u@linaro.org>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

On Tue, Jun 11, 2024 at 01:41:57PM +0300, Manos Pitsidianakis wrote:
> Date: Tue, 11 Jun 2024 13:41:57 +0300
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
> 
> > Currently, pl011 exclusively occupies a cargo as a package. In the
> > future, will other Rust implementations utilize the workspace mechanism
> > to act as a second package in the same cargo? Or will new cargo be created
> > again?
> 
> What do you mean by "new cargo"? I didn't catch that :(
> 
> A workspace would make sense if we have "general" crate libraries that
> hardware crates depend on.

Thanks Manos!

I mean if we spread the rust device across the QEMU submodules, wouldn't
we have to create their own cargo directories (aka single-package cargo)
for each rust device?

However, if the Rust code is all centralized under the /Rust directory,
then it can be managed by multiple-packages in cargo workspace. 

About the "general" crate, I'm not sure whether a base lib to manage
external crates is a good idea, like I replied in [1].

[1]: https://lore.kernel.org/qemu-devel/CAJSP0QWLe6yPDE3rPztx=oS0g+vKT9W3GykrNU0EQZcaW06sog@mail.gmail.com/T/#mfaf9abf06ed82dd7f8ce5e7520bbb4447083b550

> > 
> > Under a unified Rust directory, using a workspace to manage multiple
> > packages looks as if it would be easier to maintain. Decentralized to an
> > existing directory, they're all separate cargos, and external dependencies
> > tend to become fragmented?
> 
> Hmm potentially yes, but that's a "what if" scenario. Let's worry about that
> bridge when we cross it!
>

Yes!



