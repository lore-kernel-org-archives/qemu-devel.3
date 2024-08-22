Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F970C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 15:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh9mo-0005lz-Aq; Thu, 22 Aug 2024 11:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sh9mk-0005kB-Dn
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 11:31:38 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sh9mi-0007zF-D7
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 11:31:38 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a7ab63a388bso71368766b.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 08:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724340694; x=1724945494; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1hFgkaIH/nKBYZoZWeM2HW9A3rrz8SZz74mXBRb0p8o=;
 b=QAzaJCEStZx7+0BjvZ6aEgaJIYT2PB++ItuuHx86ANG+gAIRB00vve1yOjyoICB7MT
 OZlyGd93/kFw38LmjbQG29d1qApjwP/6gJdG4F0w1CLIar+GqTIK4+7WkjZcghwVR1NI
 JBgm/u1oi3b3kFQzFIIuFOBa9SEpJfBOdoj1jtqLqBYfRBRNFYhsuiPqVtNrED025QaA
 4uvxFFKAoJ+IBfDy1xorTXYVy4944qTZHSPSMlBpm3qIZM0MND2jbAbj3MFZyCiT8Q+k
 rD9bNKOGLTjn8untu+0uqTYCt9LIQb8HUpAhjsw50yp984b/PDNMBlIH52Ttmuyw0psS
 /tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724340694; x=1724945494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1hFgkaIH/nKBYZoZWeM2HW9A3rrz8SZz74mXBRb0p8o=;
 b=WB1MUTBzUkRYECNRpe9NpAa1P9EwfOU3bXW0oIfBmkQxLncIQL7swAFIxVKw+3I4OT
 bVcwGyOUt92fJVQV+oHzgIdm3dlS207VUGgBDpe6rH1ZM3dGH+b8FYnTNxG4kgCMOOKG
 MBxf7YHByqaWafT6+Ib1QNawOvpB88t5HcLysL8B0wvuwN/R+tMVNHsTadyhHeItdcmS
 ATU1tQZE+LuF5OUexL+0YG/5OHWzWJFHVlmqwGXbepqnNGFNwFzzHsxNytz9qFwF8uPa
 KBBmWUZrvlZCKQJBYXNN7sGlLDaOLsGKaby9RedaATSUVcGbBEVdJ4mj+/1CHQz4PSfe
 wWQw==
X-Gm-Message-State: AOJu0Yw+q2Ow6NeU9t6CTEZudsPc7ReEbvnpPYZHOE19jojtMdpEfZZ9
 h4BMHkoUaxO9Sgc7DCxMS9usunBNl3RZVgknmxWUjU6VgRd2cap56MKEBTnASCxk5tdIGmdfNsQ
 bZ+tV1FmORunj/Q1hcB0OJ0AgfTuwWafE1IrY6A==
X-Google-Smtp-Source: AGHT+IGpvyvVFUCQh9zrtAt02nBb7G61Ja2mxiREHeGS33DZpbodsKaIDrc/dP6QvdkZmDDYnPLd2/FtvK5NB8b38po=
X-Received: by 2002:a05:6402:530d:b0:5be:cdda:1c6b with SMTP id
 4fb4d7f45d1cf-5c0792b5a3cmr2137792a12.31.1724340693984; Thu, 22 Aug 2024
 08:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240725055447.14512-1-yaoxt.fnst@fujitsu.com>
 <CAFEAcA_MDwXrgi3xALUZcRrNq_ds6LyL2HwvCS+Syv8vwDGW-Q@mail.gmail.com>
 <OSZPR01MB645376D56BA4BE4B5C4B9FF78D8E2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB645376D56BA4BE4B5C4B9FF78D8E2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Aug 2024 16:31:22 +0100
Message-ID: <CAFEAcA9kbWEvCPYCKkvpYQP_W6ASwtkMH7gsehM+qDS5DTRWVg@mail.gmail.com>
Subject: Re: [PATCH] scripts/coccinelle: New range.cocci
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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

