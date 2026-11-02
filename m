Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993F0606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 06:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vplavfxn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNlWO-0007IS-U7; Mon, 02 Nov 2026 01:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1xNlWN-0007IH-Qt
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 01:27:55 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1xNlWM-0002Mr-A5
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 01:27:55 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-4a71d0c4233so1399730fac.0
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 22:27:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793600872; cv=none;
 d=google.com; s=arc-20260327;
 b=SttSk6wiGPgGb0PsoDNuS9mk4zvzmK7lBWPianL0lW7za0d4WLa2dIqAVTzWFuR6Rb
 WOYKx7bEEDdglqMGBSBWbizegcf35UwED2nPRiGgI+Ennpaqj/mNeF1SAKYRBQKoWXt7
 Bv2X1QPcvN2bmOnWwDPmiv2/O0lJ9mviurw8bnhFRaXr7h8bHLtcTuot/r0bE4o2T9dt
 TAZCDaf9upQEpNhb1JzfNj/RxL4Ewrs5lWn26yZyLsKGPK3q7EU2R2PfC+yZB1+tZQFK
 K8PwgAZwOl/nIPZcUAemaGcuymUrEan0a0mDp+LhRAB/jjdncs5VIaAPKHp7nm3o28hQ
 5MhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FBlh56DDUe+mELSFkXbKhdhUoMz8rcbqMLOZ97PnnpQ=;
 fh=t5KLznR9BWgEdiJtBtJ19cLI+afAuYM6Q5kEz2FYrRc=;
 b=WgZDA2MUYZ5uDjDdIIvRKfOw/pxfP04EYFCThAsq+qGf91hGq0LQ7Z3OtdXZNGYP92
 5QXEQFCryTDidQBsVAdJ/FvxC9f9VFLRQhGSYOD3USN658ktL052TrmR71NsnRrRxdsM
 M4kvMNRJQdCWE9C399stRS/d6Mgg3FHALwz/Z7pOpZFdUEX8PyRbksPQOTV5WL7B5FQs
 oFICpKh0ka4mrJ+mzTvot4ywv6KLHTCbmLJp5Es/SLgYOjxiAZ19rH9YlxtNaoVYTKgk
 GQ1WrABeMsV1ojM9nyLTWH773wPBLsRLfxqGcF9t8GADEEkK64fsukt4Z3MKFZL60yr0
 E9PA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793600872; x=1794205672; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FBlh56DDUe+mELSFkXbKhdhUoMz8rcbqMLOZ97PnnpQ=;
 b=vplavfxn9G7HH5glSdyRHfZOVmKgB2dWPy1U6qpVbt4A6cHa+NUnjertm+58i23cF/
 TIuqQwTjsBjGbyJaFqDpFBly1K/hRBfRTE5v52IQMeNJtAvnx4FJRUssBah/cADoVtMY
 ha59bFDaB5wvTMdJ0Rg0GUOi7y/FOX7mfa8En5dGc76w/AOQat6zU4tubKoqTQOy11Fh
 0++3LVu4Mv8T0+PYmmhBlU2Q8cLJIRB0gAGqBHaUzWyRWYs1uZEJZ2iuv08hfUipAc5g
 22JaENrghrz29nBVdDrJOWiZ9OgyG0ttFtnphWojdAfR+PEUMYGfHIdahw5gZ+d09Cz6
 2K1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793600872; x=1794205672;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FBlh56DDUe+mELSFkXbKhdhUoMz8rcbqMLOZ97PnnpQ=;
 b=fxEu3QJkYwBc38OHXDqLSwh3IAMw1Qd2o/BXZrgrHgX/okaj6zzdbAuZdM3H2+1QTt
 3mT41yH1PgDtjCvDCou0JaDj77susQ7Fdi8S/PhAdr5CEY4DGK8B2HH8BOuGjLFioXmT
 JKRF8QWJECjziX1iz41rnNTvh91AfizAV+63Ty0n52g3Ee4ceKSPpgv7+LVBTlqXF89v
 VjHN/+n6z9TWWzSJoDAiMXAFhksCXo8bt+AUusO9EcOW48A/JmT+BJx531G5Tj5dANq3
 YBMGUISOKFtDpibmV5f+OtcSjFtJrrOWYZeZCzBMGIf/sxCcXamp2n78QKCyeEThxs5l
 YQ+A==
X-Gm-Message-State: AFq9FYLGs1tiBRmbELdjp4K1uxkbV4nnLEbOOl3sORxSEa5aOaJwltRK
 VqRrWCiWcIVafJwqMgbvDgxK9XTI6Z0Dr1T6vonNgFDZi/FHa2tfxFLO+g3i/aAa3DmYF2WCRL7
 GVGfX9C+UV5BTFSc+vsHDOoFV3bhFiB8=
