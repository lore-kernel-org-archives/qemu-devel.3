Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C02CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 12:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKbMO-0005Wj-Um; Wed, 06 May 2026 08:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wKbMM-0005W8-82
 for qemu-devel@nongnu.org; Wed, 06 May 2026 08:28:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wKbMB-0001oe-Ma
 for qemu-devel@nongnu.org; Wed, 06 May 2026 08:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778070481;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/PoO/YSWuuQn8MYN48uxszW/67/0bMvM+epWQ24oSxM=;
 b=XCqO7iDIeabf6YAZoUqEtYFock49rKHABdUZpD45TnN4WhvrU/G+NBuoBx+aWrQp/ZHgZY
 J+6eOR4XVwzm/bz7I969RgGKkp7AU7x9ywM829/6h539JujjpUGV6fuhBMLAjiCeP1QGUn
 x5mgVclySpj5yuaWz+U78CAKKg2je10=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-kR_VcDqeNKanHZGZQtWyvA-1; Wed, 06 May 2026 08:28:00 -0400
X-MC-Unique: kR_VcDqeNKanHZGZQtWyvA-1
X-Mimecast-MFC-AGG-ID: kR_VcDqeNKanHZGZQtWyvA_1778070479
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488d1b5bca0so33667125e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 05:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778070479; x=1778675279;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/PoO/YSWuuQn8MYN48uxszW/67/0bMvM+epWQ24oSxM=;
 b=cqXaSF2jse7oJMT4H/XjtFNixpmpUlfYKtu9sJkaZkRffKaH+srPDZUYAkCNl7B8L7
 D3yTN0l1zkZKkHqlWmGE3cnfqJBMrkTMk+1rx1cmo9cMKu8FXTbu7WAOYGSlW9heF3Bc
 03exPEiQwmSABzQ3J3dxsvCrZ7pErgUVEucbtj3za+kXq374Vxn0JcDKvz67EoV7LZdS
 XGi+RIZzelBRilecnc8IfkHm64M3AryezknLn4brLEjKXtWBkkT289zv3wEqzofOTfZR
 iNIi3Av1sj7wwidkc50q7u5wtO1IhUqCel6qSYeR5BaKFKDqAsAH9cRZ8HHx1LNyF3Ml
 3PCw==
X-Forwarded-Encrypted: i=1;
 AFNElJ96A8O3WzK3WSYpoCc5f/6x8GohzL+oDbzJ5lwO7/UHNZsgKfAp5Sy/osjsjz3D1X4MuDXH226NF74F@nongnu.org
X-Gm-Message-State: AOJu0YwdHE/nJ04e8gfW/EM8DCoVW2Vdc5y9xD5R2UKDnpyiC/omB1dm
 Vs4EXAjSB3u38313EHL8ncf2ACeVtafGja0cyj86DtX4iIzrjSy5jq6ROzMXZwUByyreO0xngXG
 AZsFKr2wf/bMeabL0eIN7Mz0ulRvT/eDQo/jDbAfmhJ/IUECZDc4X50/r
X-Gm-Gg: AeBDievNyjGuzgRSObfv2sR0q8cvXNmEsb0yZN+jtzsbC2R/JoW26jKJAJhJAhOTEkq
 E84HFjRirq6RDGkd1etdjfz67UmqTfpVD+8CrSA2snPS68nyxxuckGW25kkPS/EG6/5VipmNNcD
 s/nCw1cdcC+Um3xcB2OL+LZ8KSe5xBM5JIxZlIqbyUEGn6Fb59OB1MGbIqOJU/NFxpyYx+R+4a0
 hcImRaRhFXdYfA9HqD2OeuR3lQGmWs5TzBMoIPl6aHUHmqDPyoRVRVVfEeSY4d8oBaMRdEY8O8f
 XfL0PQfZcUFno2HcPPCQk5UhOoKKNMQWsv6+TUuTSeOc1NAM8f5GeZZdKpqKGKPB8Bb7OBI4UK8
 LeMjZeji4oSxAkkbXNWjjTbxyMAYQr+pEHF3E77LZCdMwLV8MGgiuz8NNG5QO4mnieX12A3PMJ6
 KnW7Ba
X-Received: by 2002:a05:600c:6095:b0:485:39b2:a47c with SMTP id
 5b1f17b1804b1-48e51f48352mr55998215e9.25.1778070478820; 
 Wed, 06 May 2026 05:27:58 -0700 (PDT)
X-Received: by 2002:a05:600c:6095:b0:485:39b2:a47c with SMTP id
 5b1f17b1804b1-48e51f48352mr55997815e9.25.1778070478407; 
 Wed, 06 May 2026 05:27:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5389da63sm44587985e9.4.2026.05.06.05.27.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 05:27:57 -0700 (PDT)
