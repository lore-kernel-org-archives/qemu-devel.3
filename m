Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7EBCA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 11:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqsHn-0001BO-Ch; Tue, 26 Aug 2025 07:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqsHk-0001AL-2o
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 07:56:20 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqsHb-00041Q-Ai
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 07:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756209371; x=1787745371;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=DjruP3zVaDni25JdTj3Hbcotcj7S6OQKXQgb01W6hW4=;
 b=HGzpONb4OKjTCi4LNMSuyZqqbxnpUlXgCAinc7NWPGW/pALI0t9IYGLO
 5ffM/S4TREU8LJ7yJjfTdWKa6ro0EYsXFg9m/zgADx1l0nOHNlRsOWL7/
 WC1RdRSq3IibTtNqrAfD4dtV+AYW9MdQCOE2NQf+AvTr5/FpL+2JFpbLN
 kehhEnfDFEYR0fUGFXVytZPlglH/Y5TkM5uQuHtr0fj0VNDTAoKvhP0fW
 iUaWFoL3qINSlBddY9oMuOseX7uG+D9Con9/R/ISKhhJa9xP5MbjgV0cV
 NpI1YxwFtCOKu+9Br53pGp58ldE9TGPtpvqha+BMiG7nrDpHEKuTP1Ukv w==;
X-CSE-ConnectionGUID: jdtejGFLSliOpxrDzyizig==
X-CSE-MsgGUID: K8uulzKmRyGHi6E30QSs5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58381611"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="58381611"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 04:56:08 -0700
X-CSE-ConnectionGUID: dphR7WE8ROqeMlM69XDCQg==
X-CSE-MsgGUID: YddReRKcQBuIlhDtNFcb4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="193225332"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 04:56:06 -0700
Message-ID: <2695f43d-e075-49d1-9e5f-9aeac48d9930@intel.com>
Date: Tue, 26 Aug 2025 19:56:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/19] hw/i386/pc_piix.c: remove nvdimm initialisation
 from pc_init_isa()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-9-mark.caveayland@nutanix.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250822121342.894223-9-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.751, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> NVDIMMs cannot be used by PCs from a pre-PCI era.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   hw/i386/pc_piix.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 129a3e2524..816124c027 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -592,12 +592,6 @@ static void pc_init_isa(MachineState *machine)
>           }
>       }
>   #endif
> -
> -    if (machine->nvdimms_state->is_enabled) {
> -        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
> -                               x86_nvdimm_acpi_dsmio,
> -                               x86ms->fw_cfg, OBJECT(pcms));
> -    }
>   }
>   #endif
>   


