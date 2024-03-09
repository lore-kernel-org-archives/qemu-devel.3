Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A541BC54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 16:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rizZl-0001Uf-3D; Sat, 09 Mar 2024 11:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rizZj-0001Tm-2d
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 11:29:31 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rizZh-0000L3-9R
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 11:29:30 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33e2268ed96so1965339f8f.3
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 08:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710001766; x=1710606566; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c+Qp+eRpNnuEw4WIaFD7l2PcKXeWbed1VsO5WF8bn70=;
 b=fU80+7RqYHzgTYsL/8Fb1q4LJUcdiWA2ASVJ4PZhYf2xT0kVRjYQNfpLWZL7l0OWGU
 mcckVx9vdO6IYdA/gidDyD0uzsuzaQIzMXfzcrVCbXNcwtvw1gHWeJWHPUv2X1CD6yiu
 6qgg8JN5Tfj8VnIlb2rMaDRzNK2z+YihAZQt5C13voqBptii7OwJz59AC7VQnhJl3CtG
 bbJbm4ZNPRADZjXTP0u0kocw+yDJoZIqjNOEBX6LMqzQapYqKg9c7Pk4TZLGb5TsyyLb
 V/w0QkIehSwh23HG39j8/1BqWxd598R8z2xcdbMM49G41/2suzmrD0RbT1AWzLJvKtI+
 ZCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710001766; x=1710606566;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c+Qp+eRpNnuEw4WIaFD7l2PcKXeWbed1VsO5WF8bn70=;
 b=VnQHeU9IbglHd6hochHALNiGTJkGH5L8mUjiaHsvnMPptfYJNgrqIE86gzObT7C6Wm
 2kY4yLjKLcne2walzrHXrdr5CkVCapals8+NiRli4sTnG1KiTKRgvOGBqXKoJGZtprbI
 g1wr86qr6oWjEgejhNi2INEzEb6uKHJ1hdCgoEqde7ldVTm5BFgPdosP8YDXD4TczXfV
 899pHP1rHXiFo4Q18q3536PxyaROVZJwwX4vK6sQb9p3Gy3CF2Ye92Jf283JQdpN7K5X
 Kvp2YKc1pYsElwh4gPMwKjH9cnH3ljeLz9OUrMnDQA9Ze0bwtPUZxNhl2pNM2NWaW7Zi
 HCaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUQX+3itlXvsxuKkNTD8/fK0wty+yh6hf9CJUVlNm7j87YAosta86zq2WYnGH/rGJMrh83zZApLiaA2HTnYTRIHE0QMQs=
X-Gm-Message-State: AOJu0YzRSOUwyEv0s8Wp0gP01K374ADsZxWRPPNz6+OR+42JLRVdq2/c
 d5iV/RwZlRppzXzkzVZ5w412OgUGpWu86rvZbJBWMAq3RK3iSMUuDUG2t5O+ul8=
X-Google-Smtp-Source: AGHT+IGdV5djV7ebkyRfFbmxeybpKYUWZXPGQiVgxP6hnDjejPV88IO+hbeAoO+sn57nG+pTckNzhA==
X-Received: by 2002:a5d:4e01:0:b0:33e:5fb9:af28 with SMTP id
 p1-20020a5d4e01000000b0033e5fb9af28mr1291195wrt.57.1710001765651; 
 Sat, 09 Mar 2024 08:29:25 -0800 (PST)
Received: from [192.168.69.100] ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a5d51c8000000b0033e6ede34d3sm2148252wrv.39.2024.03.09.08.29.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Mar 2024 08:29:25 -0800 (PST)
Message-ID: <16c61c00-30e9-41a3-b202-ec05d778e296@linaro.org>
Date: Sat, 9 Mar 2024 17:29:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/pci-host/pam: Free PAMMemoryRegion from
 Intel-specific bit handling
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240309134056.1605-1-shentey@gmail.com>
 <20240309134056.1605-2-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240309134056.1605-2-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Hi Bernhard,

