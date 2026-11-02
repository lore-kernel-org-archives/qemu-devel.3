Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E52F606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 06:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y89/+QYy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNlY4-0008Bf-St; Mon, 02 Nov 2026 01:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1xNlY3-0008BV-MZ
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 01:29:39 -0500
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1xNlY1-0002Ti-SE
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 01:29:39 -0500
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-4a755bbe158so1862139fac.0
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 22:29:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793600976; cv=none;
 d=google.com; s=arc-20260327;
 b=d1Wp0+aZOLD4Hpji8ZeRgqvIrJF4cl9LXTMxZrqY+V1dGHzcbmScRc8yqSqeX3Du8z
 Sf6TPETeLK0FFrruXgEhgutPJqzQDLA7LjZLKog/qKAZoH+OTvBzdarlZQowZHb6YQFd
 BpDNDAU9E9jjKGjv8HFFJdVBHATs5IPrO8Lbhb9HaR67wtkWwQONUzfMwwoZiDwouQMV
 NrLjyOaKlbKe/2ptT7UFP1YWO6PGNSDSN/g9S1TH/RL4Ooz7mrA88GqfI/MjUv8Yp/rU
 uCVDD6je4wb0juXB3OHWWUHp/8PUAG7Zt7zvxtdqpWp6w8wrB3Z+CNYyF9oLdgcs4P6P
 OsfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LgNEZpKudtf7pIpCmWJukKb15bb47V5V97eXm32D82A=;
 fh=t5KLznR9BWgEdiJtBtJ19cLI+afAuYM6Q5kEz2FYrRc=;
 b=Z6COYCVfRK+pTZeu2J4o3W9e6p8T1iAaDkd4dQM0a7dOyg2GaMw4reU8fF3omCN8Ac
 AlQ/YeWQegWP6iyPS3Xzej4qLMsQ6ge0DslfsvHl3uJRECfX+F+hy8iSGjOI91e6nCc/
 Jgzy5RYMlme0W+HWtDzRvtBO1SJKxgHjgBvvPxnkwT/wL2iA0AFgh+znLHsRmQsb8u27
 Z5E9sTxH3aUxlSP8aU6HQ1x+fj8o4mxMcYDrODRUueyH2S0HCy6ciOKVvkBaYmLByep7
 SLNrWtQ3W4G1tbVfhdJmsxw42y7VfhGbqYxhD2YD4XD3oEqU71i+ZJZ43Ybxz2s/zEaL
 sBIw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793600976; x=1794205776; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LgNEZpKudtf7pIpCmWJukKb15bb47V5V97eXm32D82A=;
 b=Y89/+QYyuR5Vn1OQv0ZpKEhPTfig/rqYpQsuKZp9sGfqBPqW1Zu/FQBQKEKwNUL2Wz
 aaWMR6C977HnTVWosTDM/YDjpac4h8taM7ycEAnRYfMQkEPGeavVOsPKRKOIqCeMNLh+
 GCEaYdf75c5I/aW7okcSHINhw6s8s2btEuxJJMp/MEQVpIaYdafalKb+ejA4z/qIDGj7
 u1iPAlbNtNB+UjES3grrtJnq6vqCRNEbJb8eHrUDIsiaKge/GjWoNB/By5SYwOqthgn3
 cjV/np80OxY5SFZdtD4ZBU8PEqA+VkE/8uzumT7SebhjH+wRu7guCOpyeN7wg6ULY25Q
 zU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793600976; x=1794205776;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LgNEZpKudtf7pIpCmWJukKb15bb47V5V97eXm32D82A=;
 b=wbUEQZZftPnG2eqGyMljCy5hNdGJAm4REl+YOBY56UO4qD2UOBqUhVCoqxrt6RieYt
 /SOYTV96XzW33oMkH4RXEmx4brxVDlEwtq8T1dANtBtboncDhfYVNomA6Dys1HNOAI82
 jl4czI7H13lwpJim7+b0GsVkIMOiQLn/P17QmS1FmcWXiVR2+AKfOQqjCvtTcKfMrvXa
 DlAppeOmSYEHhtd5G7xZ026wYQ4FUWEZRLNZIn8Y3YQQ1yRPd6S5/KPkQ4X5hfbd40ZZ
 sxM2iq+CMdyWr2/eD5H9Trc2RYENFivKnF04dyVBBlRJ9WzF2K77GjNTPVmIs6oHzuH0
 J88g==
X-Gm-Message-State: AFq9FYIb8flRmb/wKeyCHYeXHLf7dejvI28wi0FtE3K9GBiYC9LBEFEJ
 qkKurWEy9iQnXkCCKHLLn6H1wTgg9UJkkbSvWc1ZkQjLaHrCfSYeZxVfk5SsSBMvNWgOeNSAWD4
 YYfF1b1u4eYsWHVHWjCOThvVtX8mR5Q8=
