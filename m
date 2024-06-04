Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642E1C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 00:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEHrj-0003vG-L0; Mon, 03 Jun 2024 20:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEHrg-0003uH-9N
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 20:17:24 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEHre-0004GN-GR
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 20:17:23 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4eb25f3c203so361951e0c.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 17:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717460241; x=1718065041; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FAyRbR/SvGBnLo3Q6pm1EwtPfPdbDpjCLywo8AKkb0E=;
 b=bMWNHAnkqluje8D3ZyDMYfIByfpomHHMvj0iDnGgiGaVdhEwmu5vbGtys7s0NS6Mxs
 GmKnb+s8cUg/Kuo8yH6716P+0rvjg+T9bOJ24guqqgMj5znvj4zACZHtk5Wo/9/mvhKC
 qGCzNaV2/k6/5EaPLHYTpo7TohagvfkB/LDboeVkha37aS7RKya8XRdbn3RGXlvSJVTk
 aK/vy1c+eFlZ+VbSLkGufja2m2BRKeaF115NSbdtWxeWDQUxixLrivtUSaV+0Z15UcCx
 WTcJI7jerF5YK79qiL+jpmPF51wPh7JuKQMGNJrDUmZ2w9yygz0+708wqkarVVBrB1rJ
 OBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717460241; x=1718065041;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FAyRbR/SvGBnLo3Q6pm1EwtPfPdbDpjCLywo8AKkb0E=;
 b=cu12h6p+65Iz/0oKVxL+z0BWklEVXtLdQmGKhtKw003azL/tMP5I2TIwwN829T0bjl
 ayx48BKZR46zN7wucx/dUUGUC4t3O4T6CwRaUxUptOHtBeuw0WsMmrRNPvnZiGdtrwsw
 XnsYNjUFwAGAkWtYQgeGRHLQbkuMAUH3Zy8zfhUX6oHuoJpHdALIQbCuzYZEZP+ataPx
 uMwQjwqqYeWvwde+bnEvdZWR+JUIwYli4KQUNy5kc/Dh6RskkmfpG7thS++05MGqvTVS
 r2gHyMamKsCcAwIOIHn8O1AfFqUH0V4KFd2tZXnpiGA7bnidKnKfGOcv0m/qfJpMvzK/
 FASQ==
X-Gm-Message-State: AOJu0Yw8rs9kXUzsxb1Mb9snplmk1iRynB5E9ZcpNzY3JkeskPKCOeEW
 rSM57k3O7v0t0XxUDlKw3GTI/mwXys1NwMC4cJT082mVKi4MQXPYSZ7bULZGBIKbUMkGcCDj5aw
 hsPxZAWQSiRWcTnJcPaBuPak8BfA=
X-Google-Smtp-Source: AGHT+IHmEE30rWtlaES/6i6lebHUzNRW9Yqswl0F2Qd/AXxIMFicArkecuCiuF+yRsmaPjU6TED3/zHXqxv8kPei6Sw=
X-Received: by 2002:a05:6122:737:b0:4ea:f128:7adb with SMTP id
 71dfb90a1353d-4eb02edf12bmr8622006e0c.10.1717460241322; Mon, 03 Jun 2024
 17:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-26-richard.henderson@linaro.org>
In-Reply-To: <20240412073346.458116-26-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 10:16:55 +1000
Message-ID: <CAKmqyKPYV9pYTEARiFz4qzt4qcO9k5p9jPwJ6ozjCigvfLsWgg@mail.gmail.com>
Subject: Re: [PATCH v3 25/27] hw/riscv/virt: Replace sprintf by g_strdup_printf
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Apr 12, 2024 at 5:36=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1.
> Use g_strdup_printf instead.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Message-Id: <20240411104340.6617-8-philmd@linaro.org>
> [rth: Use g_strdup_printf]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index d171e74f7b..4fdb660525 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1617,10 +1617,8 @@ static void virt_machine_instance_init(Object *obj=
)
>  static char *virt_get_aia_guests(Object *obj, Error **errp)
>  {
>      RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> -    char val[32];
>
> -    sprintf(val, "%d", s->aia_guests);
> -    return g_strdup(val);
> +    return g_strdup_printf("%d", s->aia_guests);
>  }
>
>  static void virt_set_aia_guests(Object *obj, const char *val, Error **er=
rp)
> @@ -1741,7 +1739,6 @@ static void virt_machine_device_plug_cb(HotplugHand=
ler *hotplug_dev,
>
>  static void virt_machine_class_init(ObjectClass *oc, void *data)
>  {
> -    char str[128];
>      MachineClass *mc =3D MACHINE_CLASS(oc);
>      HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
>
> @@ -1767,7 +1764,6 @@ static void virt_machine_class_init(ObjectClass *oc=
, void *data)
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
>  #endif
>
> -
>      object_class_property_add_bool(oc, "aclint", virt_get_aclint,
>                                     virt_set_aclint);
>      object_class_property_set_description(oc, "aclint",
> @@ -1785,9 +1781,14 @@ static void virt_machine_class_init(ObjectClass *o=
c, void *data)
>      object_class_property_add_str(oc, "aia-guests",
>                                    virt_get_aia_guests,
>                                    virt_set_aia_guests);
> -    sprintf(str, "Set number of guest MMIO pages for AIA IMSIC. Valid va=
lue "
> -                 "should be between 0 and %d.", VIRT_IRQCHIP_MAX_GUESTS)=
;
> -    object_class_property_set_description(oc, "aia-guests", str);
> +    {
> +        g_autofree char *str =3D
> +            g_strdup_printf("Set number of guest MMIO pages for AIA IMSI=
C. "
> +                            "Valid value should be between 0 and %d.",
> +                            VIRT_IRQCHIP_MAX_GUESTS);
> +        object_class_property_set_description(oc, "aia-guests", str);
> +    }
> +
>      object_class_property_add(oc, "acpi", "OnOffAuto",
>                                virt_get_acpi, virt_set_acpi,
>                                NULL, NULL);
> --
> 2.34.1
>
>

