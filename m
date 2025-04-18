Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83116C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 09:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5i04-000225-5Z; Fri, 18 Apr 2025 05:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u5i00-00021h-UB
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 05:27:04 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u5hzy-0007wR-US
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 05:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744968423; x=1776504423;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=pTk5ViUpM4C+jXZ5ACPVSPVowtgXkJmHefkrp2JhwlQ=;
 b=FNIwk7WfU13a81urKJfEv8S/UfGVTkGmrH3HtRgkGMsGxJaHCMbYTvAh
 Qya6WiOoSeVHTOp6mfMZ15t60RTwPKtyTHfiTgCvhu6jDcYgqarC8uuv0
 F0qNyVKbaH+jApa4djrvOFf4lungj+Qjos/B8fKp6ZyL6hHUKl+IZSL/f
 xtxX57X/0Fxe/IiG6As7A9HZYZkYh9i9R5c4t6QI5WXVpXkQ3Jr0peFc0
 0YMRU12yiKZxyeSi78oOI2okhrZzuLTHoG/221KhW8lGqRx0EK3HTPrFN
 a9todRwLTyRPffgIqTnEw2BoVOzjFKn3MyuHQ1hdR0o3wH4xPapolXlBV g==;
X-CSE-ConnectionGUID: if1EiJvuS2acHvLzjqkLNw==
X-CSE-MsgGUID: VssDQknwRfSkwaJwtzsdNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="50423583"
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; d="scan'208";a="50423583"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2025 02:27:00 -0700
X-CSE-ConnectionGUID: XL2TeJXkSLuhWameynBt5g==
X-CSE-MsgGUID: 7qtCxKclQHWIeCqZZT5eWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; d="scan'208";a="154253924"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 18 Apr 2025 02:26:58 -0700
Date: Fri, 18 Apr 2025 17:47:51 +0800
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
Subject: Re: [PATCH v8 01/55] *** HACK *** linux-headers: Update headers to
 pull in TDX API changes
Message-ID: <aAIfx8P20K5YsfZd@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-2-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-2-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> 
> diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
> index 86f2c34e7afa..baca2d479365 100644
> --- a/linux-headers/asm-x86/kvm.h
> +++ b/linux-headers/asm-x86/kvm.h
> @@ -925,4 +925,73 @@ struct kvm_hyperv_eventfd {
>  #define KVM_X86_SNP_VM		4
>  #define KVM_X86_TDX_VM		5
>  
> +/* Trust Domain eXtension sub-ioctl() commands. */

Typo? s/eXtension/Extension/

> +enum kvm_tdx_cmd_id {
> +	KVM_TDX_CAPABILITIES = 0,
> +	KVM_TDX_INIT_VM,
> +	KVM_TDX_INIT_VCPU,
> +	KVM_TDX_INIT_MEM_REGION,
> +	KVM_TDX_FINALIZE_VM,
> +	KVM_TDX_GET_CPUID,
> +
> +	KVM_TDX_CMD_NR_MAX,
> +};
> +
> +struct kvm_tdx_cmd {
> +	/* enum kvm_tdx_cmd_id */
> +	__u32 id;
> +	/* flags for sub-commend. If sub-command doesn't use this, set zero. */

Typo?  s/sub-commend/sub-command/, this line have these 2 cases.