On 9/3/24 14:40, Bernhard Beschow wrote:
> The PAM bit extraction is currently spread across pam.c and the northbridge
> device models, making the extraction logic harder to comprehend. Also note how
> pam_update() deals with PAM_REGIONS_COUNT, even though it handles exactly one
> region. Fix this (at the cost of minor code duplication) by moving the bit
> extraction into the northbridge device models. As a side effect, pam_update()
> becomes less Intel-specific which would allow it to be reused e.g. in VIA
> northbridges.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/pci-host/pam.h |  7 +++----
>   hw/pci-host/i440fx.c      |  7 +++++--
>   hw/pci-host/pam.c         | 14 +++++++-------
>   hw/pci-host/q35.c         |  5 +++--
>   4 files changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/include/hw/pci-host/pam.h b/include/hw/pci-host/pam.h
> index 005916f826..b9b33aecc8 100644
> --- a/include/hw/pci-host/pam.h
> +++ b/include/hw/pci-host/pam.h
> @@ -70,7 +70,6 @@
>   /* PAM registers: log nibble and high nibble*/
>   #define PAM_ATTR_WE     ((uint8_t)2)
>   #define PAM_ATTR_RE     ((uint8_t)1)
> -#define PAM_ATTR_MASK   ((uint8_t)3)

Why not use PAM_ATTR_foo instead of MCH_HOST_BRIDGE_PAM_foo?

>   /* SMRAM register */
>   #define SMRAM_D_OPEN           ((uint8_t)(1 << 6))
> @@ -83,13 +82,13 @@
>   #define PAM_REGIONS_COUNT       13
>   
>   typedef struct PAMMemoryRegion {
> -    MemoryRegion alias[4];  /* index = PAM value */
> -    unsigned current;
> +    MemoryRegion alias[4];  /* index = mode value */
> +    uint8_t mode;
>   } PAMMemoryRegion;
>   
>   void init_pam(PAMMemoryRegion *mem, Object *owner, MemoryRegion *ram,
>                 MemoryRegion *system, MemoryRegion *pci,
>                 uint32_t start, uint32_t size);
> -void pam_update(PAMMemoryRegion *mem, int idx, uint8_t val);
> +void pam_update(PAMMemoryRegion *mem, uint8_t mode);
>   
>   #endif /* QEMU_PAM_H */
> diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
> index 4f0a0438d7..cddd506ab0 100644
> --- a/hw/pci-host/i440fx.c
> +++ b/hw/pci-host/i440fx.c
> @@ -64,6 +64,8 @@ struct I440FXState {
>   #define I440FX_PAM_SIZE 7
>   #define I440FX_SMRAM    0x72
>   
> +#define I440FX_PAM_ATTR_MASK ((uint8_t)3)

or (PAM_ATTR_RE|PAM_ATTR_WE)?

It is odd to have I440FX_PAM_ATTR_MASK disconnected
from the values it masks.

> -void pam_update(PAMMemoryRegion *pam, int idx, uint8_t val)
> +void pam_update(PAMMemoryRegion *pam, uint8_t mode)
>   {
> -    assert(0 <= idx && idx < PAM_REGIONS_COUNT);
> +    g_assert(mode < ARRAY_SIZE(pam->alias));
>   
> -    memory_region_set_enabled(&pam->alias[pam->current], false);
> -    pam->current = (val >> ((!(idx & 1)) * 4)) & PAM_ATTR_MASK;

Can we pass the mask by argument instead?

> -    memory_region_set_enabled(&pam->alias[pam->current], true);
> +    memory_region_set_enabled(&pam->alias[pam->mode], false);
> +    pam->mode = mode;
> +    memory_region_set_enabled(&pam->alias[pam->mode], true);
>   }

Are the VIA values different of the PAM_ATTR_foo ones?

I'm not sure this is an helpful change, I'd rather
remove the MCH_HOST_BRIDGE_PAM_foo definitions and
use the PAM generic ones.

Regards,

Phil.

