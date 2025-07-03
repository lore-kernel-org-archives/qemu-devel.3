Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C862C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXMY2-0000kA-QL; Thu, 03 Jul 2025 12:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXMXq-0000iO-BY
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:12:20 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXMXl-0008Ua-Ay
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:12:16 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-70e1d8c2dc2so58617367b3.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 09:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751559131; x=1752163931; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eLD5rCZZtRsFRqmF/RTaXlqSjNHcC2laWs33UCZ4iC0=;
 b=lDo3p0dS0ppiHAPnrBMlMrM712bEAEg8ID4LNQ0qFO+BO9ONDARakOosYL1ARV/g1V
 p9s/QGBAP/w1IeY/AvSEcKXtbicbEh69eNlgEaWeKCV1xeYVWo1kBrecc5YCwgmeqLiB
 HtcBAB9F3GGXL0FclUQHrkJWz6v1Ih8EC43IQng0jIgwc874Xhz2zpwQ2sADpYSy3Yva
 PYgzURijiUBS9/mjn4CWCx5KqfO2ORs0tRWEbN2ogP7M/vWlXPI+2tj3Q/h2c9RHmuf8
 z38JllphY0XXWOLQS98HrXZN38LYFGlK8p0PUZooaPQucF9sLazTCIaxRPtWndWvjEzU
 LS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751559131; x=1752163931;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eLD5rCZZtRsFRqmF/RTaXlqSjNHcC2laWs33UCZ4iC0=;
 b=aeViCluu06uWTWVw9hQrS50g4yFoJc7VXbpLXkJxE5ZNXBPhZRqoUHpUAX4q4O499v
 LM961g4BexMApPPIBBnFyXpQJdVTmKLydfmEwP+RkMInyWA9X2v9OEfJu7jJxbuHg+jc
 ckvml+jInzPvKrL6NgXc9BjOtyVhm85NyTvw5fqdx4Mhw59VBn1BBnC/NU2kgFrDxQmS
 WsIb88SvNfVkASvyY5yYNDv+uDdO2blp6jyS+6ilTcUF0089q4d9MMJCErlK1X/7pxPh
 EXhZckfdQRRnpcb63+8J6FS3ilZdNRC/1xgbbDAMuiXqVYfH7mZFc2G+sM8g9GkS4NU/
 xUbw==
X-Gm-Message-State: AOJu0YwUUv/ZM9MsSBRH/hV1SVk0xuJRX+Gxsq6aHIZM86RQKU0KFscN
 L8lHKQZdIOtEM4pRYaLi+U7vMEvaxs4XwT3gkzA17DoV8tVteGv1oHky1lpaVWxFifwSPjM184a
 vDD2fngSclW2oZShyrYXhPtkJS+yrhDeeyxCeVVWe9g==
X-Gm-Gg: ASbGncsrRpFx1mIEIxWiakd/ZT6PDIy3Y2hg54EOnt39OLF+w4/DKkLZybMaJddn5yZ
 6UBsrnvxiPCiU9tbfK2J8VTtu8QacdZP828O4GYmm3+s/T7S/jlADxPZvhx/zwilQc/aLxi8HpN
 MUf9kzyZZmY7IkPApAezeliaW5Ij2oYT0ByAR10HbvMHHN
X-Google-Smtp-Source: AGHT+IFor6IQDlgMt6U8NlYX9xjCOwJLtqduwa8+oXrTDk9NpjtQPBw+37gvS6Xt24UxtcWXefZzoiZTKeZnznCnjWI=
X-Received: by 2002:a05:690c:dc5:b0:713:ff70:8588 with SMTP id
 00721157ae682-7164d4b9a8fmr104200267b3.36.1751559130757; Thu, 03 Jul 2025
 09:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250618230549.3351152-1-jcksn@duck.com>
 <20250618230549.3351152-4-jcksn@duck.com>
In-Reply-To: <20250618230549.3351152-4-jcksn@duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 17:11:59 +0100
X-Gm-Features: Ac12FXzdr4wIP82uEOAjEopzJrMCM9eC6FrNGj5QeGvhKtjGl0JBLcRA6gPdjjo
Message-ID: <CAFEAcA_K6nWFkkfTuD9QJyr2gUDeiGF-b==oo5wHMVOTB5Jnzw@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] MAX78000: Add ICC to SOC
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Thu, 19 Jun 2025 at 00:06, Jackson Donaldson <jackson88044@gmail.com> wrote:
>
> This commit adds the instruction cache controller
> to max78000_soc
>
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>
> ---
>  hw/arm/max78000_soc.c         | 19 +++++++++++++++----
>  include/hw/arm/max78000_soc.h |  6 ++++++
>  2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
> index 9676ada6a2..8d8d2dce61 100644
> --- a/hw/arm/max78000_soc.c
> +++ b/hw/arm/max78000_soc.c
> @@ -17,12 +17,19 @@
>  #include "hw/qdev-clock.h"
>  #include "hw/misc/unimp.h"
>
> +static const uint32_t max78000_icc_addr[] = {0x4002a000, 0x4002a800};
> +
>  static void max78000_soc_initfn(Object *obj)
>  {
>      MAX78000State *s = MAX78000_SOC(obj);
> +    int i;
>
>      object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
>
> +    for (i = 0; i < MAX78000_NUM_ICC; i++) {
> +        object_initialize_child(obj, "icc[*]", &s->icc[i], TYPE_MAX78000_ICC);

You should give each child a unique name:

           g_autofree char *name = g_strdup_printf("icc%d", i);
           object_initialize_child(obj, name, ...);


> +    }
> +
>      s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
>  }

Otherwise this looks good.

-- PMM

