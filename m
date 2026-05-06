Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F135CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 12:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKbck-0002LW-Vn; Wed, 06 May 2026 08:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wKbcf-0002EZ-70
 for qemu-devel@nongnu.org; Wed, 06 May 2026 08:45:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wKbcd-0005gu-7B
 for qemu-devel@nongnu.org; Wed, 06 May 2026 08:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778071501;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R2zUJRp5isIzC4I+U9uuUTm0bVtshQuzDJK0Ti/Oc0g=;
 b=Ipl6G2uZPqqXlpRlGuZnhfR739DrtTyyifRLy9QRX+gJKyYwbIsnbWumS08kImlpSIV1qU
 UNgcooWJa0W4BWU+ELADMpUxuE3Krqg2cNLQIBWU23DNbkoVWCq7bazBqkx/+Ll43X/DYq
 783IHd3p2HJfDtsAL927T+bWfNpalz4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-X7jF9731PFeOEI1RQ8GaIg-1; Wed, 06 May 2026 08:45:00 -0400
X-MC-Unique: X7jF9731PFeOEI1RQ8GaIg-1
X-Mimecast-MFC-AGG-ID: X7jF9731PFeOEI1RQ8GaIg_1778071499
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-44f1b4d0fb0so1776756f8f.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 05:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778071499; x=1778676299;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2zUJRp5isIzC4I+U9uuUTm0bVtshQuzDJK0Ti/Oc0g=;
 b=EvehU3Lwa+zeE7l+gOF/UVk4wxtRrkbDUHBbQ86nmufRX7RPAsKH9U0ZUe5bDLnB6j
 tt/BBG+s17s2DM1y4NCKvmCvHHANxFk774TVafczkmqknF94BKISoF4/Z9x87mcSlW8Q
 oxItblp9/FuFpsnLUklYoBzgObeqTeniKulAmcKGTX9hrnlxZZoFHGmQTMHYlB6aqMko
 BwPUHYs+4sn1/u9FS04CJwtdmutCT/gPTYL8OXUX6LVaictww76tUiaQWR3Ku0H7elp+
 kxuoWwOTZym0WxqiVreRTE2jZYWyvYb4J3fnFpABwzrbEuxrRWee3Xa0wqAURA+jzikc
 iqhg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8a3LyM7/xMxMG3ysf4ArIM0b9B19Qz5OVtqzbZuRRDVcm/M05amHyIVPo8z2qAtHNMrSW6+dPOj32C@nongnu.org
X-Gm-Message-State: AOJu0YxCPR3YNeVB3IElDhWcqDLyVimsQ62LPGEadTCwM17piy2C6sXa
 TDunAoxteEvLrxA+CC2cjV2z7Z0xlamoGQ4rrlDRxeqgjmU46V5sBiTfeXv7EBkqJs50xlsZTkL
 pFXuX1cikAmweuCwtb7ll5r5kJKZW2R5FfonCmeXNFSA0ma6G4P5bNFFo
X-Gm-Gg: AeBDiesZJlT3NcVZU4wAD2DtdTI5yPvAzqDMqNSGR/2gI8fwcKSi45zGdAFRTT9C6r3
 OlHNLU9t4ujHhoUI+cG/h54Ub20NY3dgU+UrG7N60zhIwWK9G1l49k6UNcJFw8kx6yYKacRppeK
 SDt3m6E1JFcDUiQSywLUIkCmYed4TQevngYtWU6CkbhpUhVeLhhsmZ1nyrftJyfQKL8gHdOR2je
 gyExlgV2x/POk3yyXQ7ju03p4hbBDxrBw0lyXleOr3uYMH/TeHdRq4boGb6qMamlAgjRpH3fZCv
 6rclOp26MUi5um0Lj7ARW98UroWHSnvitrYQtq56cS6taAyVcuLzpmDobQhQOuIkvtnPIaofITv
 w9cnD/jn1C/WAP33ES05t5S4AKB4sLZvoRzKL1mqJnf6+w08rajaGvSnUqvDDVdfnoSnM+Qk+Eu
 bui2ga
X-Received: by 2002:a05:600c:8b0c:b0:48a:7a10:4f47 with SMTP id
 5b1f17b1804b1-48e51e0a620mr60627905e9.3.1778071499003; 
 Wed, 06 May 2026 05:44:59 -0700 (PDT)
X-Received: by 2002:a05:600c:8b0c:b0:48a:7a10:4f47 with SMTP id
 5b1f17b1804b1-48e51e0a620mr60627415e9.3.1778071498627; 
 Wed, 06 May 2026 05:44:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538fad5fsm50164865e9.10.2026.05.06.05.44.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 05:44:58 -0700 (PDT)
