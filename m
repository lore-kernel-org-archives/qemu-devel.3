Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5663D3E779
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8S89-0006ws-3x; Tue, 05 Nov 2024 17:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8S87-0006vl-Jo; Tue, 05 Nov 2024 17:34:31 -0500
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8S85-0001u2-U7; Tue, 05 Nov 2024 17:34:31 -0500
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-5139cd002b7so1514084e0c.0; 
 Tue, 05 Nov 2024 14:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730846068; x=1731450868; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+UwgmuRq0+OGGQeDNtF/5FwIx7BUqqW9UryJulqPz9c=;
 b=gXOJHAgSO2RP0ItDb4SO1jdQozn8f4+FyiN3HMS7xsnqYPMNaN0km514AH5ARtKyR+
 PbnFUPtAeoOEgOCGVtfJOr4Z9KEINAv86TRFJMVTDL1CMm9b1TqBV3R2LOPFmJ5KjZ42
 fnFQfyQ6ZKnK2wkGjk9sOWoYbn3MS0iD30pFlLPX/g99GRizFpJE1y+piR7CURdaRhVB
 8gx6HmXOwd9V2aDshh4sAZyg7p+8zLmKoz+G+/LQRUL2iz7BlR3BeqV3dljlEbEqxloB
 uw0l/zngsKqp0phCaQ2Kf6h6rCa3sdGwvG2/xsbNOU/Z/d6gGBrOL4fB3O1eyjBx+c8w
 MLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846068; x=1731450868;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+UwgmuRq0+OGGQeDNtF/5FwIx7BUqqW9UryJulqPz9c=;
 b=Md39E+uqVSa30Pphzi+UW/NQ9LMKfksb44CYkZu/5yQeCWPqX+sAqW4xeGhIDRJG2M
 kn41dRdJ7nEMkfP0yA7QxxKvOCa5MuLWoDF0FzurDfWjKWmcHldL5b+v76u/MdqMQO2I
 O5M4o6N8tb/n5EIQ6JTExX9zvQ0bv39miqP1Gwk7m7PK/GoNRWNf5JAneDOvdWp7oSsn
 Ob89yFr1p7Bc5AtIIH4ZTvCmwMSP+aS0IrqhCkzHNqXz6jswfOnQB4S0KvOWcbVNW98g
 N8bXEsH37g2KZAiRPTyJlz2MlZtFq9tqQur3Ob/BvHQVU5AH8NtEsVnvCA81ruSaPIAE
 +gjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgS+eZ0mqxSC3WB7fKNOOvWdTBow9OeBFDO9XkHMyGKxekSdsk+fxtGlGNUqQstRFMX34BaKg87w==@nongnu.org
X-Gm-Message-State: AOJu0YwfOY4uTvyidtdB5xAw8V7IihkyYrbrmN7vcAFdv54AQBIekFBy
 EYi9lmSkTXq7X8j50Tz/QeZnoAyN6YW93RN02DGNjPkuUEYyrGvPCZQ3uVIZYDpdoP8nlkoRxh2
 if772ociQUTuMycYarjnGZT0uTws=
X-Google-Smtp-Source: AGHT+IG9MrpTKjsFDhEGcujMkCbnjVI6IE7L9lF8t2bYL+UBQWVOH2d0bfzwk81i2/tFk8IvNhe69fqaDxIcx3Ln1OE=
X-Received: by 2002:a05:6102:5488:b0:4a5:6f41:2143 with SMTP id
 ada2fe7eead31-4a8cfb42ee1mr35267226137.4.1730846068437; Tue, 05 Nov 2024
 14:34:28 -0800 (PST)
MIME-Version: 1.0
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-3-philmd@linaro.org>
In-Reply-To: <20241105130431.22564-3-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Nov 2024 08:34:01 +1000
Message-ID: <CAKmqyKNoXGsVmufYtWu0FbsFZvoTQyc64c0dSLdF_ACTkR-paA@mail.gmail.com>
Subject: Re: [PATCH 02/19] hw/microblaze: Deprecate big-endian petalogix-ml605
 & xlnx-zynqmp-pmu
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa36.google.com
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

