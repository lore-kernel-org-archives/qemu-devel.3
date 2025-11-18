Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FAACED24E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 09:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLHpY-00049O-78; Tue, 18 Nov 2025 04:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vLHpN-00044Q-KU
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 04:16:47 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vLHpL-0006Hq-Vh
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 04:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763457404; x=1794993404;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=WD40aa6wBB7MlaHBmih+AcID6ZhW8pF+m8VokDRZ5nM=;
 b=A0mYaQJ35I+rEqURuVLrdgHNmo0bskk+sjwTMfJexm02UtvSdRKORDHr
 1HxrFS/mlZNXuoas2OXCpgZgqmVsns+9jxdL1DuMQCNN+aYHYjiXikLZ7
 vqwqsm2M+gLNgZ56vjVtvRYf//Ftmr2qotb1MVwH67hMfZIdTcHOFN3XT
 xi774yWdJJ1a6e82PLwUIsAmEg/nzxDzrRR0Zpc94fgtBwDdx8HHlIlYO
 wsyc++Mo6KkakmjZpRS6eviyj0e67ZpDkaUCGUVVCNd6YSswFdF4Tga5N
 HxVPbjGW6kpzzIRFU+GXig2LvzX6IGdEEb2q+ggWZdHvROHi+B/E6hNVf w==;
X-CSE-ConnectionGUID: ynjMeGJxT+Gelc3jx/bmhg==
X-CSE-MsgGUID: jyzaT2IkQXyX+fawTxR5TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="83098808"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="83098808"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 01:16:42 -0800
X-CSE-ConnectionGUID: coPoJP03Tmig0F15ycjWYw==
X-CSE-MsgGUID: 5IPbd0X6Tza20YiGHNlwQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="190502536"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.78])
 ([10.124.240.78])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 01:16:40 -0800
Message-ID: <4216e86e-cbeb-45d6-a936-c8c8892a1178@intel.com>
Date: Tue, 18 Nov 2025 17:16:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] i386/cpu: Drop incorrect comment for CPUID 0x1E
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20251118080837.837505-1-zhao1.liu@intel.com>
 <20251118080837.837505-3-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251118080837.837505-3-zhao1.liu@intel.com>
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
> The information (tmul_maxk and tmul_maxn) in CPUID 0x1E.0x0.EBX is
> defined for architecture, not for SPR.
> 
> This is to say, these "hardcoded" values won't change in future. If
> the TMUL component needs to be extended for new palettes, there'll
> likely be the new TMUL instructions, or new types of AMX instructions
> that are _parallel_ to TMUL that operate in particular palettes,
> instead of changing current tmul_maxk and tmul_maxn fields in CPUID
> 0x1E.0x0.EBX.
> 
> Furthermore, the previous attempt [*] to make the 0x1E.0x0.EBX fields
> user-configurable is incorrect and unnecessary.
> 
> Therefore, drop the incorrect and misleading comment.
> 
> [*]: https://lore.kernel.org/qemu-devel/20230106083826.5384-2-lei4.wang@intel.com/
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

The intent was that when new palette introduced in the future, AMX TMUL 
might be adjusted for better performance. But given that SDM now defines 
it clearly as constant:

   EBX[7:0]  TMUL_MAXK tmul_maxk (rows or columns). Value = 16.
   EBX[23:8] TMUL_MAXN tmul_maxn (column bytes).    Value = 64.

so, it cannot change any more.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   target/i386/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 41d224330d05..0c954202cea8 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -8403,7 +8403,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           break;
>       }
>       case 0x1E: {
> -        /* AMX TMUL, for now hardcoded for Sapphire Rapids */
> +        /* AMX TMUL */
>           *eax = 0;
>           *ebx = 0;
>           *ecx = 0;


