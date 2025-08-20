Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65C5CA0EED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoe5I-00028e-Iv; Wed, 20 Aug 2025 04:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoe51-00027B-On; Wed, 20 Aug 2025 04:22:01 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoe4z-0000HG-9p; Wed, 20 Aug 2025 04:21:59 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-245f19aab74so2763355ad.0; 
 Wed, 20 Aug 2025 01:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755678115; x=1756282915; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IFHuGe5C8GzHXoHqKxoYfg8O2jjmuHuyJkDrmSEBnYM=;
 b=BkVLfaAh7LYJhSwwKSTwJPO4/PcX31DveeKxTzahzYi6Y69iR6Z6EfseEnDWjt7ptJ
 hOcMYfv+scI1NmivC7mjPJPupJSgr3SFO2jkFakRhfwsqOxI5c/S7kZuxBwurdjGJsFs
 l23HQvGoKnlB/1iIg5b/xj7lzwBm4hoxq3qURQvxug6O/rcgILk8dDqX1Qe+LRuTgj0Y
 5BbvHGZav7vFsYDUUL8gC6yOFn5eEWwc7BuL+bYWUpxGpxA/g0RAH1r/AXmhendEaw3i
 rHIA5DFGgqBoa4XHpDBx1ijltP61SV0nrE4tniLGAOi81bbpCJHHttHpA7hKz/U/4Vse
 BAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755678115; x=1756282915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IFHuGe5C8GzHXoHqKxoYfg8O2jjmuHuyJkDrmSEBnYM=;
 b=ZQeMgmAyEE9nSoDcNLsN2AgXbXM7X15I1xZlq/jU/jbpRdt5/xmLFGeTYL6ynIN51R
 +ydh7OJUPAF9y/e9mJUHM31k8H4CjAEhuuFvxxB8rf5NZXEjQoULr4TcaliA3lj+SHre
 k1JI5po6FljSZav1amOawivCJZdI1anex8rD0M4TDIYdIPYSMzl2jX03I2XJB8X4g50H
 9W/ehDd2Pw8cOJa0clM8fBCZBFKZ1UmwsmMWk3pIuO46UOhNralCL21IVJ0bYc8WcvxS
 xJmWUgI4buI3Dhyeu1eplIbOmLxFRLUHGXVid84z78ial6gzEi2F0CX35CYm3JAgGLLE
 p86A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU71ssIwGlcvF1LA+d7+BeGppDGvJPP51TR9YsQEFk9sagz9pYaOZLlqu2vpvyvuq7+0gvZW6iebHnvNA==@nongnu.org,
 AJvYcCVY9r3q+CevLVDhK7NmPFjzEXhOfVGFd8qENKzzbVO5KPEBaHme/fLxo60qBzsLzwmsAz2ugR8yjQ==@nongnu.org,
 AJvYcCXV+YG7PF1S4iSQbl/BgMAMEb5MgtJ2rfx8/OzwLPk90RixiE8fUBHOQK5e5epS4Kk2FQS4b+Rro1OWLw==@nongnu.org
X-Gm-Message-State: AOJu0YwQ7IG4/SWO2oW7S/lRb9xLnyI55KSRDfMT2l/KNhXIzK7tc1Lf
 SAGMC6BpxIx1gd/feNE+CXNOfiz5l/7eEvF3SeLX6fbYpznV9DqpWN3LFsaMuF8Cxcj8YcLKHle
 nchq+niJUETG0jBzOeXe73YHhI1d3+/c=
X-Gm-Gg: ASbGncvnFA2UI9PWJgyUDKjtR5RjoInGfCGIJThwwiNmiOXf0vGH29L10Vo4ih4zHpH
 vokiu83oFVBdrTtEFn/mu+3qmE6jybtHza7qFVKig6+RT1aHFfpJ31ycaMum4XaBarSSi/++fzN
 gWQi2xr5yD1grySkAHpamRqZW9u9As9IvJZf+m3vk58uRVoDmGqPXSTrDZZZo5tSXkKhS8XIwLR
 dpbVjKX6soU39rzaEhfg+pIFyuo6ZL2USQCQPkTSNB47lVU
