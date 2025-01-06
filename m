Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E2FE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 04:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUew6-0005ZI-QA; Sun, 05 Jan 2025 23:41:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUew5-0005Z6-7G
 for qemu-devel@nongnu.org; Sun, 05 Jan 2025 23:41:53 -0500
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUew3-0001Iu-5x
 for qemu-devel@nongnu.org; Sun, 05 Jan 2025 23:41:52 -0500
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-51882748165so4751532e0c.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2025 20:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736138509; x=1736743309; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ssYoaN1CJQL0aubbmMqT3/uobKV/gR4S0AGM7QoAHk=;
 b=BACJdP77AtSb18PtGRn+W+8NMI1nC9hP6wUNpiF8qZi3F8myWSrJ7C+tyXKERQPe01
 rKjblYLWSBz4HLbnJzwzQFMhssLXI1phsWiPIC2YrgkPIo+9GgwDIPT3exbpD4pEaiv0
 YvSsvQOqpg/ztyy6dJnAr+WDIIXFeHQc3dGw0P/cml9onoYdfcxyDm2tmcO+2yXObKI+
 fQpdAJTwVnAT7c4pJ5nwj6bvM7wdMGFfQ+mErLTUYb74pRf6uFOrW24krGClG8Kfx8At
 gpW8SQGy2zrLbfcOfeDyg0RteYHi+I6c3NQRE+AbemaPKBihd39fCBTaAEX/Tf9AQ63O
 SlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736138509; x=1736743309;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ssYoaN1CJQL0aubbmMqT3/uobKV/gR4S0AGM7QoAHk=;
 b=BTL6cFQlvgXVXbSM9fhqAbL26OLMP0q2+KgN96bziTM61YnbyGPffJ9qg0GMzAOFyW
 fgdkg+2U+SBCoTu65ASb8S2S44E/o4GZyiJ0qMRhlWHcmMjya/dAnSoz70neZTRA0uN6
 hMz8IfFPBySoswOLUSw/HN6cUIoN4uBglFh28FAEnuwj1ZT9ndEtVA1BxOty1aXSsx7t
 zuifih958yxJ0rmFUYtIEieaepi7ZcGHGLAmOg/qLBl+KHleUPm4iBRTpH3nG0YHRi5Y
 ORlsjJPWnWnosbQRuXODcJHBIoP7SVQJRedu1+pw+5rUT2EXswAVYBMvoV8gXi8Vq3Oj
 fmVg==
X-Gm-Message-State: AOJu0Yw4GKMlKqsugTzKypbqsQoc794jU4a3KLRCdX1mHU1eaeiSqapJ
 QdFfoEacn3RR+8/NBfS77Qn86CxXTDpcz9wpdddUwZ49WS1IrCjUJgL4vd/exKX4t8NaKSPGz4o
 9uSfchsIUaH693WTfrCXXNqDD1cc=
X-Gm-Gg: ASbGnct6QDnUBRuhcfj0mxz2UNGO001ljFsXY3mONVKCQCBqjK/wNlMWP0oBniic4+N
 hc370aDlcO9o6dUsQAomEK3rn07L9FrnOCuFGDeGk/seLi1Sj4MINMEfBGbPSwFaCFbg=
X-Google-Smtp-Source: AGHT+IFBLQs4M2LGX39y7nXqTf2iB3NWoHsP9Podg9280E03bTO/c1rjIE4GXaXPTnf6NZ129dc9rq3nKzDGbnzpsYE=
X-Received: by 2002:a05:6122:d04:b0:518:80fb:df24 with SMTP id
 71dfb90a1353d-51b75c3b88amr44645322e0c.3.1736138509555; Sun, 05 Jan 2025
 20:41:49 -0800 (PST)
