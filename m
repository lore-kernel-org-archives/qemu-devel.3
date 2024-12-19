Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAD6E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 23:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOPgk-00016P-AX; Thu, 19 Dec 2024 18:12:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thesamprice@gmail.com>)
 id 1tOPgi-00011b-Ei
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 18:12:12 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <thesamprice@gmail.com>)
 id 1tOPgf-0000QF-4V
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 18:12:11 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7feb6871730so864942a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 15:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734649925; x=1735254725; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xTkSiDPKsWhsfKxgDtr84JLNjegWspTyWm1YQ671aOI=;
 b=moxP3nc4UHIDEYuOO4iluju1W6QF8lvJ8Y9ztFlUZl1fH2TNTxja3FXrL+FexttK7y
 aJ1+UtoiyqEiiPCcBM18OhsepXVte93vzz+1wdn7zeb+VSv4wnjvGfpfSMbl1SWkyRFI
 UF3WiNdd67D+IcLdAUz4c/4L6KcJ9Lcmle2meOpUcDdNl0BFU5IwMufp1R2AlGSrnYK7
 2ftfhSDVqDYuuXborkTRhaz3B8Qv5i4d7SCHuzkwMasj0126qL4Du52rw6tlkjS2/wOj
 tcjs61oXJEWNuSqXW0JJZoUkpTMoIB5NYkE5T+LIj5mwEUXh72wWKtDQ9roB3Q4wKVrq
 rxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734649925; x=1735254725;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xTkSiDPKsWhsfKxgDtr84JLNjegWspTyWm1YQ671aOI=;
 b=skfCQL8bt0oJBLwDwGihBSdc0PueNTAh5ZvUAeeR2McfB/P2TIspOJPC2FQaXUfvyS
 mepDqJ8y8OWAVqVx5v2pIWvyMvhsK1cNhanh6MpT9TZDyjtaRF1u2uOtecnJafQW8b3c
 SSV9AHRH1LPjb9SlL1bS4oxGZyx9yMIOybEI51XTyXWK5/rUT3Ee1poPdV/nVFqsPp6u
 oVrOBVKCIIIXpaGjDPEhTc6LWleKSWEafuHp+J+LwPjkPmhUfBwkNBxvFGwd4hX+eDo2
 3AYyCGsC3l/ui6ZsCiSjSjAjlTUgbDMqXiibCBAsM8YQnDPNYN3k2cRtd/ixigVzGKoC
 b+tQ==
X-Gm-Message-State: AOJu0Yz+8M2tpCwzujoiyELGV3Ng+XvgeCvdeYzoAtdUaJYJglB7s6Sz
 Jp/AvjuEqZhdTKyDYBlCUnGcHXAOLA16aQ6yUZ8MNcuehr678DSdtA11PfUPudvpwG2oERYUnI9
 NBV/RiHGLtyMNCgWfr3VkUS/z6OhieQ==
X-Gm-Gg: ASbGncsfnJ+piN2PdclgubEAFkSxg6nYNQiJ8BMT4XoJJV9IiUDOFCkvIgpr/mbfNgQ
 MSWE2aiXhpnyr4OlYsJHhcdHa7D5yf/a8i/IiDQI=
X-Google-Smtp-Source: AGHT+IHf1wFjAwH4lNBRbQRf4Y26f26bxdBOj3yFns5b/uMz1+nzo4IUPFKuzlwwrQNlA2docq5GKuYHGcuAvvhvfSk=
X-Received: by 2002:a17:90a:e18f:b0:2ee:aa28:79aa with SMTP id
 98e67ed59e1d1-2f452dfcd7fmr1166839a91.6.1734649925251; Thu, 19 Dec 2024
 15:12:05 -0800 (PST)
MIME-Version: 1.0
References: <CAEekfLYJqvMDf5A_Yj=N6jMGQ4oj3rC+fv3xcCCfSBy8TDaY-Q@mail.gmail.com>
In-Reply-To: <CAEekfLYJqvMDf5A_Yj=N6jMGQ4oj3rC+fv3xcCCfSBy8TDaY-Q@mail.gmail.com>
From: Sam Price <thesamprice@gmail.com>
Date: Thu, 19 Dec 2024 18:11:54 -0500
Message-ID: <CAEekfLaeMQ-5pZw9+edU8E6jdvz6nCHE0WVZe7-Myg1NBKVLng@mail.gmail.com>
Subject: Re: Subject: [PATCH] loader: Add register setting support via cli
To: qemu-devel@nongnu.org
Cc: alistair@alistair23.me
Content-Type: multipart/alternative; boundary="0000000000009ab7040629a7a89f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=thesamprice@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000009ab7040629a7a89f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Bump / ping

