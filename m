Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE7EC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 06:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri7Zc-00039X-01; Thu, 07 Mar 2024 01:49:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1ri7Za-00039I-SN
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 01:49:46 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1ri7ZZ-000629-3r
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 01:49:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709794185; x=1741330185;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=IP94U6G5V6a/b2gIRU7XzyvOiVqQ6L0z7EF8CyPcEV0=;
 b=aMOmLudcmMebq1ki99URoJ3oXpwLukAk0h5aqgEshZwPHw5NrdpCwC08
 Ujr1fIs6RKM5W+/Bx/jv2oc2J3IXODZIbx+ve1Zf/ZJm1dF0l+qSLcgyJ
 SfhM+JFuJie0D+welIKQAw61dj/wSu8EF3EpqT3NwCDIiZrd0i3LFR0ZJ
 qg10kl5IQopwSH6jRmdJiv+VlrPnmsYdlSuerRe7mdUY13VOAe7qt3WGV
 /6UmwtjNTfw1okPNqtZRkbSI0A6SNGowgPO8D4yemHPao33vjMqy6C86H
 +zgI6yOfIiVkvScfMI3/tMA9o44MfPb7KSJYXivnvB0tP9x6lW2C40tR1 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="15853910"
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; d="scan'208";a="15853910"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2024 22:49:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; d="scan'208";a="40992648"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 06 Mar 2024 22:49:40 -0800
Date: Thu, 7 Mar 2024 15:03:26 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org,
 Xiaoling Song <xiaoling.song@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 07/14] tests/unit/test-smp-parse: Bump max_cpus to 4096
Message-ID: <ZelmvuFwIuANB7bU@intel.com>
References: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
 <20240306095407.3058909-8-zhao1.liu@linux.intel.com>
 <90b8cc0e-3ad7-4121-8797-41cb65903fa8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90b8cc0e-3ad7-4121-8797-41cb65903fa8@redhat.com>
Received-SPF: none client-ip=192.198.163.10;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
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

Hi Thomas,

> >           /*
> > -         * config: -smp 512
> > +         * config: -smp 4096
> >            * The test machine should tweak the supported max CPUs to
> > -         * 511 (MAX_CPUS - 1) for testing.
> > +         * 4095 (MAX_CPUS - 1) for testing.
> >            */
> > -        .config = SMP_CONFIG_GENERIC(T, MAX_CPUS, F, 0, F, 0, F, 0, F, 0),
> > -        .expect_error = "Invalid SMP CPUs 512. The max CPUs supported "
> > -                        "by machine '" SMP_MACHINE_NAME "' is 511",
> > +        .config = SMP_CONFIG_GENERIC(T, 4096, F, 0, F, 0, F, 0, F, 0),
> > +        .expect_error = "Invalid SMP CPUs 4096. The max CPUs supported "
> 
> You could maybe use stringify(MAX_CPUS) in above line
> (but it won't work for the 4095 below, so it's maybe not worth the effort)

Yes, it's also because of corner cases like 4095 that I don't do such a
thorough cleanup here.
 
> > +                        "by machine '" SMP_MACHINE_NAME "' is 4095",
> >       },
> >   };
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Thanks!

Zhao


