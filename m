Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5F9C369C2
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Apr 2025 16:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6Xjf-0001uM-Oc; Sun, 20 Apr 2025 12:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1u6Xjd-0001tz-5w; Sun, 20 Apr 2025 12:41:37 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1u6Xjb-0003lw-Ei; Sun, 20 Apr 2025 12:41:36 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso27341185e9.2; 
 Sun, 20 Apr 2025 09:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745167293; x=1745772093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oQj5HjpcJ6IzdE7RabUVtlOGf7vSB/W87Z0qo4NpnGU=;
 b=XbbpblwIOi9hVU7cOMyMKSszlnv8/dkw1uHQDZ4qluYEtPvKXNpZnpAej3yELD6Vl3
 cENJb6kpAHxDT+aUwTYJIVYU8rshRpIXpR8uIIrlvzlbiw4b4NnJZ0Q4AzQYG2TYRLgR
 DmquD2naX2R2xnHueL3TOmqM+s2mhIQTjeHvzFI48lUYuxl57P9xpew6cvI0mIi+33Zf
 DTDZsLpJazBlxsA+/N5l+p2MgL18bEmkfQxEOrr3RRG4AmxdhmsDSOk4ZUsH+p9TLsp8
 0aXw20JaGK51IAKJKW1raQ4lqrb3z06TIGXCB00gG+5r+Nv/lzPXqRzIgwOfHC+3222C
 5V3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745167293; x=1745772093;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oQj5HjpcJ6IzdE7RabUVtlOGf7vSB/W87Z0qo4NpnGU=;
 b=jOf9VjwnsWLgdab04v1rX7Nu9tPKHgqAJJowdnJtZ3tW+SXgSLiaqMoWesQ55HsPvN
 uz0txSHDReXukMThKDKlOovsPlVLIN2msNtEJUzk0MxrmoIdxG+78tc/V/0v5mJFNzbm
 8gYLPhMXqnkUrWN2EBIxvDp8zvVJlhwNtqvXMvKLrIu9uTUR6Vqjcl2KG41zeI0ks/+Y
 E6djAumzpLrkUz+G91dMJQhpZ2Aq8JnLQF1goONXq4ND2iI/XLNzDvqgMMzqf78qUTUJ
 kulLdTPGcFmBj18t47ZzREn8IsCyeN61BMoWT+Uip28YaaXTPB/5nhOekz3nbAlKob24
 Apsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeuYB7TuhbTvdC1UObxrOklea+1jgUq4H0P5UWCjw3FmYaDjJr7ONW4NeVIm2yKg6mbAd9UB4HCAM=@nongnu.org,
 AJvYcCUhDVEVX5Jx1DwJC97eY0N72YfMBNm/1ckLy2dLXa8qZRdGD8a8nARVRC+CNv3i5LFkPptoveltSv9i@nongnu.org,
 AJvYcCXmbd/kvMh55CPpQ52yKeLLDLt49RlEzQMaREpppIQZweQP7bJTC3XHsdB7KlQn/mcgEzEOMUqkInTwFg==@nongnu.org
X-Gm-Message-State: AOJu0YxHwhBg23x8OGk/i6xhIP3Ts/V4ndT+8Lj/v2pjKlBbAapucKRl
 cPzlIvpbBb2M/OZyOpAI9E2fzgSC/sG9T6MeA4Tmeqoa52L5gAHu
X-Gm-Gg: ASbGncvgZFr5fLTOT8kgYEMZfjiKbHw15Davy5GsmEH22OPXS8Mi8SkgnHqo9mi4OXV
 tHmVQrN+ezO/K3zPAnMq8BnpP6PlGe/KT5Td3CmgqC38MOZuAUaTLKD6Hxj78+I0PK/hCfJLFqK
 h072xh1MI6ELoBFZ6YtQOYrNJ2aR9wYHfCzp5kpfb7oJoM7LPux9axpKTS8fZ0qpoCAmVG5aCoc
 ElKvri+ii4qC8x+pj1pEqSxwEugdzHSb+YqjRnsEc361+CZ8xtMi2t+fc4Ool6UzwrPdDldWPYM
 K03eeWiJCJbE67fFxeVGm1SJOnOU5LNHDLmvNZ4rA1bJMs4rVnWgah4TqUUF8oaxPixcxPm+sri
 HyjJKj3wFC/y+20JOFv5tpZ7/
