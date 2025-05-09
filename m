Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484FBC3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 06:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDHYQ-0000Jn-0k; Fri, 09 May 2025 02:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uDHYM-0000Iz-8s; Fri, 09 May 2025 02:49:51 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uDHYK-0008L5-EB; Fri, 09 May 2025 02:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746773388; x=1778309388;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Avp9ih7O0rS3iqGb/YM02n6x4BTddKP/bzEfaLI3gZg=;
 b=W7PCQ2235bdU+JosCKfF6b2/cebFVx45vXsgyDJ+EpemcPM21gPAQyUg
 G/EKiXrQmy7Ek/1jjYnrXq2QhaGwwYAKUTqm+uuFIugd0tGEqcj9uSHmT
 LohUNENDbc4Bu7CdEyFgX5SMU1olwTeBja1z+4xHkk2zzai7qAu5rpnho
 anChwsYIAgri2jYTpCYuZb1cuPL5BQ4GBq1C0xJdpyFTybUpWiNLP58h2
 HwjPCALIpzQZ+d6IUhW9yxcrfSCVXQ4+c0dkTs0moCkx7tX98Jf6/e3/m
 fBkbFrFVoSQjatnk/XyKAPNoqlZUVk2fCQ8PkjdpTpI/9bOm9+V9zv/bL Q==;
X-CSE-ConnectionGUID: qjQ8zNYZSk+mLFc7OUPjzw==
X-CSE-MsgGUID: Hbp7xI09S4uE1aeaPqvCew==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="36216120"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="36216120"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 23:49:40 -0700
X-CSE-ConnectionGUID: 7Pzedr8eSwG9Ykn8VQdFWQ==
X-CSE-MsgGUID: +phI7N1YS5m7iubQu1JxEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="136419659"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 23:49:31 -0700
Message-ID: <23260c74-01ba-45bc-bf2f-b3e19c28ec8a@intel.com>
Date: Fri, 9 May 2025 14:49:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/27] target/i386/cpu: Remove
 CPUX86State::enable_cpuid_0xb field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Jason Wang <jasowang@redhat.com>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-13-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250508133550.81391-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 5/8/2025 9:35 PM, Philippe Mathieu-Daudé wrote:
> The CPUX86State::enable_cpuid_0xb boolean was only disabled
> for the pc-q35-2.6 and pc-i440fx-2.6 machines, which got
> removed. Being now always %true, we can remove it and simplify
> cpu_x86_cpuid().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/cpu.h | 3 ---
>   target/i386/cpu.c | 6 ------
>   2 files changed, 9 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 0db70a70439..06817a31cf9 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2241,9 +2241,6 @@ struct ArchCPU {
>        */
>       bool legacy_multi_node;
>   
> -    /* Compatibility bits for old machine types: */
> -    bool enable_cpuid_0xb;
> -
>       /* Enable auto level-increase for all CPUID leaves */
>       bool full_cpuid_auto_level;
>   
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 49179f35812..6fe37f71b1e 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6982,11 +6982,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           break;
>       case 0xB:
>           /* Extended Topology Enumeration Leaf */
> -        if (!cpu->enable_cpuid_0xb) {
> -                *eax = *ebx = *ecx = *edx = 0;
> -                break;
> -        }
> -
>           *ecx = count & 0xff;
>           *edx = cpu->apic_id;
>   
> @@ -8828,7 +8823,6 @@ static const Property x86_cpu_properties[] = {
>       DEFINE_PROP_UINT64("ucode-rev", X86CPU, ucode_rev, 0),
>       DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
>       DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
> -    DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),

It's deprecating the "cpuid-0xb" property.

I think we need go with the standard process to deprecate it.

>       DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
>       DEFINE_PROP_BOOL("x-amd-topoext-features-only", X86CPU, amd_topoext_features_only, true),
>       DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),


