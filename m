Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F044C606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vivier.eu header.i=laurent@vivier.eu header.a=rsa-sha256 header.s=s1-ionos header.b=t0CRn5kT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM5b2-0001jp-PF; Wed, 28 Oct 2026 11:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1xM5b0-0001jS-Hu
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 11:29:47 -0400
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1xM5ay-0001U3-FB
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 11:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1793201380; x=1793806180; i=laurent@vivier.eu;
 bh=TEYl0haMvNtjB/z4now2zeIJaSYGVBImnDarl1RZEkk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=t0CRn5kTRKt7PC7ZJ8tKe9y/2DJGLsfVYD7nrd6OIPO9B3rJtxGC0vyhDBrO4FWf
 3FZNW28eXG689/oq3lNGUuzND3ANPsyZks1H4GOjO2Ai5qlSM8CtreZmkocYMloxi
 EirJro/JHYpj2Cp3SZNCiaV5znugpN4B69RrOxsuCbBBWS65VxtBh6V0sYdC6p0Vl
 Vcv5xNpDME+Nklelme25Ad1EC5cszy7J8t31Nx2tugMdnIqCGJi9jBes3XbWRtvKc
 8xt2agLwxEbTU7JHm+dZgVm+Xp1zImEqgQQBbWeMCQuXxwEnwdzStEmge55zFN7pZ
 6ClCVbsVLWp24fz6KA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1MORVA-1xBhJy1Kfe-00Yv9l; Wed, 28
 Oct 2026 16:29:40 +0100
Message-ID: <030196b2-a90c-4d26-815b-d7f04d3448dc@vivier.eu>
Date: Wed, 28 Oct 2026 16:29:39 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] target/m68k: Fix fsave/frestore for 68881 FPU
To: 54weasels <54weasels@gmail.com>, qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu
References: <20260903044626.24453-1-54weasels@gmail.com>
 <20260903044626.24453-3-54weasels@gmail.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20260903044626.24453-3-54weasels@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K7YjUpS8LX7bjLt9v2aH82z2mkYXczMtgN0YYB1BFNTz6QSJmFn
 e6XXvfSTlVIe+c6RW82dDvhAEhRQclwDUvC4XPvcC70VE8iYBXzJXpCjHa4TZ77Yobi5wHZ
 TCUepyWyXNLVOTprkz9m9gogCHrYyvwwOCCsDpAkUT5JM4s29bNeyuptL89MklbM/SE8LKL
 cjnUUupmIn2bTUPG9coWg==
UI-OutboundReport: notjunk:1;M01:P0:f+OybpW9otw=;bC5Ld8tl7z9SMRKdFRgV9AHvAFO
 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
 ki5YZsS
Received-SPF: pass client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Le 03/09/2026 =C3=A0 06:45, 54weasels a =C3=A9crit=C2=A0:
> Why this change is made & How it will be used:
> The 68881/68882 FPUs require fsave/frestore instructions to read/write s=
tate frames. QEMU only fully implemented this for the 68040. The Sun-3 use=
s a 68881 FPU, and the boot ROM executes `fsave` to probe FPU presence. Th=
is patch adds basic 68881 FPU state frame handling (NULL frame) to accurat=
ely simulate an idle FPU state.
>=20
> Impact on existing functionality:
> Fixes FPU detection for 68881/68882 across all M68k boards without affec=
ting 68040 specific state logic.
>=20
> Signed-off-by: 54weasels <54weasels@gmail.com>
> ---
>   target/m68k/translate.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
>=20
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index 138c89d3e5..c89ef213ed 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -5364,11 +5364,11 @@ DISAS_INSN(frestore)
>           gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
>           return;
>       }
> -    if (m68k_feature(s->env, M68K_FEATURE_M68040)) {
> +    if (m68k_feature(s->env, M68K_FEATURE_FPU)) {

This is not correct for 68060, it has FPU feature bit set but not 040 feat=
uer bit, so it will be=20
managed as 68881/68882. To keep existing behavior, it needs to call disas_=
undef()

>           SRC_EA(env, addr, OS_LONG, 0, NULL);
>           /* FIXME: check the state frame */
>       } else {
> -        disas_undef(env, s, insn);
> +        disas_undef_fpu(env, s, insn);

unrelated, needs a separate patch or omitted.

>       }
>   }
>  =20
> @@ -5379,12 +5379,18 @@ DISAS_INSN(fsave)
>           return;
>       }
>  =20
> -    if (m68k_feature(s->env, M68K_FEATURE_M68040)) {
> -        /* always write IDLE */
> -        TCGv idle =3D tcg_constant_i32(0x41000000);
> -        DEST_EA(env, insn, OS_LONG, idle, NULL);
> +    if (m68k_feature(s->env, M68K_FEATURE_FPU)) {
> +        TCGv frame;
> +        if (m68k_feature(s->env, M68K_FEATURE_M68040)) {
> +            /* 68040 FSAVE: always write IDLE */
> +            frame =3D tcg_constant_i32(0x41000000);

same as previously


> +        } else {
> +            /* 68881/68882 FSAVE: always write NULL frame */
> +            frame =3D tcg_constant_i32(0x00000000);
> +        }
> +        DEST_EA(env, insn, OS_LONG, frame, NULL);
>       } else {
> -        disas_undef(env, s, insn);
> +        disas_undef_fpu(env, s, insn);

same as previously

>       }
>   }
>   #endif

Thanks,
Laurent