On Wed, 21 Aug 2024 at 01:21, Xingtao Yao (Fujitsu)
<yaoxt.fnst@fujitsu.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Peter Maydell <peter.maydell@linaro.org>
> > Sent: Tuesday, August 20, 2024 4:41 PM
> > To: Yao, Xingtao/=E5=A7=9A =E5=B9=B8=E6=B6=9B <yaoxt.fnst@fujitsu.com>
> > Cc: qemu-devel@nongnu.org
> > Subject: Re: [PATCH] scripts/coccinelle: New range.cocci
> >
> > On Thu, 25 Jul 2024 at 06:55, Yao Xingtao via <qemu-devel@nongnu.org> w=
rote:
> > >
> > > This is the semantic patch from commit 7b3e371526 "cxl/mailbox: make
> > > range overlap check more readable"
> > >
> > > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > > ---
> > >  scripts/coccinelle/range.cocci | 49
> > ++++++++++++++++++++++++++++++++++
> > >  1 file changed, 49 insertions(+)
> > >  create mode 100644 scripts/coccinelle/range.cocci
> > >
> > > diff --git a/scripts/coccinelle/range.cocci b/scripts/coccinelle/rang=
e.cocci
> > > new file mode 100644
> > > index 000000000000..21b07945ccb2
> > > --- /dev/null
> > > +++ b/scripts/coccinelle/range.cocci
> > > @@ -0,0 +1,49 @@
> > > +/*
> > > +  Usage:
> > > +
> > > +    spatch \
> > > +           --macro-file scripts/cocci-macro-file.h \
> > > +           --sp-file scripts/coccinelle/range.cocci \
> > > +           --keep-comments \
> > > +           --in-place \
> > > +           --dir .
> > > +
> > > +  Description:
> > > +    Find out the range overlap check and use ranges_overlap() instea=
d.
> > > +
> > > +  Note:
> > > +    This pattern cannot accurately match the region overlap check, a=
nd you
> > > +    need to manually delete the use cases that do not meet the condi=
tions.
> > > +
> > > +    In addition, the parameters of ranges_overlap() may be filled in=
correctly,
> > > +    and some use cases may be better to use range_overlaps_range().
> >
> > I think these restrictions mean that we should do one
> > of two things:
> >  (1) rewrite this as a Coccinelle script that just prints
> >      out the places where it found matches (i.e. a "grep"
> >      type operation, not a search-and-replace), so the
> >      user can then go and investigate them and do the
> >      range_overlap they want to do
> >  (2) fix the problems so that you really can apply it to
> >      the source tree and get correct fixes
> >
> > The ideal would be (2) -- the ideal flow for coccinelle
> > driven patches is that you can review the coccinelle
> > script to check for things like off-by-one errors, and
> > then can trust all the changes it makes. Otherwise
> > reviewers need to carefully scrutinize each source
> > change individually.
> >
> > It's the off-by-one issue that really makes me think
> > that (2) would be preferable -- it would otherwise
> > be I think quite easy to accidentally rewrite a correct
> > range check into one that's off-by-one and not notice.
> thanks for your reply!
> I tried my best to match all the patterns of the region overlap check,
> but it is difficult, I am not good at cocci, could you give me some advic=
e?


Something like this seems to me to work and mostly makes the
same substitutions as your series suggests:

=3D=3D=3Dbegin=3D=3D=3D
//  Usage:
//    spatch \
//          --macro-file scripts/cocci-macro-file.h \
//           --sp-file scripts/coccinelle/range.cocci \
//           --keep-comments \
//           --in-place \
//           --dir .
//
//  Description:
//   Find out the range overlap check and use ranges_overlap() instead.
//
// Usage notes:
// * Any change made here shouldn't be a behaviour change, but you'll
//   need to check that the suggested changes really are range checks
//   semantically, and not something else that happened to match the patter=
n.
//   In particular the patterns for (start1, end1) vs (start2, end2)
//   can match very widely.
// * This won't detect cases where somebody intended to write a range overl=
ap
//   but made an off-by-one error in the bounds checks.
// * You may need to add a #include "qemu/range.h" to the file.
//
// The arguments to ranges_overlap() are start1, len1, start2, len2.
// This means that the last value included in each range is (start + len - =
1).
//
// Note that Coccinelle is smart enough to match unbracketed
// versions of expressions if we provide it with patterns with brackets,
// but not vice-versa, so our match expressions are generous with bracketin=
g.

@@
// Where the code expresses things in terms of start and length:
expression S1, L1, S2, L2;
@@
(
- (((S1 + L1) <=3D S2) || ((S2 + L2) <=3D S1))
+ !ranges_overlap(S1, L1, S2, L2)
|
- ((S1 < (S2 + L2)) && (S2 < (S1 + L1)))
+ ranges_overlap(S1, L1, S2, L2)
)
@@
// Where the code expresses things with (start, length) and (start, end)
// with the 'end' byte not being inside the second range.
expression S1, E1, S2, L2;
@@
(
- ((S1 >=3D (S2 + L2)) || (E1 <=3D S2))
+ !ranges_overlap(S1, E1 - S1, S2, L2)
|
- ((S1 < (S2 + L2)) && (E1 > S2))
+ ranges_overlap(S1, E1 - S1, S2, L2)
)
@@
// Where the code expresses things with (start, end), (start, end)
// with the 'end' bytes not being inside the second range.
expression S1, E1, S2, E2;
@@
(
- ((S1 >=3D E2) || (E1 <=3D S2))
+ !ranges_overlap(S1, E1 - S1, S2, E2 - S2)
|
- ((S1 < E2) && (E1 > S2))
+ ranges_overlap(S1, E1 - S1, S2, E2 - S2)
)
=3D=3D=3Dendit=3D=3D=3D

The awkward part here is that (as the notes suggest) those last
two patterns will match an awful lot of things that aren't
ranges. (I think we could in theory improve on that a bit by
for instance insisting that none of S1 S2 E1 E2 were constants,
but that seems tricky at minimum in Coccinelle.) But at least
the substitution they suggest will be an arithmetically correct one.

A couple of other review notes:
 * our Coccinelle comment format style is '//', not C-style comments
 * all new files in the tree need the usual copyright-and-license
   information at the top

thanks
-- PMM

