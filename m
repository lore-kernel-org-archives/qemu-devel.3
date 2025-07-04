Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AB0C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 03:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXXP4-0007uu-5h; Thu, 03 Jul 2025 23:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uXXOy-0007ua-D4
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 23:47:52 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uXXOw-0004h8-GR
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 23:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751600871; x=1783136871;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=c8HjYqua6kZq0tY/HwUalqJ2A9Mz/w8N7Jd2biUSYZE=;
 b=FkIn0TK9yppNVO/G1WyWRR1QU2PQl4KoYLfWyGE2S9iS6w3IqekzYNHB
 qiAVFHk6zgYWU48TGvldJvD9QKas+Kbj/1ANhOS2Z+d5SvkBOisWtlOUK
 NMD4KOTJcHrI3tB36a/1Xv/D8KpMbz2bdZSy+nceVdSGFdAeukwe0zGAB
 zmeK3j1l5f1Eet36RVzlaMuhnKo51ZSba0baygK/AkjH+/fwDOAfXut/z
 0rQVLrysYEmRE9YY84AAVcG5ovDJQTUUkwZLyDoH73aALBSxfz6ftSx0Q
 vHDql3/iuPALLPbrMK4mtv/jHJaPevakSYGXImFek+rp7vWFxSCF71wWF A==;
X-CSE-ConnectionGUID: CbKhfFD9TE6cz6eu0s14zA==
X-CSE-MsgGUID: movfpu5ESQycR39Ef3OO+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="71373910"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="71373910"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 20:47:49 -0700
X-CSE-ConnectionGUID: mIZFBJ06Qzavsi5dxn2NYA==
X-CSE-MsgGUID: VzTKBq64QcqMigs2ukGGxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="155297875"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.37])
 ([10.124.240.37])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 20:47:45 -0700
Message-ID: <1dc7cdfd-b34a-4f7c-b9f1-8c24861c8272@linux.intel.com>
Date: Fri, 4 Jul 2025 11:47:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] i386/cpu: Enable 0x1f leaf for GraniteRapids by
 default
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Jason Zeng <jason.zeng@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Tejus GK <tejus.gk@nutanix.com>, Manish Mishra <manish.mishra@nutanix.com>,
 qemu-devel@nongnu.org
References: <20250626083105.2581859-1-zhao1.liu@intel.com>
 <20250626083105.2581859-8-zhao1.liu@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250626083105.2581859-8-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=198.175.65.10;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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
> Host GraniteRapids CPU has 0x1f leaf by default, so that enable it for
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
> index 70f8fc37f8e0..acf7e0de184d 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5242,8 +5242,11 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>              },
>              {
>                  .version = 3,
> -                .note = "with gnr-sp cache model",
> +                .note = "with gnr-sp cache model and 0x1f leaf",

ditto.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

>                  .cache_info = &xeon_gnr_cache_info,
> +                .props = (PropValue[]) {
> +                    { "x-force-cpuid-0x1f", "on" },
> +                }
>              },
>              { /* end of list */ },
>          },

