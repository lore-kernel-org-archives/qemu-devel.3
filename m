Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10230CEBF93
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 09:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLHlw-0003RQ-KQ; Tue, 18 Nov 2025 04:13:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vLHlu-0003R6-MO
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 04:13:10 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vLHls-0005i0-FU
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 04:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763457189; x=1794993189;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=kFSYlHBQcAnq6RKxM0HATxwew1g6kEtWzTnzwDENiYs=;
 b=HsSH+/qSn35AMgIJOx03DCH2sIaTStn9jC4NfpBMpKUYTgSP1Bo4K1R5
 guMli+R+py8IUNPxn+oS+SMxAJlk7MS6Pq9YUnvWVeE9WfY7W9bg2MLqr
 y8T541lFb5YoycrCKWywGbKiePbXDHsb/Hi3uofdmnC2o5m5O/mKAHaTP
 hq1TLWSg9D83GphIXbj8ZL+cXUqmLyRWVFlGgg0iP8A5Lpm7wtiBtvSY7
 XTAB+piIr+Ri7Q1k4g0qbkUR9PVLMR6wCrj41M14/I1JkMUvCBXA0tErk
 50gx3otmY/vsCdx6oNzjR1lkmeWr5GBqqaMZYyHjfVT2wvBoRj3JIZrOt w==;
X-CSE-ConnectionGUID: nXBX6wwLTOKijzU9iBcfdw==
X-CSE-MsgGUID: UugoW4RNR2iFNDEjVgKUnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="83098422"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="83098422"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 01:12:49 -0800
X-CSE-ConnectionGUID: XXrKeaTwQYWHcyzzg7bJeg==
X-CSE-MsgGUID: NkbI44LFSTWdLeTuBm/dYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="190501867"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.78])
 ([10.124.240.78])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 01:12:49 -0800
Message-ID: <c2f98fec-27bd-4218-883f-514684681d30@intel.com>
Date: Tue, 18 Nov 2025 17:12:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] i386/cpu: Drop incorrect comment for CPUID 0x1D
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20251118080837.837505-1-zhao1.liu@intel.com>
 <20251118080837.837505-2-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251118080837.837505-2-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/18/2025 4:08 PM, Zhao Liu wrote:
> The information in CPUID 0x1D.0x1 is for tile palette 1, and is not
> SPR-specific.
> 
> This is to say, these "hardcoded" values won't change in future. If
> the palette needs to be extended, a new tile palette (maybe in a new
> subleaf) will be introduced instead of changing current information of
> tile palette 1.
> 
> Furthermore, the previous attempt [*] to make the 0x1D.0x1 fields
> user-configurable is incorrect and unnecessary.
> 
> Therefore, drop the incorrect and misleading comment.
> 
> [*]: https://lore.kernel.org/qemu-devel/20230106083826.5384-2-lei4.wang@intel.com/
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   target/i386/cpu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index f703b1478d71..41d224330d05 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -8381,7 +8381,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           *edx = 0; /* EDX is reserved. */
>           break;
>       case 0x1D: {
> -        /* AMX TILE, for now hardcoded for Sapphire Rapids*/
> +        /* AMX TILE */
>           *eax = 0;
>           *ebx = 0;
>           *ecx = 0;
> @@ -8394,6 +8394,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>               /* Highest numbered palette subleaf */
>               *eax = INTEL_AMX_TILE_MAX_SUBLEAF;
>           } else if (count == 1) {
> +            /* Tile palette 1 */

how about
	/* Tile palette 1, the values are architecturally defiend */

>               *eax = INTEL_AMX_TOTAL_TILE_BYTES |
>                      (INTEL_AMX_BYTES_PER_TILE << 16);
>               *ebx = INTEL_AMX_BYTES_PER_ROW | (INTEL_AMX_TILE_MAX_NAMES << 16);


