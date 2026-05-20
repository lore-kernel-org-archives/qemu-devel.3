Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6408CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 05:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPZnw-0000wA-A5; Wed, 20 May 2026 01:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPZnX-0000rW-AS
 for qemu-devel@nongnu.org; Wed, 20 May 2026 01:48:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPZnT-0002H1-5N
 for qemu-devel@nongnu.org; Wed, 20 May 2026 01:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779256125;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+e5SKjSHGBiM1U69LNpIM80Qvnzy6XUop0ZB66Qkn3Q=;
 b=AXM/O9gwqbKlIb+0ghV9suFi9sT6NYY+vYsiE4a8EIFEvZdrrwxUVYxgW+Uu+fF4AGORgP
 rBYLlJd2PBdfD5bqL+38w+KJ737yBHlijn4TQgaQzoOsom4Nzqbssow/mxbRL7RjIFULpD
 dGtxdOCpIl1ZGXi5T+oqQ/CME/2gpPY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-KLtjg5vZOQCHsfjeMAYlFg-1; Wed, 20 May 2026 01:48:43 -0400
X-MC-Unique: KLtjg5vZOQCHsfjeMAYlFg-1
X-Mimecast-MFC-AGG-ID: KLtjg5vZOQCHsfjeMAYlFg_1779256122
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48fd8162ed7so34139885e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 22:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779256122; x=1779860922;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+e5SKjSHGBiM1U69LNpIM80Qvnzy6XUop0ZB66Qkn3Q=;
 b=mHX4sCrTcfCnBeA4rYzuHBR/Bwdl2K0FYz+H7XPCXdu81Re4Aww0WYyK7+qP7JeUB7
 dA6UTJeI/XUYlw5kz+hV5CPZ5+LZd4fPosvk0+yTHZSlQuHmdVB+iJ4a5rMEm12BMj8j
 drx+aRf4x1OfC4aYyL/sC/CnwjzLDsiInPEBTVpD2fmTbiZmvbqdJ4BgBZKw4L/OD8un
 OwP3GUGmABSklPnz5GlAY8XYFF1VA5cXys4zieAC4RLG9CiU9y6ggu0zvJxt9ezyJvCa
 etIDKQPCVGsHOLYowqECupC49Pn6+J5beyvEE61/rbLTa6sU1f1Fj9F5yusLBJgDQ6Hi
 j3nQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8G+pZyGd2Sfrt0wpIaGWeB8Eug03S+jiNVs+Qu0CfgX8RnfLusyCPpjh4icMvjf4tzLFJFDUfyMHza@nongnu.org
X-Gm-Message-State: AOJu0YxKFNkR7LL7mz4dDCfON/i1vLOYgUztenJ8CHo6cEwbizLryNi6
 5nBFbIeQjDckaf3a5ngbukQ6R9uu/ghABTktqh1oxO7pE6AowN2XDIbW/rOC668CWKDLu6yOB8W
 ccNY0pFgQMJn7TgnebZlbcjMKbVUwU/DV8XbEyB2/JBjH6ajpmO+dti4s
X-Gm-Gg: Acq92OE22xIrel/y0u7xlPFKAd/QHHaVoIkLR3NP0gtQbSVOs55grNV7R1o7bt6du5V
 BCt798ONYG17yplY9GJiRwmenJRh/hKW3klC1jCUgISiUBORfTDeJoOcYHUcxC9/NZdtfbDW24v
 sAFF7eXqX0c50Hrt7iRz6XxJBt6YoQN9RSPjEBP1oLr55nqdGcPsy3g1JilvdFnNUS7VaiAjiIU
 26QvfnaL2QgQnhF+3Vs8PQwImNWUnRuODV9N/gVOK3NuAiQayUW87q46FAwI//Yr7QewIWsDBzB
 Tr1zhgybsJ7dk7h/NBazWyztF/JUK/46b7y5jc5i4UhXX8NGlSphXPDB1s7GCtvkl1QK/lHQ7Lo
 iql5k4oIdDlk40porb3mlirgrr5ZCYbpF4Aboy9jCtXetrk2vQstW/NcVba2kdhmBgFwwyUz0bd
 NuRtA2