X-Gm-Gg: AYBFou0TwC/oZdAMUTi+LGJJvV8INg5U8Xw+WTF+a+/VdqOned9a7P904/sdCiJx1hG
 VJQAUJDUPisdEPHQO70YLiMuo3yCpWafFACqFBtaZn1hUuKDju5HMBpfLfycW5a68v8mtoT0Jb5
 cImTTyWIkrQz7eDh1kQMnjry9BtcU4PVSn1iUM4fo7fXH33h/FjGBGQO7Vd6eTB7mOXbsHYVHyt
 /nXtSQLF0vs30ccGRwo+up+fJoMlQR+Mmahr4zfPJ8m7T7oLiuC4Yl13n3w491d7oZfDbqbq9lI
 zCXPHC3sBxfE4BFETmfzd1fv8sUIanNOdSv9TcjDu2kbeXBznf1+8K3kQGSwxzceo4dnvH8U7sw
 DdfgMdjWorSOKmZK8fqOiSe7KeE87So6dsCsRGVR/Hfw6BG4B2f4v0B0WdHI=
X-Received: by 2002:a05:6870:be90:b0:470:e97e:8f87 with SMTP id
 586e51a60fabf-4a8e099c2d7mr5992595fac.23.1793600976624; Sun, 01 Nov 2026
 22:29:36 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260903044626.24453-1-54weasels@gmail.com>
 <20260903044626.24453-3-54weasels@gmail.com>
 <030196b2-a90c-4d26-815b-d7f04d3448dc@vivier.eu>
In-Reply-To: <030196b2-a90c-4d26-815b-d7f04d3448dc@vivier.eu>
From: Purr Box <54weasels@gmail.com>
Date: Sun, 1 Nov 2026 22:29:25 -0800
X-Gm-Features: AclHuK9Qpc54Gn_uNOQLylHFjuZYb-d4ni7p32No1YQTLhx3fy0QC7eAHvNtSJE
Message-ID: <CAFWf6u_HpeHG2spNs+qeVfB-sp1e33R1CMLMXsYTq08vf2h1nw@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] target/m68k: Fix fsave/frestore for 68881 FPU
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, balaton@eik.bme.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=54weasels@gmail.com; helo=mail-oa1-x36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 8:29=E2=80=AFAM Laurent Vivier <laurent@vivier.eu> =
wrote:
>
> Le 03/09/2026 =C3=A0 06:45, 54weasels a =C3=A9crit :
> > Why this change is made & How it will be used:
> > The 68881/68882 FPUs require fsave/frestore instructions to read/write =
state frames. QEMU only fully implemented this for the 68040. The Sun-3 use=
s a 68881 FPU, and the boot ROM executes `fsave` to probe FPU presence. Thi=
s patch adds basic 68881 FPU state frame handling (NULL frame) to accuratel=
y simulate an idle FPU state.
> >
> > Impact on existing functionality:
> > Fixes FPU detection for 68881/68882 across all M68k boards without affe=
cting 68040 specific state logic.
> >
> > Signed-off-by: 54weasels <54weasels@gmail.com>
> > ---
> >   target/m68k/translate.c | 20 +++++++++++++-------
> >   1 file changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> > index 138c89d3e5..c89ef213ed 100644
> > --- a/target/m68k/translate.c
> > +++ b/target/m68k/translate.c
> > @@ -5364,11 +5364,11 @@ DISAS_INSN(frestore)
> >           gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
> >           return;
> >       }
> > -    if (m68k_feature(s->env, M68K_FEATURE_M68040)) {
> > +    if (m68k_feature(s->env, M68K_FEATURE_FPU)) {
>
> This is not correct for 68060, it has FPU feature bit set but not 040 fea=
tuer bit, so it will be
> managed as 68881/68882. To keep existing behavior, it needs to call disas=
_undef()
>

Good catch, thanks. In v6 I'll leave the 68040 path as it is and add an
explicit branch for M68020/M68030 (NULL frame). Everything else, 68060
included, goes to disas_undef() as it does today.

> >           SRC_EA(env, addr, OS_LONG, 0, NULL);
> >           /* FIXME: check the state frame */
> >       } else {
> > -        disas_undef(env, s, insn);
> > +        disas_undef_fpu(env, s, insn);
>
> unrelated, needs a separate patch or omitted.
>

Agreed, I'll drop the disas_undef_fpu() change.

> >       }
> >   }
> >
> > @@ -5379,12 +5379,18 @@ DISAS_INSN(fsave)
> >           return;
> >       }
> >
> > -    if (m68k_feature(s->env, M68K_FEATURE_M68040)) {
> > -        /* always write IDLE */
> > -        TCGv idle =3D tcg_constant_i32(0x41000000);
> > -        DEST_EA(env, insn, OS_LONG, idle, NULL);
> > +    if (m68k_feature(s->env, M68K_FEATURE_FPU)) {
> > +        TCGv frame;
> > +        if (m68k_feature(s->env, M68K_FEATURE_M68040)) {
> > +            /* 68040 FSAVE: always write IDLE */
> > +            frame =3D tcg_constant_i32(0x41000000);
>
> same as previously
>
>
> > +        } else {
> > +            /* 68881/68882 FSAVE: always write NULL frame */
> > +            frame =3D tcg_constant_i32(0x00000000);
> > +        }
> > +        DEST_EA(env, insn, OS_LONG, frame, NULL);
> >       } else {
> > -        disas_undef(env, s, insn);
> > +        disas_undef_fpu(env, s, insn);
>
> same as previously
>
> >       }
> >   }
> >   #endif
>
> Thanks,
> Laurent

