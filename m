Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821FBCCD184
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 02:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8r8F-0003Mg-3f; Tue, 14 Oct 2025 22:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8r8B-0003MI-Ha
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 22:20:47 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8r83-0003LB-Uu
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 22:20:47 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-62fca01f0d9so12284669a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 19:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760494836; x=1761099636; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AMb51Wr2DZY/rVJCxhqogBRYio86jS8/Gojx8HlDlo0=;
 b=lxRjASPWuIVqHtJAq6WJDBiXF94+oeHWQQ1Z7wjF1lZkvTutlhkFhCBmOOywLDFIVc
 yfLrAaBj+RThX42Rtc1IoAc1UR8aXDmJVzd68XW/U44XgkmFtBlpj/e9LR6vSlbZFmDm
 itblx/xZBVWSVsV73ri8lG6fazpBu0OgO2fiDP1Auhxb3KLaDhPT9ii05PNE++non75d
 L/MOxY13mHcxQnNRQQlnkC79bbcDhy7KhfghOGHNbP1n+PLCgCfwGXm8pb033f2MM22t
 GxkNRR2e1NCYSq2U76uPgAm2rX1KhjBYFeebk37U2T7eZ3w8/uW07pgRAt7dBJawdBdN
 dZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760494836; x=1761099636;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AMb51Wr2DZY/rVJCxhqogBRYio86jS8/Gojx8HlDlo0=;
 b=N20cCcpcjx1IIZxz1mZpJ3MzVHDbVdJMV+QJvxuxPkYks3wroIshhiVqlJRtaBsEql
 Qi5p8En2U6su8f1lsEFEaADQyuNlmVVXp2brShgx4XBEfNm54DSyfokdudPq8qVx/YXU
 kQA/fzyzVeDt3V3VgbBtz0x5q6fgqJBxewTMADUh7e49koTp7uMy2Jel4ffsRdRil/oG
 ehVb4rhRitWsbQoP3xL+t4vj7tFL3CxG3+TJYJFIdrJeN5n/fftuP4n/b0rLaoS261OP
 BjqBDOHL8HI/O2NRyhAYHU+huoK/nj747ltUAZyHxIu6t5ypxGXoMDi9R+V/Rhh7ZttK
 bEnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV42cWwNEo+T+fTVYHF+SO9LcgGw/YwUIW3FQ/4m+Er0fMFmLaboynzcveb+vD8I2kQuPFrPOhy3VNC@nongnu.org
X-Gm-Message-State: AOJu0YzoPIb14fr+XrTkpe1CVB71WCSW4svY5OnWVP/vP0U07vwKRGCV
 FNeKL5M9IF3AEB4BqWYxzsnJqWQlKgKCYebIKmjbudUwrfeUmsjoWg9ka7g9s8g8HCGtKMslGte
 O/pFJwH+whZIP1OE3FoiKyQlL7LEgPW8=
X-Gm-Gg: ASbGncuU+vLiTeUAj3z6mRXBH+avpPYttDJDmHnvBBdipZNjxJnyHZUTXjDA5CKMu/9
 pVf0laJakwPi8QtnFObzA+vBY0Cy6AceRLUnNnLyQUxYYz8uLiBtomO0Kxh+voPXGEHd+xfSVCP
 bDV+qVrHPtX2JDRQTzVgbAgL073gEpKeBOAYUffNBDDxncW1XS4h268Ei3cVBOMDlrle4wlebh7
 /S0DtM3YY0vS617SjPsI4M8/+t9PH/u12YbwOJdws+jIOY3iSCsJct8tp249klahcEw2rsoC8vM
 Xw==
X-Google-Smtp-Source: AGHT+IGz2RKOMGOI7dax0JZxImXRMMaHnX2REmv0gNrPW+eLFD/tiCWHzMK00HMlxPWpVnz5Lhk+ns0FYUMGYkRcY8k=
X-Received: by 2002:a05:6402:50ce:b0:62f:50ff:b675 with SMTP id
 4fb4d7f45d1cf-639d5c74d05mr23793900a12.33.1760494835755; Tue, 14 Oct 2025
 19:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20251004200049.871646-1-linux@roeck-us.net>
 <20251004200049.871646-3-linux@roeck-us.net>
In-Reply-To: <20251004200049.871646-3-linux@roeck-us.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 15 Oct 2025 12:20:07 +1000
X-Gm-Features: AS18NWAwWGeei24tH5famsMohy6AKE_W5AYTGmevAG6BRkhHXmyea3hzgegwpEc
Message-ID: <CAKmqyKNrOSbxPotadvOcaNYnvEdZY75k0pkmO4Pv9gVsTxG4qg@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/riscv: microchip_pfsoc: Connect Ethernet PHY
 channels
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Sun, Oct 5, 2025 at 6:03=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/microchip_pfsoc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index ba1d090d9b..6e2a6e721b 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -414,6 +414,8 @@ static void microchip_pfsoc_soc_realize(DeviceState *=
dev, Error **errp)
>
>      object_property_set_int(OBJECT(&s->gem0), "revision", GEM_REVISION, =
errp);
>      object_property_set_int(OBJECT(&s->gem0), "phy-addr", 8, errp);
> +    object_property_set_bool(OBJECT(&s->gem0), "phy-connected", false, e=
rrp);
> +
>      sysbus_realize(SYS_BUS_DEVICE(&s->gem0), errp);
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem0), 0,
>                      memmap[MICROCHIP_PFSOC_GEM0].base);
> @@ -422,6 +424,8 @@ static void microchip_pfsoc_soc_realize(DeviceState *=
dev, Error **errp)
>
>      object_property_set_int(OBJECT(&s->gem1), "revision", GEM_REVISION, =
errp);
>      object_property_set_int(OBJECT(&s->gem1), "phy-addr", 9, errp);
> +    object_property_set_link(OBJECT(&s->gem1), "phy-consumer",
> +                             OBJECT(&s->gem0), errp);
>      sysbus_realize(SYS_BUS_DEVICE(&s->gem1), errp);
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem1), 0,
>                      memmap[MICROCHIP_PFSOC_GEM1].base);
> --
> 2.45.2
>
>

