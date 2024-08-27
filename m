Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93A7C54734
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 11:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siui1-0002bW-Et; Tue, 27 Aug 2024 07:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1siuhz-0002aV-Vm
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:50:00 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1siuhy-0003Fh-Dz
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:49:59 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-201e52ca0caso37904895ad.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 04:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1724759396; x=1725364196; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N1LIUfVr5TEqcG8OA04wMBB6meM6iPqqsTecNl3xdtM=;
 b=V7V4v7u3WUbJVpmAbKqDLstCVuMcnhAzmrRsxvoglYGpC8zUFybdnR7237yfeWacgV
 fC2FI28cOPGamkNRv/C2RBv84xApZ30NGaRV0T9kV/mpPASAvSayiDOMg2ZsQnld5WrL
 xvoFE9VSA9YcYiemth1G5dgAkdAwZz5kwxnzhmrl09H1/6MxKb7jQfYC0y0oCwDdYoIR
 gOKTJSPYBu0r4Fz0q3kUHV82Vfpy/44X6VX0s8XnNFPEAoElhd7PshijBuRE2bYIntoz
 6MycF4fvjWtGDwhgkRA6wUf1Rq4b7Gu99Iv1Oo2/yYpqjkE5majWOQ7AAxmKTGM1sCzd
 84kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724759396; x=1725364196;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N1LIUfVr5TEqcG8OA04wMBB6meM6iPqqsTecNl3xdtM=;
 b=XBZZky60KIvQvVp/sNy27vCix+W4jToAz5xdi8AHv8BTjhDDWiyBmJTcOoEuJxAvuT
 Xy5BRVI1m2KWoT+pjg/feuzWzxhF0lBwm9iXMoy/Ye0SFIJNuBzDPvcadVeI/8lrnRUj
 ccx4PzhmMsjdPOh3o6GXga6+vz8AyygnIMOL5QpZUTodKRC0F+r2pC7406BVEGj8zFSA
 LnYeANOjuvRM6XashLaGez4fodpfEdhHwv8HHwvOpGFpMgkukuDbMjQ3bukJ8++SrFVS
 y7Ggk5JvwOTsE7yaEDpTwzQdh7Len2+GhwSdcLlHft32PXKVZ2ERBmDUHlqTv+BgDjpH
 ENuA==
X-Gm-Message-State: AOJu0YwMX6N8cHadYmmrqc9w5zIb3jB43NjZPxDLuOmoYfnjjE/14ItR
 J0d/NyAvQ6ttxGVW6okwR4+fsXqr9R2LKHXJZipAohKVjy5ldZ6Mzmdv9GKiep1r2Txi5Q0JbuJ
 RUiK9KoO/q+4PwZ7RnThb/uA8NKz5BNUSyND9xnQELR77/xs=
X-Google-Smtp-Source: AGHT+IFhvlQVhTBHJk8JUheCsPL6J6Gwa5o8aVW4s2qDR7/QEXgBKYR6lrDTr80fAPbi3uM2Nc8F+DUQPlsb8lJ+t3U=
X-Received: by 2002:a17:902:d4ce:b0:201:f853:3e69 with SMTP id
 d9443c01a7336-2039e4fbb83mr133643035ad.57.1724759396102; Tue, 27 Aug 2024
 04:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240715084639.983127-1-chigot@adacore.com>
 <CAJ307EhvEYa6owtcXmjnBp_9k3HQXbbpbQck9pgS5d9wXgxfGw@mail.gmail.com>
In-Reply-To: <CAJ307EhvEYa6owtcXmjnBp_9k3HQXbbpbQck9pgS5d9wXgxfGw@mail.gmail.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Tue, 27 Aug 2024 13:49:44 +0200
Message-ID: <CAJ307Eh8aKvdi7kifGO0RoEpmyEXt9b7oYmYvFtw7KjgyepGxg@mail.gmail.com>
Subject: Re: [PATCH] hw/ppc: fix decrementer with BookE timers
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com, Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=chigot@adacore.com; helo=mail-pl1-x631.google.com
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

Hey,

Gentle ping

Thanks Cl=C3=A9ment

On Mon, Jul 29, 2024 at 10:33=E2=80=AFAM Cl=C3=A9ment Chigot <chigot@adacor=
e.com> wrote:
>
> Hi,
>
> Gentle ping + CC missing maintainers.
>
> Thanks Cl=C3=A9ment
>
> On Mon, Jul 15, 2024 at 10:46=E2=80=AFAM Cl=C3=A9ment Chigot <chigot@adac=
ore.com> wrote:
> >
> > The BookE decrementer stops at 0, meaning that it won't decremented
> > towards "negative" values.
> > However, the current logic is inverted: decr is updated solely when
> > the resulting value would be negative.
> >
> > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> > Fixed: 8e0a5ac87800 ("hw/ppc: Avoid decrementer rounding errors")
> > ---
> >  hw/ppc/ppc.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> > index e6fa5580c0..9fc85c7de0 100644
> > --- a/hw/ppc/ppc.c
> > +++ b/hw/ppc/ppc.c
> > @@ -729,7 +729,9 @@ static inline int64_t __cpu_ppc_load_decr(CPUPPCSta=
te *env, int64_t now,
> >      int64_t decr;
> >
> >      n =3D ns_to_tb(tb_env->decr_freq, now);
> > -    if (next > n && tb_env->flags & PPC_TIMER_BOOKE) {
> > +
> > +    /* BookE timers stop when reaching 0.  */
> > +    if (next < n && tb_env->flags & PPC_TIMER_BOOKE) {
> >          decr =3D 0;
> >      } else {
> >          decr =3D next - n;
> > --
> > 2.25.1
> >

