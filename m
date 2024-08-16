Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB61C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 14:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sexld-0004oD-Eb; Fri, 16 Aug 2024 10:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sexlY-0004n7-Cg
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 10:17:20 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sexlV-0007yJ-A9
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 10:17:20 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ef2cb7d562so25143741fa.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 07:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723817834; x=1724422634; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tMYHt9G0BRgCr0uEeqglLAfx/JM3opmVw3/UKxEzYvw=;
 b=vXwC0OlOSVtIcqE9jBPi8G20PXV389bgJveQ0nAMGwkMwOceK7zgUP3i8BYLhfZSDf
 qgtgfZSJEl8H6RD3D54ddYl0iC6KMODy2GJlWHbfZS6K8urpDVOLQQLd7YDMwBzsQKBz
 K9PTdPI6pFLqpVVZcPVvx9DemzMWcnA+HoPeSU41lSUW5SRDNkRaCGv2chLD/0NLN+IH
 1ohLpzWNl9GepaM66TGFFNtkXXzBTJ3G5qCNNJZ6WsE2iyHQ8V5MlvuUtzdS/LLB3GHy
 WaG9/NbTeelFpD/R5IkMFkIpFuBDtSujRC4SDlIux62HJedBv7zvLp1V6QQPb9dROxtR
 lZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723817834; x=1724422634;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tMYHt9G0BRgCr0uEeqglLAfx/JM3opmVw3/UKxEzYvw=;
 b=GVAzQa9BCU5fJGRANvKuWl0acdrWYtUlfqrQTik4YlIHRtOeB6rRW7h6sqqLWTBUAU
 U3E0ctYfGhU4RUNS5LsN9Q9N2n7Nsn6al6to6W4TMI0ha8xIxJlOaHsgXMg12psTT3Wo
 Bg7cC6XgIY0/kasP7x22xjbN0be3tmPFNEPhsFX2a95wc8TrxOTsG1UMdxmaxTSL1m7A
 JdhG5z/1Zkdmy3BzMr7VSsrUz6B6IgetFjRlWXqJyMsX5CqZtfqfSkuVRYjrzjpm1jDX
 r07xXLP3dXEUY/8m+nAtsYLwgBhhh8kwjrlJ7NZdCzVri/77M0SYdwt7+6KaenjZua7E
 tC0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbckgc4LDiLrNm358bh4qKsU+l2B15o/kqAOW8xRX1WH/nM3T+MN0RY+bXjIdtaFhRZEVyDDEK1u7FxgZI0im3qic/A34=
X-Gm-Message-State: AOJu0Yyoo9nuHsA+ZxAhJiATHUxpK3nABpH/mXH2kEEL2gLXpl7V29Yq
 xiT1lYkaiqbOFXZGfeHzvW7Q3CCF3EOV/OkZkxE0JjslQsEwEfi7P9dSNZEAct/srLSgUZjXLKW
 /pOxJnBb9IptF60fXYP90raUQzrAk98i8veulUw==
X-Google-Smtp-Source: AGHT+IFucfmgbSScfjVPj/rRmOxPaOazQrk3+hSn3k99gmg211DY/z3HIxQ8h9KerCUvu0tZ4iMf/pWeIqHJMY4suyU=
X-Received: by 2002:a2e:e02:0:b0:2ef:1ecc:cf5a with SMTP id
 38308e7fff4ca-2f3be5b1636mr20090131fa.26.1723817833984; Fri, 16 Aug 2024
 07:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
 <20240814233645.944327-3-pierrick.bouvier@linaro.org>
 <491b34f6-a81a-4793-984c-6a588910d0e1@redhat.com>
 <87ttfm2em2.fsf@draig.linaro.org>
 <557ad237-9a46-4dff-9177-bd4b2108d26c@linaro.org>
 <87h6bk3a9k.fsf@draig.linaro.org>
In-Reply-To: <87h6bk3a9k.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Aug 2024 15:17:02 +0100
Message-ID: <CAFEAcA9ROs_a=Qb6-bbwDTR646CaXLN1XG6uZEnPk6oU-k0xjA@mail.gmail.com>
Subject: Re: [PATCH 2/6] contrib/plugins/cache: fix warning when compiling on
 32bits host
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 16 Aug 2024 at 13:48, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Richard Henderson <richard.henderson@linaro.org> writes:
>
> > On 8/15/24 21:46, Alex Benn=C3=A9e wrote:
> >> Thomas Huth <thuth@redhat.com> writes:
> >>
> >>> On 15/08/2024 01.36, Pierrick Bouvier wrote:
> >>>> Found on debian stable (i386).
> >>>> ../contrib/plugins/cache.c: In function 'vcpu_tb_trans':
> >>>> ../contrib/plugins/cache.c:477:30: error: cast from pointer to integ=
er of different size [-Werror=3Dpointer-to-int-cast]
> >>>>     477 |             effective_addr =3D (uint64_t) qemu_plugin_insn=
_haddr(insn);
> >>>>         |
> >>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >>>> ---
> >>>>    contrib/plugins/cache.c | 6 +++---
> >>>>    1 file changed, 3 insertions(+), 3 deletions(-)
> >>>> diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
> >>>> index 512ef6776b7..82ed734d6d4 100644
> >>>> --- a/contrib/plugins/cache.c
> >>>> +++ b/contrib/plugins/cache.c
> >>>> @@ -471,12 +471,12 @@ static void vcpu_tb_trans(qemu_plugin_id_t id,=
 struct qemu_plugin_tb *tb)
> >>>>        n_insns =3D qemu_plugin_tb_n_insns(tb);
> >>>>        for (i =3D 0; i < n_insns; i++) {
> >>>>            struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn=
(tb, i);
> >>>> -        uint64_t effective_addr;
> >>>> +        uintptr_t effective_addr;
> >>>>              if (sys) {
> >>>> -            effective_addr =3D (uint64_t) qemu_plugin_insn_haddr(in=
sn);
> >>>> +            effective_addr =3D (uintptr_t) qemu_plugin_insn_haddr(i=
nsn);
> >>>>            } else {
> >>>> -            effective_addr =3D (uint64_t) qemu_plugin_insn_vaddr(in=
sn);
> >>>> +            effective_addr =3D (uintptr_t)
> >>>> qemu_plugin_insn_vaddr(insn);
> >>>>            }
> >>>
> >>> Is this the right fix? I assume effective_addr stores an address of
> >>> the guest, so if the guest is 64-bit and the host is 32-bit, you now
> >>> lose the upper bits of the address...?
> >> I think the problem is higher up, it was a mistake to have:
> >>    void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn
> >> *insn);
> >> return *void.
> >
> > No, not a bug.  This is a host addr, right there in the name.
> > Returning uint64_t would be a bug.
>
> No it's:
>
>  * Returns: hardware (physical) target address of instruction
>
> I was kinda assuming that was what the underlying host_addr[] fields in
> DisasContextDB are. Are we just saying its QEMU's vaddr of where the
> guest physical address is mapped into QEMU?

DisasContextBase::host_addr[] are host (virtual) addresses,
i.e. pointers you can dereference in C code in QEMU.
The comment in qemu_plugin_insn_haddr() says:

     * ??? The return value is not intended for use of host memory,
     * but as a proxy for address space and physical address.

This seems pretty QEMU-implementation-internal to me and
not something we should be allowing to escape into the
plugin API. What, per the comment, we ought to be exposing is
the (address space, guest physaddr) tuple, which we
presumably don't conveniently have to hand here.

thanks
-- PMM

