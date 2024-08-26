Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD69C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 00:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siNFq-0008QH-PG; Sun, 25 Aug 2024 20:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNFo-0008J4-UI; Sun, 25 Aug 2024 20:06:40 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNFn-00011v-82; Sun, 25 Aug 2024 20:06:40 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2f3f25a1713so42864411fa.2; 
 Sun, 25 Aug 2024 17:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724630797; x=1725235597; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c8KpSH2/8UXSgFzTZXJ5Acjckq9KLqp6+mKVmD/Y0+c=;
 b=Bxim3B3INC6ibFiZ3G4rB1RLyCm4GgJMf6rtW97g53gZU+7yM1b7DNfr0mBWn/THqn
 nFtRf3iy1qiOCcs6Cpvckh6iz3h3ty/H4D+vbbHQBLx70RTFVldNhuuOOnwJ0CB/dVB1
 fjOBh6PQ7YKi6wtlG8SkPIWZRltNdqNUG6Q2C4veCeB1uI8AcZzC7bnzoB4nTmQ1Pnk2
 ut9IJY6yiIS4Y5fCKK+ZD5C58kkrCvCN/wU4nLwMfPUgFqPvAHuYfMRrosRBuQ4VMf6C
 K7yW26YaI/q08Ku3Wuh5I3u9PEm407odMe7hCjbktEFnsbSHebFUnBdj2/a+dwzSR4rp
 6KQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724630797; x=1725235597;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c8KpSH2/8UXSgFzTZXJ5Acjckq9KLqp6+mKVmD/Y0+c=;
 b=ON5KQj0+5nTM05SVpL4y7kcjVd7Nxu0u72bvdN2qupdzLZSthJ+Fxxv/JG657Qai7F
 zAbG4cOOxBdtqjlIoi8eDfDRHFOjAHNlKOqVsF0gHQQ/MP/lzfIpxWol1OZ6I5mZbDfb
 GGMH8gI6oIr6tSRYaBn/tDFc0/jh2cB21P2Vv/zHzYzm2YbztCPfNqdIg+GfbvT8TDLr
 UFuqpnqwPuXLzYP1mC7LcyXn6kPUmVQjQGSDABs8xDWE6hOE85j5beGMVZeClYFWJjYc
 PlrtvUIav1gmety8GnisiA09NzD50pYY7xbwRTMRVmvm2LXaM+AdUFpKsy6eXAcUPZAb
 XCgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiH/BjgVrL4/tClkpj4dzLA2VUHyQSE6MXAi8FMUVQxoSmc6PebkbbazwbUDLzoCI1jLmdHGBwjpjv@nongnu.org
X-Gm-Message-State: AOJu0YzGoP+nfCL+gxKQ5E6xYD3AHPNzhM4DK+DFAV43Tendo4bfRzja
 nzBk1uhw7yUT+l2nE5OjYMtoD0Rbe79qtnUN77NvVAqR8EdFkR1f1QIMeMXc0F0JX9rBN2fmDrM
 BlvlMOXqd3dqhLKig/MfusUCFiGQ=
X-Google-Smtp-Source: AGHT+IGDv7iuZxQJVzQqsCfjv3ZhI1Q4ZkECL4AOOzYS7UU6JUGkWOasMbHxYads5YbIZOQdgsNuWEQsnPUqLLi7Ocs=
X-Received: by 2002:a2e:be8a:0:b0:2ef:251f:785 with SMTP id
 38308e7fff4ca-2f4f48d62a9mr59780031fa.1.1724630796177; Sun, 25 Aug 2024
 17:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240822162127.705879-1-peter.maydell@linaro.org>
 <20240822162127.705879-4-peter.maydell@linaro.org>
In-Reply-To: <20240822162127.705879-4-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Aug 2024 10:06:08 +1000
Message-ID: <CAKmqyKPj6fBcUG0wpzBVx4U+mYJufFm=W0t_Cy3pKQ5kj69W4w@mail.gmail.com>
Subject: Re: [PATCH for-9.2 3/6] hw/nvram/xlnx-bbram: Call
 register_finalize_block
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Francisco Iglesias <francisco.iglesias@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=alistair23@gmail.com; helo=mail-lj1-x234.google.com
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

