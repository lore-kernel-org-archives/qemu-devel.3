Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F9FC2BA18
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 09:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKEVN-0002U0-Hp; Thu, 20 Jun 2024 05:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKEVI-0002Nu-Gy
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:54:53 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKEVF-0005UJ-Si
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:54:51 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a6f51660223so36780966b.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 02:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718877288; x=1719482088; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m5sQ6gvadSLwAdHAje/r5iIRCwLuMbfiGlO1mJnXkOE=;
 b=lmpbHgpE/Fnrd/ehJZLtV2hgnlhGw86mBf/58iIQgd0QGkAPVEcry3FXhuNX2N+nId
 P7Zf1XQh+FX4x8JTlxq2v612jTfs6fDRmkiYswoL7c9Y4ZmKGU3iohZnqNbh2G/oWCsV
 ZBy+9ma4qprjk9NXFzwLRQ5KDEJKr23btfkrwpzYbi5hjvk8D8JAqrNW9qpXNHlYagJZ
 6npKbn6Ki2ktMaxCBAmD/yJXD/BQn1CAeW9e7hm5RQ5nzCjMjpD/Fb5WMi9F8kCC3kPJ
 6wDnq15pUQa6jy9YSXZdIitrwKgYo/WhAMfwjPMUubhSZ/THRkcC0FHCAOrjFxoO1i+D
 NqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718877288; x=1719482088;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m5sQ6gvadSLwAdHAje/r5iIRCwLuMbfiGlO1mJnXkOE=;
 b=SKe5tlB/HVnp76TSuChuBgqFxLkvT8xM7jhX6plRhAxz7saMiLnIu+9z1Qvt3HBI+x
 WylgaVuAJkyCDtFVa477Mz+vOp+Q9b0GWu5REhpEnhK9O2h82qQFk9jmf5fYvl6oB/v0
 qy8BIsfppp+K06ZougguOJJEwD0gy4X692JDCTJoUEejdfB4Xjy5KgO7CdG+jXB3IZZ3
 8bmKxpKrdH6cr+ahxYTem0jjHw1TclABx0w2FO4fd4Qql7n5zJvlvx5uu8JdKgXM0uzj
 h/UCv4was4wsai/t+RM4fLBwaESWiATGcMpassdb6H1wBCOWU/10HZaz7UqJDMm/I1SX
 VkbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK4uqxsooyykhG42BYUGsWggx/3DLLBcZ8nczcwBigAB9saWiN3+5PPVdUpJGXGc0jS00dtepIVoJYobc676NpMqn0puE=
X-Gm-Message-State: AOJu0YxliGSxp7MfBS2YvAZFtEWKUuiUfvmyZav9pCCB9vCSevw51kxa
 tmdLRBZJ3oRInmMbNHBImXIABS6noJ+ppU5vbxEjCKbuss1xtoGSVHVerkm6Z70O+6jc8kWIOGC
 e
X-Google-Smtp-Source: AGHT+IGxJ3ZfIYw1pMFGBCEM6yZEIIvKuwFPI4yvqBLnUeV35YKW3eTBXfcTcLtnEXogEJ3YGKUqjg==
X-Received: by 2002:a50:9b54:0:b0:57a:4c22:b3 with SMTP id
 4fb4d7f45d1cf-57d07e0d43dmr3318794a12.1.1718877288049; 
 Thu, 20 Jun 2024 02:54:48 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.151.40])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56ecdd40sm753149066b.120.2024.06.20.02.54.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 02:54:47 -0700 (PDT)
Message-ID: <2c043e6e-e685-44fb-a231-e59d7ba89234@linaro.org>
Date: Thu, 20 Jun 2024 11:54:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/32] hw/sd: Add emmc_cmd_SEND_EXT_CSD() handler
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 Joel Stanley <joel@jms.id.au>
Cc: Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
References: <20230703132509.2474225-1-clg@kaod.org>
 <20230703132509.2474225-23-clg@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20230703132509.2474225-23-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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
> The parameters mimick a real 4GB eMMC, but it can be set to various
> sizes. Initially from Vincent Palatin <vpalatin@chromium.org>
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/sd/sdmmc-internal.h |  97 ++++++++++++++++++++++++++++++++++++
>   include/hw/sd/sd.h     |   1 +
>   hw/sd/sd.c             | 109 ++++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 206 insertions(+), 1 deletion(-)


> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 51e2254728a6..212658050441 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -141,6 +141,7 @@ struct SDState {
>       uint64_t data_start;
>       uint32_t data_offset;
>       uint8_t data[512];
> +    uint8_t ext_csd[512];

Since the SWITCH command writes to EXT_CSD, this array must be
migrated.

>       qemu_irq readonly_cb;
>       qemu_irq inserted_cb;
>       QEMUTimer *ocr_power_timer;
> @@ -414,8 +415,85 @@ static const uint8_t sd_csd_rw_mask[16] = {
>       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfc, 0xfe,
>   };
>   
> +static void mmc_set_ext_csd(SDState *sd, uint64_t size)
> +{
> +    uint32_t sectcount = size >> HWBLOCK_SHIFT;
> +
> +    memset(sd->ext_csd, 0, sizeof(sd->ext_csd));
> +
> +    sd->ext_csd[EXT_CSD_S_CMD_SET] = 0x1; /* supported command sets */
> +    sd->ext_csd[EXT_CSD_HPI_FEATURES] = 0x3; /* HPI features  */
> +    sd->ext_csd[EXT_CSD_BKOPS_SUPPORT] = 0x1; /* Background operations */
> +    sd->ext_csd[241] = 0xA; /* 1st initialization time after partitioning */
> +    sd->ext_csd[EXT_CSD_TRIM_MULT] = 0x1; /* Trim multiplier */
> +    sd->ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT] = 0x15; /* Secure feature */
> +    sd->ext_csd[EXT_CSD_SEC_ERASE_MULT] = 0x96; /* Secure erase support */
> +    sd->ext_csd[EXT_CSD_SEC_TRIM_MULT] = 0x96; /* Secure TRIM multiplier */
> +    sd->ext_csd[EXT_CSD_BOOT_INFO] = 0x7; /* Boot information */
> +    sd->ext_csd[EXT_CSD_BOOT_MULT] = 0x8; /* Boot partition size. 128KB unit */
> +    sd->ext_csd[EXT_CSD_ACC_SIZE] = 0x6; /* Access size */
> +    sd->ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] = 0x4; /* HC Erase unit size */
> +    sd->ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT] = 0x1; /* HC erase timeout */
> +    sd->ext_csd[EXT_CSD_REL_WR_SEC_C] = 0x1; /* Reliable write sector count */
> +    sd->ext_csd[EXT_CSD_HC_WP_GRP_SIZE] = 0x4; /* HC write protect group size */
> +    sd->ext_csd[EXT_CSD_S_C_VCC] = 0x8; /* Sleep current VCC  */
> +    sd->ext_csd[EXT_CSD_S_C_VCCQ] = 0x7; /* Sleep current VCCQ */
> +    sd->ext_csd[EXT_CSD_S_A_TIMEOUT] = 0x11; /* Sleep/Awake timeout */
> +    sd->ext_csd[215] = (sectcount >> 24) & 0xff; /* Sector count */
> +    sd->ext_csd[214] = (sectcount >> 16) & 0xff; /* ... */
> +    sd->ext_csd[213] = (sectcount >> 8) & 0xff;  /* ... */
> +    sd->ext_csd[EXT_CSD_SEC_CNT] = (sectcount & 0xff);       /* ... */
> +    sd->ext_csd[210] = 0xa; /* Min write perf for 8bit@52Mhz */
> +    sd->ext_csd[209] = 0xa; /* Min read perf for 8bit@52Mhz  */
> +    sd->ext_csd[208] = 0xa; /* Min write perf for 4bit@52Mhz */
> +    sd->ext_csd[207] = 0xa; /* Min read perf for 4bit@52Mhz */
> +    sd->ext_csd[206] = 0xa; /* Min write perf for 4bit@26Mhz */
> +    sd->ext_csd[205] = 0xa; /* Min read perf for 4bit@26Mhz */
> +    sd->ext_csd[EXT_CSD_PART_SWITCH_TIME] = 0x1;
> +    sd->ext_csd[EXT_CSD_OUT_OF_INTERRUPT_TIME] = 0x1;
> +    sd->ext_csd[EXT_CSD_CARD_TYPE] = 0x7;
> +    sd->ext_csd[EXT_CSD_STRUCTURE] = 0x2;
> +    sd->ext_csd[EXT_CSD_REV] = 0x5;
> +    sd->ext_csd[EXT_CSD_RPMB_MULT] = 0x1; /* RPMB size */
> +    sd->ext_csd[EXT_CSD_PARTITION_SUPPORT] = 0x3;
> +    sd->ext_csd[159] = 0x00; /* Max enhanced area size */
> +    sd->ext_csd[158] = 0x00; /* ... */
> +    sd->ext_csd[157] = 0xEC; /* ... */
> +}


