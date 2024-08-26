Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49169C5320E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 00:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siNGH-0001uR-Fc; Sun, 25 Aug 2024 20:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNGF-0001lj-Cl; Sun, 25 Aug 2024 20:07:07 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNGD-00014E-M4; Sun, 25 Aug 2024 20:07:07 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2f3e9fb6ee9so44814711fa.3; 
 Sun, 25 Aug 2024 17:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724630823; x=1725235623; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hp0W6J3P4vcUTlf8QDvwq0u7ou0EA/al6NCWg9HBzjg=;
 b=E/FDrpiL04KhhgLiSu5waCam9ZgYwBoZu/Js6PfyA22wf+CFEpVWkNRbJMhm7WPpZi
 WUM9hHkSAv/OGe67axz/yZtStWs5IvK+G1rSSNq9J9BYHUeNdDomwqvoL7ZBs/qAI2H+
 zMTNoDtahbuewhuRLfWUDe1iLPTBMjJ6RLhQqFvyEHLugBUaAKRuYmlDSX6J8gLNTuEq
 NoUStZqwGLNXAcZmpMUof1J0vKwNBjqEFsWRd7GhDYaxq37rlgIkRPNl2Cwqu82DDZD7
 DP7oblb5C8CidX74K9AX9Gl0DGsV4cxpzr1eztzIj7CoaVzAT0dzCjVtylx5Vz1+Gjnf
 viuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724630823; x=1725235623;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hp0W6J3P4vcUTlf8QDvwq0u7ou0EA/al6NCWg9HBzjg=;
 b=UY27xsXJCRMBxZ6jMDaq+v3mbnxA57tAx2b+QqeUUOygncLX2EWy5JkPud6Xvq5CXA
 G+/XvmYR9rJC6A0meTqimVmWw/x/QwPSlSH93K4zRefK5TLvvUxMlRJDNyhlKTvuiAWn
 WykybhAGQLMG+h3mKMdMalv70cZPdb2JFY6pAHa1ppvZKnefGgwc53SL5Z7klQ7O5EB3
 djl3B49wF0VWppl6dx9nFwSXVfEGR3PA1B7EVAwoLsuwwGRQUAAkOWZyqkzIiYniM7Km
 sXEHaWe4YfyQMjPMJBdlDatNXnivHbfdaCdGVJhhYtsAqLwScpzqc9tvIzqbePRcPN4S
 MU0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNe3OMqm3LEGVYMCzSP0/6tYu7kfOmrNx8ATJIpYvsg4t3TJb5yQYXPPy3yGG1ZBtWlbg3jOc5Uy15@nongnu.org
X-Gm-Message-State: AOJu0YxY0ipPl9Y6YISg/SnvEwQtqHhWonXXJGdAzFI09URMeMOyOxK+
 XrIEjuzE3kFQIHI+siGBkJSAEMAVlYCk4F0dcl7203DBe0Mn4som9q9ybk22Hql8AmUTc5zXKww
 lKcUscfNYCXxz6HIlIzJpKcnlo3SzjyHL23M=
X-Google-Smtp-Source: AGHT+IEn8OFgLanoJslzfjvPVoLvYJ3Unge/GjeNPvuF2hAYux7uJBkXkqkgDaQ1wOQrJ36fAlsMe/HSWQcX6v1v8WE=
X-Received: by 2002:a05:651c:2204:b0:2f3:e2f0:af18 with SMTP id
 38308e7fff4ca-2f4f4937862mr57516111fa.35.1724630822962; Sun, 25 Aug 2024
 17:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240822162127.705879-1-peter.maydell@linaro.org>
 <20240822162127.705879-5-peter.maydell@linaro.org>
In-Reply-To: <20240822162127.705879-5-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Aug 2024 10:06:35 +1000
Message-ID: <CAKmqyKMn10QDSsEkDAZHTJbiML_HjQLFU8PnkZjQ1RxVvpdtrA@mail.gmail.com>
Subject: Re: [PATCH for-9.2 4/6] hw/nvram/xlnx-zynqmp-efuse: Call
 register_finalize_block
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Francisco Iglesias <francisco.iglesias@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=alistair23@gmail.com; helo=mail-lj1-x229.google.com
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