MIME-Version: 1.0
References: <CAEekfLYJqvMDf5A_Yj=N6jMGQ4oj3rC+fv3xcCCfSBy8TDaY-Q@mail.gmail.com>
In-Reply-To: <CAEekfLYJqvMDf5A_Yj=N6jMGQ4oj3rC+fv3xcCCfSBy8TDaY-Q@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jan 2025 14:41:23 +1000
Message-ID: <CAKmqyKPo=a=RHUvvgKZLB_DJnEXO=7u25MwNfXu5EDjak=y0vg@mail.gmail.com>
Subject: Re: Subject: [PATCH] loader: Add register setting support via cli
To: Sam Price <thesamprice@gmail.com>
Cc: qemu-devel@nongnu.org, alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
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

On Fri, Dec 6, 2024 at 1:30=E2=80=AFPM Sam Price <thesamprice@gmail.com> wr=
ote:
>
> I needed to set the registers prior to boot up to mimic what uboot
> would do prior to loading a binary.  This adds a generic option of reg
> to the loader command, it uses the existing gcc commands for setting
> register values.
>
> I'm sorry I couldn't figure out how to work the git send-email
> properly.  Configuring it with my gmail became too cumbersome, and my
> work email was also challenging to configure.
>
> I have the file staged here.
> https://gitlab.com/thesamprice/qemu/-/tree/loader?ref_type=3Dheads
> I am unsure of how to add tests for this.
> I could continue working too polish this off with instructions from
> others if it is desired for the main line.

Thanks for the patch. This will need documentation added under
`docs/system/generic-loader.rst` so that people know how to use it and
what it does