X-Google-Smtp-Source: AGHT+IGSMJInWGBopWW+4D4+ChqGf/KSW6qxRZ3fhd3t+adPTKMopRl+d7JpOsYifsQ0+AvRO0korw==
X-Received: by 2002:a05:600c:3d08:b0:43b:cc3c:60bc with SMTP id
 5b1f17b1804b1-4406aba7ecdmr98226025e9.15.1745167292383; 
 Sun, 20 Apr 2025 09:41:32 -0700 (PDT)
Received: from ?IPv6:::1?
 (p200300faaf05a000316ff64cee01ecde.dip0.t-ipconnect.de.
 [2003:fa:af05:a000:316f:f64c:ee01:ecde])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d6e0364sm101610945e9.38.2025.04.20.09.41.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Apr 2025 09:41:31 -0700 (PDT)
Date: Sun, 20 Apr 2025 11:45:59 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>, Thomas Huth <thuth@redhat.com>
CC: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH v6 3/3] hw/ppc/e500: Add Freescale eSDHC to e500plat
In-Reply-To: <d74736e8-6132-2b7e-0037-c1262ce8e388@eik.bme.hu>
References: <20221101222934.52444-1-philmd@linaro.org>
 <20221101222934.52444-4-philmd@linaro.org>
 <325d3f62-b94b-4391-bdf1-2063da5e3b99@redhat.com>
 <d74736e8-6132-2b7e-0037-c1262ce8e388@eik.bme.hu>
Message-ID: <18F96FA7-BD1F-406C-BFF0-D784D477F4CC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 17=2E April 2025 21:40:44 UTC schrieb BALATON Zoltan <balaton@eik=2Ebme=
=2Ehu>:
>On Thu, 17 Apr 2025, Thomas Huth wrote:
>> On 01/11/2022 23=2E29, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Adds missing functionality to e500plat machine which increases the
>>> chance of given "real" firmware images to access SD cards=2E
>>>=20
>>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>> Message-Id: <20221018210146=2E193159-8-shentey@gmail=2Ecom>
>>> [PMD: Simplify using create_unimplemented_device("esdhc")]
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>>> ---
>>=20
>> Hi!
>>=20
>> I recently noticed that the QEMU advent calendar 2018 day 19 image (htt=
ps://www=2Eqemu-advent-calendar=2Eorg/2018/download/day19=2Etar=2Exz) is fl=
ooding the console with "mmc0: Internal clock never stabilised" messages wh=
en it's started like this:
>>=20
>> /qemu-system-ppc64 -vga none -nographic -monitor none -M ppce500 -cpu e=
5500 -kernel =2E=2E/day19/uImage
>>=20
>> This was not the case when I assembled the image in 2018=2E I bisected =
the problem and apparently this patch here is causing the problem=2E Do you=
 know whether there is a way to fix this again?
>
>That patch added the MMC/SD controller so no wonder it did not appear bef=
ore=2E The error seems to be in Linux esdhci driver where it checks for:
>
>sdhci_readl(host, ESDHC_PRSSTAT) & ESDHC_CLOCK_STABLE
>
>So I think that bit should be set somewhere=2E Berhard had some patches f=
or e500 so maybe there's already a fix for this somewhere=2E

This logic is already implemented in the USDHC device model=2E Given that =
the e500 and the i=2Emx machines need the same modifications to make u-boot=
 work, and given that the imx25 machine also uses the USDHC model even thou=
gh the original has an ESDHC, the USDHC might be a better fit here=2E AFAIC=
S only the interrupt bits specific to the ESDHC need special treatment here=
 -- which could be achieved e=2Eg=2E by subclassing=2E

I could send a patch for that=2E Volunteers ahead for a timely solution=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan

