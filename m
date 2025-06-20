Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7D9C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSf7N-0006Kd-Pf; Fri, 20 Jun 2025 13:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uSf7E-0006GA-2Z
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:01:25 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uSf7A-0002hx-PT
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:01:22 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-70b4e497d96so20378607b3.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750438879; x=1751043679; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ggFAI3KcmE6aq1u+WOExbZQrZBQ2mNBQxUlBcv9HYKc=;
 b=I+2REOXUXYVPqzTvXcp+/BHsq0BfQW3rojAbAgk7QGYPvizVgSecGDeO+/Nm/5qWn4
 OX8XkGMLD5sbWPDpdGFIiiSCwY7dkX1owPr+c+to7XWAQsP2hMGF7imO/xGF194GJ33N
 HEbh1o0YtSPI7BOempLngnW6Q+d0QtxBMk0bNrUcrN2IIOvPaKVUgj1Wh3CFiyGmX+Xz
 1pU6lq7Y8hYdJenbMwBivg2t5FkEE3aPLu3JuWQ2q3S5J48ed0gd8v8fkFJSFLIBS29O
 dBI/l0Iv56jU9xFJzINcOYHRSWPuUoP6LOayE06eYcru0IewBfdrALVhZpKGDn/eW06J
 1Qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750438879; x=1751043679;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ggFAI3KcmE6aq1u+WOExbZQrZBQ2mNBQxUlBcv9HYKc=;
 b=sjbSVbedU1VjBYkeugrP8WZG0whw2oEzmrI1+10vA1o9CEbU0tteoN/SYoyWnCdq5S
 dy96Ug6Qr3wRwkgYphQ3CPRisrMEdMrtSqebG2Xqw4pULVTu140jP4MwK+3GnWQdVwrD
 B++4jW5aiNAgjUcOc98KF4oHpthjkPp8Did+tIVO6fQZT65GwLO21DvrtkDcC6sNcp4A
 eDleX6kfdfzFefmWBSnI8eERD3wg0vR8eTPj6olEZ64fDKcpiuvbdR4wpNl8svWj0GEa
 4LcbmLaYBdGR8tVBPGBAfwj5ZmlL0NKW+6HdtntZjqPkxvwy0Fm8zWfzvH2lZzAL8ZuB
 GYmQ==
X-Gm-Message-State: AOJu0YzxT5HdiudkPDs6hJRoZt88nz4M7tesyJ3ISLBkwqrSzhPMtmrh
 3Zs60d6Dl6N2Q4zAk0+uePH8rJM0R4cZ0TPU3/BUpyW/c7dFv322HP8VeLLUkiiVXSx9XWWvQrP
 YYSxDus5p67+Q2ChbHEF2irLIOWogvizdsICVFcxD8g==
X-Gm-Gg: ASbGnctCAc4A47TvJJhpjR6PkQORiOeG3IHKVs0JOOLyl3s180j9Zvg264z0GNrmwAk
 8v83yGJOCdowzokLxjFfG/yZmCKapncbLsJ1YFbCN7hgjFvSZgL7F13VdgkQ3Ol1kw/N2eqe5H9
 89jP+IRiSGyqKnIIg2+as0u7i3KcUQZB5DXOlKq4Ih3PXJ
X-Google-Smtp-Source: AGHT+IHuhUm4oLg+r/iMHiuLHFvTSArZerK7EvP+13l9eorbq+jsY2V84qR2h+MSJJPoshSEsB3LmLiWFO3on3tKaSE=
X-Received: by 2002:a05:690c:a0a8:10b0:70d:f47a:7e21 with SMTP id
 00721157ae682-712c6311a2emr39535767b3.1.1750438879330; Fri, 20 Jun 2025
 10:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250620151418.1166195-1-imammedo@redhat.com>
 <20250620151418.1166195-4-imammedo@redhat.com>
In-Reply-To: <20250620151418.1166195-4-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jun 2025 18:01:08 +0100
X-Gm-Features: AX0GCFsBIAxCW3ZGtkQwIfjLLJ_QjHPxGtDPOrvGQ1APLrNWNYFUADFIjNxCz1c
Message-ID: <CAFEAcA-=oPi3PGzES3f5xAtFmTrwFhRCrHLPkJ6Q_tFBkcFcZw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mark HPET as unlocked
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, mst@redhat.com, 
 anisinha@redhat.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com, 
 pbonzini@redhat.com, peterx@redhat.com, david@redhat.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Fri, 20 Jun 2025 at 16:15, Igor Mammedov <imammedo@redhat.com> wrote:
>
> Reading QEMU_CLOCK_VIRTUAL is thread-safe.
>
> with CLI
>  -M q35,hpet=on -cpu host -enable-kvm -smp 240,sockets=4
> patch makes WS2025 guest, that was able to boot in 4/2min, to boot in 2/1min.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/timer/hpet.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index 0fd1337a15..1ebd715529 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -681,6 +681,8 @@ static void hpet_init(Object *obj)
>
>      /* HPET Area */
>      memory_region_init_io(&s->iomem, obj, &hpet_ram_ops, s, "hpet", HPET_LEN);
> +    memory_region_enable_lockless_ro_io(&s->iomem);
> +    s->iomem.disable_reentrancy_guard = true;
>      sysbus_init_mmio(sbd, &s->iomem);

Is this sequence possible?


thread A
   takes the BQL
   enters hpet_ram_write() for HPET_CFG to set ENABLE
   executes s->config = new_val (setting the ENABLE bit in it)
   context switch before it gets to the point of setting
     s->hpet_offset

thread B
   enters hpet_ram_read() for HPET_COUNTER (which it can now
    do because it doesn't need the BQL)
   hpet_enabled() returns true (it tests s->config)
   calls hpet_get_ticks which adds hpet_offset to the clock,
     but hpet_offset has not been correctly set by A yet

thanks
-- PMM

