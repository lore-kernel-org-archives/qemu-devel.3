Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4D5C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 13:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taE39-0006ii-Vf; Tue, 21 Jan 2025 08:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taE38-0006iG-0A
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 08:12:10 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taE36-0000cT-2U
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 08:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737465128; x=1769001128;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ugiyz5iK8nRFzYKbg7YBcQVWkkmTJlbfgY0Q1HJmPro=;
 b=ZZTgp1miv4Nu1dZxk3S+uAKxsXEcLi5Hg79o9F+IuhRc8q17azSvMsRP
 IwB125mkbEZQJd72wbl/SDp/Orilj1gWbzLUYZshV2RY9Bg4GTTBhI5xq
 AGr3YXYX3mVG8mo2lMEqhn70Y3YAQ3UPP+lDCiQh4f7Iaf3720ThAAmUI
 ZQLaxA4713mm3uhn3dYHq9PXKYVM1pU9qGlkxD7a6mWzQQVKuND55mlII
 OWMz8uHVmXLptRrzVcUGvcxg9g80PiC/c+Fw2Xu0V3SsdngAGgZ7iaocX
 9Dfl78dyyXlS2/QJhqPFW9xF2j1e/tF+E/2P1EbAEvxjNa5cZD9gYFmT6 A==;
X-CSE-ConnectionGUID: odTYGfeSTwufgDujENax4A==
X-CSE-MsgGUID: dKPtz7/XQpGh+u6twhcnmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="41633659"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="41633659"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 05:12:05 -0800
X-CSE-ConnectionGUID: PPLxeXPrTMaVxJNrfGC+Gg==
X-CSE-MsgGUID: LEFafopLQAqmmWWIvixmNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="107345057"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 21 Jan 2025 05:12:03 -0800
Date: Tue, 21 Jan 2025 21:31:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, imammedo@redhat.com,
 xiaoyao.li@intel.com, zhao1.liu@linux.intel.com, xuelian.guo@intel.com
Subject: Re: [PATCH 4/4] docs: Add GNR, SRF and CWF CPU models
Message-ID: <Z4+hrXVb7uVYA/2B@intel.com>
References: <20250121020650.1899618-1-tao1.su@linux.intel.com>
 <20250121020650.1899618-5-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121020650.1899618-5-tao1.su@linux.intel.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Tue, Jan 21, 2025 at 10:06:50AM +0800, Tao Su wrote:
> Date: Tue, 21 Jan 2025 10:06:50 +0800
> From: Tao Su <tao1.su@linux.intel.com>
> Subject: [PATCH 4/4] docs: Add GNR, SRF and CWF CPU models
> X-Mailer: git-send-email 2.34.1
> 
> Update GraniteRapids, SierraForest and ClearwaterForest CPU models in
> section "Preferred CPU models for Intel x86 hosts".
> 
> Also introduce bhi-no, gds-no and rfds-no in doc.
> 
> Suggested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> ---
>  docs/system/cpu-models-x86.rst.inc | 42 ++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)

[snip]

> +``bhi-no``
> +  Recommended to inform that the guest that the host is ``not``

s/inform that the guest/inform the guest/

> +  vulnerable to CVE-2022-0001, Branch History Injection (BHI).
> +
> +  This too is an MSR feature, so it does not show up in the Linux

s/This too is an/This is also an/

> +  ``/proc/cpuinfo`` in the host or guest.
> +
> +  It should only be enabled for VMs if the host reports
> +  ``BHI: Not affected`` in the
> +  ``/sys/devices/system/cpu/vulnerabilities/spectre_v2`` file.
> +
> +``gds-no``
> +  Recommended to inform that the guest that the host is ``not``
> +  vulnerable to CVE-2022-40982, Gather Data Sampling (GDS).

s/inform that the guest/inform the guest/

> +  This too is an MSR feature, so it does not show up in the Linux
> +  ``/proc/cpuinfo`` in the host or guest.

s/This too is an/This is also an/

> +  It should only be enabled for VMs if the host reports ``Not affected``
> +  in the ``/sys/devices/system/cpu/vulnerabilities/gather_data_sampling``
> +  file.
> +
> +``rfds-no``
> +  Recommended to inform that the guest that the host is ``not``
> +  vulnerable to CVE-2023-28746, Register File Data Sampling (RFDS).

ditto.

> +  This too is an MSR feature, so it does not show up in the Linux
> +  ``/proc/cpuinfo`` in the host or guest.

ditto.

> +  It should only be enabled for VMs if the host reports ``Not affected``
> +  in the ``/sys/devices/system/cpu/vulnerabilities/reg_file_data_sampling``
> +  file.
>  
>  Preferred CPU models for AMD x86 hosts
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Thanks very much! With nits fixed :-),

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>