Message-ID: <869487dc-ae63-4a86-b680-8ec70789e18a@redhat.com>
Date: Wed, 6 May 2026 14:27:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/31] hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0 as
 VCMDQ backing
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhenzhong.duan@intel.com,
 kjaju@nvidia.com, phrdina@redhat.com
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-21-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260415105552.622421-21-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 4/15/26 12:55 PM, Shameer Kolothum wrote:
> Introduce tegra241_cmdqv_vintf_ptr() to route VCMDQ register accesses
> through the mmap'd VINTF page0 backing once a hardware queue has been
> allocated.
>
> There are two QEMU trapped MMIO apertures for VCMDQ registers:
s/VCMDQ registers/ VCMDQ Page0 registers
>
>   - Direct VCMDQ aperture (offset 0x10000)
emphasize this is page 0
>   - VINTF Page0 (offset 0x30000)
>
> These are hardware aliases: they address the same underlying registers.
> A subsequent patch maps the VINTF aperture as a guest-direct RAM region;
> in this patch both remain QEMU-trapped.
>
> VCMDQ register accesses operate in one of two mutually exclusive modes,
> depending on whether a hardware queue (IOMMU_HW_QUEUE_ALLOC) has been
> allocated for the VCMDQ:
>
> Pre-alloc: vintf_ptr is NULL. Both apertures use QEMU's register
> cache. Hardware is not yet engaged;
>
> Post-alloc: vintf_ptr is valid. Both QEMU trapped apertures access
> registers directly via the mmap'd vintf_page0 pointer, bypassing
> the cache. Hardware is the single source of truth.
>
> The pre-to-post-alloc transition is triggered by the BASE register write
> that initiates IOMMU_HW_QUEUE_ALLOC. No cache-to-hardware synchronisation
> is needed at transition time. The hardware mandated init sequence requires
> BASE to be written first; PROD_INDX, CONS_INDX and CONFIG.CMDQ_EN are
> programmed only after BASE and are therefore always post-alloc.
>
> Any pre-alloc writes to those registers update only the register cache,
> which is discarded at the transition.
>
> CMDQV acceleration only becomes active once the guest enables VINTF and
> programs the VCMDQ BASE register. Until then, all VCMDQ accesses are
> served from the emulated register cache with no real hardware command
> processing. This matches the CMDQV hardware specification: if the logical
> CMDQ index does not map to any allocated Virtual CMDQ, "the access is
> dropped with no Fault/Interrupt".
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.c | 48 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index b5f2f74cf2..eb619e1134 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -75,17 +75,45 @@ static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
>      return true;
>  }
>  
> +static inline uint32_t *tegra241_cmdqv_vintf_ptr(Tegra241CMDQV *cmdqv,
> +                                                 int index, hwaddr offset0)
> +{
> +    if (!cmdqv->vcmdq[index] || !cmdqv->vintf_page0) {
> +        return NULL;
> +    }
> +    return (uint32_t *)(cmdqv->vintf_page0 +
> +                        (index * CMDQV_VCMDQ_STRIDE) +
> +                        (offset0 - CMDQV_VCMDQ_PAGE0_BASE));
> +}
> +
>  /*
>   * Read a VCMDQ register using VCMDQ0_* offsets.
>   *
>   * The caller normalizes the MMIO offset such that @offset0 always refers
>   * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
>   *
> - * All VCMDQ accesses return cached registers.
> + * If the VCMDQ is allocated and VINTF page0 is mmap'd, read directly
> + * from the VINTF page0 backing. Otherwise, fall back to cached state.
>   */
>  static uint64_t tegra241_cmdqv_read_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0,
>                                            int index)
>  {
> +    uint32_t *ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, offset0);
> +
> +    if (ptr) {
> +        switch (offset0) {
> +        case A_VCMDQ0_CONS_INDX:
> +        case A_VCMDQ0_PROD_INDX:
> +        case A_VCMDQ0_CONFIG:
> +        case A_VCMDQ0_STATUS:
> +        case A_VCMDQ0_GERROR:
> +        case A_VCMDQ0_GERRORN:
> +            return *ptr;
> +        default:
are there other page0 regs which are not modeled for which this
implement would return 0?
> +            break;
> +        }
> +    }
I would prefer we have a clear separation between page0 accesses and
page1 accesses (meaning 2 different helpers).

This would help understand that page1 accesses are always trapped
whereas page0 access can be either cached or mmapped.
> +
>      switch (offset0) {
>      case A_VCMDQ0_CONS_INDX:
>          return cmdqv->vcmdq_cons_indx[index];
> @@ -120,11 +148,29 @@ static uint64_t tegra241_cmdqv_read_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0,
>   *
>   * The caller normalizes the MMIO offset such that @offset0 always refers
>   * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
> + *
> + * If the VCMDQ is allocated and VINTF page0 is mmap'd, write directly
> + * to the VINTF page0 backing. Otherwise, update cached state.
>   */
>  static void tegra241_cmdqv_write_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0,
>                                         int index, uint64_t value,
>                                         unsigned size, Error **errp)
>  {
> +    uint32_t *ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, offset0);
> +
> +    if (ptr) {
> +        switch (offset0) {
> +        case A_VCMDQ0_CONS_INDX:
> +        case A_VCMDQ0_PROD_INDX:
> +        case A_VCMDQ0_CONFIG:
> +        case A_VCMDQ0_GERRORN:
> +            *ptr = (uint32_t)value;
> +            return;
> +        default:
> +            break;
> +        }
> +    }
> +
>      switch (offset0) {
>      case A_VCMDQ0_CONS_INDX:
>          cmdqv->vcmdq_cons_indx[index] = (uint32_t)value;
Thanks

Eric


