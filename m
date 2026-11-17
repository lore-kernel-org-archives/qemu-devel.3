Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D5D606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=eRmkt6gs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTFDO-00076r-QK; Tue, 17 Nov 2026 04:10:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xTFDN-000767-6u
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:10:57 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xTFDL-0001oN-Cf
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:10:56 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c4203bbb1e9so747107866b.3
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 01:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1794906654; x=1795511454; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aRfquUDAPsLpa9/2xbyG+SbrtcQRB0PT56U1jR1xO1c=;
 b=eRmkt6gslybPRjE2C8rcQjgkhPGJKlDNkqnoHXwBMMKD0+TToKXaxG2CtDnWSe0zCk
 a2aKdnINsl9s5AY8IA052/ktZwarhVqZy4C5PZnTJoaOMpyaPwChhwXdMJQeaHQ/VzFn
 1bFY8Mqvnn1f0dMU5R67IxW2X2afk95c7sA6YbY27ErNjALdrWwMr9O/ieHd3p/8yC5P
 BSPjOIVAXC4KC3HK3P7QFxgV2FsHHsaawN4hzn4quZuq+fCZrhMafWpFQfFiQk8L1Jv9
 dbvJT9p0oj9x7KZRQM/ytgMB7+lBLG/skCliqpbCWTKofi9rxIrn/dZ1RYH98+YiBuqC
 OCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794906654; x=1795511454;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aRfquUDAPsLpa9/2xbyG+SbrtcQRB0PT56U1jR1xO1c=;
 b=d107H+niMcMOwdAGrwZnMRXF/5indzWf1kpIAhfWfvzq67bBS7yNyVfEMkWSYVDpJT
 zIWGC5IN3A7xOySkei0opKux6jjpt9BMU5MIWNGC8ZdzWK2ZrmrCEnPfNeCS3GMeKHYR
 ba4OC857qE/BUmoQCmoKU+y4BAdf0unrvPRuH8z9wPWCxqGfDOUDF8fIUAYlVtaCR8YQ
 q26xfP0hzBU1sylCIPzl4EgAM8wuGF5FZgLHPzHUKWtn8nK+afA2jE3mU3XTyF9jnjj0
 qt4JvWSiu9kCQHiwYJ9LCcPd3M0viAJ135Ftveo6TMDX1njeR5L1x0UpnCC1j2IWfRCF
 NEIg==
X-Gm-Message-State: APuU4Z87ZZ2DHkVXi2UuJ+iY2gtNhRF8csYndwTcr4bTOo5E+niw16ce
 hZoWn78XhFxV4fesIe2lmDACXodlviIciZVapJbbQXfkTsAFiBP7naXXXFCxQbh9NAqV3ZLfaI2
 wAtNsDIbnsP3bsfS7klUaiO3xtU09/W7CzQ8iV5fp2CgD/0Jx32hVm9uBjKl/R6Gks15GBL2FzZ
 RtR7AT0Blkt1aBKC2+hUw+penStJ/cz8fP8sIJAb303yk=
X-Gm-Gg: AYBFou3ADfV5qBhRD8YeVxtQeCDswQpJSdgWfFV9Ep2R0mKtC8xjRnGCUCKd/BqvWqV
 iutSsQGYfRR1ZKZKB8pffKrk46fzbw4WO4rXneYNe01mBRusXX0VhyaCwsMzbPgv6dDl5cCFW5E
 El+kvZvTJaPLN9+egvlQrLsneQHoE1+/ndw7u8Rtem+AOb3MboiAwwPib/wK3M5TzGyQm0METM9
 640fM7j+IvAvZ0NyF/+kh0fPtVyTZzXyJ4GYQ96v7l3jxviLT3avTE6ilbFnfwEgERN/SZtdXix
 omDYWczP0AZkWQ2mWFAPgvVNtpKcxABZzpDaqqaL39VlppQZzrm5Gqhloutr+RXzoR1eE84WYTx
 kyL068m4e8AU3uUPL8IPjC5uK9J4Efr+FMqU4056XRjcL9D6aL6DnlkqN7HuC5NqNEwKlL0Jw/D
 A/3vM4rMgP+wmY/+HosE0R8mfuTtvCAFzyLLsjq2hdFM8sIfXtZ5dnpgJeFar+bjSh2Ct3GS8xu
 MzD4MYMxOOuPU/20Kp1d7qAxH9CGLKlBozJVirRPBZBWgCh7QJdTTvcReQfofdk0Xz7hp5/4dMH
 Op93AZ5Qzhvr7Jvj71z07poLhCs4+0dGXbnJ8GntgIqIEKZI6H41G+4r6rhB8Jh6mMc=
