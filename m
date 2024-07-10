Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B151C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 12:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRWpg-0005Bj-F1; Wed, 10 Jul 2024 08:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1sRWpf-0005AP-2l
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 08:54:03 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1sRWpd-0005Mc-25
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 08:54:02 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-6e7e23b42c3so3350831a12.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 05:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1720616039; x=1721220839; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xcI3G78QRRbAdulHX3Cxc4DSj45wRt18Z4TKgO4B1E4=;
 b=XI+vk60R257pUfEIDymhhLxg9qYgcTy2p2dxL4LFcsB4mgWyxyf/NsvZmJ77aqLquD
 8Icks58yeByt9f/MsCBwaYhyX1Il22Na/HA06QRzYr4QLaRzO6JxyO/9rBc3/Ow+V892
 dUAAX0hzoKXtBNXmkj0Dnldy/jWBUv614kJ/o/ifMID0Q/GbhL8oGovw8tAFy7EFI+za
 jG9Nod9j3K8dXyUVEiQUKYBPhCM53HPgpfRP++9Ghe2mHu9q8/y+b/h2CSjUOJqV2/gC
 ub4D5bv77VkPxIC44iGKFGBe9+eMdNQMtmgnYZyaSUKQfZNreP9SYOF+PtrXClcWT2fv
 I2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720616039; x=1721220839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xcI3G78QRRbAdulHX3Cxc4DSj45wRt18Z4TKgO4B1E4=;
 b=iqKP8fzJp5m/5lOJdQUwa4OUXRlQoh9rAJMR3mdlN4ruHvoK/tAgiNNCdvbEgYLYqr
 7WbQpJW94LX7NW6C4LC1VzmI4IJPIe+QBqrvjq+Na84SSugV491dwQ2io+Sx3mem7clm
 8o4Kc0XygvrrbB25q41j7FegHhhs8BcXfw+xal3PkVxo8Qk4Ly5EInHfTbc0mQ+qM+4l
 2AJci7NhyfXh7nKmpCFioH0rysRXmmvErby94Tq4tUQJTBPeVX9vepr7U6iGaga0wUdB
 lITU6nhftQnJ3aVowNeSQV1kXwP6oJ59+duhAM8GR+PQ5y/wvhiIJm76b/RHVIfag6VU
 0kmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdA5xiPXIET6hycyzwGU0yMT3kedLrY5yWf7smieumylmoChXGnQn9tlAIcn2cX3FVUgL+Z9WWwT0ZGiRGrkBWn6pWuYo=
X-Gm-Message-State: AOJu0Yz92IlXNljarxieIRQAAReOZtwF1ULaX1gNsB+5ujgKSOwEUC2E
 WwQAKpBvXU78he5c+kgRCD760Kp/vOB4zBWDM8m3SnHjl5qB5aqN1X9r6VcnobhOJKtqHIWDVeS
 5Ij/rjtwP+O6pMD/FynqB0kLh2+GyO4FVEofR
X-Google-Smtp-Source: AGHT+IE4K9WIUD7ehTvB+tCIng4AdsxqmLsMFKAE8DIO3YdwCB0qx9jrZp40AJCcn7+dC1ZMizthfn2SpW5QFze9Iow=
X-Received: by 2002:a05:6a20:1e44:b0:1bd:23c7:ebfb with SMTP id
 adf61e73a8af0-1c2984e11e5mr4076797637.62.1720616039181; Wed, 10 Jul 2024
 05:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240608083415.2769160-1-pbonzini@redhat.com>
 <20240608083415.2769160-14-pbonzini@redhat.com>
 <CAJ307EhO9MEk7=w62CGjYn9J3YGOPk0e7gRKMUGk57Wh0y75rg@mail.gmail.com>
 <0a94f7e1-611f-42bd-8fea-d3c940a26647@redhat.com>
In-Reply-To: <0a94f7e1-611f-42bd-8fea-d3c940a26647@redhat.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Wed, 10 Jul 2024 14:53:47 +0200
Message-ID: <CAJ307Ei0bUW8bJebOXswkvvJrFVbE_wqHNAK4stohViaJpREtQ@mail.gmail.com>
Subject: Re: [PULL 13/42] target/i386: use gen_writeback() within gen_POP()
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=chigot@adacore.com; helo=mail-pg1-x52f.google.com
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

