Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119D5CD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 15:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNBNN-00028k-Fx; Wed, 13 May 2026 11:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wNBNA-00027w-OM; Wed, 13 May 2026 11:19:46 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wNBN8-0000au-GQ; Wed, 13 May 2026 11:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778685582; x=1810221582;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=hQ5dpmFu5yQGGUHLRP8DIecP71rjkOUWyvBqAvPXdtg=;
 b=mcW8nEutfxKqdUqSl/8DDg0oi4spgmg0P9YkLvLKvVk7XmiJ/rCjvSUP
 egdpU9H1onPixke9uW26KYHMjnGJ3Q5N+AAZIqRHaTbDu+pWdSHEijY6G
 NXX9Z8cCiMRiIR8Z5NrKlu8t74ffeFl7PMTJn4k6dVZs67czUe2YZDDdL
 gYgC8SaCMdi/cvXEyxZ9vNJnvhv8QbBlA03vtQLQtE6m8tgWmxofUlSRJ
 fDWgLX/SvwFz6hbxbuPsJt7Zkx+APeTO7iJ9Cs9/sMLCn/y1eaRFWD6My
 wTEFaIeCHDECqpzx8ZtuzdSipRdp+MMDLHkZZ4fL3LHtvOCoKub1Tvh7D w==;
X-CSE-ConnectionGUID: IWOziauKTXuPcO70h6/fXw==
X-CSE-MsgGUID: A5SCtyiBSoWC/2Kf55oOjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="83468642"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="83468642"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 08:19:37 -0700
X-CSE-ConnectionGUID: KqSS0+GXQH6eN+ZuV3177w==
X-CSE-MsgGUID: v8fP/fECQaC6mdDDI4QStQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="233667877"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 13 May 2026 08:19:34 -0700
Date: Wed, 13 May 2026 23:47:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, philmd@linaro.org, rad@semihalf.com,
 leif.lindholm@oss.qualcomm.com, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 03/21] x86: q35: generate WDAT ACPI table
Message-ID: <agSdBwKQh3C9UgdF@intel.com>
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-4-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303092532.2410177-4-imammedo@redhat.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Tue, Mar 03, 2026 at 10:25:14AM +0100, Igor Mammedov wrote:
> Date: Tue,  3 Mar 2026 10:25:14 +0100
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: [PATCH v2 03/21] x86: q35: generate WDAT ACPI table
> 
> It will generate WDAT table [1] customized for TCO watchdog.
> This allows Windows guests (Windows Server 2008/Vista+) to
> use TCO watchdog using built-in generic driver, which
> alleviates need to install vendor specific drivers.
> 
> Given that enabling it might change guest behaviour
> (both Windows/Linux) the feature is disabled by default.
> 
> Users that need it can enable the feature with
> following CLI option.
>     -machine wdat=on
> 
> 1)
>    "Hardware Watchdog Timers Design Specification"
>     https://uefi.org/acpi 'Watchdog Action Table (WDAT)'
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Ani Sinha <anisinha@redhat.com>
> ---
>  include/hw/acpi/wdat-ich9.h | 15 +++++++
>  hw/acpi/meson.build         |  3 +-
>  hw/acpi/wdat-ich9-stub.c    | 15 +++++++
>  hw/acpi/wdat-ich9.c         | 90 +++++++++++++++++++++++++++++++++++++
>  hw/i386/acpi-build.c        | 12 +++++
>  5 files changed, 134 insertions(+), 1 deletion(-)
>  create mode 100644 include/hw/acpi/wdat-ich9.h
>  create mode 100644 hw/acpi/wdat-ich9-stub.c
>  create mode 100644 hw/acpi/wdat-ich9.c

...

> +void build_ich9_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
> +                     const char *oem_table_id, uint64_t tco_base)
> +{
> +    AcpiTable table = { .sig = "WDAT", .rev = 1, .oem_id = oem_id,
> +                        .oem_table_id = oem_table_id };
> +    struct AcpiGenericAddress tco_rld =  TCO_REG(tco_base, 0x0, 16);
> +    struct AcpiGenericAddress tco2_sts = TCO_REG(tco_base, 0x6, 16);
> +    struct AcpiGenericAddress tco1_cnt = TCO_REG(tco_base, 0x8, 16);
> +    struct AcpiGenericAddress tco_tmr =  TCO_REG(tco_base, 0x12, 16);
> +
> +    acpi_table_begin(&table, table_data);
> +    build_append_int_noprefix(table_data, 0x20, 4); /* Watchdog Header Length */
> +    build_append_int_noprefix(table_data, 0xff, 2); /* PCI Segment */
> +    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Bus Number */
> +    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Device Number */
> +    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Function Number */
> +    build_append_int_noprefix(table_data, 0, 3);    /* Reserved */
> +    /*
> +     * limits/resolution are defined by ICH9 TCO spec
> +     */
> +    build_append_int_noprefix(table_data, 0x258, 4);/* Timer Period, ms */
> +    build_append_int_noprefix(table_data, 0x3ff, 4);/* Maximum Count */
> +    build_append_int_noprefix(table_data, 0x4, 4);  /* Minimum Count */

Spec said: The time-out period before the WDT fires is recommended to be at
least 5 minutes and is required to be less than 4,294,967,296 count
intervals.

Here we encode 0x4 * 0x258 = 2400ms, less than 5 minutes. But I
understand because "5 minutes" is just "recommanded" by spec, so 2400ms is
okay.

LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


