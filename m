Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31587C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 17:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXkDP-0004ag-83; Fri, 04 Jul 2025 13:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXkDM-0004Zl-Q3
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 13:28:44 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXkDL-00067k-10
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 13:28:44 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e731a56e111so989905276.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 10:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751650122; x=1752254922; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9KCN9mYaUWXyO4j8AMRdwOZNpBoYuHmpDR2+2xoPko4=;
 b=kjY4Hq5nGthuwB9+iz9NeOFcz5CsBw0ckoJ40UOj65N88vhKinOz4Nxn30CpwZWJpA
 dNWsMgh6X3QDgQZfCVZ1rSCUP7xFzhf1+vMw6OVCYtQR0z2/INBlYplX7UB/vf07Fc08
 lh7vyBcAs9IGW0+/YwXfytmmFLlEQKLo53fgvZDxUiNtmOtm5rAYFvAHthMDYtNGNxJ4
 27b9TllqlGWYlz4pAq9yzQ8tQsF7SF+nM2Z6TsHtRtWe5LzUXrryeZClGADlexFLEOQt
 DC5trmhpnhSPHMZuYCUQDVcctDl28DEroKMgHVS0JSel+AF7H+fmAtef3E5XcrpSEpjQ
 xkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751650122; x=1752254922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9KCN9mYaUWXyO4j8AMRdwOZNpBoYuHmpDR2+2xoPko4=;
 b=iSsXljKJLoqiSrd3Cgvvtbmpe1Z1jaOBo8PBK4bAhQ4QeFrYW3C54C9qvkKVBip1Q2
 OuG7w+iPqaWbeJu6uPm8XCDQy+2jAyPEqf1N1262aQBSDcwT4ESiYYqunQ91AlajF/nT
 lq+depjFR9e+1r8OXi7WlH0WECvJ0khgGr6lN+F4XzcF/cZR04a8gUtqfblrMuUkZGHb
 X63ehW0uQu7EESXGIuhL1zhshqx9x11gil2/1fb4mLBMnLC2EpytUl/y9iyK5UuqJ94V
 rd8gwS7NTiczHUZ7REeLqkW+iujwIw7AtqU4kL4yBWkqLbX38bdK6skxw5cJvAI+a6Ml
 vkyg==
X-Gm-Message-State: AOJu0YyOOmDhzyjIr6F7IDBME2VB49GL10ESqirEKqkCnZ05tPmAc88f
 YpY4GDGjoTUV/1bhAPqpoy8vGIdvJ1h8xZusEguHEseujD+jhRDNi29pmtAOHuZ1NRA/2Ih2yrV
 K3JgnOlkNArlz0KKMUQCkFsQjHUD2j05eZC5JEpTqu5fP9vv/F8RI
X-Gm-Gg: ASbGncs1kjUX+onEtKprU0qrp5dsZf4FjZ3Lxgg+91Iz9uWIPYG7wz4NA2T+O+gwcRc
 475XC+BXzmV1Oq5evZvi+OJCB+IoJK0a3/0xqjfpx3UQiq0DI2bVx5vo/T5DfCkmP2syXMPXeqe
 KW0mlDrlYNW/K2CbiKBe/Cl38ClHlxfQVmSoLYioQSkLMn
X-Google-Smtp-Source: AGHT+IFQTmng8owKrPdXh1dnOIXzXz9tgfRJ0z7QedtlmFz/t1DDsKmQuY7Ju83fVqRIODXvFShgdf7fKEM1NovmIuY=
X-Received: by 2002:a05:6902:110a:b0:e81:52ff:b40 with SMTP id
 3f1490d57ef6-e89a0c1f5eamr3127635276.20.1751650121727; Fri, 04 Jul 2025
 10:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250704165729.208381-1-jcksn@duck.com>
 <20250704165729.208381-10-jcksn@duck.com>
In-Reply-To: <20250704165729.208381-10-jcksn@duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 18:28:29 +0100
X-Gm-Features: Ac12FXzm31NI7VlPP3f2T_q2tX1iw-6RKhT6tbaYp6_LIe6di2YnSBWgt3wdse4
Message-ID: <CAFEAcA94PWJDgd=8cwmiKOOPGfqmyOqzzV73hzXjzH3xdha7_w@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] MAX78000: Add TRNG to SOC
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 4 Jul 2025 at 17:57, Jackson Donaldson <jackson88044@gmail.com> wrote:
>
> This commit adds TRNG to max78000_soc
>
> Signed-off-by: Jackson Donaldson
> ---
>  hw/arm/max78000_soc.c         | 12 +++++++++++-
>  include/hw/arm/max78000_soc.h |  2 ++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
> index eddd9616f0..074fb1da8b 100644
> --- a/hw/arm/max78000_soc.c
> +++ b/hw/arm/max78000_soc.c
> @@ -43,6 +43,8 @@ static void max78000_soc_initfn(Object *obj)
>                                  TYPE_MAX78000_UART);
>      }
>
> +    object_initialize_child(obj, "trng", &s->trng, TYPE_MAX78000_TRNG);
> +
>      s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
>  }
>
> @@ -51,6 +53,7 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
>      MAX78000State *s = MAX78000_SOC(dev_soc);
>      MemoryRegion *system_memory = get_system_memory();
>      DeviceState *dev, *gcrdev, *armv7m;
> +    g_autofree char *trng_link = NULL;
>      SysBusDevice *busdev;
>      Error *err = NULL;
>      int i;
> @@ -126,6 +129,14 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
>                                                         max78000_uart_irq[i]));
>      }
>
> +    dev = DEVICE(&s->trng);
> +    sysbus_realize(SYS_BUS_DEVICE(dev), errp);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x4004d000);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(armv7m, 4));
> +
> +    trng_link = g_strdup("trng");
> +    object_property_set_link(OBJECT(gcrdev), trng_link, OBJECT(dev), &err);

This string is constant, so you can just pass it in:
   object_property_set_link(OBJECT(gcrdev), "trng", ...)
rather than having a local variable and allocating memory.

> +
>      dev = DEVICE(&s->gcr);
>      sysbus_realize(SYS_BUS_DEVICE(dev), errp);
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x40000000);

thanks
-- PMM

