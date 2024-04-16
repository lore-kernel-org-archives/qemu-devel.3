Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC05C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 16:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwleX-0002Gv-OR; Tue, 16 Apr 2024 12:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rwleT-0002GS-09
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 12:27:21 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rwleQ-0003Qw-Bg
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 12:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713284838; x=1744820838;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ng9OTjejOyw+pwithlGzX2/iCS0eu7Mo2R60EBJqeA0=;
 b=CFDNFe9PuVT2NrVsqc1TZ9KaT0qCLiyovQZrC5hx2uP1luAR3UHCnEN+
 2AVoTz2FZapsKROJHr0AgdElAyHFtG2+NvFZZs87YM4s2our0omU4U61F
 zgXPWoqSS2P+e0rgVeqar6e3DEntUF7CttWKSr9WDR0Dl/WDvkA5CsFu5
 /g4XaNzvnHQHXSZHHQTVXhfONZ7tp0GN6UwYmxF+hGfw6JrCqniEcmcCO
 Br4WAWIvsdMF1Huz2N33IKkKxFDK9o8zT2xF5D7/sgoB9n3fjMFcWFWP8
 TesTil5W6Qah1fy/h5MZJ9vslY+MPKVuM8+oTKX/DNdeMgV+wvhusI3sP A==;
X-CSE-ConnectionGUID: WGP02pW+TWakTxEvE2FlcA==
X-CSE-MsgGUID: /FqaZiepSouakef65kXxFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="20124633"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; d="scan'208";a="20124633"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2024 09:27:14 -0700
X-CSE-ConnectionGUID: jQ12t00OS2aDnxn8dSR7IA==
X-CSE-MsgGUID: Ntvm5KODRLePodukWvgG0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; d="scan'208";a="22199490"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 16 Apr 2024 09:27:13 -0700
Date: Wed, 17 Apr 2024 00:41:16 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Dave Hello <hsu@peterdavehello.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] Add zh_TW Traditional Chinese translation
Message-ID: <Zh6qLCvyiSk6YkVy@intel.com>
References: <adPv4goMCNmjeDRUK1LGCAHIZdOxvMoFAqlU1bCnvTCPsCTUFRQnOQnThBC3oIzU9IczdS6aw1vKLQ-w7Zk9CRo5FfvINiaInut_U4VwbeI=@peterdavehello.org>
 <CAFEAcA_D1+BUk01mXNwRehxYqyXQU+Zu98sWBujauk5L2tHh3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_D1+BUk01mXNwRehxYqyXQU+Zu98sWBujauk5L2tHh3w@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Hi Peter,

On Tue, Apr 16, 2024 at 02:27:45PM +0100, Peter Maydell wrote:
> Date: Tue, 16 Apr 2024 14:27:45 +0100
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: Re: [PATCH] Add zh_TW Traditional Chinese translation
> 
> On Tue, 16 Apr 2024 at 14:00, Peter Dave Hello <hsu@peterdavehello.org> wrote:
> >
> > From: Peter Dave Hello <hsu@peterdavehello.org>
> > Date: Tue, 16 Apr 2024 00:43:29 +0800
> > Subject: [PATCH] Add a simple zh_TW Traditional Chinese translation
> >
> > This patch adds a basic zh_TW translation file for Taiwan Traditional
> > Chinese users.
> >
> > Signed-off-by: Peter Dave Hello <hsu@peterdavehello.org>
> 
> This name in your Signed-off-by line doesn't match the
> name you use in the .po file...
> 
> > ---
> >  po/LINGUAS  |  1 +
> >  po/zh_TW.po | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 94 insertions(+)
> >  create mode 100644 po/zh_TW.po
> >
> > diff --git a/po/LINGUAS b/po/LINGUAS
> > index 9b33a36..08163e8 100644
> > --- a/po/LINGUAS
> > +++ b/po/LINGUAS
> > @@ -7,3 +7,4 @@ sv
> >  tr
> >  uk
> >  zh_CN
> > +zh_TW
> > diff --git a/po/zh_TW.po b/po/zh_TW.po
> > new file mode 100644
> > index 0000000..d25557e
> > --- /dev/null
> > +++ b/po/zh_TW.po
> > @@ -0,0 +1,93 @@
> > +# Chinese translations for PACKAGE package.
> > +# Copyright (C) 2024 THE PACKAGE'S COPYRIGHT HOLDER
> > +# This file is distributed under the same license as the PACKAGE package.
> 
> Can you replace all these placeholder ALLCAPS items
> with the right values, please?
> 
> > +# Peter Hsu <hsu@peterdavehello.org>, 2024.
> > +#

Open source license is missing here.

And I checked the other .po files and found that none of them declare
the open source license, are they missing it? Or does this case default
to "GPL-2.0-or-later"?

Thanks,
Zhao


