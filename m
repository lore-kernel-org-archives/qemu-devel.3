Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84287D3E77A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SEG-0003qk-AG; Tue, 05 Nov 2024 17:40:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8SEB-0003qW-T8; Tue, 05 Nov 2024 17:40:48 -0500
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8SEA-0003AX-C4; Tue, 05 Nov 2024 17:40:47 -0500
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-84fe1bc5284so2283279241.0; 
 Tue, 05 Nov 2024 14:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730846444; x=1731451244; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wigJ1UnWmMX0x09YnYXSSLLIJ50XleHXgHbUUqXrP9U=;
 b=Kto49BUSCUQVy01xIELF8ZIrkSnx7cGRvSyHPSCQNxtg4MQbbdrDZWOQnKrgd8AmFq
 yBoF5KTjzkxQn1VeMBvy94FJaAHANfMkSFxeAMTzKnMO3xMujr6Vq0XgdUEPamVSY3oc
 GYiTSd1Ft0D+i45PsdcuadtZsS0xuhN9qPuhiTK9w9U/T9xRnm8BPiSo+pOCccs2DDvn
 rB15yFjgMm8wKZDBjDIcGSvCQ1BPDeq95Fte8YSEe2TbJy9j3ihg6KXz1KqI9thXWjkw
 olt/dn13KC92ovwIjaIlrADf4ChtRDnH1qZyye7bVxZd3gmjjjPpzyphJYXNCXjfIxWb
 iecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846444; x=1731451244;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wigJ1UnWmMX0x09YnYXSSLLIJ50XleHXgHbUUqXrP9U=;
 b=GSqnmErHDwA8UrYPfpZWxIbpNNcGRrLKeoQIgNyEC8+Ymhwpl9Na23/zZCveMVvo/2
 FDV7/hAWRQe3e8Hit8zbgTohXODhTaEwq5Q9HxobjOTpD9HdhKH67yOrtK8/K4/eZMvD
 R771valLDO4GtP8APJVSf3NYQlS5JkacvZBQb7CEQuThh8BhgF1u3ODQlVmN9P51wUge
 OSq7/gmWF4V7NF6zlTbtfbD1WPqLWGbPWPRsmI9LhMBfE1luHipST5ZWxLhjIiEqrxfc
 TG20Iq7HssUhgBVqFy0RAklfKSj3GwxRdGk4BjMQwV4JLBw3JLB2TOttFnfqguHTqiYB
 GLIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8Kmr3Rr1YmHUgfs+amcLOhja3FxwGiZlfgUC1afmtDbNcvH+Ub3MXe3Xv6wA9NlzDNFRf7CnO3g==@nongnu.org
X-Gm-Message-State: AOJu0YwXYyJXJEa8yKpbUUxix+wUh/fP4OWyEZbyRAlzUzDkcIlQJb9d
 YfSGyIrb8WIobAhcvUEq8aK1bsUGG4EmW+RDKXL3u27HKG7zMV8/c9ofbGQD4+yemOM1F61fNwF
 5JKtZtsJaLAas75tdBU/uqXE+7Hc=
X-Google-Smtp-Source: AGHT+IH90+EsbQnMLWrsYvFkFvSzT6IFJX6YnzslVUlSpnRnQ9EF0eECM8l6z/5hUMkymcevgAPqdKMZu9ikxjVLcR0=
X-Received: by 2002:a05:6102:3909:b0:4a5:c74b:66a7 with SMTP id
 ada2fe7eead31-4a962f3bd39mr16793151137.19.1730846442842; Tue, 05 Nov 2024
 14:40:42 -0800 (PST)
MIME-Version: 1.0
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-6-philmd@linaro.org>
In-Reply-To: <20241105130431.22564-6-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Nov 2024 08:40:16 +1000
Message-ID: <CAKmqyKNHA7CR70HrvB2Ao4Yr=H3fziMO8pZkVZiQ-YrXuAmCLw@mail.gmail.com>
Subject: Re: [PATCH 05/19] hw/microblaze/s3adsp1800: Declare machine type
 using DEFINE_TYPES macro
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Nov 5, 2024 at 11:05=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Replace DEFINE_MACHINE() by DEFINE_TYPES(), converting the
> class_init() handler.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/microblaze/petalogix_s3adsp1800_mmu.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/pet=
alogix_s3adsp1800_mmu.c
> index 581b0411e29..6c0f5c6c651 100644
> --- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
> +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> @@ -55,6 +55,9 @@
>  #define ETHLITE_IRQ         1
>  #define UARTLITE_IRQ        3
>
> +#define TYPE_PETALOGIX_S3ADSP1800_MACHINE \
> +            MACHINE_TYPE_NAME("petalogix-s3adsp1800")
> +
>  static void
>  petalogix_s3adsp1800_init(MachineState *machine)
>  {
> @@ -132,11 +135,21 @@ petalogix_s3adsp1800_init(MachineState *machine)
>                             NULL);
>  }
>
> -static void petalogix_s3adsp1800_machine_init(MachineClass *mc)
> +static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc, voi=
d *data)
>  {
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
>      mc->desc =3D "PetaLogix linux refdesign for xilinx Spartan 3ADSP1800=
";
>      mc->init =3D petalogix_s3adsp1800_init;
>      mc->is_default =3D true;
>  }
>
> -DEFINE_MACHINE("petalogix-s3adsp1800", petalogix_s3adsp1800_machine_init=
)
> +static const TypeInfo petalogix_s3adsp1800_machine_types[] =3D {
> +    {
> +        .name           =3D TYPE_PETALOGIX_S3ADSP1800_MACHINE,
> +        .parent         =3D TYPE_MACHINE,
> +        .class_init     =3D petalogix_s3adsp1800_machine_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(petalogix_s3adsp1800_machine_types)
> --
> 2.45.2
>
>