X-Received: by 2002:a17:907:1c85:b0:c49:b8ec:a9e3 with SMTP id
 a640c23a62f3a-c50963bbc82mr1148728966b.43.1794906653692; 
 Tue, 17 Nov 2026 01:10:53 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com.
 [209.85.208.42]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b79d19sm514400366b.71.2026.11.17.01.10.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 01:10:52 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6b85bc2bf9dso697215a12.3
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 01:10:52 -0800 (PST)
X-Received: by 2002:a05:6402:a513:10b0:6b7:186:e60b with SMTP id
 4fb4d7f45d1cf-6b7c0891425mr7749743a12.5.1794906651535; Tue, 17 Nov 2026
 01:10:51 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
 <20260825-upstream-ntrace_core-v1-4-f8be2f40d2fd@gmail.com>
In-Reply-To: <20260825-upstream-ntrace_core-v1-4-f8be2f40d2fd@gmail.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Tue, 17 Nov 2026 17:10:40 +0800
X-Gmail-Original-Message-ID: <CAMXXpfYGwRLKurEaC3ypaWL=BdDbASZuSYxFXeFC35rKn-GVfQ@mail.gmail.com>
X-Gm-Features: AclHuK-dqqgmNgt4vsN72xM89LbqEydezYISjPky5Sh_z0QS4_iMlNzGs9s5F0w
Message-ID: <CAMXXpfYGwRLKurEaC3ypaWL=BdDbASZuSYxFXeFC35rKn-GVfQ@mail.gmail.com>
Subject: Re: [PATCH 04/13] hw/riscv/trace-encoder.c: align ntrace messages
 with ones
To: Konstantin Semichastnov <antikostya2@gmail.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexei Filippov <halip0503@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000005eaf97066075458f"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=jay.chang@sifive.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000005eaf97066075458f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Jay Chang<jay.chang@sifive.com>
Thanks

On Tue, Aug 25, 2026 at 10:49=E2=80=AFPM Konstantin Semichastnov <
antikostya2@gmail.com> wrote:

