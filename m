Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694CBC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 00:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC6wO-0001vX-OI; Tue, 28 May 2024 20:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sC6wM-0001uo-DA; Tue, 28 May 2024 20:13:15 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sC6wK-0008IN-GR; Tue, 28 May 2024 20:13:13 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f4a52b9589so13236695ad.3; 
 Tue, 28 May 2024 17:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716941591; x=1717546391; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N5gho23C2tN+BCaVzSD0iLE+yNArfa25MZzAKPqJl68=;
 b=QbYpeIarhkTusx8GuH/TFRYkSJXB7MfAcz34xR592hTb65fsHyAJ8/Q0xS9GhQx6Rv
 IZi+EjSiGVUjR9keKYte8aKyi9MKbVpNOUn+20O5s+mghCtXb3SOyi0wLyenpQVGZtXY
 qz0atcto9T7jd1jOup/ILizS7n95qUwOn4F/VSmc+C8Raw+aX7+1jwny6J6180QYWBwB
 RNh4Aw7YiGB9e9ONPHWAqX3rydv0ll03SvRUx5k/9HSpRdZYMiB7Jg9DlywpRx7gNNZV
 I8zCLN8QohryOsSxmIw4kdeUqNhCDv0QTDNaAPD8RHU6kw63i6cphxTT+qQAYk1agvb0
 cUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716941591; x=1717546391;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=N5gho23C2tN+BCaVzSD0iLE+yNArfa25MZzAKPqJl68=;
 b=lf2dAbbG4RYJeKTCIJFtlYqfDxAes/Ur/u9ewv3VV/i0GiWE2cUWW47ZD+tX0mU87O
 WzeVkSprw5/CaEuDU3fsE+VuWhRiQ1xCNqd84xnlIEacSo0OwxuaVtUdk9wbkjUe7Hzp
 XY6+v3KL7hlF4/EA5Vc+dgXtnNuFjsGWgrt8jAGpQ0HaCcimoR0TkuqEEsxVaPDOr+hY
 4tKPfrCLb8XHaveXRWQZIhybja6T9QaYtiq4xHa1wpSynZ52XoSqADU++Ikw0g6V0jQO
 /4XMh9jrASdrDQNhJ2u8Au5Huqu+UjqhnMvE/+KUv8fvIr1cYngMFiJK4KGfRZJEi9Qc
 RxgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCHWlKSbEJ4j2I8tDlta2jEY5LElNTY5RX3qOi4FIG1zYiWSln2VuFuTIq9zTMjXUfltIb0WvDRBYrxIsUYvw2W1pytSmhO4CHQGE5Yr2ylAj+E9Nk08r+c+4=
X-Gm-Message-State: AOJu0Yxe/nTUFrlUoJ7HZtMrwxbqbL7CPeMPyKA9NRCeAKSgjHEAJCJz
 CgLRZcvacPwTr/9slz9RBKYv6xoC2qzKh5a6de+2PwmbdaiuMKcEAXEmoQ==
X-Google-Smtp-Source: AGHT+IE3mJ33+cyYSPJ/duntszT/ryZiW9lnSPbTFRVeZ0ueMkftn39XVr7eDOFWSmg64GHFdzQq+w==
X-Received: by 2002:a17:902:da85:b0:1f0:8bbd:34db with SMTP id
 d9443c01a7336-1f44873d4aamr127876545ad.34.1716941590640; 
 Tue, 28 May 2024 17:13:10 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c9dae6asm85781975ad.296.2024.05.28.17.13.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 17:13:10 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 May 2024 10:13:04 +1000
Message-Id: <D1LOZVAI9RGP.315U4KSV0NNW@gmail.com>
Cc: "Caleb Schlossin" <calebs@linux.vnet.ibm.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>, "Daniel
 Henrique Barboza" <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH 03/10] target/ppc: Improve SPR indirect registers
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240526122612.473476-1-npiggin@gmail.com>
 <20240526122612.473476-4-npiggin@gmail.com>
 <eed27a5e-6b32-45e0-8d76-51371fadc976@linux.ibm.com>
In-Reply-To: <eed27a5e-6b32-45e0-8d76-51371fadc976@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

On Tue May 28, 2024 at 4:50 PM AEST, Harsh Prateek Bora wrote:
>
> Hi Nick,
>
> On 5/26/24 17:56, Nicholas Piggin wrote:
> > SPRC/SPRD were recently added to all BookS CPUs supported, but
> > they are only tested on POWER9 and POWER10, so restrict them to
> > those CPUs.
> >=20
>
> Hope you mean to restrict to P9/10 for both spapr and pnv or just pnv ?

For pnv, but they are hypervisor registers so they can not be
accessed with spapr.

[...]

> > @@ -321,11 +322,25 @@ void helper_store_sprc(CPUPPCState *env, target_u=
long val)
> >  =20
> >   target_ulong helper_load_sprd(CPUPPCState *env)
> >   {
> > +    PowerPCCPU *cpu =3D env_archcpu(env);
> > +    PnvCore *pc =3D pnv_cpu_state(cpu)->core;
>
> We may want to avoid creating local variable cpu here also like previous=
=20
> patches.

Since we have a maze of pointers and types, sometimes I like to
write the types down, but maybe that's just me :P

> However, is this helper meant to be accessible for spapr as well ?

Right, it's not. I *think* it should be okay to do this since it
should never be reached by spapr.

Thanks,
Nick

