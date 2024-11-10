Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA6BD6409B
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 13:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tA8HR-0005nL-1n; Sun, 10 Nov 2024 08:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tA8HP-0005nC-Q8
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 08:47:04 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tA8HN-0007U4-H7
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 08:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731246421; x=1762782421;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=mj8RWUkT099zyRgSs1U7m5aBP9vxolu8PsRl+Yo8xbw=;
 b=J0vriBnIx6PMTojVt/n4R7WCJrbTOA7E5rkQVlCeWIvBv/M9B8m5MB8p
 c/K88z+Va4cuXDeUMTdtOIs27+2Kbz+EYglZWcvXmca1/kbqjHHJRc2+2
 Wnj363fM/TZp3OViM0kMLYt73Mu774I62JEMaKC8wwmHKeGx1luJc5FBK
 DeLOjVZSvAHpWiNCFffKvNl5qSCfeIYxukYrJ8MHvigHwGguT+I589T11
 N9UGU1ujOI7yogi26CWcbStTZ3o7FE5b1gSSsnh/3XFOhnu0QWTDQAYeX
 7RBY/TrMD2j+CjTud+LgrzmnLsf2oUtzopys0UKgY7iXy7ycxDaHrvkek g==;
X-CSE-ConnectionGUID: Imy1mo5uQT2vaQc/eJ+pWw==
X-CSE-MsgGUID: mqlc4oMyT6OZEO7Ff+EGiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="48583983"
X-IronPort-AV: E=Sophos;i="6.12,143,1728975600"; d="scan'208";a="48583983"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2024 05:46:56 -0800
X-CSE-ConnectionGUID: 5MbU2qUGSeqHXP2caah4OQ==
X-CSE-MsgGUID: IfKX+GpTTz6009VOlMsU9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,143,1728975600"; d="scan'208";a="86182106"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 10 Nov 2024 05:46:55 -0800
Date: Sun, 10 Nov 2024 22:04:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>,
 Yongwei Ma <yongwei.ma@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PULL 09/29] qapi/qom: Define cache enumeration and properties
 for machine
Message-ID: <ZzC9hCPd7vbGrGDa@intel.com>
References: <20241105224727.53059-1-philmd@linaro.org>
 <20241105224727.53059-10-philmd@linaro.org>
 <CAFEAcA_+ZSZF1VYFcPRq1AD+i4=nT2RsdVhhaj7wiL4xD=R_-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_+ZSZF1VYFcPRq1AD+i4=nT2RsdVhhaj7wiL4xD=R_-A@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, Nov 08, 2024 at 07:10:42PM +0000, Peter Maydell wrote:
> Date: Fri, 8 Nov 2024 19:10:42 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: Re: [PULL 09/29] qapi/qom: Define cache enumeration and properties
>  for machine
> 
> On Tue, 5 Nov 2024 at 22:49, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> >
> > From: Zhao Liu <zhao1.liu@intel.com>
> >
> > The x86 and ARM need to allow user to configure cache properties
> > (current only topology):
> >  * For x86, the default cache topology model (of max/host CPU) does not
> >    always match the Host's real physical cache topology. Performance can
> >    increase when the configured virtual topology is closer to the
> >    physical topology than a default topology would be.
> >  * For ARM, QEMU can't get the cache topology information from the CPU
> >    registers, then user configuration is necessary. Additionally, the
> >    cache information is also needed for MPAM emulation (for TCG) to
> >    build the right PPTT.
> >
> 
> Hi; Coverity points out an issue with this change (CID 1565389):
> 
> > diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
> > index 5d8d7edcbd3..c6d90cd6d41 100644
> > --- a/hw/core/machine-smp.c
> > +++ b/hw/core/machine-smp.c
> > @@ -261,6 +261,31 @@ void machine_parse_smp_config(MachineState *ms,
> >      }
> >  }
> >
> > +bool machine_parse_smp_cache(MachineState *ms,
> > +                             const SmpCachePropertiesList *caches,
> > +                             Error **errp)
> > +{
> > +    const SmpCachePropertiesList *node;
> > +    DECLARE_BITMAP(caches_bitmap, CACHE_LEVEL_AND_TYPE__MAX);
> 
> DECLARE_BITMAP() defines the caches_bitmap bitmap, but it
> does not initialize it...

Yes, I missed this...

> > +
> > +    for (node = caches; node; node = node->next) {
> > +        /* Prohibit users from repeating settings. */
> > +        if (test_bit(node->value->cache, caches_bitmap)) {
> 
> ...so here we are reading the variable when it is uninitialized.
> 
> If you want to zero-initialize the bitmap you can use
>    bitmap_zero(caches_bitmap, CACHE_LEVEL_AND_TYPE__MAX);

Thank you for your advice! I'll submit a patch to fix this!

Regards,
Zhao


