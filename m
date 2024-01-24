Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E493C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 18:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSiQw-0002cG-IM; Wed, 24 Jan 2024 13:57:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rSiQs-0002b7-Gd
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 13:57:06 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rSiQq-0008Cy-Pg
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 13:57:06 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d75ea3a9b6so28398285ad.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 10:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706122623; x=1706727423; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nqMBNzZx3ZE2LKLPN5406gk/QS3v52I3gK5sU8RKhzc=;
 b=Q33Mo70DyYMaqk3qgXdY+PfywBnJEWVZs9ljI6PBr/NB+LGJ2EfHrkwq6Jjyvi1CEm
 ylxgm0+MJGzlipsr9OGCzFkrpGBltrAZJr9IfRZNOJ9/Ut7J6vqw7AUTvMA+iuv4k8+W
 pQzfkPGjEynT4ZDRezqNbcOR0pPrbXLSi6uaEJMlGY8Chw8WDs+VZ1nVk3bnQRF/unEu
 ICalyhassVvaUBfjpg0VN7wPR/AVwhIX5HToPXWdo8qDZIWDRWy4H/fKHvPWH+khuzrh
 gbuVEqa2tqA3sBBYSjyQNyYY7x4hArcAFCSpGG64O01GDA0VfiWGrRbT4w/a7ag7S3wm
 54Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706122623; x=1706727423;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nqMBNzZx3ZE2LKLPN5406gk/QS3v52I3gK5sU8RKhzc=;
 b=CVe/nwYGY8aZjLVQQexhBVczFNrxBS2StHA88/GGwGMkXKBPE5qkVYydSi6BC397mI
 84p63bRODicsP7sojbtu4ldGGPBjX3vPQ+EC2nD8XB15Kf6MXg2epVnKTmDRxKXGzrh5
 fmAB33ni6T9IvqmZCbGcfhT+xKQDpn1gsanl6jgIY1Gf+XLhBISWuvHfXbg/sYcPvnvj
 lgdiv3k7ICqPrWzrd3s4MduGdhIkDoRulTOSUuqb0SSslf/0Jy4eSxASHkiY6UdIcuoz
 BKK7zM1LvFNarkZyDAlELgbcbSNjVU6Ide55HAn1+8iAoLltSgqplvlfMXHI+h9otudb
 ISdg==
X-Gm-Message-State: AOJu0YzoBLa4B/wDsTWbPMmklWgsJO4TbDjBTTGjF9Fd227QaTsQEF6n
 3q88ZZioTmp3eaAijFpyqAir4qyvHQM8uNaxg5BRtrHHCaI78pkn
X-Google-Smtp-Source: AGHT+IEw27iDW+MU/bmpce30MixoYf5Z3Eiyqlw10Vy89mzcTVB33gVN0fPadnIxiEeMDp1QWuWKxg==
X-Received: by 2002:a17:90b:88f:b0:290:8cb7:fa10 with SMTP id
 bj15-20020a17090b088f00b002908cb7fa10mr3909572pjb.15.1706122623196; 
 Wed, 24 Jan 2024 10:57:03 -0800 (PST)
Received: from debian (c-71-202-32-218.hsd1.ca.comcast.net. [71.202.32.218])
 by smtp.gmail.com with ESMTPSA id
 r5-20020a17090ad40500b0029004b9df9fsm14257004pju.36.2024.01.24.10.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 10:57:02 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jan 2024 10:57:00 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 Fan Ni <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>,
 Davidlohr Bueso <dave@stgolabs.net>, linuxarm@huawei.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 4/5] hw/cxl: Update mailbox status registers.
Message-ID: <ZbFdfOiWTkTggRSp@debian>
References: <20240124134814.8717-1-Jonathan.Cameron@huawei.com>
 <20240124134814.8717-5-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124134814.8717-5-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x634.google.com
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

