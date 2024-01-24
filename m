Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB8EC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 18:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rShga-0007QY-AP; Wed, 24 Jan 2024 13:09:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rShgY-0007Q8-Mz
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 13:09:14 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rShgX-0002bM-09
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 13:09:14 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6dd87e7c355so1078688b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 10:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706119751; x=1706724551; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hhadsUTDszaOgv4nbkvtCwW/W6GdDZinn9LINS1tLz4=;
 b=hEYgGgVNwMZZkEiAF6h64qrcAImhzIrQUV/fdVKG4XwB6Rg9u6Dyg7qAjcT245KI5q
 ygzdnFkp6tGxlYZ5HqNEne9Qb30n9wdMU1GATiWp1o2004xTgBYR62dwXNd/UrV/VfoF
 4aaVE1nl3m9SLGz72sNr/IiFCfTb+clAFtw+BC6C5C3RfbUdAhLNmxqYjPngXOeXu/nT
 C1QFBMkNfvNUDyrEDv1zCr12JSB1KTPCDzV9vGhFGbWR37nIgKPODcCdQaEhv5V9O2u4
 u5W5T8jRdZ+Hq8ZmbXvSkOR8CZAjqFTSahsYTC7ZmrV+qQfnpCAzC9iL+ktpkXXLvclJ
 k+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706119751; x=1706724551;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hhadsUTDszaOgv4nbkvtCwW/W6GdDZinn9LINS1tLz4=;
 b=KEcMidXnfNMt2gfdWJHOPLK43AwBCgjtbv4BSGE1kOEjgEQGCMvyDrsDMJGpDwEo3z
 yZ77UkxOiHrDA2Ga7yCY17F6UuPG1xLN31QoGfmsQ/Mzs7Hj4eWFPeEc3ygeQTcNJ+EZ
 gH/Dz4Dmim1Jkk6gCnCnzko3oKTLheivQJHTBw7WPzaXzFE9xqMr5xbR0SdPIfas+0aA
 juuK7BEsnPlFrQ1hY7WlZkp9C/GayZZ2ORwJifxMCCLMQyslTTw3Vx/6fWs+lxSoWPoP
 3zhtJlrG1ERNOfIaFRUjHjinbuKTmqZHNXEuETzswF+k9yfgKg4c6zuFDVoF46pjCtPh
 U/Ng==
X-Gm-Message-State: AOJu0YxH0erTKFCKRqCzIG+KTEsDhqGC9DrrnkRAkfndnxE7iFf1UXCt
 6osHWoTPHEUst6+L3K34jvbEOIF3/FCCFUzywl/xxvPZAKmicS1P
X-Google-Smtp-Source: AGHT+IGGTFyU9LI7CxgLzI60Jb//l0sAUlHKejdVbua4DcMmVOM+AqKIz/hxmZV2pm1h027V6bUstA==
X-Received: by 2002:a05:6a21:789a:b0:19c:6383:c404 with SMTP id
 bf26-20020a056a21789a00b0019c6383c404mr935101pzc.12.1706119751150; 
 Wed, 24 Jan 2024 10:09:11 -0800 (PST)
Received: from debian (c-71-202-32-218.hsd1.ca.comcast.net. [71.202.32.218])
 by smtp.gmail.com with ESMTPSA id
 ey9-20020a056a0038c900b006d70b0d4639sm14160191pfb.107.2024.01.24.10.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 10:09:10 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jan 2024 10:08:50 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 Fan Ni <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>,
 Davidlohr Bueso <dave@stgolabs.net>, linuxarm@huawei.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/5] hw/cxl: Update HDM Decoder capability to version 3
Message-ID: <ZbFSMtnkEug8q_6Q@debian>
References: <20240124134814.8717-1-Jonathan.Cameron@huawei.com>
 <20240124134814.8717-2-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124134814.8717-2-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

