Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D00CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 11:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqsHY-00016c-8W; Tue, 26 Aug 2025 07:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqsHU-00015D-Tz
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 07:56:05 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqsHN-00041Q-GW
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 07:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756209357; x=1787745357;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=kLqqN5HcEwjZwfNpDms8Rqd/qdDP1h9+n13szXmtxdg=;
 b=CANIJE4gMVTPnX7Eebr/lQZnr279H9TlceAHfXW3LxazMaVkWaKqksPm
 rAK9o4MMo35tMyFlfpRrziuhaamezDJqjcweK9qkWz9ipgqbpkFaAv5M8
 8fE3ZyZ0rNliQzwzhcQZxJvPK5969J2i+9KCfVpnRVzZO/ztuuIaPY01R
 0n8qHshTILrF9YyvcSuy/m/ToYK5Q9QdWcPGUzw+ZIoj7jAikFWdTMEp7
 BvbCZVomcpyYDWF7pXcMj0BlFImIWL1yYUIg1mWvAUfGDZ6wa7WnCvaAW
 Y9tXw90inPcTyWQMGEaUrpfzjCkypDYQKN17TIiIhDanTwcJXjUC3EIPc g==;
X-CSE-ConnectionGUID: ebCTZcWjRd2uvs5ASOWUow==
X-CSE-MsgGUID: 4miHZV4QTpqK1unptQRztg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58381567"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="58381567"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 04:55:49 -0700
X-CSE-ConnectionGUID: Hy/USlH0T8i81VLs6pPfnA==
X-CSE-MsgGUID: 0iF0ZN8lRrmc/pGTdZZ2rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="193225155"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 04:55:46 -0700
Message-ID: <7df15c31-603d-460c-b0d8-18fded41d092@intel.com>
Date: Tue, 26 Aug 2025 19:55:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/19] hw/i386/pc_piix.c: remove SGX initialisation
 from pc_init_isa()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-8-mark.caveayland@nutanix.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250822121342.894223-8-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=xiaoyao.li@intel.com;
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

On 8/22/2025 8:11 PM, Mark Cave-Ayland wrote:
> The Intel SGX instructions only exist on recent CPUs and so would never be available
> on a CPU from the pre-PCI era.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   hw/i386/pc_piix.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index e58a7b3977..129a3e2524 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -509,8 +509,6 @@ static void pc_init_isa(MachineState *machine)
>           }
>       }
>   
> -    pc_machine_init_sgx_epc(pcms);
> -
>       /*
>        * There is a small chance that someone unintentionally passes "-cpu max"
>        * for the isapc machine, which will provide a much more modern 32-bit


