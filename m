Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC01C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2024 12:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryW67-00030E-7N; Sun, 21 Apr 2024 08:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lkp@intel.com>) id 1ryW63-0002zr-7j
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 08:15:03 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lkp@intel.com>) id 1ryW60-0003Kd-0c
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 08:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713701701; x=1745237701;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=LPPVp3JalpchXXn5VxkxWYPZ6dKa11QDpIhFan31a8w=;
 b=A8Wc89H69uMR9V4sS0dulcMz+LtKja30qdYqVxRojZzGEGNuLIaObqqM
 /fqMNuxwAAX2TK/b51pGcYysRFwsvMX1Q1RfOtpg9wOgn2zE2k3vAKGoe
 MBOli9JQ1AmqJmDGXjkIFCxEDynxLJc55JOgCLHvWfmloEvEp+QJebOdv
 4ACQiGAmwKooFu+3z5pWZm3HQSo2IBSpsiUNtcZISBNRtqE/Dcott5YcZ
 gm7fXotzrMHCQ88AW0YREl2SSYvYyUhdZDUtBDwgKg0UjrBWChtAqALgQ
 LC8PNHzmJZTONPMnVbD6TTvHFp83/D+K+HLpDPG8cbAJkxWW4Qp1J3mj0 g==;
X-CSE-ConnectionGUID: EtlUePbAS3Gm2lUHv9ym+w==
X-CSE-MsgGUID: uT30yN2wRjq9DMDBNlXb8w==
X-IronPort-AV: E=McAfee;i="6600,9927,11050"; a="20386907"
X-IronPort-AV: E=Sophos;i="6.07,218,1708416000"; d="scan'208";a="20386907"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2024 05:14:56 -0700
X-CSE-ConnectionGUID: C0Jeq7A3RpiqZCcgLkMW0w==
X-CSE-MsgGUID: Vu8TxWsvR5ONSzipf1pQHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,218,1708416000"; d="scan'208";a="61205258"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
 by orviesa001.jf.intel.com with ESMTP; 21 Apr 2024 05:14:53 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1ryW5q-000Bu2-15;
 Sun, 21 Apr 2024 12:14:50 +0000
Date: Sun, 21 Apr 2024 20:14:21 +0800
From: kernel test robot <lkp@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jonathan.Cameron@huawei.com,
 dan.j.williams@intel.com, dave@stgolabs.net, ira.weiny@intel.com,
 alison.schofield@intel.com
Subject: Re: [PATCH v3 2/2] cxl/core: add poison creation event handler
Message-ID: <202404212044.uSxtGRtL-lkp@intel.com>
References: <20240417075053.3273543-3-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417075053.3273543-3-ruansy.fnst@fujitsu.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=lkp@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.42,
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

Hi Shiyang,

kernel test robot noticed the following build errors:

[auto build test ERROR on cxl/next]
[also build test ERROR on linus/master v6.9-rc4 next-20240419]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shiyang-Ruan/cxl-core-correct-length-of-DPA-field-masks/20240417-155443
base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
patch link:    https://lore.kernel.org/r/20240417075053.3273543-3-ruansy.fnst%40fujitsu.com
patch subject: [PATCH v3 2/2] cxl/core: add poison creation event handler
config: csky-randconfig-002-20240421 (https://download.01.org/0day-ci/archive/20240421/202404212044.uSxtGRtL-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240421/202404212044.uSxtGRtL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404212044.uSxtGRtL-lkp@intel.com/

All errors (new ones prefixed by >>):

   `.exit.text' referenced in section `__jump_table' of fs/ceph/super.o: defined in discarded section `.exit.text' of fs/ceph/super.o
   `.exit.text' referenced in section `__jump_table' of fs/ceph/super.o: defined in discarded section `.exit.text' of fs/ceph/super.o
   csky-linux-ld: drivers/cxl/core/mbox.o: in function `__cxl_report_poison':
   mbox.c:(.text+0xa12): undefined reference to `cxl_trace_hpa'
>> csky-linux-ld: mbox.c:(.text+0xa44): undefined reference to `cxl_trace_hpa'
   `.exit.text' referenced in section `__jump_table' of drivers/target/target_core_configfs.o: defined in discarded section `.exit.text' of drivers/target/target_core_configfs.o
   `.exit.text' referenced in section `__jump_table' of drivers/target/target_core_configfs.o: defined in discarded section `.exit.text' of drivers/target/target_core_configfs.o
   `.exit.text' referenced in section `__jump_table' of net/ceph/ceph_common.o: defined in discarded section `.exit.text' of net/ceph/ceph_common.o
   `.exit.text' referenced in section `__jump_table' of net/ceph/ceph_common.o: defined in discarded section `.exit.text' of net/ceph/ceph_common.o

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