On Fri, Aug 23, 2024 at 2:22=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> The TYPE_XLNX_BBRAM device creates a register block with
> register_init_block32() in its instance_init method; we must
> therefore destroy it in our instance_finalize method to avoid a leak
> in the QOM introspection "init-inspect-finalize" lifecycle:
>
> Direct leak of 304 byte(s) in 1 object(s) allocated from:
>     #0 0x5641518ca9d8 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-=
from-laptop/qemu/build/asan/qemu-system-aarch64+0x294d9d8) (BuildId: 4a6
> 18cb63d57d5a19ed45cfc262b08da47eaafe5)
>     #1 0x7ff1aab31c50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:=
161:13
>     #2 0x564151cffc5d in register_init_block hw/core/register.c:248:34
>     #3 0x564151d006be in register_init_block32 hw/core/register.c:299:12
>     #4 0x56415293df75 in bbram_ctrl_init hw/nvram/xlnx-bbram.c:462:9
>     #5 0x564154891dc1 in object_init_with_type qom/object.c:420:9
>     #6 0x56415487909b in object_initialize_with_type qom/object.c:562:5
>     #7 0x56415487a93d in object_new_with_type qom/object.c:782:5
>     #8 0x56415487aa11 in object_new qom/object.c:797:12
>     #9 0x56415507883d in qmp_device_list_properties qom/qom-qmp-cmds.c:14=
4:11
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/nvram/xlnx-bbram.h |  1 +
>  hw/nvram/xlnx-bbram.c         | 13 ++++++++++---
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/nvram/xlnx-bbram.h b/include/hw/nvram/xlnx-bbram.=
h
> index 6fc13f8cc17..bce8e89d905 100644
> --- a/include/hw/nvram/xlnx-bbram.h
> +++ b/include/hw/nvram/xlnx-bbram.h
> @@ -47,6 +47,7 @@ struct XlnxBBRam {
>      bool bbram8_wo;
>      bool blk_ro;
>
> +    RegisterInfoArray *reg_array;
>      uint32_t regs[RMAX_XLNX_BBRAM];
>      RegisterInfo regs_info[RMAX_XLNX_BBRAM];
>  };
> diff --git a/hw/nvram/xlnx-bbram.c b/hw/nvram/xlnx-bbram.c
> index 09575a77d77..1bc58e90ad0 100644
> --- a/hw/nvram/xlnx-bbram.c
> +++ b/hw/nvram/xlnx-bbram.c
> @@ -456,9 +456,8 @@ static void bbram_ctrl_init(Object *obj)
>  {
>      XlnxBBRam *s =3D XLNX_BBRAM(obj);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> -    RegisterInfoArray *reg_array;
>
> -    reg_array =3D
> +    s->reg_array =3D
>          register_init_block32(DEVICE(obj), bbram_ctrl_regs_info,
>                                ARRAY_SIZE(bbram_ctrl_regs_info),
>                                s->regs_info, s->regs,
> @@ -466,10 +465,17 @@ static void bbram_ctrl_init(Object *obj)
>                                XLNX_BBRAM_ERR_DEBUG,
>                                R_MAX * 4);
>
> -    sysbus_init_mmio(sbd, &reg_array->mem);
> +    sysbus_init_mmio(sbd, &s->reg_array->mem);
>      sysbus_init_irq(sbd, &s->irq_bbram);
>  }
>
> +static void bbram_ctrl_finalize(Object *obj)
> +{
> +    XlnxBBRam *s =3D XLNX_BBRAM(obj);
> +
> +    register_finalize_block(s->reg_array);
> +}
> +
>  static void bbram_prop_set_drive(Object *obj, Visitor *v, const char *na=
me,
>                                   void *opaque, Error **errp)
>  {
> @@ -537,6 +543,7 @@ static const TypeInfo bbram_ctrl_info =3D {
>      .instance_size =3D sizeof(XlnxBBRam),
>      .class_init    =3D bbram_ctrl_class_init,
>      .instance_init =3D bbram_ctrl_init,
> +    .instance_finalize =3D bbram_ctrl_finalize,
>  };
>
>  static void bbram_ctrl_register_types(void)
> --
> 2.34.1
>
>

