Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF7FC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 22:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHWFz-0001w7-6h; Wed, 12 Jun 2024 18:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHWFy-0001vy-06
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 18:15:50 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHWFw-0002zU-06
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 18:15:49 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-421eab59723so3794525e9.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 15:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718230546; x=1718835346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TRE58Bewh9fGBzs82TvbYVpM1CoFZH6uefY40tDNRp0=;
 b=W7OKQYf0xsXiOt5jDGjq3WxT9wPhXp9enBNKXbtXOsEsct4xpDUNTfEKT0uk0I0Wxs
 98FaDsVYU9D7mZtZFhegODq5wAjtBbnZUc8DRk+MDwiAwyjsT0Nne7XAOc3GJw4I24I4
 fzqggObuKbGTOgJ3iE/vnf9G2979KiWj6AXtWqKcA9+sQq+FnEJBB9IUV++/QHdelLs8
 2l8BBXBPquOAwIKoBUEb/7PkFTUpNVoUi/j2Du/A6EBv02tnodyLCPrCSlc/6OmS1ewr
 SMfSCRiv1hxuuUGBK6ZD/Q4LScEmILc4yvUtpvuNDsJQjf0DX5Kv2CbCEhLl35wAC05R
 ipWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718230546; x=1718835346;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TRE58Bewh9fGBzs82TvbYVpM1CoFZH6uefY40tDNRp0=;
 b=qfOGxDJo+exBbJ39S6fGjunI3gjE7cW+9vzjKoOX/8qTU1W9sM0V8aNu3pLOW3bf4i
 WEe11lBOk5pyM8Cm+ku1VRYDPtkWlMU37i3qMLkB3A1R0pHSi3U6qy1WBoRNI3e15wWL
 iEl4LOLSaXkHZuVC3KM0mDqQMog8V0b82gTqkD/t3I/v8vK9e55JzWcDbQKoYxMsFm8m
 38pGHt3Vv86Hs7tG6wMh6aqKpi17YBqRi43e+FG+ZhzmLu3RWmozaskoiYH7kzVC4kIF
 fwRsqpYIIxeJtqB95S4BVz/Q33Wkx78BLMt02eQf6d0jflS//QGj83p3Jmzt4iJnefag
 w1pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyCntwW0m+YvONC8vfHSEmRKSre9mmJ8qugRaDVneAkLsFLAI0YVPh0d6dPLgU3YpzowTERFzzdvWg87+xF2Vm3OqMPgU=
X-Gm-Message-State: AOJu0YxjmxMwfuPBlvqRdqm8gYYKnAJf8LiGVs40H+CKACeo64vvvqCK
 ub1RKpduXsQYuVRFKBJoe+2QlyfDYfzgTyzC/onGHoonbApirTHGjfFHh2Pg3Gw=
X-Google-Smtp-Source: AGHT+IHG2zp4CAmdvGyQ35ZytbCiXd3A/oFwIOpDKrL45deI3cEehuYroXo/VeH5irgj8mVFkLvpIA==
X-Received: by 2002:a05:600c:5102:b0:418:ee2:5911 with SMTP id
 5b1f17b1804b1-422866c543emr26226585e9.28.1718230545945; 
 Wed, 12 Jun 2024 15:15:45 -0700 (PDT)
Received: from [192.168.69.100] (sta21-h02-176-184-21-30.dsl.sta.abo.bbox.fr.
 [176.184.21.30]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f6320bfdsm1648295e9.37.2024.06.12.15.15.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 15:15:45 -0700 (PDT)
Message-ID: <9962c6af-e72d-427b-b3af-5faf0447dae1@linaro.org>
Date: Thu, 13 Jun 2024 00:15:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/32] hw/sd: Add CMD21 tuning sequence
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
References: <20230703132509.2474225-1-clg@kaod.org>
 <20230703132509.2474225-21-clg@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20230703132509.2474225-21-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 3/7/23 15:24, Cédric Le Goater wrote:
