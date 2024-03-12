Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4614C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxyw-00015y-Oa; Tue, 12 Mar 2024 04:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjxyp-00014s-Fa; Tue, 12 Mar 2024 04:59:27 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjxym-0007UW-VT; Tue, 12 Mar 2024 04:59:26 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5d3912c9a83so3441385a12.3; 
 Tue, 12 Mar 2024 01:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710233963; x=1710838763; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sEbC4eCs3pbGDskAHW1xVByeXhtUetTLtcMbx2y3JKw=;
 b=MpFhn4zXf6W4qORz2XnY32dlvp8rBHg9jopYMlrk6/eA6KbS3qy6j007+mIiUz/8rq
 3zWO/G7x3VYdGbKqhnf3PAWApjlb09HqlU5uz8OOx2KJN1w7PVOBlLfuXq9f1oLNgqex
 rhrjpfKaVL0tJfxX6FGKRC17cJRmPo2eMaTqxzxL60AX4DhvqPb1/VhuHCcIGuU2Dtpo
 CK0CWH2yvMnwDTTipg+KKP9X+O1aCF7jwlRiuRaB1PMMyYcMmme+oIc4X7vWoNxodljK
 f+gSSDvfZatGhuTq3+Y9Q8935asev97Fx9yb4pW/pw9tvtlNyQSA7JH5eRax18mGoS56
 2E/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710233963; x=1710838763;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sEbC4eCs3pbGDskAHW1xVByeXhtUetTLtcMbx2y3JKw=;
 b=pVmgAH5O6FC2n8cJe8ep+EzOQDegsZ90gCko2trmo08Jmu8aepfK2sCV4vBy97fc8h
 WIVMUNmTLoiv1aO4cZ1i7d1nJTuXJ9UO57RIjGPnVhw2JE1kCemzRjQQ8G26p4U5UfIz
 6WcsrQ8Dj2391vOpocfRKFlFLjfvfvdMe4096OkK/XUjF00wHOzwQhmj4xgDpjwo4g+2
 xQ+8TnCBEqVRuGT687g5+02MquF0HPRfjKcFXFC948EmDnW7ApLgg5YC5HB21Iu6lPiu
 X6mX3GYrTL3685KK2E2FFyDKeBtDVWzJrm7sSjHm1bs+TsXar0CilakR4l8wpsKm0Mdz
 0MsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1jLWaq07LmyYKRhwtZ/gEqd4Ppl3X24OfiLxTx2LJBmtFo9mb1Ff6Q/eidZy2c0A35MuHYUcoQ8XTotjYSwRokItF
X-Gm-Message-State: AOJu0YxmgBKyC2UFJvrQBSe/UdlhQjDnrj/0qKgtsEtBE6UhWoDqg11P
 vxcQqu4ZWkhRgqnRJfQSJJpDPxJ6jl9Fu3atjFhEQ8DEeHIndOnoVgS6i+kdOdI=
X-Google-Smtp-Source: AGHT+IGF92y9ENwJeo5QeVxonXnc5N/Z6hdy2csQ3rdGoPzPk+cr/Ep5GvXS1EJrLP2t0L+j6DZuGQ==
X-Received: by 2002:a17:90b:46ce:b0:29b:6da4:277e with SMTP id
 jx14-20020a17090b46ce00b0029b6da4277emr6321334pjb.1.1710233963047; 
 Tue, 12 Mar 2024 01:59:23 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 t4-20020a17090abc4400b0029beb0fc60fsm3775312pjv.28.2024.03.12.01.59.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 01:59:22 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 18:59:17 +1000
Message-Id: <CZRNC9YHEMML.VNDNEAS6FEG2@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "David Gibson" <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 01/13] ppc: Drop support for POWER9 and POWER10 DD1 chips
X-Mailer: aerc 0.15.2
References: <20240311185200.2185753-1-npiggin@gmail.com>
 <20240311185200.2185753-2-npiggin@gmail.com>
 <5f8b269f-1f43-42ab-b4bf-d0314b739493@linux.ibm.com>
 <d1b34bf3-e9b7-48e6-9e46-ec396068b888@linux.ibm.com>
In-Reply-To: <d1b34bf3-e9b7-48e6-9e46-ec396068b888@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Mar 12, 2024 at 2:55 PM AEST, Harsh Prateek Bora wrote:
>
>
> On 3/12/24 10:20, Harsh Prateek Bora wrote:
> >=20
> >=20
> > On 3/12/24 00:21, Nicholas Piggin wrote:
> >> The POWER9 DD1 and POWER10 DD1 chips are not public and are no longer =
of
> >> any use in QEMU. Remove them.
> >>
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> ---
> >> =C2=A0 hw/ppc/spapr_cpu_core.c |=C2=A0 2 --
> >> =C2=A0 target/ppc/cpu-models.c |=C2=A0 4 ----
> >> =C2=A0 target/ppc/cpu_init.c=C2=A0=C2=A0 |=C2=A0 7 ++-----
> >> =C2=A0 target/ppc/kvm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 11=
 -----------
> >> =C2=A0 4 files changed, 2 insertions(+), 22 deletions(-)
> >=20
> > Do we want to squash in removal of the macro as well?
> >
>
> <snip>
> Actually both, correcting diff:
>
> diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> index 0229ef3a9a..7d89b41214 100644
> --- a/target/ppc/cpu-models.h
> +++ b/target/ppc/cpu-models.h
> @@ -348,11 +348,9 @@ enum {
>       CPU_POWERPC_POWER8NVL_BASE     =3D 0x004C0000,
>       CPU_POWERPC_POWER8NVL_v10      =3D 0x004C0100,
>       CPU_POWERPC_POWER9_BASE        =3D 0x004E0000,
> -    CPU_POWERPC_POWER9_DD1         =3D 0x004E1100,
>       CPU_POWERPC_POWER9_DD20        =3D 0x004E1200,
>       CPU_POWERPC_POWER9_DD22        =3D 0x004E1202,
>       CPU_POWERPC_POWER10_BASE       =3D 0x00800000,
> -    CPU_POWERPC_POWER10_DD1        =3D 0x00801100,
>       CPU_POWERPC_POWER10_DD20       =3D 0x00801200,
>       CPU_POWERPC_970_v22            =3D 0x00390202,
>       CPU_POWERPC_970FX_v10          =3D 0x00391100,

That would make sense, but we do seem to use this list as somewhat of a
reference or at least historic graveyard too (note all the other CPUs we
no longer support). So I was going to just leave them there.

Thanks,
Nick