On Tue, Nov 5, 2024 at 11:06=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> The petalogix-ml605 machine was explicitly added as little-endian only
> machine in commit 00914b7d970 ("microblaze: Add PetaLogix ml605 MMU
> little-endian ref design"). Mark the big-endian version as deprecated.
>
> When the xlnx-zynqmp-pmu machine's CPU was added in commit 133d23b3ad1
> ("xlnx-zynqmp-pmu: Add the CPU and memory"), its 'endianness' property
> was set to %true, thus wired in little endianness.
>
> Both machine are included in the big-endian system binary, while their
> CPU is working in little-endian. Unlikely to work as it. Deprecate now
> as broken config so we can remove soon.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  docs/about/deprecated.rst                        | 6 ++++++
>  configs/devices/microblaze-softmmu/default.mak   | 2 --
>  configs/devices/microblazeel-softmmu/default.mak | 5 ++++-
>  hw/microblaze/petalogix_ml605_mmu.c              | 7 ++++++-
>  hw/microblaze/xlnx-zynqmp-pmu.c                  | 8 ++++++--
>  5 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index ff404d44f85..e1c8829e1a4 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -279,6 +279,12 @@ BMC and a witherspoon like OpenPOWER system. It was =
used for bring up
>  of the AST2600 SoC in labs.  It can be easily replaced by the
>  ``rainier-bmc`` machine which is a real product.
>
> +Big-Endian variants of MicroBlaze ``petalogix-ml605`` and ``xlnx-zynqmp-=
pmu`` machines (since 9.2)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''=
''''''''''''''''''''''''''
> +
> +Both ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` were added for little e=
ndian
> +CPUs. Big endian support is not tested.
> +
>  Backend options
>  ---------------
>
> diff --git a/configs/devices/microblaze-softmmu/default.mak b/configs/dev=
ices/microblaze-softmmu/default.mak
> index 583e3959bb7..78941064655 100644
> --- a/configs/devices/microblaze-softmmu/default.mak
> +++ b/configs/devices/microblaze-softmmu/default.mak
> @@ -2,5 +2,3 @@
>
>  # Boards are selected by default, uncomment to keep out of the build.
>  # CONFIG_PETALOGIX_S3ADSP1800=3Dn
> -# CONFIG_PETALOGIX_ML605=3Dn
> -# CONFIG_XLNX_ZYNQMP_PMU=3Dn
> diff --git a/configs/devices/microblazeel-softmmu/default.mak b/configs/d=
evices/microblazeel-softmmu/default.mak
> index 29f7f13816c..4c1086435bf 100644
> --- a/configs/devices/microblazeel-softmmu/default.mak
> +++ b/configs/devices/microblazeel-softmmu/default.mak
> @@ -1,3 +1,6 @@
>  # Default configuration for microblazeel-softmmu
>
> -include ../microblaze-softmmu/default.mak
> +# Boards are selected by default, uncomment to keep out of the build.
> +# CONFIG_PETALOGIX_S3ADSP1800=3Dn
> +# CONFIG_PETALOGIX_ML605=3Dn
> +# CONFIG_XLNX_ZYNQMP_PMU=3Dn
> diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogi=
x_ml605_mmu.c
> index df808ac323e..61e47d83988 100644
> --- a/hw/microblaze/petalogix_ml605_mmu.c
> +++ b/hw/microblaze/petalogix_ml605_mmu.c
> @@ -213,7 +213,12 @@ petalogix_ml605_init(MachineState *machine)
>
>  static void petalogix_ml605_machine_init(MachineClass *mc)
>  {
> -    mc->desc =3D "PetaLogix linux refdesign for xilinx ml605 little endi=
an";
> +#if TARGET_BIG_ENDIAN
> +    mc->desc =3D "PetaLogix linux refdesign for xilinx ml605 (big endian=
)";
> +    mc->deprecation_reason =3D "big endian support is not tested";
> +#else
> +    mc->desc =3D "PetaLogix linux refdesign for xilinx ml605 (little end=
ian)";
> +#endif
>      mc->init =3D petalogix_ml605_init;
>  }
>
> diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-=
pmu.c
> index 43608c2dca4..567aad47bfc 100644
> --- a/hw/microblaze/xlnx-zynqmp-pmu.c
> +++ b/hw/microblaze/xlnx-zynqmp-pmu.c
> @@ -181,9 +181,13 @@ static void xlnx_zynqmp_pmu_init(MachineState *machi=
ne)
>
>  static void xlnx_zynqmp_pmu_machine_init(MachineClass *mc)
>  {
> -    mc->desc =3D "Xilinx ZynqMP PMU machine";
> +#if TARGET_BIG_ENDIAN
> +    mc->desc =3D "Xilinx ZynqMP PMU machine (big endian)";
> +    mc->deprecation_reason =3D "big endian support is not tested";
> +#else
> +    mc->desc =3D "Xilinx ZynqMP PMU machine (little endian)";
> +#endif
>      mc->init =3D xlnx_zynqmp_pmu_init;
>  }
>
>  DEFINE_MACHINE("xlnx-zynqmp-pmu", xlnx_zynqmp_pmu_machine_init)
> -
> --
> 2.45.2
>
>

