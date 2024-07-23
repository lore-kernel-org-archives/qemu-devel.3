Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32577C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 17:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWJOZ-0005Vk-Ni; Tue, 23 Jul 2024 13:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWJOX-0005VF-Si
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 13:33:50 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWJOV-0003Jm-K3
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 13:33:49 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a7aaa77fac4so8317166b.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 10:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721756025; x=1722360825; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vbncix//iWOPLASlg+LzKx9lQZMDl+Y+aCcev+Szhs4=;
 b=CWug1wDo9cat+1dAyz4VE1VuLr3aG2p/Z6aHECdNgay08eKjne6k+a+m4r5uaI6ZIh
 vQPRH/T5Tui/pYlmRBmMG/eQlkCqMTa7UoeQzvMyHPjO/f6vOEHwSORYwByXc1EhkJJT
 pk6fjlc3Bf51wJTERNMhI/RKIXFOGl0ZPFZ10R5iTLQLLmc8XJDEwnLLCM38HDqy6wnY
 GLnadFtU91qcLLPfSOJ258WryXvoXWCKAzoib6DGtCg+Ooemc1yU6POhhvGhJmWytaTO
 n4WYCVp64uQKNR0J+bw2cHe/IyjhAKJIg2BZIuj1zpxdrrZd7BzIDzEYTf7nq6HhM+1K
 wByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721756025; x=1722360825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vbncix//iWOPLASlg+LzKx9lQZMDl+Y+aCcev+Szhs4=;
 b=ijeoHHHbvI0BObqEhjVi7/nhy9mTOMmPvX577fz73wgtbXZrFWlJxqJbS0lpjaS5wh
 q7eK1RNrxtj0ubvRew2ySudAxxFbcAm57aeJ0vj8lZ8SM3VrMap29DI31z85uAM4Qw+q
 Mhw8lwTD206CdcheeKYnsUVlDME9kxvCY1Jr/6BYoAU7TwjAb0ib83DFouPj2mvc7CXs
 O1X8XAln4RUInsn2dvzSg/vc8CpvEPu/ZKORw0uQQiFS7kH2D646K+5K8/ly8FAmBkVs
 JgzxkCANptSYOquiFfc4SgIbr1RmgA70JBIB0R0HoLQSpgKHAq0csm11c5o4RBrObBrQ
 TEvw==
X-Gm-Message-State: AOJu0YyhTHjMQPX2Xa6b2zOhohlwU1lBaHe3Oqptz3n/ycqXGf//jJ2R
 xipWcTrfzSpcMJ7OpQdQN4N7XEHiy5L6OrhFxm8EgfCKwSwASJ/YfR1Mm87zsmBTjvl4WdrHF61
 Q1veMueUkmYQS2sFp2S8LuIfmfXcC4U4jK/ugxg==
X-Google-Smtp-Source: AGHT+IGwa6Q6EK3+FRpW97z8vFOcpcD140ydJNsazR6N5wv3NpjFS+huEBP9VFb159Ad+wP2ilFKnTr2RIEkG/nOCqQ=
X-Received: by 2002:a50:c314:0:b0:5a2:c1b1:4d3 with SMTP id
 4fb4d7f45d1cf-5aaa50c9c7emr504670a12.28.1721756025098; Tue, 23 Jul 2024
 10:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240723151454.1396826-1-peter.maydell@linaro.org>
 <CAMo8BfL_1CsSVbi66rhR=RTSFyVgOwZqEZfUv4tc=EqvTYjmNA@mail.gmail.com>
In-Reply-To: <CAMo8BfL_1CsSVbi66rhR=RTSFyVgOwZqEZfUv4tc=EqvTYjmNA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jul 2024 18:33:33 +0100
Message-ID: <CAFEAcA-Va1GvQ_u3KKiHESgvpvM-sKBvB=JvxTf6Di-5AKX=Hw@mail.gmail.com>
Subject: Re: [PATCH] target/xtensa: Make use of 'segment' in pptlb helper less
 confusing
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 23 Jul 2024 at 18:09, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Tue, Jul 23, 2024 at 8:14=E2=80=AFAM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > Coverity gets confused about the use of the 'segment' variable in the
> > pptlb helper function: it thinks that we can take a code path where
> > we first initialize it:
> >   unsigned segment =3D XTENSA_MPU_PROBE_B;  // 0x40000000
> > and then use that value as a shift count:
> >   } else if (nhits =3D=3D 1 && (env->sregs[MPUENB] & (1u << segment))) =
{
> >
> > In fact this isn't possible, beacuse xtensa_mpu_lookup() is passed
> > '&segment', and it uses that as an output value, which it will always
> > set if it returns nonzero.  But the way the code is currently written
> > is confusing to a human reader as well as to Coverity.
> >
> > Instead of initializing 'segment' at the top of the function with a
> > value that's only used in the "nhits =3D=3D 0" code path, use the
> > constant value directly in that code path, and don't initialize
> > segment.  This matches the way we use xtensa_mpu_lookup() in its
> > other callsites in get_physical_addr_mpu().
> >
> > Resolves: Coverity CID 1547589
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  target/xtensa/mmu_helper.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
> > index 997b21d3890..29b84d5dbf6 100644
> > --- a/target/xtensa/mmu_helper.c
> > +++ b/target/xtensa/mmu_helper.c
> > @@ -991,7 +991,7 @@ uint32_t HELPER(rptlb1)(CPUXtensaState *env, uint32=
_t s)
> >  uint32_t HELPER(pptlb)(CPUXtensaState *env, uint32_t v)
> >  {
> >      unsigned nhits;
> > -    unsigned segment =3D XTENSA_MPU_PROBE_B;
> > +    unsigned segment;
>
> The change suggests that coverity is ok with potentially using
> uninitialized value in the shift, but not with the value that would
> definitely make the shift illegal, which is a bit odd.

Yeah, the new Coverity check that has resulted in it detecting
hundreds of new "issues" relating to overflow is a bit broken
and has produced a lot of "it ought to be able to realise that
what it's suggesting is impossible" issues.

For instance there is a whole category of issues which look like:

     int x =3D foo(); /* returns -1 on error */
     if (x < 0) {
         return;
     }
     some arithmetic operation involving x;

where it complains that the arithmetic operation might overflow
because x might be negative because foo() can return a negative
value. It seems like it traces a line from "x could be a
specific constant value here" through to "this is a place where
if we use that constant value then it would go wrong", without
tying it into its own dataflow knowledge that would tell it that
the code-execution-path it claims is problematic can't happen
with that value of the constant.

I resolved at least a hundred of these new errors as false-positives;
this is one of the cases where I felt that even though it wasn't
actually correct about the possible error it was somewhere where
we could make our code more readable to humans (it took me two
tries reading the code before I figured out what was going on
and that this wasn't a "confusion between whether variable is
a bit value or a mask" bug).

(Also it's possible Coverity will also complain about the
possible-use-uninitialized; we can't tell until the change is
in the tree and it gets re-scanned. But if it does I'll mark
that as a false-positive.)

thanks
-- PMM

