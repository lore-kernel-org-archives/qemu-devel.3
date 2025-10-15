Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0393CCD184
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 02:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8rC0-00053m-HD; Tue, 14 Oct 2025 22:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8rBx-00052W-CP
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 22:24:41 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8rBi-0003tz-2S
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 22:24:39 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-634b774f135so9648013a12.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 19:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760495061; x=1761099861; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gp13dvcQhfwF/JKqdDmmqKB5Yail0lrxLkSvJtcQlUI=;
 b=IMMuAeFC/vd0XLoNyRvEVote0Myqz1toRsKmB3Kwl/NNxca0jOue/bOwOzVJUBLPUs
 gTp/0Qeit2wAx2qdDhoFhWoVhHhSvIUzh2d8YnxuHXKUCjw8ne6ABbkDUdBGG1XXrkCe
 P4Cr9TyrVUZzN+dwL3AMPhnP+hDPNqHHZMsbEqc2NcqGL6/kkCOsAKnuo/F9XtB1HEBU
 3NisEgEBFuQwXY1iVjyP12bjWxlohTkgvrwAsSdwy9pmonUXA8NECyLWT5x71ldcaT+M
 byFhQcuhB/XsNQRtHOamG5S7B2sX3PIxlF3Gwalkv3pdippyKrNujoYoHaJLwY3+Mx80
 qiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760495061; x=1761099861;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gp13dvcQhfwF/JKqdDmmqKB5Yail0lrxLkSvJtcQlUI=;
 b=rtuijOynvzK3Wnph9dQQhbYUiRz8FAcXV61AnMigLn+6inNQTume6dEz2RnzCq9uvi
 XkTBVxiu5kCqd8ABIExAQ7tSgJq3lHifFir39FDAcd1Lle0fEJdmKoNg+c+G18rVVPQI
 sxuMV2QRqiwbAbg7LRT3toQdAkYm2L7n16o0B/uFYa/yQjykUyq0mHFUSWVdDYL4OYCj
 VUXtNAlNwBwl1mI2SSuWyf9y7VgL3fl7yMIoOy4O7wKXJmTaG5MNkm9kZ7GwNiCNRai9
 hHTw+0qTAJuMFlHl6+lSP1Y/n2WHYqMgvLFmD133+54rkYrUr/N2Mn8MbAc3D4ImXEYm
 OUpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0FZuFa5P3uBP4YyHQ4aw86z/uGbIl7Hi1ClLkNSoUFY0fi8vVeciLO37GypPml9sTyYhSqPprfgsb@nongnu.org
X-Gm-Message-State: AOJu0YwwG090Bbsp+cuRnkvd4WVs+d/Ylx6vl8YeF9unx5kvIZJghABH
 Wbc1maDMAjRzI2aTnvdxr5ARcvgjlS+zUj3yyYm3p6Kh0tNkYMWu7ujOyI4x92rDjOCldrsvs9c
 V0E0XTrRbqv4bArruIvAk+fe8G/DKmGE=
X-Gm-Gg: ASbGncvp6WQAjslPIQgCcuC2LDEZ3TzRFM32KL36DlecnZsdkAONGWxb4a5WOsXI1Qt
 Rj9RRH2xFnlZhfhDn0wmDIMw/Hlmaw1vQJzsHzg+Mj6va8SFQWMwIEbhWZKGs1dkTQWn+wH7Zg1
 xM9G4geQO4Js7hUzOLlnBUlnJ5hdMtvag0w7Z1ywcytFgQb/z/p9F2MsKu6MDBi4qsEiA+pIMkn
 iwZezcJLIo88hKkbe2ZFGCdEwX+ZAVqxH4Cpa5TDgpORapOwVRmhC8iGAo9Pj9EXAg=
X-Google-Smtp-Source: AGHT+IEcQ2k4wDMQNmrj1s8e6x3fHLrMesMDJz/c3Vr2ndiT/3HBNjenrfvh83hHFWtIBXOxu4YhZjYG46svXs/bQhw=
X-Received: by 2002:a05:6402:358c:b0:639:e050:6794 with SMTP id
 4fb4d7f45d1cf-639e0506bd2mr20395065a12.11.1760495061212; Tue, 14 Oct 2025
 19:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <20251004200049.871646-1-linux@roeck-us.net>
 <20251004200049.871646-5-linux@roeck-us.net>
In-Reply-To: <20251004200049.871646-5-linux@roeck-us.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 15 Oct 2025 12:23:54 +1000
X-Gm-Features: AS18NWDIhFH0EEYwEg9W41_NTXJH8oVdsGtVc9ZrloYfaRmS2dY-y9U8YchcruA
Message-ID: <CAKmqyKOP8hThu-XZud87dnJaJtmenA-mcrWnAwEyWN_7BYBfmA@mail.gmail.com>
Subject: Re: [PATCH 4/4] microchip icicle: Enable PCS on Cadence Ethernet
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> PCS needs to be enabled for SGMII to be supported by the Linux kernel.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/microchip_pfsoc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 6e2a6e721b..5d3007e8d3 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -415,6 +415,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *=
dev, Error **errp)
>      object_property_set_int(OBJECT(&s->gem0), "revision", GEM_REVISION, =
errp);
>      object_property_set_int(OBJECT(&s->gem0), "phy-addr", 8, errp);
>      object_property_set_bool(OBJECT(&s->gem0), "phy-connected", false, e=
rrp);
> +    object_property_set_bool(OBJECT(&s->gem0), "pcs-enabled", true, errp=
);
>
>      sysbus_realize(SYS_BUS_DEVICE(&s->gem0), errp);
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem0), 0,
> @@ -426,6 +427,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *=
dev, Error **errp)
>      object_property_set_int(OBJECT(&s->gem1), "phy-addr", 9, errp);
>      object_property_set_link(OBJECT(&s->gem1), "phy-consumer",
>                               OBJECT(&s->gem0), errp);
> +    object_property_set_bool(OBJECT(&s->gem1), "pcs-enabled", true, errp=
);
>      sysbus_realize(SYS_BUS_DEVICE(&s->gem1), errp);
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem1), 0,
>                      memmap[MICROCHIP_PFSOC_GEM1].base);
> --
> 2.45.2
>
>

