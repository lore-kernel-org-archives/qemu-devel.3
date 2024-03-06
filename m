Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A89CC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 06:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhkXR-00007O-0c; Wed, 06 Mar 2024 01:14:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhkXN-0008NA-Uk
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:13:58 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhkXL-0006iL-JB
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709705636; x=1741241636;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=pGxAaPn4Dp0DsaG9o7fOyGVw9FO6hnBu3dHfNNhiOe0=;
 b=fp7lgQf9jkVVIHipQeuyhReOq9fK/rOvuYa4aDWHdUidi3xzzSitA2JE
 96iAPzseTn6OxhSc+Zmxmqi2CAGteNI5S/qYPvEU3KdI+LWgo64PPWOiI
 IVim0be8TsXLPeaNa4v6I5vb1riCeHYOHHIX5ubJu7YMOD2BRtVuGnMMO
 ml3itN9cckUcvFyWxQ9ul+j+ywroYPMu/xB79tkduKDi38EIpA4Eu3aFv
 kCUujf/p90jHTiob4dIP8rzhhOKmp2vB2P6OB2xCA099aGXfum5sEXDiu
 Q8/RJYBSOFZW+W13NleHp8zdzZ4cBArN7qboMb5BdUDcqo8WhgcubAjJU g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="7243880"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="7243880"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2024 22:13:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="14304164"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 05 Mar 2024 22:13:51 -0800
Date: Wed, 6 Mar 2024 14:27:37 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, devel@lists.libvirt.org,
 qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] hw/core/machine-smp: Remove deprecated "parameter=0" SMP
 configurations
Message-ID: <ZegM2RHPZSc1V059@intel.com>
References: <20240304044510.2305849-1-zhao1.liu@linux.intel.com>
 <CAE8KmOxvZFjtKkHiGGREx_b0QgfDjPWZ7Ex3nqAQQbiPKa_wrQ@mail.gmail.com>
 <ZeVyKMux7Ysjo/lY@intel.com>
 <CAE8KmOxJECe7oNkB1Oiuk-+_4J4drmdJTL2mBzQz+Zu+6XpxrQ@mail.gmail.com>
 <ZebM/2for1NVjeuc@intel.com>
 <CAE8KmOwXrrLe9nCm=8qiyde2M2bg35-1THAhtO4Tg-TrTwRz_g@mail.gmail.com>
 <Zefj+boRnrtkxXsE@intel.com>
 <CAE8KmOxzh7+NZiPAJPpmiKtJxi=uwDcRLVy=PT_ZohuTTWkHvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE8KmOxzh7+NZiPAJPpmiKtJxi=uwDcRLVy=PT_ZohuTTWkHvw@mail.gmail.com>
Received-SPF: none client-ip=192.198.163.13;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Mar 06, 2024 at 10:19:41AM +0530, Prasad Pandit wrote:
> Date: Wed, 6 Mar 2024 10:19:41 +0530
> From: Prasad Pandit <ppandit@redhat.com>
> Subject: Re: [PATCH] hw/core/machine-smp: Remove deprecated "parameter=0"
>  SMP configurations
> 
> Hello Zhao,
> 
> On Wed, 6 Mar 2024 at 08:49, Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> >> then checking 'config->has_maxcpus ?' above is probably not required I
> >> think. It could just be
> >>
> >>    maxcpus = config->maxcpus
> >
> > Yes.
> >
> > > If a user does not specify config->maxcpus with -smp option, then it
> > > could default to zero(0) in 'config' parameter? (same for other config
> > > fields)
> >
> > Yes. I could post another series for this cleanup soon.
> > The above change you suggested doesn't require API changes ;-).
> 
> * Great!  (Communication is the most difficult skill to master. :))
> 
> * If you plan to send a separate patch for above refactoring, then I'd
> add Reviewed-by for this one.
 
Yeah, I will send a series, which will also include this patch, to avoid
trivial smp cleanup fragmentation.

> Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thanks!

-Zhao


