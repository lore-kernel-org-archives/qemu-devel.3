Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A42C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 07:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uba3m-0000xk-Fi; Tue, 15 Jul 2025 03:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uba3j-0000tx-DN; Tue, 15 Jul 2025 03:26:39 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uba3d-0005c1-5w; Tue, 15 Jul 2025 03:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752564393; x=1784100393;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=diH2VzVtmdjEOMOU7HGCpb9Z/8LCKSPT60pSYxn/8x8=;
 b=frSgbvNkOHpobVL+tDQEEMLH/GXnJ3Kti9QdtIEPANqsdrRQEUj3LCV/
 IJyISqzX3hxwnB86Px963STlLpP5vQkEB1EFHj7N4m9Q7rtAGljbis7tm
 EN3N6205UqCOrGrY+Y5EEKdCTLUgl/Irw2qFrgahHczBgtVAE4rtYx99T
 0oKoVYSZSmNULQm9OK9MVjOq5BILR/HCkRrM4HlUMKAvTiea3TdZKCMEP
 dN52eGuwmb/2b1myWQUIWWCM1sgmIhn9zsCtS6LLJIf1+scxDIUKPF2R4
 lM71fHbHtRdrhnq6XVajeu+QeEDft2uhPc1fkaO2KQ9Z6OrWuvqxTkHQT A==;
X-CSE-ConnectionGUID: 7ngZn7ouSTunULSWV9gKTQ==
X-CSE-MsgGUID: jrr6OeaSQ1qH2VsXR+c7fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58580313"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="58580313"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 00:26:29 -0700
X-CSE-ConnectionGUID: 5reR67JFRBiU2O9fxnj1Aw==
X-CSE-MsgGUID: 4mRwTjTTS+CQGJtBSRzGMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="194304816"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 00:26:26 -0700
Message-ID: <0002fed1-2ba8-41f9-a4f6-bac2654333e3@intel.com>
Date: Tue, 15 Jul 2025 15:26:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/arm/xen-pvh: Remove unnecessary 'hw/xen/arch_hvm.h'
 header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony@xenproject.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Peter Maydell
 <peter.maydell@linaro.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>
References: <20250715071528.46196-1-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250715071528.46196-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/15/2025 3:15 PM, Philippe Mathieu-Daudé wrote:
> "hw/xen/arch_hvm.h" only declares the arch_handle_ioreq() and
> arch_xen_set_memory() prototypes, which are not used by xen-pvh.c.
> Remove the unnecessary header inclusion.
> 
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
> Based-on: <20250513171737.74386-1-philmd@linaro.org>
> ---
>   hw/arm/xen-pvh.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
> index 4b26bcff7a5..1a9eeb01c8e 100644
> --- a/hw/arm/xen-pvh.c
> +++ b/hw/arm/xen-pvh.c
> @@ -10,7 +10,6 @@
>   #include "hw/boards.h"
>   #include "system/system.h"
>   #include "hw/xen/xen-pvh-common.h"
> -#include "hw/xen/arch_hvm.h"
>   
>   #define TYPE_XEN_ARM  MACHINE_TYPE_NAME("xenpvh")
>   


