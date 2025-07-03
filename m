Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EA3C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXMf8-0004wo-Cz; Thu, 03 Jul 2025 12:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXMf6-0004we-Tf
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:19:48 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXMez-0004l5-NQ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:19:48 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e7387d4a336so7468411276.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 09:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751559580; x=1752164380; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CMI5RE+wJ2gOpmNxl7Uv7OdkZ9V4apFccHPKb73rYSA=;
 b=ntXbdodFCIHCCyejjoZWH19VIuJ33y36c0LHED9FQajmFtrMMMnr+/pCRfoNnbyHga
 4IAhypZtegWnFbYTjjjJjR6qP0feB1OagLB0Bys8Hq7dqZ5e6Qc/fSsmWo9hfqNykhQ0
 eTcgezOoQEb+nhrzSaC/FAmMd7nCcpIhvtnZDzEnIMt1Qz6XwoHhS5ZqccQdi4RxG/PZ
 O2OhlzChl4eh6vKxl8GlTMbvo818LGAZLXKLkxMoKEE71uKQnlOnmG3dd82hFBbctQqH
 LZH/f7BANNb+haXnHne8GWX5ETm8vkpkjRUH2dH2JzhZDNfTxKEFG9GuLXTPJNqMSwhF
 TmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751559580; x=1752164380;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CMI5RE+wJ2gOpmNxl7Uv7OdkZ9V4apFccHPKb73rYSA=;
 b=e2E2ed7PI40HTMeOsIShq9NCbHSWGKZiJT0D+lNKSXjCb7k3ksmMpNS/nP4R83XauF
 2R1j4Gup553TJbh/TIy+mXmuPVomEC7a8DtTgW2lc4gVsVqruseV46L1tb7vptLzefVc
 IMScaYphAgWGpdSpRX24Z9KO3j2FzEOvn7Tk2IgH2vSMolQcokdc133rw04iUO2EekxN
 185XMImgJcr+8wmn8tiNLLG6WukKN4YiQGkwRqFWo/8dWSLRav0rMDC7vF6PwBl4y4Ga
 tAq5ZlOZkbxihz7OkVBgTaoGMro2p6wg1Ao3wlCoNhhK4mlOjkxpCZZuXBgBKkX/XmSY
 YHXw==
X-Gm-Message-State: AOJu0YyuwkLpF+O+zT8U6wo+iKpf1McrUyfYcHKbMVA6o/42wCaOkz3V
 2uMzP1H5xtTDRKK/hctMEq3hu3wdiPlEh5VAg7LWi2CJvEHUKBy7mcBwjrikQMEp1ttDHkD4mwl
 v6cwK6BDKXkraYuVUkTRKzW2pUVJSNKSw8zjpm/X9x7dmhk2LwR8e
X-Gm-Gg: ASbGncsek9sae4kf8wZw5M2CeWM0vvxc1Zp8AAoXUD1gSZ9Xa9j0jgP8MyXu9RtQL2p
 Ujzz7KX6KZ9OlhwMrEJYskNmCH95loLPwjdJpKHcWW6tv0StObQKujLccOXPQZtvfvgEOFKU6tF
 /h4wKRYTWqewbuDL+8M4ONrpyQF4dwJpiFtC/NWukOcCzE
X-Google-Smtp-Source: AGHT+IHhEcrjDTYsNMPBs3rjbzG2BSBQp6yLQkwbk2WQ+VdXdwjegmG4qubZXkZcWr9mvTAyOpw7ZiiSQU3+V93y4yY=
X-Received: by 2002:a05:690c:7349:b0:70f:83af:7db1 with SMTP id
 00721157ae682-716590ae5demr64769787b3.19.1751559580069; Thu, 03 Jul 2025
 09:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250618230549.3351152-1-jcksn@duck.com>
 <20250618230549.3351152-8-jcksn@duck.com>
In-Reply-To: <20250618230549.3351152-8-jcksn@duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 17:19:28 +0100
X-Gm-Features: Ac12FXwcV90XLIITOQuKxQWfaBDyEAWEbRNej-BC9YO9CcoxuI5-MVj6heH8Hvs
Message-ID: <CAFEAcA9QsOz3oea2=MsfwTRJoSGfdRL-1n5RXgahw58LLon0=g@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] MAX78000: Add GCR to SOC
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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
> This commit adds the Global Control Register to
> max78000_soc
>
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>



> @@ -106,13 +115,21 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
>          }
>          dev->id = g_strdup_printf("uart%d", i);
>
> +        object_property_set_link(OBJECT(gcrdev), dev->id, OBJECT(dev),
> +                                 &err);

The second argument to object_property_set_link() is the name of
the link property. That might or might not happen to be the same
as the ID of the device you're connecting it to, but you shouldn't
be directly accessing DeviceState::id here. Just create the
string you need with g_strdup_printf() (and don't forget to use
g_autofree so it gets freed).

> +
>          busdev = SYS_BUS_DEVICE(dev);
>          sysbus_mmio_map(busdev, 0, max78000_uart_addr[i]);
>          sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m,
>                                                         max78000_uart_irq[i]));
>      }
>
> -    create_unimplemented_device("globalControl",        0x40000000, 0x400);
> +    dev = DEVICE(&s->gcr);
> +    sysbus_realize(SYS_BUS_DEVICE(dev), errp);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x40000000);

thanks
-- PMM

