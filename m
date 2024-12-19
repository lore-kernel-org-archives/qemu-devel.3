Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55733E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 00:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO4QP-0002Yb-JU; Wed, 18 Dec 2024 19:29:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO4QE-0002Y5-Qg; Wed, 18 Dec 2024 19:29:47 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO4QC-00008H-VE; Wed, 18 Dec 2024 19:29:46 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-725c86bbae7so219304b3a.3; 
 Wed, 18 Dec 2024 16:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734568183; x=1735172983; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7qY0p9SykZf9ZkNUIWWTuMCPeHT1fKXv5iBbBEdoGPk=;
 b=Xxv4KY/P2lcmjRRnWvVYcgDbtDql9LrQbTByIgw1CDQnbOshSlAVUwzeCkMhe4UdW7
 pyegat21Ok+vRKe05aqkzEn+ii3yG8lNYLOn17oN7iJvoHf7NotAUjqBNWQIX/sjD41Z
 lte80D+TfoZ1S6lsdFS2xKmAUTvTyqUmfGiYW4/2uSYCYIFYqTIfF8k77C0uxPzNIMiB
 jBlx6RZRzJpvJoZiqC6DjhNgGP3cDGqP6kGe4utdSvxZH6lZo1PahxFFrZFMkBiMcEtn
 TRlU3HXsyN9B6yJgcs1EGti5T03yf8d40/7Ugt/SXfk/SNSgJe6THgnDBX0fTRRksXyG
 tPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734568183; x=1735172983;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7qY0p9SykZf9ZkNUIWWTuMCPeHT1fKXv5iBbBEdoGPk=;
 b=GKUjXNGsMzNc7/QU3RF59gVp8jia9NXQHkW4TvOix1gTaGr977Wit+Q+99kv69OZa7
 gB9diJ1jdxVUNXQSzzQaW1I1VG65112Rc8SO91tj3V15oe1/TWITh7mjKd/74O27uwI6
 DYmiOrKit+Qy1KslEcUKTtQisLB6yV1dR5s36d1+wrCd6bi2QiSuuHyXZCwaTOpnXcMZ
 fT+0Sya3BCVfM0EOI0iit13y2zFx99qsXV7wTJdDcBs31pRbbG5kyAiK6iPBcgqxCea+
 g2HS4fey0u5blJOpY16FMv2HgDX/nFwX/de0tJW81tEoMh/PtpXLfTD3SqwuZFZw+d+V
 7agA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUCl5rgs3efl450Zvn+79z7eCkWbVlVHu8hayuIplfSKLfc5ExLSyGs55tmtIL5jwd07hdGdGHJw==@nongnu.org
X-Gm-Message-State: AOJu0YyGNmXwC+KUCWdLXNkWQmUvF17aRtJfUDNfDoIZFSsgkVXWkPdN
 y1bCwY/XyMsg3WrharyAV6Ls8slzNSvBsqPJpMtgQv4IL9MawcRr
X-Gm-Gg: ASbGncsMwh+tygrtMXw7UirbzsMTGlPmUNmwOpTsnYcqHVszxGYNJIbdKADVRn+iSz4
 0h9EYJWKOJ1PYP9GCoE9o0qmeBkmx+KbndXTcH+icIur9KntuhRPGo+eoB6Qhm2A1/0R4rpmXqk
 EDFsQVFNOBjabo9rq8hXOKWhM6qJxaL3on8DyesXwDg6zklpfaSkVvwqbFOp4FiVW3FxZomZy8G
 r2eFt6IA7yXD10SA21SSa8mafjP0XZMzpE83NNA09+KprjEx4Bev+fvxY9ooIq6cBYiucqqqSs=
X-Google-Smtp-Source: AGHT+IGKtgu35FgBIOzbk+TTPXXNGrf000lDPIWIE9+yEBF31bpm1Xk6zYcSOKdjRJUT5qGKA4FOsw==
X-Received: by 2002:a05:6a00:3307:b0:725:90f9:daf9 with SMTP id
 d2e1a72fcca58-72a8d261072mr6604701b3a.15.1734568183249; 
 Wed, 18 Dec 2024 16:29:43 -0800 (PST)
Received: from localhost (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad837395sm75634b3a.69.2024.12.18.16.29.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 16:29:42 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Dec 2024 10:29:36 +1000
Message-Id: <D6F93NM6OW2L.2FDO88L38PABR@gmail.com>
Cc: <qemu-devel@nongnu.org>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>,
 "Daniel Henrique Barboza" <danielhb413@gmail.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, <qemu-ppc@nongnu.org>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Peter Maydell" <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 7/7] hw/ppc/epapr: Do not swap ePAPR magic value
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: aerc 0.18.2
References: <20241218182106.78800-1-philmd@linaro.org>
 <20241218182106.78800-8-philmd@linaro.org>
 <277eeed4-0467-1529-f52d-2c128d8d46bb@eik.bme.hu>
In-Reply-To: <277eeed4-0467-1529-f52d-2c128d8d46bb@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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

On Thu Dec 19, 2024 at 5:18 AM AEST, BALATON Zoltan wrote:
> On Wed, 18 Dec 2024, Philippe Mathieu-Daud=C3=A9 wrote:
> > The ePAPR magic value in $r6 doesn't need to be byte swapped.
> >
> > See ePAPR-v1.1.pdf chapter 5.4.1 "Boot CPU Initial Register State"
> > and the following mailing-list thread:
> > https://lore.kernel.org/qemu-devel/CAFEAcA_NR4XW5DNL4nq7vnH4XRH5UWbhQCx=
uLyKqYk6_FCBrAA@mail.gmail.com/
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> > hw/ppc/sam460ex.c     | 2 +-
> > hw/ppc/virtex_ml507.c | 2 +-
> > 2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> > index 78e2a46e753..db9c8f3fa6e 100644
> > --- a/hw/ppc/sam460ex.c
> > +++ b/hw/ppc/sam460ex.c
> > @@ -234,7 +234,7 @@ static void main_cpu_reset(void *opaque)
> >
> >         /* Create a mapping for the kernel.  */
> >         booke_set_tlb(&env->tlb.tlbe[0], 0, 0, 1 << 31);
> > -        env->gpr[6] =3D tswap32(EPAPR_MAGIC);
> > +        env->gpr[6] =3D EPAPR_MAGIC;
>
> I don't know how to test this (or if anything actually uses it).

The Linux kernel boot wrapper tests it AFAIKS. Does this mean
they never worked on LE hosts?

> not sure about is what endianness env->gpr is? It's a host array so maybe=
=20
> it needs to match the host endianness which is little endian most of the=
=20
> time as opposed to PPC big endian on this machine. So maybe tswap is wron=
g=20
> but is removing it right? Maybe we need to only swap on LE hosts. I think=
=20
> it's only used by Linux kernels so maybe trying to boot one could test=20
> this change but I'm not sure.

Yes env->gpr is host-endian, and emulated target code will see
the same value that the host does. It can't be correct because
the machine running in emulation can't possibly know what endian
the host is.

I think we should just take it, it looks trivially correct
(always dangerous words when dealing with early boot code, lol).

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Regards,
> BALATON Zoltan
>
> >         env->gpr[7] =3D (16 * MiB) - 8; /* bi->ima_size; */
> >
> >     } else {
> > diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> > index f378e5c4a90..6197d31d88f 100644
> > --- a/hw/ppc/virtex_ml507.c
> > +++ b/hw/ppc/virtex_ml507.c
> > @@ -119,7 +119,7 @@ static void main_cpu_reset(void *opaque)
> >     /* Create a mapping spanning the 32bit addr space. */
> >     booke_set_tlb(&env->tlb.tlbe[0], 0, 0, 1U << 31);
> >     booke_set_tlb(&env->tlb.tlbe[1], 0x80000000, 0x80000000, 1U << 31);
> > -    env->gpr[6] =3D tswap32(EPAPR_MAGIC);
> > +    env->gpr[6] =3D EPAPR_MAGIC;
> >     env->gpr[7] =3D bi->ima_size;
> > }
> >
> >