Sincerely,

Sam Price



On Thu, Dec 5, 2024 at 10:29=E2=80=AFPM Sam Price <thesamprice@gmail.com> w=
rote:

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
> diff --git a/include/hw/core/generic-loader.h
> b/include/hw/core/generic-loader.h
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
> +    bool has_register_defaults[31];  /* Track if a default value is
> provided */
> +    uint64_t register_defaults[31];  /* Default values for registers
> r0-r30 */
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
> --
> 2.45.2
>

--0000000000009ab7040629a7a89f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Bump / ping<br clear=3D"all"><br clear=3D"all"><div><div =
dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><d=
iv dir=3D"ltr">Sincerely,<br><br>Sam Price<br><br></div></div></div></div><=
div><br></div><div><br><div class=3D"gmail_quote gmail_quote_container"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 5, 2024 at 10:29=E2=80=AFPM =
Sam Price &lt;<a href=3D"mailto:thesamprice@gmail.com">thesamprice@gmail.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">I needed to set th=
e registers prior to boot up to mimic what uboot<br>
would do prior to loading a binary.=C2=A0 This adds a generic option of reg=
<br>
to the loader command, it uses the existing gcc commands for setting<br>
register values.<br>
<br>
I&#39;m sorry I couldn&#39;t figure out how to work the git send-email<br>
properly.=C2=A0 Configuring it with my gmail became too cumbersome, and my<=
br>
work email was also challenging to configure.<br>
<br>
I have the file staged here.<br>
<a href=3D"https://gitlab.com/thesamprice/qemu/-/tree/loader?ref_type=3Dhea=
ds" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/thesamprice/qem=
u/-/tree/loader?ref_type=3Dheads</a><br>
I am unsure of how to add tests for this.<br>
I could continue working too polish this off with instructions from<br>
others if it is desired for the main line.<br>
<br>
Signed-off-by: Sam Price &lt;<a href=3D"mailto:thesamprice@gmail.com" targe=
t=3D"_blank">thesamprice@gmail.com</a>&gt;<br>
---<br>
<br>
---<br>
=C2=A0hw/core/generic-loader.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 28 ++++++=
++++++++++++++++++++++<br>
=C2=A0include/hw/core/generic-loader.h |=C2=A0 6 +++++-<br>
=C2=A0roms/SLOF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0roms/edk2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0roms/openbios=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0roms/opensbi=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0roms/seabios=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0roms/seabios-hppa=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 2 +-<br>
=C2=A0tests/lcitool/libvirt-ci=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +=
-<br>
=C2=A09 files changed, 40 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c<br>
index ea8628b892..ebda8ac43f 100644<br>
--- a/hw/core/generic-loader.c<br>
+++ b/hw/core/generic-loader.c<br>
@@ -55,6 +55,19 @@ static void generic_loader_reset(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; 31; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;has_register_defaults[i]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUClass *cc =3D CPU_GET_CLASS(s=
-&gt;cpu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t buf[sizeof(uint64_t)];<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(buf, &amp;s-&gt;register_=
defaults[i], sizeof(uint64_t));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cc &amp;&amp; cc-&gt;gdb_wri=
te_register) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cc-&gt;gdb_write_r=
egister(s-&gt;cpu, buf, i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (s-&gt;data_len) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert(s-&gt;data_len &lt;=3D sizeof(s-&g=
t;data));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_memory_write(s-&gt;cpu-&gt;as, s-&gt;=
addr, &amp;s-&gt;data, s-&gt;data_len,<br>
@@ -172,6 +185,20 @@ static void generic_loader_realize(DeviceState<br>
*dev, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;data =3D cpu_to_le64(s-&gt;data);<b=
r>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 /* Store the CPU register default if specified */<br>
+=C2=A0 =C2=A0 if (s-&gt;reg) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int reg_num;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sscanf(s-&gt;reg, &quot;r%d&quot;, &amp;re=
g_num) =3D=3D 1 &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg_=
num &gt;=3D 0 &amp;&amp; reg_num &lt; 31) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;register_defaults[reg_num]=
 =3D s-&gt;data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;has_register_defaults[reg_=
num] =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Unsupport=
ed register: %s&quot;, s-&gt;reg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0}<br>
<br>
=C2=A0static void generic_loader_unrealize(DeviceState *dev)<br>
@@ -186,6 +213,7 @@ static Property generic_loader_props[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_BOOL(&quot;data-be&quot;, GenericLoaderStat=
e, data_be, false),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_UINT32(&quot;cpu-num&quot;, GenericLoaderSt=
ate, cpu_num, CPU_NONE),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_BOOL(&quot;force-raw&quot;, GenericLoaderSt=
ate, force_raw, false),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_STRING(&quot;reg&quot;, GenericLoaderState, reg)=
,<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_STRING(&quot;file&quot;, GenericLoaderState=
, file),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_END_OF_LIST(),<br>
=C2=A0};<br>
diff --git a/include/hw/core/generic-loader.h b/include/hw/core/generic-loa=
der.h<br>
index 19d87b39c8..d81e1632fd 100644<br>
--- a/include/hw/core/generic-loader.h<br>
+++ b/include/hw/core/generic-loader.h<br>
@@ -35,10 +35,14 @@ struct GenericLoaderState {<br>
=C2=A0 =C2=A0 =C2=A0uint32_t cpu_num;<br>
<br>
=C2=A0 =C2=A0 =C2=A0char *file;<br>
-<br>
+=C2=A0 =C2=A0 char *reg;<br>
=C2=A0 =C2=A0 =C2=A0bool force_raw;<br>
=C2=A0 =C2=A0 =C2=A0bool data_be;<br>
=C2=A0 =C2=A0 =C2=A0bool set_pc;<br>
+<br>
+=C2=A0 =C2=A0 /* Add an array for storing default register values */<br>
+=C2=A0 =C2=A0 bool has_register_defaults[31];=C2=A0 /* Track if a default =
value is provided */<br>
+=C2=A0 =C2=A0 uint64_t register_defaults[31];=C2=A0 /* Default values for =
registers r0-r30 */<br>
=C2=A0};<br>
<br>
=C2=A0#define TYPE_GENERIC_LOADER &quot;loader&quot;<br>
diff --git a/roms/SLOF b/roms/SLOF<br>
index 3a259df244..6b6c16b4b4 160000<br>
--- a/roms/SLOF<br>
+++ b/roms/SLOF<br>
@@ -1 +1 @@<br>
-Subproject commit 3a259df2449fc4a4e43ab5f33f0b2c66484b4bc3<br>
+Subproject commit 6b6c16b4b40763507cf1f518096f3c3883c5cf2d<br>
diff --git a/roms/edk2 b/roms/edk2<br>
index 4dfdca63a9..f80f052277 160000<br>
--- a/roms/edk2<br>
+++ b/roms/edk2<br>
@@ -1 +1 @@<br>
-Subproject commit 4dfdca63a93497203f197ec98ba20e2327e4afe4<br>
+Subproject commit f80f052277c88a67c55e107b550f504eeea947d3<br>
diff --git a/roms/openbios b/roms/openbios<br>
index c3a19c1e54..af97fd7af5 160000<br>
--- a/roms/openbios<br>
+++ b/roms/openbios<br>
@@ -1 +1 @@<br>
-Subproject commit c3a19c1e54977a53027d6232050e1e3e39a98a1b<br>
+Subproject commit af97fd7af5e7c18f591a7b987291d3db4ffb28b5<br>
diff --git a/roms/opensbi b/roms/opensbi<br>
index 43cace6c36..057eb10b6d 160000<br>
--- a/roms/opensbi<br>
+++ b/roms/opensbi<br>
@@ -1 +1 @@<br>
-Subproject commit 43cace6c3671e5172d0df0a8963e552bb04b7b20<br>
+Subproject commit 057eb10b6d523540012e6947d5c9f63e95244e94<br>
diff --git a/roms/seabios b/roms/seabios<br>
index a6ed6b701f..ea1b7a0733 160000<br>
--- a/roms/seabios<br>
+++ b/roms/seabios<br>
@@ -1 +1 @@<br>
-Subproject commit a6ed6b701f0a57db0569ab98b0661c12a6ec3ff8<br>
+Subproject commit ea1b7a0733906b8425d948ae94fba63c32b1d425<br>
diff --git a/roms/seabios-hppa b/roms/seabios-hppa<br>
index a528f01d7a..673d2595d4 160000<br>
--- a/roms/seabios-hppa<br>
+++ b/roms/seabios-hppa<br>
@@ -1 +1 @@<br>
-Subproject commit a528f01d7abd511d3cc71b7acaab6e036ee524bd<br>
+Subproject commit 673d2595d4f773cc266cbf8dbaf2f475a6adb949<br>
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci<br>
index 9ad3f70bde..9bff3b763b 160000<br>
--- a/tests/lcitool/libvirt-ci<br>
+++ b/tests/lcitool/libvirt-ci<br>
@@ -1 +1 @@<br>
-Subproject commit 9ad3f70bde9865d5ad18f36d256d472e72b5cbf3<br>
+Subproject commit 9bff3b763b5531a1490e238bfbf77306dc3a6dbb<br>
-- <br>
2.45.2<br>
</blockquote></div></div>

--0000000000009ab7040629a7a89f--