On Wed, Jan 24, 2024 at 01:48:10PM +0000, Jonathan Cameron wrote:
> Part of standardizing the QEMU code on CXL r3.1.
> No fuctional changes as everything added is optional and
> it is set as not implemented.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  include/hw/cxl/cxl_component.h | 16 ++++++++++++++--
>  hw/cxl/cxl-component-utils.c   | 10 +++++++++-
>  2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> index 5227a8e833..7d3edef1bf 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -109,8 +109,9 @@ REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET + 0x18)
>      (CXL_SEC_REGISTERS_OFFSET + CXL_SEC_REGISTERS_SIZE)
>  #define CXL_LINK_REGISTERS_SIZE   0x38
>  
> -/* 8.2.5.12 - CXL HDM Decoder Capability Structure */
> -#define HDM_DECODE_MAX 10 /* 8.2.5.12.1 */
> +/* CXL r3.1 Section 8.2.4.20: CXL HDM Decoder Capability Structure */
> +#define HDM_DECODE_MAX 10 /* Maximum decoders for Devices */
> +#define CXL_HDM_CAPABILITY_VERSION 3
>  #define CXL_HDM_REGISTERS_OFFSET \
>      (CXL_LINK_REGISTERS_OFFSET + CXL_LINK_REGISTERS_SIZE)
>  #define CXL_HDM_REGISTERS_SIZE (0x10 + 0x20 * HDM_DECODE_MAX)
> @@ -133,6 +134,11 @@ REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET + 0x18)
>              FIELD(CXL_HDM_DECODER##n##_CTRL, COMMITTED, 10, 1)                 \
>              FIELD(CXL_HDM_DECODER##n##_CTRL, ERR, 11, 1)                       \
>              FIELD(CXL_HDM_DECODER##n##_CTRL, TYPE, 12, 1)                      \
> +            FIELD(CXL_HDM_DECODER##n##_CTRL, BI, 13, 1)                        \
> +            FIELD(CXL_HDM_DECODER##n##_CTRL, UIO, 14, 1)                       \
> +            FIELD(CXL_HDM_DECODER##n##_CTRL, UIG, 16, 4)                       \
> +            FIELD(CXL_HDM_DECODER##n##_CTRL, UIW, 20, 4)                       \
> +            FIELD(CXL_HDM_DECODER##n##_CTRL, ISP, 24, 4)                       \
>    REG32(CXL_HDM_DECODER##n##_TARGET_LIST_LO,                                   \
>          CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x24)                          \
>    REG32(CXL_HDM_DECODER##n##_TARGET_LIST_HI,                                   \
> @@ -148,6 +154,12 @@ REG32(CXL_HDM_DECODER_CAPABILITY, CXL_HDM_REGISTERS_OFFSET)
>      FIELD(CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_256B, 8, 1)
>      FIELD(CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_4K, 9, 1)
>      FIELD(CXL_HDM_DECODER_CAPABILITY, POISON_ON_ERR_CAP, 10, 1)
> +    FIELD(CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 11, 1)
> +    FIELD(CXL_HDM_DECODER_CAPABILITY, 16_WAY, 12, 1)
> +    FIELD(CXL_HDM_DECODER_CAPABILITY, UIO, 13, 1)
> +    FIELD(CXL_HDM_DECODER_CAPABILITY, UIO_DECODER_COUNT, 16, 4)
> +    FIELD(CXL_HDM_DECODER_CAPABILITY, MEMDATA_NXM_CAP, 20, 1)
> +    FIELD(CXL_HDM_DECODER_CAPABILITY, SUPPORTED_COHERENCY_MODEL, 21, 2)
>  REG32(CXL_HDM_DECODER_GLOBAL_CONTROL, CXL_HDM_REGISTERS_OFFSET + 4)
>      FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, POISON_ON_ERR_EN, 0, 1)
>      FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, HDM_DECODER_ENABLE, 1, 1)
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index 5ddd47ed8d..a55cf5a036 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -243,6 +243,14 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_4K, 1);
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
>                       POISON_ON_ERR_CAP, 0);
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 0);
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 16_WAY, 0);
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO, 0);
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> +                     UIO_DECODER_COUNT, 0);
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, MEMDATA_NXM_CAP, 0);
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> +                     SUPPORTED_COHERENCY_MODEL, 0); /* Unknown */
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_GLOBAL_CONTROL,
>                       HDM_DECODER_ENABLE, 0);
>      write_msk[R_CXL_HDM_DECODER_GLOBAL_CONTROL] = 0x3;
> @@ -326,7 +334,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
>          return;
>      }
>  
> -    init_cap_reg(HDM, 5, 1);
> +    init_cap_reg(HDM, 5, CXL_HDM_CAPABILITY_VERSION);
>      hdm_init_common(reg_state, write_msk, type);
>  
>      if (caps < 5) {
> -- 
> 2.39.2
> 

