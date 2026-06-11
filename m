Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EE0CD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXcgD-0005vq-IW; Thu, 11 Jun 2026 06:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wXcg0-0005tm-RJ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 06:30:29 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wXcfy-0004qq-Rk
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 06:30:20 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bebde89cfd3so999982466b.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 03:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1781173817; x=1781778617; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p77B0xYauOL4J7Ev1UzSvLivahywcH0/3Wx4E1msO2c=;
 b=d6/k2GsBZDBpfMKFXphH/Rkl6R4v7EQMf2H1ahfBBBzGEsURI6e0h7a9/XGNzEuU/W
 Z6bnnfdNFewGoqr4eus4rmRtKihifI/w5LkCPHB9zGxQzm4JNVxlNOq/+KExFuL6nQDk
 3vz61+9SjsbDPgl4PyqtkMRgqhB5noBGEzFZWy3C+q9gmOkAI4wmEvwMGuR7Tr5eHBfH
 sjuLS2op/A94qPOdOASvlJGUnI8xxNmDfOGGZitvGpT4yd07N0MOQ6VfkOqrWmhB5AXH
 etJevA4LZwcsGYFLMymGMgFlV8+kZz7F31qc4jaSEfCysbfeb4unv7FVcjKWnNN/yGd6
 bbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781173817; x=1781778617;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p77B0xYauOL4J7Ev1UzSvLivahywcH0/3Wx4E1msO2c=;
 b=qf8jHP9l+qJ8LUWlu7faxI/+npb/A5Or8dJxoU0LsZAYPosKUeVy5kyvsL+zLz7xKB
 PFmjK1cVD+uGFd4YWKsulwl+3gTwuyzgedN+QSkEvRGflDUE57FQICyJ9ce7n1Rag4j/
 4ucBui9gBxfcmwtnPs/pXdmHTelkM9gt4EIowg2dlwLtj28RlWB6jLbyer2tjbQGSsRQ
 W5Q8wXUBHFRVZ34KZ/cTH5qyuY7ZkMYqUxiloykvd/9xDmTuH2pcVhtJwNqiQdimOXAi
 j8mNJ3StT0b0p7qstGCLe2UOBcVpoLv7oYMotU9MAUc96ozoy46sdawogF9fAASCvi2e
 xK9g==
X-Gm-Message-State: AOJu0Yxzw7jyHUAgz2LYeKXII4SVENXwXjd62Wietv9jYpG8Ow9+/4Fr
 bIZS7hJgWieTdxRWZD95iU2NkGkCk7rTkFiRIzIqbsMdfePOnoxf+XWgKq3WcpcWmIq0QVKGG28
 RYO3YbeGErMv2UMN7lTLaaIofbXFY0UGe20njdsptVe7O70UEJYcGimXTyNk8Ud8TEqwWxE5HKA
 s2QNLmNAsuGopWPqhCRxbGt5vfU+CSc2T/XaYnUPZ3wWE=
X-Gm-Gg: Acq92OFMNiNav+mkVjZVtL0tHQSkftUqbiTYTALWe5J0RPBllwMBMke16R1pcGw0+S5
 4mNMRr3yzB0gu9/kiP2eJnOQSJebBPUwD/YCg4fQ58ZImrl2XLq9Ua6rFnggxMBS8IrCH6EJu3N
 R61xSXPys8Ys80aMee3ck2J7xU1jnOx3uCAoMttSwtFbAa0cZxAb6SuKj640vONVPxqppoZRe45
 yOWNlIKcqk1pON4pcUb1MAdtuuGdbMyCCowex+mIewpDTg5yRWt9dpX5MgNr0Gh6F9LDUajRyui
 P5CIdA9+J9dIXebMrz3hT5mvotdZEUo8S2ruAgUawlcQBdHwZg/BqnmhKjg5hiEiwOWYkj+FPFt
 vzvEbmr5JYaZ5DKA9/wjLPkDR1YToblL+jeRNt/6IAt39W5+DtlPEvwYgo31iyjO+9fS+E63YS1
 32WvXthVeQzH/8jpzEbjx7RSsG6wSHOoXvWWolwpahjug575LDqSH00FhCjWxKMRZns56RNG0=
X-Received: by 2002:a17:907:2707:b0:bdb:e19d:525c with SMTP id
 a640c23a62f3a-bfc88206125mr70729166b.33.1781173816575; 
 Thu, 11 Jun 2026 03:30:16 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com.
 [209.85.208.42]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfcb0f14edbsm45733866b.3.2026.06.11.03.30.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 03:30:14 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-68f36e1663cso13998875a12.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 03:30:14 -0700 (PDT)
X-Received: by 2002:a05:6402:1466:b0:691:956a:cf72 with SMTP id
 4fb4d7f45d1cf-6930e32ccc2mr974940a12.17.1781173814308; Thu, 11 Jun 2026
 03:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260318185238.99143-1-luisccunha8@gmail.com>
 <20260318185238.99143-3-luisccunha8@gmail.com>
In-Reply-To: <20260318185238.99143-3-luisccunha8@gmail.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Thu, 11 Jun 2026 18:30:02 +0800
X-Gmail-Original-Message-ID: <CAMXXpfZEr0aChYeq+HQRj3WnjtjiF-cqo8sd5HVbqP6S8z0VDg@mail.gmail.com>
X-Gm-Features: AVVi8CftBZgSovfDygZljDPOBtIbRXeRU2B7Bv1ik7oU_qqkIv74cJ7OpPvmnVM
Message-ID: <CAMXXpfZEr0aChYeq+HQRj3WnjtjiF-cqo8sd5HVbqP6S8z0VDg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] target/riscv: Add SPMP CSR configuration
To: luisccc <luisccunha8@gmail.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>, frank.chang@sifive.com
Content-Type: multipart/alternative; boundary="0000000000007c35d10653f7d80a"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=jay.chang@sifive.com; helo=mail-ej1-x630.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000007c35d10653f7d80a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 3:46=E2=80=AFAM luisccc <luisccunha8@gmail.com> wro=
te:

> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> +static bool xiselect_spmp_range(target_ulong isel)
> +{
> +    return (ISELECT_SPMP_BASE <=3D isel &&
> +            isel <=3D ISELECT_SPMP_BASE + MAX_RISCV_SPMPS);
> +}
>
0 <=3D isel <=3D 64 indicates that there are 65 valid entries in total.

> +static int rmw_xireg_spmp(CPURISCVState *env, int csrno,
> +                        target_ulong isel, target_ulong *val,
> +                        target_ulong new_val, target_ulong wr_mask)
> +{
> +    int index =3D 0;
> +    bool m_mode_access =3D false;
> +
> +    /* Read 0 and write ignore if no rules are delegated */
> +    if (env->spmp_state.num_deleg_rules =3D=3D 0) {
> +        *val =3D 0;
>
Maybe we should avoid dereferencing NULL
if (val) {
*val =3D 0;
}

> +        return 0;
> +    }
> +
> +    index =3D isel - ISELECT_SPMP_BASE;
> +
> +    switch (csrno) {
> +    case CSR_MIREG:
> +        /* If M mode, signal it */
> +        m_mode_access =3D true;
> +        [[fallthrough]];
> +    case CSR_SIREG:
> +        if (val) {
> +            *val =3D spmpaddr_csr_read(env, index);
> +        }
> +
> +        spmpaddr_csr_write(env, index, new_val & wr_mask, m_mode_access)=
;
> +        break;
> +    case CSR_MIREG2:
> +        /* If M mode, signal it */
> +        m_mode_access =3D true;
> +        [[fallthrough]];
> +    case CSR_SIREG2:
> +        index =3D isel - ISELECT_SPMP_BASE;
>
Duplicate setting index ?

Spec says : The mireg3 through mireg6 are reserved.
Maybe
    /* Reserved as WPRI - read returns 0, write ignored */
    case CSR_SIREG3:
        /* fallthrough */
    case CSR_SIREG4 ... CSR_SIREG6:
        /* fallthrough */
    case CSR_MIREG3:
        /* fallthrough */
    case CSR_MIREG4 ... CSR_MIREG6:
        if (val) {
            *val =3D 0;
        }
        break;

--=20
> 2.43.0
>
>
>

--0000000000007c35d10653f7d80a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 19,=
 2026 at 3:46=E2=80=AFAM luisccc &lt;<a href=3D"mailto:luisccunha8@gmail.co=
m">luisccunha8@gmail.com</a>&gt; wrote:</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
diff --git a/target/riscv/csr.c b/target/riscv/csr.c<br>
+static bool xiselect_spmp_range(target_ulong isel)<br>
+{<br>
+=C2=A0 =C2=A0 return (ISELECT_SPMP_BASE &lt;=3D isel &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 isel &lt;=3D ISELECT_SPMP_BASE +=
 MAX_RISCV_SPMPS);<br>
+}<br></blockquote><div><code class=3D"gmail-p8i6j0f">0 &lt;=3D isel &lt;=
=3D 64</code> indicates that there are 65 valid entries in total.</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
+static int rmw_xireg_spmp(CPURISCVState *env, int csrno,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 target_ulong isel, target_ulong *val,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 target_ulong new_val, target_ulong wr_mask)<br>
+{<br>
+=C2=A0 =C2=A0 int index =3D 0;<br>
+=C2=A0 =C2=A0 bool m_mode_access =3D false;<br>
+<br>
+=C2=A0 =C2=A0 /* Read 0 and write ignore if no rules are delegated */<br>
+=C2=A0 =C2=A0 if (env-&gt;spmp_state.num_deleg_rules =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *val =3D 0;<br></blockquote><div>Maybe we shou=
ld avoid dereferencing NULL<br>if (val) {</div><div>*val =3D 0;</div><div>}=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 index =3D isel - ISELECT_SPMP_BASE;<br>
+<br>
+=C2=A0 =C2=A0 switch (csrno) {<br>
+=C2=A0 =C2=A0 case CSR_MIREG:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If M mode, signal it */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 m_mode_access =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [[fallthrough]];<br>
+=C2=A0 =C2=A0 case CSR_SIREG:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *val =3D spmpaddr_csr_read(env, =
index);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 spmpaddr_csr_write(env, index, new_val &amp; w=
r_mask, m_mode_access);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case CSR_MIREG2:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If M mode, signal it */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 m_mode_access =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [[fallthrough]];<br>
+=C2=A0 =C2=A0 case CSR_SIREG2:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D isel - ISELECT_SPMP_BASE;<br></block=
quote><div>Duplicate setting index ?</div><div><br>Spec says :=C2=A0The mir=
eg3 through mireg6 are reserved.<br>Maybe<br>=C2=A0 =C2=A0 /* Reserved as W=
PRI - read returns 0, write ignored */<br>=C2=A0 =C2=A0 case CSR_SIREG3:<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fallthrough */<br>=C2=A0 =C2=A0 case CSR_SI=
REG4 ... CSR_SIREG6:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fallthrough */<br>=
=C2=A0 =C2=A0 case CSR_MIREG3:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fallthroug=
h */<br>=C2=A0 =C2=A0 case CSR_MIREG4 ... CSR_MIREG6:<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (val) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *val =3D=
 0;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<=
br><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
-- <br>
2.43.0<br>
<br>
<br>
</blockquote></div></div>

--0000000000007c35d10653f7d80a--

