Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E82C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 06:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scIqn-0006H7-Vr; Fri, 09 Aug 2024 02:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1scIqm-0006Fo-EU; Fri, 09 Aug 2024 02:11:44 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1scIqk-0002jk-Mf; Fri, 09 Aug 2024 02:11:44 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fc66fc35f2so20155195ad.0; 
 Thu, 08 Aug 2024 23:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723183900; x=1723788700; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s7l1SCg+yug/pMLEagw5dz6FCwiLq9b/ZseW7gW8YQM=;
 b=R625562H2UqAk0Um/rz2RdCW9Oh8eKgHEFddbhpuo72Hwt59y/ryHG9wXiU4kEoLvn
 cbFvCt7REC1gyXGwPiKYjG8HkoJDDPC0LjF4CUmmG1oxPmn/JaIciVTgD30FEG5KKA30
 1RCFhNzuPZqqwo5GTdOE2I9kDw4emCx2eEC+xa2qFkXbmmQHmOJZiz/zCiKBxqZoy6t6
 a0iARhZ35IDDmX4d/yLgB3cNpshjAJttp6XhO1mOxayHa+C1GiD4bON/yNYdssnl2F9L
 l/d0Dly87b0HeYzN0kyfR+E2kp6kI/bvjcbrO/RCKskdyYG3xACyv/VkX4zr50ch4C0u
 8srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723183900; x=1723788700;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s7l1SCg+yug/pMLEagw5dz6FCwiLq9b/ZseW7gW8YQM=;
 b=xS8uunGG2Uzv4+gIGy+buJ/HYfI9r+LXBguwdDWDFO38Hor/h2xytni0G801f4oRCE
 DgIeeGUckGTXfMWwy3itv9Qd3VEa7b3ThPk47vp4BdhdxHQITXoFc4zicZlQWGhJBYhT
 BdTZRJuf7dUeavIKu36E9p5QwdiPsYn36htonymrIYyy+1W2XBhpD5Eyo4S06Emlcyxt
 MoJDNQUU173/D6RV0IHQ191lXYAK7F6FxsbUPtA41Sq4nk6WMGEStgIQS83j5fk5+g5d
 IA3Zkh9e0oSw8lM1LQCRSRgkbqDVNuILsBi8CADdKjMfCLaWHVPa+dkeGrfkVV14csbr
 m/Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzQ+wLFAzLCbmEG2YX6W0UArpxL80Q3M1BENJY4oV0wYgiflgshaXVq/EyfENuifDPV0UGydtf5gAJBTPJJ6d0zJxBSPGKmO0ilWwXo6j6YwWZN4hCJzOTFCk=
X-Gm-Message-State: AOJu0YzOMLgPlTZS8oOjMT81Q+14/7nntRrXT0izigjttFOCDb4qZiZy
 Bw8GxMAzEZd98u2zLcFhbpcfzFgZZkzYMvKitGA85eLWaenh8fnY
X-Google-Smtp-Source: AGHT+IFMy7Y1w48RHOSQuoFCkDH74ILBrB+jDMF4I6MtrCJurZqQ8u3LKuzCBpwvIigA/8Y1RK4lrQ==
X-Received: by 2002:a17:903:2450:b0:1fb:2ebc:d16b with SMTP id
 d9443c01a7336-200967f7884mr60229725ad.7.1723183899982; 
 Thu, 08 Aug 2024 23:11:39 -0700 (PDT)
