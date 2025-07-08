Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8E7C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFCg-0007uB-0p; Tue, 08 Jul 2025 16:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uZDqm-000761-IC
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:19:38 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uZDqg-00088X-VU
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752002367; x=1783538367;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=DOWBNkJ3FXhDMjaVX1XrR48Cz6mtSyrhJrNzdwWEYhc=;
 b=BpDx0oqS7fjm3QaIp6EzDNkqh978MKVxbDCbb9xc/i+gMT3Rlvnea6KS
 V5ZBLbnHhcyHqdXa42WT3aRuxH2I3nKPJ6jbSmNCWIIE726WPyCSXd9SW
 YYcopBrYIDPYx1RL15lNTFMpR7CGLVTdfiVekfC4jYxMS0Ox13gYmGamh
 S0dM+bHcHeK1mFQ2RamiqHLJFzGTdn6sOs8IxLQRRpDorRZny+r2VMgPt
 D6lFVpnCS/Ai97AvOrr/40pYDpIddCdtyxm8RDptkn0SYM4q1i8zP0fhf
 S6H1Ywh1Ic+9p8uLEGrCpoQe/WzeWcO0UHU6Y1Bj/lReQ130QigkY4PkV A==;
X-CSE-ConnectionGUID: twGVuIRgQf++s+rtU0fpcg==
X-CSE-MsgGUID: IQZhJZ/vSN6vkjUxd0Qw5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="57994507"
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; d="scan'208";a="57994507"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 01:24:48 -0700
X-CSE-ConnectionGUID: AFZqXPakR76Bmh1QlF8MLw==
X-CSE-MsgGUID: IBAijQJJRHWK8QOPBsPYNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; d="scan'208";a="159475782"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 08 Jul 2025 01:24:47 -0700
Date: Tue, 8 Jul 2025 16:46:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 tao1.su@intel.com, chenyi.qiang@intel.com
Subject: Re: [PATCH v2] i386/cpu: Remove FEAT_24_0_EBX for AVX10
Message-ID: <aGza1j4QaivzC9W7@intel.com>
References: <20250707141151.4187798-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707141151.4187798-1-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jul 07, 2025 at 10:11:51PM +0800, Xiaoyao Li wrote:
> Date: Mon, 7 Jul 2025 22:11:51 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v2] i386/cpu: Remove FEAT_24_0_EBX for AVX10
> X-Mailer: git-send-email 2.43.0
> 
> It turns out that all the Intel processors enumerating the support of
> Intel AVX10 support all vector widths. It's documented in the latest
> SDM, vol 1, Chapter 16 "programming with Intel AVX10".
> 
> (Note that AVX10.1 spec stops update since AVX10 is subsumed into SDM
>  while AVX10.2 spec stays update for the future extension of AVX10)
> 
> Now SDM [1] marks the bit 16-18 of CPUID.0x24_0.EBX as reserved and they
> are reserved at 1. The purpose of Intel is to remove the semantic of
> vector length enumeration from these bits since all the 128/256/512 bit
> length are supported and no need for enumeration. But Intel has to keep
> them reserved at 1 to make it compatible with the software written based
> on earlier avx10 spec that checks the bits to query of the support of each
> vector length.
> 
> For QEMU, it makes no sense to allow the configurability of the bits
> anymore. Remove the leaf FEAT_24_0_EBX and related stuff. Just hardcore
> the bits to all 1 when AVX10 is exposed to guest, to comply with the SDM
> and stop trying to associate them with the enumeration of vector length.
> 
> [1] https://cdrdv2.intel.com/v1/dl/getContent/671200 (rev 088)
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> changes in v2:
>  - refine the commit message to reference update from SDM instead of
>    AVX10 spec;
>  - call out explicitly the purpose of disassociating the enumeration of
>    vector length from the CPUID bits.
> ---
>  target/i386/cpu.c | 37 ++-----------------------------------
>  target/i386/cpu.h | 12 ------------
>  2 files changed, 2 insertions(+), 47 deletions(-)

LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


