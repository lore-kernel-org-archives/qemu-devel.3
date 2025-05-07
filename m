Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9649BC369DC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 06:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCXrk-00050j-CY; Wed, 07 May 2025 02:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCXri-00050b-E6
 for qemu-devel@nongnu.org; Wed, 07 May 2025 02:02:46 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCXrg-0006Cn-Ao
 for qemu-devel@nongnu.org; Wed, 07 May 2025 02:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746597764; x=1778133764;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fYeFsw+e+0T7mv/VnYux2PU5Nz3oieqA4saYwFggnsU=;
 b=jstd/2uHLsWobvSf2SXB6Q1xoXPX7DoJOA3PFvDssPyQqdiiWG+5PLvM
 aoHI98pFw2RvasDaLV5faTKKjbFWOy+rrDJPUXAqMnN2LUH0mpV9jTUqs
 l6v0CkxGpLMQ4LjWiesNLUlJrv0uoU//sTVtCTrzRCZojcOyiUzGoVTOe
 bH+I8qdERwZBBFoTsuHFN1n4VJE3bGIjz2XIeo54IZxj0IhctYiuIjruu
 frLV+dCpoMDbe5jfvBmqD3glSkLks8aYmrBWg3HsuAD1QUSD68mH32DJ5
 his4mSLAY/UpxvaIqjBHhLyOm/Z9+mCbEMkjLX7V9z6WsQxKwiIrYbbCg Q==;
X-CSE-ConnectionGUID: kS7E8BJuTVS9dRpoDdizXQ==
X-CSE-MsgGUID: JRr31pycSbOGJCPI1IKMMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="58502825"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="58502825"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 23:02:41 -0700
X-CSE-ConnectionGUID: WD21wPEwSPS02x5jbc9/dg==
X-CSE-MsgGUID: SFOhLJtuQf+oZRCT33bSPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="141033394"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 06 May 2025 23:02:33 -0700
Date: Wed, 7 May 2025 14:23:34 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Cl=E9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v3 02/19] hw/i386/pc: Remove
 PCMachineClass::legacy_cpu_hotplug field
Message-ID: <aBr8Zknwle47ljOB@intel.com>
References: <20250502185652.67370-1-philmd@linaro.org>
 <20250502185652.67370-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502185652.67370-3-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 3fffa4a3328..625889783ec 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1465,9 +1465,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>      }
>      aml_append(dsdt, scope);
>  
> -    if (pcmc->legacy_cpu_hotplug) {
> -        build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
> -    } else {
> +    {

Why leave the {} here? for clarity?

>          CPUHotplugFeatures opts = {
>              .acpi_1_compatible = true, .has_legacy_cphp = true,
>              .smi_path = pm->smi_on_cpuhp ? "\\_SB.PCI0.SMI0.SMIC" : NULL,

Otherwise,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


