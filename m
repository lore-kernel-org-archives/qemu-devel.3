Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2460DC7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 09:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWtPC-0005Qr-Gu; Wed, 02 Jul 2025 05:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uWtP2-0005Mh-Ef
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 05:05:16 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uWtOu-0005Yw-ND
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 05:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751447109; x=1782983109;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=FYvqE1dreIBJ0IRqIt+R5lkTuiFftO1lyqanVbKLGWI=;
 b=FJtFBJX56e3U9G3yWbJ4tp2ltzJAyxyGjR7RX84IicIqLO/T6m17R+zb
 rT/x0pl4Up6b62qw5zWG15I7A1K4UIDFamDg1+Xkk68IKYmrIM10lzK4X
 o5wgVi+AfK+vh5kgPOoSr3GuDc2bPLrgpG+aeL31FsVaq1PgXS4oPnugw
 OveJo2GDp/5P8nCzMEvCXwLEiGs0qWdBt+NQ+HMCOaz043QVreRWMMDFr
 69PiuM+HFZfuGElNH4yBI1ztU887u14YPkTrrVQzv4/6LlvXXobb6RXKs
 oiLQSqmuMOswME+6/cjIjhy+3rlD1RRwebSrpkM3kwMh+SMMtngliLoQU g==;
X-CSE-ConnectionGUID: EgZhhzcnRleUz2XaE/3jqA==
X-CSE-MsgGUID: 6yZ/UbOMTS+K7DBcAXi/VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53448821"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="53448821"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 02:05:05 -0700
X-CSE-ConnectionGUID: 5Sm47SFVTVK1fTC6kNOAxA==
X-CSE-MsgGUID: bfGo06vLShOp4AMJp8MeXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="159724762"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.80])
 ([10.124.240.80])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 02:05:02 -0700
Message-ID: <0b2a6fbe-6232-4e6a-8423-ab09f6d312b7@linux.intel.com>
Date: Wed, 2 Jul 2025 17:04:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] i386/cpu: Add descriptor 0x49 for CPUID 0x2 encoding
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
 <20250620092734.1576677-3-zhao1.liu@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250620092734.1576677-3-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.20;
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
> The legacy_l2_cache (2nd-level cache: 4 MByte, 16-way set associative,
> 64 byte line size) corresponds to descriptor 0x49, but at present
> cpuid2_cache_descriptors doesn't support descriptor 0x49 because it has
> multiple meanings.
>
> The 0x49 is necessary when CPUID 0x2 and 0x4 leaves have the consistent
> cache model, and use legacy_l2_cache as the default l2 cache.
>
> Therefore, add descriptor 0x49 to represent general l2 cache.
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  target/i386/cpu.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index e398868a3f8d..995766c9d74c 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -127,7 +127,18 @@ struct CPUID2CacheDescriptorInfo cpuid2_cache_descriptors[] = {
>                 .associativity = 8,  .line_size = 64, },
>      [0x48] = { .level = 2, .type = UNIFIED_CACHE,     .size =   3 * MiB,
>                 .associativity = 12, .line_size = 64, },
> -    /* Descriptor 0x49 depends on CPU family/model, so it is not included */
> +    /*
> +     * Descriptor 0x49 has 2 cases:
> +     *  - 2nd-level cache: 4 MByte, 16-way set associative, 64 byte line size.
> +     *  - 3rd-level cache: 4MB, 16-way set associative, 64-byte line size
> +     *    (Intel Xeon processor MP, Family 0FH, Model 06H).
> +     *
> +     * When it represents l3, then it depends on CPU family/model. Fortunately,
> +     * the legacy cache/CPU models don't have such special l3. So, just add it
> +     * to represent the general l2 case.

For comments and commit message, we'd better use the capital character
"L2/L3" to represent the 2nd/3rd level cache which is more conventional. 

Others look good to me.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


> +     */
> +    [0x49] = { .level = 2, .type = UNIFIED_CACHE,     .size =   4 * MiB,
> +               .associativity = 16, .line_size = 64, },
>      [0x4A] = { .level = 3, .type = UNIFIED_CACHE,     .size =   6 * MiB,
>                 .associativity = 12, .line_size = 64, },
>      [0x4B] = { .level = 3, .type = UNIFIED_CACHE,     .size =   8 * MiB,

