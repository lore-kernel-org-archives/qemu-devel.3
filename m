Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51096CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 15:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEUqY-00087N-Bb; Thu, 30 Oct 2025 11:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vEUqA-00084P-Ro
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:45:31 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vEUq1-0003J1-6a
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761839121; x=1793375121;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qS+02fCqSHr3tcnWuRZhV6jK2aqbd4ZTjkQZxDlSqeE=;
 b=IDgvgZ4tffuEPPGcdudFkhtbhykmrj8ImKE/eHxYqvL/utBZGOsfc2kT
 N/DTxJFgS65Qrf9UthLvOuiCUFf2KraM5YO8dDrIwBPU/fm0AkeXCB/M/
 A8RRZbCpxD8rlqqSpjKXtQRHr4RyP0JA6n3Pji7AcHuoqsTZM8HSOdWz6
 UqYnDgWw/6ZihysCu+6AudZmJfe7bine9jh36UgNhq7KxRt8AF/rh1eHg
 s6WUwyDYO3ulSXKsvbKJIsSse/1L4yyzMdz8U0hkANmpMRGekKLYBqkGa
 8g6gBexuv1GEk3WMm4D9gRL1E5BCv+8ulKhVL32gYhV+VPcuokpujj3PV Q==;
X-CSE-ConnectionGUID: IJYr9Pa8Sjm6sFtKwetKLA==
X-CSE-MsgGUID: 2TaPD82GTZ+TSvD4beEsGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="63189907"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; d="scan'208";a="63189907"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2025 08:45:15 -0700
X-CSE-ConnectionGUID: FC40WmS4QyaVU3OXCmeoBA==
X-CSE-MsgGUID: 8ovOVZtJQuCi1zFIX0P/xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; d="scan'208";a="209560818"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 30 Oct 2025 08:45:11 -0700
Date: Fri, 31 Oct 2025 00:07:23 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
Subject: Re: [PATCH v3 20/20] i386/tdx: Add CET SHSTK/IBT into the supported
 CPUID by XFAM
Message-ID: <aQONOxHIu8IUtmiJ@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-21-zhao1.liu@intel.com>
 <ea4ff407-b5ee-4649-b5cd-82b626dca3ee@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea4ff407-b5ee-4649-b5cd-82b626dca3ee@intel.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Oct 28, 2025 at 04:55:25PM +0800, Xiaoyao Li wrote:
> Date: Tue, 28 Oct 2025 16:55:25 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v3 20/20] i386/tdx: Add CET SHSTK/IBT into the
>  supported CPUID by XFAM
> 
> On 10/24/2025 2:56 PM, Zhao Liu wrote:
> > From: Chenyi Qiang <chenyi.qiang@intel.com>
> > 
> > So that it can be configured in TD guest.
> > 
> > And considerring cet-u and cet-s have the same dependencies, it's enough
> > to only list cet-u in tdx_xfam_deps[].
> 
> In fact, this is not the reason.
> 
> The reason is that CET_U and CET_S bits are always same in supported XFAM
> reported by TDX module, i.e., either 00 or 11. So, we only need to choose
> one of them.

Good words. Will update.

> > Tested-by: Farrah Chen <farrah.chen@intel.com>
> > Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> With commit message updated,
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Thanks!

Regards,
Zhao


