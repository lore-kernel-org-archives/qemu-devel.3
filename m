Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBF0E67807
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 17:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7Hsm-0003fG-R2; Sat, 02 Nov 2024 13:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1t7Hsi-0003Yd-Kb
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 13:25:49 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1t7Hsc-0000H9-6I
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 13:25:48 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3e600add5dcso1455523b6e.2
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2024 10:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1730568341; x=1731173141;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GAtHiDGXjGao+0b08gt/1V7bTutDyyRkGVEW6KE2NrE=;
 b=2/9hsghpK1TT01PM+E5EzhBEZO0GQzADwoL3kDnce5WxAUreMkIoOjBHMTH3CCRDvy
 4pzctPVoTfzGBMSWenQxzKUUoxqsXtQd6/WarXKtZkr+1WvY0rbLtIPSgufkmCxyyJuw
 cpX5FAcol5gBuAv2+EY9elmKJ0ws1Cknz1cG5zYLSVg2JKULsNFgGda8brz4TyFmJAm3
 A6Cw/lbyBdiCHu8t0F6y0b21SFvYeMF8uLcZNxh21RomSOBbUFHgzbFCQTkDuMrRpkdW
 TWn9lIBm9V1+w6vsikQEgFMnfHlIEzP0I9HbAp1SmJdiqYLEzTS+Jt05W3NNVc0+ubng
 tQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730568341; x=1731173141;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GAtHiDGXjGao+0b08gt/1V7bTutDyyRkGVEW6KE2NrE=;
 b=sRa2P4YJ6sUNPrMyxErXsLXEpp7yYxNhk2r2VH6TCXgP24FT7MBCnKg6G1uhqvRZYA
 TbB0EeEz8cR1h6u9kuTFNloYoTrFecrPLG6qUCz8YkMXimWBLP4/15Qgpkarl5DkqBUf
 I8qO2U4VLN30IuAKGhnecKK8eGtcIn6k6W3D2AyOk+xaaE5KsbS40i7dmexrQBAPAkAL
 //Ppbetun3GdfCX1yp2LnRzX+u1YfII/3UR8J63zlxELTNaAA6CvuuuCZgEFTZqoue03
 3k/U3eEYhNu3p+hiodOCwTyHdasCyNNYNDX1bAut1oU/dm4MF8GaSH0TFPSWh/vFZz/L
 a/Yw==
X-Gm-Message-State: AOJu0Yy/CkMFsEgIKBPd3PNQiXXHO3QVgs+aR/ycOAIPnaFWwED4dRkF
 TvMCBMJ7pbSZ0GcPhfddxrIBgySnzFkq4EihvYY8XqcOxvX8K9paIblD8FDJewA=
X-Google-Smtp-Source: AGHT+IFdxfkdhTviBaS444I8/TuUk57n+/AkZorQDiRrOITqtKYfx5/vfdv+Q+kKqC8/K0gRyTbo5g==
X-Received: by 2002:a05:6808:de7:b0:3e7:60b9:d62b with SMTP id
 5614622812f47-3e760b9da08mr3065535b6e.43.1730568340829; 
 Sat, 02 Nov 2024 10:25:40 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:fa3e:9c23:b11b:a3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e6612595d9sm1295311b6e.51.2024.11.02.10.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 10:25:39 -0700 (PDT)
Date: Sat, 2 Nov 2024 12:25:33 -0500
From: Corey Minyard <corey@minyard.net>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH v3 11/26] hw/i2c/mpc_i2c: Convert DPRINTF to trace events
 for register access
Message-ID: <ZyZgjZMmqy2WHqip@mail.minyard.net>
References: <20241102131715.548849-1-shentey@gmail.com>
 <20241102131715.548849-12-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241102131715.548849-12-shentey@gmail.com>
Received-SPF: none client-ip=2607:f8b0:4864:20::229;
 envelope-from=corey@minyard.net; helo=mail-oi1-x229.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: corey@minyard.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Nov 02, 2024 at 02:17:00PM +0100, Bernhard Beschow wrote:
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Signed-off-by: Corey Minyard <cminyard@mvista.com>

> ---
>  hw/i2c/mpc_i2c.c    | 9 +++++----
>  hw/i2c/trace-events | 5 +++++
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
> index 2467d1a9aa..3d79c15653 100644
> --- a/hw/i2c/mpc_i2c.c
> +++ b/hw/i2c/mpc_i2c.c
> @@ -24,6 +24,7 @@
>  #include "hw/sysbus.h"
>  #include "migration/vmstate.h"
>  #include "qom/object.h"
> +#include "trace.h"
>  
>  /* #define DEBUG_I2C */
>  
> @@ -224,8 +225,8 @@ static uint64_t mpc_i2c_read(void *opaque, hwaddr addr, unsigned size)
>          break;
>      }
>  
> -    DPRINTF("%s: addr " HWADDR_FMT_plx " %02" PRIx32 "\n", __func__,
> -                                         addr, value);
> +    trace_mpc_i2c_read(addr, value);
> +
>      return (uint64_t)value;
>  }
>  
> @@ -234,8 +235,8 @@ static void mpc_i2c_write(void *opaque, hwaddr addr,
>  {
>      MPCI2CState *s = opaque;
>  
> -    DPRINTF("%s: addr " HWADDR_FMT_plx " val %08" PRIx64 "\n", __func__,
> -                                             addr, value);
> +    trace_mpc_i2c_write(addr, value);
> +
>      switch (addr) {
>      case MPC_I2C_ADR:
>          s->adr = value & CADR_MASK;
> diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
> index 6900e06eda..f708a7ace1 100644
> --- a/hw/i2c/trace-events
> +++ b/hw/i2c/trace-events
> @@ -35,6 +35,11 @@ aspeed_i2c_bus_write(uint32_t busid, uint64_t offset, unsigned size, uint64_t va
>  aspeed_i2c_bus_send(const char *mode, int i, int count, uint8_t byte) "%s send %d/%d 0x%02x"
>  aspeed_i2c_bus_recv(const char *mode, int i, int count, uint8_t byte) "%s recv %d/%d 0x%02x"
>  
> +# mpc_i2c.c
> +
> +mpc_i2c_read(uint64_t addr, uint32_t value) "[0x%" PRIx64 "] -> 0x%02" PRIx32
> +mpc_i2c_write(uint64_t addr, uint32_t value) "[0x%" PRIx64 "] <- 0x%02" PRIx32
> +
>  # npcm7xx_smbus.c
>  
>  npcm7xx_smbus_read(const char *id, uint64_t offset, uint64_t value, unsigned size) "%s offset: 0x%04" PRIx64 " value: 0x%02" PRIx64 " size: %u"
> -- 
> 2.47.0
> 
> 

