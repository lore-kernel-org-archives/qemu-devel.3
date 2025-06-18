Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B04C71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 05:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRlhc-0005Ao-Jj; Wed, 18 Jun 2025 01:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lkp@intel.com>) id 1uRlhZ-0005AU-Os
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 01:51:13 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lkp@intel.com>) id 1uRlhW-0007dH-FQ
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 01:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750225870; x=1781761870;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Ix9bi/fX1Gwx5BysY/tiJbZOcKkeZxk/l1KDBs0K1Ek=;
 b=berCmMMrC0B+wUbqcgOScAW5qZM3ubOpfHcvoR9mlj7WKKJ0GjFXabVW
 WL9tyjpWs6ncs7gFXPnsBoakvfxA5eg7v+OVXjoBXtlgRhkuFrLwQUH2b
 mM1pkFd02sARCr/kQT9Xr6CiOpUhNKeW6HTl5zhx/i6n2AVgB1crrUPjf
 BFsMxpqEQvwRIN9wZgfu74JwxpDpbJzGdxjW7yETPExhy4Jhf2b7QKd1y
 TdV3kOuKy0csz1jh1w/inn+Tgs/LxeU7s/J+3l3r8go952UNnHrzeRHi5
 xw83X9bYIIB2t7mhFDw8f7mhEZ97UloEtwsSjtBO5koO2XL4uIQPdlc+y w==;
X-CSE-ConnectionGUID: 3CIDLIxNQlq2M/nadrUAiw==
X-CSE-MsgGUID: MollWDXCT/uqpUQtTMGxSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52129821"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="52129821"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 22:51:05 -0700
X-CSE-ConnectionGUID: /xobBj0uSjSpdsNqEZHD3g==
X-CSE-MsgGUID: /ZiOOu0qQ5qQbIq3slAqyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="149202862"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
 by orviesa009.jf.intel.com with ESMTP; 17 Jun 2025 22:51:04 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1uRlhM-000JRU-2A;
 Wed, 18 Jun 2025 05:51:00 +0000
Date: Wed, 18 Jun 2025 13:50:19 +0800
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>, Gabriel Somlo <somlo@cmu.edu>,
 "Michael S . Tsirkin" <mst@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Fabian Vogt <fvogt@suse.de>,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH RESEND] firmware: qemu_fw_cfg: Do not hard depend on
 CONFIG_HAS_IOPORT_MAP
Message-ID: <202506181300.OUXh1Amh-lkp@intel.com>
References: <20250616161408.26748-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250616161408.26748-1-tiwai@suse.de>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=lkp@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
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

Hi Takashi,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.16-rc2 next-20250617]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Takashi-Iwai/firmware-qemu_fw_cfg-Do-not-hard-depend-on-CONFIG_HAS_IOPORT_MAP/20250617-001546
base:   linus/master
patch link:    https://lore.kernel.org/r/20250616161408.26748-1-tiwai%40suse.de
patch subject: [PATCH RESEND] firmware: qemu_fw_cfg: Do not hard depend on CONFIG_HAS_IOPORT_MAP
config: arm64-randconfig-r073-20250618 (https://download.01.org/0day-ci/archive/20250618/202506181300.OUXh1Amh-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250618/202506181300.OUXh1Amh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506181300.OUXh1Amh-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/firmware/qemu_fw_cfg.c: In function 'fw_cfg_io_cleanup':
>> drivers/firmware/qemu_fw_cfg.c:207:3: error: implicit declaration of function 'ioport_unmap' [-Werror=implicit-function-declaration]
     207 |   ioport_unmap(fw_cfg_dev_base);
         |   ^~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/ioport_unmap +207 drivers/firmware/qemu_fw_cfg.c

2d6d60a3d3eca5 Marc-André Lureau 2018-02-28  199  
75f3e8e47f3810 Gabriel Somlo     2016-01-28  200  /* clean up fw_cfg device i/o */
75f3e8e47f3810 Gabriel Somlo     2016-01-28  201  static void fw_cfg_io_cleanup(void)
75f3e8e47f3810 Gabriel Somlo     2016-01-28  202  {
75f3e8e47f3810 Gabriel Somlo     2016-01-28  203  	if (fw_cfg_is_mmio) {
75f3e8e47f3810 Gabriel Somlo     2016-01-28  204  		iounmap(fw_cfg_dev_base);
75f3e8e47f3810 Gabriel Somlo     2016-01-28  205  		release_mem_region(fw_cfg_p_base, fw_cfg_p_size);
75f3e8e47f3810 Gabriel Somlo     2016-01-28  206  	} else {
75f3e8e47f3810 Gabriel Somlo     2016-01-28 @207  		ioport_unmap(fw_cfg_dev_base);
75f3e8e47f3810 Gabriel Somlo     2016-01-28  208  		release_region(fw_cfg_p_base, fw_cfg_p_size);
75f3e8e47f3810 Gabriel Somlo     2016-01-28  209  	}
75f3e8e47f3810 Gabriel Somlo     2016-01-28  210  }
75f3e8e47f3810 Gabriel Somlo     2016-01-28  211  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

