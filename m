Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A31C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 10:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYjLo-0004Ze-2B; Fri, 17 Jan 2025 05:13:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tYjLl-0004W2-KH; Fri, 17 Jan 2025 05:13:14 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tYjLf-0001nf-Gw; Fri, 17 Jan 2025 05:13:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737108788; x=1768644788;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=SIgXHvANC82Vg5ReA7IdnJaf8txoLEWwOmUSigIHr1E=;
 b=QPk0OGdfwugbp1V+cygNjkyxbi0mC8tZnKqauNvmHQxDJvgG4saIQZp5
 NHbRgO7iJiAMP95GpP6cw0CpjJI31CgnCuVG/R25aCJBEKixQKeERNObC
 PR46qOtWyeEaoNxeKTdYoLdv0wjRomdcaG9GkGKoHNQfQdGH3fXMGZTj2
 xWrwi8hP30EuPggPVoDCcBJ9af5LsD1DTIp7V3E8f2VTtaJukj9SxiKsI
 VysXe8KSh6Yvg1CxJRDPqkVhItpWaamqy6r6KFEBH9B7levDJzBOr/3Dr
 5hs0H0B67ALz7SzGRSWAVZ//bHJ3V5d0WAfezWcS0bruY0L2kwN0cbesP A==;
X-CSE-ConnectionGUID: jjOKpBM6QbSVpKQ/mxph9g==
X-CSE-MsgGUID: 3GElGCZARo2MT9Ez1cEgWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37653914"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="37653914"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jan 2025 02:13:02 -0800
X-CSE-ConnectionGUID: uuQp4KGPSf2/vMZfvMk9eg==
X-CSE-MsgGUID: 5/19OrRTQO2IA3olY19A1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="105612788"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 17 Jan 2025 02:12:59 -0800
Date: Fri, 17 Jan 2025 18:31:51 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [RFC 09/13] i386/fw_cfg: move hpet_cfg definition to hpet.c
Message-ID: <Z4oxlydZIK/f/aNC@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-10-zhao1.liu@intel.com>
 <1da970e8-1708-48ef-87c4-1099d23e8909@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1da970e8-1708-48ef-87c4-1099d23e8909@redhat.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> This breaks if you disable HPET, which is why fw_cfg.c defines it.
> 
> You can do something like
> 
> diff --git a/include/hw/timer/hpet-fw-cfg.h b/include/hw/timer/hpet-fw-cfg.h
> new file mode 100644
> index 00000000000..234a49fc92e
> --- /dev/null
> +++ b/include/hw/timer/hpet-fw-cfg.h
> @@ -0,0 +1,16 @@
> +struct hpet_fw_entry
> +{
> +    uint32_t event_timer_block_id;
> +    uint64_t address;
> +    uint16_t min_tick;
> +    uint8_t page_prot;
> +} QEMU_PACKED;
> +
> +struct hpet_fw_config
> +{
> +    uint8_t count;
> +    struct hpet_fw_entry hpet[8];
> +} QEMU_PACKED;
> +
> +extern struct hpet_fw_config hpet_fw_cfg;
> +
> diff --git a/include/hw/timer/hpet.h b/include/hw/timer/hpet.h
> index d17a8d43199..6f7fcbc3c60 100644
> --- a/include/hw/timer/hpet.h
> +++ b/include/hw/timer/hpet.h
> @@ -60,26 +60,12 @@
>  #define HPET_TN_INT_ROUTE_CAP_SHIFT 32
>  #define HPET_TN_CFG_BITS_READONLY_OR_RESERVED 0xffff80b1U
> -struct hpet_fw_entry
> -{
> -    uint32_t event_timer_block_id;
> -    uint64_t address;
> -    uint16_t min_tick;
> -    uint8_t page_prot;
> -} QEMU_PACKED;
> -
> -struct hpet_fw_config
> -{
> -    uint8_t count;
> -    struct hpet_fw_entry hpet[8];
> -} QEMU_PACKED;
> -
> -extern struct hpet_fw_config hpet_cfg;
> -
>  #define TYPE_HPET "hpet"
>  #define HPET_INTCAP "hpet-intcap"
> +#include "hw/timer/hpet-fw-cfg.h"
> +
>  static inline bool hpet_find(void)
>  {
>      return object_resolve_path_type("", TYPE_HPET, NULL);
> diff --git a/rust/wrapper.h b/rust/wrapper.h
> index 285d0eb6ad0..82381e43472 100644
> --- a/rust/wrapper.h
> +++ b/rust/wrapper.h
> @@ -62,3 +62,4 @@ typedef enum memory_order {
>  #include "qapi/error.h"
>  #include "migration/vmstate.h"
>  #include "chardev/char-serial.h"
> +#include "hw/timer/hpet-fw-cfg.h"
> 
> 
> but you will have to use unsafe to access it since it's a "static mut".
> 

Unfortunately, this way doesn't work either, if we disable both
CONFIG_HPET and CONFIG_X_HPET_RUST.

This is because I integrates hpet_fw_cfg into hpet lib which is compiled
under CONFIG_X_HPET_RUST along with other HPET parts.

The place broken is when hpet_fw_cfg is written into machine's fw_cfg (in
hw/i386/fw_cfg.c).

I think we can just wrap such write like:

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 162785019b7a..3635b83620da 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -147,7 +147,14 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
 #endif
     fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, 1);

-    fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_fw_cfg, sizeof(hpet_fw_cfg));
+#if defined(CONFIG_HPET) || defined(CONFIG_X_HPET_RUST)
+    PCMachineState *pcms = (PCMachineState *)object_dynamic_cast(OBJECT(ms),
+                                                                 TYPE_PC_MACHINE);
+    if (pcms && pcms->hpet_enabled) {
+        fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_fw_cfg, sizeof(hpet_fw_cfg));
+    }
+#endif
+
     /* allocate memory for the NUMA channel: one (64bit) word for the number
      * of nodes, one word for each VCPU->node and one word for each node to
      * hold the amount of memory.

---

The hpet_fw_cfg is written unconditionally since 40ac17cd, because it
concerns ACPI HPET is created unconditionally. But that fact has changed
and ACPI checks HPET device now (hw/i386/acpi-build.c):

static void acpi_get_misc_info(AcpiMiscInfo *info)
{
    info->has_hpet = hpet_find();
#ifdef CONFIG_TPM
    info->tpm_version = tpm_get_version(tpm_find());
#endif
}

I think this is a thorough enough solution and I can post a separate
patch.

Thanks,
Zhao




