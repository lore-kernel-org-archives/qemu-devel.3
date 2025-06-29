Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06212C7EE39
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 00:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW2RP-000654-Az; Sun, 29 Jun 2025 20:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1uW2RL-00064e-UO
 for qemu-devel@nongnu.org; Sun, 29 Jun 2025 20:32:07 -0400
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1uW2RG-0006Mt-4t
 for qemu-devel@nongnu.org; Sun, 29 Jun 2025 20:32:06 -0400
X-ASG-Debug-ID: 1751243504-086e2327846bba0001-jgbH7p
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by
 mx1.zhaoxin.com with ESMTP id Mf9SUBYSvEdUYp0v (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 30 Jun 2025 08:31:44 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Mon, 30 Jun
 2025 08:31:44 +0800
Received: from ZXSHMBX1.zhaoxin.com ([::1]) by ZXSHMBX1.zhaoxin.com
 ([fe80::2c07:394e:4919:4dc1%7]) with mapi id 15.01.2507.044; Mon, 30 Jun 2025
 08:31:44 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from [192.168.31.91] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Sun, 29 Jun
 2025 17:47:24 +0800
Message-ID: <7f2b589b-589d-4d72-9ecb-26bb5727f724@zhaoxin.com>
Date: Sun, 29 Jun 2025 17:47:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] i386/cpu: Introduce cache model for YongFeng
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
X-ASG-Orig-Subj: Re: [PATCH 4/8] i386/cpu: Introduce cache model for YongFeng
CC: Jason Zeng <jason.zeng@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, "Tao
 Su" <tao1.su@intel.com>, Yi Lai <yi1.lai@intel.com>, Dapeng Mi
 <dapeng1.mi@intel.com>, Tejus GK <tejus.gk@nutanix.com>, Manish Mishra
 <manish.mishra@nutanix.com>, <qemu-devel@nongnu.org>