On Wed, Jul 10, 2024 at 12:43=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> On 7/10/24 11:42, Cl=C3=A9ment Chigot wrote:
> > Hi Mark,
> >
> > This patch introduces regressions in our x86_64 VxWorks kernels
> > running over qemu. Some page faults are triggered randomly.
> >
> > Earlier to this patch, the MemOp `ot` passed to `gen_op_st_v` was the
> > `gen_pop_T0` created a few lines above.
> > Now, this is `op->ot` which comes from elsewhere.
> >
> > Adding `op->ot =3D ot` just before calling `gen_writeback` fixes my
> > regressions. But I'm wondering if there could be some unexpected
> > fallbacks, `op->ot` possibly being used afterwards.
>
> Mark's patch is correct and the (previously latent) mistake is in
> the decoding table.
>
> The manual correctly says that POP has "default 64-bit" operand;
> that is, it is 64-bit even without a REX.W prefix.  It must be
> marked as "d64" rather than "v".
>
> Can you test this patch?

Yes, it does work. Thanks a lot for it !

> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-ne=
w.c.inc
> index 0d846c32c22..d2da1d396d5 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -1717,7 +1717,7 @@ static const X86OpEntry opcodes_root[256] =3D {
>       [0x8C] =3D X86_OP_ENTRYwr(MOV, E,v, S,w, op0_Mw),
>       [0x8D] =3D X86_OP_ENTRYwr(LEA, G,v, M,v, nolea),
>       [0x8E] =3D X86_OP_ENTRYwr(MOV, S,w, E,w),
> -    [0x8F] =3D X86_OP_GROUPw(group1A, E,v),
> +    [0x8F] =3D X86_OP_GROUPw(group1A, E,d64),
>
>       [0x98] =3D X86_OP_ENTRY1(CBW,    0,v), /* rAX */
>       [0x99] =3D X86_OP_ENTRYwr(CWD,   2,v, 0,v), /* rDX, rAX */
> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
> index fc7477833bc..36bb308e449 100644
> --- a/target/i386/tcg/emit.c.inc
> +++ b/target/i386/tcg/emit.c.inc
> @@ -2788,6 +2788,8 @@ static void gen_POP(DisasContext *s, X86DecodedInsn=
 *decode)
>       X86DecodedOp *op =3D &decode->op[0];
>       MemOp ot =3D gen_pop_T0(s);
>
> +    /* Only 16/32-bit access in 32-bit mode, 16/64-bit access in long mo=
de.  */
> +    assert(ot =3D=3D op->ot);
>       if (op->has_ea || op->unit =3D=3D X86_OP_SEG) {
>           /* NOTE: order is important for MMU exceptions */
>           gen_writeback(s, decode, 0, s->T0);
>
> Thanks (and it's reassuring that everything else has worked fine
> for you!),
>
> Paolo
>
> > Thanks,
> > Cl=C3=A9ment
> >
> > On Sat, Jun 8, 2024 at 10:36=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.=
com> wrote:
> >>
> >> From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >>
> >> Instead of directly implementing the writeback using gen_op_st_v(), us=
e the
> >> existing gen_writeback() function.
> >>
> >> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> >> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >> Message-ID: <20240606095319.229650-3-mark.cave-ayland@ilande.co.uk>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> >>   target/i386/tcg/emit.c.inc | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
> >> index ca78504b6e4..6123235c000 100644
> >> --- a/target/i386/tcg/emit.c.inc
> >> +++ b/target/i386/tcg/emit.c.inc
> >> @@ -2580,9 +2580,9 @@ static void gen_POP(DisasContext *s, CPUX86State=
 *env, X86DecodedInsn *decode)
> >>
> >>       if (op->has_ea) {
> >>           /* NOTE: order is important for MMU exceptions */
> >> -        gen_op_st_v(s, ot, s->T0, s->A0);
> >> -        op->unit =3D X86_OP_SKIP;
> >> +        gen_writeback(s, decode, 0, s->T0);
> >>       }
> >> +
> >>       /* NOTE: writing back registers after update is important for po=
p %sp */
> >>       gen_pop_update(s, ot);
> >>   }
> >> --
> >> 2.45.1
> >>
> >>
> >
> >
>