Message-ID: <4918654a-7c79-474b-9ede-5418460a5a76@redhat.com>
Date: Wed, 6 May 2026 14:44:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/31] hw/arm/tegra241-cmdqv: Map VINTF page0 into
 guest MMIO space
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhenzhong.duan@intel.com,
 kjaju@nvidia.com, phrdina@redhat.com
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-23-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260415105552.622421-23-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 4/15/26 12:55 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Once a VCMDQ is allocated, map the mmap'd vintf_page0 region directly
> into the guest-visible MMIO space at offset 0x30000 as a RAM-backed
> MemoryRegion. This eliminates QEMU trapping for hot-path CONS/PROD
> index updates.
>
> After this patch, the two VCMDQ apertures use different access paths:
> the direct aperture (0x10000) remains QEMU-trapped and writes via
> vintf_ptr, while the VI aperture (0x30000) is a direct guest RAM
> mapping. Both paths write to the same underlying vintf_page0 memory,
> so no synchronisation between the apertures is needed.

I fail to understand when the previous trapped path using ptr in
tegra241_cmdqv_read/write_vcmdq gets used versus that path. Is it
eventually used?
>
> The mapping is installed lazily on first successful VCMDQ hardware
> queue allocation and removed when CMDQV or VINTF is disabled.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.h |  1 +
>  hw/arm/tegra241-cmdqv.c | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
>
> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
> index 039d86374f..2befa6205e 100644
> --- a/hw/arm/tegra241-cmdqv.h
> +++ b/hw/arm/tegra241-cmdqv.h
> @@ -46,6 +46,7 @@ typedef struct Tegra241CMDQV {
>      IOMMUFDVeventq *veventq;
>      IOMMUFDHWqueue *vcmdq[TEGRA241_CMDQV_MAX_CMDQ];
>      void *vintf_page0;
> +    MemoryRegion *mr_vintf_page0;
>  
>      /* Register Cache */
>      uint32_t config;
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index eb619e1134..bf989dd51f 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -15,6 +15,40 @@
>  #include "tegra241-cmdqv.h"
>  #include "trace.h"
>  
> +static void tegra241_cmdqv_guest_unmap_vintf_page0(Tegra241CMDQV *cmdqv)
> +{
> +    if (!cmdqv->mr_vintf_page0) {
> +        return;
> +    }
> +
> +    memory_region_del_subregion(&cmdqv->mmio_cmdqv, cmdqv->mr_vintf_page0);
> +    object_unparent(OBJECT(cmdqv->mr_vintf_page0));
> +    g_free(cmdqv->mr_vintf_page0);
> +    cmdqv->mr_vintf_page0 = NULL;
> +}
> +
> +static void tegra241_cmdqv_guest_map_vintf_page0(Tegra241CMDQV *cmdqv)
> +{
> +    char *name;
> +
> +    if (cmdqv->mr_vintf_page0) {
> +        return;
> +    }
> +
> +    name = g_strdup_printf("%s vintf-page0",
> +                           memory_region_name(&cmdqv->mmio_cmdqv));
> +    cmdqv->mr_vintf_page0 = g_malloc0(sizeof(*cmdqv->mr_vintf_page0));
> +    memory_region_init_ram_device_ptr(cmdqv->mr_vintf_page0,
> +                                      memory_region_owner(&cmdqv->mmio_cmdqv),
> +                                      name, VINTF_PAGE_SIZE,
> +                                      cmdqv->vintf_page0);
> +    cmdqv->mr_vintf_page0->ram_device_skip_iommu_map = true;
I guess you need a setter, here to.
> +    memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv,
> +                                        CMDQV_VINTF_PAGE0_BASE,
> +                                        cmdqv->mr_vintf_page0, 1);
> +    g_free(name);
> +}
> +
>  static void tegra241_cmdqv_free_vcmdq(Tegra241CMDQV *cmdqv, int index)
>  {
>      IOMMUFDViommu *viommu = cmdqv->s_accel->viommu;
> @@ -72,6 +106,7 @@ static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
>      hw_queue->viommu = viommu;
>      cmdqv->vcmdq[index] = hw_queue;
>  
> +    tegra241_cmdqv_guest_map_vintf_page0(cmdqv);
>      return true;
>  }
>  
> @@ -312,6 +347,7 @@ static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
>                  cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
>              }
>          } else {
> +            tegra241_cmdqv_guest_unmap_vintf_page0(cmdqv);
>              tegra241_cmdqv_free_all_vcmdq(cmdqv);
>              tegra241_cmdqv_munmap_vintf_page0(cmdqv, errp);
>              cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
> @@ -438,6 +474,7 @@ static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
>          if (value & R_CONFIG_CMDQV_EN_MASK) {
>              cmdqv->status |= R_STATUS_CMDQV_ENABLED_MASK;
>          } else {
> +            tegra241_cmdqv_guest_unmap_vintf_page0(cmdqv);
>              tegra241_cmdqv_free_all_vcmdq(cmdqv);
>              cmdqv->status &= ~R_STATUS_CMDQV_ENABLED_MASK;
>          }
Thanks

Eric