References: <20250626083105.2581859-1-zhao1.liu@intel.com>
 <20250626083105.2581859-5-zhao1.liu@intel.com>
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
In-Reply-To: <20250626083105.2581859-5-zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 6/30/2025 8:31:43 AM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1751243504
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 9213
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.143588
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=210.0.225.12; envelope-from=EwanHai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 6/26/25 4:31 PM, Zhao Liu wrote:
> 
> 
> From: Ewan Hai <ewanhai-oc@zhaoxin.com>
> 
> Add the cache model to YongFeng (v3) to better emulate its
> environment.
> 
> Note, although YongFeng v2 was added after v10.0, it was also back
> ported to v10.0.2. Therefore, the new version (v3) is needed to avoid
> conflict.
> 
> The cache model is as follows:
> 
>        --- cache 0 ---
>        cache type                         = data cache (1)
>        cache level                        = 0x1 (1)
>        self-initializing cache level      = true
>        fully associative cache            = false
>        maximum IDs for CPUs sharing cache = 0x0 (0)
>        maximum IDs for cores in pkg       = 0x0 (0)
>        system coherency line size         = 0x40 (64)
>        physical line partitions           = 0x1 (1)
>        ways of associativity              = 0x8 (8)
>        number of sets                     = 0x40 (64)
>        WBINVD/INVD acts on lower caches   = false
>        inclusive to lower caches          = false
>        complex cache indexing             = false
>        number of sets (s)                 = 64
>        (size synth)                       = 32768 (32 KB)
>        --- cache 1 ---
>        cache type                         = instruction cache (2)
>        cache level                        = 0x1 (1)
>        self-initializing cache level      = true
>        fully associative cache            = false
>        maximum IDs for CPUs sharing cache = 0x0 (0)
>        maximum IDs for cores in pkg       = 0x0 (0)
>        system coherency line size         = 0x40 (64)
>        physical line partitions           = 0x1 (1)
>        ways of associativity              = 0x10 (16)
>        number of sets                     = 0x40 (64)
>        WBINVD/INVD acts on lower caches   = false
>        inclusive to lower caches          = false
>        complex cache indexing             = false
>        number of sets (s)                 = 64
>        (size synth)                       = 65536 (64 KB)
>        --- cache 2 ---
>        cache type                         = unified cache (3)
>        cache level                        = 0x2 (2)
>        self-initializing cache level      = true
>        fully associative cache            = false
>        maximum IDs for CPUs sharing cache = 0x0 (0)
>        maximum IDs for cores in pkg       = 0x0 (0)
>        system coherency line size         = 0x40 (64)
>        physical line partitions           = 0x1 (1)
>        ways of associativity              = 0x8 (8)
>        number of sets                     = 0x200 (512)
>        WBINVD/INVD acts on lower caches   = false
>        inclusive to lower caches          = true
>        complex cache indexing             = false
>        number of sets (s)                 = 512
>        (size synth)                       = 262144 (256 KB)
>        --- cache 3 ---
>        cache type                         = unified cache (3)
>        cache level                        = 0x3 (3)
>        self-initializing cache level      = true
>        fully associative cache            = false
>        maximum IDs for CPUs sharing cache = 0x0 (0)
>        maximum IDs for cores in pkg       = 0x0 (0)
>        system coherency line size         = 0x40 (64)
>        physical line partitions           = 0x1 (1)
>        ways of associativity              = 0x10 (16)
>        number of sets                     = 0x2000 (8192)
>        WBINVD/INVD acts on lower caches   = true
>        inclusive to lower caches          = true
>        complex cache indexing             = false
>        number of sets (s)                 = 8192
>        (size synth)                       = 8388608 (8 MB)
>        --- cache 4 ---
>        cache type                         = no more caches (0)
> 
> Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes on the original codes:
>   * Rearrange cache model fields to make them easier to check.
>   * And add explanation of why v3 is needed.
>   * Drop lines_per_tag field for L2 & L3.
> ---
>   target/i386/cpu.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 104 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a7f2e5dd3fcb..08c84ba90f52 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3159,6 +3159,105 @@ static const CPUCaches xeon_srf_cache_info = {
>       },
>   };
> 
> +static const CPUCaches yongfeng_cache_info = {
> +    .l1d_cache = &(CPUCacheInfo) {
> +        /* CPUID 0x4.0x0.EAX */
> +        .type = DATA_CACHE,
> +        .level = 1,
> +        .self_init = true,
> +
> +        /* CPUID 0x4.0x0.EBX */
> +        .line_size = 64,
> +        .partitions = 1,
> +        .associativity = 8,
> +
> +        /* CPUID 0x4.0x0.ECX */
> +        .sets = 64,
> +
> +        /* CPUID 0x4.0x0.EDX */
> +        .no_invd_sharing = false,
> +        .inclusive = false,
> +        .complex_indexing = false,
> +
> +        /* CPUID 0x80000005.ECX */
> +        .lines_per_tag = 1,
> +        .size = 32 * KiB,
> +
> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> +    },
> +    .l1i_cache = &(CPUCacheInfo) {
> +        /* CPUID 0x4.0x1.EAX */
> +        .type = INSTRUCTION_CACHE,
> +        .level = 1,
> +        .self_init = true,
> +
> +        /* CPUID 0x4.0x1.EBX */
> +        .line_size = 64,
> +        .partitions = 1,
> +        .associativity = 16,
> +
> +        /* CPUID 0x4.0x1.ECX */
> +        .sets = 64,
> +
> +        /* CPUID 0x4.0x1.EDX */
> +        .no_invd_sharing = false,
> +        .inclusive = false,
> +        .complex_indexing = false,
> +
> +        /* CPUID 0x80000005.EDX */
> +        .lines_per_tag = 1,
> +        .size = 64 * KiB,
> +
> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> +    },
> +    .l2_cache = &(CPUCacheInfo) {
> +        /* CPUID 0x4.0x2.EAX */
> +        .type = UNIFIED_CACHE,
> +        .level = 2,
> +        .self_init = true,
> +
> +        /* CPUID 0x4.0x2.EBX */
> +        .line_size = 64,
> +        .partitions = 1,
> +        .associativity = 8,
> +
> +        /* CPUID 0x4.0x2.ECX */
> +        .sets = 512,
> +
> +        /* CPUID 0x4.0x2.EDX */
> +        .no_invd_sharing = false,
> +        .inclusive = true,
> +        .complex_indexing = false,
> +
> +        /* CPUID 0x80000006.ECX */
> +        .size = 256 * KiB,
> +
> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> +    },
> +    .l3_cache = &(CPUCacheInfo) {
> +        /* CPUID 0x4.0x3.EAX */
> +        .type = UNIFIED_CACHE,
> +        .level = 3,
> +        .self_init = true,
> +
> +        /* CPUID 0x4.0x3.EBX */
> +        .line_size = 64,
> +        .partitions = 1,
> +        .associativity = 16,
> +
> +        /* CPUID 0x4.0x3.ECX */
> +        .sets = 8192,
> +
> +        /* CPUID 0x4.0x3.EDX */
> +        .no_invd_sharing = true,
> +        .inclusive = true,
> +        .complex_indexing = false,
> +
> +        .size = 8 * MiB,
> +        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
> +    },
> +};
> +
>   /* The following VMX features are not supported by KVM and are left out in the
>    * CPU definitions:
>    *
> @@ -6438,6 +6537,11 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>                       { /* end of list */ }
>                   }
>               },
> +            {
> +                .version = 3,
> +                .note = "with the cache info",

I realize that my previous use of "cache info" was not precise; "cache model" is 
more appropriate. Please help me adjust accordingly, thank you.

> +                .cache_info = &yongfeng_cache_info
> +            },
>               { /* end of list */ }
>           }
>       },
> --
> 2.34.1
> 

Hi Zhao,

I tested the patchsets you provided on different hosts, and here are the results:

1. On an Intel host with KVM enabled
The CPUID leaves 0x2 and 0x4 reported inside the YongFeng-V3 VM match our 
expected cache details exactly. However, CPUID leaf 0x80000005 returns all 
zeros. This is because when KVM is in use, QEMU uses the host's vendor for the 
IS_INTEL_CPU(env), IS_ZHAOXIN_CPU(env), and IS_AMD_CPU(env) checks. Given that 
behavior, a zeroed 0x80000005 leaf in the guest is expected and, to me, 
acceptable. What are your thoughts?

2. On a YongFeng host (with or without KVM)
The CPUID leaves 0x2, 0x4, and 0x80000006 inside the VM all return the values we 
want, and the L1D/L1I cache info in leaf 0x80000005 is also correct.

3. TLB info in leaf 0x80000005
On both Intel and YongFeng hosts, the L1 TLB fields in leaf 0x80000005 remain 
constant, as we discussed. As you mentioned before, "we can wait and see what 
maintainers think" about this.

In summary, both patchsets look good for Zhaoxin support, I don't see any issues 
so far.

Btw, YongFeng host also support 0x1F, does YongFeng need to turn on 
"x-force-cpuid-0x1f" default ? I think maybe yes.


Best regards,
Ewan