> From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> 
> MMC cards support different tuning sequence for entering HS200 mode.
> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> [ clg: - ported on QEMU 7.0 ]
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/sd/sd.c | 40 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 4b4a4cda2e68..7332f7a18435 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2017,6 +2017,30 @@ static const uint8_t sd_tuning_block_pattern[SD_TUNING_BLOCK_SIZE] = {
>       0xbb, 0xff, 0xf7, 0xff,         0xf7, 0x7f, 0x7b, 0xde,
>   };
>   
> +#define EXCSD_BUS_WIDTH_OFFSET 183
> +#define BUS_WIDTH_8_MASK    0x4
> +#define BUS_WIDTH_4_MASK    0x2
> +#define MMC_TUNING_BLOCK_SIZE   128
> +
> +static const uint8_t mmc_tuning_block_pattern[128] = {
> +       0xff, 0xff, 0x00, 0xff, 0xff, 0xff, 0x00, 0x00,
> +       0xff, 0xff, 0xcc, 0xcc, 0xcc, 0x33, 0xcc, 0xcc,
> +       0xcc, 0x33, 0x33, 0xcc, 0xcc, 0xcc, 0xff, 0xff,
> +       0xff, 0xee, 0xff, 0xff, 0xff, 0xee, 0xee, 0xff,
> +       0xff, 0xff, 0xdd, 0xff, 0xff, 0xff, 0xdd, 0xdd,
> +       0xff, 0xff, 0xff, 0xbb, 0xff, 0xff, 0xff, 0xbb,
> +       0xbb, 0xff, 0xff, 0xff, 0x77, 0xff, 0xff, 0xff,
> +       0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee, 0xff,
> +       0xff, 0xff, 0xff, 0x00, 0xff, 0xff, 0xff, 0x00,
> +       0x00, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0x33, 0xcc,
> +       0xcc, 0xcc, 0x33, 0x33, 0xcc, 0xcc, 0xcc, 0xff,
> +       0xff, 0xff, 0xee, 0xff, 0xff, 0xff, 0xee, 0xee,
> +       0xff, 0xff, 0xff, 0xdd, 0xff, 0xff, 0xff, 0xdd,
> +       0xdd, 0xff, 0xff, 0xff, 0xbb, 0xff, 0xff, 0xff,
> +       0xbb, 0xbb, 0xff, 0xff, 0xff, 0x77, 0xff, 0xff,
> +       0xff, 0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee,
> +};
> +
>   uint8_t sd_read_byte(SDState *sd)
>   {
>       /* TODO: Append CRCs */
> @@ -2103,6 +2127,22 @@ uint8_t sd_read_byte(SDState *sd)
>           ret = sd_tuning_block_pattern[sd->data_offset++];
>           break;
>   
> +    case 21:    /* CMD21: SEND_TUNING_BLOCK (MMC) */

This can be accessed in SPI/SD modes, should we check for eMMC then?

Similarly, other cases previous eMMC introduction only expect SPI/SD
but don't check for it. I need to think a bit more on how to handle
that.

> +        if (sd->data_offset >= MMC_TUNING_BLOCK_SIZE - 1) {
> +            sd->state = sd_transfer_state;
> +        }
> +        if (sd->ext_csd[EXCSD_BUS_WIDTH_OFFSET] & BUS_WIDTH_8_MASK) {
> +            ret = mmc_tuning_block_pattern[sd->data_offset++];
> +        } else {
> +            /*
> +             * Return LSB Nibbles of two byte from the 8bit tuning
> +             * block for 4bit mode
> +             */
> +            ret = mmc_tuning_block_pattern[sd->data_offset++] & 0x0F;
> +            ret |= (mmc_tuning_block_pattern[sd->data_offset++] & 0x0F) << 4;
> +        }
> +        break;
> +
>       case 22:  /* ACMD22: SEND_NUM_WR_BLOCKS */
>           ret = sd->data[sd->data_offset ++];
>   


