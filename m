Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA23CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 05:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwwnC-0000zp-Po; Fri, 12 Sep 2025 01:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uwwnA-0000zM-48
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 01:57:52 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uwwn8-0003pK-Ag
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 01:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757656670; x=1789192670;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5hg2mWTWlH6GipyyvRx7sHhTjqd6+ezHH8qfKPsm0ss=;
 b=bpwulalL4JPbLzvnvDQtzbh2O+ueRqtS8Wj1c5/IJ7g6UgwAOfbIWc1X
 H6ieDUPp2rWgxL6ca4Cqj+MfJk9W0yJAnKiivTyNR4CzGKyBXUwq2b5FW
 rODwWMUhocKFeNgQIDqzIOCTuDrH9Bg7k/fsGOxPDvfG7a/sYIna5RqUM
 WEn61e4UZY/wMdSqusMKDDPd4YyLmmZeRV3iDu+0iyJWH1FruABUt1twC
 T6XyWGxc0gYxTlHlzwF/ci5KlAFDjKvuFaKL6L7p/W5eyuENRO6PZmtor
 E4FUvT3MRBIbahmjG+90jQL1jf5X4/HcxfVt044QHYgFPffgykUnm05oA A==;
X-CSE-ConnectionGUID: 7Q+UZIz4RC2qim3YIF15Tw==
X-CSE-MsgGUID: 6toslNDGTGiivS7a43GRBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="59695250"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="59695250"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 22:57:47 -0700
X-CSE-ConnectionGUID: 2Hxq9EHBTPOUA9ajlEXjeQ==
X-CSE-MsgGUID: l6lUUnb+SE2eFR+57Inrww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="174272634"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 22:57:45 -0700
Message-ID: <9242e7c6-be5c-4043-80b6-908b4297994e@intel.com>
Date: Fri, 12 Sep 2025 13:57:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] qemu-optios: Fix, cleanup and add description of
 tdx-guest
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250714091953.448226-1-xiaoyao.li@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250714091953.448226-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/14/2025 5:19 PM, Xiaoyao Li wrote:
> Patch 1 is the fix to generated doc html.
> 
> Patch 2-4 are the cleanup of memory-encryption
> 
> Patch 5 add description of tdx-guest.

Gentle ping.

Appreciated if anyone could help cc the folks who are responsible for 
the qemu-option but I missed to cc.

> Xiaoyao Li (5):
>    qemu-options: Move sgx-epc options from "M" to "machine"
>    i386/sev: Remove the example that references memory-encryption
>    qemu-options: Change memory-encryption to confidential-guest-support
>      in the example
>    qemu-options: Add confidential-guest-support to machine options
>    qemu-options: Add description of tdx-guest object
> 
>   qemu-options.hx   | 66 ++++++++++++++++++++++++++++++++++++++---------
>   target/i386/sev.c |  4 ---
>   2 files changed, 54 insertions(+), 16 deletions(-)
> 


