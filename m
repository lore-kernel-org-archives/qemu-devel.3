Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E603BC531FA
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 05:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnrSM-0007JF-2t; Sun, 26 Jul 2026 01:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wnrSK-0007Ic-7y
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 01:31:20 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wnrSI-0006LH-IH
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 01:31:19 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ceeee8c46bso5541665ad.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 22:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785043877; x=1785648677; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Gh5SGwp3syKEsgHMMV7WvgBsAMLiuwFuownj8+ZpGMs=;
 b=MMyyZfySWRwkqA3E62/CGBuJLiYhChOJ4njKlQphhucO+gIRLXkl1TmqAOkF+os8fB
 eJiP94N6cTESEWTy8Z20WEVrXPdpc+Sy6x235AESA0qOmZmafDiUT+U29z7gZqP46nJz
 A0LhuUKslV1qdeqXMfvQzLn4ECOnAsKsfLSXhMfmB93s+O/UH6v2BW3KpSAIKe9uHh1M
 JigN2wzfgl2T0m3cgLENQ7J443qlG/JqBaOyQNpmik0k+hHlpCDuOyLfof5PtE/WSf3R
 /Qa0oNgfo+DLHIqLMMteTF+UTxB3zHOS+8rWJsV4zME3qMnJsIyQ1JB+2PIRe2zkPW5k
 sfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785043877; x=1785648677;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Gh5SGwp3syKEsgHMMV7WvgBsAMLiuwFuownj8+ZpGMs=;
 b=exx1qzy+R0UMOWSA5osNcSsJrv+r9VNvLaPIizZpRAHqbSpXDHaffPivh56zJVLjXl
 FmJgF2L2T+FvMSTAUA+ASV7ppNm5LnaLkc6pwEFHrvgervilxyUtP3GhnELM3bmOqet1
 FMNIcoPPpnvyVJQKXYkSYkgM8T6ZtoMaekVoCZo07nI4jFrN/rxH1HdrGqqq1FTNxoC6
 G4tA6S1HJXPYmEl6T9ewxf+H+EzWz+0XQWmZ0rxOjkUzBlqOnP/TVOGuqtlymB7tPm67
 wL+QBWGI0/kCFiapY0VIVieKx8n/FwYXgJWs8e3HrQpPWxFxptDLfV+2jIQk8ups9O+M
 3MzA==
X-Gm-Message-State: AOJu0Yz7JCYn1WCE+KKA/IYII66QtNGetxz2p6REG/VRJ+XEActEFyRO
 hvfbXQ9wnnEck7+CpFW1rWuiw9izKZS+l6mQt/sUqyFRxFwY9lchrEk1
X-Gm-Gg: AR+sD11rLlaRq4OMDk0FHst5uEAn0XJ4cC1hk8H0KEERDq5dP2RfaZ23IeF5gBxBlVC
 AhQ9K4HJXe/4m77EjZ84lQWMNwlnM/JL0FajMcsvXXDxrJiVu8JFmudju1R/ruNs5mhtqClcGEw
 XR+4iCKQFyWVhuDTtwE2wzTLtOkO7T7FWy+S5pGEAJDoi1dXJ3uhxN6BN4ys6QZECLtZUPOr4df
 UPbjWPIDNUQvm8UBoIRX8xClHy2AyGSOgIAimEH5O2SbQyHXo456HTr7FerZaSKBQ3gnTQIShFC
 e89bKsd4Ff0e3VZ5ym+ssy9jKSUqvc2LW12ezjwf0iniCvceKxuBNzZRqnkf2u7Uie4aMyBaqLy
 Yn6WjaWM0pRejA6V3mh9SSJGIxysmNwPWcMPcheyVSbBdJe/2fk2YzzfWEe1QD1oIXy+v5sFtRL
 /sJ8lcREShr+jEADyzNWSz
X-Received: by 2002:a17:90b:2f8c:b0:38e:c140:2a0b with SMTP id
 98e67ed59e1d1-38f29604998mr2953166a91.3.1785043876910; 
 Sat, 25 Jul 2026 22:31:16 -0700 (PDT)
Received: from DESKTOP-7HME356.localdomain ([38.34.7.236])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13015052sm38684005c88.5.2026.07.25.22.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 22:31:16 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/7] hw/riscv: k230: add gsdma in K230 board
From: Junze Cao <caojunze424@gmail.com>
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com
In-Reply-To: <20260721161335.73872-3-dingtao0430@163.com>
References: <20260721161335.73872-1-dingtao0430@163.com>
 <20260721161335.73872-3-dingtao0430@163.com>
