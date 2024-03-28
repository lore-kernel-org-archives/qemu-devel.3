Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312F3C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 03:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpgst-0000zP-AX; Wed, 27 Mar 2024 23:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpgso-0000z4-Hs
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 23:56:54 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpgsk-00085G-UF
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 23:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711598211; x=1743134211;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=s2en2Oq6as1ft1O+CmjlO4qejAfRyUOCGX4QfCIi8qk=;
 b=Pt/SAtb7BsueQSvh8Vw6Xk6H4tk1A7tbx52VEI7SChA2q+wUAwsc7TS+
 WkRwj1c6o3zNPfVuyZzDr3SZP2d+MSQjYvn1grAJmLtxgnaLUKCs/0T1Q
 bDjaW3FPVN+vZDypysUxWsoQoYVsd1s1LjWPy3KFr3p5To6h8qPdz0Ptp
 5KWp+DV5lyZgGhfbXoVjdn9vGlw0rYK8XwrfcKNOmnAcFclwRyLl+Vns5
 NnIEsG2axGYWnuBhDFkwzlWqSXcOyXXjbrxeSYFKSPKVVdVGJyQk1XYQK
 cRDdrcZwXgzZCenP0u0WrlOBzp56182Dc6tD054D+Hnn/FakWNokskHDc w==;
X-CSE-ConnectionGUID: cuj75i9GRBilC0atcy7JCQ==
X-CSE-MsgGUID: 2wEuMqCMTQSo6Y963xXcBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6953393"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6953393"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 20:56:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; d="scan'208";a="16587131"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2024 20:56:43 -0700
Date: Thu, 28 Mar 2024 12:10:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH-for-9.1 v2 21/21] hw/i386/pc: Replace
 PCMachineClass::acpi_data_size by PC_ACPI_DATA_SIZE
Message-ID: <ZgTtvwXMNwm/3I7j@intel.com>
References: <20240327095124.73639-1-philmd@linaro.org>
 <20240327095124.73639-22-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327095124.73639-22-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Philippe,

On Wed, Mar 27, 2024 at 10:51:23AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Wed, 27 Mar 2024 10:51:23 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-9.1 v2 21/21] hw/i386/pc: Replace
>  PCMachineClass::acpi_data_size by PC_ACPI_DATA_SIZE
> X-Mailer: git-send-email 2.41.0

[snip]

> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 27e04c52f6..f01a30d3d9 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -256,6 +256,16 @@ GlobalProperty pc_compat_2_4[] = {
>  };
>  const size_t pc_compat_2_4_len = G_N_ELEMENTS(pc_compat_2_4);
>  
> +/*
> + * @PC_ACPI_DATA_SIZE:
> + * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
> + * and other BIOS datastructures.
> + *
> + * BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K
> + * reported to be used at the moment, 32K should be enough for a while.
> + */
> +#define PC_ACPI_DATA_SIZE (0x20000 + 0x8000)
> +

What about putting this in pc.h? Because it is a general definition for
PC.

Others are good for me,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


