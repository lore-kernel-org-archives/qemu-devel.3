Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299E4CD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 10:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKDFA-0005sn-OH; Tue, 05 May 2026 06:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wKDF6-0005s6-6q
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:43:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wKDF4-00038y-AC
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777977785;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hm9Udy8qecY32jK1J534y99qVoBQy65LoN7flgxPzIY=;
 b=Be35xvFZgpt2kCN7B1mF8d8T3KNOU+tIf1tY9Web2/mZWbjPE7JS2U57CiGG9jK8SDCOEb
 0o82qw6efqXZT/V1w/E9W2dLGXzulYWW8EgaYsz9NGMRAnhQ8b2dIxELt9CgCv/9dgJMGQ
 Pm8+QYG89kor9ovJc947UK63dMLSy2A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-sE1XOc11NlOP6pXzg1xQ3w-1; Tue, 05 May 2026 06:43:04 -0400
X-MC-Unique: sE1XOc11NlOP6pXzg1xQ3w-1
X-Mimecast-MFC-AGG-ID: sE1XOc11NlOP6pXzg1xQ3w_1777977783
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488ba2f4094so37252105e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 03:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777977783; x=1778582583;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hm9Udy8qecY32jK1J534y99qVoBQy65LoN7flgxPzIY=;
 b=Tv/hw9ENwtrXMOne5w9xJ0NizFaMr+ZL+Wg3e/E8VexHa9aWl0OjEfq/4aP2N825dx
 05qh/6VaqMgVsuliZ49RodJZCvcBgdUyFAmyly5pF5xZqtPm/cBlfhnSLO0/SKIk7qG9
 LXzGF3t1aco6+gQxGDs2m0Bj82KMBGGX1RlKbZK/tMjhi4mKcXVM+iqiKl6vB99zBxuD
 o4YB+QHi/B240xnEuBpwfUteyFMjZRZCmT4eeVEhvZ2lH++kp89lsdPg4qZ6x5B5OEqg
 0XDx0dfpnlOm5zU766rMm6kpX1s4xHZJCsI10ieaHpI9GLDIavfQgAzeuJI1KP1X65x7
 SJvg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9omoWe1TI93eESViaw93f4M0TCtboFu2SLOJupLd6gRQH0yfVwnND9MTanw/IjunlbSSa3SzKYeNj1@nongnu.org
X-Gm-Message-State: AOJu0Yzi5buqU7vJr+nksyeKdpURnvnLaIUQscuRpk65IDS6AIfg1K+m
 totLXIT1JlLAvQIVUDDvw2MNzWkb20csVe1GNDulg+O92kgQ0JCBnkw+pnKO6p5h4MWtSsdyc6p
 ekjbSFhHtNzluPn7P61g6qCBrKjXIogJW47ExHpscd/FIHaZQVS5WhVmy
X-Gm-Gg: AeBDievBD3ecFcQ56+LeVKLV3yVvBYgEPtbf+MDvdT8ae3HygedWOScViLDcTapeXVP
 D8CvoKWdPWzZOm+i5e0DktMwRKPyNmsy7nw3dwkZU+t0HxEnvP6sptixLIazfS1FSO777BipN8W
 rkOv1o+twExVhGFssGPBNmCnNn/mVX7Kb0fPEG8f/OnanqC7Sh2Oxs2ycKeiWuv2ik50TAQuyXB
 2QWQPNvlyGTL/uQvcEnOkXCVFSFJy2rSxWD77fDruv+o0VCOgfH9vf5DdbsHCDW9Z82DnDrMDqB
 uKXChW41RyS/qDFGjg0sKnT1gC2Dnmj1pUOIrV4cQtMLF1YZM0dQtOCz77bT6x8ETRwzBsc6unt
 w0ch+73uugDTa6E+SmJSMLfJkpqA0T0E2tV6e3bRg/+0mA3gsm0/UGpWG+nvDfR1Fl+IRrx66KL
 4eVokU
X-Received: by 2002:a05:600d:8451:b0:488:a723:ea53 with SMTP id
 5b1f17b1804b1-48d187d95e0mr29233125e9.7.1777977782933; 
 Tue, 05 May 2026 03:43:02 -0700 (PDT)
X-Received: by 2002:a05:600d:8451:b0:488:a723:ea53 with SMTP id
 5b1f17b1804b1-48d187d95e0mr29232745e9.7.1777977782459; 
 Tue, 05 May 2026 03:43:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d149ebdebsm22736025e9.4.2026.05.05.03.43.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 03:43:01 -0700 (PDT)
Message-ID: <abd9298d-1c3c-4f0c-8aab-ca03edb6b230@redhat.com>
Date: Tue, 5 May 2026 12:42:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/31] hw/arm/tegra241-cmdqv: Emulate VCMDQ register
 writes
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhenzhong.duan@intel.com,
 kjaju@nvidia.com, phrdina@redhat.com
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-17-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260415105552.622421-17-skolothumtho@nvidia.com>
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