On Fri, Aug 23, 2024 at 2:23=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> The TYPE_XLNX_ZYNQMP_EFUSE device creates a register block with
> register_init_block32() in its instance_init method; we must
> therefore destroy it in our instance_finalize method to avoid a leak
> in the QOM introspection "init-inspect-finalize" lifecycle:
>
> Direct leak of 304 byte(s) in 1 object(s) allocated from:
>     #0 0x55f3ff5839d8 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-=
from-laptop/qemu/build/asan/qemu-system-aarch64+0x294d9d8) (BuildId: 23cf93=
1c66865a71b6cc4da95156d03bc106fa72)
>     #1 0x7f3f31c6bc50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:=
161:13
>     #2 0x55f3ff9b8c5d in register_init_block hw/core/register.c:248:34
>     #3 0x55f3ff9b96be in register_init_block32 hw/core/register.c:299:12
>     #4 0x55f4005e5b25 in efuse_ctrl_init hw/nvram/xlnx-versal-efuse-ctrl.=
c:718:9
>     #5 0x55f40254afb1 in object_init_with_type qom/object.c:420:9
>     #6 0x55f40253228b in object_initialize_with_type qom/object.c:562:5
>     #7 0x55f402533b2d in object_new_with_type qom/object.c:782:5
>     #8 0x55f402533c01 in object_new qom/object.c:797:12
>     #9 0x55f402d31a2d in qmp_device_list_properties qom/qom-qmp-cmds.c:14=
4:11
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/nvram/xlnx-zynqmp-efuse.h |  1 +
>  hw/nvram/xlnx-zynqmp-efuse.c         | 13 ++++++++++---
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/nvram/xlnx-zynqmp-efuse.h b/include/hw/nvram/xlnx=
-zynqmp-efuse.h
> index f5beacc2e6a..7fb12df3fbb 100644
> --- a/include/hw/nvram/xlnx-zynqmp-efuse.h
> +++ b/include/hw/nvram/xlnx-zynqmp-efuse.h
> @@ -37,6 +37,7 @@ struct XlnxZynqMPEFuse {
>      qemu_irq irq;
>
>      XlnxEFuse *efuse;
> +    RegisterInfoArray *reg_array;
>      uint32_t regs[XLNX_ZYNQMP_EFUSE_R_MAX];
>      RegisterInfo regs_info[XLNX_ZYNQMP_EFUSE_R_MAX];
>  };
> diff --git a/hw/nvram/xlnx-zynqmp-efuse.c b/hw/nvram/xlnx-zynqmp-efuse.c
> index 2d465f0fc6a..4e2d1b9d1e7 100644
> --- a/hw/nvram/xlnx-zynqmp-efuse.c
> +++ b/hw/nvram/xlnx-zynqmp-efuse.c
> @@ -803,9 +803,8 @@ static void zynqmp_efuse_init(Object *obj)
>  {
>      XlnxZynqMPEFuse *s =3D XLNX_ZYNQMP_EFUSE(obj);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> -    RegisterInfoArray *reg_array;
>
> -    reg_array =3D
> +    s->reg_array =3D
>          register_init_block32(DEVICE(obj), zynqmp_efuse_regs_info,
>                                ARRAY_SIZE(zynqmp_efuse_regs_info),
>                                s->regs_info, s->regs,
> @@ -813,10 +812,17 @@ static void zynqmp_efuse_init(Object *obj)
>                                ZYNQMP_EFUSE_ERR_DEBUG,
>                                R_MAX * 4);
>
> -    sysbus_init_mmio(sbd, &reg_array->mem);
> +    sysbus_init_mmio(sbd, &s->reg_array->mem);
>      sysbus_init_irq(sbd, &s->irq);
>  }
>
> +static void zynqmp_efuse_finalize(Object *obj)
> +{
> +    XlnxZynqMPEFuse *s =3D XLNX_ZYNQMP_EFUSE(obj);
> +
> +    register_finalize_block(s->reg_array);
> +}
> +
>  static const VMStateDescription vmstate_efuse =3D {
>      .name =3D TYPE_XLNX_ZYNQMP_EFUSE,
>      .version_id =3D 1,
> @@ -853,6 +859,7 @@ static const TypeInfo efuse_info =3D {
>      .instance_size =3D sizeof(XlnxZynqMPEFuse),
>      .class_init    =3D zynqmp_efuse_class_init,
>      .instance_init =3D zynqmp_efuse_init,
> +    .instance_finalize =3D zynqmp_efuse_finalize,
>  };
>
>  static void efuse_register_types(void)
> --
> 2.34.1
>
>

