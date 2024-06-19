Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7D1C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 17:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJzIW-0000zw-Ph; Wed, 19 Jun 2024 13:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJzIS-0000zB-SC
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 13:40:37 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJzIQ-00063s-MB
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 13:40:36 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57cc1c00ba6so6449266a12.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 10:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718818833; x=1719423633; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f4skJCa4wMR5/p1vPpn4GIPcC8hA65S+qZcd/sGER4E=;
 b=QBRhGfYy3w+oSLiQvcU5HbCeg9JW2uC7bonsrLIotT2Pisc7ldmdGZRcfi3s7/Pj2D
 e0b0AHs0PUvzpW57qFVcWpATwFpkYbkRjJoH5V408ywixeuuSEq3ART1RvXXYD1YjxrX
 HY8DHEYV/uRlF2rj9R5CWSj2urvrk66jN0crmwdrEi4iRKvYwxo+E+xE2JZWA+Onw9VQ
 ZMSX2lWUeaUzUFTfaBJ6KjLbDYK0Vx8pbHDFwo54PWysCegZhBFyqFECNz80t5HA1vv/
 6PAfAOZrw87foe4Sawfmr1LHGa5LHXiyvN98dj4CzUK0Qls4G9hC5TBamTqy33e+y5Rq
 Iw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718818833; x=1719423633;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f4skJCa4wMR5/p1vPpn4GIPcC8hA65S+qZcd/sGER4E=;
 b=rKfE5jYtT2fCOq/gGAHRS0FxW58l5DBvstXpOrPWcGyHtTVbrby8SwHvMECxqJwvSZ
 mKaGf8vsoQ4e2h2c7zjR3eXzwI9BM8e7DZij8FlQj0avMIa7affAI0jOETSjeyzOJVe0
 OLfJPWguF7PMm1mRRQAF5vSS/s2LKw719Fy5GzseruStlo6K1vy1G7mwtgl2O1MN1+A/
 iuFodcXzGrZq3Q3jBaEmSX1mN+MVZCTC+RPDGDSUpAiIeXmf++Va8FgUoF+zHCe07dLl
 qGMSs6MLb/0UWNAmDDBNYJBQwPRb8Y93b0tG3n1PbZoBW8dxqqAfnbchrMruNIrsXYFH
 ahEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf6Ygw6dOLpLiLAV8jbuPBjLJItC6e+dDcdAB5orklB2f8Hb7n6s0MTPB+o8ilpjDW9gfFEjsHgL5cHoHs1unJO3NO8YA=
X-Gm-Message-State: AOJu0YxWCA0QDx/ROLo0SoCN9hF9JGH2VFleLOWF8agrtIPlYW8K24Z6
 t5oub95F0wwLbZ5BbJsXsNM9J/bvyqD+z8/wHBpPnHjDiQQ21yiWS8Jfe1PGCiA=
X-Google-Smtp-Source: AGHT+IGt5awq/V9cI3yWAlJE10x1aAboz7tqIYIVpYmP2fj6G+4CFlzBkBMa6GXnptqH1nbKRfsPlw==
X-Received: by 2002:a50:ee92:0:b0:57c:765b:83a3 with SMTP id
 4fb4d7f45d1cf-57d0bff1a13mr1925322a12.25.1718818832015; 
 Wed, 19 Jun 2024 10:40:32 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.133.105])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb743890dsm8616920a12.83.2024.06.19.10.40.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 10:40:31 -0700 (PDT)
Message-ID: <59f1da17-719d-4389-b21a-053b2ee980dd@linaro.org>
Date: Wed, 19 Jun 2024 19:40:29 +0200
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
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

Hi,

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

First pass review, this will take time...

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

We do not support (and are not interested in) that. I'll use 0x0 for
"do not support".

> +    sd->ext_csd[EXT_CSD_SEC_ERASE_MULT] = 0x96; /* Secure erase support */

This value is obsolete, so I'd use 0x0 to avoid confusions.

> +    sd->ext_csd[EXT_CSD_SEC_TRIM_MULT] = 0x96; /* Secure TRIM multiplier */

Again, 0x0 for "not defined".

> +    sd->ext_csd[EXT_CSD_BOOT_INFO] = 0x7; /* Boot information */
> +    sd->ext_csd[EXT_CSD_BOOT_MULT] = 0x8; /* Boot partition size. 128KB unit */
> +    sd->ext_csd[EXT_CSD_ACC_SIZE] = 0x6; /* Access size */

16KB of super_page_size hmm. Simpler could be the underlying block
retrieved with bdrv_nb_sectors() or simply BDRV_SECTOR_SIZE (0x1).

> +    sd->ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] = 0x4; /* HC Erase unit size */

2MB of erase size hmmm why not.

> +    sd->ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT] = 0x1; /* HC erase timeout */

We don't implement timeout, can we use 0?

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

Class B at 3MB/s. I suppose announcing up to J at 21MB/s is safe (0x46).

> +    sd->ext_csd[EXT_CSD_PART_SWITCH_TIME] = 0x1;

SWITCH command isn't implemented so far. We could use 0x0 for "not
defined".

> +    sd->ext_csd[EXT_CSD_OUT_OF_INTERRUPT_TIME] = 0x1;

Similarly, 0x0 for "undefined" is legal.

> +    sd->ext_csd[EXT_CSD_CARD_TYPE] = 0x7;

You anounce dual data rate. Could we just use High-Speed mode (0x3)
to ease modelling?

> +    sd->ext_csd[EXT_CSD_STRUCTURE] = 0x2;
> +    sd->ext_csd[EXT_CSD_REV] = 0x5;

This is Revision 1.5 (for MMC v4.41)... The first QEMU implementation
was based on Revision 1.3 (for MMC v4.3) and I'm seeing some features
from Revision 1.6 (for MMC v4.5)...

Do we want to implement all of them? Since we are adding from
scratch, I suggest we directly start with v4.5 (0x6).

Note, EXT_CSD_BUS_WIDTH is not set (0x0) meaning 1-bit data bus.
I'd set it to 0x2 (8-bit):

        sd->ext_csd[EXT_CSD_BUS_WIDTH] = EXT_CSD_BUS_WIDTH_8_MASK;

> +    sd->ext_csd[EXT_CSD_RPMB_MULT] = 0x1; /* RPMB size */
> +    sd->ext_csd[EXT_CSD_PARTITION_SUPPORT] = 0x3;
> +    sd->ext_csd[159] = 0x00; /* Max enhanced area size */
> +    sd->ext_csd[158] = 0x00; /* ... */
> +    sd->ext_csd[157] = 0xEC; /* ... */
> +}


