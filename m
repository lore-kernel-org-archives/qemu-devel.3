Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A74606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=gCiiaNY8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTG9R-0005LC-JL; Tue, 17 Nov 2026 05:10:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xTG9P-0005Kd-H2
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:10:55 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xTG9M-0000uP-K5
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:10:55 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c40f29667e6so783036766b.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 02:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1794910251; x=1795515051; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XRG0of1hoB/vT6BmhYVlnUACQ1Af/rDzfjGnNwGAsNE=;
 b=gCiiaNY8VG4uzOw1V4MMblpvmNNy3JegN21pTNhKmAlfG+qi1MgixfgPJ6agbtyhb5
 HS1uCgfN1/Nl4BibOaSJBijQDgCR88GKW6NF9IJP8tL7KySBkqJENHQddIXPtb9LXzLz
 M4FcufhWBogEwx7QF8ycS8AhOS0wIe4yGnpLQt9eQrXyCHI+4U67QjicLNyXcRJKsPE2
 f84XNKo1yuIPpiJZN240Tt3NcUlC/td7ovGNlViu3U8vfE4h308MvtE7AtwN+j0X5cOf
 mk05zhSf+YIZnX8PimDhobU1xL9CwJDSzvTAJVSXz1CSx3cKOzh3UmJy8IVgSf7zNIrs
 wQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794910251; x=1795515051;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XRG0of1hoB/vT6BmhYVlnUACQ1Af/rDzfjGnNwGAsNE=;
 b=qQ5SX+AAjRcKQ/KaObHIvnfk/qXk7N4QSSqkFJ21/aGKlwdbPmqN1dzfJAf/PM/QQ+
 1S0ALNbc/ebpzSRpkpvA4Xe/vIi9t+mXuWzb9ZgSXIDPEcpoE7V0ANlJMGxp8j/YaHuy
 kY9oon3Ssz+/A9pt3ZTtUJZckU5KTuQZghMx/JPw5J0vKZG1fQcb+sSGcQDZa5JFnsve
 yOWlf/P2GHbOjNDvIv/vdaTtg9yqV20+A0Bqd88pTfuzBdpwx5yFxAji2JwR8ljy7nww
 M4FfWDzQ9ABACUEX1FM7p66GxvW7MSQV7vebOqmw7tC801xqv2Z/o4zLnhzMW6xaOgQ3
 jhpQ==
X-Gm-Message-State: APuU4Z9jXMYmIJSC2IPk3YwojVs/uXXTwL+itvzPaEnZHuOoIiUwA2G2
 GaZZaMfZq6Imzz8Dsg8DWZYbpB+I78vHnh5tbQvJvyAwlsCoiPyW8mFH3wfJNh9CpUoVPKchv6e
 UfhQdd8ROF9w6pVfqMO75m67gV17n3nQhO2GCOjCX1kQQduDZJjJTMlMNwnuh69l8I4EoW0X8Pp
 pBibICxOrfjT9hwFp4VPXodZGbOkqybAoBuT8Sxl6KOgs=
X-Gm-Gg: AYBFou0EMPVKGepOsQVR/ghETXbAOzC0DcjopnBjck/pJFr+Pp91T/D1eWRZLkQmfsG
 1oYpGliAnC/2JVJuQ8+Q6x2kq/L5XNtT6D3IgCjHwfYmJbmpZPjw8VaxqGyhzoKJTK9qSsWoutf
 qnxX0wsioSPdzpmvW6NNzTOruQ3POQdmM6AhjVIm8gkK89/0sQ/Ox1zQ0e1vXZd0lN/ffLLoupC
 x7JgrW17VgsE6RSNAHYZ8zepQ/ICoLFew5FHFd00dNVq7m5stP5mkL1YATFoqJNFR0+KrV9TgAD
 RtBcPatZKnQ5+crZHPxG4OXUVaq14JZ1ukIs0BejocGUdnrnEe0RJ1dSbgD/Rx634ZK9GpZ6cku
 6PF6L/jHNHBV8+xrnOmPMXm2AwW3iHviva2FWosG8ex0gcmBngyWfHk4GIXbBO1a4Ja+xh3aaO/
 +WnOL8i7G81alYsGFcRXPwNcrW8hLnqollkWs6PwqZyk2Y1CT3Ve/gGJwXfuGP5fsjiTwR+6tGf
 9xGjT3PG8MY72frSOkO9uqqgWMj/fdLKZt9tiTcsZdRfyCg/IXlL2XNyyNU9O/7pLGjWHb5FBqs
 Pv+X8ZA6yaB5dp2Nxtub/DqGOYSc7nfgD5xWuShpl/UOCR29VJ+x
