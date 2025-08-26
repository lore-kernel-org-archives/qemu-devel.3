Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EF2CA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 11:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqsIj-0001q4-AE; Tue, 26 Aug 2025 07:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqsIf-0001m2-7K
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 07:57:17 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqsIa-00046m-KR
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 07:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756209433; x=1787745433;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=MqVNpvDq1thheLmVYaOGTqGDG1bSCjKg7S+17Okx4Gs=;
 b=YXbnJboguYS9fm1h3MvZiDF1FsxVo/5ktKip3ZTs80W3nPMui6+FEisD
 etlcK4EKz037nUFuLnritCRmeVcxeKB/fwG5+/so7u5gMLOFtw1vruM3o
 6yKwGM0l71kjiDimTTaMWvLEXpXZln4pEv1zTdm64AU2afm9jpiWQlbYr
 YpkTx1sNlFhX/cL87lNDB/tn+yLsDYn+TuP/R6WTM7DBMwFnAhP6GhGje
 O1N29N8EeW6qppDptAJ4ZIy86liyiSFytZNI34Y/on4Mg2c5M1J+bwqLD
 nH7xC4RXtoCNLeThAI9YB3zYNg2tTkWiuIeyy6KS/6aOGtWYwW9PeHJNf g==;
X-CSE-ConnectionGUID: pltbR6MrTfmOfPTYZr4wsQ==
X-CSE-MsgGUID: K5sDgTH/TCmsPbuIt+bxBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="62086002"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="62086002"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 04:57:08 -0700
X-CSE-ConnectionGUID: bU38utpQS6qH+qplWOVZcg==
X-CSE-MsgGUID: MnN71yNSS4W6xOAnjXuQlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="174862491"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 04:57:06 -0700
Message-ID: <0c1b5dcc-9bae-4f2d-ba81-310524c095b7@intel.com>
Date: Tue, 26 Aug 2025 19:57:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/19] hw/i386/pc_piix.c: hardcode hole64_size to 0 in
 pc_init_isa()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-11-mark.caveayland@nutanix.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250822121342.894223-11-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.751, RCVD_IN_DNSWL_MED=-2.3,
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

On 8/22/2025 8:11 PM, Mark Cave-Ayland wrote:
> All isapc machines must have 32-bit CPUs and have no PCI 64-bit hole so it can be
> hardcoded to 0.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   hw/i386/pc_piix.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index fc94937ad4..7c9f4b78b0 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -444,7 +444,6 @@ static void pc_init_isa(MachineState *machine)
>       GSIState *gsi_state;
>       MemoryRegion *ram_memory;
>       MemoryRegion *rom_memory = system_memory;
> -    uint64_t hole64_size = 0;
>   
>       /*
>        * There is no RAM split for the isapc machine
> @@ -480,7 +479,7 @@ static void pc_init_isa(MachineState *machine)
>   
>       /* allocate ram and load rom/bios */
>       if (!xen_enabled()) {
> -        pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
> +        pc_memory_init(pcms, system_memory, rom_memory, 0);
>       } else {
>           assert(machine->ram_size == x86ms->below_4g_mem_size +
>                                       x86ms->above_4g_mem_size);