>
> Signed-off-by: Sam Price <thesamprice@gmail.com>
> ---
>
> ---
>  hw/core/generic-loader.c         | 28 ++++++++++++++++++++++++++++
>  include/hw/core/generic-loader.h |  6 +++++-
>  roms/SLOF                        |  2 +-
>  roms/edk2                        |  2 +-
>  roms/openbios                    |  2 +-
>  roms/opensbi                     |  2 +-
>  roms/seabios                     |  2 +-
>  roms/seabios-hppa                |  2 +-
>  tests/lcitool/libvirt-ci         |  2 +-
>  9 files changed, 40 insertions(+), 8 deletions(-)
>
> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
> index ea8628b892..ebda8ac43f 100644
> --- a/hw/core/generic-loader.c
> +++ b/hw/core/generic-loader.c
> @@ -55,6 +55,19 @@ static void generic_loader_reset(void *opaque)
>          }
>      }
>
> +    for (int i =3D 0; i < 31; i++) {

Why 31?

I'm guessing you picked this because that's how many registers your
architecture supports, but that's not the same for all architectures

> +        if (s->has_register_defaults[i]) {
> +            CPUClass *cc =3D CPU_GET_CLASS(s->cpu);
> +            uint8_t buf[sizeof(uint64_t)];
> +            memcpy(buf, &s->register_defaults[i], sizeof(uint64_t));
> +            if (cc && cc->gdb_write_register) {
> +                cc->gdb_write_register(s->cpu, buf, i);
> +            }
> +        }
> +    }
> +
> +
> +
>      if (s->data_len) {
>          assert(s->data_len <=3D sizeof(s->data));
>          dma_memory_write(s->cpu->as, s->addr, &s->data, s->data_len,
> @@ -172,6 +185,20 @@ static void generic_loader_realize(DeviceState
> *dev, Error **errp)
>      } else {
>          s->data =3D cpu_to_le64(s->data);
>      }
> +
> +    /* Store the CPU register default if specified */
> +    if (s->reg) {
> +        int reg_num;
> +        if (sscanf(s->reg, "r%d", &reg_num) =3D=3D 1 &&
> +                    reg_num >=3D 0 && reg_num < 31) {

I don't think all architectures call their registers r* and they don't
all have 31 registers

> +            s->register_defaults[reg_num] =3D s->data;
> +            s->has_register_defaults[reg_num] =3D true;
> +        } else {
> +            error_setg(errp, "Unsupported register: %s", s->reg);
> +            return;
> +        }
> +    }
> +
>  }
>
>  static void generic_loader_unrealize(DeviceState *dev)
> @@ -186,6 +213,7 @@ static Property generic_loader_props[] =3D {
>      DEFINE_PROP_BOOL("data-be", GenericLoaderState, data_be, false),
>      DEFINE_PROP_UINT32("cpu-num", GenericLoaderState, cpu_num, CPU_NONE)=
,
>      DEFINE_PROP_BOOL("force-raw", GenericLoaderState, force_raw, false),
> +    DEFINE_PROP_STRING("reg", GenericLoaderState, reg),
>      DEFINE_PROP_STRING("file", GenericLoaderState, file),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> diff --git a/include/hw/core/generic-loader.h b/include/hw/core/generic-l=
oader.h
> index 19d87b39c8..d81e1632fd 100644
> --- a/include/hw/core/generic-loader.h
> +++ b/include/hw/core/generic-loader.h
> @@ -35,10 +35,14 @@ struct GenericLoaderState {
>      uint32_t cpu_num;
>
>      char *file;
> -
> +    char *reg;
>      bool force_raw;
>      bool data_be;
>      bool set_pc;
> +
> +    /* Add an array for storing default register values */
> +    bool has_register_defaults[31];  /* Track if a default value is prov=
ided */
> +    uint64_t register_defaults[31];  /* Default values for registers r0-=
r30 */
>  };
>
>  #define TYPE_GENERIC_LOADER "loader"
> diff --git a/roms/SLOF b/roms/SLOF
> index 3a259df244..6b6c16b4b4 160000
> --- a/roms/SLOF
> +++ b/roms/SLOF
> @@ -1 +1 @@
> -Subproject commit 3a259df2449fc4a4e43ab5f33f0b2c66484b4bc3
> +Subproject commit 6b6c16b4b40763507cf1f518096f3c3883c5cf2d
> diff --git a/roms/edk2 b/roms/edk2
> index 4dfdca63a9..f80f052277 160000
> --- a/roms/edk2
> +++ b/roms/edk2
> @@ -1 +1 @@
> -Subproject commit 4dfdca63a93497203f197ec98ba20e2327e4afe4
> +Subproject commit f80f052277c88a67c55e107b550f504eeea947d3
> diff --git a/roms/openbios b/roms/openbios
> index c3a19c1e54..af97fd7af5 160000
> --- a/roms/openbios
> +++ b/roms/openbios
> @@ -1 +1 @@
> -Subproject commit c3a19c1e54977a53027d6232050e1e3e39a98a1b
> +Subproject commit af97fd7af5e7c18f591a7b987291d3db4ffb28b5
> diff --git a/roms/opensbi b/roms/opensbi
> index 43cace6c36..057eb10b6d 160000
> --- a/roms/opensbi
> +++ b/roms/opensbi
> @@ -1 +1 @@
> -Subproject commit 43cace6c3671e5172d0df0a8963e552bb04b7b20
> +Subproject commit 057eb10b6d523540012e6947d5c9f63e95244e94
> diff --git a/roms/seabios b/roms/seabios
> index a6ed6b701f..ea1b7a0733 160000
> --- a/roms/seabios
> +++ b/roms/seabios
> @@ -1 +1 @@
> -Subproject commit a6ed6b701f0a57db0569ab98b0661c12a6ec3ff8
> +Subproject commit ea1b7a0733906b8425d948ae94fba63c32b1d425
> diff --git a/roms/seabios-hppa b/roms/seabios-hppa
> index a528f01d7a..673d2595d4 160000
> --- a/roms/seabios-hppa
> +++ b/roms/seabios-hppa
> @@ -1 +1 @@
> -Subproject commit a528f01d7abd511d3cc71b7acaab6e036ee524bd
> +Subproject commit 673d2595d4f773cc266cbf8dbaf2f475a6adb949
> diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
> index 9ad3f70bde..9bff3b763b 160000
> --- a/tests/lcitool/libvirt-ci
> +++ b/tests/lcitool/libvirt-ci
> @@ -1 +1 @@
> -Subproject commit 9ad3f70bde9865d5ad18f36d256d472e72b5cbf3
> +Subproject commit 9bff3b763b5531a1490e238bfbf77306dc3a6dbb

Did you mean to change all of these submodules?


Alistair

> --
> 2.45.2
>

