Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25F7CA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 12:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqsOb-0005AE-2T; Tue, 26 Aug 2025 08:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqsOY-000580-Mn
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 08:03:22 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqsOL-0005Cm-1X
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 08:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756209789; x=1787745789;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=Ego4xOJfosa5/hKeXlkeBD7cRj9hX6lXMVIQyUR1TSU=;
 b=cFe8DyD5EuQ9muvlX8cfDNca9omNXJuOYMPLG2jWOcF2eAJvNwFMeFZp
 7crY1ePrpn/RNuLoB/q0riqfkoscBjnfsZlrUFFkCwSGzSKk/j6D7L8TE
 v3y5ffCGgdGmcnqTGd6PqFRtBZ+lX8IjwXHctsajrPOMNR8lzT8SRHm2t
 A+TSb9xA0A9fOT5BgpvM05qyjS6/gztaTCo/9H4cIvxFa3gPFeoo+g19u
 qIRcBK9kgaW3WlHFfIjj/Tie3vmFvBvI7vmm2QhYXmQPsqAOjDo16YO5+
 YcoSEkdeUqQK5t1Iv8DG1ilrFUe+3GW2l4O11SHQ2nLyGCAvp49qSm3aP w==;
X-CSE-ConnectionGUID: rBfZZZ0DRqeTkNFmfpsH1w==
X-CSE-MsgGUID: H+OFGpSzS52ihCh/YcBJfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62273909"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="62273909"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 05:03:06 -0700
X-CSE-ConnectionGUID: dSzfMYy7Q1a/rT6l74tjYg==
X-CSE-MsgGUID: fZYNO/iMSNi068LGQygxfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="168787368"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 05:03:03 -0700
Message-ID: <642ca99f-6f27-4327-89c8-ff9518001bfd@intel.com>
Date: Tue, 26 Aug 2025 20:03:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/19] hw/i386/pc_piix.c: hardcode pcms->pci_bus to
 NULL in pc_init_isa()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-15-mark.caveayland@nutanix.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250822121342.894223-15-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.751, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 8/22/2025 8:12 PM, Mark Cave-Ayland wrote:
> By definition PCI can never be enabled on an isapc machine so hardcode the PCIBus argument
> of pc_nic_init() to NULL.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   hw/i386/pc_piix.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index e8603b585a..49bd1a41e7 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -519,7 +519,7 @@ static void pc_init_isa(MachineState *machine)
>       pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
>                            !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
>   
> -    pc_nic_init(pcmc, isa_bus, pcms->pcibus);
> +    pc_nic_init(pcmc, isa_bus, NULL);
>   
>       ide_drive_get(hd, ARRAY_SIZE(hd));
>       for (i = 0; i < MAX_IDE_BUS; i++) {