Received: from localhost ([146.112.118.69]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff592b7d3bsm134167045ad.302.2024.08.08.23.11.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Aug 2024 23:11:39 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Aug 2024 16:11:35 +1000
Message-Id: <D3B5PKXVIPUN.2JSO6MPU9DPW1@gmail.com>
Subject: Re: [PATCH for-9.1] tcg/ppc: Sync tcg_out_test and constraints
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
Cc: <qemu-stable@nongnu.org>, "qemu-ppc" <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.18.2
References: <20240807040843.7882-1-richard.henderson@linaro.org>
 <44328324-af73-4439-9d2b-d414e0e13dd7@linaro.org>
In-Reply-To: <44328324-af73-4439-9d2b-d414e0e13dd7@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

On Thu Aug 8, 2024 at 2:46 AM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> On 7/8/24 06:08, Richard Henderson wrote:
> > Ensure the code structure is the same for matching constraints
> > and emitting code, lest we allow constants that cannot be
> > trivially tested.
> >=20
> > Cc: qemu-stable@nongnu.org
> > Fixes: ad788aebbab ("tcg/ppc: Support TCG_COND_TST{EQ,NE}")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2487
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >   tcg/ppc/tcg-target.c.inc | 21 ++++++++++-----------
> >   1 file changed, 10 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> > index 7f3829beeb..3553a47ba9 100644
> > --- a/tcg/ppc/tcg-target.c.inc
> > +++ b/tcg/ppc/tcg-target.c.inc
> > @@ -325,9 +325,11 @@ static bool tcg_target_const_match(int64_t sval, i=
nt ct,
> >               if ((uval & ~0xffff) =3D=3D 0 || (uval & ~0xffff0000ull) =
=3D=3D 0) {
> >                   return 1;
> >               }
> > -            if (TCG_TARGET_REG_BITS =3D=3D 32 || type =3D=3D TCG_TYPE_=
I32
> > -                ? mask_operand(uval, &mb, &me)
> > -                : mask64_operand(uval << clz64(uval), &mb, &me)) {
> > +            if (uval =3D=3D (uint32_t)uval && mask_operand(uval, &mb, =
&me)) {
> > +                return 1;
> > +            }
> > +            if (TCG_TARGET_REG_BITS =3D=3D 64 &&
> > +                mask64_operand(uval << clz64(uval), &mb, &me)) {
> >                   return 1;
> >               }
> >               return 0;
> > @@ -1749,8 +1751,6 @@ static void tcg_out_test(TCGContext *s, TCGReg de=
st, TCGReg arg1, TCGArg arg2,
> >  =20
> >       if (type =3D=3D TCG_TYPE_I32) {
> >           arg2 =3D (uint32_t)arg2;
> > -    } else if (arg2 =3D=3D (uint32_t)arg2) {
> > -        type =3D TCG_TYPE_I32;
> >       }
> >  =20
> >       if ((arg2 & ~0xffff) =3D=3D 0) {
> > @@ -1761,12 +1761,11 @@ static void tcg_out_test(TCGContext *s, TCGReg =
dest, TCGReg arg1, TCGArg arg2,
> >           tcg_out32(s, ANDIS | SAI(arg1, dest, arg2 >> 16));
> >           return;
> >       }
> > -    if (TCG_TARGET_REG_BITS =3D=3D 32 || type =3D=3D TCG_TYPE_I32) {
> > -        if (mask_operand(arg2, &mb, &me)) {
> > -            tcg_out_rlw_rc(s, RLWINM, dest, arg1, 0, mb, me, rc);
> > -            return;
> > -        }
> > -    } else {
> > +    if (arg2 =3D=3D (uint32_t)arg2 && mask_operand(arg2, &mb, &me)) {
> > +        tcg_out_rlw_rc(s, RLWINM, dest, arg1, 0, mb, me, rc);
> > +        return;
> > +    }
> > +    if (TCG_TARGET_REG_BITS =3D=3D 64) {
> >           int sh =3D clz64(arg2);
> >           if (mask64_operand(arg2 << sh, &mb, &me)) {
> >               tcg_out_rld_rc(s, RLDICR, dest, arg1, sh, me, rc);
>
> Preferably having someone from PPC also reviewing this,
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

I don't know much of the back end, but I think I follow where the
match was letting through a constant that could not be emitted.
Thanks for the fix and review.

Bigger problem seems to be I'm not testing x86 on ppc so I'll have
to rectify that. Also IIRC we were supposed to be adding a ppc
runner to gitlab CI, I'll have to check what's happening with that,
I think it got stalled on IT security rigmarole :(

Thanks,
Nick