X-Google-Smtp-Source: AGHT+IGDMTlegYdT7JN9H+gk6uW+epUI9WmrAsC6wDF/yqbKNXzLOGAUtxxgEk/89NEN92IBuQJ5Xne1OnE9WqJ4JXQ=
X-Received: by 2002:a17:902:cecc:b0:240:10dc:b7c9 with SMTP id
 d9443c01a7336-245ef0c305cmr24833595ad.9.1755678115006; Wed, 20 Aug 2025
 01:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
 <c59e13b025fd8a631463ce6033c50b02d3906b38.1755623521.git.ktokunaga.mail@gmail.com>
 <eb741401-fbc2-4ffc-b3da-83fe5646a03b@linaro.org>
In-Reply-To: <eb741401-fbc2-4ffc-b3da-83fe5646a03b@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Wed, 20 Aug 2025 17:21:42 +0900
X-Gm-Features: Ac12FXzKzBE7ZIuHZyjSYdA4LwuZlUussW3-5ryUM5qxfDPSAUOOxdFPjWm2Qa0
Message-ID: <CAEDrbUZj5tTq-TJCdkhL2uyME150KW09FKqxv0XMGb5dzRJj-g@mail.gmail.com>
Subject: Re: [PATCH 14/35] tcg/wasm: Add deposit/sextract/extract instrcutions
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>, 
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, 
 qemu-riscv@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000629a0c063cc7aad4"
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x635.google.com
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

--000000000000629a0c063cc7aad4
Content-Type: text/plain; charset="UTF-8"

Hi Richard, thank you for the feedback.

