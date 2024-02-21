Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F7CC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcrT4-0005MN-MB; Wed, 21 Feb 2024 13:37:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcrT3-0005LO-4r
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:37:17 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcrT1-00062c-EW
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:37:16 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a3e72ec566aso126154666b.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 10:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708540633; x=1709145433; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yrKXObd+UTfgg0nkPQ5SnoLv8F/U/VagFm3n3E/xOQw=;
 b=gdqdQ/x/Zw8UcUK42GuiSEb+akZVrilXUvhOoaxFA5IEe1SPdgn6pB3WeMniPlHSng
 5qMWhQSC75d7yKO0y5sC1+bPOiQhJrS+JncaHvlX6/8TuKsxRJbWaIblF8X3ya5CYbcn
 QqAy9gYT0dJySHwImH+PFi1XF9pD/i+wIfC28u0rLwsru7KcQrR+CYdWCOY4VqX9J3ZS
 iwyC1tYJantFpBfOIJDIdDNjLlLccKYFaaWEXGTWcZ2iV/OOq3BD4iiHz0uYVZC8rArr
 RzS2S/PqfbcMWidLEicffFK6JBJViE14ZCrdrXu2OgSpMX5xOmSU9dtfDhgC5VTgi/oJ
 d/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708540633; x=1709145433;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yrKXObd+UTfgg0nkPQ5SnoLv8F/U/VagFm3n3E/xOQw=;
 b=GbpIX11tOwY40Cztezn69RTIARUx1AtNOgmN+lzYMTe25w7i1oG6req9cW/BvQ2J2H
 2adr8IdGnSG4Gda8kDaYY9D5SWqPWWKLM+S6MdYKffVTAUeq+bRGcoYc/7uyogOl+N08
 vuwaMhd8peGpGwuxEgpHr/LOwXtiNOUv8sAQzgsGT78ibEO6Q3nK2RUsZWOTaHxMA+m0
 wKlUdD8YBUnL/ll2K9Or/Glhe8r1BHlOJ/aMjWSzh5ygkMBn51/2WFus+sstFhaNBb1M
 NSkZlIeU6E99rEOEILbnaez1ok6LXUXcoDiGIcSe0vaCjbt6sBEmHmo7aCg9b//90y8j
 k6Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdTub0OhvwnvGXp/Iu1qoUZ3aSxFJi/L/C0T/QSo5LZ1fEvW4RjMHZ3GhDX8oe6uCyKtKJdIHLjOVIHaVDHY972Xx+qWU=
X-Gm-Message-State: AOJu0YxTAH6mWxHNgGiMZcr++COg/vLVZ6GdQXHbZPC7GEA1Kf61t4Dr
 ZQxa6QnPm1B8ZC/F7E37JLv+BTrw3hS3LWIVURKAC0uf6BpPNA5iXFNqlUkpcur16nkGK2HsJSd
 snwg=
X-Google-Smtp-Source: AGHT+IEKn3abDQvvAQ37razbCcJYNnFZoQdaZXMaTJlBV3inF6AR8qJs5XsiBLgEmE8H83ExLtbhWQ==
X-Received: by 2002:a17:906:b0c:b0:a3e:5b7f:6d31 with SMTP id
 u12-20020a1709060b0c00b00a3e5b7f6d31mr6365745ejg.5.1708540633145; 
 Wed, 21 Feb 2024 10:37:13 -0800 (PST)
Received: from [192.168.221.175] ([93.23.14.172])
 by smtp.gmail.com with ESMTPSA id
 vu2-20020a170907a64200b00a3d2e690abfsm5132944ejc.122.2024.02.21.10.37.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 10:37:12 -0800 (PST)
Message-ID: <8a67e4b9-df36-449a-ac74-e8da3a8b3af1@linaro.org>
Date: Wed, 21 Feb 2024 19:37:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] hw/ide: Move IDE DMA related definitions to a
 separate header ide-dma.h
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-block@nongnu.org
References: <20240220085505.30255-1-thuth@redhat.com>
 <20240220085505.30255-4-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240220085505.30255-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 20/2/24 09:55, Thomas Huth wrote:
> These definitions are required outside of the hw/ide/ code, too,
> so lets's move them from internal.h to a new header called ide-dma.h.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/ide/ide-dma.h  | 37 +++++++++++++++++++++++++++++++++++++
>   include/hw/ide/internal.h | 29 +----------------------------
>   2 files changed, 38 insertions(+), 28 deletions(-)
>   create mode 100644 include/hw/ide/ide-dma.h
> 
> diff --git a/include/hw/ide/ide-dma.h b/include/hw/ide/ide-dma.h
> new file mode 100644
> index 0000000000..3ac4c3c9fa
> --- /dev/null
> +++ b/include/hw/ide/ide-dma.h
> @@ -0,0 +1,37 @@
> +#ifndef HW_IDE_DMA_H
> +#define HW_IDE_DMA_H
> +
> +#include "block/aio.h"
> +#include "qemu/iov.h"
> +
> +typedef struct IDEState IDEState;
> +typedef struct IDEDMAOps IDEDMAOps;
> +typedef struct IDEDMA IDEDMA;
> +
> +typedef void DMAStartFunc(const IDEDMA *, IDEState *, BlockCompletionFunc *);
> +typedef void DMAVoidFunc(const IDEDMA *);
> +typedef int DMAIntFunc(const IDEDMA *, bool);
> +typedef int32_t DMAInt32Func(const IDEDMA *, int32_t len);
> +typedef void DMAu32Func(const IDEDMA *, uint32_t);
> +typedef void DMAStopFunc(const IDEDMA *, bool);
> +
> +struct IDEDMAOps {
> +    DMAStartFunc *start_dma;
> +    DMAVoidFunc *pio_transfer;
> +    DMAInt32Func *prepare_buf;
> +    DMAu32Func *commit_buf;
> +    DMAIntFunc *rw_buf;
> +    DMAVoidFunc *restart;
> +    DMAVoidFunc *restart_dma;
> +    DMAStopFunc *set_inactive;
> +    DMAVoidFunc *cmd_done;
> +    DMAVoidFunc *reset;
> +};
> +
> +struct IDEDMA {
> +    const struct IDEDMAOps *ops;

While here, let's use the typedef, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +    QEMUIOVector qiov;
> +    BlockAIOCB *aiocb;
> +};