Date: Sun, 26 Jul 2026 13:31:10 +0800
Message-Id: <178504387085.903859.4880530568877113564.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785043874; l=3633;
 i=caojunze424@gmail.com; s=junze-gmail; h=from:subject:message-id;
 bh=MKFm7KchDXG4VHHj+M9MgGc9OUP/OW9vgMs3SUORzsE=;
 b=YGW6yeyNPV/P8QgZnTgCWQMK6w20vA1Q/sGWwEtZoKXaGc3L1rjumyjw/5E9GgIIQE8F9nxck
 IWPvrHhz21XDOU3Hi1A7JdHq0ANheIXtax6n8Dy/7aNDy7rhDHrf4KF
X-Developer-Key: i=caojunze424@gmail.com; a=ed25519;
 pk=lnFIWNw+6CoDrHFIKUJKdgrRbvgAbQGcEFiVsIigOJ8=
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=caojunze424@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

# Add your code comments below. There is no need to trim or delete
# any existing content -- just insert your comments under the relevant
# lines of code. Lines starting with "> " are quoted diff context and
# lines starting with "| " are comments from other reviewers.
# The final email will be reformatted automatically to include only
# the sections that have your comments.
#
> This commit replaces the unimplemented part of GSDMA in K230. And connect the interrupt to plic.
> 
> Signed-off-by: Tao Ding <dingtao0430@163.com>
>
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index de37c08cae..d28ac06043 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -162,3 +162,4 @@ config K230
>      select SERIAL_MM
>      select UNIMP
>      select K230_WDT
> +    select K230_GSDMA
> diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
> index 656f28190c..c80bd65694 100644
> --- a/hw/riscv/k230.c
> +++ b/hw/riscv/k230.c
> @@ -110,6 +110,7 @@ static void k230_soc_init(Object *obj)
>      object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
>      object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
>      object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
> +    object_initialize_child(obj, "k230-gsdma", &s->gsdma, TYPE_K230_GSDMA);
>  
>      qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
>      qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
> @@ -206,6 +207,14 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[1]), 0,
>                         qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT1_IRQ));
>  
> +    /* Gsdma */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gsdma), errp)) {
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gsdma), 0, memmap[K230_DEV_GSDMA].base);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gsdma), 0,
> +                       qdev_get_gpio_in(DEVICE(s->c908_plic), K230_GSDMA_IRQ));
> +
>      /* unimplemented devices */
>      create_unimplemented_device("kpu.l2-cache",
>                                  memmap[K230_DEV_KPU_L2_CACHE].base,
> @@ -221,9 +230,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>                                  memmap[K230_DEV_AI_2D_ENGINE].base,
>                                  memmap[K230_DEV_AI_2D_ENGINE].size);
>  
> -    create_unimplemented_device("gsdma", memmap[K230_DEV_GSDMA].base,
> -                                memmap[K230_DEV_GSDMA].size);
> -
>      create_unimplemented_device("dma", memmap[K230_DEV_DMA].base,
>                                  memmap[K230_DEV_DMA].size);
>  
> diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
> index 592e1c26bf..156a386edc 100644
> --- a/include/hw/riscv/k230.h
> +++ b/include/hw/riscv/k230.h
> @@ -18,6 +18,7 @@
>  #include "hw/core/boards.h"
>  #include "hw/riscv/riscv_hart.h"
>  #include "hw/watchdog/k230_wdt.h"
> +#include "hw/dma/k230_gsdma.h"
>  
>  #define C908_CPU_HARTID   (0)
>  
> @@ -33,6 +34,7 @@ typedef struct K230SoCState {
>      RISCVHartArrayState c908_cpu; /* Small core */
>  
>      K230WdtState wdt[2];
> +    K230GSDMAState gsdma;
>      MemoryRegion sram;
>      MemoryRegion bootrom;
>  
> @@ -129,6 +131,7 @@ enum {
>      K230_UART4_IRQ  = 20,
>      K230_WDT0_IRQ   = 107,
>      K230_WDT1_IRQ   = 108,
> +    K230_GSDMA_IRQ  = 140,
>  };
>  
>  #define K230_UART_COUNT 5

Reviewed-by: Junze Cao <caojunze424@gmail.com>

-- 
Junze Cao <caojunze424@gmail.com>