> N-Trace format requires idle bytes to be filled with 0xff, instead of
> zeroes, like E-Trace format
>
> Signed-off-by: Konstantin Semichastnov <antikostya2@gmail.com>
> ---
>  hw/riscv/trace-encoder.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
> index 10e52e207e..703454c9b7 100644
> --- a/hw/riscv/trace-encoder.c
> +++ b/hw/riscv/trace-encoder.c
> @@ -398,21 +398,35 @@ static void trencoder_send_message_smem(TraceEncode=
r
> *trencoder,
>      hwaddr dest =3D trencoder_read_ramsink_writep(trencoder);
>      bool wrapped =3D false;
>
> +    if (trencoder->ntrace) {
> +        /*
> +         * RISC-V N-Trace 3.1. MSEO Sequences:
> +         * idle bytes in N-Trace format are filled with 0xff, instead of
> zeroes
> +         */
> +        memset(msg + msg_size, 0xff, 4 - msg_size % 4);
> +    }
>      msg_size =3D QEMU_ALIGN_UP(msg_size, 4);
>
>      /* clear trRamWrap before writing to SMEM */
>      dest =3D FIELD_DP64(dest, TR_RAM_WP_LOW, WRAP, 0);
>
>      /*
> -     * Fill with null bytes if we can't fit the packet in
> +     * Fill with idle bytes if we can't fit the packet in
>       * ramlimit, set wrap and write the packet in ramstart.
>       */
>      if (dest + msg_size > trencoder->ramsink_ramlimit) {
> -        g_autofree uint8_t *null_packet =3D NULL;
> -        uint8_t null_size =3D trencoder->ramsink_ramlimit - dest;
> +        g_autofree uint8_t *idle_packet =3D NULL;
> +        uint8_t idle_size =3D trencoder->ramsink_ramlimit - dest;
>
> -        null_packet =3D g_malloc0(null_size);
> -        cpu_physical_memory_write(dest, null_packet, null_size);
> +        idle_packet =3D g_malloc0(idle_size);
> +        if (trencoder->ntrace) {
> +            /*
> +             * RISC-V N-Trace 3.1. MSEO Sequences:
> +             * idle bytes in N-Trace format are filled with 0xff, instea=
d
> of zeroes
> +             */
> +            memset(idle_packet, 0xff, idle_size);
> +        }
> +        cpu_physical_memory_write(dest, idle_packet, idle_size);
>
>          dest =3D trencoder->ramsink_ramstart;
>          wrapped =3D true;
>
> --
> 2.43.0
>
>
>

--0000000000005eaf97066075458f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Jay Chang&lt;<a href=3D"mailto:jay.chang@sifi=
ve.com" target=3D"_blank">jay.chang@sifive.com</a>&gt;<div>Thanks</div></di=
v><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Tue, Aug 25, 2026 at 10:49=E2=80=AFPM Konstantin Semic=
hastnov &lt;<a href=3D"mailto:antikostya2@gmail.com">antikostya2@gmail.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">N=
-Trace format requires idle bytes to be filled with 0xff, instead of<br>
zeroes, like E-Trace format<br>
<br>
Signed-off-by: Konstantin Semichastnov &lt;<a href=3D"mailto:antikostya2@gm=
ail.com" target=3D"_blank">antikostya2@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/riscv/trace-encoder.c | 24 +++++++++++++++++++-----<br>
=C2=A01 file changed, 19 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c<br>
index 10e52e207e..703454c9b7 100644<br>
--- a/hw/riscv/trace-encoder.c<br>
+++ b/hw/riscv/trace-encoder.c<br>
@@ -398,21 +398,35 @@ static void trencoder_send_message_smem(TraceEncoder =
*trencoder,<br>
=C2=A0 =C2=A0 =C2=A0hwaddr dest =3D trencoder_read_ramsink_writep(trencoder=
);<br>
=C2=A0 =C2=A0 =C2=A0bool wrapped =3D false;<br>
<br>
+=C2=A0 =C2=A0 if (trencoder-&gt;ntrace) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* RISC-V N-Trace 3.1. MSEO Sequences:<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* idle bytes in N-Trace format are fille=
d with 0xff, instead of zeroes<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(msg + msg_size, 0xff, 4 - msg_size % 4)=
;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0msg_size =3D QEMU_ALIGN_UP(msg_size, 4);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* clear trRamWrap before writing to SMEM */<br>
=C2=A0 =C2=A0 =C2=A0dest =3D FIELD_DP64(dest, TR_RAM_WP_LOW, WRAP, 0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
-=C2=A0 =C2=A0 =C2=A0* Fill with null bytes if we can&#39;t fit the packet =
in<br>
+=C2=A0 =C2=A0 =C2=A0* Fill with idle bytes if we can&#39;t fit the packet =
in<br>
=C2=A0 =C2=A0 =C2=A0 * ramlimit, set wrap and write the packet in ramstart.=
<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if (dest + msg_size &gt; trencoder-&gt;ramsink_ramlimit=
) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree uint8_t *null_packet =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t null_size =3D trencoder-&gt;ramsink_ra=
mlimit - dest;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree uint8_t *idle_packet =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t idle_size =3D trencoder-&gt;ramsink_ra=
mlimit - dest;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 null_packet =3D g_malloc0(null_size);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_physical_memory_write(dest, null_packet, n=
ull_size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 idle_packet =3D g_malloc0(idle_size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (trencoder-&gt;ntrace) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* RISC-V N-Trace 3.1. MSEO=
 Sequences:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* idle bytes in N-Trace fo=
rmat are filled with 0xff, instead of zeroes<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(idle_packet, 0xff, idle_s=
ize);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_physical_memory_write(dest, idle_packet, i=
dle_size);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dest =3D trencoder-&gt;ramsink_ramstart;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wrapped =3D true;<br>
<br>
-- <br>
2.43.0<br>
<br>
<br>
</blockquote></div>

--0000000000005eaf97066075458f--

