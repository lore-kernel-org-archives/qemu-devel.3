Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F78EC83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 08:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWt8n-0007gu-FN; Wed, 02 Jul 2025 04:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uWt8k-0007ga-2v
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 04:48:26 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uWt8h-00023F-Hj
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 04:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751446104; x=1782982104;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=zk6cPQfsKpuWrDifx8+BrG8ShNF9/KPb42pCeEVTuV8=;
 b=UA/NTdnoQm0aWDdg1ENYfOQ56m+MVkktB9E/tiozaMtdr19qqQ7tRt+T
 lLGoCBOToSc605v5TAgmaLbuK61ZgUa6WPx1k9oj5fyvfzYms45SJZZzx
 Td8e3j/+n9zjEV/nC25IIe+RDw0jFc5Lt8KofuzQPevEfteNGfccrfe2q
 Sw+GN7QUkW5H/bxecGQlcE8Pr/X+27P66Yz4HKnx5xHZce4NSxt3luW5h
 b5KAxBGC7ow1sLOgQhxrROLDndI1BQe42mWHKW1ONF7Sg8NcBlamHaOlQ
 qXxnjpJDAOaNk16bb2cyTbvMxg9TZRbJPs6S748P/csoI/d9mHLRoH9DZ g==;
X-CSE-ConnectionGUID: 7gpJxvauTYaVQZFRN1PlTg==
X-CSE-MsgGUID: ufrHP5nOSYi6cgqx7Gi5VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="65187185"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="65187185"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 01:48:18 -0700
X-CSE-ConnectionGUID: NUITdyxRRsOun/lNM0ItnA==
X-CSE-MsgGUID: zLN0N6NlRXaZmp58HrIXpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="153476348"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.80])
 ([10.124.240.80])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 01:48:14 -0700
Message-ID: <4fde6b82-0d13-48d8-898a-e105b9a79858@linux.intel.com>
Date: Wed, 2 Jul 2025 16:48:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] i386/cpu: Refine comment of
 CPUID2CacheDescriptorInfo
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Pu Wen <puwen@hygon.cn>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20250620092734.1576677-1-zhao1.liu@intel.com>
 <20250620092734.1576677-2-zhao1.liu@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250620092734.1576677-2-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.12;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On 6/20/2025 5:27 PM, Zhao Liu wrote:
> Refer to SDM vol.3 table 1-21, add the notes about the missing
> descriptor, and fix the typo and comment format.
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  target/i386/cpu.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 40aefb38f6da..e398868a3f8d 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -66,6 +66,7 @@ struct CPUID2CacheDescriptorInfo {
>  
>  /*
>   * Known CPUID 2 cache descriptors.
> + * TLB, prefetch and sectored cache related descriptors are not included.
>   * From Intel SDM Volume 2A, CPUID instruction
>   */
>  struct CPUID2CacheDescriptorInfo cpuid2_cache_descriptors[] = {
> @@ -87,18 +88,29 @@ struct CPUID2CacheDescriptorInfo cpuid2_cache_descriptors[] = {
>                 .associativity = 2,  .line_size = 64, },
>      [0x21] = { .level = 2, .type = UNIFIED_CACHE,     .size = 256 * KiB,
>                 .associativity = 8,  .line_size = 64, },
> -    /* lines per sector is not supported cpuid2_cache_descriptor(),
> -    * so descriptors 0x22, 0x23 are not included
> -    */
> +    /*
> +     * lines per sector is not supported cpuid2_cache_descriptor(),
> +     * so descriptors 0x22, 0x23 are not included
> +     */
>      [0x24] = { .level = 2, .type = UNIFIED_CACHE,     .size =   1 * MiB,
>                 .associativity = 16, .line_size = 64, },
> -    /* lines per sector is not supported cpuid2_cache_descriptor(),
> -    * so descriptors 0x25, 0x20 are not included
> -    */
> +    /*
> +     * lines per sector is not supported cpuid2_cache_descriptor(),
> +     * so descriptors 0x25, 0x29 are not included
> +     */
>      [0x2C] = { .level = 1, .type = DATA_CACHE,        .size =  32 * KiB,
>                 .associativity = 8,  .line_size = 64, },
>      [0x30] = { .level = 1, .type = INSTRUCTION_CACHE, .size =  32 * KiB,
>                 .associativity = 8,  .line_size = 64, },
> +    /*
> +     * Newer Intel CPUs (having the cores without L3, e.g., Intel MTL, ARL)
> +     * use CPUID 0x4 leaf to describe cache topology, by encoding CPUID 0x2
> +     * leaf with 0xFF. For older CPUs (without 0x4 leaf), it's also valid
> +     * to just ignore l3's code if there's no l3.

s/l3/L3/g

Others look good to me. 

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


> +     *
> +     * This already covers all the cases in QEMU, so code 0x40 is not
> +     * included.
> +     */
>      [0x41] = { .level = 2, .type = UNIFIED_CACHE,     .size = 128 * KiB,
>                 .associativity = 4,  .line_size = 32, },
>      [0x42] = { .level = 2, .type = UNIFIED_CACHE,     .size = 256 * KiB,
> @@ -136,9 +148,10 @@ struct CPUID2CacheDescriptorInfo cpuid2_cache_descriptors[] = {
>                 .associativity = 4,  .line_size = 64, },
>      [0x78] = { .level = 2, .type = UNIFIED_CACHE,     .size =   1 * MiB,
>                 .associativity = 4,  .line_size = 64, },
> -    /* lines per sector is not supported cpuid2_cache_descriptor(),
> -    * so descriptors 0x79, 0x7A, 0x7B, 0x7C are not included.
> -    */
> +    /*
> +     * lines per sector is not supported cpuid2_cache_descriptor(),
> +     * so descriptors 0x79, 0x7A, 0x7B, 0x7C are not included.
> +     */
>      [0x7D] = { .level = 2, .type = UNIFIED_CACHE,     .size =   2 * MiB,
>                 .associativity = 8,  .line_size = 64, },
>      [0x7F] = { .level = 2, .type = UNIFIED_CACHE,     .size = 512 * KiB,

