Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C04CA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 07:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqo4X-0000Ks-RZ; Tue, 26 Aug 2025 03:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqo4W-0000KT-E1
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 03:26:24 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqo4K-0004bs-KE
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 03:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756193173; x=1787729173;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=nep+OoqBQbkcGHXXR11aY2mGItIQ9CCq0J5CpZyzD3U=;
 b=P/bjsihlhD9kZVJlDhJjS9lV13n3RYR3L3x1t6U2zr5g0VKFMybDO/W+
 5CU7w1h1+Zr+1KUCgM3zYGsPOq1RqF2mGCXGXobIbe5GPV9sfGXaqlT8U
 iUgagJrn83nRv1W7olwb/PPxa6l2ZPRhupyuLXBvWCHdzrp7LC/k85YfD
 OCiTWLsMnZuAC94JfXyroD1FwDaZanqCf7zdA0XcGnejvP/kpEIeUDXM6
 WO2z9U6LpEmx6thhBkiqrzFl0laY0msqsIrDk9hlPPF69qibZnBUzhYOl
 NgQFCSAyrqAB+VXYAQSb+HVVB3gojho/Fkc4LED0GYw/UPPUeDbH2YPsK g==;
X-CSE-ConnectionGUID: NKD9EsPeROekK93OnG2+nA==
X-CSE-MsgGUID: muez4KEfT+qwpSWO6nYHPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="81013913"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="81013913"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 00:26:03 -0700
X-CSE-ConnectionGUID: U0/+oTVyQWm0Q0S/KC3fHA==
X-CSE-MsgGUID: 7SISmsQMSDyr1u2oeg5IhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="200398199"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 00:26:00 -0700
Message-ID: <3c2e9fbc-db80-4dd6-a1a5-deeabb8c0194@intel.com>
Date: Tue, 26 Aug 2025 15:25:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/19] hw/i386/pc_piix.c: restrict isapc machine to
 32-bit CPUs
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-2-mark.caveayland@nutanix.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250822121342.894223-2-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.703, RCVD_IN_DNSWL_MED=-2.3,
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

On 8/22/2025 8:11 PM, Mark Cave-Ayland wrote:
> The isapc machine represents a legacy ISA PC with a 486 CPU. Whilst it is
> possible to specify any CPU via -cpu on the command line, it makes no
> sense to allow modern 64-bit CPUs to be used.
> 
> Restrict the isapc machine to the available 32-bit CPUs, taking care to
> handle the case where if a user inadvertently uses -cpu max then the "best"
> 32-bit CPU is used (in this case the pentium3).
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/i386/pc_piix.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index c03324281b..5720b6b556 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -436,6 +436,19 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
>   #ifdef CONFIG_ISAPC
>   static void pc_init_isa(MachineState *machine)
>   {
> +    /*
> +     * There is a small chance that someone unintentionally passes "-cpu max"
> +     * for the isapc machine, which will provide a much more modern 32-bit
> +     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
> +     * been specified, choose the "best" 32-bit cpu possible which we consider
> +     * be the pentium3 (deliberately choosing an Intel CPU given that the
> +     * default 486 CPU for the isapc machine is also an Intel CPU).
> +     */
> +    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
> +        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
> +        warn_report("-cpu max is invalid for isapc machine, using pentium3");
> +    }

Do we need to handle the case of "-cpu host"?

>       pc_init1(machine, NULL);
>   }
>   #endif
> @@ -806,7 +819,19 @@ DEFINE_I440FX_MACHINE(2, 6);
>   #ifdef CONFIG_ISAPC
>   static void isapc_machine_options(MachineClass *m)
>   {
> +    static const char * const valid_cpu_types[] = {
> +        X86_CPU_TYPE_NAME("486"),
> +        X86_CPU_TYPE_NAME("athlon"),
> +        X86_CPU_TYPE_NAME("kvm32"),
> +        X86_CPU_TYPE_NAME("pentium"),
> +        X86_CPU_TYPE_NAME("pentium2"),
> +        X86_CPU_TYPE_NAME("pentium3"),
> +        X86_CPU_TYPE_NAME("qemu32"),
> +        X86_CPU_TYPE_NAME("max"),
> +        NULL
> +    };
>       PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> +
>       m->desc = "ISA-only PC";
>       m->max_cpus = 1;
>       m->option_rom_has_mr = true;
> @@ -819,6 +844,7 @@ static void isapc_machine_options(MachineClass *m)
>       pcmc->has_reserved_memory = false;
>       m->default_nic = "ne2k_isa";
>       m->default_cpu_type = X86_CPU_TYPE_NAME("486");
> +    m->valid_cpu_types = valid_cpu_types;
>       m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
>       m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
>   }


