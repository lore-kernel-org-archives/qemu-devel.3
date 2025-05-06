Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF90CC3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 11:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCG6Y-0005og-7U; Tue, 06 May 2025 07:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCG6W-0005oT-Uk
 for qemu-devel@nongnu.org; Tue, 06 May 2025 07:04:53 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCG6V-00076Q-AN
 for qemu-devel@nongnu.org; Tue, 06 May 2025 07:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746529491; x=1778065491;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=aL0LxQp0JFKmjhqvlD9pqaRxZ/mjT8+7XFUc+D4wktg=;
 b=mGmhT1aAvmM04K8sRQHV6//ARhAbgTcdBf5D4ZFaM+yldSziXtYcdMOR
 v6dLfmn9aIbVoDDlH5JAgRhzdOoPdstu6MGd5L/gbXEOQLptDcnd4zEEz
 gjQl0+0YRjZ857eip9hhyOYEVP9LPLtsckDBfyCv4sn9oyBugsLJtcdrh
 kozkTQHtv469ZRtTnHgZnJj+o7q42a4lOyjFn98N1USXidvuo0o2OqfjM
 NE1vdlzfzZi2lwxHcYBntnM2DQfsGiT4rtLxojxGlQlueR74ai4oeUadv
 wqKJf0qBNzfiIjvd7/Te9Eia1kjHf+4/UYY1R/LmzCuvOJG+bi+Rlz31V Q==;
X-CSE-ConnectionGUID: vqSc0TMUTVy1bRcMW8HduQ==
X-CSE-MsgGUID: eRULTAY3Q26cvqPAUCSfxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="59581187"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="59581187"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 04:04:47 -0700
X-CSE-ConnectionGUID: kieHtg/FQU674CAb3KtNWQ==
X-CSE-MsgGUID: CgwhQ70fRqKYaVCV4ZX8ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="139640562"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 06 May 2025 04:04:45 -0700
Date: Tue, 6 May 2025 19:25:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 48/55] i386/tdx: Add XFD to supported bit of TDX
Message-ID: <aBnxuZD/Tn8zUmdR@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-49-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-49-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Apr 01, 2025 at 09:01:58AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:58 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 48/55] i386/tdx: Add XFD to supported bit of TDX
> X-Mailer: git-send-email 2.34.1
> 
> Just mark XFD as always supported for TDX. This simple solution relies
> on the fact KVM will report XFD as 0 when it's not supported by the
> hardware.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/cpu.h     | 1 +
>  target/i386/kvm/tdx.c | 5 +++++
>  2 files changed, 6 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