> On 8/20/25 04:21, Kohei Tokunaga wrote:
> > The tcg_out_extract and tcg_out_sextract functions were used by several
> > other functions (e.g. tcg_out_ext*) and intended to emit TCI code. So
they
> > have been renamed to tcg_tci_out_extract and tcg_tci_out_sextract.
> >
> > Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> > ---
> >   tcg/wasm/tcg-target.c.inc | 104 +++++++++++++++++++++++++++++++++-----
> >   1 file changed, 91 insertions(+), 13 deletions(-)
> >
> > diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
> > index 03cb3b2f46..6220b43f98 100644
> > --- a/tcg/wasm/tcg-target.c.inc
> > +++ b/tcg/wasm/tcg-target.c.inc
> > @@ -163,7 +163,10 @@ typedef enum {
> >       OPC_I64_SHR_U = 0x88,
> >
> >       OPC_I32_WRAP_I64 = 0xa7,
> > +    OPC_I64_EXTEND_I32_S = 0xac,
> >       OPC_I64_EXTEND_I32_U = 0xad,
> > +    OPC_I64_EXTEND8_S = 0xc2,
> > +    OPC_I64_EXTEND16_S = 0xc3,
> >   } WasmInsn;
> >
> >   typedef enum {
> > @@ -380,6 +383,66 @@ static void tcg_wasm_out_movcond(TCGContext *s,
TCGType type, TCGReg ret,
> >       tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
> >   }
> >
> > +static void tcg_wasm_out_deposit(TCGContext *s,
> > +                                 TCGReg dest, TCGReg arg1, TCGReg arg2,
> > +                                 int pos, int len)
> > +{
> > +    int64_t mask = (((int64_t)1 << len) - 1) << pos;
> > +    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
> > +    tcg_wasm_out_op_const(s, OPC_I64_CONST, ~mask);
> > +    tcg_wasm_out_op(s, OPC_I64_AND);
> > +    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg2));
> > +    tcg_wasm_out_op_const(s, OPC_I64_CONST, pos);
> > +    tcg_wasm_out_op(s, OPC_I64_SHL);
> > +    tcg_wasm_out_op_const(s, OPC_I64_CONST, mask);
> > +    tcg_wasm_out_op(s, OPC_I64_AND);
> > +    tcg_wasm_out_op(s, OPC_I64_OR);
> > +    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(dest));
> > +}
> > +
> > +static void tcg_wasm_out_extract(TCGContext *s, TCGReg dest, TCGReg
arg1,
> > +                                 int pos, int len)
> > +{
> > +    int64_t mask = ~0ULL >> (64 - len);
> > +    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
> > +    if (pos > 0) {
> > +        tcg_wasm_out_op_const(s, OPC_I64_CONST, pos);
> > +        tcg_wasm_out_op(s, OPC_I64_SHR_U);
> > +    }
> > +    if ((pos + len) < 64) {
> > +        tcg_wasm_out_op_const(s, OPC_I64_CONST, mask);
> > +        tcg_wasm_out_op(s, OPC_I64_AND);
> > +    }
> > +    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(dest));
> > +}
>
> This is no better than the generic tcg expansion.
> You should omit it.
>
> > +
> > +static void tcg_wasm_out_sextract(TCGContext *s, TCGReg dest, TCGReg
arg1,
> > +                                  int pos, int len)
> > +{
> > +    int discard = 64 - len;
> > +    int high = discard - pos;
> > +
> > +    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
> > +
> > +    if ((pos == 0) && (len == 8)) {
> > +        tcg_wasm_out_op(s, OPC_I64_EXTEND8_S);
> > +    } else if ((pos == 0) && (len == 16)) {
> > +        tcg_wasm_out_op(s, OPC_I64_EXTEND16_S);
> > +    } else if ((pos == 0) && (len == 32)) {
> > +        tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
> > +        tcg_wasm_out_op(s, OPC_I64_EXTEND_I32_S);
>
> This is worth keeping.
> Compare tcg/i386/tcg-target-has.h, tcg_target_sextract_valid.

I'll apply them in the next version of the patch series.

Regards,
Kohei

--000000000000629a0c063cc7aad4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Richard, thank you for the feedback.<b=
r><br>&gt; On 8/20/25 04:21, Kohei Tokunaga wrote:<br>&gt; &gt; The tcg_out=
_extract and tcg_out_sextract functions were used by several<br>&gt; &gt; o=
ther functions (e.g. tcg_out_ext*) and intended to emit TCI code. So they<b=
r>&gt; &gt; have been renamed to tcg_tci_out_extract and tcg_tci_out_sextra=
ct.<br>&gt; &gt;<br>&gt; &gt; Signed-off-by: Kohei Tokunaga &lt;<a href=3D"=
mailto:ktokunaga.mail@gmail.com">ktokunaga.mail@gmail.com</a>&gt;<br>&gt; &=
gt; ---<br>&gt; &gt; =C2=A0 tcg/wasm/tcg-target.c.inc | 104 +++++++++++++++=
++++++++++++++++++-----<br>&gt; &gt; =C2=A0 1 file changed, 91 insertions(+=
), 13 deletions(-)<br>&gt; &gt;<br>&gt; &gt; diff --git a/tcg/wasm/tcg-targ=
et.c.inc b/tcg/wasm/tcg-target.c.inc<br>&gt; &gt; index 03cb3b2f46..6220b43=
f98 100644<br>&gt; &gt; --- a/tcg/wasm/tcg-target.c.inc<br>&gt; &gt; +++ b/=
tcg/wasm/tcg-target.c.inc<br>&gt; &gt; @@ -163,7 +163,10 @@ typedef enum {<=
br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 OPC_I64_SHR_U =3D 0x88,<br>&gt; &gt; =C2=
=A0 <br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 OPC_I32_WRAP_I64 =3D 0xa7,<br>&gt; &=
gt; + =C2=A0 =C2=A0OPC_I64_EXTEND_I32_S =3D 0xac,<br>&gt; &gt; =C2=A0 =C2=
=A0 =C2=A0 OPC_I64_EXTEND_I32_U =3D 0xad,<br>&gt; &gt; + =C2=A0 =C2=A0OPC_I=
64_EXTEND8_S =3D 0xc2,<br>&gt; &gt; + =C2=A0 =C2=A0OPC_I64_EXTEND16_S =3D 0=
xc3,<br>&gt; &gt; =C2=A0 } WasmInsn;<br>&gt; &gt; =C2=A0 <br>&gt; &gt; =C2=
=A0 typedef enum {<br>&gt; &gt; @@ -380,6 +383,66 @@ static void tcg_wasm_o=
ut_movcond(TCGContext *s, TCGType type, TCGReg ret,<br>&gt; &gt; =C2=A0 =C2=
=A0 =C2=A0 tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));<br>&gt; &g=
t; =C2=A0 }<br>&gt; &gt; =C2=A0 <br>&gt; &gt; +static void tcg_wasm_out_dep=
osit(TCGContext *s,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 T=
CGReg dest, TCGReg arg1, TCGReg arg2,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 int pos, int len)<br>&gt; &gt; +{<br>&gt; &gt; + =C2=A0 =
=C2=A0int64_t mask =3D (((int64_t)1 &lt;&lt; len) - 1) &lt;&lt; pos;<br>&gt=
; &gt; + =C2=A0 =C2=A0tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1))=
;<br>&gt; &gt; + =C2=A0 =C2=A0tcg_wasm_out_op_const(s, OPC_I64_CONST, ~mask=
);<br>&gt; &gt; + =C2=A0 =C2=A0tcg_wasm_out_op(s, OPC_I64_AND);<br>&gt; &gt=
; + =C2=A0 =C2=A0tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg2));<br>=
&gt; &gt; + =C2=A0 =C2=A0tcg_wasm_out_op_const(s, OPC_I64_CONST, pos);<br>&=
gt; &gt; + =C2=A0 =C2=A0tcg_wasm_out_op(s, OPC_I64_SHL);<br>&gt; &gt; + =C2=
=A0 =C2=A0tcg_wasm_out_op_const(s, OPC_I64_CONST, mask);<br>&gt; &gt; + =C2=
=A0 =C2=A0tcg_wasm_out_op(s, OPC_I64_AND);<br>&gt; &gt; + =C2=A0 =C2=A0tcg_=
wasm_out_op(s, OPC_I64_OR);<br>&gt; &gt; + =C2=A0 =C2=A0tcg_wasm_out_op_idx=
(s, OPC_GLOBAL_SET, REG_IDX(dest));<br>&gt; &gt; +}<br>&gt; &gt; +<br>&gt; =
&gt; +static void tcg_wasm_out_extract(TCGContext *s, TCGReg dest, TCGReg a=
rg1,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int pos, int len)<=
br>&gt; &gt; +{<br>&gt; &gt; + =C2=A0 =C2=A0int64_t mask =3D ~0ULL &gt;&gt;=
 (64 - len);<br>&gt; &gt; + =C2=A0 =C2=A0tcg_wasm_out_op_idx(s, OPC_GLOBAL_=
GET, REG_IDX(arg1));<br>&gt; &gt; + =C2=A0 =C2=A0if (pos &gt; 0) {<br>&gt; =
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_wasm_out_op_const(s, OPC_I64_CONST, p=
os);<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_wasm_out_op(s, OPC_I64_S=
HR_U);<br>&gt; &gt; + =C2=A0 =C2=A0}<br>&gt; &gt; + =C2=A0 =C2=A0if ((pos +=
 len) &lt; 64) {<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_wasm_out_op_=
const(s, OPC_I64_CONST, mask);<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0tc=
g_wasm_out_op(s, OPC_I64_AND);<br>&gt; &gt; + =C2=A0 =C2=A0}<br>&gt; &gt; +=
 =C2=A0 =C2=A0tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(dest));<br>&gt=
