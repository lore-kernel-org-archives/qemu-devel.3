Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EDFC25B74
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2024 09:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDhTg-000518-J2; Sun, 02 Jun 2024 05:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sDhTf-00050n-LL
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 05:26:11 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sDhTd-0004Gd-Bc
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 05:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717320370; x=1748856370;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0C/xZryNFc0TrM/AngUrcE9gU/qdXFZTvfiIOP+xTa0=;
 b=bqsSalLEhG1+UrUPQbTxy2wnLgjWmtv5loE3UM83MxMU3HxKohtro9BZ
 eIJOGj4gPdj8T/9bddjwqN2ypXY63wBXL3oYPy3bEQCO5xMM5Kww3MATz
 tYZCTH0rWHbdWg6BrltUwOtnOnNVCcF0x2+B1CjkyrFqU1C8/Lxx8GoXa
 Bc28ZbGEVGRUH729lo+tAl/8FfjNI9EOLfB2tcFk1k6BB7Srz8sD8v8EW
 Xd/wdsTnuYRM9wta7M7p+7rQX3Rc8PEEGtp9uCNCrp3K2QPDxxCrIxYul
 xSJIRNzDmTCcRft/lYwdakQoWOvwieNrWAjYDCXyEfZjLwjNELAKo01kG Q==;
X-CSE-ConnectionGUID: IrJpHwsOSViZ29ii37u7CA==
X-CSE-MsgGUID: XzwAXxTuS2+01RmMV1RRug==
X-IronPort-AV: E=McAfee;i="6600,9927,11090"; a="25223956"
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; d="scan'208";a="25223956"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 02:26:07 -0700
X-CSE-ConnectionGUID: 7MjO5vmLSoSTMxu1SO8o0g==
X-CSE-MsgGUID: W/7mPZEhTtWE+dF4eq5bKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; d="scan'208";a="41028388"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 02 Jun 2024 02:26:06 -0700
Date: Sun, 2 Jun 2024 17:41:31 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/6] meson: assume x86-64-v2 baseline ISA
Message-ID: <Zlw+S1RlXwxLovGu@intel.com>
References: <20240531091457.42200-1-pbonzini@redhat.com>
 <20240531091457.42200-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531091457.42200-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.041,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, May 31, 2024 at 11:14:53AM +0200, Paolo Bonzini wrote:
> Date: Fri, 31 May 2024 11:14:53 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 2/6] meson: assume x86-64-v2 baseline ISA
> X-Mailer: git-send-email 2.45.1
> 
> x86-64-v2 processors were released in 2008, assume that we have one.
> Unfortunately there is no GCC flag to enable all the features
> without disabling what came after; so enable them one by one.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 63866071445..19d1fc1f33b 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -336,9 +336,13 @@ if host_arch == 'i386' and not cc.links('''
>    qemu_common_flags = ['-march=i486'] + qemu_common_flags
>  endif
>  
> -# ??? Only extremely old AMD cpus do not have cmpxchg16b.
> -# If we truly care, we should simply detect this case at
> -# runtime and generate the fallback to serial emulation.
> +# Assume x86-64-v2 (minus CMPXCHG16B for 32-bit code)

Is it necessary to state the requirement (x86-64-v2) for x86 host in
some doc?

e.g., docs/system/target-i386.rst.

> +if host_arch == 'i386'
> +  qemu_common_flags = ['-mfpmath=sse'] + qemu_common_flags
> +endif
> +if host_arch in ['i386', 'x86_64']
> +  qemu_common_flags = ['-mpopcnt', '-msse4.2'] + qemu_common_flags
> +endif
>  if host_arch == 'x86_64'
>    qemu_common_flags = ['-mcx16'] + qemu_common_flags
>  endif
> -- 
> 2.45.1

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



