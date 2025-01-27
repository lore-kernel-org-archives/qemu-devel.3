Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF38C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 13:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcPTN-0005OO-JG; Mon, 27 Jan 2025 08:48:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcPTD-0005JW-Sn
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:48:09 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcPTC-0006b9-0J
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:48:07 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e479e529ebcso5671839276.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 05:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737985684; x=1738590484; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pGSZQYIIEv1Hss+sXLGwkTIIM85rE82n5uM1Hs3Gbcw=;
 b=PLpk+SVu+t0J6S273xQGH4uo5KYBnVLQBhqG4LXn7x514oIL7J5T3sRfVyQaICy8dv
 Hr9i6y+1MZ28npR5hpBohq2xadkWll3U+Dpwytzf3FgQMnwklkiBm807KC3tqOvfVU/J
 lhgGnimD2h79zVJZdoOaTDM0mz/2++ul7pkBXQzDq+3RgUM4++V+B1z4+wHl6QDC/i7z
 W51xrXMv/FOnuKMAhWrD3zHttC3I7GBTDM7nznaDlbqL7ZQvI+HTY0QQ1pvDWRT9Jdmo
 NejUg/WYgCk9D6yMgppsV36/GntbFslGy0nVvQTT8FfKgHF+ar3FMJegbfP/2QVkGsyH
 WdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737985684; x=1738590484;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pGSZQYIIEv1Hss+sXLGwkTIIM85rE82n5uM1Hs3Gbcw=;
 b=RTl9F36BWUley453sCzw929/7DL2D9OMhQSJvkmk6dKkjofiNLRoZUsCBcLFRVpjj+
 UZBQ+X5+xwXkxCPwAWxdO0RIbXF8+FbYnWjgjNGwqd4tXcCbq19tZneDn5xKFiT+ZzvT
 b9nwY3C5nrnHPsX4FZ0GYRDINfed2arJTHtXD9Qke+yFgxTBeSjkMoUyJbQt8GKiATa2
 /6UpQokYygKw4+bItP2Tk1EJVBxp7dFtuCjZztgz5iB5WQikUHTObSIxK8hVnja6sG2f
 S/H1fO1elIASELipyGle+of4U+RnAv2eH8TJ1P+hiIrIGSARThHj5pUXbn2BBkc0Wuap
 sfOA==
X-Gm-Message-State: AOJu0YzEBG+iD5MH5AXSpHANVDeUrJ7KO5Mx5wxUjzEusmJnDdabdmD/
 /8RyQMkQVOjQeHTYNq17h8Y9ecwZkdeuLTAUBAlWWne4xyRwJ2poLT6W+OhZ8NXpOR76SK6IEUz
 rxB5fjP/yK5Ve0l4N1tcebESWzqS+UHiYg8aBwg==
X-Gm-Gg: ASbGncv4BLOHI3S8c7DvwCYNBu2Nmu4VU2bHljrUEhwF58LQ+NjX/VrsqMi8Dgor/4w
 1aR7qFYQ5lqAwZ6jXy5QHgQNeD1SHVuRIpi0Gd65mzoz2UzDAAiLhhMX6gFwlw6U=
X-Google-Smtp-Source: AGHT+IEG0/7caeupgK24fCSJxka47/Y6yRPeFpGn1snOFVr2DF4Vg+lGVnHtvNCoddOj9ChMKsjBF/tqvzojZF/rV3w=
X-Received: by 2002:a05:6902:110d:b0:e57:99a0:eda6 with SMTP id
 3f1490d57ef6-e57b1096d49mr29452638276.25.1737985684003; Mon, 27 Jan 2025
 05:48:04 -0800 (PST)
MIME-Version: 1.0
References: <20250111183711.2338-1-shentey@gmail.com>
 <20250111183711.2338-6-shentey@gmail.com>
In-Reply-To: <20250111183711.2338-6-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2025 13:47:52 +0000
X-Gm-Features: AWEUYZm36kueC-tntTARxaKKD0Hfk85dhYcun4STmvqmv4sgZEWM-oBPf-kwiI0
Message-ID: <CAFEAcA8tcK4u1sRwO=ed39jt5+imQoOK+fp-w-ku2cSNTdc7HQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] hw/gpio/imx_gpio: Don't clear input GPIO values
 upon reset
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, Guenter Roeck <linux@roeck-us.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>, 
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Sat, 11 Jan 2025 at 18:37, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Input GPIO values such as a present SD card may get notified before the GPIO
> controller itself gets reset. Claring the input values thus loses data. Assuming
> that input GPIO events are only fired when the state changes, the input values
> shouldn't be reset.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/gpio/imx_gpio.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/gpio/imx_gpio.c b/hw/gpio/imx_gpio.c
> index 898f80f8c8..67c47a7280 100644
> --- a/hw/gpio/imx_gpio.c
> +++ b/hw/gpio/imx_gpio.c
> @@ -302,7 +302,6 @@ static void imx_gpio_reset(DeviceState *dev)
>
>      s->dr       = 0;
>      s->gdir     = 0;
> -    s->psr      = 0;
>      s->icr      = 0;
>      s->imr      = 0;
>      s->isr      = 0;

I guess so; we really don't do a good job of consistency about
how to handle GPIO lines that might be high on reset.

The other approach to this would be:
 * devices on both ends implement three-phase reset
 * device that has the GPIO line high on reset should ensure
   it does the qemu_set_irq() for that in the reset "exit" phase
 * device on the input end should:
   - clear the input-data state to 0 in the "hold" phase
   - ensure that its qemu_irq callback function does the
     right thing if it's called during an "exit" phase
     (probably needs no code changes)

That is more "what my mental model of the right thing is"
rather than something we actually do in many (any?) devices
today, though.

thanks
-- PMM

