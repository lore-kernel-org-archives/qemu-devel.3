Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711E5E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 07:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYKTZ-0005ZD-Qc; Thu, 16 Jan 2025 02:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tYKTH-0005W7-L7
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 02:39:22 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tYKTF-0004SA-BW
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 02:39:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737013157; x=1768549157;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=yqs5Kest30XVewuxUxoRxpGiRu/K6qHIatYSRtqqR2E=;
 b=KEdQ6IsHtWTpK65NLHgm/NLfJuslohWJeqanJ1+eo6oop9La2zivZrRo
 rWk15LSv2IIwQy+OjEUbB5DlRpBg0K0+rRwE0Dmb4X1kdOI6UBh7k9d9f
 N0/MSuNIvJkUOy8lHlr3lLooUSzNrCTVKfMXTljgBLfwkA5KXeeTD4t13
 agemip5ifDPZm9+rCEpbn+3nGHh1M2T/Zjom98LeZ/O4Vk+mN3R7MNrru
 qnTGmw7XJtFY1dA380EN7z/EXqbCMa0DMHv+2Vu4EbJkbnvQzrOgAopo9
 V0TdqJrUdAFmGe7Z86uk4rjZgKLWoWEoWcvqAKaYA/2JxthphwG2uSPDB A==;
X-CSE-ConnectionGUID: 3sCXPSpDSwuojABGP4iO7Q==
X-CSE-MsgGUID: 3g327J70TNGNoyfSwhguhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="48041824"
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; d="scan'208";a="48041824"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2025 23:39:14 -0800
X-CSE-ConnectionGUID: 0Fco6pNfSb6oJXIMBWmu/g==
X-CSE-MsgGUID: IC1kyf1ISCqUzAcDKIfwjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; d="scan'208";a="105942698"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 15 Jan 2025 23:39:12 -0800
Date: Thu, 16 Jan 2025 15:58:03 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] docs/about: Change notes on x86 machine type deprecation
 into a general one
Message-ID: <Z4i8Cx2xZmswBgzm@intel.com>
References: <20250116064644.65670-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116064644.65670-1-thuth@redhat.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1.793,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jan 16, 2025 at 07:46:44AM +0100, Thomas Huth wrote:
> Date: Thu, 16 Jan 2025 07:46:44 +0100
> From: Thomas Huth <thuth@redhat.com>
> Subject: [PATCH] docs/about: Change notes on x86 machine type deprecation
>  into a general one
> 
> We now have a general note about versioned machine types getting
> deprecated and removed at the beginning of the deprecated.rst file,
> so we should also have a general note about this in removed-features.rst
> (which will also apply to versioned non-x86 machine types) instead of
> listing individual old machine types in the document.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/about/deprecated.rst       |  7 -------
>  docs/about/removed-features.rst | 11 +++++------
>  2 files changed, 5 insertions(+), 13 deletions(-)
> 

Sounds good to me, so:

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Let's see if others have any feedback :-)


