Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CE6C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wphGd-0001uN-Dg; Fri, 31 Jul 2026 03:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wphGa-0001u3-Uj
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 03:02:48 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wphGY-0004i4-9B
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 03:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785481366; x=1817017366;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=q+bBhFiR/a3Yhx/IQoWPqSv6sYswYpdvscBkOWh1GY0=;
 b=PIR9fn87jWRiQAeuSECqRgOeYWh4kgZZuVVVVCAdt1T3R5OfgsIXQ65K
 5FAjnHn2kHfXgR5vOp/knnqtaMzEbnDCYdeA879V+WHlXkNsetuhr4TDY
 6yQoyV9PBPMB3bvisEQJRS+ODph3brSoHYziVnuPTBuGCGlwVAZfxIU0g
 c8U9dC1Q7IiDHtNIQ5GFk2D7u/hnN035K3fxkLNFX/c+s0wH12TP5RZeB
 THNjamRfIVPOF05n1trs+ZwYdYwq6rTxnIrXX1FLjlqwOdoA5xy4P2Wrx
 JtuMnmjTRGX6fXgDAaA5atxrjwqi1ad9ZJskZY5gGACn2/I2mWRQX4pmi w==;
X-CSE-ConnectionGUID: baaAlN3MT9mrTc/AfRxpyA==
X-CSE-MsgGUID: haDiSgboSCGug2hCmI0lEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="108897379"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="108897379"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 00:02:42 -0700
X-CSE-ConnectionGUID: uDImOzGnRGO6la07l3fwJw==
X-CSE-MsgGUID: +OEGw4F1Q2OziMuRltsWNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="261116799"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by orviesa009.jf.intel.com with ESMTP; 31 Jul 2026 00:02:41 -0700
Date: Fri, 31 Jul 2026 15:02:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: zhang_wei@open-hieco.net
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v1 1/9] target/i386: Sync AMD CPUID aliases for Hygon
Message-ID: <amxIj+rZvDrtX7BM@intel.com>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
 <20260706055530.1752094-2-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260706055530.1752094-2-zhang_wei@open-hieco.net>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> -GlobalProperty pc_compat_11_0[] = {};
> +GlobalProperty pc_compat_11_0[] = {
> +    { TYPE_X86_CPU, "x-hygon-vendor-abi-fixes", "false" },
> +};

This needs rebase on v11.1 :)

>  const size_t pc_compat_11_0_len = G_N_ELEMENTS(pc_compat_11_0);
>  
>  GlobalProperty pc_compat_10_2[] = {};
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 5805d33ab9..32b8bc9ebd 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -8608,6 +8608,20 @@ uint32_t cpu_x86_virtual_addr_width(CPUX86State *env)
>      }
>  }
>  
> +/*
> + * AMD CPUs define CPUID[0x80000001].EDX aliases for selected CPUID[1].EDX
> + * feature bits.  Hygon Dhyana follows the same extended feature alias rules.
> + * Enable the corrected Hygon behavior only for machine types where Hygon
> + * vendor ABI fixes are on.
> + */
> +static bool x86_cpu_has_amd_cpuid_aliases(const X86CPU *cpu)
> +{
> +    const CPUX86State *env = &cpu->env;
> +
> +    return IS_AMD_CPU(env) ||
> +           (cpu->hygon_vendor_abi_fixes && IS_HYGON_CPU(env));
> +}
> +
>  void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                     uint32_t *eax, uint32_t *ebx,
>                     uint32_t *ecx, uint32_t *edx)
> @@ -10147,10 +10161,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>          }
>      }
>  
> -    /* On AMD CPUs, some CPUID[8000_0001].EDX bits must match the bits on
> -     * CPUID[1].EDX.
> +    /*
> +     * CPUs that use AMD-compatible extended CPUID aliases must keep selected
> +     * CPUID[0x80000001].EDX bits synchronized with CPUID[1].EDX.
>       */
> -    if (IS_AMD_CPU(env)) {
> +    if (x86_cpu_has_amd_cpuid_aliases(cpu)) {

Or we can omit this helper ("x86_cpu_has_amd_cpuid_aliases(cpu)") and
instead do the check directly inline?

I think we should have fewer helpers like this, unless the conditional
checks are really lengthy... Since the helpers added for each ABI is
similar, but we can¡¯t consolidate them into a single generic helper
(because while the AMD and Hygon ABIs are basically similar, there are
still differences), having too many similar helpers makes the code seem
fragmented.

> @@ -2461,6 +2467,12 @@ struct ArchCPU {
>       */
>      bool vendor_cpuid_only_v2;
>  
> +    /*
> +     * Enable Hygon vendor ABI fixes for new machine types.  Old machine
> +     * types disable this to preserve guest-visible CPU ABI.
> +     */
> +    bool hygon_vendor_abi_fixes;
> +

Maybe the following comment to emphasize this is a compat option?

/*
 * Compatibility bits for old machine types: if true, apply Hygon
 * vendor-specific ABI fixes.  Old machine types disable this to
 * preserve the guest-visible CPU ABI.
 */

>      /* Only advertise TOPOEXT features that AMD defines */
>      bool amd_topoext_features_only;
>  
> diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
> index 17c0965827..b7f8834052 100644
> --- a/tests/qtest/test-x86-cpuid-compat.c
> +++ b/tests/qtest/test-x86-cpuid-compat.c
> @@ -113,6 +113,21 @@ typedef struct FeatureTestArgs {
>      bool expected_value;
>  } FeatureTestArgs;
>  
> +typedef struct BoolPropTestArgs {
> +    /* Test name */
> +    const char *name;
> +    /* CPU type */
> +    const char *cpu;
> +    /* CPU features (may be NULL) */
> +    const char *cpufeat;
> +    /* machine type (may be NULL to use default machine) */
> +    const char *machine;
> +    /* CPU property to read */
> +    const char *property;
> +    /* expected value of the property */
> +    bool expected_value;
> +} BoolPropTestArgs;

Good test!

Regards,
Zhao


