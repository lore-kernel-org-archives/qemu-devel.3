Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872F8CA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 09:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqqK0-0002MN-DP; Tue, 26 Aug 2025 05:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqqJy-0002Lo-6o
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 05:50:30 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqqJs-0002V2-MN
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 05:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756201825; x=1787737825;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=n5HP/0tCjR3U8YeepG2VESGEVykvV61Aaow+L4qPOCQ=;
 b=MTZpU4W2q6BcjKXJybRymXyPL4C5nRJ3Vr7/BTnbUVKSHy8R+oK/YDij
 3BjV7KbGW8Wx2HNiv1NyCCwhOBSknGvGmWgchseixaRdinO8dcHw90Wbf
 zBw28ozx/qm0sABnhXIG3LTDp/hhqj1wtev/kaY3yK+hRuRBsumgp9veZ
 d6gKCr4sImlgjzp5Vht9jOalVHmgUDnjv58ER78m9AFgX9BTQvxuM0dMq
 A1z3gVwlorP+S6HR0ebd6mdyHjJZoKfesgKjJp6lwjtnhacKLgvji27Zj
 qU37GcNUtU4r8pED/scdmCf2XaOUnvpPhpyo/9QKMQCc2+nn+71QswsiM A==;
X-CSE-ConnectionGUID: uE8OcMtPRse6l+ptzlPXPA==
X-CSE-MsgGUID: aTu6GId+SrScYNK07M+jcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="58138973"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="58138973"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 02:50:21 -0700
X-CSE-ConnectionGUID: xmDnd1cuQtGpQfAkbWMurg==
X-CSE-MsgGUID: jBq80d29Q+iFTapO5FCfOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="174795812"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 02:50:17 -0700
Message-ID: <0bb31bb1-1a44-4723-9bbf-da9c528e42c5@intel.com>
Date: Tue, 26 Aug 2025 17:50:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/19] hw/i386/pc_piix.c: assume pcmc->pci_enabled is
 always false in pc_init_isa()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-14-mark.caveayland@nutanix.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250822121342.894223-14-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.703, RCVD_IN_DNSWL_MED=-2.3,
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

On 8/22/2025 8:11 PM, Mark Cave-Ayland wrote:
> By definition PCI can never be enabled on an isapc machine so hardcode the relevant values
> set via pcmc->pci_enabled.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

It seems to me that this patch can be squashed into patch 05

> ---
>   hw/i386/pc_piix.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 924888b59d..e8603b585a 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -492,7 +492,7 @@ static void pc_init_isa(MachineState *machine)
>           }
>       }
>   
> -    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
> +    gsi_state = pc_gsi_create(&x86ms->gsi, false);
>   
>       isa_bus = isa_bus_new(NULL, system_memory, system_io,
>                               &error_abort);
> @@ -513,7 +513,7 @@ static void pc_init_isa(MachineState *machine)
>           x86_register_ferr_irq(x86ms->gsi[13]);
>       }
>   
> -    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
> +    pc_vga_init(isa_bus, NULL);
>   
>       /* init basic PC hardware */
>       pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,


