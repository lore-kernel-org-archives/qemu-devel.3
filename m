Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174F7C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 18:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rShx6-0004bf-LK; Wed, 24 Jan 2024 13:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rShx4-0004bD-Ac
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 13:26:18 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rShx2-0007Ja-Kv
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 13:26:18 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d7232dcb3eso28355855ad.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 10:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706120775; x=1706725575; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C4yZxOJffiW/TvBI4CtO7xaQ0Fri7dVAm/5G1HU++eU=;
 b=T7xqMPGXaL5WpC8px5alNUMeGlJU+/0z59bwYhYMxIga8A2J1thhX/JjvSDtlBwy22
 soJMmyaOMbzhlDY1MDgJdfLYg/rC3+jYt7DDEzOI2FIk5NwA3w+Y1MKMNQgYxTKHs4Yo
 x0LKe1kvvIo0VnZwXQrKGjFnL1dv/PbdrUoIzgh9Bmpi7RrU5zOe160CpqaXrbnnxS8H
 bwJmdOGdVUI8TctvIYaw7qvDHycEwc3VY2N6MUv7ygQ6cdfzRtUeHqwMEVFz3WNlVoJ9
 +nCC0eBBlIjzyz0sMlVMHFm0AH6iIFbJ4CTXOyPvJkHZ5W/9gy04WaUoWMHdL1LVwx4f
 q46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706120775; x=1706725575;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C4yZxOJffiW/TvBI4CtO7xaQ0Fri7dVAm/5G1HU++eU=;
 b=NhmxtjWlAFPMvgvvnXbIqcB9kt1oQvwKsiizlkvdAebNWjsGYs41c8/xUZjIYD3ail
 jpxxluMCb8Da4Z1gp+dzo7N2svyFkOrB98z98p+/ifB4lYh9ONDjc5RqHc7Gv85fefNx
 IvbPG13ibRmnNVQe35Bi0xjrpL6kV8bUiEwY+9WVKtDD48g46Y2+HmQit2M1BZR+2ePT
 9iyuAWgD8FWRkBOcN3Tw+9E12DT85uLkqYtZDzoKfd7v5LY9n0sUHDQA3X106VexrKL2
 9r114agQcBfwfECFM3s05IEXO1hxh3Ud88FDOmrkax94Wvb3YTpMft5uqkWvoloUnRkg
 gXwQ==
X-Gm-Message-State: AOJu0YwN/9xgjmd6Qz5eH71dRB5Ja/q/zYC+gohEsAw5kgR1BL3Hry5D
 FRQ9wGQkKO83SjppGY/FNcJBC306e6AVbQbRgiGjVGVeqTFEmv6e
X-Google-Smtp-Source: AGHT+IG+8Ttg6fWlzmaQGo3N6weH119gLL2JY4A3Ep74ZZdpNQVK98VGuAJC3lBV7mAu1+Rcxd/tKA==
X-Received: by 2002:a17:903:32c4:b0:1d7:1df6:4505 with SMTP id
 i4-20020a17090332c400b001d71df64505mr1178689plr.30.1706120774742; 
 Wed, 24 Jan 2024 10:26:14 -0800 (PST)
Received: from debian (c-71-202-32-218.hsd1.ca.comcast.net. [71.202.32.218])
 by smtp.gmail.com with ESMTPSA id
 y4-20020a170902d64400b001d7465c213bsm5869238plh.197.2024.01.24.10.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 10:26:14 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jan 2024 10:26:11 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 Fan Ni <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>,
 Davidlohr Bueso <dave@stgolabs.net>, linuxarm@huawei.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 3/5] hw/cxl: Update RAS Capability Definitions for
 version 3.
Message-ID: <ZbFWQ1rEOZ8LUXh9@debian>
References: <20240124134814.8717-1-Jonathan.Cameron@huawei.com>
 <20240124134814.8717-4-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124134814.8717-4-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jan 24, 2024 at 01:48:12PM +0000, Jonathan Cameron wrote:
> Part of bringing all of CXL emulation inline with CXL r3.1.
> No functional changes.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  include/hw/cxl/cxl_component.h | 5 ++++-
>  hw/cxl/cxl-component-utils.c   | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> index 2c7631bd1e..b5da72b789 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -60,8 +60,9 @@ CXLx_CAPABILITY_HEADER(SNOOP, 0x14)
>   * implements. Some of these are specific to certain types of components, but
>   * this implementation leaves enough space regardless.
>   */
> -/* 8.2.5.9 - CXL RAS Capability Structure */
>  
> +/* CXL r3.1 Section 8.2.4.17: CXL RAS Capability Structure */
> +#define CXL_RAS_CAPABILITY_VERSION 3
>  /* Give ample space for caps before this */
>  #define CXL_RAS_REGISTERS_OFFSET 0x80
>  #define CXL_RAS_REGISTERS_SIZE   0x58
> @@ -95,6 +96,8 @@ REG32(CXL_RAS_COR_ERR_STATUS, CXL_RAS_REGISTERS_OFFSET + 0xc)
>  REG32(CXL_RAS_COR_ERR_MASK, CXL_RAS_REGISTERS_OFFSET + 0x10)
>  REG32(CXL_RAS_ERR_CAP_CTRL, CXL_RAS_REGISTERS_OFFSET + 0x14)
>      FIELD(CXL_RAS_ERR_CAP_CTRL, FIRST_ERROR_POINTER, 0, 6)
> +    FIELD(CXL_RAS_ERR_CAP_CTRL, MULTIPLE_HEADER_RECORDING_CAP, 9, 1)
> +    FIELD(CXL_RAS_ERR_POISON_ENABLED, POISON_ENABLED, 13, 1)
>  REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET + 0x18)
>  #define CXL_RAS_ERR_HEADER_NUM 32
>  /* Offset 0x18 - 0x58 reserved for RAS logs */
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index a55cf5a036..848bfa20f1 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -325,7 +325,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
>                         CXL_##reg##_REGISTERS_OFFSET);                         \
>      } while (0)
>  
> -    init_cap_reg(RAS, 2, 2);
> +    init_cap_reg(RAS, 2, CXL_RAS_CAPABILITY_VERSION);
>      ras_init_common(reg_state, write_msk);
>  
>      init_cap_reg(LINK, 4, 2);
> -- 
> 2.39.2
> 