; &gt; +}<br>&gt; <br>&gt; This is no better than the generic tcg expansion=
.<br>&gt; You should omit it.<br>&gt; <br>&gt; &gt; +<br>&gt; &gt; +static =
void tcg_wasm_out_sextract(TCGContext *s, TCGReg dest, TCGReg arg1,<br>&gt;=
 &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int pos, int len)<br>&g=
t; &gt; +{<br>&gt; &gt; + =C2=A0 =C2=A0int discard =3D 64 - len;<br>&gt; &g=
t; + =C2=A0 =C2=A0int high =3D discard - pos;<br>&gt; &gt; +<br>&gt; &gt; +=
 =C2=A0 =C2=A0tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));<br>&gt=
; &gt; +<br>&gt; &gt; + =C2=A0 =C2=A0if ((pos =3D=3D 0) &amp;&amp; (len =3D=
=3D 8)) {<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_wasm_out_op(s, OPC_=
I64_EXTEND8_S);<br>&gt; &gt; + =C2=A0 =C2=A0} else if ((pos =3D=3D 0) &amp;=
&amp; (len =3D=3D 16)) {<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_wasm=
_out_op(s, OPC_I64_EXTEND16_S);<br>&gt; &gt; + =C2=A0 =C2=A0} else if ((pos=
 =3D=3D 0) &amp;&amp; (len =3D=3D 32)) {<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tcg_wasm_out_op(s, OPC_I32_WRAP_I64);<br>&gt; &gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0tcg_wasm_out_op(s, OPC_I64_EXTEND_I32_S);<br>&gt; <br>&gt;=
 This is worth keeping.<br>&gt; Compare tcg/i386/tcg-target-has.h, tcg_targ=
et_sextract_valid.<br><br>I&#39;ll apply them in the next version of the pa=
tch series.<br><br>Regards,<br>Kohei<br><br></div></div>

--000000000000629a0c063cc7aad4--