X-Gm-Gg: AYBFou2gd4piWhgseDxOiRMxJ7kmf6B+DuJIepCDzJKb39RlUvI6WL1FWfKBS+BqyUT
 l36M3+atPmZAj1Yh6Nv4KcrfI5hx+q1gPqs8OycY9umZNZE4svZCirmwRcP/PMTLXcDrM0xPTkd
 jkCBHRT9Vu2fhnoUr2H/IiL2EDlI9XVNlsJPxHXOf7zN5plXnc5NL/GR3CeU3l/X8SZ8btc57Sv
 P7w9wX9TGgJ5wABs5jFt9E6sHTlMckWzmaP/LGbPHfYU6edp+zJ+L1vUkoEQAznZEFgzKmi/934
 wmiF6fjxoYDTIaCEgYjnZhn1RdN9A3iYTVjKZvEOg3myPE/vNLsu8Smpb/pTxWK0Cs7O86c7j9K
 F0W1WmI3t6vjtSuF3C7kXEJj71zka6zQd4kA6lQ==
X-Received: by 2002:a05:6870:3b15:b0:49e:7e48:9314 with SMTP id
 586e51a60fabf-4a90771ad85mr5552580fac.39.1793600872430; Sun, 01 Nov 2026
 22:27:52 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260903044626.24453-1-54weasels@gmail.com>
 <20260903044626.24453-2-54weasels@gmail.com>
 <49426047-ad68-4e43-8c60-7b0daef46161@vivier.eu>
In-Reply-To: <49426047-ad68-4e43-8c60-7b0daef46161@vivier.eu>
From: Purr Box <54weasels@gmail.com>
Date: Sun, 1 Nov 2026 22:27:41 -0800
X-Gm-Features: AclHuK_g78tt7hfbTPvU-BKwKHO4AeBMJ6EQ0oMrCGRM5XomTuOtGYhDR6w5_s4
Message-ID: <CAFWf6u_1F6kEyNRmUX9Wyj-+JWwOdGkG5hAwbHiESzdkZm0CTg@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] target/m68k: Add dummy CAAR register
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, balaton@eik.bme.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=54weasels@gmail.com; helo=mail-oa1-x31.google.com
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

On Wed, Oct 28, 2026 at 7:54=E2=80=AFAM Laurent Vivier <laurent@vivier.eu> =
wrote:
>
> Le 03/09/2026 =C3=A0 06:45, 54weasels a =C3=A9crit :
> > Why this change is made & How it will be used:
> > The Sun-3 ROM expects the Cache Control Register (CAAR) to exist on the=
 68020. Reading/writing this register currently aborts QEMU. This patch pro=
vides a dummy implementation that simply ignores writes and returns 0 on re=
ads, allowing the ROM to continue booting.
> >
> > Impact on existing functionality:
> > No impact on existing targets. ColdFire and Mac targets do not access C=
AAR in a way that currently aborts, and providing a safe dummy implementati=
on ensures robustness across M68k boards.
> >
> > Signed-off-by: 54weasels <54weasels@gmail.com>
> > ---
> >   target/m68k/helper.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> > index 5f91d206f5..68f523ea84 100644
> > --- a/target/m68k/helper.c
> > +++ b/target/m68k/helper.c
> > @@ -281,8 +281,10 @@ void HELPER(m68k_movec_to)(CPUM68KState *env, uint=
32_t reg, uint32_t val)
> >               return;
> >           }
> >           break;
> > -    /* Unimplemented Registers */
> > +    /* Dummy implementation for CAAR */
> >       case M68K_CR_CAAR:
>
> CAAR is only supported on 020 and 030, use m68k_feature() here to check t=
hem and return. Otherwise
> use break to go to raise_exception_ra()
>
> > +        return;
> > +    /* Unimplemented Registers */
> >       case M68K_CR_PCR:
> >       case M68K_CR_BUSCR:
> >           cpu_abort(env_cpu(env),
> > @@ -385,8 +387,10 @@ uint32_t HELPER(m68k_movec_from)(CPUM68KState *env=
, uint32_t reg)
> >               return env->mmu.ttr[M68K_DTTR1];
> >           }
> >           break;
> > -    /* Unimplemented Registers */
> > +    /* Dummy implementation for CAAR */
> >       case M68K_CR_CAAR:
> > +        return 0;
>
> Same comment as for m68k_movec_to()
>
> > +    /* Unimplemented Registers */
> >       case M68K_CR_PCR:
> >       case M68K_CR_BUSCR:
> >           cpu_abort(env_cpu(env), "Unimplemented control register read =
0x%x\n",
>
> Thanks,
> Laurent
>

Thanks Laurent, will do in v6: CAAR is accepted only when M68020 or M68030
is set, and every other CPU falls through to raise_exception_ra(). Same
change in m68k_movec_from().