X-Received: by 2002:a17:906:5146:10b0:c46:645f:cedf with SMTP id
 a640c23a62f3a-c5096398ad5mr870718766b.15.1794910250698; 
 Tue, 17 Nov 2026 02:10:50 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com.
 [209.85.218.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b5ac2asm516770466b.55.2026.11.17.02.10.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 02:10:50 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c40f29667e6so783030866b.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 02:10:50 -0800 (PST)
X-Received: by 2002:a17:907:1b0a:b0:c50:5e0a:fbad with SMTP id
 a640c23a62f3a-c5096430d02mr1091376066b.39.1794910249512; Tue, 17 Nov 2026
 02:10:49 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
 <20260825-upstream-ntrace_core-v1-12-f8be2f40d2fd@gmail.com>
In-Reply-To: <20260825-upstream-ntrace_core-v1-12-f8be2f40d2fd@gmail.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Tue, 17 Nov 2026 18:10:37 +0800
X-Gmail-Original-Message-ID: <CAMXXpfY78gE8yF3JtO2hZQZnnOk2tdOcRK1jmSghyP3SEUwRnA@mail.gmail.com>
X-Gm-Features: AclHuK9xeWnLO3wFTUj_NbICCo2aLMzi7A42H3UG-x9cW3ci5-RBGmNTibIBGNg
Message-ID: <CAMXXpfY78gE8yF3JtO2hZQZnnOk2tdOcRK1jmSghyP3SEUwRnA@mail.gmail.com>
Subject: Re: [PATCH 12/13] hw/riscv/trace-encoder.c: remaining fields to
 ram-sink as RO values
To: Konstantin Semichastnov <antikostya2@gmail.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexei Filippov <halip0503@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000d375f30660761b1b"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=jay.chang@sifive.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000d375f30660761b1b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Jay Chang<jay.chang@sifive.com>
Thanks

On Tue, Aug 25, 2026 at 10:49=E2=80=AFPM Konstantin Semichastnov <
antikostya2@gmail.com> wrote:

>  - set trRamActive RO =3D 1 (always active)
>  - set trRamEnable RO =3D 1 (always enabled)
>  - set trRamMode RO =3D 1 (only SMEM mode)
>  - set trRamStopOnWrap RO =3D 0 (not supported)
>  - set trRamMemFormat RO =3D 0 (memory formatted as plain bytes)
>  - set trRamAsyncFreq RO =3D 0 (alignment synchronization packets disable=
d)
>  - set trRamHasSMEM =3D 1 (RAM sink supports SMEM)
>
> Signed-off-by: Konstantin Semichastnov <antikostya2@gmail.com>
> ---
>  hw/riscv/trace-ram-sink.c | 22 +++++++++++++++++++++-
>  hw/riscv/trace-ram-sink.h |  1 +
>  2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/trace-ram-sink.c b/hw/riscv/trace-ram-sink.c
> index c273335fec..03ffa9caae 100644
> --- a/hw/riscv/trace-ram-sink.c
> +++ b/hw/riscv/trace-ram-sink.c
> @@ -40,13 +40,33 @@
>                                 R_TR_RAM_IMPL_HAS_SRAM_MASK | \
>                                 R_TR_RAM_IMPL_HAS_SMEM_MASK)
>
> -#define R_TR_RAM_IMPL_RESET (BIT(0) | 0x9 << 8)
> +#define R_TR_RAM_IMPL_RESET (BIT(0) | 0x9 << 8 |
> R_TR_RAM_IMPL_HAS_SMEM_MASK)
> +
> +static uint64_t tr_ramsink_ctrl_set_hardwire_vals(uint64_t input)
> +{
> +    input =3D FIELD_DP32(input, TR_RAM_CONTROL, ACTIVE, 1);
> +    input =3D FIELD_DP32(input, TR_RAM_CONTROL, ENABLE, 1);
> +    input =3D FIELD_DP32(input, TR_RAM_CONTROL, MODE, 1);
> +    input =3D FIELD_DP32(input, TR_RAM_CONTROL, STOP_ON_WRAP, 0);
> +    input =3D FIELD_DP32(input, TR_RAM_CONTROL, MEM_FORMAT, 0);
> +    input =3D FIELD_DP32(input, TR_RAM_CONTROL, ASYNC_FREQ, 0);
> +
> +    return input;
> +}
> +
> +static uint64_t tr_ramsink_ctrl_prew(RegisterInfo *reg, uint64_t val)
> +{
> +    val =3D tr_ramsink_ctrl_set_hardwire_vals(val);
> +
> +    return val;
> +}
>
>  static RegisterAccessInfo tr_ramsink_regs_info[] =3D {
>      {   .name =3D "TR_RAM_CONTROL", .addr =3D A_TR_RAM_CONTROL,
>          .rsvd =3D R_TR_RAM_CONTROL_RSVP_BITS,
>          .reset =3D R_TR_RAM_CONTROL_RESET,
>          .ro =3D R_TR_RAM_CONTROL_RO_BITS,
> +        .pre_write =3D tr_ramsink_ctrl_prew,
>      },
>      {   .name =3D "TR_RAM_IMPL", .addr =3D A_TR_RAM_IMPL,
>          .rsvd =3D R_TR_RAM_IMPL_RSVP_BITS,
> diff --git a/hw/riscv/trace-ram-sink.h b/hw/riscv/trace-ram-sink.h
> index 0a7225642c..e516b73e00 100644
> --- a/hw/riscv/trace-ram-sink.h
> +++ b/hw/riscv/trace-ram-sink.h
> @@ -28,6 +28,7 @@ REG32(TR_RAM_CONTROL, 0x0)
>      FIELD(TR_RAM_CONTROL, MODE, 4, 1)
>      FIELD(TR_RAM_CONTROL, STOP_ON_WRAP, 8, 1)
>      FIELD(TR_RAM_CONTROL, MEM_FORMAT, 9, 2)
> +    FIELD(TR_RAM_CONTROL, ASYNC_FREQ, 12, 3)
>      /* reserved bits */
>      FIELD(TR_RAM_CONTROL, RSVP1, 2, 1)
>      FIELD(TR_RAM_CONTROL, RSVP2, 5, 3)
>
> --
> 2.43.0
>
>
>

--000000000000d375f30660761b1b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Jay Chang&lt;<a href=3D"mailto:jay.chang@sifi=
ve.com" target=3D"_blank">jay.chang@sifive.com</a>&gt;<div>Thanks</div></di=
v><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Tue, Aug 25, 2026 at 10:49=E2=80=AFPM Konstantin Semic=
hastnov &lt;<a href=3D"mailto:antikostya2@gmail.com">antikostya2@gmail.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
=C2=A0- set trRamActive RO =3D 1 (always active)<br>
=C2=A0- set trRamEnable RO =3D 1 (always enabled)<br>
=C2=A0- set trRamMode RO =3D 1 (only SMEM mode)<br>
=C2=A0- set trRamStopOnWrap RO =3D 0 (not supported)<br>
=C2=A0- set trRamMemFormat RO =3D 0 (memory formatted as plain bytes)<br>
=C2=A0- set trRamAsyncFreq RO =3D 0 (alignment synchronization packets disa=
bled)<br>
=C2=A0- set trRamHasSMEM =3D 1 (RAM sink supports SMEM)<br>
<br>
Signed-off-by: Konstantin Semichastnov &lt;<a href=3D"mailto:antikostya2@gm=
ail.com" target=3D"_blank">antikostya2@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/riscv/trace-ram-sink.c | 22 +++++++++++++++++++++-<br>
=C2=A0hw/riscv/trace-ram-sink.h |=C2=A0 1 +<br>
=C2=A02 files changed, 22 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/hw/riscv/trace-ram-sink.c b/hw/riscv/trace-ram-sink.c<br>
index c273335fec..03ffa9caae 100644<br>
--- a/hw/riscv/trace-ram-sink.c<br>
+++ b/hw/riscv/trace-ram-sink.c<br>
@@ -40,13 +40,33 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 R_TR_RAM_IMPL_HAS_SRAM_MASK | \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 R_TR_RAM_IMPL_HAS_SMEM_MASK)<br>
<br>
-#define R_TR_RAM_IMPL_RESET (BIT(0) | 0x9 &lt;&lt; 8)<br>
+#define R_TR_RAM_IMPL_RESET (BIT(0) | 0x9 &lt;&lt; 8 | R_TR_RAM_IMPL_HAS_S=
MEM_MASK)<br>
+<br>
+static uint64_t tr_ramsink_ctrl_set_hardwire_vals(uint64_t input)<br>
+{<br>
+=C2=A0 =C2=A0 input =3D FIELD_DP32(input, TR_RAM_CONTROL, ACTIVE, 1);<br>
+=C2=A0 =C2=A0 input =3D FIELD_DP32(input, TR_RAM_CONTROL, ENABLE, 1);<br>
+=C2=A0 =C2=A0 input =3D FIELD_DP32(input, TR_RAM_CONTROL, MODE, 1);<br>
+=C2=A0 =C2=A0 input =3D FIELD_DP32(input, TR_RAM_CONTROL, STOP_ON_WRAP, 0)=
;<br>
+=C2=A0 =C2=A0 input =3D FIELD_DP32(input, TR_RAM_CONTROL, MEM_FORMAT, 0);<=
br>
+=C2=A0 =C2=A0 input =3D FIELD_DP32(input, TR_RAM_CONTROL, ASYNC_FREQ, 0);<=
br>
+<br>
+=C2=A0 =C2=A0 return input;<br>
+}<br>
+<br>
+static uint64_t tr_ramsink_ctrl_prew(RegisterInfo *reg, uint64_t val)<br>
+{<br>
+=C2=A0 =C2=A0 val =3D tr_ramsink_ctrl_set_hardwire_vals(val);<br>
+<br>
+=C2=A0 =C2=A0 return val;<br>
+}<br>
<br>
=C2=A0static RegisterAccessInfo tr_ramsink_regs_info[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0{=C2=A0 =C2=A0.name =3D &quot;TR_RAM_CONTROL&quot;, .ad=
dr =3D A_TR_RAM_CONTROL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.rsvd =3D R_TR_RAM_CONTROL_RSVP_BITS,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.reset =3D R_TR_RAM_CONTROL_RESET,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.ro =3D R_TR_RAM_CONTROL_RO_BITS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .pre_write =3D tr_ramsink_ctrl_prew,<br>
=C2=A0 =C2=A0 =C2=A0},<br>
=C2=A0 =C2=A0 =C2=A0{=C2=A0 =C2=A0.name =3D &quot;TR_RAM_IMPL&quot;, .addr =
=3D A_TR_RAM_IMPL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.rsvd =3D R_TR_RAM_IMPL_RSVP_BITS,<br>
diff --git a/hw/riscv/trace-ram-sink.h b/hw/riscv/trace-ram-sink.h<br>
index 0a7225642c..e516b73e00 100644<br>
--- a/hw/riscv/trace-ram-sink.h<br>
+++ b/hw/riscv/trace-ram-sink.h<br>
@@ -28,6 +28,7 @@ REG32(TR_RAM_CONTROL, 0x0)<br>
=C2=A0 =C2=A0 =C2=A0FIELD(TR_RAM_CONTROL, MODE, 4, 1)<br>
=C2=A0 =C2=A0 =C2=A0FIELD(TR_RAM_CONTROL, STOP_ON_WRAP, 8, 1)<br>
=C2=A0 =C2=A0 =C2=A0FIELD(TR_RAM_CONTROL, MEM_FORMAT, 9, 2)<br>
+=C2=A0 =C2=A0 FIELD(TR_RAM_CONTROL, ASYNC_FREQ, 12, 3)<br>
=C2=A0 =C2=A0 =C2=A0/* reserved bits */<br>
=C2=A0 =C2=A0 =C2=A0FIELD(TR_RAM_CONTROL, RSVP1, 2, 1)<br>
=C2=A0 =C2=A0 =C2=A0FIELD(TR_RAM_CONTROL, RSVP2, 5, 3)<br>
<br>
-- <br>
2.43.0<br>
<br>
<br>
</blockquote></div>

--000000000000d375f30660761b1b--

