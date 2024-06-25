Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33ABDC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 14:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM6xj-0000uO-11; Tue, 25 Jun 2024 10:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sM6xe-0000rW-Ly
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:15:55 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sM6xa-0003Uz-Ty
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719324952; x=1750860952;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=I3srXga0wNGNFokbzv6aed3xUsaz/KaZZxaaTkWpc0E=;
 b=BqPE10aGwCT1+QvscPZXAqidX3F9jKJ7PEclKlQ9U5O6eZqAL8YnWwq1
 4xd5c8UFXQPfbv6egjUCVDnsZM8+HCiAlJdNI5QnOlFOEdz9zq0gPLB8c
 8iAcE0myx3qxmFjoUlYBBethccQ/25Td0jBrY1UtQT0GGfdccggMyFoQx
 9NR8fTPakHfplIQm0il3QImE0uGIjMJY1zLgFKjQr+OFv8zlVjFuggEIx
 KOKADf8Iugdw0vlUUIqx78rGKEqtcVMcj2GeRfVXqM93y5fmaLZGpALxe
 ZXFTFoiT+LLfn8xZisldCqaSX48C2S5HpAwOSk7zRnZg6TPaBA/i2pOeI Q==;
X-CSE-ConnectionGUID: jtzxIoNMQbiGKqhSG5kFiA==
X-CSE-MsgGUID: OizDBvndRAeh5qBD2l2Waw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16173194"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; d="scan'208";a="16173194"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2024 07:15:48 -0700
X-CSE-ConnectionGUID: f67jgbjHSd+LRalE8IowgQ==
X-CSE-MsgGUID: do+1UBLsRlSTzU+dCJUC0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; d="scan'208";a="43473978"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 25 Jun 2024 07:15:45 -0700
Date: Tue, 25 Jun 2024 22:31:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: EwanHai <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com, rockcui@zhaoxin.com, louisqi@zhaoxin.com
Subject: Re: [PATCH 0/4] Add support for Zhaoxin Yongfeng CPU model and other
 improvements
Message-ID: <ZnrUt0/5CZ2Ww45e@intel.com>
References: <20240625091905.1325205-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625091905.1325205-1-ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

Hi EwanHai,

On Tue, Jun 25, 2024 at 05:19:01AM -0400, EwanHai wrote:
> Date: Tue, 25 Jun 2024 05:19:01 -0400
> From: EwanHai <ewanhai-oc@zhaoxin.com>
> Subject: [PATCH 0/4] Add support for Zhaoxin Yongfeng CPU model and other
>  improvements
> X-Mailer: git-send-email 2.34.1
> 
> This patch series introduces support for the Zhaoxin Yongfeng CPU model and includes
> some improvements and updates related to Zhaoxin and VIA CPUs. The changes ensure that
> QEMU can correctly identify and emulate Zhaoxin CPUs, providing accurate functionality
> and performance characteristics.
> 
>
> ### Summary of Changes
> 
> EwanHai (4):
>   target/i386: Add support for Zhaoxin/VIA CPU vendor identification
>   target/i386: Add CPUID leaf 0xC000_0001 EDX definitions
>   target/i386: Introduce Zhaoxin Yongfeng CPU model
>   target/i386: Update CMPLegacy handling for Zhaoxin and VIA CPUs
> 
>  target/i386/cpu.c | 130 ++++++++++++++++++++++++++++++++++++++++++++--
>  target/i386/cpu.h |  38 ++++++++++++++
>  2 files changed, 165 insertions(+), 3 deletions(-)
> 
> ### Known Bugs
> 
> 1. Issue with VMX Preemption Timer Rate on Yongfeng CPU:
>    - Description: On Yongfeng CPUs, the VMX preemption timer rate is 128, meaning that
>      bits 4:0 of MSR_IA32_VMX_MISC_CTLS should be set to 7. However, due to Intel's rate
>      being 5, the Linux kernel has hardcoded this value as 5:
>      `#define VMX_MISC_EMULATED_PREEMPTION_TIMER_RATE 5`
>    - Impact: This discrepancy can cause incorrect behavior in the VMX preemption timer on
>      Yongfeng CPUs.
>    - Workaround: A patch to correct this issue in the Linux kernel is currently being
>      prepared and will be submitted soon.
>  

Thanks for your patch. Is there some spec/datasheet link that people can
refer to?

Regards,
Zhao