X-Received: by 2002:a05:600c:3e1b:b0:48a:9562:7a30 with SMTP id
 5b1f17b1804b1-48fe6515f20mr334868425e9.24.1779256122126; 
 Tue, 19 May 2026 22:48:42 -0700 (PDT)
X-Received: by 2002:a05:600c:3e1b:b0:48a:9562:7a30 with SMTP id
 5b1f17b1804b1-48fe6515f20mr334868075e9.24.1779256121645; 
 Tue, 19 May 2026 22:48:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c834besm403792765e9.3.2026.05.19.22.48.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 22:48:41 -0700 (PDT)
Message-ID: <7a96fe4f-a42b-44d7-b0e1-d767c42f4eb8@redhat.com>
Date: Wed, 20 May 2026 07:48:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/32] hw/arm/tegra241-cmdqv: Emulate VCMDQ register
 reads
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, zhenzhong.duan@intel.com, kjaju@nvidia.com,
 phrdina@redhat.com
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-16-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260519103727.899332-16-skolothumtho@nvidia.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 5/19/26 12:36 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Tegra241 CMDQV exposes per-VCMDQ register windows through two MMIO
> apertures:
>
>   Direct VCMDQ aperture (0x10000/0x20000): VCMDQ Page0/Page1
>   VINTF logical aperture (0x30000/0x40000): VINTF0 LVCMDQ Page0/Page1
>
> Both apertures are hardware aliases of the same underlying registers:
>
>   Page 0 (control/status): CONS_INDX, PROD_INDX, CONFIG, STATUS,
>                            GERROR, GERRORN
>   Page 1 (base/DRAM):      BASE_L/H, CONS_INDX_BASE_DRAM_L/H
>
> The direct aperture Page 0 is programmable at any time so long as
> CMDQV_EN is enabled. The VINTF (logical) aperture Page 0 is
> programmable only once SW has mapped a VCMDQ to a VINTF; the
> "logical" view is local to that VINTF.
>
> Add read emulation for both apertures, backed by a single per-VCMDQ
> register cache. VINTF aperture reads are translated to their
> equivalent direct-aperture offset and served from the same cached
> state.
>
> Once IOMMU_HW_QUEUE_ALLOC and viommu_mmap are wired up in a
> subsequent patch, Page 0 reads will be served directly from the
> hardware-backed mmap'd page instead of the cache. Page 1 is also a
> hardware alias, but the kernel only exposes mmap for Page 0, so
> Page 1 reads always trap to QEMU and are served from cache.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.h | 215 ++++++++++++++++++++++++++++++++++++++++
>  hw/arm/tegra241-cmdqv.c |  95 ++++++++++++++++++
>  hw/arm/trace-events     |   2 +
>  3 files changed, 312 insertions(+)
>
> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
> index ace327443a..6b21a407af 100644
> --- a/hw/arm/tegra241-cmdqv.h
> +++ b/hw/arm/tegra241-cmdqv.h
> @@ -30,6 +30,13 @@
>   */
>  #define TEGRA241_CMDQV_IO_LEN 0x50000
>  
> +/* CMDQV MMIO aperture bases and VCMDQ stride */
> +#define CMDQV_VCMDQ_PAGE0_BASE  0x10000  /* CMDQV_CMDQ_BASE */
> +#define CMDQV_VCMDQ_PAGE1_BASE  0x20000
> +#define CMDQV_VINTF_PAGE0_BASE  0x30000  /* CMDQV_VI_CMDQ_BASE */
> +#define CMDQV_VINTF_PAGE1_BASE  0x40000
> +#define CMDQV_VCMDQ_STRIDE      0x80
> +
>  typedef struct Tegra241CMDQV {
>      struct iommu_viommu_tegra241_cmdqv cmdqv_data;
>      SMMUv3AccelState *s_accel;
> @@ -52,6 +59,19 @@ typedef struct Tegra241CMDQV {
>      uint32_t vintf_sid_match[TEGRA241_CMDQV_MAX_NUM_SID];
>      uint32_t vintf_sid_replace[TEGRA241_CMDQV_MAX_NUM_SID];
>      uint32_t vintf_cmdq_err_map[4];
> +    /*
> +     * VCMDQ register cache. The direct (VCMDQ aperture) and logical
> +     * (VINTF aperture) views are hardware aliases; both are served from
> +     * this single cached copy.
> +     */
> +    uint32_t vcmdq_cons_indx[TEGRA241_CMDQV_MAX_CMDQ];
> +    uint32_t vcmdq_prod_indx[TEGRA241_CMDQV_MAX_CMDQ];
> +    uint32_t vcmdq_config[TEGRA241_CMDQV_MAX_CMDQ];
> +    uint32_t vcmdq_status[TEGRA241_CMDQV_MAX_CMDQ];
> +    uint32_t vcmdq_gerror[TEGRA241_CMDQV_MAX_CMDQ];
> +    uint32_t vcmdq_gerrorn[TEGRA241_CMDQV_MAX_CMDQ];
> +    uint64_t vcmdq_base[TEGRA241_CMDQV_MAX_CMDQ];
> +    uint64_t vcmdq_cons_indx_base[TEGRA241_CMDQV_MAX_CMDQ];
>  } Tegra241CMDQV;
>  
>  /* CMDQ-V Config page registers (offset 0x00000) */
> @@ -143,6 +163,201 @@ REG32(VINTF0_LVCMDQ_ERR_MAP_0, 0x10c0)
>  FIELD(VINTF0_LVCMDQ_ERR_MAP_0, LVCMDQ_ERR_MAP, 0, 32)
>  #define A_VINTF0_LVCMDQ_ERR_MAP_3 (A_VINTF0_LVCMDQ_ERR_MAP_0 + 3 * 4)
>  
> +/*
> + * VCMDQ Page 0 register window @ CMDQV_VCMDQ_PAGE0_BASE.
> + * Direct VCMDQ aperture; control and status registers.
> + */
> +#define SMMU_CMDQV_VCMDQi_CONS_INDX_(i)                     \
> +    REG32(VCMDQ##i##_CONS_INDX,                             \
> +          CMDQV_VCMDQ_PAGE0_BASE + i * CMDQV_VCMDQ_STRIDE)  \
> +    FIELD(VCMDQ##i##_CONS_INDX, RD, 0, 20)                  \
> +    FIELD(VCMDQ##i##_CONS_INDX, ERR, 24, 7)
> +
> +SMMU_CMDQV_VCMDQi_CONS_INDX_(0)
> +SMMU_CMDQV_VCMDQi_CONS_INDX_(1)
> +
> +#define V_VCMDQ_CONS_INDX_ERR_CERROR_NONE         0
> +#define V_VCMDQ_CONS_INDX_ERR_CERROR_ILL_OPCODE   1
> +#define V_VCMDQ_CONS_INDX_ERR_CERROR_ABT          2
> +#define V_VCMDQ_CONS_INDX_ERR_CERROR_ATC_INV_SYNC 3
> +#define V_VCMDQ_CONS_INDX_ERR_CERROR_ILL_ACCESS   4
> +
> +#define SMMU_CMDQV_VCMDQi_PROD_INDX_(i)                          \
> +    REG32(VCMDQ##i##_PROD_INDX,                                  \
> +          CMDQV_VCMDQ_PAGE0_BASE + 0x4 + i * CMDQV_VCMDQ_STRIDE) \
> +    FIELD(VCMDQ##i##_PROD_INDX, WR, 0, 20)
> +
> +SMMU_CMDQV_VCMDQi_PROD_INDX_(0)
> +SMMU_CMDQV_VCMDQi_PROD_INDX_(1)
> +
> +#define SMMU_CMDQV_VCMDQi_CONFIG_(i)                             \
> +    REG32(VCMDQ##i##_CONFIG,                                     \
> +          CMDQV_VCMDQ_PAGE0_BASE + 0x8 + i * CMDQV_VCMDQ_STRIDE) \
> +    FIELD(VCMDQ##i##_CONFIG, CMDQ_EN, 0, 1)
> +
> +SMMU_CMDQV_VCMDQi_CONFIG_(0)
> +SMMU_CMDQV_VCMDQi_CONFIG_(1)
> +
> +#define SMMU_CMDQV_VCMDQi_STATUS_(i)                             \
> +    REG32(VCMDQ##i##_STATUS,                                     \
> +          CMDQV_VCMDQ_PAGE0_BASE + 0xc + i * CMDQV_VCMDQ_STRIDE) \
> +    FIELD(VCMDQ##i##_STATUS, CMDQ_EN_OK, 0, 1)
> +
> +SMMU_CMDQV_VCMDQi_STATUS_(0)
> +SMMU_CMDQV_VCMDQi_STATUS_(1)
> +
> +#define SMMU_CMDQV_VCMDQi_GERROR_(i)                              \
> +    REG32(VCMDQ##i##_GERROR,                                      \
> +          CMDQV_VCMDQ_PAGE0_BASE + 0x10 + i * CMDQV_VCMDQ_STRIDE) \
> +    FIELD(VCMDQ##i##_GERROR, CMDQ_ERR, 0, 1)                      \
> +    FIELD(VCMDQ##i##_GERROR, CONS_DRAM_WR_ABT_ERR, 1, 1)          \
> +    FIELD(VCMDQ##i##_GERROR, CMDQ_INIT_ERR, 2, 1)
> +
> +SMMU_CMDQV_VCMDQi_GERROR_(0)
> +SMMU_CMDQV_VCMDQi_GERROR_(1)
> +
> +#define SMMU_CMDQV_VCMDQi_GERRORN_(i)                             \
> +    REG32(VCMDQ##i##_GERRORN,                                     \
> +          CMDQV_VCMDQ_PAGE0_BASE + 0x14 + i * CMDQV_VCMDQ_STRIDE) \
> +    FIELD(VCMDQ##i##_GERRORN, CMDQ_ERR, 0, 1)                     \
> +    FIELD(VCMDQ##i##_GERRORN, CONS_DRAM_WR_ABT_ERR, 1, 1)         \
> +    FIELD(VCMDQ##i##_GERRORN, CMDQ_INIT_ERR, 2, 1)
> +
> +SMMU_CMDQV_VCMDQi_GERRORN_(0)
> +SMMU_CMDQV_VCMDQi_GERRORN_(1)


nit, what I meant in my v4 comments is I would prefer we group the
eventual register definition to represent the actual layout of each
page, instead of interleaving them with actual macros:
This would look like:

/* page 0 */

/* vcmdq0 */

+SMMU_CMDQV_VCMDQi_CONS_INDX_(0)
+SMMU_CMDQV_VCMDQi_PROD_INDX_(0)
+SMMU_CMDQV_VCMDQi_CONFIG_(0)
+SMMU_CMDQV_VCMDQi_STATUS_(0)
+SMMU_CMDQV_VCMDQi_GERROR_(0)
+SMMU_CMDQV_VCMDQi_GERRORN_(0)

/* vcmdq1 */

+SMMU_CMDQV_VCMDQi_CONS_INDX_(1)
+SMMU_CMDQV_VCMDQi_PROD_INDX_(1)
+SMMU_CMDQV_VCMDQi_CONFIG_(1)
+SMMU_CMDQV_VCMDQi_STATUS_(1)
+SMMU_CMDQV_VCMDQi_GERROR_(1)
+SMMU_CMDQV_VCMDQi_GERRORN_(1)

same for page 1

To me it looks easier to remember the layout without looking at the spec.


Taste & colors, what do you prefer? 






> +
> +/*
> + * VCMDQ Page 1 register window @ CMDQV_VCMDQ_PAGE1_BASE.
> + * Direct VCMDQ aperture; base and DRAM address registers.
> + */
> +#define SMMU_CMDQV_VCMDQi_BASE_L_(i)                                          \
> +    REG32(VCMDQ##i##_BASE_L, CMDQV_VCMDQ_PAGE1_BASE + i * CMDQV_VCMDQ_STRIDE) \
> +    FIELD(VCMDQ##i##_BASE_L, LOG2SIZE, 0, 5)                                  \
> +    FIELD(VCMDQ##i##_BASE_L, ADDR, 5, 27)
> +
> +SMMU_CMDQV_VCMDQi_BASE_L_(0)
> +SMMU_CMDQV_VCMDQi_BASE_L_(1)
> +
> +#define SMMU_CMDQV_VCMDQi_BASE_H_(i)                             \
> +    REG32(VCMDQ##i##_BASE_H,                                     \
> +          CMDQV_VCMDQ_PAGE1_BASE + 0x4 + i * CMDQV_VCMDQ_STRIDE) \
> +    FIELD(VCMDQ##i##_BASE_H, ADDR, 0, 16)
> +
> +SMMU_CMDQV_VCMDQi_BASE_H_(0)
> +SMMU_CMDQV_VCMDQi_BASE_H_(1)
> +
> +#define SMMU_CMDQV_VCMDQi_CONS_INDX_BASE_DRAM_L_(i)              \
> +    REG32(VCMDQ##i##_CONS_INDX_BASE_DRAM_L,                      \
> +          CMDQV_VCMDQ_PAGE1_BASE + 0x8 + i * CMDQV_VCMDQ_STRIDE) \
> +    FIELD(VCMDQ##i##_CONS_INDX_BASE_DRAM_L, ADDR, 0, 32)
> +
> +SMMU_CMDQV_VCMDQi_CONS_INDX_BASE_DRAM_L_(0)
> +SMMU_CMDQV_VCMDQi_CONS_INDX_BASE_DRAM_L_(1)
> +
> +#define SMMU_CMDQV_VCMDQi_CONS_INDX_BASE_DRAM_H_(i)              \
> +    REG32(VCMDQ##i##_CONS_INDX_BASE_DRAM_H,                      \
> +          CMDQV_VCMDQ_PAGE1_BASE + 0xc + i * CMDQV_VCMDQ_STRIDE) \
> +    FIELD(VCMDQ##i##_CONS_INDX_BASE_DRAM_H, ADDR, 0, 16)
> +
> +SMMU_CMDQV_VCMDQi_CONS_INDX_BASE_DRAM_H_(0)
> +SMMU_CMDQV_VCMDQi_CONS_INDX_BASE_DRAM_H_(1)
> +
> +/*
> + * VINTF0 LVCMDQ Page 0 register window @ CMDQV_VINTF_PAGE0_BASE.
> + * Logical VCMDQ aperture (VCMDQs mapped via VINTF); control and
> + * status registers. Hardware alias of VCMDQ Page 0 above.
> + */
> +#define SMMU_CMDQV_VI_VCMDQi_CONS_INDX_(i)                  \
> +    REG32(VI_VCMDQ##i##_CONS_INDX,                          \
> +          CMDQV_VINTF_PAGE0_BASE + i * CMDQV_VCMDQ_STRIDE)  \
> +    FIELD(VI_VCMDQ##i##_CONS_INDX, RD, 0, 20)               \
> +    FIELD(VI_VCMDQ##i##_CONS_INDX, ERR, 24, 7)
> +
> +SMMU_CMDQV_VI_VCMDQi_CONS_INDX_(0)
> +SMMU_CMDQV_VI_VCMDQi_CONS_INDX_(1)
> +
> +#define SMMU_CMDQV_VI_VCMDQi_PROD_INDX_(i)                       \
> +    REG32(VI_VCMDQ##i##_PROD_INDX,                               \
> +          CMDQV_VINTF_PAGE0_BASE + 0x4 + i * CMDQV_VCMDQ_STRIDE) \
> +    FIELD(VI_VCMDQ##i##_PROD_INDX, WR, 0, 20)
> +
> +SMMU_CMDQV_VI_VCMDQi_PROD_INDX_(0)
> +SMMU_CMDQV_VI_VCMDQi_PROD_INDX_(1)
> +
> +#define SMMU_CMDQV_VI_VCMDQi_CONFIG_(i)                          \
> +    REG32(VI_VCMDQ##i##_CONFIG,                                  \
> +          CMDQV_VINTF_PAGE0_BASE + 0x8 + i * CMDQV_VCMDQ_STRIDE) \
> +    FIELD(VI_VCMDQ##i##_CONFIG, CMDQ_EN, 0, 1)
> +
> +SMMU_CMDQV_VI_VCMDQi_CONFIG_(0)
> +SMMU_CMDQV_VI_VCMDQi_CONFIG_(1)
> +
> +#define SMMU_CMDQV_VI_VCMDQi_STATUS_(i)                          \
> +    REG32(VI_VCMDQ##i##_STATUS,                                  \
> +          CMDQV_VINTF_PAGE0_BASE + 0xc + i * CMDQV_VCMDQ_STRIDE) \
> +    FIELD(VI_VCMDQ##i##_STATUS, CMDQ_EN_OK, 0, 1)
> +
> +SMMU_CMDQV_VI_VCMDQi_STATUS_(0)
> +SMMU_CMDQV_VI_VCMDQi_STATUS_(1)
> +
> +#define SMMU_CMDQV_VI_VCMDQi_GERROR_(i)                           \
> +    REG32(VI_VCMDQ##i##_GERROR,                                   \
> +          CMDQV_VINTF_PAGE0_BASE + 0x10 + i * CMDQV_VCMDQ_STRIDE) \
> +    FIELD(VI_VCMDQ##i##_GERROR, CMDQ_ERR, 0, 1)                   \
> +    FIELD(VI_VCMDQ##i##_GERROR, CONS_DRAM_WR_ABT_ERR, 1, 1)       \
> +    FIELD(VI_VCMDQ##i##_GERROR, CMDQ_INIT_ERR, 2, 1)
> +
> +SMMU_CMDQV_VI_VCMDQi_GERROR_(0)
> +SMMU_CMDQV_VI_VCMDQi_GERROR_(1)
> +
> +#define SMMU_CMDQV_VI_VCMDQi_GERRORN_(i)                          \
> +    REG32(VI_VCMDQ##i##_GERRORN,                                  \
> +          CMDQV_VINTF_PAGE0_BASE + 0x14 + i * CMDQV_VCMDQ_STRIDE) \
> +    FIELD(VI_VCMDQ##i##_GERRORN, CMDQ_ERR, 0, 1)                  \
> +    FIELD(VI_VCMDQ##i##_GERRORN, CONS_DRAM_WR_ABT_ERR, 1, 1)      \
> +    FIELD(VI_VCMDQ##i##_GERRORN, CMDQ_INIT_ERR, 2, 1)
> +
> +SMMU_CMDQV_VI_VCMDQi_GERRORN_(0)
> +SMMU_CMDQV_VI_VCMDQi_GERRORN_(1)
> +
> +/*
> + * VINTF0 LVCMDQ Page 1 register window @ CMDQV_VINTF_PAGE1_BASE.
> + * Logical VCMDQ aperture (VCMDQs mapped via VINTF); base and DRAM
> + * address registers. Hardware alias of VCMDQ Page 1 above.
> + */
> +#define SMMU_CMDQV_VI_VCMDQi_BASE_L_(i)                     \
> +    REG32(VI_VCMDQ##i##_BASE_L,                             \
> +          CMDQV_VINTF_PAGE1_BASE + i * CMDQV_VCMDQ_STRIDE)  \
> +    FIELD(VI_VCMDQ##i##_BASE_L, LOG2SIZE, 0, 5)             \
> +    FIELD(VI_VCMDQ##i##_BASE_L, ADDR, 5, 27)
> +
> +SMMU_CMDQV_VI_VCMDQi_BASE_L_(0)
> +SMMU_CMDQV_VI_VCMDQi_BASE_L_(1)
> +
> +#define SMMU_CMDQV_VI_VCMDQi_BASE_H_(i)                          \
> +    REG32(VI_VCMDQ##i##_BASE_H,                                  \
> +          CMDQV_VINTF_PAGE1_BASE + 0x4 + i * CMDQV_VCMDQ_STRIDE) \
> +    FIELD(VI_VCMDQ##i##_BASE_H, ADDR, 0, 16)
> +
> +SMMU_CMDQV_VI_VCMDQi_BASE_H_(0)
> +SMMU_CMDQV_VI_VCMDQi_BASE_H_(1)
> +
> +#define SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_L_(i)           \
> +    REG32(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_L,                   \
> +          CMDQV_VINTF_PAGE1_BASE + 0x8 + i * CMDQV_VCMDQ_STRIDE) \
> +    FIELD(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_L, ADDR, 0, 32)
> +
> +SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_L_(0)
> +SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_L_(1)
> +
> +#define SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_H_(i)           \
> +    REG32(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_H,                   \
> +          CMDQV_VINTF_PAGE1_BASE + 0xc + i * CMDQV_VCMDQ_STRIDE) \
> +    FIELD(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_H, ADDR, 0, 16)
> +
> +SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_H_(0)
> +SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_H_(1)
> +
>  const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
>  
>  #endif /* HW_ARM_TEGRA241_CMDQV_H */
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index 813b9a61ce..f859126ad6 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -16,6 +16,75 @@
>  #include "tegra241-cmdqv.h"
>  #include "trace.h"
>  
> +/*
> + * Read a VCMDQ Page 0 register (control/status) using VCMDQ0_* offsets.
> + *
> + * The caller normalizes the MMIO offset such that @offset0 always refers
> + * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
> + */
> +static uint64_t tegra241_cmdqv_read_vcmdq_page0(Tegra241CMDQV *cmdqv,
> +                                                hwaddr offset0, int index)
> +{
> +    uint64_t val = 0;
> +
> +    switch (offset0) {
> +    case A_VCMDQ0_CONS_INDX:
> +        val = cmdqv->vcmdq_cons_indx[index];
> +        break;
> +    case A_VCMDQ0_PROD_INDX:
> +        val = cmdqv->vcmdq_prod_indx[index];
> +        break;
> +    case A_VCMDQ0_CONFIG:
> +        val = cmdqv->vcmdq_config[index];
> +        break;
> +    case A_VCMDQ0_STATUS:
> +        val = cmdqv->vcmdq_status[index];
> +        break;
> +    case A_VCMDQ0_GERROR:
> +        val = cmdqv->vcmdq_gerror[index];
> +        break;
> +    case A_VCMDQ0_GERRORN:
> +        val = cmdqv->vcmdq_gerrorn[index];
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s unhandled read access at 0x%" PRIx64 "\n",
> +                      __func__, offset0);
> +    }
> +    trace_tegra241_cmdqv_read_vcmdq_page0(index, offset0, val);
> +    return val;
> +}
> +
> +/*
> + * Read a VCMDQ Page 1 register (base / DRAM address) using VCMDQ0_* offsets.
> + */
> +static uint64_t tegra241_cmdqv_read_vcmdq_page1(Tegra241CMDQV *cmdqv,
> +                                                hwaddr offset0, int index)
> +{
> +    uint64_t val = 0;
> +
> +    switch (offset0) {
> +    case A_VCMDQ0_BASE_L:
> +        val = cmdqv->vcmdq_base[index];
> +        break;
> +    case A_VCMDQ0_BASE_H:
> +        val = cmdqv->vcmdq_base[index] >> 32;
> +        break;
> +    case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
> +        val = cmdqv->vcmdq_cons_indx_base[index];
> +        break;
> +    case A_VCMDQ0_CONS_INDX_BASE_DRAM_H:
> +        val = cmdqv->vcmdq_cons_indx_base[index] >> 32;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s unhandled read access at 0x%" PRIx64 "\n",
> +                      __func__, offset0);
> +    }
> +    trace_tegra241_cmdqv_read_vcmdq_page1(index, offset0, val);
> +    return val;
> +}
> +
>  static uint64_t tegra241_cmdqv_config_vintf_read(Tegra241CMDQV *cmdqv,
>                                                   hwaddr offset)
>  {
> @@ -93,6 +162,7 @@ static uint64_t tegra241_cmdqv_read_mmio(void *opaque, hwaddr offset,
>  {
>      Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
>      uint64_t val = 0;
> +    int index;
>  
>      if (offset >= TEGRA241_CMDQV_IO_LEN) {
>          qemu_log_mask(LOG_UNIMP,
> @@ -126,6 +196,31 @@ static uint64_t tegra241_cmdqv_read_mmio(void *opaque, hwaddr offset,
>      case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
>          val = tegra241_cmdqv_config_vintf_read(cmdqv, offset);
>          break;
> +    case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ1_GERRORN:
> +        /*
> +         * VINTF Page0 registers are hardware aliases of VCMDQ Page0 registers.
> +         * Translate the VINTF aperture offset to its VCMDQ Page0 equivalent
> +         * and fall through to the Page0 dispatch below.
> +         */
> +        offset -= CMDQV_VINTF_PAGE0_BASE - CMDQV_VCMDQ_PAGE0_BASE;
> +        QEMU_FALLTHROUGH;
> +    case A_VCMDQ0_CONS_INDX ... A_VCMDQ1_GERRORN:
> +        /*
> +         * Decode a per-VCMDQ Page 0 access. Each VCMDQ occupies a
> +         * CMDQV_VCMDQ_STRIDE-byte window; extract the index and normalize
> +         * to the VCMDQ0_* offset before calling the Page 0 helper.
> +         */
> +        index = (offset - CMDQV_VCMDQ_PAGE0_BASE) / CMDQV_VCMDQ_STRIDE;
> +        return tegra241_cmdqv_read_vcmdq_page0(cmdqv,
> +                offset - index * CMDQV_VCMDQ_STRIDE, index);
> +    case A_VI_VCMDQ0_BASE_L ... A_VI_VCMDQ1_CONS_INDX_BASE_DRAM_H:
> +        /* Same VINTF-to-VCMDQ translation as VINTF Page0 case above. */
> +        offset -= CMDQV_VINTF_PAGE1_BASE - CMDQV_VCMDQ_PAGE1_BASE;
> +        QEMU_FALLTHROUGH;
> +    case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
> +        index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
> +        return tegra241_cmdqv_read_vcmdq_page1(cmdqv,
> +                offset - index * CMDQV_VCMDQ_STRIDE, index);
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s unhandled read access at 0x%" PRIx64 "\n",
>                        __func__, offset);
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 8c61d66a26..8c34a04b24 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -75,6 +75,8 @@ smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vS
>  # tegra241-cmdqv
>  tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
>  tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
> +tegra241_cmdqv_read_vcmdq_page0(int index, uint64_t offset0, uint64_t val) "vcmdq[%d] page0 offset0: 0x%"PRIx64" val: 0x%"PRIx64
> +tegra241_cmdqv_read_vcmdq_page1(int index, uint64_t offset0, uint64_t val) "vcmdq[%d] page1 offset0: 0x%"PRIx64" val: 0x%"PRIx64
>  
>  # strongarm.c
>  strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
Besides looks good to me

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


