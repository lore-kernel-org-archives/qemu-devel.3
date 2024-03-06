Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6485C54798
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 03:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhhod-0002I3-Is; Tue, 05 Mar 2024 22:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhhob-0002Hv-Tc
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 22:19:33 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhhoa-0002Er-5t
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 22:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709695173; x=1741231173;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=j2U/Y0eTjA1IMULuB9DjlXsruOJ9T7M9iEEiOvFQHlQ=;
 b=iFZqIW35WI3UEJmQBvf/0UcB61L5kl9avr0zyXfJiU9Kr5DrC4nwRwBc
 lGuIhwk2U7caKjNv3StVVcUZ85SyJEd8Sz06Xy8679PaGnhmXg8T6kGpz
 fkju3tqnnuV9S9eNqieG3qBc/I1Ei6uGDUqUDOCbS0mhGwxPXNH4JQXLG
 2i2E/aR23hqw3vxmmy1Baa3rdd52DnIyN2KDSf9vf+NktNZbx+mLOtAGM
 JAAhjKqZ/RglTTNGIrrO84E/YwLCrspaDtA0J0kcdM1NHtVdoB/A2YU4F
 xZvyBEZxHzGhtAl8M6LFOvAigjvp9AmsVfMlMwxVQ0xA4yHwrxWqdn4C/ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="15433663"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="15433663"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2024 19:19:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="10024565"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 05 Mar 2024 19:19:27 -0800
Date: Wed, 6 Mar 2024 11:33:13 +0800
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
Message-ID: <Zefj+boRnrtkxXsE@intel.com>
References: <20240304044510.2305849-1-zhao1.liu@linux.intel.com>
 <CAE8KmOxvZFjtKkHiGGREx_b0QgfDjPWZ7Ex3nqAQQbiPKa_wrQ@mail.gmail.com>
 <ZeVyKMux7Ysjo/lY@intel.com>
 <CAE8KmOxJECe7oNkB1Oiuk-+_4J4drmdJTL2mBzQz+Zu+6XpxrQ@mail.gmail.com>
 <ZebM/2for1NVjeuc@intel.com>
 <CAE8KmOwXrrLe9nCm=8qiyde2M2bg35-1THAhtO4Tg-TrTwRz_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE8KmOwXrrLe9nCm=8qiyde2M2bg35-1THAhtO4Tg-TrTwRz_g@mail.gmail.com>
Received-SPF: none client-ip=198.175.65.13;
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

Hi Prasad,

> On Tue, 5 Mar 2024 at 12:59, Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> > After simple test, if user sets maxcpus as 0, the has_maxcpus will be
> > true as well...I think it's related with QAPI code generation logic.
> 
> * Right.
> 
> [Maybe we digressed a bit in the discussion, so I snipped much of the
> details here. Sorry about that.]
> 
> * "if user sets maxcpus as 0, the has_maxcpus will be true as well",
> ie if 'has_*' fields are always set
> 
>     unsigned maxcpus = config->has_maxcpus ? config->maxcpus : 0;
> 
> then checking 'config->has_maxcpus ?' above is probably not required I
> think. It could just be
> 
>    maxcpus = config->maxcpus

Yes.

> If a user does not specify config->maxcpus with -smp option, then it
> could default to zero(0) in 'config' parameter? (same for other config
> fields)
 
Yes. I could post another series for this cleanup soon.

> * If such change requires API changes (I'm not sure how), then
> probably it is outside the scope of this patch.
> 
> ...wdyt?
>

The above change you suggested doesn't require API changes ;-).

Thanks,
Zhao


