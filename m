Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37FBCD6E6B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV6or-0005a6-KI; Thu, 04 Jun 2026 08:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wV6ol-0005ZK-5y
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 08:04:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wV6oi-0007jE-9B
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 08:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780574694;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rWp2RSDCvMDMihzheVnZxgAJCtfA1V9HskT1OAMbe6E=;
 b=H1Xw5pUczPwD3RSKU0E0x1j2ZL1B5Go99OSutC+LnwztX8Xn5/Igz14xu/5sOQqquwwtJr
 4RUPtKLxSyvYyLtmh3eSFdhwbM/9A/4RNBaRtGmc+QrH+78ovW46Z8O3TJs9TV8pjKS1oq
 0E3VPsWcR6g7TnV15DVs0DDvpRJzN5E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-8GovJ0O7N7GPZVxkPycaoQ-1; Thu, 04 Jun 2026 08:04:52 -0400
X-MC-Unique: 8GovJ0O7N7GPZVxkPycaoQ-1
X-Mimecast-MFC-AGG-ID: 8GovJ0O7N7GPZVxkPycaoQ_1780574691
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45ef9437b7aso444322f8f.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 05:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780574691; x=1781179491;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rWp2RSDCvMDMihzheVnZxgAJCtfA1V9HskT1OAMbe6E=;
 b=XlbjVPHpvOLUOxLB4+3gFNVSXoYkH3nczo3w24JG8XeewHOe816TSdVZ2Zbx34xmZf
 FBsaUT2yxwpsnWvOhhsbcfTqwbh7zgMFg7/byXnr/TAHLIGWkIDCMJNZpyFRQAC2ohwk
 ++dafwJuSQ2ug+gj+otFt0SOG0x6tgHj9Ug0lV4OTubzxD8Fa/0rD1unNoSLoQCr2WwN
 vZT01TT5sVZ4u6+rFv9o7+blgo9nqZn8tw0CTvN3eOsVeBkbmARWbzJDg8/lSg1xsLnS
 zUedwU73zlSW+NgwuG4/ho3hgh8UGCodCUd1NNFd8MgV6O1fskPsaVaLadG/tStoBtUU
 bqqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9W/iZwJ/Zb2XHV0VK86I/M85MeK/qJZSC+1KNrdylv6eW/Ns9+uDUj1osuiCB4O3zVCol/hFOFoWMq@nongnu.org
X-Gm-Message-State: AOJu0YzbPSOGmoAW3fZxPsaK/VHVA2NdzX7mGP/WqX3Gu9i++K+MAZKC
 YNVU0GG1Lx5cz3poD5fNv1V+6EsCsHqVG+TWYKosgggJNYMTiHBR4DUBsBMmfO/ZVOQz2dasc+7
 zhPoAycsDIN7bmLyMQ9p5WEbqfUiU5qI0B/fo5zoisSr4BzCOy3kBXhbi
X-Gm-Gg: Acq92OHkH4qnVOIE/v1fThOk/7B1kBYYk5eLxaf4HoA2xCPny/exWPOZB0eVreH6fev
 bBbbljY3TJ6FjkuEWci7h/LLFx87rw5527TjSzBmuOT9JJH3W1wvFAiO+mQv3QF+mpZx0iJTZYK
 QoM8wpadfs7n3Cd2XLlH4WqLntIanlprmzfnLWivEr08VCcn1sDcJ+1kURf3A4H/Z9gwQXHMR8D
 Tp9GmdKlLDOPxE/UrmML0EtF6Pisf/b3PRMRJR1eNzmeVxZA+UfBN7rPxM8GWNJ7EMjkUE9A6Yt
 A7thuYEvMX2iijSRuYWdLEP1EWsEgnaZwSpHjcxko+GL2BuF/3qB8vG7LVQ3W0cJnlWNemo8h4S
 FvV8r5/uMLbl3U2pF0nVe0eQnCQ76/SwMfd9GC1s2X3SgIdwyFkLCUl/2vu4wzwsVAdNVb+z2lX
 N4qDxl
