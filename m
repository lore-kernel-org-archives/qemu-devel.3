Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B44606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vivier.eu header.i=laurent@vivier.eu header.a=rsa-sha256 header.s=s1-ionos header.b=CiNq6VjQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM52u-0000Yj-Jm; Wed, 28 Oct 2026 10:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1xM52S-0000VE-2v
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:54:05 -0400
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1xM52Q-0006cG-4f
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1793199228; x=1793804028; i=laurent@vivier.eu;
 bh=4krLTMNITU50YUhc81JnUjdznZ8pJoMS3/9sYP/VB/c=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=CiNq6VjQGDd5FtyGQlJaOzhFR30+OPA7dSEa4TIowUQZibjYq6D5Uxir08fKUTio
 w6yHZ+akBJHqdB2T9w78qx1vKqLDvbkObxbI6M9r0+fUsIxmQbuEocPde2MEWfw69
 wnCAeBqtMMFY0bEaCzHAsajeGIjuSQk/sRKUb1BmYB8PMgg/GPNGgayjZPW0ZeOkL
 zweelvI/umJ2sJC2mtU1ry5V5AbdQyckq/UKi61AqKriv6W7MZgM4Yadk45+1oYlF
 y153t+kQBI9q8DKlxcrxFA9vbuzvWD1YGMzXE0dDC6gfGX8oCVXJ6LePW3rIsvhSv
 JTFzgF7LkmeApTy2mg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1MNLZc-1xAbt03HTe-00Xoce; Wed, 28
 Oct 2026 15:53:48 +0100
Message-ID: <49426047-ad68-4e43-8c60-7b0daef46161@vivier.eu>
Date: Wed, 28 Oct 2026 15:53:47 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] target/m68k: Add dummy CAAR register
To: 54weasels <54weasels@gmail.com>, qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu
References: <20260903044626.24453-1-54weasels@gmail.com>
 <20260903044626.24453-2-54weasels@gmail.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20260903044626.24453-2-54weasels@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ivx60der2EDJG0LuYc3BY4q/oUugKa1lRhHJI/9Utw+atL9zn9c
 s5t44NHyvks4DXyjfI+sjtRc4iQHh2SGenjhy4XJw5SqDTvNMJ8EBso5g1Nb2/svCGsOdTG
 YTmUswIj44no2jLx1Qcn1Hr8VuHnpmoa8KHLT7cYLSr7zkTHp/lNnshePBHwB76RA266Gst
 lX3YX6+7BFd9v5ayyugBQ==
UI-OutboundReport: notjunk:1;M01:P0:Dyh3QO+6gRM=;UZeZTqdqjWy9wVt2g+WSYfFcgln
 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
 +d8bz7N
Received-SPF: pass client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
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
> The Sun-3 ROM expects the Cache Control Register (CAAR) to exist on the =
68020. Reading/writing this register currently aborts QEMU. This patch pro=
vides a dummy implementation that simply ignores writes and returns 0 on r=
eads, allowing the ROM to continue booting.
>=20
> Impact on existing functionality:
> No impact on existing targets. ColdFire and Mac targets do not access CA=
AR in a way that currently aborts, and providing a safe dummy implementati=
on ensures robustness across M68k boards.
>=20
> Signed-off-by: 54weasels <54weasels@gmail.com>
> ---
>   target/m68k/helper.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index 5f91d206f5..68f523ea84 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -281,8 +281,10 @@ void HELPER(m68k_movec_to)(CPUM68KState *env, uint3=
2_t reg, uint32_t val)
>               return;
>           }
>           break;
> -    /* Unimplemented Registers */
> +    /* Dummy implementation for CAAR */
>       case M68K_CR_CAAR:

CAAR is only supported on 020 and 030, use m68k_feature() here to check th=
em and return. Otherwise=20
use break to go to raise_exception_ra()

> +        return;
> +    /* Unimplemented Registers */
>       case M68K_CR_PCR:
>       case M68K_CR_BUSCR:
>           cpu_abort(env_cpu(env),
> @@ -385,8 +387,10 @@ uint32_t HELPER(m68k_movec_from)(CPUM68KState *env,=
 uint32_t reg)
>               return env->mmu.ttr[M68K_DTTR1];
>           }
>           break;
> -    /* Unimplemented Registers */
> +    /* Dummy implementation for CAAR */
>       case M68K_CR_CAAR:
> +        return 0;

Same comment as for m68k_movec_to()

> +    /* Unimplemented Registers */
>       case M68K_CR_PCR:
>       case M68K_CR_BUSCR:
>           cpu_abort(env_cpu(env), "Unimplemented control register read 0=
x%x\n",

Thanks,
Laurent


