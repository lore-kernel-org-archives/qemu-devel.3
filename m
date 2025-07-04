Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17675C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 03:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXXNM-0007AX-6G; Thu, 03 Jul 2025 23:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uXXNK-0007AA-2g
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 23:46:10 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uXXNE-0004Bf-IF
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 23:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751600764; x=1783136764;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=lh7zT/w9nSlmx6hF3+1nXnbAnOLOgN0WeLEBEKZlxsc=;
 b=ElVY1Bxdn0uGbYLEcGdjgZEwqW+6IwnFNJXBqOgkTltVKlz2ciGHs9wo
 LYO3HeHJQgpVQpPB2l6RjOgiRpQfOmjFqAUdyibfdCQIN16v7V5/6K0bY
 aha5zGNFPhMmRbptTEeXMzrxgtXHN8SpxAcu2mjt5tkJGWIxJloNoKDFe
 3IapF51FSJD7JY7emwi5Iz8mCQ57zpVq/bSd5+w924wf+I3khRUHHVH8T
 uyq+qneYlYPHYhiYtGeejtk3dyOczZV4U9UfnqIWA9D1U5FM7fY7f/FyE
 NiDjhAcbLJKa0BBpx7MnXuzUypZhT8laUBzKrNxRLF7fzwDfJejvG12HH A==;
X-CSE-ConnectionGUID: RZkerAojRli213JmFab2rg==
X-CSE-MsgGUID: CyBDHpImREOdxLhfxwPc1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64533888"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="64533888"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 20:46:01 -0700
X-CSE-ConnectionGUID: jCdIMR6lQdqoX87lDiR3ag==
X-CSE-MsgGUID: 5GBscZaCSKuW/OaCPpK6Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="153964254"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.37])
 ([10.124.240.37])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 20:45:58 -0700
Message-ID: <80c3be7b-f26e-421c-8821-597ad2fc5305@linux.intel.com>
Date: Fri, 4 Jul 2025 11:45:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] i386/cpu: Enable 0x1f leaf for SierraForest by default
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Jason Zeng <jason.zeng@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Tejus GK <tejus.gk@nutanix.com>, Manish Mishra <manish.mishra@nutanix.com>,
 qemu-devel@nongnu.org
References: <20250626083105.2581859-1-zhao1.liu@intel.com>
 <20250626083105.2581859-7-zhao1.liu@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250626083105.2581859-7-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=192.198.163.11;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 6/26/2025 4:31 PM, Zhao Liu wrote:
> Host SierraForest CPU has 0x1f leaf by default, so that enable it for
> Guest CPU by default as well.
>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes since RFC:
>  * Rename the property to "x-force-cpuid-0x1f". (Igor)
> ---
>  target/i386/cpu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index ee36f7ee2ccc..70f8fc37f8e0 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5392,8 +5392,11 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>              },
>              {
>                  .version = 3,
> -                .note = "with srf-sp cache model",
> +                .note = "with srf-sp cache model and 0x1f leaf",

Since 0x1f contains multiple sub-leaves, so better change the words to
"0x1f leaves".

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


>                  .cache_info = &xeon_srf_cache_info,
> +                .props = (PropValue[]) {
> +                    { "x-force-cpuid-0x1f", "on" },
> +                }
>              },
>              { /* end of list */ },
>          },