X-Received: by 2002:a05:600c:a09:b0:490:688b:f9f8 with SMTP id
 5b1f17b1804b1-490b5fe6672mr124374535e9.27.1780574691085; 
 Thu, 04 Jun 2026 05:04:51 -0700 (PDT)
X-Received: by 2002:a05:600c:a09:b0:490:688b:f9f8 with SMTP id
 5b1f17b1804b1-490b5fe6672mr124373775e9.27.1780574690619; 
 Thu, 04 Jun 2026 05:04:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcb13sm15562980f8f.2.2026.06.04.05.04.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 05:04:50 -0700 (PDT)
Message-ID: <0a3a4401-2c1f-485c-b0b4-5f435c0a58fa@redhat.com>
Date: Thu, 4 Jun 2026 14:04:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 25/31] hw/arm/tegra241-cmdqv: Limit queue size based on
 backend page size
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, zhenzhong.duan@intel.com, kjaju@nvidia.com,
 phrdina@redhat.com
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
 <20260601114221.457995-26-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260601114221.457995-26-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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



On 6/1/26 1:42 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> CMDQV HW performs DMA accesses to guest queue memory by its host
> physical address set up via IOMMUFD. This requires the guest queue
> to be contiguous in both guest PA and host PA space. With Tegra241
> CMDQV enabled, we must only advertise a command queue size (CMDQS)
> that the host can safely back with physically contiguous memory.
> Allowing a queue size larger than the host page size could cause
> the hardware to DMA across page boundaries, leading to faults.
>
> Use qemu_minrampagesize() to find the smallest memory-backend page
> size in use, then cap IDR1.CMDQS so the guest cannot configure a
> command queue that exceeds that contiguous backing.
>
> Note this is done at SMMUv3 init, before any guest queue GPA is
> known, so the cap is conservative. Maximum queue size is 8MiB;
> it is recommended to back the VM with hugepage sizes large enough
> so CMDQS stays at the HW maximum. Smaller backing pages reduce
> CMDQS accordingly.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> ---
>  hw/arm/tegra241-cmdqv.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index ac17b56c1c..661c46e3d9 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -16,6 +16,8 @@
>  #include "hw/arm/smmuv3-common.h"
>  #include "hw/core/irq.h"
>  #include "smmuv3-accel.h"
> +#include "smmuv3-internal.h"
> +#include "system/hostmem.h"
>  #include "tegra241-cmdqv.h"
>  #include "trace.h"
>  
> @@ -874,6 +876,8 @@ free_viommu:
>  static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
>  {
>      int i;
> +    long pgsize;
> +    uint32_t val;
>  
>      cmdqv->config = V_CONFIG_RESET;
>      cmdqv->param = FIELD_DP32(0, PARAM, CMDQV_VER, CMDQV_VER);
> @@ -905,6 +909,22 @@ static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
>          cmdqv->vcmdq_base[i] = 0;
>          cmdqv->vcmdq_cons_indx_base[i] = 0;
>      }
> +
> +    /*
> +     * CMDQ must not cross a physical RAM backend page. Adjust CMDQS so the
> +     * queue fits entirely within the smallest backend page size, ensuring
> +     * the command queue is physically contiguous in host memory.
> +     *
> +     *   IDR1.CMDQS = log2(max_qsz) - entry_shift
> +     *
> +     * where entry_shift = 4 (each CMDQ entry is 16 bytes = 2^4).
> +     */
> +    pgsize = qemu_minrampagesize();
> +    if (pgsize == LONG_MAX) {
> +        pgsize = qemu_real_host_page_size();
> +    }
> +    val = FIELD_EX32(s->idr[1], IDR1, CMDQS);
> +    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS, MIN(ctz64(pgsize) - 4, val));
>  }
>  
>  static void tegra241_cmdqv_reset(SMMUv3State *s)