Hi,
On 4/15/26 12:55 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> This is the write side counterpart of the VCMDQ read emulation. Add write
> handling for both CMDQV_CMDQ_BASE and CMDQV_VI_CMDQ_BASE apertures using
> the same index decoding and VINTF-to-VCMDQ translation logic as the read
> path.
>
> VINTF aperture writes are translated to their CMDQV_CMDQ_BASE equivalent
> and update the same cached state. Page1 registers (BASE, CONS_INDX_BASE)
> always update the cache. Once IOMMU_HW_QUEUE_ALLOC and viommu_mmap are
> wired up in a subsequent patch, Page0 register writes will be forwarded
> to the hardware-backed mmap'd page.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.c | 99 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
>
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index 35e6f0bbd6..d4ba2ada92 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -55,6 +55,70 @@ static uint64_t tegra241_cmdqv_read_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0,
>      }
>  }
>  
> +/*
> + * Write a VCMDQ register using VCMDQ0_* offsets.
> + *
> + * The caller normalizes the MMIO offset such that @offset0 always refers
> + * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
> + */
> +static void tegra241_cmdqv_write_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0,
> +                                       int index, uint64_t value,
> +                                       unsigned size)
> +{
> +    switch (offset0) {
> +    case A_VCMDQ0_CONS_INDX:
> +        cmdqv->vcmdq_cons_indx[index] = (uint32_t)value;
> +        return;
> +    case A_VCMDQ0_PROD_INDX:
> +        cmdqv->vcmdq_prod_indx[index] = (uint32_t)value;
> +        return;
> +    case A_VCMDQ0_CONFIG:
> +        if (value & R_VCMDQ0_CONFIG_CMDQ_EN_MASK) {
> +            cmdqv->vcmdq_status[index] |= R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
> +        } else {
> +            cmdqv->vcmdq_status[index] &= ~R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
> +        }
> +        cmdqv->vcmdq_config[index] = (uint32_t)value;
> +        return;
> +    case A_VCMDQ0_GERRORN:
> +        cmdqv->vcmdq_gerrorn[index] = (uint32_t)value;
> +        return;
> +    case A_VCMDQ0_BASE_L:
> +        if (size == 8) {
> +            cmdqv->vcmdq_base[index] = value;
> +        } else {
> +            cmdqv->vcmdq_base[index] =
> +                (cmdqv->vcmdq_base[index] & 0xffffffff00000000ULL) |
> +                (value & 0xffffffffULL);
can you explain the access pattern?
this does not look like A_STRTAB_BASE smmuv3 writes/read

> +        }
> +        return;
> +    case A_VCMDQ0_BASE_H:
> +        cmdqv->vcmdq_base[index] =
> +            (cmdqv->vcmdq_base[index] & 0xffffffffULL) |
> +            ((uint64_t)value << 32);
> +        return;
> +    case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
> +        if (size == 8) {
> +            cmdqv->vcmdq_cons_indx_base[index] = value;
> +        } else {
> +            cmdqv->vcmdq_cons_indx_base[index] =
> +                (cmdqv->vcmdq_cons_indx_base[index] & 0xffffffff00000000ULL) |
> +                (value & 0xffffffffULL);
> +        }
> +        return;
> +    case A_VCMDQ0_CONS_INDX_BASE_DRAM_H:
> +        cmdqv->vcmdq_cons_indx_base[index] =
> +            (cmdqv->vcmdq_cons_indx_base[index] & 0xffffffffULL) |
> +            ((uint64_t)value << 32);
> +        return;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s unhandled write access at 0x%" PRIx64 "\n",
> +                      __func__, offset0);
> +        return;
> +    }
> +}
> +
>  static uint64_t tegra241_cmdqv_config_vintf_read(Tegra241CMDQV *cmdqv,
>                                                   hwaddr offset)
>  {
> @@ -212,6 +276,7 @@ static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
>                                        uint64_t value, unsigned size)
>  {
>      Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
> +    int index;
>  
>      if (offset >= TEGRA241_CMDQV_IO_LEN) {
>          qemu_log_mask(LOG_UNIMP,
> @@ -238,6 +303,40 @@ static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
>      case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
>          tegra241_cmdqv_config_vintf_write(cmdqv, offset, value);
>          break;
> +    case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ1_GERRORN:
> +        /*
> +         * VINTF Page0 registers have the same per-VCMDQ layout as the
> +         * VCMDQ Page0 registers. Translate the VINTF aperture offset to the
> +         * equivalent VCMDQ aperture offset, then fall through to reuse the
> +         * common VCMDQ decoding logic below.
> +         */
> +        offset -= CMDQV_VINTF_PAGE0_BASE - CMDQV_VCMDQ_PAGE0_BASE;
> +        QEMU_FALLTHROUGH;
> +    case A_VCMDQ0_CONS_INDX ... A_VCMDQ1_GERRORN:
> +        /*
> +         * Decode a per-VCMDQ register access.
> +         *
> +         * The hardware supports up to 128 identical VCMDQ instances; we
> +         * currently expose TEGRA241_CMDQV_MAX_CMDQ (= 2). Each VCMDQ
> +         * occupies a CMDQV_VCMDQ_STRIDE-byte window within the page.
> +         *
> +         * Extract the VCMDQ index and normalize to the VCMDQ0_* register
> +         * offset. A single helper services all instances via @index.
> +         */
> +        index = (offset - CMDQV_VCMDQ_PAGE0_BASE) / CMDQV_VCMDQ_STRIDE;
> +        tegra241_cmdqv_write_vcmdq(cmdqv, offset - index * CMDQV_VCMDQ_STRIDE,
> +                                   index, value, size);
> +        break;
> +    case A_VI_VCMDQ0_BASE_L ... A_VI_VCMDQ1_CONS_INDX_BASE_DRAM_H:
> +        /* Same VINTF-to-VCMDQ translation as VINTF Page0 case above */
> +        offset -= CMDQV_VINTF_PAGE1_BASE - CMDQV_VCMDQ_PAGE1_BASE;
> +        QEMU_FALLTHROUGH;
> +    case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
> +        /* Same decode logic as VCMDQ Page0 case above */
> +        index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
> +        tegra241_cmdqv_write_vcmdq(cmdqv, offset - index * CMDQV_VCMDQ_STRIDE,
> +                                   index, value, size);
> +        break;
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
>                        __func__, offset);
Thanks

Eric


