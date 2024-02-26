Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF79C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWkX-0000ZE-DH; Mon, 26 Feb 2024 03:54:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reWkT-0000YM-VO
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:54:10 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reWkQ-0001Zk-4D
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:54:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708937646; x=1740473646;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=U40E5/5sv6h+//U6p9gFhgvAFzDdkN3emXgdd1nAFMs=;
 b=nwP2vh8RAd759K+0X/FPsH5ggb7t5uskgvLYi2TLP6PTQRbYK5wMw7+s
 TaB7n+HY4Glci148EsN+ssndXNGwO2NBZO2U4/us2KibY2ad++Etc136f
 Eb+0oH2fMKHA7RFvBGg/Iv/O0gzfnzkBNsItZe6Wy/pHoLJtQCLIjlXeD
 ApOApWuXPTocpUtHeLYocLC09qM7UG8rUKOWQhPA6UROefuBUqL8LzQmY
 jJqo7MnmbZ6RYeGMNWLchWZZaWzlQ2ZSjHKiEvxgcIi5n9VEGjLaTfAt9
 AILkWMQso8H6XsMQxnjW7ZJ4NdpW2jfmRH8PLpxIYSSTbJkQEoAYy20p/ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14626364"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="14626364"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 00:54:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="11377175"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 26 Feb 2024 00:54:00 -0800
Date: Mon, 26 Feb 2024 17:07:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Durrant <paul@xen.org>,
 Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Sergio Lopez <slp@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 4/6] hw/i386/pc: Remove unneeded class attribute
 "kvmclock_enabled"
Message-ID: <ZdxU3Wb4IY/ON4iY@intel.com>
References: <20240224135851.100361-1-shentey@gmail.com>
 <20240224135851.100361-5-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224135851.100361-5-shentey@gmail.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, Feb 24, 2024 at 02:58:49PM +0100, Bernhard Beschow wrote:
> Date: Sat, 24 Feb 2024 14:58:49 +0100
> From: Bernhard Beschow <shentey@gmail.com>
> Subject: [PATCH v2 4/6] hw/i386/pc: Remove unneeded class attribute
>  "kvmclock_enabled"
> X-Mailer: git-send-email 2.44.0
> 
> PCMachineClass introduces the attribute into the class hierarchy and sets it to
> true. There is no sub class overriding the attribute. Commit 30d2a17b46e9
> "hw/i386: Remove the deprecated machines 0.12 up to 0.15" removed the last
> overrides of this attribute. The attribute is now unneeded and can be removed.
> 
> Fixes: 30d2a17b46e9 "hw/i386: Remove the deprecated machines 0.12 up to 0.15"
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  include/hw/i386/pc.h | 1 -
>  hw/i386/pc.c         | 1 -
>  hw/i386/pc_piix.c    | 2 +-
>  3 files changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 27834043c3..4bb1899602 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -92,7 +92,6 @@ struct PCMachineClass {
>  
>      /* Device configuration: */
>      bool pci_enabled;
> -    bool kvmclock_enabled;
>      const char *default_south_bridge;
>  
>      /* Compat options: */
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 353edeb2ea..a80f809b83 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1799,7 +1799,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>      pcmc->smbios_uuid_encoded = true;
>      pcmc->gigabyte_align = true;
>      pcmc->has_reserved_memory = true;
> -    pcmc->kvmclock_enabled = true;
>      pcmc->enforce_aligned_dimm = true;
>      pcmc->enforce_amd_1tb_hole = true;
>      /* BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K reported
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 814d24326d..49d5d48db9 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -184,7 +184,7 @@ static void pc_init1(MachineState *machine,
>      pc_machine_init_sgx_epc(pcms);
>      x86_cpus_init(x86ms, pcmc->default_cpu_version);
>  
> -    if (kvm_enabled() && pcmc->kvmclock_enabled) {
> +    if (kvm_enabled()) {
>          kvmclock_create(pcmc->kvmclock_create_always);
>      }
>  
> -- 
> 2.44.0
> 
> 