On Wed, Jan 24, 2024 at 01:48:13PM +0000, Jonathan Cameron wrote:
> Whilst the reported version was 1 so there should be no changes,
> a couple of fields (where the value 0 was valid) were not
> defined. Make those explicit and update references to be based
> on CXL r3.1.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  include/hw/cxl/cxl_device.h | 17 ++++++++++-------
>  hw/cxl/cxl-device-utils.c   |  6 +++++-
>  2 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 31d2afcd3d..9f51c586d7 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -189,7 +189,7 @@ typedef struct cxl_device_state {
>          };
>      };
>  
> -    /* mmio for the mailbox registers 8.2.8.4 */
> +    /* CXL r3.1 Section 8.2.8.4: Mailbox Registers */
>      struct {
>          MemoryRegion mailbox;
>          uint16_t payload_size;
> @@ -310,39 +310,42 @@ void cxl_initialize_t3_ld_cci(CXLCCI *cci, DeviceState *d,
>  REG64(CXL_DEV_EVENT_STATUS, 0)
>      FIELD(CXL_DEV_EVENT_STATUS, EVENT_STATUS, 0, 32)
>  
> -/* CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register */
> +#define CXL_DEV_MAILBOX_VERSION 1
> +/* CXL r3.1 Section 8.2.8.4.3: Mailbox Capabilities Register */
>  REG32(CXL_DEV_MAILBOX_CAP, 0)
>      FIELD(CXL_DEV_MAILBOX_CAP, PAYLOAD_SIZE, 0, 5)
>      FIELD(CXL_DEV_MAILBOX_CAP, INT_CAP, 5, 1)
>      FIELD(CXL_DEV_MAILBOX_CAP, BG_INT_CAP, 6, 1)
>      FIELD(CXL_DEV_MAILBOX_CAP, MSI_N, 7, 4)
> +    FIELD(CXL_DEV_MAILBOX_CAP, MBOX_READY_TIME, 11, 8)
> +    FIELD(CXL_DEV_MAILBOX_CAP, TYPE, 19, 4)
>  
> -/* CXL 2.0 8.2.8.4.4 Mailbox Control Register */
> +/* CXL r3.1 Section 8.2.8.4.4: Mailbox Control Register */
>  REG32(CXL_DEV_MAILBOX_CTRL, 4)
>      FIELD(CXL_DEV_MAILBOX_CTRL, DOORBELL, 0, 1)
>      FIELD(CXL_DEV_MAILBOX_CTRL, INT_EN, 1, 1)
>      FIELD(CXL_DEV_MAILBOX_CTRL, BG_INT_EN, 2, 1)
>  
> -/* CXL 2.0 8.2.8.4.5 Command Register */
> +/* CXL r3.1 Section 8.2.8.4.5: Command Register */
>  REG64(CXL_DEV_MAILBOX_CMD, 8)
>      FIELD(CXL_DEV_MAILBOX_CMD, COMMAND, 0, 8)
>      FIELD(CXL_DEV_MAILBOX_CMD, COMMAND_SET, 8, 8)
>      FIELD(CXL_DEV_MAILBOX_CMD, LENGTH, 16, 20)
>  
> -/* CXL 2.0 8.2.8.4.6 Mailbox Status Register */
> +/* CXL r3.1 Section 8.2.8.4.6: Mailbox Status Register */
>  REG64(CXL_DEV_MAILBOX_STS, 0x10)
>      FIELD(CXL_DEV_MAILBOX_STS, BG_OP, 0, 1)
>      FIELD(CXL_DEV_MAILBOX_STS, ERRNO, 32, 16)
>      FIELD(CXL_DEV_MAILBOX_STS, VENDOR_ERRNO, 48, 16)
>  
> -/* CXL 2.0 8.2.8.4.7 Background Command Status Register */
> +/* CXL r3.1 Section 8.2.8.4.7: Background Command Status Register */
>  REG64(CXL_DEV_BG_CMD_STS, 0x18)
>      FIELD(CXL_DEV_BG_CMD_STS, OP, 0, 16)
>      FIELD(CXL_DEV_BG_CMD_STS, PERCENTAGE_COMP, 16, 7)
>      FIELD(CXL_DEV_BG_CMD_STS, RET_CODE, 32, 16)
>      FIELD(CXL_DEV_BG_CMD_STS, VENDOR_RET_CODE, 48, 16)
>  
> -/* CXL 2.0 8.2.8.4.8 Command Payload Registers */
> +/* CXL r3.1 Section 8.2.8.4.8: Command Payload Registers */
>  REG32(CXL_DEV_CMD_PAYLOAD, 0x20)
>  
>  REG64(CXL_MEM_DEV_STS, 0)
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> index 40b619ffd9..9df8738f86 100644
> --- a/hw/cxl/cxl-device-utils.c
> +++ b/hw/cxl/cxl-device-utils.c
> @@ -366,6 +366,10 @@ static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
>      ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
>                       MSI_N, msi_n);
>      cxl_dstate->mbox_msi_n = msi_n;
> +    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
> +                     MBOX_READY_TIME, 0); /* Not reported */
> +    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
> +                     TYPE, 0); /* Inferred from class code */
>  }
>  
>  static void memdev_reg_init_common(CXLDeviceState *cxl_dstate)
> @@ -392,7 +396,7 @@ void cxl_device_register_init_t3(CXLType3Dev *ct3d)
>      cxl_device_cap_init(cxl_dstate, DEVICE_STATUS, 1, 2);
>      device_reg_init_common(cxl_dstate);
>  
> -    cxl_device_cap_init(cxl_dstate, MAILBOX, 2, 1);
> +    cxl_device_cap_init(cxl_dstate, MAILBOX, 2, CXL_DEV_MAILBOX_VERSION);
>      mailbox_reg_init_common(cxl_dstate);
>  
>      cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000, 1);
> -- 
> 2.39.2
> 

